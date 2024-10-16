Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F2F157490
	for <linux-modules@vger.kernel.org>; Wed, 16 Oct 2024 15:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729092676; cv=none; b=GEP7eJXCwAb1DvlAjRKpYGwt9dpQ+OqOsPqFpacK6/ChBy0Hh58l4aaAe8jkWiB7M2x2VKJZ1IC6pOu6nW7/w+ilhHITfZ1qvQlTryBdfkGGFx813PDNUpXvxCvANIoH2DMnqYlliUnfynfG8SfQAJjkVCE4g2zOX2eCMyOBEBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729092676; c=relaxed/simple;
	bh=AOxl2wh5CifbeV75OtFSnWg0hVwy8Qulf/lxjcWEdE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CU1+RATKefickVp94VRFR3T2OrPLovWd1lvCzW0OMubLwwLYrmj2U1KVGWG2aNm3BKMzP1bMZgj1Q4qdpJX3pTJLnAlANg78clXuIlPUA8lLPePT4E65fdI2O9U9m2/iBiAwww5llVv3azNldnvIL/xry5aTg/aY8GkT7w5vSX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UPHqVg1D; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UPHqVg1D"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-460969c49f2so219431cf.0
        for <linux-modules@vger.kernel.org>; Wed, 16 Oct 2024 08:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729092674; x=1729697474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cNH8n7vAXNpqv161ekyIO/QtlJw3I0M1vcXsx9q3jBs=;
        b=UPHqVg1Dg4HseRGTELeNuilObArfTQoEmXEEoL6XWq5cKGkCAH1TUplec8Gx4IexmY
         5yLTUcMtlZVjNqy8paLPlyWqnuDdkYcSxZWFm+9zY6vdv95XFsSG7g1b3invxUwV2Z9W
         I4aMihbqT2nvFWm5/9SaCVjqRSepGqqVTBwSbK36dYqPvl4jx2X6rW/vJ24B6LaSontn
         bvzkGYtJ1OK9IorqFGoyUR5PBOdu6EVyFxP3tCfxh31GFwALmyQHz06JNqUsNW/lYx56
         RxfunDblqZ1Ov4SPHM+CbWVbTP8DemyZ9BEoFWj4qL6JHgIFrdPSMi7oWsWsZOKgZaxm
         DsQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729092674; x=1729697474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cNH8n7vAXNpqv161ekyIO/QtlJw3I0M1vcXsx9q3jBs=;
        b=fRzqTOmXMbdosUO8SPVbjRZK/ZxVZ5AGnU0k9oi9vAR/pqRNlTm/mFbCQFe8Lq7H29
         RSjFfRemkjGUgiiEJMBBw0Lkw57gWc8+vQjTHv6FnCZ7uw3XZLImm74zE17N3RC0KxtY
         GIkU8nIwqvlWTumnru9CNAav8CgVjXE+ARKqMjLjiNaKdnRUokT/AkI8KvqEmkX+OoJI
         8PRRQcm5wakSLkSgtbt4cf3QMTuVFLO1T9u0oMbyipgI2BujY99UTH4nj2nuNWY4fDA5
         jeCt6wOz/rTe4EnQLc6bPvBTFlggt2fXZSYPjL4IsI5m/PJAcKEafenJ9MEI7n2HDjBI
         EJKg==
X-Forwarded-Encrypted: i=1; AJvYcCVgX161A0HSJirCsslSCHNTfs6wosv4CBChV064sywsQAlO2f7JmjLmc835A15pCKXITHqCR7xZP2u/aGLs@vger.kernel.org
X-Gm-Message-State: AOJu0YySmGphWgsEJXMQb6LKNx3rDVD7ouSBTgUXXcvFXZz6Gm6hgrjY
	5ziOzmXBE8xGCWVX3t9wCrwd4kC0kflAwcs7MHz9539Ex+pz6GZVnLGQpJ4XiKben5gLkCPiVb3
	VSKVplqovcdOuYHl8UO5zRMkqg1+r1b8jZYbD
X-Google-Smtp-Source: AGHT+IGudMHXsmYGzzbu6wtwlVBO8hVujna9DcXSZGz9gZBzYtahTCs4wrRVyVY5zJ1Yb7n2KSm2tObymWH0InDaTYM=
X-Received: by 2002:a05:622a:468d:b0:460:47af:e3c8 with SMTP id
 d75a77b69052e-4608db3511bmr5992071cf.4.1729092673380; Wed, 16 Oct 2024
 08:31:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <52ee32c0c92afc4d3263cea1f8a1cdc809728aff.1729088288.git.linux@leemhuis.info>
In-Reply-To: <52ee32c0c92afc4d3263cea1f8a1cdc809728aff.1729088288.git.linux@leemhuis.info>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Wed, 16 Oct 2024 08:30:34 -0700
Message-ID: <CABCJKuf_s54EhYO1-j20VgHGC8AJ44cug6773XZ673eukUsLxA@mail.gmail.com>
Subject: Re: [PATCH v2] module: sign with sha512 instead of sha1 by default
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org, 
	Masahiro Yamada <masahiroy@kernel.org>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thorsten,

On Wed, Oct 16, 2024 at 7:18=E2=80=AFAM Thorsten Leemhuis <linux@leemhuis.i=
nfo> wrote:
>
> Switch away from using sha1 for module signing by default and use the
> more modern sha512 instead, which is what among others Arch, Fedora,
> RHEL, and Ubuntu are currently using for their kernels.
>
> Sha1 has not been considered secure against well-funded opponents since
> 2005[1]; since 2011 the NIST and other organizations furthermore
> recommended its replacement[2]. This is why OpenSSL on RHEL9, Fedora
> Linux 41+[3], and likely some other current and future distributions
> reject the creation of sha1 signatures, which leads to a build error of
> allmodconfig configurations:
>
>   80A20474797F0000:error:03000098:digital envelope routines:do_sigver_ini=
t:invalid digest:crypto/evp/m_sigver.c:342:
>   make[4]: *** [.../certs/Makefile:53: certs/signing_key.pem] Error 1
>   make[4]: *** Deleting file 'certs/signing_key.pem'
>   make[4]: *** Waiting for unfinished jobs....
>   make[3]: *** [.../scripts/Makefile.build:478: certs] Error 2
>   make[2]: *** [.../Makefile:1936: .] Error 2
>   make[1]: *** [.../Makefile:224: __sub-make] Error 2
>   make[1]: Leaving directory '...'
>   make: *** [Makefile:224: __sub-make] Error 2
>
> This change makes allmodconfig work again and sets a default that is
> more appropriate for current and future users, too.
>
> Link: https://www.schneier.com/blog/archives/2005/02/cryptanalysis_o.html=
 [1]
> Link: https://csrc.nist.gov/projects/hash-functions [2]
> Link: https://fedoraproject.org/wiki/Changes/OpenSSLDistrustsha1SigVer [3=
]
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> ---
>
> v2:
> * use 'default MODULE_SIG_SHA512' in the "Hash algorithm to sign
>   modules" choice instead of resorting the entries there.
> * rewrite patch description
> * drop RFC tag
>
> v1: https://lore.kernel.org/all/42aa307d7ffae1851b4a8787f5c276dd0b3beece.=
1728543368.git.linux@leemhuis.info/
> ---
>  kernel/module/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
> index 7c6588148d42d3..0c746a150e34e2 100644
> --- a/kernel/module/Kconfig
> +++ b/kernel/module/Kconfig
> @@ -231,6 +231,7 @@ comment "Do not forget to sign required modules with =
scripts/sign-file"
>  choice
>         prompt "Hash algorithm to sign modules"
>         depends on MODULE_SIG || IMA_APPRAISE_MODSIG
> +       default MODULE_SIG_SHA512
>         help
>           This determines which sort of hashing algorithm will be used du=
ring
>           signature generation.  This algorithm _must_ be built into the =
kernel

This looks good to me. Thank you for the patch!

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami
