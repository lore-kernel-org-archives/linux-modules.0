Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C942132132
	for <linux-modules@vger.kernel.org>; Tue, 27 Aug 2024 18:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724784512; cv=none; b=DqlGqpWzk6FsDlvA2ZP2l1DBNKibOMsNBqci5yADRUYsR7ArGaibI25Hy1+ov/ukyhv80Nuxp3fmg6UEBRj7BMZRCgSXnHCU8tAXQVfJ9eUECYMLSLqhsy2KtnviKEhVkjWii3y+xGfqb3I1eYFg6bDoZc67HcJ4fHsM9URdplE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724784512; c=relaxed/simple;
	bh=I5//Ha3NSD2Wtl/0jjx0iRpYd7vI5TxmgjMPfRVQ1/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m6D5jKZkBB3mdvewEof9y5HAHeljbDqYcYKAK8NcSXoB4VqzFDA8LgGVWYSDDjt7/Wk6Ksz4RvoG5CHBExmIbzndIl3d9lAoWaibR1xgu/p7SleIjlQj5TtX6JOruZk78mFb/maKtZAl60M5ONjD4H9ndwnvHHM3j933ymQHVwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4eGRhfl3; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4eGRhfl3"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-454b1e08393so46851cf.0
        for <linux-modules@vger.kernel.org>; Tue, 27 Aug 2024 11:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724784510; x=1725389310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LidQY3N7TAVU7mz++A4EWJV/Qlk2ObRsexeEqCJH/sQ=;
        b=4eGRhfl3kXUoAYV1Enr6mzC5351bzICnr6nhNH48IsRwaHVU6z0s5mLq9fPrOcJH8x
         XHvrX8i4u70ltCZhnNQVWkQWZbJ8OE4ye70pZwN5v7GnrptJCtO0qNmrDQI1pnzMGlXg
         T6aLawl8+TaQPwcQ1YagRxdQ25I2Qo671YZLLrBTwSvscdTk6aHmFH0WIkdfFl9aj8Md
         tjImVw834O50hhLLMltKfGrs603HfCFL770DDl3BVSrEfxZK+88hb8ix86u09xJ2F6m4
         BLPqVXfNF0UHtMjF8LkmHNtrktVfPF7JdZ9k7VM/j2T4JtEl+KlH3xDdCeb3V7zoAdh6
         KRmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724784510; x=1725389310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LidQY3N7TAVU7mz++A4EWJV/Qlk2ObRsexeEqCJH/sQ=;
        b=iYZY/kp89GdaPa7QQcMXcoF1XwsE/fuQ0RqrN7HEt/02j4p4fxbfIbDc2Fo+JejUOv
         2s3G+U90C0y7HXZXYK7vbAna/e7m8vir3Pomr/HVBZTUytjfUcxSF9pRcF6bYxxuMNeQ
         6XMkVpMrsljo57Za0ObtQRLkJW+FEcCs/yCC5W0qBvzV0dVkCP3onhHpaJiIeqTFvItI
         GVIz2nTu6pBc/eU/84/Nh5/RhvF0uOovhBJHWlB03f0fgRMiu7W8zwgpAulzUYyYnzeG
         ENMga+ryXhdDNzN8IrFbqojg7GKE9wmOZ02b9aRRpeeyUDDPogZPC/RY9oty0YqRUoN6
         bwDA==
X-Forwarded-Encrypted: i=1; AJvYcCWh88gNrei1l9f/2O7DLDJIj9flvZnr9c72G9uSxlMJroACCnXnY5mk6NVm3i4sjvlnQxG+y9b143NIXKhH@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/OZCgqj/kbtPM+Lxb4V4XQyRGbts3UywJ7bOrs+XLxmoytHCF
	jHSDslOyDSzWntePLvrKdB4Af40G3wcZLiuWpY32CLuibCtZKOBSMk4NLAqWAoIrevKlTIZenHv
	Az2yWE1zg9YeNosrawZ1Tb/P0XqVDS0IFG8K4
X-Google-Smtp-Source: AGHT+IEYo3wpUDQ07W+N/9n1FFu7R6YCMxlFn855GpjF2BmicavhNUlzTFwLoKagN05qtS/bFGVksEONLKfLBTPt0T8=
X-Received: by 2002:ac8:5a45:0:b0:453:5b18:817 with SMTP id
 d75a77b69052e-4566caed6c1mr336721cf.6.1724784509942; Tue, 27 Aug 2024
 11:48:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815173903.4172139-21-samitolvanen@google.com>
 <20240815173903.4172139-23-samitolvanen@google.com> <f9ad5fdd-25d4-4d98-84d0-84dfba2a75f2@suse.com>
In-Reply-To: <f9ad5fdd-25d4-4d98-84d0-84dfba2a75f2@suse.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Tue, 27 Aug 2024 11:47:51 -0700
Message-ID: <CABCJKuc8fOmsbpqOJXwYstwc+7DEf-Bf26_n5_ai2Pax1tXqUg@mail.gmail.com>
Subject: Re: [PATCH v2 02/19] gendwarfksyms: Add symbol list handling
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, Neal Gompa <neal@gompa.dev>, 
	Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>, Asahi Linux <asahi@lists.linux.dev>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Petr,

On Tue, Aug 27, 2024 at 2:16=E2=80=AFAM Petr Pavlu <petr.pavlu@suse.com> wr=
ote:
>
> On 8/15/24 19:39, Sami Tolvanen wrote:
> > +static bool is_export_symbol(struct state *state, Dwarf_Die *die)
> > +{
> > +     Dwarf_Die *source =3D die;
> > +     Dwarf_Die origin;
> > +
> > +     state->sym =3D NULL;
>
> Nit: This assignment isn't strictly necessary, the value is overwritten
> a few lines below and isn't used in between.

True, I think this was left over from refactoring.

> > +int symbol_read_exports(FILE *file)
> > +{
> > +     struct symbol *sym;
> > +     char *line =3D NULL;
> > +     char *name =3D NULL;
> > +     size_t size =3D 0;
> > +     int nsym =3D 0;
> > +
> > +     while (getline(&line, &size, file) > 0) {
> > +             if (sscanf(line, "%ms\n", &name) !=3D 1) {
> > +                     error("malformed input line: %s", line);
> > +                     return -1;
> > +             }
> > +
> > +             free(line);
> > +             line =3D NULL;
> > +
> > +             if (is_exported(name))
> > +                     continue; /* Ignore duplicates */
> > +
> > +             sym =3D malloc(sizeof(struct symbol));
> > +             if (!sym) {
> > +                     error("malloc failed");
> > +                     return -1;
> > +             }
> > +
> > +             sym->name =3D name;
> > +             name =3D NULL;
> > +
> > +             hash_add(symbol_names, &sym->name_hash, name_hash(sym->na=
me));
> > +             ++nsym;
> > +
> > +             debug("%s", sym->name);
> > +     }
> > +
> > +     if (line)
> > +             free(line);
>
> The loop leaks line on a potential sscanf() error and name if the symbol
> is a duplicate or malloc(sizeof(struct symbol)) fails. Additionally, it
> should be possible to avoid allocating line by getline() on each
> iteration.
>
> I would change it to something like this (not tested):

Good points, I'll change this to your suggested version (after testing). Th=
anks!

Sami
