Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205A61FA8DE
	for <linux-modules@vger.kernel.org>; Tue, 14 Jan 2025 18:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736881108; cv=none; b=HYN0Bubwvmo7Frp0kzr2KosP1+Phoh8xNiaTcYYq1ttPcwMQm7kLW7+QoeP2f7UFSSiqmzs65kp1Yysz/KPvNJliS9h6H6UIfL3x4Qld06VrSJzwT0JrcZ/YeeVvS/8g1xX2Nz8yBO9/EZzMKVA10NFxsM36iHNEYcjMu7+XjG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736881108; c=relaxed/simple;
	bh=iKe/Ir7F11LNiqHDMJ30bCROVh05nyv6d7BmrLXKNNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjqEuVRo08OOZk1YkiIwythVw6YpugNC/QPc+CTseK0+OkLpZfpswgsaJlERoeEvnZSaLDyIsV5zGijB7xMXVTNxY6Y5cNyyOoX0ehviyn+bRIV8HnPvbZaTqvzVhGnO4rRZm/XJ4p8c5uhUzhj8T1PhAowmFYlAODmo/WqgIIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sv3uIoG+; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sv3uIoG+"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-215740b7fb8so213995ad.0
        for <linux-modules@vger.kernel.org>; Tue, 14 Jan 2025 10:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736881104; x=1737485904; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t2CWdiE+Y588cATxDxllUErMB/2Ly3FWAF67BGEJO/4=;
        b=Sv3uIoG+7ybTo6/20hlUgLSpZCTtlmaGT0HRF+CCEQ6gd6WATFrWywTTBPM/9I6CTg
         /5rMAGJMR/9JIP8pYgo0KsULbGgvxqtI8gW9gVm3HSUDxExTLGoCLwxkAlwj/oI2DuIQ
         2/OnjPOYCGMRrOuU0JLYMVdObEcdW+1WYIINM1IiKIpxELyRUfRKcYiG3FxJxF+Q/Fed
         ChHbFFIqt1X87kbBknso6RhuMUHWSRP4VtKf/9iWlmN+s4J5MyqAtfXkQVb8zb+GT8xn
         wtoTw3h+foApVHIq6BRBg9974sDe1rM0Qu/n71XDuVWJFI/RaDO7OXHqMGVG2gAtTxLZ
         sz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736881104; x=1737485904;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t2CWdiE+Y588cATxDxllUErMB/2Ly3FWAF67BGEJO/4=;
        b=HpqOH9Us47LoS4OH/sVqsmWQGn4Q9v2vcmcYIj97DbPmGSl+/mo+Rmd+sFDFfz7XJr
         xHr5BjfLfNEBD/itWVlI2lXldujFh/6WRBwbWHoGhBZ3/NPx5pSO52CpdDbHvGfnOLZJ
         gtpVbzFgVbW5ZgcxmvBc4zR+ePqU/feuKgt/pXv4HZ/cd2j5Q2/OQd6rL64uynkXR498
         BYGNZD9kZ6X6Tw+Elewf1jrQmCVzTOcfiwNuoBLIswQlJHz3FLAJZovNflit13R2+HnM
         hSGsmKGw+2XHScOBnnpZfKESMIh4dQht6LH0CbNYUzau3+34VEtbEpwJdkihejub7gtt
         OouA==
X-Forwarded-Encrypted: i=1; AJvYcCX/3d53lAHzN8IZNyld2uXiKFFsIz1U88JhnmfxGpQuAKpztbui37nM+M7zFjKuzKJ6/+0DLOFOGf+6gj53@vger.kernel.org
X-Gm-Message-State: AOJu0YzImdnkWM4e/cEUixN5i731Ba6aIvSa0fckW88+iGKbkPi4ddDj
	3Q+Ia2H9s4yXrAgqkDEgjH+ksG0SyzkE7UVFQsntn00wXU1oRN+V2sDIOddphg==
X-Gm-Gg: ASbGncuj4rlul7gCQHzLpELH3+CxM8Xz/9RZFdyyAw2f5sc1+rMnSFc8aOAjMMYMHHq
	WvGwvKK++0n5dJ6uSK9FEQhVQAtKAeo5QOXySF5RwGRDXcz4OMPZbM7jXmu7e6oOMKiOsykFQer
	yfqEa9+WT4vJaIsEdnaOW33Sql4C0nmT4G9nNmFWO5suTNkVxoqM7cxKBbEBWC88ImwABJ0xbQL
	WK7rtUqUSWuvtYhZ0bHhWXALNtKelghCILHq5pUsj0lcp8MCmDRUhzMwJwtDpATBc/MACaSc41J
	IzTnsxrr08hN/t+dQj3/FtKS50Q=
X-Google-Smtp-Source: AGHT+IG/013Oj515jx+bAnxAgTCQ+vTnK59fPTZt8oVE2ZAEpSVnb9QRz1EEDwXZHaYE7mba9SJ2Ig==
X-Received: by 2002:a17:903:492:b0:20b:5e34:1850 with SMTP id d9443c01a7336-21bf0e598d9mr26285ad.23.1736881104251;
        Tue, 14 Jan 2025 10:58:24 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f2339dasm69151185ad.177.2025.01.14.10.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 10:58:23 -0800 (PST)
Date: Tue, 14 Jan 2025 18:58:19 +0000
From: Sami Tolvanen <samitolvanen@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Matthew Maurer <mmaurer@google.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Jonathan Corbet <corbet@lwn.net>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
	linux-kbuild@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v13 5/5] rust: Use gendwarfksyms + extended modversions
 for CONFIG_MODVERSIONS
Message-ID: <20250114185819.GA2222429@google.com>
References: <20250103-extended-modversions-v13-0-35d87c65ee04@google.com>
 <20250103-extended-modversions-v13-5-35d87c65ee04@google.com>
 <CAK7LNATGw-m_dcdjTBHsFwCZh7mTt8q8yNZQ7VFP=hMU8NvUvg@mail.gmail.com>
 <CABCJKuf-w1puUsypU-cr5BH8uvCdPPQmhZZ1qVKDDg3Y-iQhSg@mail.gmail.com>
 <CAK7LNASh4xMN8nN5vwR6R1OCNW9u4MJz=CSwW4_4hvFOhczmWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNASh4xMN8nN5vwR6R1OCNW9u4MJz=CSwW4_4hvFOhczmWA@mail.gmail.com>

On Tue, Jan 14, 2025 at 10:22:15AM +0900, Masahiro Yamada wrote:
> On Tue, Jan 14, 2025 at 5:04 AM Sami Tolvanen <samitolvanen@google.com> wrote:
> >
> > Hi Masahiro,
> >
> > On Fri, Jan 10, 2025 at 6:26 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > >
> > > On Sat, Jan 4, 2025 at 2:37 AM Matthew Maurer <mmaurer@google.com> wrote:
> > > >
> > > > From: Sami Tolvanen <samitolvanen@google.com>
> > > >
> > > > Previously, two things stopped Rust from using MODVERSIONS:
> > > > 1. Rust symbols are occasionally too long to be represented in the
> > > >    original versions table
> > > > 2. Rust types cannot be properly hashed by the existing genksyms
> > > >    approach because:
> > > >         * Looking up type definitions in Rust is more complex than C
> > > >         * Type layout is potentially dependent on the compiler in Rust,
> > > >           not just the source type declaration.
> > > >
> > > > CONFIG_EXTENDED_MODVERSIONS addresses the first point, and
> > > > CONFIG_GENDWARFKSYMS the second. If Rust wants to use MODVERSIONS, allow
> > > > it to do so by selecting both features.
> > > >
> > > > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > > > Co-developed-by: Matthew Maurer <mmaurer@google.com>
> > > > Signed-off-by: Matthew Maurer <mmaurer@google.com>
> > > > ---
> > > >  init/Kconfig  |  3 ++-
> > > >  rust/Makefile | 34 ++++++++++++++++++++++++++++++++--
> > > >  2 files changed, 34 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/init/Kconfig b/init/Kconfig
> > > > index c1f9eb3d5f2e892e977ba1425599502dc830f552..b60acfd9431e0ac2bf401ecb6523b5104ad31150 100644
> > > > --- a/init/Kconfig
> > > > +++ b/init/Kconfig
> > > > @@ -1959,7 +1959,8 @@ config RUST
> > > >         bool "Rust support"
> > > >         depends on HAVE_RUST
> > > >         depends on RUST_IS_AVAILABLE
> > > > -       depends on !MODVERSIONS
> > > > +       select EXTENDED_MODVERSIONS if MODVERSIONS
> > > > +       depends on !MODVERSIONS || GENDWARFKSYMS
> > > >         depends on !GCC_PLUGIN_RANDSTRUCT
> > > >         depends on !RANDSTRUCT
> > > >         depends on !DEBUG_INFO_BTF || PAHOLE_HAS_LANG_EXCLUDE
> > > > diff --git a/rust/Makefile b/rust/Makefile
> > > > index a40a3936126d603836e0ec9b42a1285916b60e45..80f970ad81f7989afe5ff2b5f633f50feb7f6006 100644
> > > > --- a/rust/Makefile
> > > > +++ b/rust/Makefile
> > > > @@ -329,10 +329,11 @@ $(obj)/bindings/bindings_helpers_generated.rs: private bindgen_target_extra = ;
> > > >  $(obj)/bindings/bindings_helpers_generated.rs: $(src)/helpers/helpers.c FORCE
> > > >         $(call if_changed_dep,bindgen)
> > > >
> > > > +rust_exports = $(NM) -p --defined-only $(1) | awk '$$2~/(T|R|D|B)/ && $$3!~/__cfi/ { printf $(2),$(3) }'
> > > > +
> > > >  quiet_cmd_exports = EXPORTS $@
> > > >        cmd_exports = \
> > > > -       $(NM) -p --defined-only $< \
> > > > -               | awk '$$2~/(T|R|D|B)/ && $$3!~/__cfi/ {printf "EXPORT_SYMBOL_RUST_GPL(%s);\n",$$3}' > $@
> > > > +       $(call rust_exports,$<,"EXPORT_SYMBOL_RUST_GPL(%s);\n",$$3) > $@
> > >
> > > I noticed a nit:
> > >
> > > Both of the two callsites of rust_exports pass
> > > '$$3' to the last parameter instead of hardcoding it.
> > >
> > > Is it a flexibility for future extensions?
> > >
> > > I cannot think of any other use except for printing
> > > the third column, i.e. symbol name.
> >
> > Good catch, the last parameter isn't necessary anymore. It was used in
> > early versions of the series to also pass symbol addresses to
> > gendwarfksyms, but that's not needed since we read the symbol table
> > directly now.
> 
> If you submit a diff, I will squash it to 5/5.
> (You do not need to input commit description body)

Thanks, here's a diff that drops the last parameter.

Sami


diff --git a/rust/Makefile b/rust/Makefile
index 80f970ad81f7..ab300bfb46f6 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -329,11 +329,11 @@ $(obj)/bindings/bindings_helpers_generated.rs: private bindgen_target_extra = ;
 $(obj)/bindings/bindings_helpers_generated.rs: $(src)/helpers/helpers.c FORCE
 	$(call if_changed_dep,bindgen)
 
-rust_exports = $(NM) -p --defined-only $(1) | awk '$$2~/(T|R|D|B)/ && $$3!~/__cfi/ { printf $(2),$(3) }'
+rust_exports = $(NM) -p --defined-only $(1) | awk '$$2~/(T|R|D|B)/ && $$3!~/__cfi/ { printf $(2),$$3 }'
 
 quiet_cmd_exports = EXPORTS $@
       cmd_exports = \
-	$(call rust_exports,$<,"EXPORT_SYMBOL_RUST_GPL(%s);\n",$$3) > $@
+	$(call rust_exports,$<,"EXPORT_SYMBOL_RUST_GPL(%s);\n") > $@
 
 $(obj)/exports_core_generated.h: $(obj)/core.o FORCE
 	$(call if_changed,exports)
@@ -404,7 +404,7 @@ endif
 
 ifdef CONFIG_MODVERSIONS
 cmd_gendwarfksyms = $(if $(skip_gendwarfksyms),, \
-	$(call rust_exports,$@,"%s\n",$$3) | \
+	$(call rust_exports,$@,"%s\n") | \
 	scripts/gendwarfksyms/gendwarfksyms \
 		$(if $(KBUILD_GENDWARFKSYMS_STABLE), --stable) \
 		$(if $(KBUILD_SYMTYPES), --symtypes $(@:.o=.symtypes),) \
