Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6482364E8B
	for <linux-modules@vger.kernel.org>; Thu,  9 Apr 2026 16:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775751566; cv=none; b=jpjt8UybymkKUQ327h7quSFFf5HuIMHXdqMmbKPvOAXgm1icpekNpro8FXFG0N4Exer2mrKlmzRH5uWTb3aNzgI1vSyE7c2lizffsuw64qc/dYEYmhLzPOFQU1glyr2mM+NB4cXkikXzucoa4s3PmxZsUb+AuPP7wE/Piwq7nvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775751566; c=relaxed/simple;
	bh=4ST+hPB0HfJyx4zcBPDhvtmJYMEBRZ/dYXMapLMv6bg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u9UoB1BadOIH9sBHapMEQbO0Z2sQNsjOU7lOTBdB8rXk2iB9r1spW6PKPqlJ0Un0MY44lEhbGqBamI9nuD3zq138QSxawc5hkwR2mKoZUqLF8y3J37kyaSPxbvNLLjA7fxu8e0U+oer1tNVQy+orokfgnEaU4Uxl6l8lude7fyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ha6ai0lb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ha6ai0lb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC01C2BCB3
	for <linux-modules@vger.kernel.org>; Thu,  9 Apr 2026 16:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775751566;
	bh=4ST+hPB0HfJyx4zcBPDhvtmJYMEBRZ/dYXMapLMv6bg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ha6ai0lbwR8U5dFvxHDDn3S4cqYm4HR+WmDmiEfue1jHfrutZTZb/fklkVqsjKNhR
	 7W/YSX1wjvyxCIXtCADAWNlCyuVz+MWZHEHfpZ4qJ8EbUXueZOEu+d9Vf1jc+Rjfde
	 bXR1VOcyDPwYIf2uk+G3ful6Bba7gNpjVwRLR9Gv5fI/8IXA4xHPCjo8X9SbkpgW4D
	 zepHaIJp3rlE16hg5AsR3ib6YMvcd9m5UlSH2MKJdFKAvQIxQ57wfHlbuBtjmav+uy
	 +q09uY/zjecylWD1FIjTxyCzny/Q7iSFTp8gXg6z+obB/22Ecq2wUnAh/xGM+KKkSP
	 wkjJFJmjAX71Q==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-38dfb789d7fso9989621fa.2
        for <linux-modules@vger.kernel.org>; Thu, 09 Apr 2026 09:19:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW/X37qwKfsXt6q9TncMvWoFcBtEeUFK/lrSrWPH59/XoB03QWB3Wd9gS28AuFIsEJuvlNmeTLLbVrMaV42@vger.kernel.org
X-Gm-Message-State: AOJu0YzIh0HrafQDa4erRfw7KA6hqaTjry4KpYJTBuIiZrcIrqrQi4Ey
	uDGgXkOwruXhRF5g9Xcr4SQtRxS1w2sUwgObmgSG2JIpQ6v8Kl3Z+ggiQq5suCo1IgA7qOZTW1R
	68LJRvSG/5XQtDDKeFTMipEf19heLIyA=
X-Received: by 2002:a2e:95c3:0:b0:38c:c32e:5b2c with SMTP id
 38308e7fff4ca-38e3362371emr11761351fa.19.1775751564937; Thu, 09 Apr 2026
 09:19:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331205849.498295-1-ojeda@kernel.org> <CAJ-ks9nqv30SOiCia8LE6XbKEURNCa9qwwcszsQ0a8FRxR0Msg@mail.gmail.com>
 <CANiq72mKuQgK_R=xs6270nwYigzCvJiFJ1PcOB+WT3OdXO7E0A@mail.gmail.com>
In-Reply-To: <CANiq72mKuQgK_R=xs6270nwYigzCvJiFJ1PcOB+WT3OdXO7E0A@mail.gmail.com>
From: Tamir Duberstein <tamird@kernel.org>
Date: Thu, 9 Apr 2026 12:18:48 -0400
X-Gmail-Original-Message-ID: <CAJ-ks9nMA1zqGhHhOk8hmfNgoODQ+D-WforPU6iCciYbPsDD-Q@mail.gmail.com>
X-Gm-Features: AQROBzDZ5E11AfueQzg0LR9apqPigjI17D9aa2qN_B_BOWd8NoNl2G48fdG5R0g
Message-ID: <CAJ-ks9nMA1zqGhHhOk8hmfNgoODQ+D-WforPU6iCciYbPsDD-Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] kbuild: rust: allow `clippy::uninlined_format_args`
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	Aaron Tomlin <atomlin@atomlin.com>, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 9:07=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Fri, Apr 3, 2026 at 12:25=E2=80=AFPM Tamir Duberstein <tamird@kernel.o=
rg> wrote:
> >
> > Seeing this patch a bit late but in clippy 1.85.0 there is
> > `#[clippy::format_args]` which would permit us to make the lint work
> > with our custom macros.
>
> +1, that may be good to consider, especially with the bump -- added
> and backlinked in:
>
>   https://github.com/Rust-for-Linux/linux/issues/349
>
> Maybe an issue would be good to create too.

Turns out `#[clippy::format_args]` doesn't work for us due to the
`fmt!` proc-macro.

It seems the handling of `#[clippy::format_args]` is more
sophisticated than (at least I) expected: it doesn't blindly check the
inputs to annotated macros, but rather looks for the place where
`fmt::Arguments` are created.

In our case something like `pr_info!("{}", i)` ends up expanding to
`core::format_args!("{}", Adapter(&(i)))`, which does not trigger
`uninlined_format_args`.

We also cannot fix that just by having `fmt!` assign `Adapter(&(i))`
to a local variable and then return `fmt::Arguments`, since
`core::format_args!` borrows its arguments. The local would not live
long enough.

I filed this upstream as https://github.com/rust-lang/rust-clippy/issues/16=
833.
