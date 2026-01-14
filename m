Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEFB39900B
	for <linux-modules@vger.kernel.org>; Wed, 14 Jan 2026 12:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768393916; cv=none; b=purcbdzjxamuUr+ozeuqDVIUjQtc7EXiTyAkg9jU2bIiwGg69mAw63NJDFeY4cwJJbNWmxKDiOkcwFKslPkRHog4ajQe9pBjL/fmp3vkvZHo9wFua4Mi9cZHu4NNZ7O3xKpbj8Azc2C6UI4ZZAP5/ZW+YnnMpndeGPiovsV+Orc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768393916; c=relaxed/simple;
	bh=lo+iadz8qHbkZgbzUhvlIGNW4LhYtiDx0eCXw/IdSZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gaA47a7iJYu7wfq6aXNd4QQWmp/AcYJo2Cm23DhnocJaq7Az+2WvdwPfWViNNUonIFrZHyaID2pQBI8dBQBfSIavVt3rvZ4NjfPJVLVWvVafWBy+7EQ5qoThDyOnD9prX0ndXBTZkx67NQv8+K54E6M65IGjB6MmgB43LALsdrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=H1Yd78pQ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="H1Yd78pQ"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-432d2c7dd52so4683563f8f.2
        for <linux-modules@vger.kernel.org>; Wed, 14 Jan 2026 04:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768393910; x=1768998710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AI8gmotF1cnQLBo8BsEJi9P54oWsQwjAb5p5bbIKvWA=;
        b=H1Yd78pQk7UlAxWa2mWziDx3JIl1mahxgqh2RQQQwfrgt8rosRlyV7wVSUsEHGpmeN
         DQHSd7rph62ZMmZzZEOv/VuCubDpiJkmqvMgJJS6DpMYBk3NAtVBRInNhKtzrp1+hhBI
         iy4cui5tK+CztXZnNOAq8NmmI0ruva3eoJQYkEk3xkP3wUkP7xB907UQ/Ng0KOGDDaPG
         erxJQkZfgR5iH70ZcCErFg5+ln5Mj8kLrE0IBMRqjtxV5gjQbAqvEhgISO7+Oce4IEGM
         oYk6o+yCLZQQyCmS/BKHkAFLOnyZM5yXWs0k/OPwvW9NCW1sHUuQybDBRry3RyOwKxzy
         IaUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768393910; x=1768998710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AI8gmotF1cnQLBo8BsEJi9P54oWsQwjAb5p5bbIKvWA=;
        b=qqmTvvAohXwsVUBdNjj+TDK2vWIf7FdBFQkmNAe6SvNoqsRHGKmAxDQj9iG4Lp5CA0
         kjxPMMF+vDV78zqjPGxCoNlBT5uanR6WfnEDN8YWdAS3Ga/NU7JJHhQEuXDI3Li4C23/
         KTXcSEnAZ84BkG+HK5t5jZ4CQS86tp3opknhz74b/PfLDe61MaNvdElX3syooFO8oxJq
         X77xOA9hXoa7/a+QTNz0E2sO6h6RLpO3qr+xf9MEqa1HZApeaoGR8GddSfIyQbTvurPw
         ACRTMtjme+9Y/vg8IyiSkgvxtfui4NZm6mL4uftavxaMWpwpD5Nm1j4t787DfggT4Ri2
         ARGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcyp2UhEhWTDMHUYihPddzK3ezIMTblTinFYzp4as+fiMVvtVapPMPSbw3Vi9FxHJjRC1FDAcXbvlJizsr@vger.kernel.org
X-Gm-Message-State: AOJu0YyNAsQANNFwfZTBMIuAoINR2J2XYTxHW3fFEHJl9ip5xpqThXxD
	fEHhbdfWZZV3vWlmNgPL/Q59oeFxt1YoX8RqVoyn/BvjXigB//gb+xRhLarDUsTbmxA=
X-Gm-Gg: AY/fxX6yNiDbZMt9pA45UU1ILauU2MQeF0VQ3aa28Ms4R3CoUxSfIkwUqWKDPw/j/Zu
	FAIeLlvPy4Oe18SonTlipf6dAL0C3LbLQclXZei3Ce9e3ExMS5rxk29uAZeV5+FZXMHNbsut2uC
	cbep1+lpwT6Umm8e7t53cTCbYjklVssK1kgaxp97Gag85Agu0AnBwLpmTSpONfnoUc9taogYTPN
	Z+7XKQR3G5sU60G5KakNwzFovfRJ5ep+HZ8pDbPJv+IdJiYC//tfMSHvi1KQawcJaSnkCKWCA0U
	CjLdRZHt1xElvmk2jrtglXG5l+J0a1JO2jLk/C/GTDgFvO1fE79mj4Rr0TKFsdMB3nlIBp8eS1w
	EGl/xht++t1JtjsQtn9dDy+XGgQWzBdmXCHCo3eDhBqlXGOkdynHVXcv1UVRpe4CgnlNIORqC15
	iHPL1AMp+jJ1fuoaj5VD9FuClhG/xsLPU=
X-Received: by 2002:a05:6000:420a:b0:430:fd0f:28fe with SMTP id ffacd0b85a97d-4342c54ace1mr3155170f8f.31.1768393910254;
        Wed, 14 Jan 2026 04:31:50 -0800 (PST)
Received: from zovi.suse.cz (109-81-1-107.rct.o2.cz. [109.81.1.107])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ee243sm50097772f8f.31.2026.01.14.04.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 04:31:49 -0800 (PST)
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
Subject: [PATCH 2/2] livepatch: Free klp_{object,func}_ext data after initialization
Date: Wed, 14 Jan 2026 13:29:54 +0100
Message-ID: <20260114123056.2045816-3-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114123056.2045816-1-petr.pavlu@suse.com>
References: <20260114123056.2045816-1-petr.pavlu@suse.com>
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
---
 kernel/livepatch/core.c             |  3 ++-
 scripts/module.lds.S                |  4 ++--
 tools/objtool/check.c               |  2 +-
 tools/objtool/include/objtool/klp.h | 10 +++++-----
 tools/objtool/klp-diff.c            |  2 +-
 5 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 4e0ac47b3623..3621a7c1b737 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -1364,7 +1364,8 @@ struct klp_object_ext *klp_build_locate_init_objects(const struct module *mod,
 	for (int i = 1; i < info->hdr.e_shnum; i++) {
 		Elf_Shdr *shdr = &info->sechdrs[i];
 
-		if (strcmp(info->secstrings + shdr->sh_name, "__klp_objects"))
+		if (strcmp(info->secstrings + shdr->sh_name,
+			   ".init.klp_objects"))
 			continue;
 
 		*nr_objs = shdr->sh_size / sizeof(struct klp_object_ext);
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

