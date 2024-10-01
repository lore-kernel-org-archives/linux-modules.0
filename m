Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614271CDA0B
	for <linux-modules@vger.kernel.org>; Tue,  1 Oct 2024 20:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727813934; cv=none; b=Jj1B18reY9LS40L9nn5nXG/GCDYvt2i9xsw20kDOHyoPIjsuT0fOmb0tkmguvZmN8fa02n6c2pBrTWcs84ekoEUS88bTeTNUZlZdNtReI+NNwdWfq7eh4Wg0PlLvw1MyDRw3SWlhZwagwzA6q49jTTzu+Bv1y/D+9w+ENOxB4ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727813934; c=relaxed/simple;
	bh=RyRRva46Au0EaG06flnXvPQqiLcxe9w3qwxQucSjMPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K6Y2PsVBJs63Y+9iXZPhzRb1F/OF5MMtGYwxQr5fxbJ051lnYy306bLHPJPiICzGphSV/TrlirpdM3e3S7YYy4HyVdsM5tAcxCDPDnQ2TVwUtawfjX+KDzIejV3QTBAcYfIZPiIum8oAwb44HhWPVSJLFa53vz85b1MpQMCkytU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rzTnF5cE; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rzTnF5cE"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-45b4e638a9aso17291cf.1
        for <linux-modules@vger.kernel.org>; Tue, 01 Oct 2024 13:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727813932; x=1728418732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/GuuFkapqTR185OUWCoLZGw0BcekQwTFJers3DxjmY=;
        b=rzTnF5cEbvkLP3sY1Oina7JAfndb9xo6iCeNvSZzD/T0fNhc5ecL66L1LeCRf06fn/
         /rkOpdhuX87DWewavvVEowvxAl2bpxLzqz4E1D2yLi0IWMLcbfa5XLd41e5C4ervULd3
         23uOf3mRlaxLNpE8DM+XewZUT0q8U5cU7cJie1izHZM84GUAFA8ybkYfheYlywR0rB26
         rYN/SyaZR8yWdrD0wKZX40hiYKhZU7i0hYEigo4jcFLeOelDeIXZ87w2JMVLSYpCSpr5
         947ywT4jloqMC9W8fMnDdIHeASufDuB5simirHdKygm+fRLjG1K/LKSsTvSvfykHPcb/
         yVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727813932; x=1728418732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/GuuFkapqTR185OUWCoLZGw0BcekQwTFJers3DxjmY=;
        b=FlPnQQ973EXyCSalw4p+u4XaXU3ktXiPwhVABU8FAdTaoxrurNPNhp54tlp+yGBTzi
         /lTycYDJkVXc4X3hKGSr0wM1SFxa/ElUeqU9Ab24mqJqUYDJcsVqybs0J+No0YfceBCw
         CHqdVAsIUOGxlpiK8P2696g19m+Kd+xlZXHyKsxH/Zi76dZb3gaH2XUInv5qBhRDTx64
         g+NwYG6Bl/3Uzvklky79GqcpIUSxZaG3MITFcVG+ipServ4HUwpvRrk/NC4rKUHFwwDA
         MrZ57OXVhV7OkAdYsr/ILYKsKhzNK0wWLZxwSdry4e3NKotLgYCEq4ORkdPLrpWijntw
         TK6w==
X-Forwarded-Encrypted: i=1; AJvYcCUzOmhoh+KxPvqOZX/Wg3E0jglwZq4Mr3uUd1+1Fm7fi6OwYHEoD9DPwlgPZsN0BKQ54ZXkajPWHIP4JQfc@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkt/QmBUNdZpTApDVi6Cgz6iI8vlBrHHF124w5JY5CaD8jv5ik
	eO45vnHwuRNEfFTD58e3NyVutum9ZvEb62o+RSVa1Q5F0F6o8+QF6uO80PgS9Bo8U0evX/7UsJg
	vRZfR2jtnWFNOd6iIgeg9FpOJq6BUhFO+BNPt
X-Google-Smtp-Source: AGHT+IGgt6P2UjzCfEsFRuOsqPPi1mqlprj6DD1mDyXiUt6hrKmTWvB7O34383hQFNSzxcqc9hke5vvwb8pZ2vx7XYc=
X-Received: by 2002:a05:622a:8612:b0:453:5b5a:e77c with SMTP id
 d75a77b69052e-45d81709cf4mr770761cf.10.1727813932030; Tue, 01 Oct 2024
 13:18:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923181846.549877-22-samitolvanen@google.com>
 <20240923181846.549877-28-samitolvanen@google.com> <a71e018b-1dc6-4427-8f10-399d8a9a5243@suse.com>
In-Reply-To: <a71e018b-1dc6-4427-8f10-399d8a9a5243@suse.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Tue, 1 Oct 2024 20:18:15 +0000
Message-ID: <CABCJKuf4G0=XjOkagTBah+u6V7ZxbY9qdGYdqX__45bE0SeN8Q@mail.gmail.com>
Subject: Re: [PATCH v3 06/20] gendwarfksyms: Add a cache for processed DIEs
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

On Tue, Oct 1, 2024 at 2:10=E2=80=AFPM Petr Pavlu <petr.pavlu@suse.com> wro=
te:
>
> On 9/23/24 20:18, Sami Tolvanen wrote:
> > +static void update_fqn(struct die *cache, Dwarf_Die *die)
> > +{
> > +     if (!cache->fqn)
> > +             cache->fqn =3D get_fqn(die) ?: "";
> > +}
>
> When is update_fqn() called with cache->fqn being already non-NULL?

In patch 16, because we need the name before process_fqn() is called,
and if we end up outputting the name after that, cache->fqn is already
non-NULL.

> In general, I find handling of cache->fqn slightly confusing, mostly
> because the member has three states: NULL initially,
> a statically-allocated empty string if the DIE doesn't have a name and
> a dynamically-allocated non-zero-length string otherwise.
>
> I wonder if it would be possible to reduce it to two states: NULL
> initially and when the DIE doesn't have a name, or a regular string.

I also thought about it, but using an empty string to represent an
unnamed DIE and NULL to represent an uninitialized value seemed the
most reasonable option.

> > +static inline const char *die_state_name(enum die_state state)
> > +{
> > +     switch (state) {
> > +     default:
> > +     CASE_CONST_TO_STR(DIE_INCOMPLETE)
> > +     CASE_CONST_TO_STR(DIE_COMPLETE)
> > +     }
>
> Nit: I suggest to move the default case out of the switch statement:
>
>         switch (state) {
>         CASE_CONST_TO_STR(DIE_INCOMPLETE)
>         CASE_CONST_TO_STR(DIE_COMPLETE)
>         }
>         error("unexpected die_state: %d", state);
>
> This way, if someone adds a new value in die_state and forgets to handle
> it in die_state_name(), they get a compiler warning.. or a runtime error
> later.

Sure, I'll change this.

Sami
