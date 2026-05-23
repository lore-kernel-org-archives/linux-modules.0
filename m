Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241222DC79F
	for <linux-modules@vger.kernel.org>; Sat, 23 May 2026 07:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779521558; cv=none; b=O1baSz9nLuPSEncdB4wP3TIDBujFTrKiI50XN5Wfhp3goXhQoCOA0j0nUCEf3GmFgFZeQ0AqEpadX8abDQXJixpo2i/Gtrtxj+rEinCS2NF6uHLKaC1Q/Fqq2ORKB6XyFSWhhSy7quAi/EpQOs0WApO9oTGfFClNAA1NmJxioCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779521558; c=relaxed/simple;
	bh=xfr43jZFPQ4vzDiUvT12nKe7ghJMtx0Bs1pBsN9mgzE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=asy7q79BpuZCqvexpTwr+TMKwX4w0xO+/0f2XGci1jPfzWvXOlLlkzwJgYZ3egUwvJwcvVPIRMuPpOBA8kx6r88Zjb3tpVbpDLaA7Ck0LX5Kriy720B6m6SIRmbMYpvI4lOoXJJZMkD+led+Rx+7cDaFBeoa9JFTVuXdmFJXppk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDfDEsBp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDfDEsBp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A95381F000E9;
	Sat, 23 May 2026 07:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779521556;
	bh=eK7WAK+v3M65seu4SLNgkx96/ehfPHNzkgA7YXRZXt4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NDfDEsBpfVp4cuHXR+L9H0qM5yKon+2rkkOERQV6p3bJgQY7QNN5YrVmRiguus80u
	 J42qoWKkIkVYb8NJ9HzEWA9DWqMHhgw/YEUgHX4d1wghcql4vhs/0stVQ0FCjemQ9A
	 Xu0+OJjTtOw/SrJn85dy/09gFyB/AhjVBuKlXqN6oSMPTe4sKL3fw1AVvhqs2gL4YO
	 dyEjG+LZND10cedAsPQVFfk5Uel6zfIQvmuuRqZvDTcLS3ZB5ZuBM5xRnvDDJKv8XX
	 7uznozKuju2r4w8uchGDijpp3v+V0j8OkTN2d6gwBcSHvt+JCpDPYAqZIDbvWqN+yA
	 3KEzvdRfnYa4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/24] dyndbg: drop NUM_TYPE_ARGS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260523-dd-maint-2-v2-12-b937312aa083@gmail.com>
References: <20260523-dd-maint-2-v2-12-b937312aa083@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 23 May 2026 07:32:36 +0000
Message-Id: <20260523073236.A95381F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] `include/linux/dynamic_debug.h` uses `ARRAY_SIZE` in the `DECLARE_D=
YNDBG_CLASSMAP` macro but does not include `<linux/array_size.h>`.
--

commit 618a01dd2902c43678e5c0a9f07fd35aaf566937
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg: drop NUM_TYPE_ARGS

This commit drops the NUM_TYPE_ARGS macro and replaces it with ARRAY_SIZE in
the DECLARE_DYNDBG_CLASSMAP macro.

> diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
> --- a/include/linux/dynamic_debug.h
> +++ b/include/linux/dynamic_debug.h
> @@ -121,11 +121,9 @@ struct ddebug_class_param {
>  		.mod_name =3D KBUILD_MODNAME,				\
>  		.base =3D _base,						\
>  		.map_type =3D _maptype,					\
> -		.length =3D NUM_TYPE_ARGS(char*, __VA_ARGS__),		\
> +		.length =3D ARRAY_SIZE(_var##_classnames),		\

[Severity: Low]
Does this macro expansion require linux/array_size.h to be included directly
in include/linux/dynamic_debug.h?

If a driver or module includes linux/dynamic_debug.h and invokes
DECLARE_DYNDBG_CLASSMAP without independently including linux/array_size.h
(for example, via linux/kernel.h), it might fail to compile. It looks like
the include for linux/array_size.h was added to lib/dynamic_debug.c below,
instead of to this header file.

>  		.class_names =3D _var##_classnames,			\
>  	}

[ ... ]

> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -13,6 +13,7 @@
> =20
>  #define pr_fmt(fmt) "dyndbg: " fmt
> =20
> +#include <linux/array_size.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260523-dd-maint-2=
-v2-0-b937312aa083@gmail.com?part=3D12
