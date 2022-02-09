Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50625C433EF
	for <linux-modules@archiver.kernel.org>; Wed,  9 Feb 2022 17:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237921AbiBIRLZ (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 9 Feb 2022 12:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235040AbiBIRLX (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 9 Feb 2022 12:11:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5BA65C05CB87
        for <linux-modules@vger.kernel.org>; Wed,  9 Feb 2022 09:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644426683;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zn93pWzcJQL1BOkvuuBdPwWHwZUtP+/5XlTnx5+7OzE=;
        b=S4VvlYJeTDkSdvrKfmb+maAo3Z4zG/tcVQZAVGQ1sY4xKLu7W2FzDghcakpF6j+H1XgRYS
        zOlvfDoTkFhuPPOFjRSjQNQLS5D9MOcxatSIH/ylJ0qNhEpK6spCcHowNk+vbFSTbrtYyM
        uSeKQOA+G5Rjj+lH/B8cBVl7pwA6C7M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-199-AJ-ZOAMfMBq0IznnI5mLVw-1; Wed, 09 Feb 2022 12:11:22 -0500
X-MC-Unique: AJ-ZOAMfMBq0IznnI5mLVw-1
Received: by mail-wr1-f69.google.com with SMTP id r2-20020adfa142000000b001e176ac1ec3so1362390wrr.3
        for <linux-modules@vger.kernel.org>; Wed, 09 Feb 2022 09:11:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=zn93pWzcJQL1BOkvuuBdPwWHwZUtP+/5XlTnx5+7OzE=;
        b=eIg9n4LIWZfwijZUG3mjGocc4bt/AajiWwQjGbdH1VsJB1HJkPuz31ISSn1IIkvkuJ
         Yhha5FA52un/m8T1pbupIk2mFroQLop6K9dzB5qM82z1qF0ueAiNfBAzukRmsUnTigyC
         rId8lQxXbRx7bAd8wrhnEW7bSPYrosigGZzEZHsx/V58bgSDQtquZsVYjvI7cJl925MG
         dlOIQgQ00ezdKnzR740eB9ksTWOnV8da8niw/HkTYA06usK/MpSSgFTcvJdJ46BYnwf6
         C64MoL7hdpph+ivN1igNyt6j7u0SsIZ4BZAYcsBsJrBU9bYtHKfAy4+iOJW6euM+mw7E
         73cw==
X-Gm-Message-State: AOAM532FAYN3/wI4knaCLCj5EiYcFnHJbHOByhHJId64ACKJESmPzGyF
        KWyaPLYwH2HtlJTitUclCZCAkHdRZf2qInrHRkj+XGmax29x517d2s+p/rNVoVbQGGGyzDW3a/l
        /E/dd2QznYORzd3P373k0dEvY
X-Received: by 2002:adf:db0a:: with SMTP id s10mr2933347wri.267.1644426681214;
        Wed, 09 Feb 2022 09:11:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxJNSQajL6V1idh+sD44LiClePbaHvGmAFtzzJhaVSss0+AGRM9MjlmC8+qYd42Mya2PjxiMQ==
X-Received: by 2002:adf:db0a:: with SMTP id s10mr2933336wri.267.1644426681073;
        Wed, 09 Feb 2022 09:11:21 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id u15sm16026570wrs.18.2022.02.09.09.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 09:11:20 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        live-patching@vger.kernel.org, atomlin@atomlin.com,
        ghalat@redhat.com, allen.lkml@gmail.com, void@manifault.com,
        joe@perches.com, christophe.leroy@csgroup.eu, msuchanek@suse.de,
        oleksandr@natalenko.name
Subject: [PATCH v5 12/13] module: Move kdb_modules list out of core code
Date:   Wed,  9 Feb 2022 17:11:17 +0000
Message-Id: <20220209171118.3269581-2-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220209171118.3269581-1-atomlin@redhat.com>
References: <20220209171118.3269581-1-atomlin@redhat.com>
Reply-To: 20220209170358.3266629-1-atomlin@redhat.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

No functional change.

This patch migrates kdb_modules list to core kdb code
since the list of added/or loaded modules is no longer
private.

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 kernel/debug/kdb/kdb_main.c | 5 +++++
 kernel/module/internal.h    | 1 +
 kernel/module/main.c        | 4 ----
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 0852a537dad4..f101f5f078f4 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -59,6 +59,11 @@ EXPORT_SYMBOL(kdb_grepping_flag);
 int kdb_grep_leading;
 int kdb_grep_trailing;
 
+#ifdef CONFIG_MODULES
+extern struct list_head modules;
+struct list_head *kdb_modules = &modules; /* kdb needs the list of modules */
+#endif /* CONFIG_MODULES */
+
 /*
  * Kernel debugger state flags
  */
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 52d30bf6d6b0..c49b4900b30b 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -225,6 +225,7 @@ static int mod_sysfs_setup(struct module *mod,
 {
 	return 0;
 }
+
 static inline void mod_sysfs_fini(struct module *mod) { }
 static inline void module_remove_modinfo_attrs(struct module *mod, int end) { }
 static inline void del_usage_links(struct module *mod) { }
diff --git a/kernel/module/main.c b/kernel/module/main.c
index c2255954b7df..519c5335f7a6 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -105,10 +105,6 @@ static void mod_update_bounds(struct module *mod)
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

