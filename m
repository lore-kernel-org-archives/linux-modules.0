Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA47211491
	for <linux-modules@vger.kernel.org>; Fri, 18 Apr 2025 16:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744994794; cv=none; b=e7EXxI0W+SZdv6if5eM7wJ2hMx6ClrHKjJT3MiNXr2O/5velAjP2OXwJRMzM3s8R/6krypUdbMRikRz6ei3H0iZhah8351WJ3Jpzvg/75V+CduOUq2kNPUrhoTCsW6WTFxWDxgQwW5xpeUTx3TY8F8ka0KhA3H2r9zMMp/yyi8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744994794; c=relaxed/simple;
	bh=B2O/Gspz1Le8Dpdt/hJq1P6tX6Y+3COZWoh3DyLF374=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EX0V50UsWUadkqHB7u5Cu1h+fskAOSPTknDFiqZdTCi2s3gzGByzrp3HiA2yfSNtjwen5Xmvo1EFvY74b2EMM8oYaa3GQzFeFgrnZw+KYY1SrBpWO1Zxj5t3L6ZdLTxO1Aab89CCGOteVLvUKFavNMqZCBO0naCjDLw4R8A992Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F9EHaAD5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F9EHaAD5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744994792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sXISLttdp4Stt1jgFUlPHh5G81JdIsLDJqti/qjxK3U=;
	b=F9EHaAD5iFtoz2vCEnXLlMtnpPdm3rVnPZPthUVESX7brdnAEosyd+XfWjgvnBoB6aYTkx
	UP1v3za2AGUARBKzgk9dZF7DUS7OPDeTfhJ6g9OZ4IXBmOOTOZewy036wxKD+XAUXIwAEq
	Jre6x+VX9i/ktFWgFLYR3W4qVL+coNo=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-JxOwZVY4M_yu4scF5KMSmA-1; Fri, 18 Apr 2025 12:46:30 -0400
X-MC-Unique: JxOwZVY4M_yu4scF5KMSmA-1
X-Mimecast-MFC-AGG-ID: JxOwZVY4M_yu4scF5KMSmA_1744994789
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-30c2e219d47so12025551fa.3
        for <linux-modules@vger.kernel.org>; Fri, 18 Apr 2025 09:46:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744994788; x=1745599588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sXISLttdp4Stt1jgFUlPHh5G81JdIsLDJqti/qjxK3U=;
        b=fjuith3XygTEl98C5T0HN5jsWRqbaDxqrUZjQlLHN3Fh4Atp31bRsshUPOmdNyrOCr
         k5Nd/teFP3VwgOBa/Ol0yjctTvHXUpzVNCxA32Ar9ddMGqNq0rxS/pva+LawrPNHBCmn
         nVJrPgllmqNfHhnCW4QI7bau4CSvaKK3yicXsaL4YXTOI3EbROAo9+7Lu4LYrfpS/xgx
         lBwrlKQSdh/+JdOGf2O2DqnldAve8Aly+PYg28ysPFBkgla4xAHvKVX0ValDo0F9RS08
         iIwm3OyydOF3YXwgr07WXiLvZO6dxFhQh87VX0GUUahwh/AzHZehQbSPpN4tjtNKU3FG
         3tPg==
X-Gm-Message-State: AOJu0YyR5OyCp6c49ACLFXzNk8XVfxr5x+SpMh/vMzxgZWVyWS3S/ewG
	bpNa5yr5r7Ks0FhFI2hnKgMQzYGLafqhEyKJxYAtI0ib15ZZ+9ENdHL9MbVNELmkZSKdJ8W3ETm
	zs8J33oiGUP4eewKR+GrSglC+DcI5BS35Ab8lg7f3ma1p2Jdj5XZLJf/L/D7ysyjpO2ajWoRuYR
	kdEhr5qwDLWrLmdQWY5bpcFsjiBoUbKnIypwL0T9tt0ys+eY8m
X-Gm-Gg: ASbGncvETYuh7yPchfYsnqgLrszjra2Bsr7wM90f8zhZTiaMSwbfXkrqK/GuhAPxxF4
	2SsiJN5QVo9M0F2qshCndCaJff1Ms1Q3FOLihyn8Q6/EqXgJBlbaE4k/tU5Mxaq60TjcgnV22BV
	Y6Euh+C+jrTcAMOTRVoitHdCGHog==
X-Received: by 2002:a05:651c:884:b0:30c:518e:452 with SMTP id 38308e7fff4ca-310904dafe3mr11403541fa.13.1744994788111;
        Fri, 18 Apr 2025 09:46:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFC8XRPOnxIuvHQdgVNgUalUWGkmYje20l8oa3eP/0kCqW28Zy4fKraow99TA0b7uAR33mRN5OeXt86kGaQflc=
X-Received: by 2002:a05:651c:884:b0:30c:518e:452 with SMTP id
 38308e7fff4ca-310904dafe3mr11403491fa.13.1744994787751; Fri, 18 Apr 2025
 09:46:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418000834.672343-1-herton@redhat.com> <aAGZe_mDBZ7DcG2o@bombadil.infradead.org>
In-Reply-To: <aAGZe_mDBZ7DcG2o@bombadil.infradead.org>
From: Herton Krzesinski <hkrzesin@redhat.com>
Date: Fri, 18 Apr 2025 13:46:15 -0300
X-Gm-Features: ATxdqUEZOONVcWteu9JX-s24qC2ILTT1BAu4NXZrhJH4HWLz_YH7IazkwItI_Do
Message-ID: <CAJmZWFFhqGv+gu2BmZZRKxELDoOLyjXdn-UQuU6CAZ_JZP7UHg@mail.gmail.com>
Subject: Re: [PATCH] lib/test_kmod: do not hardcode/depend on any filesystem
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, petr.pavlu@suse.com, samitolvanen@google.com, 
	da.gomez@samsung.com, Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 9:14=E2=80=AFPM Luis Chamberlain <mcgrof@kernel.org=
> wrote:
>
> On Thu, Apr 17, 2025 at 09:08:34PM -0300, Herton R. Krzesinski wrote:
> > Right now test_kmod has hardcoded dependencies on btrfs/xfs. That
> > is not optimal since you end up needing to select/build them, but it
> > is not really required since other fs could be selected for the testing=
.
> > Also, we can't change the default/driver module used for testing on
> > initialization.
> >
> > Thus make it more generic: introduce two module parameters (start_drive=
r
> > and start_test_fs), which allow to select which modules/fs to use for
> > the testing on test_kmod initialization. Then it's up to the user to
> > select which modules/fs to use for testing based on his config. However=
,
> > keep test_module as required default.
> >
> > This way, config/modules becomes selectable as when the testing is done
> > from selftests (userspace).
> >
> > While at it, also change trigger_config_run_type, since at module
> > initialization we already set the defaults at __kmod_config_init and
> > should not need to do it again in test_kmod_init(), thus we can
> > avoid to again set test_driver/test_fs.
> >
> > Signed-off-by: Herton R. Krzesinski <herton@redhat.com>
> > ---
> >  lib/Kconfig.debug |  6 -----
> >  lib/test_kmod.c   | 64 +++++++++++++++++++++++++----------------------
> >  2 files changed, 34 insertions(+), 36 deletions(-)
> >
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 9fe4d8dfe578..1e0f8cbf0365 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -2983,13 +2983,7 @@ config TEST_DYNAMIC_DEBUG
> >  config TEST_KMOD
> >       tristate "kmod stress tester"
> >       depends on m
> > -     depends on NETDEVICES && NET_CORE && INET # for TUN
> > -     depends on BLOCK
> > -     depends on PAGE_SIZE_LESS_THAN_256KB # for BTRFS
>
> Please read the commit log that added PAGE_SIZE_LESS_THAN_256KB, what
> do we want to do about those complaining about that? Maybe Cc the
> author of that patch.

afaik that problem only happens because of selecting BTRFS. Since I'm remov=
ing
selection of BTRFS now it shouldn't be a problem.

>
> Other than that, it looks good to me. Did you run the selftest?

Yes, I did both load the module with force_init_test and without, and
run the kmod.sh selftest and arbitrarily chose vfat module for fs test
(in my config
xfs is loaded/used and ext4 is builtin).

But now I noticed that I forgot to update
tools/testing/selftests/kmod/config, I'll
send a v2 shortly.

>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
>
>   Luis
>

