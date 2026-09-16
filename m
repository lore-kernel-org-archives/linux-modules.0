Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C46495AF2
	for <linux-modules@vger.kernel.org>; Wed, 16 Sep 2026 16:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789576869; cv=none; b=Xn/Ipl7Ef1FSKhP3APrMObExY6cXycv65Ouzs08SkRwoZYFlhb54kOzVXhGzef48ob53hIqleYBg2aGclKb/tIhX63qRny9iy400Vtfy6keTUGhApMFtQxx4nRkusSd4LVcOD5Fr31OuCXxe/wpDUiIy4E290nEYEm5fXoAUBdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789576869; c=relaxed/simple;
	bh=QjfMsWMaMzH1kJ2EhtKVdI4E+XFrBxNAgaIiOsn7Z7A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aMW1eGbVBQSdAATB5g91b7XlSUFQOFz40Lm1/Fdg1tLd/cWGgq3rTe0tlxe1vzLw+caZT/5MGXHXO8PSSTBNblYHmHHNuMWtMjFFGQAzl7P+d95bSeB41zxQvfl+FsMbcTJFQrcgg54nRzfeW33Sb4EQeK0Fr44HP5xwDqRW++g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4Wm+ZFN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4Wm+ZFN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E3471F000FF;
	Wed, 16 Sep 2026 16:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789576859;
	bh=vZgyQidYMLyvGq4E+oKRD3Z1765ODD0CdTnReGLUSHI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L4Wm+ZFNS5w7vNj4K5F2Es3vG240ISRRl+2ufBfbMwfHbdyMUbMmmeb2YisDIYcie
	 TYQqeXDz3ODz2H2JX09Gyf5I+O7KbTA6rX+SerE6cCQCtfNSnW3tpwWvIfnhzR1egp
	 Wqx6j19sAZQkZmIILYILU0gv1mgclj3lGNChW1waIeYVW4qipUKR2DmxSilqdV5nAB
	 NKzwIZlIm6teRr//sFo7Ej5L1hUHjC2+aaW5UqOWH7cZfwg7RaKiEh6HlFO5nA6Reh
	 6GIKKd7Q7n3ya38vXnqeXPRhiRKzRbumg5iLs5LI/3QjzLthtcfl50im614KVk78wn
	 kf/EFM9AnWF6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 28/38] dyndbg-API: promote
 DYNAMIC_DEBUG_CLASSMAP_PARAM to API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: linux-modules@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260916-dd-cmap-part2-clean-v10-28-af4cf4767707@gmail.com>
References: <20260916-dd-cmap-part2-clean-v10-0-af4cf4767707@gmail.com>
 <20260916-dd-cmap-part2-clean-v10-28-af4cf4767707@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 16:40:59 +0000
Message-Id: <20260916164059.8E3471F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] macro: redefinition of _DPRINTK_CLASSBITS_INIT
--

commit 0781b4eba8375be337f6f650796b2d759c24bf73
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg-API: promote DYNAMIC_DEBUG_CLASSMAP_PARAM to API

This commit moves the DYNAMIC_DEBUG_CLASSMAP_PARAM macro into the header
and refines it into two separate macros for different use cases. It also ad=
ds
stub macros for !CONFIG_DYNAMIC_DEBUG and cleans up the test code.

> diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
> index 26c858588eb16..3114f4f28be44 100644
> --- a/include/linux/dynamic_debug.h
> +++ b/include/linux/dynamic_debug.h
> @@ -60,6 +60,8 @@ struct _ddebug {
>  #else
>  #define _DPRINTK_FLAGS_DEFAULT 0
>  #endif
> +#define _DPRINTK_CLASSBITS_INIT ((_DPRINTK_FLAGS_DEFAULT & _DPRINTK_FLAG=
S_PRINT) ? ~0U : 0U)
> +
>  	unsigned int flags:8;
>  #ifdef CONFIG_JUMP_LABEL
>  	union {

[ ... ]

> @@ -466,9 +506,20 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
>  #include <linux/errno.h>
>  #include <linux/printk.h>
> =20
> +#if defined(DEBUG)
> +#define _DPRINTK_CLASSBITS_INIT ~0U
> +#else
> +#define _DPRINTK_CLASSBITS_INIT 0U
> +#endif

[Severity: Low]
Does this redefine _DPRINTK_CLASSBITS_INIT when CONFIG_DYNAMIC_DEBUG is
disabled? The macro is already defined unconditionally earlier in this file
(just before the flags field of struct _ddebug), which causes a
-Wmacro-redefined compiler warning.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-dd-cmap-pa=
rt2-clean-v10-0-af4cf4767707@gmail.com?part=3D28
