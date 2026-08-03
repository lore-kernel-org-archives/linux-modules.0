Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C81380FC3
	for <linux-modules@vger.kernel.org>; Mon,  3 Aug 2026 05:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785735756; cv=none; b=M8hEXI1OM1j70rdM48fIldmE5+hIFYGBL2kqwgYBDPrKAYW3uHGAQ2L0oO+yjMuFz5pUzRsuwTKsh1aVZigdRWG3gKO4ZTFLH0NDuITD4idQY4J2TnzTgRLta4C2+6K82AkIvTqJ6ktwwobwGmjpjcyS8m6VDLKhi9nXJmOaxQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785735756; c=relaxed/simple;
	bh=WkKUNX87DuQkqkOPRSmJwrPUOu0C/xAuh3ctsMAZ0iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=crj2jQPEFV8wdfRiqXrN3tZG8IeVsHDJB7c74Hqagk0ZkhpesuNourIKxkXim3v4kn1lBX357v985OGiptHdCbM2zxcGybK8Vm/v4Ooe+C5xc3Umh1sCYqQS3OllLHbEJ1nQlfaB9NB2xj5DABM23My4pm40O5/nKRYc6ykl1Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eht17sB9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eht17sB9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 367531F000E9;
	Mon,  3 Aug 2026 05:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785735754;
	bh=FUlFgdPQrrnJgNKWTBktu5nia45q+Mo1UXEENpCK7mo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eht17sB9bSQVZmDlcndw3gUfhO6UI8sD7/iSfDsOjR541p0YI29nCnyn1KqkjdoFC
	 xBX8V9RXcq30+lIAcnEB3CKjnac/TNmhhc1TOFtDiY8lAv2zsH9ojDPNiIdY417bYm
	 mcM7og3XUcW8UeTf5yf+BzbIycTRPzOjNA2tIvVNm8QEonYnI7SwP5SnKoK7sUrY4U
	 I/Z2Y6XMPXq+BuZ56Q41D/ZE10RuEgdSRQBPPEfaKG2xXcDxe3IkKdqgJ04Sv2wvvI
	 rpWyQz4HU6wHABAdHgIDcx7yOdBHrMRinCbog2LWISHByaA0m7jXMQT1ZU4SRyUnWt
	 zGn3vPyxXtlQQ==
Date: Sun, 2 Aug 2026 22:42:32 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: sashiko-bot@kernel.org
Cc: linux-modules@vger.kernel.org
Subject: Re: [PATCH 05/14] objtool/klp: Add .klp.symid for sympos
 disambiguation
Message-ID: <7avwg6oos7kjtotwlpcxhy5qiviu5gzhwew2ibjcfccu4vbonu@25ayhrgt7b33>
References: <cover.1785727106.git.jpoimboe@kernel.org>
 <64d50f077b569f47883c015cdb7079edb068efe8.1785727106.git.jpoimboe@kernel.org>
 <20260803034116.43C111F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260803034116.43C111F000E9@smtp.kernel.org>

On Mon, Aug 03, 2026 at 03:41:15AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Relocations in .klp.symid pointing to discarded sections (.exitcall.exit, .exit.text, etc.) will cause a link-time error when building vmlinux.
> --
> 
> --- Patch [5]: [PATCH 05/14] objtool/klp: Add .klp.symid for sympos disambiguation ---
> commit 09454266fcd41f3c022cac215ab86d1269c37d52
> Author: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> objtool/klp: Add .klp.symid for sympos disambiguation
> 
> This commit introduces a new .klp.symid section to vmlinux.o to help
> livepatch reliably determine the sympos of duplicate-named symbols. It
> emits an array of identifiers and relocations that survives the final link,
> allowing klp-diff to correlate symbols between vmlinux.o and vmlinux.
> 
> > diff --git a/tools/objtool/klp-symid.c b/tools/objtool/klp-symid.c
> > new file mode 100644
> > index 0000000000000..cf188cdfa6079
> > --- /dev/null
> > +++ b/tools/objtool/klp-symid.c
> [ ... ]
> > +static const char * const discarded_secs[] = {
> > +	".discard",
> > +	".modinfo",
> > +	"__tracepoint_check",
> > +};
> > +
> > +static bool discarded_sec(struct section *sec)
> > +{
> > +	if (!(sec->sh.sh_flags & SHF_ALLOC))
> > +		return true;
> > +
> > +	for (int i = 0; i < ARRAY_SIZE(discarded_secs); i++)
> > +		if (strstarts(sec->name, discarded_secs[i]))
> > +			return true;
> > +
> > +	return false;
> > +}
> 
> [Severity: Low]
> Should the discarded_secs array also include .exitcall.exit and .exit.
> sections?
> 
> Because these exit sections have the SHF_ALLOC flag set, the first check in
> discarded_sec() will not catch them. If they are also omitted from the
> discarded_secs array, klp_create_symid_sections() will mistakenly generate
> relocations pointing to them.
> 
> Since the linker script unconditionally discards .exitcall.exit via the
> DISCARDS macro, generating relocations against it causes a deterministic
> link-time error ("relocation refers to a discarded section") when building
> vmlinux.
> 
> Could this happen in practice? Common driver exit handlers (e.g.,
> module_cleanup used by drivers like cx18 and ivtv) often result in
> duplicate static symbols like __exitcall_module_cleanup in the
> .exitcall.exit section when the modules are built-in.

I'm not convinced this can happen in practice.  Why would somebody be
trying to patch or reference a module exit symbol anyway?

-- 
Josh
