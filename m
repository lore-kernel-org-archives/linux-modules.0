Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E293A9635
	for <linux-modules@vger.kernel.org>; Thu,  2 Jul 2026 16:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010499; cv=none; b=kp7hT/5aJc7HKW3kv2jun75Yzdk24CwiQoTF7agD7hzGPPWWyQnjDsV5kIACxQ7ki2HzMhICZ4je1NpKg7giyjy9bvFtycwNwELmrcmySH5LrpVJv4+iBP5/mBGjHjiYfGO8ctm6Qnw/T9IbtRWv4Ng1ZzbdW6tJM8oVdmoe4uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010499; c=relaxed/simple;
	bh=DkA2pTZNQqVs9Nrf7TD5N2m0l0e3VhiWsrxu2lYAwiU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RSXSGu1db7cxUPK8bWsfyAnrdo0VUj7y0rCaN+R1jYG7+bAcpHdJK4qKuo6DKmzKC25Eh1LS86Ag7YgjFGPdZSbp94T/lMx+wsLvcPHoTIZJ/m4F7njc7SNhhxm1WMBII2iCbDrL4s6qi56OLEIxpO1wx7R8wd4Ro4WjNndj7NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ck9EjMWR; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ck9EjMWR"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-44cb057311bso986823fac.0
        for <linux-modules@vger.kernel.org>; Thu, 02 Jul 2026 09:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783010491; x=1783615291; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Erf+9mXLsSsdoKA6DDUH191uMINCSbpojgzEHl3ic+4=;
        b=ck9EjMWRHwKsQJZXO8/AXxJ/O6/F9axpvFpJbW7hLkJAA1iNffiampm4jm+tYc4fnj
         vJ/bKsAXAmXOVNDRu99e8CcgHPl1qX1v6AXmgG1EQkttJfiQoy65mwAVquba8MyI57jX
         0dmB6DEvQbxepauj0iSQgT6GwK92wJw67WkauCrIUjcimTaQ8uQfyqzx8yiMhzU7x+21
         ZedCnFGl2SvOK9riLJIJE3MQVWE8abw12Lm6aOk7nr8dc3SjvSCithFKuqDrXQSQ5IGT
         /lrXbWRxrR0kvkYFJA3a831CaQHyOsnzkRNoWRQ+0SiBus5Vt/u4j0HelV86fT2YaWb1
         0HEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783010491; x=1783615291;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Erf+9mXLsSsdoKA6DDUH191uMINCSbpojgzEHl3ic+4=;
        b=eSzVPq2zoqUnE69F2jouVDTiJiX2CL0+SGwpQkObr/eRwNp99MV6LbLC6VThhzJ5zi
         Zisteu++aFy2fYm70d2Wa11xNj3N81JT8dfV1+lzf9EdzQbybtVCya4DOe/hcs5Ldr1F
         pz7IvXRTX7GDznLctW77x7HvJDdm+jF9vNWSNZtZQTL27e/dHgXfhQQq1UTYevNaEtJ/
         h41IxR6WXFiR7wd5QOpaTijzCKjqqVeXQzdaB9Ob3FoTnZZp4q439E5dP/RFrcvtvBS2
         DLzUORCAJzxGKC3b4zDfyjDDOHeImNHs1Ikt+S7mTsjFV8FEJwhxymEkwOWzXTM4onB2
         eUiw==
X-Forwarded-Encrypted: i=1; AHgh+Rqo/YdldZ8q7PI/XouOWJD4o8ejp1VnaagL6M51EdMOU7Fj0zY/JFqJo+XY6ueIYsVXVID6M+tM7WgMIQS6@vger.kernel.org
X-Gm-Message-State: AOJu0YwdIGLUD+PWE9pYU0c2f/vdngWlzoFmUkhKVhF8isuBH+9MeZaK
	i2AvJ1UQ5UmJR4tTlDUmoYfY37CIWZzrSYL2RFHK1d/Cpn04ah3whU3q
X-Gm-Gg: AfdE7cmdUuMCBJnio7IrmHGd5apy3mIkykgImISM7bJmCzIyn/Ucde/9MgO3NZzvLgV
	i4r/CxQc+AtYAQK6pp2HwuzLRBCg42Yzlgh6eFBIXgvYYsuiljho9Z/+0sSJtDoQdTwxOoSAKCF
	GZttwjCZa0qqAbUkylCD0t3Ndctw/krbM9fCQ/O+qD2jc3dijGQzsUuyuzA61n/mMJo3Oprxney
	Zdl5byXssKR1+xv/d8esIhNfRGhhzdRrW+8NuVXZ3+B9kKxqVsDkTfr6BBaQq+YbY8iKmAVDECH
	o4wDkUZCDgqBeojOul7/m0XT7gEcTdF2Vl/55cAZ4IQQRTHmu9SWP2lC8V0p/KLKsaHwlUjFH0X
	cJs7z0KZCMvh4A8y8ju+OSfk7ehAVXAMjMMKtPNfUBoEZV7Cm+9freSVWQ0DJL1muXQ3X6JeuYr
	hk0S7GrXhCxAYep7mQcVIPyjE2sDlpEQrsIluCP1Ca2Zw+oloYkZg=
X-Received: by 2002:a05:6870:e0d2:b0:44c:a364:fea8 with SMTP id 586e51a60fabf-44cabc88b37mr3590704fac.41.1783010491169;
        Thu, 02 Jul 2026 09:41:31 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-44cbec93702sm3189652fac.12.2026.07.02.09.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 09:41:30 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Thu, 02 Jul 2026 10:41:03 -0600
Subject: [PATCH v5 11/18] dyndbg: tighten fn-sig of
 ddebug_apply_class_bitmap
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-dd-maint-2-v5-11-24f22b052bf2@gmail.com>
References: <20260702-dd-maint-2-v5-0-24f22b052bf2@gmail.com>
In-Reply-To: <20260702-dd-maint-2-v5-0-24f22b052bf2@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783010473; l=2913;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=DkA2pTZNQqVs9Nrf7TD5N2m0l0e3VhiWsrxu2lYAwiU=;
 b=8qVdQFuygCFOI55ytb23VvBu9ZTlSpFhxL0vul4wxXXXDard415mjlNzyLE9vOheQ5VjLSith
 GgQNUK30WNDBHOz/OQHVK/eeYsBfjNOG8IDQcKcLTTIGM/82SHFKPQw
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

old_bits arg is currently a pointer to the input bits, but this could
allow inadvertent changes to the input by the fn.  Disallow this.
And constify new_bits while here.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
v2: move RvB after SoB
---
 lib/dynamic_debug.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 0fc9cd14e2d2..8c3b29904346 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -617,7 +617,8 @@ static int ddebug_exec_queries(char *query, const char *modname)
 
 /* apply a new class-param setting */
 static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
-				     unsigned long *new_bits, unsigned long *old_bits,
+				     const unsigned long *new_bits,
+				     const unsigned long old_bits,
 				     const char *query_modname)
 {
 #define QUERY_SIZE 128
@@ -626,12 +627,12 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 	int matches = 0;
 	int bi, ct;
 
-	if (*new_bits != *old_bits)
+	if (*new_bits != old_bits)
 		v2pr_info("apply bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
-			  *old_bits, query_modname ?: "'*'");
+			  old_bits, query_modname ?: "'*'");
 
 	for (bi = 0; bi < map->length; bi++) {
-		if (test_bit(bi, new_bits) == test_bit(bi, old_bits))
+		if (test_bit(bi, new_bits) == test_bit(bi, &old_bits))
 			continue;
 
 		snprintf(query, QUERY_SIZE, "class %s %c%s", map->class_names[bi],
@@ -643,9 +644,9 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 		v2pr_info("bit_%d: %d matches on class: %s -> 0x%lx\n", bi,
 			  ct, map->class_names[bi], *new_bits);
 	}
-	if (*new_bits != *old_bits)
+	if (*new_bits != old_bits)
 		v2pr_info("applied bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
-			  *old_bits, query_modname ?: "'*'");
+			  old_bits, query_modname ?: "'*'");
 
 	return matches;
 }
@@ -693,7 +694,7 @@ static int param_set_dyndbg_module_classes(const char *instr,
 			inrep &= CLASSMAP_BITMASK(map->length);
 		}
 		v2pr_info("bits:0x%lx > %s.%s\n", inrep, mod_name ?: "*", KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &inrep, dcp->bits, mod_name);
+		totct += ddebug_apply_class_bitmap(dcp, &inrep, *dcp->bits, mod_name);
 		*dcp->bits = inrep;
 		break;
 	case DD_CLASS_TYPE_LEVEL_NUM:
@@ -706,7 +707,7 @@ static int param_set_dyndbg_module_classes(const char *instr,
 		old_bits = CLASSMAP_BITMASK(*dcp->lvl);
 		new_bits = CLASSMAP_BITMASK(inrep);
 		v2pr_info("lvl:%ld bits:0x%lx > %s\n", inrep, new_bits, KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &new_bits, &old_bits, mod_name);
+		totct += ddebug_apply_class_bitmap(dcp, &new_bits, old_bits, mod_name);
 		*dcp->lvl = inrep;
 		break;
 	default:

-- 
2.54.0

