Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0023B71DC
	for <linux-modules@vger.kernel.org>; Wed,  8 Jul 2026 02:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783477466; cv=none; b=nYMEc1MVuPJUMfT2K7qEhsC3FKz5W30PaVN5fDKuKks8k59D9xGqM3PRO2jg8p0dgPYTbxBIG6Kt7CQrOquuDQoZiwSW1iR+Evnv0haYwB4RiAMZygEOs/tVYTZh+voASv35rg3SETZT08pa7Gzo6UR4BWQQ0x9t77pIeO4PpPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783477466; c=relaxed/simple;
	bh=vvzQqnjHZxjB457O8tkol1FwvhxuMPEu4iiVVuLkMrU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=by75rsmlN+GtPeJrVeGZg5g9kqTIG0HV6p5i2YZhFSyT7txf2eRiDZs9soGlTbNuyFUMBZ72dlLBgZAJx+5ZOjQkKKfOXBS1uKnaWd/8f3gU2qMfLovA6Lj4MkvgO5ihygRrPHM3TmJD4Pe6sa8ZOQN1iXFeCPKSKLfciGnluPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3aowv0b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3aowv0b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC02F1F000E9;
	Wed,  8 Jul 2026 02:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783477464;
	bh=0/tpV7om0mq0D47x0oAvdgpxEIffLwqkt+J+RPoXadY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A3aowv0bLRsjT4T3VcBdORmprXrcJB+pcl4Xx6z+LA0pgikoue9uuQZDXBcXoQgvL
	 XKD95++6DMza0bkc+rGIOB/DVeXog9AfI9GpKLx71e++TuIdXj5Yi9WjPN7XZpA5qo
	 XhhMRcc+d5AYmf2bRHIwdOXfzOmOWuBiblzzGFJg/T2o98Jb8yFfyYNPxEGIijgYuD
	 3FVXx0wVRYKOy7F/jqIYlu7lMpWBp26ljTh4NymesZinYL4/kbRmciOK0egJGzd5GP
	 ZbxiR69QSxZUKw0w4dxaO6LlS2ReeC7Op2HUa2mEBIiNIGyUnkav80FmlDNJdhZRMe
	 4/+ZmILpjAauQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 10/24] dyndbg: drop NUM_TYPE_ARGS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
In-Reply-To: <20260707-dd-maint-2-v6-10-381f3edb0045@gmail.com>
References: <20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com>
 <20260707-dd-maint-2-v6-10-381f3edb0045@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 02:24:24 +0000
Message-Id: <20260708022424.AC02F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The newly defined macro __DDEBUG_ARRAY_SIZE is unused because the a=
rray size calculation is manually open-coded.
--

--- Patch [10]: [PATCH v6 10/24] dyndbg: drop NUM_TYPE_ARGS ---
commit 0ca0f4a344ab62c4d4df9c27a60daf65fecad136
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg: drop NUM_TYPE_ARGS

This commit removes the NUM_TYPE_ARGS macro and replaces it with an array
size calculation. The commit message mentions adding a new local macro named
__DDEBUG_ARRAY_SIZE to handle this without causing include conflicts.

> diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
> index 9607121c3072e..9ae1accb9bf63 100644
> --- a/include/linux/dynamic_debug.h
> +++ b/include/linux/dynamic_debug.h
> @@ -8,6 +8,8 @@
> =20
>  #include <linux/build_bug.h>
> =20
> +#define __DDEBUG_ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
> +

[ ... ]

> @@ -122,11 +124,9 @@ struct ddebug_class_param {
>  		.mod_name =3D KBUILD_MODNAME,				\
>  		.base =3D _base,						\
>  		.map_type =3D _maptype,					\
> -		.length =3D NUM_TYPE_ARGS(char*, __VA_ARGS__),		\
> +		.length =3D (sizeof(_var##_classnames) / sizeof(_var##_classnames[0]))=
, \

[Severity: Low]
This isn't a bug, but should this line use the new __DDEBUG_ARRAY_SIZE macro
introduced above? The calculation appears to be manually open-coded here,
leaving the newly defined macro unused.

>  		.class_names =3D _var##_classnames,			\
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-dd-maint-2=
-v6-0-381f3edb0045@gmail.com?part=3D10
