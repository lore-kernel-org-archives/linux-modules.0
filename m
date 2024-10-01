Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667761CB32B
	for <linux-modules@vger.kernel.org>; Tue,  1 Oct 2024 21:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727817686; cv=none; b=IR1jD2hPQlDUZKzAw0LmDhGTCp39G/nWFKC+H1jEmT5spO4r/MDiPiji5kYg3P9uopAogi/2p1WvDmQCU34KC65rnVk1OLkS28Hhx887VTzfD3r2O3D4IHqkVCqncac8HKQ9wERThi2MJlLwedm5koFwsFoJq5yv63DZEIyCva4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727817686; c=relaxed/simple;
	bh=EQjfFUP6V15WHbsMfHvl8IITEfL2R5znZ0//S7cqib4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hkznMtE11lye3dGN5fzscv/weYFJg9RavDrZkX/xn31tICyvXJVxiyg+dlEON0twj15RFXHo3wXic+PKaayJYOThGekXHcUrlVWII/gGeQAaR/COh+t4oVAdjuQrx5H9A+lCtv7ZW10eTdpUYUSCDncba8q2+5XRVEuRQKWo4zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FvE7kiBX; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FvE7kiBX"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-536552fcc07so3170e87.1
        for <linux-modules@vger.kernel.org>; Tue, 01 Oct 2024 14:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727817683; x=1728422483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hoWrsU7z+qdIIFDpkMHhN4PhrREusH4jkiAl/mJtNdI=;
        b=FvE7kiBX8ZtLZa9UpwtJfNIQrFOiEzSoWeAXMqTVzC/H2VHvnD/MOVgjvO0BPoNHTZ
         DLgqN3x8qnWckY/gGPNv/Bwd2FK9OnqD3D6YIAbjWpTofZuNBgtspGjf7KejVXlwlYMo
         39cx8VrQsjE7n66dpjeoz+zzskC2COm2H5qxWCBxWj/IJf2S2qOom62uSkEQgh1CmEK4
         ks7Q6jEiCTLjB5NGmyjK5mhTnyS7+epwMCv8pMAbYhqCYY8B0H1yzi/lhA2XG5bP/deA
         i2BIFNwkzAwJO7O4KRmSVFAVvNG+TPQ4k3xCujBD4hFgvH58NuF8NJEQPhSRooSCldoV
         l6/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727817683; x=1728422483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hoWrsU7z+qdIIFDpkMHhN4PhrREusH4jkiAl/mJtNdI=;
        b=UXyKHsKEAPYsv6UZYE66Vo6K1y31YmUqLXM+1430YH2Uej6bv6Z9hNwAwWE7WR7WmZ
         xVe4/JUBl+X2sYGGiWKG6yw0WV4O3jvrwHmGuMxCm6Fkca+XrGF8/JsQHTFbzz2SDcRa
         KZ32LkFIXDUR5FOXLW6i3SS9opzyjVaew2hRM/d7dxHEOyRME5r4rBM9VLyQeVexEDeI
         ozw7IYJmfq654Tk5MxCi8h74b+JSDf8rCygbSctmoXKLA9BXsNDSMOnozMqXLJPjHUWD
         1Dj0WBf0Xx5ScAs4efeU/OGJJoAyhE7j6kpvfLFzrgcA1phP/eS4YfcwPr6WkSpufPTn
         vJ8A==
X-Forwarded-Encrypted: i=1; AJvYcCVfbYqAFJOjLx5kXPq5sHKgAOD1EAOQMxZI4StkYitWGbNjqY3BD3RW/0VXMKV4xMRbcxZwIRjpTqMDwnnY@vger.kernel.org
X-Gm-Message-State: AOJu0YxZwrLIaB24IglsqdA5UoIFn+UBHVWrdmWURcK9uQmShwCw62cB
	09M7WjlHZH0IWabDweJtQjyQMSP9Bo5WB8HxINh95h2y911jbP7L2yEB+r2Woce4IB45vaizLbA
	gktkZ+31UOx+NVwrPpkCAZgbx5uUmE4CmWZkO
X-Google-Smtp-Source: AGHT+IGgP22tnj35LCYM0fX1Dz0p+NCTjOYdsvD+bPVZjH0BMXExjm00WWuhd0WmAK7axQvJ/g54h5N5+4LKt45smrY=
X-Received: by 2002:a05:6512:239c:b0:539:9ff9:5cbe with SMTP id
 2adb3069b0e04-539a0f0695cmr152225e87.4.1727817683249; Tue, 01 Oct 2024
 14:21:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923181846.549877-22-samitolvanen@google.com>
 <20240923181846.549877-32-samitolvanen@google.com> <f0eee8a9-766a-463c-bc36-676e49efe950@suse.com>
In-Reply-To: <f0eee8a9-766a-463c-bc36-676e49efe950@suse.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Tue, 1 Oct 2024 21:20:41 +0000
Message-ID: <CABCJKudn0WcOAg89ouTQoEHQC5n90SdetxHYG7GvQWmWo6WQ5A@mail.gmail.com>
Subject: Re: [PATCH v3 10/20] gendwarfksyms: Expand structure types
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

On Tue, Oct 1, 2024 at 2:16=E2=80=AFPM Petr Pavlu <petr.pavlu@suse.com> wro=
te:
>
> On 9/23/24 20:18, Sami Tolvanen wrote:
> > +static void process_variant_type(struct state *state, struct die *cach=
e,
> > +                              Dwarf_Die *die)
> > +{
> > +     process_list_comma(state, cache);
> > +     process(cache, "variant {");
> > +     process_linebreak(cache, 1);
> > +     check(process_die_container(state, cache, die, process_type,
> > +                                 match_member_type));
> > +     process_linebreak(cache, -1);
> > +     process(cache, "}");
> > +}
> > +
> > +static void process_variant_part_type(struct state *state, struct die =
*cache,
> > +                                   Dwarf_Die *die)
> > +{
> > +     process_list_comma(state, cache);
> > +     process(cache, "variant_part {");
> > +     process_linebreak(cache, 1);
> > +     check(process_die_container(state, cache, die, process_type,
> > +                                 match_variant_type));
> > +     process_linebreak(cache, -1);
> > +     process(cache, "}");
> > +}
>
> For variant types, should the tool worry also about DW_AT_discr and
> DW_AT_discr_value?

Hmm, I initially thought they were not necessary, but looking at the
rustc DWARF output a bit more closely, it might actually be a good
idea to include this information. I'll add these both, although since
DW_AT_discr just points to a member DIE, it's probably enough to just
process all child DIEs for the variant_part instead of limiting
ourselves to variants only.

> > +static void process_unspecified_type(struct state *state, struct die *=
cache,
> > +                                  Dwarf_Die *die)
> > +{
> > +     /*
> > +      * These can be emitted for stand-elone assembly code, which mean=
s we
> > +      * might run into them in vmlinux.o.
> > +      */
>
> Nit: stand-elone -> stand-alone.

Oops, I'll fix this too. Thanks!

Sami
