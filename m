Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32EE3BCD0F
	for <linux-modules@vger.kernel.org>; Wed,  8 Jul 2026 02:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783477146; cv=none; b=S6O3pDovRR4bXfIPfygUY+L0V+BnxswJvk2wnPKcw7+ROsfbvN959JMZZyFD9i4IEts8HYVNhDNUvj6n1fSOWJdzeoxQD/ATta5ExoUCHDu97WMV948DYuQjkzty/h0dy8KFhLOwogC8hlzjlPEweI/44obk1adjJ6da01ZCM1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783477146; c=relaxed/simple;
	bh=yuU7Ney2ZEpZhcSHRLhN1Hd3JteSoqhbjcNCSJkzkCQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tl43MhCW6eBD5mgQzLP+S4/l5D1ofJePGFQmj5JTAR71WWhNU7jvO1MWO/bBxappi70VwbkS1yylc2AKqPUbj9oAn64g26kaBLg/FNdLlGWHgdNNVQjj7Rl7TXfdA6dDLmzTgJxlTQoK/DQ/BfsfuCeOygA6M53y9x56HgwK0ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPlO8Thx; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPlO8Thx"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-495b250b01cso188080b6e.0
        for <linux-modules@vger.kernel.org>; Tue, 07 Jul 2026 19:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783477142; x=1784081942; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NbF6QlEYI8YeAh15gg2DHV7921lYu+qQ/2CzzHDk6K0=;
        b=aPlO8ThxsuVBly3rbt3tOCjqCGAvfEF6auAQJgvFwc4W9SOYmV7+5nTk32jQl98b03
         8SSm81saFHZ3w+3H2uV4bkf95+g3q/aVFN84KiES5pCPDGqMQ/doCl9RKWURirPEsKiy
         4xJEJ8oS2ojyuyAqnNi1QoEUjTWz5TpZJyAAHvUd7KfJX8DfYxQ7mX7TEK5luI7LQONj
         tMgiAJaR+v+Pr+s2nfhctK+9/Vf25OgmVeB9LNkxsqQ39ThXRm84NrKa/HcZt/aSp12S
         n8FK9L8ylXsMSdrCZJXAvoq/LfJFbSHi3s5/PpMXeNBxM5nC711k65zFw0TUoLeJX64v
         +hew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783477142; x=1784081942;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NbF6QlEYI8YeAh15gg2DHV7921lYu+qQ/2CzzHDk6K0=;
        b=DrDYcEBf7WDQDFLVfgIG9M6r+fRadd9etMnEVh3A3LF8P7wR3zkaiy91gl4YjrO9dv
         B31p+97TsyJ5qGLnRa0c3yMwWxxHJLqeM5rJ7VVprqVBgjz/YFf1FGZYfIXwS2N44qeI
         bajjaOOoRUr8oJtgLCTBx9SuuIqSVkzEIDk3t8z8sUFsDEZCp3oKWLrRrM+B/MybUQVJ
         6ZXc0WMmpoejy47wHvSgeaUAbIXGFdkdTQmQbG8glYbtiP0NbMta/u/1DGdBacMgZgog
         m3a2k/lXvYdz8ogSHBRzTeunA1+HEjx5KSyaCpA6Aqlrt1UPa07N/UfLSXEdAiYIAj9r
         U1Qw==
X-Forwarded-Encrypted: i=1; AFNElJ+4VsjlqxjmxUw8FPYxtuVd9NaKY3s9E+YMragjgMUtBwJ6qbQUjNFxGCdpYGVC2uzwpfFbai9YYDZj+/72@vger.kernel.org
X-Gm-Message-State: AOJu0YxpWtl7MXDr4RjkjR3lPjnnmMThmlPyyonr5EzK8quhqFSxOHG/
	zPo2ElUmFMoCKY8J27JHTcySVcM74LZTCnQKBo/ASCm6cMC1voaf5g2u
X-Gm-Gg: AfdE7cmkaLhjwINyjFA7oV+Rrb+gL5fw1CQxBcIT15cC0VidnmNq/CHHVfsIiKJ3Tgj
	6Q4+P9b0AmM2EAfwTtSqHWRMLudGbbpCFGp4KdrDhOn6k+fEJM0hDlbM0mV+Aae71u1fYdNBDqW
	2epcw9GFc5VcMIlrwPykBnNMbmozh/4hQzG5cLBmZFFFFqoqofhKXHSDazN+Pjv107Gm6uV1j6a
	5U3Qf7lycqS2wowhBY3aRKjud6Z4L2dZ2WjgOhgXgCkSUfrCC0it6rWtmZu7MzHujtZ5dpj1y3G
	xCNS4FaXyw4l9+dug7TwMkKmfFaS8ydZnCk0FzNxRscJEyyFIzbE/mbSSrHSlUB6eGc2KJjaUdP
	DEWKwkuhdOPSuL97TRdtZ1PlMt7TxMt2lKc/r5te0HP91bCwWUROEVLaQWUF8SovhSDdWLsqN3p
	9PFrZb85ZEblL3lxYekkx3J57fljLHdaDQ+HWGj455AbpsmHMkweA=
X-Received: by 2002:a05:6808:1495:b0:497:d3d6:6a56 with SMTP id 5614622812f47-4a1fed56c03mr344760b6e.0.1783477141665;
        Tue, 07 Jul 2026 19:19:01 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-4a1aa006f74sm799975b6e.0.2026.07.07.19.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 19:19:00 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 07 Jul 2026 20:18:19 -0600
Subject: [PATCH v6 19/24] dyndbg: pin class param storage to u32
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-dd-maint-2-v6-19-381f3edb0045@gmail.com>
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
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783477102; l=8850;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=yuU7Ney2ZEpZhcSHRLhN1Hd3JteSoqhbjcNCSJkzkCQ=;
 b=XZFGUjWBcwqsRZm86CChkkPojSZOAMoeFFo4g9T44j5GcKu2eglhFgA5GpdMz8s+iUnw46bji
 OyIKo4/5amiD9I76DHuP0Jsk8gQMyB0Lppz6IQjoQK3PozAplEwWZq5
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
2.55.0

