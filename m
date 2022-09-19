Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3126DECAAD3
	for <linux-modules@archiver.kernel.org>; Mon, 19 Sep 2022 12:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiISMd1 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 19 Sep 2022 08:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiISMdZ (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 19 Sep 2022 08:33:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BDB2CE1D;
        Mon, 19 Sep 2022 05:33:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 623851F86B;
        Mon, 19 Sep 2022 12:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1663590802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M0h2FH7lDjvNShm0Jeu6rNK8Wnz5JsB4bgbgPNhOu7c=;
        b=jfDO/FQkTD4Ey8zyQlaRAvTbevrViyoP2KBebTG8/dtuxrJKezZmbeVhalITRU3epEv7OD
        sR4FVyVt/95IFMbnJSckKCO7yhhl2o6mp+FJG2wOWObViqd2Ut5CDukH/cDyWxBkOH/Khf
        JgC6JNrzHqrMKRCMnbEXO8/rSC5c6GI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 40D3813A96;
        Mon, 19 Sep 2022 12:33:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wHjgDpJhKGN4LAAAMHmgww
        (envelope-from <petr.pavlu@suse.com>); Mon, 19 Sep 2022 12:33:22 +0000
From:   Petr Pavlu <petr.pavlu@suse.com>
To:     mcgrof@kernel.org
Cc:     pmladek@suse.com, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH v2 1/2] module: Correct wake up of module_wq
Date:   Mon, 19 Sep 2022 14:32:32 +0200
Message-Id: <20220919123233.8538-2-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220919123233.8538-1-petr.pavlu@suse.com>
References: <20220919123233.8538-1-petr.pavlu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

The module_wq wait queue has only non-exclusive waiters and all waits
are interruptible, therefore for consistency use wake_up_interruptible()
to wake its waiters.

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 kernel/module/main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index a4e4d84b6f4e..06cb41c3d2a1 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -763,7 +763,7 @@ SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
 
 	free_module(mod);
 	/* someone could wait for the module in add_unformed_module() */
-	wake_up_all(&module_wq);
+	wake_up_interruptible(&module_wq);
 	return 0;
 out:
 	mutex_unlock(&module_mutex);
@@ -2524,7 +2524,7 @@ static noinline int do_init_module(struct module *mod)
 		schedule_work(&init_free_wq);
 
 	mutex_unlock(&module_mutex);
-	wake_up_all(&module_wq);
+	wake_up_interruptible(&module_wq);
 
 	return 0;
 
@@ -2540,7 +2540,7 @@ static noinline int do_init_module(struct module *mod)
 	klp_module_going(mod);
 	ftrace_release_mod(mod);
 	free_module(mod);
-	wake_up_all(&module_wq);
+	wake_up_interruptible(&module_wq);
 	return ret;
 }
 
@@ -2886,7 +2886,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	/* Unlink carefully: kallsyms could be walking list. */
 	list_del_rcu(&mod->list);
 	mod_tree_remove(mod);
-	wake_up_all(&module_wq);
+	wake_up_interruptible(&module_wq);
 	/* Wait for RCU-sched synchronizing before releasing mod->list. */
 	synchronize_rcu();
 	mutex_unlock(&module_mutex);
-- 
2.35.3

