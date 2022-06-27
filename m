Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0883C43334
	for <linux-modules@archiver.kernel.org>; Mon, 27 Jun 2022 16:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239331AbiF0QlC (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 27 Jun 2022 12:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234427AbiF0QlB (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 27 Jun 2022 12:41:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E400F1AF12
        for <linux-modules@vger.kernel.org>; Mon, 27 Jun 2022 09:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656348060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mmtu6sGZISHFbuV/9DFRuThUAmo/IEgFbvkJ55YDBQk=;
        b=X3j1s1FtK0Q3/s8AxkMWIDh124fsesTVb4JIc3Y+mRfHUngUA7pVO4WV8kh8KaXSqQFREY
        wFS38/axnBu16wUQsApwqUb5Z1fs80nUIyxZaMM0PGqrVjDhUUhFCmMF6bk9AI80r8WTW8
        G8mPoPInLih/jgfc2TZjpicTfhIbRjQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-618-ZE2aQt1vOkCZeKtyFEOkWg-1; Mon, 27 Jun 2022 12:40:57 -0400
X-MC-Unique: ZE2aQt1vOkCZeKtyFEOkWg-1
Received: by mail-wm1-f72.google.com with SMTP id z11-20020a05600c0a0b00b003a043991610so3498060wmp.8
        for <linux-modules@vger.kernel.org>; Mon, 27 Jun 2022 09:40:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mmtu6sGZISHFbuV/9DFRuThUAmo/IEgFbvkJ55YDBQk=;
        b=HR8TCHgvjMpu4qL5xYEvBZIwJ6ILZ4fZ4K45ncjzFBGfwnIcjeOwDY+rdDaaJ02cTm
         sHuc5rAxpMAypx7H4834Kiea3DL5Dph97FMc3llPazhYcbKt61620nOgr4EQJt0a5AbQ
         YH9noH03J4Ie8uQXyfIYLVa7gMa63WcyXQ6aQVo7MNgBLjX1cySjQwiVBdE8iMoq1jIQ
         gDIYsBwhaKhwjyzYBAGWO5RjG7UGkN3JPOBSLUwdwHLzZSCfUqrnqFA8F/8tqLOuShvQ
         83CATdNMmPJfoqYTle6mGnRLPE9AETzw+6Eu4SxNx718ELrGxMhk/omdnRmx6cLaQ+VK
         5X7w==
X-Gm-Message-State: AJIora+Wxu5mmsWLNFCmMFZ4FHKZcqA0ZfEK0a/3f6UOXAKawTRy8Iic
        Guy0Tca2aMaAWaDmZ8gTLlTDO20s3nsyBlllBv8MCyISBdJtfvbHHllwIFb1Kv0ZMOtj/9PalyT
        bOguqAA5d1TOAik6PNx88LNnj
X-Received: by 2002:a05:600c:b46:b0:3a0:4a51:bb1d with SMTP id k6-20020a05600c0b4600b003a04a51bb1dmr6902206wmr.168.1656348056350;
        Mon, 27 Jun 2022 09:40:56 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uf1D9edbDGWlaOoBkfKKagim3AhPqi7BL5FVkNGElHCF/EiWHy1LGL+pVfZHkDgBe53dYR5A==
X-Received: by 2002:a05:600c:b46:b0:3a0:4a51:bb1d with SMTP id k6-20020a05600c0b4600b003a04a51bb1dmr6902190wmr.168.1656348056151;
        Mon, 27 Jun 2022 09:40:56 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id d18-20020adfe852000000b0021ba3d1f2a0sm10803679wrn.48.2022.06.27.09.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 09:40:55 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] module: Show the last unloaded module's taint flag(s)
Date:   Mon, 27 Jun 2022 17:40:52 +0100
Message-Id: <20220627164052.2416485-2-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220627164052.2416485-1-atomlin@redhat.com>
References: <20220627164052.2416485-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

For diagnostic purposes, this patch, in addition to keeping a record/or
track of the last known unloaded module, we now will include the
module's taint flag(s) too e.g: " [last unloaded: fpga_mgr_mod(OE)]"

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 kernel/module/main.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index dcb83cf18d84..0ca6fd38b903 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -524,7 +524,12 @@ static struct module_attribute modinfo_##field = {                    \
 MODINFO_ATTR(version);
 MODINFO_ATTR(srcversion);
 
-static char last_unloaded_module[MODULE_NAME_LEN+1];
+/*
+ * Maximum number of characters written by module_flags()
+ * without a module's state information.
+ */
+#define LAST_UNLOADED_MODULE_NAME_LEN (MODULE_NAME_LEN + MODULE_FLAGS_BUF_SIZE - 2 + 1)
+static char last_unloaded_module[LAST_UNLOADED_MODULE_NAME_LEN];
 
 #ifdef CONFIG_MODULE_UNLOAD
 
@@ -694,6 +699,7 @@ SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
 {
 	struct module *mod;
 	char name[MODULE_NAME_LEN];
+	char buf[LAST_UNLOADED_MODULE_NAME_LEN];
 	int ret, forced = 0;
 
 	if (!capable(CAP_SYS_MODULE) || modules_disabled)
@@ -753,8 +759,8 @@ SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
 
 	async_synchronize_full();
 
-	/* Store the name of the last unloaded module for diagnostic purposes */
 	strlcpy(last_unloaded_module, mod->name, sizeof(last_unloaded_module));
+	strcat(last_unloaded_module, module_flags(mod, buf, false));
 
 	free_module(mod);
 	/* someone could wait for the module in add_unformed_module() */
-- 
2.34.3

