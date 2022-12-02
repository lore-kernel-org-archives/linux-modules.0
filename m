Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FCEC4332F
	for <linux-modules@archiver.kernel.org>; Fri,  2 Dec 2022 22:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234759AbiLBWsC (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 2 Dec 2022 17:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234753AbiLBWsB (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 2 Dec 2022 17:48:01 -0500
Received: from mail-il1-x149.google.com (mail-il1-x149.google.com [IPv6:2607:f8b0:4864:20::149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840807BC22
        for <linux-modules@vger.kernel.org>; Fri,  2 Dec 2022 14:47:59 -0800 (PST)
Received: by mail-il1-x149.google.com with SMTP id c4-20020a056e020bc400b0030098df879dso6749561ilu.6
        for <linux-modules@vger.kernel.org>; Fri, 02 Dec 2022 14:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kr2FFYjrlmKQpl0FW9cRYWBpZCQQ4WxEePYVPH7PqT0=;
        b=aig6Am3XKh1f74fIoP78XmyYoMV06xOmH0SRrk9TCuJ30vcxCB6RIZVxlkWc4IW82q
         2uIqiG3js6ixvzMtrv2w3qAX1gMUNHU9Jpd+qiPXSNFHKbehWNF7Yhw2hnsYzBVHiz+U
         /xJtJBId/qyG3lUq5Gebw3wMCtj97OgR8Iuh+NX2oUJTao+RSD97NbqgA6jJbdPMvs0d
         v0DCQHtlp3kq5Ddfnf3WHfDLXQoDLyzfX18K4SfCv7rdPhWhlGu0YOEWfi4OkK0rmIKe
         Vz8L0l0NKQWQ8QpriqE46JttBua6QTtUfOf6j36qUTSKJGD76Wfrp8mqX71XIjDSw2Ur
         J52w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kr2FFYjrlmKQpl0FW9cRYWBpZCQQ4WxEePYVPH7PqT0=;
        b=GnbvAbk4JZggnnVcMvbId/6EhDFCNDw70wbTaRHF7TB/wtvkcW2rios7gI2W+/DoCu
         aAoo5/rkoBECb0ic5GazJVnlohi3LTXduuNHduU3MGlGlGqrqVPwnyROZFllXExUSK5C
         d88s+x+UGt7h6ySytNzZhe/dvjof/1S+8H+Q+1VoTGWj4US64bQ+y9U8KoL11V7m66uB
         Hp2cX1aNLeoQaG98r10Ahl2tdwhvSkYQ0bHr4ZG7r9FAYV42b63oMdRKQfmzlsOXUc17
         ZHx7nD5mWqOPvB4jVRmkYjkJD1tZniK+0/WORzD9N/mbNAF3mWiDeaQ+5Y4cTWcRReCZ
         S+oQ==
X-Gm-Message-State: ANoB5pmpQfSBlpDZJMDYnFLs1nTmZ34s1cEfWya2iPK4LCTG2mFb4aqb
        uImkUs3JWuLES22bKwTbBCJvWYzI8g4t1/f6T4LmjugjFK5d/k3xmzcofNfZHfOJ6O9i18T1SMd
        JyJvnEb9h72xPAYux1+kEj1HI5Iwf+ZRy0r70qHI46nU9SYhje6AFgvJd0nL7hGm8WwxAzC5LAo
        oKtbM=
X-Google-Smtp-Source: AA0mqf6Pfb/78vXpVbkKCzqWVQv6p/o5CGfleflTWNDSxkmzuLudt9k+BC1QXoNkn4IL0y9f0t/YX3baNUddM3A=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:a6b:fb13:0:b0:6de:383e:4146 with SMTP id
 h19-20020a6bfb13000000b006de383e4146mr27314176iog.48.1670021278767; Fri, 02
 Dec 2022 14:47:58 -0800 (PST)
Date:   Fri,  2 Dec 2022 16:47:40 -0600
In-Reply-To: <20221202224540.1446952-1-allenwebb@google.com>
Mime-Version: 1.0
References: <20221202224540.1446952-1-allenwebb@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221202224744.1447448-1-allenwebb@google.com>
Subject: [PATCH v6 1/5] module: Add empty modalias sysfs attribute
From:   Allen Webb <allenwebb@google.com>
To:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Allen Webb <allenwebb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

This adds the modalias sysfs attribute in preparation for its
implementation.

Signed-off-by: Allen Webb <allenwebb@google.com>
---
 include/linux/module.h   |  1 +
 kernel/module/internal.h |  2 ++
 kernel/module/sysfs.c    | 33 +++++++++++++++++++++++++++++++++
 kernel/params.c          |  7 +++++++
 4 files changed, 43 insertions(+)

diff --git a/include/linux/module.h b/include/linux/module.h
index ec61fb53979a9..0bfa859a21566 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -47,6 +47,7 @@ struct module_kobject {
 	struct kobject *drivers_dir;
 	struct module_param_attrs *mp;
 	struct completion *kobj_completion;
+	struct bin_attribute modalias_attr;
 } __randomize_layout;
 
 struct module_attribute {
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 2e2bf236f5582..8d7ae37584868 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -259,11 +259,13 @@ static inline void add_kallsyms(struct module *mod, const struct load_info *info
 #endif /* CONFIG_KALLSYMS */
 
 #ifdef CONFIG_SYSFS
+void add_modalias_attr(struct module_kobject *mk);
 int mod_sysfs_setup(struct module *mod, const struct load_info *info,
 		    struct kernel_param *kparam, unsigned int num_params);
 void mod_sysfs_teardown(struct module *mod);
 void init_param_lock(struct module *mod);
 #else /* !CONFIG_SYSFS */
+static inline void add_modalias_attr(struct module_kobject *mk) {}
 static inline int mod_sysfs_setup(struct module *mod,
 			   	  const struct load_info *info,
 			   	  struct kernel_param *kparam,
diff --git a/kernel/module/sysfs.c b/kernel/module/sysfs.c
index ce68f821dcd12..8dafec7455fbe 100644
--- a/kernel/module/sysfs.c
+++ b/kernel/module/sysfs.c
@@ -240,6 +240,37 @@ static inline void add_notes_attrs(struct module *mod, const struct load_info *i
 static inline void remove_notes_attrs(struct module *mod) { }
 #endif /* CONFIG_KALLSYMS */
 
+static ssize_t module_modalias_read(struct file *filp, struct kobject *kobj,
+				    struct bin_attribute *bin_attr,
+				    char *buf, loff_t pos, size_t count)
+{
+	return 0;
+}
+
+/* Used in kernel/params.c for builtin modules.
+ *
+ * `struct module_kobject` is used instead of `struct module` because for
+ * builtin modules, the `struct module` is not available when this is called.
+ */
+void add_modalias_attr(struct module_kobject *mk)
+{
+	sysfs_bin_attr_init(&mk->modalias_attr);
+	mk->modalias_attr.attr.name = "modalias";
+	mk->modalias_attr.attr.mode = 0444;
+	mk->modalias_attr.read = module_modalias_read;
+	if (sysfs_create_bin_file(&mk->kobj, &mk->modalias_attr)) {
+		/* We shouldn't ignore the return type, but there is nothing to
+		 * do.
+		 */
+		return;
+	}
+}
+
+static void remove_modalias_attr(struct module_kobject *mk)
+{
+	sysfs_remove_bin_file(&mk->kobj, &mk->modalias_attr);
+}
+
 static void del_usage_links(struct module *mod)
 {
 #ifdef CONFIG_MODULE_UNLOAD
@@ -398,6 +429,7 @@ int mod_sysfs_setup(struct module *mod,
 
 	add_sect_attrs(mod, info);
 	add_notes_attrs(mod, info);
+	add_modalias_attr(&mod->mkobj);
 
 	return 0;
 
@@ -415,6 +447,7 @@ int mod_sysfs_setup(struct module *mod,
 
 static void mod_sysfs_fini(struct module *mod)
 {
+	remove_modalias_attr(&mod->mkobj);
 	remove_notes_attrs(mod);
 	remove_sect_attrs(mod);
 	mod_kobject_put(mod);
diff --git a/kernel/params.c b/kernel/params.c
index 5b92310425c50..b7fd5313a3118 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -14,6 +14,12 @@
 #include <linux/ctype.h>
 #include <linux/security.h>
 
+#ifdef CONFIG_MODULES
+#include "module/internal.h"
+#else
+static inline void add_modalias_attr(struct module_kobject *mk) {}
+#endif /* !CONFIG_MODULES */
+
 #ifdef CONFIG_SYSFS
 /* Protects all built-in parameters, modules use their own param_lock */
 static DEFINE_MUTEX(param_lock);
@@ -815,6 +821,7 @@ static void __init kernel_add_sysfs_param(const char *name,
 	BUG_ON(err);
 	kobject_uevent(&mk->kobj, KOBJ_ADD);
 	kobject_put(&mk->kobj);
+	add_modalias_attr(mk);
 }
 
 /*
-- 
2.37.3

