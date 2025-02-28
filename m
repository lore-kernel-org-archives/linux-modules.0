Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7977F253B57
	for <linux-modules@vger.kernel.org>; Fri, 28 Feb 2025 09:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740733852; cv=none; b=EmtjWTqpAL0zF6R8AZ1y1MJ8lXBy4Nv8T+CromKER4z57wsjMaPoBgXzLAOWjxjai5GhTQZ/oobzXsshCgi7PnOSgsbnwO09YTeKYAZ4ouEzivKxKA19FxSx7usTdPtYkMBIYEXIFRfW9md2gx+mpYSIs347/NoLPAbNHwclj/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740733852; c=relaxed/simple;
	bh=B+KZR9U+QNu7SUxJ+i8T3VOmdEx/39PbN2GtIhllJPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pXtQPyB/ID6YWRpgButdzpZAdm3Uf46o510sTILfgewG4KKyVa5sdO8lWN9Ve7916u2W6TBdNWgLCJxhityjfv8TzSQfjLzWr2LmYSS7jdBheXrrhUQY/ATNBT6hHGm49iGNwNPoSbvJb5Li6LSVYCA4+nJPWtN10XY56BjPb1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YrdBKK1G; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YrdBKK1G"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so1118444f8f.0
        for <linux-modules@vger.kernel.org>; Fri, 28 Feb 2025 01:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740733848; x=1741338648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+KZR9U+QNu7SUxJ+i8T3VOmdEx/39PbN2GtIhllJPc=;
        b=YrdBKK1Gc8taDPwF3BXslAm+4RyH1VD/8Y4MpBK18oEBxGYhAXV32Ixzwr979xnnfI
         X1XGf3igKoEAUZ5I11awrSNmbn9bMboYqs/4vY2FUouqYIK5LXuc9954EGcBDr4kUCM6
         6nDnFZ0Ni/nhoP43QfIWAki9ebSSxrz2lxV3yTxi0uvYPNdaYV8dZE9u9bFMzf3yhOtM
         bJuhBoR2FxtP13b6TuvKo9l5x3yseZ2Lsz9Q8hsudHLRgc1alY9ZJ+OMfNUTfc80/2az
         Q3reEXuXNt3ed9ugMzBGI4WxzZFZiS6qQn7K8Ds4IzXmvSQJSvAeRCM16zpPDwKkO/a5
         WbLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740733848; x=1741338648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B+KZR9U+QNu7SUxJ+i8T3VOmdEx/39PbN2GtIhllJPc=;
        b=lHXRKAv4hVJaf5Ahdf6oj2k2eJdk22uFKozWOzBNiK1iyvc94vOTLRbzmAqrromca3
         8pGGL/w/s285IVpy0Q2yi42QFs85M+I3Ay+5YbwgOtS/nDVBSG6Q+XfDdTKA8KZ5S8Lm
         xdKBLcBhDihNinXPbODVIQykg1r/ufagvkfi/Qkf0iCxsBaqITo5n1PlD9XyVeH6/BY6
         l8//kxpXv3pyc0OOoaczAGPqCvPUVXocOcRkrQkyXGQpRUons5FtWiHAc1vhRE758BeQ
         6dkby05DgA7QgKxkwJVXyUiMNfcSC3Dj1L4kQ2rVPX4ZcmLdaVHc3iPFCA/lHlAjTPJC
         n9Fw==
X-Forwarded-Encrypted: i=1; AJvYcCXtXuOpnEPwj5MZDtb/41SJgZcdT7JJzLpzuBcg+Y9U3tSz9Z7XCT8BMETtMCm+UGIhl3MZ9lbCBgf6a3pN@vger.kernel.org
X-Gm-Message-State: AOJu0YyKig0gbbNsXgAT85sNkuAZSe9ufRkzD+28Lj2pYDP2iwPzdT0S
	FZzqkcj3miGiX8kmcXecTLuf0K302f31mcrkLdYDDsW8hkKiPO+MCeESUV9Wg36d7Ui29rxWYdX
	Ul8VxWlQMgC8rkbLVoWl6QCg7hqKVZcBSA0xb
X-Gm-Gg: ASbGncu3ipDBvT7g86DQZwsc9/3/AFZm3jMP1TEnIERgJCGkVxN9cAaKQIBKdztfghP
	TMmNX72pL4rd48PCJWZhk+pXbVnrLX0kMvPg/nLGL+h+hcycZymuUJMiExovgNzovHS4ehD6o3x
	uOeqTBSdK2dlYs1ZBfWry6+77YWYAg2BN1zYK8
X-Google-Smtp-Source: AGHT+IERGpvzIDS0sWelP51+WNxcT7yjVOKO5ZFHLOo3Y6uovfZdy2A/BnsEEhMwf3nYmys4gVtLG8EpMJrjOz8W398=
X-Received: by 2002:a05:6000:4029:b0:38f:2726:bc0e with SMTP id
 ffacd0b85a97d-390eca138d2mr2034057f8f.44.1740733847661; Fri, 28 Feb 2025
 01:10:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227-module-params-v3-v8-0-ceeee85d9347@kernel.org> <20250227-module-params-v3-v8-2-ceeee85d9347@kernel.org>
In-Reply-To: <20250227-module-params-v3-v8-2-ceeee85d9347@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 28 Feb 2025 10:10:36 +0100
X-Gm-Features: AQ5f1JqSvSbT0FH7s_hhnc_jNCyh2EVcbOEFqp5yXZR56yXssuri7XnydNHPcvw
Message-ID: <CAH5fLghKoWQqOC8jRES_ZdSg_PJHd22bQWngaQ4fRHJPHYLB6Q@mail.gmail.com>
Subject: Re: [PATCH v8 2/7] rust: str: implement `Index` for `BStr`
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
	Greg KH <gregkh@linuxfoundation.org>, Fiona Behrens <me@kloenk.dev>, 
	Daniel Almeida <daniel.almeida@collabora.com>, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 3:39=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> The `Index` implementation on `BStr` was lost when we switched `BStr` fro=
m
> a type alias of `[u8]` to a newtype. Add back `Index` by implementing
> `Index` for `BStr` when `Index` would be implemented for `[u8]`.
>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
> Reviewed-by: Fiona Behrens <me@kloenk.dev>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
