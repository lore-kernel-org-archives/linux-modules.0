Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D8B13C816
	for <linux-modules@vger.kernel.org>; Sat, 19 Oct 2024 22:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729375831; cv=none; b=BuLlHXb6DuIxOJe09nwTRk4R2DIPmpNBk/fr/0AGmE2omX2wFtFZoKhrOeBx7tNaUCdp+acvUtkLNwBKeZu34tIDQmGx0Cw1+GyHCEa+MBe6SVhAMoLvsq8zyJ0wNx05JaHdnki/MPdxVy0/GNzY/VXS3vRxXIAUR0ivKcplIcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729375831; c=relaxed/simple;
	bh=E8yJAGA+WXseiASrATVpEUc4a0ztnM92be1wv/hrwuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VLDjeIf83LMcfpajX2a5iSxPjWun0iRZKWSrb4DDrMymZeVIQNyRWNNF06UL3t93F5ZrxMJa3pr1qX5J2wfNgjf/Z1txICP4WZBF9FNR2qQEnKiRV4bxoIT7ayH5Vaoix4WOxcbdP9EOjqXfWT+8X3y9AAxTb7topbv50h9fyv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I66R7ST4; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I66R7ST4"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539f72c913aso3897329e87.1
        for <linux-modules@vger.kernel.org>; Sat, 19 Oct 2024 15:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729375827; x=1729980627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m99yWBYvjNOuJ/xfN9fzRFdi8s+CeuV28C3wioWcRr0=;
        b=I66R7ST4wtZjipKUc8BQtoKlzeK6MW2lJgPEfEQHAhmmrzeETUKIL7OEhwu5jKAJKm
         NI6p/oHc6NZXDD7T8EivD2OYe4MPRn3lf106igD2crw3J78miXFmHnBnUqwQ1wYrmik6
         8DLxfc9kHiVonn0Joous+cpD8evLstoXR5eeK7gTOFfMqP+4gyi5GLcS2SGQM+jerILY
         kOqPPm8NaapdhGePWhwCMGQ011p9hNzCsOhM0ZTsrHIfGideugY6ScNpIw8/vWRQJ1E3
         b3emoVO1VL2Td0kX42GbmAXzYE0PN9hmY0AhGUENeM/mxgW1pDf1jgnbSlWreJslAp5t
         XMxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729375827; x=1729980627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m99yWBYvjNOuJ/xfN9fzRFdi8s+CeuV28C3wioWcRr0=;
        b=hpkpZjLNdvzRDVIpmgzXkrDh2/2BaEhLBF6/0MtTU4LeCrwEm9mq+S0BHgwxa3C/ER
         mKfzIRmKiCclDOZcxwVD5tAVitLF7R2z4vywOccBrM+4Z+MY9zRY4ZA75njcRbcgXWMo
         H6TIdAdp8hkGvLDv+Ol9r8AUPXuoxic3MjsIb4a/j326nWA6s/OtR5cV9zupIRwgCddY
         av2qpzugjGiYHk6Zicv3QubKho4XDrL8LZk2YDctMmclpyJBD4EoXW1oXcuX3cit2OfO
         pa0xBH0NFquKb4+trdiZF03cYXZGgMJ9KwUCvsHtWhlHTDPeeIbn204JxHmOVb8ycwa2
         ipXA==
X-Forwarded-Encrypted: i=1; AJvYcCXksnFruQG66tYb6L2XOj5o7kcHFSa5G5c/zCuSmHrtzSD8n016aGiFvWmUJdMkpIUMtuQSd9Tkv0VQjubv@vger.kernel.org
X-Gm-Message-State: AOJu0YzeigYY85S5rX5dayBhiUtaX8xoWzmc31wBhl94RHPMgV8qZvxj
	kfxLSI5NwjSaP9SxJ/t0QM0Ij/dkJUbLuspSWRFKd0mC76KjJccJ0SnOgMkUYre/80JOQMpSlXW
	rQHkqZrwgiIgXRbSQ6WZ/ErtFd9E=
X-Google-Smtp-Source: AGHT+IFKIs6/rGZm3ruXOPN0F4CgQSp53qqR8bjO03xssJKODyeMpcpHMF3lKVbFs1CM9Z9D8T3Dz5iQIfs6bGLgRh4=
X-Received: by 2002:a05:6512:1116:b0:539:f7ba:c982 with SMTP id
 2adb3069b0e04-53a1522aa1emr3585080e87.33.1729375826911; Sat, 19 Oct 2024
 15:10:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+icZUULLhDyScuQnM4Tx+JD9xMFhnKVkxepUK_o1jGhJGo+bQ@mail.gmail.com>
 <CA+icZUW_K-f-ATDuvtsjXokx7aWUcfh7XpW2JhxBeegXp3V4xw@mail.gmail.com>
 <CACvgo50-oorSp+70CctrxQRt04T5bkrO-z4uX66GeBFXROxYZA@mail.gmail.com>
 <CA+icZUVi8_17bPgGYFph-Jc3bhTRRVZa1K8dJgOChHors_ySFA@mail.gmail.com>
 <CACvgo50dFQHROV+JhJOgutDOTYQg4R9aWTJdBXXhNWjR_rF9Bw@mail.gmail.com> <CA+icZUXt5iDqw43-vxCamYFpz0SpaiWNfgkj8e+a5LwK9E5n+A@mail.gmail.com>
In-Reply-To: <CA+icZUXt5iDqw43-vxCamYFpz0SpaiWNfgkj8e+a5LwK9E5n+A@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Sun, 20 Oct 2024 00:09:50 +0200
Message-ID: <CA+icZUXuWwEz+h_bRGK3sP_hLnzjYh+8McUGQJzqcqyr58K+_w@mail.gmail.com>
Subject: Re: First experiments with kmod-git and meson build-system
To: Emil Velikov <emil.l.velikov@gmail.com>
Cc: "Marco d'Itri" <md@linux.it>, Lucas De Marchi <lucas.de.marchi@gmail.com>, 
	linux-modules@vger.kernel.org, Tobias Stoeckmann <tobias@stoeckmann.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 20, 2024 at 12:07=E2=80=AFAM Sedat Dilek <sedat.dilek@gmail.com=
> wrote:
>
> On Sat, Oct 19, 2024 at 4:31=E2=80=AFPM Emil Velikov <emil.l.velikov@gmai=
l.com> wrote:
> ...
> > > [built-in options]
> > > -buildtype =3D 'debugoptimized'
> > > +;buildtype =3D 'debugoptimized'
> > >
> > > ^^ What buildtype other than above exists?
> > >
> >
> > Check the meson website - it describes them quite well [2]
> >
> > [2] https://mesonbuild.com/Builtin-options.html#details-for-buildtype
> >
> > -Emil
> >
>
> Thanks.
>
> In my custom INI file:
>
> [built-in options]
> buildtype =3D 'release'
>
> and:
>
> sudo meson install --strip -C ../build
>
> Results:
>
> # file /bin/kmod /usr/lib/x86_64-linux-gnu/libkmod.so.2.5.0
> /bin/kmod:                                  ELF 64-bit LSB pie
> executable, x86-64, version 1 (SYSV), dynamically linked, interpreter
> /lib64/ld-linux-x86-64.so.2, Build
> ID[sha1]=3Def45146171c0036544a9345fbd7d0c96e3fa4cc3, for GNU/Linux 3.2.0,=
 stripped
> /usr/lib/x86_64-linux-gnu/libkmod.so.2.5.0: ELF 64-bit LSB shared
> object, x86-64, version 1 (SYSV), dynamically linked,
> BuildID[sha1]=3D725a4446b481b380588011e4e8733c1db
> eed3c82, stripped
>
> # ll /bin/kmod /usr/lib/x86_64-linux-gnu/libkmod.so.2.5.0
> -rwxr-xr-x 1 root root 172K 19. Okt 23:51 /bin/kmod
> -rwxr-xr-x 1 root root 103K 19. Okt 23:51
> /usr/lib/x86_64-linux-gnu/libkmod.so.2.5.0
>

Link: https://mesonbuild.com/Release-notes-for-0-62-0.html#meson-install-st=
rip
