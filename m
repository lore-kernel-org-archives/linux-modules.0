Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0380A186C
	for <linux-modules@vger.kernel.org>; Tue, 10 Oct 2023 21:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="EGbOwCTb"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36A598
	for <linux-modules@vger.kernel.org>; Tue, 10 Oct 2023 14:26:55 -0700 (PDT)
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8CEA73F148
	for <linux-modules@vger.kernel.org>; Tue, 10 Oct 2023 21:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1696973214;
	bh=bbJL2SOs8ojKA5eoIkTwtjiwN0Y17d4pCBALcurYDbM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=EGbOwCTbgnG0qtzHcLeK4xmagTlavBn+26rDLOGJd1N59/5Gb5v6GvPXUWRO3Miuq
	 fzj4NdNKq80D7VG5lHU5R2F4KZaltolwo8zH2GCBXkMjp9g6e4vcfdzOqB0MkpBtNk
	 mEVr8KQEFnZWP8etU+esoJpF007VMDg70z9wEH8i0Gnh4cDu/qLraUuA2bIQ9DQeTm
	 VwMtZXF/wL+G9qR16EO4Dl5vefloTPWe3rs4ho1jM8y5b2vOv+G4p2jDFoFLep/RAt
	 Lj5WV08BJbEuxP8V+0QxGkEfb71k6CCw//ifqEPqCBbG1CASvVlUYohTt3aLds/xde
	 sA3/RswEM/28Q==
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1c9af63aa32so12571055ad.1
        for <linux-modules@vger.kernel.org>; Tue, 10 Oct 2023 14:26:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696973208; x=1697578008;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bbJL2SOs8ojKA5eoIkTwtjiwN0Y17d4pCBALcurYDbM=;
        b=IZj9eFO4xTrounW7l0QnsmHJ0S9WYtNojEFPVcRePVKqujt2DnJETgEyDhbJpaH3l7
         LB3gPi+j3/ITyB0vGpFHzacWchIU6u9e/QPNQRvYzbNJ8ZOPF8d2zimvTTa4gTlVPx9v
         hPE0pl6itH6IYC80BS6kIoRev8065TAhVi/shNCf5savC/aUnKSEGlD7wkxlhMiRDPBQ
         QWGeX1movWnDzlfNnziK6zWYWnzF3dm5oQMIGALE/hvDz3XEcFml6GKyziOV6jucPi21
         xx6CAVPHOAbFU4UemFja/IgElaMVFyb8UZQ+cS3loh0KdizV87iHCh/jTNEGTVSapS1I
         1OAA==
X-Gm-Message-State: AOJu0Yz6W5WAlbtEsH8aNSNgfr5C5DccqkTuXcBRiwc9xtiyKMaw2OP5
	L2z0i7vQqonYXqpeQWef2xgrk0iv+covEYEPztxVVMtjg1kd+mIruMzk/rwF/lsFtVMWoCvz0+B
	8XfHwWgIpDPnsCP3tQbIwQvSnHiGntZmhvVqeD91o4ERBSI57ocP2Zw==
X-Received: by 2002:a17:902:f546:b0:1bb:e74b:39ff with SMTP id h6-20020a170902f54600b001bbe74b39ffmr20923276plf.0.1696973207794;
        Tue, 10 Oct 2023 14:26:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhPNlPGDhB23VsV1NLFkLmOVxbRADLHq+9HPJKINV5zuYaaLs4kvapjxiGjBumVRZrSs0ziQ==
X-Received: by 2002:a17:902:f546:b0:1bb:e74b:39ff with SMTP id h6-20020a170902f54600b001bbe74b39ffmr20923258plf.0.1696973207428;
        Tue, 10 Oct 2023 14:26:47 -0700 (PDT)
Received: from localhost ([2001:67c:1560:8007::aac:c15c])
        by smtp.gmail.com with ESMTPSA id e4-20020a170902d38400b001bb9bc8d232sm12287028pld.61.2023.10.10.14.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 14:26:47 -0700 (PDT)
From: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-crypto@vger.kernel.org,
	herbert@gondor.apana.org.au,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] module: Do not offer sha224 for built-in module signing
Date: Tue, 10 Oct 2023 22:26:33 +0100
Message-Id: <20231010212633.64042-1-dimitri.ledkov@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

sha224 does not provide enough security against collision attacks
relative to the default keys used for signing (RSA 4k & P-384). Also
sha224 never became popular, as sha256 got widely adopter ahead of
sha224 being introduced.

Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
---
 kernel/module/Kconfig | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
index 19a53d5e77..9d7d45525f 100644
--- a/kernel/module/Kconfig
+++ b/kernel/module/Kconfig
@@ -236,10 +236,6 @@ choice
 	  possible to load a signed module containing the algorithm to check
 	  the signature on that module.
 
-config MODULE_SIG_SHA224
-	bool "Sign modules with SHA-224"
-	select CRYPTO_SHA256
-
 config MODULE_SIG_SHA256
 	bool "Sign modules with SHA-256"
 	select CRYPTO_SHA256
@@ -257,7 +253,6 @@ endchoice
 config MODULE_SIG_HASH
 	string
 	depends on MODULE_SIG || IMA_APPRAISE_MODSIG
-	default "sha224" if MODULE_SIG_SHA224
 	default "sha256" if MODULE_SIG_SHA256
 	default "sha384" if MODULE_SIG_SHA384
 	default "sha512" if MODULE_SIG_SHA512
-- 
2.34.1

