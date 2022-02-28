Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455EDC433F5
	for <linux-modules@archiver.kernel.org>; Mon, 28 Feb 2022 23:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbiB1XpE (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 28 Feb 2022 18:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbiB1Xom (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 28 Feb 2022 18:44:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CCB3410214E
        for <linux-modules@vger.kernel.org>; Mon, 28 Feb 2022 15:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646091835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JCVgx6h60KphAH4XrbUjxHa/sKqxkAwrzZ+dqhUICdc=;
        b=IZXRnQ31ge2qjk+u4WPGgjmKPA2w+vs1KnwJWSDOmJQon7MV8QoDuzhuYiVvkJJDxZirvL
        peR0U7wMwiPVFuxsdwvB59kJDSkx/I+dKxPBx/+As8uOdNtHNR+2XLnIMtGyvV4auUmrH1
        IJvFfSE/fDEpzON2ZIcqApGw57RXCG8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-133-mOPi238gMMKtjBpoX3shZQ-1; Mon, 28 Feb 2022 18:43:53 -0500
X-MC-Unique: mOPi238gMMKtjBpoX3shZQ-1
Received: by mail-wm1-f72.google.com with SMTP id v125-20020a1cac83000000b0037e3d70e7e1so339890wme.1
        for <linux-modules@vger.kernel.org>; Mon, 28 Feb 2022 15:43:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JCVgx6h60KphAH4XrbUjxHa/sKqxkAwrzZ+dqhUICdc=;
        b=6PW2CCNlN0b1rPyTO5X1Sozimde1J+AEynCdTMqaJTtmIItx84vnaHNNv2WWWET22B
         BdEU7NAmja6TPuGnprkNyTyU1nd+OhMbZzAM9dLZ8Vti9CSb6eMv1Zstf7eKB3IBNNYj
         gZgYtSH7agfq0FHfgNWTmFvmwVI8bMWfIzB0tZc7PCjSGewceCZT/t/WShcVtibBH2sB
         5V32PcupsP5rFJ99p0SE+/evHEa/RbR+a8LSGqarYCTaaSJR9hupEaSMB21zkLx3rh68
         sfHEiTvNDg/ODKV3nAb3+rDUt+mX5Ar3kJqPD1IegTNyKZzIaTcyeQndcty6OE3d/5qw
         8aJA==
X-Gm-Message-State: AOAM533754vCv9WYdVxsG90WO2oaECRnqZXjtZcOoBnCNXzbIW0h36hn
        9bg0HX6arw/z8rNDmK+W8+xBtCWnw/cS0PtkcYqM4PcfHfsIam3zwy8wzPl/3KYyRRXaN4+FuF9
        ZR9iEPNBCUn0wafa4KI15Buwq
X-Received: by 2002:adf:efc6:0:b0:1ed:f546:bd94 with SMTP id i6-20020adfefc6000000b001edf546bd94mr16735774wrp.33.1646091832435;
        Mon, 28 Feb 2022 15:43:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwvkHT2Nr5oVlCjs3WQD7yCipJPicE0ezxsN0GNl+lDKBwiQ2bhZCtnaHE/oS8Rl/COENGV8w==
X-Received: by 2002:adf:efc6:0:b0:1ed:f546:bd94 with SMTP id i6-20020adfefc6000000b001edf546bd94mr16735757wrp.33.1646091832269;
        Mon, 28 Feb 2022 15:43:52 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id x16-20020adff0d0000000b001ea81265a5fsm15866904wro.99.2022.02.28.15.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 15:43:51 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org, christophe.leroy@csgroup.eu, pmladek@suse.com
Cc:     cl@linux.com, mbenes@suse.cz, akpm@linux-foundation.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, void@manifault.com,
        atomlin@atomlin.com, allen.lkml@gmail.com, joe@perches.com,
        msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, daniel.thompson@linaro.org
Subject: [PATCH v9 13/14] module: Move kdb_modules list out of core code
Date:   Mon, 28 Feb 2022 23:43:21 +0000
Message-Id: <20220228234322.2073104-14-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220228234322.2073104-1-atomlin@redhat.com>
References: <20220228234322.2073104-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

No functional change.

This patch migrates kdb_modules list to core kdb code
since the list of added/or loaded modules is no longer
private.

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 kernel/debug/kdb/kdb_main.c    | 5 +++++
 kernel/debug/kdb/kdb_private.h | 4 ----
 kernel/module/main.c           | 4 ----
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 0852a537dad4..5369bf45c5d4 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -59,6 +59,11 @@ EXPORT_SYMBOL(kdb_grepping_flag);
 int kdb_grep_leading;
 int kdb_grep_trailing;
 
+#ifdef CONFIG_MODULES
+extern struct list_head modules;
+static struct list_head *kdb_modules = &modules; /* kdb needs the list of modules */
+#endif /* CONFIG_MODULES */
+
 /*
  * Kernel debugger state flags
  */
diff --git a/kernel/debug/kdb/kdb_private.h b/kernel/debug/kdb/kdb_private.h
index 0d2f9feea0a4..1f8c519a5f81 100644
--- a/kernel/debug/kdb/kdb_private.h
+++ b/kernel/debug/kdb/kdb_private.h
@@ -226,10 +226,6 @@ extern void kdb_kbd_cleanup_state(void);
 #define kdb_kbd_cleanup_state()
 #endif /* ! CONFIG_KDB_KEYBOARD */
 
-#ifdef CONFIG_MODULES
-extern struct list_head *kdb_modules;
-#endif /* CONFIG_MODULES */
-
 extern char kdb_prompt_str[];
 
 #define	KDB_WORD_SIZE	((int)sizeof(unsigned long))
diff --git a/kernel/module/main.c b/kernel/module/main.c
index b8a59b5c3e3a..bcc4f7a82649 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -108,10 +108,6 @@ static void mod_update_bounds(struct module *mod)
 		__mod_update_bounds(mod->init_layout.base, mod->init_layout.size);
 }
 
-#ifdef CONFIG_KGDB_KDB
-struct list_head *kdb_modules = &modules; /* kdb needs the list of modules */
-#endif /* CONFIG_KGDB_KDB */
-
 static void module_assert_mutex_or_preempt(void)
 {
 #ifdef CONFIG_LOCKDEP
-- 
2.34.1

