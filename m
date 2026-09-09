Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86701212550
	for <linux-modules@vger.kernel.org>; Wed,  9 Sep 2026 01:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788915817; cv=none; b=E0sbSFG9sxBJX9wjE0gqxwQGdIMBe5R6BaKQEkHf761QzUyIJebi/temdpYN3v0hSsVli8TmjN5YPlpwUpp3zyb+gpxEdsC3JZ6KaePcjaQ3BKF9mEwb1djAGZKUsroVVcQIkH2uyAK7nyBXjxKd97vCx+ogJugbjlJFNyWI1WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788915817; c=relaxed/simple;
	bh=tCbrlSGDST+1hIiGMF6nCSNXkPyTwF8+kcRyEX9OUy0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=piLfzDUFT+j44Veq+ki34JV8yUw73DEuF5Q35UFiYEyBOtZAiMzJDvAvr7p5J9B2B8/BJRsb7CrRRW7zBm33TAVqn4MJC1W7k08vIRCyy0Q27I8+QXtcPNmD95seVb9fLp+NrxtEOOKmbwVVuUTy4kX8PgAS9YZs0E/6WWHKmFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBRacGqX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBRacGqX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03411F00A3A;
	Wed,  9 Sep 2026 01:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788915816;
	bh=sC3v78wFfTmV4KNIA9iqq8HzsBIRQD+k+bkPhvg8uv0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PBRacGqXhVZpODoY5KfYqdmU9/OPaWcp8Nwpq13iXLUm1q5RkPYGpb1Onuo4z/1lQ
	 Ov/I9ohlsRhkSSe+Ir4sf1PqsGyWrW29VSg3HgOX6nk/LoUDuFD9z0NeRY7yEZInRm
	 v23Q478upEtrFIN5PyQUTtKyenRfiBuwrbktjmTKUDtFritPU2eHVXyJkDKf2HWrq3
	 vIG2eww7cMLRbRgNwFgmG+KFSZSfej9ztmOUL4wTJi8p8I2l6Yyvsy69y3PNet9ZiR
	 0r/ZBe0HVuypIDxN7wAZ1BrbwiU7x5e/67ca2zvfLm31uGBCsqfff5/dW2qO2mvqbE
	 AcT10SHnEbBKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 07/39] dyndbg: factor ddebug_match_desc out from
 ddebug_change
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
In-Reply-To: <20260908-dd-cmap-part2-clean-v9-7-3a3f621f4a10@gmail.com>
References: <20260908-dd-cmap-part2-clean-v9-0-3a3f621f4a10@gmail.com>
 <20260908-dd-cmap-part2-clean-v9-7-3a3f621f4a10@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 01:03:35 +0000
Message-Id: <20260909010335.E03411F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incomplete check for NULL `dp->format` bypasses the intended pro=
tection when `query->format` is NULL.
--

commit 6e852d37b2302458d6d8e267b4a7058839bebf01
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg: factor ddebug_match_desc out from ddebug_change

This commit factors out the descriptor matching logic from ddebug_change() =
into
a new ddebug_match_desc() boolean function. It replaces inner loop continue
statements with return false to simplify the logic, and elevates a check for
a NULL format string to report an error and skip the descriptor.

> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index 49334d1aa4b3a..46ef31328194e 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
[ ... ]
> @@ -172,6 +172,59 @@ static struct ddebug_class_map *ddebug_find_valid_cl=
ass(struct ddebug_table cons
[ ... ]
> +	/* match against the format */
> +	if (query->format) {
> +		if (!dp->format) {
> +			pr_err_ratelimited("ddebug: NULL format string at %s:%s:%u\n",
> +					   dp->filename ? dp->filename : "?",
> +					   dp->function ? dp->function : "?",
> +					   dp->lineno);
> +			return false;
> +		}

[Severity: Medium]
Does nesting the !dp->format check inside if (query->format) bypass the
intended protection when a query does not filter by format?

If a user issues a query without a format filter (for example,
echo 'module * +p' > control), query->format is NULL. This skips the
evaluation of the inner check entirely.

Can this allow a malformed descriptor to be enabled, leading to the kernel
crashing later in __dynamic_pr_debug() when the missing format is executed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-dd-cmap-pa=
rt2-clean-v9-0-3a3f621f4a10@gmail.com?part=3D7
