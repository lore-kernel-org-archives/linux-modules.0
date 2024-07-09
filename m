Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE01513D8A3
	for <linux-modules@vger.kernel.org>; Tue,  9 Jul 2024 06:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720508321; cv=none; b=XdhvJaUwiynQZQck4s6MTXDx4ESHvt99I6lVyiIheQ63BJusKPv5qkc6EV4UUeIYnx4K13rt+r99VG2/zmG73diQ3NR6phaF/xD8BfeAy40TSdIpglxeqBVOA59zW9gVVf/PRXBdpHLJbFtpTR/i/KPNa+F3o8Ri3QtgLQ033oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720508321; c=relaxed/simple;
	bh=6cpbzmjkMj/+KT7yjNAf9Um11QZ/lIiDyJuGkRGSK4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uzzTkC9vCctLfakRZudGOw70eiYdFvBLqHF7UTlwWTlkjseXTiS+yqguYGCHumP1lsPaQgNp425hoEd3IPoNbdYtd9p4W6BWIGYTXt0Fvq4BwbBRVGpcYqWowFx7YUxWuIpHZqkHDrT510B8zaeE4WtIO7huuWc0yencOkUsDB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ObEg95Os; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ObEg95Os"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ee92f7137bso40689151fa.1
        for <linux-modules@vger.kernel.org>; Mon, 08 Jul 2024 23:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720508318; x=1721113118; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KBZlTb8Eof6R20qrr/sRa7dwLCzeq9PnMFLS9YGLiLI=;
        b=ObEg95Os97KgpPs/h1OXDRzNAM9ww9DynKyYBVlYWVOE1P7pFcutMx5kSywOvDbf/A
         dYacJUKOP6Q5zfTrNXdVlib3sYoTBgZnqBGDdsEknCISXskkJ0ieVsr3HMZVpkqC/OZO
         y6VZfIyEhuqqPVoaw1i+k8ycOJkLn0yEJUcArddN0/T68Ph9aP9363sQmPM7rHtYdmy8
         EwLBourqUhwUC6C2q83nGi188q2Icv6aKtGrluHb4gwnVBaNxONtgBBXbZ+VSrUAKqvO
         fQwm61A4t0pvmD6ykx5wdwsukSf0kYx9z1QuIEVlvV8iocLFnOwY4jV6d3l/S0FzSt1d
         QBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720508318; x=1721113118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KBZlTb8Eof6R20qrr/sRa7dwLCzeq9PnMFLS9YGLiLI=;
        b=i2bHsNqE9zjPoiH3MnAhRCYY7P3duQdVjoPmIooChscLhkL6AbrpDniZkPWxhynuBy
         qyRyDd+oCOiFF68Rp6sTCjJPe5uwt3Yqtnn0pQOakffxAzI+BVGsR6laU642WfXg23No
         4f3BQR5S3i8/9KqtXGkTVFLJChTB/pcM2HzV6adPmd2Vg9Oc7t5hN1nJdKiyne5PFKKd
         nHPHAOnpY19VMHEoMCOgnZCADFrtea2nMw9YkjpBwf4MPdJqPh3Zagk9SamXbtcROE5M
         +VZkUxzyuaEbCHmIcCpnCMX+rsDSPcMGEDXFoJclNXskI0Hz60EkO73ZGHpX9VahdvBZ
         OTOA==
X-Forwarded-Encrypted: i=1; AJvYcCUd9WUe5H9RCAho/61he9YSeI4UZxJz+7AmN+4vh6KClUaAU8Mr0o1xj3KTXwXqI1ynCThvMzsajpOeoh18u+3IewWde/UT4JeS6+NNwA==
X-Gm-Message-State: AOJu0YzM+0ZsAMW57elrYC1O+1lBar+Mvg6JHcjK9veyJbWo0huzMcAO
	MNsxyPW42IKc/8lD9cLUgR1IzziLr9Ibpp/PNeIS/Z19vtmHZgLIRs6KyuQcVu1W2U9bQ3MbYKx
	w
X-Google-Smtp-Source: AGHT+IGObn48yczLVOSPPn2MgOHMOxVpueStKydNv/bOLPNKAJELBv0hX605oHaZX1AC9SAjpv4s/Q==
X-Received: by 2002:a05:6512:3142:b0:52d:215b:9028 with SMTP id 2adb3069b0e04-52eb99d5d76mr931572e87.60.1720508317663;
        Mon, 08 Jul 2024 23:58:37 -0700 (PDT)
Received: from localhost (p50915e7b.dip0.t-ipconnect.de. [80.145.94.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bba548fesm706835a12.11.2024.07.08.23.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 23:58:37 -0700 (PDT)
Date: Tue, 9 Jul 2024 08:58:36 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: 
	=?utf-8?Q?=C3=81gatha?= Isabelle Chris Moreira Guedes <code@agatha.dev>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>, patch-reply@agatha.dev
Subject: Re: [PATCH v3] init: staging: Fix missing warning/taint on builtin
 code
Message-ID: <yttxdeeg6uxosoiom3jf6h5wfkgk7ths6qnqf5s3sr2nikftgh@dvexcjeznxpp>
References: <zsk54zosv6tht4j4nma4ix7lq2knxi3ylqadd2foznc72nkaa3@xbc7gpozx6ai>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3knqfckw67jieu3n"
Content-Disposition: inline
In-Reply-To: <zsk54zosv6tht4j4nma4ix7lq2knxi3ylqadd2foznc72nkaa3@xbc7gpozx6ai>


--3knqfckw67jieu3n
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sat, Jul 06, 2024 at 12:15:01AM -0300, =C1gatha Isabelle Chris Moreira G=
uedes wrote:
> Fix the absence of warning message and kernel tainting when initializing
> drivers from the `drivers/staging` subtree from initcalls (when
> configured as built-in).
>=20
> When such a driver is built as module and the module is loaded, the
> `load_module()` function taints the kernel to signal code of unknown
> quality is loaded, and produces a warning like this:
>=20
> [    8.076352] rts5208: module is from the staging directory, the
> quality is unknown, you have been warned.
>=20
> The same behaviour is absent, however, when a staging driver is compiled
> as built-in on the kernel image, since loading it happens through
> initcalls and not through load_module().
>=20
> This might prevent relevant information of being available on a bug
> report (i.e. on a panic log) among other possible problems.
>=20
> NOTES:
> - The patch is written in such a way that all non-staging drivers are
>   kept the way they were, except for staging drivers built with
>   `-DSTAGING_CODE`.
> - Since it changes some macros related to clang LTO as well, I tested it
>   and it works properly in kernels compiled with both clang and gcc.
> - Some `checkpatch.pl` errors, warnings and checks (with `--strict`) are
>   present. Some were already there, some I introduced but I think
>   they're unavoidable. Some IMHO don=B4t make sense at all, I think they
>   would apply for most regular macros but initcall macros are just way
>   different.
>=20
> Fixes: 061b1bd394ca ("Staging: add TAINT_CRAP for all drivers/staging cod=
e")
> Signed-off-by: =C1gatha Isabelle Chris Moreira Guedes <code@agatha.dev>

I didn't grok the complete patch, the but intention is good.

Thanks
Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Best regards
Uwe

--3knqfckw67jieu3n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmaM35kACgkQj4D7WH0S
/k53Wgf/S2QsAUpX9rVxaP4UXEN1jtI8O5t43BTPfB4g7rEmwB4vhT3ntuPY/VqU
nuebxMkdmMp7tiEb99uCfp2W9WDtZxsc6bf5BXuFyp1opwsvZqZXQBMVMndPTRf/
0xPF4vpb4ypXwI/XYXjRSnh7mRdF9UP309w87TGpqxde1/CZ4Q0QMldBpOUyfVZr
BrikXOzKfp4psA0fB1y7NLWXJeZHsaN+zGkzATc8w8ZfN1A67aPHsQf/Xj4cX9RA
Hd4aHHo2wp1DASkaevPXPna/kSVCxBpEbrBKqschrC1NiE4wexB1r79XbWnLOujZ
y6oCH3XDle5EvxxLWHHTpek8sWNbrg==
=Y6sb
-----END PGP SIGNATURE-----

--3knqfckw67jieu3n--
