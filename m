Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2618F143C63
	for <linux-modules@vger.kernel.org>; Sat,  9 Nov 2024 22:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731190646; cv=none; b=bRQzzd7B7WPXHnLHeawHreMrFHIdbFdYaONr0R2AuX/yq+3GvdgKeS6/zVvl/f4jGXrds+oD2v8Zf8vZsI5ZyLqShl/keGADwh31eo+fe+LX2e5xkUvsWWWChCv8422FNVldtOgrcq5R7PnvKhUb8K/xSshyLOxVBayg8rn2dB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731190646; c=relaxed/simple;
	bh=QsMQnXVPXdFJYOkdxe4IjuaL38UpsOeDPai9dSd6LSw=;
	h=MIME-Version:Content-Type:Date:Message-ID:To:From:Subject:CC:
	 In-Reply-To:References; b=C0CYaZF2AJ5oVSJ8key9ccSor3e60CYPM6YAGf9OqLKxkbq0DoqyaxbXbkeG/FPymn2bSnZwo8AEnM7T2ATWGgQqsYs5Tw2+8R7weqluWMmUwreLKjGoq7Sk0uZSIQwXLRFJ1pYMLlhd2Uw6DxFtcLMuPppz6GFdaT5FYiqSM4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=bX5oLq9J; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bX5oLq9J"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20241109221722euoutp026b3e315bd2e29591bfb00b085a21b6ad~GbLd_FWOP1200912009euoutp02e
	for <linux-modules@vger.kernel.org>; Sat,  9 Nov 2024 22:17:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20241109221722euoutp026b3e315bd2e29591bfb00b085a21b6ad~GbLd_FWOP1200912009euoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1731190642;
	bh=ueqcKqZ3CAToylfEDQVhdRAfa9slExaYq87dkAOsapI=;
	h=Date:To:From:Subject:CC:In-Reply-To:References:From;
	b=bX5oLq9J+h5faIJyiOlnL4q9o30JJwp6MkYDllA+rkU9CbGk6hMtCzLFf6qybJsp+
	 Rx5zn8davwuHT6K/K/7REBDT1Aq3M9536h3XlkbTlgcr7Yj90WFy8ajTDO4yYfHQQJ
	 UjVzwsotedicRHTkJlSNH3w58LL0FpYioF+SYF3Y=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20241109221720eucas1p2331532aea4e6280e6432987b759e2d6b~GbLcxa7pE1899518995eucas1p2X;
	Sat,  9 Nov 2024 22:17:20 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 83.69.20821.07FDF276; Sat,  9
	Nov 2024 22:17:20 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20241109221720eucas1p1e3f15dd5a4b8e20d107d1584630c8422~GbLcPDtHx2136121361eucas1p10;
	Sat,  9 Nov 2024 22:17:20 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241109221720eusmtrp1e388b539b692bb4c49801397909ab7a7~GbLcOQdCt0594805948eusmtrp1M;
	Sat,  9 Nov 2024 22:17:20 +0000 (GMT)
X-AuditID: cbfec7f2-b09c370000005155-d0-672fdf704957
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 6E.AF.19920.07FDF276; Sat,  9
	Nov 2024 22:17:20 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241109221720eusmtip29409a74e180525c4492b8914cac4a28a~GbLb-uWNg1802118021eusmtip2o;
	Sat,  9 Nov 2024 22:17:19 +0000 (GMT)
Received: from mail.scsc.local (106.110.32.87) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Sat, 9 Nov 2024 22:17:19 +0000
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 9 Nov 2024 23:17:18 +0100
Message-ID: <D5HZV4A6SC9A.25U3Q0WUVDJHZ@samsung.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Luis Chamberlain
	<mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen
	<samitolvanen@google.com>, Kees Cook <kees@kernel.org>,
	<linux-modules@vger.kernel.org>
From: Daniel Gomez <da.gomez@samsung.com>
Subject: Re: [RFC PATCH 2/3] module: Don't fail module loading when setting
 ro_after_init section RO failed
CC: <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>
X-Mailer: aerc 0.18.2-67-g7f69618ac1fd
In-Reply-To: <164e5f22f8ab59d1d516e3c992efdd9f83ab4819.1731148254.git.christophe.leroy@csgroup.eu>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsWy7djP87oF9/XTDT7c0LO4M+k5u8W6t+dZ
	LS7vmsNm0TD7O6vFjQlPGS2WfnnHbLF0xVtWi82bpjI7cHh8vXmOyWPBplKPTas62TzenTvH
	7rF+y1UWj8+b5ALYorhsUlJzMstSi/TtErgyvv/ayFxwlKfiyYp17A2MK7m6GDk5JARMJDZ+
	2cfaxcjFISSwglHi9MLVzBDOF0aJCX1TmCCcz4wSvx8fYIVpeXT6CRtEYjmjxMuNjQhVJ3s+
	QA3bwShx48xWdpAWXgFBiZMzn7CA2MwC2hLLFr5mhrA1JVq3/waq4eBgEVCR6D8dA1FuIvFm
	7kuwoSICzxklVu/tYgNJsAHV7zu5CWymsECuRNu1Z1AzPSQWHXjEAnGemsT//oksIDM5BZIk
	7u2JgAgrSsyYuBKqpFbi1JZbYPMlBH5wSGybOIcNIuEicb/jDpQtLPHq+BZ2CFtG4vTkHqjm
	dIkl62ZB2QUSe27PYgXZJSFgLdF3Jgci7Chx9/NmqDCfxI23ghBX8klM2jadGSLMK9HRJjSB
	UWUWUvjMQgqfWUjhs4CReRWjeGppcW56arFhXmq5XnFibnFpXrpecn7uJkZg+jn97/inHYxz
	X33UO8TIxMF4iFGCg1lJhFfDXz9diDclsbIqtSg/vqg0J7X4EKM0B4uSOK9qinyqkEB6Yklq
	dmpqQWoRTJaJg1OqgWluojDLfPUjn91enE499XmbnNWlrbss71kc3l5+3/+B1Q9nK9e8275M
	Ntoql5LKjG+pr+8M7dHlMbSctelEl2g8U6B5wpHPT8O09pX0sn+S5kxPtG2WTa/u5ZjKYBZy
	9KfVwgk53npP/jUtsvp9euPc3Hm/OEXDNsy7x7/S990dnWVTN31rPSlqxilq8fvW4nD+dtmX
	rx69d1hUETH7sc3dcgftzWXPawqD+V0Wvfszt6cs9YS5xEKJRQIXtJyPXOGbp6zWnqmzqYrj
	/VGhKP64qFCPuF0fqgSS2A+k6N+e85hpNZPdc1eundwOD/+byRx/YT87+J/E3/dq7bLsBSkH
	z/7+dyB/x8KOJ1Ll15VYijMSDbWYi4oTARf4Jh6uAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsVy+t/xe7oF9/XTDb7+YbO4M+k5u8W6t+dZ
	LS7vmsNm0TD7O6vFjQlPGS2WfnnHbLF0xVtWi82bpjI7cHh8vXmOyWPBplKPTas62TzenTvH
	7rF+y1UWj8+b5ALYovRsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJz
	MstSi/TtEvQyvv/ayFxwlKfiyYp17A2MK7m6GDk5JARMJB6dfsLWxcjFISSwlFFi1uJF7BAJ
	GYmNX66yQtjCEn+udUEVfWSU2Pb9BBOEs4NRonfzA7AqXgFBiZMzn7CA2MwC2hLLFr5mhrA1
	JVq3/waaysHBIqAi0X86BqLcROLN3Jdgc0QEnjNKrN4LsoGTgw2oft/JTWBXCAvkSrRdewY1
	00Ni0YFHLBAXqUn875/IAnFEJ5PEnumbmUEWcAokSdzbEwFRoygxY+JKqPpaic9/nzFOYBSZ
	heTUWUhOnYXk1AWMzKsYRVJLi3PTc4sN9YoTc4tL89L1kvNzNzECI3TbsZ+bdzDOe/VR7xAj
	EwfjIUYJDmYlEV4Nf/10Id6UxMqq1KL8+KLSnNTiQ4ymQD9PZJYSTc4Hpoi8knhDMwNTQxMz
	SwNTSzNjJXFet8vn04QE0hNLUrNTUwtSi2D6mDg4pRqYfIvUfbP3SUkXifAbLL996eM7S+me
	gKqv3mc9tj6ZPv+R26fWBWnyfHE7veSKDimY26rO5Go//kY5+e+jHbuOpFk+S61esHXF3aye
	eSnctme8eRlOP53iFrPXib/O6sDJq9dLwwJvRcwJvhSWvmrHryXqvy3uNoVc1r8bM/EmOwN3
	Q0+A3n9+fW9WEdX9No0vbh3d5G965siC7HAfs5S0ozbbCif2SCcvuv9s7up/sgqtHgzXugVZ
	qiZY1LxLTt3Ab3zqTZDZASm7gIXTn29P8578xCriX9KS6O+vy/YsZQy7+Dhyi2nM+t05MS/V
	l7+33/tiU6x0xVrjrRMEruV/LNOtr/X0WNGYcVvJY+ZDJZbijERDLeai4kQAHYJSAlkDAAA=
X-CMS-MailID: 20241109221720eucas1p1e3f15dd5a4b8e20d107d1584630c8422
X-Msg-Generator: CA
X-RootMTR: 20241109103554eucas1p1548e0da57cccb9546a88402f1f5c94be
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241109103554eucas1p1548e0da57cccb9546a88402f1f5c94be
References: <737f952790c96a09ad5e51689918b97ef9b29174.1731148254.git.christophe.leroy@csgroup.eu>
	<CGME20241109103554eucas1p1548e0da57cccb9546a88402f1f5c94be@eucas1p1.samsung.com>
	<164e5f22f8ab59d1d516e3c992efdd9f83ab4819.1731148254.git.christophe.leroy@csgroup.eu>

On Sat Nov 9, 2024 at 11:35 AM CET, Christophe Leroy wrote:
> Once module init has succeded it is too late to cancel loading.
> If setting ro_after_init data section to read-only fails, all we
> can do is to inform the user through a warning.
>
> Reported-by: Thomas Gleixner <tglx@linutronix.de>
> Closes: https://lore.kernel.org/all/20230915082126.4187913-1-ruanjinjie@h=
uawei.com/
> Fixes: d1909c022173 ("module: Don't ignore errors from set_memory_XX()")
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  kernel/module/main.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 2de4ad7af335..1bf4b0db291b 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2583,7 +2583,9 @@ static noinline int do_init_module(struct module *m=
od)
>  #endif
>  	ret =3D module_enable_rodata_ro_after_init(mod);
>  	if (ret)
> -		goto fail_mutex_unlock;
> +		pr_warn("%s: %s() returned %d, ro_after_init data might still be writa=
ble\n",
> +			mod->name, __func__, ret);
> +
>  	mod_tree_remove_init(mod);
>  	module_arch_freeing_init(mod);
>  	for_class_mod_mem_type(type, init) {
> @@ -2622,8 +2624,6 @@ static noinline int do_init_module(struct module *m=
od)
> =20
>  	return 0;

I think it would make sense to propagate the error. But that would
require changing modprobe.c. What kind of error can we expect when this
happens?

> =20
> -fail_mutex_unlock:
> -	mutex_unlock(&module_mutex);
>  fail_free_freeinit:
>  	kfree(freeinit);
>  fail:

