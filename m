Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CA713957E
	for <linux-modules@vger.kernel.org>; Thu,  5 Feb 2026 14:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770302266; cv=none; b=UxsmHMi52soCXRh177P/VPesGJcuNK0dZdoCwgve2QHgF5RkSxkTEA8Gpg4TgmlJeXd7byEqlq+9uCLOMTUgqW1Gt3Celn6MqRP69NU3/Qx3YzyU9NvpoO770HEzS7y83AMiJsGni0mBAuiEM/qxyJkSvbbqSEvDMkA1WRTd78I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770302266; c=relaxed/simple;
	bh=3+I3YXJAeMJegb9I1hw4ztW66HinQyv4pQxBA83lAQY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WvNlLw7Jf56Nt+pAMcNjSfqueDOPjTC0ihVbus7CpUjLcq69hJuwb6yk9dDdO4lofbK4YoNhZgQOvWxRke/X4Flwf7ZRmGSNRHmvzdv+gqOKDceP+jCeYg4VGatZwUrhdUZKABH3J7FM+jlcwNtVZZ0NA73lINxB5fVWwz3jlBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NYJrqpiY; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NYJrqpiY"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43590777e22so652675f8f.3
        for <linux-modules@vger.kernel.org>; Thu, 05 Feb 2026 06:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770302264; x=1770907064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D1qdUtqe3EFZ3Mf4wkI+qAPVS2QnmUM27Jj1lTw5Vko=;
        b=NYJrqpiYTJpJwBLGDkMMaHEzkM3t4Cc88bnFX5Ty/yfbDAPshd5HJ5rIeJaEYsyU++
         z1isjn/JKfxToucf4bze3g07YYwYMpLsh91lwChjgiNMsF+8RtwctgrlsZIWq//oiOjX
         s9yo/DfLqfVmcf+lM68gsWcg2vcbLB0O5CxCF+oFE1YibxlINVrRZQyNpHQronxWZPqC
         O5XFFRUN6b1MGmTTbpIk0Ts08kvwbh4gdelgsTM48t8Oxj8CJW99WjHXW93CkvsiNyoC
         c+tIQvvUDbS7fjBlwWrDw55RTtgSFiBvropJxj76paIdEwUfwCoMG15SrxueEhWEB8NU
         CR1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770302264; x=1770907064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D1qdUtqe3EFZ3Mf4wkI+qAPVS2QnmUM27Jj1lTw5Vko=;
        b=DIFKpTjJt4y8P3cty/ZabQY+rtuTYg3rqUN53PzXBKvlTTf1HVdF21eGVs69hiCCl3
         knGKtOFzS3SSBsoIqocjeE17vvtiXS8A71o79tpz5hhew2ApkgAwAbD7r5V5IMX6sIP2
         NCj7yuoDQIS/dSD7SjQBDNNasXeYyIk+D0sDVst2tpCztLR3HGNhoS2fQlPidOI1If6C
         cXScUm1K0u0OMr+gM8sD+baHdQ7fLtQwCEEqE95ULq6JCpQJbE9VKXoi44E/lVAbiFVU
         Z3nmGgv5/3UJzS/NuAR1HoN2aTxNllE9OjoDZ/57YQUFzogDr3HIG/tm/G7uzQruIDgO
         WZNA==
X-Forwarded-Encrypted: i=1; AJvYcCVFYRPqXnz0fdxqOdRU1qfs/KlB6SlncgDCEriGk/ATeJFbQAw33I2Gj0GLCjty47gupgJRg9q9lCHiaN2l@vger.kernel.org
X-Gm-Message-State: AOJu0YzjI8B6ZBo+qxJQTM8lp1RtDc7FH5rqoDCcCB12VVYtpB24Vb42
	ndl9jgKBv/nqQiYvwziNlQF6jrhYUDe/PF0wr5dUXGCs6+fZI3Y9n2QnpbwftskwWmc=
X-Gm-Gg: AZuq6aIACSHoZS5XSn81CcyghSrFJJ+bH0aXBF4xgeErUsrhCx1wRzp+VO1Yam1CStS
	7aIIhFMiyKEYo1pi3p4f7PLT5zz/sBHX+iGpHkBFVpiEqO2IC/84qE3MQWk2/CElbrkJysPvJtL
	oOU7Ay9+xluQKri4cYmt38QEhXd+3WYqPuEgUp2eHEyU07H85tNz1wEFKW+QRb7wQlUM0dnJ/yG
	JasSfIOEgEU6m+D+A3/o8Iin+XNa0GFd30o7521b1S4Sgy/lQr/by24Thxh5PQeh9/thsl6bURn
	grxom9lZQoF9NVO1fxKtPC7BBHs5oS9ycjjE3LUY/hQGsa7sC/L4Pj8wqIVRsi1jYvpeeYXLCUW
	Dz3vildyDkjGY8PeJtuAYG9AsoNYOHBPIYzFclw0lDzKvjlIBfh9lu4nDVe1GEma1kSJtwy2q2h
	z/uOTr2JuPSOIpe2bczee9rJNLHNd522o=
X-Received: by 2002:adf:fc86:0:b0:436:19f9:9012 with SMTP id ffacd0b85a97d-43619f99049mr5823961f8f.9.1770302263969;
        Thu, 05 Feb 2026 06:37:43 -0800 (PST)
Received: from zovi.suse.cz (109-81-1-107.rct.o2.cz. [109.81.1.107])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43617e25cefsm15486175f8f.9.2026.02.05.06.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 06:37:43 -0800 (PST)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] module: Fix the modversions and signing submenus
Date: Thu,  5 Feb 2026 15:37:08 +0100
Message-ID: <20260205143720.423026-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The module Kconfig file contains a set of options related to "Module
versioning support" (depends on MODVERSIONS) and "Module signature
verification" (depends on MODULE_SIG). The Kconfig tool automatically
creates submenus when an entry for a symbol is followed by consecutive
items that all depend on the symbol. However, this functionality doesn't
work for the mentioned module options. The MODVERSIONS options are
interleaved with ASM_MODVERSIONS, which has no 'depends on MODVERSIONS' but
instead uses 'default HAVE_ASM_MODVERSIONS && MODVERSIONS'. Similarly, the
MODULE_SIG options are interleaved by a comment warning not to forget
signing modules with scripts/sign-file, which uses the condition 'depends
on MODULE_SIG_FORCE && !MODULE_SIG_ALL'.

The result is that the options are confusingly shown when using
a menuconfig tool, as follows:

 [*]   Module versioning support
         Module versioning implementation (genksyms (from source code))  --->
 [ ]   Extended Module Versioning Support
 [*]   Basic Module Versioning Support
 [*]   Source checksum for all modules
 [*]   Module signature verification
 [ ]     Require modules to be validly signed
 [ ]     Automatically sign all modules
       Hash algorithm to sign modules (SHA-256)  --->

Fix the issue by using if/endif to group related options together in
kernel/module/Kconfig, similarly to how the MODULE_DEBUG options are
already grouped. Note that the signing-related options depend on
'MODULE_SIG || IMA_APPRAISE_MODSIG', with the exception of
MODULE_SIG_FORCE, which is valid only for MODULE_SIG and is therefore kept
separately. For consistency, do the same for the MODULE_COMPRESS entries.
The options are then properly placed into submenus, as follows:

 [*]   Module versioning support
         Module versioning implementation (genksyms (from source code))  --->
 [ ]     Extended Module Versioning Support
 [*]     Basic Module Versioning Support
 [*]   Source checksum for all modules
 [*]   Module signature verification
 [ ]     Require modules to be validly signed
 [ ]     Automatically sign all modules
         Hash algorithm to sign modules (SHA-256)  --->

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 kernel/module/Kconfig | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
index 2a1beebf1d37..537985387ff3 100644
--- a/kernel/module/Kconfig
+++ b/kernel/module/Kconfig
@@ -169,9 +169,10 @@ config MODVERSIONS
 	  make them incompatible with the kernel you are running.  If
 	  unsure, say N.
 
+if MODVERSIONS
+
 choice
 	prompt "Module versioning implementation"
-	depends on MODVERSIONS
 	help
 	  Select the tool used to calculate symbol versions for modules.
 
@@ -206,7 +207,7 @@ endchoice
 
 config ASM_MODVERSIONS
 	bool
-	default HAVE_ASM_MODVERSIONS && MODVERSIONS
+	default HAVE_ASM_MODVERSIONS
 	help
 	  This enables module versioning for exported symbols also from
 	  assembly. This can be enabled only when the target architecture
@@ -214,7 +215,6 @@ config ASM_MODVERSIONS
 
 config EXTENDED_MODVERSIONS
 	bool "Extended Module Versioning Support"
-	depends on MODVERSIONS
 	help
 	  This enables extended MODVERSIONs support, allowing long symbol
 	  names to be versioned.
@@ -224,7 +224,6 @@ config EXTENDED_MODVERSIONS
 
 config BASIC_MODVERSIONS
 	bool "Basic Module Versioning Support"
-	depends on MODVERSIONS
 	default y
 	help
 	  This enables basic MODVERSIONS support, allowing older tools or
@@ -237,6 +236,8 @@ config BASIC_MODVERSIONS
 	  This is enabled by default when MODVERSIONS are enabled.
 	  If unsure, say Y.
 
+endif # MODVERSIONS
+
 config MODULE_SRCVERSION_ALL
 	bool "Source checksum for all modules"
 	help
@@ -277,10 +278,11 @@ config MODULE_SIG_FORCE
 	  Reject unsigned modules or signed modules for which we don't have a
 	  key.  Without this, such modules will simply taint the kernel.
 
+if MODULE_SIG || IMA_APPRAISE_MODSIG
+
 config MODULE_SIG_ALL
 	bool "Automatically sign all modules"
 	default y
-	depends on MODULE_SIG || IMA_APPRAISE_MODSIG
 	help
 	  Sign all modules during make modules_install. Without this option,
 	  modules must be signed manually, using the scripts/sign-file tool.
@@ -290,7 +292,6 @@ comment "Do not forget to sign required modules with scripts/sign-file"
 
 choice
 	prompt "Hash algorithm to sign modules"
-	depends on MODULE_SIG || IMA_APPRAISE_MODSIG
 	default MODULE_SIG_SHA512
 	help
 	  This determines which sort of hashing algorithm will be used during
@@ -331,7 +332,6 @@ endchoice
 
 config MODULE_SIG_HASH
 	string
-	depends on MODULE_SIG || IMA_APPRAISE_MODSIG
 	default "sha1" if MODULE_SIG_SHA1
 	default "sha256" if MODULE_SIG_SHA256
 	default "sha384" if MODULE_SIG_SHA384
@@ -340,6 +340,8 @@ config MODULE_SIG_HASH
 	default "sha3-384" if MODULE_SIG_SHA3_384
 	default "sha3-512" if MODULE_SIG_SHA3_512
 
+endif # MODULE_SIG || IMA_APPRAISE_MODSIG
+
 config MODULE_COMPRESS
 	bool "Module compression"
 	help
@@ -355,9 +357,10 @@ config MODULE_COMPRESS
 
 	  If unsure, say N.
 
+if MODULE_COMPRESS
+
 choice
 	prompt "Module compression type"
-	depends on MODULE_COMPRESS
 	help
 	  Choose the supported algorithm for module compression.
 
@@ -384,7 +387,6 @@ endchoice
 config MODULE_COMPRESS_ALL
 	bool "Automatically compress all modules"
 	default y
-	depends on MODULE_COMPRESS
 	help
 	  Compress all modules during 'make modules_install'.
 
@@ -394,7 +396,6 @@ config MODULE_COMPRESS_ALL
 
 config MODULE_DECOMPRESS
 	bool "Support in-kernel module decompression"
-	depends on MODULE_COMPRESS
 	select ZLIB_INFLATE if MODULE_COMPRESS_GZIP
 	select XZ_DEC if MODULE_COMPRESS_XZ
 	select ZSTD_DECOMPRESS if MODULE_COMPRESS_ZSTD
@@ -405,6 +406,8 @@ config MODULE_DECOMPRESS
 
 	  If unsure, say N.
 
+endif # MODULE_COMPRESS
+
 config MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS
 	bool "Allow loading of modules with missing namespace imports"
 	help

base-commit: 6bd9ed02871f22beb0e50690b0c3caf457104f7c
-- 
2.52.0

