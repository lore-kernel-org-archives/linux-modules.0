Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478571BDAB5
	for <linux-modules@vger.kernel.org>; Fri, 16 Aug 2024 15:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723823495; cv=none; b=Tmjtxs28ioohvxWHQtCZXugFq3LCmf1d7QJY6nGpRYxOFXyULgbu31bG481O2pFEbluncJJQYI5ra1QfpiqJKxnoy6i6MROS6kroptHgQwbvWPPa888edG88f7PWNPVu+j5Uz7Pj8+sT0iyXEzhO3AGcHm6FscrjfVdGYWXWKC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723823495; c=relaxed/simple;
	bh=aTpatmIGqiMC7+hU1OkoYLiM35+6LYxID9L25XPk8l8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LoLmlzp259JxrN8XPGoFtPq0yS9d91h6NEEU41Rv/cY8f/apQyNa7591rPL+L4akzjh4OChEBy0hv78yFyQltrEm1j3CwfhuebFVEuThlfF0IF2fnGCT5yfOojEtJM9nHwnLOGlZON4bLf2SLPudCVC+PLyhcA7iy4ijK2BkmPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EnOpsI0x; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EnOpsI0x"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4928989e272so837325137.2
        for <linux-modules@vger.kernel.org>; Fri, 16 Aug 2024 08:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723823492; x=1724428292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVTGOKA5IKmJj5zDO1DyZoUEkVlymdLnKbH0vw8teA4=;
        b=EnOpsI0x1zX/KA9JOiq3diJCg5p8yrxq1Kju5yDHOkDoRasrBXR4Qtbe+z8I94zRy9
         oKaDMOZ/aYTTSak0IcgTBQS4kRdWgajUIcwyyQ1m+bJLPBR90TOYap/SZ3Z/o26iq237
         uqgLRSvHz+IwVU7WZGKOu0alI9eyJwLW2urG1eHtTtX6ahUoS0GZx1yj0+bpOojaiKn5
         Yhd7aQgQttY0FKjilLjfzUlJbo/SnJGlhQl7ysTbIzomoBvs9EBT8ZG93NCZTOaxJoij
         q/EqTVCEYlz4gcAlhkuSsrr/GYJfBQgb+xXQ4KlYOdZswH6w63KQBVyTdxEnucQyV0rY
         Pgzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723823492; x=1724428292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oVTGOKA5IKmJj5zDO1DyZoUEkVlymdLnKbH0vw8teA4=;
        b=EyXDwczkdxKQUEE30RsbNqq1ncZVL1ujXvrUHINDHM2365vlBjlq/rZEI/4yu4dqV7
         ojHCkAZkzvjjSqBhsYzutisTeR+n+3f7Q+gdJrKJ7Gd/Z/QuJ1adcIB0LZ6TCtdfc3J3
         LrT6jOjlhejObpSnlA1j5BG0wIsvgOabj8fvTc8cOWJ4fjROooCtqSNWjdDtJ1WtzbJc
         AaxlTxt8vqkd+1xBH/IUsNuMY2zTPwO+aMAtR+/yLpfccRmaBk+lSZfLYgkymfAK5Z7a
         Xb8mv87PU6Vo87PKlhgSPnxHgc1HX0drEsd3bjHUG6e2bpefdFQ+2XnIUaiwwB4sDnfv
         1y7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXP3c5VxNuEfYE23sqaQg4vlA9x63/npCxLh34tbIJTlPx3dF7Sze6a4j5k+ugihrpt/w9XA+XrtiGeAwvWXHO542DEUSpAfgfPGu4vJQ==
X-Gm-Message-State: AOJu0YxTrXAiGBXyPOgvTshylhkFtugEWJJBJbQf/CPcOajSfb0+0LEs
	rK1y6KmcE4vFnab0xRr/zKKweDc/SV/Hn14EIFtXup7Ixtw1YQ+bpjb40E34KJUWDH9Q7D7ZcSk
	tQww1MHK558KX3xZ9PYfcf4orcBDOVMOxjd88
X-Google-Smtp-Source: AGHT+IFrg6f6qSm3TiL3zt4TuWVBOxUcMXZyDfUiXF2IUyGH3wmo6nzc1yc+vCPuTrt/IV1JuHI4FaQJcHYE6thnrtU=
X-Received: by 2002:a05:6102:390f:b0:48f:380a:ca90 with SMTP id
 ada2fe7eead31-4978848984dmr131943137.18.1723823491972; Fri, 16 Aug 2024
 08:51:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815173903.4172139-21-samitolvanen@google.com>
 <20240815173903.4172139-37-samitolvanen@google.com> <2024081600-grub-deskwork-4bae@gregkh>
In-Reply-To: <2024081600-grub-deskwork-4bae@gregkh>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Fri, 16 Aug 2024 08:50:53 -0700
Message-ID: <CABCJKuedc3aCO2Or+_YBSzK_zp9zB8nFwjr-tK95EBM3La1AmA@mail.gmail.com>
Subject: Re: [PATCH v2 16/19] gendwarfksyms: Add support for reserved
 structure fields
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Matthew Maurer <mmaurer@google.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Petr Pavlu <petr.pavlu@suse.com>, Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>, 
	Janne Grunau <j@jannau.net>, Asahi Linux <asahi@lists.linux.dev>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Fri, Aug 16, 2024 at 12:20=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Aug 15, 2024 at 05:39:20PM +0000, Sami Tolvanen wrote:
> > Distributions that want to maintain a stable kABI need the ability to
> > add reserved fields to kernel data structures that they anticipate
> > will be modified during the ABI support timeframe, either by LTS
> > updates or backports.
> >
> > With genksyms, developers would typically hide changes to the reserved
> > fields from version calculation with #ifndef __GENKSYMS__, which would
> > result in the symbol version not changing even though the actual type
> > of the reserved field changes. When we process precompiled object
> > files, this is again not an option.
> >
> > To support stable symbol versions for reserved fields, change the
> > union type processing to recognize field name prefixes, and if the
> > union contains a field name that starts with __kabi_reserved, only use
> > the type of that field for computing symbol versions. In other words,
> > let's assume we have a structure where we want to reserve space for
> > future changes:
> >
> >   struct struct1 {
> >     long a;
> >     long __kabi_reserved_0; /* reserved for future use */
> >   };
> >   struct struct1 exported;
> >
> > gendwarfksyms --debug produces the following output:
> >
> >   variable structure_type struct1 {
> >     member base_type long int byte_size(8) encoding(5) data_member_loca=
tion(0),
> >     member base_type long int byte_size(8) encoding(5) data_member_loca=
tion(8),
> >   } byte_size(16);
> >   #SYMVER exported 0x67997f89
> >
> > To take the reserved field into use, a distribution would replace it
> > with a union, with one of the fields keeping the __kabi_reserved name
> > prefix for the original type:
> >
> >   struct struct1 {
> >     long a;
> >     union {
> >       long __kabi_reserved_0;
> >       struct {
> >           int b;
> >           int v;
> >       };
> >     };
> >
>
> Ah, ignore my previous email, here's the --stable stuff.
>
> But this all needs to go into some documentation somewhere, trying to
> dig it out of a changelog is going to be impossible to point people at.

I agree, which is why I included the details in the comments too.
There's also an example file if you scroll down a bit further, but I
can certainly add some actual documentation too. Since the --stable
bits are not really needed in the mainline kernel, do you prefer a
file in Documentation/ or is it sufficient to expand the example files
to include any missing details?

> > +/* See dwarf.c:process_reserved */
> > +#define RESERVED_PREFIX "__kabi_reserved"
>
> Seems semi-sane, I can live with this.

Is there something you'd change to make this more than semi-sane?

> I don't know if you want to take the next step and provide examples of
> how to use this in "easy to use macros" for it all, but if so, that
> might be nice.

This should already work with the macros Android uses, for example,
with minor changes. The current example file doesn't include macro
wrappers, but I can add them in the next version.

> Especially as I have no idea how you are going to do
> this with the rust side of things, this all will work for any structures
> defined in .rs code, right?

Yes, Rust structures can use the same scheme. Accessing union members
might be less convenient than in C, but can presumably be wrapped in
helper macros if needed.

Sami
