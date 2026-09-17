Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E5D53FD2A
	for <linux-modules@vger.kernel.org>; Thu, 17 Sep 2026 13:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789652914; cv=none; b=Bzb+Zw+z13VrafKlLCYAj/KYA8Di6ChOsdSmOpOY4avFzbUea700NE8KXn08K3ZyITc+DackecEWf1w2Xb8OB2xgp/h6BkjwHcb5FhfUtGax4iFxe+pRC9iFm7tHo1XOwu9JB9/P4vRsrDwDXoWjkypR6Skkxuz+mgQgC08y1Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789652914; c=relaxed/simple;
	bh=i4x3wPdZ5JYK8YnKWmSnCMI5NYvU+8MHCqOs6NnBwoE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=K5baz1gno1XYG7UrsoEsdr0xJPohRjJB/VObp3nnhhlw2kb9Qs73Hg8qKPK83BtxJuNZFSl91Ns3nOgsOfye+tQ2Wge4MkPLzo/2QWQQog8nlD1EgJYAe9MVWwe4GreqIfYYjrlTsS+S4OMOlAx9gadal+FuwhprzXUS3UqKU08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aL/wCTu7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aL/wCTu7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D411F00893;
	Thu, 17 Sep 2026 13:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789652906;
	bh=AwOL6H/ighqekqE6mTsIsfmQo/VpusOu08k5Mn4QSsY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aL/wCTu7lRcKUMvbDmQfVH+TCoOYjaiETryQFMOqzdL2N9+8f47bUWrMmzAvL9IG1
	 zX3bImyOvSDNAGmbKHL6PkOOd0P3AZ8nGa+wP5uh7n9F1YM4kWyqY4XgNeuw/d1Frk
	 CfFR3MfAYhu3hCumPkU6l9Ym93p+tt6tNlE2RdiZuS80s1TSaVpoCtXH5uzfcPtZ5t
	 O0tIxn94jgX3diajeSJ3guIIQ2BUAf/Db6RIDhbKmh9RtSraAC+0eRx+MMswPYshjk
	 pX8opQxGMrecKA/g3vMCeftheTWxmvgQys3fGZArfaB1NrrU7x48xs9xkgJdzTXmoi
	 YbftAygSJY6Bg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 1/4] kallsyms: embed source file:line info in kernel
 stack traces
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260917133727.428546-2-sashal@kernel.org>
References: <20260917133727.428546-1-sashal@kernel.org>
 <20260917133727.428546-2-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 13:48:25 +0000
Message-Id: <20260917134826.62D411F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] scripts: division by zero in find_vmlinux_sym() due to missing sh_e=
ntsize check
- [Low] scripts: memory leak of dynamically allocated arrays at exit
--

commit 37641e6c997ac852eedac002b430b40b946dc18d
Author: Sasha Levin <sashal@kernel.org>
Subject: kallsyms: embed source file:line info in kernel stack traces

This commit adds CONFIG_KALLSYMS_LINEINFO, which embeds DWARF-derived
address-to-line mappings directly into the kernel image. A new host tool
(scripts/gen_lineinfo) extracts this info from vmlinux using libdw. The
stack traces will then directly print file and line numbers.

> diff --git a/scripts/gen_lineinfo.c b/scripts/gen_lineinfo.c
> new file mode 100644
> --- /dev/null
> +++ b/scripts/gen_lineinfo.c

[ ... ]

> +static unsigned long long find_vmlinux_sym(Elf *elf, const char *name,
> +					   unsigned long long fallback,
> +					   bool required)
> +{
> +	size_t nsyms, i;
> +	Elf_Scn *scn =3D NULL;
> +	GElf_Shdr shdr;
> +
> +	while ((scn =3D elf_nextscn(elf, scn)) !=3D NULL) {
> +		Elf_Data *data;
> +
> +		if (!gelf_getshdr(scn, &shdr))
> +			continue;
> +		if (shdr.sh_type !=3D SHT_SYMTAB)
> +			continue;
> +
> +		data =3D elf_getdata(scn, NULL);
> +		if (!data)
> +			continue;
> +
> +		nsyms =3D shdr.sh_size / shdr.sh_entsize;

[Severity: Low]
Can this division cause a crash if a malformed ELF file is encountered?

If the vmlinux ELF file is malformed and contains an SHT_SYMTAB section
where shdr.sh_entsize is zero, this will result in a division by zero and
a SIGFPE crash. Other functions in this file, such as
collect_symbol_starts(), appear to validate !shdr.sh_entsize before
performing this division. Should this loop skip sections with a zero
sh_entsize as well?

[ ... ]

> +int main(int argc, char *argv[])
> +{

[ ... ]

> +	/* Cleanup */
> +	free(entries);
> +	free(sym_starts);
> +	free(seq_ends);
> +	for (unsigned int i =3D 0; i < num_files; i++)
> +		free(files[i]);
> +	free(files);
> +
> +	return 0;
> +}

[Severity: Low]
Does this cleanup block miss some dynamically allocated arrays?

The main() function allocates text_starts, asm_spans, and cu_row_seq_end
during execution, but omits freeing them here. While the OS reclaims memory
upon process exit (making the leak relatively harmless for a short-lived
build tool), the presence of a dedicated cleanup block implies an intent to
achieve a clean memory leak check. Could text_starts, asm_spans, and
cu_row_seq_end be added to this cleanup section?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917133727.4285=
46-1-sashal@kernel.org?part=3D1
