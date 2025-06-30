Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7B772609
	for <linux-modules@vger.kernel.org>; Mon, 30 Jun 2025 13:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751291162; cv=none; b=l6ZTfl67XcJjyKbH5MlLIxZ/pTinbcH+wrNoAWAalagpMotBdlIeeaAd81VUeM988JFbkwBTH2Z2WKm7iCLldUBHIH8SL4z2jEgVwZorwUupz1RHaGFFvHkO1EIYNOiNs9f30Lla7vYPpV+xnVrYgPS5z1XESrHKhCYIXt4KfSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751291162; c=relaxed/simple;
	bh=Hm2MbwnXKGaJY2SHxo57MJJ3f6qfhV7R4lhuAtejQEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VF3/YtE9vxY6bIVTc7fWRLBgNo2wU1Zh4LKluOuRh1kF+Att3nvyc9rj74sZYZJv9ypvJIBrj1eXq1a1e5ifMtGTIYVLwAupLwA4eV2kJyamIEwe1HkxBGBOWQE/ov4XZcWJ4bkortY6qI2xgOxIWxWkQKikdSATwB0M7cQnbT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U4s/41yj; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U4s/41yj"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-553a5f2d321so11398e87.0
        for <linux-modules@vger.kernel.org>; Mon, 30 Jun 2025 06:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751291158; x=1751895958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mWmIrVh084A9jSFONPMpFqcwNwUZcNanqciTXj5s4zw=;
        b=U4s/41yjZbvcqUJ8z9Dgo4L4piFHwwV+7mVljl87BsuCPpZsYrV7R+dzgNnuAIqhXx
         jruH7+/JoQC5tO2iQ01lKTMrJDI6vhTml0ctGJqJGrwFRUJXlPb8iLlL4375IsjjYuUK
         0+fpdQyVyfXCGzT2hEq43wEAF2ZL3j4xPPo+MhsE7HYDPFeHBk6pzwAXPaPgcs03A4qv
         eHIgIOPfrJI8cPsvkwhHM6+hVvTbIFu2/FvS/PoOs7tggcEW2jAdwbRtiL5vntIDDjG4
         DH/4HuJ57HJjYoSJ3Rr/VxJp8Mlz2nkExR6NZxyDXUEul4UBxLzQjQWMsrTc7nxgYJP3
         t5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751291158; x=1751895958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mWmIrVh084A9jSFONPMpFqcwNwUZcNanqciTXj5s4zw=;
        b=lLqJjS7T14pQoW1wLdf6e9YfOjB//soRwIFEsR/NFfdLTzVn7WukFJdf7GFUYsCusj
         lVgnkNxrmsmFbgVduCVLYWsbne5BlxzFln+pIiVNtSFOIKUQy9AQFpl8jBTlRTEBs3L1
         qlkPEUbVtaVIdhJ7ujuKCC6S5oJZxFWa9nauMxGApjcTuiPne+YS1rWkxHIQsnkRN4kZ
         OQEXYar/jrKhPeh9rbpzpkgIXI05Bcrh+iC565AOBCum10p55Oh8JWcwA9ldXKoTsm74
         PAyRYV6lY8h2QhGp8VQfYAYdEU5vMYCtdiywDmINgRsmUCnBXuBYJCn70wo3sp9MQkGw
         lVEQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8FfkO5SQrq/EZ+S7IH+jX7lzBTcB3mii16Iflxa43iRcdv+PPj9sgF3DtPLhwptsy8nbs0bT4+if8JydJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7ZkmFKCxNoJKKCWAUBN4kny6kJQbJ05BCUpFIPeHdUZmDkBRb
	83LZQicauqEF9PJjuJzWT9gP+llIp5HN4TW3P0zoDjrCb2ZMyyjvixK7yx5xoiMUmIeng1sjKr1
	97u5ikMRHbWofMJizKujWz9eK5zjhKspYHETovbq5e+wRQGDWLfTqqLdj
X-Gm-Gg: ASbGnctshVJu3D07Lf3Rk/1WJ5Ouxv26nXABlBsELV5YDpPsP1BqqjSXgaX2tfEXUyo
	UsJbcRHPDptIWy55ZBvfMaHbcEiI2unYIo2KU7PEuj4IfS2jEMYRXE8N1neX7YwtLISyJVErtb+
	VZxMepPw/VsFnW7yGiqNs9nyImpmNc/3KxKo+9oS7jcLleaTnGk/UZaz6OFshojxxFJvJnP8bq
X-Google-Smtp-Source: AGHT+IH05ue31sjxr2KdVgJP17Yc3pASLUVWnVUjo0re10D86rxcIxDQG9NNQHSZ1qpfo2acDCIsZpKWq8UAcdAUe3c=
X-Received: by 2002:a05:6512:2445:b0:553:24cf:79c with SMTP id
 2adb3069b0e04-5551404736bmr276292e87.7.1751291158014; Mon, 30 Jun 2025
 06:45:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623092350.3261118-2-gprocida@google.com> <20250625095215.4027938-1-gprocida@google.com>
 <CAK7LNASNVh8fDErjSbcR1TiCfy=LM-j3iYSNpqAvp8OhGmsKjQ@mail.gmail.com>
 <CAGvU0HnzfLxGhLT3Se4wNvyzEkpTKmd8ATFFgBRBVNrOKDXcgA@mail.gmail.com> <CAK7LNATp1n2c9RqNoe0oztRtLoMy8JqHF1KqSRsj5avp3vjHCQ@mail.gmail.com>
In-Reply-To: <CAK7LNATp1n2c9RqNoe0oztRtLoMy8JqHF1KqSRsj5avp3vjHCQ@mail.gmail.com>
From: Giuliano Procida <gprocida@google.com>
Date: Mon, 30 Jun 2025 14:45:21 +0100
X-Gm-Features: Ac12FXyRhPKA7k9LFq_9lXtXeBu0I63z-ojiqb2OMdNduBkpVKUo_WdgJg-YSnA
Message-ID: <CAGvU0HkKacQKB1q9NWcqChLGoMB+1vu9UdqYc+tBRbTTc3++GQ@mail.gmail.com>
Subject: Re: [PATCH] gendwarfksyms: order -T symtypes output by name
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-modules@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 30 Jun 2025 at 14:24, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Mon, Jun 30, 2025 at 7:05=E2=80=AFPM Giuliano Procida <gprocida@google=
.com> wrote:
> >
> > Hi.
> >
> > On Sun, 29 Jun 2025 at 18:51, Masahiro Yamada <masahiroy@kernel.org> wr=
ote:
> > >
> > > On Wed, Jun 25, 2025 at 6:52=E2=80=AFPM Giuliano Procida <gprocida@go=
ogle.com> wrote:
> > > >
> > > > When writing symtypes information, we iterate through the entire ha=
sh
> > > > table containing type expansions. The key order varies unpredictabl=
y
> > > > as new entries are added, making it harder to compare symtypes betw=
een
> > > > builds.
> > > >
> > > > Resolve this by sorting the type expansions by name before output.
> > > >
> > > > Signed-off-by: Giuliano Procida <gprocida@google.com>
> > > > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
> > > > ---
> > > >  scripts/gendwarfksyms/types.c | 29 ++++++++++++++++++++++++++---
> > > >  1 file changed, 26 insertions(+), 3 deletions(-)
> > > >
> > > > [Adjusted the first line of the description. Added reviewer tags.
> > > >  Added missing CC to linux-modules.]
> > > >
> > > > diff --git a/scripts/gendwarfksyms/types.c b/scripts/gendwarfksyms/=
types.c
> > > > index 7bd459ea6c59..51c1471e8684 100644
> > > > --- a/scripts/gendwarfksyms/types.c
> > > > +++ b/scripts/gendwarfksyms/types.c
> > > > @@ -6,6 +6,8 @@
> > > >  #define _GNU_SOURCE
> > > >  #include <inttypes.h>
> > > >  #include <stdio.h>
> > > > +#include <stdlib.h>
> > > > +#include <string.h>
> > > >  #include <zlib.h>
> > > >
> > > >  #include "gendwarfksyms.h"
> > > > @@ -179,20 +181,41 @@ static int type_map_get(const char *name, str=
uct type_expansion **res)
> > > >         return -1;
> > > >  }
> > > >
> > > > +static int cmp_expansion_name(const void *p1, const void *p2)
> > > > +{
> > > > +       struct type_expansion *const *e1 =3D p1;
> > > > +       struct type_expansion *const *e2 =3D p2;
> > > > +
> > > > +       return strcmp((*e1)->name, (*e2)->name);
> > > > +}
> > > > +
> > > >  static void type_map_write(FILE *file)
> > > >  {
> > > >         struct type_expansion *e;
> > > >         struct hlist_node *tmp;
> > > > +       struct type_expansion **es;
> > > > +       size_t count =3D 0;
> > > > +       size_t i =3D 0;
> > > >
> > > >         if (!file)
> > > >                 return;
> > > >
> > > > -       hash_for_each_safe(type_map, e, tmp, hash) {
> > > > -               checkp(fputs(e->name, file));
> > > > +       hash_for_each_safe(type_map, e, tmp, hash)
> > > > +               ++count;
> > > > +       es =3D xmalloc(count * sizeof(struct type_expansion *));
> > >
> > > Just a nit:
> > >
> > >            es =3D xmalloc(count * sizeof(*es));
> > >
> > > is better?
> > >
> > > > +       hash_for_each_safe(type_map, e, tmp, hash)
> > > > +               es[i++] =3D e;
> > > > +
> > > > +       qsort(es, count, sizeof(struct type_expansion *), cmp_expan=
sion_name);
> > >
> > > qsort(es, count, sizeof(*es), cmp_expansion_name);
> > >
> >
> > That's a fair point.
> >
> > However, in the gendwarfksyms code, all but one of the sizeofs uses an
> > explicit type name. The exception is sizeof(stats) where stats is an ar=
ray.
> >
> > I'll leave Sami's code as it is.
>
>
> This rule is clearly documented with rationale.
>
> See this:
> https://github.com/torvalds/linux/blob/v6.15/Documentation/process/coding=
-style.rst?plain=3D1#L941
>
>

I can follow up with a change that adjusts all occurrences. That
shouldn't take long at all.

>
> --
> Best Regards
> Masahiro Yamada
