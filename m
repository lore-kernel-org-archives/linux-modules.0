Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2BC372073
	for <linux-modules@vger.kernel.org>; Mon,  1 Jun 2026 12:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780316202; cv=none; b=ZIFvIzwLVZB6YgwKGCSoPJslKcaDLK1JW6i+TMJvK//CMzsq4aH879w8iz1a8Gg8iOHfLEV4wpJOCyl4Kdz6/mGfX6Mb4kY/aNkGe5Dm6ub68vTAv2MSSIbEMqZ+fCRAlUxim2FQcVnZUpJX7uE8LzsQiOyeoM+/VECcjFD2djU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780316202; c=relaxed/simple;
	bh=heKeqj1VrvZzgGxburSR5Ki197u22mpkJiHrB/VkVag=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FQ0WU+goxMSSMqnvpNpsFFeW6rAal5+wrXG7DKr+eic/+pRaHwk2rA5ul1T42IlJHZ7uNxri6nYseiuzacQxkYUMUtHl/76eIAyvsxIaipcCIOQXXqRYr0z8JPXWptFxQiDZS5iIPQwk9WrUrHRX0aLy5ARez9Ob3PCh2r6P2pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTzVAMTX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTzVAMTX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 815001F00893;
	Mon,  1 Jun 2026 12:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780316201;
	bh=POZMb1jdGG4gTbzr3gBInMrID1M1xtjHnD3Td9h1tJE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YTzVAMTXyA96Npl8erqZjuSq65yoZ+sJ1px3fHzGRtDv/JY25kSJotf5pO9tAxEWZ
	 ePWzzjrb1Kb90HSGbF4KUJw1dWu8HbDfb9o/GtcYKY9DZ7GZYR2bzZVDmp0JMxAh11
	 hxJkWplO88CEa0ZM31SXBZuhSclWpSxTDSHeMXYcDgjJ2UQ1+jr/iQPaCxh4VaVywf
	 khzFYH/b8sO01KTLsXE5l9kTlETPTnt9Uw7Ma6HYCYayni2/CYJeYps2dWpE9SlMhV
	 rM7M8UOqdP46u2wixwU8EWFrkpBnY99i/pXrHoHBbHsl1tMXT1SuA5WWCjhk4nWbmI
	 zL8PCtbzlOiRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 13/24] dyndbg: reduce verbose/debug clutter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260601-dd-maint-2-v3-13-4a15b241bd3c@gmail.com>
References: <20260601-dd-maint-2-v3-13-4a15b241bd3c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 12:16:40 +0000
Message-Id: <20260601121641.815001F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] Loss of 'no matches' diagnostic output at verbose=3D1.
- [Low] Commit message output mismatch due to double space formatting.
--

commit 4e15442ecf24d2ba351dc5e3411a51965df2f4c3
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg: reduce verbose/debug clutter

This commit reduces verbose and debug clutter in dyndbg by condensing
multi-line logging output into single lines and dropping unnecessary verbose
messages during query execution and module addition.

> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index 0377d9f8dcd1f..bacb55f960faf 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -276,9 +276,6 @@ static int ddebug_change(const struct ddebug_query *q=
uery,
>  	}
>  	mutex_unlock(&ddebug_lock);
> =20
> -	if (!nfound && verbose)
> -		pr_info("no matches for query\n");
> -

[Severity: Low]
Is it possible this unintentionally hides the 'no matches' diagnostic output
from ddebug_change() for users with verbose=3D1?

The commit message mentions that this status is retold later in the output,
but that updated line is printed using v2pr_info() in ddebug_exec_queries().
Since v2pr_info() requires verbose >=3D 2, users running with verbose=3D1 w=
ill
lose this diagnostic feedback when queries don't match.

>  	return nfound;
>  }

[ ... ]

> @@ -593,7 +587,8 @@ static int ddebug_exec_queries(char *query, const cha=
r *modname)
>  		if (!query || !*query || *query =3D=3D '#')
>  			continue;
> =20
> -		vpr_info("query %d: \"%s\" mod:%s\n", i, query, modname ?: "*");
> +		vpr_info("query %d: %s%s \"%s\"\n", i,
> +			 modname ? "module " : "", modname ?: "", query);

[Severity: Low]
Will this format string produce a double space in the output when modname
is NULL?

If modname is NULL in ddebug_exec_queries(), both %s formatters evaluate to
empty strings. This leaves the space after the colon and the space before
the quote adjacent, resulting in a double space before the query string.

This isn't a bug, but it contradicts the single space output explicitly sho=
wn
in the commit message.

> =20
>  		rc =3D ddebug_exec_query(query, modname);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601-dd-maint-2=
-v3-0-4a15b241bd3c@gmail.com?part=3D13
