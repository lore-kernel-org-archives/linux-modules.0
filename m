Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A9D382F0D
	for <linux-modules@vger.kernel.org>; Fri,  3 Apr 2026 10:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775210839; cv=pass; b=IxEq8ebNA+rTefj9a1+gXIgBRp5k62id2SbdLlxb58P3rzqaBnYvipWKg9+wxdNEyCeQkasx1prYlWAHHY1QV2kCcdyWqKbxFy2NHRVoIZiTVzu6Rf7X1NV91z0rwLT951nhQd0hvRXLpRFMsN+2GaJpJcuayUghIdGtPuawBc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775210839; c=relaxed/simple;
	bh=l6iFZzW+AWF3/QEU6LglpEwpw23G8B8xolbXTX0zh2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TU4xSK3Y2rOepfNawIxy0jgvuWkVvxLdBAPoN/0ymEEMPKyD7eLXRJ05FVZ/7hd7enRXK4DSmQrFDRwcu1hoGpOTZ20qepaF2ANL9NYVJDrSDp+Wo+f0PXUAAXkHmzl1ngL11woDGnBWzrfxGAhU7NtFR6GF7f3WploTvNfGzCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=djt6QZTR; arc=pass smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djt6QZTR"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-38a365f1869so1222381fa.3
        for <linux-modules@vger.kernel.org>; Fri, 03 Apr 2026 03:07:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775210832; cv=none;
        d=google.com; s=arc-20240605;
        b=TyEH8hoYWz1Pd6oKCrGlgaFiBdSbXmLBKVCCrBOgke9r5bvSIXegTzk+A1gobaSq59
         foO7JTf5i+kaW8i1gn6Uw/rxX5MYiiojJUihYc/uBPumzPGdya9dm3EV7Us5T8thWVFT
         P3jyipexgmS0ypd3qifmWOA9EN560M6IFenucg+DzcQReSlA4UoyhjBIEjN4lZ/q4Bij
         42fEqjIsha5QJL2FhdTl5NvOT1PJnM1he9nI68qFEmxTgvAcMHnQQv3RUxfG9TPqa1hi
         kWiuKJvyYH/fbbocEpcgtb1CmNwfRExN7LQbHrwykRHO05b9LaSZRYpiTY7JcTLWiIIP
         FCGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oPJMJaHpZbFcRCyZeIIkk5jL0cCGPysTlsDPbLnYuac=;
        fh=Ld+iYlsHghMK1R/Px1ngJ/w87g91JKMRJQRQ96+smPk=;
        b=c0pxM86vRERLbUgPOfviyEF0W4/wn6OjiGd3UbASvphW4YAP0bPRG+FTx8A1VzpU4G
         3kjZsCl88XKQxRkoU65HMaFIDrlbQ2BclBU2u1rvsgnQq8EexnEuzPOcZF/EBQ5/9EAp
         3nVp6IYvwsJFinLirYfDU5nN9KetP9u9IwENGXaExJGj/izwSGh5DX2e61fdP/9yeZgT
         jWyabY5JKEnLuCVJJDJuuOGxyEL4nlvVBX+CDyQGROw5SK8UYPD5MzDgmbxqc78ZpvEQ
         s973PmJL0IvdZAikug4yg+7PR3uixXSQTeEsicklWXGuaRJottJ56Kt9mNMiMH14b3BW
         iZSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775210832; x=1775815632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oPJMJaHpZbFcRCyZeIIkk5jL0cCGPysTlsDPbLnYuac=;
        b=djt6QZTRfT+XcEa1NxzzaJE1gUQlCKaKO6cK/w6rS80EpPop3wYhW02DcP4gx/OMZ6
         yMOvMJMI6seSsYr53wjzyZ5u3r4cd4EXtwf9wRNLRUpgxbDLwI8BNEH0tJG4zkPyX2am
         5khpWbmWgBOe0AfPhHD1CirtkaPoet0ny8l9uSKSrHxiS+DHLiBZmVa41briIfrMxbP5
         gRePp3b4PvkWE4FhUxRkDjnABs/c2zamHosaduIZbyFCb6sXEd5bNVeArrt8kIbLjSu9
         1KazumvICrWNBZWF0T9eFIkwJTD4Bz3CP+qSwmJx2PRff/bUHuHf3QDKBc/iYdidY1il
         UDpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775210832; x=1775815632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oPJMJaHpZbFcRCyZeIIkk5jL0cCGPysTlsDPbLnYuac=;
        b=SKiw9qM3FPzpG/kXYJUNt7RGyvUIqoaNpAPKfkcUJ4RTw/kP89Nr7voUjvol+9IVGS
         S7YTggupXN5ZBOD7BTAFePdRCgjYp+lEJI0GiBUuEjv+ux7UsNpkWWFQgvNMvN3ilTnm
         nzxp4VPq+pAYoKHgEC9BxiLJ7xHXbMUaTp5HUvnT2mdDHU7FB8hMYAXK0uf9o9RSJc/j
         s1Im/vTVjTrHDN4PunFphG/Gy9tldlQ5grevFDd8xG4Gpi6KToKf51vWpgg00FSjsUa1
         FW++KjzqSWQl8rNR3l3zroZ4tJMA8mMisRLGSEUba43LU0nXaC86J0xQNtbt/Y4RBrmA
         yvEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHkN6kgrTBe57HyBjxC5bKpkj+NqvSvSyztSeaJ3nLgZAVYr5xpppiKPC3z64frINwiGLNUYVFh1MqHf4B@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp68w+6BrcXBTehhy3NRga9EcGc+Rk2VG4i3vgkDg04T56KOHu
	iN2DTctD8TO6GebcPP8DUZ9jMX6HoOSj+frsdqqphEw1+T9xtGUBB/sIGR7bm3TQjZgqbpqzTj3
	uxvTUU9JqxLKGDbHg4cWncj9BvSKZx3g=
X-Gm-Gg: AeBDieuozPVCC597b8aCMOycZsm/dfTutuSHYxUO7yCynMIaEOO5DLwQdihW0x/Gjlh
	jZctYomaXEhWypI9YG56hq/GVIp1mxre78VHphstPyeCBgycWJTqIk089KAQMy8HE6P2LkwE1pH
	ekhl30c+qE7F5GHphCM+Xs4QKEQlUGsNMwu/CIldu7wtC4xVK/bccq526/Z9I8GxjK5vmkyc045
	lpDtwIMd/DtHvG6YvlFZIlBwYk9335a4v/ZQy2wib1XlEbWd4Tblh4/rcJAXH4AhRoWm8Ju/aJ4
	cQWffwHrx1egjRkU+qxc3gHE+7sjMPrhkRXksyH+5X+YEuvNdE7ZlqCOG+ROBfhCwfFMU/7+GOf
	rdQNg6vr9WW4GNQQJ1AAEU+k=
X-Received: by 2002:a05:6512:31d6:b0:5a1:4712:376a with SMTP id
 2adb3069b0e04-5a33759184amr467862e87.8.1775210832087; Fri, 03 Apr 2026
 03:07:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331205849.498295-1-ojeda@kernel.org>
In-Reply-To: <20260331205849.498295-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 3 Apr 2026 12:06:56 +0200
X-Gm-Features: AQROBzBBW7rQ85ZJif0nroczUc04Z6h0dVRy0ZiPuatyp9TJcZiZGUSTP9K1ZwE
Message-ID: <CANiq72=-vxjqPPiAPrN8Oxcs8ExhHY2qvhN_Qd5JnxGGKEOOcw@mail.gmail.com>
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

On Tue, Mar 31, 2026 at 10:59=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wr=
ote:
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
>
> Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned i=
n older LTSs).
> Link: https://lore.kernel.org/rust-for-linux/CANiq72=3DdrAtf3y_DZ-2o4jb6A=
z9J3Yj4QYwWnbRui4sm4AJD3Q@mail.gmail.com/ [1]
> Link: https://github.com/rust-lang/rust-clippy/pull/15287 [2]
> Link: https://github.com/rust-lang/rust-clippy/issues/15151 [3]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied series to `rust-next` -- thanks everyone!

(If wanted by modules, I can drop the top commit.)

Cheers,
Miguel
