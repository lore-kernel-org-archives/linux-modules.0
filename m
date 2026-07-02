Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D10A3655ED
	for <linux-modules@vger.kernel.org>; Thu,  2 Jul 2026 16:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010505; cv=none; b=j3Q3G/+l+9AfaRSHqKLknHjVfiuM7JICK6QtrEeMRwTAflOjDT+qk70NLzvPADLNtjTU92TTpD0q5UEy/3AmzAIvOEzTbHidtfzCAsIvk7iyTwt6OtlxKel3OZ151sGBVwn32IkngW6NrLuI04Aoy5qqLgNVZ9XFF+HNWokLg2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010505; c=relaxed/simple;
	bh=Rkaiarmz1d1BE2BK1Vt3ZNHLzG+/+DAzV9LQfBqpeYA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F7J+DQ8k3Q9v8GGUZoIjwFo+alUmWpkUYrRbCHEhcSY+MNsRjGpOHsW+ciOb2xduA77NnROQDODqSUu82mMaea3S0HS5oz0xNJOMC/wfP7Q0s5MALXd0env4Gc8IncpL0H93GaUygZvzHCWDEDtsInT2yBRZcP0rHVBxlQwpIvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JAfk1V5F; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAfk1V5F"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6a149bfb2a8so1079996eaf.2
        for <linux-modules@vger.kernel.org>; Thu, 02 Jul 2026 09:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783010495; x=1783615295; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=awYu8Hzlyyi7KMutwzgeqju0d//QhNh6gl6sXyGQVC4=;
        b=JAfk1V5FudYsgy7OJOIMk9W9Kr6CsET6KFbiLFYzXXtXOOt5t6vlybjtPplyzgiz1e
         XWyPGBow7pf7udzzk/N6K92rKKonUPja28hRmdCBiNn2wK73CtU/rZ3zub/stInWerYJ
         hbV15j0Dli3zqEYlkJjgvj2++qjrVHuB7RdAXRSR+khZHC4WshzGGuImtWOdDNsQo/wU
         h7IvYmeQBXTVcHAGH73TuXxK6OI/XsyRBsE7Egk8XDXyQ1yuOOMYKlhDHCs8HcOP1qbf
         H8lj6QoHh98E/0bXw1myzIfLHzLmcK2ZsPlW5aAw/l5QTs/7T5EfqlX83mlWS+3wOKUI
         YSqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783010495; x=1783615295;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=awYu8Hzlyyi7KMutwzgeqju0d//QhNh6gl6sXyGQVC4=;
        b=ippiPpk9WembQGK6Hw6UJlSo/3il3QUpMEdZ9Jfw7IYmL7zNosxio9YPM3dguslxof
         3dLGfJHgPOaNI89ip6qlrzQby96g+aL7R9EBYBRqu1GBn3mfyoO/JzvJT4JUyCRHHuBJ
         gs/+FUmfjuQi+BMkYk5bhy21GXshjzmPFCyV36tywwYAFHQ9yUhyYbMOVWRvoZIx31ls
         5mtNc2gS7WWvonf82okaaYyQl60ujmxCUBfFvgFCdOOh8TX/AYzzRHsGG65VmvWlfLtW
         CNS8BqpdhH6urY288PQSj1nD9CNusjvcQla5cPkuDui6x6uZ/QNwEWYy6qNz5AC8vr+N
         06jg==
X-Forwarded-Encrypted: i=1; AFNElJ/nJwKxbs3bxRE6Jz8wGJiy2C8KeyXei1EL5/Xtt1JR78YWWDUwA7DSSblu/rS7rpk707AEwORz1W64OFMu@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3a+UP3bSrr62HAXU70zALuIYVXnP8b4Fem9sbls945f8TjkvR
	3WmOkkLsWJYXlMbt5AtBZh0pW3WGW6z7ne1hMe22GmDpFYhtG39USaHs
X-Gm-Gg: AfdE7cnDiiSE0mbcs2TPmlRkPB4b/vLCT7rhmX7IWD4uMOgAey9aBd1r6ERqiFugLf8
	cB/lfSHOjY3HJ4U/WC8dlDbcOQ9Yi6JXhp6IGyN1pVxhH+U/Fs8Cqm55oGvOPdbrCDXv7Obx+h/
	ZLFQHWPB9pcZyv1gJO9uGdkHlDlj3/x+TQgZmXOoL9NI7zG21sfOgfkDNPaOqlu1C9lvXDn2JcK
	oVcfHkLj3OpY1WtZiZbGANEl3X4BiJK5beCh4JGRXgxXUygwZoj1R6qbjvZfvez1wcJeSnI9C4x
	0qaPNryqxcn61OIooLOkm6mTjddswRhAdp3yIplTQDY6ILA+dNxnfCexEzxV7Q/3xsyLzd2AoMx
	CKCCgjdYz2mM44VcI5mx34dXg7BHJ7YBDYttIdtzreXSKfUppE54QWo0U+2yt9KoJGgEHhCrg+o
	r48yaUqE3+0n9ptB+u73qnDhgh1mkGBno0EWBRcLkidegJY8NBWRc=
X-Received: by 2002:a05:6820:4d0c:b0:6a1:7181:6da1 with SMTP id 006d021491bc7-6a3099c62d8mr4274723eaf.18.1783010495250;
        Thu, 02 Jul 2026 09:41:35 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-44cbec93702sm3189652fac.12.2026.07.02.09.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 09:41:34 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Thu, 02 Jul 2026 10:41:06 -0600
Subject: [PATCH v5 14/18] dyndbg: pin class param storage to u32
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-dd-maint-2-v5-14-24f22b052bf2@gmail.com>
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
 linux-modules@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783010473; l=8850;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=Rkaiarmz1d1BE2BK1Vt3ZNHLzG+/+DAzV9LQfBqpeYA=;
 b=10i5ajLqnrQU2b85PRItB8sJyrqro5EY3B8zB3JZsgK3Z9TY3GW1D1CGlmgCQNPDeRDUQg1wI
 gHenwfiP0H5ALnJMHeVE7yxzEONH2MDnEs3ohSmK71tB91/kPkT7XTN
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

Currently, `struct ddebug_class_param` uses pointers to `unsigned
long` values which store the state of `bits` and `lvl`, so it changes
sizes depending upon the architecture.  Make it always u32 for
consistency.

The bits field references __drm_debug, which was unsigned int, before
commit f158936b60a7 ("drm: POC drm on dyndbg - use in core, 2 helpers, 3 drivers.")
changed it to unsigned long.  This patch changes it back.

That enlargement was a thinko; although modules can have up to 63
classes, and *could* have all those classes in a single classmap, the
real reason is to support multiple classmaps (with non-overlapping
class-id ranges).

32 bits is a practical limit for a class-param's usability since all
classes are set together with a single write of a hex value; 16 would
be a realistic limit, drm.debug has ~12 classes.

  #> echo 0x0fff > /sys/module/drm/parameters/debug

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
v5: u32 for all arches
v4: undo change struct ddebug_class_param to _ddebug_class_param

v3:
fix undefd behavior when classmaps is all 64 bits.
change module_param_named( type-arg from ulong to ullong)
change struct ddebug_class_param to _ddebug_class_param

in drivers/gpu/drm/drm_print.{c,h}
api change later

v2:

patch was "make bits & lvl same size"
but that size was unsigned long, only 32 bits on i386 etc
use u64 for all bits, and %llu %llx

u64-fix

u64-drm-dbg
---
 drivers/gpu/drm/drm_print.c   |  4 ++--
 include/drm/drm_print.h       |  2 +-
 include/linux/dynamic_debug.h |  4 ++--
 lib/dynamic_debug.c           | 35 +++++++++++++++++++----------------
 lib/test_dynamic_debug.c      |  2 +-
 5 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index ded9461df5f2..711ae6606c6e 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -40,7 +40,7 @@
  * __drm_debug: Enable debug output.
  * Bitmask of DRM_UT_x. See include/drm/drm_print.h for details.
  */
-unsigned long __drm_debug;
+u32 __drm_debug;
 EXPORT_SYMBOL(__drm_debug);
 
 MODULE_PARM_DESC(debug, "Enable debug output, where each bit enables a debug category.\n"
@@ -54,7 +54,7 @@ MODULE_PARM_DESC(debug, "Enable debug output, where each bit enables a debug cat
 "\t\tBit 8 (0x100) will enable DP messages (displayport code)");
 
 #if !defined(CONFIG_DRM_USE_DYNAMIC_DEBUG)
-module_param_named(debug, __drm_debug, ulong, 0600);
+module_param_named(debug, __drm_debug, uint, 0600);
 #else
 /* classnames must match vals of enum drm_debug_category */
 DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index ab017b05e175..ed7ce7d7b74c 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -39,7 +39,7 @@ struct drm_device;
 struct seq_file;
 
 /* Do *not* use outside of drm_print.[ch]! */
-extern unsigned long __drm_debug;
+extern u32 __drm_debug;
 
 /**
  * DOC: print
diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index d164a24dece1..250b8391cb14 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -105,8 +105,8 @@ struct _ddebug_info {
 
 struct ddebug_class_param {
 	union {
-		unsigned long *bits;
-		unsigned int *lvl;
+		u32 *bits;
+		u32 *lvl;
 	};
 	char flags[8];
 	const struct ddebug_class_map *map;
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index d99c69b9ad12..af05f4ae3b55 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -582,6 +582,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 		pr_err("query parse failed\n");
 		return -EINVAL;
 	}
+
 	/* actually go and implement the change */
 	nfound = ddebug_change(&query, &modifiers);
 	v3pr_info_dq(&query, nfound ? "applied" : "no-match");
@@ -632,8 +633,7 @@ static int ddebug_exec_queries(char *query, const char *modname)
 
 /* apply a new class-param setting */
 static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
-				     const unsigned long *new_bits,
-				     const unsigned long old_bits,
+				     const u32 *new_bits, const u32 old_bits,
 				     const char *query_modname)
 {
 #define QUERY_SIZE 128
@@ -643,24 +643,27 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 	int bi, ct;
 
 	if (*new_bits != old_bits)
-		v2pr_info("apply bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
+		v2pr_info("apply bitmap: 0x%x to: 0x%x for %s\n", *new_bits,
 			  old_bits, query_modname ?: "'*'");
 
 	for (bi = 0; bi < map->length; bi++) {
-		if (test_bit(bi, new_bits) == test_bit(bi, &old_bits))
+		bool new_b = !!(*new_bits & BIT(bi));
+		bool old_b = !!(old_bits & BIT(bi));
+
+		if (new_b == old_b)
 			continue;
 
 		snprintf(query, QUERY_SIZE, "class %s %c%s", map->class_names[bi],
-			 test_bit(bi, new_bits) ? '+' : '-', dcp->flags);
+			 new_b ? '+' : '-', dcp->flags);
 
 		ct = ddebug_exec_queries(query, query_modname);
 		matches += ct;
 
-		v2pr_info("bit_%d: %d matches on class: %s -> 0x%lx\n", bi,
+		v2pr_info("bit_%d: %d matches on class: %s -> 0x%x\n", bi,
 			  ct, map->class_names[bi], *new_bits);
 	}
 	if (*new_bits != old_bits)
-		v2pr_info("applied bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
+		v2pr_info("applied bitmap: 0x%x to: 0x%x for %s\n", *new_bits,
 			  old_bits, query_modname ?: "'*'");
 
 	return matches;
@@ -669,7 +672,7 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 /* stub to later conditionally add "$module." prefix where not already done */
 #define KP_NAME(kp)	kp->name
 
-#define CLASSMAP_BITMASK(width) ((1UL << (width)) - 1)
+#define CLASSMAP_BITMASK(width) ((width) >= 32 ? ~0U : (1U << (width)) - 1)
 
 /**
  * param_set_dyndbg_classes - class FOO >control
@@ -689,10 +692,10 @@ static int param_set_dyndbg_module_classes(const char *instr,
 {
 	const struct ddebug_class_param *dcp = kp->arg;
 	const struct ddebug_class_map *map = dcp->map;
-	unsigned long inrep, new_bits, old_bits;
+	u32 inrep, new_bits, old_bits;
 	int rc, totct = 0;
 
-	rc = kstrtoul(instr, 0, &inrep);
+	rc = kstrtou32(instr, 0, &inrep);
 	if (rc) {
 		int len = strcspn(instr, "\n");
 		pr_err("expecting numeric input, not: %.*s > %s\n",
@@ -704,24 +707,24 @@ static int param_set_dyndbg_module_classes(const char *instr,
 	case DD_CLASS_TYPE_DISJOINT_BITS:
 		/* expect bits. mask and warn if too many */
 		if (inrep & ~CLASSMAP_BITMASK(map->length)) {
-			pr_warn("%s: input: 0x%lx exceeds mask: 0x%lx, masking\n",
+			pr_warn("%s: input: 0x%x exceeds mask: 0x%x, masking\n",
 				KP_NAME(kp), inrep, CLASSMAP_BITMASK(map->length));
 			inrep &= CLASSMAP_BITMASK(map->length);
 		}
-		v2pr_info("bits:0x%lx > %s.%s\n", inrep, mod_name ?: "*", KP_NAME(kp));
+		v2pr_info("bits:0x%x > %s.%s\n", inrep, mod_name ?: "*", KP_NAME(kp));
 		totct += ddebug_apply_class_bitmap(dcp, &inrep, *dcp->bits, mod_name);
 		*dcp->bits = inrep;
 		break;
 	case DD_CLASS_TYPE_LEVEL_NUM:
 		/* input is bitpos, of highest verbosity to be enabled */
 		if (inrep > map->length) {
-			pr_warn("%s: level:%ld exceeds max:%d, clamping\n",
+			pr_warn("%s: level:%u exceeds max:%d, clamping\n",
 				KP_NAME(kp), inrep, map->length);
 			inrep = map->length;
 		}
 		old_bits = CLASSMAP_BITMASK(*dcp->lvl);
 		new_bits = CLASSMAP_BITMASK(inrep);
-		v2pr_info("lvl:%ld bits:0x%lx > %s\n", inrep, new_bits, KP_NAME(kp));
+		v2pr_info("lvl:%u bits:0x%x > %s\n", inrep, new_bits, KP_NAME(kp));
 		totct += ddebug_apply_class_bitmap(dcp, &new_bits, old_bits, mod_name);
 		*dcp->lvl = inrep;
 		break;
@@ -767,9 +770,9 @@ int param_get_dyndbg_classes(char *buffer, const struct kernel_param *kp)
 
 	switch (map->map_type) {
 	case DD_CLASS_TYPE_DISJOINT_BITS:
-		return scnprintf(buffer, PAGE_SIZE, "0x%lx\n", *dcp->bits);
+		return scnprintf(buffer, PAGE_SIZE, "0x%x\n", *dcp->bits);
 	case DD_CLASS_TYPE_LEVEL_NUM:
-		return scnprintf(buffer, PAGE_SIZE, "%d\n", *dcp->lvl);
+		return scnprintf(buffer, PAGE_SIZE, "%u\n", *dcp->lvl);
 	default:
 		return -1;
 	}
diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index 74d183ebf3e0..9e8e028461ad 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -40,7 +40,7 @@ module_param_cb(do_prints, &param_ops_do_prints, NULL, 0600);
  * - tie together sysname, mapname, bitsname, flagsname
  */
 #define DD_SYS_WRAP(_model, _flags)					\
-	static unsigned long bits_##_model;				\
+	static u32 bits_##_model;					\
 	static struct ddebug_class_param _flags##_model = {		\
 		.bits = &bits_##_model,					\
 		.flags = #_flags,					\

-- 
2.54.0

