Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA03BC433F5
	for <linux-modules@archiver.kernel.org>; Mon,  7 Mar 2022 17:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240204AbiCGRqN (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 7 Mar 2022 12:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240039AbiCGRqM (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 7 Mar 2022 12:46:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA66671ED6
        for <linux-modules@vger.kernel.org>; Mon,  7 Mar 2022 09:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646675117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zln+MaotO9F3OZWBQkZ8RRcCDDlcbIVRMz8zB5PgPNY=;
        b=i1Psm0wIoaGxjcx0KJV2v/hhvhePk1TgM0KGeIJny9tW606yUcOaD8J10lGZpy6+3dq1Lv
        YjvkalI7oDJO0ChBRVTEiKRC8y/ka3Iv7nsB5GRpcdnvFegUW1CZyNYyG5T5C6XQur1IDi
        sgoE2g85Gjdypq20xRfPJ/vrr/BE2IE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-661-FiDYAufoN-SyN1aQ3oxnow-1; Mon, 07 Mar 2022 12:45:15 -0500
X-MC-Unique: FiDYAufoN-SyN1aQ3oxnow-1
Received: by mail-wr1-f70.google.com with SMTP id w17-20020adfec51000000b001f068bc3342so2581557wrn.6
        for <linux-modules@vger.kernel.org>; Mon, 07 Mar 2022 09:45:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zln+MaotO9F3OZWBQkZ8RRcCDDlcbIVRMz8zB5PgPNY=;
        b=Y8zQDy8aAQ5d6gwZ2vMc6SWQ0tnj1Y5UP/oKjWFu+2wwZ2BJyl4NXw38v0tkYw1Fap
         QvSgf4HcC5jxGKDZ628+SvTui+lKAg6DNWEQHPrsplu0iLP9/5XiYnL+rzqSDtNt30Wq
         6iMrFqborOkuNxzHTJ56rmzUxW6rm2NZDgv3+JQvm4pIZTmh114nZlJ5nqHc7M1/6lR+
         RiAfJiPXhTNOItF/7vyAOXHhbsTd2l7cFJpSaVboAGvnXm801jryyU/20tA1QmyoJXmt
         4sNrTszhhAQSKclIbV6tnh4VkwUrSzQc+9VVV8N5BJnvRNMx04CH9jgCJDBkknFmaTe9
         e2kA==
X-Gm-Message-State: AOAM5304uIMo9SEX9yk+cX9SwyYZ5qmuCxX90/s8Dq3DOoZL7LHcvLdI
        7B8RWd4FYHmLH4VMCnIwHw2banKiHFLe69neLmQ72OIbdpRTPR7fzl0MuW99yDQkopixW0qANAT
        nCyREA8IUNl6uuLTkOzzGBcNH
X-Received: by 2002:a1c:3b8a:0:b0:380:e40a:289 with SMTP id i132-20020a1c3b8a000000b00380e40a0289mr34309wma.17.1646675114811;
        Mon, 07 Mar 2022 09:45:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyY/fkUfr3e+yHgjvOoGxvPVt/pwa4RcBCbGkd/zhkEYQLLrZJrU48t5SjlLln7AqjJ3UDMgA==
X-Received: by 2002:a1c:3b8a:0:b0:380:e40a:289 with SMTP id i132-20020a1c3b8a000000b00380e40a0289mr34275wma.17.1646675114602;
        Mon, 07 Mar 2022 09:45:14 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id g11-20020a5d554b000000b001f0326a23ddsm12153963wrw.70.2022.03.07.09.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 09:45:14 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org, christophe.leroy@csgroup.eu
Cc:     cl@linux.com, mbenes@suse.cz, akpm@linux-foundation.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, void@manifault.com,
        atomlin@atomlin.com, allen.lkml@gmail.com, joe@perches.com,
        msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, daniel.thompson@linaro.org,
        hch@infradead.org, pmladek@suse.com
Subject: [PATCH v10 02/14] module: Simple refactor in preparation for split
Date:   Mon,  7 Mar 2022 17:44:57 +0000
Message-Id: <20220307174509.2887714-3-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220307174509.2887714-1-atomlin@redhat.com>
References: <20220307174509.2887714-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

No functional change.

This patch makes it possible to move non-essential code
out of core module code.

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 kernel/module/internal.h | 21 +++++++++++++++++++++
 kernel/module/main.c     | 22 ++--------------------
 2 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 8c381c99062f..ea8c4c02614c 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -7,6 +7,27 @@
 
 #include <linux/elf.h>
 #include <asm/module.h>
+#include <linux/mutex.h>
+
+#ifndef ARCH_SHF_SMALL
+#define ARCH_SHF_SMALL 0
+#endif
+
+/* If this is set, the section belongs in the init part of the module */
+#define INIT_OFFSET_MASK (1UL << (BITS_PER_LONG - 1))
+/* Maximum number of characters written by module_flags() */
+#define MODULE_FLAGS_BUF_SIZE (TAINT_FLAGS_COUNT + 4)
+
+extern struct mutex module_mutex;
+extern struct list_head modules;
+
+/* Provided by the linker */
+extern const struct kernel_symbol __start___ksymtab[];
+extern const struct kernel_symbol __stop___ksymtab[];
+extern const struct kernel_symbol __start___ksymtab_gpl[];
+extern const struct kernel_symbol __stop___ksymtab_gpl[];
+extern const s32 __start___kcrctab[];
+extern const s32 __start___kcrctab_gpl[];
 
 struct load_info {
 	const char *name;
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 34a2b0cf3c3e..5f5e21f972dd 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -63,10 +63,6 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/module.h>
 
-#ifndef ARCH_SHF_SMALL
-#define ARCH_SHF_SMALL 0
-#endif
-
 /*
  * Modules' sections will be aligned on page boundaries
  * to ensure complete separation of code and data, but
@@ -78,9 +74,6 @@
 # define debug_align(X) (X)
 #endif
 
-/* If this is set, the section belongs in the init part of the module */
-#define INIT_OFFSET_MASK (1UL << (BITS_PER_LONG-1))
-
 /*
  * Mutex protects:
  * 1) List of modules (also safely readable with preempt_disable),
@@ -88,8 +81,8 @@
  * 3) module_addr_min/module_addr_max.
  * (delete and add uses RCU list operations).
  */
-static DEFINE_MUTEX(module_mutex);
-static LIST_HEAD(modules);
+DEFINE_MUTEX(module_mutex);
+LIST_HEAD(modules);
 
 /* Work queue for freeing init sections in success case */
 static void do_free_init(struct work_struct *w);
@@ -408,14 +401,6 @@ static __maybe_unused void *any_section_objs(const struct load_info *info,
 	return (void *)info->sechdrs[sec].sh_addr;
 }
 
-/* Provided by the linker */
-extern const struct kernel_symbol __start___ksymtab[];
-extern const struct kernel_symbol __stop___ksymtab[];
-extern const struct kernel_symbol __start___ksymtab_gpl[];
-extern const struct kernel_symbol __stop___ksymtab_gpl[];
-extern const s32 __start___kcrctab[];
-extern const s32 __start___kcrctab_gpl[];
-
 #ifndef CONFIG_MODVERSIONS
 #define symversion(base, idx) NULL
 #else
@@ -4542,9 +4527,6 @@ static void cfi_cleanup(struct module *mod)
 #endif
 }
 
-/* Maximum number of characters written by module_flags() */
-#define MODULE_FLAGS_BUF_SIZE (TAINT_FLAGS_COUNT + 4)
-
 /* Keep in sync with MODULE_FLAGS_BUF_SIZE !!! */
 static char *module_flags(struct module *mod, char *buf)
 {
-- 
2.34.1

