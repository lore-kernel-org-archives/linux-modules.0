Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76AF4BD10C
	for <linux-modules@vger.kernel.org>; Sat,  5 Sep 2026 18:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788632760; cv=none; b=DgiyH4uJmh4wRIwzscBLk+6x76Jyke6mFTTyLQaSHQOw2uT5sgjxedPSJfch32l1X4/LvwIIBcmwxYlHESFm0s4F3QRqqksVejC2NC/ip3xDJMjzKilf6CszTWEB50DR6PkIcFjORgYP3AMWW0xKWFNjKcQ5GCEWirqEO+vSqeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788632760; c=relaxed/simple;
	bh=CB3A4Eo4T/S1gxsHcMs7WJM/rrltMfNfgeGdGFbkhrE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VQTP/4BUZGsKLrZIfu7zOIZQlEGFdJKJDgReAuIFzbLpFxSkH3pFdkTPsamZVYyZB1qTD5brvQg98nRHHnl5XNcSq1weTOVQIbMbYXkujzhXagmKuhdp38DToloJKwUSjCeas0LEy4OpGrqYVnLD0po3Ro2gmHUADXa9ivMnSNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKy9lX6c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKy9lX6c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E98B01F00A3A;
	Sat,  5 Sep 2026 18:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788632759;
	bh=MsPMMEw3H2JVpz+Q+EdDIKoqphVTWWsOCNhvGoMBLFI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jKy9lX6c4mWLaMDTDhc/MovTIhg6It2vTZcT73LVIL/zT4DQlGUB0jq2AXjak32OC
	 TtTHYiNoFaulC/TFqGCeP9p5Vq8+CyntjMA8mtZN3sdwpshrRBGE0hW1+QKSdxZnBN
	 X+7kcPmZ9epAu4sy0HaCT0Gr23/cfOzctcllOPiaVPXxU8wKE7fVdFTGJZrd8CBStX
	 Off80z2MWqO247N09N3WtChbueOz0FHAJkj53NQrmRGIMbsutzHEPziToJOKVoQQyz
	 EucUOa/RJ3tqVrybPxIkROuOpa8u0//BNCKquJmww6w1AvaNAdupy2i3RLcfLATpVe
	 4pH75DX1duIpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 40/43] dyndbg: add epilogue to dynamic_debug/control
 file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: linux-modules@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260905-dd-cmap-part2-clean-v8-40-a4cc0674f6fd@gmail.com>
References: <20260905-dd-cmap-part2-clean-v8-0-a4cc0674f6fd@gmail.com>
 <20260905-dd-cmap-part2-clean-v8-40-a4cc0674f6fd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 18:25:58 +0000
Message-Id: <20260905182558.E98B01F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] ddebug_proc_start() fails to return EPILOGUE_TOKEN when resuming=
 sequence iteration at the epilogue index, which violates seq_file semantic=
s and causes the epilogue to be silently omitted if a read boundary falls e=
xactly before it.
--

commit c254572f4a41eba87d7288c5cb6c6ef71571d0a3
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg: add epilogue to dynamic_debug/control file

This commit adds an epilogue to the control-file to allow display of
statistics without disturbing the header. It introduces an EPILOGUE_TOKEN
yielded at the end of seq_file iteration.

> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index b7ccf471b5efe..d098afe8d340f 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c

[ ... ]

>  static void *ddebug_proc_next(struct seq_file *m, void *p, loff_t *pos)
>  {
>  	struct ddebug_iter *iter =3D m->private;
>  	struct _ddebug *dp;
> =20
> +	(*pos)++;
> +
> +	if (p =3D=3D EPILOGUE_TOKEN)
> +		return NULL;
> +
>  	if (p =3D=3D SEQ_START_TOKEN)
>  		dp =3D ddebug_iter_first(iter);
>  	else
>  		dp =3D ddebug_iter_next(iter);
> -	++*pos;
> -	return dp;
> +
> +	if (dp)
> +		return dp;
> +
> +	return EPILOGUE_TOKEN;

[Severity: Medium]
Since ddebug_proc_next() now yields EPILOGUE_TOKEN as an additional sequence
element, does ddebug_proc_start() also need to be updated to handle resuming
iteration at the epilogue index?

If a read boundary falls exactly before the epilogue (where pos equals the
total number of items plus one), ddebug_proc_start() will iterate until dp
is NULL, and then return NULL instead of EPILOGUE_TOKEN:

lib/dynamic_debug.c:ddebug_proc_start() {
	...
	dp =3D ddebug_iter_first(iter);
	while (dp !=3D NULL && --n > 0)
		dp =3D ddebug_iter_next(iter);
	return dp;
}

Will this cause the epilogue to be silently omitted in that scenario?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905-dd-cmap-pa=
rt2-clean-v8-0-a4cc0674f6fd@gmail.com?part=3D40
