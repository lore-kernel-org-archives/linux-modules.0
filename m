Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198AB276041
	for <linux-modules@vger.kernel.org>; Sat,  1 Aug 2026 14:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785595175; cv=none; b=NIdyiUxRvayZOQbXEdKk17V7jiK9jLrQpMXBIvKENPG7tgO859QzB6g0tfeH1D5xuqM7CpfK42ZFUfAjbChEGmj4wH3Nagrl3RPsZ08yOirOYK7B5FkIdycVeXzDPPquSNR4AWwkYek9teFzOWDmvDpnX67E8NOAcNn7tCRu7XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785595175; c=relaxed/simple;
	bh=SB78r8uXdVVAfTnWPkqJs61wSO82ZPc/deyxw45EHpI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c0fxskuofZY+XrI37h9M4aZjz+qSKi5pdAqDKIK8Ng8taPy2xUlJ6eDirYIRVsfuXjkvmN2XBw1JWz87m9ZwAY/WuuVpbnZB7EZoBGoWnpcTT3rCsS1yU1HBMIp1qYY6I7mX01Js11R0p2XKi3LFzNM9E6hAhyFQlhyl4fya6Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yejb1dQx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yejb1dQx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B7C1F00AC4;
	Sat,  1 Aug 2026 14:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785595173;
	bh=EZJ+Ll3WJOfRcovQW/nbNKrLU/+G+GC9XZn7s5JE1D4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Yejb1dQxHHIGf92BLC7GkgpBW2+Tgrw8DzIZhdjdRWF7YjM++LRwJr4LnmsB94cMc
	 CQ7C0pUrjX1em4RwtRqyyTSlrGivzpO5qvYKwASAmoW04p974jDGpcWYNkAZI4PsJ+
	 AJ7c9u6HeGN5gf4FSQr/387aDrI40PIRAEgBHEp1Kwy3mZGLuofJVdXq4+JkK0wX6M
	 l9A2s8HQpNm9NAK6WEgmRQDWIXJ6Y2IHaMlGw3QUhFTh/r5dA26U+0AqgTXnZOkXIY
	 b1Mw7U0nGWsuVp0rvRK2xrBKPLlOVI1L2XcaTVHaT1lE8LetE5DHQ7PYFzhivZEIRs
	 Uc3ad7il+61ug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/4] kallsyms: delta-compress lineinfo tables for
 ~2.7x size reduction
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260801143219.3975824-4-sashal@kernel.org>
References: <20260801143219.3975824-1-sashal@kernel.org>
 <20260801143219.3975824-4-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 14:39:33 +0000
Message-Id: <20260801143933.95B7C1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing alignment validation for inner offsets `blocks_offset` a=
nd `files_offset` from the module lineinfo header, risking fatal alignment =
traps.
--

--- Patch [3]: [PATCH v8 3/4] kallsyms: delta-compress lineinfo tables for =
~2.7x size reduction ---
commit cc36cd56474b921c9564d160db461d97e0550634
Author: Sasha Levin <sashal@kernel.org>

kallsyms: delta-compress lineinfo tables for ~2.7x size reduction

This commit replaces the flat uncompressed parallel arrays in kallsyms
lineinfo with a block-indexed, delta-encoded, ULEB128 varint compressed
format to significantly reduce the memory footprint.

> diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
> --- a/kernel/module/kallsyms.c
> +++ b/kernel/module/kallsyms.c

[ ... ]

> @@ -540,80 +535,63 @@ static bool module_lookup_lineinfo_section(const vo=
id *blob, u32 blob_size,
>  		return false;
> =20
>  	base =3D (const u8 *)blob + hdr_offset;
> -	hdr =3D (const struct mod_lineinfo_header *)base;
> -	num_entries =3D hdr->num_entries;
> -	num_files =3D hdr->num_files;
> -	filenames_size =3D hdr->filenames_size;
> +	hdr =3D base;
> =20
> -	if (num_entries =3D=3D 0)
> +	if (hdr->num_entries =3D=3D 0 || hdr->num_blocks =3D=3D 0)
>  		return false;
> =20
> -	/*
> -	 * Validate counts before multiplying =E2=80=94 sizing arithmetic could
> -	 * otherwise overflow on 32-bit with a malformed blob.  Each entry
> -	 * contributes one u32 (addrs), one u16 (file_ids), and one u32
> -	 * (lines); each file contributes one u32 (file_offsets).
> -	 */
>  	/* Validate each sub-array fits within the remaining blob bytes */
>  	{
>  		u32 avail =3D blob_size - hdr_offset;
> -		u32 needed =3D mod_lineinfo_filenames_off(num_entries, num_files);
> =20
> -		if (num_entries > U32_MAX / sizeof(u32))
> +		if (hdr->blocks_offset > avail ||
> +		    hdr->blocks_size > avail - hdr->blocks_offset)
> +			return false;
> +		if (hdr->data_offset > avail ||
> +		    hdr->data_size > avail - hdr->data_offset)
>  			return false;
> -		if (num_files > U32_MAX / sizeof(u32))
> +		if (hdr->files_offset > avail ||
> +		    hdr->files_size > avail - hdr->files_offset)
>  			return false;
> -		if (needed > avail || filenames_size > avail - needed)
> +		if (hdr->filenames_offset > avail ||
> +		    hdr->filenames_size > avail - hdr->filenames_offset)
>  			return false;
>  	}

[Severity: Medium]
Could these inner offsets (like hdr->blocks_offset and hdr->files_offset)
be unaligned in a malformed blob?

The code validates the bounds correctly here, but misses an alignment check
before these offsets are later added to the base pointer and assigned to
the u32 arrays.

If the offsets are not multiples of 4, wouldn't dereferencing tbl.blk_addrs
or tbl.file_offsets trigger an alignment exception on strict-alignment
architectures? If this happens during an NMI or panic, it seems like it
could cause a recursive fault and permanently lose the backtrace.

[ ... ]

> +	tbl.blk_addrs	=3D base + hdr->blocks_offset;
> +	tbl.blk_offsets	=3D base + hdr->blocks_offset +
> +			  hdr->num_blocks * sizeof(u32);
> +	tbl.data	=3D base + hdr->data_offset;
> +	tbl.data_size	=3D hdr->data_size;
> +	tbl.file_offsets =3D base + hdr->files_offset;
> +	tbl.filenames	=3D base + hdr->filenames_offset;
> +	tbl.num_entries	=3D hdr->num_entries;
> +	tbl.num_blocks	=3D hdr->num_blocks;
> +	tbl.num_files	=3D hdr->num_files;
> +	tbl.filenames_size =3D hdr->filenames_size;
> +
> +	return lineinfo_search(&tbl, section_offset, min_offset, file, line);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801143219.3975=
824-1-sashal@kernel.org?part=3D3
