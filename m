Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794667402;
	b=hwu+b6qtmgMmLMsC6Jp00Xs8QwTLeWysypshbD7FnHGJfcoMg58fY5Xch/oJZvMZUUwa
	 ubU0wP8+ZbomgwYGfgd8BOIyfjU3KWQ4yCrVncjeGp0ZT3Lsfr5sUvIaxPA/v5GF3QdMt
	 ytNZQwIVKG4jx4ewC4HJnWc5I9Pbp2AjzonmOKGesk62tbyqucb4RGD5hbxuT5Ob7SZHS
	 EOC+22Jka9YvF7eHlZmI04mba/U/S6jw5xMEpUNQSVBoJk6kz9om21jNmFfa0ANlqxtne
	 s8TzS7Am6jnOmu10PeDqNnboaPb1tl88b87xm34Kdr8hSfeX/ASWNfqd/cZtmuvXqdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794667402;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DHvb0rX14VD3+BLmmVcyRb1OFLTsx+6h+sMOxp0D5OM=;
	b=2l+S/6iqD6BqMAfAw6sYO+FFCVlZ5SME8HUFNxtudZXPuMv9KpUARFYkBoUCvFhwuDh9
	 H3i0Riyvr/eG4UGFrBlcdiG1hYAPrmzH+Be+gdLjg7MfKEEauk9mS9jRANo92h9cDZzXG
	 7eCAeG/1bkvPYVNu+ld4LHErGpQXksVuNdNEdMIP2esiwMqShCg20ppKLI4dYi1JTra8p
	 YqMtSCJ2WjMTcEGqokeuCCUsow3s0v7RuXhlP4cgAc1c6XYhxem4qi5pXBGB38lEa9gfy
	 wkQ3w0cfs4yPX0K5MzwwPJtyfSAf4kSZd51pqS8PiIIZFlhvBFGkkBKuRVjJTrCfYBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HOiv39gM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1480606A329;
	Sat, 14 Nov 2026 14:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HOiv39gM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C85531F000C4;
	Sat, 14 Nov 2026 14:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794667402;
	bh=DHvb0rX14VD3+BLmmVcyRb1OFLTsx+6h+sMOxp0D5OM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HOiv39gMvRlm/XnJpSgXFc2eC9q5WzQ/JLo8ga+t1+Znyq9yWWiqgtGviU0wt0P1K
	 NYzT4zu8P4o1tjdMptcjJRUMGiuN92PQIdvi9hOGtYCfSh+3cBVpEReRVQNct1Gf6v
	 28KLUnaQshKhWghfVCou87ysVfB0Xicz2JUBf5s2KcV9OEXvrwa/IO9xcqtyWL0882
	 w0VvPPEdgWRa23jN1dBOG6H0Gnh8HeD802jVbtOXYLqaTSo3DgoFdBLB8zFFzD0o7E
	 +lHWdM5rwVoHrL9sen4rnynN/pBjmCVrxTKqEQlWeiK4XIwwoRqAedx7r4syqs2gQV
	 AxXGXeHbdjg0w==
Message-ID: <sashiko-outbox-214645@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] module: Add LZ4 module compression
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paul Menzel" <pmenzel@molgen.mpg.de>, "Luis Chamberlain" <mcgrof@kernel.org>, "Petr
 Pavlu" <petr.pavlu@suse.com>, "Daniel Gomez" <da.gomez@kernel.org>, "Sami
 Tolvanen" <samitolvanen@google.com>, "Aaron Tomlin" <atomlin@atomlin.com>, "Nathan
 Chancellor" <nathan@kernel.org>, "Nicolas Schier" <nsc@kernel.org>, "Nick
 Terrell" <terrelln@fb.com>, "David Sterba" <dsterba@suse.com>
Cc: linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org
In-Reply-To: <20261113144233.193782-1-pmenzel@molgen.mpg.de>
References: <20261113144233.193782-1-pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 14:43:21 +0000
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] module: int retval overflow and truncation in
  module_lz4_decompress()
- [Low] module: 0-byte LZ4 frame causes vmap() -ENOMEM in
  module_lz4_decompress()
--

commit 5ec28e23c9b1ef7c279c61b63187aad310dbdc6c
Author: Paul Menzel <pmenzel@molgen.mpg.de>

module: Add LZ4 module compression

This commit adds build and in-kernel decompression support for LZ4-compress=
ed
kernel modules (.ko.lz4).

Link: https://github.com/kmod-project/kmod/pull/505 [1]

> diff --git a/kernel/module/decompress.c b/kernel/module/decompress.c
> index cce098671be97..5828b7ec9d7b6 100644
> --- a/kernel/module/decompress.c
> +++ b/kernel/module/decompress.c

[ ... ]

> +static int module_lz4_verify_content(struct load_info *info, size_t tota=
l,
> +				     u32 expected)
> +{
> +	void *data;
> +	u32 csum;
> +
> +	data =3D vmap(info->pages, info->used_pages, VM_MAP, PAGE_KERNEL_RO);
> +	if (!data)
> +		return -ENOMEM;
> +	csum =3D xxh32(data, total, 0);
> +	vunmap(data);
> +
> +	if (csum !=3D expected) {
> +		pr_err("LZ4-compressed data is corrupt (content checksum)\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}

[Severity: Low]
What happens here when an LZ4 frame decompresses to 0 bytes?

Unlike the gzip, xz and zstd decompressors, which allocate a page before
starting the loop, module_lz4_decompress() only calls module_get_next_page()
inside module_lz4_copy_out() while len is non-zero.  An empty LZ4 frame hits
the zero block_size end mark with info->used_pages =3D=3D 0, so vmap() in
module_lz4_verify_content() (and in module_decompress() when content
checksums are disabled) returns NULL and fails with -ENOMEM instead of
rejecting the empty module.

> +
> +static ssize_t module_lz4_decompress(struct load_info *info,
> +				     const void *buf, size_t size)
> +{
> +	const u8 *in =3D buf, *end =3D in + size, *desc;
> +	size_t block_max, total =3D 0, dict_len =3D 0;
> +	u64 content_size =3D 0;
> +	u8 *scratch, *out;
> +	bool linked;
> +	u8 flg, bd;
> +	int retval;

[ ... ]

> +	if ((flg & LZ4F_FLG_CONTENT_SIZE) && content_size !=3D total) {
> +		pr_err("LZ4-compressed data has a wrong content size\n");
> +		retval =3D -EINVAL;
> +		goto out;
> +	}
> +
> +	retval =3D total;
> +	goto out;

[Severity: Medium]
Can assigning total to int retval overflow or truncate the decompressed siz=
e?

module_lz4_decompress() returns ssize_t, but retval is declared as int.  If=
 a
highly compressible LZ4 frame expands to 2 GiB or more, assigning size_t
total to retval either overflows into a negative non-errno value returned
from finit_module() or truncates the upper 32 bits on 64-bit systems, leavi=
ng
info->len smaller than the vmap()'d pages in info->hdr.  Declaring retval as
ssize_t (like module_gzip_decompress() and module_xz_decompress()) and
bounding total would avoid this.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113144233.1937=
82-1-pmenzel@molgen.mpg.de?part=3D1
