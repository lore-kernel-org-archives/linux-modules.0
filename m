Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA53A20FAB2
	for <linux-modules@vger.kernel.org>; Sat,  8 Nov 2025 02:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762569447; cv=none; b=iE0MQd+DeCoHGeQtlYTVzFBzG3pKSCqD/Eu8GlwIOCEGU7oKwF02/kNkkBU0K4oT2EVZLzRyjrLAeBENMMaegtcApq9esVqhIUVcAVJ056C/vgYVIaigqxprSeBZlDVsjDqh1GqMjNrC49VydfJPSnCQ26iNA4gUSjk2PSfTbQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762569447; c=relaxed/simple;
	bh=pZs543aQJXGBiZv1p3fT4nEMYNcLibbhNgR3xp64diA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZafAlbImp7ggpCGHZeZHUdNnGBHzaKNMd+5MOM6MMg+TWwnY2cIR6+4BZGXPONFeOx1MOVshC3njm7G6n3/wOda1pdoBr26DfnQvFafpVVkJ9fx6KovOK/j/S0WYIlI9t7yHTz0goFqmvQ2dcTdd1BjAfIezSIuryItfo5+rblM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4Pz1O8f; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4Pz1O8f"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-29498a10972so1211835ad.0
        for <linux-modules@vger.kernel.org>; Fri, 07 Nov 2025 18:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762569445; x=1763174245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZs543aQJXGBiZv1p3fT4nEMYNcLibbhNgR3xp64diA=;
        b=D4Pz1O8fBgxVfdLn0kGOEPXb0Nmg76AgpJ/stxFpJ6/vKMwRMy+tyE6VHmRef8yl5a
         J8sC7qAT32BKsKL2K+sbGtrDuSBnfDyI+7SfLKNmzGRO1uevSAXTYuv26lKUoFrw8U+Y
         B2iSh3SbPRyQIzoTfh5Aufl4OIfIF+RhjQYQT4e6cxaOWLx++qhEZNySZlLeQCZLhZTr
         JlJy7lOhCEQfh97v3Fv6CRy8JV/mXtkpggFW37TBz99luVoUGN6om9GQHH+RO930XbnQ
         R1Qp/PmzrTRGrjz9+oDbKhBd0qSgwkzT7MHKilazuxuiRpEcpB6Nti0nr3KLk1Y+q/5D
         o6vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762569445; x=1763174245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pZs543aQJXGBiZv1p3fT4nEMYNcLibbhNgR3xp64diA=;
        b=SrI9ZkfRrxInO5xhr3dQOux8skK06SwHo/dsJsJeQMfrSJxHX1f/pDBqEHjoP6W0Pb
         uwpVsug3GsDSOtR2snV9C5ZVVdP6QE28+fsq7af1rZgrNs/kQCKKgU/I/ngyrjJkBn5L
         TSI61VT+6fAHqw1floPkL/SdKB+XXJ1sws2dfJCkaJZj1AXjr51hh1VzOxzJ9dl6/98/
         Ggz6HMAhRFWxyYFR989xy0B9lvMzDPBIC5YA/CsheNR5lFgiQ+kKYaBDJIn9y0YvuKBL
         Dq/YcFNlz6NGpF2gP43mSBjj6o/RXjd+ndYvHZ0HpBTmuOpBVVm0+blGBe9E3ep+0BcV
         0F3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQPUHj4wkySd+D//6qIPHxrcHSB5+n4z7UxQ42VTwoaDcBa3kAZYHLWHnTKllD9DSjZxx21rm4c7cmpF6S@vger.kernel.org
X-Gm-Message-State: AOJu0YxgmrDqZez2MUQmFizD2fMGbBMl9fvFNtzoTqOjnaSY3qSkM+NV
	Qm7hTiqfSrbCznWEbtyp5UuKH3T1Q+ttuyBAZZsXAVjKr6J/PAG/KjdKkIqO+NiCAzGcQ9UQ3CR
	3ly5k+Z7oFO+2u2Q9tGxxoN2hkNgaDAg=
X-Gm-Gg: ASbGnctM6obbwwKsBIogA5CLgOYfNZxdRW3o96vsPokKIzrCstY9KeBo2JA5q5q0vL+
	qsaW+LU6cegYnZCmwqMELz4nOfdRgorwuHUZj2Tel1eETH/HzHqGfthoqbvj2i2v7MA5rGHHCuE
	5xT4+jKqHrsMrvQjaI/Dkzfx4zIVO+vGT7Q0oEWEJk4cl8UyLgDf4QfOL+BgFU4FoV1FSJYIIlR
	etY8sVy7xp3OYvR0FdLx/6fjazi3eBh0d/IhKVDBSkxKq0qE2JD5+/h/zJOKkWRAjrYm+1XFgRu
	afKAeNrmkk9UelW+7uc7epBJXwD2UpNuEQjHtf2JTiRJA6364zwrddIAUVM5treYbR65meQKRvg
	L052YuZo5zYXooA==
X-Google-Smtp-Source: AGHT+IEovvjVicfDdGQT2CYmrDOWKJSfWNjNZjATvixUw1CuI60OG2r2rmWY0cQTlJoWG3OL54m2HoMu3xt+gxb8f9U=
X-Received: by 2002:a17:902:c409:b0:295:3262:c695 with SMTP id
 d9443c01a7336-297e5646bd4mr8325045ad.3.1762569445056; Fri, 07 Nov 2025
 18:37:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251108014246.689509-1-ojeda@kernel.org> <CANiq72nKC5r24VHAp9oUPR1HVPqT+=0ab9N0w6GqTF-kJOeiSw@mail.gmail.com>
In-Reply-To: <CANiq72nKC5r24VHAp9oUPR1HVPqT+=0ab9N0w6GqTF-kJOeiSw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 8 Nov 2025 03:37:12 +0100
X-Gm-Features: AWmQ_bkkl97L4KdKe3MLMAG94NJvyqaB6LbDFgvfVIDBf_nqC8JcMtGIqLcDcT4
Message-ID: <CANiq72kWWe_w-0088SiGvKFrh49P9wRcPxQvkSoU=SOpSrHbKQ@mail.gmail.com>
Subject: Re: [PATCH] rust: kbuild: skip gendwarfksyms in `bindings.o` for Rust
 >= 1.91.0
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, linux-modules@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, stable@vger.kernel.org, 
	Haiyue Wang <haiyuewa@163.com>, Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 8, 2025 at 3:30=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> With `#[no_mangle]` may be more reliable and it also gives an actual
> exported symbol.

Or `#[used]` to keep it mangled since we don't care.

Cheers,
Miguel
