Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AB51DF98A
	for <linux-modules@vger.kernel.org>; Thu, 17 Oct 2024 17:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729185444; cv=none; b=DrgDW0M/Mse+7ljrkKfcvOHjy3xvq6xrcTEANTKzLiaQ6vDYWsb7UfyhBi5pBCazSSBLS+L8vZ+n3CrN+7EgNE8NaJhyq7n2X/6aTdFBuN4WHick565N028SkrW2GiTa9m7oRXn04l5L1MekZWJpBLBvkYaRdpojpZkZg8Bpe+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729185444; c=relaxed/simple;
	bh=LXBM87VgTajUfoddl93XER3Ggzxg+hva2Bdydm+KZvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AHVjKdwWLiEmwJFmZfkKaE3rHIT0byfR4lLV9LcysmhnNbqhda1dH9dJgJHH3urgUtflXCdwggkvsaq7cur3a4XJg6u5L94tKBz6tQnTuVR1846Vm7JgtWKT6s3DdG6Rxv9rt1/7E97PlFdneicogdIFntwk5VMIPb81MULdggM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3XjWA+EV; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3XjWA+EV"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-460969c49f2so16401cf.0
        for <linux-modules@vger.kernel.org>; Thu, 17 Oct 2024 10:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729185437; x=1729790237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BzGHX9RewD+lFN+PsdkdUDyFtxdmTUuls9yy7HWZZDw=;
        b=3XjWA+EVJW1pT187uxMDSUXIY54EWTo6mena/HHRyPuksdmOF9wumFqJRah+CMDHGz
         Q5gT/gAiNsHJKYLdcZ6F+JydRm5QImAF2RJWuracsUyH7MmPpl0FSmODBkqVI3rU5ycw
         WRy3ATDH1MFNqq6x8424P8n1cZ5/r/CTkaHIuPXO0eu/m8kjjTClw8aStHwwq+MCRZdN
         xhrCGuEnsW3cUY/cq12fxfKLk40lkbkYSekoh892s4w7gbnbc3mMmc96VNgIZNmxS79F
         fO3kLgFmjih/q6EBPzFGVHZrEwPzG1JQKiDdyU+vGsYMUWWy/X+o3by5N6SLzcglh23x
         FBxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729185437; x=1729790237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BzGHX9RewD+lFN+PsdkdUDyFtxdmTUuls9yy7HWZZDw=;
        b=hGfzFkc930SglYGmD6qOGh0n6QBefTpulLqvXViIxAC19z+aASMvR2VdDij89L/R3n
         h2yuH7ohvSm5KqdXzQrYh2pF3nIx3q16L5tNSLG3F+gT7UVT27o3bdLbflnzveW5bkaV
         LKr2tCnENdtODzB5as68ljjSnJfK0JUdhBV3BeGq4AD8ugJJJMRb07U31It0j6+1XJ7L
         4iG/kYDduoW4A/oD1KViCXgSFQ1P0ibtX2ybeoxMwTp1uetD0Vf14LPSnfvZgjdquW4j
         WwGCweX3qT11QBUm91btN8HG7+8/CPGwLZlXbcaIZv/59MBK98YkpDMXjzSC/R+J3GU/
         5/QA==
X-Forwarded-Encrypted: i=1; AJvYcCV1+UEB/3p8Y+IX5g5mTYctWCZvSHI/fclWiu6KPbnSnLWNr+ktjSFYwcn5p+AWxTPGXc0849a4Io5rHZ32@vger.kernel.org
X-Gm-Message-State: AOJu0YzePmBpKda1RGoYAFxgtmJAGyIjJKHkN3rDCC890LdBcGcCe79m
	ecgjJNWC4nsGGmx5NkTeHlAduGm5fEWt2NZCUnrQfjDi6+4RFS2QD5NoQX1RsBSDXSayU6eStud
	G5HjxaXfardMF/AFldhyux7/33cTR19xKl5wZ
X-Google-Smtp-Source: AGHT+IFjnbonH6yoypoj4JMlM2KZYLkHt5TRVpIt0pWfJ3kNYug/WS8GkSqpjREjXv+9piu9Cr4VVtVs+4gHPNpk+DI=
X-Received: by 2002:a05:622a:468d:b0:460:46a8:9e67 with SMTP id
 d75a77b69052e-4609c7fefbcmr4254721cf.10.1729185436537; Thu, 17 Oct 2024
 10:17:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008183823.36676-21-samitolvanen@google.com>
 <20241008183823.36676-24-samitolvanen@google.com> <9a3c1b7e-6cd3-45ea-9be1-13a5b436cacd@suse.com>
In-Reply-To: <9a3c1b7e-6cd3-45ea-9be1-13a5b436cacd@suse.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Thu, 17 Oct 2024 10:16:37 -0700
Message-ID: <CABCJKue0rb_7V5bpuC3Zvwnv4n29=s+9J_hW5Z+6i6VPRQs9Nw@mail.gmail.com>
Subject: Re: [PATCH v4 03/19] gendwarfksyms: Add address matching
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Daniel Gomez <da.gomez@samsung.com>, Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>, 
	Janne Grunau <j@jannau.net>, Miroslav Benes <mbenes@suse.cz>, Asahi Linux <asahi@lists.linux.dev>, 
	Sedat Dilek <sedat.dilek@gmail.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 17, 2024 at 7:08=E2=80=AFAM Petr Pavlu <petr.pavlu@suse.com> wr=
ote:
>
> > @@ -22,9 +53,13 @@ static unsigned int for_each(const char *name, symbo=
l_callback_t func,
> >               if (strcmp(match->name, name))
> >                       continue;
> >
> > +             /* Call func for the match, and all address matches */
> >               if (func)
> >                       func(match, data);
> >
> > +             if (match->addr.section !=3D SHN_UNDEF)
> > +                     return __for_each_addr(match, func, data) + 1;
> > +
> >               return 1;
> >       }
>
> This change means that symbol_get() doesn't return the first matching
> symbol but the last one matched by an address.
>
> For instance:
> void foo(int a1) {}
> void bar(int a1) __attribute__((alias("foo")));
>
> The compiler produces the debug information only for foo() but
> gendwarfksyms would instead report that it processed bar() when reading
> this data, which is misleading. On the other hand, I don't immediately
> see that it would result in an incorrect CRC or symtypes output, because
> the symbols with the same address are effectively treated as one group,
> so I'm not sure if this is important or not.

Hmm, I suppose we could print out all the symbol names that matched,
but no, this doesn't affect versions or type output. I'll think about
it.

Sami
