Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F019C433F5
	for <linux-modules@archiver.kernel.org>; Mon, 25 Apr 2022 09:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241112AbiDYJMB (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 25 Apr 2022 05:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbiDYJL5 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 25 Apr 2022 05:11:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B010C9B42
        for <linux-modules@vger.kernel.org>; Mon, 25 Apr 2022 02:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650877732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7UCwzHE3i1dq/qNGOoGWSbel4RLLAWZDbZnWwu5x7jM=;
        b=OQUqyHSPU8BSkHxON+WM0Z48HdGUtMBjPbXiiD3GIb5FEMPkmhu4lFF86RP6BaaO4E7378
        rOzSvBfAJ5Tx9MrG+jlGznmmu3Xnh3ADC2NbxCpjIpRcp/SUjJF2WJhDn8E8Xv/fCDOSes
        jxR4QTuHhGE2WnUtQg1eLVNwoVuC/GM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-dio3lhGGPESihvugWo8OkA-1; Mon, 25 Apr 2022 05:08:49 -0400
X-MC-Unique: dio3lhGGPESihvugWo8OkA-1
Received: by mail-wm1-f71.google.com with SMTP id y11-20020a7bc18b000000b0038eac019fc0so6898640wmi.9
        for <linux-modules@vger.kernel.org>; Mon, 25 Apr 2022 02:08:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7UCwzHE3i1dq/qNGOoGWSbel4RLLAWZDbZnWwu5x7jM=;
        b=BeNsjeO82+9CYm6/c3qlOMdQeV6IxaZm7hTxnyBGWyeD0SFuq/jT57ttEpitWAJKl1
         3tji5NCpIhn3V70lV4L6XL+TfbFSu/OqNF82l+mNciIxPErTw2DwG/8qQiHsHpC9L6qr
         Uymc8VJiVcWPi6If1dK++i8XsmgeR1RG5CGbdfxG7Oj1jfSMRhMM5fERGQzy1JX3LHk1
         5wwwUgEqpbFzXjfFaI9FcVQzxTjvgFtr1ra9HlTd23tO/jY7Xn7jqyV1lZ/MYUJtiZGF
         Wm317QYrACGF/7Jud1tXYecTRQfQKX5sJUWwuwjQWdkNCt9K1gpP9p4mgpDoTKpANueW
         TlZQ==
X-Gm-Message-State: AOAM532C39VOfsxBodEZVwjLm/TkKP3z1ECAwkayQAXvzTIQeuA7hzuN
        AhGoBaU9TZE7f9yjnsn2zMdcjPJMHw3uqEgvq+HDjUvXN0O4WstHxVleJFUzTQ0/JqiJBM6bqTN
        sh/6rGiVS2mKJkTxFtAgGmvi6
X-Received: by 2002:a05:600c:281:b0:38e:bc6e:5971 with SMTP id 1-20020a05600c028100b0038ebc6e5971mr15608767wmk.111.1650877728046;
        Mon, 25 Apr 2022 02:08:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+ka7rhRqfE4pSkDVBAfjJmPXrDOYb219F24apu+8D+rAjhTBnw9h3sbZ1t4AjyPzHf5C+Sg==
X-Received: by 2002:a05:600c:281:b0:38e:bc6e:5971 with SMTP id 1-20020a05600c028100b0038ebc6e5971mr15608749wmk.111.1650877727825;
        Mon, 25 Apr 2022 02:08:47 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id l10-20020a05600002aa00b0020a7cc29000sm9325070wry.75.2022.04.25.02.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 02:08:46 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        christophe.leroy@csgroup.eu, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com, oleksandr@natalenko.name,
        neelx@redhat.com
Subject: [PATCH v4 2/2] module: Introduce module unload taint tracking
Date:   Mon, 25 Apr 2022 10:08:41 +0100
Message-Id: <20220425090841.3958494-3-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220425090841.3958494-1-atomlin@redhat.com>
References: <20220425090841.3958494-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Currently, only the initial module that tainted the kernel is
recorded e.g. when an out-of-tree module is loaded.

The purpose of this patch is to allow the kernel to maintain a record of
each unloaded module that taints the kernel. So, in addition to
displaying a list of linked modules (see print_modules()) e.g. in the
event of a detected bad page, unloaded modules that carried a taint/or
taints are displayed too. A tainted module unload count is maintained.

The number of tracked modules is not fixed. This feature is disabled by
default.

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 init/Kconfig         | 11 ++++++++
 kernel/module/main.c | 65 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index ddcbefe535e9..6b30210f787d 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2118,6 +2118,17 @@ config MODULE_FORCE_UNLOAD
 	  rmmod).  This is mainly for kernel developers and desperate users.
 	  If unsure, say N.
 
+config MODULE_UNLOAD_TAINT_TRACKING
+	bool "Tainted module unload tracking"
+	depends on MODULE_UNLOAD
+	default n
+	help
+	  This option allows you to maintain a record of each unloaded
+	  module that tainted the kernel. In addition to displaying a
+	  list of linked (or loaded) modules e.g. on detection of a bad
+	  page (see bad_page()), the aforementioned details are also
+	  shown. If unsure, say N.
+
 config MODVERSIONS
 	bool "Module versioning support"
 	help
diff --git a/kernel/module/main.c b/kernel/module/main.c
index ea78cec316dd..35686e63b32f 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -68,6 +68,16 @@
  */
 DEFINE_MUTEX(module_mutex);
 LIST_HEAD(modules);
+#ifdef CONFIG_MODULE_UNLOAD_TAINT_TRACKING
+static LIST_HEAD(unloaded_tainted_modules);
+
+struct mod_unload_taint {
+	struct list_head list;
+	char name[MODULE_NAME_LEN];
+	unsigned long taints;
+	u64 count;
+};
+#endif
 
 /* Work queue for freeing init sections in success case */
 static void do_free_init(struct work_struct *w);
@@ -150,6 +160,41 @@ int unregister_module_notifier(struct notifier_block *nb)
 }
 EXPORT_SYMBOL(unregister_module_notifier);
 
+#ifdef CONFIG_MODULE_UNLOAD_TAINT_TRACKING
+static int try_add_tainted_module(struct module *mod)
+{
+	struct mod_unload_taint *mod_taint;
+
+	module_assert_mutex_or_preempt();
+
+	list_for_each_entry_rcu(mod_taint, &unloaded_tainted_modules, list,
+				lockdep_is_held(&module_mutex)) {
+		size_t len = strlen(mod_taint->name);
+
+		if (!strncmp(mod_taint->name, mod->name, len) &&
+		    mod_taint->taints & mod->taints) {
+			mod_taint->count++;
+			goto out;
+		}
+	}
+
+	mod_taint = kmalloc(sizeof(*mod_taint), GFP_KERNEL);
+	if (unlikely(!mod_taint))
+		return -ENOMEM;
+	strscpy(mod_taint->name, mod->name, MODULE_NAME_LEN);
+	mod_taint->taints = mod->taints;
+	list_add_rcu(&mod_taint->list, &unloaded_tainted_modules);
+	mod_taint->count = 1;
+out:
+	return 0;
+}
+#else /* MODULE_UNLOAD_TAINT_TRACKING */
+static int try_add_tainted_module(struct module *mod)
+{
+	return 0;
+}
+#endif
+
 /*
  * We require a truly strong try_module_get(): 0 means success.
  * Otherwise an error is returned due to ongoing or failed
@@ -1201,6 +1246,9 @@ static void free_module(struct module *mod)
 	module_bug_cleanup(mod);
 	/* Wait for RCU-sched synchronizing before releasing mod->list and buglist. */
 	synchronize_rcu();
+	if (try_add_tainted_module(mod))
+		pr_err("%s: adding tainted module to the unloaded tainted modules list failed.\n",
+		       mod->name);
 	mutex_unlock(&module_mutex);
 
 	/* Clean up CFI for the module. */
@@ -3126,6 +3174,9 @@ struct module *__module_text_address(unsigned long addr)
 void print_modules(void)
 {
 	struct module *mod;
+#ifdef CONFIG_MODULE_UNLOAD_TAINT_TRACKING
+	struct mod_unload_taint *mod_taint;
+#endif
 	char buf[MODULE_FLAGS_BUF_SIZE];
 
 	printk(KERN_DEFAULT "Modules linked in:");
@@ -3136,6 +3187,20 @@ void print_modules(void)
 			continue;
 		pr_cont(" %s%s", mod->name, module_flags(mod, buf));
 	}
+#ifdef CONFIG_MODULE_UNLOAD_TAINT_TRACKING
+	if (!list_empty(&unloaded_tainted_modules)) {
+		printk(KERN_DEFAULT "Unloaded tainted modules:");
+		list_for_each_entry_rcu(mod_taint, &unloaded_tainted_modules,
+					list) {
+			size_t l;
+
+			l = module_flags_taint(mod_taint->taints, buf);
+			buf[l++] = '\0';
+			pr_cont(" %s(%s):%llu", mod_taint->name, buf,
+				mod_taint->count);
+		}
+	}
+#endif
 	preempt_enable();
 	if (last_unloaded_module[0])
 		pr_cont(" [last unloaded: %s]", last_unloaded_module);
-- 
2.34.1

