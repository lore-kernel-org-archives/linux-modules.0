Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EA67462
	for <linux-modules@vger.kernel.org>; Sat, 19 Oct 2024 14:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729348264; cv=none; b=IZosBewL4MyndOUi1h5qs8IkMqvJR1wEKyaJBh6CCPv8PiXmB0nCiEXgK8Mrm4ec19nB8/BVyEn9DoGL3VVwAPQQiTpLeDed33bMlX0mHPNR1SQoHnkqy/66NiO4p8cOSRJf58fPDPRTNE9i4BIC/1iups+f/1rE+klTrs0FXN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729348264; c=relaxed/simple;
	bh=44QQ7wzsdMqDAptt7Z2JzhCHYUeM+5foUxSlSzXykwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pp+egTrfyEGHladjhA2D0qLVux5x0Be8ExC8DjBFu45GwakXMeJktm6YscSD9rjf8ewSp7obKgT99vnCbmh8kE9+kps1QQ7KyConPX8LonvpzeZAsmmr3OJPkbxQh0TToOQ3xPwRwDl4rmQ8UeCJg2XDtpA7mZBGwvyE3L7JM+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XpGeUVF3; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpGeUVF3"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fb51f39394so32731601fa.2
        for <linux-modules@vger.kernel.org>; Sat, 19 Oct 2024 07:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729348261; x=1729953061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WnWU9zfHt1zA8zglRcDW9woNJ7NPHt0BJ9yMOoSR7/c=;
        b=XpGeUVF31WT7D+2yw8APEB4W/85p0L4Nm5VjjuUt5/HAf/EaVNYITTzanm5XwxUA8e
         XMT+b+GHzf1ySHvP8QNM68GwQu5yHy/G3oBlh/1JXzMJx1ZqirvGs8nJ6GEcGFZHlbBi
         t4DrWbdUKmPKvKlbdxZKDqCFWixEk9NS+/j8mG3rXFi44OFHbCCBCusPDf53jY+/tIpm
         Qb9b2M+u/N7fynj7XkF0puBBMXzgWbPlfNqe5D9VeZkZ20UKt52UZNsGQbdOWu4LAxH/
         L00tDbxx/KFaPzR5bnb+4PRvR+fbJeH1GMFjSub03nJg+o8H9tPrq08pub2U/Ag0uS6v
         6Yvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729348261; x=1729953061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WnWU9zfHt1zA8zglRcDW9woNJ7NPHt0BJ9yMOoSR7/c=;
        b=cXjH8Efcon6RmRIXMlPY89tN1UX2b7nfx6b98NTCKNWeqAZD8Xq7EXTHbUrRMIBxEg
         mnYqPAnQAm95n5f/HveKC03FLE0FzQNmdFK5z8XmpVX5vj5UJiPSVDnPyVNj7DO0vlVy
         kxQJTrf5rvuJ7rUQJF9CVd3iZd9DeYNQESjmS8IGYMByrOVjZUJwVPvbNM5KTcg/Plcm
         dAg5sINmf86A1IUc0DUhYg1WlRdfznz8u1+UG3EijWLYU5RYSwCkOMNWjFxjRvQ0Gw9i
         tNOd3BW12In8IAxtLK/O4ctckTqVWxwpdNyWCgoNdfn0VKRd6c+cjO6GGCizlZGurfZr
         +0yg==
X-Forwarded-Encrypted: i=1; AJvYcCUuAvBfJ4L6oxRVeZO3n8VziUUK5qE5K9Nagm5D8soSuWFhH933BoRzgYT8ls9F/x7g8jtI/bbGvojhuWPK@vger.kernel.org
X-Gm-Message-State: AOJu0YwzqY7+53p4kPW4AKHBGzLfv/cKc3gQgQavZ7SBhdEMmScZ+uA7
	CdDsk3AKNfMhR1qrehSsCdH8gmkFh4mRRl+hWjd1g0teQWuLRScD4UVSiTBKK4+j7b6QJ51rEMr
	EscNZb/Qbcj0l6HBck4sBbongSlwk8E7N
X-Google-Smtp-Source: AGHT+IHapFbNjjQ7iT2h5U6BDuiP9Xe6YpiUC7peBNIWiz/jh6dIPJLhMMcHutxMoXl+L8LYcKrRFXn5w2YqJDN+JuQ=
X-Received: by 2002:a2e:d01:0:b0:2fb:3a12:a582 with SMTP id
 38308e7fff4ca-2fb82eb0752mr25690401fa.23.1729348260247; Sat, 19 Oct 2024
 07:31:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+icZUULLhDyScuQnM4Tx+JD9xMFhnKVkxepUK_o1jGhJGo+bQ@mail.gmail.com>
 <CA+icZUW_K-f-ATDuvtsjXokx7aWUcfh7XpW2JhxBeegXp3V4xw@mail.gmail.com>
 <CACvgo50-oorSp+70CctrxQRt04T5bkrO-z4uX66GeBFXROxYZA@mail.gmail.com> <CA+icZUVi8_17bPgGYFph-Jc3bhTRRVZa1K8dJgOChHors_ySFA@mail.gmail.com>
In-Reply-To: <CA+icZUVi8_17bPgGYFph-Jc3bhTRRVZa1K8dJgOChHors_ySFA@mail.gmail.com>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Sat, 19 Oct 2024 15:30:48 +0100
Message-ID: <CACvgo50dFQHROV+JhJOgutDOTYQg4R9aWTJdBXXhNWjR_rF9Bw@mail.gmail.com>
Subject: Re: First experiments with kmod-git and meson build-system
To: sedat.dilek@gmail.com
Cc: "Marco d'Itri" <md@linux.it>, Lucas De Marchi <lucas.de.marchi@gmail.com>, 
	linux-modules@vger.kernel.org, Tobias Stoeckmann <tobias@stoeckmann.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 19 Oct 2024 at 12:35, Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Fri, Oct 18, 2024 at 2:01=E2=80=AFPM Emil Velikov <emil.l.velikov@gmai=
l.com> wrote:
> >
> > Hi Sedat,
> >
> > On Fri, 18 Oct 2024 at 11:48, Sedat Dilek <sedat.dilek@gmail.com> wrote=
:
>
> > Have you tested the resulting files, or you're just building testing?
> > In case of the latter we already have CI which covers Debian so
> > :shrug:
> >
>
> Hi Emil,
>
> Great, you consider Debian/unstable builds in your CI.

We already do use Debian unstable - see the .github folder, in particular [=
1]

[1] https://github.com/kmod-project/kmod/blob/2758cb57ebe2b7bbf3b435544187a=
98702929b48/.github/workflows/main.yml#L34

> Thanks.
>
> > > looks like etc directory was not copied to $PREFIX.
> > >
> >
> > Yes, meson behaves differently wrt /etc - not much we can do there.
> > Ideally you can check how other Debian packages using meson deal with
> > this and borrow the approach.
> >
>
> Hmmm, can this be somehow documented - say in README.md?
>

Don't think it scales to document more than the very basics build and
install in kmod's README. Meson has a dedicated site plus a very
active discussion and issues sections.

> > > meson setup --prefix $PREFIX --sysconfdir $PREFIX/etc --native-file
> > > build-dev.ini ../build
> > >
> >
> > The build-dev.ini is a configuration file for kmod _developers_, so it
> > for packaging purposes seems off IMHO.
> >
>
> Yupp.
> Did upgrade to latest kmod-git and moved to a custom ini file - see below=
.
>
> [ Documentation ]
>
> README.md requires some hints to manpages and docs build requirements:
>
> manpages: scdoc
> docs: gtk-doc-tools (/usr/bin/gtkdoc-scan)
>
> Link: https://packages.debian.org/sid/all/gtk-doc-tools/filelist
>
> I see some more improvements to README.md.
> Offer: I can cook up a patch and send for review.
>

Yes please, nicely spotted. Please read over the CONTRIBUTING.md file for t=
ips.
Try to use the general project name (gtk-doc) and not the package name.

> > If you want to help with the Debian side, you can reach out to their
> > maintainer Marco (CC'd) via the debian bug tracker, email or salsa[1].
> >
> > HTH
> > Emil
> > [1] https://salsa.debian.org/md/kmod
>
> Ah Marco :-)!
>
> I did an install from kmod-git with overwriting the kmod binary and
> libkmod library.
>
> Renew my initrd.img file:
>
> KVER=3D"6.12.0-rc3-1-amd64-clang19-kcfi" ; update-initramfs -c -k $KVER
> -v 2>&1 | tee log_update-initramfs_$KVER.txt
>
> Booted fine!
>
> I saw some other things like:
>
>  file /usr/lib/x86_64-linux-gnu/libkmod.so*
> /usr/lib/x86_64-linux-gnu/libkmod.so:       symbolic link to libkmod.so.2
> /usr/lib/x86_64-linux-gnu/libkmod.so.2:     symbolic link to libkmod.so.2=
.5.0
> /usr/lib/x86_64-linux-gnu/libkmod.so.2.5.0: ELF 64-bit LSB shared
> object, x86-64, version 1 (SYSV), dynamically linked,
> BuildID[sha1]=3D3990121244ac36f617b2d289712054ecb1e390ba, with
> debug_info, not stripped
>
> Or an ASAN complaint is displayed requiring a LD_PRELOAD when
> "b_sanitize =3D 'address,undefined'" is used (when running
> update-initramfs).
>

Yup, those are expected... Speaking of which - with the sanitizers
enablement move to `build-dev.ini` I forgot to update the README :-)

> I have done my own INI file:
>
> --- build-dev.ini       2024-10-19 13:24:58.806312629 +0200
> +++ build-dileks.ini    2024-10-19 13:26:05.332670566 +0200
> @@ -4,15 +4,15 @@
> ; SPDX-License-Identifier: LGPL-2.1-or-later
>
> [project options]
> -build-tests =3D true
> -debug-messages =3D true
> -docs =3D true
> +build-tests =3D false
> +debug-messages =3D false
> +docs =3D false
> zstd =3D 'enabled'
> xz =3D 'enabled'
> zlib =3D 'enabled'
> openssl =3D 'enabled'
> werror =3D true
> -b_sanitize =3D 'address,undefined'
> +;b_sanitize =3D 'address,undefined'
>
> [built-in options]
> -buildtype =3D 'debugoptimized'
> +;buildtype =3D 'debugoptimized'
>
> ^^ What buildtype other than above exists?
>

Check the meson website - it describes them quite well [2]

[2] https://mesonbuild.com/Builtin-options.html#details-for-buildtype

-Emil

> Thanks for the helpful hints, Emil.
>
> Best regards,
> -Sedat-
