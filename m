Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9311802DA
	for <linux-modules@vger.kernel.org>; Tue, 30 Apr 2024 17:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714499331; cv=none; b=UJM1XwG4bz/5iTC2jIQ7fbjT+DNRwTUc5oLCcbwmXhtlVSyTKXtqt4eKPmEIXl8axl4QRYd5XDYXjYo9zEvQ5XKSJc+p8HucJ3UUP9myZoCGhVG0dpoDDT4tWegypwfbNlqTSmdGIguvaYCKiC5IHANnaaUBUa6sIEbyCT+PNyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714499331; c=relaxed/simple;
	bh=4d6vB+R2kumOfYgumQoUnu+DRAVWlzK2/8JYhK0cqgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LF4hu38/Q0AwSfftIeFTlWWJL9WHSPVI8wa6WqNLE4rQsSLGhcpGGKezY4i+rIiQ4XkYkPx7z8GcQVp+dimqJrcCB6GHBuYLTk8gS3NGIzRZjQH7ieZDlLkKngWgDAgoojh8EG8+RQA1Z6ewnAPEQJcm7h7mjYtnHDTmLqaK3aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yf0ID8D9; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yf0ID8D9"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-de54b28c41eso6778092276.0
        for <linux-modules@vger.kernel.org>; Tue, 30 Apr 2024 10:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714499329; x=1715104129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XhPAOUlC/HHaThomD14/OgR4UH5kJYHjCuFzfGbjP60=;
        b=Yf0ID8D9Qe+2xXe16TC8qOvXRJujgaDMxksO2PnZNZrxhQbht6tBpeOUIK38IKjK25
         VHfJBxyU/0dFoAtjSOpvoJFA6ZlONwB8rwLuXsEawz7tkQw56pgW93LkK5SkftcO/9pD
         JxUMBWkzEPWq+5H78iBlczwnbpivHiCvHgKu+gvX03CXs7a03LU6UBRxYkxnrivrsc6X
         zuqPh5m82mn2m2MUNIfRrJuyR5g+2UPfldZLqnflXzit/0/yxPfBFJtHzeMY1+87b8K2
         GDoXKFq3uoy9JFSxqKoK0NNPLactC605kpUzYklLvTSzoe3cVO5U+ilOOX3VsnEizlnT
         qxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714499329; x=1715104129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XhPAOUlC/HHaThomD14/OgR4UH5kJYHjCuFzfGbjP60=;
        b=cG7AtuJnuxWN5gLgmzlHmCuy5F4Gldy9sdoBOxneRuoPs1+GUJcPl0nErsilkM/xNV
         hBjrjr+1dhvQDrOWEsvjkY3O1tYFid/NW7nkIqkTLNvH2F704wDR5DG/5gwnmmK1eJsx
         iNwC01U3Lgh1XuaRGKtijh6fULWFtX1XYQFC4YPM/+uPatWoiHJumjVRtYD53P73MNaI
         ux8Ov8G9hfhJQmAvpXFw7dLvLCJrjVpgSUlDjm7rZqOvy/U/MNeHKFpH1zO6iQtoWdX+
         tufl+tf3oCj/myIP+aEPJr1zHAVanNRqs46xDXjl6i74ANo1CjlPnAfwS6+a/dJSpdcS
         wSXQ==
X-Gm-Message-State: AOJu0YyV/wVJvyGaU80zvyQrGq8HaPwmD+JcFMQ9Vnv3KO8btE86N42I
	+8Iz1WBa5gulBc7qQGNVTYM5mkzYy5l6nYlnHXBhA3t1/lQnYz0r9Fip8DCD6OsHjbMvZHeDgLF
	78195wZReYuOTe3wYpOy0sqbRPte1kcz8
X-Google-Smtp-Source: AGHT+IGDog9rlq/82ZXw+pCAUd1DasmhZQ/xgJhpUTFtjAXJXGbFYKbAGU3HO7ojD/cYn4ZlP6o/xpImkJXxc7qtxr4=
X-Received: by 2002:a25:818e:0:b0:de5:4ed6:d3f2 with SMTP id
 p14-20020a25818e000000b00de54ed6d3f2mr309269ybk.20.1714499328514; Tue, 30 Apr
 2024 10:48:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212-decompression-fixes-v1-0-06f92ad07985@gmail.com>
 <20240212-decompression-fixes-v1-13-06f92ad07985@gmail.com> <4gbaobiwemc4y6ztn7zxbn3ztxc4jydqjnpsbcfp2ejhaanu2u@cjernf4wylda>
In-Reply-To: <4gbaobiwemc4y6ztn7zxbn3ztxc4jydqjnpsbcfp2ejhaanu2u@cjernf4wylda>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Tue, 30 Apr 2024 18:48:36 +0100
Message-ID: <CACvgo53FvP3=EFvzU=kzf_g3-EGXS0PBiS76yLhFvV17FqQpEw@mail.gmail.com>
Subject: Re: [PATCH kmod 13/13] libkmod: always fallback to do_init_module()
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: linux-modules@vger.kernel.org, mcgrof@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Apr 2024 at 00:39, Lucas De Marchi <lucas.demarchi@intel.com> wr=
ote:
>
> On Mon, Feb 12, 2024 at 05:23:14PM GMT, Emil Velikov via B4 Relay wrote:
> >From: Emil Velikov <emil.l.velikov@gmail.com>
> >
> >Since the direct loading was introduced a few bugs became obvious that
> >the compression args used were off - both in-kernel and dkms.
> >
> >While both of those are fixed already, not all of those have reached all
> >users. For example: for dkms I'm aiming to do a release just as kmod has
> >theirs (to align /lib/modules <> /usr/lib/modules support).
> >
> >Although I am wondering if we can indiscriminatingly callback to the old
> >do_init_module() in all the cases. This means that we'll catch any
> >in-kernel decompression issues - invalid args, ENOMEM, other....
> >Although for others (wrong magic, perm, etc) we will end up doing the
> >exact kernel work twice.
>
> I'm not sure I like to repeat this for any error. Example: if we get an
> EAGAIN we go and try again?  When thinking about the recent in-kernel
> optimizations to stop loading the same file again over and over, just
> doing it again seems like a wrong approach.
>

To be honest I did notice the optimisation work in the kernel, but
wasn't able to quantify its benefits on my end. =C2=AF\_(=E3=83=84)_/=C2=AF

The most wide-spread issue (incompatible compression arguments in
kernel and dkms) has been fixed and new releases are available. And
other triggers do not seem that common/likely. So deferring/dropping
this patch makes sense.

> >
> >Overall the trade-off seems worth it, so flip this.
>
>
> I'm not sure. I will keep this out for now and apply the rest.
> +Luis too.
>

Ack, thanks o/
-Emil

>
> Lucas De Marchi
>
>
> >
> >Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
> >---
> > libkmod/libkmod-module.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
> >index d309948..2c0d46d 100644
> >--- a/libkmod/libkmod-module.c
> >+++ b/libkmod/libkmod-module.c
> >@@ -980,7 +980,7 @@ KMOD_EXPORT int kmod_module_insert_module(struct kmo=
d_module *mod,
> >       }
> >
> >       err =3D do_finit_module(mod, flags, args);
> >-      if (err =3D=3D -ENOSYS)
> >+      if (err)
> >               err =3D do_init_module(mod, flags, args);
> >
> >       if (err < 0)
> >
> >--
> >2.43.0
> >
