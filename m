Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC573876B7
	for <linux-modules@vger.kernel.org>; Sat,  5 Sep 2026 18:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788633085; cv=none; b=UsIbO4AcFZYHg6cZaqwVCiM2Gmblw5mzXd6WS8UtVf73ETqj2O2QSw5GBwNaNFX3gBavKXf+/xwkpi3QXK3Ks7aoBfN+rJbXMF4oIBm2liPzahS+/gC6sgHShAjSyjvG/+3pz2J3g/nefjreB+hcFpork8ZS6WAR4LSoEGFRVwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788633085; c=relaxed/simple;
	bh=yU+ME3WnHyYPt9Mlu0xcFFT52RIHS/vESEFTkPS7e80=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UIWR+rJgeReMZvBCIzqytxsx4BKZX9vNpM7MJ2sWYHoFWZ9y/RmzY5xvRQUPlTngHFhgWhU+0FrFermYZUZidCOAcrAmw+5mV/Ij91sAKfPAb2bjAT4d0ND/Ar5N/vuwXTvNHk5DjyrNzhgJ7GGqguAZeTkEh0cqfXdDfd7vGNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpZiwIHP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpZiwIHP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CFC81F00A3A;
	Sat,  5 Sep 2026 18:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788633081;
	bh=Is1ERzeA0TVbo6445ZfCRd9CWvVeUJ9Wl0WbMpFatq4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZpZiwIHPzH7hMwiNS+Jwym6ruPlxYVreUdt/DUWCv6Ie58C9dd8Q34SDrYXk+xoi8
	 updFZpFoU7rxxLsBcPpTsxalNHTNc96ViHf1gzD/JLDaSQ38bsiK9uqzI2RviNSPAJ
	 MpNL/2ekImbbmEP2Zft15ihqTOXWttAtpub/xaZ9pHerf16scr5fXL9n7Iu3Ljw+cM
	 cAMHq7k8A0dxttUXjZZFglApMWt9UkKjT740zo03f8YpW+NoHjiFURNirft/zZSOz7
	 OiGCsLNL2/uXuYnuPmAjqJmxAZp8rrgrnRUFknxJ9hksr70kxaA7JruS94O2iKI2pE
	 GF1UqacwY+aHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 31/43] dyndbg-test: add do_bulk testpoint, rename
 do_prints to do_classes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: linux-modules@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260905-dd-cmap-part2-clean-v8-31-a4cc0674f6fd@gmail.com>
References: <20260905-dd-cmap-part2-clean-v8-0-a4cc0674f6fd@gmail.com>
 <20260905-dd-cmap-part2-clean-v8-31-a4cc0674f6fd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 18:31:21 +0000
Message-Id: <20260905183121.9CFC81F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Infinite loop in do_bulk() due to signed/unsigned comparison and m=
issing CPU yields in test module loops.
--

commit a7ab45223d01dd1193ddd552d158d079f7cd23de
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg-test: add do_bulk testpoint, rename do_prints to do_classes

This commit enhances the test_dynamic_debug module by renaming the do_prints
sysnode to do_classes and adding a new do_bulk parameter. Both parameters
now accept a work-count to generate significant workloads with a single
write.

> diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
> index 01ce07001d4c7..39499e52d7c04 100644
> --- a/lib/test_dynamic_debug.c
> +++ b/lib/test_dynamic_debug.c
[ ... ]
> @@ -213,17 +236,40 @@ static void do_levels(void)
>  #endif
>  }
> =20
> -static void do_prints(void)
> +static void do_classes(unsigned int ct)
>  {
> -	pr_debug("do_prints:\n");
> -	do_cats();
> -	do_levels();
> +	/* maybe clamp this */
> +	pr_debug("do_classes %d times:\n", ct);
> +	for (; ct; ct--) {
> +		do_cats();
> +		do_levels();
> +	}

[Severity: High]
Since this loop can run for a very long time if a large value is written to
the sysfs node, could it cause CPU or RCU stalls? Would it be safer to add a
cond_resched() inside the loop to prevent lockups?

> +}
> +
> +static void do_bulk(unsigned int ct)
> +{
> +	int i;
> +
> +	pr_debug("do_bulk %d times:\n", ct);
> +	for (i =3D 1; i <=3D ct; i++) {

[Severity: High]
Does this loop condition introduce a potential infinite loop?

The loop counter 'i' is declared as a signed int, while 'ct' is an
unsigned int. If a user writes UINT_MAX (4294967295) to the do_bulk sysfs
parameter, 'i' will be promoted to unsigned int for the comparison. Since an
unsigned int can never exceed UINT_MAX, the condition 'i <=3D ct' will alwa=
ys
be true.

Could this lead to a hard kernel lockup if an extremely large integer is
provided? Should 'i' be declared as an unsigned int, and the loop bounded
or clamped to avoid wrapping?

> +		pr_debug("bulk msg %d.0\n", i);
> +		pr_debug("bulk msg %d.1\n", i);
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905-dd-cmap-pa=
rt2-clean-v8-0-a4cc0674f6fd@gmail.com?part=3D31
