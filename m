Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD5D55C1A
	for <linux-modules@vger.kernel.org>; Tue,  2 Jul 2024 07:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719906655; cv=none; b=gD6JgtpRO6DPxazW9SffHYZzQFLEJW04yuuKvkyu24h3MTZnAj0CraX5E8XKz8VCVbtGQ91WaFY/1MfrdgReJhF0vdEQCzLhg57ep+3DdzA/fJHJGYi4qE8jOqLXni4b4Tob1YF7ufuxf0mA6WEDXKhWvqGUvC43IRqs/6TGXi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719906655; c=relaxed/simple;
	bh=9czvJGOvhkjvTp8PcjNjfzcP7w0rgKYFY5zHgd9obAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uuW3eNu3Byg2SxIpGz0BB1StxuPGB+i300YnDpBP0sfFNQcjk7jIgqVZpqAYiZIxhP/Cn5MKvkwo0TuF/sclNa6ISYcBJQ7CWffk4KRcSbCJmwuNw9nCB4d27SG8mukUoJj1pH2VKGF5D7iEwMecV0E4J3hXK3y1xWZl/lgM2rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Pe7BXWC1; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Pe7BXWC1"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-58b447c513aso614215a12.2
        for <linux-modules@vger.kernel.org>; Tue, 02 Jul 2024 00:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719906651; x=1720511451; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vhAmzmcq0WuiQKKI22a1SwLWFklDX0v9Vk9Oow2Okq8=;
        b=Pe7BXWC1QRFOE7T4gE/orT8thR5nLMlCQ1MpO1La56BdVlnC0Ja5PZ4CYc2UXAL7Eu
         1fvKAvuI4MjYeRXxyrXqYf08ym8nq7RAtWw8tj9zXc+S7nMGb3t/cFzhA2ueG1TBwYRL
         85ir6Y/ydNLpICtP7E9U3baXyMd3VDsIU+laK7rA7UJWEA3TN7iUITpimRbloMDeSDUr
         gnahU3Gm8VU78QYJurBeCyTNP0erp8sbiSrpUCXrMZ7EV4IxU+rju87m7RK7UyURQy0K
         eNz8vPO6I3/RxivdUfTusm+Pulv1yCYLbyiVmqEdug+nPrgkt42djdDm6IZh/g49qIT/
         y+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719906651; x=1720511451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vhAmzmcq0WuiQKKI22a1SwLWFklDX0v9Vk9Oow2Okq8=;
        b=ic1V2mB73XTH5ZetoYzH4zCPJtOPDffMbdHz3SPTgZWjaVHTbABuz14NHaL0Fu2aDM
         LGMYX1fD7TcsR4QIMWSaYhZi7bkjUch3c809EL6IHojT2D/T42uus1RCuiz7ELqzr2sE
         cD943J4eUSZcynRfMX/NovVkqru9gAarZElAtrQa6K0tzcyzRDG7eewVaJ1IYxGTGezD
         9XfXjwVSZhmgZjecAballIJdNb5bIp+gQM/QxPrBz4fgWMtX8YuyDEBUJJPGBGgEvmx9
         oV5qF2l1dDYlyV/svoy1OjsfI1PzcnZ5qxAZrRbD+XCOXRTJIYllUVkJ4tcVbbNsjppm
         /h0A==
X-Forwarded-Encrypted: i=1; AJvYcCXQVitUy0aVe2ebPALujkQR29UWDobAvZNy8lq7ExG3P0vgW/7+5lsjpgZXnJUSB+OQ3gsbmQZhpqxs/CUw78r1Lxgjz5OUKl/NvGde1w==
X-Gm-Message-State: AOJu0YyG4FGd78m1GHrqBjE75c1lp99wfJPEhaSJbPOkvTmCopt188fh
	ZPtD++qk9DMyCSl1oRidZo8+q60jzsZIpzXffD1tTzJPJnBETywxdQRe0z/ba1I=
X-Google-Smtp-Source: AGHT+IFi6j8VAuo5d2PZ/pxMR/jTGMp1MlQFd306txfl5rOiDjRTXE8kLhWglEC0VzjiFtE+VJJlcw==
X-Received: by 2002:a17:906:e289:b0:a6f:51d0:d226 with SMTP id a640c23a62f3a-a75144a7c20mr471162066b.66.1719906651179;
        Tue, 02 Jul 2024 00:50:51 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab08cf7csm397251966b.155.2024.07.02.00.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 00:50:50 -0700 (PDT)
Date: Tue, 2 Jul 2024 09:50:49 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: 
	=?utf-8?Q?=C3=81gatha?= Isabelle Chris Moreira Guedes <code@agatha.dev>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, 
	=?utf-8?Q?=C3=81gatha?= Isabelle Chris Moreira Guedes <patch-reply@agatha.dev>, Jookia <contact@jookia.org>
Subject: Re: [PATCH] staging: Fix missing warning/taint on builtin code
Message-ID: <lm4ju5czrrmbiq3jgrjwrgsbudnkcydixnribyuspqcvblt3q5@u5oiczdrzajq>
References: <yf3ewok3u7fu7f4yqlcovcvedkhyjtibvwzlgbcjwf7ijcsktt@vrk54srlnk2n>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jntomoi4xkbaz2om"
Content-Disposition: inline
In-Reply-To: <yf3ewok3u7fu7f4yqlcovcvedkhyjtibvwzlgbcjwf7ijcsktt@vrk54srlnk2n>


--jntomoi4xkbaz2om
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello =C1gatha,

On Tue, Jul 02, 2024 at 02:44:31AM -0300, =C1gatha Isabelle Chris Moreira G=
uedes wrote:
> ACKNOWLEDGEMENTS
> Thanks for Jookia, heat and ukleinek for the important comments &
> suggestions on this patch prior to submission.

FTR: That happend in the #kernelnewbies irc channel.

>  drivers/staging/Makefile |  2 ++
>  include/linux/init.h     |  6 ++++++
>  include/linux/module.h   | 33 +++++++++++++++++++++++++++++++++
>  init/main.c              | 20 ++++++++++++++++++++
>  kernel/module/main.c     |  4 +---
>  5 files changed, 62 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
> index 5390879b5d1b..7cea13436426 100644
> --- a/drivers/staging/Makefile
> +++ b/drivers/staging/Makefile
> @@ -1,6 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # Makefile for staging directory
> =20
> +subdir-ccflags-y +=3D -DSTAGING_CODE
> +
>  obj-y				+=3D media/
>  obj-$(CONFIG_FB_OLPC_DCON)	+=3D olpc_dcon/
>  obj-$(CONFIG_RTL8192E)		+=3D rtl8192e/
> diff --git a/include/linux/init.h b/include/linux/init.h
> index 58cef4c2e59a..68c37600958f 100644
> --- a/include/linux/init.h
> +++ b/include/linux/init.h
> @@ -397,4 +397,10 @@ void __init parse_early_options(char *cmdline);
>  #define __exit_p(x) NULL
>  #endif
> =20
> +#ifdef CONFIG_STAGING
> +#ifndef __ASSEMBLY__
> +extern void staging_taint(const char *code_id, bool module);
> +#endif /* __ASSEMBLY__ */
> +#endif /* CONFIG_STAGING */

You could drop the #ifdef for CONFIG_STAGING here. The obvious downside
of this suggestion is that then you have a declaration of a function
that isn't available depending on configuration. However the compiler
doesn't care and the upside of not having CONFIG_STAGING in
<linux/init.h> is that compile units that have nothing to do with
CONFIG_STAGING but include <linux/init.h> won't get recompiled if you
switch the setting.

(OK, maybe a minor issue given that most drivers also include
<linux/module.h> where the #ifdef cannot be dropped.)

>  #endif /* _LINUX_INIT_H */
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 330ffb59efe5..ffe58f5d143b 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -76,6 +76,39 @@ extern struct module_attribute module_uevent;
>  extern int init_module(void);
>  extern void cleanup_module(void);
> =20
> +#ifdef CONFIG_STAGING
> +
> +#define __lower_define_initcall(fn, id) ___define_initcall(fn, id, .init=
call##id)
> +
> +/**
> + * __staging_define_initcall(fn,id) - staging initialization entry point
> + * @fn: the function to run at kernel boot time
> + * @id: the initcall level
> + *
> + * __staging_define_initcall() will ensure the drive's init function is =
always
> + * called during initcalls for staging code by producing a wrapper funct=
ion.
> + * It applies if a module from the drivers/staging subtree is builtin to=
 the
> + * kernel. It reproduces the behavior in load_module() by tainting the k=
ernel
> + * and logging a warning about the code quality.
> + */
> +
> +#define __staging_define_initcall(fn, id) \
> +	static int __init __staging_wrapped_##fn(void) \
> +	{ \
> +		staging_taint(__FILE__, false); \
> +		return fn(); \
> +	} \
> +__lower_define_initcall(__staging_wrapped_##fn, id)
> +
> +#ifdef STAGING_CODE
> +
> +#undef __define_initcall
> +#define __define_initcall(fn, id) __staging_define_initcall(fn, id)

undefining macros makes the implemented logic hard to understand. While
it allows to keep the touched code compact, in the long run it's more
important that it's understandable.

So I suggest to modify the original definition of __define_initcall().

> +#endif /* STAGING_CODE */
> +
> +#endif /* CONFIG_STAGING */
> +
>  #ifndef MODULE
>  /**
>   * module_init() - driver initialization entry point

I like the idea and think the missing taint for built-in code is an
oversight that went unnoticed for an astonishingly long time (since 2008
if my quick research is right).

Maybe add

Fixes: 061b1bd394ca ("Staging: add TAINT_CRAP for all drivers/staging code")

to the commit log?!

Best regards
Uwe

--jntomoi4xkbaz2om
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmaDsVYACgkQj4D7WH0S
/k71Ewf/eFkpkA1Kp0Qe7mX8QA2q8Er+fkdCxbRIf9Ue/wWQWx13hfhiITsc66Nk
StoFD2Xmy6BDBIyNDKfIyH4sGd+El1JdYbOaDZ1E5HbAjEyTQW+65iMv4w8fo+xh
UcWf+ynPp3nhRsOgwivl5jBv9WKyuqEO+Zg8EKm0aJffn1i8+tiQlvRGYOZDMQN9
aq9Iwi56neepw3wR/dtIlbOpbhlviH7ldUdoTFub2DXOnvsTgIn4uQxOqpYle8Cn
DqODC9fUAyna51N1cMnYkR6gYpZ3ZgIWmgPaqUeoYKfq5cRYSZzuvLqSu6vIzFmB
A8w60BWYs4vNuuD7UmwRqvMmaIKWGQ==
=uzyz
-----END PGP SIGNATURE-----

--jntomoi4xkbaz2om--
