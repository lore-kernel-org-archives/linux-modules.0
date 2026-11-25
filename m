Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795609702;
	b=KJHhsFQDEUZQn+KJSwBVPIGx8Ypg11WXmcp1iZPATATUnSuyvqYLdi3LoiivNfiX4ARq
	 2D98cUeYds/lMumo3TY5OgBcySohxJWufk19apFaLp9RdBIXUauxiURwPsF8PFrVxcCb4
	 jxyPNAkAwb0s3oEHu2Hm47T49mThR6rrlSri5ibl1qL8hU+8Klpaomt4e6lkvKJymJxXk
	 gMdBC0jCFdSX81P4gCE6SvH0thS8CE1eLtTJZWRQNrvaGrsABoG57GivH9iujKwywPWU5
	 FuP2+Sy05FIbRiYc3j0SafkpWKk6Xug12ZWoU0IoOkovKS5AhOTjaYQwGy6tuJCyCjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795609702;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=hpvurHXKOGNZ9gnVI9/HzwEjSAtsSaCAYF1pwCYTtaQ=;
	b=BpFWrWUPDWCuX3bM8nWgrBm9n03MpJsm3SyGK5e7HcjpFnZ0i4UYHPhLjpD0api7l3yN
	 ZtCOVFYFW+5LbA9Iy/BTscbgn2lb0ZTVh0HvVmA7izl6BXFJNwRCqih7A5eVNpuoHC20w
	 0SvmVOScwuqSfqD6V5V5pshq4xvOl+LAvTAyiUBiHYu2oglmxkS7rO+ffMl4FLPBgDFx+
	 RVE0z5vaD4XpIrfiFYnGheh5/ZimS9h7CzE3SapM1HZ6JEW1eMCzi2Q5rHskwlmQcx7pf
	 ijpPkLYIwBsLIcO/OvR8fiL8vwAfEMBms+xMqvfyigbDzu6fALH2fXawlnkoBPbZ2sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GI8ATaNy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF7C606A321;
	Wed, 25 Nov 2026 12:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GI8ATaNy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9C2F1F000D1;
	Wed, 25 Nov 2026 12:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795609701;
	bh=hpvurHXKOGNZ9gnVI9/HzwEjSAtsSaCAYF1pwCYTtaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GI8ATaNyTMyEXxgfjz+oenZ1X6CmViRKww60LktsKeuQ38vALYgH+CM3Hbv/jYM35
	 6SKWl6rpruUqfXlO0AG1stUNmKN7XrAjBIYeBI7FSve7iYj6dKkMutVcq1AJ+X2xR2
	 19kiUTCSOs+OaCbJWc5BS7yA8mHNWfv6EtVTsS3fBWIhaG6wRSLGO9mkAekgzlNi+2
	 hA+94fmfPzfiS6+tCDRvjGixzW51m9J71z0Srxx3OhG8sP50OmQoHRVeSkjB50vTlA
	 3dbrKrkC173/KfGhf+zpcI2ujyaPDFOcosjmorvdgBOq0+5ZCcnSiODTggIeuPP4vi
	 sCC2aqMMVMLVg==
Date: Wed, 25 Nov 2026 12:28:11 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Nicolas Schier <n.schier@fritz.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, Onur =?utf-8?B?w5Z6a2Fu?= <work@onurozkan.dev>, 
	Kees Cook <kees@kernel.org>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v6 5/7] kbuild: batch module finalisation
Message-ID: <awbUJuLahIbbL7vi@gremlin>
References: <20261124-build-speedup-v6-0-141a4f861c67@kernel.org>
 <20261124-build-speedup-v6-5-141a4f861c67@kernel.org>
 <20261125-bald-mushroom-of-development-7b2288@l-nschier-z2>
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261125-bald-mushroom-of-development-7b2288@l-nschier-z2>

On Wed, Nov 25, 2026 at 10:56:32AM +0100, Nicolas Schier wrote:
> On Tue, Nov 24, 2026 at 12:20:15PM +0000, Lorenzo Stoakes (ARM) wrote:
> > With the .mod.S change in place, module finalisation on allmodconfig builds
> > consists of a large number of very short-lived jobs.
> >
> > For allmodconfig x86-64 this can be on the order of ~22,000 jobs of a few
> > milliseconds in duration each.
> >
> > Each job entails processing ~22k .cmd files, so the combination of heavy
> > overhead and small individual job results in a lot of unnecessary and
> > repeated work even with all cores being utilised.
> >
> > The solution is to batch by a number of jobs. Determining which value makes
> > sense was done empirically.
> >
> > On a 128-thread threadripper box doing an allmodconfig build, best of
> > 2, *.ko, *.mod.o deleted each time:
> >
> >     modules per chunk    instances    wall
> >     -----------------    ---------    ------
> >                     1        11171    10.22s
> >                     2         5586     6.72s
> >                     4         2793     4.97s
> >                     8         1397     4.26s
> >                    16          699     4.05s
> >                    32          350     4.05s
> >                    64          175     4.07s
> >                   128           88     4.05s
> >                   256           44     4.03s
> >                   512           22     4.18s
> >
> > Wall time flattens for 16-256 module batches.
> >
> > A slower/lower core machine will do better with fewer modules-per-batch, a
> > faster/higher core machine will do better with more modules-per-batch.
> >
> > Therefore, take the midpoint which works in the most margin in either
> > direction - 128 modules per batch.
> >
> > This naturally scales with module count too as the optimum gains are
> > obtained with higher module count, so fewer batches in this case costs less
> > overhead.
> >
> > Each instance holds only its own modules' variables and the top-level one
> > reads no per-module .cmd files at all, the same rules serve both levels,
> > and an instance is told its chunk with modfinal-first=<index>.
> >
> > Only the top-level instance builds .module-common.o, to the chunks it is a
> > plain prerequisite, so no two instances ever write it.
> >
> > "make modules" with every *.mod.o and *.ko deleted goes from 28.9s to 15.9s
> > with clang 22. No-op "make modules" goes from 5.6s to 4.8s, as checking the
> > 22,000 targets is spread over the chunks too.
> >
> > Whole build, 128-thread Threadripper 9980X, best of N runs:
> >
> >                                          before   after     delta
> >                                          -------------------------------
> >   x86 allmodconfig, no-op make, gcc         2.3s     1.4s    -0.85s (-38%)
> >   x86 allmodconfig, no-op make, clang       2.8s     1.8s    -0.94s (-34%)
> >   x86 allmodconfig, clean, gcc            306.6s   294.1s     -12.6s (-4%)
> >   x86 allmodconfig, clean, clang          290.2s   283.9s     -6.4s (-2%)
> >
> > Reviewed-by: Kees Cook <kees@kernel.org>
> > Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
> >  scripts/Makefile.modfinal | 30 +++++++++++++++++++++++++++++-
> >  1 file changed, 29 insertions(+), 1 deletion(-)
> >
> > diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
> > index 75e9effdf02c..4d5e6e1a0ff9 100644
> > --- a/scripts/Makefile.modfinal
> > +++ b/scripts/Makefile.modfinal
> > @@ -13,9 +13,30 @@ include $(srctree)/scripts/Makefile.lib
> >  # find all modules listed in modules.order
> >  modules := $(call read-file, modules.order)
> >
> > +modfinal-chunk-size := 128
> > +
> > +ifdef modfinal-first
> > +
> > +# this instance handles the chunk of modules.order starting at $(modfinal-first)
> > +modules := $(wordlist $(modfinal-first), $(words $(modules)), $(modules))
> > +modules := $(wordlist 1, $(modfinal-chunk-size), $(modules))
> > +
> >  __modfinal: $(modules:%.o=%.ko)
> >  	@:
> >
> > +else
> > +
> > +modfinal-chunks := $(addprefix chunk-, $(shell seq 1 $(modfinal-chunk-size) $(words $(modules))))
> > +
> > +PHONY += $(modfinal-chunks)
> > +$(modfinal-chunks): .module-common.o
> > +	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modfinal modfinal-first=$(@:chunk-%=%)
>
> Thanks!
>
> Reviewed-by: Nicolas Schier <n.schier@fritz.com>

Thanks!

>
>
> (bike-shedding) For readability, I'd favourised the use of pattern
> matching stem:
>
> $(modfinal-chunks): chunk-%: .module-common.o
> 	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modfinal modfinal-first=$*

Ack, will fix that up on next respin if needed :)

>
> --
> Nicolas

--
Cheers, Lorenzo
