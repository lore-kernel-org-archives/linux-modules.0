Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6512DE1FC
	for <linux-modules@vger.kernel.org>; Tue, 19 Aug 2025 12:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755605698; cv=none; b=h5onTKWZqt27nYlNHhyiX7fl6mAqNw6zem2o+nxOKrkuYkYb1XSX6tXAwfIjphwpjpMJmTM1RYHBO2j0wFfTOpep/9pIC8cxbr3Nw5SmEFjz5pfCdWJKLC88/PWrHBHs6otB643ikf6NE4dhXmYaybcLci0qrauqpVIf5vPjTVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755605698; c=relaxed/simple;
	bh=r3n24YkeAiFzv8X5Ud5TZiphJux1PzHKFS6EknRtIUU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mnzHvC3AVINrTVU4Td8nXTBuF8uj6k2Ay//8T60JrZ7pGxqx6UAD7pEBQ3Bs42KWN5AFbar4/0ku+3+WJykxkc87RConnqnxOEeuM3LUKF7lC6ozUtwe87uzDLrCY7WhyC2jma4l6Cd4bM2XjSxXT1zk7MKYm7S3fHlWPoGxKBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=F/88lRbz; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="F/88lRbz"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3b9edf4cf6cso4755572f8f.3
        for <linux-modules@vger.kernel.org>; Tue, 19 Aug 2025 05:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755605694; x=1756210494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cv3UADiqbQ2TvjUbAoLCvVlixqzyy4Oo4r3fQdXVk88=;
        b=F/88lRbzqKUf08vBQP/Upn2ZDki7A6PkSWxOKmFteiexffhPSHZ+L2IPcsqlGem5Ho
         e1ygf1kCwUO+9o1C+fgPO9ECX0EC5BIh2UUhaLDzZ77/eItfcOlJrONQu+5tm1PM8ReN
         ixDrKHMmpuDpu2c4arsSW2Vy1/gAFhgvfqUcy2EEO7lyAVSEGx2acM4Cwmdn87DMLxZ9
         wgq7zt01acBTRz9NFumjElO6v2Pfe0Q+m0If16+mOspgTOT1wfy48sXAIP4DTi6fdtwZ
         FxHmllIhsjghqT4v7iu3r/3rHXRPD6sjnp0eRw7NbCMKuvBQOBAyw8IPZghRN4pclm5j
         xyRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755605694; x=1756210494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cv3UADiqbQ2TvjUbAoLCvVlixqzyy4Oo4r3fQdXVk88=;
        b=fTUDxnwfercqEQflfANC0JxW9fWTdVYCZ1nzP2fgR707W2FLEZyh4cpYbRBPdAWvc4
         Kh44asfj6w3sulyVkrCYkf8c9Xy4NO4QwyuCXVnp74mrtQx+uxN0QSMBEIDs3M5vNiVp
         pkHMobxVl4rfjqJO5WFHyNpNm8cWD56BAbuVfndC8SD+n3edSpMy6zZLcz406cLnmc5N
         8wwnhIIVgEiQM6lA5hs3sHyfdVYJeSiR0ncBjSFoA9XsIP8xEkBf0X+JL36a+jR8rqqX
         IuS28cY25khjx5dT9qIEcgEurQYp/zRkBtfxBAOwlc2kNP3TXCRUFiqAXLLTJ9THs6LW
         PzcQ==
X-Gm-Message-State: AOJu0Yw3ptPxTw3O/OpnIsFc/xzJhrYTFJN8KW57VCMPmSe0zMY3JWb/
	XzZ4e01XrCchOR+Y78+0uj1jIsSKfrJTFKismO7myD4gFxVgNpZuneQIJh4C+6xa10Y=
X-Gm-Gg: ASbGncsgMx07EweeL87vFsvE3v7haL6K36pTTWMEfBoILIfF7Q2Rn783qtHBz6mY9r6
	miALJLfrEw2e/jfeW4irDOAg1bQBwlPYmhG3xFILBwX7ZlAGiAbAjuSEBpCMsdwib7WSPf1Pq1z
	L5SMzqpsq89dFj81G8rp/abKqzutDL7fRCpIJKXcim9HpiqxHP+DghRF2jk74pqKoytTa51vz94
	4KkdZP9fuYq/NfDuPmtSnMZJRdCtoiq/1nrgG0ohXIgXLYoZV38mOEnZFyJCHB3Jxhe8LCn7Yk2
	M2geVEPnxYCvt6RZeVVNRyzmw3ZPNVUB0q29ZISfzn3JQAoSPPisfwt0LaJCGvR1Wot2rnZkiGt
	OTjNglKzgXKDyjLNonycWHxXhOMQzIdmrw77YoQs=
X-Google-Smtp-Source: AGHT+IE/kD7//F1ivwBIkItT7/N13kE12xwZismDvDilF7dG6FebLdN4vgvroAj3YGiVbETZjeg3Ug==
X-Received: by 2002:a05:6000:26cc:b0:3b6:936:976c with SMTP id ffacd0b85a97d-3c0e2c89f54mr1719672f8f.17.1755605694332;
        Tue, 19 Aug 2025 05:14:54 -0700 (PDT)
Received: from zovi.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446cb0735csm107977765ad.57.2025.08.19.05.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 05:14:53 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] module: Remove unused __INIT*_OR_MODULE macros
Date: Tue, 19 Aug 2025 14:13:37 +0200
Message-ID: <20250819121423.460156-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the __INIT_OR_MODULE, __INITDATA_OR_MODULE and
__INITRODATA_OR_MODULE macros. These were introduced in commit 8b5a10fc6fd0
("x86: properly annotate alternatives.c"). Only __INITRODATA_OR_MODULE was
ever used, in arch/x86/kernel/alternative.c. In 2011, commit dc326fca2b64
("x86, cpu: Clean up and unify the NOP selection infrastructure") removed
this usage.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 include/linux/module.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 3319a5269d28..e9e6eeb042aa 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -151,16 +151,10 @@ extern void cleanup_module(void);
 #define __init_or_module
 #define __initdata_or_module
 #define __initconst_or_module
-#define __INIT_OR_MODULE	.text
-#define __INITDATA_OR_MODULE	.data
-#define __INITRODATA_OR_MODULE	.section ".rodata","a",%progbits
 #else
 #define __init_or_module __init
 #define __initdata_or_module __initdata
 #define __initconst_or_module __initconst
-#define __INIT_OR_MODULE __INIT
-#define __INITDATA_OR_MODULE __INITDATA
-#define __INITRODATA_OR_MODULE __INITRODATA
 #endif /*CONFIG_MODULES*/
 
 struct module_kobject *lookup_or_create_module_kobject(const char *name);

base-commit: be48bcf004f9d0c9207ff21d0edb3b42f253829e
-- 
2.50.1

