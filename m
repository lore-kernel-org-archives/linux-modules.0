Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20243D3D04
	for <linux-modules@vger.kernel.org>; Wed, 21 Jan 2026 08:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768984163; cv=none; b=CeWKmh9dfMXTzRq76NjPRYsCoV94m+l3lNsRaFJknwoRd36jB3kek3vdPk2IrCwlQirGhxNlhPyR4EoGrtOg8zL5H/ZwbGCgvoqYoql605PTx6iu3XK2RYeY1sTDNIvJcYerS7hBx3GeEdrGa2yBGzj3W7HlM1oTjZRU/1FdqH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768984163; c=relaxed/simple;
	bh=tf2r0DbF4We3sVnIZiZOAFzXpYYSfLGiXXDWTAoLYpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D7OIj+hoQh4Fg1Q2s2qepswDUtJvSmPIbehHBCrPsxFeADiG1k8IUEAvjD/PmJYK1bwgSTm/52HcZjlzGUrp9nXNYMrKNDY72zSECyEBD9QMhvjK/dpfcHrhgrtD2cEOws67xkbq+9C3Hi56Ab+8zVJuVqey1HmP/oZw+GghnBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ny8Qiv1y; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ny8Qiv1y"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4801d1daf53so46247715e9.2
        for <linux-modules@vger.kernel.org>; Wed, 21 Jan 2026 00:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768984159; x=1769588959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7vxOZHcSBD1fpQdkK38syRA+6nyfkbQXy3R8wbjNKlg=;
        b=Ny8Qiv1ydkinzp/mRVJAD8Q3d0d1kXAI6CLUeB+zGmWZ8tFO5hMe0XNvijab+4cIb8
         MbhuEoEY059NqrhH/bIAauh8YY/bcGSu1ywqy1Dq2dyRqYqO6s5NGEE5KDKKbS9g/vwc
         hMGVL/DX4U8SQJqnHpwTYL+BmTqjw0Jd7ZIjMya4tXaJiy0xqEzfBgvBcIY3j/BhhLut
         W3wT2gTRFaetQ6LiAgFaHWZcv2dfB++XK9SVOZAOqU+MF3mAOULuwbaxFzy3I3HcUeDP
         uq7EizhB+n6e/yHIZQrNOETn2t1QsDo1FCbOghkPU9hASSe7kjIQ39rWQhGU1/HbbXOE
         ZXDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768984159; x=1769588959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7vxOZHcSBD1fpQdkK38syRA+6nyfkbQXy3R8wbjNKlg=;
        b=ZNhOwhrgNG1AM+lK3mReFadI+MeBMiFb5R+46ueSuvGUlUnB7FegfloQ3qomeamy14
         G1aHYRMyLwgDCjBQTgTqkEW2laqLheAlZUTkBUa/m1sdJwIWl9di6NeE5E2Rn8XsEeUl
         J+CWnDjXTYXXxR3uQdqiw8YXzNkCMBR6KvtTQdTHqetCy9MR5nqFimN8cnf9+L786J/Z
         oXxKgiDO0ef9FoFMfYWjDVpbmONPpMI+Z3Josmt+YVapR5n8NzTFthMzp083vwlnxTwr
         mQyZfhJZmmu67uXHNY1PuAq2Y4If+Qk6tIXsSaeJbyXdxpxzISvkPjfTbK4xGDmmaPxw
         xfAA==
X-Forwarded-Encrypted: i=1; AJvYcCVA+awyuopZuU2iNaoWReqmz9RHLxl620tS4s3Hefr2lIJCp0LDkVYHAXDkKaVVKBJI4p80NcrS9PZZsTLM@vger.kernel.org
X-Gm-Message-State: AOJu0YyPs3OSHn9SjgucgBKYSbNbs08OwhkS4WNcam5966swhAKk5f0L
	YXp6axPxZNZdAHJqg0+xLX6PnHTtAuokwnc5DbGmTmM5jkqBHWFuBv/S6mDK4HLKmU4=
X-Gm-Gg: AZuq6aLXn5/9PfoCiQ9UVi0v8rAb1V215OewaSx/Skkg5zzC+BkA/wVkdyb+ZoBbLGE
	Ja5af/9HXJGvzw3MpO/PybY9+D5yelGue4rjpjCSpPO99u60tocS1Yg7fcZTGnaSbIgNxFc9D6A
	+zKm7FyV6PywSTIJd2qICaAnSgdbWAYULDllXsdcq2vdz39G2F6AB/fGam23Lzq4iYla7NcCwcW
	7g943iO4VBUPrkD7IoEddhHKXTx6tIa/iVZ4AQvx+VdzGPF8GHQv9XPKGrbwN6Pcgd2dINlE8Bm
	tAFXj98Wv08NsX5FIF0sb4cNCa/TJQD4WkA2sxrKLwe8Cr9+4dRuZoZhIVGEtn52gBNyRPQiQEz
	12H3dJ+KLZQ6irT65y8nt9hFy7rg6KW0o/Jkvc5mVhME+4/zz+s5MYphkapRSP0JTeUq4S1c59o
	qFUuPqJ8/RgDE2oTS04EctRIIFh+nJH10=
X-Received: by 2002:a05:600c:6990:b0:47e:c562:a41f with SMTP id 5b1f17b1804b1-4801e334361mr221506345e9.18.1768984158802;
        Wed, 21 Jan 2026 00:29:18 -0800 (PST)
Received: from zovi.suse.cz (109-81-1-107.rct.o2.cz. [109.81.1.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f4b2755absm441635355e9.15.2026.01.21.00.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 00:29:18 -0800 (PST)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Joe Lawrence <joe.lawrence@redhat.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Peter Zijlstra <peterz@infradead.org>,
	live-patching@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] livepatch: Free klp_{object,func}_ext data after initialization
Date: Wed, 21 Jan 2026 09:28:17 +0100
Message-ID: <20260121082842.3050453-3-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121082842.3050453-1-petr.pavlu@suse.com>
References: <20260121082842.3050453-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The klp_object_ext and klp_func_ext data, which are stored in the
__klp_objects and __klp_funcs sections, respectively, are not needed
after they are used to create the actual klp_object and klp_func
instances. This operation is implemented by the init function in
scripts/livepatch/init.c.

Prefix the two sections with ".init" so they are freed after the module
is initializated.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
Acked-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 scripts/livepatch/init.c            |  2 +-
 scripts/module.lds.S                |  4 ++--
 tools/objtool/check.c               |  2 +-
 tools/objtool/include/objtool/klp.h | 10 +++++-----
 tools/objtool/klp-diff.c            |  2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/scripts/livepatch/init.c b/scripts/livepatch/init.c
index a02252e1de03..3e658db5dfe8 100644
--- a/scripts/livepatch/init.c
+++ b/scripts/livepatch/init.c
@@ -18,7 +18,7 @@ static int __init livepatch_mod_init(void)
 	unsigned int nr_objs;
 	int ret;
 
-	obj_exts = klp_locate_section_objs(THIS_MODULE, "__klp_objects",
+	obj_exts = klp_locate_section_objs(THIS_MODULE, ".init.klp_objects",
 					   sizeof(*obj_exts), &nr_objs);
 	if (!nr_objs) {
 		pr_err("nothing to patch!\n");
diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index 383d19beffb4..054ef99e8288 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -34,8 +34,8 @@ SECTIONS {
 
 	__patchable_function_entries : { *(__patchable_function_entries) }
 
-	__klp_funcs		0: ALIGN(8) { KEEP(*(__klp_funcs)) }
-	__klp_objects		0: ALIGN(8) { KEEP(*(__klp_objects)) }
+	.init.klp_funcs		0 : ALIGN(8) { KEEP(*(.init.klp_funcs)) }
+	.init.klp_objects	0 : ALIGN(8) { KEEP(*(.init.klp_objects)) }
 
 #ifdef CONFIG_ARCH_USES_CFI_TRAPS
 	__kcfi_traps		: { KEEP(*(.kcfi_traps)) }
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 3f7999317f4d..933868ee3beb 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4761,7 +4761,7 @@ static int validate_ibt(struct objtool_file *file)
 		    !strcmp(sec->name, "__bug_table")			||
 		    !strcmp(sec->name, "__ex_table")			||
 		    !strcmp(sec->name, "__jump_table")			||
-		    !strcmp(sec->name, "__klp_funcs")			||
+		    !strcmp(sec->name, ".init.klp_funcs")		||
 		    !strcmp(sec->name, "__mcount_loc")			||
 		    !strcmp(sec->name, ".llvm.call-graph-profile")	||
 		    !strcmp(sec->name, ".llvm_bb_addr_map")		||
diff --git a/tools/objtool/include/objtool/klp.h b/tools/objtool/include/objtool/klp.h
index ad830a7ce55b..e32e5e8bc631 100644
--- a/tools/objtool/include/objtool/klp.h
+++ b/tools/objtool/include/objtool/klp.h
@@ -6,12 +6,12 @@
 #define SHN_LIVEPATCH		0xff20
 
 /*
- * __klp_objects and __klp_funcs are created by klp diff and used by the patch
- * module init code to build the klp_patch, klp_object and klp_func structs
- * needed by the livepatch API.
+ * .init.klp_objects and .init.klp_funcs are created by klp diff and used by the
+ * patch module init code to build the klp_patch, klp_object and klp_func
+ * structs needed by the livepatch API.
  */
-#define KLP_OBJECTS_SEC	"__klp_objects"
-#define KLP_FUNCS_SEC	"__klp_funcs"
+#define KLP_OBJECTS_SEC	".init.klp_objects"
+#define KLP_FUNCS_SEC	".init.klp_funcs"
 
 /*
  * __klp_relocs is an intermediate section which are created by klp diff and
diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index 4d1f9e9977eb..fd64d5e3c3b6 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -1439,7 +1439,7 @@ static int clone_special_sections(struct elfs *e)
 }
 
 /*
- * Create __klp_objects and __klp_funcs sections which are intermediate
+ * Create .init.klp_objects and .init.klp_funcs sections which are intermediate
  * sections provided as input to the patch module's init code for building the
  * klp_patch, klp_object and klp_func structs for the livepatch API.
  */
-- 
2.52.0

