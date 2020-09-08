Return-Path: <SRS0=CO/U=CR=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216A9C433E2
	for <linux-modules@archiver.kernel.org>; Tue,  8 Sep 2020 19:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD17120658
	for <linux-modules@archiver.kernel.org>; Tue,  8 Sep 2020 19:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="i6HVXVbE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730361AbgIHT7l (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731437AbgIHT7h (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 8 Sep 2020 15:59:37 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0C4C061755
        for <linux-modules@vger.kernel.org>; Tue,  8 Sep 2020 12:59:37 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id q9so184150wmj.2
        for <linux-modules@vger.kernel.org>; Tue, 08 Sep 2020 12:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6Bi+XdwVbjYliaCr5IaGm6ChAPDH7ThwYB/lImKcl0Y=;
        b=i6HVXVbE0kOV+N7lAKBaYWwFd7HEZJRbOc6+iTNLBk4cjl0+ot04iC2WeXf+DkHCZ7
         oa3yHdXjvi4SMJ7OpBU5NnSo8Q8pTz8HPj8DTrd6Pz1Ye7swwxzcMAqB+QoOkwZfK8jh
         gwmvsDcpgeYeP4glQEJF/PntcbrftJcPrWUShBDi2SqRpskFWJOj6MdCYD2fbot9Spam
         3H3VBf5KVAQ1oTbSW/H4JTRhk/m9xCrDX3CO9SBr6i2KAZTRGM2vcM2wifw2Ue/A/DVa
         whCJle/nDb9esmV9ivJJArdb/B0iTxu1vm6AOh3cmT7S/PCaXtt1ArXk79z7Ke4J+tER
         TKQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Bi+XdwVbjYliaCr5IaGm6ChAPDH7ThwYB/lImKcl0Y=;
        b=eeneWVPlrdTu4SdPUb4CVia8uHoSxIy8A4OUkmbW8lkYzu1557E9g4+gR3FqLnDsYp
         EvqkqwYcJVeWDytERMgF1Ipx6I8x2KoXGG9Pg3F/ZHy6Y4F4kHGterWAd4/HK0t8O4j8
         y+8owX3DwnOX8ClPurIgeuGV4NFYRcTTQuMqtyoTmBDYwpHbsO0s6lZyx812YgAYKkSx
         ne2POlX1Zz0R2Ri0FkXyWnBY8wE130MBlMVceRBhex13dj/qozV88Wc5LyfvnD7afmIj
         f/fwwxbTYkvBfBzJctCPXunwLlPYfQ32ABllO+R3nyaM+lxJXwFARz8y1PEyM3h5KaZF
         DSfQ==
X-Gm-Message-State: AOAM531NRJqU1pgtB+xqTureo9FXiCqxLiYijS9tINuWPiNgKw56Gg/p
        iSQlYghBSrrJgHtOx71fYekKCAFPxIj1vQ==
X-Google-Smtp-Source: ABdhPJwcVFNJUfxQPeCxvwOv7GPVUBLz19uWBfuTSqfPGoF47931LVU0rxLP3vK2XqesM7DHB/Mliw==
X-Received: by 2002:a1c:9ed8:: with SMTP id h207mr94523wme.116.1599595174011;
        Tue, 08 Sep 2020 12:59:34 -0700 (PDT)
Received: from localhost.localdomain (ip1f11fff1.dynamic.kabel-deutschland.de. [31.17.255.241])
        by smtp.gmail.com with ESMTPSA id m3sm680855wme.31.2020.09.08.12.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 12:59:33 -0700 (PDT)
From:   Torge Matthies <openglfreak@googlemail.com>
To:     linux-modules@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Torge Matthies <openglfreak@googlemail.com>
Subject: [PATCH v2 2/2] testsuite: add test for zstd-compressed module
Date:   Tue,  8 Sep 2020 21:59:21 +0200
Message-Id: <20200908195921.869779-2-openglfreak@googlemail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908195921.869779-1-openglfreak@googlemail.com>
References: <20200908195921.869779-1-openglfreak@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

I took away one module from the gzip-compressed modules for this purpose.

Signed-off-by: Torge Matthies <openglfreak@googlemail.com>
---
 testsuite/populate-modules.sh | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/testsuite/populate-modules.sh b/testsuite/populate-modules.sh
index 5140f7a..358e740 100755
--- a/testsuite/populate-modules.sh
+++ b/testsuite/populate-modules.sh
@@ -66,10 +66,13 @@ map=(
 
 gzip_array=(
     "test-depmod/modules-order-compressed/lib/modules/4.4.4/kernel/drivers/block/cciss.ko"
-    "test-depmod/modules-order-compressed/lib/modules/4.4.4/kernel/drivers/scsi/hpsa.ko"
     "test-depmod/modules-order-compressed/lib/modules/4.4.4/kernel/drivers/scsi/scsi_mod.ko"
     )
 
+zstd_array=(
+    "test-depmod/modules-order-compressed/lib/modules/4.4.4/kernel/drivers/scsi/hpsa.ko"
+    )
+
 attach_sha256_array=(
     "test-modinfo/mod-simple-sha256.ko"
     )
@@ -101,6 +104,11 @@ for m in "${gzip_array[@]}"; do
     gzip $ROOTFS/$m
 done
 
+# zstd-compress these modules
+for m in "${zstd_array[@]}"; do
+    zstd --rm $ROOTFS/$m
+done
+
 for m in "${attach_sha1_array[@]}"; do
     cat ${MODULE_PLAYGROUND}/dummy.sha1 >> ${ROOTFS}/$m
 done
-- 
2.28.0

