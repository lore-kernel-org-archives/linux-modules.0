Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80131C433FE
	for <linux-modules@archiver.kernel.org>; Tue, 22 Feb 2022 14:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbiBVOOH (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 22 Feb 2022 09:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbiBVONx (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 22 Feb 2022 09:13:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F8EB113AF2
        for <linux-modules@vger.kernel.org>; Tue, 22 Feb 2022 06:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645539202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i103PSP092uwH2wOfbrJepw6+2qfz41xvp5h85cEBaI=;
        b=Wu+OIWlBDb91q2o70FdlWukJDhHahL0lbiZPukv+F1kr3bwzEGVDHhdCt8IujntWAunroR
        W0Gqv3QckTOc/W9a/6K4s7QCYXzTeuwCcGRVvWUDEKKCXBTidbtisMNNUC2fu30tg6qtLa
        yQLcf5agvJDrZmqCXdBsn08O0dKCrIk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-22-sOQ0EWdONu21nxP2gIuE5Q-1; Tue, 22 Feb 2022 09:13:21 -0500
X-MC-Unique: sOQ0EWdONu21nxP2gIuE5Q-1
Received: by mail-wr1-f72.google.com with SMTP id q12-20020adfbb8c000000b001ea938f79e9so961055wrg.23
        for <linux-modules@vger.kernel.org>; Tue, 22 Feb 2022 06:13:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i103PSP092uwH2wOfbrJepw6+2qfz41xvp5h85cEBaI=;
        b=7XxRup+sRZBXW3K0ABCx0sl9OITxGhJVdaTcIyIlzD/xGnEgQMRu9n9Sd99Aw4OSsX
         DM8+bcRZIG0QZbVhTTi0RHt/Mtw63DKcpZi2H891zXuP2aEH5FDCoSHc/ddVJGKcc3sh
         V+rlcSx7kPWFLlWCFsfgy5VTFffhV4oZu4S0iZN/otZ0iGW6glzw3pn/GOwprxvf4rlI
         HcWQsPqego68jLnXHM2XS7uqKynVr5qDdhYFFkRV/rS+SRV3XB9F9sFeY9DVmr2MwGrb
         XGU0X2VZUz8SbulkPcuzaXgwgDeBedkaPDotlh4PZELvsoz4P8x4d04JsPhFlzEde/16
         GV+w==
X-Gm-Message-State: AOAM533sFae1sSyJ0MHfB2Ik9A0hBlcgyhW2RLcexUcpYDAy/WAHFcn9
        ujE4dgZRaNGNbZQcPKKMGW+lu5vVN8bi21ONO/ELNfCPJ+UdlSQbOt5CsX5IYCEPNK/2/shP7WY
        SLXyGWPsYuR0yn7ryyCzOXpH/
X-Received: by 2002:a7b:c5d0:0:b0:355:482a:6f44 with SMTP id n16-20020a7bc5d0000000b00355482a6f44mr3483014wmk.58.1645539200132;
        Tue, 22 Feb 2022 06:13:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz6YxDMv4TmmFlo2qDNI4ZTeMejQdZ8kRAII4z7tr97kukxRE6wN6LPuNR5BkNnmKSASfAGrA==
X-Received: by 2002:a7b:c5d0:0:b0:355:482a:6f44 with SMTP id n16-20020a7bc5d0000000b00355482a6f44mr3482990wmk.58.1645539199918;
        Tue, 22 Feb 2022 06:13:19 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id 20sm2467724wmk.26.2022.02.22.06.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 06:13:19 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org, christophe.leroy@csgroup.eu
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        void@manifault.com, atomlin@atomlin.com, allen.lkml@gmail.com,
        joe@perches.com, msuchanek@suse.de, oleksandr@natalenko.name
Subject: [PATCH v8 12/13] module: Move kdb_modules list out of core code
Date:   Tue, 22 Feb 2022 14:13:02 +0000
Message-Id: <20220222141303.1392190-13-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220222141303.1392190-1-atomlin@redhat.com>
References: <20220222141303.1392190-1-atomlin@redhat.com>
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

