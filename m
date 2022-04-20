Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24EF6C433F5
	for <linux-modules@archiver.kernel.org>; Wed, 20 Apr 2022 11:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378276AbiDTLzu (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 20 Apr 2022 07:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378277AbiDTLzt (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 20 Apr 2022 07:55:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B45114249C
        for <linux-modules@vger.kernel.org>; Wed, 20 Apr 2022 04:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650455582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wj4nXdv1p55S6gdjYiynG1yQGRwuN4zNBoal8sio/r8=;
        b=RRfnzZG5B4Uzka+smO4lo+eWMWUH+LYzsw/rQX25ngzWH06yY0FG/UMakEH9SEpws7JmEC
        nOCBLnYPfqDrFsminex800rzT0reOYbnF1NuMrYZAl+bFpMHp9F0Ki4N7xLaWSJJuFo2gA
        deKb5P3WF0OHcJ5F5rAyv1mPQAW5p90=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-144-ubvketUGOvq-ZlSZ6Qi2iA-1; Wed, 20 Apr 2022 07:53:01 -0400
X-MC-Unique: ubvketUGOvq-ZlSZ6Qi2iA-1
Received: by mail-wm1-f70.google.com with SMTP id c125-20020a1c3583000000b0038e3f6e871aso810836wma.8
        for <linux-modules@vger.kernel.org>; Wed, 20 Apr 2022 04:53:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wj4nXdv1p55S6gdjYiynG1yQGRwuN4zNBoal8sio/r8=;
        b=XMDTJqXxh3ihWrLYalBSQpGMJlzQC4M9j2momasTNWzfhOTd8HmN7wd+IWv6OU5t+8
         q7Bp5vU87vFBMTxUa5ibuhtAB19PjXfBNMg/Ved68LveytZZ1uvxCHz9Hfj//PoKe4Ss
         bIXvDCOq60wwKhr3lhIXfEqh5+BwGxrQP1sZJyECuw8Wi3Kqri5XTi0FaimNfRnZKG0o
         YQZBoPCYotWSGGAHbgi3zGcprON6nI4Ch0YL6JDYNDwVPPRW1kQ006Exj2wsHaCFgE2j
         QbB9jM58NQV8NjpKvc8xST2joQdK+Hjv1Mjldjg/8giPDCaz2pMTDrFG5oSOfsVel9dg
         +9Qg==
X-Gm-Message-State: AOAM5336gNnboy2mHnkR3qYR8fAcLrTuEmwBY1fT0Z3gnSoUpt3fqUWf
        DCkTXExLGnllmFWC0jct5JC30sjzbuGVH97Zd+FTOiFblstvwUtTwOq5fbwJZQdGgI6U8Zo0GnD
        Bnzp3hnXtH3h3XLuP2AZOL9eB
X-Received: by 2002:a05:600c:3ac6:b0:38e:d79e:d9a with SMTP id d6-20020a05600c3ac600b0038ed79e0d9amr3231380wms.200.1650455580566;
        Wed, 20 Apr 2022 04:53:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyptGP8duMmQo1LImHknI95oJYwmBAN9GbqtwZdsmtM8wxSj1PX+FCWEX4Pfh1PWJZNJ5TyOQ==
X-Received: by 2002:a05:600c:3ac6:b0:38e:d79e:d9a with SMTP id d6-20020a05600c3ac600b0038ed79e0d9amr3231366wms.200.1650455580418;
        Wed, 20 Apr 2022 04:53:00 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id v14-20020a7bcb4e000000b0034492fa24c6sm18866730wmj.34.2022.04.20.04.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 04:52:59 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        christophe.leroy@csgroup.eu, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com, oleksandr@natalenko.name,
        neelx@redhat.com
Subject: [PATCH v3 1/2] module: Make module_flags_taint() accept a module's taints bitmap directly
Date:   Wed, 20 Apr 2022 12:52:56 +0100
Message-Id: <20220420115257.3498300-2-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220420115257.3498300-1-atomlin@redhat.com>
References: <20220420115257.3498300-1-atomlin@redhat.com>
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

