Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920F1E56F
	for <linux-modules@vger.kernel.org>; Thu, 27 Feb 2025 00:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740615467; cv=none; b=bStM9/xWkSz3QSWU6nQ/kgD8H0FdEl796m7lxl2hxgzDAJS8A7Z5YHjklHyydvbUt2qeylXB+f4opzes3n8uutFeeN5asnq+xOsIxN3Hxw7wKKZVR05+ycI/zvFncrJtDMEBBfqa5PC+EbTB7gLboXFrr56DrjV8KnNGpCAM8iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740615467; c=relaxed/simple;
	bh=95vP5oO74tokr4BkurE5S3y21f+wNnfjDr7XC/BGAU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vEWWgYwfVxUGm4/xa0SaFMDPBXA0M/qtIvC35y5NwizbmzsWAF/DFpdvwezdSozqi7bJpaq9Ep6J/i3UPgLGjeOQMahYEn9POhkN78PoVvlJ9cxJb21LGMd4z4n5P9oVMtV5bLDOBoNotqPhI2dM0ZFvoRtDEF9H3j2pAUyHCX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=c4eBt2l8; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="c4eBt2l8"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6f679788fd1so3353647b3.2
        for <linux-modules@vger.kernel.org>; Wed, 26 Feb 2025 16:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1740615464; x=1741220264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/8pOkRdkavFiHcWKEd5sA0HUSbssEIq4tj0O2hK2RA=;
        b=c4eBt2l8CbcJoRlKyyQ/cjSlxKK2oBfQVCWZ4Pu48hjjJck5HoE/BGWQmHzcWE4p66
         tUDyP+XoGeHYNu57d2p/Lnl02I1KdGq3H19EuIS4gY4gxiw1CJXR64hzAUf6nOf5Sezl
         L1GKVmLl7miRsh0kxbvRZMVwZTSM7yD6L6266gCs0+LBVtO+AZkq0zuq9hJ5IBgkglAn
         k5gtL7vObIGfQbEXZ0oqX3pgnh4zTGK4/SFYr8x+Yey0txrlwR1XZeItx2Z9Vk8idc8S
         D68HMmHwWcACdYbj1ox3ZswNQcVxGiKUsJZA+XW7awr70U/9xY71z4M2FoKJRrOugXAM
         45CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740615464; x=1741220264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J/8pOkRdkavFiHcWKEd5sA0HUSbssEIq4tj0O2hK2RA=;
        b=qfmJ8L++CKwmPk5pCe6EvFoD6rLKzTSmMoX0eM+DHlzOQD8dS97NaFbt+dBXYuCJin
         ZeaOaH4tKtobcgMji1oveoCZgO8WY8E170ZMH6iJ37qExTGGJ4HNXgz3blA13rxDKEzs
         ysuSAmbGi6ecTzmQwPzT/2vgOAZupSDRtOKW1eztlmrKQReC+XqUDN5Fe+AFcexhW4gy
         ihYoTM0kXH4tvCVITrxHMkPiBQ6I/R0OwajOlXJWnysfkurqIUyIlmMNVYaDua9ef1GJ
         8dcWwT4ywZLaPUdx7MZCfmdfz22kFZhwRxwo4cA7YAobXKxknZi16FxHVAiHYCh4pBPl
         y/Hg==
X-Forwarded-Encrypted: i=1; AJvYcCUeBA79LFXWr3nnqHNrViP1vxVf+uIsl8KP19SxTfHq052EwGqJkAWPcDa0Rqld5NcY3tCPliXvvBGwpTAx@vger.kernel.org
X-Gm-Message-State: AOJu0YyeJc3/54V73MBX7AoGYIcWdr+ffqEvM/NcDBRwH33iwanaXK6O
	Wq/KNyzWAXcGwcZiCm3fWHVy4mQYthj1bsA0xZXxdq0kCqZ6ojJiRHyQoRbFPmy94aTL+TIHg3T
	dFo2MnjeX+erPdsbYQlpIveNc5gFbah2PSbuZ
X-Gm-Gg: ASbGnculG2P6UazLyOtwFMJ3zRo5GGQuOaOuYJORfJXGASVAWOz4nwi3986ZbCDwrgB
	UcS9jKNgJ1d097G2izEI/7bZTsz+NaRG1ZMzTZyO4k09MNdqQsCch9ADOWIjqXaM8GQdCVLn1yw
	Agzakego8=
X-Google-Smtp-Source: AGHT+IHe4X02T2euH7liqYMP6jiJfMZtT6v1W3CIFOciiH/l39472KYlGO244KC2IT1ddKL6wDC2WrqJNGGfRmugYAg=
X-Received: by 2002:a05:690c:6201:b0:6fd:2fcf:1323 with SMTP id
 00721157ae682-6fd2fcf1784mr39373967b3.21.1740615464498; Wed, 26 Feb 2025
 16:17:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250114161729.77142-1-arulpandiyan.vadivel@siemens.com> <CAHC9VhR8Ny3McMo7ZDw06ry0VdUHEQcym8yvSJHdYdUUoVMAKQ@mail.gmail.com>
In-Reply-To: <CAHC9VhR8Ny3McMo7ZDw06ry0VdUHEQcym8yvSJHdYdUUoVMAKQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 26 Feb 2025 19:17:33 -0500
X-Gm-Features: AQ5f1JqyY6G7naGSxupk9C14H3Zkfd_SH7ynbGHRa2yBgJJ7pms3QzIzx43eRMQ
Message-ID: <CAHC9VhR41PLeO-TZvDt8jM2j5oDr_VyHPmsWh-B0ND4Ynot4HQ@mail.gmail.com>
Subject: Re: [PATCH] loadpin: remove MODULE_COMPRESS_NONE as it is no longer supported
To: Arulpandiyan Vadivel <arulpandiyan.vadivel@siemens.com>, Kees Cook <keescook@chromium.org>
Cc: linux-security-module@vger.kernel.org, linux-modules@vger.kernel.org, 
	cedric.hombourger@siemens.com, srikanth.krishnakar@siemens.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 10:20=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> On Tue, Jan 14, 2025 at 11:16=E2=80=AFAM Arulpandiyan Vadivel
> <arulpandiyan.vadivel@siemens.com> wrote:
> >
> > Updated the MODULE_COMPRESS_NONE with MODULE_COMPRESS as it was no long=
er
> > available from kernel modules.
> >
> > Fixes: c7ff693fa209 ("module: Split modules_install compression and in-=
kernel decompression")
> > Signed-off-by: Arulpandiyan Vadivel <arulpandiyan.vadivel@siemens.com>
> > ---
> > Changes in v2:
> > Reword the commit message
> > Modify logic and add Fixes tag.
> > ---
> >  security/loadpin/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> For what it's worth, this looks fine to me.
>
> Reviewed-by: Paul Moore <paul@paul-moore.com>

Kees, did you ever merge this into your LoadPin tree?

> > diff --git a/security/loadpin/Kconfig b/security/loadpin/Kconfig
> > index 848f8b4a60190..d82bcdb34cc8a 100644
> > --- a/security/loadpin/Kconfig
> > +++ b/security/loadpin/Kconfig
> > @@ -16,7 +16,7 @@ config SECURITY_LOADPIN_ENFORCE
> >         depends on SECURITY_LOADPIN
> >         # Module compression breaks LoadPin unless modules are decompre=
ssed in
> >         # the kernel.
> > -       depends on !MODULES || (MODULE_COMPRESS_NONE || MODULE_DECOMPRE=
SS)
> > +       depends on !MODULES || (!MODULE_COMPRESS || MODULE_DECOMPRESS)
> >         help
> >           If selected, LoadPin will enforce pinning at boot. If not
> >           selected, it can be enabled at boot with the kernel parameter
> > --
> > 2.39.5

--=20
paul-moore.com
