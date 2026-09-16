Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A39E4C2256
	for <linux-modules@vger.kernel.org>; Wed, 16 Sep 2026 15:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789573627; cv=none; b=BzVX2mLILQmojkSqHQq26hidjGrGnecIDvM0wrG+r61H02N6EDwpa7GJE035yHxLcMYH8tAeq/i8NHJ1iEEyPMrxe3clIWwcvkmAWRY4rJNBzXr/YNwbA8jz0GPY2r9KCD4TYunMIzvxcAJvKZVq59qUQfe/XLqt1I340LqN3zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789573627; c=relaxed/simple;
	bh=t3+sYGtUQ9tX0cVv7QtYVq9i6tI7jiFEukWBiNOPUMY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bH/D5ivUDipJgY8CFx+CNHea7lnKryi5tZyg7UKP56bvIz/MOwhGankfp5svLIrNKsXpbdQy2W59gUbs7ZOwwuhZ5ciVZ/jarTDNfcS1g+U2C0Qo2ZfexFxz2R+2/4+aTx+h5zqzqdJZh8LppM4nO0jW7p2bdTdJ4bDfAZb4haM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KORdjHVe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KORdjHVe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 773B31F000FF;
	Wed, 16 Sep 2026 15:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789573623;
	bh=Mx/WdcnA9WUEs1IOuBH8MMQKjCutHAhuRSPiR/QCDG0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KORdjHVeZS85a9QsDJtgywzaolW56TBjQbU8ODrI5WJw/efsNmmpv6WI9IKHH6Cn0
	 C8zH9RHpKg+KD3aw5HL0zg5dFnUJLxENDjUwVwasUTC0cfhh1LQFzvcDuaA/vJpMAk
	 RjekycoxblGBtYG0zJpPsUpxjIyjw7nT9i41AZxPgEXaPNp7ZDLl1llVXVaBeDS9n4
	 32onC30tuvMqJ47M1IxteMaZCJcbDFukycY2zVSd0JnfsaS6nyOFe1vBMvbIeHzXo2
	 p+/wI1O4/WtELcJuH77r7J3JFqJgklJobjtNy52ZuwPUEMHQDsIggMgwjwSmGolKG1
	 SHel84/+F4snA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 07/38] dyndbg: factor ddebug_match_desc out from
 ddebug_change
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
In-Reply-To: <20260916-dd-cmap-part2-clean-v10-7-af4cf4767707@gmail.com>
References: <20260916-dd-cmap-part2-clean-v10-0-af4cf4767707@gmail.com>
 <20260916-dd-cmap-part2-clean-v10-7-af4cf4767707@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 15:47:02 +0000
Message-Id: <20260916154703.773B31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] dyndbg: orphaned comment for ddebug_change applied to ddebug_match_=
desc
--

commit 09e57b269ce55ff151c63cc7e5d0dc659c6f52d5
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg: factor ddebug_match_desc out from ddebug_change

This commit factors out the per-descriptor matching logic from
ddebug_change into a new boolean function, ddebug_match_desc,
to simplify the inner loop.

> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index 49334d1aa4b3a..5187516c57a93 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -172,6 +172,60 @@ static struct ddebug_class_map *ddebug_find_valid_cl=
ass(struct ddebug_table cons
>   * callsites, normally the same as number of changes.  If verbose,
>   * logs the changes.  Takes ddebug_lock.
>   */
> +static bool ddebug_match_desc(const struct ddebug_query *query,
> +			      struct _ddebug *dp,
> +			      int valid_class)

[Severity: Low]
Does this placement separate the block comment from its intended target?

The comment describes a function that returns the number of matching callsi=
tes
and takes ddebug_lock, which accurately describes ddebug_change().

However, by inserting ddebug_match_desc() immediately after this comment,
does it leave ddebug_change() undocumented and make the comment falsely app=
ly
to ddebug_match_desc() (which returns a bool and takes no locks)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-dd-cmap-pa=
rt2-clean-v10-0-af4cf4767707@gmail.com?part=3D7
