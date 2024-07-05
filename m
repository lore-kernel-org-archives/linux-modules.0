Received: from relay3-g.mailbaby.net (relay3-g.mailbaby.net [66.45.229.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD9F149C6A
	for <linux-modules@vger.kernel.org>; Fri,  5 Jul 2024 10:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.45.229.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720174726; cv=none; b=rK4eN64q0L8v3sJId20S//5jo+SvUkpFzaanS8MLIQUAum0Aps6C3bpp01pwgjpYwOtRsmhowWPrAZWriEjR3+sVWeZVe+7Pp8EVnfZRiOLhDkHW1UGYGkra19pmLlmdwLO9NykexclUysFY1Pp7fTNq+qzovI6aBxh58nY9RAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720174726; c=relaxed/simple;
	bh=7jgEqcjTCqs+FgYseS70xGsCqp1rhQstQZWc1/wKPSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y+RXLFiQIZo1l5dl5XY1PNWwDdCJGx6KLqx35VcLlp5KOHtvgfp9TCEXf1v8CYFKVqRmCFJpwOueMYD8jbiHwR7AYMOc3hTvlTcw4+nJrS/BGRkLbDx8Nu9algIF+bMJHzx8IGm0yzgsskvbqBvMegPyo0yfL+XQdKt+VYhIzJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=agatha.dev; spf=fail smtp.mailfrom=agatha.dev; dkim=pass (1024-bit key) header.d=mailbaby.net header.i=@mailbaby.net header.b=CDAgf5mE; dkim=pass (2048-bit key) header.d=agatha.dev header.i=@agatha.dev header.b=Ib8u6rJS; arc=none smtp.client-ip=66.45.229.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=agatha.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=agatha.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailbaby.net header.i=@mailbaby.net header.b="CDAgf5mE";
	dkim=pass (2048-bit key) header.d=agatha.dev header.i=@agatha.dev header.b="Ib8u6rJS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbaby.net;
 q=dns/txt; s=bambino; bh=P7407o4cF3B3cHSlfH75shhge4JAHbqilxKRRnWL+8o=;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:references;
 b=CDAgf5mEnPxcEZLeOyHX0NnSV0Rd23kmHFPekeozSUZ9LbblNZ8vhk70S8xhCsscIR9w5SP2k
 ShCu/bT0IoGB/YnqXwmyl4WfhcP7SeqjDTuccbCrF58WFNWE80pR6G3v5azo8CtzNT7Hu2kZ5SY
 H+Px50ivmtrKDXtOrjmmSEE=
Received: from mia3000.dnsiaas.com ([192.155.110.18] mia3000.dnsiaas.com)
 (Authenticated sender: mb6724)
 by relay3-g.mailbaby.net (MailBabyMTA) with ESMTPSA id 190826280870005453.004
 for <linux-modules@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Fri, 05 Jul 2024 10:13:31 +0000
X-Zone-Loop: bc64b7c6c2a4fc2b4920da9f5faa2990ffe9c2b1c21f
X-Get-Message-Sender-Via: mb6724: authenticated_id: code@agatha.dev
X-NS-SCAN: PASS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=agatha.dev;
	s=default; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=P7407o4cF3B3cHSlfH75shhge4JAHbqilxKRRnWL+8o=; b=Ib8u6rJS6X/+/PLmKBlRHX2yeJ
	qy4HoGVr2oLyTIFGhwSA+OUK1LcKp3CRxgkwZzt+WDv1LSv4EEYjQrAru9p2ZYTSmppHGU7/IDte2
	CF4JdLrpbmHIUgPPiHLMP5HPOo8BauyON+IKeLaaStIhmMrBylcNRG+YfIcDw/KmbWMRYbv6WlcBm
	BsKbu1dWBukyfDTYw4UeoyiNEV6CB2uPg18SqfwiwdTPuBUVZy43ZGGtlcxh4sKjvKYPcQxUgQUIv
	YnUYvLAo6bpzQvG+QBbkg77z6QY5Igi5XLV0q9Rr55xwJVSqjSPbaFee+iKEReVLIApVTNI7f1ekN
	+sZqeznw==;
Received: from [186.250.91.79] (port=19691 helo=kurupi-arch.blackcat)
	by mia3000.dnsiaas.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <code@agatha.dev>)
	id 1sPfwX-000000025By-1Ekx;
	Fri, 05 Jul 2024 06:13:29 -0400
Date: Fri, 5 Jul 2024 07:13:25 -0300
From: =?utf-8?Q?=C3=81gatha?= Isabelle Chris Moreira Guedes <code@agatha.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, patch-reply@agatha.dev
Subject: Re: [PATCH v2] init: staging: Fix missing warning/taint on builtin
 code
Message-ID: <ntho73bskbdi36rh32ufxdzs7c7yf3neo5xsemiy4bbkhzkmrn@dyoyyjjovirx>
References: <n5plxnkubcnbuyv7l24i4cwsauh4odwk6g5yiys6oiiwj3i34r@izcjggvv2om2>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jaor3nrnh2yw2jhr"
Content-Disposition: inline
In-Reply-To: <n5plxnkubcnbuyv7l24i4cwsauh4odwk6g5yiys6oiiwj3i34r@izcjggvv2om2>
X-AuthUser: me@agatha.dev


--jaor3nrnh2yw2jhr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

Please disregard this one, there will be a v3 soon.

There were some oversights on my side regarding some review points, and
also the code itself.

On Thu, Jul 04, 2024 at 09:20:49PM GMT, =C1gatha Isabelle Chris Moreira Gue=
des wrote:
> diff --git a/init/main.c b/init/main.c
> index 206acdde51f5..a297675dd397 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1602,3 +1602,23 @@ static noinline void __init kernel_init_freeable(v=
oid)
> =20
>  	integrity_load_keys();
>  }
> +
> +#ifdef CONFIG_STAGING

Here we break the building in kernel configs where `CONFIG_STAGING=3Dn`
because:

> +/**
> + * staging_init_taint() - We need to taint the kernel whenever staging c=
ode
> + * is initialized (from built-in drivers) or loaded (as modules) and iss=
ue
> + * a warning the first time it happens.
> + */
> +void staging_taint(const char *code_id, bool module)
> +{

^ `staging_taint()` is built only with `CONFIG_STAGING`, and

> +#endif /* CONFIG_STAGING */
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index d18a94b973e1..d7d33336ab43 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2039,9 +2039,7 @@ static void module_augment_kernel_taints(struct mod=
ule *mod, struct load_info *i
>  	check_modinfo_retpoline(mod, info);
> =20
>  	if (get_modinfo(info, "staging")) {
> -		add_taint_module(mod, TAINT_CRAP, LOCKDEP_STILL_OK);

here we call `staging_taint()` regardless of having `CONFIG_STAGING` or
not. So on all kernels with modules enabled this patch as it is now
would break the builds.

I just noticed a couple of hours after submission when I was looking at
it again.

I'll fix it and submit v3 soon.


--jaor3nrnh2yw2jhr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQMdxNgKl/8Z+5yuVT3jE4VBgsOTAUCZofHPwAKCRD3jE4VBgsO
TDOgAQDK1u0p/uGNzQYphLK2DjZywb57FlvwmsNtXZUpWQ9slgEAvs66Q1fqoSTX
mSfAaukLZ0DbRHoA71KisjCk8DNWGQw=
=teyj
-----END PGP SIGNATURE-----

--jaor3nrnh2yw2jhr--
