Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C415C360ECB
	for <linux-modules@vger.kernel.org>; Sat, 23 May 2026 07:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779520536; cv=none; b=hzlwMCUadxtsHVO8l3xosU6XdiyKFJCILIWN4/L7gOdHXWLCC+G5d5sV3yV7BoNbeQr2hLfSlqrPZkVn3UD8aKh+FROZYUusU8KnfC+8LD+V16Z5zz17i/Yi7BkDSBk92WUIgY7MpT2cPHXZv0j+M8WrkZ/OIGcu3AC4SbI9YRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779520536; c=relaxed/simple;
	bh=OzV7Wj7oJumeYJuXzDM4oh65TQwzCkr22zEagik33WM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g3uKOKM5fXTV/IyNJAT3CEl587Z253A8q6S6qecaKFbTOxS4h9goyiZDspsoLFzyiR3bnD18xBT5KOeyo4nI2O/vpHXIlRGVV3HFAsyW4vSaZIUcgxrR0eB9NKaOvdePCaulvNnaXZukqyk5cHrNOTwUuX7tJK/8aHo8vXYCsl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFLLWlXt; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFLLWlXt"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43eb05b1875so4419088f8f.3
        for <linux-modules@vger.kernel.org>; Sat, 23 May 2026 00:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779520532; x=1780125332; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eCuMXDkXIzjpCTc97wh1wqHbLxz3MXCZGl5F5Zzn1NY=;
        b=FFLLWlXt4KtaWdZc/ib2+yFfxPsnFCmx5w22RpX3KWrGCVZa4dmuk4oahNTVoHvy2q
         GMOGPdSm9QqjQ9DqfLTK6sZKYR0JVEk3re8MTMWIvBsm/8so0mYzJkRtyztO6M3kLDX+
         1ezugcIsr9ifUKOGlz31WLnJg+R1Dyro+lMnciFGdjHBo8spx7ZZcl9LqYGjdOJYAYxg
         yP7l8tPF92U1wE2uRdfkJ5WNVA5+zm+tQZT7ldqMT1xGseI1NLfEC5tne1UiXhuKhMd2
         IhdTSvvIT69uAJ+NqJgO2VekBDNnC+iBOGO1UQy0icC1YyrlNmcPAuHuSooWPCoQo0v8
         wWqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779520532; x=1780125332;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eCuMXDkXIzjpCTc97wh1wqHbLxz3MXCZGl5F5Zzn1NY=;
        b=GuS8MKhH6JQK6Or2lTb8qsT+jYq7L1souI30FOJYk4bL8/tE0sOF0bgHigV+IcoEI8
         xCGBP1WXQr8VYKYVtW5xPNTivDRkHQw5gsFQ26Q2mxerU9Q3sv5Jf6gC9o4zatZl1qup
         FXgpmwjXgbqNcOBnck7qJcGybg8iTYnXj9SpSd8KZxeE+WGwJHOWmMJL9nUTXZx/2oV+
         HJqUypeUSSei5YRavaURv0G6z3rQVYkksQMFkvAwPAfOackAe7hc334Q1p+boLGHTMNR
         4MasoKhLHzUHoJu95fOzL2QtgD76H0HrmPZ17WfkzmuVgazZxPUChYmSEHgPFN7DIHIf
         cLXQ==
X-Forwarded-Encrypted: i=1; AFNElJ+ReLlVylT2U7buCSnGcz0CbIE3qu1wjuVrQdD4r4mB7tV4kWMnLksmBQVY0X0HQwED4a1d0FPIVydJo4eC@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz27kKL3Ro5XyuTBjKP6nEBTChhtk3aC00lvrjIpdXZ+hslk48
	VgAQ6OzcF8fR90TLD5Gsx+pThqnNPIAUT3TsL8y9fZXQiCvEHemJHiXUAlWc+XYS5QQ=
X-Gm-Gg: Acq92OEx2TeRDjKYLF+XEJtNSeMtjS66SbHa/UqMi+GppLSsdpRkUm7BKiwdPH/YS5I
	ZAL/GDjhrizzjSSUyY3XiPH5jutA6tg/0PjHWVwQF/pPNcQ1dhIroMKQ2i/o+IPdB63b361hyqE
	1sKvPGkTSDWXBHm+/u8jL1cQLlpSAFFetrBncQK6wpFVGdVKhEIDLjAe2KX8u/NhqvnJtmjRGHA
	+kM83reTaZLcypz1ogV8BUAxwpxB3x86YP08pMg8tjjFXm+r7TNFOzoaP1ayJctYEzfNvo5ydVE
	VvwNZhU2DeFWpQyItjlaB9lNyQb5BwmzryvEJGi00hh3mhbua+vyRXdgkEB+DNtmFEJBVTgOKqk
	LenvOSQIZAoPHqRwKNL9ocVSjWKDMK4wooB2CRbFNQRrjR4pbWf8058npy3JgVfQY43reb/OGkM
	rN26ltBViaSRaQAo9kho2WBSO5ZwT9
X-Received: by 2002:a05:6000:178c:b0:43d:6f0f:32fe with SMTP id ffacd0b85a97d-45eb38b86demr11280922f8f.31.1779520532028;
        Sat, 23 May 2026 00:15:32 -0700 (PDT)
Received: from [192.168.0.174] ([31.96.183.250])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-45eb6d5cb76sm8639838f8f.25.2026.05.23.00.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 00:15:31 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Sat, 23 May 2026 01:14:51 -0600
Subject: [PATCH v2 18/24] dyndbg: Upgrade class param storage to u64 for
 64-bit classmaps
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260523-dd-maint-2-v2-18-b937312aa083@gmail.com>
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
 linux-kselftest@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779520485; l=6869;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=OzV7Wj7oJumeYJuXzDM4oh65TQwzCkr22zEagik33WM=;
 b=LP638XLB1aeVh+3q5CiEQF4ZWen0Za4VMp4vR/HZBfsuqp+oK1zODgDypmx5msqiuyp7M1VR0
 JuqTuQmRBqdCxw9TqUHEf0ZZ9ewWHyNw2Br32oXFXFQhbAsYB9tFNF+
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

Currently, `struct ddebug_class_param` uses `unsigned long` pointers
to store the state of `bits` and `lvl`. On 32-bit architectures, this
limits the bit-vector to 32 bits, which truncates 64-bit classmaps
(such as the one needed by `__drm_debug`).

To guarantee support for 64-bit debug categories across all
architectures, upgrade the internal storage types in `struct
_ddebug_class_param` to `u64`. This inherently makes both union
members the same size while safely avoiding truncation.

This includes:
- Changing union members `bits` and `lvl` to `u64 *`.
- Using `kstrtou64()` for sysfs input parsing.
- Replacing array-based `test_bit()` operations with safe `u64` scalar
  bitwise logic (`!!(val & (1ULL << bi))`).
- adjusting lib/test_dynamic_debug.c too

Not yet done:
- Updating `drm_print`'s `__drm_debug` to `u64` and configuring the
  associated module parameter as `ullong`.
- Fixing an unused variable warning in `__drm_printfn_dbg`.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
v2:

patch was "make bits & lvl same size"
but that size was unsigned long, only 32 bits on i386 etc
use u64 for all bits, and %llu %llx
---
 include/linux/dynamic_debug.h |  4 ++--
 lib/dynamic_debug.c           | 34 ++++++++++++++++++----------------
 lib/test_dynamic_debug.c      |  2 +-
 3 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 0a137a586510..a84dcc127e5a 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -91,8 +91,8 @@ struct _ddebug_info {
 
 struct ddebug_class_param {
 	union {
-		unsigned long *bits;
-		unsigned int *lvl;
+		u64 *bits;
+		u64 *lvl;
 	};
 	char flags[8];
 	const struct ddebug_class_map *map;
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index e9481ef21825..580aa258f902 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -624,8 +624,7 @@ static int ddebug_exec_queries(char *query, const char *modname)
 
 /* apply a new class-param setting */
 static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
-				     const unsigned long *new_bits,
-				     const unsigned long old_bits,
+				     const u64 *new_bits, const u64 old_bits,
 				     const char *query_modname)
 {
 #define QUERY_SIZE 128
@@ -635,24 +634,27 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 	int bi, ct;
 
 	if (*new_bits != old_bits)
-		v2pr_info("apply bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
+		v2pr_info("apply bitmap: 0x%llx to: 0x%llx for %s\n", *new_bits,
 			  old_bits, query_modname ?: "'*'");
 
 	for (bi = 0; bi < map->length; bi++) {
-		if (test_bit(bi, new_bits) == test_bit(bi, &old_bits))
+		bool new_b = !!(*new_bits & (1ULL << bi));
+		bool old_b = !!(old_bits & (1ULL << bi));
+
+		if (new_b == old_b)
 			continue;
 
 		snprintf(query, QUERY_SIZE, "class %s %c%s", map->class_names[bi],
-			 test_bit(bi, new_bits) ? '+' : '-', dcp->flags);
+			 new_b ? '+' : '-', dcp->flags);
 
 		ct = ddebug_exec_queries(query, query_modname);
 		matches += ct;
 
-		v2pr_info("bit_%d: %d matches on class: %s -> 0x%lx\n", bi,
+		v2pr_info("bit_%d: %d matches on class: %s -> 0x%llx\n", bi,
 			  ct, map->class_names[bi], *new_bits);
 	}
 	if (*new_bits != old_bits)
-		v2pr_info("applied bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
+		v2pr_info("applied bitmap: 0x%llx to: 0x%llx for %s\n", *new_bits,
 			  old_bits, query_modname ?: "'*'");
 
 	return matches;
@@ -661,7 +663,7 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 /* stub to later conditionally add "$module." prefix where not already done */
 #define KP_NAME(kp)	kp->name
 
-#define CLASSMAP_BITMASK(width) ((1UL << (width)) - 1)
+#define CLASSMAP_BITMASK(width) ((1ULL << (width)) - 1)
 
 /**
  * param_set_dyndbg_classes - class FOO >control
@@ -681,10 +683,10 @@ static int param_set_dyndbg_module_classes(const char *instr,
 {
 	const struct ddebug_class_param *dcp = kp->arg;
 	const struct ddebug_class_map *map = dcp->map;
-	unsigned long inrep, new_bits, old_bits;
+	u64 inrep, new_bits, old_bits;
 	int rc, totct = 0;
 
-	rc = kstrtoul(instr, 0, &inrep);
+	rc = kstrtou64(instr, 0, &inrep);
 	if (rc) {
 		int len = strcspn(instr, "\n");
 		pr_err("expecting numeric input, not: %.*s > %s\n",
@@ -696,24 +698,24 @@ static int param_set_dyndbg_module_classes(const char *instr,
 	case DD_CLASS_TYPE_DISJOINT_BITS:
 		/* expect bits. mask and warn if too many */
 		if (inrep & ~CLASSMAP_BITMASK(map->length)) {
-			pr_warn("%s: input: 0x%lx exceeds mask: 0x%lx, masking\n",
+			pr_warn("%s: input: 0x%llx exceeds mask: 0x%llx, masking\n",
 				KP_NAME(kp), inrep, CLASSMAP_BITMASK(map->length));
 			inrep &= CLASSMAP_BITMASK(map->length);
 		}
-		v2pr_info("bits:0x%lx > %s.%s\n", inrep, mod_name ?: "*", KP_NAME(kp));
+		v2pr_info("bits:0x%llx > %s.%s\n", inrep, mod_name ?: "*", KP_NAME(kp));
 		totct += ddebug_apply_class_bitmap(dcp, &inrep, *dcp->bits, mod_name);
 		*dcp->bits = inrep;
 		break;
 	case DD_CLASS_TYPE_LEVEL_NUM:
 		/* input is bitpos, of highest verbosity to be enabled */
 		if (inrep > map->length) {
-			pr_warn("%s: level:%ld exceeds max:%d, clamping\n",
+			pr_warn("%s: level:%llu exceeds max:%d, clamping\n",
 				KP_NAME(kp), inrep, map->length);
 			inrep = map->length;
 		}
 		old_bits = CLASSMAP_BITMASK(*dcp->lvl);
 		new_bits = CLASSMAP_BITMASK(inrep);
-		v2pr_info("lvl:%ld bits:0x%lx > %s\n", inrep, new_bits, KP_NAME(kp));
+		v2pr_info("lvl:%llu bits:0x%llx > %s\n", inrep, new_bits, KP_NAME(kp));
 		totct += ddebug_apply_class_bitmap(dcp, &new_bits, old_bits, mod_name);
 		*dcp->lvl = inrep;
 		break;
@@ -759,9 +761,9 @@ int param_get_dyndbg_classes(char *buffer, const struct kernel_param *kp)
 
 	switch (map->map_type) {
 	case DD_CLASS_TYPE_DISJOINT_BITS:
-		return scnprintf(buffer, PAGE_SIZE, "0x%lx\n", *dcp->bits);
+		return scnprintf(buffer, PAGE_SIZE, "0x%llx\n", *dcp->bits);
 	case DD_CLASS_TYPE_LEVEL_NUM:
-		return scnprintf(buffer, PAGE_SIZE, "%d\n", *dcp->lvl);
+		return scnprintf(buffer, PAGE_SIZE, "%llu\n", *dcp->lvl);
 	default:
 		return -1;
 	}
diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index 74d183ebf3e0..c049580d2152 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -40,7 +40,7 @@ module_param_cb(do_prints, &param_ops_do_prints, NULL, 0600);
  * - tie together sysname, mapname, bitsname, flagsname
  */
 #define DD_SYS_WRAP(_model, _flags)					\
-	static unsigned long bits_##_model;				\
+	static u64 bits_##_model;					\
 	static struct ddebug_class_param _flags##_model = {		\
 		.bits = &bits_##_model,					\
 		.flags = #_flags,					\

-- 
2.54.0

