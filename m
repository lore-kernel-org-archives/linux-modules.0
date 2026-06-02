Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFCC3CBE73
	for <linux-modules@vger.kernel.org>; Tue,  2 Jun 2026 23:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780441280; cv=none; b=F7tkjUkiHDEqYTelYkFUoN0gTYRlRgLqJ6xRMart0LfYqJw6wDwJciaW655ViX4+MIDGEx48EzP8akEbgT6Jtl8BEbybOFCESmYUS2uP14ei2qMsOZOhJWreMyxu3hb5eUWuanRMjvuKNE2gKK09Nol3ua8SQJshxDrDvD7r0vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780441280; c=relaxed/simple;
	bh=n50uXbJ28y+uvi3esoZeNTaSi+0Vnry+e+0CD3KkWL0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WNyxCYhobt8WJ0Loewzk73H8jrds2dGEGhsa0gKDHIfVSeX0eZEVCaGuuujp7Cix7CR4z+xDvW//2Wb49gxfT2FGYVm/C63HtNTYBFT0BWMpU8L6fVgVhnfuV/LEnpkKadR8O2tUimHgLPc5dVl+J3P6qM/RZydnQCytSa0YAKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxUsLEmB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxUsLEmB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF531F00893;
	Tue,  2 Jun 2026 23:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780441279;
	bh=0DHd3T7WCvX2G0o36nulYmOiqQQfpbAodg47bLJkgfA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oxUsLEmBljRYqXUf5+/8M3NoMwOc1NpbKXROiRAVxBsWApRgb5mkIk/FWUWlbsECO
	 fNTKcppKWZbx+HmNyP8OdmjI3thfcTP8yGeI/zPIcUJXjSNaKdDaILAaJ6OenDXOr6
	 ykfDoglU6Wj5OK3+OpTP2rIU7MEimmfiO2r0lNPNLwGkCyE+ZD48riIBKq5qu39TW2
	 b8ELu5hr5tgf6R+9fffkE6xnrziPuhHy5amCIxJU3dIRrRPGWoquOCO3W8FUlXfiWi
	 BXRE4KKhVWGW3RSBNA90u3IoXPK3Sc00B76cLloMzEXFEJhysaoSbaroIjHLvu6eM9
	 N1GhrZisjpmSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 22/25] selftests-dyndbg: add a dynamic_debug
 run_tests target
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260602-dd-maint-2-v4-22-19a1445585a8@gmail.com>
References: <20260602-dd-maint-2-v4-22-19a1445585a8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 23:01:19 +0000
Message-Id: <20260602230119.5DF531F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Unconditional full read of the trace buffer risks memory exhaust=
ion and test hangs.
- [Low] Flawed shell redirection fails to silence stderr in `ifrmmod`.
--

commit b7cfa1be78853b6d269ce0f8b3593fb8481c478f
Author: Jim Cromie <jim.cromie@gmail.com>

selftests-dyndbg: add a dynamic_debug run_tests target

This commit adds a selftest script for dynamic-debug and includes it in
the selftests Makefile. The script currently has basic tests which modify
pr_debug() flags in the builtin params module.

> diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/t=
ools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
> new file mode 100755
> index 0000000000000..1239f1e105911
> --- /dev/null
> +++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
[ ... ]
> +function error_log_ref {
> +    # to show what I got
> +    : echo "# error-log-ref: $1"
> +    : echo cat \$2
> +}
> +
> +function ifrmmod {
> +    lsmod | grep "$1" 2>&1>/dev/null && rmmod $1
> +}

[Severity: Low]
Are the shell redirections in the correct order in ifrmmod()?

Bash evaluates redirections left-to-right, so `2>&1` first redirects stderr
to the original stdout, and `>/dev/null` then redirects stdout to
`/dev/null`. This causes any stderr produced by the command to leak to the
terminal instead of being properly silenced.

Should this use `>/dev/null 2>&1` instead?

[ ... ]
> +# $1 - trace instance name, 0 for global event trace
> +# $2 - line number counting from the bottom
> +# $3 - text to search for
> +function search_trace_name() {
> +	if [ "$1" =3D "0" ]; then
> +	    buf=3D$(cat /sys/kernel/tracing/trace)

[Severity: Medium]
Will this unconditional read of the entire trace buffer risk memory
exhaustion?

Ftrace buffers can grow to hundreds of megabytes or gigabytes, and reading
them entirely into bash memory risks OOM kills or severe performance
degradation.

Additionally, if a specific line is requested for checking (when `$2 !=3D 0=
`),
the `buf` variable is populated but ignored during the search evaluation,
making the expensive read entirely useless.

Although the commit message notes these functions will be used shortly,
could this logic flaw cause test hangs when the function is utilized?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602-dd-maint-2=
-v4-0-19a1445585a8@gmail.com?part=3D22
