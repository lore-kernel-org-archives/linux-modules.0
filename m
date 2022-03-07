Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA90EC433EF
	for <linux-modules@archiver.kernel.org>; Mon,  7 Mar 2022 17:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244535AbiCGRqh (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 7 Mar 2022 12:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241029AbiCGRqe (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 7 Mar 2022 12:46:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7184390CD6
        for <linux-modules@vger.kernel.org>; Mon,  7 Mar 2022 09:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646675128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=apZpBB6s8ANx6PnqHZt1W7YrWPlcLByEn5Sm08WSqaI=;
        b=gV7qPDeQfiNnTqBSW7qp/wdD0zK4S3NAuRzmruwWTfnYIoBAvBMjZdY51ZuRwF6THeCBTj
        uAuSoFW4wX9llaDiij0i3ZTQwuG28yX/bz/vZmVO2068Bt3QFU5VH2mmiLkIQlQJNN6TWM
        PX131tQQTzyC9K7xUXsibVSRQZ+pPks=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-323-Q-FaGzC_MYmFVvY10i7KeQ-1; Mon, 07 Mar 2022 12:45:27 -0500
X-MC-Unique: Q-FaGzC_MYmFVvY10i7KeQ-1
Received: by mail-wm1-f72.google.com with SMTP id x5-20020a1c7c05000000b00389bcc8df46so575435wmc.0
        for <linux-modules@vger.kernel.org>; Mon, 07 Mar 2022 09:45:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=apZpBB6s8ANx6PnqHZt1W7YrWPlcLByEn5Sm08WSqaI=;
        b=ueEYxqhnQf/EhLkQV3PSHomcSM7BYqcVbUaWJNOqQxL+KXYlB4vKDnWfluxzpW2ts2
         wZMqn6Du08UvG/VOt8emNU5jtu5PSrU0Val4n+NfwpLf+fseUb3Ww4bO+SRytpR/u+7O
         oGToDMc5bo0HfV6bBVk01cl4HUSNHoUHEeeGtO/Nu8cAU1PhiWvmA6CkBpEd7bDTQtY7
         384p7CAv8A9FuWGZLfls5EfLCKMNYUaasB/XDZ3Q/x87jwLwcgnQG/URGR4PM1sui9vo
         zmpzAnE39Sp9tmmwwhN1vSTueLezcjQgHwjAl6764HOLINNIKNPEmuOdhST75zNuFidT
         GXMg==
X-Gm-Message-State: AOAM531D6EqsgioR3QcCq6se3qiLPgwnALdRTUPC04SeJ4cUnTYZlBof
        zurOOdsotkWFjcnSWiUXIdwaI+GN2jQ9l3Og9aiFstmtmH0mOLCy+D0to/QnrDhNAneST1Mc/nA
        FG15A24Lhmo70qcEo5uiVCI52
X-Received: by 2002:a5d:47ca:0:b0:1ef:d6ae:591a with SMTP id o10-20020a5d47ca000000b001efd6ae591amr8816976wrc.358.1646675125785;
        Mon, 07 Mar 2022 09:45:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxQZDKYDmiZfDW76IesytM1KFQWFYcPPgT3Fl39F45QSnJcrKVEh5ixjTrr1DuSBJjyrSRO5Q==
X-Received: by 2002:a5d:47ca:0:b0:1ef:d6ae:591a with SMTP id o10-20020a5d47ca000000b001efd6ae591amr8816954wrc.358.1646675125431;
        Mon, 07 Mar 2022 09:45:25 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id l13-20020a5d4bcd000000b001f0620ecb3csm10779965wrt.40.2022.03.07.09.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 09:45:24 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org, christophe.leroy@csgroup.eu
Cc:     cl@linux.com, mbenes@suse.cz, akpm@linux-foundation.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, void@manifault.com,
        atomlin@atomlin.com, allen.lkml@gmail.com, joe@perches.com,
        msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, daniel.thompson@linaro.org,
        hch@infradead.org, pmladek@suse.com
Subject: [PATCH v10 07/14] module: Move extra signature support out of core code
Date:   Mon,  7 Mar 2022 17:45:02 +0000
Message-Id: <20220307174509.2887714-8-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220307174509.2887714-1-atomlin@redhat.com>
References: <20220307174509.2887714-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

No functional change.

This patch migrates additional module signature check
code from core module code into kernel/module/signing.c.

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 include/linux/module.h   | 12 +++---
 kernel/module/internal.h |  9 +++++
 kernel/module/main.c     | 87 ----------------------------------------
 kernel/module/signing.c  | 77 +++++++++++++++++++++++++++++++++++
 4 files changed, 93 insertions(+), 92 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 7ec9715de7dc..5e2059f3afc7 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -672,7 +672,6 @@ static inline bool is_livepatch_module(struct module *mod)
 #endif
 }
 
-bool is_module_sig_enforced(void);
 void set_module_sig_enforced(void);
 
 #else /* !CONFIG_MODULES... */
@@ -799,10 +798,6 @@ static inline bool module_requested_async_probing(struct module *module)
 	return false;
 }
 
-static inline bool is_module_sig_enforced(void)
-{
-	return false;
-}
 
 static inline void set_module_sig_enforced(void)
 {
@@ -854,11 +849,18 @@ static inline bool retpoline_module_ok(bool has_retpoline)
 #endif
 
 #ifdef CONFIG_MODULE_SIG
+bool is_module_sig_enforced(void);
+
 static inline bool module_sig_ok(struct module *module)
 {
 	return module->sig_ok;
 }
 #else	/* !CONFIG_MODULE_SIG */
+static inline bool is_module_sig_enforced(void)
+{
+	return false;
+}
+
 static inline bool module_sig_ok(struct module *module)
 {
 	return true;
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index a6895bb5598a..d6f646a5da41 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -158,3 +158,12 @@ static inline int module_enforce_rwx_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
 	return 0;
 }
 #endif /* CONFIG_STRICT_MODULE_RWX */
+
+#ifdef CONFIG_MODULE_SIG
+int module_sig_check(struct load_info *info, int flags);
+#else /* !CONFIG_MODULE_SIG */
+static inline int module_sig_check(struct load_info *info, int flags)
+{
+	return 0;
+}
+#endif /* !CONFIG_MODULE_SIG */
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 5cd63f14b1ef..c63e10c61694 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -23,7 +23,6 @@
 #include <linux/vmalloc.h>
 #include <linux/elf.h>
 #include <linux/proc_fs.h>
-#include <linux/security.h>
 #include <linux/seq_file.h>
 #include <linux/syscalls.h>
 #include <linux/fcntl.h>
@@ -127,28 +126,6 @@ static void module_assert_mutex_or_preempt(void)
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
@@ -2569,70 +2546,6 @@ static inline void kmemleak_load_module(const struct module *mod,
 }
 #endif
 
-#ifdef CONFIG_MODULE_SIG
-static int module_sig_check(struct load_info *info, int flags)
-{
-	int err = -ENODATA;
-	const unsigned long markerlen = sizeof(MODULE_SIG_STRING) - 1;
-	const char *reason;
-	const void *mod = info->hdr;
-	bool mangled_module = flags & (MODULE_INIT_IGNORE_MODVERSIONS |
-				       MODULE_INIT_IGNORE_VERMAGIC);
-	/*
-	 * Do not allow mangled modules as a module with version information
-	 * removed is no longer the module that was signed.
-	 */
-	if (!mangled_module &&
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
 #if defined(CONFIG_64BIT)
diff --git a/kernel/module/signing.c b/kernel/module/signing.c
index 8aeb6d2ee94b..85c8999dfecf 100644
--- a/kernel/module/signing.c
+++ b/kernel/module/signing.c
@@ -11,9 +11,29 @@
 #include <linux/module_signature.h>
 #include <linux/string.h>
 #include <linux/verification.h>
+#include <linux/security.h>
 #include <crypto/public_key.h>
+#include <uapi/linux/module.h>
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
@@ -43,3 +63,60 @@ int mod_verify_sig(const void *mod, struct load_info *info)
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
+	bool mangled_module = flags & (MODULE_INIT_IGNORE_MODVERSIONS |
+				       MODULE_INIT_IGNORE_VERMAGIC);
+	/*
+	 * Do not allow mangled modules as a module with version information
+	 * removed is no longer the module that was signed.
+	 */
+	if (!mangled_module &&
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
2.34.1

