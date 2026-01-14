Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72880399004
	for <linux-modules@vger.kernel.org>; Wed, 14 Jan 2026 12:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768393916; cv=none; b=Neuu8eG6mxlWbvDr7/+dCPTTfY2aVgHh3gMre+8+CJj30/V/0A/QZAlhV3dXCvR9vG3tciXg5U2EqTvYB5tWUrK8eGI7uPwD1YVvgONOj5EGif1meq37QN0Mf2/2LZ+MJRC9uhZuj8m9SF7mRwLnMhe3vS5PRC01GWTBIaSZ0tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768393916; c=relaxed/simple;
	bh=ZgJ1dEU6+ZGVdXM6hw4wKI+le2B582/kbyjLsCiprmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cnd0GKbpQsaICCX6v/DXZVD7c411KQp5cGODG6K7QutVOXjpc1DyYyJY+5o0SykUybZpEIy+rXZJLnk1RlWG+/TjFiRE8D9/lZ2NVrWu0s52FgrSB+6mN/w9pIs2DFGszdhfPUh+/gABgHLQZCdJn9cW0lo3+qGpKAl6XhW6xpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EdL1qTm9; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EdL1qTm9"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47ee937ecf2so855045e9.0
        for <linux-modules@vger.kernel.org>; Wed, 14 Jan 2026 04:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768393909; x=1768998709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RR3YoD6WCTWgJohAhViTjBihhVdnHUrj5lJnB7qGoyI=;
        b=EdL1qTm9TFRSj5q3AdElTFnRhEhUbcnj2iYgVIl12twupqEltlfymYPnts2A3UeQgh
         lgvH2ElIJ4V9QslRuXYo8wrA00mkSUQf9NybDijPUhZTMHzuYPYGAQv5wLCYoxM1KiWJ
         og7f0fBVfu/saNOX6oC6xwWxCxDtMG8asOs+ChpYwFUf3XW5nf/HDC0eb1SkCXDMBUm7
         LFN7dBV9pjzSEEJULoWWuLLOPYmBVImjST1tzDOzctQBlg1ZJ8tnQrI8loKhh7Z1n61z
         eZ7RnHIhfAVdV9xz1NxHqQH5SdyF1cZSoiucN0xXP4YYe2ZVWfrfJ2mm9vlig0mjPj0m
         LAxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768393909; x=1768998709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RR3YoD6WCTWgJohAhViTjBihhVdnHUrj5lJnB7qGoyI=;
        b=g5lyZ98vFzORRino72ATRClEqS0QnHKOV83h+w3+jvOlv1OeR791OBEdmBLDXn8qhd
         +TPMmFeb0pb6ijshLnPMZc0wBZeCiq3sNYk1uobcUaeG5oPrahpIrn3RgbL3wh/5uRog
         9BuZxU7HEchpI0BatVsk3IknSCCnGrPjj7HdGgPSzF53KoQiZm4iHB7D49xCSNgE32xl
         v9T4fSgVqG+txC+r1D9AaAKNWCqSWKmW3PHfgGCpEIbGtdfmZmAzzXHkGb6cQbEgWTJO
         blOkYZ6aN4tDItHwZHkvoZG9JdKLVK54vplRI8LMsRaZ6Yj2THO3HJJ8DuBNnWwW6S7h
         F2qw==
X-Forwarded-Encrypted: i=1; AJvYcCX6vC16qZzUZxU/OLHiyZvmAIrnoX1iewojAGYdJ8rfrfDNiueYYSQTqqziZTKmkoQts7t4aBhUwQme5eLO@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3S/F8Ttbhkes7piDoQFnUMoi+p4eYoG7oQtZUvEuQtDRkNpXz
	fqi6W1r76fIUW9b5wz+okC2Lebfgl7JH2ddiGcXIAzMaIfSzpm+DQQ0p51OsJxMk/Io=
X-Gm-Gg: AY/fxX59mPIK5IthLyNV2QToljV7LJf4JIsIeeKDzBvQMjySJR8Ffl+BEYcya5YGTlg
	gNzdGtAXhl9ScmWP8mjFTrzuhVqWYsV4LGQfjQQZr32acv6NM126ZyGHF8bP6CkIeTAM6htNMdy
	Utka4DWUfxzolQLSpTAZb4PAFF9txxbAUstWqQ/xfNA0qVbiy+nyzKieSK+96Oz9GySAcILjBi2
	DEgGFwiem8D0+OmtyUyjOkqylzbJT6CTaYZSGF3dOpF6AwApZZYUyN0m7eAxlc8SlXLnlCcfViK
	vxS5CUUwczgbs6bycUsp1XNejdv9CLlMUTeqSd6WfQNyzTHUFDNdGc/WD4oj8K8dCaY4apztEMH
	L3HAVn0lVFcsF9Xm+4YWgi5vhUF2Py67rw1CkKLg6tq4MiiSyWZ39N7fKBTLOhTcKWGaS8S1MLW
	MMFRxzXJ1DtKdH/lHjtRt8lsqaYVhNSeQ=
X-Received: by 2002:a05:600c:a44:b0:47b:deb9:163d with SMTP id 5b1f17b1804b1-47ee377d1damr26618985e9.7.1768393909141;
        Wed, 14 Jan 2026 04:31:49 -0800 (PST)
Received: from zovi.suse.cz (109-81-1-107.rct.o2.cz. [109.81.1.107])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ee243sm50097772f8f.31.2026.01.14.04.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 04:31:48 -0800 (PST)
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
Subject: [PATCH 1/2] livepatch: Fix having __klp_objects relics in non-livepatch modules
Date: Wed, 14 Jan 2026 13:29:53 +0100
Message-ID: <20260114123056.2045816-2-petr.pavlu@suse.com>
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

The linker script scripts/module.lds.S specifies that all input
__klp_objects sections should be consolidated into an output section of
the same name, and start/stop symbols should be created to enable
scripts/livepatch/init.c to locate this data.

This start/stop pattern is not ideal for modules because the symbols are
created even if no __klp_objects input sections are present.
Consequently, a dummy __klp_objects section also appears in the
resulting module. This unnecessarily pollutes non-livepatch modules.

Instead, since modules are relocatable files, the usual method for
locating consolidated data in a module is to read its section table.
This approach avoids the aforementioned problem.

The klp_modinfo already stores a copy of the entire section table with
the final addresses. Introduce a helper function that
scripts/livepatch/init.c can call to obtain the location of the
__klp_objects section from this data.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 include/linux/livepatch.h |  3 +++
 kernel/livepatch/core.c   | 20 ++++++++++++++++++++
 scripts/livepatch/init.c  | 17 ++++++-----------
 scripts/module.lds.S      |  7 +------
 4 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
index 772919e8096a..ca90adbe89ed 100644
--- a/include/linux/livepatch.h
+++ b/include/linux/livepatch.h
@@ -175,6 +175,9 @@ int klp_enable_patch(struct klp_patch *);
 int klp_module_coming(struct module *mod);
 void klp_module_going(struct module *mod);
 
+struct klp_object_ext *klp_build_locate_init_objects(const struct module *mod,
+						     unsigned int *nr_objs);
+
 void klp_copy_process(struct task_struct *child);
 void klp_update_patch_state(struct task_struct *task);
 
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 9917756dae46..4e0ac47b3623 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -1356,6 +1356,26 @@ void klp_module_going(struct module *mod)
 	mutex_unlock(&klp_mutex);
 }
 
+struct klp_object_ext *klp_build_locate_init_objects(const struct module *mod,
+						     unsigned int *nr_objs)
+{
+	struct klp_modinfo *info = mod->klp_info;
+
+	for (int i = 1; i < info->hdr.e_shnum; i++) {
+		Elf_Shdr *shdr = &info->sechdrs[i];
+
+		if (strcmp(info->secstrings + shdr->sh_name, "__klp_objects"))
+			continue;
+
+		*nr_objs = shdr->sh_size / sizeof(struct klp_object_ext);
+		return (struct klp_object_ext *)shdr->sh_addr;
+	}
+
+	*nr_objs = 0;
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(klp_build_locate_init_objects);
+
 static int __init klp_init(void)
 {
 	klp_root_kobj = kobject_create_and_add("livepatch", kernel_kobj);
diff --git a/scripts/livepatch/init.c b/scripts/livepatch/init.c
index 2274d8f5a482..23e037d6de19 100644
--- a/scripts/livepatch/init.c
+++ b/scripts/livepatch/init.c
@@ -9,19 +9,16 @@
 #include <linux/slab.h>
 #include <linux/livepatch.h>
 
-extern struct klp_object_ext __start_klp_objects[];
-extern struct klp_object_ext __stop_klp_objects[];
-
 static struct klp_patch *patch;
 
 static int __init livepatch_mod_init(void)
 {
+	struct klp_object_ext *obj_exts;
 	struct klp_object *objs;
 	unsigned int nr_objs;
 	int ret;
 
-	nr_objs = __stop_klp_objects - __start_klp_objects;
-
+	obj_exts = klp_build_locate_init_objects(THIS_MODULE, &nr_objs);
 	if (!nr_objs) {
 		pr_err("nothing to patch!\n");
 		ret = -EINVAL;
@@ -41,7 +38,7 @@ static int __init livepatch_mod_init(void)
 	}
 
 	for (int i = 0; i < nr_objs; i++) {
-		struct klp_object_ext *obj_ext = __start_klp_objects + i;
+		struct klp_object_ext *obj_ext = obj_exts + i;
 		struct klp_func_ext *funcs_ext = obj_ext->funcs;
 		unsigned int nr_funcs = obj_ext->nr_funcs;
 		struct klp_func *funcs = objs[i].funcs;
@@ -90,12 +87,10 @@ static int __init livepatch_mod_init(void)
 
 static void __exit livepatch_mod_exit(void)
 {
-	unsigned int nr_objs;
-
-	nr_objs = __stop_klp_objects - __start_klp_objects;
+	struct klp_object *obj;
 
-	for (int i = 0; i < nr_objs; i++)
-		kfree(patch->objs[i].funcs);
+	klp_for_each_object_static(patch, obj)
+		kfree(obj->funcs);
 
 	kfree(patch->objs);
 	kfree(patch);
diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index 3037d5e5527c..383d19beffb4 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -35,12 +35,7 @@ SECTIONS {
 	__patchable_function_entries : { *(__patchable_function_entries) }
 
 	__klp_funcs		0: ALIGN(8) { KEEP(*(__klp_funcs)) }
-
-	__klp_objects		0: ALIGN(8) {
-		__start_klp_objects = .;
-		KEEP(*(__klp_objects))
-		__stop_klp_objects = .;
-	}
+	__klp_objects		0: ALIGN(8) { KEEP(*(__klp_objects)) }
 
 #ifdef CONFIG_ARCH_USES_CFI_TRAPS
 	__kcfi_traps		: { KEEP(*(.kcfi_traps)) }
-- 
2.52.0

