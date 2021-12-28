Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5C5C433FE
	for <linux-modules@archiver.kernel.org>; Tue, 28 Dec 2021 21:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237582AbhL1Va7 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 28 Dec 2021 16:30:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36027 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237547AbhL1Vaw (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 28 Dec 2021 16:30:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640727051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mCGQaji14i2F94mV0DWpkRKJAs6KEBhnNJRRFLq3kec=;
        b=KHP/iBuj0mVxuWZg+4mz/hLRs3dZ0oVwxk2Rtjn9zY36nRIMcjkTFojvNVLjPFPDpDSGpB
        DJNS2jAZY27ySMEJEwmmEFnuPbY78hYn8m5jJoCowvjZr+c0Hz/GEsJu9tzMJ2U3ZUYcPL
        Rp0OM3rOS1u8C16NGd3N2/yJ5qQKHkg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-218-7N_nNcGRP5W-Yf_7z-dong-1; Tue, 28 Dec 2021 16:30:50 -0500
X-MC-Unique: 7N_nNcGRP5W-Yf_7z-dong-1
Received: by mail-wm1-f69.google.com with SMTP id l20-20020a05600c1d1400b003458e02cea0so11661070wms.7
        for <linux-modules@vger.kernel.org>; Tue, 28 Dec 2021 13:30:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mCGQaji14i2F94mV0DWpkRKJAs6KEBhnNJRRFLq3kec=;
        b=7Ywj1EwzSn6o31Fxx6CVcvge6Qh7i8JQvPZxHOYF4jEDvIVMfCS/yWar5oCalVs0cz
         6RZXVgOM9yNPJwkOLgYNIEcABt2XPhxs1c5f8/6oB5kXFTnaUipLZiNIURN4kzyYQEUX
         j02QPgIOBSpDpJ5+iJkSl1xPtPb0KoMTuwIy/6NtrAXq66k+MWjDIb0gi0yHfxYKAjeF
         AEQ9vCBllascuE8vX7GOcDQpMdBJcX40A+kUi30nYpj0DAqQOQgx5IXh2q8oO8TvT6H7
         PqKOwaTOxvvUoXSL/dwhIc58q+s/UUIoStnuraKf9H0ULbYK7U+vY0YqM3NjD3BUJqyl
         MlyA==
X-Gm-Message-State: AOAM532WkbrlYwwjz6qB+AipFoUWIIDL/phX6XVjBc89trnVPM2Yh7w1
        Z36zjjIQTwmZBVoru8d0iY/B7+91KIVSSJUWHygNIoS7/hntgKSd0S8n+ttvUjtm5Bl9qQP+QDX
        9jwznC0G3+7p79VDaQyZJOZ40
X-Received: by 2002:a5d:4ac1:: with SMTP id y1mr7059439wrs.588.1640727049360;
        Tue, 28 Dec 2021 13:30:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzIYphcVIhT3nBANNBEk2578Lhh5pmlGNiiIxOfT+c3XgWX4iunwncZgmKGb+Z/glmSo3vB4A==
X-Received: by 2002:a5d:4ac1:: with SMTP id y1mr7059433wrs.588.1640727049201;
        Tue, 28 Dec 2021 13:30:49 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id l4sm18975858wrm.62.2021.12.28.13.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 13:30:48 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com
Subject: [RFC PATCH 07/12] module: Move extra signature support out of core code
Date:   Tue, 28 Dec 2021 21:30:36 +0000
Message-Id: <20211228213041.1356334-8-atomlin@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211228213041.1356334-1-atomlin@redhat.com>
References: <YbKUUJUtjBk/n913@bombadil.infradead.org>
 <20211228213041.1356334-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

No functional change.

This patch migrates additional module signature check
code from core module code into kernel/module/signing.c.

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 include/linux/module.h   |  5 ++-
 kernel/module/internal.h |  9 +++++
 kernel/module/main.c     | 86 ----------------------------------------
 kernel/module/signing.c  | 75 +++++++++++++++++++++++++++++++++++
 4 files changed, 87 insertions(+), 88 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 218ac6768433..3383912268af 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -736,8 +736,8 @@ static inline bool is_livepatch_module(struct module *mod)
 }
 #endif /* CONFIG_LIVEPATCH */
 
-bool is_module_sig_enforced(void);
-void set_module_sig_enforced(void);
+extern bool is_module_sig_enforced(void);
+extern void set_module_sig_enforced(void);
 
 #else /* !CONFIG_MODULES... */
 
@@ -927,6 +927,7 @@ static inline bool module_sig_ok(struct module *module)
 {
 	return true;
 }
+#define sig_enforce false
 #endif	/* CONFIG_MODULE_SIG */
 
 int module_kallsyms_on_each_symbol(int (*fn)(void *, const char *,
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 91ef152aeffb..b4db57bafcd3 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -63,3 +63,12 @@ static inline int copy_module_elf(struct module *mod, struct load_info *info)
 }
 static inline void free_module_elf(struct module *mod) { }
 #endif /* CONFIG_LIVEPATCH */
+
+#ifdef CONFIG_MODULE_SIG
+extern int module_sig_check(struct load_info *info, int flags);
+#else /* !CONFIG_MODULE_SIG */
+static int module_sig_check(struct load_info *info, int flags)
+{
+	return 0;
+}
+#endif /* !CONFIG_MODULE_SIG */
diff --git a/kernel/module/main.c b/kernel/module/main.c
index c404d00f7958..8f8a904d5ba7 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -22,7 +22,6 @@
 #include <linux/vmalloc.h>
 #include <linux/elf.h>
 #include <linux/proc_fs.h>
-#include <linux/security.h>
 #include <linux/seq_file.h>
 #include <linux/syscalls.h>
 #include <linux/fcntl.h>
@@ -114,28 +113,6 @@ static void module_assert_mutex_or_preempt(void)
 #endif
 }
 
-#ifdef CONFIG_MODULE_SIG
-static bool sig_enforce = IS_ENABLED(CONFIG_MODULE_SIG_FORCE);
-module_param(sig_enforce, bool_enable_only, 0644);
-
-void set_module_sig_enforced(void)
-{
-	sig_enforce = true;
-}
-#else
-#define sig_enforce false
-#endif
-
-/*
- * Export sig_enforce kernel cmdline parameter to allow other subsystems rely
- * on that instead of directly to CONFIG_MODULE_SIG_FORCE config.
- */
-bool is_module_sig_enforced(void)
-{
-	return sig_enforce;
-}
-EXPORT_SYMBOL(is_module_sig_enforced);
-
 /* Block module loading/unloading? */
 int modules_disabled = 0;
 core_param(nomodule, modules_disabled, bint, 0);
@@ -2517,69 +2494,6 @@ static inline void kmemleak_load_module(const struct module *mod,
 }
 #endif
 
-#ifdef CONFIG_MODULE_SIG
-static int module_sig_check(struct load_info *info, int flags)
-{
-	int err = -ENODATA;
-	const unsigned long markerlen = sizeof(MODULE_SIG_STRING) - 1;
-	const char *reason;
-	const void *mod = info->hdr;
-
-	/*
-	 * Require flags == 0, as a module with version information
-	 * removed is no longer the module that was signed
-	 */
-	if (flags == 0 &&
-	    info->len > markerlen &&
-	    memcmp(mod + info->len - markerlen, MODULE_SIG_STRING, markerlen) == 0) {
-		/* We truncate the module to discard the signature */
-		info->len -= markerlen;
-		err = mod_verify_sig(mod, info);
-		if (!err) {
-			info->sig_ok = true;
-			return 0;
-		}
-	}
-
-	/*
-	 * We don't permit modules to be loaded into the trusted kernels
-	 * without a valid signature on them, but if we're not enforcing,
-	 * certain errors are non-fatal.
-	 */
-	switch (err) {
-	case -ENODATA:
-		reason = "unsigned module";
-		break;
-	case -ENOPKG:
-		reason = "module with unsupported crypto";
-		break;
-	case -ENOKEY:
-		reason = "module with unavailable key";
-		break;
-
-	default:
-		/*
-		 * All other errors are fatal, including lack of memory,
-		 * unparseable signatures, and signature check failures --
-		 * even if signatures aren't required.
-		 */
-		return err;
-	}
-
-	if (is_module_sig_enforced()) {
-		pr_notice("Loading of %s is rejected\n", reason);
-		return -EKEYREJECTED;
-	}
-
-	return security_locked_down(LOCKDOWN_MODULE_SIGNATURE);
-}
-#else /* !CONFIG_MODULE_SIG */
-static int module_sig_check(struct load_info *info, int flags)
-{
-	return 0;
-}
-#endif /* !CONFIG_MODULE_SIG */
-
 static int validate_section_offset(struct load_info *info, Elf_Shdr *shdr)
 {
 	unsigned long secend;
diff --git a/kernel/module/signing.c b/kernel/module/signing.c
index 8aeb6d2ee94b..ff41541e982a 100644
--- a/kernel/module/signing.c
+++ b/kernel/module/signing.c
@@ -11,9 +11,28 @@
 #include <linux/module_signature.h>
 #include <linux/string.h>
 #include <linux/verification.h>
+#include <linux/security.h>
 #include <crypto/public_key.h>
 #include "internal.h"
 
+static bool sig_enforce = IS_ENABLED(CONFIG_MODULE_SIG_FORCE);
+module_param(sig_enforce, bool_enable_only, 0644);
+
+/*
+ * Export sig_enforce kernel cmdline parameter to allow other subsystems rely
+ * on that instead of directly to CONFIG_MODULE_SIG_FORCE config.
+ */
+bool is_module_sig_enforced(void)
+{
+	return sig_enforce;
+}
+EXPORT_SYMBOL(is_module_sig_enforced);
+
+void set_module_sig_enforced(void)
+{
+	sig_enforce = true;
+}
+
 /*
  * Verify the signature on a module.
  */
@@ -43,3 +62,59 @@ int mod_verify_sig(const void *mod, struct load_info *info)
 				      VERIFYING_MODULE_SIGNATURE,
 				      NULL, NULL);
 }
+
+int module_sig_check(struct load_info *info, int flags)
+{
+	int err = -ENODATA;
+	const unsigned long markerlen = sizeof(MODULE_SIG_STRING) - 1;
+	const char *reason;
+	const void *mod = info->hdr;
+
+	/*
+	 * Require flags == 0, as a module with version information
+	 * removed is no longer the module that was signed
+	 */
+	if (flags == 0 &&
+	    info->len > markerlen &&
+	    memcmp(mod + info->len - markerlen, MODULE_SIG_STRING, markerlen) == 0) {
+		/* We truncate the module to discard the signature */
+		info->len -= markerlen;
+		err = mod_verify_sig(mod, info);
+		if (!err) {
+			info->sig_ok = true;
+			return 0;
+		}
+	}
+
+	/*
+	 * We don't permit modules to be loaded into the trusted kernels
+	 * without a valid signature on them, but if we're not enforcing,
+	 * certain errors are non-fatal.
+	 */
+	switch (err) {
+	case -ENODATA:
+		reason = "unsigned module";
+		break;
+	case -ENOPKG:
+		reason = "module with unsupported crypto";
+		break;
+	case -ENOKEY:
+		reason = "module with unavailable key";
+		break;
+
+	default:
+		/*
+		 * All other errors are fatal, including lack of memory,
+		 * unparseable signatures, and signature check failures --
+		 * even if signatures aren't required.
+		 */
+		return err;
+	}
+
+	if (is_module_sig_enforced()) {
+		pr_notice("Loading of %s is rejected\n", reason);
+		return -EKEYREJECTED;
+	}
+
+	return security_locked_down(LOCKDOWN_MODULE_SIGNATURE);
+}
-- 
2.31.1

