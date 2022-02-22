Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0907C433EF
	for <linux-modules@archiver.kernel.org>; Tue, 22 Feb 2022 13:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbiBVNR0 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 22 Feb 2022 08:17:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbiBVNRZ (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 22 Feb 2022 08:17:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D64597DE27
        for <linux-modules@vger.kernel.org>; Tue, 22 Feb 2022 05:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645535819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i103PSP092uwH2wOfbrJepw6+2qfz41xvp5h85cEBaI=;
        b=b5rolwFYxPSzCjfYcFctDe2FRxJFoiQF1bXWYpRT3v+u/3no1hiUbvS6H+QIu2ejTVYgTL
        a0pp8zMloM3aqSQqaHoWuU3Jz2Dx5P9YbFudE8vn3pHoPzBJT7M1MwCU6pNXTn723zRWt8
        VN8KrPy4j7AMHDmu/dkAJEL9oPAP46k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-658-qR560PAYN0W26pA7pmtcuA-1; Tue, 22 Feb 2022 08:16:57 -0500
X-MC-Unique: qR560PAYN0W26pA7pmtcuA-1
Received: by mail-wm1-f72.google.com with SMTP id t2-20020a7bc3c2000000b003528fe59cb9so598518wmj.5
        for <linux-modules@vger.kernel.org>; Tue, 22 Feb 2022 05:16:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i103PSP092uwH2wOfbrJepw6+2qfz41xvp5h85cEBaI=;
        b=1Kfm2pKc4A+u+VHGWKvdIhgSIXgGza3AmsZmyaIdbV/aw/NkXZ7odkSqHEH8VYYYkQ
         EESbEvCxFQsR/C3DCDThfS7eQ0kyxxkAj5MFOsg5Tqq4J2XWBDO0JFaoK+vl8pvH039b
         47RITN8FnU/W5g1MCgdiwJNO/xxow6JYVKi8TEtco5halh5ky/dsVkpneXhB6oPc+k/u
         SAQJFRpn1792LjKRwJf0PwQW9F0fv20OGB5EUnKN8ZJwdUfcMzZl8LZBPTiImOi82ddE
         aqkY8wH6QYXQbUN0R7ARrXQVC0y/yjqE3g4/VxiIKb3hxmqpCRNyduIpfMvajF3hSzXq
         Eirw==
X-Gm-Message-State: AOAM533NtQajatQbloWgyP/TU7eHaz00fYscHpxYMD3swW+35e+DYjDO
        kFyFVlhOr/go9H/A+0hsO6PBIy8VfYI/ffDoxoJsdIpkpAR5u1x23Y2vWEDykIBVMphKA+SPeVd
        E8vY3bJ9Vc5KsdfRg5gaOE/wq
X-Received: by 2002:a7b:c74e:0:b0:37b:9785:fbe5 with SMTP id w14-20020a7bc74e000000b0037b9785fbe5mr3295542wmk.54.1645535816656;
        Tue, 22 Feb 2022 05:16:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxPe/RBLGHCG5LhYm5QVzuvAesPgVKQvj5ua3K+B3a7c2SCNK9DQkgQxpJ6QFWyakZXMp4q5Q==
X-Received: by 2002:a7b:c74e:0:b0:37b:9785:fbe5 with SMTP id w14-20020a7bc74e000000b0037b9785fbe5mr3295523wmk.54.1645535816451;
        Tue, 22 Feb 2022 05:16:56 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id j6-20020a05600c190600b0037c3659a12fsm3079698wmq.6.2022.02.22.05.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 05:16:56 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org, christophe.leroy@csgroup.eu
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        void@manifault.com, atomlin@atomlin.com, allen.lkml@gmail.com,
        joe@perches.com, msuchanek@suse.de, oleksandr@natalenko.name
Subject: [PATCH v7 12/13] module: Move kdb_modules list out of core code
Date:   Tue, 22 Feb 2022 13:16:54 +0000
Message-Id: <20220222131655.1352953-1-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220222130911.1348513-1-atomlin@redhat.com>
References: <20220222130911.1348513-1-atomlin@redhat.com>
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

