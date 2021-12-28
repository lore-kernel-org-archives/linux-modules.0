Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81029C433EF
	for <linux-modules@archiver.kernel.org>; Tue, 28 Dec 2021 21:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237503AbhL1Vat (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 28 Dec 2021 16:30:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:45070 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236380AbhL1Var (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 28 Dec 2021 16:30:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640727046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7kJi6QbhQe0UKqaYog/4fs8E9UhX+TpYHbtJQ2kzdak=;
        b=hbop5jSnE+BTiFCVm2J6DwAT81q49tG8+2dEA+nW2m5/lBeCqdGSoQ1jb9eXmeSR/AaY84
        zbhX6gv6Olp2wt1jKCwS7jyZWJmRuYCSs87rkz1a7PTCGVCbAvWPrYPNhm1r5Iw7C7VtnB
        EGOx7Qxb2bvI4017Xy4eXDewu+HIE8Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-633-eKG8HT_dNkmdhLnh0a4Zfw-1; Tue, 28 Dec 2021 16:30:45 -0500
X-MC-Unique: eKG8HT_dNkmdhLnh0a4Zfw-1
Received: by mail-wr1-f72.google.com with SMTP id s30-20020adfa29e000000b001a25caee635so4301672wra.19
        for <linux-modules@vger.kernel.org>; Tue, 28 Dec 2021 13:30:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7kJi6QbhQe0UKqaYog/4fs8E9UhX+TpYHbtJQ2kzdak=;
        b=djgDP83San4cCoQXcfN9/Gmn3hpKNgATopp4b19kd33w6h/mi/SQZsQI1W4jP7CoA6
         BvVuA/9+KdAxO9OmFlGl96/Lk5/FSrVz0LBs0hq62R/Rj4W1NNffmn197Gz1QANEKZHf
         VRXFLXs32VbgdrEluBPkyGZzsIieoOmA69/+GGREt98urXOJcgD8x1otuVTn9EdU7+5g
         rOdt4qkx/0L+yMvf1RFlT9uZ2JbGipDEJYPbHCBlxx9qIuJZVF6vOHyx5jJTmnx/WkR4
         Yd2hmXKOfvFExfqL6W2JJ9w+b7r8R3l5j9kRmWp7wWMYBLFC8xxKYBIpcKdfmPgdn+DE
         lZ4g==
X-Gm-Message-State: AOAM533ryFU5yngfUhHxSMktyKnLY5/G5PFx/wFfWsO4ai4ng2NMbjCq
        VIGVBopH91QafPR+Ofmm3wz+nMjCmRKSm2PvFx0AQhEsEB/9phGr+LyTjv5H4Ov4EZI2GFS6CC+
        ud0n5x/lseTVL3TUjfepQjc8V
X-Received: by 2002:adf:f40b:: with SMTP id g11mr17714782wro.645.1640727044320;
        Tue, 28 Dec 2021 13:30:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwbqBZEjYGOyh2QSHDIyFzBjjvk3ujK70INOECBs15JXNRoREc+6f2quKphIDOOu8dbecImnQ==
X-Received: by 2002:adf:f40b:: with SMTP id g11mr17714769wro.645.1640727044176;
        Tue, 28 Dec 2021 13:30:44 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id h3sm19232220wrt.94.2021.12.28.13.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 13:30:43 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com
Subject: [RFC PATCH 02/12] module: Simple refactor in preparation for split
Date:   Tue, 28 Dec 2021 21:30:31 +0000
Message-Id: <20211228213041.1356334-3-atomlin@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211228213041.1356334-1-atomlin@redhat.com>
References: <YbKUUJUtjBk/n913@bombadil.infradead.org>
 <20211228213041.1356334-1-atomlin@redhat.com>
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
index 33783abc377b..ffc50df010a7 100644
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
index bc997c3e2c95..2a6b859716c0 100644
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
@@ -1491,7 +1476,6 @@ struct module_sect_attrs {
 	struct module_sect_attr attrs[];
 };
 
-#define MODULE_SECT_READ_SIZE (3 /* "0x", "\n" */ + (BITS_PER_LONG / 4))
 static ssize_t module_sect_read(struct file *file, struct kobject *kobj,
 				struct bin_attribute *battr,
 				char *buf, loff_t pos, size_t count)
@@ -4498,9 +4482,6 @@ static void cfi_cleanup(struct module *mod)
 #endif
 }
 
-/* Maximum number of characters written by module_flags() */
-#define MODULE_FLAGS_BUF_SIZE (TAINT_FLAGS_COUNT + 4)
-
 /* Keep in sync with MODULE_FLAGS_BUF_SIZE !!! */
 static char *module_flags(struct module *mod, char *buf)
 {
-- 
2.31.1

