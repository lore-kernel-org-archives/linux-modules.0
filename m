Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2650348C73
	for <linux-modules@vger.kernel.org>; Sat, 23 May 2026 07:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779520523; cv=none; b=V0/RYqskliATUyCocSgF+cnL4tLhoiXL89EwVpQfjs2BZ+wIdhUFCacQS5FdBnVdTcKuPupu4cV/7xgaj6b99KUEWp1qC2Vj9NrE69jb4Q8AIGAY3rULRji/l5Jt+t4nrFzgrZbjE0PzUGYwI7BVVVdwVeu9o2a0Ae8PMea0mhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779520523; c=relaxed/simple;
	bh=gQZ88gBfz79ESKcPkTx8I8zUQh8zyexO3lJ8TNMZRbE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JqCchr/+ae4mdq149u/Y3FskEkj/BruWeuJs3RVc/QG8SCz/3JhwhSYB1H2R4kRUwPEzE5VEpzs2EarOZSHMYgNrPTadd309lp3ebR1aD2W4Pp/FLO0kFtVUhPV4lgNKOdab1x68MhAadFeM0vzYgKeX28Tc7S07sarITHT1mHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g3L2IHHj; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3L2IHHj"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-44a5174670eso4707985f8f.1
        for <linux-modules@vger.kernel.org>; Sat, 23 May 2026 00:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779520513; x=1780125313; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mi262PGX/DdxCI7Tfx7Z5HvSlx4T7DOtXurGXyeHKEo=;
        b=g3L2IHHjYlNPTpem/1St92SHBAQ40oMoXxZvyfIgmfegr70Ld6w6VG0BctF0dG5Rbf
         FwVrhFCe7QaJEzbTKmvrYr8PFAcfj1u2ZI8pIzwBbVxHY+SqoA/gAdZi+8kxReWEnksk
         rxjEdWvBh2dc6r5V2Dk/iXe9kUqN3CY4rz3CHkda3iC7ad6uxT0OLJ/Gz5nr4G1Zk0/u
         VO1IJDAMTbTB0lUhdmm7UozgxKnIdW8DMdph0eXNSsDWxNX0TcrZ30W/oHFAKRZr5o9k
         GxHMVXL505slrD6oA1EZgms8bKbgbIDMUcOiV6TgoZ2di1BuiLOu7Tq/dfLNF3kLevnC
         5rRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779520513; x=1780125313;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Mi262PGX/DdxCI7Tfx7Z5HvSlx4T7DOtXurGXyeHKEo=;
        b=mgF0wmF8mbYabo57C9wJXTxNdJ6ksloVguLPc6YNFjyzZPFiQ47QJhvTJ02mNuozJC
         Yck43pXvoCrEtPUnnX51tnvLUKzOYkeVMeK6xUz4DkUZX2UFX1xAqlOJyc7v4woida2Q
         MKtUqiuhPB4dzqD8Somc+o9plSDUtEnEXDmRTxd2gfuLLQebqJt4dw0WOHu5gxd/Krjj
         aXZ9BsBVJiTfroUEwp+OwOkx8ocby2RzUZoxUyI17OOgChMPd08++lxCT/XTuTNCGL66
         Ip5U5kPipfv00+Ya5TqfHnXfRzkikKqlzmahn6Z7eoh42gWyc9QF+SFrgztmu6B8Xr8X
         mM/w==
X-Forwarded-Encrypted: i=1; AFNElJ8E7kIMyEjkQ++Ye01w4fw4/FR5+MjMWKjFUs7XAeQigbS2vE9U+d76RycmcAcpR5WasufkOkA+8Kfy6HNn@vger.kernel.org
X-Gm-Message-State: AOJu0YwM6G7Vq1QsAqLwMj6IfoqYZo1FmIaQC8ZOkkXguwqyEAV/NHH9
	kML2JBWWrAlP6xm4apEiLXeYu21P5phQk5GEL7QiP1MdcC42AHcR0KyaCjhp4sUllFo=
X-Gm-Gg: Acq92OGJZ3LdDcLrXR779NG13LCaTaNgfSGZPlNtkTIFuh+PIT+P7vG2cGVXCdvL07e
	Vfh0c4nPAZy5JfPyE+EzPNjNQ1UDjdcHFNqQ7Fsf6/nKqxiY36kYQASSVS+iDDjqEwAUuMRB22x
	2gUyjXy5EKHNhRVQCl6UMn2oF7W91Gz0WaSvV4DD6wO8KRuH7TB1VsSp2rdPzTcyzIzpEO/B3kk
	L2tmS641wJRNPIYFwP8zRv/Cqlr2tk55SzisINTUlgscRSJ5IKlkjQxDXdXQahz2sKKslc88g1r
	KUK23y3TkKQGLEy+9hGIJyRpLuPVv1OstP/2DeFDkFxhBe8PkX/5Bc3HJbV5tyVgpgQX+liK8VP
	R0eRiLa7aG/kJ4TvpVJub0Dy/YM7O+5JYdYEfvjxzwa74TIMbGsLbsw89SKfenJ5QtQwoevh5aP
	iElay532g70/WDNUx+oQVHQCBrvAL6
X-Received: by 2002:a05:6000:4901:b0:455:fbb:28bb with SMTP id ffacd0b85a97d-45eb38af9abmr10516199f8f.35.1779520513292;
        Sat, 23 May 2026 00:15:13 -0700 (PDT)
Received: from [192.168.0.174] ([31.96.183.250])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-45eb6d5cb76sm8639838f8f.25.2026.05.23.00.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 00:15:09 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Sat, 23 May 2026 01:14:44 -0600
Subject: [PATCH v2 11/24] dyndbg-API: remove
 DD_CLASS_TYPE_(DISJOINT|LEVEL)_NAMES and code
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260523-dd-maint-2-v2-11-b937312aa083@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779520485; l=8828;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=gQZ88gBfz79ESKcPkTx8I8zUQh8zyexO3lJ8TNMZRbE=;
 b=4FEUbbf77XrK3sQMboxzqsW5eRGGLoftq58Ya8XU4/wQQo7cLzeH0LP23ba8DIlO2Ss5/xuYY
 zVwIeCF9ILiBoxy66jtJwifLUXN0ZBV4zRvHpnfm6V92SCZ/MzTd0/0
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

Remove the DD_CLASS_TYPE_*_NAMES classmap types and code.

These 2 classmap types accept class names at the PARAM interface, for
example:

  echo +DRM_UT_CORE,-DRM_UT_KMS > /sys/module/drm/parameters/debug_names

The code works, but its only used by test-dynamic-debug, and wasn't
asked for by anyone else, so reduce LOC & test-surface; simplify things.

Also rename enum class_map_type to enum ddebug_class_map_type.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
v2:

move RvB after SoB

respect const instr in param_set_dyndbg_module_classes, return -EINVAL on classtype err.
---
 include/linux/dynamic_debug.h | 23 +++-------
 lib/dynamic_debug.c           | 99 +++----------------------------------------
 lib/test_dynamic_debug.c      | 26 ------------
 3 files changed, 12 insertions(+), 136 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index a10adac8e8f0..aa45dcf36a44 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -59,27 +59,16 @@ struct _ddebug {
 #endif
 } __attribute__((aligned(8)));
 
-enum class_map_type {
+enum ddebug_class_map_type {
 	DD_CLASS_TYPE_DISJOINT_BITS,
 	/**
-	 * DD_CLASS_TYPE_DISJOINT_BITS: classes are independent, one per bit.
-	 * expecting hex input. Built for drm.debug, basis for other types.
+	 * DD_CLASS_TYPE_DISJOINT_BITS: classes are independent, mapped to bits[0..N].
+	 * Expects hex input. Built for drm.debug, basis for other types.
 	 */
 	DD_CLASS_TYPE_LEVEL_NUM,
 	/**
-	 * DD_CLASS_TYPE_LEVEL_NUM: input is numeric level, 0-N.
-	 * N turns on just bits N-1 .. 0, so N=0 turns all bits off.
-	 */
-	DD_CLASS_TYPE_DISJOINT_NAMES,
-	/**
-	 * DD_CLASS_TYPE_DISJOINT_NAMES: input is a CSV of [+-]CLASS_NAMES,
-	 * classes are independent, like _DISJOINT_BITS.
-	 */
-	DD_CLASS_TYPE_LEVEL_NAMES,
-	/**
-	 * DD_CLASS_TYPE_LEVEL_NAMES: input is a CSV of [+-]CLASS_NAMES,
-	 * intended for names like: INFO,DEBUG,TRACE, with a module prefix
-	 * avoid EMERG,ALERT,CRIT,ERR,WARNING: they're not debug
+	 * DD_CLASS_TYPE_LEVEL_NUM: input is numeric level, 0..N.
+	 * Input N turns on bits 0..N-1
 	 */
 };
 
@@ -90,7 +79,7 @@ struct ddebug_class_map {
 	const char **class_names;
 	const int length;
 	const int base;		/* index of 1st .class_id, allows split/shared space */
-	enum class_map_type map_type;
+	enum ddebug_class_map_type map_type;
 };
 
 /* encapsulate linker provided built-in (or module) dyndbg data */
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index a9caf84ddb22..0377d9f8dcd1 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -646,76 +646,6 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 
 #define CLASSMAP_BITMASK(width) ((1UL << (width)) - 1)
 
-/* accept comma-separated-list of [+-] classnames */
-static int param_set_dyndbg_classnames(const char *instr, const struct kernel_param *kp)
-{
-	const struct ddebug_class_param *dcp = kp->arg;
-	const struct ddebug_class_map *map = dcp->map;
-	unsigned long curr_bits, old_bits;
-	char *cl_str, *p, *tmp;
-	int cls_id, totct = 0;
-	bool wanted;
-
-	cl_str = tmp = kstrdup_and_replace(instr, '\n', '\0', GFP_KERNEL);
-	if (!tmp)
-		return -ENOMEM;
-
-	/* start with previously set state-bits, then modify */
-	curr_bits = old_bits = *dcp->bits;
-	vpr_info("\"%s\" > %s:0x%lx\n", cl_str, KP_NAME(kp), curr_bits);
-
-	for (; cl_str; cl_str = p) {
-		p = strchr(cl_str, ',');
-		if (p)
-			*p++ = '\0';
-
-		if (*cl_str == '-') {
-			wanted = false;
-			cl_str++;
-		} else {
-			wanted = true;
-			if (*cl_str == '+')
-				cl_str++;
-		}
-		cls_id = match_string(map->class_names, map->length, cl_str);
-		if (cls_id < 0) {
-			pr_err("%s unknown to %s\n", cl_str, KP_NAME(kp));
-			continue;
-		}
-
-		/* have one or more valid class_ids of one *_NAMES type */
-		switch (map->map_type) {
-		case DD_CLASS_TYPE_DISJOINT_NAMES:
-			/* the +/- pertains to a single bit */
-			if (test_bit(cls_id, &curr_bits) == wanted) {
-				v3pr_info("no change on %s\n", cl_str);
-				continue;
-			}
-			curr_bits ^= BIT(cls_id);
-			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, dcp->bits);
-			*dcp->bits = curr_bits;
-			v2pr_info("%s: changed bit %d:%s\n", KP_NAME(kp), cls_id,
-				  map->class_names[cls_id]);
-			break;
-		case DD_CLASS_TYPE_LEVEL_NAMES:
-			/* cls_id = N in 0..max. wanted +/- determines N or N-1 */
-			old_bits = CLASSMAP_BITMASK(*dcp->lvl);
-			curr_bits = CLASSMAP_BITMASK(cls_id + (wanted ? 1 : 0 ));
-
-			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, &old_bits);
-			*dcp->lvl = (cls_id + (wanted ? 1 : 0));
-			v2pr_info("%s: changed bit-%d: \"%s\" %lx->%lx\n", KP_NAME(kp), cls_id,
-				  map->class_names[cls_id], old_bits, curr_bits);
-			break;
-		default:
-			pr_err("illegal map-type value %d\n", map->map_type);
-		}
-	}
-	kfree(tmp);
-	vpr_info("total matches: %d\n", totct);
-	return 0;
-}
-
 /**
  * param_set_dyndbg_classes - class FOO >control
  * @instr: string echo>d to sysfs, input depends on map_type
@@ -734,28 +664,14 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
 	unsigned long inrep, new_bits, old_bits;
 	int rc, totct = 0;
 
-	switch (map->map_type) {
-
-	case DD_CLASS_TYPE_DISJOINT_NAMES:
-	case DD_CLASS_TYPE_LEVEL_NAMES:
-		/* handle [+-]classnames list separately, we are done here */
-		return param_set_dyndbg_classnames(instr, kp);
-
-	case DD_CLASS_TYPE_DISJOINT_BITS:
-	case DD_CLASS_TYPE_LEVEL_NUM:
-		/* numeric input, accept and fall-thru */
-		rc = kstrtoul(instr, 0, &inrep);
-		if (rc) {
-			pr_err("expecting numeric input: %s > %s\n", instr, KP_NAME(kp));
-			return -EINVAL;
-		}
-		break;
-	default:
-		pr_err("%s: bad map type: %d\n", KP_NAME(kp), map->map_type);
+	rc = kstrtoul(instr, 0, &inrep);
+	if (rc) {
+		int len = strcspn(instr, "\n");
+		pr_err("expecting numeric input, not: %.*s > %s\n",
+		       len, instr, KP_NAME(kp));
 		return -EINVAL;
 	}
 
-	/* only _BITS,_NUM (numeric) map-types get here */
 	switch (map->map_type) {
 	case DD_CLASS_TYPE_DISJOINT_BITS:
 		/* expect bits. mask and warn if too many */
@@ -783,6 +699,7 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
 		break;
 	default:
 		pr_warn("%s: bad map type: %d\n", KP_NAME(kp), map->map_type);
+		return -EINVAL;
 	}
 	vpr_info("%s: total matches: %d\n", KP_NAME(kp), totct);
 	return 0;
@@ -804,12 +721,8 @@ int param_get_dyndbg_classes(char *buffer, const struct kernel_param *kp)
 	const struct ddebug_class_map *map = dcp->map;
 
 	switch (map->map_type) {
-
-	case DD_CLASS_TYPE_DISJOINT_NAMES:
 	case DD_CLASS_TYPE_DISJOINT_BITS:
 		return scnprintf(buffer, PAGE_SIZE, "0x%lx\n", *dcp->bits);
-
-	case DD_CLASS_TYPE_LEVEL_NAMES:
 	case DD_CLASS_TYPE_LEVEL_NUM:
 		return scnprintf(buffer, PAGE_SIZE, "%d\n", *dcp->lvl);
 	default:
diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index 77c2a669b6af..74d183ebf3e0 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -74,13 +74,6 @@ DECLARE_DYNDBG_CLASSMAP(map_disjoint_bits, DD_CLASS_TYPE_DISJOINT_BITS, 0,
 DD_SYS_WRAP(disjoint_bits, p);
 DD_SYS_WRAP(disjoint_bits, T);
 
-/* symbolic input, independent bits */
-enum cat_disjoint_names { LOW = 11, MID, HI };
-DECLARE_DYNDBG_CLASSMAP(map_disjoint_names, DD_CLASS_TYPE_DISJOINT_NAMES, 10,
-			"LOW", "MID", "HI");
-DD_SYS_WRAP(disjoint_names, p);
-DD_SYS_WRAP(disjoint_names, T);
-
 /* numeric verbosity, V2 > V1 related */
 enum cat_level_num { V0 = 14, V1, V2, V3, V4, V5, V6, V7 };
 DECLARE_DYNDBG_CLASSMAP(map_level_num, DD_CLASS_TYPE_LEVEL_NUM, 14,
@@ -88,13 +81,6 @@ DECLARE_DYNDBG_CLASSMAP(map_level_num, DD_CLASS_TYPE_LEVEL_NUM, 14,
 DD_SYS_WRAP(level_num, p);
 DD_SYS_WRAP(level_num, T);
 
-/* symbolic verbosity */
-enum cat_level_names { L0 = 22, L1, L2, L3, L4, L5, L6, L7 };
-DECLARE_DYNDBG_CLASSMAP(map_level_names, DD_CLASS_TYPE_LEVEL_NAMES, 22,
-			"L0", "L1", "L2", "L3", "L4", "L5", "L6", "L7");
-DD_SYS_WRAP(level_names, p);
-DD_SYS_WRAP(level_names, T);
-
 /* stand-in for all pr_debug etc */
 #define prdbg(SYM) __pr_debug_cls(SYM, #SYM " msg\n")
 
@@ -102,10 +88,6 @@ static void do_cats(void)
 {
 	pr_debug("doing categories\n");
 
-	prdbg(LOW);
-	prdbg(MID);
-	prdbg(HI);
-
 	prdbg(D2_CORE);
 	prdbg(D2_DRIVER);
 	prdbg(D2_KMS);
@@ -129,14 +111,6 @@ static void do_levels(void)
 	prdbg(V5);
 	prdbg(V6);
 	prdbg(V7);
-
-	prdbg(L1);
-	prdbg(L2);
-	prdbg(L3);
-	prdbg(L4);
-	prdbg(L5);
-	prdbg(L6);
-	prdbg(L7);
 }
 
 static void do_prints(void)

-- 
2.54.0

