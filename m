Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8D7C77B6F
	for <linux-modules@archiver.kernel.org>; Thu,  6 Apr 2023 19:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239846AbjDFTBL (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 6 Apr 2023 15:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240363AbjDFTBH (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 6 Apr 2023 15:01:07 -0400
Received: from mail-il1-x14a.google.com (mail-il1-x14a.google.com [IPv6:2607:f8b0:4864:20::14a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E242186AD
        for <linux-modules@vger.kernel.org>; Thu,  6 Apr 2023 12:01:02 -0700 (PDT)
Received: by mail-il1-x14a.google.com with SMTP id d5-20020a923605000000b003232594207dso26428331ila.8
        for <linux-modules@vger.kernel.org>; Thu, 06 Apr 2023 12:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680807662;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lY1ByN87FMvQLmIB6FmZa+RzwBjVh5nyLSYhKEEms/o=;
        b=TXJhoFceFs9wdYTRZd708YmwDXv6ZmJEZM5qsCVnFNFux6VSIy2sN485OdoLj6gH/u
         AQsSA/pqWjyYGM48tvaIncpfU2OLAUpCMQfGEUljMQY32VJVtir3KfI0/oLx5XXuijgt
         IdQDFo/dXt9qgNaakCRBJpEPF2lgHkdbMkFeyywUgZbfu/OiLuvJ3B+dRHj3/Osu3wFs
         Igv3FoQJ+xdCyHBUlOkjbozloyiEts0oRkMIvsUAEiq5xM+8ae/xA8FEMfg2w3bV7nHX
         XXgsLfahva+s2fFRR2U9HW32kdVcssWxj7eIV8JYkxojb7lCllY002RCrgMUSAo+vdRi
         BYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680807662;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lY1ByN87FMvQLmIB6FmZa+RzwBjVh5nyLSYhKEEms/o=;
        b=7DRY92zs0KcGx1dOUnjcG6BUZc2ZsDPOBesZ5iCfVk/E4tjYsrjTc0YPbWmNKTj4az
         4awV3ocsawPItS4juY7JaN4YNRBzRTAZNTq3mzs7MepqN+oVhZKeqFewgG2f3L91mQ6K
         NZFV0tyI4G6/ZEgLw4eSa4cmL/EWoss08FrrAvlJZkQkiE5ITE3Y/fBx0Z4AylOTHha2
         RFzNsiTGJkmaSfXaBmevr6H6t1yOD6gxTerPmtjVmacgSTvVTbePZOtp2VKcyYyUP9jv
         pmOvWbS4NxUot5QUgwT93w3wScOPODYW3jYKu1ucjLMGGObbhdKollToOxXzM65cAUko
         yxaw==
X-Gm-Message-State: AAQBX9ewD6w9AR2G8mXt3rDh1E2l8XTHw8WXADPrjco08dmpaUv6Y8Nz
        6GkthWyrXyVvXdriHz1ZPTM1cuy0biklTh9DHTZeWcwYcJq+q5tcyK3+NeoLIPTddNwJBaRlQch
        V9UdZqgKRIXPXRJ59slRxES+eWPQcHIJhhf3VR8ApMnLnhSViczVcSZZ689Ddsz3Cj103lqU+j9
        oZOng=
X-Google-Smtp-Source: AKy350Y53lWgT3pwwk/QGvquIa8pju0CYYGVAfASYtJqDKWDb552KXeL4N024JqlQO8Qz0mCpt8UDRDqw6NUjSI=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:a02:8503:0:b0:3a9:75c9:da25 with SMTP id
 g3-20020a028503000000b003a975c9da25mr5548851jai.1.1680807662053; Thu, 06 Apr
 2023 12:01:02 -0700 (PDT)
Date:   Thu,  6 Apr 2023 14:00:23 -0500
In-Reply-To: <20230406190030.968972-1-allenwebb@google.com>
Mime-Version: 1.0
References: <20221219204619.2205248-1-allenwebb@google.com> <20230406190030.968972-1-allenwebb@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230406190030.968972-5-allenwebb@google.com>
Subject: [PATCH v10 04/11] module.h: MODULE_DEVICE_TABLE for built-in modules
From:   Allen Webb <allenwebb@google.com>
To:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     gregkh@linuxfoundation.org, mcgrof@kernel.org,
        christophe.leroy@csgroup.eu, nick.alcock@oracle.com,
        Allen Webb <allenwebb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Implement MODULE_DEVICE_TABLE for build-in modules to make it possible
to generate a builtin.alias file to complement modules.alias.

Signed-off-by: Allen Webb <allenwebb@google.com>
---
 include/linux/module.h | 36 +++++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 4435ad9439ab..b1cb12e06996 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -237,14 +237,36 @@ extern void cleanup_module(void);
 /* What your module does. */
 #define MODULE_DESCRIPTION(_description) MODULE_INFO(description, _description)
 
-#ifdef MODULE
-/* Creates an alias so file2alias.c can find device table. */
+/*
+ * Creates an alias so file2alias.c can find device table.
+ *
+ * Use this in cases where a device table is used to match devices because it
+ * surfaces match-id based module aliases to userspace for:
+ *   - Automatic module loading through modules.alias.
+ *   - Tools like USBGuard which block devices based on policy such as which
+ *     modules match a device.
+ *
+ * The only use-case for built-in drivers today is to enable userspace to
+ * prevent / allow probe for devices on certain subsystems even if the driver is
+ * already loaded. An example is the USB subsystem with its authorized_default
+ * sysfs attribute. For more details refer to the kernel's Documentation for USB
+ * about authorized_default.
+ *
+ * The module name is included in the alias for two reasons:
+ *   - It avoids creating two aliases with the same name for built-in modules.
+ *     Historically MODULE_DEVICE_TABLE was a no-op for built-in modules, so
+ *     there was nothing to stop different modules from having the same device
+ *     table name and consequently the same alias when building as a module.
+ *   - The module name is needed by files2alias.c to associate a particular
+ *     device table with its associated module for built-in modules since
+ *     files2alias would otherwise see the module name as `vmlinuz.o`.
+ */
 #define MODULE_DEVICE_TABLE(type, name)					\
-extern typeof(name) __mod_##type##__##name##_device_table		\
-  __attribute__ ((unused, alias(__stringify(name))))
-#else  /* !MODULE */
-#define MODULE_DEVICE_TABLE(type, name)
-#endif
+extern void *CONCATENATE(						\
+	CONCATENATE(__mod_##type##__##name##__,				\
+		__KBUILD_MODNAME),					\
+	_device_table)							\
+	__attribute__ ((unused, alias(__stringify(name))))
 
 /* Version of form [<epoch>:]<version>[-<extra-version>].
  * Or for CVS/RCS ID version, everything but the number is stripped.
-- 
2.39.2

