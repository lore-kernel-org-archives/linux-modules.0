Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795737630;
	b=vdWIt+x79XBocE7kKNeU/U+GVP6hwjHWKPZRai9c8WFMtH9i9lN43lJZyLuao/HIzYXw
	 mo4UoX7fpt8NbLKnodroIF3SP54KWeaV6JHWEjR8Fdx29fxPqnQwEUB+DU6meB+CJtoOX
	 MG48wpcn/Dv8MFgd70kIayY34NeSKmfD0kkR0Q9viKpSVcOvTs5FWigl4PZXTeoNbwryi
	 2e5Q88TQY4ROAZ4p8iKaV/W9apsEaXSknnNHeJnChoLUMWRnuUV9OgIf1rdcFw8sqc3fT
	 +EYjx9fWXcJIy6rv49qchDVDC5TSNdim+WRzMYDx4mT4shkB03rLBZ98No7DUzBu1DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795737630;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=BeaediEPiyvNCVsEZncQlv8H37LBayA0CIHeGsXXEqs=;
	b=oBQfsmM5blRqs5LA/9ckcpbSQ8iIHmadbvFYeOLzxOhU9CBWgcqGbcmblOpPAJFrbGAm
	 FTHcXbPaDIaATejs6cTqHE8cPh3RBg7LMcsCVE3w+kMudW7o2jn0rVzjno++u5z7TtRr4
	 iy6ERhH2j+E8lcpFwZiagWyYo2Wf81zNbaBQjavL+Crm8t12bT+OOwQaZWfxvyp4sUEBz
	 4ZDfPX1pNqbijUWHgASPxTlmu6NTVAp3DbWhlcslX345aH8xDQVPj8CcG+yviy1+v6VAZ
	 V8rWNeZeY3nEDOFnGHQUQdey4NS+wG/2yKv9zSP5oUv+BJnTzD7vSQ7sD4+B1v5FAUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ieiPBByc;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF04606A32C
	for <linux-modules@vger.kernel.org>; Fri, 27 Nov 2026 00:00:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BF04606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ieiPBByc
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-490d59c3edaso5119786f8f.1
        for <linux-modules@vger.kernel.org>; Thu, 26 Nov 2026 16:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795737628; x=1796342428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BeaediEPiyvNCVsEZncQlv8H37LBayA0CIHeGsXXEqs=;
        b=ieiPBBycSaIialON0r3egXgkOds8V+lp3Rx2UO+1Y0rc9nyNj3E8dmAyRMl2/P9BD+
         PFavVZZmNjPcy7UAGi2wzMcobZ2cJAlGDv6z2NcQ2h/93ltnk/WP52gnS4fQqtwyBm51
         JqSI9cstk3F74SB1inEcLmKqWtQ5P3Pynl7ma6L4ZLchz00VchONifCfcSvxYRGEuDVt
         MTYR2mBKPkbYTv3mB1WR8QnfVdLFNnmSdLxkcK9nDw/rVstI0vvaFQlTTXWkrTlfl1T4
         NXGMmYwxxS2+y2mrp9fs6RC0GPtI4QyfsZGg4gMlis+dVpm+L+R/pcwBgk4EGuKQ3HbA
         82Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795737628; x=1796342428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BeaediEPiyvNCVsEZncQlv8H37LBayA0CIHeGsXXEqs=;
        b=TacOJYhmKivpAHvTXjqrrhWeqxKxxaajYXQg2MO/k7kbcC8G8ohRyXwr0zLg4h0gZd
         kza2YDkVwxV8DYx8lg+jr0Gc1h9FJF3xsMxUp0rLEdYDl14bOYg5vpn4eQzlnZVKQo9r
         CHrnq5B0gfnv/2pg4HZ1hjkMwSLf09YcaD+pTOx3141EU0qrpzZXUNVM89kGPOKYFQa2
         I8mVt437gXBGCAaBV6mOBiMdnQCNE2GyHevYazKZfX64P/vV8cIZt8v761C0RGvqNHXt
         3Yk2JjiWkDVvmE78aksjxe45KX6vAYHUkhLGYiUJwBePQ8sqvnVsiJug+dMdRkVeLIfz
         Bt5Q==
X-Forwarded-Encrypted: i=1; AL+hErE2E6/422SlHus6gjcH/w9+CxTb6SbtrN+uo5xjYNe17mmzkeeIx2BqtRPiKyWKCcUiGl6u/J5ObNlyGodm@vger.kernel.org
X-Gm-Message-State: APuU4Z/4OIC8Y6tmsB4cHJxCebb5x+5+LfHH7oABHBE1fNospueQ4hme
	+Y7cd+9XrDP6hFeF6DGUITocdvocfY22bAS6EoFSnTlA2JpOpPyUtWd7
X-Gm-Gg: AZFdTZc6vDiNuzck5Fm5J4uHzT3HgCK39fhEPc+sNmSPtMYrRARG3bSz1jVmHaPDGc0
	dgjuzr7PqQ/p9VqaryUI5rU4Ojh4dnNo1lfDHhE3V2BLMnlvNxPqlrn+kEZQh1Upj9hga8AcUE2
	v3Fp509NbO/LmVOD/zXkEPl/qnX03ghyohF0sylI0X0a0rXTOTmMvetNlZUKPhSVmnsMxNquP9e
	JExR9MRX68ecZhJ0LM13KK4JhhQyP5xh/YPLQCdE/MDeV9yvnroBRUbEvmltfPVQ9Pl8smS44zl
	DSg7V0w0CCEWTPp7/giOOnxVklnP5pvLqxr4apodyxEc1E3gIBe+x6nso5XQ2y4+w6KwWU5tAwd
	AYkC7aMfFd7eWnSpfLCSvgnDq0SdqGhn8mPUnFKau2T8IMAfHXhcj/v6snzkcwnEiFJ/9yGAP5H
	8HCy+bDSL3BA05nkrZlfItwSqqEVlJu8ukGqTdPIrHlNXb3r56i7qx84ZTW0vspswpH5ow6rabd
	JyCSwA8GiNBxaYyNqNZv6JDC5ZOqTDZNqKFedRmG4vN/6xXeU+I5rLd8B9UajZ0xrCRHBRn2mEK
	1clzoar1krR0Mkh8qeXozzWuedhkgRlVKkj12FcJ3dyfToI2ibIDOLDrK8uFTPpoEDd2wKLa3Gg
	Tn6/2rFvJqrDYi2M0hQ==
X-Received: by 2002:adf:e00e:0:10b0:4bb:c87d:62bd with SMTP id ffacd0b85a97d-4bbc87d6304mr6603804f8f.23.1795737628291;
        Thu, 26 Nov 2026 16:00:28 -0800 (PST)
Received: from nixos-office (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a68048esm45536616f8f.29.2026.11.26.16.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 16:00:27 -0800 (PST)
Sender: Julian Braha <julian.braha@gmail.com>
From: Julian Braha <julianbraha@gmail.com>
To: nathan@kernel.org,
	nsc@kernel.org
Cc: samitolvanen@google.com,
	torvalds@linux-foundation.org,
	ljs@kernel.org,
	david.laight.linux@gmail.com,
	sashal@kernel.org,
	lzsx618@gmail.com,
	zuoan.penguin@gmail.com,
	petr.pavlu@suse.com,
	jani.nikula@intel.com,
	xur@google.com,
	sidnayyar@google.com,
	robertusdchris@gmail.com,
	acourbot@nvidia.com,
	linux-modules@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Julian Braha <julianbraha@gmail.com>
Subject: [PATCH 2/5] scripts: restore support for 64-bit pointers in host hash functions
Date: Fri, 27 Nov 2026 00:00:12 +0000
Message-ID: <20261127000015.3662267-3-julianbraha@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261127000015.3662267-1-julianbraha@gmail.com>
References: <20261127000015.3662267-1-julianbraha@gmail.com>
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This partially reverts commit f93d6bfbd2f7 ("kconfig: use hash table to
reuse expressions").

When the kernel's hash headers were copied over for host usage, hash_ptr()
was also simplified to remove the bit count parameter, with only the "fast
32bit" path in use.

With the bit count parameter restored, let's restore support for passing a
64-bit pointer to hash_ptr(), rather than truncating to 32 bits.

Like other headers in tools/, use __SIZEOF_LONG__ to check the host word
size, as opposed to the in-kernel BITS_PER_LONG.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 scripts/include/hash.h | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/scripts/include/hash.h b/scripts/include/hash.h
index ae0d3fc8d470..08e901b8a43d 100644
--- a/scripts/include/hash.h
+++ b/scripts/include/hash.h
@@ -12,17 +12,29 @@ static inline unsigned int hash_str(const char *s)
 	return hash;
 }
 
+#if __SIZEOF_LONG__ == 4
+#define hash_long(val, bits) hash_32(val, bits)
+#else
+#define hash_long(val, bits) hash_64(val, bits)
+#endif
+
 /* simplified version of functions from include/linux/hash.h */
 #define GOLDEN_RATIO_32 0x61C88647
+#define GOLDEN_RATIO_64 0x61C8864680B583EBull
 
 static inline unsigned int hash_32(unsigned int val, unsigned int bits)
 {
 	return bits ? (val * GOLDEN_RATIO_32) >> (32 - bits) : 0;
 }
 
+static inline unsigned int hash_64(unsigned long long val, unsigned int bits)
+{
+	return bits ? (val * GOLDEN_RATIO_64) >> (64 - bits) : 0;
+}
+
 static inline unsigned int hash_ptr(const void *ptr, unsigned int bits)
 {
-	return hash_32((unsigned int)(unsigned long)ptr, bits);
+	return hash_long((unsigned long)ptr, bits);
 }
 
 #endif /* HASH_H */
-- 
2.56.0

