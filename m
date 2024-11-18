Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCEC153836
	for <linux-modules@vger.kernel.org>; Mon, 18 Nov 2024 09:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731920741; cv=none; b=OOmbBTi5gsvxkvPP4I2C7qebAvMDXcFgH19IHK9z6rzgQfM1plsXrGo78CFpSn5os4G7JuwAj18spkijeVckJsAlYLk1qmXzuXx5pwXyz2E3CLNr1BbrglNLJ5cpzdtUB5tBN/+8EP9+3eRIOxkmkzSOafdSO9P7lqgDZOoHG8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731920741; c=relaxed/simple;
	bh=v1oPu8EK9Yje3QSYL7jhWwmGgplSWsGADQQaQ0iqSeE=;
	h=MIME-Version:Content-Type:Date:Message-ID:Subject:CC:To:From:
	 In-Reply-To:References; b=Ztw9XAB5F6U/8H2n6zQCKeIeq7zHURN4ktEnqPHM9od/QldrCqAX3OTimU58Zatk6Gzt0XZp9b1zJS57AXI3iTP7gISL6z64hAvkvnkbI1cNDQGZ53qQrUjthUmXTeuOItZjI2p+6f7S2StPdfGt4AdlZ5L3YAJNFBhvduCHxYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=C/Ub49Hn; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="C/Ub49Hn"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20241118090529euoutp013f0688435dfeb08014482605f7ff6990~JBLpGWC_X0543805438euoutp01t
	for <linux-modules@vger.kernel.org>; Mon, 18 Nov 2024 09:05:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20241118090529euoutp013f0688435dfeb08014482605f7ff6990~JBLpGWC_X0543805438euoutp01t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1731920729;
	bh=DubZSvc6o/gsvQ8WWFf7RzJ2tiB1sSgELZFQIWXJmdQ=;
	h=Date:Subject:CC:To:From:In-Reply-To:References:From;
	b=C/Ub49HnD3VW9wx1owcU4FL/pCurLDKrdIF2JUnHlCyWQPmS4XcBzhz5POXfBUyQF
	 3s6+2Q4PZv7yFXUFp/oRD9b/hB1J+w72tpP1qKO6K4SAzuUSqe5rSiWnZLkw9zkwca
	 4T40FVWq367qbF2k7gsFYxOmh7QdP7rGc4kh8UmE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20241118090529eucas1p1fd5ed1fca9107a75e9f2a63a22286380~JBLozzMd70349703497eucas1p1V;
	Mon, 18 Nov 2024 09:05:29 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 6B.6A.20821.9530B376; Mon, 18
	Nov 2024 09:05:29 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20241118090528eucas1p218351817a7952f71bed5e24210e56ad6~JBLoW784C0342903429eucas1p2n;
	Mon, 18 Nov 2024 09:05:28 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241118090528eusmtrp2fb4edeb1ff0c5b4096a2f4bec8925aa2~JBLoWHxf51386113861eusmtrp2G;
	Mon, 18 Nov 2024 09:05:28 +0000 (GMT)
X-AuditID: cbfec7f2-b09c370000005155-fe-673b0359237a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 30.EB.19920.8530B376; Mon, 18
	Nov 2024 09:05:28 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241118090528eusmtip1d0cbfeb3bb678351b968856c211e94b4~JBLoLUYNV2217622176eusmtip15;
	Mon, 18 Nov 2024 09:05:28 +0000 (GMT)
Received: from mail.scsc.local (106.110.32.87) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 18 Nov 2024 09:05:27 +0000
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 18 Nov 2024 10:05:27 +0100
Message-ID: <D5P6NQ9ZWP13.K9G49CLMO6LV@samsung.com>
Subject: Re: [PATCH v5 2/2] module: Block a module by TUXEDO from accessing
 GPL symbols
CC: Werner Sembach <wse@tuxedocomputers.com>, <mcgrof@kernel.org>,
	<petr.pavlu@suse.com>, <samitolvanen@google.com>,
	<linux-modules@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux@leemhuis.info>, <vv@tuxedocomputers.com>, <cs@tuxedo.de>,
	<linux-spdx@vger.kernel.org>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, Daniel
	Gomez <d+samsung@kruces.com>, Thomas Gleixner <tglx@linutronix.de>, Greg
	Kroah-Hartman <gregkh@linuxfoundation.org>
From: Daniel Gomez <da.gomez@samsung.com>
X-Mailer: aerc 0.18.2-67-g7f69618ac1fd
In-Reply-To: <wnfqe7q2aby76zokkh77jhlwc2dbr243kycmejc4wj5wflywgi@6sox742ip22g>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIKsWRmVeSWpSXmKPExsWy7djP87qRzNbpBr/OSVpsO2Rksfv/XWaL
	5sXr2Swu75rDZtEw+zurxZJvB9ksVu+Mtrgx4SmjxdIv75gtlq54y2qxedNUZov5Xz+xWfyb
	/Ibd4vzSpawOfB7vb7SyeyzYVOqxaVUnm8f/3gesHoeaHzB5vDt3jt1j/9w17B7rt1xl8di5
	+w+bx79lDWwenzfJBXBHcdmkpOZklqUW6dslcGWcnNPDWrBXvGL+sn/sDYynhLsYOTkkBEwk
	3j88xdjFyMUhJLCCUWJJx1NmCOcLo8S1fRuZIJzPjBLbGiYywrT8/X0bqmo5o8SL7fOY4aoe
	/fjJDFIlJLCTUaLzMBuIzSsgKHFy5hMWEJtZQFti2cLXzBC2pkTr9t/sIDaLgKrEjHMX2SHq
	jSU2zFsI1issECnRuOQZE0T9bCaJoxsUQZaJCBxhlPjwZD9YAxvQoH0nN7FDnKcm8b9/Itgy
	TgE/iS0rpjNBxBUlZkxcyQJh10qc2nIL7DcJgVOcEl/W7IFKuEhcuzKZFcIWlnh1fAvUUBmJ
	/zvnQw1Kl1iybhZUfYHEntuzgOo5gGxrib4zORBhR4l1yxezQIT5JG68FYS4n09i0rbpzBBh
	XomONqEJjCqzkEJoFlIIzUIKoQWMzKsYxVNLi3PTU4sN81LL9YoTc4tL89L1kvNzNzECU93p
	f8c/7WCc++qj3iFGJg7GQ4wSHMxKIryXXM3ThXhTEiurUovy44tKc1KLDzFKc7AoifOqpsin
	CgmkJ5akZqemFqQWwWSZODilGpjav3JeMXPbyfjSeF+7/f9KWbll9qYP1n77mZeaE2Bt//u4
	xNY3lxuV7BcdYOS6fH9yUaiyXMSMquhq35r5z1jvcd5UW9ubdUdWruNd9ifubu0Hb3o7nyvf
	FpkhazDJeNpJhqe3xeXbEg6cM9Q5PzlwLmPXp7e23X/39c0U/DpzpwKnYOeKjr8HrEXeyRZb
	VDOK2mXGX/HxD3779t6WvLJkjtquNXqywjVTNzosuWl2m+PFv2saM3Rr50bd2f+t38H5WsG+
	N3+MTwSfnfK9+1KFzbboyGCBBIWa0spNr4OmpW5zTf7xUGrdRe342Vcv5gm8vGj/JjXm8Lw4
	3/z2y2ZnX5/f4qDoULdWMdZmj4oSS3FGoqEWc1FxIgAWTvzI5AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDIsWRmVeSWpSXmKPExsVy+t/xu7oRzNbpBk93WlhsO2Rksfv/XWaL
	5sXr2Swu75rDZtEw+zurxZJvB9ksVu+Mtrgx4SmjxdIv75gtlq54y2qxedNUZov5Xz+xWfyb
	/Ibd4vzSpawOfB7vb7SyeyzYVOqxaVUnm8f/3gesHoeaHzB5vDt3jt1j/9w17B7rt1xl8di5
	+w+bx79lDWwenzfJBXBH6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mk
	pOZklqUW6dsl6GWcnNPDWrBXvGL+sn/sDYynhLsYOTkkBEwk/v6+zdzFyMUhJLCUUaJ1+wNm
	iISMxMYvV1khbGGJP9e62CCKPjJKnP/zD8rZySixcuoXJpAqXgFBiZMzn7CA2MwC2hLLFr5m
	hrA1gab+ZgexWQRUJWacu8gOUW8ssWHeQjYQW1ggUqJxyTMmiPrZTBJHNyiC2CICRxglpiwE
	O5UNaM6+k5vYIS5Sk/jfP5EF4ojNTBJbNvcwgiQ4BfwktqyYzgRRpCgxY+JKFgi7VuLz32eM
	ExhFZiG5dRaSW2chuXUBI/MqRpHU0uLc9NxiQ73ixNzi0rx0veT83E2MwGSw7djPzTsY5736
	qHeIkYmD8RCjBAezkgjvJVfzdCHelMTKqtSi/Pii0pzU4kOMpkBPT2SWEk3OB6ajvJJ4QzMD
	U0MTM0sDU0szYyVxXrfL59OEBNITS1KzU1MLUotg+pg4OKUamI5ax3rWPVDS/aD+UvNqnZEc
	55fDbOcjDaeY1P98OXVX2AYOd8b4GE7ZUJOzy3ykJu/3ntF8tnKpnPhmY41dL76sv/3xyKG+
	/4XHKqblBEyLNX/atCr70EKG1/YKKpctlQ8dnWGStmopc71XUcjpQP7ive6qu7jPsXSsFlfV
	2PminnH9mZIqw6JnPyPN5ljyMT/bI7NvUbazm1O94Qn2lQFhV5ImnNgtMbFa3FfqnZvltJnh
	OZ+fbZkXZ3Gf12O1bndWu8Q+8ZbCkK29rb1W28547M/K0d87Y2HgUYZLpTFP9q+zUZTja/3/
	UfTck9aijVrZfCe98sss/mV8ajni9Dvooq9KTqn5S7HCDK1oJZbijERDLeai4kQABPNNgY8D
	AAA=
X-CMS-MailID: 20241118090528eucas1p218351817a7952f71bed5e24210e56ad6
X-Msg-Generator: CA
X-RootMTR: 20241116172026eucas1p2ae18643501640a7c6a3a796c30b60fed
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241116172026eucas1p2ae18643501640a7c6a3a796c30b60fed
References: <20241115185253.1299264-1-wse@tuxedocomputers.com>
	<20241115185253.1299264-3-wse@tuxedocomputers.com>
	<D5NGCPSP7EO8.28YI337NY203X@kruces.com>
	<CGME20241116172026eucas1p2ae18643501640a7c6a3a796c30b60fed@eucas1p2.samsung.com>
	<wnfqe7q2aby76zokkh77jhlwc2dbr243kycmejc4wj5wflywgi@6sox742ip22g>

On Sat Nov 16, 2024 at 6:20 PM CET, Uwe Kleine-K=C3=B6nig wrote:
> On Sat, Nov 16, 2024 at 09:15:55AM +0100, Daniel Gomez wrote:
>> On Fri Nov 15, 2024 at 7:50 PM CET, Werner Sembach wrote:
>> > From: Uwe Kleine-K=C3=B6nig <ukleinek@kernel.org>
>> >
>> > TUXEDO has not yet relicensed a module for GPLv2+ as a reply from form=
er
>> > contributers the committed code under GPLv3+ is awaited.
>>=20
>> FYI, the SPDX identifier GPL-2.0+ is deprecated as of 2.0rc2 [1]. I thin=
k you'd
>> need to use GPL-2.0-or-later [2] instead. And when using the SPDX identi=
fier,
>> you don't need to include the full text boilerplate in the source of eve=
ry file
>> as long as you include a LICENSE file or COPYRIGHT file with a copy of t=
he
>> license. One example upstream here [3] commit 1a59d1b8e05ea ("treewide: =
Replace
>> GPLv2 boilerplate/reference with SPDX - rule 156").
>>=20
>> [1] https://protect2.fireeye.com/v1/url?k=3D86f7819c-e78c2b15-86f60ad3-7=
4fe48600034-4f48619e45d5b211&q=3D1&e=3D7cb2448b-7ab2-415e-b77d-ad14970bc0a0=
&u=3Dhttps%3A%2F%2Fspdx.org%2Flicenses%2FGPL-2.0%2B.html
>> [2] https://protect2.fireeye.com/v1/url?k=3D939eb0bf-f2e51a36-939f3bf0-7=
4fe48600034-b542784fecbfce13&q=3D1&e=3D7cb2448b-7ab2-415e-b77d-ad14970bc0a0=
&u=3Dhttps%3A%2F%2Fspdx.org%2Flicenses%2FGPL-2.0-or-later.html
>> [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/c=
ommit/?h=3Dv6.12-rc7&id=3D1a59d1b8e05ea
>
> If you're convinced that "GPL-2.0-or-later" is the right string to use
> (and the following somewhat agrees with you:

Thomas and Greg may have decided not deprecating the old identifiers [1]
to avoid modifying thousands of files. I think it was expected the SPDX
to mark them as equivalent? But I'm not entirely sure if this is the
correct approach though as SPDX marks them as deprecated as I mentioned
earlier.

Thomas, Greg, are we using any specific SPDX version for kernel license
identifiers? Why the new identifiers where amended as valid and not
replacing [2] the old ones? Was it to avoid replacing all files with the
old id?

[1] https://lore.kernel.org/all/alpine.DEB.2.21.1804240953460.5261@nanos.te=
c.linutronix.de/
[2] 9376ff9ba298c983062a12cbbafde506a4eaea71 ("LICENSES/GPL2.0: Add
GPL-2.0-only/or-later as valid identifiers")

Daniel

>
> 	linux$ git rev-parse next/master
> 	744cf71b8bdfcdd77aaf58395e068b7457634b2c
>
> 	linux$ git grep -l -F 'SPDX-License-Identifier: GPL-2.0+' next/master | =
wc -l
> 	3640
>
> 	linux$ git grep -l -F 'SPDX-License-Identifier: GPL-2.0-or-later' next/m=
aster | wc -l
> 	9005
> )
>
> you can consider patching Documentation/process/license-rules.rst which
> currently reads:
>
>    License identifiers for licenses like [L]GPL with the 'or later' optio=
n
>    are constructed by using a "+" for indicating the 'or later' option.::
>
>       // SPDX-License-Identifier: GPL-2.0+
>       // SPDX-License-Identifier: LGPL-2.1+
>
> Best regards
> Uwe

