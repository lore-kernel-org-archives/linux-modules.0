Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBBD3515F2
	for <linux-modules@vger.kernel.org>; Mon,  3 Aug 2026 03:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785728477; cv=none; b=AcIZtbK2jjtcEF21Dp9M1Jf1cbYGasykGQqMwTSh+n1jtsS5y9pWlE/0ijIRxbBpCE9V4kkKsm8jBt1rkm0JYbj4KIdpNVdtbJVZU5QtD6xtTxe1fqFMnEHvEq/qq7fVy0aCHHMjZzSjEBwMryVaINHZ6vFLVHamxA2IXeuudLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785728477; c=relaxed/simple;
	bh=hhp+rFNQUexgzLx6ddHpcoUHNLFrMKfT65x/WF+O3pE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gRW7tveV3aWNHdYUZzNzlU0osFEx7yRfBCNXOOmVG8kn/cetgxTvP8YebIZcPYn+ql9MlVT7E7qyBkd56vzVhADdWBUZ+YSDFb/ihmyxKNcZg9F5sLPNSf7mHd1S7HsqLZaocUze2jgneXG/y7RWnerDP2r9C+eh/+80k9aHNHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMg49paj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMg49paj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C111F000E9;
	Mon,  3 Aug 2026 03:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785728476;
	bh=k01drJOz5pQLtijAuDc9yxNu8u16sh3v3g7fVFZbgVY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nMg49paj9OJKPXDm1lAoXh3564y8rr3bfqU1Zz2hbWtd9iDPrD//qCelKjazUWGqP
	 1AnOrd4JT6iaKY32RC8YipAmlF3bDDbNciUCk60XpYX8pkhxiMhMPg9EjR7xFqQPQd
	 bgZbPZv1b5KbuuWPfMiHF37wXNv771+P2e7PUXkWTJQlpZOf1zj2XiGcWQuYoOA607
	 0MOWAfM8HLp1h0nMa1Q5/ZgMVgS8u0UiSvEbVQ1Rk6na/hG2dWZvVmRUb39Pk3VWe4
	 +X+MOA+mCGMuWZQF4+eQJUtPS7/IM1bYV72DcCE+4Bgiff5I1OWUPTod/bktG2lX6E
	 RcfOXavoi2zpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/14] objtool/klp: Add .klp.symid for sympos
 disambiguation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Josh Poimboeuf" <jpoimboe@kernel.org>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <64d50f077b569f47883c015cdb7079edb068efe8.1785727106.git.jpoimboe@kernel.org>
References: <cover.1785727106.git.jpoimboe@kernel.org>
 <64d50f077b569f47883c015cdb7079edb068efe8.1785727106.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 03:41:15 +0000
Message-Id: <20260803034116.43C111F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Relocations in .klp.symid pointing to discarded sections (.exitcall=
.exit, .exit.text, etc.) will cause a link-time error when building vmlinux.
--

--- Patch [5]: [PATCH 05/14] objtool/klp: Add .klp.symid for sympos disambi=
guation ---
commit 09454266fcd41f3c022cac215ab86d1269c37d52
Author: Josh Poimboeuf <jpoimboe@kernel.org>

objtool/klp: Add .klp.symid for sympos disambiguation

This commit introduces a new .klp.symid section to vmlinux.o to help
livepatch reliably determine the sympos of duplicate-named symbols. It
emits an array of identifiers and relocations that survives the final link,
allowing klp-diff to correlate symbols between vmlinux.o and vmlinux.

> diff --git a/tools/objtool/klp-symid.c b/tools/objtool/klp-symid.c
> new file mode 100644
> index 0000000000000..cf188cdfa6079
> --- /dev/null
> +++ b/tools/objtool/klp-symid.c
[ ... ]
> +static const char * const discarded_secs[] =3D {
> +	".discard",
> +	".modinfo",
> +	"__tracepoint_check",
> +};
> +
> +static bool discarded_sec(struct section *sec)
> +{
> +	if (!(sec->sh.sh_flags & SHF_ALLOC))
> +		return true;
> +
> +	for (int i =3D 0; i < ARRAY_SIZE(discarded_secs); i++)
> +		if (strstarts(sec->name, discarded_secs[i]))
> +			return true;
> +
> +	return false;
> +}

[Severity: Low]
Should the discarded_secs array also include .exitcall.exit and .exit.
sections?

Because these exit sections have the SHF_ALLOC flag set, the first check in
discarded_sec() will not catch them. If they are also omitted from the
discarded_secs array, klp_create_symid_sections() will mistakenly generate
relocations pointing to them.

Since the linker script unconditionally discards .exitcall.exit via the
DISCARDS macro, generating relocations against it causes a deterministic
link-time error ("relocation refers to a discarded section") when building
vmlinux.

Could this happen in practice? Common driver exit handlers (e.g.,
module_cleanup used by drivers like cx18 and ivtv) often result in
duplicate static symbols like __exitcall_module_cleanup in the
.exitcall.exit section when the modules are built-in.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1785727106.gi=
t.jpoimboe@kernel.org?part=3D5
