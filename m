Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DB4C4332F
	for <linux-modules@archiver.kernel.org>; Fri, 18 Feb 2022 21:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239783AbiBRVZj (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 18 Feb 2022 16:25:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239772AbiBRVZg (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 18 Feb 2022 16:25:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 40C1E23F0A3
        for <linux-modules@vger.kernel.org>; Fri, 18 Feb 2022 13:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645219518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7zVpwYHDHIaBW4/Qu1I++XmAGaqsqPN3XBi8gcs7g9U=;
        b=fAWtiMcabjGiEJAQx+pryfxcHpVl2tkW7a6ke2FmiJPe36Se5EDB5Buc7UNN8wiXzdo3Es
        iwaQbkfKJylhjdFU5AbhP1xTQPku2C41xBl1m6rPZP3w3A3w1JjgYEMT5A37S3fPvEsggd
        +D5IqmaF6+7VilTi1b0nPT8mlfR7p4Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-64-SjK8XqWDMJSXf1JFtitjHw-1; Fri, 18 Feb 2022 16:25:17 -0500
X-MC-Unique: SjK8XqWDMJSXf1JFtitjHw-1
Received: by mail-wm1-f69.google.com with SMTP id v130-20020a1cac88000000b0037e3d70e7e1so3708036wme.1
        for <linux-modules@vger.kernel.org>; Fri, 18 Feb 2022 13:25:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7zVpwYHDHIaBW4/Qu1I++XmAGaqsqPN3XBi8gcs7g9U=;
        b=iNZRSUy7J953gTgVN0vmRKo4ZLuQx+qOQw2AqItARWYYw3k1cdeh5Re7UosAGVZJfh
         uQh7hAQ9xl3aVfk9IEQN6WbWSzfYyyxROxxr+SmnD0avQl9niAMwiJsxGw9NtkG+trO8
         23nQU94ClZaZnfQ7gO9jlzf7wV3j0g4zzf6ZMe+PI0UpZZfX2tTSTIjveGXuYU7s20P3
         YQ09i7gEj9zLIE4F+NRALc9toy4JvCFusRQ4WBQ+jrwF3q0BT2Q8aBKeO7XdeFdYllSH
         lR4xow4WYSQExAbhc/JlI1RiMJ4C/a+3scoPX/kSfwPaeGm3iel0FvtMM/I8fNpPUdSL
         LAEA==
X-Gm-Message-State: AOAM530wetRJW2ZMoPs0Qn89yHfuAeUcANGBuSuy+h2dkMlVV2Vol/FH
        HhmTi15VnizbqNIuYVXuFM2VKUMI8Aj5uCKQE99IuaxlolTFZ1jP9FpT9xflEgD9OmbIUkfuDhk
        KSpEF8t4przNwp/vYX0kjCvIR
X-Received: by 2002:a7b:c4ce:0:b0:37c:49b:403d with SMTP id g14-20020a7bc4ce000000b0037c049b403dmr8781027wmk.90.1645219515857;
        Fri, 18 Feb 2022 13:25:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJymMX3gO6OiWxbu+w7bG7vFV4zMkN14kQa4YRqO+Dth6Y79BaztOus2OvCJ4bxyIHy7Kv/VkA==
X-Received: by 2002:a7b:c4ce:0:b0:37c:49b:403d with SMTP id g14-20020a7bc4ce000000b0037c049b403dmr8781004wmk.90.1645219515600;
        Fri, 18 Feb 2022 13:25:15 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id b15sm41534566wri.96.2022.02.18.13.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 13:25:15 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        live-patching@vger.kernel.org, atomlin@atomlin.com,
        ghalat@redhat.com, allen.lkml@gmail.com, joe@perches.com,
        christophe.leroy@csgroup.eu, msuchanek@suse.de,
        oleksandr@natalenko.name
Subject: [PATCH v6 02/13] module: Simple refactor in preparation for split
Date:   Fri, 18 Feb 2022 21:25:00 +0000
Message-Id: <20220218212511.887059-3-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220218212511.887059-1-atomlin@redhat.com>
References: <20220218212511.887059-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

No functional change.

This patch makes it possible to move non-essential code
out of core module code.

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

