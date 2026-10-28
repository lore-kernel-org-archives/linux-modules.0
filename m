Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793219123;
	b=3+/Iyx70D+2DP6cWBuoCvJH5jd7QSsGWMhxrAHEVMGKYREWQI4Sc0n5e1BeO+1vqw5Ur
	 ixwVRAgbOFFPAeS5+emieDURDxY+1TgDIoTpmBrcDxttlBF2VXTE1MC64AgDS93OMHzwG
	 7ZZmpk1rxojX5y4CzDDq/U0QsAhCpsyunlk+8hUhDqvlZbTkdFeqEu0sc4eUZpMpKkp9l
	 kZv+is+uYh8Yjo6mhwbN6ZJgEkSz7x3LLZrJGMMOdZC/fqfy/Iqd1RUaTwHgiu8VcdTSe
	 8bR29YdA+pG7QnOoF4iKbNVi20F7hOSCkYXvm5dAT6aQE2phy6RAsFjf6tx8qGDszhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793219123;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=im4vE6T4fp0TQnYmj1ZMGNvailJ73yGfxGWlNlyM8gQ=;
	b=Bku3N3kQ3pKPClipUbiz2Y/0hgvnrYfeyX4suJn+9Z+73EN/r2+hfq5mYmCbpo7UDPJz
	 byHiGn3ibpw4dhDowLx8fy+WCoKtxsgG7ZtEwICsv5fjZ0WK4bi+f3IwSAa2Elj5N0x/p
	 kck56T4jqdwxJXC9X+7vIf3GvCEW1w3TGs+lUHd3zHW35rnaXsWCPehr7FrkMJyCvzvf+
	 OSClBRVPIwY/w5m7TDF8vKv1TopaJdPYS4EnQzscdoAeJhTnuFQ/pV5TiUggmhFGgb/S5
	 kg0/XsieLu5J8FxUo87yiu7c2zdiOxr5PhsDoQfgnWnpdLM6LmvQVGeV5U6GpcgLW0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lLdN5zpT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06B4606A31C;
	Wed, 28 Oct 2026 20:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lLdN5zpT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10DE31F01828;
	Wed, 28 Oct 2026 20:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793219122;
	bh=im4vE6T4fp0TQnYmj1ZMGNvailJ73yGfxGWlNlyM8gQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lLdN5zpTayZ91G5Q2JOPwWdEPVUEMIBkIlvdCgeUS9H8WpFFRSblhI6MwwEwTGrHw
	 3xVuMG4Col7k/SPmVxSdWe3ypT0RGPWMaeBhYGvtrUxOqZcWL/B0nz0cPY7PuuocBv
	 GlSFLeCXElrnlW9mkOzdWBCknepotJfS8grmgc1xNXZu6gLyy9ljfsnucPTnw87hFw
	 Yur74tRxqx0wMTr+hLGs3Oeir7lljNFWl4vuWNbn2Hz7x91iWFYs7zIcpNEONcs7PM
	 QmgWLMSxglZEKsruJiX5HCHlbRrNpq538Xn7D9Hw6xwE6zAp2i7RU2nbzhIQx7c4pj
	 Kl+ZJYD8kUGjQ==
Message-ID: <sashiko-outbox-188406@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 30/39] dyndbg: split multi-query strings with @
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>, "Jason Baron" <jbaron@akamai.com>, "Shuah
 Khan" <shuah@kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>, "Thomas
 Zimmermann" <tzimmermann@suse.de>, "David Airlie" <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, "Arnd Bergmann" <arnd@arndb.de>, "Luis
 Chamberlain" <mcgrof@kernel.org>, "Petr Pavlu" <petr.pavlu@suse.com>, "Daniel
 Gomez" <da.gomez@kernel.org>, "Sami Tolvanen" <samitolvanen@google.com>, "Aaron
 Tomlin" <atomlin@atomlin.com>, "Jonathan Corbet" <corbet@net.net>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Nathan Chancellor" <nathan@kernel.org>, "Nicolas
 Schier" <nsc@kernel.org>, "Shuah Khan" <skhan@linuxfoundation.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Pavel
 Machek" <pavel@kernel.org>, "Len Brown" <lenb@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>, "Petr
 Mladek" <pmladek@suse.com>, "Steven Rostedt" <rostedt@goodmis.org>, "John
 Ogness" <john.ogness@linutronix.de>, "Sergey Senozhatsky" <senozhatsky@chromium.org>,
 =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <linux@weissschuh.net>, "Jason A.
 Donenfeld" <Jason@zx2c4.com>
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org, "Jason
 Baron" <jbaron@redhat.com>
In-Reply-To: <20261027-dd-cmap-part2-clean-v13-30-9267923be612@gmail.com>
References: <20261027-dd-cmap-part2-clean-v13-0-9267923be612@gmail.com>
 <20261027-dd-cmap-part2-clean-v13-30-9267923be612@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 20:25:20 +0000
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] dyndbg: ddebug_find_delimiter() tracks quotes across comments an=
d newlines
--

commit 0c538c4aea6cd34ef1fce80f637f8815b5c63761
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg: split multi-query strings with @

This commit adds '@' as a multi-command delimiter alongside ';' and '\n' in
dynamic debug queries, using a quote-aware helper ddebug_find_delimiter() to
avoid splitting on delimiters inside quoted strings. It also updates the
dynamic debug documentation and selftests accordingly.

> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index 5d99c3aef5a16..11f7350f35907 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -622,6 +622,30 @@ static int ddebug_exec_query(char *query_string, con=
st char *modname)
>  	return nfound;
>  }
> =20
> +/*
> + * Split multi-query string on delimiters (@, ;, \n), ignoring delimiters
> + * that appear inside single or double quoted strings.
> + */
> +static char *ddebug_find_delimiter(char *str, const char *delims)
> +{
> +	bool in_quote =3D false;
> +	char quote_char =3D 0;
> +
> +	for (; *str; str++) {
> +		if (*str =3D=3D '"' || *str =3D=3D '\'') {
> +			if (!in_quote) {
> +				in_quote =3D true;
> +				quote_char =3D *str;
> +			} else if (*str =3D=3D quote_char) {
> +				in_quote =3D false;
> +			}
> +		} else if (!in_quote && strchr(delims, *str)) {
> +			return str;
> +		}
> +	}
> +	return NULL;
> +}
> +
>  /* handle multiple queries in query string, continue on error, return
>     last error or number of matching callsites.  Module name is either
>     in the modname arg (for boot args) or perhaps in query string.
> @@ -632,7 +656,7 @@ static int ddebug_exec_queries(char *query, const cha=
r *modname)
>  	int i, errs =3D 0, exitcode =3D 0, rc, nfound =3D 0;
> =20
>  	for (i =3D 0; query; query =3D split) {
> -		split =3D strpbrk(query, ";\n");
> +		split =3D ddebug_find_delimiter(query, "@;\n");
>  		if (split)
>  			*split++ =3D '\0';

[Severity: Medium]
Can ddebug_find_delimiter() drop or merge subsequent lines in a multi-line
query when a '#' comment contains an apostrophe or when a line has an
unclosed quote?

Previously, ddebug_exec_queries() called strpbrk(query, ";\n"), which
unconditionally split the input buffer on '\n' before comment handling in
ddebug_exec_queries() and ddebug_tokenize():

lib/dynamic_debug.c:ddebug_exec_queries() {
	...
	query =3D skip_spaces_and_commas(query);

	if (!query || !*query || *query =3D=3D '#')
		continue;
	...
}

lib/dynamic_debug.c:ddebug_tokenize() {
	...
	while (*buf) {
		...
		if (*buf =3D=3D '#')
			break;	/* token starts comment, skip rest of line */
	...
}

With ddebug_find_delimiter(query, "@;\n"), quote state is tracked across '#'
comments and across '\n'. If a multi-line write to
/proc/dynamic_debug/control contains an apostrophe inside a comment, such a=
s:

  # don't enable foo
  func bar +p

or an inline comment:

  func foo +p # module's debug
  func bar +p

ddebug_find_delimiter() sets in_quote =3D true on the '\'' and ignores the =
'\n'
at the end of the comment line. As a result, "func bar +p" is merged into t=
he
commented line and silently discarded when ddebug_exec_queries() or
ddebug_tokenize() skips the comment.

Similarly, if a line has an unclosed quote, ddebug_find_delimiter() no long=
er
splits at '\n'. On a multi-line buffer, subsequent lines are concatenated
into the broken line instead of failing that line and continuing. On a
single-line write via echo, the trailing '\n' is left attached to the query
string and emitted in the v2pr_info() and pr_err("unclosed quote: %s\n", bu=
f)
messages, which also appears to be why the golden hashes for the unclosed
quote tests (FT_grammar_errs.1, FT_grammar_errs.21, and FT_grammar_errs.41)
changed in GOLDEN_RECORDS in
tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh.

Should '\n' always terminate a query (and reset quote state, or be split
before scanning for ';' and '@'), and should '#' comments outside quotes sk=
ip
to the end of the line?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-dd-cmap-pa=
rt2-clean-v13-0-9267923be612@gmail.com?part=3D30
