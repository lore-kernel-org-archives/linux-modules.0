Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C4130C162
	for <linux-modules@vger.kernel.org>; Sun,  7 Jun 2026 20:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780865075; cv=pass; b=EfVP1DDLn/EFzz+P2AHRAKfoi31AKYMsArJb+Byn3XkttNdE24NRtYM+ugd56H8V57ow1zCcLSvA9uioJf5M0CMw4lPVWnaqHWRXpzCu1kX8eEKPYqYTJwZKbnMaqCBUZgId92ljNL645rGYqPX+o9fZnWZWkjUnX9otNuJTelA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780865075; c=relaxed/simple;
	bh=KN1F3bd0TQ5iup4dFP//scSZCORGiAVnFHhUKNhcnYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lZ9ke0l5RzYAtvnYdhO3CTEUWqL04NGMZ92wxARB6TcXMDXXOjie9ux4muuZCtMZF/NoJprBV0z9/m7d72/+EQBXYiwplUl7lXDUwuWIFZNw16fYlSMDQRARWkQpJG01TA0eiHseWY3Z8TLviVP1O4xU/ldKdY7lMxfyXVcqh9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/3MD3KP; arc=pass smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/3MD3KP"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-9157b94a07aso463696085a.0
        for <linux-modules@vger.kernel.org>; Sun, 07 Jun 2026 13:44:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780865073; cv=none;
        d=google.com; s=arc-20240605;
        b=bQ2oVqb0t2m0FUuOuf4NC+9om/WMjeNa3QGFw7A7K6qtsqQVa/0avaF9hG8H4Gv18L
         P4WJ3Fwm0I2U+WNl8XxWUDiViW6KM5HFy+yJVIo3d/mrELiJo/fsNgcdOn708Oy4kVvm
         FNnjXsEeZzq6N6SlSLfTDW+RtsVK983aM8YJCEakMr8VqLs8013uya4Jy81p1iA6+XC6
         t17fwPMKsuW3YLBZ8IcWr95whfiZMhSRk9MDu13gsZBKH8RIn1Vns1dw5Dj5RlEA5gI0
         mDCSs204+Ku6dLGgiTUMKskGLpLJgDa5kknq2sQ578TQKO4nbgH3BxE3rbXF69ObNwoy
         61mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zcJ1FGMLWiaXBW7omqcJ0jfGqRFeWks+49Sn79+dB0c=;
        fh=Q79oKEuY5zsnIWMGYT8+i787F1aWGDNgQBZS5Sokh1s=;
        b=GXLJu3JKMktMKhv02HP9m2xzT1C7botJtfevfzYDT7FJAUSxE8619LVu0AL4uZdVd8
         KzF1DP1/6GowYFgpckQ97z/M0E5UFJ12FMZdprBpy3e8ZhOr7+r1YshLW1k0DES834lJ
         OmRGLf5GQ5UT/amYWZlXXDTdyjxHpgrlOj5bHUjIkaJzRtN0ffb+NwalMySDxg5ptNHt
         Fhywg6rXKUm+1rVIpV4MOr5y1y/R/1yqjQNt9LyAyEMgVLcgoJEJPMQlabBxQMumypyv
         aYr3emruDtzQzy/FmvKE9UJpx1Kf5C5iYf9zed5Tv7iRUkBHsSytR2FjcvlW/B1eQBmC
         6p7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780865073; x=1781469873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zcJ1FGMLWiaXBW7omqcJ0jfGqRFeWks+49Sn79+dB0c=;
        b=P/3MD3KPTXGYQdjC4UeCyL/nZl8d2bZ1oUexqW2GlznAwJAyuNjNV38Kl797Pxas/i
         iMtoqpY8lzrny+R+YI7qJtxAAXrIC3ssWYN/e+4EZBHd7HNfBIIfy00t5+Ov85vEeocS
         v+nM+sHDWW/Wl1GSO9KhscJ7WFJepk8jwx07rBJqz43UH5jIVvaTco9QLizYSzg3kKoD
         FP2p/s9LSRj7STKPcNyvqdkWhvW107Q02RkGAYT9coMAePSaU0Epy97WuuEBuoT9AkLW
         Of3/Mo6HaloyO1Jws8o49vETJFxYj8IM9a1kh8e6wFT50UOvkp3SojSrnQlnaNWKIQGn
         LKTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780865073; x=1781469873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zcJ1FGMLWiaXBW7omqcJ0jfGqRFeWks+49Sn79+dB0c=;
        b=JkF1//eIGLgD+8/UyxVuxIAK9yw4y8pTE8Qul9A2ssGTAcVtWPGwrTAWy/g4l8dv83
         9oHGqFT0KJz7RHQpX4g7OOZQN3T3V1ryvHpaVe5Z+TcrOsOPh3CMniuv3D6MW3jPQLOT
         OGXfAvFT652Ot29au5m7pFN0AL+vA2xzlcL2tNu47pk/BERLB96lNSeRb7Zq4GXaXQNI
         m6L+zlty6LgZzNm5LtHIwTZnHfK9WXNGORTUBgZ4d/mCenZcp+S7DuWkKUBMYKV7fgIA
         CBCVzs+tJbnyEFyuQ1TLVlKvCjqwbAT6pr0J7VnTvGC12nJTQscOGLbI6RhgCDGnpXTn
         VqjQ==
X-Forwarded-Encrypted: i=1; AFNElJ9YCEHz8mhR2KWRTyMesAWjkDp0H9xM50Mq094NkNE+0M1U/jC7CK9J8xM4Uotru73imNSrBFghv+tf7Gv3@vger.kernel.org
X-Gm-Message-State: AOJu0YwMetj2RZR5ZCS3ntcdB+6CGa1r4XnlzKmz8jvcZo2cl85QjfEM
	0jzgJzW8rzKjix2LZo4q/QLQl00GqPria39k7Bn7UK2cbK6n6PCIJMPBmNnSnSgBuAOM/LcsEyh
	4AOKekdohiSMCvwJWnRyIKBeGzguXzhM=
X-Gm-Gg: Acq92OG9ti9LP4iFXB0dRw6uTK5xWpDJz9fa9DK6E61Yw1lC4R+8pEj+UZlJBZrA+ZS
	lZYfznUeVJNutIfvetz+p7LginGfzxtGjyu9UzlgNUEfU1DbuEr8tZosM+fM5iX9qVMfQeO3ju3
	uBO1iI8yI3MY/QPCZM6Yk4PkfWR6d67HF1LRUeoE1xc8lCTx/0BdK4XdR4PsDn/IlhCJpFSF2JR
	8pCRAZ2wpPDtAX74v4/7koBP9erH4DOZLpGy5EH6wh7lIGqpoFyxWHoapvc81d8MpUvSpHsUw/9
	uszl8e09irLXzYBzqQqjuKIzL7KrXDYzMvoX7iWwfQBrhioMMgXScCBzX3XK/9wZQ61EpKbdSLk
	HOL8I9BHd/GL6KNHC8tBAVAURVagUXn6GSDsi
X-Received: by 2002:a05:620a:410d:b0:915:70b5:b204 with SMTP id
 af79cd13be357-915a9df7c6cmr2144608685a.54.1780865072826; Sun, 07 Jun 2026
 13:44:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604110455.1608038-1-petr.pavlu@suse.com> <20260604110455.1608038-2-petr.pavlu@suse.com>
In-Reply-To: <20260604110455.1608038-2-petr.pavlu@suse.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sun, 7 Jun 2026 13:44:21 -0700
X-Gm-Features: AVVi8CcpynFClfuEAaqP1uLDWMw9ic4YglNbLBUGiNbd7XhW0lgdYdjcOJPqYxE
Message-ID: <CAMo8BfLko+NZ4HVwjmPgUny3_LM4qBp+vP0HsX=315mra=p+-w@mail.gmail.com>
Subject: Re: [PATCH 1/2] xtensa/simdisk: Avoid referring to module::args
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Chris Zankel <chris@zankel.net>, Luis Chamberlain <mcgrof@kernel.org>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Matthew Wood <thepacketgeek@gmail.com>, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 4:05=E2=80=AFAM Petr Pavlu <petr.pavlu@suse.com> wro=
te:
>
> When simdisk support is built as a loadable module,
> simdisk_param_set_filename() receives a pointer into module::args and
> stores each filename pointer as is.
>
> In preparation for removing module::args, update the simdisk.filename
> parameter code to copy the provided string. This is somewhat complicated =
by
> the fact that simdisk support can also be built-in, in which case the
> parameters are parsed during early boot before slab is available. In that
> case, the command line itself is preserved for the lifetime of the kernel=
,
> so continue storing the incoming pointer directly.
>
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> ---
>  arch/xtensa/platforms/iss/simdisk.c | 38 +++++++++++++++++++++++++----
>  1 file changed, 33 insertions(+), 5 deletions(-)

Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>

--=20
Thanks.
-- Max
