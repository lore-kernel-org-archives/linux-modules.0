Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D062F8E85
	for <linux-modules@vger.kernel.org>; Sat, 30 May 2026 15:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780156562; cv=none; b=ZUjxLRO3YtUcWMBBHP4TeW+HOsu2TANmOgOrxbZ4kbakNfHhtIGSzYflEnO7KNYIeQnmBDNT9SZq3mvTalVxH3ACRliKLWRoiXk+fPuWHFN3l6d8Mu5alkK3t8qmPn2ppdUgHEU4AFfd7ysgnTf6EGpXOeJcd9l2ISgUOazeUow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780156562; c=relaxed/simple;
	bh=49diSm0PLFW8UguWtFSjd5MLm7awxZVRxqaKWvGrgM0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Sg5W3ozKVBiYdGDT+dKBJ/bA08+5LdS4XDV81pFX61ZKf6T8yGul3bRd3bIN+QN6UGNgLjfFpjxww0dqbUGj2/dNRvTynDH2pKm5HTYgu+a9Zz13hNlaemq54tgPzcUtzB+fjjyLCCIzGe6fRjlgKzlUvgDSXX0Y+dhF6ay6JF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Igk0GyuO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Igk0GyuO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74901F00893;
	Sat, 30 May 2026 15:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780156560;
	bh=47FRlhr4lLDLGcldCmy4ksl15B/hQmuf6g8VNhXI62o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Igk0GyuOtF4Yf01wJG+oVQDs1JXghPoHPQcEUSpVf+ozj1C/kgkBAy1dMWe/7G3MT
	 4oo55NDYe8I9x1n8yGNs8pPPO/EKCu4Ry5fxPz18thNbFNviHeH+EY44gioS3IRjAq
	 fxD8GV4HIWOqdI3h20Id1bfTXJcz6l91Pa9KtgCuDJuFs6N1vbLBkNHhFzSQrU3VGG
	 Ztbc6GWWAAAU3D4V5vWExJuUcPMlD55RwpuShv7SFFz6/1xxOCgh5Rh8DxC1LMCcGG
	 a2F9oQUhh3j0XhEIchbJsRr0uEdQJwzLRb/1mW7C3sdWFNrHO8AimnINGVEsuQFKEf
	 EN+FfgXpQsI7Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] ARM: module.lds: fix unwind metadata for merged
 .text sections
Reply-To: sashiko-reviews@lists.linux.dev
To: Egg12138 <egg12138@foxmail.com>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <tencent_08845B64E5F38EB7FA1779982A071AB4A607@qq.com>
References: <tencent_08845B64E5F38EB7FA1779982A071AB4A607@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 15:56:00 +0000
Message-Id: <20260530155600.A74901F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing NULL check on the return value of `unwind_table_add()` in =
`module_finalize()` causes a kernel panic on memory allocation failure.
--

commit 0098f68f3e89e8e569da9c5eaaa9486505d4ea3d
Author: Xiao Junzhe <egg12138@foxmail.com>

ARM: module.lds: fix unwind metadata for merged .text sections

Commit 1ba9f8979426 ("vmlinux.lds: Unify TEXT_MAIN, DATA_MAIN,
and related macros") made scripts/module.lds.S merge module input
.text.* sections into the output .text section. On ARM, the paired
unwind input sections keep their original names. This commit ensures
the ARM module unwind output names stay in sync with the text sections.

> diff --git a/arch/arm/include/asm/module.lds.h b/arch/arm/include/asm/mod=
ule.lds.h
> index 0e7cb4e314b48..1d56c0375c18b 100644
> --- a/arch/arm/include/asm/module.lds.h
> +++ b/arch/arm/include/asm/module.lds.h
> @@ -1,4 +1,16 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifdef CONFIG_ARM_UNWIND
> +SECTIONS {
> +	.ARM.extab		0 : {
> +		*(.ARM.extab .ARM.extab.text .ARM.extab.text.[0-9a-zA-Z_]*)
> +	}
> +	.ARM.exidx		0 : {
> +		*(.ARM.exidx .ARM.exidx.text .ARM.exidx.text.[0-9a-zA-Z_]*)
> +	}
> +}
> +#endif

[Severity: High]
This is a pre-existing issue and was not introduced by the patch under revi=
ew,
but while reviewing how ARM module unwind tables are registered, I noticed a
potential concern in arch/arm/kernel/module.c:

arch/arm/kernel/module.c:module_finalize() {
    ...
		if (txt_sec) {
			struct unwind_table *table =3D
				unwind_table_add(s->sh_addr,
						s->sh_size,
						txt_sec->sh_addr,
						txt_sec->sh_size);

			list_add(&table->mod_list, unwind_list);
    ...
}

Does this code safely handle a null return from unwind_table_add?

If unwind_table_add fails to allocate memory, it returns a null pointer.
Passing that directly to list_add causes an offset-based dereference of nul=
l.

Could this trigger a kernel panic during module loading if the system is out
of memory?

> +
>  #ifdef CONFIG_ARM_MODULE_PLTS
>  SECTIONS {
>  	.plt : { BYTE(0) }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_08845B64E5F=
38EB7FA1779982A071AB4A607@qq.com?part=3D1
