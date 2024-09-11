Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2EC1B14EF
	for <linux-modules@vger.kernel.org>; Wed, 11 Sep 2024 16:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726070629; cv=none; b=lXlAPJQWf/MoaiEpEW1gb/gmd90iI96t7Ui1JTkt7VVTPRpVjbRe7G/WCggXaprowhoxuVPdaITj4uB8lXI0gZmf6PZIoArWw4dHc6ytb3xouQr3jcTisjOn6UUM+kWNWZYqRGTpTXacOrwR4xBztM0SBHSPjIXNhbHMMVbcoWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726070629; c=relaxed/simple;
	bh=9sXB+vF2HaFIBrbpsH0gLpHJzwQVTbseoo4NvxT6HN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mWSDNdBS6soWHFsGgOa3ut18DnTTUVsR/K6Dq8p/exSo7zVXJuYAVuERUg3o1xiMVEKI55qgGoyKyV6j67QQDqGyPCClmN8WGoB7rJ4X8zvOZPiJwXCQDuNAueR5ekMursgwTOJDJ6eH28iusn7yQ52RdSFfr78uSlSQCfANW4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=digjE51U; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="digjE51U"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4581cec6079so645411cf.0
        for <linux-modules@vger.kernel.org>; Wed, 11 Sep 2024 09:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726070626; x=1726675426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7nej+hDXRQGZRY33WrOI2LiHyYN70vRosnPoaBCwRhc=;
        b=digjE51Ua/9wuvOdGLvuOu3Yx0OgfKSGYXG/tLoCN8673ZHKqw3CL65wZere2xEHlL
         CSZF+Dm294ox/O0OVaeJ4J5U1EnTI9cK9IYlwjn/8jrdMUwDT9XvTjV+c1mtWGViu5Pk
         ZPsRf2dTd57MQ3hdymvwrxxJhVohbwoYg0ndIsXsuunPYxbT3DR0INZh45pLQ+xD1+lQ
         vTWSpVYUG1+1edNxMg/nSWVsr4Q/+bzOoQq6GfUJeChIcgn7uYKivv4IZj590wYSJtSW
         PRH9E2BJilIt0TXrnoR9T9WcYmzjNis4Qr+HgcYY5i12LF+r9rS2NWk4p+rdlT+yi9nL
         YFBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726070626; x=1726675426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7nej+hDXRQGZRY33WrOI2LiHyYN70vRosnPoaBCwRhc=;
        b=Xe/Ev97P2AuySeLqUQTQmf/h00mIXhHizqTwDnLXWKoP4M7QzV+yzY+2AypUhyaUnW
         gXwdHsdM7974WyHYYgnQjn17sAdxcgRLFmnysVzKNlB1fLXFgF+LImKzj7IFJOdDt6La
         yRhl80b9J1EOQSwcVx/LpZBwJAkVXIIRgNPUrgtWXNSE0dsyX2fedzff23P5fWJYlZLW
         jx2Dwbe2jYGxnK8AjGRwnq6X9OM26u/fPSugl2t6w7z5vP4Y7ugWtvgvGbBmbEfadYVd
         1yZHuUIfmEJdw1mrFby9ucwWcPhA3NKn865OxukYbwXWVBbVLJHMCfTo4F2jQjJQT5CH
         NUwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUF4Sy+WrXOhRdy7bTkHOY2KcuffKmLSG4VwEpu7BYhmJ+KIyEdnjKm2IBxEdua5wUU5RE1jsud7mFH6KvE@vger.kernel.org
X-Gm-Message-State: AOJu0YzgeF85Kkk/TJzIpv2JlfLtEsGn8anZI4TU3HRVSXMfdCNdA60+
	odIeWl59KzIY/aHDnj4H3+18H9FenRoaZ2FrCBsrSLe46UyGhln9+Jg9uFcsLI8dtkEDOcufqB2
	UJgvBSquP1LYhQjbtNTlRTYeZcfqxDX9bqJQF
X-Google-Smtp-Source: AGHT+IFqdCZ/zpCHMcTbg+wp9DmWUAH6fN0n+S9E0/kdxeU/B33WqP/WHqvn0q9L2zpcH9hRPg20QhMF9dEBajFDZtI=
X-Received: by 2002:a05:622a:d2:b0:456:7513:44ba with SMTP id
 d75a77b69052e-4584f3a33d4mr4259221cf.4.1726070626297; Wed, 11 Sep 2024
 09:03:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815173903.4172139-21-samitolvanen@google.com>
 <20240815173903.4172139-35-samitolvanen@google.com> <286b1cc5-1757-4f0a-bb66-0875f4608c7e@suse.com>
In-Reply-To: <286b1cc5-1757-4f0a-bb66-0875f4608c7e@suse.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Wed, 11 Sep 2024 09:03:07 -0700
Message-ID: <CABCJKudJR13PJgjr9-5Ff9Dzmb7=pSx7JWM5qTyR8oYRdtSDDA@mail.gmail.com>
Subject: Re: [PATCH v2 14/19] gendwarfksyms: Add symbol versioning
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, Neal Gompa <neal@gompa.dev>, 
	Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>, Asahi Linux <asahi@lists.linux.dev>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Petr,

On Wed, Sep 11, 2024 at 3:08=E2=80=AFAM Petr Pavlu <petr.pavlu@suse.com> wr=
ote:
>
> On 8/15/24 19:39, Sami Tolvanen wrote:
> > +static inline unsigned long partial_crc32(const char *s, unsigned long=
 crc)
> > +{
> > +     while (*s)
> > +             crc =3D partial_crc32_one(*s++, crc);
> > +     return crc;
> > +}
> > +
> > +#endif /* __CRC32_H */
>
> I think the CRC32 code should be ideally shared between genksyms and
> gendwarfksyms. One option would be to stick it under scripts/include,
> not sure if the best one though.

This was carried over from the initial version, which wasn't under
scripts yet. I'm happy to deduplicate this though. Masahiro, any
preferences on where this should go?

> > +static int get_symbol_cache(struct state *state, Dwarf_Die *die,
> > +                         struct die **cache)
> > +{
> > +     checkp(symbol_set_die(state->sym, die));
> > +     check(die_map_get(die, SYMBOL, cache));
> > +
> > +     if ((*cache)->state !=3D INCOMPLETE)
> > +             return 1; /* We already processed a symbol for this DIE *=
/
> > +
> > +     (*cache)->tag =3D dwarf_tag(die);
> > +     return 0;
> > +}
>
> Nit: The "get_" prefix in the name of this function is misleading. It
> isn't a plain getter but has an effect of setting the symbol die.
> A different name would be better.

Sure, I'll clean this up.

> > +static int calculate_version(struct version *version, const char *name=
,
> > +                          struct type_list *list)
> > +{
> > +     check(version_init(version));
> > +     check(__calculate_version(version, list));
> > +     cache_clear_expanded(&expansion_cache);
> > +     return 0;
> > +}
>
> Nit: The name parameter is unused.

Ah, so it is. I'll fix this too.

> More importantly, it made me think which names are included in the CRC
> calculation and which ones are omitted.
>
> If I'm looking correctly, names of structs, enums and enumerators make
> it into the calculation. On the other hand, names of struct members,
> function parameters and exports (functions/variables) are missing.
>
> I think the names of struct members and function parameters should be
> added as well. If the code changes 'struct A { int cols; int rows; }' to
> 'struct A { int rows; int cols; }' then that should be recognized as
> a different API/ABI. The same applies to function parameters.

I did leave out member names because typically renaming a member
doesn't change the ABI, but you're right, it might help capture these
types of changes where fields with identical types are reordered for
some reason. I'll add names.

> I'm not sure about export names. I would probably include them as well,
> if only for consistency.

I would rather leave out the symbol names to have consistent CRCs
between symbols that have identical types. Or is there an actual
benefit in including the symbol name in the CRC? The names are already
rather explicitly involved when symbol versions are checked.

Sami
