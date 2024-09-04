Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0ECE14EC77
	for <linux-modules@vger.kernel.org>; Wed,  4 Sep 2024 20:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725482968; cv=none; b=KyxUJrxF4X9/PCewH3puuoa8o1F1Vz52FGFhqpA7bILrjfNFSpIaBfHPkREMWALvAkwVDHaY6Obf8fFby5Ve3PXB/athouCY9uQe+P00i4H0Hw4r4iHiKB7ApcEHeG6ExMXpc+D8C0WQsURrrieQHKYCuVfPFmS38tG77Vmt4K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725482968; c=relaxed/simple;
	bh=Cc8EAH8IE6Yvd2aBPD8rscltUpBUI4dNmp2jXK/tiZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A+8tEYO3BzO4NcnmHxi4SiMLeUaJUj9VWRkrzgLVpxkH13fTNGWyBGgDFTeQj7JYSfqLVateLzpF/X0APpg702gc2oLXVR0CbHbSW30HvK44Ns0u7h/iSQTWxuWu92OluGvoUaZqUEN/KEJc0wLMg07EJ0CUl4oar3saqt6u5U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cGbPqRQB; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cGbPqRQB"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4567fe32141so28521cf.0
        for <linux-modules@vger.kernel.org>; Wed, 04 Sep 2024 13:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725482965; x=1726087765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gx0Hp8KWD3MclVMhWNlTjqLSDptdez0gd8c+TTiyWFY=;
        b=cGbPqRQBlLkzzU32aa/QfYwSFJfSY1GAYflXcNptrlfIdZ5GeA3aFIl0xphI7U/hGB
         wjzNFi+Qee7601B1OBDluKnSYEGgsHqvZygWBlqmF5Up4KD4RKdLfs9DJG0NJAjRep7g
         0neXnVt5BN7BdVqOgIqwlUDVtPuhC1Lo/jiUQfQrxEWn/2qHf4t1dVkGnvH9scLfx376
         t1gma2RFnGNB7F/KdNu+Xv5Cv8K6DQUB4q7MX0zVBf4t1L0k8Kv3PLFbXaHCBrXyeD1Y
         xCJMF8j4IWvEkdmkxhBpVqUkjby7r93Q8zvckrdZtntuB+RZ7SOWIahsgeIJyy+8u19e
         ZGhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725482965; x=1726087765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gx0Hp8KWD3MclVMhWNlTjqLSDptdez0gd8c+TTiyWFY=;
        b=m0MX75E6YCWh9QAdmDtrui/zHOr3hzmYGeQRVszWKMNYI5T348wMEcfa/fWV3jscUQ
         nhGx1yb2BgkItZ4viEtTqXJQi6sn01R3a10A4NcGo4wgZSvjhYuYRGSKDljk6tVU/k7U
         Z0kjBtAix9jTvJuNrW3RDpQjMAI13pcW/9vViS9XcKq6cSYxA8/BSmRXke8QyMhX/9yD
         EXO4dw17cZcm8hJt4l8vJWSBXbsfOZL1hlbDKJ+T5oUAKRrB+NzRbLzQ1x6czEPsL+HR
         H1A89mKSD/TJsMHkOxsnADOUhYs7Av0p6WelXRqj2ASR/3T0GiW9EqhZRrs4h3LxOkXg
         5hoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKqcpUcBQG06ffOk9l+mqSGSQzcXNZAvvGwhLRT/vgH27Ej3DKH7hvATOoG9mBmDzDkoUpLUs4R2DCjTMZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyCuC+IBTf9ieKI2PHIQgLckfsgaWW82TKreFy6HwUD8hsiAHd9
	Ty21pa4ihmvnoGidfvFlNnkQFHGPeJX0lI8s237p7sKsNgvHNwkQnvU0pAOfbolMUUaceCovyR2
	cpfZWCM3GJ1A+pc0q4ZIm7jx/2Zs9RxMhLBsU
X-Google-Smtp-Source: AGHT+IFd6KrSrGqG+ulcWq9YMSxY7NK7vHFG24Qs6rA2X3nt4MsgAamSOqjNX6oKm6LJdBaxSA3RA8iCSuENhDVVJls=
X-Received: by 2002:a05:622a:2a07:b0:453:58c8:3fd1 with SMTP id
 d75a77b69052e-45801b1f7ccmr1000011cf.0.1725482964482; Wed, 04 Sep 2024
 13:49:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815173903.4172139-21-samitolvanen@google.com>
 <20240815173903.4172139-24-samitolvanen@google.com> <CAK7LNAQs8E1pKo1Bcn4RUAkGbBFPmUsWRRrQCnUUiB588FB09A@mail.gmail.com>
In-Reply-To: <CAK7LNAQs8E1pKo1Bcn4RUAkGbBFPmUsWRRrQCnUUiB588FB09A@mail.gmail.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Wed, 4 Sep 2024 20:48:47 +0000
Message-ID: <CABCJKud+c3CdKATGDghCdJ=Tn06es5z9U5T5nDi7gWMBkyRNZw@mail.gmail.com>
Subject: Re: [PATCH v2 03/19] gendwarfksyms: Add address matching
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matthew Maurer <mmaurer@google.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Petr Pavlu <petr.pavlu@suse.com>, Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>, 
	Janne Grunau <j@jannau.net>, Asahi Linux <asahi@lists.linux.dev>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Sep 1, 2024 at 11:11=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Fri, Aug 16, 2024 at 2:39=E2=80=AFAM Sami Tolvanen <samitolvanen@googl=
e.com> wrote:
> >
> > +static int set_symbol_addr(struct symbol *sym, void *arg)
> > +{
> > +       struct symbol_addr *addr =3D arg;
> > +
> > +       if (sym->addr.section =3D=3D SHN_UNDEF) {
> > +               sym->addr.section =3D addr->section;
> > +               sym->addr.address =3D addr->address;
>
>
> These two lines can be replaced with
>
>                   sym->addr =3D *addr;

Good point, I'll fix this in the next version.

Sami
