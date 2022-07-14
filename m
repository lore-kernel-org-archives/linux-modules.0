Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1F1CCA483
	for <linux-modules@archiver.kernel.org>; Thu, 14 Jul 2022 15:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240406AbiGNPj4 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 14 Jul 2022 11:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240354AbiGNPjo (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 14 Jul 2022 11:39:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 35CAE2C647
        for <linux-modules@vger.kernel.org>; Thu, 14 Jul 2022 08:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657813182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mpFwBg17MPLedEeXsKR0g11KSb+p+AI/SVxHMocug7Y=;
        b=ec1RPWh2V5eR7jxHnrhfI8aRAUnpcLGq5izFJDGWGCHjnDsjyzHcLck9axPA36wePFslmV
        DD1Uh6Zpyq9k2B0H/wYZFBVAAvfefa2wbttBUniX7COF2ucJKITxwov3Fk5WeIcvVDNOIU
        aWE1tjSY1KtjOzNJSYkG28YOCEwubR8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-13-Wl0x9h42MzmdvMGsiEFH6A-1; Thu, 14 Jul 2022 11:39:40 -0400
X-MC-Unique: Wl0x9h42MzmdvMGsiEFH6A-1
Received: by mail-wm1-f71.google.com with SMTP id z20-20020a1c4c14000000b003a3020da654so717472wmf.5
        for <linux-modules@vger.kernel.org>; Thu, 14 Jul 2022 08:39:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mpFwBg17MPLedEeXsKR0g11KSb+p+AI/SVxHMocug7Y=;
        b=UKvtPAEMVAO3kZ0/xA5+JXnACkhwJa3EychNRS5BFccx4f5vjBt5YGwd2ENZPPCdrn
         ZF1xQcVvjoU7GOaULBRqtemOXx/b4ij6VBpbYMs7QwcNeH/m2XEVdAohiCQp2IylzrxH
         jN1IflHXI+p6w8/IckKEyPM1xa0wMbAt7DL80POZwxeeeC6o4/CDIli05HJcWHM2RoRL
         Qk2jbrt5RfSJJhYza085uhVk8C9WK31E+Sw36NzQ5M7pTOCCQWnMFVvpS3swJqtNDg6b
         QFBjBeiI8v0HHoBPEftjvulIapoUgRl8k+RSM4RqswF//UQjsl/kLyzgS8HkppkKaoz/
         QiNg==
X-Gm-Message-State: AJIora/NEUYvCKh31/7hNEwhziazd9KuXjf+NfeqPTjD9YeIWHVSCyWP
        8dnT/1Ir+Cbbfi4dIIONrsBIs7QOKlA3dxYOw8wc2Y0mVX2f0zGEFF3H2BlPzk6uLYf88idjmUH
        l//ivZfBfG6/OjqM+3XRddTR8
X-Received: by 2002:adf:f746:0:b0:21d:6afd:b7d3 with SMTP id z6-20020adff746000000b0021d6afdb7d3mr8680746wrp.501.1657813179272;
        Thu, 14 Jul 2022 08:39:39 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t5tKhmAkul9pcobJT+isErEbVQ/CkLfg6Gb+rF4t/kzbOpZtS1pgsyb94YxSH6cD9DrPkr8Q==
X-Received: by 2002:adf:f746:0:b0:21d:6afd:b7d3 with SMTP id z6-20020adff746000000b0021d6afdb7d3mr8680732wrp.501.1657813179045;
        Thu, 14 Jul 2022 08:39:39 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id w10-20020adfcd0a000000b0021d888e1132sm1729356wrm.43.2022.07.14.08.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 08:39:38 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org, christophe.leroy@csgroup.eu
Cc:     linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, oleksandr@natalenko.name, neelx@redhat.com
Subject: [PATCH v2 2/3] module: Use strscpy() for last_unloaded_module
Date:   Thu, 14 Jul 2022 16:39:32 +0100
Message-Id: <20220714153933.2095776-3-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220714153933.2095776-1-atomlin@redhat.com>
References: <20220714153933.2095776-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

The use of strlcpy() is considered deprecated [1].
In this particular context, there is no need to remain with strlcpy().
Therefore we transition to strscpy().

[1]: https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 kernel/module/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index a4d23b0ebbc0..c5db13d06995 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -754,7 +754,7 @@ SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
 	async_synchronize_full();
 
 	/* Store the name of the last unloaded module for diagnostic purposes */
-	strlcpy(last_unloaded_module, mod->name, sizeof(last_unloaded_module));
+	strscpy(last_unloaded_module, mod->name, sizeof(last_unloaded_module));
 
 	free_module(mod);
 	/* someone could wait for the module in add_unformed_module() */
-- 
2.34.3

