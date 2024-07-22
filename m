Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D6C16B389
	for <linux-modules@vger.kernel.org>; Mon, 22 Jul 2024 09:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721639236; cv=none; b=E2uOBE9SKgoOQM6eZEVf+lrEy/3hVoI847cmdV0BrW0pVlAOuHhlPDY4apHiPPivljveGMXZXTr1oMowqkKxiWVxDX2uS7rulj79Pe2HH4aENUxqYqGAMztd4zz55PxrAaQwX59oXmWz4lf7BWqoKMC34FsXJa4m6KZJi5nfZrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721639236; c=relaxed/simple;
	bh=J9TwGknNWjs/N9deiPaq5k+uLL6PXCMwbiv/oe6XZ94=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YWrRKYFrMn77K8fFB9QFQu2qJ+YTZXXctKa+pAc++IIODXSltQpHVmpod3CQfurdQ8hRyLgkkfAOrVhIdUbXCoEwu181Eb4uvMg80psnsX5/WF7Cspcz45kNcRnsJmsM5/MClS/ehKc8WZ04aPFn/OLPcZ+CdQIlztuPAP539Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HQ10Z+bS; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HQ10Z+bS"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2eeb1051360so40753341fa.0
        for <linux-modules@vger.kernel.org>; Mon, 22 Jul 2024 02:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721639233; x=1722244033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/F0ZmP17hObUGx93Q7otIls3wWDQaOtJ+irX03aguA=;
        b=HQ10Z+bSAbtFT8HdmzvO55SF5l1Z8FImaPwOkvWAp0fuUGZyJrCoPh/UAS3ddbrqks
         Ob9MxFSHD7y0wEvPO20Iq7SmYsd4m+LSqv74tJ7AjA3v1oSGSIC4FlmDCLQ7hyAVhAyI
         l0b0JnQZl0+eDnE1aJhZbcjJcQ0NkoQAFy45fIA0Rt4HSzxPJZnrYCE/C6BU0e6Ek7Zs
         J9CeOoOcLiTO3gT3DlFqYJGKwtZsf2WuIdbQOqYubBTjuuH5AnZCjxklL+TKSrOe5w83
         iSQoBR7YKhuXgFwPCBkpSO5v0m81jLdzshjBXoc1fSA/Q4lCLaYhCURTEoo9sM67O6dA
         9vIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721639233; x=1722244033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t/F0ZmP17hObUGx93Q7otIls3wWDQaOtJ+irX03aguA=;
        b=e9lhbtMuqaX5ydFZ7kQitvNDn2txZtXFYn1l5PmaCP/rRMAAML4dEos7z6ACgBp0/s
         LN8iuK8fTaqDglJHIuLS/ZT9GHISjnnWJLvvr5mrs4Gs3OQp7OCZi5wvQz6lO4KHVO3q
         LM0StsPddfAWYrzVox9b4NRH4eo1d5xSbQO4YoxEJ/4rUB3fTbiJiRh0aChQBUkSjS7Q
         2bWMAOXR2XIg/OQIbkKiSgi9Lzo+rJJncrhHogA9WOeL1ueq98EZLts0AhOLQPBnuB9G
         ePclJjI7mHuCiIRNmfd7Gd7vd2tCc/lsm8TqxeZGLl/o9h1CzhcgEHC2s2/Djv6YUzuq
         bOrw==
X-Forwarded-Encrypted: i=1; AJvYcCUjNNfQmuhWPmlD8dLDamn4HT/s+A1YzUFTdAxMfzJ0lN1C9eOcVnb0+3TEvPD36bTHvdyEv1+UbpQhrls8Egb8vqyiEObc3ZPUGM8bXg==
X-Gm-Message-State: AOJu0YxeA9jn+gyt+q56mnuDtBGcyQmKTgDUSdDFhYxZnXlXs8bkRdq1
	jZMM9dcSUiP1z/5zM9Aw9cqSShDhaUPCgxfnRqWc9hY+sl9pZUCSIdhs1hSJDrQ=
X-Google-Smtp-Source: AGHT+IFCPNC5SoKT5EINogEfHSqyN/UbbcWJnoEmhmIjj22SyV1kqmShS7JNJ5O4PLkhW1QWWrFjrg==
X-Received: by 2002:a2e:8789:0:b0:2ef:2d8b:7cdb with SMTP id 38308e7fff4ca-2ef2d8b7ea9mr21511281fa.22.1721639233272;
        Mon, 22 Jul 2024 02:07:13 -0700 (PDT)
Received: from dhcp161.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cb7753abeasm7534290a91.48.2024.07.22.02.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 02:07:12 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-modules@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH 2/2] module: Clean up the description of MODULE_SIG_<type>
Date: Mon, 22 Jul 2024 11:06:22 +0200
Message-Id: <20240722090622.16524-3-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240722090622.16524-1-petr.pavlu@suse.com>
References: <20240722090622.16524-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MODULE_SIG_<type> config choice has an inconsistent prompt styled as
a question and lengthy option names.

Simplify the prompt and option names to be consistent with other module
options.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 kernel/module/Kconfig | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
index bb7f7930fef6..ccdbd1bc12aa 100644
--- a/kernel/module/Kconfig
+++ b/kernel/module/Kconfig
@@ -228,7 +228,7 @@ comment "Do not forget to sign required modules with scripts/sign-file"
 	depends on MODULE_SIG_FORCE && !MODULE_SIG_ALL
 
 choice
-	prompt "Which hash algorithm should modules be signed with?"
+	prompt "Hash algorithm to sign modules"
 	depends on MODULE_SIG || IMA_APPRAISE_MODSIG
 	help
 	  This determines which sort of hashing algorithm will be used during
@@ -238,31 +238,31 @@ choice
 	  the signature on that module.
 
 config MODULE_SIG_SHA1
-	bool "Sign modules with SHA-1"
+	bool "SHA-1"
 	select CRYPTO_SHA1
 
 config MODULE_SIG_SHA256
-	bool "Sign modules with SHA-256"
+	bool "SHA-256"
 	select CRYPTO_SHA256
 
 config MODULE_SIG_SHA384
-	bool "Sign modules with SHA-384"
+	bool "SHA-384"
 	select CRYPTO_SHA512
 
 config MODULE_SIG_SHA512
-	bool "Sign modules with SHA-512"
+	bool "SHA-512"
 	select CRYPTO_SHA512
 
 config MODULE_SIG_SHA3_256
-	bool "Sign modules with SHA3-256"
+	bool "SHA3-256"
 	select CRYPTO_SHA3
 
 config MODULE_SIG_SHA3_384
-	bool "Sign modules with SHA3-384"
+	bool "SHA3-384"
 	select CRYPTO_SHA3
 
 config MODULE_SIG_SHA3_512
-	bool "Sign modules with SHA3-512"
+	bool "SHA3-512"
 	select CRYPTO_SHA3
 
 endchoice
-- 
2.35.3

