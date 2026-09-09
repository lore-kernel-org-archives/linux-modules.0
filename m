Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803F6212550
	for <linux-modules@vger.kernel.org>; Wed,  9 Sep 2026 01:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788915989; cv=none; b=KlRkRfAN7WVbg7UL72TIuSprAkV5lTqml6ZZ2++1sAjdPF+gGAUW2oOKuFHFbSP09rEYWXE1CdGvEtPI5nbLNlVOEFZBuevdFwBxzMQscp14BhP3WRCLkndA8lmk+2GkErgi3wUeY9Ak2H7rdJ9Tfwlr7KEp+GcRVWGgWtOc/f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788915989; c=relaxed/simple;
	bh=OHonRcJk8osviCG6PHHYQyV+4v/P86yeQLuFJyvBIBU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KzXqSUq5mntaA9JWB8Wm8WVE8ANVSIWz0Wx4HM0q2tz3OvHgx6SkHktXFQvMrjZKgmPoQkkGRbotnAU3h00j91Gm4UyFo1viCkeT9DFqNNFfyAW63U7qlW8S6phHkn2UvLhbaGs+Q/gZ4GCtYzFlS16X/oE/lMt5o96UxI30Ra4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4jAu56u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4jAu56u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7CE71F00A3A;
	Wed,  9 Sep 2026 01:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788915988;
	bh=N/vI5mKTc4jUTJ/ro7fDJfk3hUknoVNVpuIfUrFEy7M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J4jAu56uSsFXb/GO9s2GgTLaVPdUATm8rfIvrgHruN5lhMEp3sbZcZoDj4RkDb04/
	 xg6+lQSZacWOKy1Ng09m6uM/sLktwPsD5LXs22YgdEk0j2bpDP/2eGsuC0lWFhmJUV
	 2NOHrluV87DzATNro3y+UbZwNDC/FMfxJ02+mjSpx/T1uw6qJARKhhSjHDzK22jddi
	 Mzdk1uVbnpcMvlkhmupUm4FKSDsaRpjtx4ZAB7+NVoBuCOQO/69EbQJX2OFCSRH0uj
	 KlrXeFqw5DDH19xQvoUiHzSAwglV9C0YqN426iItpIZLz2FkK3fz4/Gw/64yyXmkvH
	 toN4xQGCXD+MQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 32/39] dyndbg: split multi-query strings with @
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
In-Reply-To: <20260908-dd-cmap-part2-clean-v9-32-3a3f621f4a10@gmail.com>
References: <20260908-dd-cmap-part2-clean-v9-0-3a3f621f4a10@gmail.com>
 <20260908-dd-cmap-part2-clean-v9-32-3a3f621f4a10@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 01:06:27 +0000
Message-Id: <20260909010627.E7CE71F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Adding '@' as a naive multi-query delimiter unconditionally breaks=
 dynamic debug queries for format strings or file paths containing '@'.
--

commit 14701392fec803b263b7d4600e1eddc32de76b94
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg: split multi-query strings with @

This patch adds '@' to the existing ';' and '\n' multi-command separators
for dynamic debug. This is intended to be more shell-friendly and avoid
quoting and escaping hassles when passing commands.

> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index d28858acdc8f9..e6f5a524d63b6 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
[ ... ]
> @@ -631,7 +631,7 @@ static int ddebug_exec_queries(char *query, const cha=
r *modname)
>  	int i, errs =3D 0, exitcode =3D 0, rc, nfound =3D 0;
> =20
>  	for (i =3D 0; query; query =3D split) {
> -		split =3D strpbrk(query, ";\n");
> +		split =3D strpbrk(query, "@;\n");

[Severity: High]
Does this unconditionally split queries on '@' before they undergo
quote-aware tokenization in ddebug_tokenize()?

If a user tries to filter debug prints using a format string or file path
that legitimately contains an '@' character, such as matching a device tree
node like: format "node@1234", it appears this will destructively split the
string.

Since there is no escaping mechanism in strpbrk(), could this introduce a
regression for existing valid queries containing hardware addresses or
device tree nodes?

>  		if (split)
>  			*split++ =3D '\0';
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-dd-cmap-pa=
rt2-clean-v9-0-3a3f621f4a10@gmail.com?part=3D32
