Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0692CCA47B
	for <linux-modules@archiver.kernel.org>; Thu, 14 Jul 2022 15:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240218AbiGNPjz (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 14 Jul 2022 11:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240383AbiGNPjp (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 14 Jul 2022 11:39:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D09BDCDA
        for <linux-modules@vger.kernel.org>; Thu, 14 Jul 2022 08:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657813183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zXjUnaumkR0TOxe9lPH1tSh7D3NCENEIHeJQmON/pbA=;
        b=jADFrhz72RzL6wZGzqlfB/mH0W5CzQhMN7e3gpSKMjJueQt25f1ia3eYUMiR1aE3opS4He
        RkfZTN9EqhJHcnTEQkANo5dEHNuuC6BN1591TEFb7gXS/1h3hVB2Y0boUDUbxjOLh1javw
        N3Zft5t4XTPOPfrsMyjKvcnnvg2pNow=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-287-4TQ0Kp1aNDGpl-TJGT8Zhg-1; Thu, 14 Jul 2022 11:39:42 -0400
X-MC-Unique: 4TQ0Kp1aNDGpl-TJGT8Zhg-1
Received: by mail-wm1-f69.google.com with SMTP id q15-20020a05600c040f00b003a2e5c8fca3so2808432wmb.7
        for <linux-modules@vger.kernel.org>; Thu, 14 Jul 2022 08:39:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zXjUnaumkR0TOxe9lPH1tSh7D3NCENEIHeJQmON/pbA=;
        b=DymSmjQ+x8RUn3uCSNqyP/xH4N1LGupWGLRvv4pa9CXb/05+bNG9Y/3W+NwZA/2Dxb
         Fveb5P8LHG92h0Ya0Q3/OYa+ZtncSCgW5t/N1r6x2uQYK8ZMQHyRUqKoBj7LEy9zDYAF
         9yqm5rU4hD+VEA5GHNXqK+KifOpfaI8lqRT3W1Xi7hpi1Wx5Pu3h9YbbshIuAyStJFZ1
         x4P4dOD9eQUIKsYs4e9rGCpX1+MNE6agr7QJS4gZgKDerjiXof/f9bNyi75EE1gicGoJ
         ve0QRkjAh4sdms1ob5xcPPDIw+MklbJQopjJpCksdwTZuuvJfrybGVwGWac24NtzVuSa
         DT2A==
X-Gm-Message-State: AJIora9/uS0JeXRcE4BnLpzcgZCvpLDxcSeFOrWgvER5nhTKIdwRCG8g
        NZidf2CF1jF9WjW2lMUDmblwp4O74ky83Mvi6vcgCp2hydhD6GHojgyz34uo0L5GEu0rm4mhIcu
        56Vj8Y3XHi95vF7pAudQafZhD
X-Received: by 2002:a05:600c:206:b0:3a2:e224:da6f with SMTP id 6-20020a05600c020600b003a2e224da6fmr16099545wmi.167.1657813181598;
        Thu, 14 Jul 2022 08:39:41 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1umKj6lyufc2E/Zv8r5bdD3dbXIXniFnzkwkp6SxSbe6WGK2L1R/iMwFMU8NMI5GYg/lzZAtQ==
X-Received: by 2002:a05:600c:206:b0:3a2:e224:da6f with SMTP id 6-20020a05600c020600b003a2e224da6fmr16099535wmi.167.1657813181427;
        Thu, 14 Jul 2022 08:39:41 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id a15-20020adffb8f000000b0021dbac444a7sm1742198wrr.59.2022.07.14.08.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 08:39:40 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org, christophe.leroy@csgroup.eu
Cc:     linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, oleksandr@natalenko.name, neelx@redhat.com
Subject: [PATCH v2 3/3] module: Show the last unloaded module's taint flag(s)
Date:   Thu, 14 Jul 2022 16:39:33 +0100
Message-Id: <20220714153933.2095776-4-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220714153933.2095776-1-atomlin@redhat.com>
References: <20220714153933.2095776-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

For diagnostic purposes, this patch, in addition to keeping a record/or
track of the last known unloaded module, we now will include the
module's taint flag(s) too e.g: " [last unloaded: fpga_mgr_mod(OE)]"

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 kernel/module/main.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index c5db13d06995..96ec7f94228d 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -524,7 +524,10 @@ static struct module_attribute modinfo_##field = {                    \
 MODINFO_ATTR(version);
 MODINFO_ATTR(srcversion);
 
-static char last_unloaded_module[MODULE_NAME_LEN+1];
+static struct {
+	char name[MODULE_NAME_LEN + 1];
+	char taints[MODULE_FLAGS_BUF_SIZE];
+} last_unloaded_module;
 
 #ifdef CONFIG_MODULE_UNLOAD
 
@@ -694,6 +697,7 @@ SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
 {
 	struct module *mod;
 	char name[MODULE_NAME_LEN];
+	char buf[MODULE_FLAGS_BUF_SIZE];
 	int ret, forced = 0;
 
 	if (!capable(CAP_SYS_MODULE) || modules_disabled)
@@ -753,8 +757,9 @@ SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
 
 	async_synchronize_full();
 
-	/* Store the name of the last unloaded module for diagnostic purposes */
-	strscpy(last_unloaded_module, mod->name, sizeof(last_unloaded_module));
+	/* Store the name and taints of the last unloaded module for diagnostic purposes */
+	strscpy(last_unloaded_module.name, mod->name, sizeof(last_unloaded_module.name));
+	strscpy(last_unloaded_module.taints, module_flags(mod, buf, false), sizeof(last_unloaded_module.taints));
 
 	free_module(mod);
 	/* someone could wait for the module in add_unformed_module() */
@@ -3128,7 +3133,8 @@ void print_modules(void)
 
 	print_unloaded_tainted_modules();
 	preempt_enable();
-	if (last_unloaded_module[0])
-		pr_cont(" [last unloaded: %s]", last_unloaded_module);
+	if (last_unloaded_module.name[0])
+		pr_cont(" [last unloaded: %s%s]", last_unloaded_module.name,
+			last_unloaded_module.taints);
 	pr_cont("\n");
 }
-- 
2.34.3

