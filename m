Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAB14582EC
	for <linux-modules@vger.kernel.org>; Tue, 21 Jul 2026 21:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784667927; cv=none; b=BytCFyHHTlElIQZ2l750S6ejC67Qj81UDgM5zWkORjCadmDJxKkHbH5F8nn3GWKddri211855qP/c8TNOfLcsqjc1w8lkXSOIbZ/5HSWyZATiXIbS0cSN5Eb8tHkj5FbUrDPWD/dBU6hnjKLN8CTAdbLicgC+02/pA2NJsGUHl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784667927; c=relaxed/simple;
	bh=w8q30zTJPR/8GJmAseKWCcw3Na9Vqr6SXONafXhV7Jk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JT8t+a3SD3G93Jxqo+OZLw5fxcf0ajFjZDQUEdWJb8j2UQjK15g3TGZnjiaFP/+DfH7nNb1gwzG0u0vTD7JWrD/jiD13I3IK48949CRv1L6bApqekZzZkhM3K9pyxyKgLouwuO8gJ/g6ww1ujIKJexODY7KhookqOtqmCOK6ZUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JE+2F3s/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JE+2F3s/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 062481F00A3A;
	Tue, 21 Jul 2026 21:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784667925;
	bh=UtEUVdcGTMDMgqAOtacQGh7LJpl8Y9P25RZ5RnxNrP4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JE+2F3s/JM4FdsiA0gFN0pS3/iUcdhgqxVsoioBG/VrLp27Etown1UCoGp1gmhKmF
	 /tIN1NVMZBAos68ZFInOx/g7dmcpWlYVm0LNR9TFW8KQaterVwO+yh2mtq6v6b+Yng
	 XflVdbXJv1v6EZYpkbk4Hxk+HfinGLy88TZhOKin8/yhz1TaNvQoQuCdxSNrl6EwiZ
	 V99oHakVYzOd3iOGjATHM+ihd/6OfqXYry1T22jfPujzSetYFtXWwNBt4sswMnd84b
	 ED7um8mgUw87IumqOhWu4aey+no7r+Y98EKEjO7RRaBgI5z5IiUYkPi1fm7fRIROok
	 r4B8gTTMP4Tzg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 11/29] dyndbg: factor ddebug_match_desc out from
 ddebug_change
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
In-Reply-To: <20260721-dd-maint-2-v7-11-010fbe73b311@gmail.com>
References: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
 <20260721-dd-maint-2-v7-11-010fbe73b311@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 21:05:23 +0000
Message-Id: <20260721210525.062481F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly added NULL format check uses an un-ratelimited, contex=
t-free `pr_info()` inside a globally locked inner loop.
--

--- Patch [11]: [PATCH v7 11/29] dyndbg: factor ddebug_match_desc out from =
ddebug_change ---
commit 47cab4604933a3e3a136a1d101a11ae69fe36598
Author: Jim Cromie <jim.cromie@gmail.com>
Subject: dyndbg: factor ddebug_match_desc out from ddebug_change

This commit factors out the per-descriptor filtering logic from the inner l=
oop
of ddebug_change() into a separate boolean function, ddebug_match_desc(). It
also introduces a check to prevent operating on debug descriptors with a NU=
LL
format string.

> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index 18a71a9108d3e..577a079160727 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
[ ... ]
> @@ -172,6 +172,56 @@ static struct ddebug_class_map *ddebug_find_valid_cl=
ass(struct ddebug_table cons
>   * callsites, normally the same as number of changes.  If verbose,
>   * logs the changes.  Takes ddebug_lock.
>   */
> +static bool ddebug_match_desc(const struct ddebug_query *query,
> +			      struct _ddebug *dp,
> +			      int valid_class)
> +{
[ ... ]
> +	/* match against the format */
> +	if (query->format) {
> +		if (!dp->format) {
> +			pr_info("encountered a NULL format\n");

[Severity: Medium]
Could this un-ratelimited pr_info() spam the kernel log?=20

Since ddebug_match_desc() is executed inside a nested loop holding
ddebug_lock, if there is a malformed descriptor in the system, querying the
format via debugfs could trigger this message repeatedly on every format
query.

Additionally, because the message lacks context, it doesn't provide clues
to help identify which callsite is missing the format string. Would it be
better to include details like dp->filename, dp->function, or dp->lineno
here, and perhaps use pr_info_once() or pr_warn_ratelimited() to avoid
log flooding?

> +			return false;
> +		}
> +		if (*query->format =3D=3D '^') {
> +			char *p;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-dd-maint-2=
-v7-0-010fbe73b311@gmail.com?part=3D11
