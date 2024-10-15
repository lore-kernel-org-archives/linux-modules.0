Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3011FDF9C
	for <linux-modules@vger.kernel.org>; Tue, 15 Oct 2024 23:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729034233; cv=none; b=Jb4OhkAkyDXpH1SX2Yhhrrl58IwmfeZqWtlJCHzCl9/K7os8AEACoIVZM91Xls5AR4QTJMdqJ66jzOkKGGSK9aPqhMuKIpvGlhackxDWS1TEMVK6h+nYcVzQPlR5I2Z0b84DIIAyjiPkg4jejomMWJDGYFHePaz6wH1Ka9mI9cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729034233; c=relaxed/simple;
	bh=XJb8GC1WAknzucT2QTWdPk2p/Ah0/usyy4/JqpeqgqY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mG3K96TjtFykr7qw5aLDSZS7WfCHVNPlmUckUOP7ZCeslyNWo0YMwnZ+iJU9GDrB3qx/4K0787KtGC6pUsgDiWwNbcuRH94E8ol6tJ7usUPqlr8PDwPwewG1QLVD5ZJKnAyoKA05jUlxusOmmSSSIDplhXG22KSDoravURWP+B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TWdPjvFc; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TWdPjvFc"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e292a6bdd72so6629063276.0
        for <linux-modules@vger.kernel.org>; Tue, 15 Oct 2024 16:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729034231; x=1729639031; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5/P7PU9aN7A7FFAWIBfgCyglKPdadfqEBvM4ZLHjr8=;
        b=TWdPjvFcxbbZxe5pCEVt3skTpH90BrIXPLyRDfZEjsq/lQmqIGLnupqjl3lnRIQIad
         ICLrcpN/IYNTeGPMXqWCffiCo6U7Uz+EdsGpIalLsYqKFoMD7enkHHT1q7Q/+VD1LLRv
         VnEC7XbvFV0ngrqoUoN8ybeV/f43La0NizowOyukYnY6/PnfjOh6Fr0NwbVVYUKZ2d5r
         Po7oV+xBvYoQWfblGuloTorS/WR8GbNAvVVaSeQfvpxHTleN7phazlQBI4xC/jB10odi
         aSuGPUiWAgBfNh6TPV5IBhbqlrui2DlDYhD7odEOg7dVhjmB1ms+HHiLz+ev++HFEllR
         S3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729034231; x=1729639031;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5/P7PU9aN7A7FFAWIBfgCyglKPdadfqEBvM4ZLHjr8=;
        b=uB1B5FM+9dlfnNiWWu65umX2YIdq73qjQfEA52YDiS0bvbJxIpTlIhfyFSr8+PX59i
         EHaV/SXENxPMkRzT7pzK43xs0/aoxLVDi48DKFjRLE2rjC3p2CNSonamUd8u34qIrAN5
         z8nc+xKbL8HhNVby7+qh8H3QNrqJFPFQlAo8hA7oUgulLSOVnvcgLzZMiPFbyvxzLHw9
         l70nSVrLiE+exHW1JpNBfODFXobb5FP0pjpRAOlhVhbJBpD3YwxOabPXvZtEaRQLMvuB
         Cl09/cs2bFLdAsJuwCNiUhrrGQUdZtjqbB+X10cQRmcF1J30xicN4XzIcfdQMEGMVX17
         hKYg==
X-Forwarded-Encrypted: i=1; AJvYcCX065VoDxx0XGoosaywDH+8+/dZhk1PtS9i0m+0Bcj6pVbcayJnPx0G9xMxcaHNEvCxFI5FDBtMqHqMNQ+H@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3PTA81x4fTqhKLSO7dn5sK8st07uEC9Pq6cUBCTBXHvk1Mqq9
	/Tnfhz0g+zXquE8jPeLX/vc46hMVtjiu9tTbJSVOWOBtPGrYwpq19yz67eoeaZcalSvPX9DlZde
	sWtL7yQ==
X-Google-Smtp-Source: AGHT+IHlcOSiFpgrtgTMZf7XD1aoOu7CIo6sCmkumbM59IPTWcpoaqCvBof0VvqlLZjwyxA/2OD2PgVfqjC/
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a25:6b43:0:b0:e1d:2043:da46 with SMTP id
 3f1490d57ef6-e29782f3106mr1614276.3.1729034230807; Tue, 15 Oct 2024 16:17:10
 -0700 (PDT)
Date: Tue, 15 Oct 2024 23:16:40 +0000
In-Reply-To: <20241015231651.3851138-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241015231651.3851138-1-mmaurer@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241015231651.3851138-7-mmaurer@google.com>
Subject: [PATCH 06/12] module: Factor out elf_validity_cache_index_mod
From: Matthew Maurer <mmaurer@google.com>
To: mcgrof@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	samitolvanen@google.com, Matthew Maurer <mmaurer@google.com>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@samsung.com>
Content-Type: text/plain; charset="UTF-8"

Centralize .gnu.linkonce.this_module detection and property validation.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 kernel/module/main.c | 129 ++++++++++++++++++++++---------------------
 1 file changed, 67 insertions(+), 62 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 6747cbc774b0..b633347d5d98 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1952,6 +1952,68 @@ static int elf_validity_cache_index_info(struct load_info *info)
 	return 0;
 }
 
+/**
+ * elf_validity_cache_index_mod() - Validates and caches this_module section
+ * @info: Load info to cache this_module on.
+ *        Must have &load_info->sechdrs and &load_info->secstrings populated
+ *
+ * The ".gnu.linkonce.this_module" ELF section is special. It is what modpost
+ * uses to refer to __this_module and let's use rely on THIS_MODULE to point
+ * to &__this_module properly. The kernel's modpost declares it on each
+ * modules's *.mod.c file. If the struct module of the kernel changes a full
+ * kernel rebuild is required.
+ *
+ * We have a few expectations for this special section, this function
+ * validates all this for us:
+ *
+ * * The section has contents
+ * * The section is unique
+ * * We expect the kernel to always have to allocate it: SHF_ALLOC
+ * * The section size must match the kernel's run time's struct module
+ *   size
+ *
+ * If all checks pass, the index will be cached in &load_info->index.mod
+ *
+ * Return: %0 on validation success, %-ENOEXEC on failure
+ */
+static int elf_validity_cache_index_mod(struct load_info *info)
+{
+	Elf_Shdr *shdr;
+	int mod_idx;
+
+	mod_idx = find_any_unique_sec(info, ".gnu.linkonce.this_module");
+	if (mod_idx <= 0) {
+		pr_err("module %s: Exactly one .gnu.linkonce.this_module section must exist.\n",
+		       info->name ?: "(missing .modinfo section or name field)");
+		return -ENOEXEC;
+	}
+
+	shdr = &info->sechdrs[mod_idx];
+
+	if (shdr->sh_type == SHT_NOBITS) {
+		pr_err("module %s: .gnu.linkonce.this_module section must have a size set\n",
+		       info->name ?: "(missing .modinfo section or name field)");
+		return -ENOEXEC;
+	}
+
+	if (!(shdr->sh_flags & SHF_ALLOC)) {
+		pr_err("module %s: .gnu.linkonce.this_module must occupy memory during process execution\n",
+		       info->name ?: "(missing .modinfo section or name field)");
+		return -ENOEXEC;
+	}
+
+	if (shdr->sh_size != sizeof(struct module)) {
+		pr_err("module %s: .gnu.linkonce.this_module section size must match the kernel's built struct module size at run time\n",
+		       info->name ?: "(missing .modinfo section or name field)");
+		return -ENOEXEC;
+	}
+
+	info->index.mod = mod_idx;
+
+	return 0;
+}
+
+
 /*
  * Check userspace passed ELF module against our expectations, and cache
  * useful variables for further processing as we go.
@@ -1977,7 +2039,6 @@ static int elf_validity_cache_copy(struct load_info *info, int flags)
 	unsigned int i;
 	Elf_Shdr *shdr;
 	int err;
-	unsigned int num_mod_secs = 0, mod_idx;
 	unsigned int num_sym_secs = 0, sym_idx;
 
 	err = elf_validity_cache_sechdrs(info);
@@ -1987,16 +2048,15 @@ static int elf_validity_cache_copy(struct load_info *info, int flags)
 	if (err < 0)
 		return err;
 	err = elf_validity_cache_index_info(info);
+	if (err < 0)
+		return err;
+	err = elf_validity_cache_index_mod(info);
 	if (err < 0)
 		return err;
 
 	for (i = 1; i < info->hdr->e_shnum; i++) {
 		shdr = &info->sechdrs[i];
-		switch (shdr->sh_type) {
-		case SHT_NULL:
-		case SHT_NOBITS:
-			continue;
-		case SHT_SYMTAB:
+		if (shdr->sh_type == SHT_SYMTAB) {
 			if (shdr->sh_link == SHN_UNDEF
 			    || shdr->sh_link >= info->hdr->e_shnum) {
 				pr_err("Invalid ELF sh_link!=SHN_UNDEF(%d) or (sh_link(%d) >= hdr->e_shnum(%d)\n",
@@ -2006,14 +2066,6 @@ static int elf_validity_cache_copy(struct load_info *info, int flags)
 			}
 			num_sym_secs++;
 			sym_idx = i;
-			fallthrough;
-		default:
-			if (strcmp(info->secstrings + shdr->sh_name,
-				   ".gnu.linkonce.this_module") == 0) {
-				num_mod_secs++;
-				mod_idx = i;
-			}
-			break;
 		}
 	}
 
@@ -2029,55 +2081,8 @@ static int elf_validity_cache_copy(struct load_info *info, int flags)
 	info->index.str = shdr->sh_link;
 	info->strtab = (char *)info->hdr + info->sechdrs[info->index.str].sh_offset;
 
-	/*
-	 * The ".gnu.linkonce.this_module" ELF section is special. It is
-	 * what modpost uses to refer to __this_module and let's use rely
-	 * on THIS_MODULE to point to &__this_module properly. The kernel's
-	 * modpost declares it on each modules's *.mod.c file. If the struct
-	 * module of the kernel changes a full kernel rebuild is required.
-	 *
-	 * We have a few expectaions for this special section, the following
-	 * code validates all this for us:
-	 *
-	 *   o Only one section must exist
-	 *   o We expect the kernel to always have to allocate it: SHF_ALLOC
-	 *   o The section size must match the kernel's run time's struct module
-	 *     size
-	 */
-	if (num_mod_secs != 1) {
-		pr_err("module %s: Only one .gnu.linkonce.this_module section must exist.\n",
-		       info->name ?: "(missing .modinfo section or name field)");
-		goto no_exec;
-	}
-
-	shdr = &info->sechdrs[mod_idx];
-
-	/*
-	 * This is already implied on the switch above, however let's be
-	 * pedantic about it.
-	 */
-	if (shdr->sh_type == SHT_NOBITS) {
-		pr_err("module %s: .gnu.linkonce.this_module section must have a size set\n",
-		       info->name ?: "(missing .modinfo section or name field)");
-		goto no_exec;
-	}
-
-	if (!(shdr->sh_flags & SHF_ALLOC)) {
-		pr_err("module %s: .gnu.linkonce.this_module must occupy memory during process execution\n",
-		       info->name ?: "(missing .modinfo section or name field)");
-		goto no_exec;
-	}
-
-	if (shdr->sh_size != sizeof(struct module)) {
-		pr_err("module %s: .gnu.linkonce.this_module section size must match the kernel's built struct module size at run time\n",
-		       info->name ?: "(missing .modinfo section or name field)");
-		goto no_exec;
-	}
-
-	info->index.mod = mod_idx;
-
 	/* This is temporary: point mod into copy of data. */
-	info->mod = (void *)info->hdr + shdr->sh_offset;
+	info->mod = (void *)info->hdr + info->sechdrs[info->index.mod].sh_offset;
 
 	/*
 	 * If we didn't load the .modinfo 'name' field earlier, fall back to
-- 
2.47.0.rc1.288.g06298d1525-goog

