Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CC415EFB1
	for <linux-modules@vger.kernel.org>; Tue, 18 Jun 2024 20:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718741976; cv=none; b=Ki6EUx3HOqBuBPkaKSYsu2jfNotOM+hJlkc1dXwm59H8joJFwF1c+IaDUup0eSAqss2nP6WXxRfNzS7GEj1Uv9FEhmPWYYNf3HO3Yc455F6zQdmaMsGJnW7lebqIWmUZnvjTsTuTcpBwZILGv2M6LGrbxNLTv+GneKJmJ4M94/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718741976; c=relaxed/simple;
	bh=94jbta9RKhaSlDyNCdrM049X1zIhYddMYsT9+9JpVCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDrVIOEYDBIIhebq/ck1ervXQkfqTe5j+E0iEaWDdRqIlm9unEOft9lXgV5yZF1YyvCgtcXck1rb2jWiw9B2/E3NuwJY4Kpq18PkMxwdf6Or9Z7OGWIHUyeNLP0rDQ9aA2cyVFy0uKFZlzCrIuDc4snk0suXskGi9gWsXpNc1Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nCPgnJkx; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nCPgnJkx"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f44b5b9de6so46671185ad.3
        for <linux-modules@vger.kernel.org>; Tue, 18 Jun 2024 13:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718741973; x=1719346773; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mV+obHqwFZWixpRN1P9+xUT02aptZp/gmo4vDnJf/nM=;
        b=nCPgnJkxijXsbXuXvnvc6dhkOchG+VYl5E2NLv40o3JUTEelBIH/oPgQMBl8kp4Obi
         gBI4kR0m9626Uh4ZNV/yENqRuzP5Qb/E7mgHg4aaETA6KRTKw+xDt1BMNvFJ/MTyUjhV
         Rft47qohh8WZIsQeiPKkOIJHjNkZAXeugXCFPQW5gZRvF4/C+ZSGyeYmeqsFbegCiuow
         SX9r4+IhIw4Q2AwDEJ3t39sZL41E32/e93hCTCBqf1/MnmOH+X7zsoKD26WRkUHC8P32
         OoT2O8D695PeoTyJ8HXNSSPyr0xUDHhKKZ8mYmCP94X6K2E4lUQvTLMz+fMxKJaik9aH
         OuQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718741973; x=1719346773;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mV+obHqwFZWixpRN1P9+xUT02aptZp/gmo4vDnJf/nM=;
        b=ubHKcas+KKH024Mq0UJqfI4HyMGgi7DCXdd0K6G1wEHh62WKaCA7gRIL0jQGKLq9L1
         mjytI20pBv6N4vFZ/yrMSAjnKsHrKm/KHwPUhClU8If0HdfTp/SWyN/pu6apDsoEOHTK
         qZmN0zFeSKiZWwBoom3yJkvRVneGcMikzsskLJxVpuDSrjrwqJ7LPUfiUpxs20Slpr//
         QiBKjREAt29zq0+PuVyo/9OKkZrgQwsOudGjT6S/MhHlnIubIRmwiL4m+vEgGC++kx36
         F9pg5YnTyDjiR++6hMXQBmo8heKsHBh5hWxiqwUx1awcIaJ0a7PueXj0pEVwCFfKdYOX
         rVuw==
X-Forwarded-Encrypted: i=1; AJvYcCWv4ac/2BHw2vUumaRbBj2Cwu51735CQkck3s6Cy4dDYEbgIovyGHGPEb7u1cvzVXEsWvm9zsZhFIf3hoWKtyqtasEur2WbvqjHPCbN5w==
X-Gm-Message-State: AOJu0Yxie/C1/z57kJ6R68cp0QEh6mrrzyesmY/bd3KV947lvBJckB1W
	Ulq/XukdcfwAoFptQE6rlbOdcXCyEwbRAD8z/yHP+W0o54A/boeGwwe1xo0I4Q==
X-Google-Smtp-Source: AGHT+IHyLOxXtzm0QV3I4PfO8dmxnhFR4zmQ5ve3IHxTlcknskE8vGuxSlOyocduRsCXhhHzmgHp0Q==
X-Received: by 2002:a17:902:d504:b0:1f6:7fa4:e064 with SMTP id d9443c01a7336-1f9aa46e5b5mr7283155ad.61.1718741973072;
        Tue, 18 Jun 2024 13:19:33 -0700 (PDT)
Received: from google.com ([2620:0:1000:2510:5dfa:e7d1:8470:826c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f43ce3sm101374865ad.278.2024.06.18.13.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 13:19:32 -0700 (PDT)
Date: Tue, 18 Jun 2024 13:19:27 -0700
From: Sami Tolvanen <samitolvanen@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Matthew Maurer <mmaurer@google.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 00/15] Implement MODVERSIONS for Rust
Message-ID: <20240618201927.GC1611012@google.com>
References: <20240617175818.58219-17-samitolvanen@google.com>
 <2024061842-hatless-viewpoint-5024@gregkh>
 <CAK7LNAS_OsXeoDRoMbdXUGY=-jhuoHgo-L6W79n+Kb4G4xEBwQ@mail.gmail.com>
 <2024061828-tricky-playtime-f844@gregkh>
 <CAK7LNAR9qgk2AxtMUMiOw-jYZyjmj6aVDPH25aPa4K-1jQjOFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNAR9qgk2AxtMUMiOw-jYZyjmj6aVDPH25aPa4K-1jQjOFw@mail.gmail.com>

On Wed, Jun 19, 2024 at 04:03:45AM +0900, Masahiro Yamada wrote:
> On Wed, Jun 19, 2024 at 2:18 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Jun 19, 2024 at 01:50:36AM +0900, Masahiro Yamada wrote:
> > > On Wed, Jun 19, 2024 at 1:44 AM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > That's cool, can the C code be switched to also use this?  That way we
> > > > only have one path/code for all of this?
> > >
> > >
> > > As the description says, it requires CONFIG_DEBUG_INFO.
> > > We can strip the debug info from the final vmlinux, but
> > > I guess the build speed will be even slower than the current genksyms.
> >
> > For people who want genksyms (i.e. distros), don't they normally already
> > enable DEBUG_INFO as well?  The problems of genksyms are well known and
> > a pain (I speak from experience), so replacing it with info based on
> > DWARF would be great, I'll gladly trade off the DEBUG_INFO issue for
> > stablilty!
> >
> > thanks,
> >
> > greg k-h
> >
> 
> 
> 
> I do not think gendwarfksyms is a drop-in replacement,
> because it relies on libelf and libdw, which will not
> work with LLVM bitcode when CONFIG_LTO_CLANG=y.
> 
> His "Let's postpone this until final linking" stuff will
> come back?
> Then, vmlinux.o is processed to extract the CRC
> of all symbols?

I agree, this won't work with LTO unless we process vmlinux.o.

> In my benchmark, this tool took 3.84 sec just for processing
> a single rust/core.o object.

To be fair, Rust currently exports all globals and core.o has 400
exported symbols as a result. During my brief testing, this tool is
faster than genksyms for normal C code.

> I'd love to see how long it will take to process vmlinux.o

It's obviously going to be quite slow, my defconfig vmlinux.o has
14k exported symbols:

 Performance counter stats for './tools/gendwarfksyms/gendwarfksyms vmlinux.o':

        371,527.67 msec task-clock:u                     #    1.000 CPUs utilized
                 0      context-switches:u               #    0.000 /sec
                 0      cpu-migrations:u                 #    0.000 /sec
           231,554      page-faults:u                    #  623.248 /sec
   <not supported>      cycles:u
   <not supported>      instructions:u
   <not supported>      branches:u
   <not supported>      branch-misses:u

     371.686151684 seconds time elapsed

     370.534637000 seconds user
       0.987825000 seconds sys

The tool is currently single-threaded, so if we really want to go this
route, it could probably be made a bit faster.

> And this occurs even when a single source file is changed
> and vmlinux.o is re-linked.

I suppose anyone using LTO already knows it won't be a quick rebuild
though.

Sami
