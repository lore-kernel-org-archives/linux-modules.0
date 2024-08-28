Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E631ABEA9
	for <linux-modules@vger.kernel.org>; Wed, 28 Aug 2024 21:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724882336; cv=none; b=MDcnYrUiawGdQenSBlVLKHhXByRCFPv0lJJh3pmEWvpcBFJQSICgeJ5DIMyPSJknv/PNqpjngEaYs40rXDcyOgVF+r2Exsh01xAAood5GBUDhI2eGVPfH40m3Nrs/Le7AwqUI+gvbSQ/Vzq9bF2N//oBOtJgqXJ9xDL8RwX10tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724882336; c=relaxed/simple;
	bh=o+gAn/ilZ3C56975j8rPvUkgN8dfBSz6M6D5Wf/lSRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLB4FKnoAMmwrLAEyQ/BXTcrS0MgUXLidNmmsgraSXzv1mn4oAwgXWwdEbYfvtFWw2ml0W9QC9Cr9YFAOdvLBYxEpWuYzERTbnycysqirpAUdz7Tq5mwliU/B4Tzl79Cp207mRqNUL//56KMYf5uj8SnuW3ScveIJ+5JcwpphiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v+V4kCIM; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v+V4kCIM"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-202018541afso27735ad.1
        for <linux-modules@vger.kernel.org>; Wed, 28 Aug 2024 14:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724882334; x=1725487134; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nnGSwXCYQc4Hwc+sfrpcLFkK6Wt2k6zs0AyOgifdXGg=;
        b=v+V4kCIMaDH5LZGtMEqJHuPmAHofgBF4kgzrNaRoL7jJ50gC6axGbUpQKImEJYK1oU
         MZdCnnBcTr7MomTjEriinbhpLMaZlRiRnvNWTyNf7QQfREgJygui0Ju+pN95ngpp9tjH
         rOYDQTqFaagJFBwbGyH9jwhsb7SG+yh4P/U9jrSSPc4gDvEnRl3nmVz+8WZLdiQw36Ge
         +EJbo8D4UskccJHKoMZDtmW7nVxwTu+YL0ukoJAL/t5awf//J9zZ3i44VW+zcn7t6m2I
         KgfjFyCc3TpLZqMszFA2tPr9cfrt7hYy4jqLoWFDUGzPBfKyy/R2xp/vFTFWya32Aqhs
         61Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724882334; x=1725487134;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nnGSwXCYQc4Hwc+sfrpcLFkK6Wt2k6zs0AyOgifdXGg=;
        b=iPvzvwWlHOgc118sotToeQmCaYcN+izUH0J4lRLbfz+ZrnroKn2hmz28/CrAW5AzYY
         p+9HGWphjTxLOhuwCFL34uugYI4qhxPNAEUT7DCavRIWGk3tIz5RnTU/jO5azpDUtErA
         N0hA2s/af+ZbZGuvLDv/916V5Lq7u3tT0NvYjdHuIUzjMbGrTSXI86Nf73defP7nreuG
         VG4z4X6ZaPchkDl+oufYnSP+9yLHiGkmr4awCF3CPCshcU+48CiWlAwMf1atbY/e4fPJ
         Gc4LTk118vUf90/lDADbemG368b6wvb9aKrFSJnfcYLIbYuYuHY0SFAwh8iIS2FGUWEu
         th2A==
X-Forwarded-Encrypted: i=1; AJvYcCUQQl1+e4ktjH0QRcNQwFWF2+MjDwzP0sSEDy8cDZ3d/NvdhWlZgGrfiR8vbFlGuAMuNrT0ASFfrH3WMqdM@vger.kernel.org
X-Gm-Message-State: AOJu0YzVkzUzDih8gicD/DSM/g97Ae7MwNk0TTrkSlQ2HbcJwx2Cw3zG
	7xjtOyxiVapcwkhnAPxouHIFY5+Rey1EVbPmd+WOvT+ed8Kaq4EDDSSdJ0lIYQ==
X-Google-Smtp-Source: AGHT+IGVfzjHYyRASEld6yxxMpC9vJZBxYqjU0CXEpHxInbohWJsi3m/XdXyujxzXPDjs/QQJYYJow==
X-Received: by 2002:a17:903:604:b0:202:883:c0d with SMTP id d9443c01a7336-2050d2366demr1037415ad.24.1724882333453;
        Wed, 28 Aug 2024 14:58:53 -0700 (PDT)
Received: from google.com (226.75.127.34.bc.googleusercontent.com. [34.127.75.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038560dfaesm103172195ad.223.2024.08.28.14.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 14:58:52 -0700 (PDT)
Date: Wed, 28 Aug 2024 21:58:48 +0000
From: Sami Tolvanen <samitolvanen@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Matthew Maurer <mmaurer@google.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>, Petr Pavlu <petr.pavlu@suse.com>,
	Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>,
	Janne Grunau <j@jannau.net>, Asahi Linux <asahi@lists.linux.dev>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 04/19] gendwarfksyms: Add support for type pointers
Message-ID: <20240828215848.GE2130480@google.com>
References: <20240815173903.4172139-21-samitolvanen@google.com>
 <20240815173903.4172139-25-samitolvanen@google.com>
 <CAK7LNATb8zbwEVgM+_=CaYSysov6YBMbKjy8+t8CrRA_72jxuQ@mail.gmail.com>
 <CAK7LNAQBO-VA8G9uumwH5m9idQofY1ZR+hnNfL7y4P3m16xFNQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNAQBO-VA8G9uumwH5m9idQofY1ZR+hnNfL7y4P3m16xFNQ@mail.gmail.com>

On Wed, Aug 28, 2024 at 04:15:03PM +0900, Masahiro Yamada wrote:
> On Wed, Aug 28, 2024 at 3:50 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > On Fri, Aug 16, 2024 at 2:39 AM Sami Tolvanen <samitolvanen@google.com> wrote:
> > >
> > > The compiler may choose not to emit type information in DWARF for
> > > external symbols. Clang, for example, does this for symbols not
> > > defined in the current TU.
> > >
> > > To provide a way to work around this issue, add support for
> > > __gendwarfksyms_ptr_<symbol> pointers that force the compiler to emit
> > > the necessary type information in DWARF also for the missing symbols.
> > >
> > > Example usage:
> > >
> > >   #define GENDWARFKSYMS_PTR(sym) \
> > >       static typeof(sym) *__gendwarfksyms_ptr_##sym __used  \
> > >           __section(".discard.gendwarfksyms") = &sym;
> > >
> > >   extern int external_symbol(void);
> > >   GENDWARFKSYMS_PTR(external_symbol);
> > >
> > > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> >
> >
> >
> >
> > Commit ddb5cdbafaaad6b99d7007ae1740403124502d03
> > had a similar idea; it has a reference to each
> > export symbol, including the ones defined in different TUs,
> > but in assembly code.
> >
> > Didn't it suffice your need?
> >
> 
> 
> Presumably, this is an unfortunate duplication, but I do not have an
> idea to avoid it.
> 
> The symbol reference in assembly code works in *.S as well as *.c.
> 
> The C reference will pull-in the debug info, but it will not work in *.S

Correct. I'm not a huge fan of the extra reference either, but I don't
see a cleaner way to ensure we always have all the types in DWARF.

Sami
