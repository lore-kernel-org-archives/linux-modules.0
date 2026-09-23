Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD4B37F313
	for <linux-modules@vger.kernel.org>; Wed, 23 Sep 2026 22:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790203619; cv=none; b=ahepOjid4E7kfkd7F8doMr6i+1hj/mhsCOvwvcTUq3GB24ngdtKfPCMCt3cPPfnKpHjKa0hRjU106Ju6fJ66OD0NZyG1eeOQToQ1Bog58WVxfPNdTLbLpWimu6I7m1gTEcK5yIO31OED8aThrAPuq7pg/jeoXVDYjMKM9DQ0L0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790203619; c=relaxed/simple;
	bh=KNN97Go3YdZT8zaDEGP3a04v/Pzrvsb4l3Oz+QPTLyg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YVLNSNPX2RLIvHqB9L1kkQM1lPGkCtjvbY4qmV1OF3MwYhP/UE/MPfnBquaYcmZMdnfT4iVrInWewnr0tvpbkr7Or/+sHMparlnmDaqx0hwLxYuw6O+5jon1CU+1g1V+48lENUfGBH/FBezRPHdDWtcQsuomTJmx8yzaLSTqX4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNyFEUjq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNyFEUjq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F5C71F000FF;
	Wed, 23 Sep 2026 22:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790203617;
	bh=zV7Edqh6VJLJxXbpJs0WM2q3SWyu+jjHY7Utst0DXXA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZNyFEUjqK03hbyuiVsl/layy3lNQmF5cCYlYDtglYd86vcHap2Z7xnqIoI8DKZdsw
	 pe0ncPcKXqB/Psg+ga4OV7hfkkcOt5w7FZ2c3fN1mwj6j/Fz9tlGax/eMSoVg+lnxO
	 3Nn+Ba3XP3dPhBieC//EqUpPPt75PjOE0T5DxmZHw3FDRol+B7kBem7bwAPKdaG4lE
	 DfU13h9YehiGZS3v0sDqYBVkdxZp4camSO31CA3ZXIhLY6EBbZNg6ur7WK+pJiKHZZ
	 Jg5BB+tkpFgx+F9UUUdpM5mFPZc+6V/s0Lj7blF+2BwsTXrzUyburkLCBKoU08KUyA
	 y2re62EjFWNbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 29/38] dyndbg: control-parser: treat comma as a
 token separator
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: linux-modules@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260923-dd-cmap-part2-clean-v11-29-9b6c217fdf2f@gmail.com>
References: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
 <20260923-dd-cmap-part2-clean-v11-29-9b6c217fdf2f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 22:46:56 +0000
Message-Id: <20260923224657.3F5C71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] dyndbg: UAPI break for unquoted commas in queries
--

commit 3647cd55c26b2f7588078b414e3120a9276258a8
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg: control-parser: treat comma as a token separator

This commit updates the dynamic debug control parser to treat commas as
token separators alongside spaces and tabs. This is intended to allow users
to avoid shell quoting issues by substituting spaces with commas.

> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index 8eef2e7387a98..6482fd28def46 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
[ ... ]
> @@ -336,8 +344,8 @@ static int ddebug_tokenize(char *buf, char *words[], =
int maxwords)
>  	while (*buf) {
>  		char *end;
> =20
> -		/* Skip leading whitespace */
> -		buf =3D skip_spaces(buf);
> +		/* Skip leading whitespace and comma */
> +		buf =3D skip_spaces_and_commas(buf);

[Severity: High]
Does this introduce a UAPI regression for existing unquoted queries that
contain commas?=20

For example, if a user currently submits a query like "format a,b +p" via
the debugfs interface, the parser would previously see three tokens: "forma=
t",
"a,b", and "+p".

With commas treated as separators here and in the loop below, wouldn't this
result in four disconnected tokens: "format", "a", "b", and "+p"?

>  		if (!*buf)
>  			break;	/* oh, it was trailing whitespace */
>  		if (*buf =3D=3D '#')
> @@ -353,7 +361,7 @@ static int ddebug_tokenize(char *buf, char *words[], =
int maxwords)
>  				return -EINVAL;	/* unclosed quote */
>  			}
>  		} else {
> -			for (end =3D buf; *end && !isspace(*end); end++)
> +			for (end =3D buf; *end && !isspace(*end) && *end !=3D ','; end++)
>  				;

[Severity: High]
Because the parser now explicitly stops at commas within an unquoted string,
existing queries containing unquoted commas will be split.

Since ddebug_parse_query() expects an even number of match-spec tokens
(checking nwords % 2 !=3D 0), won't it fail and print "expecting pairs of
match-spec <value>"?

This would break automated scripts or user commands that pass unquoted
commas in their match arguments. Is there a way to support commas as
separators without breaking existing unquoted comma usage?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-dd-cmap-pa=
rt2-clean-v11-0-9b6c217fdf2f@gmail.com?part=3D29
