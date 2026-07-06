Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5E9379C22
	for <linux-modules@vger.kernel.org>; Mon,  6 Jul 2026 14:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783348838; cv=none; b=Kqv6Vlb0R9Cda9TyZc1wvEw7SmamTji1Gnd4YXsEuk/Y3JLy0aKI7KvOphWAkDQb0YNl9HGwWjNgBlvPnkmNGMrsVuoNdxo8LUzRTyOqeJpJ5x/grGrz3Bfx34pVGbiVHQNm3CpJcv+Hom+NhUeqn7vkmdSxnPLKbzMYnmy908c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783348838; c=relaxed/simple;
	bh=esI8ALs+jwMeqg9IbfjVV8t6J/CkMZwZRvGYuGiDHGY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N/wFP8b1z/rJu+fz05z0aSYZ36KYEcTh3wh2A7smsbD4Qch6NmaONnLvJK3sL4cN2wDIVf0DTY445JmIIt12s0AdNyNj1rQpkYNGL7USQAEtsz8R6plOup0iaQKbwDheUzwGa5orUrPFC90wgv66itjPESzOJhMThtzwkdbRV5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrnRqsOE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrnRqsOE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 060841F00A3A;
	Mon,  6 Jul 2026 14:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783348837;
	bh=YSsAm/jesVbdzASitjja08awV8a0pt6aEuVSt4nCLHA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nrnRqsOEmxjUsT08mUyV682F4DrPnJFTTrZu85ZhajTK+SQz3wlLa85KSt6fTzXoz
	 bzFYiWe1gAxaTx+5gyZWkMEctuiYhU/5Ts0TP6XkOPp9jCaAIOHlM1168qVrLiHt+a
	 L3n+IzUakrO9ibL/E+1OtGpcFP6RlccO6gvsnQboMmtleAFkhoD7nXlxns4rIBjmIM
	 w3Ubk06lcjm/VZsy8VS+jUlVQVz3FIanGnyVkIldTzDeMJFURXWaz54SP6+7HGHjVs
	 VJlIYkRg1bXQYGMuomXpBKLJjPkmWxqJhm9XAhtCRIp8UtJTtAhamPCE8LU3Hn5UQp
	 N0+bfzSZ23xqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/4] kallsyms: delta-compress lineinfo tables for
 ~2.7x size reduction
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260706142914.2398993-4-sashal@kernel.org>
References: <20260706142914.2398993-1-sashal@kernel.org>
 <20260706142914.2398993-4-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 14:40:36 +0000
Message-Id: <20260706144037.060841F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] lineinfo_read_sleb128 contains a signed left shift that can overfl=
ow on malformed or large data, triggering a UBSAN splat in NMI/panic contex=
ts.
--

commit 3756e632dbdf4d6db79f0e2c8a39f6103ac6e8ad
Author: Sasha Levin <sashal@kernel.org>

kallsyms: delta-compress lineinfo tables for ~2.7x size reduction

This patch replaces the flat uncompressed parallel arrays for lineinfo with=
 a
block-indexed, delta-encoded, ULEB128/SLEB128 varint compressed format to
significantly reduce size. Entries are grouped into blocks of 64 and decoded
entirely on the stack to ensure safety during NMI or panic contexts.

> diff --git a/include/linux/mod_lineinfo.h b/include/linux/mod_lineinfo.h
> index 9cda3263a0784..a3c7143433020 100644
> --- a/include/linux/mod_lineinfo.h
> +++ b/include/linux/mod_lineinfo.h

[ ... ]

> +/* Read an SLEB128 varint. Same safety guarantees as above. */
> +static inline int32_t lineinfo_read_sleb128(const u8 *data, u32 *pos, u3=
2 end)
> +{
> +	int32_t result =3D 0;
> +	unsigned int shift =3D 0;
> +	u8 byte =3D 0;
> +
> +	while (*pos < end) {
> +		byte =3D data[*pos];
> +		(*pos)++;
> +		result |=3D (int32_t)(byte & 0x7f) << shift;

[Severity: High]
Can this signed left shift trigger a UBSAN splat on malformed or large data?

For the 5th byte of an SLEB128 varint, shift will be 28. If the decoded byte
has a value greater than 7 (e.g. 0x7F), 127 << 28 evaluates to 3409130496,
which exceeds INT32_MAX.

Since left-shifting into or past the sign bit of a signed integer is
undefined behavior in C, a corrupted or maliciously crafted .mod_lineinfo
section could trigger a CONFIG_UBSAN_SHIFT splat.

If this function is called by lineinfo_search() during an NMI or panic
context, would the resulting UBSAN splat attempt to take locks and call
printk, potentially causing a deadlock or nested panic?

Perhaps the shift should be performed as unsigned:
result |=3D (int32_t)((u32)(byte & 0x7f) << shift);

> +		shift +=3D 7;
> +		if (!(byte & 0x80))
> +			break;
> +		if (shift >=3D 32) {
> +			while (*pos < end && (data[*pos] & 0x80))
> +				(*pos)++;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706142914.2398=
993-1-sashal@kernel.org?part=3D3
