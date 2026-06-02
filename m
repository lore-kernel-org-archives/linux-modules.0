Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6F634C139
	for <linux-modules@vger.kernel.org>; Tue,  2 Jun 2026 22:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780441080; cv=none; b=PfDbzuBQliiQ65FANBRw9k7eF7cf7wl7YX/jJ+Pybut8rsbWQEpZQbw/v+huSni5xChp+EgS8D+0bxAfkxycDlOoRMmq4kEB1gZvA4/eyMjEYd5iqlJve2Q/KaDHZoH/DWgjQujmHWCpjGz1inA8qdXcx6nNoHUztLBrtLa31BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780441080; c=relaxed/simple;
	bh=GL9rTSwM0zxZOLfxFYoB7rVOsp5Isw/6hl1V4IthxCs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EYVx0f4R9gHgwqMTwoxzifFa6Y8kVha9w7q/xf8KwbzISOGR8yH+WzIBO7PyM8rZBNq4kx1zN7eX9Nfov8gxLkYNoLqtC8viffSTAAPZ6J6IhIueEqXyVdC70ZVdzZKZMr+E9eyL4Kd+/ulRlWkytQimGbZ33YmWlqqxh1gkTfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwNMrZky; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwNMrZky"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308981F00893;
	Tue,  2 Jun 2026 22:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780441079;
	bh=TukxZ7G066Od+IL0LkYgUFH+W+MQmVjoKnKbqVdjLwA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cwNMrZkypnLUuN/0ec8c6eEMCc6qn0Wvq4Y6F9t3PIOPN2RMexTa6J6hfL5HJ5NMW
	 iBLLCXSOQK1r0cLlZUVqWKUpGbBtETygXs7wMyS22OBh+WgC7duZu95k+cOceZQqW7
	 4weTVJ1xfpk03ZRpAK63RKzx+KalDF2LvMNmeC9sYlec+M7YNOWrUZtUHqIds2+IQa
	 uIt9Kv4yTjK7fGimkoplpXrh4oNY0WOrYWhnOO+IqT7F6S5ao1iXWETMjnegAIEXgY
	 1MVjoi56/ZFb7ZwX+IzKWoD+fpIjccYhkTWcB+e3PIkTO3SOOxQbJHLizr4Ev1YcCI
	 twssFBbfJ/3Iw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 12/25] dyndbg: drop NUM_TYPE_ARGS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260602-dd-maint-2-v4-12-19a1445585a8@gmail.com>
References: <20260602-dd-maint-2-v4-12-19a1445585a8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 22:57:58 +0000
Message-Id: <20260602225759.308981F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The macro DECLARE_DYNDBG_CLASSMAP relies on ARRAY_SIZE, but the pat=
ch fails to include <linux/array_size.h>.
--

commit 464d8da755ec7b15d6bc584121b284d4801591c5
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg: drop NUM_TYPE_ARGS

This commit replaces the custom NUM_TYPE_ARGS macro with the standard
ARRAY_SIZE macro in the dynamic debug classmap declaration. It removes
the NUM_TYPE_ARGS definition entirely since the array declaration is
complete.

> diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
> index 78c22c6d23128..867e3978675f0 100644
> --- a/include/linux/dynamic_debug.h
> +++ b/include/linux/dynamic_debug.h
> @@ -121,11 +121,9 @@ struct ddebug_class_param {
>  		.mod_name =3D KBUILD_MODNAME,				\
>  		.base =3D _base,						\
>  		.map_type =3D _maptype,					\
> -		.length =3D NUM_TYPE_ARGS(char*, __VA_ARGS__),		\
> +		.length =3D ARRAY_SIZE(_var##_classnames),		\

[Severity: Low]
Does this require an include of <linux/array_size.h> to keep the header
self-contained?

The DECLARE_DYNDBG_CLASSMAP macro now relies on ARRAY_SIZE, but it appears
the header that defines it is not explicitly included in dynamic_debug.h.
Could this cause build errors for files using this macro if they do not
already happen to include <linux/array_size.h> directly or indirectly?

>  		.class_names =3D _var##_classnames,			\
>  	}
> -#define NUM_TYPE_ARGS(eltype, ...)				\
> -	(sizeof((eltype[]) {__VA_ARGS__}) / sizeof(eltype))

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602-dd-maint-2=
-v4-0-19a1445585a8@gmail.com?part=3D12
