Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030BD3B9930
	for <linux-modules@vger.kernel.org>; Wed,  8 Jul 2026 02:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783477139; cv=none; b=GdDBlQiuCV0m2gtd9L0e0sV2yPFy5COk7hZdo6muN3m9NBEUXCIHB9csnsBFFvj9wrbXUgstDe2D/DCW5hF8rr3HMD5Gx8gH79eLLkN3dI9IbVCPlL4CaAE1I5Y6GkJ1xT1N77s/rqM1OGpd96cjqwZ8m/eGGDjgSou0RO5UsQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783477139; c=relaxed/simple;
	bh=PPomXDqOPZZDfNdm43tbxaOgsUnHx8T5uRdXvuxBFp4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ikM9Yg1vBmFRZ4H5p7Y325y+GbWEP9oeHl8uEzaymccvvgEzfDDe9Ujr4lnIKubk7CZuFysluGb74nWFnRiD309K2bmAI9abqCCI/yOS7aTGiv4tlm/29OZlC4V+6arTdfQ9vSRk7o8UDz7XE5LkHF6kF8d/TtDlZb12OCHdQSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hVcQCqHk; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVcQCqHk"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4a071495be0so150375b6e.0
        for <linux-modules@vger.kernel.org>; Tue, 07 Jul 2026 19:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783477135; x=1784081935; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pHdFR6BhJ4eiUKTqpuGaMPESoaVdVadkoTnW9J/lC14=;
        b=hVcQCqHkjg+ylXYNXQXcdtjptzUxayS2bzUkyOKEquojydE3GpCLn+rfSzO0mvMmCR
         b47oY9N8lbKLptPrUreD3HFmw4vCMia6CfD3R8oodx7NpSaJX5ol1p4d2E8RTTH/LCGA
         zzgJZ+jXNAu1TwJRwHVdzV0/p1X3KeIikkIr3+xeMc0tMfjCXjydKqIkc/w9mFsu9Sqb
         ywgiOwKp3O/ODV17B9Au3lBQEKiDyXWcbmE64ddC/X25EhuEbqTCd4M3h72yizPOXIpr
         cTSuw+TEl7HvrHPnxKHZVVH3DKaRzSgHtvTdV5VO3qb2k2xK/Tdt5AoKdIlFHtn2Q/MI
         X6Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783477135; x=1784081935;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pHdFR6BhJ4eiUKTqpuGaMPESoaVdVadkoTnW9J/lC14=;
        b=Ardl/MuGDy61S7l6ebZyXwlKlsZtDfXfc+8HHiYa1vt6LDmzqj41NFD7Qoul+M2J49
         NMXv7aOsla1nKlZDMf7j9plCwhZ6PXEsSl1VJaT9bF5rfuzRPAjAtXjmPTuk0/bdPxXc
         Zbx84W0hFFR660ADU0TOg/q7nF1Zv/j65ER5VEr52J7nPNAXWShEkIxOAUa/POc4L4/x
         77WzeeFVrrD/6B9lXVycXYJWO8F2twwoc34tiSpcbvnvs6pBWsztRwRXKdTQ7p+p7gEk
         0n7Cf5tjL7aMQ9rHHL/WRMy9tLgKpZhwifnf3Y2UBFppPzlkJ9RTHgECGv0N4zDT0UYN
         lEkw==
X-Forwarded-Encrypted: i=1; AFNElJ+91AxICzsA20btKw+jSUGWsovr+8inA/Ige7cnpDrZOPr7c7rDQj1XAuuMqTAcbP2t58rDHpXRIBaqeAaI@vger.kernel.org
X-Gm-Message-State: AOJu0YxFhq0Mv5LqeYVCLXJsz5T+s4fA4QayjfmxmZCPR6/sJSXEoyVi
	sdlBpEMgZQW3sAvXU3ibjHdAqhWDS8CAd78c37hOHo+KnqVMvRukc2v1
X-Gm-Gg: AfdE7ckMZkH9BHS/XL8uVQVh8LtAFpo1xuLviOKja0ZGr0mqNovx7zcsCxzdF2XqO0t
	xa5aUgz4ncH0uWjJBXy42bp7wTbfLXBnENzOcHAFZyquYmNQTkLCF+okSa7r1eaTVaHjqS52Ah1
	LdCX5Ge2gIbPNHGeV+CtErtZLfhYjmEkfGo4IvJZJU+nTb4EKkPXNG39XbjX3k1BW5KV1Fo3/0F
	6N+r8MoxFuQhVo8PMT+JMR13RGLgAZQB1Z9SITsHtd22Ws2JGQT0lVZHGm0P/DVV5CzqN3/IjSX
	cVBmKsW+12uIMt7N7nVnAxMtuLOeFOcHByxwwJi5drfxn0dIDGU0EzxOWVPM6bWZUtjcATwbVgv
	79zyIIpvqjaDIc+8nA1cO+D+LEfh0bIXMWhJNOz9s72G/YMg4X5lC6DFzo75GAm7Yce1VObZmI6
	5c/OlUGTuYB4kfKhEfh5Ewr3oQcloBYsAiuTA4zpeyYvy+WRin2a3YxRHvUtrSmg==
X-Received: by 2002:a05:6808:320e:b0:495:eb9f:53c4 with SMTP id 5614622812f47-4a2023143a5mr371501b6e.9.1783477135614;
        Tue, 07 Jul 2026 19:18:55 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-4a1aa006f74sm799975b6e.0.2026.07.07.19.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 19:18:54 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 07 Jul 2026 20:18:16 -0600
Subject: [PATCH v6 16/24] dyndbg: tighten fn-sig of
 ddebug_apply_class_bitmap
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-dd-maint-2-v6-16-381f3edb0045@gmail.com>
References: <20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com>
In-Reply-To: <20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783477102; l=2913;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=PPomXDqOPZZDfNdm43tbxaOgsUnHx8T5uRdXvuxBFp4=;
 b=CIr8KuxqpMOHsAfVjd2PFFNWeCo8/hjQ5nOwJ+0lMU9uKP5hmdjYMw/MtKkedGI69KPkPmNQK
 JOhoXQzKoBnDMud5UhPktl0b/rz+onEomJ7YEpnrospkJKIN+8/VBcL
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
2.55.0

