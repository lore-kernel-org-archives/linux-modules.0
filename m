Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10808C433EF
	for <linux-modules@archiver.kernel.org>; Tue, 19 Apr 2022 15:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350687AbiDSPG2 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 19 Apr 2022 11:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234589AbiDSPG1 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 19 Apr 2022 11:06:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B49AD38BFA
        for <linux-modules@vger.kernel.org>; Tue, 19 Apr 2022 08:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650380622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wj4nXdv1p55S6gdjYiynG1yQGRwuN4zNBoal8sio/r8=;
        b=H2FZZCQA54CDcFUAv+IxjITEew3zp/XsazrsZSFInidzIs+ho50ZgBYZ87FZiTtPXft0ON
        vIYGHLUKFO5f3BqXUAS40O6va0HBomOr0RG+6P8RWb8LMH0X0js7/4Iky90XgRtPfl6qW9
        8n4bihhiZZVNFOk9aiqeC1cICuWP5ZI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-352-875zi-SJNT2e8JqRF_4SFA-1; Tue, 19 Apr 2022 11:03:41 -0400
X-MC-Unique: 875zi-SJNT2e8JqRF_4SFA-1
Received: by mail-wm1-f71.google.com with SMTP id p21-20020a1c5455000000b0038ff4f1014fso6536406wmi.7
        for <linux-modules@vger.kernel.org>; Tue, 19 Apr 2022 08:03:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wj4nXdv1p55S6gdjYiynG1yQGRwuN4zNBoal8sio/r8=;
        b=R1T7npiVHNmM+mNSiDEAG8wFrhGxqF9ZmnkHJBsD5cp/NLMVqWHOFFQRTp8OddExq8
         qsPpbvLQjT8TgyauWwoy9Gy4OXmPe2UTlzanQxM/6qowZmf6pXZxYdRkhFQOXeF4T6KS
         25xmq1gRKRpWw2wICeVGmPIZ4RenHQ1XMs6Z8Ie/UNIekdot7MauDVJDXTC/nx+zgbKL
         mBWJ29LUF+7hVictDfE2FkYJlQ57JT7vDFGD8K7ui3GhufoPlHyGX9bMQtV80n2pJqKH
         J42tOq/HOcV6sgwmEI7UOSki0AgY+HmKOYZkSNweGz1gRErlij+8MNUCEv7rU/HPt5dy
         NNzw==
X-Gm-Message-State: AOAM530y11eMNAtQ0IHkQ2dhPYyR7aE/LVIaAOLUGR57kUnYQeawb/gC
        bdGaWmdNwfLfyrAelevHB0Hbh2RFUBAxkjVmmQk+araPV1aLSp7K1wphXd28hbALQCEls06QcQv
        94m/NtxD8FGTaYADN9dPCkQ+l
X-Received: by 2002:a5d:5889:0:b0:20a:9707:39c with SMTP id n9-20020a5d5889000000b0020a9707039cmr6711116wrf.54.1650380620255;
        Tue, 19 Apr 2022 08:03:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwChCgPohVPs2SQ2ry6VMkMu0eI/8iyTTO/0+EEMeH5AS5oHEakyqxkr6fAIHOwQVsuPFGbsg==
X-Received: by 2002:a5d:5889:0:b0:20a:9707:39c with SMTP id n9-20020a5d5889000000b0020a9707039cmr6711089wrf.54.1650380619968;
        Tue, 19 Apr 2022 08:03:39 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id r129-20020a1c2b87000000b0038e6a025d05sm17017899wmr.18.2022.04.19.08.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 08:03:38 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        christophe.leroy@csgroup.eu, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com
Subject: [RFC PATCH v2 1/2] module: Make module_flags_taint() accept a module's taints bitmap directly
Date:   Tue, 19 Apr 2022 16:03:33 +0100
Message-Id: <20220419150334.3395019-2-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220419150334.3395019-1-atomlin@redhat.com>
References: <20220419150334.3395019-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

No functional change.

The purpose of this patch is to modify module_flags_taint() to accept a
module's taints bitmap as a parameter and modifies all users accordingly.
This is in preparation for module unload taint tracking support.

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 kernel/module/main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 05a42d8fcd7a..ea78cec316dd 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -890,13 +890,13 @@ static inline int module_unload_init(struct module *mod)
 }
 #endif /* CONFIG_MODULE_UNLOAD */
 
-static size_t module_flags_taint(struct module *mod, char *buf)
+static size_t module_flags_taint(unsigned long taints, char *buf)
 {
 	size_t l = 0;
 	int i;
 
 	for (i = 0; i < TAINT_FLAGS_COUNT; i++) {
-		if (taint_flags[i].module && test_bit(i, &mod->taints))
+		if (taint_flags[i].module && test_bit(i, &taints))
 			buf[l++] = taint_flags[i].c_true;
 	}
 
@@ -974,7 +974,7 @@ static ssize_t show_taint(struct module_attribute *mattr,
 {
 	size_t l;
 
-	l = module_flags_taint(mk->mod, buffer);
+	l = module_flags_taint(mk->mod->taints, buffer);
 	buffer[l++] = '\n';
 	return l;
 }
@@ -2993,7 +2993,7 @@ char *module_flags(struct module *mod, char *buf)
 	    mod->state == MODULE_STATE_GOING ||
 	    mod->state == MODULE_STATE_COMING) {
 		buf[bx++] = '(';
-		bx += module_flags_taint(mod, buf + bx);
+		bx += module_flags_taint(mod->taints, buf + bx);
 		/* Show a - for module-is-being-unloaded */
 		if (mod->state == MODULE_STATE_GOING)
 			buf[bx++] = '-';
-- 
2.34.1

