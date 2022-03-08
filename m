Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2492BC433EF
	for <linux-modules@archiver.kernel.org>; Tue,  8 Mar 2022 10:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345997AbiCHKxK (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 8 Mar 2022 05:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346072AbiCHKxE (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 8 Mar 2022 05:53:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4298D43490
        for <linux-modules@vger.kernel.org>; Tue,  8 Mar 2022 02:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646736727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R1HEPCyruPf1eLWtXxVEMzx/0uUk6Tce0FMKc7iO5fU=;
        b=UqTiWj8hmQpGez59utLYRo9OlMTiYfcROvJPa7EXGgcKgSdjH2sqNQ1WruGICA3UeQAzw8
        n4ME6kKHSM4AQIbPWfNPxlN1mHNQ3pFS2I0EMz4A/LkTLAF23uARukRuTaFp87EktTozsZ
        N1aD7TmvFFbW03D+6ryeX+WEbDX5iQY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-279-PbJ9nXrKMCmW5dIZKUW1Dw-1; Tue, 08 Mar 2022 05:52:06 -0500
X-MC-Unique: PbJ9nXrKMCmW5dIZKUW1Dw-1
Received: by mail-wm1-f70.google.com with SMTP id j42-20020a05600c1c2a00b00381febe402eso1024752wms.0
        for <linux-modules@vger.kernel.org>; Tue, 08 Mar 2022 02:52:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R1HEPCyruPf1eLWtXxVEMzx/0uUk6Tce0FMKc7iO5fU=;
        b=754gRf7aVZa02+83HndtDpCTIXQscj6hP2DhJw8tKqR8IxjcMOIN+q9D96jxWVeO2I
         Po6vy9oYm+xlxm70Yj9W8TPjh1MdiX3akvfB8ceJkDWbpYT0zssVr/8Vd3fs3vCovIIJ
         YlElTvFxSrKRVbfaus/IdH4zsHH8kufWlbNfd8m8CWzVRDbCeAP3zRDwbPZn39VzCRBR
         qZuBoZTpnvEbr0LIPzICMy5XD8qEorTTx5p5a83icrQABwbJwrEc7ZfWuRTWgPYWrNqi
         NmqNc3n6X0TsPndAyXjuDQu6Bx0mCp7bbSLy2JGY3P+geWtTmWmY8c+R8yk7XR481CKR
         5Vvw==
X-Gm-Message-State: AOAM530iTTGMksJiko9bwmsnMi3YbnBF0lGUqsFX0lZSZLYRnnj9Vbgu
        j3twqSI7JDWN+dVsTLzw8H92QIscvwELmEXHdU1ctOhukXY0nN6AES7qoxe12QWV6uIXava/AAV
        7P2sSu5erdVjwjH6+x0Mwc/mp
X-Received: by 2002:a05:600c:4ed2:b0:381:8c80:4774 with SMTP id g18-20020a05600c4ed200b003818c804774mr2915871wmq.4.1646736725147;
        Tue, 08 Mar 2022 02:52:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyrLgM6L2NB/kVCLnMPCcY3VSUiwe8whTzoffN12U5JFpjrb0Ay3h4p8/8EXXLZeOCo6UKu5Q==
X-Received: by 2002:a05:600c:4ed2:b0:381:8c80:4774 with SMTP id g18-20020a05600c4ed200b003818c804774mr2915841wmq.4.1646736724921;
        Tue, 08 Mar 2022 02:52:04 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id n7-20020a05600c3b8700b00389a6241669sm2104230wms.33.2022.03.08.02.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 02:52:04 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org, christophe.leroy@csgroup.eu,
        daniel.thompson@linaro.org, hch@infradead.org
Cc:     cl@linux.com, mbenes@suse.cz, akpm@linux-foundation.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, void@manifault.com,
        atomlin@atomlin.com, allen.lkml@gmail.com, joe@perches.com,
        msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, pmladek@suse.com
Subject: [PATCH] kdb: Remove redundant module related references
Date:   Tue,  8 Mar 2022 10:52:03 +0000
Message-Id: <20220308105203.2981099-1-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220307174741.2889588-1-atomlin@redhat.com>
References: <20220307174741.2889588-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Hi Luis, Christoph, Daniel,

Is this patch ok or would you rather another iteration of the series?
Either way is fine for me. Thanks.


No functional change.

There is no need to include linux/module.h.
This patch addresses the above. Furthermore, we remove the list of known
loaded modules i.e. stored in 'kdb_modules', since it is now redundant.

Fixes: 260681b3763f ("module: Move kdb module related code out of main kdb code")
Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 kernel/debug/kdb/kdb_io.c       | 1 -
 kernel/debug/kdb/kdb_keyboard.c | 1 -
 kernel/debug/kdb/kdb_private.h  | 4 ----
 kernel/debug/kdb/kdb_support.c  | 1 -
 4 files changed, 7 deletions(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 6735ac36b718..67d3c48a1522 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -9,7 +9,6 @@
  * Copyright (c) 2009 Wind River Systems, Inc.  All Rights Reserved.
  */
 
-#include <linux/module.h>
 #include <linux/types.h>
 #include <linux/ctype.h>
 #include <linux/kernel.h>
diff --git a/kernel/debug/kdb/kdb_keyboard.c b/kernel/debug/kdb/kdb_keyboard.c
index f877a0a0d7cf..f87c750d3eb3 100644
--- a/kernel/debug/kdb/kdb_keyboard.c
+++ b/kernel/debug/kdb/kdb_keyboard.c
@@ -11,7 +11,6 @@
 #include <linux/kdb.h>
 #include <linux/keyboard.h>
 #include <linux/ctype.h>
-#include <linux/module.h>
 #include <linux/io.h>
 
 /* Keyboard Controller Registers on normal PCs. */
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
diff --git a/kernel/debug/kdb/kdb_support.c b/kernel/debug/kdb/kdb_support.c
index df2bface866e..08229ffb6b5e 100644
--- a/kernel/debug/kdb/kdb_support.c
+++ b/kernel/debug/kdb/kdb_support.c
@@ -17,7 +17,6 @@
 #include <linux/stddef.h>
 #include <linux/vmalloc.h>
 #include <linux/ptrace.h>
-#include <linux/module.h>
 #include <linux/highmem.h>
 #include <linux/hardirq.h>
 #include <linux/delay.h>
-- 
2.34.1

