Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03ED5212550
	for <linux-modules@vger.kernel.org>; Wed,  9 Sep 2026 01:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788916096; cv=none; b=WEy8JuYZO1QBHEb8CuoSC2XkiSIAVLJfhSxgnu0kTyKuiTepbR5cNhrLOPhuZxaOXJ43t397zpghjg3h4Zf9YB9FX+feEwdEaVDYgB1bx2d6ERDC6F6ikah3VjQEbWPhFUrlsfluRzrMPVfuGBn2D75Rm/xcFLpCT7dE4segqqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788916096; c=relaxed/simple;
	bh=9epS0He/7xscEy4RlKAjWtGp5eLW1fRU0OeU/xn1FQ4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M2Oa1kEmTCRxHdTyCYzjW6HB2bIMVHGCl9jb0TmhTXSlFvCDi9voE45ALbp9a2y2S9FiQdR8dSLojRz7kSFVqiiqp3CvJPSAbg/wO7qktcKmEoSMPm3Q6nw0yJDFNI5DmVtjY/NYRMLJ/uHlq4vbix/h9piIlJSKuZOfj/8KgMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=au1gVv83; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="au1gVv83"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D901F00A3A;
	Wed,  9 Sep 2026 01:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788916094;
	bh=QgUx71SE8d71pLrq+PVW9L01Jc1Tir2GTbsSq0aMYNQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=au1gVv83amCR7ceF1rQ0qLKkL6nRXIao0hwomcT+m6byPcxcqP1YQ5rqX1Q4KpC2a
	 hlxa5sV47zo2ryJCbcxdYD1T6d4GiOiDaqFu2yN6bYCpQi7wE/Z8ir1K4T+VEe0/JL
	 0WkAVPCWsgwQS/shzW+AMQ4awVS7Uo24QP1V8b1y9Fo3URIk1J5JUTvKCZipzkflQV
	 3mCxqaXpTCi0S5mZ13SRRoIEq51f9f6agbdf/oH1lwDqk7GlTxOObXyKQKIxWk8shv
	 XenrZ7DHP1PHp+sH0C6hENOXSRQ7jnAapMcKGQIdlD3Btn26IOYZNyaUT4ef38HU9+
	 AWLEe7AT4anIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 28/39] dyndbg-test: add do_bulk testpoint, rename
 do_prints to do_classes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
In-Reply-To: <20260908-dd-cmap-part2-clean-v9-28-3a3f621f4a10@gmail.com>
References: <20260908-dd-cmap-part2-clean-v9-0-3a3f621f4a10@gmail.com>
 <20260908-dd-cmap-part2-clean-v9-28-3a3f621f4a10@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 01:08:14 +0000
Message-Id: <20260909010814.61D901F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The function do_bulk() contains a loop that will run infinitely =
if the module parameter 'ct' is set to UINT_MAX, leading to an unkillable t=
ask and a denial of service.
- [Low] New classes V8 and Vu8 were added to the enums, but were not added =
to the classmap definition or the test output function, resulting in dead c=
ode.
--

commit 7bf906f06540c9e08d2719aba493b1c2f6501853
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg-test: add do_bulk testpoint, rename do_prints to do_classes

This commit updates test_dynamic_debug.ko by renaming do_prints to
do_classes and introducing a new do_bulk feature. It aims to generate
significant workloads with a single write to sysfs nodes and consolidate
the parameter operations for these features.

> diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
> index 01ce07001d4c7..b7f9ed9b2794e 100644
> --- a/lib/test_dynamic_debug.c
> +++ b/lib/test_dynamic_debug.c
[ ... ]
> @@ -103,7 +123,10 @@ enum cat_disjoint_bits {
>  	D2_DRMRES };
> =20
>  /* numeric verbosity, V2 > V1 related.  V1 is > D2_DRMRES */
> -enum cat_level_num { V1 =3D 16, V2, V3, V4, V5, V6, V7 };
> +enum cat_level_num { V1 =3D 16, V2, V3, V4, V5, V6, V7, V8 };
> +
> +/* test _USE_ w offset */
> +enum cat_level_offset { Vu1 =3D V1 + 8, Vu2, Vu3, Vu4, Vu5, Vu6, Vu7, Vu=
8 };

[Severity: Low]
This isn't a bug, but since V8 and Vu8 were added to these enumerations,
should they also be added to the classmap definitions and tested in
do_levels()? Currently, it appears they are left out of the corresponding
prdbg() calls and will not generate any log output.

[ ... ]
> @@ -213,17 +237,42 @@ static void do_levels(void)
>  #endif
>  }
> =20
> -static void do_prints(void)
> +static void do_classes(unsigned int ct)
>  {
[ ... ]
> +static void do_bulk(unsigned int ct)
> +{
> +	unsigned int i;
> +
> +	pr_debug("do_bulk %u times:\n", ct);
> +	for (i =3D 1; i <=3D ct; i++) {

[Severity: Medium]
If a user sets the sysfs parameter to UINT_MAX, could this loop condition
become always true?

The commit message mentions using unsigned int to prevent wrapping lockups =
on
UINT_MAX. However, if ct reaches UINT_MAX, the condition (i <=3D ct) remains
true when i reaches UINT_MAX. Then, i++ wraps i back to 0, which is also
less than UINT_MAX, meaning the loop would never terminate and the task
would become unkillable.

Should ct be clamped during parsing in param_set_do_repeats(), or the loop
structure modified to safely handle UINT_MAX?

> +		pr_debug("bulk msg %u.0\n", i);
> +		pr_debug("bulk msg %u.1\n", i);
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-dd-cmap-pa=
rt2-clean-v9-0-3a3f621f4a10@gmail.com?part=3D28
