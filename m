Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03752FF486
	for <linux-modules@vger.kernel.org>; Wed,  2 Jul 2025 15:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751470076; cv=none; b=NHajXSbXHjOsFjxi1Jom/hk4aGXAdrV2CiG+dVTIf+nCS7FeiYh56TBXwKe4S7tbOly366ULKn+hC1P4asc5fx4pFTNDUClb4F+/HXk+KaIsogMtRipKC5Nv2FHtDdGJWPcVPQTllP9uvHixEGvZg3NwU0XqOAeN5+zkKDc76XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751470076; c=relaxed/simple;
	bh=R3w2XCZ+9hC/UQRD0VOIOyl0Fwy/AYwdVSqZytDRbyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b6ZiZ99eAWi+93CY8nIAgzi8+uDPi2+zS49Sc8rxCeg2WmKM8g8akNenewfGb2dOcaVkviSAHaaMICkJt+v2VjcC02cUvV2j7dx917kB0/QUi9w6X1TZ9cAsR+kK0iDRwG05NXPM2wQUFrXrSHJoQGu7qYQS9UW0X/ZLawryqxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fSRIFJpu; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fSRIFJpu"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a548a73ff2so6327753f8f.0
        for <linux-modules@vger.kernel.org>; Wed, 02 Jul 2025 08:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751470073; x=1752074873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ugfvMw37FYCbNgp16hJSt7OdezX3ZWc2zEhd8WWY3I4=;
        b=fSRIFJpuj7EbDCIioeymFx4JpGmeIBGUU8TNs2Sms+ZzpNxPexJaygwc5h8jJjC2kh
         h3GjtjDlVwuNtZAizzbxzdybHmIO5zRDx3J9V9c+jX8C+h648/XqhIWcA1jfPfeZR9O0
         keB+6i+zgTBlWaET3Y3/oPjvY9QcU1WUObl0VHr2uLw2rcSxNCKhF4w909PmbLbf8ysC
         66TrsnLYfhmQBMsy9rErWxotOedb5jOOI/j5kH0a+bOayASKLHwWyC5Dpf+E3gchb51M
         BHdprCwvo3QGnXASC1fryotJTfXSeMS4GadXHyyLduDGbkBw+7t2Td1WtIIsYIxaPDw2
         4KaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751470073; x=1752074873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ugfvMw37FYCbNgp16hJSt7OdezX3ZWc2zEhd8WWY3I4=;
        b=MpPNRgKG8r6m/nmg6Yk2RX72b1xqVK8VN5zvkEby6j9V/yUeZGFnH48xnFTJ+vFj9r
         9v3mvw/fe29e1jzDzPoZOB37LxstmLpvMG5PKG56JWLeCaxTZ7zOJs8L0jTQqNaeafZJ
         1Zq+eRjcj1QsrWPZsZ0mTXbv5EMM4FdmU+uzB9S8RdET3t6MI8647b7EIfHqrzLcmbGt
         eiKhaw5kiIZaVqyzBJ8MYHyy3EkqCucGHz9waUBwM95FH0k2F6xC+OQxQDUx9HHFLt38
         GjAJBhDfZFP2iMBl+qnxrT0WUZqzIDFf5c7DgQPRiZZSrwQqUv01nRs6fmtZgzSxmmzL
         Vh7A==
X-Forwarded-Encrypted: i=1; AJvYcCUtefL4y9QbdEqLWa7s7qFe6zRosXm41vmUHOZFPR4GAOrnFXPPxBwkbxkaoRtTxdg/JScJ4aNJgHS847fk@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb4f+EXwTqt7Y3+l8sCP7NnJYZBwil9V4aZVdLQsgXrapTAnlG
	M5AiCrjmB9FtK18NIMMngaHw2vFVwVZBNjkDCYV3gotptd+d8SWJmn1BNEmb7BdIev1/WgohRCR
	w5+HTTIJPlNpezQqez/fFshe2yGt72CCEloPtMETl
X-Gm-Gg: ASbGncsAygoMVN0nSlx1p/YeamwACiHf8M3fCh/cZ4y+DwK6tFDo2auWUvDCoDh5e++
	qoYSML/PFZ371OlzAtGHTKGCGQSdkoR3RT2/Tn/qNyooS0s+KtnwydbDRz+t7wsHRq8PbvcDdv4
	SmCjZ+/lkDrEQURR3Z5qMI36zQS22ubel4qnYaTiLNQV/m
X-Google-Smtp-Source: AGHT+IEXxgvMAbbclIedX4dgfJFsqC/LVdMO+VKlBTNEwybEIPdTuBzGSh5PvnP88V7tuXnmlGMxd5H2vPZ17Yd18gg=
X-Received: by 2002:a05:6000:2891:b0:3a5:527b:64c6 with SMTP id
 ffacd0b85a97d-3b1fd74c9bbmr3330783f8f.1.1751470073141; Wed, 02 Jul 2025
 08:27:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702-module-params-v3-v14-0-5b1cc32311af@kernel.org>
 <20250702-module-params-v3-v14-1-5b1cc32311af@kernel.org> <DB1NVTWHU7BN.2WGPMAY9LQYNW@kernel.org>
In-Reply-To: <DB1NVTWHU7BN.2WGPMAY9LQYNW@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 2 Jul 2025 17:27:41 +0200
X-Gm-Features: Ac12FXw61cMF6EsKoC5KmH0MvT9whf775volIzyT9NHNJ14IR5rW7yw5x1K4H9c
Message-ID: <CAH5fLgiOK-zA0qT1dis-BsrEAk96R+E8e_F_361w7kCq_uxn7g@mail.gmail.com>
Subject: Re: [PATCH v14 1/7] rust: sync: add `OnceLock`
To: Benno Lossin <lossin@kernel.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Nicolas Schier <nicolas.schier@linux.dev>, Trevor Gross <tmgross@umich.edu>, 
	Adam Bratschi-Kaye <ark.email@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Daniel Gomez <da.gomez@samsung.com>, Simona Vetter <simona.vetter@ffwll.ch>, 
	Greg KH <gregkh@linuxfoundation.org>, Fiona Behrens <me@kloenk.dev>, 
	Daniel Almeida <daniel.almeida@collabora.com>, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 5:07=E2=80=AFPM Benno Lossin <lossin@kernel.org> wro=
te:
>
> On Wed Jul 2, 2025 at 3:18 PM CEST, Andreas Hindborg wrote:
> > +impl<T: Copy> OnceLock<T> {
> > +    /// Get a copy of the contained object.
> > +    ///
> > +    /// Returns [`None`] if the [`OnceLock`] is empty.
> > +    pub fn copy(&self) -> Option<T> {
> > +        if self.init.load(Acquire) =3D=3D 2 {
> > +            // SAFETY: As determined by the load above, the object is =
ready for shared access.
> > +            Some(unsafe { *self.value.get() })
> > +        } else {
> > +            None
> > +        }
>
> The impl can just be:
>
>     self.as_ref().copied()
>
> Would it make sense for this function to take `self` instead & we make
> the `OnceLock` also `Copy` if `T: Copy`? Maybe not...

Atomics are not Copy.

Alice
