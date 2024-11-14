Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC4E1F8EE9
	for <linux-modules@vger.kernel.org>; Thu, 14 Nov 2024 11:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731585027; cv=none; b=shY2eTg0s3uO90OdO8kq1xvXTizkZSj8VfeFtQAV3IXmymEHpeQSFK0KA1qC9KMStSYALfIBynx8JnDjUe80aNJq4ZZlGvaYFG4o4dSFFhMtXRvycR0M6Fc+5nF4pBLN4XV3R860V++zxOFwkfhUsc7cAStGW4117phslucUUnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731585027; c=relaxed/simple;
	bh=VMNOHBw5gBBtp43tH02IaMDcjlxPJ1NdFLla12jbm1U=;
	h=MIME-Version:Content-Type:Date:Message-ID:From:Subject:CC:To:
	 In-Reply-To:References; b=sWl/C56jJoYxzJ+tj7wXgshiroiH808oRHRVRkxRaPrqR7Zs3L9U5mERol5K85ZDcOq6qFHd1QhaPsQoHV+N8N9cmpaUb/sNN9savS4zWp/ZSkYM4lcj/QFuOeKWfw/K4OsG9eZeYRrDjWPWpyLMZb7cuMYDC1zoR94U4dep8W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=IRUvV5bR; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IRUvV5bR"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20241114115017euoutp02e44a5f122f8e3831096959bd9d086679~H02Y90YGT0292902929euoutp02e
	for <linux-modules@vger.kernel.org>; Thu, 14 Nov 2024 11:50:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20241114115017euoutp02e44a5f122f8e3831096959bd9d086679~H02Y90YGT0292902929euoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1731585017;
	bh=aSnFwn3fyWLWfZWTjEoWx9q1NNGL8GR1CfTtxNKRsSE=;
	h=Date:From:Subject:CC:To:In-Reply-To:References:From;
	b=IRUvV5bRooMIV9FTy4IG4YzQrRPtebVFioKerh1rqO4KYQbG6dCZ8Tbro80p4kjlT
	 C/U7AXBgpN0EvdGWJugF9Cxrrfqk/vu4FaYzmZL6J0zJFq/XI3XnhTvvvjE7ESTCx8
	 AILDDI1wm8PzRwNZSixJBrfsAOXY1P7co0+RCCYQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20241114115017eucas1p1e8cdb0561b668b4715b67d1c0bbac162~H02Ys0Lo12345323453eucas1p1R;
	Thu, 14 Nov 2024 11:50:17 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 3E.15.20409.9F3E5376; Thu, 14
	Nov 2024 11:50:17 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20241114115017eucas1p2862331fc47bf0f1a44035cc7e422a6c7~H02YYStlw0875708757eucas1p2O;
	Thu, 14 Nov 2024 11:50:17 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241114115017eusmtrp1bd4dc11952f9293c6e1a39c45e7fbdbf~H02YXvXmX0888608886eusmtrp1I;
	Thu, 14 Nov 2024 11:50:17 +0000 (GMT)
X-AuditID: cbfec7f4-c0df970000004fb9-9a-6735e3f92001
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id B8.83.19920.9F3E5376; Thu, 14
	Nov 2024 11:50:17 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241114115016eusmtip228356855edd0f55ee7d9ad03cba9a07d~H02YLyBx11445114451eusmtip25;
	Thu, 14 Nov 2024 11:50:16 +0000 (GMT)
Received: from mail.scsc.local (106.110.32.87) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 14 Nov 2024 11:50:16 +0000
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 14 Nov 2024 12:50:15 +0100
Message-ID: <D5LVNQFINITS.13C3C5UV89XRR@samsung.com>
From: Daniel Gomez <da.gomez@samsung.com>
Subject: Re: [PATCH 0/2] module: Block modules by Tuxedo from accessing GPL
 symbols
CC: Werner Sembach <wse@tuxedocomputers.com>, <tux@tuxedocomputers.com>,
	Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>,
	<linux-modules@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Thorsten
	Leemhuis <linux@leemhuis.info>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, "Luis
 Chamberlain" <mcgrof@kernel.org>
X-Mailer: aerc 0.18.2-67-g7f69618ac1fd
In-Reply-To: <20241114103133.547032-4-ukleinek@kernel.org>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRmVeSWpSXmKPExsWy7djPc7o/H5umG5yeIGtxedccNouG2d9Z
	LVbvjLa4MeEpo8XSL++YLZaueAsUWjWPxeLn/IusFueXLmV14PRYsKnUY9OqTjaPQ80PmDzW
	b7nK4vFvWQObx+dNcgFsUVw2Kak5mWWpRfp2CVwZs37cZCxYIljRNX8+ewPjP74uRk4OCQET
	idu9txi7GLk4hARWMErMPfMIyvnCKLF59382COczkDNzJxtMy+IFHewQieWMEg9Pf0eo+vV9
	EROEs5NR4tnSThaQFl4BQYmTM5+A2cwC2hLLFr5mhrA1JVq3/2YHsVkEVCU+NRxkh6g3kfj4
	eAaYzQZUs+/kJjBbWCBUYuadPcwgC5gFmpgkPi1bxgSSEBFIlfg79TkjxH1qEv/7J4It4xSw
	kujf+5sJIq4oMWPiShYIu1bi1JZbYJdKCPznkPjV0AOVcJFY8r2FGcIWlnh1fAs7hC0jcXoy
	TE26xJJ1s6DsAok9t2exdjFyANnWEn1nciDCjhJrD9xjgwjzSdx4KwjxL5/EpG3TmSHCvBId
	bUITGFVmIYXQLKQQmoUUQgsYmVcxiqeWFuempxYb5aWW6xUn5haX5qXrJefnbmIEpqLT/45/
	2cG4/NVHvUOMTByMhxglOJiVRHhPORunC/GmJFZWpRblxxeV5qQWH2KU5mBREudVTZFPFRJI
	TyxJzU5NLUgtgskycXBKNTC1JNgs+Rk8X4f/faaOiG7cNfVC3xVBBh5s6Xs0nYzbbH/qOEie
	7rSYHiy92WPaKRmlM8Gp8gb2YoFcr/oL1WYorao6krXvzX7eBEYthqVLvs7UfV0l9lznh8AE
	N9/oMLvv21xuGij1rUlZtJKt4/s+731yl3QWst6/6pHY0Lt3pbdss2TQgQ/WO5l6uq+Xfazv
	+37eu827/kpKRGPCH4UVW0LDhWol74WFeEd/9nx+yFKb5xF/a+kbRhNpPpbMGwI/kkT8+L6c
	XvX3DvfirweOBrk9V2+fO3vGZ4E8MU7rV30V6VY380Jf/q4SC5k/MSy7m8/Q6Vxcomaj97p6
	Q17L32Ylzu+3WTpIOjxTYinOSDTUYi4qTgQAhmJtj7QDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsVy+t/xe7o/H5umG3T+Y7e4vGsOm0XD7O+s
	Fqt3RlvcmPCU0WLpl3fMFktXvAUKrZrHYvFz/kVWi/NLl7I6cHos2FTqsWlVJ5vHoeYHTB7r
	t1xl8fi3rIHN4/MmuQC2KD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTub
	lNSczLLUIn27BL2MWT9uMhYsEazomj+fvYHxH18XIyeHhICJxOIFHexdjFwcQgJLGSVOPT7F
	ApGQkdj45SorhC0s8edaFxtE0UdGiU+/5rFCODsZJfZ9WgLWwSsgKHFy5hMwm1lAW2LZwtfM
	ELamROv23+wgNouAqsSnhoPsEPUmEh8fzwCz2YBq9p3cBGYLC4RKzLyzhxlkAbNAE5PEtOcr
	wAaJCKRK/J36nBHiJDWJ//0TWSCu6AY56QnYrZwCVhL9e38zQRQpSsyYuBLqn1qJz3+fMU5g
	FJmF5NhZSI6dheTYBYzMqxhFUkuLc9Nziw31ihNzi0vz0vWS83M3MQKjdduxn5t3MM579VHv
	ECMTB+MhRgkOZiUR3lPOxulCvCmJlVWpRfnxRaU5qcWHGE2Bvp7ILCWanA9MF3kl8YZmBqaG
	JmaWBqaWZsZK4rxul8+nCQmkJ5akZqemFqQWwfQxcXBKNTDl7roecqNw7kZnq/Ldeo+enYhJ
	eD9t5bbPv+OEJpq3eroKq3RI+MjcniUhpPjKdu9CUcGVAXPdlvz6Np/nf4DK/6uXhSX9Hr1N
	fH79yolFZl+bRTfN6lu4hOevuQIrp+P6JM6y7kffLq283Lot8uPpwpWcCTvV/IO+/vzLeSDc
	y/lcqN6lD30L0+bJZJw6lFScc0voQ8TSih+X74ZwPN+pLxq6/q5TcoL5tq/ppd9CujfLnHrq
	fsVh3r7FIeW5bL+epO6fnH7o72sne43QX4e2KH1WbX5stEnvh1voRhen37t+Hzoidzh7h9lT
	oWVHVz6PMxEpvsL7W7Em4cophiM39fZf3NRap3LC08msWvHiFiWW4oxEQy3mouJEAHyRychf
	AwAA
X-CMS-MailID: 20241114115017eucas1p2862331fc47bf0f1a44035cc7e422a6c7
X-Msg-Generator: CA
X-RootMTR: 20241114103151eucas1p133de0b231bf06bf8cd42621347a0ed17
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241114103151eucas1p133de0b231bf06bf8cd42621347a0ed17
References: <CGME20241114103151eucas1p133de0b231bf06bf8cd42621347a0ed17@eucas1p1.samsung.com>
	<20241114103133.547032-4-ukleinek@kernel.org>

On Thu Nov 14, 2024 at 11:31 AM CET, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>
> the kernel modules provided by Tuxedo on
> https://protect2.fireeye.com/v1/url?k=3D2f239e82-70bfb7a8-2f2215cd-000bab=
e598f7-32952349600b722d&q=3D1&e=3D9535a8fa-5a9d-4d94-a12d-ff39b9d3b9cf&u=3D=
https%3A%2F%2Fgitlab.com%2Ftuxedocomputers%2Fdevelopment%2Fpackages%2Ftuxed=
o-drivers
> are licensed under GPLv3 or later. This is incompatible with the
> kernel's license and so makes it impossible for distributions and other
> third parties to support these at least in pre-compiled form and so
> limits user experience and the possibilities to work on mainlining these
> drivers.
>
> This incompatibility is created on purpose to control the upstream
> process. See https://protect2.fireeye.com/v1/url?k=3D12fa0a06-4d66232c-12=
fb8149-000babe598f7-5be6d19feac11441&q=3D1&e=3D9535a8fa-5a9d-4d94-a12d-ff39=
b9d3b9cf&u=3Dhttps%3A%2F%2Ffosstodon.org%2F%40kernellogger%2F11342331433799=
1594 for
> a nice summary of the situation and some further links about the issue.
>
> Note that the pull request that fixed the MODULE_LICENSE invocations to
> stop claiming GPL(v2) compatibility was accepted and then immediately
> reverted "for the time being until the legal stuff is sorted out"
> (https://protect2.fireeye.com/v1/url?k=3D80a9845b-df35ad71-80a80f14-000ba=
be598f7-b5ddbbaedbccb553&q=3D1&e=3D9535a8fa-5a9d-4d94-a12d-ff39b9d3b9cf&u=
=3Dhttps%3A%2F%2Fgitlab.com%2Ftuxedocomputers%2Fdevelopment%2Fpackages%2Ftu=
xedo-drivers%2F-%2Fcommit%2Fa8c09b6c2ce6393fe39d8652d133af9f06cfb427).

This commit did not remove the license boilerplate as this other one [1]
upstream did. So I think the license was still inconsistent.

[1] 1a59d1b8e05ea6ab45f7e18897de1ef0e6bc3da6 ("treewide: Replace GPLv2
boilerplate/reference with SPDX - rule 15").

>
> Best regards
> Uwe
>
> Uwe Kleine-K=C3=B6nig (2):
>   module: Put known GPL offenders in an array
>   module: Block modules by Tuxedo from accessing GPL symbols
>
>  kernel/module/main.c | 56 +++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 47 insertions(+), 9 deletions(-)
>
> base-commit: 28955f4fa2823e39f1ecfb3a37a364563527afbc

