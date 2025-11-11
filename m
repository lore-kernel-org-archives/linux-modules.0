Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A67328B64
	for <linux-modules@vger.kernel.org>; Tue, 11 Nov 2025 19:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762890291; cv=none; b=HhSLssNp8KDI5DyQ1U1JNdBJpiHbjx/7ADYfSxqi0RkiwE1OVsKxPcpn/d7xZ+zoWz5npvze8mf86U0M2IvamdIoItpqNmKFXAGzjE39FV9AVwIib6TSHgo8gGn++bMHnHCGXJfQFQIYBdjF/fGgTOrVB+46BtcqMRb8w0SZDTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762890291; c=relaxed/simple;
	bh=JiUjPFE5L6L3WUSoWqtnqWCucYId5dZy3dcTcIJ6lbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bSZR/Oucpq8FiDQMLE5AcNx3djSCTwfO2GdRhrvdBsUVwF1RHySO+uzajOjHi5nm3uqD9Z2FBOT9cpt7licXO+MptdSnUub7l03PDK1RxDHjmWUqQQL1Q4ABX/zdCjnU0N4tv761hjxR5Q27zwo9AngCPfA+Pf4OE/OvgjMSUl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNEQU7rt; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNEQU7rt"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-295395ceda3so44905ad.2
        for <linux-modules@vger.kernel.org>; Tue, 11 Nov 2025 11:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762890290; x=1763495090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBwIkGZr5oeEH/G4GQqW+JJA6UiGsteAP6cGwBb+I8s=;
        b=QNEQU7rtfTdxjxfLCG/eoAFCg3CucgTfZVBDPlwuoAPm7XcK9zGsBYVLObEFyEoFYS
         xyv6BnTy2D9SKz6DOkv2E0uQbHF4WgefM7jwP++mKN83FwIhhDCz/vSl4HtaYkAEcqBQ
         0sfjITnHLxKpanUBKGo5ScC6ZjmG90qMQYWQylwp1bKV4Jwbm2/JJrnHqiyW+dfKNk+7
         x992ScOgjL5X9MLD8+gSBGgBfdnK92VKswHf7MhqDuimWgxX5t3kIOCFA38INXZS8AGk
         vGRYu3H6E6R+N6Fn8POgVGwA7nege4shGjmcG/6nHPebFUwjuyvuwYMRLHdB0ub814zb
         Zcfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762890290; x=1763495090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hBwIkGZr5oeEH/G4GQqW+JJA6UiGsteAP6cGwBb+I8s=;
        b=U6xpD/JuEmH0kSndV4RqZxHQ58k2iq2OY7vLgTh5MrmncVWX5FmMyCe4zsYTBttfxK
         2xpWa4ubG8ySIPnpNRklchOVSL7aY2jmm+T9vvLTj2EFLVL86I83cLkObQ4a9oU+KB5h
         Iawj7ODZ/S7kaN46JnsNiX8N//ICsc57ItwMYGPjvI+v413rawkA0kLfaDJsztm2Qwt5
         rFxDt0a7/aB6bVd/Pj1OeXstz0gS52xc8B6ve4MmNHVb6x3HPir04SJrA/lvkf41p4m/
         /9XAIMEo2OSCcO5tlWsEYwRy66N/1XOqyBvCyoYYrHowMRt7Oo4z3EkqGkPMGzkE5vds
         1HRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGvboRUQUhk3XTYRhdutaiLdJieSQAnpvSmpYUtsJVhtQi6ivwQl8P62bbmCapRwOtxZu9rnZ9Lalv3R78@vger.kernel.org
X-Gm-Message-State: AOJu0YxwwxCCR98c0yoxPjDawlIetqQskMsub73sC2KXfTFe1rgCrmtZ
	9RToxJjxgaEjJxJ52wG8rkJka7K6ADx5/zWLyYedDok3e5mOxPMyk/YEglRaCdRsr9Xgd4JdAPe
	l5G5+eN9bc2Va3x3Lvd6GzHcpqVfMofQ=
X-Gm-Gg: ASbGncs/IkdYsQT4X1We6SvrLCvrUCYozr6S+/xODuUpvZyz++yO9QYvu/Z5RSA2Hoq
	p/IjUeegKrpXAIRSUvdV9POeWmYFtHg6MF4Jano1cQ7syOXZlxnaa6YPsCOptmza2HLU7xI4PX8
	UVQhj7G6NxDnk70iS+WFwOTFxqHnrYxDep8eE0N15nqarvCgAoMc0AqkURgOxFmypRrdGf4RZKc
	Gi5zJahExTqpsLWBAxZEI2rzS+8xas7IMdi0+m4vPKMDjjIXEe3Q0cbjCUhod5a2cfQU07xUEt9
	CvE4NtDHWM9/gCA/o9A/gKKIaU2fwq2cnNAZ2kVpApP+rOubVsiEVZkyThawDw7dL09FxcxuSrL
	DYj8=
X-Google-Smtp-Source: AGHT+IEIgD2TIb5lI+JHX8EN36MOz76t2fs8U9WrA5lSIrN1Ee1RN3oycFlI6xL09eb/igzj3iXymu1H+QisdP+gzoo=
X-Received: by 2002:a17:902:c951:b0:295:f926:c030 with SMTP id
 d9443c01a7336-2984ed34944mr3301345ad.2.1762890289896; Tue, 11 Nov 2025
 11:44:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110131913.1789896-1-ojeda@kernel.org>
In-Reply-To: <20251110131913.1789896-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 11 Nov 2025 20:44:37 +0100
X-Gm-Features: AWmQ_bl0uHm3iTs5smKUuF4u87o5Gft8n3MmJwhpnH_Cho0hzrCzkBHz2YKCGnk
Message-ID: <CANiq72kOOieyK03wukCDRaG8po1nmH6BFnyEe_Y7Do42BF_S8w@mail.gmail.com>
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

On Mon, Nov 10, 2025 at 2:19=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> From: Sami Tolvanen <samitolvanen@google.com>
>
> Starting with Rust 1.91.0 (released 2025-10-30), in upstream commit
> ab91a63d403b ("Ignore intrinsic calls in cross-crate-inlining cost model"=
)
> [1][2], `bindings.o` stops containing DWARF debug information because the
> `Default` implementations contained `write_bytes()` calls which are now
> ignored in that cost model (note that `CLIPPY=3D1` does not reproduce it)=
.
>
> This means `gendwarfksyms` complains:
>
>       RUSTC L rust/bindings.o
>     error: gendwarfksyms: process_module: dwarf_get_units failed: no debu=
gging information?
>
> There are several alternatives that would work here: conditionally
> skipping in the cases needed (but that is subtle and brittle), forcing
> DWARF generation with e.g. a dummy `static` (ugly and we may need to
> do it in several crates), skipping the call to the tool in the Kbuild
> command when there are no exports (fine) or teaching the tool to do so
> itself (simple and clean).
>
> Thus do the last one: don't attempt to process files if we have no symbol
> versions to calculate.
>
>   [ I used the commit log of my patch linked below since it explained the
>     root issue and expanded it a bit more to summarize the alternatives.
>
>       - Miguel ]
>
> Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned i=
n older LTSs).
> Reported-by: Haiyue Wang <haiyuewa@163.com>
> Closes: https://lore.kernel.org/rust-for-linux/b8c1c73d-bf8b-4bf2-beb1-84=
ffdcd60547@163.com/
> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
> Link: https://lore.kernel.org/rust-for-linux/CANiq72nKC5r24VHAp9oUPR1HVPq=
T+=3D0ab9N0w6GqTF-kJOeiSw@mail.gmail.com/
> Link: https://github.com/rust-lang/rust/commit/ab91a63d403b0105cacd72809c=
d292a72984ed99 [1]
> Link: https://github.com/rust-lang/rust/pull/145910 [2]
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to `rust-fixes` to start getting some testing.

If someone doesn't want it, then please let me know.

Cheers,
Miguel
