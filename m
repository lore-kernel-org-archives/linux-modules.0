Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D85C433EF
	for <linux-modules@archiver.kernel.org>; Wed, 16 Feb 2022 07:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbiBPH4U (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 16 Feb 2022 02:56:20 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbiBPH4T (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 16 Feb 2022 02:56:19 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E12EBF67
        for <linux-modules@vger.kernel.org>; Tue, 15 Feb 2022 23:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644998167; x=1676534167;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aTU4/FKEoWqEyoxK0LDVBg5CYF3mnWAarrmQtxP3Qp0=;
  b=JXJKS8Co8cFqqugupiKFJyL8FuhDZg39vZiTr2IphB+m/d4OD9qp6kRB
   W31fXd9hhGcgc08NOTNL8AJuHqHc8ftzojazwDOrQqf8A6jIXQkHFbTni
   Q9jd/+u0nNm7wutGK1ugkPyJOshneCstAVtucFA8iaBtT6S0itsq6Sx3U
   pkj0H8lB+LLb4jXwa7Ow9T4Exzj2pVyiCIWlV6XLdR9IyUJh5txfeQdE/
   HjCE8RO4MWoha6pKnBxYszkwoqqMNln3pru8PfSqC3LAUu2TzICQK60sY
   G0Fwq0PgrpQayrbIiZDm5pTkaKEmnNvr6AtPzteMqkRbysAu5ZpRpo6zs
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="311286602"
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="311286602"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 23:56:04 -0800
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="636377640"
Received: from dcanchal-mobl1.ger.corp.intel.com (HELO ldmartin-desk2.intel.com) ([10.212.233.152])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 23:56:04 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-modules@vger.kernel.org
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 4/8] libkmod: Add helper function to iterate lookup options
Date:   Tue, 15 Feb 2022 23:55:29 -0800
Message-Id: <20220216075533.185693-5-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220216075533.185693-1-lucas.demarchi@intel.com>
References: <20220216075533.185693-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

The CHECK_ERR_AND_FINISH macro with conditional code flow changes has
been a source of bugs. Get rid of it replacing with a helper function
to iterate an array of lookup functions. This helper may also be useful
in future to create different lookup APIs in libkmod.
---
 libkmod/libkmod-module.c | 82 ++++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 45 deletions(-)

diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index 1b59c3c..7cb6d26 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -499,13 +499,26 @@ KMOD_EXPORT struct kmod_module *kmod_module_ref(struct kmod_module *mod)
 	return mod;
 }
 
-#define CHECK_ERR_AND_FINISH(_err, _label_err, _list, label_finish)	\
-	do {								\
-		if ((_err) < 0)						\
-			goto _label_err;				\
-		if (*(_list) != NULL)					\
-			goto finish;					\
-	} while (0)
+typedef int (*lookup_func)(struct kmod_ctx *ctx, const char *name, struct kmod_list **list) __attribute__((nonnull(1, 2, 3)));
+
+static int __kmod_module_new_from_lookup(struct kmod_ctx *ctx, const lookup_func lookup[],
+					 size_t lookup_count, const char *s,
+					 struct kmod_list **list)
+{
+	unsigned int i;
+
+	for (i = 0; i < lookup_count; i++) {
+		int err;
+
+		err = lookup[i](ctx, s, list);
+		if (err < 0 && err != -ENOSYS)
+			return err;
+		else if (*list != NULL)
+			return 0;
+	}
+
+	return 0;
+}
 
 /**
  * kmod_module_new_from_lookup:
@@ -538,8 +551,17 @@ KMOD_EXPORT int kmod_module_new_from_lookup(struct kmod_ctx *ctx,
 						const char *given_alias,
 						struct kmod_list **list)
 {
-	int err;
+	const lookup_func lookup[] = {
+		kmod_lookup_alias_from_config,
+		kmod_lookup_alias_from_moddep_file,
+		kmod_lookup_alias_from_symbols_file,
+		kmod_lookup_alias_from_commands,
+		kmod_lookup_alias_from_aliases_file,
+		kmod_lookup_alias_from_builtin_file,
+		kmod_lookup_alias_from_kernel_builtin_file,
+	};
 	char alias[PATH_MAX];
+	int err;
 
 	if (ctx == NULL || given_alias == NULL)
 		return -ENOENT;
@@ -556,48 +578,18 @@ KMOD_EXPORT int kmod_module_new_from_lookup(struct kmod_ctx *ctx,
 
 	DBG(ctx, "input alias=%s, normalized=%s\n", given_alias, alias);
 
-	/* Aliases from config file override all the others */
-	err = kmod_lookup_alias_from_config(ctx, alias, list);
-	CHECK_ERR_AND_FINISH(err, fail, list, finish);
+	err = __kmod_module_new_from_lookup(ctx, lookup, sizeof(lookup),
+					    alias, list);
 
-	DBG(ctx, "lookup modules.dep %s\n", alias);
-	err = kmod_lookup_alias_from_moddep_file(ctx, alias, list);
-	CHECK_ERR_AND_FINISH(err, fail, list, finish);
-
-	DBG(ctx, "lookup modules.symbols %s\n", alias);
-	err = kmod_lookup_alias_from_symbols_file(ctx, alias, list);
-	CHECK_ERR_AND_FINISH(err, fail, list, finish);
-
-	DBG(ctx, "lookup install and remove commands %s\n", alias);
-	err = kmod_lookup_alias_from_commands(ctx, alias, list);
-	CHECK_ERR_AND_FINISH(err, fail, list, finish);
-
-	DBG(ctx, "lookup modules.aliases %s\n", alias);
-	err = kmod_lookup_alias_from_aliases_file(ctx, alias, list);
-	CHECK_ERR_AND_FINISH(err, fail, list, finish);
-
-	DBG(ctx, "lookup modules.builtin %s\n", alias);
-	err = kmod_lookup_alias_from_builtin_file(ctx, alias, list);
-	CHECK_ERR_AND_FINISH(err, fail, list, finish);
-
-	DBG(ctx, "lookup modules.builtin.modinfo %s\n", alias);
-	err = kmod_lookup_alias_from_kernel_builtin_file(ctx, alias, list);
-	/* Optional index missing, ignore */
-	if (err == -ENOSYS)
-		err = 0;
-	CHECK_ERR_AND_FINISH(err, fail, list, finish);
+	DBG(ctx, "lookup=%s found=%d\n", alias, err >= 0 && *list);
 
+	if (err < 0) {
+		kmod_module_unref_list(*list);
+		*list = NULL;
+	}
 
-finish:
-	DBG(ctx, "lookup %s matches=%d, list=%p\n", alias, err, *list);
-	return err > 0 ? 0 : err;
-fail:
-	DBG(ctx, "Failed to lookup %s\n", alias);
-	kmod_module_unref_list(*list);
-	*list = NULL;
 	return err;
 }
-#undef CHECK_ERR_AND_FINISH
 
 /**
  * kmod_module_unref_list:
-- 
2.35.1

