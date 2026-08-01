Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEB4389107
	for <linux-modules@vger.kernel.org>; Sat,  1 Aug 2026 14:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785595555; cv=none; b=eJYndkf8h3ZeTBH2tj1snFlfPxIfDioLa5vDbapWfJSKts9fK7iGFJJwqho4lZ0bVpcPKUvC+vZHPwnEUXf5SO8lnamHOxEqCqTWnmORG2QLHsbT4m2y5mPycXnVJprkH4U5g5Lb7NJ7Qxxy6E+O7cH2m4P6gkZ8H6HgCQj/p10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785595555; c=relaxed/simple;
	bh=5/jaPTp1SxMhv95oCccCnVjOJmvirKTlgOATjvPX7JA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NXJEw3iwu1xafDbgaUMDKNnkLoWDB7nG6Awuk8Y04qC6WTe1hxZeABvNd7xmRzn9SKnh4uwoLXdlRdjUkjDPxYbnJ3JEXfLN4ZNdQ7Ku1vwGh2VHKtOywyLLtEwXiWSNG5z2ZPhASzGVO75u1YIsJu0InKxrAyA8j2i3iIj9nlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLY47xvb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLY47xvb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3755B1F00ACA;
	Sat,  1 Aug 2026 14:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785595554;
	bh=IZusMNt0R2Rm5TbCcPItYt5FudBLuuH0prpLo6O9WSs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PLY47xvbnq8KVFrCZbdm4JsqVGX0EUkQkhrYgoQ8cALhL/qBsnGMYHldwQE3M5L4W
	 6TCi8C/Tt9jopuAaQaDOt4/msXXyIKySqRZqUOUsk0FSzIZVhRPUoxpYfZI5R5w5GF
	 xGD9amH1aC4gOEOkC1gXKL5d3VNQGfyBR39UPY8LdwDbaUkQ7A5Ginfv76CGtS7Amd
	 0DDckidt99/jv92RoHhXuclksmuzrRoG9Qvv/L7U6j8eOrdjLZoL8X5jYv+IDTVwJu
	 uz1wv9uH1DxMqKaxiP3+mghSm3kl9psyEnR9zTmeOX8cpfgAwVwRNuBc5iEUIg62uN
	 mY3SQh1Yq/zEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/4] kallsyms: embed source file:line info in kernel
 stack traces
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260801143219.3975824-2-sashal@kernel.org>
References: <20260801143219.3975824-1-sashal@kernel.org>
 <20260801143219.3975824-2-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 14:45:53 +0000
Message-Id: <20260801144554.3755B1F00ACA@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Use of `snprintf` violates `sprint_symbol` API contract and caus=
es trace buffer inflation.
--

--- Patch [1]: [PATCH v8 1/4] kallsyms: embed source file:line info in kern=
el stack traces ---
commit 8a14a0edefef69e5b032ac47662777d287f71164
Author: Sasha Levin <sashal@kernel.org>

kallsyms: embed source file:line info in kernel stack traces

Add CONFIG_KALLSYMS_LINEINFO, which embeds a compact address-to-line
lookup table in the kernel image so stack traces directly print source
file and line number information.

> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c

[ ... ]

> @@ -497,6 +567,23 @@ static int __sprint_symbol(char *buffer, unsigned lo=
ng address,
>  		len +=3D sprintf(buffer + len, "]");
>  	}
> =20
> +	/*
> +	 * Append "(file:line)" only for stack-backtrace consumers.  Plain
> +	 * sprint_symbol() backs %ps, and many existing format strings tack
> +	 * literal "()" after %ps to indicate a function call ("foo()
> +	 * replaced with bar()"); appending lineinfo there would produce a
> +	 * confusing "foo (file:line)()".
> +	 */
> +	if (add_lineinfo && IS_ENABLED(CONFIG_KALLSYMS_LINEINFO) && !modname) {
> +		const char *li_file;
> +		unsigned int li_line;
> +
> +		if (kallsyms_lookup_lineinfo(address, sym_start,
> +					     &li_file, &li_line))
> +			len +=3D snprintf(buffer + len, KSYM_SYMBOL_LEN - len,
> +					" (%s:%u)", li_file, li_line);

[Severity: Medium]
Is it safe to use snprintf() here instead of scnprintf()?

The API contract for sprint_symbol() specifies it returns the number of byt=
es
stored. If the source file path is very long and truncation occurs, snprint=
f()
will return the un-truncated length.

This can cause caller logic errors. For example, if a kprobe triggers on a
symbol with a long source path, fetch_store_symstrlen() will allocate buffer
space based on this inflated return value. When fetch_store_symstring() wri=
tes
the truncated string, the tail of the allocated ring buffer remains
uninitialized. Future callers attempting pointer advancement via
buf +=3D sprint_symbol(...) could also be exposed to out-of-bounds writes.

Could this be changed to use scnprintf() to ensure it returns the actual
number of bytes written?

> +	}
> +
>  	return len;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801143219.3975=
824-1-sashal@kernel.org?part=3D1
