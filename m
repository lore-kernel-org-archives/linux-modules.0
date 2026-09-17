Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248C751D52C
	for <linux-modules@vger.kernel.org>; Thu, 17 Sep 2026 13:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789652803; cv=none; b=owNewuyWrQ3NOJNf0JcH8/UzatwZPpKduNWQ/hvE4wJul9dhvp7Bof+R9Xz6HsDXMnvW1r5SHwp5m8RHBvrfAFHsNIl08piTIhnlDIMBlo2QRDb2hpDyw+mwnrROBM7EbjRVMoJHEQZdtcuriUsZhpEFX4sqzwVuUFYONS74kis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789652803; c=relaxed/simple;
	bh=1qxxcUfZ7Jktjmr+b9bLYWR/gKfXL8pulV77ICnkPPg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fyiRmPoA02nrKTnr525v+xJUwS2jEJvXbnn8awR7fnKGqtW/sjrQH+swTxDbcoxjI4mgb5wRxOjrW6tS6eqJb33S4CBc17eKQLTfqO06yfB2fmo5ejm1Seo0mqS6zMVoklGFUjjMF7BeYht0jScXi/eY0eclKbdV60I8YqMcUrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KmVZMZ2F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KmVZMZ2F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D25B1F00899;
	Thu, 17 Sep 2026 13:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789652790;
	bh=0+Zi6R1f1T0BQMFRG6nP5mP3lyR3vkII3z0GMvGaLmY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KmVZMZ2FCs1N+9gmeNKgCvYfUzVrQT16CnwNIKDC+qGqVnNqx9NElQ0mnLTFeOMC8
	 BwuO99mxBYjmyhMAeYgXdVGU0qxRKLSt2mTbFhiyh5KFOjk4kHYtSB89YWelKHXzMa
	 KNlq9Ejr1DoI3/QO8Mi3n4yCDHxn816TUuGn3R2UlunyZgojx4m/MHnSqcCcQD67Jy
	 pkFXP/RgkyGuHwvmY8E5XAC63Ry48LpYYwONqAr4YvSg1IrVeLywkztwyn3EGSv2JX
	 komuJNNI0NZZFUueJlWmVcc6CAWnDwc8u3JETWev5XfxdcNN6i6lzrRVxo6BUZlOwZ
	 tZrBkRuItyZ2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 2/4] kallsyms: extend lineinfo to loadable modules
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260917133727.428546-3-sashal@kernel.org>
References: <20260917133727.428546-1-sashal@kernel.org>
 <20260917133727.428546-3-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 13:46:30 +0000
Message-Id: <20260917134630.8D25B1F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] scripts: gen_lineinfo: integer overflow in relocation bounds che=
ck allows OOB access
--

commit 39f395f93fb90faf7a6d102ff862dc9fb6013c84
Author: Sasha Levin <sashal@kernel.org>

kallsyms: extend lineinfo to loadable modules

This commit adds CONFIG_KALLSYMS_LINEINFO_MODULES to extend the lineinfo
feature to loadable kernel modules. It post-processes each .ko file at
build time to embed binary tables containing section-relative offsets,
file IDs, line numbers, and filenames.

> diff --git a/scripts/gen_lineinfo.c b/scripts/gen_lineinfo.c
> --- a/scripts/gen_lineinfo.c
> +++ b/scripts/gen_lineinfo.c
[ ... ]
> +static void apply_one_debug_reloc(Elf_Data *dl_data, Elf_Data *sym_data,
> +				  bool target_le, const GElf_Ehdr *ehdr,
> +				  unsigned int abs32_type,
> +				  unsigned int abs64_type, GElf_Xword r_info,
> +				  GElf_Addr r_offset, GElf_Sxword addend,
> +				  bool has_addend, bool bias)
> +{
[ ... ]
> +	if (arith_width) {
> +		uint64_t cur;
> +
> +		if (r_offset + arith_width > dl_data->d_size)
> +			return;

[Severity: Medium]
Could an integer overflow occur here? If a malformed ELF relocation
has an r_offset near UINT64_MAX, r_offset + arith_width could wrap around
to a small value and incorrectly pass this bounds check.

Since the tool subsequently does pointer arithmetic using r_offset:
(unsigned char *)dl_data->d_buf + r_offset

Would this allow an out-of-bounds read and write on the section buffer?

> +		/*
> +		 * A delta, not an address: the section bias would appear in
> +		 * the ADD and cancel in the matching SUB, so leave it out.
> +		 */
> +		cur =3D elf_read_uint((unsigned char *)dl_data->d_buf + r_offset,
> +				    arith_width, target_le);
> +		value =3D (uint64_t)(sym.st_value + addend);
> +		cur =3D is_sub ? cur - value : cur + value;
> +		elf_write_uint((unsigned char *)dl_data->d_buf + r_offset,
> +			       cur, arith_width, target_le);
> +		return;
> +	}
> +
> +	width =3D is_abs64 ? 8 : 4;
> +
> +	if (r_offset + width > dl_data->d_size)
> +		return;

[Severity: Medium]
Similarly, can r_offset + width overflow here? A crafted .ko or .o file
might bypass this validation due to wrapping, leading to the same
out-of-bounds access on the dl_data->d_buf buffer further down.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917133727.4285=
46-1-sashal@kernel.org?part=3D2
