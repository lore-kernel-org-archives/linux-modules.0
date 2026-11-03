Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793743289;
	b=XR48tazJeTK5+CpZozdk/8RVrg1JqWdCWV2jvYAdan3TnvJ9P1aTMDKwxels6Br2njaj
	 uill3osMQbVnzqeTcNgL+OoiGQ9fBijybC5HNjnZ4hACd98LFInRckK6c7w3JuVIhXsRU
	 JUm+VeYQqDrBwHC41jVQteUgu2pSiRD7cWbr9Ieul2m8acoSp6i/ujisc42sBdHscfK++
	 CCgvpNHw/9u7kEotsDxQCmNQfr2W8d0LfjZWvdL+TgcJ5Kdyfm5Ti3snsKrW+awTG+Qad
	 cDVeHJ5tzWBW/t/fTjwiwFLEtKPlceBL0UvRbHWmABDTsu68yDzOie6uW1RUoL4e2+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793743289;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qS2xCuNVtbwMQHOR5Qyk0hhInlpTIzeTw1oiP5mDAeY=;
	b=BXHbYcs1p36DY4yXlfaTU00M63JFyrhd4oMHmbru6spkT3cQXCJIkX7kF2wNIGRdkkGD
	 1dZEKpeG97gBYMMWi/9ecCWBN04/8uZ+OneRkl8pEp/oBeG1NJGfZ+QNg7ldjJ14U+fC8
	 8+Ec1qPZxlI1XdUQsJMLvAUPt53MMAeafu2Bk98BF0Aqw4whxyzBQiMb6B0PxhyM1T72P
	 4vBCQ1P0JC5dvxvRHHmMAkB28LU9M5I332foCIBhBFsyOX3gSBydzXDiozt2rHpP4KxcJ
	 Xl5EZHQtX9EBnQ8wtLdc41WTRJAdb3OL35APeKjvBNaLzDd7GtwVurIADQ508g7KV5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MqI4fzJA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECBF606A329
	for <linux-modules@vger.kernel.org>; Tue,  3 Nov 2026 22:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MqI4fzJA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AABC1F00919;
	Tue,  3 Nov 2026 22:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793743288;
	bh=qS2xCuNVtbwMQHOR5Qyk0hhInlpTIzeTw1oiP5mDAeY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MqI4fzJAg6q7TDSxinuycU1MrR/LZxOFj3KQNbATKIkMgcj1SmoIWQQTmid+CPJ+N
	 RRoJboegTDcC9J+tjsTl0BNGO97PNb9BXbCFY/M6Mtjvx1VLaNl2A41rH77jzEKJaQ
	 FUP+3okTNt7AUjGEKsbBSzOrkPfHBuEwnHDu4mJtQkixthkRvNz4R8jfqbHYrrs+rk
	 jjurC2VwxlXRL3rP/TvReiTExj5inm+4VACh5+v+G1srZzTlBhSzQPRacKYm4TfZqd
	 xPnCSCo4diDvBnO5Qh5QKDU5CxC3n0tY9Wcixi7sb9nTCM0F0RnxDpBqgZGrZXDC7F
	 91DRbc2O6Xq0w==
Message-ID: <sashiko-outbox-196090@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 2/3] module: Extend module_blacklist parameter to
 built-in modules
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-modules@vger.kernel.org, "Petr Pavlu" <petr.pavlu@suse.com>, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261103214223.32598-3-atomlin@atomlin.com>
References: <20261103214223.32598-1-atomlin@atomlin.com>
 <20261103214223.32598-3-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 22:01:28 +0000
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
- [Low] module: missing kernel-parameters.txt update for module_blacklist=3D
--

commit b07237b9f1588393358dd2a97ba3add75969d76b
Author: Aaron Tomlin <atomlin@atomlin.com>

module: Extend module_blacklist parameter to built-in modules

This commit extends the module_blacklist=3D command-line parameter to built=
-in
modules by recording their initcall functions and module names in a
.initcall.modnames section. During early boot, do_one_initcall_builtin()
checks this table and skips initcalls for blacklisted built-in modules, with
parameter handling moved to init/main.c so it also works when CONFIG_MODULES
is disabled.

> diff --git a/init/main.c b/init/main.c
> index d7bf1ffc5f503..99df129d3b296 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1406,6 +1406,56 @@ static inline void do_trace_initcall_level(const c=
har *level)
>  }
>  #endif /* !TRACEPOINTS_ENABLED */
> =20
> +extern struct initcall_modname __start_initcall_modnames[];
> +extern struct initcall_modname __stop_initcall_modnames[];
> +
> +/* module_blacklist is a comma-separated list of module names */
> +static char *module_blacklist;
> +bool __init_or_module module_is_blacklisted(const char *module_name)
> +{
> +	const char *p;
> +	size_t len;
> +
> +	if (!module_blacklist)
> +		return false;
> +
> +	for (p =3D module_blacklist; *p; p +=3D len) {
> +		len =3D strcspn(p, ",");
> +		if (strlen(module_name) =3D=3D len && parameqn(module_name, p, len))
> +			return true;
> +		if (p[len] =3D=3D ',')
> +			len++;
> +	}
> +	return false;
> +}
> +core_param(module_blacklist, module_blacklist, charp, 0400);

[Severity: Low]
This patch moves core_param(module_blacklist, ...) to init/main.c and exten=
ds
module_blacklist=3D via do_one_initcall_builtin() so that it also skips
initcalls for built-in modules defined with module_init(), even when
CONFIG_MODULES=3Dn.

However, Documentation/admin-guide/kernel-parameters.txt still describes
module_blacklist=3D only in terms of loading modules:

	module_blacklist=3D  [KNL] Do not load a comma-separated list of
			modules.  Useful for debugging problem modules.

The follow-up patch in the series (commit 7bf71ba917d2 ("module: Rename
module_blacklist to module_denylist")) renames the entry to module_denylist=
=3D
without updating this description either.

Should Documentation/admin-guide/kernel-parameters.txt be updated here to
mention that module_blacklist=3D also skips initialization of built-in modu=
les?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103214223.3259=
8-1-atomlin@atomlin.com?part=3D2
