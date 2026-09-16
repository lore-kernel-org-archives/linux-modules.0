Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16CE4B8268
	for <linux-modules@vger.kernel.org>; Wed, 16 Sep 2026 16:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789576655; cv=none; b=bD3rZVLEZi9WbQ9mFVCsJCi5G609ZxpKHJ46vrRXXIidggZJ/HccH12AEaiZH+MjkNEOPFpuQJEu6v2JImMvsVvpU8kf9KWFiOnOfg78HTc9MBOBQ2buARtxD6kN9ERKBrDTqhIin7PCLJlyiYycZxUENmnVmCSxrg4Oldo3dso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789576655; c=relaxed/simple;
	bh=gb+HuUcd8OVBBkNzXMTpyEJ6Oj4/6ghDvVR+UQ42PFU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TI56NlNzfIsqOGL4NOaUe/xb4F3eRJthCRbgVfYD6t3DEIzA3pYun+7xzjMoruwaZHCnQe4WafqmtTFmIF1EQrCHXSTHtayfqxFTQPJ1XZUXwlK/M4IrDecIGSkZXSYz6jLSVcuhNHpriYyOG329xxVbT/02+JlKhdyFRuBhgB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WiPg5ZLp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WiPg5ZLp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ABE61F000FF;
	Wed, 16 Sep 2026 16:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789576651;
	bh=fnQ/LEy8CpwXRHtpdaP0pEJ9RfxvbYmeBW7andNB+vo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WiPg5ZLp9sZKRtBrhlmSW4H3Re9BeVjYWfp2G6f/qIVtUS0ieCVnKAOQSI8rIcHyu
	 w8C3ugElOYk1VtYgdDDv32SXDDCiflE2UFKDGToo+gqmcuPL8kd7Hwjslx8mPhm2xZ
	 IYsOzGvcJgRgB2rDR8dKAB7kbUgCXV3dhDExJjy3LvlGmqCKLocr7k55A9F2J2T0gh
	 G9uJsYdlNGAW7VgItbYbiIoYqYiElJyoCad+S2lwmokO1IoUG4V9R5iF4g1WMWC6vd
	 aZ08YWvIIFDPY8GKcaAoK8jHxg4jQEcC7UglrSpw5Ng+5s6lFKmm8QrD+1Uwh1wKjY
	 byHg0OysSEPUg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 27/38] dyndbg-test: add do_bulk testpoint, rename
 do_prints to do_classes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: linux-modules@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260916-dd-cmap-part2-clean-v10-27-af4cf4767707@gmail.com>
References: <20260916-dd-cmap-part2-clean-v10-0-af4cf4767707@gmail.com>
 <20260916-dd-cmap-part2-clean-v10-27-af4cf4767707@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 16:37:31 +0000
Message-Id: <20260916163731.9ABE61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] test_dynamic_debug: unkillable process in do_bulk and do_classes
--

commit 6245dc1853df17e050ea8032572222d30c017fd7
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg-test: add do_bulk testpoint, rename do_prints to do_classes

This commit introduces a do_bulk testpoint and renames do_prints to
do_classes in the test_dynamic_debug module. These changes allow generating
high-volume workloads with a single sysfs write to better support testing of
dynamic debug features.

> diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
> index 01ce07001d4c7..560e23f14ac8f 100644
> --- a/lib/test_dynamic_debug.c
> +++ b/lib/test_dynamic_debug.c
[ ... ]
> -static void do_prints(void)
> +static void do_classes(unsigned int ct)
>  {
> -	pr_debug("do_prints:\n");
> -	do_cats();
> -	do_levels();
> +	/* maybe clamp this */
> +	pr_debug("do_classes %u times:\n", ct);
> +	for (; ct; ct--) {
> +		do_cats();
> +		do_levels();
> +		cond_resched();

[Severity: Medium]
Can this loop in do_classes() run indefinitely without checking for signals?

If a large integer (e.g., UINT_MAX) is written to the do_classes sysfs
parameter, the lack of fatal_signal_pending() or signal_pending() prevents
the test from being gracefully aborted via SIGKILL or SIGINT. This could
trap the process in kernel space and flood syslog/journald.

> +	}
> +}
> +
> +static void do_bulk(unsigned int ct)
> +{
> +	unsigned int i;
> +
> +	pr_debug("do_bulk %u times:\n", ct);
> +	for (i =3D 0; i < ct; i++) {
> +		pr_debug("bulk msg %u.0\n", i + 1);
> +		pr_debug("bulk msg %u.1\n", i + 1);
> +		pr_debug("bulk msg %u.2\n", i + 1);
> +		pr_debug("bulk msg %u.3\n", i + 1);
> +		pr_debug("bulk msg %u.4\n", i + 1);
> +		pr_debug("bulk msg %u.5\n", i + 1);
> +		pr_debug("bulk msg %u.6\n", i + 1);
> +		pr_debug("bulk msg %u.7\n", i + 1);
> +		pr_debug("bulk msg %u.8\n", i + 1);
> +		pr_debug("bulk msg %u.9\n", i + 1);
> +		cond_resched();

[Severity: Medium]
Similarly, does this loop in do_bulk() also need a signal check?

A process writing a large value to the do_bulk sysfs parameter could
become unkillable for an extended period, preventing process termination.

> +	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-dd-cmap-pa=
rt2-clean-v10-0-af4cf4767707@gmail.com?part=3D27
