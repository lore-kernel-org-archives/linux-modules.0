Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1CE1AD3EF
	for <linux-modules@vger.kernel.org>; Wed, 28 Aug 2024 23:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724886567; cv=none; b=kZGhLx41Imy6o+FiIJRqJDq/NvAk76tj1+hPRR/qj3WbtFlMgGwuxiAtE5OdA+5KaLl7XuWT0IrXpRL3dCXSxMH+UEF/M/jctaWzsXio6U1AzEEnqdu1yrNc4KWcHnoJ2MtlQXjf7XMcfc8bFzfzk5fON7NrEtTsoQ0jTQ1t+D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724886567; c=relaxed/simple;
	bh=RZmcXzwnrRhYwDoAQj1Jxhe7OhhEeGVabMOYn+OKJEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VobjL12NP4IMWtnaMJ6lsr6d4nBY4OU8nX4wXQZcDGVp2TUlYLpK1/awvn9CBuB6TvNsuPoi//BRkTSiaZc5qKwfTyeiTxJwO1+EBqZ0WduU69Zc7mhgBnOdxN1zksal7VB4ZMYlUGgVyZToS8PDWMbh21EUyEsOE5p4vIIhOkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H4Mzj55Y; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H4Mzj55Y"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-201fed75b38so38715ad.1
        for <linux-modules@vger.kernel.org>; Wed, 28 Aug 2024 16:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724886565; x=1725491365; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bF9tb8hwDYR6xa7gB1x7sZNbhUYJUgSYOVOAb5zjrCw=;
        b=H4Mzj55Y4gMWJjD1yLPZX94RAzWQmOtv7QN7sKScGjy84ZXuLZl7MRRSW+5n14ADLp
         1mv1DSXKXTcK9T4lsvGpZsPosjeUN3M+jNiiBszsGLZTfRzDKl/VC8U0hvjOuRLwfQBP
         Hm1h5BOIZfPcb7Mrk0/8ENbwdZEijPzrw/qWtU9d8Q8P8np7DcjyDIzVMn+eCsVS9rqY
         XgrsEuQX3KS7KTat6SaZ1TNqgHSjKoMKtpXROs9+3lDy47NoTCfcQzh7c6oUYckFX8Ah
         l5fYnYM+0oqAS41V5b59z6BSEwP7RvB186VBIGi5eNx23qGQO5LcFTdj4w+3vvCA4Vih
         kNGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724886565; x=1725491365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bF9tb8hwDYR6xa7gB1x7sZNbhUYJUgSYOVOAb5zjrCw=;
        b=mM6UasGbatSoj3OHBlQ6bNazXazeVMr3CWQRjhsIcWRxcHvsge++BRY6k09dQX8eOL
         vVJ7xrdzE51cH1Z+ii5MHas7wAvkl2mQmdi066FEP9Xtd1JPGUSTEuXAiwqI39DWoOs+
         fhI/iTtetATRBmb5vHoW3wKuTdL91YuAuBEgrSxt/E60brtMcJ0IhoQy/87AugBhSTuW
         NElRqx+TVMKTl6rriWlTat/XMPB9BAKOrTioF8mkBiE7EAsdMQRnYS4N8njDCzBYZ+Eg
         GVRjE/0/KXQUPWptzmdh8/ZFjQK9SuXRlT8usSboKgKMOKpB1rlL4iBoXssUjQs836vt
         A5Hg==
X-Forwarded-Encrypted: i=1; AJvYcCXdFWmd5U7T7ozYOIc82El7ZdToBFag6jeHMBFOkWzlkiMqxp6u2MyMGc8+oa+lzkRk5kCDWQIHPkDjf3jS@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr7Zvk545xyF2U8prBHF8FNlE4UxtOrRQKFWWTjR4cBbqtxkD1
	QRTOICDbruXmiNdk0KUixnpZx1SWeHnYdssH76WOv/GnpGT25g/PGblstHwGcA==
X-Google-Smtp-Source: AGHT+IGefsWlldxzVDyfJdh6ODHqSR4DIkOY4bryKmhorJbglzA63HVpwHsAO+Qawqv6PlgLxud4xg==
X-Received: by 2002:a17:902:ce8a:b0:200:7d11:e8e3 with SMTP id d9443c01a7336-2050d1f0c57mr1140385ad.14.1724886564314;
        Wed, 28 Aug 2024 16:09:24 -0700 (PDT)
Received: from google.com (226.75.127.34.bc.googleusercontent.com. [34.127.75.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a5b56sm5350b3a.57.2024.08.28.16.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 16:09:23 -0700 (PDT)
Date: Wed, 28 Aug 2024 23:09:19 +0000
From: Sami Tolvanen <samitolvanen@google.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Matthew Maurer <mmaurer@google.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>, Neal Gompa <neal@gompa.dev>,
	Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>,
	Asahi Linux <asahi@lists.linux.dev>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 02/19] gendwarfksyms: Add symbol list handling
Message-ID: <20240828230919.GI2130480@google.com>
References: <20240815173903.4172139-21-samitolvanen@google.com>
 <20240815173903.4172139-23-samitolvanen@google.com>
 <95db3178-a2ce-421e-8024-afd7fa3359a3@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95db3178-a2ce-421e-8024-afd7fa3359a3@suse.com>

On Wed, Aug 28, 2024 at 02:35:29PM +0200, Petr Pavlu wrote:
> On 8/15/24 19:39, Sami Tolvanen wrote:
> > diff --git a/scripts/gendwarfksyms/dwarf.c b/scripts/gendwarfksyms/dwarf.c
> > index 65a29d0bd8f4..71cfab0553da 100644
> > --- a/scripts/gendwarfksyms/dwarf.c
> > +++ b/scripts/gendwarfksyms/dwarf.c
> > @@ -5,6 +5,48 @@
> > [...]
> > +
> > +static bool is_export_symbol(struct state *state, Dwarf_Die *die)
> > +{
> > +	Dwarf_Die *source = die;
> > +	Dwarf_Die origin;
> > +
> > +	state->sym = NULL;
> > +
> > +	/* If the DIE has an abstract origin, use it for type information. */
> > +	if (get_ref_die_attr(die, DW_AT_abstract_origin, &origin))
> > +		source = &origin;
> > +
> > +	state->sym = symbol_get(get_name(die));
> > +
> > +	/* Look up using the origin name if there are no matches. */
> > +	if (!state->sym && source != die)
> > +		state->sym = symbol_get(get_name(source));
> > +
> > +	state->die = *source;
> > +	return !!state->sym;
> > +}
> 
> Sorry, I don't want to comment much on function names.. but I realized
> the name of is_export_symbol() isn't really great. The "is_" prefix
> strongly indicates that it is only a query function, yet it changes the
> state. It makes its caller process_exported_symbols() hard to understand
> on the first read.

I see your point. How would you make this more obvious? get_ doesn't
seem entirely accurate either. match_ perhaps?

Sami
