Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A20A334692;
	Thu, 10 Sep 2026 16:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789057226; cv=none; b=YJ5QLp9inVpH+vcbGMgOIkh9WfIPHri6yZx5QQbOoZYrj+l6JaLDZYGIxvs0jgEVPf2i9GaMFJyj0dGSDBpeD+IMUdOl8fzlNiT5fOW0ycTJAcxiFBLY2yi51DMaLR3MZ22s/7GOQyvz+NsyvIPt7R4BQb42eAHn7zpbka2ogvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789057226; c=relaxed/simple;
	bh=Eh2t79fGoNYzVTayHaBw7iqMWAqqtTzT2Efx0yoJY8c=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=OxAYHt3WZuL/+AWuu0EVJVjdKUEVptU22q16q8+Cq9ryu+JNTI6FUR5YWIj2FHBSOHoZdCYkKIPobf9ZopV/GMO7B1m6zHjZRJaOX01iI4uJYNV7ucclfVPG3M6EjsnNHpltr344sJoPEqStZH0qUZkZQ1FdKvKNsBXjLRJvErY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.helo=mail.mainlining.org; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.helo=mail.mainlining.org
Date: Thu, 10 Sep 2026 17:19:56 +0100
From: Bradley Morgan <brads@mainlining.org>
To: kmehltretter@gmail.com
CC: James.Bottomley@HansenPartnership.com, alex@ghiti.fr, aou@eecs.berkeley.edu,
 ardb@kernel.org, atomlin@atomlin.com, catalin.marinas@arm.com,
 chenhuacai@kernel.org, da.gomez@kernel.org, deller@gmx.de,
 jiaxun.yang@flygoat.com, kernel@xen0n.name,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux@armlinux.org.uk,
 loongarch@lists.linux.dev, mark.rutland@arm.com, mcgrof@kernel.org,
 nico@fluxnic.net, palmer@dabbelt.com, petr.pavlu@suse.com, pjw@kernel.org,
 samitolvanen@google.com, will@kernel.org
Subject: Re: [PATCH] module: reject out-of-range relocation target indices
In-Reply-To: <20260908230815.78409-1-kmehltretter@gmail.com>
Message-ID: <1C79D3C8-4B53-4B62-A14D-5DC1860F8099@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 9 September 2026 00:08:15 BST, Karl Mehltretter <kmehltretter@gmail.com>
wrote:
>apply_relocations() skips relocation sections whose sh_info target index
>is outside the section table. ARM, ARM64, LoongArch, PA-RISC and RISC-V
>use sh_info earlier in module_frob_arch_sections(), before this check.
>
>ARM, ARM64, LoongArch and RISC-V use the unchecked index to read
>sh_flags outside the section header table. PA-RISC uses it to index an
>e_shnum-sized heap array for a read and an update. QEMU reproduced
>page-fault Oopses on ARM, ARM64, LoongArch and RISC-V, and a Data TLB
>miss on the PA-RISC array read.
>
>Validate sh_info for SHT_REL and SHT_RELA sections in
>elf_validity_cache_sechdrs(). Reject the module with ENOEXEC before
>architecture code can use the index.
>
>Fixes: c298be74492b ("parisc: fix module loading failure of large kernel modules")
>Fixes: 7d485f647c1f ("ARM: 8220/1: allow modules outside of bl range")
>Fixes: fd045f6cd98e ("arm64: add support for module PLTs")
>Fixes: ab1ef68e5401 ("RISC-V: Add sections of PLT and GOT for kernel module")
>Fixes: fcdfe9d22bed ("LoongArch: Add ELF and module support")
>Cc: stable@vger.kernel.org
>Assisted-by: LLM
>Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

I don't think so, sorry, see below.

>---
>
>A custom harness for upstream Frama-C 33.0 (Arsenic) Eva found the
>ARM32 instance in a source-identical ARM module_frob_arch_sections()
>slice. Eva reported the out-of-range section-table pointer and sh_flags
>access.
>
>The analysis and ARM32 A/B test ran at Linux b9b3e33b70b7 ("Merge tag
>'trace-v7.2-rc6' of
>git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace"). The
>PA-RISC, ARM64, RISC-V, LoongArch and x86_64 A/B tests ran at the
>declared base commit, 28924df2a08f. arch/arm/kernel/module-plts.c and
>the touched loop in kernel/module/main.c are identical between the two
>commits.
>
>Each A/B test changed only a relocation section's sh_info to
>0x10000000. The same configurations and modules were used before and
>after the change. All controls loaded before and after the change. The
>fixed kernels rejected the malformed modules with ENOEXEC.
>
>Original-kernel results with QEMU 10.2.1 TCG:
>
>- ARM32, virt/Cortex-A15, GCC 15.2.0, multi_v7_defconfig plus
>  VMSPLIT_2G: page fault at module_frob_arch_sections()+0x160.
>- ARM64, virt/Cortex-A57, GCC 15.2.0, defconfig: page fault at
>  module_frob_arch_sections()+0x110.
>- PA-RISC, B160L, hppa-linux-gcc 8.1.0, binutils 2.30,
>  generic-32bit_defconfig: Data TLB miss at
>  module_frob_arch_sections()+0x11c on the stub_entries read for a
>  counted R_PARISC_PCREL17F relocation.
>- RISC-V, virt, GCC 15.2.0, defconfig plus RELOCATABLE with
>  MODULE_SECTIONS enabled: page fault at
>  module_frob_arch_sections()+0xe4.
>- LoongArch, virt/LA464, LLVM 21.1.8, loongson64_defconfig: page fault
>  at module_frob_arch_sections()+0x1b8.
>
>On x86_64, which has no vulnerable early sh_info access, the original
>kernel loaded both modules. The fixed kernel loaded the control and
>rejected the malformed module with ENOEXEC. The test used pc/qemu64,
>x86_64_defconfig and GCC 15.2.0.
>---
> kernel/module/main.c | 7 +++++++
> 1 file changed, 7 insertions(+)
>
>diff --git a/kernel/module/main.c b/kernel/module/main.c
>index d0e1e0bd2ad0..30c7a05488bc 100644
>--- a/kernel/module/main.c
>+++ b/kernel/module/main.c
>@@ -1933,6 +1933,7 @@ static int elf_validity_ehdr(const struct load_info *info)
>  * * Section array fits in the user provided data
>  * * Section index 0 is NULL
>  * * Section contents are inbounds
>+ * * Relocation section target indices are inbounds
>  *
>  * Then updates @info with a &load_info->sechdrs pointer if valid.
>  *
>@@ -1983,6 +1984,12 @@ static int elf_validity_cache_sechdrs(struct load_info *info)
> 	/* Validate contents are inbounds */
> 	for (i = 1; i < info->hdr->e_shnum; i++) {
> 		shdr = &sechdrs[i];
>+		if ((shdr->sh_type == SHT_REL || shdr->sh_type == SHT_RELA) &&
>+		    shdr->sh_info >= info->hdr->e_shnum) {
>+			pr_err("Invalid ELF relocation section target index %u\n",
>+			       shdr->sh_info);
>+			return -ENOEXEC;
>+		}
> 		switch (shdr->sh_type) {
> 		case SHT_NULL:
> 		case SHT_NOBITS:

If the module passes the signature check and the blacklist check, the
kernel would assume that the module is fine and ^W^W^W^W won't blow the
whole
world up^W^W^W^W^W

Since module_frob_arch_sections() loads AFTER said checks pass, adding
checks is just useless bloat imho.

NAK, sorry


>
>base-commit: 28924df2a08f440c73991b83028032c901de2ae4
>

--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
