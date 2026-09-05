Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B99B35C1B1
	for <linux-modules@vger.kernel.org>; Sat,  5 Sep 2026 18:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788632674; cv=none; b=HYctApOfT4lXyb4YxlHHZjH76p4Y2BD6VyVKtLrqDMR2siG4ztuBoPhoj3XucqHYhg6PzlJ7j4q0yb9U9ASsc/RI/0vL9KJjv+C3mfr1LYlqiTCpO+EVr0Qg8w5M4DFuIjrvijcXfB4/eLubWmgBzLGL4tLGsafrT8O1e/nseX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788632674; c=relaxed/simple;
	bh=cLU4C+a8OusdWY1feS4BnBMB2UqsQY0LSPXww0UefTQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jlPQNHI3sDZtim9zPMPA09lQev6aj4Nnm16VjqHRLh8t9Cs5EscY1D+v88cX8oNZ1cYrTOcHcJnkP6MEvTzTUpxwg/w/r5/7eR84WJQfRmuK0gu+rdtwYeICMIGGQsOHD/e8BAx5vOLL35yVYfUxLqoT38M+K41KBP7Z23bHZ4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ve1S4nWE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ve1S4nWE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A7481F00A3A;
	Sat,  5 Sep 2026 18:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788632672;
	bh=OAiQechsp7RW2OX1azpdHfvTcmd5o+lcbrfS1dcfX+w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ve1S4nWEjUW2wB6cMTj8DbB6kQps0nW3c+67NlnOJ6+Cjl7y/7+CUBHxmxSo2t0ZZ
	 eflKZo4hMyYfp+Krzesi0oh+Q6qguH94pp8qj52M26b3UIVUmWXk/glxJjkPu2gnr7
	 Qe9vws9xlibCE0YOuvIpb4Qb6HK8zFOSQBfQgoG4oSaXh+ceH1+z7Ao+EMXo2+/waQ
	 NRG89Ms1i72bEZkNN7zcm+m8Kw7Pw2o1krkP7/NLkT3YcqfJuL7u7Gwn+UfvWo6MP9
	 1oHEgL8/uyYh3750QMXw8dJJeiyX6BPUA6kKVhcHdqqwU8e8i5FczsMgRtrjj7Wn0d
	 jLdTKrV9lIz2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 35/43] dyndbg: split multi-query strings with @
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
In-Reply-To: <20260905-dd-cmap-part2-clean-v8-35-a4cc0674f6fd@gmail.com>
References: <20260905-dd-cmap-part2-clean-v8-0-a4cc0674f6fd@gmail.com>
 <20260905-dd-cmap-part2-clean-v8-35-a4cc0674f6fd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 18:24:31 +0000
Message-Id: <20260905182432.4A7481F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The selftest intended to verify the new '@' query separator mist=
akenly uses ';' instead, leaving the new feature untested.
- [Medium] Unconditional string splitting on '@' breaks valid queries conta=
ining literal '@' characters (e.g., in format strings for device tree addre=
sses or emails).
--

commit 02bd61a3e52ea827cb76db337dc5c8fc31993564
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg: split multi-query strings with @

This patch adds '@' to the existing ';' and '\n' multi-command
separators, which is more shell-friendly, so you can more fully avoid
quoting and escaping hassles. It also updates the selftests script.

> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index 6f700de9738c4..93a5a481c8b8c 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -631,7 +631,7 @@ static int ddebug_exec_queries(char *query, const cha=
r *modname)
>  	int i, errs =3D 0, exitcode =3D 0, rc, nfound =3D 0;
> =20
>  	for (i =3D 0; query; query =3D split) {
> -		split =3D strpbrk(query, ";\n");
> +		split =3D strpbrk(query, "@;\n");

[Severity: Medium]
Will this unconditional string splitting on '@' break valid queries contain=
ing
literal '@' characters?

For example, format strings containing device tree addresses or emails like
dyndbg=3D"format \"node@1000\" +p". It seems they will be incorrectly split=
 at
the '@' character before quote-aware tokenization occurs, causing syntax
errors and failing to enable the intended debug statements.

>  		if (split)
>  			*split++ =3D '\0';

[ ... ]

> diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/t=
ools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
> index f0b18afa73722..0bb3c3e11df75 100755
> --- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
> +++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh

[ ... ]

> @@ -325,9 +325,19 @@ function FT_basic_queries {
>      ddcmd "module params +l"  'kernel/params.c'
>      ddcmd "module params -m"  'kernel/params.c'
>      ddcmd "module params =3D_"  'kernel/params.c'
> +}
> +
> +function FT_multi_query {
> +    v_echo "${GREEN}# MULTI_QUERY_TESTS ${NC}"
> +    if [ $LACK_DD_BUILTIN -eq 1 ]; then
> +	echo "SKIP - test requires params, which is a builtin module"
> +	return
> +    fi
> +    ddcmd =3D_ # zero everything
> =20
> -    # multi-query commands split on ; on a single line
> +    # multi-query commands on a single line, split on ;/@ respectively
>      ddcmd "module params +mf ; module params func parse_args +sl"  'kern=
el/params.c'
> +    ddcmd "module params -f ; module params func parse_args -l"  'kernel=
/params.c'

[Severity: Medium]
Does this selftest command mistakenly use ';' instead of the intended '@'
separator?

The comment right above in FT_multi_query() indicates it tests splitting on
';/@ respectively', but both commands use ';', which means the new '@'
separator feature remains completely untested here.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905-dd-cmap-pa=
rt2-clean-v8-0-a4cc0674f6fd@gmail.com?part=3D35
