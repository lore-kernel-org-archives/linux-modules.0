Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870CC4BFE86;
	Thu, 10 Sep 2026 11:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038014; cv=none; b=DhMCOfuixXQqW7VPOsDrRQLVuvgZoEe9aAQqAK9f0a2W2Mg6uEEWnXmJlE5zD9YVFPVBqpRbnyRN81/2RFWiP3SgKkf+BlSIhY13l+XPaErMXifLzgmMJOZBBED6iC6dOhp6arpZyz4fSCmK8cBKQBtMPUbgNmzSpOuOtcmbSq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038014; c=relaxed/simple;
	bh=GZBN4+Ahl7IKT5/kZ9iCf9zxj1nhJ97qfawQ0TNmcJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sLVHI/hMAA1fqkFSBnBzdHqbZXkCdQ3I8H2d8hPtASqAzrZnP9i8rtK00Lol+QxJwWQmi3gh5im46DvLnhFAnrCebEtBNMAOmyEiW7dQ9pP2biL35J1NmYxicAomPpAmjzXz9eCjoLjf6+RN8FfI+xY0/CeRrNlPsHsfPDzugww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=Ht6lbPKN; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="Ht6lbPKN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1789037970; x=1789642770; i=deller@gmx.de;
	bh=ipiRvkORDhgb0K9DjSPIxTjlIDLEzSGQK7koR9SqWFU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Ht6lbPKN+Jtericc7k1jDAZW+QydRwq4kNMzJq0h4eNXzxOQZEpT3Z09BwTiD1XV
	 De+3+3SGd0LC6Jpv6pM5CQMcXkE+E44N7ZBeUQWZDC3YmeN1gmio4hlJb4IxwrLeX
	 jjki7sAyzfC3ucIgSTgeIaS0548qmlw86XoQv8BFDNiuDX6U2xO8O8F7Bh02cfRqC
	 tADk+yM742VXdJaUNkjKFvMS2rd0zO2km2ZdsRxBhekN7G8WHDEfULrqJUOS3CrUk
	 /01kcSn85tsMDuXhFXFkNGHe72TvXo8xN2ETpRdxSHk1fCYKFKUp5hjotL+THvwOo
	 knNVDU1jMkCTrHCSKg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBDj4-1wyatz2wDm-00Ddye; Thu, 10
 Sep 2026 12:59:30 +0200
Message-ID: <a8f29668-be71-4679-a95d-55dfbd9b5c61@gmx.de>
Date: Thu, 10 Sep 2026 12:59:21 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module: reject out-of-range relocation target indices
To: Karl Mehltretter <kmehltretter@gmail.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>, Ard Biesheuvel <ardb@kernel.org>,
 Nicolas Pitre <nico@fluxnic.net>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-modules@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
 linux-riscv@lists.infradead.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260908230815.78409-1-kmehltretter@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260908230815.78409-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5IENoiXa8Ku7yh9lQUtq4iHgOYgaIUBDuUfO5NH2zNz1XcLrYgf
 v2nRXlRxIMulnKyk2R9mUmKE5IqfwpCRypiB8C6uW4q2GHKVKCX+6XSooSW7TCTnPNbETfx
 Qw8HJAz7JbQNDm/o3+DcMYJP+i5rkFuScX4pvwouUJFfDQ73403tHRZ0X5KSpV0w68Uv8sB
 Wxr+Uo/m7YMUtkR/dFoDw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GxFcy/Bx5c0=;aO98q13FhKhr9q+t+9YN0465ei9
 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

On 9/9/26 01:08, Karl Mehltretter wrote:
> apply_relocations() skips relocation sections whose sh_info target index
> is outside the section table. ARM, ARM64, LoongArch, PA-RISC and RISC-V
> use sh_info earlier in module_frob_arch_sections(), before this check.
>
> ARM, ARM64, LoongArch and RISC-V use the unchecked index to read
> sh_flags outside the section header table. PA-RISC uses it to index an
> e_shnum-sized heap array for a read and an update. QEMU reproduced
> page-fault Oopses on ARM, ARM64, LoongArch and RISC-V, and a Data TLB
> miss on the PA-RISC array read.
>=20
> Validate sh_info for SHT_REL and SHT_RELA sections in
> elf_validity_cache_sechdrs(). Reject the module with ENOEXEC before
> architecture code can use the index.
>=20
> Fixes: c298be74492b ("parisc: fix module loading failure of large kernel=
 modules")
> Fixes: 7d485f647c1f ("ARM: 8220/1: allow modules outside of bl range")
> Fixes: fd045f6cd98e ("arm64: add support for module PLTs")
> Fixes: ab1ef68e5401 ("RISC-V: Add sections of PLT and GOT for kernel mod=
ule")
> Fixes: fcdfe9d22bed ("LoongArch: Add ELF and module support")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>=20
> A custom harness for upstream Frama-C 33.0 (Arsenic) Eva found the
> ARM32 instance in a source-identical ARM module_frob_arch_sections()
> slice. Eva reported the out-of-range section-table pointer and sh_flags
> access.
>=20
> The analysis and ARM32 A/B test ran at Linux b9b3e33b70b7 ("Merge tag
> 'trace-v7.2-rc6' of
> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace"). The
> PA-RISC, ARM64, RISC-V, LoongArch and x86_64 A/B tests ran at the
> declared base commit, 28924df2a08f. arch/arm/kernel/module-plts.c and
> the touched loop in kernel/module/main.c are identical between the two
> commits.
>=20
> Each A/B test changed only a relocation section's sh_info to
> 0x10000000. The same configurations and modules were used before and
> after the change. All controls loaded before and after the change. The
> fixed kernels rejected the malformed modules with ENOEXEC.
>=20
> Original-kernel results with QEMU 10.2.1 TCG:
>=20
> - ARM32, virt/Cortex-A15, GCC 15.2.0, multi_v7_defconfig plus
>    VMSPLIT_2G: page fault at module_frob_arch_sections()+0x160.
> - ARM64, virt/Cortex-A57, GCC 15.2.0, defconfig: page fault at
>    module_frob_arch_sections()+0x110.
> - PA-RISC, B160L, hppa-linux-gcc 8.1.0, binutils 2.30,
>    generic-32bit_defconfig: Data TLB miss at
>    module_frob_arch_sections()+0x11c on the stub_entries read for a
>    counted R_PARISC_PCREL17F relocation.
> - RISC-V, virt, GCC 15.2.0, defconfig plus RELOCATABLE with
>    MODULE_SECTIONS enabled: page fault at
>    module_frob_arch_sections()+0xe4.
> - LoongArch, virt/LA464, LLVM 21.1.8, loongson64_defconfig: page fault
>    at module_frob_arch_sections()+0x1b8.
>=20
> On x86_64, which has no vulnerable early sh_info access, the original
> kernel loaded both modules. The fixed kernel loaded the control and
> rejected the malformed module with ENOEXEC. The test used pc/qemu64,
> x86_64_defconfig and GCC 15.2.0.

Interesting.
So, this patch helps to prevent loading modules with buggy entries,
even if the module was e.g. loaded on x86-64 before.

For me the patch is OK, but it only adds one random sanitizing check,
and where would we stop to check?

> ---
>   kernel/module/main.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>=20
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index d0e1e0bd2ad0..30c7a05488bc 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -1933,6 +1933,7 @@ static int elf_validity_ehdr(const struct load_inf=
o *info)
>    * * Section array fits in the user provided data
>    * * Section index 0 is NULL
>    * * Section contents are inbounds
> + * * Relocation section target indices are inbounds
>    *
>    * Then updates @info with a &load_info->sechdrs pointer if valid.
>    *
> @@ -1983,6 +1984,12 @@ static int elf_validity_cache_sechdrs(struct load=
_info *info)
>   	/* Validate contents are inbounds */
>   	for (i =3D 1; i < info->hdr->e_shnum; i++) {
>   		shdr =3D &sechdrs[i];
> +		if ((shdr->sh_type =3D=3D SHT_REL || shdr->sh_type =3D=3D SHT_RELA) &=
&
> +		    shdr->sh_info >=3D info->hdr->e_shnum) {
> +			pr_err("Invalid ELF relocation section target index %u\n",
> +			       shdr->sh_info);

Suggestion:
Print the module name too, otherwise it's hard to find out later which mod=
ule is broken.

Helge

> +			return -ENOEXEC;
> +		}
>   		switch (shdr->sh_type) {
>   		case SHT_NULL:
>   		case SHT_NOBITS:
>=20
> base-commit: 28924df2a08f440c73991b83028032c901de2ae4

