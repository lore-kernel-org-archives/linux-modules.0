Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795522347;
	b=KmIhdlVqgria/C0bISU26g3HvrYDDE3M9G7YlQPFxQlxkbHNDmVJcFczUHCMPV08ne0h
	 evFS9/FVg1+vgLlvJEO5PG7hToQm9W2ntU0GGf9h6H5DwEHN74YbVNBYCRzmH/yYd46tN
	 4+vQ1Irj41b11hNH8aW73To8LeKARrgNAdpczR3wU4koEJSra36kvdUiAoorep+bRYppK
	 j6sE44Eqq0DxXUto9Cs0onb4ewumU5edUNhPkMjUL3x+AtDhNxseIEZTpZmCwrhQqakUF
	 rvbV6TDIh5auvzqf04vClYc8oZhHotnyJZfYfYKSPDg5BjQrO3SZ3hZS/K6taAyqZzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795522347;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=lcouaT860fSncNDjT71En57t3vzKX312cQDjtO45TD0=;
	b=IJ92203IzZgoGFiVi2WmqOba6tmGHRlP/FhwTvcq423kg+i+5Z3ZuBf7WMhpzpZ1w0w4
	 ZeT0+bUnzbkGzOy8u3c/5GF9omVNfr0bCsYAxR2wSzaoB04Tuu0c6/EpTbnn7mKoMQ2h+
	 Vzhv41EG69C8SZKSg1SuX7SEGpdglDztgtVOHprbYrk1W4tWH9J5JzT61IVIlCSZ/TKw4
	 J/7bn0aX5hho2QwilViOfIhugyEui4kBLESW0HqetDwzMmZ+X1wNUjQBr7KmA2PNSbI09
	 CqqI7ApGZ44KUcgvUZoKuqn2ImGsCHoNkZb1fUT2W2Uva4d3HBRxHgU/V4NBwuQFZXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X4o7sCKe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB6D606A31E;
	Tue, 24 Nov 2026 12:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X4o7sCKe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33BE21F000D0;
	Tue, 24 Nov 2026 12:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795522347;
	bh=lcouaT860fSncNDjT71En57t3vzKX312cQDjtO45TD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X4o7sCKeK8LJxMw9wq4pyT/qbtY/rvIkq49NWdMrKPtqSSk+B8uewS91k/r6mfuUA
	 0jmsTzpv3TT+oJOel0vr8OGArYWNa2/iuOm26VQnoWbL1Ydvr5OzsPnoBGwcAg4bb7
	 YotYWM/GYLdOOBkQCjAJSfvt3n1fzWyDpdMjEjkQgTTRjtv9twYVG84qrW9ZSCjyMx
	 ZXjgKXzpJbufnGEEJczPccFFA5oAe5wsAG9iIb7vqwO1yfYD49IH7HAf9R3Chdpk4z
	 S3Jhz+3rHPkbODTjU61HjL0V5WN/D2Q4M5tW1vuJTs1XzW/UHXI8o+HCVvZI1SKQqu
	 ZAJtHTRDEr17Q==
Date: Tue, 24 Nov 2026 12:12:16 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: sashiko-reviews@lists.linux.dev, 
	Linus Torvalds <torvalds@linux-foundation.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
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
	linux-kbuild@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-modules@vger.kernel.org
Subject: Re: [PATCH v5 02/11] kbuild: implement and use depcheck to check
 dependency timestamps
Message-ID: <awV_BWhKtRWZtgbv@gremlin>
References: <20261104-build-speedup-v5-0-0f6018be8dae@kernel.org>
 <20261104-build-speedup-v5-2-0f6018be8dae@kernel.org>
 <sashiko-outbox-199744@kernel.org>
 <CANiq72m57kFE5LTjT6V0Vajbwv_oPFEVwkBWgp5B2Xhh1E9uFg@mail.gmail.com>
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72m57kFE5LTjT6V0Vajbwv_oPFEVwkBWgp5B2Xhh1E9uFg@mail.gmail.com>

On Mon, Nov 23, 2026 at 02:28:57PM +0100, Miguel Ojeda wrote:
> On Thu, Nov 5, 2026 at 7:22 PM <sashiko-bot@kernel.org> wrote:
> >
> > - [Medium] kbuild: missing fixdep prerequisite for depcheck in scripts/basic/Makefile
> > - [Medium] kbuild: concurrent Makefile.build runs race on .depcheck.mk.tmp and .depcheck.mk
>
> I have been using some of the patches of this series for something
> else, and I have been hitting these two issues that Sashiko mentions.
>
> For the first one, e.g. `olddefconfig` in a clean tree can give:
>
>       HOSTCC  scripts/basic/depcheck
>     /bin/sh: line 1: ./scripts/basic/fixdep: No such file or directory
>
> The suggested prerequisite fixes it for me.
>
> For the second one, e.g. `make -j4 rustdoc rusttest` runs two Make
> instances on `rust/` in parallel. Most of the time one of them prints:
>
>     rust/.depcheck.mk: No such file or directory
>
> and sometimes the build fails:
>
>     rust/.depcheck.mk:1: warning: NUL character seen; rest of line ignored
>     [...]
>     rust/.depcheck.mk:22: *** missing separator.  Stop.
>
> I hope that helps!

It's very useful thanks! I will respin with a fix for that (+ the other stuff
requested here) shortly.

>
> Cheers,
> Miguel

--
Cheers, Lorenzo
