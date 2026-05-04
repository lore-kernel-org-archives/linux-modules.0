Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5640A30FC12
	for <linux-modules@vger.kernel.org>; Mon,  4 May 2026 20:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777927529; cv=none; b=M4JCYE3SSmOz895rYycO8eYw/uMlXsFHL2C6zDSfrBBYQNNkJTGKdwEvh2QBUynO4VyuLA/PkfC9lwWeNmco5Uyy1boKSWp3pALRAanYHKHCMSGN20lXq7n3klAAsPQ5/L1PU0vqey75EU2ij6YaBov4y/i1Wx4/YRJzPqGx1f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777927529; c=relaxed/simple;
	bh=o7xvrhkeutR2GpUrORK5W3plIJqLIC/hWqhAsvDVmBk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KHEM4WZH4+fyJZeh+88gbIZgaDKEdBhb9u+DCHm1CdvrZrbz+pl/hs7tQrwqJU2+qmhBdwas0m8zcSxlKLPZSPMCrJuZfWz+0pHYxx04pu0mjK4nooUmbsJsJq0ZL26AR9Vn3whqhzKJha+1Bb2HjaIh7zMZow7aD3xB0YmrG3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ilMndO8H; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilMndO8H"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7dcdd23fcdfso2498999a34.3
        for <linux-modules@vger.kernel.org>; Mon, 04 May 2026 13:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777927526; x=1778532326; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=38naadYyUxJ1fqV8HMsWZcBSB4PJy5I2xp4VmLB9+28=;
        b=ilMndO8HEGQlDUzDheKpbRrcHBBxOnw7yO0JYaOg7qGXohorYXqhYkDt92NIkxxhd1
         r3qqBfbDmAFePgKZiFiXpPch40HYfy3QM6GchIupseWuO5bRSRu0Gw5ZeGBdkxfRuJxx
         Wbn+/VK2DKHfqP2AKM1Ko83N6vgM+u8x13eydWGUCHH4P1qLutBBK6tqT7FmOBfI0PIp
         iY8FotvGhdWoXta94oXSOkD/oeyOq92ZU9PDJpzgajDXNrHZsZEoe2SqiPmWu9jovnNN
         ROlBo6Zgc6V6qbeBkPdAiQg8QGMBkDFo3stt/Urz1U3pUJQw7cL14YsAIaKz6L2kmoK6
         IQ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777927526; x=1778532326;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=38naadYyUxJ1fqV8HMsWZcBSB4PJy5I2xp4VmLB9+28=;
        b=KmpGYOQ02S3GEeRUtctF24cviHDYF+DnrabJOMArnVwDrh9+AA3IMKE6vXqu8K1rkl
         wy2HMeVdxLN2yS/gDTvuMgHjSYF5toFAWmpRKZCzfq4VO1Vuo4OGoWALkA1aWK3Cu7Mo
         uN4Oola/eufaeXzcSautKWGaSxynnVcsxVONPvtVKIzdJAfHFuLeezJpvti+wtsE1D6s
         jjStdt/xooKzNil6sobUtFRES5Mf6iIimjFMTjbDBXFjeBSmL5PBJcLoW4mNv4OSrwHa
         DTgVVPhOIWdsvWEgP8BhyAtRrwGeBVBN6su5J9ntf8CAjlngdP1jNbFblIbYgzf8/WyL
         kttw==
X-Forwarded-Encrypted: i=1; AFNElJ8w2CRYT7tIW9LLq3pfFLlPXThadvHWAdGe6xXm0rOom8pAGjOmq4saP/cuKkAolVSZp4mXWhKX5vdUGRLG@vger.kernel.org
X-Gm-Message-State: AOJu0YwIw7cqY3LWaGaHbRXQOyFc2Fhb2/G4y0VANB0LfDvS0rJCZUey
	qBsHK5FP5JX6K56ihtIJ3Y8/QHEXJPKuigN3hZNKMirccd38WFMmIkl8
X-Gm-Gg: AeBDiet0jFJ9G+j2bFLgjkqMJXayRnWJJj6L2tIMb2SYPzcLjE0CmD686lRRcoivJ62
	tzrfKuaAB7kX/MePRcLGHTXmItsS8+k2m+TrUGcZ+atCUTpxLgE5kmnjFYxsKgPUxcQ7XAMqe+6
	5MwF+MxwiGnuJIeUpf6OnHS/ujsiLVZJnu2gTAe7uUgWPp4DJGyPX83BLK07o8RoTBGIISa+W9R
	R/b1efJVhMzvVnzvZkpwBQ58UC366y+m8Sv5xmYXhyCGK3d0fw8ikllZslZbEP/lRv/+cIN5nMI
	Ox8YPiWMMyZA6f6JnYWVnEgaa62VS4e2LSbnwXlyl2sY0oiZmuWrpeukVxIlCCMLudHX6lgVGwo
	oXCcaz0rhssU99g4dKkCv1YHzISQSH+N2NDTv5tMLxdodlyCTvcwMwkk6fdc918gGo8+XfnMV20
	6ly1ouGyIkBFIclSWVqnFzGuOimNMOWKIBSkPlpimKi7ytGRzw4ZR3l0o2/VG01BFCQWR5Ea/T
X-Received: by 2002:a05:6820:81d5:b0:689:dfc8:5e3c with SMTP id 006d021491bc7-6998a56f88fmr133287eaf.3.1777927526319;
        Mon, 04 May 2026 13:45:26 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-69689266bacsm7144713eaf.0.2026.05.04.13.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 13:45:25 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Mon, 04 May 2026 14:45:14 -0600
Subject: [PATCH 08/17] dyndbg: refactor param_set_dyndbg_classes and below
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-dd-cleanups-2-v1-8-6fdd24040642@gmail.com>
References: <20260504-dd-cleanups-2-v1-0-6fdd24040642@gmail.com>
In-Reply-To: <20260504-dd-cleanups-2-v1-0-6fdd24040642@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Shuah Khan <shuah@kernel.org>, Louis Chauvet <louis.chauvet@bootlin.com>
Cc: linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777927513; l=6973;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=o7xvrhkeutR2GpUrORK5W3plIJqLIC/hWqhAsvDVmBk=;
 b=fg5P/LuLoseYTgbI61dVxG3z7zhchI8J/1/1UROCkUxLrOQU75sIuNF3pI3gHYHd65+ha46bL
 LXaaawrTDzkCLhxsks/+eDjwO8/yuOsdOeX7mX/AvRSLEo7An+gbDvP
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

Refactor callchain below param_set_dyndbg_classes(1) to allow mod-name
specific settings.  Split (1) into upper/lower fns, adding modname
param to lower, and passing NULL in from upper.  Below that, add the
same param to ddebug_apply_class_bitmap(), and pass it thru to
_ddebug_queries(), replacing NULL with the param.

This allows the callchain to update the classmap in just one module,
vs just all as currently done.  While the sysfs param is unlikely to
ever update just one module, the callchain will be used for modprobe
handling, which should update only that just-probed module.

In ddebug_apply_class_bitmap(), also check for actual changes to the
bits before announcing them, to declutter logs.

No functional change.

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 65 ++++++++++++++++++++++++++++++++---------------------
 1 file changed, 40 insertions(+), 25 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 3ae9ecabdad1..4313c8803007 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -605,9 +605,10 @@ static int ddebug_exec_queries(char *query, const char *modname)
 	return nfound;
 }
 
-/* apply a new bitmap to the sys-knob's current bit-state */
+/* apply a new class-param setting */
 static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
-				     unsigned long *new_bits, unsigned long *old_bits)
+				     unsigned long *new_bits, unsigned long *old_bits,
+				     const char *query_modname)
 {
 #define QUERY_SIZE 128
 	char query[QUERY_SIZE];
@@ -615,7 +616,9 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 	int matches = 0;
 	int bi, ct;
 
-	v2pr_info("apply: 0x%lx to: 0x%lx\n", *new_bits, *old_bits);
+	if (*new_bits != *old_bits)
+		v2pr_info("apply bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
+			  *old_bits, query_modname ?: "'*'");
 
 	for (bi = 0; bi < map->length; bi++) {
 		if (test_bit(bi, new_bits) == test_bit(bi, old_bits))
@@ -624,12 +627,16 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 		snprintf(query, QUERY_SIZE, "class %s %c%s", map->class_names[bi],
 			 test_bit(bi, new_bits) ? '+' : '-', dcp->flags);
 
-		ct = ddebug_exec_queries(query, NULL);
+		ct = ddebug_exec_queries(query, query_modname);
 		matches += ct;
 
 		v2pr_info("bit_%d: %d matches on class: %s -> 0x%lx\n", bi,
 			  ct, map->class_names[bi], *new_bits);
 	}
+	if (*new_bits != *old_bits)
+		v2pr_info("applied bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
+			  *old_bits, query_modname ?: "'*'");
+
 	return matches;
 }
 
@@ -684,7 +691,7 @@ static int param_set_dyndbg_classnames(const char *instr, const struct kernel_pa
 				continue;
 			}
 			curr_bits ^= BIT(cls_id);
-			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, dcp->bits);
+			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, dcp->bits, NULL);
 			*dcp->bits = curr_bits;
 			v2pr_info("%s: changed bit %d:%s\n", KP_NAME(kp), cls_id,
 				  map->class_names[cls_id]);
@@ -694,7 +701,7 @@ static int param_set_dyndbg_classnames(const char *instr, const struct kernel_pa
 			old_bits = CLASSMAP_BITMASK(*dcp->lvl);
 			curr_bits = CLASSMAP_BITMASK(cls_id + (wanted ? 1 : 0 ));
 
-			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, &old_bits);
+			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, &old_bits, NULL);
 			*dcp->lvl = (cls_id + (wanted ? 1 : 0));
 			v2pr_info("%s: changed bit-%d: \"%s\" %lx->%lx\n", KP_NAME(kp), cls_id,
 				  map->class_names[cls_id], old_bits, curr_bits);
@@ -708,18 +715,9 @@ static int param_set_dyndbg_classnames(const char *instr, const struct kernel_pa
 	return 0;
 }
 
-/**
- * param_set_dyndbg_classes - class FOO >control
- * @instr: string echo>d to sysfs, input depends on map_type
- * @kp:    kp->arg has state: bits/lvl, map, map_type
- *
- * Enable/disable prdbgs by their class, as given in the arguments to
- * DECLARE_DYNDBG_CLASSMAP.  For LEVEL map-types, enforce relative
- * levels by bitpos.
- *
- * Returns: 0 or <0 if error.
- */
-int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
+static int param_set_dyndbg_module_classes(const char *instr,
+					   const struct kernel_param *kp,
+					   const char *mod_name)
 {
 	const struct ddebug_class_param *dcp = kp->arg;
 	const struct ddebug_class_map *map = dcp->map;
@@ -756,8 +754,8 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
 				KP_NAME(kp), inrep, CLASSMAP_BITMASK(map->length));
 			inrep &= CLASSMAP_BITMASK(map->length);
 		}
-		v2pr_info("bits:%lx > %s\n", inrep, KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &inrep, dcp->bits);
+		v2pr_info("bits:0x%lx > %s.%s\n", inrep, mod_name ?: "*", KP_NAME(kp));
+		totct += ddebug_apply_class_bitmap(dcp, &inrep, dcp->bits, mod_name);
 		*dcp->bits = inrep;
 		break;
 	case DD_CLASS_TYPE_LEVEL_NUM:
@@ -770,7 +768,7 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
 		old_bits = CLASSMAP_BITMASK(*dcp->lvl);
 		new_bits = CLASSMAP_BITMASK(inrep);
 		v2pr_info("lvl:%ld bits:0x%lx > %s\n", inrep, new_bits, KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &new_bits, &old_bits);
+		totct += ddebug_apply_class_bitmap(dcp, &new_bits, &old_bits, mod_name);
 		*dcp->lvl = inrep;
 		break;
 	default:
@@ -779,16 +777,33 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
 	vpr_info("%s: total matches: %d\n", KP_NAME(kp), totct);
 	return 0;
 }
+
+/**
+ * param_set_dyndbg_classes - classmap kparam setter
+ * @instr: string echo>d to sysfs, input depends on map_type
+ * @kp:    kp->arg has state: bits/lvl, map, map_type
+ *
+ * enable/disable all class'd pr_debugs in the classmap. For LEVEL
+ * map-types, enforce * relative levels by bitpos.
+ *
+ * Returns: 0 or <0 if error.
+ */
+int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
+{
+	return param_set_dyndbg_module_classes(instr, kp, NULL);
+}
 EXPORT_SYMBOL(param_set_dyndbg_classes);
 
 /**
- * param_get_dyndbg_classes - classes reader
+ * param_get_dyndbg_classes - classmap kparam getter
  * @buffer: string description of controlled bits -> classes
  * @kp:     kp->arg has state: bits, map
  *
- * Reads last written state, underlying prdbg state may have been
- * altered by direct >control.  Displays 0x for DISJOINT, 0-N for
- * LEVEL Returns: #chars written or <0 on error
+ * Reads last written state, underlying pr_debug states may have been
+ * altered by direct >control.  Displays 0x for DISJOINT classmap
+ * types, 0-N for LEVEL types.
+ *
+ * Returns: ct of chars written or <0 on error
  */
 int param_get_dyndbg_classes(char *buffer, const struct kernel_param *kp)
 {

-- 
2.54.0

