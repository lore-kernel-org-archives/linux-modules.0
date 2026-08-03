Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BDD377A90
	for <linux-modules@vger.kernel.org>; Mon,  3 Aug 2026 03:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785729198; cv=none; b=Aty/AJcKVSGbK9WTTtU0QmEHu5MbharC0ogBTwBr6JIhxPEAbgFyiARYD6aUMVCGkLuzqMpeCJw4pnsotHHzdyIYHvwBFdHswaM3SZxqRiGxS98l0/JU1GBk3M+lAJ0Xsp1zG2hQUdY2vJFRl19YpTbVd4tQlBpojyextKCwUM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785729198; c=relaxed/simple;
	bh=lNQj/lCwY+btfqqZmYFWGM4kHCki0pgDLK/fBTWCX1w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R0CeeRaW+3+b/E2yXBDlbFFEzc7x1gddEgztolxn7eXQH7ZC+fAV/5Yat/5TTAPNYOnalwX7qABCacRYwlemgDuX9Vn+51eY6seWm6we9pLlMBcXMV9ONRw6aj4AckeYbnyA/NhjxiOGpZPNWoyA6I82qGK6fz98qbBXWlTM2Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUXFNaHc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUXFNaHc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC8B91F00A3A;
	Mon,  3 Aug 2026 03:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785729196;
	bh=poDNZtTtLaeBEsKZ04rMzmgyIi9K9PzjrNnpwS96jaU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YUXFNaHcv4Ton4Kd97XRjByhSlZ8TzXYdC/0SppLy/uHV7FzIVB8wpY/8+vM9JIB0
	 bs708QtycpXpbUkKvVRL/r/6ag9PEAOQU/M9dPzHNcfqvY1NfaS8HK1TgZqDtS/QPB
	 qsNqCbRPy59ynEFOLlEpxX7cOfZ9MO/xU34jcqzyQ//cP0bA0rt/lNdv7g6GfQGTv+
	 95slzRneylNRIVD5FPeE319g6jLA6beBynbS60Yn3OGSYGJwaCRrQlWTM5T6f7ji5S
	 qq68jnW+vAyRxYM+5KccIFe214cSEEForzOPDs4QIQkq27bzR7wMfRAqfHsA/27nmt
	 GOCeXXQt2cVCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/14] objtool/klp,livepatch: Resolve module symbols
 against core kallsyms
Reply-To: sashiko-reviews@lists.linux.dev
To: "Josh Poimboeuf" <jpoimboe@kernel.org>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <5f7b6798592b20c6b4accb725ba87849f3224f2c.1785727106.git.jpoimboe@kernel.org>
References: <cover.1785727106.git.jpoimboe@kernel.org>
 <5f7b6798592b20c6b4accb725ba87849f3224f2c.1785727106.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 03:53:15 +0000
Message-Id: <20260803035315.EC8B91F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] objtool's mod_sym_in_kallsyms() diverges from the kernel's is_co=
re_symbol() logic on PowerPC 64, leading to incorrect sympos calculation fo=
r livepatches.
--

--- Patch [8]: [PATCH 08/14] objtool/klp,livepatch: Resolve module symbols =
against core kallsyms ---
commit 5384e2809ccb86e9339029bde934f86f745e7b61
Author: Josh Poimboeuf <jpoimboe@kernel.org>

objtool/klp,livepatch: Resolve module symbols against core kallsyms

This commit updates livepatch to use a module's position in the core symbol
table as its sympos. It enforces this by using
module_kallsyms_on_each_core_symbol() at runtime and mirroring the
is_core_symbol() filter in objtool.

> diff --git a/tools/objtool/klp-sympos.c b/tools/objtool/klp-sympos.c
> index bbfae516d3395..34bb8d1971bd2 100644
> --- a/tools/objtool/klp-sympos.c
> +++ b/tools/objtool/klp-sympos.c
> @@ -367,6 +367,17 @@ static unsigned long find_vmlinux_sympos(struct symb=
ol *sym)
>  	return sympos;
>  }
> =20
> +static bool mod_sym_in_kallsyms(struct symbol *sym)
> +{
> +	if (is_undef_sym(sym))
> +		return false;
> +
> +	if (!(sym->sec->sh.sh_flags & SHF_ALLOC))
> +		return false;
> +
> +	return !strstarts(sym->sec->name, ".init");

[Severity: Medium]
Will this hardcoded filter improperly exclude .init symbols on PowerPC 64?

On PowerPC 64, module_init_section() unconditionally returns false, meaning
the kernel treats .init sections as core memory. This hardcoded string
matching appears to diverge from the kernel's is_core_symbol() logic on
that architecture, potentially leading to incorrect sympos calculations for
livepatches if an object contains duplicate symbols where at least one
resides in an .init section.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1785727106.gi=
t.jpoimboe@kernel.org?part=3D8
