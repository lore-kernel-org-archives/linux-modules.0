Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B912E1EE7
	for <linux-modules@vger.kernel.org>; Fri,  3 Apr 2026 15:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775231597; cv=pass; b=m9SIYp5uVfJJhiIngRfmKT1NpI4o4C0XoY7fwmRF6sQAJaKcQfmU2PU5OBfN0IOWQZnjYEaVEjRqIEHcJ0jvL1hInJ+XMORGEcRLv7QJw6J6dFysTG+Ixp4hzRH4Xe4h+odblFyKDAWoublsXgyyNo+cejjp7OsS1/GmpZ6ZrCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775231597; c=relaxed/simple;
	bh=t23z0PvZ5SLNM3iOMGWZAQbIb7X50AxZc0jqO7F0tJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IWgaYYcECSXbG0hNEELfmfNWFX0fViuLPdal+jvpJUnQcFKSzKWGAAAtpiX+yorgfs+edhWF774US884vgAV4zKyuvPzklo60cE8n+9q7Z4Lxp03H03qpO/pz0Ym+YmD1/1WnYiad7WmPYlKwJmSr26W6IgCFlS8/DoU+iRLhgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NjFAMa/4; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NjFAMa/4"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-66ba6d3dab3so11292a12.0
        for <linux-modules@vger.kernel.org>; Fri, 03 Apr 2026 08:53:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775231594; cv=none;
        d=google.com; s=arc-20240605;
        b=Zh28LlDgbbEpcGbKDkMn0HylzdTq3kTDGEN/2utvIAIutALJLoatetBpOIABlmxsd7
         d/3DJOreMuEGj2qxToqC8QhI89WacA55hU9nE05HOwIVRfJ0fQXOKXCQcXzxP1CF5Uut
         Vw5jkWVLzHkAjyLgyf+qYlAjoNE34vEdkiXrY9DffyS524/xZLjGodRLaoZmafEbFfJS
         Qos8o/InMZsxN3tFl2pzpYbrqh94AZpzr8XavKQXJUDTKMWrNUH/0WvzhUq2NxgTxc8b
         cnVQt83KKOOvRl7i+vvW/qR3dJc+YUH6A9eeqZwjl19EnYegdQa9vNy06BdxQGZmoYMf
         SGCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=coqr6EFlArhl/x0h/ZohwmdyLe+IJgT11ByZbHHxjb8=;
        fh=56l+UdEvL4b23NALdevsnUkdUaR6zLPnwL2+LAqvhHY=;
        b=VEm2kIc1Sg3Q6u1aJldNcL86yBC7e8M7uMiW9REKDt72tB4DT4/wN1cfmCAY8M0bVD
         se6vcqGT7fUBIfCx16CBHMsp29Qshtq3h9XO7hgO6Mz2Yl/SLZvhImERJuDkyD5uAmff
         rZq8aPzXOVXQQbngzyh72uqP3jCCHXCy+YEbl1bwQOt1igLHF55guKlqy0S0iRsnnBZB
         uC2A5jkjWqQoenuJBOgy3gGsuFf+J3s9bq95uvyIpVpdKFpfbR/PelRT48is7y8xErJ0
         PaSLDVvY0AIw/JqoOQ9YmRo1Q5GJKMonj4jEWUPz3xfHDhIGnPM9i1YQvH+PFBvkLmuy
         K45g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775231594; x=1775836394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=coqr6EFlArhl/x0h/ZohwmdyLe+IJgT11ByZbHHxjb8=;
        b=NjFAMa/4gMTIyl7BlE0aQyZ1GJ+rVpy10ZCGEpSJ/JxduwK/HxPapOnuNDmM8yi0XL
         SJZDXBcBl1vyCSWAbiZcgPMQXpWU5jNGVHcHuaybl5DFK3N2UoCL4zYWIPH/Ay7n17oU
         U0QEpAgorn4C7554o/d/BOg0tfERKk7lnBAeSaxZNypiOk3sGQxVcMmqdk/Xd33+FFp9
         3xqtJRkJWutehg0v6hTx9YRcIQxaHhjmspQNxGGbsyDcjT6nzWncOwVEnQIuBK9+v62J
         4+7kOwppmVeW8hBhcnZwLfJKu8D/gaLZaqLtVn6jUoHa9DiO97vlq2o2T4PkUNAIxnZb
         cgmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775231594; x=1775836394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=coqr6EFlArhl/x0h/ZohwmdyLe+IJgT11ByZbHHxjb8=;
        b=gAYU9rGC6Qqxxcu/F+FtOGe4/QLu7B4wFsu3oW5Rn380EkH3dowLahJSQfK2bOPEb5
         Ztrh5J/kdx+K1VEfY+5SVeeYVRTs5tMy8vr/j73RXR4zzS6tYRJi9BeG6/192PwGje4b
         YtFIw+5KbU8dPVfnshqwan3Lyqw3CPZg5XyknRN1BwH2N5ohUAcXPMX8qgh+csW1EceZ
         LlE/4aiTMly0r45nJFgohdj3GriC2ZCgZpAEpynXFIqmJJ6m2cgMx1JYL5Mu9asepp5c
         Wrm0FIgdrPpegNpcWmTc53XeTlwvghaJZiU6xLgYhcqHK02HRS2lhAE45ew/FyEWOCKW
         a1SA==
X-Forwarded-Encrypted: i=1; AJvYcCUEwaW+ptOG1m0VHNoa8U66khgrm0X9vLptkysBdPSKTpoxyO6AqkKDI0WamZFDj7BJ+ktQSrz/ShXCTeLh@vger.kernel.org
X-Gm-Message-State: AOJu0YyskXBMsaMBd0gsaqyq8+eCO3KZvmZa27IIaw5nO3w0deSCfNZ4
	gfHWo8fObsJ/x4OVA1zWN36tCPYsXtVSHV42nd+4KhYivsFXYFlxKBkM6dBLqGxl2K0PeZ44POE
	RUObKLuqplzpzS/I6R9rVe5vHb2jn7C46bo/zGHAU
X-Gm-Gg: AeBDievlX6WGJUX99IxBQzOUwXHOlUaK0T+JBw1dHHOlVznOfZQ1w+UgMCZ6p+8KLmb
	fxzs6X+yN+KUnWiqjy2cT8/Vlt+ZLYvMK6FR+OCqgfSkEqwJADYt3nWYOYz+WpKom8h9mw5S2Nc
	PX1cQ6kc2h/4WJg6V9D9N0uT8EpA8hBZ3INKK0LUF4JEzDxNSBl5fRO/7cSY2jAx3URmOmjDKQv
	L52MonoypouTdMSvRB5oHtON+NpFkPZxzH+Igj0m9X3JAZemDg/CqAV8dgRlSw3cYXJwr1YyLYD
	ve0ZB9nDHQ+GRco=
X-Received: by 2002:a05:6402:4244:20b0:66b:eb42:be7 with SMTP id
 4fb4d7f45d1cf-66e43f7f81amr19687a12.13.1775231594022; Fri, 03 Apr 2026
 08:53:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331205849.498295-1-ojeda@kernel.org> <20260331205849.498295-2-ojeda@kernel.org>
 <CANiq72kNqmGpFurRy2X+a=9fHV_hxpfWBJ-+dEL_qj2daLM8ww@mail.gmail.com>
In-Reply-To: <CANiq72kNqmGpFurRy2X+a=9fHV_hxpfWBJ-+dEL_qj2daLM8ww@mail.gmail.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Fri, 3 Apr 2026 08:52:37 -0700
X-Gm-Features: AQROBzAYADRZHwIlu_Hu7-_xFAf5tXH5Q2bpU3B-T608yTRVpmc4-aeDHJhGvtI
Message-ID: <CABCJKucPKB-ntYi=EzPqyypy0kEHwnZvEvCEyjdQUWqfeAnGig@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: macros: simplify `format!` arguments
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	Aaron Tomlin <atomlin@atomlin.com>, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Miguel,

On Thu, Apr 2, 2026 at 9:53=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Tue, Mar 31, 2026 at 10:59=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> =
wrote:
> >
> > Clippy in Rust 1.88.0 (only) reported [1] up to the previous commit:
> >
> >     warning: variables can be used directly in the `format!` string
> >        --> rust/macros/module.rs:112:23
> >         |
> >     112 |         let content =3D format!("{param}:{content}", param =
=3D param, content =3D content);
> >         |                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^^^^^^^^^^
> >         |
> >         =3D help: for further information visit https://rust-lang.githu=
b.io/rust-clippy/master/index.html#uninlined_format_args
> >         =3D note: `-W clippy::uninlined-format-args` implied by `-W cli=
ppy::all`
> >         =3D help: to override `-W clippy::all` add `#[allow(clippy::uni=
nlined_format_args)]`
> >     help: change this to
> >         |
> >     112 -         let content =3D format!("{param}:{content}", param =
=3D param, content =3D content);
> >     112 +         let content =3D format!("{param}:{content}");
> >
> > The reason it only triggers in that version is that the lint was moved
> > from `pedantic` to `style` in Rust 1.88.0 and then back to `pedantic`
> > in Rust 1.89.0 [2][3].
> >
> > In this case, the suggestion is fair and a pure simplification, thus
> > just apply it.
> >
> > In addition, do the same for another place in the file that Clippy does
> > not report because it is multi-line.
> >
> > Link: https://lore.kernel.org/rust-for-linux/CANiq72=3DdrAtf3y_DZ-2o4jb=
6Az9J3Yj4QYwWnbRui4sm4AJD3Q@mail.gmail.com/ [1]
> > Link: https://github.com/rust-lang/rust-clippy/pull/15287 [2]
> > Link: https://github.com/rust-lang/rust-clippy/issues/15151 [3]
> > Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
>
> I will pick this one up together with the other one, but if someone
> prefers that I don't, please shout (e.g. if modules wants to pick it
> themselves).

Sounds good to me, thanks.

> An Acked-by is also appreciated, thanks!

Acked-by: Sami Tolvanen <samitolvanen@google.com>

Sami
