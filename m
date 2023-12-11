Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5115168CF
	for <linux-modules@vger.kernel.org>; Mon, 11 Dec 2023 18:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yqc8n9Ex"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A5E8C433C8;
	Mon, 11 Dec 2023 18:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702318568;
	bh=b4SzHYBlBfVYzMKlFytXfg+W32rsjAYh1uFD+VjgDRU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Yqc8n9Exs1us3nbS3F0tNgNMwas7NPcdrqVA4j/66qtrnMWkbUmWFnpdxutMugJw5
	 Q9JMnvciuMeCJC2VDChDCpIw6zaCTJkEwupG2120YfC2x5gpArp47pUbfx1ZCKjkEX
	 ei9iUKqVqMawnxxZCAc/Xs3U0l5e0WJLkmZieQ+m1wzSv1bjjse0JWbgGqSE9uPgnm
	 NK2rj/B00S9RKyVMAnabx9X5SXji3slesIuRW8SXCJjhwVBv6v2mQRk9Nw6UFCyRs7
	 zxEyG9aYgaFm2zeNVh6g72UTARawd1yJWvo0E0U+X3P3KebBZMTPX3rxgqdbSRWflX
	 5u4sQrTJumoSw==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1feeea75fbfso3075125fac.3;
        Mon, 11 Dec 2023 10:16:08 -0800 (PST)
X-Gm-Message-State: AOJu0Yxrpt7uS4TfkRZH35Gm9v7LyQR255HkcPaalRhd0ybNhFtEtVEZ
	ibetQCRLvTpsAoM4V3R6DVOPTPEKaQAhv+sfqF8=
X-Google-Smtp-Source: AGHT+IGrB4LVwOfjwDcEsmCTjO6kZJRWvY77iRWupbzMoVZJH5NslGRTomF3l/+HCr9pN4GLQSUNVrY7qtnVzxOB62o=
X-Received: by 2002:a05:6870:1699:b0:1fb:75a:c426 with SMTP id
 j25-20020a056870169900b001fb075ac426mr4249250oae.79.1702318567772; Mon, 11
 Dec 2023 10:16:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFSh4UwYYAOb0YpC=WAL6SD+8jTLuSkhgrgjh8JmogUb10V=zw@mail.gmail.com>
 <CAK7LNASE6H2GoXzJ1PXWEqsemQ3ny1K34vOxN0uVn1fh7Mmt5A@mail.gmail.com> <CAFSh4UwkXyTnECgJBQA4uBqD0QOFiUBvj=aOy7qzXZqAZKYkcQ@mail.gmail.com>
In-Reply-To: <CAFSh4UwkXyTnECgJBQA4uBqD0QOFiUBvj=aOy7qzXZqAZKYkcQ@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 12 Dec 2023 03:15:31 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQE0vuAEqq+S_9bQ6h12TmyUDut238Q0LmeodfZZxWR+Q@mail.gmail.com>
Message-ID: <CAK7LNAQE0vuAEqq+S_9bQ6h12TmyUDut238Q0LmeodfZZxWR+Q@mail.gmail.com>
Subject: Re: Building signed debs
To: Tom Cook <tom.k.cook@gmail.com>
Cc: linux-modules <linux-modules@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 7:19=E2=80=AFPM Tom Cook <tom.k.cook@gmail.com> wro=
te:
>
> On Sat, Dec 9, 2023 at 6:18=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.=
org> wrote:
> > On Fri, Dec 8, 2023 at 8:14=E2=80=AFPM Tom Cook <tom.k.cook@gmail.com> =
wrote:
> > >
> > > I'm trying to build a signed .deb kernel package of
> > > https://github.com/torvalds/linux/tree/v6.6.  I've copied
> > > certs/default_x509.genkey to certs/x509.genkey.  The .config is the
> > > one from Ubuntu 23.10's default kernel with all new options accepted
> > > at their default and CONFIG_SYSTEM_TRUSTED_KEYS=3D"" and
> > > CONFIG_SYSTEM_REVOCATION_KEYS=3D"".
> > >
> > > This builds the kernel and modules, signs the modules, compresses the
> > > modules and then attempts to sign the modules again.  That fails,
> > > because the .ko module files are now .ko.zst files and the file it's
> > > trying to sign isn't there.  Full failure is pasted below.
> >
> >
> >
> > Modules are signed before the compression.
>
> Reading back through my earlier email, I wasn't clear that when I said "T=
his
> builds the kernel..." I meant "`make deb-pkg` builds the kernel".  I'm no=
t
> doing anything outlandish here, I think, just expecting the build system =
to
> work.
>
> Regards,
> Tom


OK, I understood.



The error is caused by the following lines
in scripts/package/builddeb:


# re-sign stripped modules
if is_enabled CONFIG_MODULE_SIG_ALL; then
        ${MAKE} -f ${srctree}/Makefile
INSTALL_MOD_PATH=3D"${image_pdir}" modules_sign
fi



The error happens when all of the following three
are enabled.

 - CONFIG_DEBUG_INFO
 - CONFIG_MODULE_SIG_ALL
 - CONFIG_MODULE_COMPRESS_*


If you disable one of them, you can do deb-pkg.







--=20
Best Regards
Masahiro Yamada
