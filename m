Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3CEC433FE
	for <linux-modules@archiver.kernel.org>; Fri, 11 Feb 2022 08:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240464AbiBKImp (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 11 Feb 2022 03:42:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239024AbiBKIml (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 11 Feb 2022 03:42:41 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8EC197
        for <linux-modules@vger.kernel.org>; Fri, 11 Feb 2022 00:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644568961; x=1676104961;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vF8am96ojuW8Jo/l28LaUCciRDgwStB7FIrFONXWZs0=;
  b=MjwTWETQ55qwUcgixxXbrXpRz3xxhYUTbI80sBDgRhSu43W319eDKORY
   jiaxp2HwMTeTEwRVl1K1tcQzhnaEIcyvtyYYzIOWEhiV4xa+rIr1OFpOl
   /487fnWpyNJT1rMMJiIEJbC1VfuUmI96/OlT4SYIMSuHZZYwh/8y7jDFm
   Zu1RXJrJMCujLlfFnf3wQhipPu0+AcKP1rHwVm41GFKjmjgFgSzKD2ujl
   A7U6a5wsWJkQCIjliw2aJeAdyNXoU4IojjcP9u7AfrKxwBKhtEjRBp2CR
   aJ6uItTiviSy2flUZucf0314aM8W06bf6wj42uXDrj5TnSuO+ICh/Jvzq
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="310427011"
X-IronPort-AV: E=Sophos;i="5.88,360,1635231600"; 
   d="scan'208";a="310427011"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 00:42:40 -0800
X-IronPort-AV: E=Sophos;i="5.88,360,1635231600"; 
   d="scan'208";a="526876375"
Received: from cheryeoh-mobl.amr.corp.intel.com (HELO ldmartin-desk2.wifi.hicv.net) ([10.209.59.32])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 00:42:40 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-modules@vger.kernel.org
Cc:     gladkov.alexey@gmail.com
Subject: [PATCH 3/3] depmod: Stop opening modules.modinfo once per module
Date:   Fri, 11 Feb 2022 00:42:30 -0800
Message-Id: <20220211084230.4489-3-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220211084230.4489-1-lucas.demarchi@intel.com>
References: <20220211084230.4489-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Since the addition of modules.aliases.bin, depmod has to open that
index multiple times and parse it over and over again:

	$ sudo strace -e openat  ./tools/depmod 2>&1 | grep modules.builtin.modinfo  | wc -l
	299
	$ time sudo  ./tools/depmod
	real    0m7.814s
	user    0m7.571s
	sys     0m0.237s

Rework the logic in depmod so it does everything: open, read and parse. The
format is very straightforward and we don't need to keep it in a data structure
since we only want to add the result to a index. New output:

	$ sudo strace -e openat  ./tools/depmod 2>&1 | grep modules.builtin.modinfo  | wc -l
	1
	$ time sudo  ./tools/depmod
	real    0m7.663s
	user    0m7.516s
	sys     0m0.139s

Indexes still match:

	$ cmp /tmp/modules.builtin.alias.bin.new
	/tmp/modules.builtin.alias.bin.old; echo $?
	0

Fix: https://github.com/kmod-project/kmod/issues/11
---
 tools/depmod.c | 158 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 96 insertions(+), 62 deletions(-)

diff --git a/tools/depmod.c b/tools/depmod.c
index ac6ead8..07a35ba 100644
--- a/tools/depmod.c
+++ b/tools/depmod.c
@@ -2346,6 +2346,102 @@ static int output_builtin_bin(struct depmod *depmod, FILE *out)
 	return 0;
 }
 
+static int flush_stream(FILE *in, int endchar)
+{
+	size_t i = 0;
+	int c;
+
+	for (c = fgetc(in);
+	     c != EOF && c != endchar && c != '\0';
+	     c = fgetc(in))
+		;
+
+	return c == endchar ? i : 0;
+}
+
+static int flush_stream_to(FILE *in, int endchar, char *dst, size_t dst_sz)
+{
+	size_t i = 0;
+	int c;
+
+	for (c = fgetc(in);
+	     c != EOF && c != endchar && c != '\0' && i < dst_sz;
+	     c = fgetc(in))
+		dst[i++] = c;
+
+	if (i == dst_sz) {
+		WRN("Could not flush stream: %d. Partial content: %.*s\n",
+		    ENOSPC, (int) dst_sz, dst);
+	}
+
+	return c == endchar ? i : 0;
+}
+
+static int output_builtin_alias_bin(struct depmod *depmod, FILE *out)
+{
+	FILE *in;
+	struct index_node *idx;
+	int ret;
+
+	if (out == stdout)
+		return 0;
+
+	in = dfdopen(depmod->cfg->dirname, "modules.builtin.modinfo", O_RDONLY, "r");
+	if (in == NULL)
+		return 0;
+
+	idx = index_create();
+	if (idx == NULL) {
+		fclose(in);
+		return -ENOMEM;
+	}
+
+	/* format: modname.key=value\0 */
+	while (!feof(in) && !ferror(in)) {
+		char alias[PATH_MAX];
+		char modname[PATH_MAX];
+		char value[PATH_MAX];
+		size_t len;
+
+		len = flush_stream_to(in, '.', modname, sizeof(modname));
+		modname[len] = '\0';
+		if (!len)
+			continue;
+
+		len = flush_stream_to(in, '=', value, sizeof(value));
+		value[len] = '\0';
+		if (!streq(value, "alias")) {
+			flush_stream(in, '\0');
+			continue;
+		}
+
+		len = flush_stream_to(in, '\0', value, sizeof(value));
+		value[len] = '\0';
+		if (!len)
+			continue;
+
+		alias[0] = '\0';
+		if (alias_normalize(value, alias, NULL) < 0) {
+			WRN("Unmatched bracket in %s\n", value);
+			continue;
+		}
+
+		index_insert(idx, alias, modname, 0);
+	}
+
+	if (ferror(in)) {
+		ret = -EINVAL;
+	} else {
+		index_write(idx, out);
+		ret = 0;
+	}
+
+	index_destroy(idx);
+	fclose(in);
+
+	return ret;
+}
+
 static int output_devname(struct depmod *depmod, FILE *out)
 {
 	size_t i;
@@ -2403,68 +2499,6 @@ static int output_devname(struct depmod *depmod, FILE *out)
 	return 0;
 }
 
-static int output_builtin_alias_bin(struct depmod *depmod, FILE *out)
-{
-	int ret = 0;
-	struct index_node *idx;
-	struct kmod_list *l, *builtin = NULL;
-
-	if (out == stdout)
-		return 0;
-
-	idx = index_create();
-	if (idx == NULL)
-		return -ENOMEM;
-
-	ret = kmod_module_get_builtin(depmod->ctx, &builtin);
-	if (ret < 0) {
-		if (ret == -ENOENT)
-			ret = 0;
-		goto out;
-	}
-
-	kmod_list_foreach(l, builtin) {
-		struct kmod_list *ll, *info_list = NULL;
-		struct kmod_module *mod = l->data;
-		const char *modname = kmod_module_get_name(mod);
-
-		ret = kmod_module_get_info(mod, &info_list);
-		if (ret < 0)
-			goto out;
-
-		kmod_list_foreach(ll, info_list) {
-			char alias[PATH_MAX];
-			const char *key = kmod_module_info_get_key(ll);
-			const char *value = kmod_module_info_get_value(ll);
-
-			if (!streq(key, "alias"))
-				continue;
-
-			alias[0] = '\0';
-			if (alias_normalize(value, alias, NULL) < 0) {
-				WRN("Unmatched bracket in %s\n", value);
-				continue;
-			}
-
-			index_insert(idx, alias, modname, 0);
-		}
-
-		kmod_module_info_free_list(info_list);
-	}
-
-out:
-	/* do not bother writing the index if we are going to discard it */
-	if (ret > 0)
-		index_write(idx, out);
-
-	if (builtin)
-		kmod_module_unref_list(builtin);
-
-	index_destroy(idx);
-
-	return ret;
-}
-
 static int depmod_output(struct depmod *depmod, FILE *out)
 {
 	static const struct depfile {
-- 
2.35.1

