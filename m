Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C80476047
	for <linux-modules@vger.kernel.org>; Tue, 21 Jul 2026 20:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784667461; cv=none; b=swoRhUXnWJuzbOP8gUaBOa1mkr8eZgIw0HX/7W5cVRIn1qQr5c4YxoW/mttakmi8rVhPbgd5a6dvUn0P/S3URYZ0REGTH1nJzOTmN2NP1o1ElWXX0ekPtAdRHsimewb5ECbI2ME/X03DVGNACNWC+vOD6U4myp7ZL6uUROjnbZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784667461; c=relaxed/simple;
	bh=eCloqlJ2v/+XMSZlI14hGW9da+1SGwpyJZa2FWOM75E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aJIgAvnO8F/6oCGMLWFj4wx9yM+U9JOgiOdEQBNWTlh+jM68jboKTQ0zL9KfMoSWorWb6B2KMKBWGFN5B6krtfGDc3GDGPZuq7lLhYZPFQtu8JdUE0IlnS9Rpbr5LdFyGrttXWLqZ90DfHiA923WH+YXSREr4rfE8rIDxuomjmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LrdeoGDG; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LrdeoGDG"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7e9f69ee6f4so6475597a34.2
        for <linux-modules@vger.kernel.org>; Tue, 21 Jul 2026 13:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784667455; x=1785272255; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cVowhHu7yo8cpo601RS2GxxXakYLg9JiM3lfJ+Lnq8M=;
        b=LrdeoGDGQq1DWqZ7PwMPc9BkdE9IRg2S6knazNkxA2NoEXL03BWyrdR6ZjgSONOuTa
         iddFDauop/3Md36UGnqE7InI88mftpTB8goCWU0qK1093dbMLEIvGiFSF6814nwME2ke
         y/KuuW9w3KIbwlgUGuUP9GhJVXsE/OsFBRgSeegAIo89kAMByR2aphlCX8vLueHudbaZ
         IjUDpSTTYzV8BANB4uYoUiaGn2XS9kyxMDUCCFN6YlB9zXIdortoY3Tra/ZcOOriN244
         iJe0k5+QwrIBd6MVwFMTfOyRJxSXxA2zztPjpeW6JYIvQQ8+4U3ToxhEU56E3lqEtIWR
         uHiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784667455; x=1785272255;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cVowhHu7yo8cpo601RS2GxxXakYLg9JiM3lfJ+Lnq8M=;
        b=UVPdinV5zH97bi/aTN2xqJn/MAYqYq5I0wmTLXTP9JuPLVgo41KocAhTEwNjUtyXQx
         qckdW7t0HklKPCYo/1dXv2E4gZ2Ozw0/wAqyAZ4BwM7v0PhI2LjEYh4EWuRaMYAz4q6F
         e8dppOqmJe9ckqL6eslkHq1h6wLBf7sm80b6xjl9vLn5oQ6ntP8tBAPb16etrh9zDOJ+
         GN4SIefTgJiZA1QnN0eBlEIlU5zq9qnETNEDsflGewrVLQdLr2z2D11wehrs+KFQDCyr
         cMPjEvcdYyHklTdsowk8pUDDxeq+pSNhOa4WyZRDn9WOoR0uzp00bjEp2H+K6Z+DmBvl
         8wjQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp35UtQM5ly1iHC3dCbTReO5nhaeR8Xp7kMgjLwrE1jx9xNeI/HIB3PHrxxpqCUGQXffDXNQYM0FZB+p9id@vger.kernel.org
X-Gm-Message-State: AOJu0YzKXuwRR8tw5lloF2Capvpk7ZYcAHdL+fqIk/WEfpIKdqyykPfS
	jpVdM4L4M4BIU++kvdPkHWpue1fKimcxPQuygMPlMM3Ww6RKbs2wvQz/zMcG9g==
X-Gm-Gg: AfdE7cnih0bYgO6GQDzsPdIDfD2y0YlnqdIJZsTP3aOZPRCdr9+SsC3fC1YG435xCZ5
	S0tDqys26bKuXa0qPSYQq8MX32QD7zkTr+cufH9BF06vqvntINzLe3nwv5PgRAN+XG65igdbgVF
	kYYFaEJeM9SWM1EJquzTM2HiOFoFrchWWpCv7oKFCnvNUQsCVhldL2fQ1ujTXxIxnZW94mdFzmg
	UKTQsKfb0qtHMvI1nb6HtGFCdKRLsibCtY0A6VcDlI+0EnEP/u829/E2BWyeCOJKgFJ3D7sLqO2
	YBkqksQcakHZdS5coSfihEHPPpTbvNDdSF7rHDA2iAx1yg84HYHsc0CbjJu56xBM3M5bZ3IZ/xA
	4MiCrwWj/vQEjx2lzdQNHZQGsLIE481uViKeoP2LtwjUbNoh36xnFHpdTYdVQmfvIm9oBMZqpsG
	S0JuuCuJlGbDjKjlcJSt6kzEDI2WA/XO8tx6p3g03f0mcYsv/DaTBSyJQudF9U8gIcPHpG19k6k
	TRJHYVfWQeflPPcdYesIXZ08w==
X-Received: by 2002:a05:6830:3c89:b0:7dd:9b19:a87b with SMTP id 46e09a7af769-7ed9a7d30famr10804335a34.4.1784667455635;
        Tue, 21 Jul 2026 13:57:35 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7edaf94a494sm11134501a34.13.2026.07.21.13.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 13:57:35 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 21 Jul 2026 14:57:09 -0600
Subject: [PATCH v7 20/29] dyndbg: refactor param_set_dyndbg_classes and
 below
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-dd-maint-2-v7-20-010fbe73b311@gmail.com>
References: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
In-Reply-To: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, Simona Vetter <simona@ffwll.ch>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784667429; l=6125;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=eCloqlJ2v/+XMSZlI14hGW9da+1SGwpyJZa2FWOM75E=;
 b=oHGyId4pOK0AQyfB5EtTY1sBf1PEHx3IQj5ek/QCUSKOnylp5jzcTcLyUk7CzUyws32r458v+
 nQAuaTfBM2oA8jq8pegokMNkBYsKo1zbnsl9r1J4l5UBBEtwgdv2HBE
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

Refactor the callchain below param_set_dyndbg_classes(1) to allow
mod-name specific settings.  Split (1) into upper/lower fns, adding
modname param to lower, and passing NULL in from upper.  Below that,
add the same param to ddebug_apply_class_bitmap(), and pass it thru to
_ddebug_queries(), replacing NULL with the param.

This allows the callchain to update the classmap in just one module,
vs just all as currently done.  While the sysfs param is unlikely to
ever update just one module, the callchain will be used for modprobe
handling, which should update only that just-probed module.

In ddebug_apply_class_bitmap(), also check for actual changes to the
bits before announcing them, to declutter logs.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
v2: move RvB after SoB
---
 lib/dynamic_debug.c | 51 +++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 39 insertions(+), 12 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index f66e5373e61e..a619cefd801f 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -615,9 +615,10 @@ static int ddebug_exec_queries(char *query, const char *modname)
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
@@ -625,7 +626,9 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 	int matches = 0;
 	int bi, ct;
 
-	v2pr_info("apply: 0x%lx to: 0x%lx\n", *new_bits, *old_bits);
+	if (*new_bits != *old_bits)
+		v2pr_info("apply bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
+			  *old_bits, query_modname ?: "'*'");
 
 	for (bi = 0; bi < map->length; bi++) {
 		if (test_bit(bi, new_bits) == test_bit(bi, old_bits))
@@ -634,12 +637,16 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
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
 
@@ -652,6 +659,7 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
  * param_set_dyndbg_classes - class FOO >control
  * @instr: string echo>d to sysfs, input depends on map_type
  * @kp:    kp->arg has state: bits/lvl, map, map_type
+ * @mod_name: module name or null for all modules with the classes
  *
  * Enable/disable prdbgs by their class, as given in the arguments to
  * DECLARE_DYNDBG_CLASSMAP.  For LEVEL map-types, enforce relative
@@ -659,7 +667,9 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
  *
  * Returns: 0 or <0 if error.
  */
-int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
+static int param_set_dyndbg_module_classes(const char *instr,
+					   const struct kernel_param *kp,
+					   const char *mod_name)
 {
 	const struct ddebug_class_param *dcp = kp->arg;
 	const struct ddebug_class_map *map = dcp->map;
@@ -683,8 +693,8 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
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
@@ -697,7 +707,7 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
 		old_bits = CLASSMAP_BITMASK(*dcp->lvl);
 		new_bits = CLASSMAP_BITMASK(inrep);
 		v2pr_info("lvl:%ld bits:0x%lx > %s\n", inrep, new_bits, KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &new_bits, &old_bits);
+		totct += ddebug_apply_class_bitmap(dcp, &new_bits, &old_bits, mod_name);
 		*dcp->lvl = inrep;
 		break;
 	default:
@@ -707,16 +717,33 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
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
2.55.0

