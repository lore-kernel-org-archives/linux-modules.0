Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86593C433EF
	for <linux-modules@archiver.kernel.org>; Wed,  9 Feb 2022 17:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237954AbiBIRI2 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 9 Feb 2022 12:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237988AbiBIRI0 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 9 Feb 2022 12:08:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 956AAC05CB9D
        for <linux-modules@vger.kernel.org>; Wed,  9 Feb 2022 09:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644426508;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Zz1hIvyOTmOfVlzPDSqic1s9brDgc02i7xbgHqy6SHg=;
        b=KxiDI44KfO/e3JdZjBdGosq1n2/XyWtWI2j0B8d55HfZr1Yrq6PsWXcALwTWKq1Ey32Ilw
        AgEVDmPP19Fi+8D8GfAOyFdLvjnc8U/L77w22tloJrv0h3+cCMoobh33GuvAv4w6BtMeaO
        7Gwj0EHwSeajvh+ypAR5WUayp8MZxN8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-651-C7cdxlBEMciQa_9sJNOAug-1; Wed, 09 Feb 2022 12:08:27 -0500
X-MC-Unique: C7cdxlBEMciQa_9sJNOAug-1
Received: by mail-wr1-f71.google.com with SMTP id q8-20020adfb188000000b001e33a8cdbf4so1336585wra.16
        for <linux-modules@vger.kernel.org>; Wed, 09 Feb 2022 09:08:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :mime-version:content-transfer-encoding;
        bh=Zz1hIvyOTmOfVlzPDSqic1s9brDgc02i7xbgHqy6SHg=;
        b=O4UBhS7Ex2IX7TRhxtjVHq7LpAzDtldI1hrSGG+r0MWW8DrCN4y1VkaBj7uKdxk01x
         hNZkoLa8RLu4KDr4C1rVneLrV4kCkjTn3zo4KgHNuj6eJZvTmUa7ydmnSBeC2c4MtRAq
         UZQGug1aExkhPdO7i+Zi+VCadzpXj3wWFDcfFzDpdsVflV+hlzE/e4nJCV19Jg4s94GK
         +C4nXK6UXZ36sAA7SCXfQRgU0U+H5eArH/9yyUiHGylyBZstZRN9Pgo2CAi/PBaCrev/
         HsElO6LOOP4YKJzrGl0hCyAeKxM8L760mNUhmb71vrOo6aznuXUbfbb0GhEg4c4Ao1e9
         Eubw==
X-Gm-Message-State: AOAM5336GQ3THQQmLBkN6fSrkFeoTGYHvjOkO7jDT0mI8KkYUuX/XZXk
        UrVT98D5rm7P/X/b44MDS8UM0DozJk+ivkD/LY6CMGgpG1i34Sa61iiLVQF8A880LL0Raszqz6J
        Ehgleh0K0kCffzuUtIli17AAW
X-Received: by 2002:a05:6000:178d:: with SMTP id e13mr2833021wrg.211.1644426495511;
        Wed, 09 Feb 2022 09:08:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyFhw1DFHfyI4XcznAfxJY91mp6SSYJbQHU22NYIp5gQs5QM793yJj7QMcWbBnLN7ey1ftjrA==
X-Received: by 2002:a05:6000:178d:: with SMTP id e13mr2832999wrg.211.1644426495247;
        Wed, 09 Feb 2022 09:08:15 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id u25sm52067wmm.15.2022.02.09.09.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 09:08:14 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        live-patching@vger.kernel.org, atomlin@atomlin.com,
        ghalat@redhat.com, allen.lkml@gmail.com, void@manifault.com,
        joe@perches.com, christophe.leroy@csgroup.eu, msuchanek@suse.de,
        oleksandr@natalenko.name
Subject: [PATCH v5 07/13] module: Move extra signature support out of core code
Date:   Wed,  9 Feb 2022 17:08:08 +0000
Message-Id: <20220209170814.3268487-1-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
Reply-To: 20220209170358.3266629-1-atomlin@redhat.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

No functional change.

This patch migrates additional module signature check
code from core module code into kernel/module/signing.c.

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 include/linux/module.h   |  1 +
 kernel/module/internal.h |  9 +++++
 kernel/module/main.c     | 87 ----------------------------------------
 kernel/module/signing.c  | 75 ++++++++++++++++++++++++++++++++++
 4 files changed, 85 insertions(+), 87 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index fd6161d78127..aea0ffd94a41 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -863,6 +863,7 @@ static inline bool module_sig_ok(struct module *module)
 {
 	return true;
 }
+#define sig_enforce false
 #endif	/* CONFIG_MODULE_SIG */
 
 int module_kallsyms_on_each_symbol(int (*fn)(void *, const char *,
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 99204447ce86..6d5891cc8421 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -162,3 +162,12 @@ static int module_enforce_rwx_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
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
index abdedc15f4f1..403f2aacb3f6 100644
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
@@ -124,28 +123,6 @@ static void module_assert_mutex_or_preempt(void)
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
@@ -2565,70 +2542,6 @@ static inline void kmemleak_load_module(const struct module *mod,
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
2.34.1

