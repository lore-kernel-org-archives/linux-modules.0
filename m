Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EC61A3BA6
	for <linux-modules@vger.kernel.org>; Wed, 25 Sep 2024 23:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727307765; cv=none; b=UbN7Qak0IqXwenIcnJEFcPh4VPG/v/SBgVXiW668N5sflhNW+8jtrq9y7cBfKp9Fun+y2+jm/HtkY7h8s3DNK/UkegMC2sBzbJBKKDE0qaamwhJDJZ1ICveL9G432Yde7ae1T+o5K+lrEIZQ3DLTHch4CHfOirepV65Az2aqqf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727307765; c=relaxed/simple;
	bh=cwCCg7cjlmVJH30GDf9Cwg6fhR2bbuS17MaqIuOSV0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lHLBnq3J7sc6UQ/o1FWVaQa/jBOkS/nsKj+XoigniCmrZw+gU+vGG5S8j0HTZPyE7RRsO93s+25IK4zAFSNoUp8ccpEGL9YZirKbFgQY+0Nqep7FvQSsr6RSJv4n91/iONj0KAJLX0i94flvW/9VjHX3Rxl+Bh7KPFRnzMPbsUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E2DB/sBO; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E2DB/sBO"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c247dd0899so5400a12.1
        for <linux-modules@vger.kernel.org>; Wed, 25 Sep 2024 16:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727307762; x=1727912562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ek54duFW07igKvK9AQGJRlqEiTdehADtLtBpPhw2agE=;
        b=E2DB/sBOLvarg2yLjBPzCZclNsJO7hUZ6G7JWzC4pwy0KSxVSEd4lwuegmPYuVSQE4
         prcHVOg7GAh69d/EyX0HEVwPNO7OoxLLT1XW9/QLTBTpHNoaawRjhV6Izc8NyK6G7J8g
         yWT+LFnEPZTweXSqF0Az63SGuO4uGNkcw9+B+7ZDCh1lPcuAEmiGtGkKT7vA+yauVohF
         3I/GitalJG7xgdUdG+J/pJVjqu/LMTaS6qysbWg7BKBSXex1Mmr8VhbGOaHL7P8+MlDu
         17kRZ9XoPDATpxO0EUSiqUqOlSRZ5lMf95dG/4z3py4hD1ZCDkd3CV/2P3UQBIVojm1S
         /P1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727307762; x=1727912562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ek54duFW07igKvK9AQGJRlqEiTdehADtLtBpPhw2agE=;
        b=jWWXXoF3JponKaVnGFBqp8pbrh3BRlJR2CT8jLTPpCNh2fHX0BLoGS+xFWNdALS8uv
         VyFVFqZs9ad1xQB/CwjpdUgmzHlxXNak7tllZg6N4Wtg68u533RguGTBDNtrIMDeu71f
         nRX87bGcWZyNiywIrt4nWZ7C2rvnjxNk3a2q+4QNdR4CxKuWSys6RXiB+k1PdyfOYcmd
         wV8ftnNohzrP4QRP6ABzh5p4HcAJXqVFoDxkL6ffVMcUxO5Doi5g1MrH3W0reOQ3kWUC
         FB0+8BYb+nd+6Ee9vplZpAQ4xLMY9mFQ8v9QWEv8nOWFrAlNHzZEFkTNuSvJig1nrZ06
         9+Yg==
X-Forwarded-Encrypted: i=1; AJvYcCXe7SOIrL8UeD9D6HQwfjya4ypcYyR3xLpyIWoVjeyHp6H2aKJgAtedHxl7fZdoABNcm78a4Z/IkxqzMDpJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxLLZPGW9vvqSlzJjNRr0rZ11NXuzOqX17d8ftnaKYegWZV6QoG
	1HMrLW2eI0xJQVYJRuztmY4Lya3ujcJPQonrtqyJL700ScBbk6c8hkvSJdrxXA/cOshKHTlTmq3
	Otdz6ejEpZXokOhi67nw+8V1kfF9GKT9Q67+g
X-Google-Smtp-Source: AGHT+IEQLkFnBxCVmc+hBCfJCN9xgnB4wVQcVoqAWlHhf+GqjN1sdjtOkK/z88OGPV3GGtu/6kc0Wj3d2hT0sVNu66g=
X-Received: by 2002:a05:6402:524d:b0:5c2:5251:ba5c with SMTP id
 4fb4d7f45d1cf-5c8783c7d8fmr251259a12.0.1727307761901; Wed, 25 Sep 2024
 16:42:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924212024.540574-1-mmaurer@google.com> <20240924212024.540574-15-mmaurer@google.com>
 <20240925230000.GA3176650@google.com>
In-Reply-To: <20240925230000.GA3176650@google.com>
From: Matthew Maurer <mmaurer@google.com>
Date: Wed, 25 Sep 2024 16:42:30 -0700
Message-ID: <CAGSQo00OqOJ+s3xULXvojXMSCR8y-TQOHAwWqpS2VDxWaDxxQA@mail.gmail.com>
Subject: Re: [PATCH v4 14/16] modules: Support extended MODVERSIONS info
To: Sami Tolvanen <samitolvanen@google.com>
Cc: masahiroy@kernel.org, ndesaulniers@google.com, ojeda@kernel.org, 
	gary@garyguo.net, mcgrof@kernel.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Benjamin Gray <bgray@linux.ibm.com>, 
	Naveen N Rao <naveen@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, neal@gompa.dev, 
	marcan@marcan.st, j@jannau.net, asahi@lists.linux.dev, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@samsung.com>, Boqun Feng <boqun.feng@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, linuxppc-dev@lists.ozlabs.org, 
	linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the catch. I've sent up v5 to include that fix. I've also
added a changelog and made sure the patches make it to linux-modules@
as Daniel suggested.


On Wed, Sep 25, 2024 at 4:00=E2=80=AFPM Sami Tolvanen <samitolvanen@google.=
com> wrote:
>
> Hi Matt,
>
> On Tue, Sep 24, 2024 at 09:19:56PM +0000, Matthew Maurer wrote:
> > +static void dedotify_ext_version_names(char *str_seq, unsigned long si=
ze)
> > +{
> > +     unsigned long out =3D 0;
> > +     unsigned long in;
> > +     char last =3D '\0';
> > +
> > +     for (in =3D 0; in < size; in++) {
> > +             if (last =3D=3D '\0')
> > +                     /* Skip one leading dot */
> > +                     if (str_seq[in] =3D=3D '.')
> > +                             in++;
>
> Thanks for addressing Michael's comment, this looks correct to me.
>
> Nit: might be cleaner in a single if statement though:
>
>         /* Skip one leading dot */
>         if (last =3D=3D '\0' && str_seq[in] =3D=3D '.')
>                 in++;
>
> > +void modversion_ext_start(const struct load_info *info,
> > +                       struct modversion_info_ext *start)
> > +{
> > +     unsigned int crc_idx =3D info->index.vers_ext_crc;
> > +     unsigned int name_idx =3D info->index.vers_ext_name;
> > +     Elf_Shdr *sechdrs =3D info->sechdrs;
> > +
> > +     /*
> > +      * Both of these fields are needed for this to be useful
> > +      * Any future fields should be initialized to NULL if absent.
> > +      */
> > +     if ((crc_idx =3D=3D 0) || (name_idx =3D=3D 0))
> > +             start->remaining =3D 0;
> > +
> > +     start->crc =3D (const s32 *)sechdrs[crc_idx].sh_addr;
> > +     start->name =3D (const char *)sechdrs[name_idx].sh_addr;
> > +     start->remaining =3D sechdrs[crc_idx].sh_size / sizeof(*start->cr=
c);
> > +}
>
> This looks unchanged from v3, so I think my comment from there
> still applies:
>
> https://lore.kernel.org/lkml/CABCJKufJK0WO92wnW09VTLqZk0ODxhuKQG=3DHbKE-v=
a0urJU1Vg@mail.gmail.com/
>
> Sami
