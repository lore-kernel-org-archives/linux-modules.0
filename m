Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420011AA7A2
	for <linux-modules@vger.kernel.org>; Thu, 14 Nov 2024 11:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731585387; cv=none; b=O5ZKT+Pk5UoW2CBPQf3cWLlyzos8ZUNxY8B2yhHLL26wwyoMsrmSsnKEJEsBT6DtNvuOE63CV8JyBHyVtkgUSgT2N2ITFwfz6T4man5odauB9743xi4twc0xeGlxXKVo0dU/PMADkrW8qHsRzcFVpFnyOh+GAwep6z33nXqGTi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731585387; c=relaxed/simple;
	bh=9O1Cc7Fz4E3w41SzCTayrWJ1BSC07hGck2ohtpLALeU=;
	h=MIME-Version:Content-Type:Date:Message-ID:Subject:CC:To:From:
	 In-Reply-To:References; b=kPooWLYrn7DuzPyM/6Wv+bOZI1ki4AqZWKCLe7GOjD1A54YBY6o30cYIf3xGOwgJrCD3sRzBIcwEW+wk4Zopj6pooQGA9dCiVFHEzZYmQxQxL6dbvvsqkR5/sW6/RJYkqLiFV74gWZCTlgDM9oxxAMxAdFzgaiS4L+nzQDL++xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=YvekuNyV; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YvekuNyV"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20241114115622euoutp024050cb1c4f771aceb480543eeabc3ab3~H07slYDem0295602956euoutp02b
	for <linux-modules@vger.kernel.org>; Thu, 14 Nov 2024 11:56:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20241114115622euoutp024050cb1c4f771aceb480543eeabc3ab3~H07slYDem0295602956euoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1731585382;
	bh=XA7yrOwCYI+Qbk3Ulc9bKec7+IuJiUk1B3sCREYaaR8=;
	h=Date:Subject:CC:To:From:In-Reply-To:References:From;
	b=YvekuNyVJmh7zVMZDs476FsrLLL2iMXfBHowfS+EsKAWEf0SDmW7XyrCmiqQou/Lg
	 w2Ei5IG6G2GGWdx+3P09rufkq8PGjt79xAN5NTTuet2y4SMlZQIt5BxUcVWM4knGDz
	 lunjaXxA3sZu7rFhvzj/T6t4GdNxAuHH0gmw1aOs=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20241114115622eucas1p10ff05ed2890e03c1e0240f305333471f~H07sVB0C12031820318eucas1p1M;
	Thu, 14 Nov 2024 11:56:22 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id AC.5E.20821.665E5376; Thu, 14
	Nov 2024 11:56:22 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20241114115621eucas1p1769d552cfbba63da7cf4c4f01ddd9a2f~H07r-G2U72032920329eucas1p1b;
	Thu, 14 Nov 2024 11:56:21 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241114115621eusmtrp1845bed0aae06916369cd3c24426677ef~H07r_hbWQ1181011810eusmtrp1O;
	Thu, 14 Nov 2024 11:56:21 +0000 (GMT)
X-AuditID: cbfec7f2-b11c470000005155-28-6735e5665b1d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 3F.7F.19654.565E5376; Thu, 14
	Nov 2024 11:56:21 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241114115621eusmtip2ad1470449f1dd496c22d03bddef74495~H07rz-YYf2619326193eusmtip2R;
	Thu, 14 Nov 2024 11:56:21 +0000 (GMT)
Received: from mail.scsc.local (106.110.32.87) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 14 Nov 2024 11:56:20 +0000
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 14 Nov 2024 12:56:20 +0100
Message-ID: <D5LVSE2UF1MA.1TZUC95PN6Y1Q@samsung.com>
Subject: Re: [PATCH 2/2] module: Block modules by Tuxedo from accessing GPL
 symbols
CC: Werner Sembach <wse@tuxedocomputers.com>, <tux@tuxedocomputers.com>,
	Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>,
	<linux-modules@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Thorsten
	Leemhuis <linux@leemhuis.info>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, "Luis
 Chamberlain" <mcgrof@kernel.org>
From: Daniel Gomez <da.gomez@samsung.com>
X-Mailer: aerc 0.18.2-67-g7f69618ac1fd
In-Reply-To: <20241114103133.547032-6-ukleinek@kernel.org>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRmVeSWpSXmKPExsWy7djPc7ppT03TDRobuSwu75rDZtEw+zur
	xeqd0RY3JjxltFj65R2zxdIVb4FCq+axWPycf5HV4vzSpawOnB4LNpV6bFrVyeZxqPkBk8f6
	LVdZPP4ta2Dz+LxJLoAtissmJTUnsyy1SN8ugStj0d1LTAV7RStaPrSzNTDOEepi5OSQEDCR
	aLm/iKmLkYtDSGAFo8TJyy2MEM4XRon3h3tYIZzPjBL/v7Www7RsmTgfqmU5UKJzDitIAqxq
	y143CHsno8Ti/xogNq+AoMTJmU9YQGxmAW2JZQtfM0PYmhKt23+DDWURUJXo+nScEaLeRKJ1
	5y2wemGBUIm38w6ygSxjFmhikvi0bBkTSEJEIFXi79TnYA1sQIP2ndwEdZ2axP/+iWDNnAJW
	EucWzWaDiCtKzJi4kgXCrpU4teUW2AcSAs2cEu8Ot7NCJFwkDi9/wgxhC0u8Or4FaqiMxOnJ
	PVDN6RJL1s2Csgsk9tyeBdTLAWRbS/SdyYEIO0os+9XHCBHmk7jxVhDiXz6JSdumM0OEeSU6
	2oQmMKrMQgqhWUghNAsphBYwMq9iFE8tLc5NTy02zEst1ytOzC0uzUvXS87P3cQITEOn/x3/
	tINx7quPeocYmTgYDzFKcDArifCecjZOF+JNSaysSi3Kjy8qzUktPsQozcGiJM6rmiKfKiSQ
	nliSmp2aWpBaBJNl4uCUamBSO+yz0OMQ+8wYx4OXrQU/WIe337+okD41t3ZD6pHFmlsqUuNP
	HY+x6GI9v+Fkdq5Qq7Pkt8qFK3Yoad7VdXkjxMvC4egvsPLbk11ugadyD+Uf9lryfIJzVM3e
	mi36B/ds/GG38PPuu6rHd9fJPYyI4sudtu5kq/n5XL4lXDIVDB/u3/b0aFoTbXjF2NyAvdcx
	Zv8Tx+XOy8/JG6jN+RT5b8efeWd6wh29srumBrHtMah65nQm/v8Vyat9Rtwd/6Wio6Tn6gtP
	NfSXcegJuPL4wmrdXW133jjFXJUpltu6inGfwZt/rCuu3nTyc5d+bCXfrvL9ZU8ykzz3mvnz
	V/DbzP+4ToopsXN27x+GCZuUWIozEg21mIuKEwHRBTI5sgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsVy+t/xe7qpT03TDc7261tc3jWHzaJh9ndW
	i9U7oy1uTHjKaLH0yztmi6Ur3gKFVs1jsfg5/yKrxfmlS1kdOD0WbCr12LSqk83jUPMDJo/1
	W66yePxb1sDm8XmTXABblJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1N
	SmpOZllqkb5dgl7GoruXmAr2ila0fGhna2CcI9TFyMkhIWAisWXifKYuRi4OIYGljBJ3fj1i
	gkjISGz8cpUVwhaW+HOtiw2i6COjxMIVrVDOTkaJWb2/wKp4BQQlTs58wgJiMwtoSyxb+JoZ
	wtaUaN3+mx3EZhFQlej6dJwRot5EonXnLbB6YYFQibfzDoINZRZoYpKY9nwFWLOIQKrE36nP
	wRrYgAbtO7mJHeIkNYn//RNZIK7YzSjxYUUf2BWcAlYS5xbNZoMoUpSYMXElC4RdK/H57zPG
	CYwis5AcOwvJsbOQHLuAkXkVo0hqaXFuem6xkV5xYm5xaV66XnJ+7iZGYLRuO/Zzyw7Gla8+
	6h1iZOJgPMQowcGsJMJ7ytk4XYg3JbGyKrUoP76oNCe1+BCjKdDXE5mlRJPzgekiryTe0MzA
	1NDEzNLA1NLMWEmcl+3K+TQhgfTEktTs1NSC1CKYPiYOTqkGpqaweK/5/C0VHQ8YL7ROs2b/
	+WZiysxzxtsnLW8/UykW07JWZkXFdaGiz1+n2rnnbYubcX6iVMWFp8zxW3YlH3rwXy51f9x8
	15UtOZ6+Pn5+h1/yiBx4NOmf6nbRhfF2ys5F5fdfLezbsLl0Y+/vGe7lDg/UIisO13UmOWwI
	mHfz479HNfK5sjJPu31al+lHbvBY8NyqKlJov2336pvbP+45/kjonEy6pIH+46LIX/eYog+o
	vDs4q495Qohq0dkDKyecmG7PrPtsHfMdm4Lfh3b9SHg5ke3G46MMb+7P0jn9Xe/JMbmwklei
	b21DkzdNft2huF2p5cH+q3WrH0/+MPuEh126U/0yhZTHpT9tj+QosRRnJBpqMRcVJwIAqJSt
	q18DAAA=
X-CMS-MailID: 20241114115621eucas1p1769d552cfbba63da7cf4c4f01ddd9a2f
X-Msg-Generator: CA
X-RootMTR: 20241114103157eucas1p13c3e82272fabc2cdf5cba8ec70d2a871
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241114103157eucas1p13c3e82272fabc2cdf5cba8ec70d2a871
References: <20241114103133.547032-4-ukleinek@kernel.org>
	<CGME20241114103157eucas1p13c3e82272fabc2cdf5cba8ec70d2a871@eucas1p1.samsung.com>
	<20241114103133.547032-6-ukleinek@kernel.org>

On Thu Nov 14, 2024 at 11:31 AM CET, Uwe Kleine-K=C3=B6nig wrote:
> Tuxedo licenses the modules used on their hardware under GPLv3+, to
> "keep control of the upstream pacing" =E2=80=93 and want to re-license th=
e code
> while upstreaming.
>
> They were asked to then at least not use MODULE_LICENSE("GPL") which
> declares compatibility to the kernel's GPLv2. They accepted the pull
> request and shortly after reverted the change and so continue to lie
> about the license.
>
> So teach the module loader that these modules are proprietary despite
> their declaration to be GPLv2 compatible "until the legal stuff is
> sorted out".
>
> Link: https://protect2.fireeye.com/v1/url?k=3D02b4686b-633f7d5d-02b5e324-=
74fe485cbff1-8cd9af635fd1f7c7&q=3D1&e=3D5f0a08bc-f529-4e41-a7a1-5aa45c54b8d=
9&u=3Dhttps%3A%2F%2Fgitlab.com%2Ftuxedocomputers%2Fdevelopment%2Fpackages%2=
Ftuxedo-drivers%2F-%2Fcommit%2Fa8c09b6c2ce6393fe39d8652d133af9f06cfb427
> Signed-off-by: Uwe Kleine-K=C3=B6nig <ukleinek@kernel.org>
> ---
>  kernel/module/main.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 878191c65efc..46badbb09d5e 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2338,6 +2338,39 @@ static const char *module_license_offenders[] =3D =
{
> =20
>  	/* lve claims to be GPL but upstream won't provide source */
>  	"lve",
> +
> +	/*
> +	 * Tuxedo distributes their kernel modules under GPLv3, but intentially
Typo here.
> +	 * lies in their MODULE_LICENSE() calls.
> +	 * See https://protect2.fireeye.com/v1/url?k=3D60e8a9e4-0163bcd2-60e922=
ab-74fe485cbff1-eff87fdcdb83953a&q=3D1&e=3D5f0a08bc-f529-4e41-a7a1-5aa45c54=
b8d9&u=3Dhttps%3A%2F%2Fgitlab.com%2Ftuxedocomputers%2Fdevelopment%2Fpackage=
s%2Ftuxedo-drivers%2F-%2Fcommit%2Fa8c09b6c2ce6393fe39d8652d133af9f06cfb427
> +	 */
> +	"gxtp7380",
> +	"ite_8291",
> +	"ite_8291_lb",
> +	"ite_8297",
> +	"ite_829x",
> +	"stk8321",
> +	"tuxedo_compatibility_check",
> +	"tuxedo_io",
> +	"tuxedo_nb02_nvidia_power_ctrl",
> +	"tuxedo_nb04_keyboard",
> +	"tuxedo_nb04_wmi_ab",
> +	"tuxedo_nb04_wmi_bs",
> +	"tuxedo_nb04_sensors",
> +	"tuxedo_nb04_power_profiles",
> +	"tuxedo_nb04_kbd_backlight",
> +	"tuxedo_nb05_keyboard",
> +	"tuxedo_nb05_kbd_backlight",
> +	"tuxedo_nb05_power_profiles",
> +	"tuxedo_nb05_ec",
> +	"tuxedo_nb05_sensors",
> +	"tuxedo_nb05_fan_control",
> +	"tuxi_acpi",
> +	"tuxedo_tuxi_fan_control",
> +	"clevo_wmi",
> +	"tuxedo_keyboard",
> +	"clevo_acpi",
> +	"uniwill_wmi",
>  };

This does not prevent module rename on their side and still bypass the
module license taint check right?

> =20
>  /*

