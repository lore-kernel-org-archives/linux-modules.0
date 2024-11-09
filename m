Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0605B14430E
	for <linux-modules@vger.kernel.org>; Sat,  9 Nov 2024 21:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731186200; cv=none; b=FSeuP20BaGSvcuObMeophIHdsjeb4VIoMI0oOWlywVo60w2wUnzNyHCEfFKy6YFUfy/4jaO4gXpvQ4fI3TpNI/WYDosQglG20dT53e6u4Tdie1LQ0ynxCMgemxsJi0WaGDYKozmu2G8q6qhjNwVirTIh1rIUUarpgxaGc59TBv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731186200; c=relaxed/simple;
	bh=YIiccCo0N3HbI9dbfe169oRbRI9AUz+ioc1px3+Fn1Y=;
	h=MIME-Version:Content-Type:Date:Message-ID:Subject:CC:To:From:
	 In-Reply-To:References; b=UyI818KnWRBaty29T4E7xS9i7oUOuXV/ujZ1ymUMFUE/2mV0OlKm3qhP5F8slHDQ+2WutJsT4YzV/2EP9BO3DjW9350JNrdlfbdrvzaVVXfwLQY6YrGvKRYi4ISj73HflGwsWe4sUoLm1+xXYLtnzgqzpw1pnfXyLTLDrVwCw0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=HCp8655v; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HCp8655v"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20241109210309euoutp01a668964c8c23944dc65249f1885d1789~GaKq9Y_hJ0191401914euoutp014
	for <linux-modules@vger.kernel.org>; Sat,  9 Nov 2024 21:03:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20241109210309euoutp01a668964c8c23944dc65249f1885d1789~GaKq9Y_hJ0191401914euoutp014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1731186189;
	bh=+dOAA64/v3yKwjwjme/F2AoNbhFg/yCBBcsPWbBXvl8=;
	h=Date:Subject:CC:To:From:In-Reply-To:References:From;
	b=HCp8655vFHBQa62bQ9HxzcyzEUms9KCKGOMUA/xVpfwD/8uFazvZ/ViWKUKv134om
	 Lz97rnnpEjYK/iWh0mvBLje/1DCI2jEuSehEVegG2WBrLLTWaIYd2xW/Uq3hnDGmK5
	 LqigZtIT0po9dl9DBAHeRGkv2zvO1Y3D76jqb6UM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20241109210308eucas1p2befa2cdeb3b48adfc9470d90ec96c3a3~GaKqRXzJR2615326153eucas1p2y;
	Sat,  9 Nov 2024 21:03:08 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 44.33.20409.C0ECF276; Sat,  9
	Nov 2024 21:03:08 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20241109210307eucas1p2aea3ee9db6d8f6fa8e550421953d1c61~GaKpqGiqT2811028110eucas1p2s;
	Sat,  9 Nov 2024 21:03:07 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241109210307eusmtrp11d33af6ee26c0813a9802c1dd031bcde~GaKppmqNU3101331013eusmtrp11;
	Sat,  9 Nov 2024 21:03:07 +0000 (GMT)
X-AuditID: cbfec7f4-c39fa70000004fb9-74-672fce0c07e2
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id EC.19.19654.B0ECF276; Sat,  9
	Nov 2024 21:03:07 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241109210307eusmtip2205b2c81025f12eb9d754706d06e9664~GaKpcjxVM0316403164eusmtip2_;
	Sat,  9 Nov 2024 21:03:07 +0000 (GMT)
Received: from mail.scsc.local (106.110.32.87) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Sat, 9 Nov 2024 21:03:06 +0000
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 9 Nov 2024 22:03:06 +0100
Message-ID: <D5HYAAW77P1A.6KLS8F6CVKGS@samsung.com>
Subject: Re: [RFC PATCH 3/3] module: pre-test setting ro_after_init data
 read-only
CC: <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Luis Chamberlain
	<mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen
	<samitolvanen@google.com>, Kees Cook <kees@kernel.org>,
	<linux-modules@vger.kernel.org>
From: Daniel Gomez <da.gomez@samsung.com>
X-Mailer: aerc 0.18.2-67-g7f69618ac1fd
In-Reply-To: <a32f2390caf6e0d157ffea6e04f5e5d8629620c2.1731148254.git.christophe.leroy@csgroup.eu>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsWy7djP87o85/TTDQ5OlbK4M+k5u8W6t+dZ
	LS7vmsNm0TD7O6vFjQlPGS2WfnnHbLF0xVtWi82bpjI7cHh8vXmOyWPBplKPTas62TzenTvH
	7rF+y1UWj8+b5ALYorhsUlJzMstSi/TtErgynq1ZyVpwj79i2dZWtgbGhzxdjJwcEgImEhvb
	brJ2MXJxCAmsYJRYM+UyE4TzhVFi24H57BDOZ0aJz2+uMsO0PNu4mg0isZxR4ufWVWxwVU+X
	7INq2cEo8eLyGkaQFl4BQYmTM5+wgNjMAtoSyxa+ZoawNSVat/9mB7FZBFQktj86yAxRbyxx
	vvk/E4gtLBAi8ax7DiNEvYfEogOPWEAWiAg8Z5RYvbeLDSTBBjRo38lN7BD3qUn8758ItoxT
	IEli0qmJjBBxRYkZE1eyQNi1Eqe23AL7VELgB4fElacPoJpdJLb9eQX1qLDEq+NboOIyEqcn
	90A1p0ssWTcLyi6Q2HN7FjD8OIBsa4m+MzkQYUeJFQc3s0OE+SRuvBWEuJ9PYtK26cwQYV6J
	jjahCYwqs5BCaBZSCM1CCqEFjMyrGMVTS4tz01OLjfJSy/WKE3OLS/PS9ZLzczcxAlPQ6X/H
	v+xgXP7qo94hRiYOxkOMEhzMSiK8Gv766UK8KYmVValF+fFFpTmpxYcYpTlYlMR5VVPkU4UE
	0hNLUrNTUwtSi2CyTBycUg1MG/OueD3bqN7vGJ5X/NPwuJkwS6GursrW1/nv38m9tD4cKr/+
	xqprXjeyXLdxPtrXOLVr37FSzZ3PjO4UnV36muvAYUcd7emu93cEKeQLvzqTOGeVwNGph14a
	Hj9+pyXVa2WWxtu1T69Un56y4KmT/+FvzF/53nTJGsfxXZhdtKXRSJjV+N7e2Hz/cyHfdczP
	/1E6k+87PemEjFWcuUhzbWPQTWU9/b3RL3e0/gk4Yr3h7uZTLDeD2zIuTmAx0+jWvPCq8kne
	fj9Ptp2bl9cppIpySG3SYQ4s9e/ur5Q0vZCgX7D28rGM6mMulw0WbrZqX3xKMN/2yZUD6QsD
	F0j2JWV1fTx/62f+t1vzz9SrK7EUZyQaajEXFScCAO9X+e2wAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsVy+t/xe7rc5/TTDT43GljcmfSc3WLd2/Os
	Fpd3zWGzaJj9ndXixoSnjBZLv7xjtli64i2rxeZNU5kdODy+3jzH5LFgU6nHplWdbB7vzp1j
	91i/5SqLx+dNcgFsUXo2RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5
	mWWpRfp2CXoZz9asZC24x1+xbGsrWwPjQ54uRk4OCQETiWcbV7N1MXJxCAksZZSY+bSJDSIh
	I7Hxy1VWCFtY4s+1Lqiij4wS0/r2skA4Oxglus/1sIBU8QoISpyc+QTMZhbQlli28DUzhK0p
	0br9NzuIzSKgIrH90UFmiHpjifPN/5lAbGGBEIln3XMYIeo9JBYdeAS2QETgOaPE6r1dYCex
	AQ3ad3ITO8RJahL/+ydCXdHJJNGw9iFYN6dAksSkUxMZIYoUJWZMXMkCYddKfP77jHECo8gs
	JMfOQnLsLCTHLmBkXsUoklpanJueW2ykV5yYW1yal66XnJ+7iREYpduO/dyyg3Hlq496hxiZ
	OBgPMUpwMCuJ8Gr466cL8aYkVlalFuXHF5XmpBYfYjQF+nois5Rocj4wTeSVxBuaGZgamphZ
	GphamhkrifOyXTmfJiSQnliSmp2aWpBaBNPHxMEp1cDU579p+6vpZnL9rR0N+UFXWBfkFR6f
	vS5b74fhluN2lnr2h/zefb837ZKrvM/u+1H9hk2C0zk3HUraZyEk/bL621WGJXpJ59MncGw9
	NGXL5UkHwhxfM6RwfV/G/jjAcvNkmzSLD+3hN6xli+y3Kv5d+H5Hxirr6+4cIReen6+8uEj7
	u2Lx1QsJyypsGKZdyvkcIKbOkzPFsYf9+PJJa26mzVTf9NyCUWF1n3DuytJ1UornLRJuRac8
	mbOueP7MjRLMlmUuk+ve2W/VU019uMDEyubMMyXNDCuVcG42ifu3hCyU+W6czS7XucXBq+x7
	z0OywGnJ90r78OgdWzZY8Hk0c/ImtEq63/M7ZTA78qsSS3FGoqEWc1FxIgDwBiXqWwMAAA==
X-CMS-MailID: 20241109210307eucas1p2aea3ee9db6d8f6fa8e550421953d1c61
X-Msg-Generator: CA
X-RootMTR: 20241109105007eucas1p10a64348dbd220dd145735eaca3541d38
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241109105007eucas1p10a64348dbd220dd145735eaca3541d38
References: <737f952790c96a09ad5e51689918b97ef9b29174.1731148254.git.christophe.leroy@csgroup.eu>
	<CGME20241109105007eucas1p10a64348dbd220dd145735eaca3541d38@eucas1p1.samsung.com>
	<a32f2390caf6e0d157ffea6e04f5e5d8629620c2.1731148254.git.christophe.leroy@csgroup.eu>

On Sat Nov 9, 2024 at 11:35 AM CET, Christophe Leroy wrote:
> To be on the safe side, try to set ro_after_init data section readonly
> at the same time as rodata. If it fails it will likely fail again
> later so let's cancel module loading while we still can do it.
> If it doesn't fail, put it back to read-only, continue module loading

I think you mean put it back to rw?

> and cross fingers so that it still works after module init. Then it
> should in principle never fail so add a WARN_ON_ONCE() to get a big
> fat warning in case it happens anyway.

I agree this is the best we can do. But I don't think there's any
guarantee that we won't fail on the second try?

>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  kernel/module/main.c       | 2 +-
>  kernel/module/strict_rwx.c | 5 ++++-
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 1bf4b0db291b..b603c9647e73 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2582,7 +2582,7 @@ static noinline int do_init_module(struct module *m=
od)
>  	rcu_assign_pointer(mod->kallsyms, &mod->core_kallsyms);
>  #endif
>  	ret =3D module_enable_rodata_ro_after_init(mod);
> -	if (ret)
> +	if (WARN_ON_ONCE(ret))
>  		pr_warn("%s: %s() returned %d, ro_after_init data might still be writa=
ble\n",
>  			mod->name, __func__, ret);
> =20
> diff --git a/kernel/module/strict_rwx.c b/kernel/module/strict_rwx.c
> index f68c59974ae2..329afd43f06b 100644
> --- a/kernel/module/strict_rwx.c
> +++ b/kernel/module/strict_rwx.c
> @@ -58,7 +58,10 @@ int module_enable_rodata_ro(const struct module *mod)
>  	if (ret)
>  		return ret;
> =20
> -	return 0;
> +	ret =3D module_set_memory(mod, MOD_RO_AFTER_INIT, set_memory_ro);
> +	if (ret)
> +		return ret;
> +	return module_set_memory(mod, MOD_RO_AFTER_INIT, set_memory_rw);
>  }
> =20
>  int module_enable_rodata_ro_after_init(const struct module *mod)

