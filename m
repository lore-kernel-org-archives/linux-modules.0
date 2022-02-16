Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C0CC433F5
	for <linux-modules@archiver.kernel.org>; Wed, 16 Feb 2022 07:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbiBPH4X (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 16 Feb 2022 02:56:23 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbiBPH4V (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 16 Feb 2022 02:56:21 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FEF1011
        for <linux-modules@vger.kernel.org>; Tue, 15 Feb 2022 23:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644998168; x=1676534168;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yQxeXfVfmPuhiDOIMRS40NLHvlVYuqAc5Ax7SG5dyZY=;
  b=h0gxmNJJYwQVow1Bvt5gj5wK+DZXInBywwN2+1cX8r2ne6vps3ssBTlR
   8Z+5Mxj8oSaXQCSnU7/XJUE+30G/Ya0mu3IhjKc6JQ0rCSJaXMQyrHbZQ
   Q3ShULCRkvqOfBBaAhSn20gut5m5pvy0RlZCfIe1DSXhWsJ99uY0JuFly
   PPNyKIXgbRsrUgIDg1eYJzqN1TNrCH8KCPNH5mkFo3RI/h8GbTXo3/Tq+
   30/O2iWxCeC1DEpgk0sQgR9EiPd1thmXWnP8T5a+xqSXnvaz44up6OxCs
   9m5fD+4KvGrPHktQQvL6u6ejBYCO2UcyhqhPNEgo+QZniVLM68LrsMt2c
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="311286604"
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="311286604"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 23:56:04 -0800
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="636377646"
Received: from dcanchal-mobl1.ger.corp.intel.com (HELO ldmartin-desk2.intel.com) ([10.212.233.152])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 23:56:04 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-modules@vger.kernel.org
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 6/8] libkmod: Add lookup from module name
Date:   Tue, 15 Feb 2022 23:55:31 -0800
Message-Id: <20220216075533.185693-7-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220216075533.185693-1-lucas.demarchi@intel.com>
References: <20220216075533.185693-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Slightly different than kmod_module_new_from_lookup(): it doesn't
consider aliases, only module names. This is useful for cases we want to
force a tool to handle something as the module name, without trying to
interpret it as an alias.
---
 libkmod/libkmod-module.c | 57 ++++++++++++++++++++++++++++++++++++++++
 libkmod/libkmod.h        |  3 +++
 libkmod/libkmod.sym      |  1 +
 3 files changed, 61 insertions(+)

diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index 1c6ff24..a1839fa 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -591,6 +591,63 @@ KMOD_EXPORT int kmod_module_new_from_lookup(struct kmod_ctx *ctx,
 	return err;
 }
 
+/**
+ * kmod_module_new_from_name_lookup:
+ * @ctx: kmod library context
+ * @modname: module name to look for
+ * @mod: returned module on success
+ *
+ * Lookup by module name, without considering possible aliases. This is similar
+ * to kmod_module_new_from_lookup(), but don't consider as source indexes and
+ * configurations that work with aliases. When succesful, this always resolves
+ * to one and only one module.
+ *
+ * The search order is: 1. module names in modules.dep index;
+ * 2. builtin indexes from kernel.
+ *
+ * The initial refcount is 1, and needs to be decremented to release the
+ * resources of the kmod_module. Since libkmod keeps track of all
+ * kmod_modules created, they are all released upon @ctx destruction too. Do
+ * not unref @ctx before all the desired operations with the returned list are
+ * completed.
+ *
+ * Returns: 0 on success or < 0 otherwise. It fails if any of the lookup
+ * methods failed, which is basically due to memory allocation failure. If
+ * module is not found, it still returns 0, but @mod is left untouched.
+ */
+KMOD_EXPORT int kmod_module_new_from_name_lookup(struct kmod_ctx *ctx,
+						 const char *modname,
+						 struct kmod_module **mod)
+{
+	const lookup_func lookup[] = {
+		kmod_lookup_alias_from_moddep_file,
+		kmod_lookup_alias_from_builtin_file,
+		kmod_lookup_alias_from_kernel_builtin_file,
+	};
+	char name_norm[PATH_MAX];
+	struct kmod_list *list = NULL;
+	int err;
+
+	if (ctx == NULL || modname == NULL || mod == NULL)
+		return -ENOENT;
+
+	modname_normalize(modname, name_norm, NULL);
+
+	DBG(ctx, "input modname=%s, normalized=%s\n", modname, name_norm);
+
+	err = __kmod_module_new_from_lookup(ctx, lookup, sizeof(lookup),
+					    name_norm, &list);
+
+	DBG(ctx, "lookup=%s found=%d\n", name_norm, err >= 0 && list);
+
+	if (err >= 0 && list != NULL)
+		*mod = kmod_module_get_module(list);
+
+	kmod_module_unref_list(list);
+
+	return err;
+}
+
 /**
  * kmod_module_unref_list:
  * @list: list of kmod modules
diff --git a/libkmod/libkmod.h b/libkmod/libkmod.h
index 3cab2e5..fed216b 100644
--- a/libkmod/libkmod.h
+++ b/libkmod/libkmod.h
@@ -129,6 +129,9 @@ int kmod_module_new_from_path(struct kmod_ctx *ctx, const char *path,
 						struct kmod_module **mod);
 int kmod_module_new_from_lookup(struct kmod_ctx *ctx, const char *given_alias,
 						struct kmod_list **list);
+int kmod_module_new_from_name_lookup(struct kmod_ctx *ctx,
+				     const char *modname,
+				     struct kmod_module **mod);
 int kmod_module_new_from_loaded(struct kmod_ctx *ctx,
 						struct kmod_list **list);
 
diff --git a/libkmod/libkmod.sym b/libkmod/libkmod.sym
index 5f5e1fb..0c04fda 100644
--- a/libkmod/libkmod.sym
+++ b/libkmod/libkmod.sym
@@ -30,6 +30,7 @@ global:
 	kmod_module_new_from_name;
 	kmod_module_new_from_path;
 	kmod_module_new_from_lookup;
+	kmod_module_new_from_name_lookup;
 	kmod_module_new_from_loaded;
 	kmod_module_ref;
 	kmod_module_unref;
-- 
2.35.1

