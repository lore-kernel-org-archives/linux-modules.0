Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795620837;
	b=d3CY8FLpIwU2ctrZkGcVEe2F9Iv7v3tWaoLho9r/kBSeeS2xqzNoBgrudbLuH+YdupGJ
	 b0ujxxNydWQ+ny3MSQC57UWmgo458OePv5O6CL/sgkAs9TfLNziuVCe6eDc3YkLeNJcwr
	 YV4B5kHlh8DrsaRlbFxr6Lce6YYgjPJ32QzGY/3lof1wkVfivhIj1jER24yU70AXPsDzq
	 j9iYLxheBbmxIxFqSCN8776S8XuTt7Bz26Mgs0ZTcRL2rpbLxp4sQR/7uLf0OyMbbbkg4
	 yeIfpXGemaPP8SkgXlJIE4Rt4345kz9CbX1JU9/WndoAKo83mIX07e9GHjoWadWi6WQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620837;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=wKqdQvSAuRnmEmZrQT2+mDn5yykXvIjFQspA9QZyZuU=;
	b=UYpJv2/4djReLoPvMxzPAGj8yOHMAVfQrObXNxXt1BBHoOkkBgKakM5JaecfVSo8KC4Z
	 hp1k3i3h6JQdujXk73FvTAYYjLfW/FYWtWY/kLH+XLNRyxoU9K0FOFMB5B4HPXLgUjcJh
	 A37GzsIyl9dpAVB91TU5QRnXODG2PRoOPhjyu8+81G+Ge1hnyu6ap3so1rTlp1Mhar49C
	 4ox1KxiqGxf1l61B4++GxC0/DmbYk9gj6gorsmrMdx8ltnUwMKJTxrIKADaFa26supGwD
	 UjyYRJPV66xMe8RuqdrRrEth+egqUPwmOw9BHEKtqzZzdngE84ac2/VCQlUNcK5dO+g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=buKUYa8n;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.50
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D3E606A32E
	for <linux-modules@vger.kernel.org>; Wed, 25 Nov 2026 15:33:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26D3E606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=buKUYa8n
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5c0f0e04628so484842e87.1
        for <linux-modules@vger.kernel.org>; Wed, 25 Nov 2026 07:33:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795620835; cv=none;
        d=google.com; s=arc-20260327;
        b=n0lUFHiKihBtAuH4rAgudQ9ICH+B5pLwBwMWGj9M0qPpz9NBSsOE1nzp901Hq71cTY
         5QwJmvq/Yu70s94CvoyXZgwmtbuPthqg14rpxj/utXQvFqxX6QdNzeb3DcyH7jzHibgA
         wXVy/QQBKZHZYZqhWu0EDAnOb87B4I2KenwgU5VtCuzdsZk7oNvNT8FBNSEsjfzip+BH
         HtYK2heEW+lB7EG7GwEt43g6jMCvnTnZA/hQO+Y5hLrj4PITjaQOweGbzQ7bFikAWaaZ
         uY0nTmflEwrU97jwxOQO740FeRKWrI6MDHABZieUxh/5YiFTtaNrFRErwLx449wdIzSs
         EHhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wKqdQvSAuRnmEmZrQT2+mDn5yykXvIjFQspA9QZyZuU=;
        fh=C0m/XLiDSlBTSnKlUsJvGavZB29cLLTDLxi0N2SprPU=;
        b=kFgKv8bfSMZg/uGq5FVNan+B/li8EpW99oydfJGJSEVVKWpc7rGqpHc8ObeMLZr1CL
         E3x29qVfZrfJpzZ9R5MypVlvqNdrrQ/LCpiUDgz1DYITWX3f6+X/faMNRlEKzOfLjAOJ
         HPExhbYyDdtaZuaLVI4pzqS7v1FcyK2fWx+R+I6cZpAWmqQlPT4H+X4YaUNNX2nAPN1h
         TAOY2kHNCMybkBj6MiV5D3sMddwksx3Pmm3Ulv3OAdSRPmI6l5XBBQOFicRAfLyNuNsU
         AmTPudcUq8sv7PsKtINniD6WyCpRbwrXX6wbUrO6IGF70aPQTVjaMlzqoX61H4cshLrU
         eYMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795620835; x=1796225635; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wKqdQvSAuRnmEmZrQT2+mDn5yykXvIjFQspA9QZyZuU=;
        b=buKUYa8n/c+VXe6APnpgpXA6FOrq+FpjqfwIVQgo23FhWgtM2lNC3OswV9rT/1j1St
         s7iH62UZ9fSmbTJmNmOe1wusd6iKi7MKlpK7OQEZEeZVEAn1tcE9gW5483bhuLeVVlZX
         tGZhQYHe59rb/eOybw083v6sewKrRTARw8BaOX0EixFJjcVTURpw2ruRgQaNIr2d12TB
         1eAlRqX28isVPYAIbEdIx9S2DjhCtfSLFhVd4UQuba+fFbGKhnhcP1QT20dQyldgF5cO
         j9MrI9ffEitabU7NvGkF5I5XmQ7HGSV3Mvyua2JTeZmuW2ZM50kod9BFAcntFma3EQ+0
         sgAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795620835; x=1796225635;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wKqdQvSAuRnmEmZrQT2+mDn5yykXvIjFQspA9QZyZuU=;
        b=Xsyt9w1SpYKbCQnktP48z5tWsib5h92q0/woJCcKe4AypQ1lKanC78iZFCxX05rpoi
         z2yFfEC2KnDp9q1YJRR6O7LvJr75EXqyNj1GxPr7t3/QnTs80R+7wzO9mP053u2YW/R6
         I6i51ovikmcyqBqqudNFnUIFz1BEHHb2TBFIx96vC6H1Coo2igmQue1wjeaPQDsNlflK
         XmhV5blQVqqba3ieHPkGecjuPRdNLKksTNAhcpC4kE5SB2YRS9HaeSyYSjWy658Ozil3
         QHGm1S00yRK8/LwqSbgByMhlXksc15X8n5rOzCI+NywkM+ISbDMva2TszYyFBcL0sjJw
         yE6A==
X-Forwarded-Encrypted: i=1; AL+hErGX8Kd6n7rzJOLHSG6MNMyRO/H8MImNbLdNZs7lL8daZc6rsAmmjYPLcdPEGsBeRRJwaSSOdLWGD9nSKQFI@vger.kernel.org
X-Gm-Message-State: APuU4Z/NIM0HBQ0Tdm+8SJftpMfPTWT5b/coNVGiJqLH0mkaRepbY/7I
	tWQhaE6jQoncA8xK/5afENn+IirC4c0LhoQBivuEfcDAY8MaUwFVBZWwEoSm4dUETp+lwRTFjDw
	Wviwv78RCRktDQMkLwxcSEI0QKgBxxzY=
X-Gm-Gg: AZFdTZeT+xDxjl3MKsTNw8heUP6rvR2LYFj0LafqnGKIoDeR9tgU+DqqO3aj/ol8k10
	SBtHKJoACxpB/prUkGM7L0RF0EkWzBenRd5YhHcEXSrU6XeuGSyRoLpyweH/aWOFtmJf7nqTd/3
	IHnfDT+dlW3Wosl7Q+34Rc++IHFOK6nPZ8xdDaNduPZFJoBEWGkL4T/aZrgELQX6z1H8R7IPufB
	t2RHqYFITx3YtK+8Lmf5eY5IBnANl/vjrgb/tQLdmiUtmc/3Y2JNgKWbzlXZrM1tAcPrXMNcHBZ
	f1STNUgn4ogkE/Rd/chHqjE5ThN8fvnjE+Z7LK9AyitUsptCG7wPupbP5npIupFgmAbDVQ/BNXN
	mFeRivHWSKeLPL29j9lDwhKFPhM++c69lUTkzYccV5v4q9JHMI8feZgZJmGUr806AvrEo66CeUQ
	W5/eM+hu+/bmHkq9bzbHzK7SeuP36w6qYhLfcPikKIutfAl/fEGVUmPKcs3RthlbexFPE0eXOWA
	3y+bnzPeyPdOOT9owLH8bIVZtF+HXMo33FAC0HM35bA+EWDB0vwp3m1bzo1PDaqTh/Xvzw4
X-Received: by 2002:a05:6512:6c3:b0:5c1:4a47:b86b with SMTP id
 2adb3069b0e04-5c1bc785b7amr6221022e87.3.1795620835046; Wed, 25 Nov 2026
 07:33:55 -0800 (PST)
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261124-build-speedup-v6-0-141a4f861c67@kernel.org> <20261124-build-speedup-v6-2-141a4f861c67@kernel.org>
In-Reply-To: <20261124-build-speedup-v6-2-141a4f861c67@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 25 Nov 2026 16:33:42 +0100
X-Gm-Features: Aa3M54rAUhOIl7nJAGzRxUt_IUS4JYfamPQ_n0qFr3V4ZOsnZoEMWuF3JwFrbDg
Message-ID: <CANiq72kdpY_tr0Gg16b24J1J-Duj3YS4rJ0CgNYVWQqmQv=nxg@mail.gmail.com>
Subject: Re: [PATCH v6 2/7] kbuild: implement and use depcheck to check
 dependency timestamps
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Nicolas Schier <n.schier@fritz.com>, Kees Cook <kees@kernel.org>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-m68k@lists.linux-m68k.org, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 1:20=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
>
> A dependency that is also a target of the same directory (e.g. header
> generated by an if_changed rule) may get remade later in the same make ru=
n,
> so do not treat a target as fresh.

One more thing I noticed: a header generated with `filechk` does not
have a `.cmd` file, so it is not covered by this.

It matters for targets that reach such a header through their `.cmd`
file alone, e.g. single targets like `.s`. For instance, after
building `arch/x86/kvm/`:

    make arch/x86/kvm/vmx/vmenter.s
    # Change an offset in `kvm-asm-offsets.c`.
    make arch/x86/kvm/vmx/vmenter.s

In mainline, the second one regenerates `kvm-asm-offsets.h` and then
`vmenter.s`. With this patch, nothing is rebuilt.

Cheers,
Miguel
