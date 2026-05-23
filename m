Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC78D34B1AD
	for <linux-modules@vger.kernel.org>; Sat, 23 May 2026 07:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779520523; cv=none; b=TqSoq7G3HkgnET0+AeAel4oJCdKFKeS/X9VY3+fyLUxEkL/Wy742WfJSYPiUkhR5MblkqTi2RZOsjmVKXhBPxKgOsA2WMTZo1Fej0nlwsoPi/Jh7e7dOQGop/lO5zs20fGBiUuuW2vPE5Y00fRgQUedUCYPcSvpe69aFaZsZjyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779520523; c=relaxed/simple;
	bh=rOksOAhaWphEcgDsCZEZduEgXwfTtl68VUCgxNPY7/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V0m8+4aasKEEdVb58ojAQPqBp8QcTmboK54ngPoX4wT+Z0k2J7ychpeLA+C1QCjsk7nwLr9cbvmp9EIggynMLe/AMG0cWMxEZmYWbAb2SzpTqWOgW34H+CmiTdw9IXOEo3zLr5igHv4KlbSmcUyLAX7I7vJ2KQmneJBWnD3IKk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QLotZ37J; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QLotZ37J"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4526a8170ceso4024403f8f.2
        for <linux-modules@vger.kernel.org>; Sat, 23 May 2026 00:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779520516; x=1780125316; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kcnaLfaQGctlS33zvErx78bjZPUMxYDde02HXus0bGY=;
        b=QLotZ37J11STgwaAiHh56BoyvTARohcxUqM37DfmdE35eUkT2sjjQZtzfh0CxDZK62
         CY3xksaw8x+q26nNcnhvkU/Cag5f3IzXTr1DX3N4v7v9vLf+ju1O6KB8O4U7QCH82ENF
         1XT/nBKP3MxlqXV/lWgsXM9MEyN64KFS/lEhv353u0pC3AgCGJgVDhYqfCfmm6OWPAfK
         BZ29hK33glyV4VvQIq28/sMidYS43gFQzVymq59LycYey/G110wCxCmVYL5X8So61J8P
         TpJTb52HLtL+P8kOnTDP33xEnJgZzMtZlQG4HCPPBRbOCi3Oo+zuZYX/k6Xay30dlFnI
         WJWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779520516; x=1780125316;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kcnaLfaQGctlS33zvErx78bjZPUMxYDde02HXus0bGY=;
        b=KAHMKiFdYw76wxQkW5CXOz28WwTAJbUMwtj67N5/TBBAATD3spUWxMtkwfmQnKajlS
         E75gMGtTheyfgNH4CRsGhzBn0zGmePWjHwMI1YEZDCaKPgS9CF3sH6zoC2Dw7a4Mn9Cp
         jc9TlUbZY8sGm6p60sdQdE0gUGDtITn1aNYvEHOlVltUFPeq4z6GRTAPSS+d8plCKdWR
         ZEQGnSMUKiH7Fecx9hSjoaB4HwTCBoFGFCthup7S/jyfdtTpM8W9PXVBTatmjZ35Gs23
         FsqHX1kOXxpIDD7GZmizU/NQxqzQRcVTRGK1bzogc3gEl+4TEt1n/o/IjcjupDU3a3hv
         GxTA==
X-Forwarded-Encrypted: i=1; AFNElJ9qpA/1unJbbHOPvZSArJLQMyXaSPUEYWa/lryQCFD4o0B7hkqre2h4k0Vn4KC0xXp9ty2CNkprxKf1RsUM@vger.kernel.org
X-Gm-Message-State: AOJu0YzytxE2wQRg0xwxzg2Ptoex9ry/EEyBljr6VaYH5fNgZ+U5GuQK
	xmSfcpT1nkcjl2N5ApLIFXQCImMXflbb8eEs6fe0W2yw3yNDoWoLHNxWN86XATQ63Ls=
X-Gm-Gg: Acq92OHlMTIzXtXlB+5EbeOl/jwNxUr0BZ6QB9yxTnCZHdh5Ui1ewFc9RDrgD3ga4MS
	L0334wtONDU2eiCEYCjK4E5OidmmozfiOBGTJpDwEuu11t1TFLRuj6QT9RM+/UuTqBoMzUMgokb
	MTK8WtU6Lk+rXBIIIbip4hGzN+YIIHrtSqHQ8dsjVTl5ImKdVDXr4WTwSKwdRTUV8EwAMqX+3vF
	0FZ16A57KC/XJ5xpSOImyfx5OebLLXCmMHu6MYv7WiElX9OdxBu9myhH86VmE8e8dV8QQCUWtu8
	FUHCJeLyGPWEciktPdqHmsd57/8F/8CyBsAPxotyLTkyBl0NM4ahPgyPRE5+ONuMfZVyJygtVtC
	OjDLAA0auZgU/QdopvDamjnqhKZyY13uK5Dt8Fy01tu5AJrd2FaZI7fsx7mV31XJ5slMxOrN2Q0
	BuHPOdx+7bxs6/WdAe4t1KA4RKq8T8
X-Received: by 2002:a05:6000:1ace:b0:45e:9417:556f with SMTP id ffacd0b85a97d-45eb38c679fmr10298303f8f.39.1779520516325;
        Sat, 23 May 2026 00:15:16 -0700 (PDT)
Received: from [192.168.0.174] ([31.96.183.250])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-45eb6d5cb76sm8639838f8f.25.2026.05.23.00.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 00:15:15 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Sat, 23 May 2026 01:14:45 -0600
Subject: [PATCH v2 12/24] dyndbg: drop NUM_TYPE_ARGS
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260523-dd-maint-2-v2-12-b937312aa083@gmail.com>
References: <20260523-dd-maint-2-v2-0-b937312aa083@gmail.com>
In-Reply-To: <20260523-dd-maint-2-v2-0-b937312aa083@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
 Jason Baron <jbaron@akamai.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779520485; l=1439;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=rOksOAhaWphEcgDsCZEZduEgXwfTtl68VUCgxNPY7/c=;
 b=IMkDxWEEMSyVXwT4wwtQxotcBdIkVon/BYyg9V3iMJcUkveV+jlKy9k+DfRHSnUkHdLpkLm0O
 gslJgQJjRPlCsYxqB/1ZQBFCoQdKro1LQI2q09sXEIk8n+4Le5VrzBd
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

ARRAY_SIZE works here, since array decl is complete.

no functional change

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
v2: include linux/array_size.h, correct commit subject
    review after sob
---
 include/linux/dynamic_debug.h | 4 +---
 lib/dynamic_debug.c           | 1 +
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index aa45dcf36a44..e724f6b93663 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -121,11 +121,9 @@ struct ddebug_class_param {
 		.mod_name = KBUILD_MODNAME,				\
 		.base = _base,						\
 		.map_type = _maptype,					\
-		.length = NUM_TYPE_ARGS(char*, __VA_ARGS__),		\
+		.length = ARRAY_SIZE(_var##_classnames),		\
 		.class_names = _var##_classnames,			\
 	}
-#define NUM_TYPE_ARGS(eltype, ...)				\
-	(sizeof((eltype[]) {__VA_ARGS__}) / sizeof(eltype))
 
 extern __printf(2, 3)
 void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...);
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 0377d9f8dcd1..6d9dbeb68ae8 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -13,6 +13,7 @@
 
 #define pr_fmt(fmt) "dyndbg: " fmt
 
+#include <linux/array_size.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>

-- 
2.54.0

