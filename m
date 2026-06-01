Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED12374725
	for <linux-modules@vger.kernel.org>; Mon,  1 Jun 2026 12:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780316463; cv=none; b=q8hgUYBeuuff6KxQuH8l9YUy6sM+3Lv9hZyWpf/Byfb0qvITaeTkq6Yh8Zxz4xxmxC5ZBJBiNRh2C/uvDgQK+tgQXhFtjQLIqRsMmj+NHWzs7O477CGnVeJW9t6iEH5/QrNmmRVc04LL/MH+biEQ6Eq0k64NPkJSR3eYtn9gf/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780316463; c=relaxed/simple;
	bh=nyPf389pjLVld6hsBNJmt6B+xPQb4bCwTsd5iOZ/fyA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jPczw9+/gxyNbRfup3gldq3QETbpmLY6F6GEXHD2b2WAmmE/VWmHnDRjv5pu22BbiTg/J8Y9W387SuCgESga/WQF3z5dTzEnOvwhCtozGi+M4XjX4EUabmMJHh/QZdBfpx3nrMIDKqav/rUHoAMtOGYOR3S5G8c9zC4X3IrPM78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flo8J27F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flo8J27F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 360121F00893;
	Mon,  1 Jun 2026 12:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780316462;
	bh=pjbARCzrhSEFuFxs7ec6GlrsC5D3O6Yf6gVlYzStKkg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=flo8J27FlUgQkSw/gpqhol/4vnKRHKk4XhpActEHiNa69BWF5HGNKplXADrEV0cgw
	 wmwIPhqSNj6eltxbMpQKL+G8wt+pduMiEW2UV3Hxf02KdAdKHh9zzR+BZ+S8bzpf4e
	 QPldbZ+Gvz7XYhTgScTOQdg/VUcNeTuY6dSFRH2tC8RXeR2MvrltZKygE0Fu7KjTtl
	 +HxWNvRON9B1kbKZpRraZoxPu035AhsLJK9b+pL0hw20SrBhnglFn5IM5Z5zyPeTjn
	 AEku2PUm3pOpMHpWKcfRbqmiP+BH1UZsJDyLA7cXtv15e4OiBxpHbJR23/kGPlYdP8
	 cePvbBBxyic8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 22/24] selftests-dyndbg: add a dynamic_debug
 run_tests target
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260601-dd-maint-2-v3-22-4a15b241bd3c@gmail.com>
References: <20260601-dd-maint-2-v3-22-4a15b241bd3c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 12:21:01 +0000
Message-Id: <20260601122102.360121F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Unquoted variable in helper function `search_trace` truncates the s=
earch pattern if it contains spaces.
--

commit 35e29a827e53195f855e4fc5d139746aeb606df3
Author: Jim Cromie <jim.cromie@gmail.com>

selftests-dyndbg: add a dynamic_debug run_tests target

This commit adds a dynamic-debug selftest script and basic test targets
for the dynamic_debug subsystem. It introduces tests that modify pr_debug()
flags and verify their effects in the control interface.

> diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/t=
ools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
> new file mode 100755
> index 0000000000000..8b2b7388678e3
> --- /dev/null
> +++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
[ ... ]
> +function ifrmmod {
> +    lsmod | grep $1 2>&1>/dev/null && rmmod $1
> +}
> +
> +# $1 - text to search for
> +function search_trace() {
> +    search_trace_name 0 1 $1

[Severity: Low]
Does this unquoted variable truncate the search pattern if it contains
spaces?

If search_trace() is called with a multi-word string like
search_trace "error message", word splitting will cause
search_trace_name() to receive "error" as the third parameter and
"message" as a fourth parameter. Since search_trace_name() only uses
$3 for its grep pattern, it will only search for the first word.

Could this be fixed by quoting "$1" instead?

> +}
> +
> +# $1 - trace instance name, 0 for global event trace
> +# $2 - line number counting from the bottom
> +# $3 - text to search for
> +function search_trace_name() {
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601-dd-maint-2=
-v3-0-4a15b241bd3c@gmail.com?part=3D22
