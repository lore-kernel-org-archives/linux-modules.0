Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53D0146593
	for <linux-modules@vger.kernel.org>; Sat,  8 Nov 2025 03:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762573902; cv=none; b=bsUEl2fUdTdGZ4k/U4bl1VPppealokAv/rKL9jvEbWmJEHKnCP4rtXRspPObS8QLKJJ442ET7rH3hIPa+7POoxFYVdfv7oMiznI95ByOHEnEbf8RKuVQzzs1EFTHP5GbSIyvIbFS7CB4Deqls3Fz84yxy5UDL1FlZ72MtcAoTxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762573902; c=relaxed/simple;
	bh=q0snDR8xQE/MKs8/cvlLIB/+XXsMPIC+6i7g2yHZzn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lErsfA5CB+E1uJ7OjDNtHFny6Xym+PUblwxjIu883QR3Q5+Dx5xFr1m6cGjAVNu3P+fhMVj2LBUF72cND0PlkuBKmPyEi5vq+d5RHW0fHiAwCuqzkpqy24pzs2cpJFMfqMEDx6U4+97ZJFxLALxR4BBF260EwscL4US98NveE4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JL1EyyCj; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JL1EyyCj"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7a9fb70f7a9so193490b3a.1
        for <linux-modules@vger.kernel.org>; Fri, 07 Nov 2025 19:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762573900; x=1763178700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0snDR8xQE/MKs8/cvlLIB/+XXsMPIC+6i7g2yHZzn4=;
        b=JL1EyyCjAu4FD76MI62hxbiXz58ajDEwaLHhf9AvdWC0YzucChlJG9HGdw4gjhqpqS
         oK2Djh/BPstXaoyiofO7PAMu+GwSaZWrpRVEs6wlEQ6Kh+MNzS+PlgkxLFLm92fzv+b9
         Q3N5Uk0qP0zwPYQKamnXOC+YQQ7ANjL192xrKpqexPI/KBj3hmnq+BlvS1XWD9p3twAS
         TDMYgYV7H+I7A5k88u/gU2MKLMX9L96+EByOpbk4vJMhj8urZx72ZKZHlLgUpB7uNqbk
         QneJP/dF5ONvfO899/FjmMeNNg5wypeAyIaMN7MIzKwhkrwZ1CCNwDt/XAmfxGR+S5wy
         +TdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762573900; x=1763178700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q0snDR8xQE/MKs8/cvlLIB/+XXsMPIC+6i7g2yHZzn4=;
        b=tpKMbHqjvZNMdEuPyEBfFAAtTuV/nhWm+G5A33iqtk+5e5ICqlu6mB/B7bhXDaUli3
         w429+zZkMzSfwkknfwmYugsp6hL/9ecZodb8bO5bNkHYDJEbK1jb1sin1s7/xzAq0fYF
         UUQTb6lzTAuwvqRkBUrmB7Xm6Bgm1l0GCIfr/d/DMDv/iBGv95ewkfmIcgZpNgJVgmuJ
         ozQObLRYdxaf6E+IUavGfFJGURkjeEaPtgBvtNYkQytnbxHgRL5LlFh802G3YUddXCEt
         5Mz5UB7uJXgNYLsU/lxYQC5aBtN4rPwatBb+iytjmYDlh6d/JcaRn6+wZ//TCgXMzGN0
         s4/w==
X-Forwarded-Encrypted: i=1; AJvYcCXeHeCTsZw6fyFWVV9y2OToy+T1rjNBAauXhUov5xq+mHWRTOpdAqn3SgJkeL+SFd0IvUjHO4g0VYHBMkvE@vger.kernel.org
X-Gm-Message-State: AOJu0YxIBsGNXscGvigHp9NdUijUjITkEYmpv+8pK4tqCgm31Jbuq+DX
	bavJFIuyxNgX9WAagKQ/nloMzPtUyohFiljiJTc/xYby7uu1gsiI2lcoAv4oxAZj58hw86YHQJ8
	KRVthH+wpMGW8jzVWOEOtG0wp7puN99w8biG1
X-Gm-Gg: ASbGncuUAlLDU1kXuXUtpLn34vaERWTy6ryraJiG8yX4Xjs9/oqTEDDp4EPVRxJ2EgB
	7ms2t7ZLJJICK+mAu0pZYWSoqtDcxwctI9IaOYe0Bz/lw43ijriwp+XPKc8oNAmk4nr9JaaDjJ9
	UbZkTMbHiEriSr736lGErKHKa+RF8Xjy4GmShv5DiXMi9XKnISRdSOoam1NgY2I29jkWnI8ibzG
	Egfz0wVJJWUQe3np1diaT0vy7AXrJNxwtebudqfYTEckanf/14ijCVtmoJ8q1ek5sqiUvmURWj8
	vmyBstaNLtba9GhFJp86OHsEKKpJhUGJzLqo3dSbaiaJXUyaizJ7DgcByR2zay16kbQtNRnWVdH
	JU9NJwTM8OCocmQ==
X-Google-Smtp-Source: AGHT+IETjy/Whs2XDm6e4xWFe1uDWjZVP1XuxrDCcYFXxquKd3GRTQOQIBFqHWaGhyeM6BjE/k74OlI4YppE1Fy6UDU=
X-Received: by 2002:a17:902:d2c9:b0:296:4e0c:8013 with SMTP id
 d9443c01a7336-297e56d8ddbmr10595185ad.6.1762573900080; Fri, 07 Nov 2025
 19:51:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b8c1c73d-bf8b-4bf2-beb1-84ffdcd60547@163.com> <CANiq72kX4Yep3pNVq8Ge=txQbPnMO=zKsci5cPgz5LDS=D6NoQ@mail.gmail.com>
 <CABCJKud0G+Xh+Wbtg4SDGvk4Yh5nmt5YgHEPj-H0y8GO5R3Amw@mail.gmail.com>
 <CANiq72mw66ADx7LoUuqY6h9KCU=uFzcNQXZ21kMP7jBjCyyaHQ@mail.gmail.com>
 <CANiq72=OFO8fBpJ6xvGunYrx5hXfcjQJ=YDqFxtMPWDzfzwpKw@mail.gmail.com> <CABCJKue1xeY7CGHScG04PdHT6TOPgsOpZVKWwgzO65qwAcbEJg@mail.gmail.com>
In-Reply-To: <CABCJKue1xeY7CGHScG04PdHT6TOPgsOpZVKWwgzO65qwAcbEJg@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 8 Nov 2025 04:51:28 +0100
X-Gm-Features: AWmQ_bnfSsY-GdPkrVyW1DX6qGnfSU4n42VV7Dd3nIzx6h8i36w7aMyP5XChm-I
Message-ID: <CANiq72ncHgjjJ_c2fdTgOO9LxmmotRS8S6pwyckLmPJG_4GPNg@mail.gmail.com>
Subject: Re: Only rust/bindings.o build fail on rust-1.91.0
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Haiyue Wang <haiyuewa@163.com>, rust-for-linux@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, linux-modules@vger.kernel.org, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 8, 2025 at 3:40=E2=80=AFAM Sami Tolvanen <samitolvanen@google.c=
om> wrote:
>
> Technically speaking, bindings.o still exports ~1500 symbols even with
> newer rustc versions.

What do you mean?

Cheers,
Miguel
