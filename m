Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2F7357728
	for <linux-modules@vger.kernel.org>; Tue, 11 Nov 2025 15:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762873558; cv=none; b=IlPs0DZhZheUhdtXSn9Dw7fmdEdzqyOv/WAK9eWw2i8Rp+bZGftikeuHS/R+/I3tG71isp2UMrfHqL0v0CIfq+Z+UBSKk70oJxxvkADkw6hXU0ClaQH1D+CBaArPxW0qVBZR78g16mk7jUSIoYM/qRKpXMBXagjg1t/eKonXo+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762873558; c=relaxed/simple;
	bh=SfMT/5nRjA3afLzv9Foi5iH+LBhxZGY4UrfDPe3Kods=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UzJdcGQQsSc3DTP6iw9gHnsLcbV5MaK/klS1jhsKH5Z8w72+9adosdTY+gEzbJqkA/8SOtuhDH58Di+Icii70xBjS7x16MToXoH+udu/50YJqtBTV7ERvgL7zYCEtyIcRnq+DD+U8R+QxSUMk3OBYcY96A5tBgfT+SsY9ixrMfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lfrQT8UK; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lfrQT8UK"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4773e108333so26873625e9.0
        for <linux-modules@vger.kernel.org>; Tue, 11 Nov 2025 07:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762873555; x=1763478355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SfMT/5nRjA3afLzv9Foi5iH+LBhxZGY4UrfDPe3Kods=;
        b=lfrQT8UKNOejvXqbNKuOq2zmRAVsY7hM/XzhrWNyvmB+Qs1b2pcRDVhoeGeffXqlVr
         NBxUGPqGhhKktU+FHSIJ1umcgsEWVpbXZJgXN4N1dRWS2HO4hs9M3xkVhCifCOJxfqo6
         Peky4QnNdN378xqXzHDkw3IxKg+pbyw9Uips+7UKsI8W8o8OjSvbv57Z0fZagvLllRvZ
         QW4IKHepAieNuLrKGVvuslv4dzi0fgozF7BkW9kTsOXjC3eHDtYdmz/AraZNm5rUxOWx
         Fnl/hYA30ITCU006kQXGNqXKFcurUhrkvgj2LZmM22PHDmMx86SU+XPDIPU5jHoEfi0j
         U66w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762873555; x=1763478355;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SfMT/5nRjA3afLzv9Foi5iH+LBhxZGY4UrfDPe3Kods=;
        b=q3IzQMkZV2o95tAT9o4Uh8dH2F9WvTrDc2KHKPGmr2BYJaqL2G/nd+ZTwYC8e7ZA2L
         nzZYebk3yKzp+HqchdVvAs0BXF9nwxtLidvL9A6tPjmVYaTQXnPZvVimIPRGPeL8a0XJ
         7e6JWnlPVbzX7978yiLi48qgBga87BSFGE9rA4GDvdRihqu8AddZYTEGDE29W/x9Lr9s
         3kq8RSfAr6/GvI+TambOTbDwxswN5a1Gtay5CjO25oyfSYwa25+x/biancF/KgNYav9c
         8uPVBpPPQamxWFnARV/6/wZth2certMsnbY7wp6T1yDdESLyI82u+ep4OQdTKkqp6L1z
         9/Fw==
X-Forwarded-Encrypted: i=1; AJvYcCVRhSKcCZGTH+WM1MUUYE5odn+FOFAjZpqFL8JTcD0pIwEDjsnJuETn7BSsRmEgPi1LhPP7mDSzG/ThE3QF@vger.kernel.org
X-Gm-Message-State: AOJu0YxyrQmGJ5IGZCmRcJ05347CcLNtZ+7OzbggFydprh7orP5WRKQb
	3MhUK8f+kTcvoNKzWZtCYO9jzLDDmLS3KV81xJ+dTmvp2aURWvvqhdHwfOEu1KCS3ct6jFt+VcU
	783bZL10hVrx3PSF+fA==
X-Google-Smtp-Source: AGHT+IGvgucKwyCN8EF+pU643WbqgIgijDo80ZsWN9AosRWSEy/CQyb/HN1/S31aszXHJHlV1eCqBbXhnvjyXGg=
X-Received: from wmlm3.prod.google.com ([2002:a7b:ca43:0:b0:477:554c:6842])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b0a:b0:45d:d353:a491 with SMTP id 5b1f17b1804b1-4777322e253mr92021425e9.1.1762873554751;
 Tue, 11 Nov 2025 07:05:54 -0800 (PST)
Date: Tue, 11 Nov 2025 15:05:53 +0000
In-Reply-To: <CANiq72m4K+UZxodnKqdx3cowbYB+Mj_Z0gB63j=3jE+E-x+3UA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251110131913.1789896-1-ojeda@kernel.org> <aRH9Tjf0tszyQhKX@google.com>
 <CANiq72m4K+UZxodnKqdx3cowbYB+Mj_Z0gB63j=3jE+E-x+3UA@mail.gmail.com>
Message-ID: <aRNQ0dymO5GIBc3e@google.com>
Subject: Re: [PATCH v2] gendwarfksyms: Skip files with no exports
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, linux-modules@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, stable@vger.kernel.org, 
	Haiyue Wang <haiyuewa@163.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 05:48:51PM +0100, Miguel Ojeda wrote:
> On Mon, Nov 10, 2025 at 3:57=E2=80=AFPM Alice Ryhl <aliceryhl@google.com>=
 wrote:
> >
> > Is gendwarfksyms actually present in 6.12 upstream? I know we have it i=
n
> > Android's 6.12 branch, but I thought we backported for Android only.
>=20
> No, you are right, this is just me being overeager. It should be:
>=20
> Cc: stable@vger.kernel.org # Needed in 6.17.y.
>=20
> It would only be needed in 6.12.y if someone actually backports the
> feature (which does rarely happen, so I guess someone could have found
> it useful since there is no Fixes tag, but hopefully people would grep
> the log in that case...).

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
