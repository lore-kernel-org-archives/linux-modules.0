Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2048D492E56
	for <linux-modules@vger.kernel.org>; Tue,  8 Sep 2026 23:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788909509; cv=none; b=aWfcBQ9XtUovMdSz+tM0WCpvwnUGjwIJpIzutAXNBwIUqr7euZ3AFJmqwbUYMzzZSxmdyVTx1mGTxG5d76Tpy9nWujFgWpkpNZXqJ1L5Q4yzzjQVGLQrXyMgVKt02U2CIGBEpw8gbM5KNcbzjI0wRJRJy1aZcdvyXUivTmZNNc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788909509; c=relaxed/simple;
	bh=po/oDsJwRG4/iDG/QIVzdf3+/6y3OC35LMse5qpM8t8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y/ZmmPUaSBTizxK5F38dL7/AZvLaqE080nP0rW+32qinX8dZOJoUMBzRye4IdL5KAbo6hCKZJ38A8IzEcs9PxBdPJyoc4GaaDtgXXQCFNuN2Iwy43J0EJWSTnOabO2OTC98ZYDRPjO6FmgJXSl4UPW662XXW49dthMXo4aDyVac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VxoHdC0n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VxoHdC0n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 706B01F00A3D;
	Tue,  8 Sep 2026 23:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788909507;
	bh=ojDckKsg+31WlP1/3t5UH6aoa9hfPUpLJAJU2lJJ1Bo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VxoHdC0nTeEEMPVo8S5rFFRM+r3DqUNEomsfQllh6Re1NvDB9+tBky3E9HRRrmoCN
	 uK9t1tdnMh2tSwhP1JYsybeaUUpgKpLvvkCI9bRzBvMipSjenZQhoxUUGu+6KDR31U
	 MQIbJuSuUpGKqxRu3CWAcrmUZ5JlHYp3tptFqY5bDYu2HZUdK9VTO1slvlekWnkwZA
	 FSZ6kgkozWZk1eHVwHLSxLbgD3kTkwcHGVnrrIgp5NYm8+tZ+JryUQxwM1Jl+oFbVm
	 F9OZZM2A9LKCoRYDFfjGqYbE+5jYElM+V4MUy2qBy5CLuo91VHoe+Zv7k5SZtBnQ1k
	 NVSRaUz/Amf4w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] module: reject out-of-range relocation target indices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260908230815.78409-1-kmehltretter@gmail.com>
References: <20260908230815.78409-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 23:18:26 +0000
Message-Id: <20260908231827.706B01F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A malformed ELF file with e_shnum =3D=3D 0 can bypass the section =
header array bounds check and cause an out-of-bounds read when unconditiona=
lly accessing sechdrs[0].
--

commit eb153e5069bc4f227bac013d4c0cba2f178ed824
Author: Karl Mehltretter <kmehltretter@gmail.com>

    module: reject out-of-range relocation target indices
   =20
    apply_relocations() skips relocation sections whose sh_info target index
    is outside the section table. ARM, ARM64, LoongArch, PA-RISC and RISC-V
    use sh_info earlier in module_frob_arch_sections(), before this check.

> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index d0e1e0bd2ad06..30c7a05488bc3 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c

[ ... ]

> @@ -1983,6 +1984,12 @@ static int elf_validity_cache_sechdrs(struct load_=
info *info)
>  	/* Validate contents are inbounds */
>  	for (i =3D 1; i < info->hdr->e_shnum; i++) {
>  		shdr =3D &sechdrs[i];

[Severity: High]
This is a pre-existing issue, but can a malformed ELF file with e_shnum =3D=
=3D 0
bypass the section header array bounds check and cause an out-of-bounds rea=
d?

Earlier in elf_validity_cache_sechdrs() in kernel/module/main.c, the bounds
check multiplies by e_shnum:

	if (info->hdr->e_shoff >=3D info->len
	    || (info->hdr->e_shnum * sizeof(Elf_Shdr) >
		info->len - info->hdr->e_shoff)) {

If e_shnum is 0, this evaluates to 0 and passes, failing to ensure space for
even the mandatory sechdrs[0].

Then the code computes sechdrs and unconditionally accesses sechdrs[0]:

	sechdrs =3D (void *)info->hdr + info->hdr->e_shoff;

	if (sechdrs[0].sh_type !=3D SHT_NULL
	    || sechdrs[0].sh_size !=3D 0
	    || sechdrs[0].sh_addr !=3D 0) {

If e_shoff is arbitrarily set near the end of info->len, does this
unconditional access to sechdrs[0] cross the vmalloc allocation boundary?

This could hit an unmapped guard page and cause a fatal page fault and
kernel Oops.

Could this sequence be triggered by a privileged user with CAP_SYS_MODULE
calling init_module() with an ELF file where info->len is exactly PAGE_SIZE,
e_shnum is 0, and e_shoff is PAGE_SIZE - 1?

> +		if ((shdr->sh_type =3D=3D SHT_REL || shdr->sh_type =3D=3D SHT_RELA) &&
> +		    shdr->sh_info >=3D info->hdr->e_shnum) {
> +			pr_err("Invalid ELF relocation section target index %u\n",
> +			       shdr->sh_info);
> +			return -ENOEXEC;
> +		}
>  		switch (shdr->sh_type) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908230815.7840=
9-1-kmehltretter@gmail.com?part=3D1
