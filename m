Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C5B387567
	for <linux-modules@vger.kernel.org>; Fri,  3 Apr 2026 10:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775211909; cv=none; b=EIuR/CLgj6LYFFexzK/sTNNG0SldoC6wvCZ35mmaxWmTAB7COEOFzSfEwr8VKxSHxrAoflRGwgoMKYDDsEXbYGdIYq+F0no79v5j3pwdFvlPoS+dNXur3nsb2IJ/ZyxN805rstCBa/KvhbQaLKi316lAZkmgn+0BLmn+uwomQek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775211909; c=relaxed/simple;
	bh=U2C+1n4eblBLZUZFn02BGUxCEgYqyusDgYhB8Ehu/fU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UbuGZppxkplTuwldK8JURj2Mw9S+FT6vfo2g9bip8AJEJZ4fA5SKpsjEpn+jE3sWZWALDh0c758kPFzp55Z9oCuZw7IYAKYzNxTWxUjNERs6ugYJBjsZfR8vl/DKobjDCA+xLeiKTzotsAwHlL7GVuKYzgkcyZe8dS47vLJJqqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0JASDWQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0JASDWQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B55CC2BCB6
	for <linux-modules@vger.kernel.org>; Fri,  3 Apr 2026 10:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775211909;
	bh=U2C+1n4eblBLZUZFn02BGUxCEgYqyusDgYhB8Ehu/fU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=M0JASDWQRdituGJi8xOwO7QYKziizkXol+VSmPb2d4XquQO+38FJUfqWs75aM9qdL
	 8gLCh/zSUxmQ+6N4cbp+kCmoCXa3SirmEpjfe7a5FcyUPmdiflMSxwChhPLMcOv6jD
	 dtN6/MuLy0R7rKf4RJja++EsSVRP8YJD/uSTcPrx7NHvbS0ZrfePJH9lINyX7usPNQ
	 AJnHW1+AqklflOv2Dhz9L33aI9AhqcY2P66HzQl7PhhYUOMDNwf9A35t1BnZtA+2Bm
	 s9DzKJK9FJTVpLiJru2lIEYdvwP22uIU2uFrzwO1J72pqTWZ2k0WKSnimVPs+JEkST
	 aaWQ6xRIra5Ug==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59dcdf60427so1671125e87.3
        for <linux-modules@vger.kernel.org>; Fri, 03 Apr 2026 03:25:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWX7HySIDZ4YR7o5/NrPAbL8Z0juu1W3zFgCIW+Iw3OiVnhoeWcyJjCmNoVYbEql+efz8cVd8LPj1rOQZVb@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+ggnHJ1dDq5H8ytgM9wu6Zfnvz+Y5sNsqK2i4w7kEoWHZNNIX
	+6MnPc6BEuw7/yW1laU6XtrDOW97n6W4unteCiN0tghfaIvpDm3Jw/5Q8rH1Yjo4Wx531C2pWfZ
	b6tiXdoEkGsR8sJlbEq3eHlSepjHdx7s=
X-Received: by 2002:a05:6512:138d:b0:5a2:c62c:1edd with SMTP id
 2adb3069b0e04-5a33757cfc8mr993241e87.25.1775211908201; Fri, 03 Apr 2026
 03:25:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331205849.498295-1-ojeda@kernel.org>
In-Reply-To: <20260331205849.498295-1-ojeda@kernel.org>
From: Tamir Duberstein <tamird@kernel.org>
Date: Fri, 3 Apr 2026 06:24:31 -0400
X-Gmail-Original-Message-ID: <CAJ-ks9nqv30SOiCia8LE6XbKEURNCa9qwwcszsQ0a8FRxR0Msg@mail.gmail.com>
X-Gm-Features: AQROBzAf1dd0CJ7lpIad1E6G-CnB4P-wdlU0-ynV0Gb0FaS0kedu_jKfyYVRJEc
Message-ID: <CAJ-ks9nqv30SOiCia8LE6XbKEURNCa9qwwcszsQ0a8FRxR0Msg@mail.gmail.com>
Subject: Re: [PATCH 1/2] kbuild: rust: allow `clippy::uninlined_format_args`
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	Aaron Tomlin <atomlin@atomlin.com>, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 4:59=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Clippy in Rust 1.88.0 (only) reports [1]:
>
>     warning: variables can be used directly in the `format!` string
>        --> rust/macros/module.rs:112:23
>         |
>     112 |         let content =3D format!("{param}:{content}", param =3D =
param, content =3D content);
>         |                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^^^^^^^^
>         |
>         =3D help: for further information visit https://rust-lang.github.=
io/rust-clippy/master/index.html#uninlined_format_args
>         =3D note: `-W clippy::uninlined-format-args` implied by `-W clipp=
y::all`
>         =3D help: to override `-W clippy::all` add `#[allow(clippy::uninl=
ined_format_args)]`
>     help: change this to
>         |
>     112 -         let content =3D format!("{param}:{content}", param =3D =
param, content =3D content);
>     112 +         let content =3D format!("{param}:{content}");
>
>     warning: variables can be used directly in the `format!` string
>        --> rust/macros/module.rs:198:14
>         |
>     198 |         t =3D> panic!("Unsupported parameter type {}", t),
>         |              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>         |
>         =3D help: for further information visit https://rust-lang.github.=
io/rust-clippy/master/index.html#uninlined_format_args
>         =3D note: `-W clippy::uninlined-format-args` implied by `-W clipp=
y::all`
>         =3D help: to override `-W clippy::all` add `#[allow(clippy::uninl=
ined_format_args)]`
>     help: change this to
>         |
>     198 -         t =3D> panic!("Unsupported parameter type {}", t),
>     198 +         t =3D> panic!("Unsupported parameter type {t}"),
>         |
>
> The reason it only triggers in that version is that the lint was moved
> from `pedantic` to `style` in Rust 1.88.0 and then back to `pedantic`
> in Rust 1.89.0 [2][3].
>
> In the first case, the suggestion is fair and a pure simplification, thus
> we will clean it up separately.
>
> To keep the behavior the same across all versions, and since the lint
> does not work for all macros (e.g. custom ones like `pr_info!`), disable
> it globally.

Seeing this patch a bit late but in clippy 1.85.0 there is
`#[clippy::format_args]` which would permit us to make the lint work
with our custom macros.

https://doc.rust-lang.org/nightly/clippy/attribs.html#clippyformat_args
