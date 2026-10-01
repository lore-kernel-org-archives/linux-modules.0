Received: from mail-yx2-f14.google.com (mail-yx2-f14.google.com [74.125.224.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB4C38DC59
	for <linux-modules@vger.kernel.org>; Thu,  1 Oct 2026 22:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790892970; cv=pass; b=g8jlcdc8pT/wERbugZqaBKgszJiKAj7A5jF2bcP2+/WpbER6bVDeFhfEyYeC8pEVuF+qYn5pXeWRxNTR+ue3/xziKXzVzgg+kJAGMZueY39uoq5SKfVdP9ZwAb9bdpeXWTa8RE6cCTLrXxMtYtbaQCQHr/cKUq/bHkXvfOP/hmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790892970; c=relaxed/simple;
	bh=Kg2RBXpFtT5mFhV9J7d4HKN6JQoqJIJ64uHnfF1xOZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LUQ+3VVCNtI3o1Bc0EMypy+zlzBbFnh80UpLn3uB4eErXcNyQOw7FeWnfOiwQbH7bxNsypLGAgiqaybfxbmh/OJWcArWKHLZMncDjxXyR09EbdCyixSO9J8tlm5jGuIOntOPCgW89jSZLW+0GHLvGPk8jOAg2gTmJilsSc4kO0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XdZpCUOc; arc=pass smtp.client-ip=74.125.224.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XdZpCUOc"
Received: by mail-yx2-f14.google.com with SMTP id 00721157ae682-8ab42612328so40937797b3.0
        for <linux-modules@vger.kernel.org>; Thu, 01 Oct 2026 15:16:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790892966; cv=none;
        d=google.com; s=arc-20260327;
        b=RjGjuOxl37s2XUAVjbKLXOHmm7OoJ1yAcOVpcYHP6XGl7hJF+paM/2yOKTtUgy/H1L
         oOh8Pb+NalIHqs2bjT4uWASFcJc5Ia6GbBI6W9qfQv5OBMRRi615lRtYqLeI8DvyKtje
         FRoh+3GLIKjPY6oKzgPonaaA8AQjnZAVBmf4giWqvSBtkfXEnQ8y4PDmwciEuNK3ZM5W
         y29+FZFSVZn1Gcz6Ymkd0KiPzt7IPBaht2IbJWyN0EFxzJXUVd8ssknfMG4Qw8kSUh0U
         IJ86H9jhGqLcbfOan3hmBwTy6Q2efgfdhvEUF0aeCEUKeGdLp2SMawSQsvw79s3ARdvo
         gltg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fFp9K5kNxLern9IX4I7rgGeq/2vHkCE/7tXvywJUIjY=;
        fh=qhQ1kGQn2xaybB6HdRpp+CiYz/mHeIsmrAcnZKvke/k=;
        b=Q9dGcbb2nZy6O+7ZmJOKn2hXSkuOKz+pgBqpLbr5mpAzX7/174dG577M9Iwmkrbl2n
         uxocKHdYJi6Hyn0sPLG40ED9Sd0JEuIFgSfLvosU0nV5f15LCy7l859f7TsG3INTjXgX
         ue1OLxSOGk9Z/7086CCEVLeVWbDR2y2pZLV6geRGwTYskhzj/yq6T1km72APU9gSQWJY
         WeftiFRJfj0J3t2X0CVq79/laWNPb72zXZ23NMqNMiF2DsFT/6e1PaFVjWvjTXvGaTpZ
         VfEEQflzD1YNBBFtq9BBOPGG3qmFqEVDblNsNo6W+l7WVRGyc7EfGgehbz1aUob8BgdS
         NOWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790892966; x=1791497766; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fFp9K5kNxLern9IX4I7rgGeq/2vHkCE/7tXvywJUIjY=;
        b=XdZpCUOc1gCdXh+n9ZtmDsYpUiOf5iYXZjypJERRvXtbGad5BaWfAz8+nPLDuUTOS1
         3iTKRnMEs6O0CB109LKzzQE+uJuq3CgeXaT+Of9VZZ0EBJ2EnfxG6ehj7IesC2wzloYg
         x0CXfghfFGua4eglECIBN8N5Mj7+vOFbMovjDlWjnGDNMkqCohGz2ib9Wlf/WCLzHq0o
         n/1Y4Ei9l3XEphcV3H/06qO/lamSGgur7eRQfLFtxIy7MrLdzNpQAH/OlasWQS9R/2G2
         P5gUxviz9/roE+j8AA9qcVuem62MK14WAsWX+Hd+DMNFbLRp3bUS93n3OWpKQEZEGpPR
         qrRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790892966; x=1791497766;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fFp9K5kNxLern9IX4I7rgGeq/2vHkCE/7tXvywJUIjY=;
        b=j0l7QydN14Az4IwGHewLcGRtL9Sko5aBNBVsuboEO2x8jw95tkBrNeUKPq7WeDzbFH
         NVk6k5V1StmvZ2DrCvXz0g/koMYpaWk1pHkfHMkvLrs31BxLHVECuRIOgRUoNLFF/i+q
         3cSYCb5Dzy8XD3FXpM2Oz40iDPysGnMW30f1Nni5FrR2NtMI0d5V2I8M5SVb6NTtCsfi
         lIeykB6OP6YMXbYDRxrgTTlYVx40/8+9LCtEGA9o3JPWhqfLjmOxj2kc5yKdBTZjuyLO
         UmvEsXPQOzavUNlIO3sLroJEpe5NJyRqhwdS6JClVf0r8OFhYS3NwBPeMu8xTZn6lCfl
         ooUQ==
X-Forwarded-Encrypted: i=1; AKwUvBxyHROfeJei4s0gEDMspjJNeYDdmIzd2Dy2tKyaQGqaEuzqfaNbU2vsmuAkjiAgbW1marUzwBT1HhVPbUyu@vger.kernel.org
X-Gm-Message-State: AFq9FYIJiO3lLh4hOVx+YznF8wSCTPF7SHOv4Lih0bEHR+iiktEbW3x2
	qfbkOdLxjGyEPOQOHTKYdu1C2m/M3SsOWrBqrrnXpWfwRdA140TWneC+8enfdtdb4sMcJnBZiT/
	z690SeQNp2i4bt+KMRL8MxfyjiHunxR2erA==
X-Gm-Gg: AYBFou0CQCpcS94e34EG+KAg4o6+lVY3zpQbVlEtOGlPppubyzRnNOmnByXtGGDAd9U
	ncFe0olhp2GeyWwGi+YTFiOOM/eJZgRHcpRfPw/nOJ33+v7Oo878DpyjG3pV0/Mtkaen9o7le4K
	zeFm0oTtbhv9aoa1dlvQW4QNrmO1m+YJQvJeOvfPkFdlnNiguRq5ELp0OBzCHJqXUqXG3xN82Mv
	4nVpdgwlUzC6ZSYc2TaUVaT8B6aRkGMM2zpNoiiP0ujqhvfJ7eMzFXuNDYAeO4GtsNdYnz5yyad
	Jvi2v9YyHKpftq+WDgUDBEDX3sGB0BTg/PFCaUKV6Ztnqp5i5WW3J5Yu7geoc0iNFYHW5H1RDd0
	HXkq8ajow0i3iPSEtCvHr4OfXVuPS6lfrhQ==
X-Received: by 2002:a05:690e:4885:20b0:674:f33:3a38 with SMTP id
 956f58d0204a3-677ac148763mr250188d50.125.1790892965727; Thu, 01 Oct 2026
 15:16:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
 <20260923-dd-cmap-part2-clean-v11-14-9b6c217fdf2f@gmail.com> <20260923224509.4DE3F1F000FF@smtp.kernel.org>
In-Reply-To: <20260923224509.4DE3F1F000FF@smtp.kernel.org>
From: jim.cromie@gmail.com
Date: Thu, 1 Oct 2026 16:15:39 -0600
X-Gm-Features: AclHuK-GHAcqAEG9-PO9HaBTq4Efz44Tmpp9mn4Tt1hmvZxExK0du5Qqqyez3YY
Message-ID: <CAJfuBxzvL1ATWv96GeEgUHY0m3G-sm0=0KRSOqVjaXQ7e61spg@mail.gmail.com>
Subject: Re: [PATCH v11 14/38] dyndbg: Bind callsites and classmaps to DDEBUG_MODNAME
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 4:45=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] dyndbg: classmaps for loadable modules are dropped if DDEBUG_M=
ODNAME is overridden
> --
>
> commit 5e35c3cb693ea4379aa99e08e89d78671956f5c5
> Author: Jim Cromie <jim.cromie@gmail.com>
>
> dyndbg: Bind callsites and classmaps to DDEBUG_MODNAME
>
> Currently, dyndbg binds KBUILD_MODNAME directly into callsite and
> classmap declarator macros.
>
> For built-ins, KBUILD_MODNAME defaults to the basename of the source
> file. For many subsystems, this fragments what should be a single
> module into separate file basenames: kernel/power/ produces "main",
> "suspend", "hibernate", "snapshot", and "swap" when all should be
> "power". Conversely, multiple unrelated built-in files across the tree
> (init/main.c, kernel/power/main.c) all collide under "main".
>
> [ ... ]
>
> > diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debu=
g.h
> > index baf5c0853f459..85863e24ad134 100644
> > --- a/include/linux/dynamic_debug.h
> > +++ b/include/linux/dynamic_debug.h
> [ ... ]
> > @@ -121,7 +129,7 @@ struct ddebug_class_param {
> >       static struct ddebug_class_map __aligned(8) __used              \
> >               __section("__dyndbg_classes") _var =3D {                 =
 \
> >               .mod =3D THIS_MODULE,                                    =
 \
> > -             .mod_name =3D KBUILD_MODNAME,                            =
 \
> > +             .mod_name =3D DDEBUG_MODNAME,                            =
 \
> >               .base =3D _base,                                         =
 \
> >               .map_type =3D _maptype,                                  =
 \
> >               .class_names =3D _var##_classnames,                      =
 \
>
> [Severity: Medium]
> Will this drop classmaps for loadable modules if a maintainer overrides
> DDEBUG_MODNAME?
>
> When a loadable module is loaded, ddebug_module_notify() calls
> ddebug_add_module() using the module's actual load name (mod->name) to
> initialize the ddebug_table's module name.
>
> During initialization, ddebug_attach_module_classes() attempts to match t=
he
> classmap to the module by comparing strings:
>
> lib/dynamic_debug.c:ddebug_attach_module_classes() {
>     ...
>     if (!strcmp(cm->mod_name, dt->mod_name)) {
>     ...
> }
>
> If a maintainer uses the opt-in hook (e.g., ccflags-y +=3D -DDDEBUG_MODNA=
ME=3D'"power"')
> on a loadable module whose load name is "suspend", cm->mod_name will be "=
power"
> while dt->mod_name is "suspend".
>
> Since the string comparison fails, will all classmaps for the loadable mo=
dule
> be silently dropped, causing class'd pr_debug calls to lose their functio=
nality
> and trigger pr_warn spam on load due to unknown class IDs?
>

I have dropped the DDEBUG_MODNAME indirection,
am keeping the existing KBUILD_MODNAME.

While it has the effect of breaking up what might be considered a single mo=
dule,
like "power", into ~6 separate ones, with names like "core" and "main",
we can debate that separately, perhaps as an RFC,
since it touches so many builtin module names.

> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-dd-cmap-=
part2-clean-v11-0-9b6c217fdf2f@gmail.com?part=3D14
