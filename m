Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C607C61DA4
	for <linux-modules@archiver.kernel.org>; Mon,  6 Feb 2023 14:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjBFOdF (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 6 Feb 2023 09:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjBFOdE (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 6 Feb 2023 09:33:04 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB5F234E2
        for <linux-modules@vger.kernel.org>; Mon,  6 Feb 2023 06:33:03 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id k8-20020a05600c1c8800b003dc57ea0dfeso10937911wms.0
        for <linux-modules@vger.kernel.org>; Mon, 06 Feb 2023 06:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xh0926pxnaBx4+Wll+3b5/KrCRZVl/ZwJJdZRl9QUQc=;
        b=YH2vT3fJPVlHjAAH+vTq5NKMHpfcVI1ZFsuk0+mqe5nuvIz2IIunqIJFGi9LNYYMkc
         H17v6YBHEOkPFfX9vqU7UTY74yD8+RMB7IO44msnV8GN2nkVRFTi3BrS4o36i8Xi4Gg3
         J1yb7dxfm3VkhlV7i5Vw+zFwJoo1fTEFEnCjj8FgH/GuXbcZju7EsffOvfLBlQe/DYKt
         zEcxqbfac9dpBCqz066rYS+F5PYv6x9FjHn5tJPT7I5rYVzInMKuIFoGXd2yYzSocYkz
         /BUPLaYC3NfJ1qYOqJp+cf43+tZgzKEmziQF/qmdt/WAE17Qv2+iN7QTUUthJ0EDGzPx
         gkog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xh0926pxnaBx4+Wll+3b5/KrCRZVl/ZwJJdZRl9QUQc=;
        b=mTt8T3Cpt3yDEk7NgN1lQ4ajge+ySYfTIkI5CjApW5ieLprc18Ke2vxFzxOu1rFJz6
         WwlR/x9H8gQ4Hb7CHHCk5rTM3QqBx97JwN57Pe2FTx6DX4vv/eHJNEDC70vuomBrBYaK
         gAUud/acCjFtr74McR0++sNFF0C8etUcxEc4/pa2jwS95KFm8hyJfifRAwfRtejQ75ep
         mrO8yGvYoJyvQCUt9eqHfSzDDn1QbD+/C2tLlalscn+Qfmjj2Hpx37NlG++0q8nbEClw
         EgTIrVaNJLMWtVvmkPvntTTcHgPVynAGQqoE47OlXy0lmTc2iEXoMZhzsk+TwpSEI07u
         pp8A==
X-Gm-Message-State: AO0yUKV+Yq6luy6j1Z6QeTjrROO5TIg/o9v0isxzKooxAtqcGaMWTeCi
        SjEx8BDi4w89MvlG0PRXysvJQWctGHc=
X-Google-Smtp-Source: AK7set/YPoJOCUoXnWbIVdfCi+sZO5U67ciupDv/QO2xPTBW3iJcuShhD9LX9DBSSwKEpf80AX0Y6Q==
X-Received: by 2002:a05:600c:1d04:b0:3cf:85f7:bbc4 with SMTP id l4-20020a05600c1d0400b003cf85f7bbc4mr19667678wms.2.1675693981314;
        Mon, 06 Feb 2023 06:33:01 -0800 (PST)
Received: from localhost ([2a00:5f00:102:0:9503:21c4:e16b:65c3])
        by smtp.gmail.com with UTF8SMTPSA id h27-20020a05600c2cbb00b003db12112fcfsm12244894wmc.4.2023.02.06.06.33.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 06:33:00 -0800 (PST)
From:   Emil Velikov <emil.l.velikov@gmail.com>
To:     linux-modules@vger.kernel.org
Cc:     emil.l.velikov@gmail.com,
        Mikhail Novosyolov <m.novosyolov@rosalinux.ru>,
        Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH] libkmod: error out on unknown hash algorithm
Date:   Mon,  6 Feb 2023 14:32:59 +0000
Message-Id: <20230206143259.585180-1-emil.l.velikov@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

From: Emil Velikov <emil.velikov@collabora.com>

Currently if we see unknown algorithm, we'll do an OOB read in
pkey_hash_algo. This can happen for example if OPENSSL_NO_SM3 is set and
the kernel module uses a SM3 hash.

Cc: Mikhail Novosyolov <m.novosyolov@rosalinux.ru>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Emil Velikov <emil.velikov@collabora.com>
---
Should probably wire some sanitizers and/or valgrind to the tests.
Although I'm not sure if I'll get the time to do so.
---
 libkmod/libkmod-signature.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/libkmod/libkmod-signature.c b/libkmod/libkmod-signature.c
index 092f396..b749a81 100644
--- a/libkmod/libkmod-signature.c
+++ b/libkmod/libkmod-signature.c
@@ -219,6 +219,7 @@ static bool fill_pkcs7(const char *mem, off_t size,
 	unsigned char *key_id_str;
 	struct pkcs7_private *pvt;
 	const char *issuer_str;
+	int hash_algo;
 
 	size -= sig_len;
 	pkcs7_raw = mem + size;
@@ -277,7 +278,10 @@ static bool fill_pkcs7(const char *mem, off_t size,
 
 	X509_ALGOR_get0(&o, NULL, NULL, dig_alg);
 
-	sig_info->hash_algo = pkey_hash_algo[obj_to_hash_algo(o)];
+	hash_algo = obj_to_hash_algo(o);
+	if (hash_algo < 0)
+		goto err3;
+	sig_info->hash_algo = pkey_hash_algo[hash_algo];
 	// hash algo has not been recognized
 	if (sig_info->hash_algo == NULL)
 		goto err3;
-- 
2.39.1

