Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D7E1B4139
	for <linux-modules@vger.kernel.org>; Thu,  2 Jan 2025 21:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735852850; cv=none; b=I3krPNUTWFsg4VcPzbKUlRmNKWY5HHx36WemdlWmGwu99MVWnQXhUt5AAx/YLZwCyxtA++tfJhZ6pK4gxdMK5geatUYm/DQpltIDbDWzQu75OAiSXEU79O5miOBeTa/QJmKSRq3II9EMnXrYfrOypR49PMV2YrntKL5cL0dQhFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735852850; c=relaxed/simple;
	bh=vTo1ZqsPUMCCaQufaEwYjzzgT7pASANYmiKJQF8QkVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nTU5u4VpXDC/Z2yu58wU95wvciv/u6Z9V3GyIkDazAwN2M/I1uGL2fE5ywnVjN7P3owiMmu5xKD1VOY/Imw3pnW+s2c3D1FkGCgNSUiXGopOq1QLAB4gPuiu8XD8LPPpSx+znyij+vqiWPGfAIv/V1tDwFpcIBvb3eN72+G8hoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wzqCA1Jf; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wzqCA1Jf"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d3e638e1b4so385a12.1
        for <linux-modules@vger.kernel.org>; Thu, 02 Jan 2025 13:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735852846; x=1736457646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9vFdZ7IDOzdE65bXGsMPSe6IPVaerxNKtrCtifyzwQ=;
        b=wzqCA1JfFUy3DHAmtzOcruJUdCbI50aFmZaDBV1Kq9ASXmx0Ev/oL7Qz96otNkIzQh
         sUVpWt1mwpacGEjdVBnU/MU/lkILA5/Rhy2IK8oHwiGrfbZ1D/qYODxRWxGADoINXtnH
         GilBlNTbZdjq/wxTQQhvkIUyNjqkollmOJ2dTC+ZXmRtqdDFxEXSNIhFTsffKIkPqqtS
         KcD7EvkonLnVOAjNSNTKEgQfNAze55qCXl5zPPEzy5Ay0FvmsRLpeaTYpnt7KeKG6geo
         uZ7f9csmWII/7Oxxl2a8rfBBmQ2E23wyS+KlYTLivINwulUci9+11HOfqvJZ7h8FnmL1
         3bew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735852846; x=1736457646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A9vFdZ7IDOzdE65bXGsMPSe6IPVaerxNKtrCtifyzwQ=;
        b=DQ6HcOgKR0l2tdU4YI7UghJALceUDrxGg4lgeCqv2pchMtsCoWTx+Ex9BVspfcIetN
         IQTsNsRB6xj/r/JFkJFpYiNZIWSihFaxlyMK85XF8/a0BT2/BC2ZixzV+sgWgM53e4sT
         R+fQQpxJNSQeqvWCCtmUNexJDKie5WZe3cBTVE2tplVWt2VY2XFc5jnj5HKfEG+vDBJV
         p9TVIVcSreh3Z0Fxl6/cJRhlrvsxBlBDvRQDXosr+iNRAxVwjM/vdovE4kE4z/NHwZ1U
         Q3d2yZTVfz/Tq/DNR42gAYOhCVnSqaOeje6+Iid0Kik7UsZhV6eQp+uVyCL4LVaE58X9
         zkpw==
X-Forwarded-Encrypted: i=1; AJvYcCVAfJWhWU39+FDbM0vCbtHWitPFRSYX5ZNVD66tIxq64gpGO4LK1o9ZuYH96nGwi1qZmPtGqJTHpZKJOPZ0@vger.kernel.org
X-Gm-Message-State: AOJu0YyJph0XsR4eCC4Jk8Y1pa+WG/PDoKb58oxWn3cI7amuwKZs3S5w
	qJ0+GadSp5QX3cn5ht4vDt+bGJ14ySzpMtRDM5rA9jhwX5K9pvWqAnb/enR5FWbB2+2HTGzv0xv
	PwwsQYDZgGqtDZCBJY6tkVb+DSDTkDW5v2tB2
X-Gm-Gg: ASbGncu9JdIpxip+CPuTfnjNlUrfr+4Hx3DWwZD3hqcFjj+iBdKh1djsO0lhLg6NE91
	GUliVh0MD7STcv8wGrTYJtKAiviaUx5t+uUXJIagtGeAT9CuzwIJCdcziWqun2TNQDw==
X-Google-Smtp-Source: AGHT+IH9SygaaxBqUPclTbHe3MzYjU7Sn3gBDwj+5VIodQhhpoIxsAYg0gsp2U2WhePi8dcPSYF5grOygMRJ+YBwyjY=
X-Received: by 2002:a05:6402:538b:b0:5d0:d7ca:7bf4 with SMTP id
 4fb4d7f45d1cf-5d9156e2c80mr23976a12.0.1735852845570; Thu, 02 Jan 2025
 13:20:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241219210736.2990838-20-samitolvanen@google.com>
 <20241219210736.2990838-22-samitolvanen@google.com> <CAK7LNAR=kBi_LN7UkO_qzUQh8fMd1BMf=ZZMQMPph5smZRzSSQ@mail.gmail.com>
In-Reply-To: <CAK7LNAR=kBi_LN7UkO_qzUQh8fMd1BMf=ZZMQMPph5smZRzSSQ@mail.gmail.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Thu, 2 Jan 2025 21:20:08 +0000
X-Gm-Features: AbW1kvaNjKx0eH_u3SVWBJidzerXL7V3SCKDxDD6r1mwb7-uASHbuJoLBzWifzg
Message-ID: <CABCJKud7qojuvkcGtOKsXjd_g5A7aS0AT611GVMGtsw5SHyJ5A@mail.gmail.com>
Subject: Re: [PATCH v7 02/18] gendwarfksyms: Add address matching
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matthew Maurer <mmaurer@google.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@samsung.com>, Neal Gompa <neal@gompa.dev>, 
	Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>, Miroslav Benes <mbenes@suse.cz>, 
	Asahi Linux <asahi@lists.linux.dev>, Sedat Dilek <sedat.dilek@gmail.com>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Dec 28, 2024 at 4:29=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Fri, Dec 20, 2024 at 6:07=E2=80=AFAM Sami Tolvanen <samitolvanen@googl=
e.com> wrote:
> >
> > diff --git a/scripts/gendwarfksyms/symbols.c b/scripts/gendwarfksyms/sy=
mbols.c
> > index 7adf2ed9b89b..98febb524dd5 100644
> > --- a/scripts/gendwarfksyms/symbols.c
> > +++ b/scripts/gendwarfksyms/symbols.c
> > @@ -6,8 +6,39 @@
> >  #include "gendwarfksyms.h"
> >
> >  #define SYMBOL_HASH_BITS 12
> > +
> > +/* struct symbol_addr -> struct symbol */
> > +static HASHTABLE_DEFINE(symbol_addrs, 1 << SYMBOL_HASH_BITS);
> > +/* name -> struct symbol */
>
> I think this comment addition should belong to 01/18 instead of 02/18.

Yeah, agreed. I'll send out v8 with these comments addressed.

Sami
