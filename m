Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597F729E0E5
	for <linux-modules@vger.kernel.org>; Sat,  8 Nov 2025 02:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762569602; cv=none; b=CFXocipdGVnkShiH7I/LH7jE7pk/gBEQ7bWqHFtc7WSJLIVCbl9rLQgUfV+KBUAgAojy2tr8g0aogzpCvPbn4om6vvNielZGafDhVl5VtmUOe2k5uwWDb9SXMGlcyu/a2YHrHY1CZG8D/CkmKXc54nCYcKveV8TKRclzX2IE5xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762569602; c=relaxed/simple;
	bh=m7LuMJmoMsw8OhL+zbye2ZVtZHlwh+NL6ZssgXY0Ijg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F7kuu/f+Z6hdZl42BNQ+Ahiy5aBUlmHa359lIuFlbMTNGe3ozIYGb3pG4bOWHkW8ljSwVqIBPWKesIE5Fa/gMALOnfzTTeBFxDPUO7ntzyDwlY9Oe8S4RbmBHmExZ44NEZBuzHtSWxoPrIbz1z/1USzcvhhIOK3L5LMSeG3rZac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HqJ/2Oi2; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HqJ/2Oi2"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-295c64cb951so89875ad.0
        for <linux-modules@vger.kernel.org>; Fri, 07 Nov 2025 18:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762569600; x=1763174400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISo6u9Qc4EcSrRzi8tm5pg3DenyGQGDB6em3HujHsKQ=;
        b=HqJ/2Oi2+EUUSDE8o79uHROYexzAQ5agtvvJkztq82qOJMAHY+E+DX+9genkeOqvA6
         yxZEOaijZaUYf1X/po09h2wuan2v9mkI13mkSPS0HUQVqhS1/ZasELwO/0P6o+xHNYtp
         WZLZL8THB41T52tT5YKZyhb13LI2sSNULVZurgXxK4diYTiHAARp0bBtBSO0dhCr761P
         kSKksz52m5yErI9VuSd7WdSxih58Gvu3sp1Gij9BgWVNbv69ayjgaGV7JO3R4zPOpJTH
         sOVWZOq6waoE8+teFt19Rj+t6R1R/bkpMRVMcxpKWQA4lp3SQ8+TPg/6QAviIFVoqcpT
         o1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762569600; x=1763174400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ISo6u9Qc4EcSrRzi8tm5pg3DenyGQGDB6em3HujHsKQ=;
        b=umBUBgdSJxfQuNJzFM4vkBkr/SLkRI0yJ/o/thIL2SsUpiwDeiCvqcXZw0iyw8fFG5
         fN3c8jB0kSkXux6jAUt/kUNUHz2nfCZTWl2RZChcqNVTimQvWnuwRkG5/gpAvr20kFGH
         Tl6r8n3lTVNOOwCUMMHoigW++cNCsveHOBU6OSkWwiBNOPF8fi+rYQBfmiSV49AZkwn8
         TRiy6JsGvNHscV0/Fh/TUBhSDnmDOW7glq5Fh793CPtzowyHYsESqEW5WdU59x0wAiSq
         rf+SBSinZnxXxOBifmgxWY+qYOICwra14Hw9pwXpuveBUANkb7nxnCg2hOngJUzwmj5U
         MnSg==
X-Forwarded-Encrypted: i=1; AJvYcCXcgs55CrBJtgIEbI3gsaX6n1v2KIXGJ1Grp43K3tBSN20OakF5lX5soeMlPDrRSMLO9hTDhQZUYG87SDzR@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4ijTmHGb0eJekVi9Uujl+EaS4/3E8DoK8h+X5c81YLKiEF/VR
	8yXhvO9kqIHX9nYHYGgmigLXGtqfVBjQYIUiesQ1EumlcSeHF7edk5j3VOUw1CceuWdETVeUysz
	YO2EaUe6imeHB86eV/JVaSAh5xbvLlFG8Y366aOPv
X-Gm-Gg: ASbGncu7Z9PhyxSs+AbyUXgM691DUXr4+FGt4IXEamzeEvOUNOSC9AFv4KiRbVoxXPt
	THj6bYrTwAFtZBYxwZ916QdwhhRATfAoyQ9HqBiWF5iTJDtm3BRpLI9HWbYfk3ughILk0GY7r2C
	JxNU4UccekKdKKmAQ44tUb4x0sghT0y0ckynO9N61AaKntg+xoEp9Tx9PHTPc2fWHRVsXDCCAqb
	gR7gc+gJsOpJz0g55ENHddihIDbE7Pmy7rzczWoI6vpLL1be+tqzTwYcA==
X-Google-Smtp-Source: AGHT+IEcWbEeQy5nVbkbDh62AxtpCgxrZfusi9drFXZyCGpbyRRVAuf5K3IddyD+sWvIScB6XWD5N0JFil1/Ikeqm58=
X-Received: by 2002:a17:902:d502:b0:26d:72f8:8cfa with SMTP id
 d9443c01a7336-297e7df1d8dmr1129025ad.13.1762569600006; Fri, 07 Nov 2025
 18:40:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b8c1c73d-bf8b-4bf2-beb1-84ffdcd60547@163.com> <CANiq72kX4Yep3pNVq8Ge=txQbPnMO=zKsci5cPgz5LDS=D6NoQ@mail.gmail.com>
 <CABCJKud0G+Xh+Wbtg4SDGvk4Yh5nmt5YgHEPj-H0y8GO5R3Amw@mail.gmail.com>
 <CANiq72mw66ADx7LoUuqY6h9KCU=uFzcNQXZ21kMP7jBjCyyaHQ@mail.gmail.com> <CANiq72=OFO8fBpJ6xvGunYrx5hXfcjQJ=YDqFxtMPWDzfzwpKw@mail.gmail.com>
In-Reply-To: <CANiq72=OFO8fBpJ6xvGunYrx5hXfcjQJ=YDqFxtMPWDzfzwpKw@mail.gmail.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Fri, 7 Nov 2025 18:39:23 -0800
X-Gm-Features: AWmQ_bmb64VymVFf8Gn-EuS7qsAtPzXyfc2oW8oZ6cRO_18rrTpp7PAlC0xQ6Tw
Message-ID: <CABCJKue1xeY7CGHScG04PdHT6TOPgsOpZVKWwgzO65qwAcbEJg@mail.gmail.com>
Subject: Re: Only rust/bindings.o build fail on rust-1.91.0
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Haiyue Wang <haiyuewa@163.com>, rust-for-linux@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, linux-modules@vger.kernel.org, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 5:42=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Thu, Nov 6, 2025 at 6:54=E2=80=AFPM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > Bisecting nightlies, it seemed to happen between:
> >
> >     rustc 1.91.0-nightly (12eb345e5 2025-09-07)
> >     rustc 1.91.0-nightly (9c27f27ea 2025-09-08)
>
> Ok, for reference, it was upstream's ab91a63d403b ("Ignore intrinsic
> calls in cross-crate-inlining cost model"): the object file stops
> containing DWARF debug information because the `Default`
> implementations contained `write_bytes()` calls which are now ignored
> in that cost model and so everything is essentially as if `#[inline]`.
>
> If one generates the bindings without the `Debug` impls, indeed the
> file stops containing DWARF even in Rust 1.90.0.
>
> For the moment, we can just skip `gendwarfksyms` starting with Rust
> 1.91.0 (sending a quick patch for that), but it may be a bit brittle
> in that new versions could again re-introduce some symbols that get
> exported from that one etc.

Technically speaking, bindings.o still exports ~1500 symbols even with
newer rustc versions. If we don't actually expect modules to use these
symbols, the correct solution is to not export them. Otherwise,
modules that depend on these symbols will nevertheless fail to load
with modversions.

> Sami, would it make sense to "auto-skip" in `gendwarfksyms` itself if
> an object file does not have anything interesting and then remove that
> from the `Makefile`?

I'm not sure it makes sense to silently export unusable symbols. I
feel like we should either ensure there's debugging information for
these symbols, or just not export them.

Sami
