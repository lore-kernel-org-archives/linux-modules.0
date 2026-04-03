Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EF9309F08
	for <linux-modules@vger.kernel.org>; Fri,  3 Apr 2026 04:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775191998; cv=pass; b=HvxV1Q7YvLNXW1602i6ce0/ihM6Tl6kQvL/6VfzwLWvVPHWlRr5M3/FFwQ2daO0ZPnP7+enOYYDSaRUHNOVjwXwDfgm11s7MyqRKWkmY2aEPpiYAQtw1+G9gY+KkJUZi+vtgHmalYiPqRONpNV0iGcqPWPxK2z85ADrTh8lFmCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775191998; c=relaxed/simple;
	bh=yl2v4HCLZpTTCWiNSHezHoQggNNu2rh4MEf6BSYZ4xo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dT7xZr6UkvnoKfi9bXlgpVga6OESTOd3izSIktyARQ4/c7/EP2KWgebns3NOIwnj6iFXSJtiVhC5UYMhLJulXtDeU3BgPVseJaChK+QOt+YzqLz3Bv8kqBlXgBdVs3/uZgy+873B6csRDeD0ElZOBiDJfhX1FXNbMl6zafZnfTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ScgQv2X5; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ScgQv2X5"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-124b07e5fe4so56585c88.3
        for <linux-modules@vger.kernel.org>; Thu, 02 Apr 2026 21:53:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775191995; cv=none;
        d=google.com; s=arc-20240605;
        b=XNJdjgPCwZFCA7FarJeh90MgQhtQJSJxVhSns834J4FnAI4HfKBHgFP9sEylIyoyzv
         GohzNzyV4zRmhk19DKsZHXjahel8ChqTQZmwROX4h36g/8tGPpkwbl7bf4iWReC/axd7
         g/CgnotP7cgiyD0kR5AEU7ak3DcqEvK14kYZ+NOP0RyMoxvblAu3L/+1EHIP2O8CF3Q0
         vLGY1bdBk3QjST5xz5xj+woXbJaaeNBLBmzziInnad7M+mD31MOAWKaGH+d2fdbC9M/D
         QxCeOYFClel89bb3/idnjLT+FG5Le08RtOZYC/Pol3zVp5UwPS6R7sa9FuLk+acn9N4U
         7C9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BFl652h+zh7LQ70IxgsBAbSjGMJ2GOXvRo1wsMp6Q80=;
        fh=2/+eMRZ9MzssOdibBi6E1sjrfwCUqKKnPNb+m2PNis0=;
        b=PWRrF1jYEhRRaRMkrB0BJIuPRRpvwqAA9VAbfn+0OVkiEV2ZdLix/hoJY9rexjJeIC
         dZ1PgAVofEe4QduJauLowXeXbeI/6QS+n0EjFo07xel0FaCli6GYgYkOMjp/5frXy99A
         34pwu4kOV79/LBFSQX5Om0a0GziRprgk2sV7gvLlp3OKTs9WYxsOmguP/TS6u23/BAgE
         zXp1g3KLeiYGVyrVryfnfPqjjSe/80VuiC+Ah7/Xkb2/bWabdkARXc8c7JEdnqLXes7b
         kdejwHn0koS7mE8aygH9IxIq0qPySN9IQj6vJ97np1wUS4yWnBIqxTMniSpdBiZOH+d5
         QfKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775191995; x=1775796795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFl652h+zh7LQ70IxgsBAbSjGMJ2GOXvRo1wsMp6Q80=;
        b=ScgQv2X5z/bPy2+z10wPDBjbAJjE3PoN74nC1/UvC8JtZrsNakh9CrdwIoI/YgeAZv
         vPnuj3BDj0nN8pXYnK9uVgnS+bFJraVVqGHAKvAp43hVsAuo9JXI9HsRc7m/RruZY+vG
         rk6zChqSM20v1riLHfqgMxA/BGVzxS2mQvBQsi/njNzqEKa+gFAhXxn7438rzumaCaM/
         I9UCC8FnDWjbGb6klI9w9/Y6Dk4cGDccSFAOfqrlJfmKvW2sre73jo6S+2MGhHYQ2xxo
         Asu1zybAk6UXgPIuDpPXjhff0bq+nGK829+7dFbpRs3XJupsBJS/81apoQjRSdwId/1b
         rCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775191995; x=1775796795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BFl652h+zh7LQ70IxgsBAbSjGMJ2GOXvRo1wsMp6Q80=;
        b=ZpVPaUEQ6HrasStmDpc6FCC8+3oIqv3o843CLihfJfzf0bKfD876N1OuSdtZPNMQUq
         XnZWWwpPKnNYUOPJkB7bEiXkFLYlK9i2paDSDZMfLAtMKQd9F97E4/k/3q6GO1ZS7RgS
         rkTrR19ptXaFBAttSR7H93qojiRX0qQ9OKydMw/MCfWNVKHW/8Dhbvu6WHViO39WRIyH
         E4e/3qlNm33naIz8zoSoawngZldfFc5PTqKxt4m4y9kRgM3Y/pP8tSpssp+8i2O4CSAj
         r4ppEjYNyjQQkWIbouDkhQDbyU0HDOkLIPhihjbkA18nnGXYbxAJ78o+n2TviyAh9NUa
         GpKw==
X-Forwarded-Encrypted: i=1; AJvYcCWr2FgD2Ihh09s+tQSsRqvWXdI3bBnEUDlr1R4eZ7pVogCQr6WWf6cwhpBZ90pbu6zRRZPzIBvShWviK+8T@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3g8o4c0Iu84SzpwyYXBj4g0U9dABKNjaOkztof2urpg5XVjiR
	q0rOaZy/+7MS6zaDOea0kzTa7zlO16wLjMAKz5E/pVjGu1QS/wNZau6ZriavAB7GdNv9DP6z5wg
	dHSHxGkqigorsovQD2+bs6QQRfSW1d4s=
X-Gm-Gg: ATEYQzyqdY5vyq1WUJpnB3I3aN29tk5APui0FoGUMyC4dPLgmh8mxpZARXpzxMVbbfW
	GuHiP33ehkuWBoROAY5gXePpDLqcVo0J7TGnErZ1KJQtAs9YrAdd8oa1iv0MvsRkqpoYGhxINeF
	TnPBWgfJvCEOvAFvPqSbFtRHi1NXRda3LQB4/lDWA1Hdv5Je7j4Pt7oa2ltk63hv5Qeztlf47r5
	h6A+fI0HI2jNCZAR5qfsRieFqTRGUjQmkZ5dWp72ENzMzEOBOA5NvOgc0XVs6AWEt3Y93o5pd/1
	tOcM36feDBrykc8vUPPZOL+O/tGnArO3it8uv+4l8/WOru5tZ1/ZQiY1QpWwJ+OD7JHJCEdkcnZ
	gzvYwiXYvaQA05pv9/ngEemY=
X-Received: by 2002:a05:7022:929:b0:128:d590:2947 with SMTP id
 a92af1059eb24-12bfb740ef0mr367589c88.4.1775191994985; Thu, 02 Apr 2026
 21:53:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331205849.498295-1-ojeda@kernel.org> <20260331205849.498295-2-ojeda@kernel.org>
In-Reply-To: <20260331205849.498295-2-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 3 Apr 2026 06:53:02 +0200
X-Gm-Features: AQROBzDJbkOKUs3Pbx6-NjHKhuMni-H63EEyi2tvHo0-KK_56o32Fe31dKQRj3Y
Message-ID: <CANiq72kNqmGpFurRy2X+a=9fHV_hxpfWBJ-+dEL_qj2daLM8ww@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: macros: simplify `format!` arguments
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	Aaron Tomlin <atomlin@atomlin.com>, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 10:59=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wr=
ote:
>
> Clippy in Rust 1.88.0 (only) reported [1] up to the previous commit:
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
> The reason it only triggers in that version is that the lint was moved
> from `pedantic` to `style` in Rust 1.88.0 and then back to `pedantic`
> in Rust 1.89.0 [2][3].
>
> In this case, the suggestion is fair and a pure simplification, thus
> just apply it.
>
> In addition, do the same for another place in the file that Clippy does
> not report because it is multi-line.
>
> Link: https://lore.kernel.org/rust-for-linux/CANiq72=3DdrAtf3y_DZ-2o4jb6A=
z9J3Yj4QYwWnbRui4sm4AJD3Q@mail.gmail.com/ [1]
> Link: https://github.com/rust-lang/rust-clippy/pull/15287 [2]
> Link: https://github.com/rust-lang/rust-clippy/issues/15151 [3]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

I will pick this one up together with the other one, but if someone
prefers that I don't, please shout (e.g. if modules wants to pick it
themselves).

An Acked-by is also appreciated, thanks!

Cheers,
Miguel
