Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB14433C7;
	Mon, 12 Aug 2024 10:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723457947; cv=none; b=RwZI7Fe1cnpyUPoz35Ivp0pGmn98S51gZjZt+Qv1alcV0dh3uaD3+hcmNMV7ZiXkyatECdeRWpYwdm6O78wS2ljc0gROhxc/8rMitLkWQpUMT0dlS6SST4usaZUDrU5iZuPa5cgUpTgL9d6M/8Ze+zHNdxvOic8kFTdN40cFPTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723457947; c=relaxed/simple;
	bh=3NoF2AqIn7ebzgigTO39jqw9ZwcZwkQemgH2i8ieHxk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=nEOll1NhLwPPueRA6MMorbnaVvEG9zuXAy5N6Uqk0JibU7sh+dCdRxd0nsZkHd/akXj5qEC29NYJB3lQf0rBeqC03ub6EzI/28+EODZ5PlPf5JzSfi8kysViAqmCplL5PfGSSjocGdK453nE3E/0m8EkJsb7Cl8hAUnKXaEcZKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=N/MU5IFo; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="N/MU5IFo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1723457911; x=1724062711; i=markus.elfring@web.de;
	bh=OnuFW8cTlccnziPEnkWW15zWY/n06Y26fjbsJ66FoW0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=N/MU5IFoaITdhg7Ykab/nxzWrF8YsUQ2fOID5NJQqUPzXvZxU9WGw50XxryzmsrB
	 t2JVIV9xI/5I4fjMo+nF3Gf0HgppLJB1hvypmuC5zrVn3ZsEBdiBC8X0IrPf8FJjp
	 OsOlejhgZcUvPLV5Wd80rbp6HGAP/nqAMhcMor/VzsaHL1JNfmwMAL3BP6KqMv+I+
	 EMk5tRD7qRLwcVS6PpGCbWy++hFUlAJGVohRKuwNY7UzbBgguaGce49D2Uds6G8tH
	 YwWNboPB29dwbFfDSme2Fr5bu7H/MbF1vg92cgoUtTXdGpkshNJQxK1dINgbXBr3n
	 LtwJi7YezL+T1foU9Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MWi5i-1sfZhX1sF6-00UF61; Mon, 12
 Aug 2024 12:18:31 +0200
Message-ID: <7ea59d03-701c-4555-a8e8-5d7272b9381c@web.de>
Date: Mon, 12 Aug 2024 12:18:17 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jinjie Ruan <ruanjinjie@huawei.com>, linux-modules@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Luis Chamberlain <mcgrof@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240812080658.2791982-1-ruanjinjie@huawei.com>
Subject: Re: [PATCH] driver core: Fix a null-ptr-deref in module_add_driver()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240812080658.2791982-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ttizh7fE6o1t4X59ST5zSv3HsJssMJrujZVork77Lb9gOlJW5V6
 O8T79LbSZRIqoMRMdwp5gtUThXWu4qTcM1axqPOzk25Zbfn3l+5A3zoX3V11/yQc5m+ik8G
 k4oIUZG9rGNvUOUefAx3/wAnHxcsX0yk5LnX1S6trvWoJP4gLt4PIvRX/TbDQZLHdJfaicZ
 XqTPUBu2KGXQv33ZYvy4g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+EEF8MPvYN4=;M7UyJRZkaCrJgIDmzZmLCKC0MS+
 Vs3+cRam1gRRSXJS86eTJzXHu4zeuSIFVMST0iuuq4T3WizZ7cZrfAksCqQVKlnM8FfQAjS0U
 YhHZsdMzLDJ9B3kL/F3X8i8PboMcXrYoAJJrbzNyXpxuqkhLgou4Ce7VNs291EjDBUohOYFiM
 uje7omurNdIPQ8q8MoL8vBASwDatQCePXjiFze2q13ggnCmgoXANMh04QqBtZ1x0c4UC+jt5x
 knGpZpsbE0gp+WUWTytajfqSx7Qf3sqYks8t0YP1xPf+0Jv1IWLWgm+ixRxnCCA5zYoP1Tyoz
 BmgJ0uiHmWhxFa4G+HPMC90Cz573whGJ2nw0LdE+rPeHlnifRyqu7IDWDZsuPgndq1ip20y/l
 IaiOFJ3nLrxshm5Btl13D+us15V77jL2/yfgvoHMlKF42xqJqHymoDyYllx6a7lABHyX/c3Rm
 BNa8VdOyJr/z5wF0n+KLLvbQ6Mw5xM9IzXRiNHu0hgqk4BuOqLyqAy1Z3rBlmkCymW/Z8s2mp
 OfbOPteOWYUkbbBW2mHXlRVyiNfOE3+ev3+O0qS536cXUY5b35mCNfyKIkQBMWZb0Vdh5QLUV
 IGouwp15somrHHneadt/TV/6YjigEFxz24ihcNM8GiStgxejS0sgVd0oyIigD4fopR9aPsHR5
 bdTaJFNxOk++R+IETuGGHQgTO+zHAZXM5OV3LKz3lapavWKz4fkg0nsdsWLqz706rBc4edNG7
 Aik3Ub64ud4B90LNea/Yiao1L0SrX1JXOODtn6hYpCsxQL9Zveupc6JnPv88gSX8rjIwzSxmY
 bdW3oXvXHOsXBlteo9wFUTvw==

> Inject fault while probing of-fpga-region, if kasprintf() fails in
> module_add_driver(), the second sysfs_remove_link() in exit path will ca=
use
> null-ptr-deref as below because kernfs_name_hash() will call strlen() wi=
th
> NULL driver_name.
=E2=80=A6

How do you think about to use the term =E2=80=9Cnull pointer dereference=
=E2=80=9D
for the commit message (and summary phrase)?


=E2=80=A6
> +++ b/drivers/base/module.c
> @@ -66,27 +66,31 @@ int module_add_driver(struct module *mod, const stru=
ct device_driver *drv)
=E2=80=A6
>  	sysfs_remove_link(mk->drivers_dir, driver_name);
> +
> +out_free_driver_name:
>  	kfree(driver_name);
>
> +out_remove_kobj:
> +	sysfs_remove_link(&drv->p->kobj, "module");
=E2=80=A6

I suggest to omit two blank lines here.

Regards,
Markus
