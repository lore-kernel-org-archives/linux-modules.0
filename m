Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B90216604
	for <linux-modules@vger.kernel.org>; Thu,  9 Jan 2025 12:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736424418; cv=none; b=KIybNADt/QWr8CZd266oMu/Bvldi3knjeJiGyipvDI+BwbwrNhOJxGTqAx0dMzYM7K+QVT314GnI52evi8Qj6AAzBADA3v659CRAebmAl50BQOHV7BeZnuYyHu3bIlVxN2blW9Y5tkQh0HSk5pKoN81Vn6kE0nhxF5pmZxpU/u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736424418; c=relaxed/simple;
	bh=7GhU3IehkQzrfLYSiA7FecBMD8WTWJNaVN0XyrbZ/Wc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mjJ9dGmmtzvY11m1l/h1fINr1t/XWQdxCwqfEuQZH32MMMdbzJ4c4/vgOn6fSj7etbFOj3qV5x/qRV7ufEnEHVjsMzePpfl2JlZ/31gO0XdzBR4Ce+wtLqBfOXyGVl474n3aifddyFMCWgo18BmmAZhFZioUZtzuk+mIYMJVOUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=urPxAkQN; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="urPxAkQN"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-385dece873cso441539f8f.0
        for <linux-modules@vger.kernel.org>; Thu, 09 Jan 2025 04:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736424415; x=1737029215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7GhU3IehkQzrfLYSiA7FecBMD8WTWJNaVN0XyrbZ/Wc=;
        b=urPxAkQNSAsWf4iNzDX+znRdi2+TEMV9bwcl60v4Ugplo10jXTwkXh/Quoc2XFpwuQ
         I3hUjTfQjZ9/INBtLxTnzOkWnobElh5Y4NRd4A863F+i4yM3/LRrsJVdlj5qXs7ksPiF
         gkb1HVMApknJas2O515Syp0moEgRH1t9WFFDJO7Lz444fOnY8IjDBRXpKm6jM9pHjzCg
         T1mPMWonE8lbsH9Rq+JvYjRSthZne6NzDPFQkfafMq4ObhjsqrXs5BVxPpsyj8Ujs+4N
         fpwx+f08rsQYaCIgmls+ZCyv/tq/QZb7xpyhr+jSjPljVoU62LcVIUXxAQjoZbKsvvx4
         QGNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736424415; x=1737029215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7GhU3IehkQzrfLYSiA7FecBMD8WTWJNaVN0XyrbZ/Wc=;
        b=JU7pDJ+gTS2go04DRaxxh55IxYVYLiYAzirc+LcQ4eVPTKtlKY2z9vQ8C4OI4J0kaX
         hLFX7pFEfrw0AOKjJqAzOIAPHtMS9dZ2IsLnDcxgaWV7qKr2Wsjxuu1uCB9N+cgNugGS
         8fgElSsM/vTYboIlGte/mvkmF8JrK0+sJ0icifYBsI0wdhdQXurEJG7HLggmXVLvdqeT
         ItR85o2D5OJb/C4VxtwzJAKW27wg0fbV0QP7HpUjhXUVPhhvaiS4fCx98JNTt+FpvFbM
         5C/M5jUh8H8bpay6j2n0qX3xBJ8tqmV3x406Orn/wuC/5Tr+Z7L06qw+i6NRY4dDJs2C
         62Tw==
X-Forwarded-Encrypted: i=1; AJvYcCXWVraKG+1j5HGTETYg5Pjs1FS2qtOUijx+MUphvtI8nOicEA71XlPTrGjB2a7vG/aBjncXcI3IFJEV31YJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxwPOa7j6IeNEkhpkD8+FlvGQICm07Oh0jCf+O2MHpEyMQ5/iW6
	Sn0L2n/cANcmaNxKDzRml20/q855lfcUyHrQFV0UGe9Jj3rZj7Bux/fbJI0sHKQn2xV6Ajz/ewe
	/GEtsLh1xPeFozeti6t1tsSIUsMz2vjk3pHXJ
X-Gm-Gg: ASbGnctCUniu2mCRxVpk+hx5WaUhEr8qS+Yj/t9KskbpCxbtBXKunvImMEqEU8v70ne
	ONWWom3uk2Uhmw7jrRuKbfGX82VocD0davh9+S5E=
X-Google-Smtp-Source: AGHT+IE2PTdrWh31/0PhZhHiWvPO9sdaJoq3CdwDOjQxrfzNeEXVkPE7TAlhiZZUNTYNoC0l1cMz7zePU+26quoCRb0=
X-Received: by 2002:a05:6000:1864:b0:385:f071:a1c9 with SMTP id
 ffacd0b85a97d-38a87357964mr5290951f8f.50.1736424415438; Thu, 09 Jan 2025
 04:06:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109-module-params-v3-v4-0-c208bcfbe11f@kernel.org> <20250109-module-params-v3-v4-2-c208bcfbe11f@kernel.org>
In-Reply-To: <20250109-module-params-v3-v4-2-c208bcfbe11f@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 9 Jan 2025 13:06:43 +0100
X-Gm-Features: AbW1kvZaoK88cOn9DnUUz3dnowBx-JuJN3St-wf2WsYbDen8KQce6Bx2-TlyoWc
Message-ID: <CAH5fLgh5iTTu_q4N3MmfwEMWb7HzAjLvKeqC-okDhbaB4uMPBg@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] rust: str: implement `strip_prefix` for `BStr`
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Luis Chamberlain <mcgrof@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Adam Bratschi-Kaye <ark.email@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Daniel Gomez <da.gomez@samsung.com>, Simona Vetter <simona.vetter@ffwll.ch>, 
	Greg KH <gregkh@linuxfoundation.org>, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 9, 2025 at 11:56=E2=80=AFAM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> Implement `strip_prefix` for `BStr` by deferring to `slice::strip_prefix`
> on the underlying `&[u8]`.
>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
