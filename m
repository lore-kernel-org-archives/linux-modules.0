Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5103E37A4B7
	for <linux-modules@vger.kernel.org>; Fri, 29 May 2026 17:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780074765; cv=none; b=PzZhIlwjhXTQQTDzQdepLyiILsG/Zp5szJYu2CsTqbXDb/jbgzOuxOtl8LNhsjALxyFFMQAmORIvF+BtrIf72jea0I4GMIUv1KNkHgkZoYKtc/gYGizO1Iv0enTXfhiL5/SADS0TpTPvW52nTqC8678lzKabzQxZl9O0ZqRDLUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780074765; c=relaxed/simple;
	bh=8gy8v24fWXGyiDG/HsSPi7FzupO+wJept+qsFk4Czw4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WJ0tb3b0KYB/HFE7rJtN6WkMN8ogoqsvIqoAM/2bWn41faG8NQMevWni5TCDZhc9NWpNGmQXH9pNhgZ+d0gR9nR/TGwrqPmviQVu5dXRIxV1GeImE9HLjMmRqmEKEF3Q+a3tRv/cQXlgOdhxfD4IMhLHTaB+QW0buAjUjzgbgrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0Rc4P/Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0Rc4P/Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101861F00893;
	Fri, 29 May 2026 17:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780074764;
	bh=vgVALfg/VfC6yBgAjZR1iy6vbTHjSsMQgVylxmrOKT4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D0Rc4P/Yde5BD7sWjf6+Qsi9wNE2hAFSPY24RsyG18PNzcYpXyXuUGzEbv7H8z3AD
	 +0QN8YwxG5K7apWuj842ctEJepSHbFP2vHTyvLHP8jrUvanJB9SEzdjqUuhiIWOIQj
	 3GTDD6WGVzJASzGt6PUtq+Nzk0ovDl4hK4ql76pDMJcX5couxkLaxo/KLaj5SaqVtC
	 T8CUYPJXi8tn5lrgFh/NurW42OD8eF7un0F0O0ml9NpeHhL3xBiYkEB0I3blQnDkSH
	 LGo2UJaTCog9Q/aGGKkboC6+ADE8WPKzutZJ33NwMJPThRB4l26zu+1clcT+cxni+v
	 6kLoWnIDFQjHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] ARM: module.lds: fix unwind metadata for merged
 .text sections
Reply-To: sashiko-reviews@lists.linux.dev
To: Egg12138 <egg12138@foxmail.com>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <tencent_D9CDCA221D0AF5EDF260559734464D39B708@qq.com>
References: <tencent_D9CDCA221D0AF5EDF260559734464D39B708@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 17:12:43 +0000
Message-Id: <20260529171244.101861F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The linker script fix is wrapped in an inverted configuration cond=
itional (`#ifndef CONFIG_ARM_UNWIND`), applying the fix only when unwinding=
 is disabled.
- [High] The wildcard patterns are enclosed in double quotes, which disable=
s wildcard matching in GNU ld.
- [Low] Non-standard linker script syntax with a space between the wildcard=
 asterisk and the section name list.
--

commit 165574ad9cf92e77eac788d811caa72c990e0b3d
Author: Xiao Junzhe <egg12138@foxmail.com>
Subject: ARM: module.lds: fix unwind metadata for merged .text sections

This commit attempts to fix a module stack unwinding failure on ARM by
coalescing .ARM.exidx and .ARM.extab input sections that belong to merged
.text.* sections. This is intended to keep the output names in sync with
what the ARM module unwind code expects.

> diff --git a/arch/arm/include/asm/module.lds.h b/arch/arm/include/asm/mod=
ule.lds.h
> --- a/arch/arm/include/asm/module.lds.h
> +++ b/arch/arm/include/asm/module.lds.h
> @@ -1,4 +1,20 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef CONFIG_ARM_UNWIND

[Severity: High]
Does this exclude the fix in the exact configuration it is intended for?

The patch aims to fix module stack unwinding, which is controlled by
CONFIG_ARM_UNWIND. Because this block is wrapped in an #ifndef, the section
coalescing will be skipped when unwinding is enabled, leaving the unwind
tables unmerged and the issue unresolved.

> +SECTIONS {
> +	.ARM.extab		0 : {
> +		*(.ARM.extab)
> +		* (".ARM.extab.text")
> +		* (".ARM.extab.text.[0-9a-zA-Z_]*")

[Severity: Low]
This isn't a bug, but there is a space between the asterisk wildcard and
the section name list. While GNU ld ignores this whitespace, standard kernel
linker script conventions typically omit it.

[Severity: High]
Will GNU ld expand the wildcard patterns when they are enclosed in double
quotes?

Enclosing a section name in double quotes causes wildcard characters like
the asterisk and brackets to lose their special meaning and be treated as
literal characters. The linker will try to match a section literally named
".ARM.extab.text.[0-9a-zA-Z_]*" instead of expanding the glob to match
sections like ".ARM.extab.text.unlikely".

> +	}
> +	.ARM.exidx		0 : {
> +		*(.ARM.exidx)
> +		* (".ARM.exidx.text")
> +		* (".ARM.exidx.text.[0-9a-zA-Z_]*")
> +	}
> +}
> +#endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_D9CDCA221D0=
AF5EDF260559734464D39B708@qq.com?part=3D1
