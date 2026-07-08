Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033373B9D9B
	for <linux-modules@vger.kernel.org>; Wed,  8 Jul 2026 19:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783539405; cv=pass; b=D0wONNmzfkRpPFAHE+UPBxjGw2fujwaVZG+o0sfvAhgDyAIGSk66sErSme2HXfxz/ZZ5J6mODSXSS6vvcKeNWacx5W/ft9+q0xe74IRD1Ndfm/QQfgz/diF2dtop6QwCBsuDc0dMoZix0hcOlAmbkKQVqkK9WVnfEcg/D8GNi/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783539405; c=relaxed/simple;
	bh=kguXhAZ9G2VENgBFpRIgWFRZh2YAaMFsHNYSBlo8zTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rB9VRZYKftm6U/IektKTAjCoCuqhhkaHcE6JQiu1fb2/IR2h6Q+dzEyFceQNXu3YsAYWhOPOgMKu4GUME1mBHuk6O6LBqcD0Pp62gOaRCXNzrMQOTLhvDMCEJl+Rh6uS6CUC4JTTsiv67/8qK8/mB3l5Dglim798DGVd/oiOe4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hj7mo7A8; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hj7mo7A8"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-847a69ba83dso149335b3a.2
        for <linux-modules@vger.kernel.org>; Wed, 08 Jul 2026 12:36:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783539403; cv=none;
        d=google.com; s=arc-20260327;
        b=rluj5kt6zp8f6zK7MMMLJXbI6dRN4VJncaOYQriE/8n6q7zbo9tXmT+p591rsjuYvI
         EmZM2cYtJhIHITe/Io8XuIvXIjJ+fz8hXhQsaYBlgtMb7SIsu1shdcSvxioYP83RFtpq
         6nb4bOiPb9oJmRfh0lYQb/AmQSWtyVDEx/OINrKJVQHHb9bQneYcWOX48BD5xFeuZHlr
         htJNFQrfRHPNjVUC8dKiHqA0pkq56704bZtLJuu13954ybITIVaIfV4egVY5AahbdWZS
         hMN+TjUqHAYHntcAYjvCooLGpqg1PkL8gY+RUYwZ6RNAcV2da+6qZtjKp4gT3iZphpo2
         4O5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gK/BZ0CSIGck6yi9THWfQV8deFFMWvYWLYGtOVRdINE=;
        fh=awgHKwXhAnSpV8Dctvgqrm9MpSXDLQGyoO7bh7OqKJI=;
        b=ZI5q9JGZ88xn8kVX3K6KR4sUM3162p2+aJE4zWOqHJiNCzPDzwB7oYcCCbTJa/W/Gc
         SESHxt1hgyVpfaoZdYkPHUkxDp44w+ITFCLYSTbRR5Ratp8ypzxUUJ8iAoASecJDIeF9
         lRq2M/1TvHb5ohxXMZibI0HBqQVETOirp4cIyJqFNiYnab6K12s1jRa9g5gBEBw4wvXC
         jZ5joqSWRjOQyar2R2SlTMOhZ/lU/gEQxhFm7q8YTw2zWgfR19lOjTgZTImOM4g3WFSJ
         neVeMeFK0oG88HHl4T/cCMSoIJLgPxoFJkv+zsnkt5hY5rNMbDIfNf+kw6bXnkoNkYn3
         ijwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783539403; x=1784144203; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gK/BZ0CSIGck6yi9THWfQV8deFFMWvYWLYGtOVRdINE=;
        b=hj7mo7A8fUGL02vtGf+WjhcVOcPqf0R1gAB6A9YI5CY7jbCvxTE3sVIkWVof6Qrcc2
         3w1HhLTJGHCaJ3et8X/ap2GHRzkrSYi5ijzl15GyqfxugDR+IIPnWU2/b0bRmAwg5SXh
         UWn8vtjMuciEtYkJikeZD4eoCzMtERwgFiD8084oiJjPkoH0pUe0YaelyuMQ6uVb7qfc
         +d4WOjj5XLMBzBETaYgbqAYoVemd2dy/+9fB/UelUTgpA5U1wflxIklXkrCL0rt99+fe
         HB0FRgavIrtd8b4bB0DYJm3rIwGp6UzouyDKdJ4YWv4kf5S7BA04wLt8i21r+zqOdQvr
         JcEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783539403; x=1784144203;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gK/BZ0CSIGck6yi9THWfQV8deFFMWvYWLYGtOVRdINE=;
        b=J8ebfkfqcJq5SdUNqHdyckBM6XZ7x39mvC9UawO9s4x1EvlpdpI0APmvslham9zxjJ
         9TcaTBcuCtSwtycu6vh5nHuZXeoAq6+8f2sAVLV0b49UnNcPRcQ5DuV+EtXg8EpOZsEB
         3zfG5q05S4dJOYQ3OSWHhlB2lW7MART2S5Hb1Ph+yZvhK9BTgp44lw1l5CuyajXHoPK7
         XsGiqEKlc15YiSZITm6RXEfJmgjP4EvkUycMvDWva/XU7nWq0XsUoEUoklMNZygaSaEL
         Zoj1yy440AL+X3E2Rca8xJTej+EDtRdu7yRV0PJm63T2+zURtRauvd39ykRdzNvaolTp
         0qlg==
X-Forwarded-Encrypted: i=1; AHgh+RpAzRHwwsXQohen/heXw6vBVsJVFilY3taktp7XE5gXNJhenezi3sUx5uXOybl2aRR9DXQwvK0zByGcrwus@vger.kernel.org
X-Gm-Message-State: AOJu0YyAfGA4zWXkd7Zm+TB420tTGZNj0vXFkObZ4Fuw+4TXk3mnd9z6
	apJRTutU5KLpax5+6D7Bj+S+H5E/A6i9LTYm2aDMHYHeHFde7KgNneVyc0/Mk89Z+du32aErHrb
	Z5tvNiWAQVog9gTV7KAkx++DfPA1mBGF1u65B
X-Gm-Gg: AfdE7clzGcXp57iNEh1GxRUwAZ+i76mUIR+UKl/n90ab1yA/WhpmOlwadujXggRxqZM
	G2mcwqK8hjkltLZzTxHw2qGJrvwKoJecEGZVVwfFpBk/pg+fTkmr3zXmaKTwjkXDp/wp2VKFxQn
	k+Fk/i4BCrbgDzGX1BAZL2/abyI3GsUTIY6h8yNh3p3n7ON9LUoQdKm+ngDl3KHYe/5zQPrntw3
	zHNv3IGucS1MWd5NtTK551Gwy2s7anQaWGCRIjOWT+aIanWDKX1lh+jrcZ0hYfi/gRR37XzaT1/
	/zI5
X-Received: by 2002:a53:ac8b:0:b0:660:54e4:5db5 with SMTP id
 956f58d0204a3-6679f1d5e06mr2904765d50.56.1783539045228; Wed, 08 Jul 2026
 12:30:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com>
 <20260707-dd-maint-2-v6-10-381f3edb0045@gmail.com> <20260708022424.AC02F1F000E9@smtp.kernel.org>
In-Reply-To: <20260708022424.AC02F1F000E9@smtp.kernel.org>
From: jim.cromie@gmail.com
Date: Wed, 8 Jul 2026 13:30:18 -0600
X-Gm-Features: AVVi8Cds7DLaQyUd_VIEnr4Erq4jsgRR4iB7pa01JTKxLMrPiWW5nBrfdkHRCNo
Message-ID: <CAJfuBxxi8k25iU-6VKTTMQmMrFCmjhUq8oV5upkvj=yXdJi-zQ@mail.gmail.com>
Subject: Re: [PATCH v6 10/24] dyndbg: drop NUM_TYPE_ARGS
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 8:24=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] The newly defined macro __DDEBUG_ARRAY_SIZE is unused because the=
 array size calculation is manually open-coded.
> --
>
> --- Patch [10]: [PATCH v6 10/24] dyndbg: drop NUM_TYPE_ARGS ---
> commit 0ca0f4a344ab62c4d4df9c27a60daf65fecad136
> Author: Jim Cromie <jim.cromie@gmail.com>
>
> dyndbg: drop NUM_TYPE_ARGS
>
> This commit removes the NUM_TYPE_ARGS macro and replaces it with an array
> size calculation. The commit message mentions adding a new local macro na=
med
> __DDEBUG_ARRAY_SIZE to handle this without causing include conflicts.
>
> > diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debu=
g.h
> > index 9607121c3072e..9ae1accb9bf63 100644
> > --- a/include/linux/dynamic_debug.h
> > +++ b/include/linux/dynamic_debug.h
> > @@ -8,6 +8,8 @@
> >
> >  #include <linux/build_bug.h>
> >
> > +#define __DDEBUG_ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
> > +
>
> [ ... ]
>
> > @@ -122,11 +124,9 @@ struct ddebug_class_param {
> >               .mod_name =3D KBUILD_MODNAME,                            =
 \
> >               .base =3D _base,                                         =
 \
> >               .map_type =3D _maptype,                                  =
 \
> > -             .length =3D NUM_TYPE_ARGS(char*, __VA_ARGS__),           =
 \
> > +             .length =3D (sizeof(_var##_classnames) / sizeof(_var##_cl=
assnames[0])), \
>
> [Severity: Low]
> This isn't a bug, but should this line use the new __DDEBUG_ARRAY_SIZE ma=
cro
> introduced above? The calculation appears to be manually open-coded here,
> leaving the newly defined macro unused.
>

Ack. Fixed locally. Will resend shortly.


> >               .class_names =3D _var##_classnames,                      =
 \
> >       }
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-dd-maint=
-2-v6-0-381f3edb0045@gmail.com?part=3D10
