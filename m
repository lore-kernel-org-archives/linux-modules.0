Received: from relay3-s.mailbaby.net (relay3-s.mailbaby.net [208.73.205.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E391BE23B
	for <linux-modules@vger.kernel.org>; Tue,  2 Jul 2024 17:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.73.205.254
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719940631; cv=none; b=FvAyPlFGR4iQAoJqkVjLjT2/D7DX33gxuyUmRKDFuYey3UJW25yUbr7ELsLkk+Ye6fuTos6k3Q2H8jHZrsFnE98drW/I6Dd5IEy92WyJDqLuuv133otMeyUc1L2EaoJs/JCEx1j5Jbo6wrdsKhq1Eto6LtoPz2nTorPi+Iq4nOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719940631; c=relaxed/simple;
	bh=71ExIM+EYTOxyMVsz+VFIZv1Mlh82DJlzB41sdGa5ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOCj/VRzMFCqb1dlXRY7jQCo76yzVdt1xMBMxJCL7hnQixvWqpEYb5FyQ07/EHBDd74n93/81XJuE4mxPypfDsy7WEmjQWRVo1Dq/gBCsglGUmg5UkIoiLjWDzRNLH6nGC6NEC1MxZTx7CiM0SEWtbMAJCRZ+MOQZrXSNo4ICwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=agatha.dev; spf=fail smtp.mailfrom=agatha.dev; dkim=pass (1024-bit key) header.d=mailbaby.net header.i=@mailbaby.net header.b=V+GFjLbB; dkim=pass (2048-bit key) header.d=agatha.dev header.i=@agatha.dev header.b=A/vpN+Ja; arc=none smtp.client-ip=208.73.205.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=agatha.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=agatha.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailbaby.net header.i=@mailbaby.net header.b="V+GFjLbB";
	dkim=pass (2048-bit key) header.d=agatha.dev header.i=@agatha.dev header.b="A/vpN+Ja"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbaby.net;
 q=dns/txt; s=bambino; bh=C2MVi7u0aBqSaHkN4epRNQ7LYKtJQ4HmDN87qdIiZk0=;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:references;
 b=V+GFjLbBGcguTyM6fxfSk8gXOum+/9TqqVeDWjGJwTYvvSVTxOMTddRGkKptVELdHDw226RKo
 Y/67Td2WVGP5TxiUSxNHAGaMLE7iuX5+2BgjXkINjQ3V1twDO8Z1dUO5FgjLL2vcGkuyAHcUmtd
 f6x79nAO5vt+wGkcMCbBxME=
Received: from mia3000.dnsiaas.com ([192.155.110.18] mia3000.dnsiaas.com)
 (Authenticated sender: mb6724)
 by relay3-s.mailbaby.net (MailBabyMTA) with ESMTPSA id 190746e73ea000a4da.003
 for <linux-modules@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Tue, 02 Jul 2024 17:11:54 +0000
X-Zone-Loop: a7c51b83e032bfd6ffd74eef356cac1ebc035d4653b4
X-Get-Message-Sender-Via: mb6724: authenticated_id: code@agatha.dev
X-NS-SCAN: PASS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=agatha.dev;
	s=default; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=C2MVi7u0aBqSaHkN4epRNQ7LYKtJQ4HmDN87qdIiZk0=; b=A/vpN+JanpGybsiu0hvaNGEMOJ
	xQO/9FxmEQ+o4L9xx6MHEZSeGVIw2mLBEHQ5L8bDJTbxeLFNeNpz0TuT84njG7HGqKjLgI+ToaW5t
	nddnEr+ZnhbYaAfUddoz7DpEu2DX4w0hsc8sXVHoTyyVuSy6ih2g+cl63JXj7VL5nSoTPyuKbBzis
	1ajSak9pnhFnGh+YsFCb8fuHiHzumfrUpLYae0wvWLltFlgMUt0VZKmXgwfYBtIVE8xQGdasllHsC
	w+IGXA44ugz9y5TNFWUBnCU1VH9rlDDLVEHm3FxKmIZ69H1axGGBGszn2YeckdVVpok2BNDJIzPdf
	pdU7bTQQ==;
Received: from [186.250.91.79] (port=20192 helo=kurupi-arch.blackcat)
	by mia3000.dnsiaas.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <code@agatha.dev>)
	id 1sOh2l-0000000EthG-0Co7;
	Tue, 02 Jul 2024 13:11:52 -0400
Date: Tue, 2 Jul 2024 14:11:47 -0300
From: =?utf-8?Q?=C3=81gatha?= Isabelle Chris Moreira Guedes <code@agatha.dev>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, 
	=?utf-8?Q?=C3=81gatha?= Isabelle Chris Moreira Guedes <patch-reply@agatha.dev>, Jookia <contact@jookia.org>
Subject: Re: [PATCH] staging: Fix missing warning/taint on builtin code
Message-ID: <diuey54pdwq4zcj2uxdhmw6fl5gahxpfs2gzg3qa6mz4qwf4ra@y65aap6nkge3>
References: <yf3ewok3u7fu7f4yqlcovcvedkhyjtibvwzlgbcjwf7ijcsktt@vrk54srlnk2n>
 <lm4ju5czrrmbiq3jgrjwrgsbudnkcydixnribyuspqcvblt3q5@u5oiczdrzajq>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g5cfquunyjpghass"
Content-Disposition: inline
In-Reply-To: <lm4ju5czrrmbiq3jgrjwrgsbudnkcydixnribyuspqcvblt3q5@u5oiczdrzajq>
X-AuthUser: me@agatha.dev


--g5cfquunyjpghass
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 02, 2024 at 09:50:49AM GMT, Uwe Kleine-K=F6nig wrote:
> Hello =C1gatha,
>=20
> On Tue, Jul 02, 2024 at 02:44:31AM -0300, =C1gatha Isabelle Chris Moreira=
 Guedes wrote:
> > ACKNOWLEDGEMENTS
> > Thanks for Jookia, heat and ukleinek for the important comments &
> > suggestions on this patch prior to submission.
>=20
> FTR: That happend in the #kernelnewbies irc channel.

<3 <3 <3

> > diff --git a/include/linux/init.h b/include/linux/init.h
> > index 58cef4c2e59a..68c37600958f 100644
> > --- a/include/linux/init.h
> > +++ b/include/linux/init.h
> > @@ -397,4 +397,10 @@ void __init parse_early_options(char *cmdline);
> >  #define __exit_p(x) NULL
> >  #endif
> > =20
> > +#ifdef CONFIG_STAGING
> > +#ifndef __ASSEMBLY__
> > +extern void staging_taint(const char *code_id, bool module);
> > +#endif /* __ASSEMBLY__ */
> > +#endif /* CONFIG_STAGING */
>=20
> You could drop the #ifdef for CONFIG_STAGING here. The obvious downside
> of this suggestion is that then you have a declaration of a function
> that isn't available depending on configuration. However the compiler
> doesn't care and the upside of not having CONFIG_STAGING in
> <linux/init.h> is that compile units that have nothing to do with
> CONFIG_STAGING but include <linux/init.h> won't get recompiled if you
> switch the setting.

Thanks a lot for the suggestion, it hasn't ocurred to me (despite the
intense task of recompiling it all over several times during
development LOL).

>=20
> (OK, maybe a minor issue given that most drivers also include
> <linux/module.h> where the #ifdef cannot be dropped.)

For drivers it would be true, but with a very minimal config I am using,
the core code that doesn't include it would get some relative build time
improvement. Definetely worth, considering the machine I am using for
kernel development here (a core2quad cpu LOL).


> > diff --git a/include/linux/module.h b/include/linux/module.h
> > index 330ffb59efe5..ffe58f5d143b 100644
> > --- a/include/linux/module.h
> > +++ b/include/linux/module.h
> > @@ -76,6 +76,39 @@ extern struct module_attribute module_uevent;
> >  extern int init_module(void);
> >  extern void cleanup_module(void);
> > =20
> > +#ifdef CONFIG_STAGING
> > +
> > +#define __lower_define_initcall(fn, id) ___define_initcall(fn, id, .in=
itcall##id)
> > +
> > +/**
> > + * __staging_define_initcall(fn,id) - staging initialization entry poi=
nt
> > + * @fn: the function to run at kernel boot time
> > + * @id: the initcall level
> > + *
> > + * __staging_define_initcall() will ensure the drive's init function i=
s always
> > + * called during initcalls for staging code by producing a wrapper fun=
ction.
> > + * It applies if a module from the drivers/staging subtree is builtin =
to the
> > + * kernel. It reproduces the behavior in load_module() by tainting the=
 kernel
> > + * and logging a warning about the code quality.
> > + */
> > +
> > +#define __staging_define_initcall(fn, id) \
> > +	static int __init __staging_wrapped_##fn(void) \
> > +	{ \
> > +		staging_taint(__FILE__, false); \
> > +		return fn(); \
> > +	} \
> > +__lower_define_initcall(__staging_wrapped_##fn, id)
> > +
> > +#ifdef STAGING_CODE
> > +
> > +#undef __define_initcall
> > +#define __define_initcall(fn, id) __staging_define_initcall(fn, id)
>=20
> undefining macros makes the implemented logic hard to understand. While
> it allows to keep the touched code compact, in the long run it's more
> important that it's understandable.
>=20
> So I suggest to modify the original definition of __define_initcall().

Yeah, I didn't like the idea of touching it at first, but it makes sense
at this time. Thanks for suggesting!

>=20
> > +#endif /* STAGING_CODE */
> > +
> > +#endif /* CONFIG_STAGING */
> > +
> >  #ifndef MODULE
> >  /**
> >   * module_init() - driver initialization entry point
>=20
> I like the idea and think the missing taint for built-in code is an
> oversight that went unnoticed for an astonishingly long time (since 2008
> if my quick research is right).
>=20
> Maybe add
>=20
> Fixes: 061b1bd394ca ("Staging: add TAINT_CRAP for all drivers/staging cod=
e")
>=20
> to the commit log?!

I'll do, thanks a lot so far Uwe!

---
Sincerely,
=C1gatha Isabelle
she/her
https://agatha.dev

--g5cfquunyjpghass
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQMdxNgKl/8Z+5yuVT3jE4VBgsOTAUCZoQ0zgAKCRD3jE4VBgsO
TJV9AP0Z2eOFITT+czoXsumzc7ZUhDBzu+nZ4T1Jhbs+xiCIwQEAld7+/XugScSk
a6T9506TPK41CqwDpq1DzSAQR6d6jQ8=
=TP39
-----END PGP SIGNATURE-----

--g5cfquunyjpghass--
