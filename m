Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716BE3C30
	for <linux-modules@vger.kernel.org>; Sun, 22 Oct 2023 18:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="JnYWFfzP"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF7FEB
	for <linux-modules@vger.kernel.org>; Sun, 22 Oct 2023 11:09:43 -0700 (PDT)
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A800D3F078
	for <linux-modules@vger.kernel.org>; Sun, 22 Oct 2023 18:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1697998180;
	bh=2u2G7y1eDVG1qOgEBPqskI7dFs5YVWHnKqB6hLgPtS0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=JnYWFfzP+HA5L1TWW2gZjveET43ndzN2pKVA93AP3tzmBYg5xHBnrX/IcxePU3Ibf
	 YOSVTDQGZz5r1m7otgBhdw5EL8d9uwsB3A75iyOFleacq62Na9Tj5zNhucpRTA0rNe
	 VL6qBTk++6PogL2SVzrSERIHF3aU8N2/Q4iqo2n2cJvlDqvflmq5ZZ6J+QrOOwZG0m
	 PESXMj/ao+FVES2PunVUzbbrUi39V3n7feQ1jfrpgYBCADsbY5OpW2/3uRHggw6eJn
	 uJ3GrUD8KRXopFmNrG53TCQVHChzgoUQLVuLTS4PsSxsNzoycITP2OT1E1Fh+IKxvv
	 tUdVJkwMBlvrw==
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-32d83fd3765so1102404f8f.3
        for <linux-modules@vger.kernel.org>; Sun, 22 Oct 2023 11:09:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697998180; x=1698602980;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2u2G7y1eDVG1qOgEBPqskI7dFs5YVWHnKqB6hLgPtS0=;
        b=saqUdOjOuK8LLVf9uCH3g+6C7TAUNrGH6D0Y2ShLE8jOx/VlJIjf7g22WrsLa4bl7W
         SCLzg67rd2I+GmSB4enSpXXk9Dcp6DgdG6P1cVC16B+7ZHxeMg+/OfxQXMKnJ+tpMu3D
         bV6xXUes6UkzV/HFvJBIec6z8jqA4JMnOdhLUi77Fzoc8Yh2drO2K+uxOOu2PrXCLMLN
         QwvYLAk2qMy67Yg4UCRfzALL9NNuocUmFKsMq06MM5pe79pRLBqi8EslQNBcAlNm5g8i
         dMkgD0mPGZIY7fUj4g1q+jvepRJgOQhNhXn2uJNPq57YLaQZrJz4ctH3hLEJ142mU7Ut
         /oyQ==
X-Gm-Message-State: AOJu0YxFV0cfydzOGgIriHXJKpyDGCSeCw8J36lqgvjwr/H1wrE4H+05
	lUVOb0MFGnDkJDINHp2lSRsxyXZJSwZhLC1lZt/2G6l/KOc3HerS4aUZdtXyGRiFLBu9KkEjkB9
	190Da+EQXqZYIa/QdiE2x2gMDkjgx/Lz+hy5I53fZ6m/rfTpHdUo=
X-Received: by 2002:adf:eec8:0:b0:32d:a28b:da08 with SMTP id a8-20020adfeec8000000b0032da28bda08mr5061043wrp.62.1697998179947;
        Sun, 22 Oct 2023 11:09:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFF6+fuKen5t5aCjEjZgy3qEXEYuodjcpENvkNYyWtlK+AEuZVgqjuYUoLyugX/fuwWz8XLxA==
X-Received: by 2002:adf:eec8:0:b0:32d:a28b:da08 with SMTP id a8-20020adfeec8000000b0032da28bda08mr5061031wrp.62.1697998179549;
        Sun, 22 Oct 2023 11:09:39 -0700 (PDT)
Received: from localhost ([2001:67c:1560:8007::aac:c15c])
        by smtp.gmail.com with ESMTPSA id o7-20020a056000010700b003232d122dbfsm6039011wrx.66.2023.10.22.11.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 11:09:39 -0700 (PDT)
From: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
To: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] kmod: Add FIPS 202 SHA-3 support
Date: Sun, 22 Oct 2023 19:09:28 +0100
Message-Id: <20231022180928.180437-1-dimitri.ledkov@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for parsing FIPS 202 SHA-3 signature hashes. Separately,
it is not clear why explicit hashes are re-encoded here, instead of
trying to generically show any digest openssl supports.

Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
---
 libkmod/libkmod-signature.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/libkmod/libkmod-signature.c b/libkmod/libkmod-signature.c
index b749a818f9..a39059cd7c 100644
--- a/libkmod/libkmod-signature.c
+++ b/libkmod/libkmod-signature.c
@@ -57,6 +57,9 @@ enum pkey_hash_algo {
 	PKEY_HASH_SHA512,
 	PKEY_HASH_SHA224,
 	PKEY_HASH_SM3,
+	PKEY_HASH_SHA3_256,
+	PKEY_HASH_SHA3_384,
+	PKEY_HASH_SHA3_512,
 	PKEY_HASH__LAST
 };
 
@@ -70,6 +73,9 @@ const char *const pkey_hash_algo[PKEY_HASH__LAST] = {
 	[PKEY_HASH_SHA512]	= "sha512",
 	[PKEY_HASH_SHA224]	= "sha224",
 	[PKEY_HASH_SM3]		= "sm3",
+	[PKEY_HASH_SHA3_256]	= "sha3-256",
+	[PKEY_HASH_SHA3_384]	= "sha3-384",
+	[PKEY_HASH_SHA3_512]	= "sha3-512",
 };
 
 enum pkey_id_type {
@@ -167,6 +173,12 @@ static int obj_to_hash_algo(const ASN1_OBJECT *o)
 	case NID_sm3:
 		return PKEY_HASH_SM3;
 # endif
+	case NID_sha3_256:
+		return PKEY_HASH_SHA3_256;
+	case NID_sha3_384:
+		return PKEY_HASH_SHA3_384;
+	case NID_sha3_512:
+		return PKEY_HASH_SHA3_512;
 	default:
 		return -1;
 	}
-- 
2.34.1

