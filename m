Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD9736C593
	for <linux-modules@vger.kernel.org>; Tue, 18 Nov 2025 16:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763483213; cv=none; b=hQwsal6tVX84BSfYc1gh/+J5EEuCGJhMoCc+oBr9NXjZD2DsoSJ1W8ltXbx0lDncq0nctBc5hcoNZmedA0XbWl9AXRAGoojbagWQ1jpWIVuP1bxiz4WrseMkdEpGHM82rKPER9U72Mo3sqcUbYvWvzD+YZJsaUzlDgwLN+xBtX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763483213; c=relaxed/simple;
	bh=FwtecA3cou5swpKk+7V9h8LfHIUHPkUFVZFloQEb+dQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pC2sU3pUNayNb0Ts24SKJKkMGHDMFqjf7ZZJYmO5hPCYP0oHtw2KUN1Udoteju7CUdXuO51JDQAbXsNRTAB/Y2CTVd9LybHLCZrRqh9jP+ZNL8IFyS2gdjpoDmD3/p8jN53GTq5gjXKF8gC8GtXJ8aiBA2ZgN5Io8NIXL3yJQMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NbiHbK8s; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NbiHbK8s"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-295c64cb951so242885ad.0
        for <linux-modules@vger.kernel.org>; Tue, 18 Nov 2025 08:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763483211; x=1764088011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FwtecA3cou5swpKk+7V9h8LfHIUHPkUFVZFloQEb+dQ=;
        b=NbiHbK8sCl+nRR1cXVIWdYqN0I3VLsKCKKWXS0wPLrvekyqFENCVxrsZSfo47wLxTw
         z//TfUqJslTZvJ7bQSfH33MtR3xV+GmKEdC6onwso6GT5UW+RIoIrZf4en+KgLGz5Nct
         2wSjImMNMkayjuFvq0UGue3kgZ/m9LFxk6tWEzSS3SHOSoVEldvwX3LjdMWSfznyiuTD
         /YyB00J6YMdyn7K77TfxB1eB1otkKcXWVI1j0ixgMAUqQb9sw0JgDuuBGzZhIhTw52Uj
         54tEhDKt4ruVyIVDYVg48gLevDM0KSo+NBDP63zbu5OVjHSE5rJBlAAWXkC1vVkZvp+L
         7mcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763483211; x=1764088011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FwtecA3cou5swpKk+7V9h8LfHIUHPkUFVZFloQEb+dQ=;
        b=Ud4vZIfqB7uFOKMctZVWGkqJWF1S/mIgEs7G8A+K3R3n7iSUNnyR3Unq11xYjnQZSl
         Bcn+3zQlIDuEpyd9TcETHuP+HEGtkn7LaNz8FUwUTazafbrauZdErW7PjhNn4hmf11qr
         TCHq9x8804BG1FVSgBTPR4QUKQzaBlkZvMxxbq16vOnRCtGu8UGI3DEVZ2xC6EIkv+uM
         FpzjCMPZL2LZwLrqhgd9lC+UH/8wrx+2b5f5mrA3Pn/FE/EhpMeTNfvhofchTrIZQYhB
         EqKLvalZ7YKYaH5Kv5e+jFqjAwHxXa0aYAXbGG8HdY/tBYz8H+bBPtIZ4C1BCztsRFPc
         w0Gw==
X-Forwarded-Encrypted: i=1; AJvYcCWTF407rDTJlEziHXnfYu97/B79iFMFPkXbwAlssy3MSMi7hUoHt085Y/eHGG6Ix7XccH6taqI3WRGbb46Q@vger.kernel.org
X-Gm-Message-State: AOJu0YzUAQXfLqkKsf/oXonwG6sXjWL/1lOlcM9EdzczvT+j7tftUcqU
	QlzWkkXEw6Z5WIPsPFlr5SJhJDcungK+ATXyO5NC+6CBfhau0mK5CjdrBfheCbtdBdmt49G7w2u
	bkyDmkW3EG49WTtM/i2jxyvsA9zgz2LznyH2g0nqV
X-Gm-Gg: ASbGncsc+ZZwTX/10SpSBC6SZbKsG+d/FxcXWtHfpEKHDsqYHSohVQ1Qrbgm+KnLIAD
	Y5vh4zOiYknJfbIv0xjq2VJQRTD+NsmwVTRCnRw5uekstw73m59UdfflIOKscUm02mbWJFX5igc
	vx4hCRuaTDGgTRrDuWpHS/Oaj5n/EMsJ5/ZlkjqQlTJF2cChFoHi0gWRBdM4q+xl7wz9yqs+M/7
	rhYX1UlutK0x6hSE4zSex5B403UurG44ToXA6mgj3CKiVb95BFmgB/g1GdnjcgB2RM1chZlF2EQ
	XPk=
X-Google-Smtp-Source: AGHT+IEttx3J/mC4gE4KpQ4cPRjj+rRjuHjvkWN8RJrR+j19dbMNf6uYkFpkl0xwq9jCxBWF224ugSC9ScsaeVYU4f0=
X-Received: by 2002:a05:7022:4387:b0:119:e56b:c1e1 with SMTP id
 a92af1059eb24-11c88f6e153mr87381c88.12.1763483210529; Tue, 18 Nov 2025
 08:26:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110131913.1789896-1-ojeda@kernel.org> <20251118145741.1042013-1-gprocida@google.com>
In-Reply-To: <20251118145741.1042013-1-gprocida@google.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Tue, 18 Nov 2025 08:26:13 -0800
X-Gm-Features: AWmQ_bkpM4OnhqoM9DwukpapoYV-fxdR_ddUQfMp-wv3ty5dsyWJZ2MH8TZJaP0
Message-ID: <CABCJKuc0ZwN23MX4mV=vVne1giR=iWKSvqFg1oKMqxUcnOWiCg@mail.gmail.com>
Subject: Re: [PATCH v2] gendwarfksyms: Skip files with no exports
To: Giuliano Procida <gprocida@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
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

Hi Giuliano,

On Tue, Nov 18, 2025 at 6:58=E2=80=AFAM Giuliano Procida <gprocida@google.c=
om> wrote:
>
> Hi.
>
> > Thus do the last one: don't attempt to process files if we have no symb=
ol
> > versions to calculate.
>
> This results in the -T foo option being ignored in the case there were
> no symbols. I think it would be better, consistent with the
> documentation and expectations, for the file to be produced empty.

The kernel build doesn't produce empty symtypes files because symbol
versioning is skipped for (non-Rust) object files that have no
exports, and before rustc 1.91, we never ran gendwarfksyms for Rust
object files that didn't have exports.

> This means that just the for loop should be skipped, say by adding the
> condition there with &&.

No, I think the current behavior is correct, we shouldn't produce empty fil=
es.

> If you disagree, then please update the documentation to match the new
> behaviour.

I re-read the documentation and it doesn't really state how the -T
flag behaves if the tool is used to process a file with no exports.
While this doesn't impact kernel builds, a patch to clarify the
documentation is always welcome!

Sami
