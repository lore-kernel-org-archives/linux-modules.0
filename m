Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E627C433F5
	for <linux-modules@archiver.kernel.org>; Fri, 28 Jan 2022 20:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244048AbiA1Ujn (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 28 Jan 2022 15:39:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:54412 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240847AbiA1Ujl (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 28 Jan 2022 15:39:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643402380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CKFHu1mwRyMCd3tE6xfYJyy3RgbH1D0nAbWrHT5RWOU=;
        b=axA3pjk7c5NpMwtJo8aKHvM/cPPmhcXBvEA3OyO6+J1HGQZhZiWK8KZvtuvaviah30jj4s
        W42/zSaWqgONc6zS2RkEV3QMyBbn81ZOEmGPe9863hdC+HD5rQUULl1ihu23lQaYI187ZP
        d32Iu2QAVSKq48IOrFzF+X4OscM8HZQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-609-23Q6byN2Nd2e0FyfqWQpBA-1; Fri, 28 Jan 2022 15:39:39 -0500
X-MC-Unique: 23Q6byN2Nd2e0FyfqWQpBA-1
Received: by mail-wm1-f71.google.com with SMTP id z2-20020a05600c220200b0034d2eb95f27so3471273wml.1
        for <linux-modules@vger.kernel.org>; Fri, 28 Jan 2022 12:39:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CKFHu1mwRyMCd3tE6xfYJyy3RgbH1D0nAbWrHT5RWOU=;
        b=bAvpG0NMFw+/c0e2tYOV4q7lcWjlRaPwKyrXtaOj6AcZir6JzUzX2LEWVs0u8z/t5f
         akiUG7hpHku2EPLtk90JkIRCKEx4rV1IHYPrLmZXlRF7TGyXDKRw3WwhrTYhlDaNIHw+
         hO+TCJBkWmS3hQZTd+eR1FZmde+OKVf/ipdk8D/yCNVZe+sN4Gb73hov/3Vw9G4g3cg4
         XtO2BgkBR4lQtNN/qkPXhqDMFiuEtCoDIQGV3vRXvhbQ1rsCu+79t0jwLoBTlMbQMixa
         POW2UqkJEYy7TpWs5pROIourD8ZAXjolrq4RbchhhqAosF7IeIFRJN2eFcdBD3n5jfAR
         YWaQ==
X-Gm-Message-State: AOAM532R4evhHerBEKpWC/nP35Gor2VazOQgF4dYl9t30G1nTiHcYhsS
        cHtxx5XBY5CmVDsxnRZmm/LskIOK0+Tm+nS7HWbn4BBRKkv188koVRqVrsfUHUfdQTZkAvQbGBm
        9EOJuv7AXq4NPbQKl97wz6YOc
X-Received: by 2002:a05:600c:1ca0:: with SMTP id k32mr7305020wms.62.1643402378587;
        Fri, 28 Jan 2022 12:39:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx071r+pfGCf25/UPxmKSKMz79BwnrKoE01zXclK8LWdr1k4TAP66d3QLFEJ4AAKM2Umk5oMg==
X-Received: by 2002:a05:600c:1ca0:: with SMTP id k32mr7305003wms.62.1643402378384;
        Fri, 28 Jan 2022 12:39:38 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id f13sm6960199wry.77.2022.01.28.12.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 12:39:37 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        live-patching@vger.kernel.org, atomlin@atomlin.com,
        ghalat@redhat.com, allen.lkml@gmail.com
Subject: [RFC PATCH v3 02/13] module: Simple refactor in preparation for split
Date:   Fri, 28 Jan 2022 20:39:23 +0000
Message-Id: <20220128203934.600247-3-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220128203934.600247-1-atomlin@redhat.com>
References: <20220128203934.600247-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

No functional change.

This patch makes it possible to move non-essential code
out of core module code.

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 kernel/module/internal.h | 22 ++++++++++++++++++++++
 kernel/module/main.c     | 23 ++---------------------
 2 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 8c381c99062f..e3c593f8767f 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -7,6 +7,28 @@
 
 #include <linux/elf.h>
 #include <asm/module.h>
+#include <linux/mutex.h>
+
+#ifndef ARCH_SHF_SMALL
+#define ARCH_SHF_SMALL 0
+#endif
+
+/* If this is set, the section belongs in the init part of the module */
+#define INIT_OFFSET_MASK (1UL << (BITS_PER_LONG-1))
+/* Maximum number of characters written by module_flags() */
+#define MODULE_FLAGS_BUF_SIZE (TAINT_FLAGS_COUNT + 4)
+#define MODULE_SECT_READ_SIZE (3 /* "0x", "\n" */ + (BITS_PER_LONG / 4))
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
index d8c6269af6cf..fee64c4957f3 100644
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
@@ -1490,7 +1475,6 @@ struct module_sect_attrs {
 	struct module_sect_attr attrs[];
 };
 
-#define MODULE_SECT_READ_SIZE (3 /* "0x", "\n" */ + (BITS_PER_LONG / 4))
 static ssize_t module_sect_read(struct file *file, struct kobject *kobj,
 				struct bin_attribute *battr,
 				char *buf, loff_t pos, size_t count)
@@ -4555,9 +4539,6 @@ static void cfi_cleanup(struct module *mod)
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

