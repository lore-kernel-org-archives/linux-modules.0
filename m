Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A543C4BFE89
	for <linux-modules@vger.kernel.org>; Wed,  9 Sep 2026 22:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788992812; cv=none; b=RkohSdScVGQQfcUfHeRQqvraTPoLt/zlg9gxdFweWVKyCaiPIebU7GZlZNfp0A0tYVjsgSSUtsjx2VvygPHFa0jDcsmrZiEBX1t84+Hymxus46kvvtzadmW4ZrPPS31TDkJZzrsSsprK6P3CoeEzFHRJszDMXBGLAPv5kxesZww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788992812; c=relaxed/simple;
	bh=CMc3Vsr7iweLoRN9H3y84ZJWlLhrHj7i+Kvx2VN2Uog=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bbSNtgbsmvHm33qnlOCmVl4ffshaMLnL0aOXyr53w8+6cvUKNDouFeGQqTzCO7V3AsDj6B9oZ7Dn11Mz3KxCgl3008kBZcWi51DjF9MvdZ80qVT9L3SzDRlENq/30Icu9D07QWm7N97XpiPsdYze9hoVda4vJeTtOe2FO90TTBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHan+4uS; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHan+4uS"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-398a5aad413so5387679a91.3
        for <linux-modules@vger.kernel.org>; Wed, 09 Sep 2026 15:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788992809; x=1789597609; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=GJIj44arWcgfsXqCTf5jusWng1C5DNidnSVlW5EdX58=;
        b=PHan+4uSrRW9YGfK+NT2JBQ3Ekb+7WQlQjyUzSJ7YladZ0+ws3P9bhcE2iBMlH7Tme
         TUptviXTK9wXY9BfVd+tuvyWa+lZz3VMJbFYlbk58GZZXy1Ooq3OCuUGhItzAYzaqtQR
         gyXJLP3KaZf1ZYA03eEM+yisRAO/3sLlJgNrEE6+nDRwGyZ2OYUrnMVzGxYNLlTfHqxm
         c0QX/RA/I9g/pPj2nTea4Dp3l7ZJap6kw7mfGrpSVEuKku4W+0YPc8+J4hs1jwTWSk6N
         bxfc0k3Z/y8FiZL8hhGGZ91L+RsxG8nVc6ngsPVMS2hiG1jAR9smA/brARUX7YD6JfhT
         wS/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788992809; x=1789597609;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GJIj44arWcgfsXqCTf5jusWng1C5DNidnSVlW5EdX58=;
        b=lsRWiFb8Cfu0lzvkOhHKkmtI/KFG21keg5jmH1RPFmQ5wlClSHQ3AxdbQ9PzYbnVrQ
         O7zpz5LgPnPB1pf5u2oLZFONhiQgsmQHSIMnZFMMEr0X4jHDkS5SYu8AkgbxeQyVe5do
         rYPSARFAhg8JGBwDL3rONsOQaLLju4va81iQggwfPayNW2bAQYSnSojQUFLP8qrwDhLn
         nH7LvTbYS2OC0gkFzo1nW1P3voMDnZdyayOF4P/YQg3gC3JGA8fimPNuKRrNy4V+65ZX
         /dM2wRaG0qs0sZYtG9WdNfaLFGsKP0eRDmSiBzrnnRn+jgo8ghcqUWGhOSWPHVlKYQ40
         3WBw==
X-Forwarded-Encrypted: i=1; AKwUvBxgHUcol55nGzURql/S0EmIRde8InE9h4GiaQZP+ZB1fclxsMyoxrwd8Wb9+daPTLQTyAblzyqTkyfr1p2D@vger.kernel.org
X-Gm-Message-State: AFuF++nYOIUzyhRUD7v55DwrwD6ENuraF8uroe3heybqtZ6oQoq5jE9K
	TH8mc7NBL2m/ugFqOmMExvaGL3kzLsxXXi326WuISB/NaBn7UFcLlg7/
X-Gm-Gg: AYBFou38rzzTNK/VUYrRSM4jtWg18a1WXjBB1jDJ201PPTuuhkbxmakTMBJT686ktMw
	q1M9w0CFLKa6sLbD3lTKjho7IirtYRUvGzfpqF5CKD+0gVaOGrUVXnW6u8ppLjFRf6tCSnKd+a+
	JiEXbVoMrLPd/pWVManw4PIZrUfDnUpZ/xmKlkonQmDDmG3/MJxabDx49Ei58qPTfc/g2bSP+MA
	CjPvUHQ+85J6v7Ehvcst8qVyGH5yMenDVIK2SmL16iq4X+DHgDBQLru4cd2rFu3kDmUeI+onw85
	26w9RIjWRHHeq+IpPD8zvNlZ2gI5CHGIha198XBNAY3n8jBAWD9kkKN801oKJzD328xY6XhBBT+
	FUfixndlUlJu8JaXOZnEKcyI9sAWybZrgz/c4fu74BcvwIusePFHbnAUaMkXJQxiOSy6sDo+f/m
	i6f8jvRGh1tEFaOg3TnDcYU+uF9/Kc5w9ReDcEW+qanfdYx2mDjW6CuZGbWbSaaanq3RJwdXQR9
	B+qtxR1rxVhE4+podNk4EiNjoM=
X-Received: by 2002:a17:90b:1643:b0:380:21b7:e727 with SMTP id 98e67ed59e1d1-39b26272f04mr54383045a91.14.1788992808747;
        Wed, 09 Sep 2026 15:26:48 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d77608fb4sm1613529a91.15.2026.09.09.15.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 15:26:48 -0700 (PDT)
Message-ID: <791206dfa4759027377273185e3940156dc9b976.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 01/18] btf: Extend UAPI to support BTF
 location (inline site) info
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org, andrii@kernel.org
Cc: daniel@iogearbox.net, jolsa@kernel.org, ihor.solodrai@linux.dev, 
	yonghong.song@linux.dev, song@kernel.org, qmo@kernel.org,
 martin.lau@linux.dev, 	memxor@gmail.com, emil@etsalapatis.com,
 mcgrof@kernel.org, petr.pavlu@suse.com, 	tj@kernel.org, kees@kernel.org,
 bpf@vger.kernel.org, nathan@kernel.org, 	nsc@kernel.org, arnd@arndb.de,
 puranjay@kernel.org, yatsenko@meta.com, 	atenart@kernel.org,
 ojeda@kernel.org, linux-modules@vger.kernel.org
Date: Wed, 09 Sep 2026 15:26:45 -0700
In-Reply-To: <20260901165757.801449-2-alan.maguire@oracle.com>
References: <20260901165757.801449-1-alan.maguire@oracle.com>
		 <20260901165757.801449-2-alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10+b1 
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-09-01 at 17:57 +0100, Alan Maguire wrote:
> Add BTF_KIND_LOC_PARAM, BTF_KIND_LOC_PROTO and BTF_KIND_LOCSEC
> to help represent location information for functions.
>=20
> BTF_KIND_LOC_PARAM is used to represent how we retrieve data at a
> location; either via register(s), or register+offset, a dereference
> of a register+offset or a constant value.
>=20
> BTF_KIND_LOC_PROTO represents location information about a location
> with multiple BTF_KIND_LOC_PARAMs.
>=20
> And finally BTF_KIND_LOCSEC is a set of location sites, each
> of which has
>=20
> - a BTF_KIND_FUNC function associated with the inline site
> - a location prototype specifying where to find the function
> =C2=A0 parameters
> - an address offset relative to the kernel base address
>=20
> This can be used to support representing
>=20
> - a fully-inlined function at potentially multiple inline sites
> =C2=A0 with potentially different parameter availability
> - a partially-inlined function where some _LOC_PROTOs represent
> =C2=A0 inlined sites as above and others have normal _FUNC representation=
s
>=20
> Also BTF_KIND_LOCSEC struct btf_loc will have two type id
> references; one for the associated func, the other for the loc_proto.
> Accordingly increase the number of m_offs references in btf_field_desc
> to 2.
>=20
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...

> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index ddd0f4f32d24..a4412bc16688 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h

...

> +static inline struct btf_loc_param *btf_loc_param(const struct btf_type =
*t)
> +static inline __u32 *btf_loc_params(const struct btf_type *t)

Maybe rename the latter to btf_loc_proto_params?

...

> diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
> index 618167cab4e6..6062c9958034 100644
> --- a/include/uapi/linux/btf.h
> +++ b/include/uapi/linux/btf.h

...

> @@ -212,4 +214,65 @@ struct btf_enum64 {
> =C2=A0	__u32	val_hi32;
> =C2=A0};
> =C2=A0
> +/*
> + * BTF_KIND_LOC_PARAM is followed by a single "struct btf_loc_param"
> + * that contains flags specifying the contents of the vlen-specified
> + * number of 4-byte values that follow.
> + */
> +struct btf_loc_param {
> +	__u32 flags;

Wdyt about adding a flexible array member here?

	__u32 params[];

Would make btf_loc_param_log() a little bit easier to follow.

> +};
> +
> +/*
> + * The combination of size, vlen and flags gives us the means to interpr=
et
> + * the following vlen-specified set of 4-byte values:
> + *
> + * - a BTF_LOC_PARAM_CONST is a constant value; combination
> + *=C2=A0=C2=A0 of size, vlen and _SIGNED flag determines it. If the valu=
e requires
> + *=C2=A0=C2=A0 64 bits it is stored in {lo,hi} order.
> + * - a BTF_LOC_PARAM_ADDR is an address that will be normalized with
> + *=C2=A0=C2=A0 respect to kernel base address.

Nit: pahole generates ADDR | CONST.

> + * - a BTF_LOC_PARAM_REG with vlen 1 is a simple register number;
> + *=C2=A0=C2=A0 with vlen 2 it is a multi-register parameter.

Nit: REG | OFFSET is not discussed.

> + * - a _REG | DEREF with vlen 1 dereferences the value in the register
> + *=C2=A0=C2=A0 number specified.
> + * - a REG | DEREF | OFFSET with vlen specifies the register value in
> + *=C2=A0=C2=A0 the first 4-byte value and the offset in the remainder.

--- >8 ---

> + * - binary logical operators operate on a combination of register
> + *=C2=A0=C2=A0 number and constant value, aside from _NOT which operates=
 on
> + *=C2=A0=C2=A0 a register

--- 8< ---

This is probably a leftover.

> + */
> +enum btf_loc_param_flags {
> +	BTF_LOC_PARAM_SIGNED		=3D	0x1,
> +	BTF_LOC_PARAM_CONST		=3D	0x2,
> +	BTF_LOC_PARAM_ADDR		=3D	0x4,
> +	BTF_LOC_PARAM_REG		=3D	0x8,
> +	BTF_LOC_PARAM_DEREF		=3D	0x10,
> +	BTF_LOC_PARAM_OFFSET		=3D	0x20,
> +};
> +
> +/*
> + * BTF_KIND_LOC_PROTO specifies location prototypes; i.e. how locations =
relate
> + * to parameters; a struct btf_type of BTF_KIND_LOC_PROTO is followed by=
 a
> + * a vlen-specified number of __u32 BTF type ids which specify the assoc=
iated
> + * BTF_KIND_LOC_PARAM for each function parameter associated with the
> + * location.=C2=A0 The type should either be 0 (no location info) or poi=
nt at
> + * a BTF_KIND_LOC_PARAM.
> + */
> +
> +/*
> + * BTF_KIND_LOCSEC consists of vlen-specified number of "struct btf_loc"
> + * containing location site-specific information;
> + *
> + * - function (func)
> + * - location prototype type id (loc_proto)
> + * - address offset (offset) relative to kernel base address

pahole uses loc->section_offset to create LOCSEC entries,
which corresponds to an offset within an ELF containing
the function section. Would it make sense to rephrase the
above comment a bit?

> + */
> +
> +struct btf_loc {
> +	__u32 func;
> +	__u32 loc_proto;
> +	__u32 offset;
> +};
> +
> =C2=A0#endif /* _UAPI__LINUX_BTF_H__ */

...


