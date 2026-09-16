Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6A94D0CF6
	for <linux-modules@vger.kernel.org>; Wed, 16 Sep 2026 16:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789576254; cv=none; b=iUJiJjIS+sMYR2UnyBZACtOrcn3274cKjF1OGumjcWdQduDMv7yhBVUqz1F60EYD74WTlMig1jl1uQ4+GZCAlh/AOS+ZYKCPR4h3Ju/H8F5EtomdNU/KPZGgIUL2E1Fz1OtyYk8ZtUEAF9raZju+dwb/XiVEbqw/Q4kdF9mTHi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789576254; c=relaxed/simple;
	bh=Y0URTgGguhM7ZmAhJdwY619vaVL3TjaKIQzHzyDbLYI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k9a+yxlWptUhMj8py/mVQYU81pm3/tlQnfLjEC+dsm3VVEHyesgKTK7lyS+UXOyOKzGu4Cm9rIpKfX/3rMhgyJ4UU9cdug5iG14Plfld9tRKBK1uiViNmHRsFV6gKRFM4b1T4Hsbej5K0gJrG5kriOXxZABZorjm3J949yMKLSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URagGVw3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URagGVw3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8035A1F000FF;
	Wed, 16 Sep 2026 16:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789576252;
	bh=GR6cQGym176ZFbuSYyzuWGk3aar8qLbo/kWgdm+jCJs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=URagGVw3Yxybs1S0MjuOrsrNOgDAmKtUGbJea8yr8aJkLZ0qGZ13mauhTKW+r/TSj
	 BtOUKOHbFibw3jytnnoBWb+oQmiGGDQZOArPRypBIQLRoLN02DrgVRWd7dkTEU+/E2
	 Z+ehP61v1Avp3w2532yncQHR87aWOUrXjg6bH2+gECWjqj9No7DJeuyGs37EfGul7v
	 m3AKt/PlE2fWo8h+9xnjWV/O0wfL7y1OiJXxq7DK55cFGw7t1kKo3Fugou5z0CiRbi
	 EAqAyqqu0JrCiOpsdCxnnVRA+Jt1cz0PNJK/OSo54pKKoNrPMua4mskq6CN1cWc9hN
	 GU3j9VDrhPgew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 25/38] dyndbg: detect class_id reservation conflicts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: linux-modules@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260916-dd-cmap-part2-clean-v10-25-af4cf4767707@gmail.com>
References: <20260916-dd-cmap-part2-clean-v10-0-af4cf4767707@gmail.com>
 <20260916-dd-cmap-part2-clean-v10-25-af4cf4767707@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 16:30:52 +0000
Message-Id: <20260916163052.8035A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] dyndbg: unconditional mod_ct increment leads to inaccurate initiali=
zation logs
--

commit d123ad70c52a21eda06f63a98463a51685d0bfb6
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg: detect class_id reservation conflicts

If a module _DEFINEs 2 or more classmaps, it must devise them to share
the per-module 0..62 class-id space; ie their respective base,+length
reservations cannot overlap.

> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index 566c3860d7bfb..7736fb3d3b791 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
[ ... ]
> @@ -1605,7 +1617,7 @@ static int __init dynamic_debug_init(void)
>  			di.mod_name =3D modname;
>  			ret =3D ddebug_add_module(&di);
>  			if (ret)
> -				goto out_err;
> +				pr_warn("failed to add built-in module %s: %d\n", modname, ret);
> =20
>  			mod_ct++;
> =20

[Severity: Low]
Is it intentional to unconditionally increment mod_ct here? By changing
this from a fatal error to a warn-and-continue, if ddebug_add_module()
fails, the inflated mod_ct will cause inaccurate initialization logs
(vpr_info) and an incorrect calculation for memory used by ddebug tables.
Should the increment only happen on success?

> @@ -1620,7 +1632,7 @@ static int __init dynamic_debug_init(void)
>  	di.mod_name =3D modname;
>  	ret =3D ddebug_add_module(&di);
>  	if (ret)
> -		goto out_err;
> +		pr_warn("failed to add built-in module %s: %d\n", modname, ret);
> =20
>  	mod_ct++;
> =20

[Severity: Low]
Similarly, does this unconditional increment of mod_ct inflate the
statistics when ddebug_add_module() fails for the final built-in module
in dynamic_debug_init()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-dd-cmap-pa=
rt2-clean-v10-0-af4cf4767707@gmail.com?part=3D25
