Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B179C433F5
	for <linux-modules@archiver.kernel.org>; Mon, 25 Apr 2022 09:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239006AbiDYJLy (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 25 Apr 2022 05:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbiDYJLx (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 25 Apr 2022 05:11:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F4235C9B69
        for <linux-modules@vger.kernel.org>; Mon, 25 Apr 2022 02:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650877728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wj4nXdv1p55S6gdjYiynG1yQGRwuN4zNBoal8sio/r8=;
        b=TLzOFxrCyIJbhlu+u0HaJdK1jxgP3dZke3ZSME34BGwB6xljt2UyoWE9OykJy6OQfnKDCX
        AGdJQz0wjJxgwOkQKhCOoUehk+69iT7Ybv9DDsS+R0pLSRpB67E3dPlt45Ce2eVS+daOZV
        VfajNNOaGkNW1b+kzvbTVTKScy5tny4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-317-lFavTMEsPrmT-b9M34Y0XA-1; Mon, 25 Apr 2022 05:08:46 -0400
X-MC-Unique: lFavTMEsPrmT-b9M34Y0XA-1
Received: by mail-wr1-f69.google.com with SMTP id e13-20020adf9bcd000000b0020adc114131so544396wrc.8
        for <linux-modules@vger.kernel.org>; Mon, 25 Apr 2022 02:08:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wj4nXdv1p55S6gdjYiynG1yQGRwuN4zNBoal8sio/r8=;
        b=ytQx/KhBH9Oa4FBrdiyWQiqFvZZF362xRSsHn4EQE+LNqbmzE+SYi/eRN611Dx+jWj
         E8ENSDfxI0u7JPfKMFBeB3JCP2gyDbk9LF3t+DsdRytDoim8GdaFJZ1N31Z9Dw3GbuDj
         ZrwQqHz4e0oUGVvuLt22zlBZB0qQhzhhOVVtYanriRY/q3L/WP7hu7kBfn/zDcF5H1Uz
         Fo4j/ruIOHU+IgTPSdYg6P5Nn7uXCBB0P4wjbVR55FP2FEY3YKAzaqdpzfFE45KEHQZW
         swpJXgaxoSSuXMiSLkmXctnpC3T5XMtic2LTyyaXaqxIRjiaBua8PlNl6+wgpOoHmzMM
         AqlA==
X-Gm-Message-State: AOAM5309roQisa8N/VJDYmrLj0ejO5OGM36t+VGtBnsMrcYWAGaHV6Ug
        F2Kld3c2ulcLRIV2XnbHXLZ+9Kw8y5pHYfIQnuo0N4AVNt68pRhtr992bID/v41QKPGXzhMfMYD
        p7SCxeyt5SirvfLkC626t75va
X-Received: by 2002:a05:6000:1688:b0:20a:7ef8:d201 with SMTP id y8-20020a056000168800b0020a7ef8d201mr13074702wrd.515.1650877725692;
        Mon, 25 Apr 2022 02:08:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBIGCZEjVe+1qUV6bT0oqZ48+b2HWORGmlt2TRSmJ3JWWIeHAHjdQ+xhgzv4kVTWYHbggEiQ==
X-Received: by 2002:a05:6000:1688:b0:20a:7ef8:d201 with SMTP id y8-20020a056000168800b0020a7ef8d201mr13074684wrd.515.1650877725518;
        Mon, 25 Apr 2022 02:08:45 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id l10-20020a05600002aa00b0020a7cc29000sm9324984wry.75.2022.04.25.02.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 02:08:44 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        christophe.leroy@csgroup.eu, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com, oleksandr@natalenko.name,
        neelx@redhat.com
Subject: [PATCH v4 1/2] module: Make module_flags_taint() accept a module's taints bitmap directly
Date:   Mon, 25 Apr 2022 10:08:40 +0100
Message-Id: <20220425090841.3958494-2-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220425090841.3958494-1-atomlin@redhat.com>
References: <20220425090841.3958494-1-atomlin@redhat.com>
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

