Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F461CEAA0
	for <linux-modules@vger.kernel.org>; Tue,  1 Oct 2024 20:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727813258; cv=none; b=QG2O66lj9RbSyN4zY1eJr681TKQUVT1NWHTVu9WQ6BliV3MP7VKvzWSqP+liRMTDywdYPwqyONwonmhZhqz8Z3wTsCBdGbUZcsYiCWMHubjN+CM2WdNepNxgUAtHa43SDN79CPLx+V6ibhSRWEkh9txQc4nrDyXW5gsJ1hdGZNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727813258; c=relaxed/simple;
	bh=nb+1zuofbp/YLzRVQkvPoNQ/yPtfFbypigrtq+u1nsA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LUtRw4tIpHBmPiAh/Jjbom8I13/pckIHwYSlvbCU9nh2G7dJ7NeQz/3TqtDIY1QIxyokJza2DgKb1/6hBgtjkyMna6O6xDxyDy87+frpLR6danI8rDhLy+vS4w4Tqu8ePqbZLejJY5o5rmWnDFOV+hMbxJYG24arPwEvRul8ww4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=idvLeY8g; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="idvLeY8g"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4582a5b495cso12441cf.1
        for <linux-modules@vger.kernel.org>; Tue, 01 Oct 2024 13:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727813256; x=1728418056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mMY9PPpiy6n79kGTLnpvPmokvdMN2sau/6lNm64LaIc=;
        b=idvLeY8gy3pcXPegwFWCxfs/2XC8TdIuc0Vzx5rcJenIxUAwmQ5AIV4m5rOi62RzWo
         MMzG+BZ7xkjmEZuVyXnI+docOUek+M2gQZQPzR3Vh88c/dbeQAv/T4VY51x9gnJdtsN5
         qRvFFo3hO9JFQbOaiUhPvnd0FmSBj8Yp/iVMpDkLnLbLgkCOdeNQGu9zCT/Z6rFlL9gI
         RiGt2juiGf1qfaS0QeQdwNJRBI1tJSSJskajTTT81P6TneGO1TQIxbS0TVEO0/Ik6Pyv
         z2Phe3n7j3B5PpN4pXnNpVmCwsC/lIKIPLPHBKjVIb/yuvf7AJjuFGvyhY9eI4eecr4k
         KFmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727813256; x=1728418056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mMY9PPpiy6n79kGTLnpvPmokvdMN2sau/6lNm64LaIc=;
        b=auye+9XZ4QHMQeLV7EnRc8Lx6NzkNI7EbK4D6zK0XRYPzK2Ep9gkIzMFDxrAxgMOcz
         XbnzGnO3QqOsHA/e4zGU6gKtsMOY9/Wf/H7rwXwc0GCcrimQ5fplWK2WSxnF6fa4dbz4
         UioOXEV3bqLFWugYIjRjD1c0CPBqkYIA/6M16icIlfwAF2o2aVguokyl9wqwSYdG6DIg
         HZGgGAyx7EMxH75onDbmcXA/FOen1KFPxY2zMSYiK5hoLAJ2K6fbGuG4/yKSaOqQNJNW
         55EUxvYI0IjC6dhodAFmXJoXyFcC+pYRtVuSKm2865FaM34dzN/2qwf8DJoHfm1yOKJw
         MixQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/7lQWmnBAzM7QD6uYQ159Zz8DtrmHTFQmX1oTH4gcU06LCZIFaR/ZPO3OYWbrSZBtmHlXciljj5gzeiis@vger.kernel.org
X-Gm-Message-State: AOJu0YxXj0aYxQK0s8wMF2ihVEtAnYiwDOa7hiQ6yyR/tWBHlHaPTiEK
	OfKU62czK02qZDIJY0f/Rrhc3rfxNnSMAQYexdEhc16EDGgVXwjEy2GymToJo9lmPVs15iIDqVl
	h3PEPn490veAdOz9aHKPgShVz+EOf4twpAiho
X-Google-Smtp-Source: AGHT+IHKBvWS6PLEHB2YJgh6RwJYvXytEANIAFFLs7YtFd7/8QYOtHb1Is9sK/px/8P98dxvd7EeN/7sfEz9KfBXdkM=
X-Received: by 2002:a05:622a:5796:b0:453:58c8:3fd1 with SMTP id
 d75a77b69052e-45d814de7f6mr742221cf.0.1727813255948; Tue, 01 Oct 2024
 13:07:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923181846.549877-22-samitolvanen@google.com>
 <20240923181846.549877-26-samitolvanen@google.com> <429b7310-3724-48a2-a8ac-e686c6945024@suse.com>
In-Reply-To: <429b7310-3724-48a2-a8ac-e686c6945024@suse.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Tue, 1 Oct 2024 20:06:59 +0000
Message-ID: <CABCJKueyGPNeUqW_xWdG11OxHDWsMM0CtV31sbg4LL0FggEN=g@mail.gmail.com>
Subject: Re: [PATCH v3 04/20] gendwarfksyms: Add address matching
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, Neal Gompa <neal@gompa.dev>, 
	Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>, Miroslav Benes <mbenes@suse.cz>, 
	Asahi Linux <asahi@lists.linux.dev>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 2:06=E2=80=AFPM Petr Pavlu <petr.pavlu@suse.com> wro=
te:
>
> On 9/23/24 20:18, Sami Tolvanen wrote:
> > -     for_each(name, get_symbol, &sym);
> > +     for_each(name, false, get_symbol, &sym);
> >       return sym;
> >  }
>
> What is the reason that the for_each() call in symbol_get() is invoked
> with name_only=3Dfalse?

It was initially added to skip address checking when reading the
symbol list, but it's redundant since there are no addresses to check
at that point anyway. I think we can just drop the name_only argument
completely. I'll change this in v4.

> > +                     for (n =3D 1; n < nsyms; ++n) {
> > +                             const char *name =3D NULL;
> > +                             Elf32_Word xndx =3D 0;
> > +                             GElf_Sym sym_mem;
> > +                             GElf_Sym *sym;
> > +
> > +                             sym =3D gelf_getsymshndx(data, xndx_data,=
 n,
> > +                                                    &sym_mem, &xndx);
>
> Please check for sym=3D=3DNULL in case the file is malformed, e.g.
> .symtab_shndx is truncated.

Good catch, I'll add a check.

Sami
