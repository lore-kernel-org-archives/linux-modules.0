Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61443CB560
	for <linux-modules@vger.kernel.org>; Sat, 22 Aug 2026 13:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787406856; cv=none; b=IWVqT9AP1+vOuveaQpkX8WaOm6V4EsOElImGjf9CN1rmQnvJYB/f5EuqYwnZqy0NqccxZtuqTwQR8Yz3TMxUkTil5KF0D4PnU9g7WojBZf5W5QsQVsQYH1MUnhlHeC7vdoDC8jZ6OL3fZdDa8D0Cihdn3gKdFfams1VJN2XbiuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787406856; c=relaxed/simple;
	bh=uFMxGHqEPW0hVIsajDV+q6/mim0jiwVFeEB2HYV1iUU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h/or5U+9RRUt4jDcDwnPAnT/0p4ovtYnXGmJEheLSrB9jox5k4jayGEfxyuBmcA0NWMkGRN1shdyzoDcLXkbLz3uK0afmsGvJh4kiC1+ggr8+dXONVk4vXArQ42R41rXSkgTkha2ACcNugQRPZc25iGaPgrZQRl2BdQUvQCo7BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FruUrbuA; arc=none smtp.client-ip=209.85.221.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FruUrbuA"
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47f7039fa59so1433823f8f.1
        for <linux-modules@vger.kernel.org>; Sat, 22 Aug 2026 06:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787406852; x=1788011652; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uCGSy80EkADOYqRdnClxXtF6MDWdUJROODWOao0NQ9A=;
        b=FruUrbuAwb46nyY5h8NAf0SLadstvYO6lvl2ceuuRN7b6YFwdw6rTSOppjojW1JkYp
         Q/KGA2u55Lfv13HXkANm8y7G48Owx6oEgnzCn72+cTbfmIZ/j0WIb4KiiAZMtlz9kP6X
         yHG6wBh2pbxitXW6X4+e76LKm2P+lw+NIggts7aQaQCOrhc9e65X9PnUKe+IpzWTLaS5
         7HMyPLFgcxweZA/DKcuw9awko9wD0DmqJ52PGeNSRgusTmdueI4k2gsF+eVmTjIF4BeN
         U8svjdE46rdYyVL2wDyj6N+XaobcWmvu2vcAeOrWvTz+w8Cm7KsY8117XEkputMoQ7KC
         5ByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787406852; x=1788011652;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uCGSy80EkADOYqRdnClxXtF6MDWdUJROODWOao0NQ9A=;
        b=oUmVoUuvFahbtVC44lnNOe9NMMU9KBDosxAeuCOMYQM7fjvSk+fSEUcdMyA5wj7lvh
         V+02jIdAbnpiJ5FuW+8seflPjIaDwIStlsCS4FzDSL8h2x1aJbNJW7iaSR/HSozhqsfD
         JBW11znCb8QJWoYP3Mk9K5jjS9TF5UWFqq7cBsDEmqJYxqZf0NNA3PF07fGmovYU6tnA
         8KScMMOwsOdN7RKOu7gFaB/hNogA0WA86AO/+0c758tGSl3HVZhbgtI9wjfm42WIlsiU
         DXT2PvWes42sM8mXrqm5HqMyunj6t0JTLOrbKIIxSao9cZkO6gMPzpHB5JNc3qFvRexq
         whXw==
X-Forwarded-Encrypted: i=1; AHgh+RppBLbmIxmvAXQSCDTiqjn++ijpaab5hnJjt7XFVzfQF1iWfiVytYbAML1hgZKLwV0boRKta79EyGo0PU++@vger.kernel.org
X-Gm-Message-State: AFuF++nmzjYmpwR/9col7tOF6xmE0UrRkvFpq3wo7AjslQuQhU8FaoPf
	90MRmah4FhxvTSevLpupGVlH5pPfuuPWojxcVdPMyIDaUFvnokp4DXdDFWI6fCqLZz6UCDA2XQ=
	=
X-Received: from wrtv12.prod.google.com ([2002:a5d:610c:0:b0:47f:76fc:f05a])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:2589:b0:482:bf17:e685
 with SMTP id ffacd0b85a97d-482c0b88f19mr19709898f8f.11.1787406851530; Sat, 22
 Aug 2026 06:54:11 -0700 (PDT)
Date: Sat, 22 Aug 2026 15:53:29 +0200
In-Reply-To: <20260822135323.795946-11-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260822135323.795946-11-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4579; i=ardb@kernel.org;
 h=from:subject; bh=BEHgSt5XbzXt4tBoZXsq5UPFvM43IOdkHorxrjqha9w=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIatz5b2w6FXrAkIL3p777u+w3ijm62ajN4vezjfYEpZQl
 u7w99y6jlIWBjEuBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCRA0mMDO0W8Xtjiy5zcH03
 q/x9b5GHzca9Bgf6WzaZLIo6+FaheSUjw3TVOf/Ejuza9aHbfV1D3U6jyXpCKevnz9LVlc13Lr4 txwYA
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed-goog
Message-ID: <20260822135323.795946-18-ardb+git@google.com>
Subject: [RFC PATCH 7/9] arm64: ftrace: Revert "fix unreachable PLT for
 ftrace_caller ..."
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, "=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

This reverts commit a7ed7b9d0ebb038db9963d574da0311cab0b666a, which is
no longer needed now that the corner case where .init.text is placed out
of direct branching range from .text of the same module can no longer
occur.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/module.h     |  1 -
 arch/arm64/include/asm/module.lds.h |  1 -
 arch/arm64/kernel/ftrace.c          | 13 +++----------
 arch/arm64/kernel/module-plts.c     | 12 +-----------
 arch/arm64/kernel/module.c          | 11 -----------
 5 files changed, 4 insertions(+), 34 deletions(-)

diff --git a/arch/arm64/include/asm/module.h b/arch/arm64/include/asm/module.h
index fb9b88eebeb1..79550b22ba19 100644
--- a/arch/arm64/include/asm/module.h
+++ b/arch/arm64/include/asm/module.h
@@ -19,7 +19,6 @@ struct mod_arch_specific {
 
 	/* for CONFIG_DYNAMIC_FTRACE */
 	struct plt_entry	*ftrace_trampolines;
-	struct plt_entry	*init_ftrace_trampolines;
 };
 
 u64 module_emit_plt_entry(struct module *mod, Elf64_Shdr *sechdrs,
diff --git a/arch/arm64/include/asm/module.lds.h b/arch/arm64/include/asm/module.lds.h
index 0b3aacd22c59..0c3aea98e116 100644
--- a/arch/arm64/include/asm/module.lds.h
+++ b/arch/arm64/include/asm/module.lds.h
@@ -2,7 +2,6 @@ SECTIONS {
 	.plt 0 : { BYTE(0) }
 	.init.plt 0 : { BYTE(0) }
 	.text.ftrace_trampoline 0 : { BYTE(0) }
-	.init.text.ftrace_trampoline 0 : { BYTE(0) }
 
 #ifdef CONFIG_KASAN_SW_TAGS
 	/*
diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index 5a1554a44162..b56da24c1be4 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -258,17 +258,10 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
 	return ftrace_modify_code(pc, 0, new, false);
 }
 
-static struct plt_entry *get_ftrace_plt(struct module *mod, unsigned long addr)
+static struct plt_entry *get_ftrace_plt(struct module *mod)
 {
 #ifdef CONFIG_MODULES
-	struct plt_entry *plt = NULL;
-
-	if (within_module_mem_type(addr, mod, MOD_INIT_TEXT))
-		plt = mod->arch.init_ftrace_trampolines;
-	else if (within_module_mem_type(addr, mod, MOD_TEXT))
-		plt = mod->arch.ftrace_trampolines;
-	else
-		return NULL;
+	struct plt_entry *plt = mod->arch.ftrace_trampolines;
 
 	return &plt[FTRACE_PLT_IDX];
 #else
@@ -339,7 +332,7 @@ static bool ftrace_find_callable_addr(struct dyn_ftrace *rec,
 	if (WARN_ON(!mod))
 		return false;
 
-	plt = get_ftrace_plt(mod, pc);
+	plt = get_ftrace_plt(mod);
 	if (!plt) {
 		pr_err("ftrace: no module PLT for %ps\n", (void *)*addr);
 		return false;
diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
index 7afd370da9f4..bde32979c06a 100644
--- a/arch/arm64/kernel/module-plts.c
+++ b/arch/arm64/kernel/module-plts.c
@@ -283,7 +283,7 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 	unsigned long core_plts = 0;
 	unsigned long init_plts = 0;
 	Elf64_Sym *syms = NULL;
-	Elf_Shdr *pltsec, *tramp = NULL, *init_tramp = NULL;
+	Elf_Shdr *pltsec, *tramp = NULL;
 	int i;
 
 	/*
@@ -298,9 +298,6 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 		else if (!strcmp(secstrings + sechdrs[i].sh_name,
 				 ".text.ftrace_trampoline"))
 			tramp = sechdrs + i;
-		else if (!strcmp(secstrings + sechdrs[i].sh_name,
-				 ".init.text.ftrace_trampoline"))
-			init_tramp = sechdrs + i;
 		else if (sechdrs[i].sh_type == SHT_SYMTAB)
 			syms = (Elf64_Sym *)sechdrs[i].sh_addr;
 	}
@@ -366,12 +363,5 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 		tramp->sh_size = NR_FTRACE_PLTS * sizeof(struct plt_entry);
 	}
 
-	if (init_tramp) {
-		init_tramp->sh_type = SHT_NOBITS;
-		init_tramp->sh_flags = SHF_EXECINSTR | SHF_ALLOC;
-		init_tramp->sh_addralign = __alignof__(struct plt_entry);
-		init_tramp->sh_size = NR_FTRACE_PLTS * sizeof(struct plt_entry);
-	}
-
 	return 0;
 }
diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index 24adb581af0e..6e5b488a219e 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -466,17 +466,6 @@ static int module_init_ftrace_plt(const Elf_Ehdr *hdr,
 	__init_plt(&plts[FTRACE_PLT_IDX], FTRACE_ADDR);
 
 	mod->arch.ftrace_trampolines = plts;
-
-	s = find_section(hdr, sechdrs, ".init.text.ftrace_trampoline");
-	if (!s)
-		return -ENOEXEC;
-
-	plts = (void *)s->sh_addr;
-
-	__init_plt(&plts[FTRACE_PLT_IDX], FTRACE_ADDR);
-
-	mod->arch.init_ftrace_trampolines = plts;
-
 #endif
 	return 0;
 }
-- 
2.55.0.860.g4b6b3295ed-goog

