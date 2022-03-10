Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7DC8C433F5
	for <linux-modules@archiver.kernel.org>; Thu, 10 Mar 2022 10:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241261AbiCJK0A (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 10 Mar 2022 05:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241272AbiCJKZu (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 10 Mar 2022 05:25:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 774A313EFAE
        for <linux-modules@vger.kernel.org>; Thu, 10 Mar 2022 02:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646907876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EwM5m/UKCLcQUodhjTTwfqA0OAG1WbMnIR0FKcI9qsQ=;
        b=ZkZch8Dd6jn5g+SaDUYd2hB8rrj/dVdQh7FpjJf8FA31cvSRoKVVwWFkEME4NI4f+flV05
        MWUv5eM11aClVWFxM+5RTs5J+QJbN+jafC5kCG4rhbneW4vwLEUBz8DcYC0UOsNDzKqzp6
        tada2hMUyGf7fyBGc041lVwX0UlYPgQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-604-1-Y-quTcNbeBDX9hurjf5A-1; Thu, 10 Mar 2022 05:24:35 -0500
X-MC-Unique: 1-Y-quTcNbeBDX9hurjf5A-1
Received: by mail-wm1-f72.google.com with SMTP id v67-20020a1cac46000000b00383e71bb26fso1959195wme.1
        for <linux-modules@vger.kernel.org>; Thu, 10 Mar 2022 02:24:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EwM5m/UKCLcQUodhjTTwfqA0OAG1WbMnIR0FKcI9qsQ=;
        b=tae0Ln7BhuFQ3PCciu1U5yCiMmLJl0KU/4s7rWVVJCjJdnfMaZZB/jzVgahca2s7PF
         6Glki54HhcXAPmwRfWubXVytE58/vUuYZAeO7g8CRy54BMvK7JNPSo3eZIeoDhIfaPnZ
         8qx6Njjv3Fg26nmVh/fRGyLZfL4/CaCk0JCRTdBrKbfrnK5/ACKI5gvg1EhSdOqb4A59
         iZXqHSLSL4PI+4q5a+PrBWugqE8IE3ENyRSa5bPoasyo3GVqz01OJKFYrAyYyaSr9/F4
         Jur4uY1F3hT7+CLuzk4WKNYYjdwe9lDDd0smTB8vAWx6/XY73RYqXsdDC6MHnWZGa9qb
         lO/A==
X-Gm-Message-State: AOAM531Xvds3+n8o1A9VPdWZyZDmvWMQ8ds9oytpgyGzRFvPn5Wcu2+W
        nGO+JQGyAON3v21elADOS03zhd1khpPNNT9dz540uCcvp9IJzyVfOjWxvw9jjTAXjnzWDhSnmvi
        Zhm2VQ4GvDkd3QRxxJH7aBaHw
X-Received: by 2002:a05:600c:4142:b0:389:a592:10ce with SMTP id h2-20020a05600c414200b00389a59210cemr3042010wmm.148.1646907873691;
        Thu, 10 Mar 2022 02:24:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzdjUYdxCgT86QW3Z7nzJHOo6s64FYEo4BqKE9S3089+9oXnTJ10VUebqj6CUYdWAtQScU9MA==
X-Received: by 2002:a05:600c:4142:b0:389:a592:10ce with SMTP id h2-20020a05600c414200b00389a59210cemr3041986wmm.148.1646907873507;
        Thu, 10 Mar 2022 02:24:33 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id h12-20020a5d548c000000b001f1f99e7792sm3696411wrv.111.2022.03.10.02.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 02:24:32 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org, christophe.leroy@csgroup.eu
Cc:     cl@linux.com, mbenes@suse.cz, akpm@linux-foundation.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, void@manifault.com,
        atomlin@atomlin.com, allen.lkml@gmail.com, joe@perches.com,
        msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, pmladek@suse.com,
        daniel.thompson@linaro.org, hch@infradead.org
Subject: [PATCH v11 08/14] module: Move kmemleak support to a separate file
Date:   Thu, 10 Mar 2022 10:24:07 +0000
Message-Id: <20220310102413.3438665-9-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220310102413.3438665-1-atomlin@redhat.com>
References: <20220310102413.3438665-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

No functional change.

This patch migrates kmemleak code out of core module
code into kernel/module/debug_kmemleak.c

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 kernel/module/Makefile         |  1 +
 kernel/module/debug_kmemleak.c | 30 ++++++++++++++++++++++++++++++
 kernel/module/internal.h       |  7 +++++++
 kernel/module/main.c           | 27 ---------------------------
 4 files changed, 38 insertions(+), 27 deletions(-)
 create mode 100644 kernel/module/debug_kmemleak.c

diff --git a/kernel/module/Makefile b/kernel/module/Makefile
index d313c8472cb3..12388627725c 100644
--- a/kernel/module/Makefile
+++ b/kernel/module/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_MODULE_SIG) += signing.o
 obj-$(CONFIG_LIVEPATCH) += livepatch.o
 obj-$(CONFIG_MODULES_TREE_LOOKUP) += tree_lookup.o
 obj-$(CONFIG_STRICT_MODULE_RWX) += strict_rwx.o
+obj-$(CONFIG_DEBUG_KMEMLEAK) += debug_kmemleak.o
diff --git a/kernel/module/debug_kmemleak.c b/kernel/module/debug_kmemleak.c
new file mode 100644
index 000000000000..12a569d361e8
--- /dev/null
+++ b/kernel/module/debug_kmemleak.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Module kmemleak support
+ *
+ * Copyright (C) 2009 Catalin Marinas
+ */
+
+#include <linux/module.h>
+#include <linux/kmemleak.h>
+#include "internal.h"
+
+void kmemleak_load_module(const struct module *mod,
+			  const struct load_info *info)
+{
+	unsigned int i;
+
+	/* only scan the sections containing data */
+	kmemleak_scan_area(mod, sizeof(struct module), GFP_KERNEL);
+
+	for (i = 1; i < info->hdr->e_shnum; i++) {
+		/* Scan all writable sections that's not executable */
+		if (!(info->sechdrs[i].sh_flags & SHF_ALLOC) ||
+		    !(info->sechdrs[i].sh_flags & SHF_WRITE) ||
+		    (info->sechdrs[i].sh_flags & SHF_EXECINSTR))
+			continue;
+
+		kmemleak_scan_area((void *)info->sechdrs[i].sh_addr,
+				   info->sechdrs[i].sh_size, GFP_KERNEL);
+	}
+}
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index d6f646a5da41..b0c360839f63 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -167,3 +167,10 @@ static inline int module_sig_check(struct load_info *info, int flags)
 	return 0;
 }
 #endif /* !CONFIG_MODULE_SIG */
+
+#ifdef CONFIG_DEBUG_KMEMLEAK
+void kmemleak_load_module(const struct module *mod, const struct load_info *info);
+#else /* !CONFIG_DEBUG_KMEMLEAK */
+static inline void kmemleak_load_module(const struct module *mod,
+					const struct load_info *info) { }
+#endif /* CONFIG_DEBUG_KMEMLEAK */
diff --git a/kernel/module/main.c b/kernel/module/main.c
index c63e10c61694..7dd283959c5c 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2519,33 +2519,6 @@ bool __weak module_exit_section(const char *name)
 	return strstarts(name, ".exit");
 }
 
-#ifdef CONFIG_DEBUG_KMEMLEAK
-static void kmemleak_load_module(const struct module *mod,
-				 const struct load_info *info)
-{
-	unsigned int i;
-
-	/* only scan the sections containing data */
-	kmemleak_scan_area(mod, sizeof(struct module), GFP_KERNEL);
-
-	for (i = 1; i < info->hdr->e_shnum; i++) {
-		/* Scan all writable sections that's not executable */
-		if (!(info->sechdrs[i].sh_flags & SHF_ALLOC) ||
-		    !(info->sechdrs[i].sh_flags & SHF_WRITE) ||
-		    (info->sechdrs[i].sh_flags & SHF_EXECINSTR))
-			continue;
-
-		kmemleak_scan_area((void *)info->sechdrs[i].sh_addr,
-				   info->sechdrs[i].sh_size, GFP_KERNEL);
-	}
-}
-#else
-static inline void kmemleak_load_module(const struct module *mod,
-					const struct load_info *info)
-{
-}
-#endif
-
 static int validate_section_offset(struct load_info *info, Elf_Shdr *shdr)
 {
 #if defined(CONFIG_64BIT)
-- 
2.34.1

