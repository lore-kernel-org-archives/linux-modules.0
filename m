Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28654C433EF
	for <linux-modules@archiver.kernel.org>; Tue, 19 Apr 2022 15:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352577AbiDSPGb (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 19 Apr 2022 11:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351872AbiDSPG3 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 19 Apr 2022 11:06:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D5CAB38DAA
        for <linux-modules@vger.kernel.org>; Tue, 19 Apr 2022 08:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650380625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IYNT6ZuIJiJoY8GI/zjU79USL2zsqTDoMA6bTiPxO48=;
        b=cMEtgWCNM3icRMLhtI6KJtVV0aSJa5pzkwPq7Z2yOUS4DXuYWUZS0czNyRJI1HMi8C22fm
        AWEQSXSFxJJ3NLhztDcT/xgZ02M/PidAAwdQOBxPEyHNqMlDYswmCwvuavb2171p81vavZ
        /kThNrgix+7xwRVnqHZGevpmAZjZA0g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-35--fkbLhSAMKuo2UF5VuTpnw-1; Tue, 19 Apr 2022 11:03:43 -0400
X-MC-Unique: -fkbLhSAMKuo2UF5VuTpnw-1
Received: by mail-wr1-f71.google.com with SMTP id v9-20020adfc409000000b002079e379921so1986004wrf.5
        for <linux-modules@vger.kernel.org>; Tue, 19 Apr 2022 08:03:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IYNT6ZuIJiJoY8GI/zjU79USL2zsqTDoMA6bTiPxO48=;
        b=HQzib+XE9iz6PqLD6LvnMJQwhUwXPhpXhArp82E+DC6Mug9r1FDrWfiHzoMAl9BHlr
         WQU5KpfGjWz/8rXBS7BJk4HqWTQxhnXWX/D1+yCkw9+gABjLi8E5EeYBVJwBKnIsZ4R6
         Cq3eGCtYRXdaZa0x9NABlnHG0h/AjNxmQfGJIkDDZ2ezI7jWDVELxqachuFDiNyZwEfX
         gzQOqKmi3+Hg+ssSDpkzznidvpVfG2j8H3G7wVrpkCNU0C39bOdEoGg7K7W3inYjUztq
         lv+3dwTR1+4byAJKQUHfbgSA7aND5tSXWfuwzSZ0gqsmOryv5vGXbwZf52tx9ctH2USB
         7I5g==
X-Gm-Message-State: AOAM533SCph+o1XGTaiwAyaR8O10IcjjYVKKDx+XF7XIhsndZmiQjn04
        Zxu6JOqkhr5n3S/Xn3TpPj66EFzPrDYfCznJHXMbd9mUMC6l38cWP6D3Ae1v32oYVvM8ZVdZkVr
        KePTe67epA8uYyVA3ty59FORq
X-Received: by 2002:adf:eed0:0:b0:207:9b35:62c4 with SMTP id a16-20020adfeed0000000b002079b3562c4mr11886870wrp.509.1650380622606;
        Tue, 19 Apr 2022 08:03:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxcok70XsxVaMKU6HNbr90avt8VZ6+aoTLI8CVNsPXJij7rNpI0D8baGm7YWjMF9VJH6qWsng==
X-Received: by 2002:adf:eed0:0:b0:207:9b35:62c4 with SMTP id a16-20020adfeed0000000b002079b3562c4mr11886858wrp.509.1650380622364;
        Tue, 19 Apr 2022 08:03:42 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id t2-20020a1c4602000000b003917d43d339sm13184166wma.4.2022.04.19.08.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 08:03:41 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        christophe.leroy@csgroup.eu, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com
Subject: [RFC PATCH v2 2/2] module: Introduce module unload taint tracking
Date:   Tue, 19 Apr 2022 16:03:34 +0100
Message-Id: <20220419150334.3395019-3-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220419150334.3395019-1-atomlin@redhat.com>
References: <20220419150334.3395019-1-atomlin@redhat.com>
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
taints are displayed too. If a previously unloaded module with a
taint/or tains is loaded once again and then a count will be shown
accordingly.

The number of tracked modules is not fixed. This feature is disabled by
default.

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 init/Kconfig         | 11 +++++++
 kernel/module/main.c | 68 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)

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
index ea78cec316dd..0f7df9ac25ce 100644
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
@@ -150,6 +160,42 @@ int unregister_module_notifier(struct notifier_block *nb)
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
+		if (len == strlen(mod->name) && !memcmp(mod_taint->name, mod->name, len) &&
+		    mod_taint->taints & mod->taints) {
+			mod_taint->count++;
+			goto out;
+		}
+	}
+
+	mod_taint = kmalloc(sizeof(*mod_taint), GFP_KERNEL);
+	if (unlikely(!mod_taint))
+		return -ENOMEM;
+	strlcpy(mod_taint->name, mod->name,
+		MODULE_NAME_LEN);
+	mod_taint->taints = mod->taints;
+	list_add_rcu(&mod_taint->list, &unloaded_tainted_modules);
+	mod_taint->count = 0;
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
@@ -1201,6 +1247,9 @@ static void free_module(struct module *mod)
 	module_bug_cleanup(mod);
 	/* Wait for RCU-sched synchronizing before releasing mod->list and buglist. */
 	synchronize_rcu();
+	if (try_add_tainted_module(mod))
+		pr_err("%s: adding tainted module to the unloaded tainted modules list failed.\n",
+		       mod->name);
 	mutex_unlock(&module_mutex);
 
 	/* Clean up CFI for the module. */
@@ -3126,6 +3175,9 @@ struct module *__module_text_address(unsigned long addr)
 void print_modules(void)
 {
 	struct module *mod;
+#ifdef CONFIG_MODULE_UNLOAD_TAINT_TRACKING
+	struct mod_unload_taint *mod_taint;
+#endif
 	char buf[MODULE_FLAGS_BUF_SIZE];
 
 	printk(KERN_DEFAULT "Modules linked in:");
@@ -3136,6 +3188,22 @@ void print_modules(void)
 			continue;
 		pr_cont(" %s%s", mod->name, module_flags(mod, buf));
 	}
+#ifdef CONFIG_MODULE_UNLOAD_TAINT_TRACKING
+	if (!list_empty(&unloaded_tainted_modules)) {
+		printk(KERN_DEFAULT "\nUnloaded tainted modules:");
+		list_for_each_entry_rcu(mod_taint, &unloaded_tainted_modules,
+					list) {
+			size_t l;
+
+			l = module_flags_taint(mod_taint->taints, buf);
+			buf[l++] = '\0';
+			pr_cont(" %s(%s)%s", mod_taint->name, buf,
+				mod_taint->count ? ":" : "");
+			if (mod_taint->count)
+				pr_cont("%llu", mod_taint->count);
+		}
+#endif
+	}
 	preempt_enable();
 	if (last_unloaded_module[0])
 		pr_cont(" [last unloaded: %s]", last_unloaded_module);
-- 
2.34.1

