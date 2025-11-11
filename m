Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8248234B1A5
	for <linux-modules@vger.kernel.org>; Tue, 11 Nov 2025 13:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762869542; cv=none; b=q//WrXJVL6jMyqbxOEPP5i8mHH1U2zGRiT9itBKfnKE8bdB1OHVf5TWzkQpFzP1Mfo5xo2bNGwkLy3ctQqH/RfBf5tG168Y/5r3Eknzun9lf2r4aXL/U81h1ftpWOAvmIK17PgWaFvUO+wQ8KovdgbkzcVXKBJdwiT/qldNLKzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762869542; c=relaxed/simple;
	bh=hRUmzVbCzzL89fOTZQBAaUfGAwTMnx1MK/93dcHh+is=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cfA7CG8ijWuDP4Hv9GZLVzFm6I+F7DuIIeYpHl5Mbv28qm1jFFHiobVWzFgDFThbCcDb7Wl54C/IrizlMEVOqVBlOwt9tE4YYTUqyT+i4EKo3jNhfDrMfWSAQxZFpHxszYeHy1enIIo72Lpl41vxiTVnIUDz0QX4Z2SAKOntZUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZsUgUUo; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZsUgUUo"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2960771ec71so5023975ad.0
        for <linux-modules@vger.kernel.org>; Tue, 11 Nov 2025 05:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762869540; x=1763474340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRUmzVbCzzL89fOTZQBAaUfGAwTMnx1MK/93dcHh+is=;
        b=YZsUgUUoLezCFU0P/y4ACxySgN2oXPKkH5rAUf5K/Knu+yjMKYIEAtI7YWLE1CRREH
         G4CuuxoaTEockrL6hXAlWf0lY4nQRzzL80T1q7fmEJSsVau+53U9PGuFNWSL/5ALXvZ9
         gY4Gy8aWTsH+WCrDPGfy3++IOkelaCvSmWKF5ReNu5O7A3o5fX0ZZx4+cq0XO63GN9qd
         bYV9JSbp9+UvllV9KKNUO+tyGt51I3QqMtssFeRcwbmHn5h+RNSgJkV/O2Rnzmtfj4zK
         CVY9Huk2VfkwFwl9kJtqYxHo8j5N51q9r4sCHWCJUmcuSGkPkMEVb2wS/9+OgyV+2kBx
         vg9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762869540; x=1763474340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hRUmzVbCzzL89fOTZQBAaUfGAwTMnx1MK/93dcHh+is=;
        b=H/2hcgg0lU4Tt08asSB5qq19psI5u6S9iesV8yXMMhvWNWYyPghsFs3mF9yPUmqMGA
         8S91vfzfNHpoB+O97qdcfTRvlf4QKM44F7Le+Czk7Olx4HtL3256uoI9QJCVbAK0bXG1
         ysaVysDE+QWCWE4Jraj7fTBeGE4bjYSSQKg+/OrGbvsH39e+cULJL3v5whemmHYXmGze
         Fpt86pWVtt5lqUUlciX/gZivajjGujGplN4YWXJ8wjXKg5DeYfGitrAiy71RRqqptTzW
         tt/XtMr4H0JF02c+eTpQTrhQN2eUgOl5rFcmBKxfOappgMPCEm50MMtsoKlsbyIP8t7D
         GZnw==
X-Forwarded-Encrypted: i=1; AJvYcCW3uaCkrf0k5jkKjDm+7HBw2WA4GQHmV53HDbEbPMk1Ukra/srqIMIGR4NZh+bPGcgOzMJL7Vl4VCRxsZMv@vger.kernel.org
X-Gm-Message-State: AOJu0YwgfVr4rV+3fwiLP2q9DsvRHztnvfp+Ksq0RBu30lIxhejkiauC
	Qc/+ltwYS+4BZbRhaKgYa+kiYmqy3rVaQZ1X8WuZ9QM0U1TvvFqL+yytr3CO7YraZ0g9GvEIyh9
	DWRc4xb0KgUspNEoim2DGuWQ2CYy4UFk=
X-Gm-Gg: ASbGncvB0lwz10AdEjZBNQxDCBIjhKezordnuhJnl4xAfCnqgSxbYGdF7Z+xG+RCUxb
	HQc0gHIoBXWC5ekgd4tFRZzy3wc2ph7g2pfNiEo914OkFc2H7JorbVwNmGI7ldFkGDMRcTf4jL8
	ZhCuaB9NQVZqnNVoWcUR294wXC3gX5R1GXFZpCl5ELE80/3kvLdygEQxGC0EitrQsrjwZLy4JbU
	QhhH0tZAXvDaXeVNoljPrWW4GaD7cWCWWM/Tx952U5vAfH6T6nWK0doIUpSNebf2isV7W1wBq4w
	9lQn+5rzttR/jJ5QXTgF/XEOUsfAVDgp2jn2p0RH92DcMZOKTGqSRenkdgLfIVBduZNCxq7UI7L
	azfwN59Lic5cSig==
X-Google-Smtp-Source: AGHT+IHYXxM/I5GaOybb6g1yecFYohV3zCOa1VEm8f2yGvBo9rJ8osfE6aj7FDf3tvSiEZ9Z9+sidUs9ZqMaIBw6rqE=
X-Received: by 2002:a17:902:d48f:b0:295:54cd:d2e2 with SMTP id
 d9443c01a7336-297e4d096a4mr91553105ad.0.1762869539841; Tue, 11 Nov 2025
 05:58:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110131913.1789896-1-ojeda@kernel.org> <CANiq72mjFobjfQEtNvk9aA+757RkLpcfmCCEJAH69ZYsr67GdA@mail.gmail.com>
In-Reply-To: <CANiq72mjFobjfQEtNvk9aA+757RkLpcfmCCEJAH69ZYsr67GdA@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 11 Nov 2025 14:58:47 +0100
X-Gm-Features: AWmQ_bmjChoTwnLfQhUmk8zTDZP6XuF3N7zYh0KKb3TDMGl3YRN3n87n4dAkPXU
Message-ID: <CANiq72kaoYYMq+ghFsa+YrRbTE13M2TrtOMwAK1eV1Sk9tEQzg@mail.gmail.com>
Subject: Re: [PATCH v2] gendwarfksyms: Skip files with no exports
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, stable@vger.kernel.org, 
	Haiyue Wang <haiyuewa@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 2:54=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> I will send a couple other fixes to Linus this week, so if nobody
> shouts, I will be picking this one.

Of course, if someone else (thanks Haiyue!) wants to give tag or two,
I can still pick those up, and that would be very welcome.

Cheers,
Miguel
