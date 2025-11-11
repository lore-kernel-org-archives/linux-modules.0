Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA820314A90
	for <linux-modules@vger.kernel.org>; Tue, 11 Nov 2025 15:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762874725; cv=none; b=Ws86H+yo7XkZ2xIuWAgDjrEzcWsJF7N/OYMRxT7+BwyCcxucE9+ilk6ormuokbmS0ftMCacZGHHqTFEllie4C9T6PhHa/lYseymWeunm6n9ZUC6QRIJsENFlLDoQmf5c+LpxcIpuSOLqLV0DPKVeBvl+N4V9Ug8cmtiqEJitMO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762874725; c=relaxed/simple;
	bh=kH2n8iyTfgAxz6xqhPaYcBszdchDNAlkl6wsHl2bXLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p/Zb+Lmrwpr7EN2S7Y4w7Se4wIqFdHRuSrVbjq9gUz4eIjfTNObkj1VozW0g1zbVsVBc7Z6+KCkjPVrSvCj2q/J/V8mkkmTTOhk3qNcRndPQLpx+ogwXdvDKvryHnqsGoIKvK/QtxN/VNwTarCzuA026d7j2Kx0c9Ww9TxiFZ3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1wlY9uu; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1wlY9uu"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-378d6fa5aebso37797091fa.2
        for <linux-modules@vger.kernel.org>; Tue, 11 Nov 2025 07:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762874722; x=1763479522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kH2n8iyTfgAxz6xqhPaYcBszdchDNAlkl6wsHl2bXLA=;
        b=T1wlY9uuIBJOoaom8q+pU3Ew+ovnvnwgbeFT6DNqOzxc17R2wq6OHP1jZN36fZVZFA
         qmYgyMDj+/2s1sVW7MVBjxMbpOfkCFWRS+kY3xo79G4ZIQtswVLh+9CJNEFyNxsdBz6h
         IqTZZrgLtMjb2kwbspqmcdMrcCjdoOnZc++p87074QOuGvi44zMiHWjrwo9WBb1AS6zq
         2g+Tfml17OcZGzLFFbD8Bjbt4eqaRfwwRNLr3JFTjxvWdt+Vzlg2bVKIYY3kpbmNR9v+
         6EPvWcr7TAApF/xiHk07HMXmH5LBUuHKndKSmXs+4TzhsdrFZ9iHLgWqAkiuakklzPka
         2ZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762874722; x=1763479522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kH2n8iyTfgAxz6xqhPaYcBszdchDNAlkl6wsHl2bXLA=;
        b=sEKkyh2Hy3MfV2ZtILwvscwFbcZez4+DCZAcRwNqLVJa/H5W50kVnZLIDXW1R5yl64
         hn6EDkh/Ps4gFEUDJs9ITJ11vief2CM0o5jYF55is8FvMSYNjLLlUnVIwBFx8tCT/bbb
         YlbBTUpjFYEWivYVEhh7D77Wn0WI6hWzJ5gwTs2tSqQ/lvLcIZJCbVlaPYgnRaNmSPex
         nJ/JtNs85E2YLPx4Ja/lyyh0judV7Tl7ObM0HinjTx585AfKxuNJZeTfTGuwJ+SWWngK
         wd2azTi1wfX2H48GHMEI/7KcKAMcZiC0YFh+JPq2lIE1rRjXOkub4Ru5zFmmSACv2yES
         cYiw==
X-Forwarded-Encrypted: i=1; AJvYcCWpNxkuCsqK99QHECjdmWVMiv6bC0uHVlVcRsC3i7uVhU4r1jj/LfiqqY46RCLQyk8dpP50MIfFdH+lL33B@vger.kernel.org
X-Gm-Message-State: AOJu0YwK+gWhrQ94iGmA5/FWmlWdxxZhuNrfgH0FfJaoZzpfSK/0O3HW
	MUbH9OIbndk95MaVu/XPqvgZvWPu5M5+oDltyi8VTqAHDVWHZlQ6fy7Igp8E8e7aRdM66/q8BK7
	RPsWl86Eml7TQCof92NwRnzGQ39s8DgQ=
X-Gm-Gg: ASbGncuDe3bwPmvD91Eu1Jg1puFELh0Kj2UZGJx5mpsSJv7LwmooU2/pB8UGK2evmTC
	R2bqhxZu5f/MW2hbacyrhtQuDzQ/Dx/5k4LAW5PSfLcFhsUsgWETaQkVoHdBr60B7V20r+BkHUc
	f7/sODmJ6cvDrV1Wd0qO2KZML6HgfyLHJJ8qsxnCOz6C8DHQZLhl3LYTqDC/aCgPb7DWCAlP5Gu
	2MPIXIO2KG7xfOaLYDoj6ofqP6koh0MPXnget6EVeletD0D/SWeAXR/tEEmajC6mJl0nA2lVg==
X-Google-Smtp-Source: AGHT+IELN2Wzp2bTqYWDhcQjlFtX9DA00ce12BJNW8cO2c8JdiyexJqlAubB4Ie5Gjviyerq6QZ+GfCfwjPRPrxTi4A=
X-Received: by 2002:a05:651c:f06:b0:37a:7c41:79e with SMTP id
 38308e7fff4ca-37a7c410bf5mr32947351fa.13.1762874721655; Tue, 11 Nov 2025
 07:25:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110131913.1789896-1-ojeda@kernel.org> <CANiq72mjFobjfQEtNvk9aA+757RkLpcfmCCEJAH69ZYsr67GdA@mail.gmail.com>
In-Reply-To: <CANiq72mjFobjfQEtNvk9aA+757RkLpcfmCCEJAH69ZYsr67GdA@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Tue, 11 Nov 2025 16:24:45 +0100
X-Gm-Features: AWmQ_bl70oXfEo-1yQ9VfgUdYtwxWC_v2530llNoS_lks6MxxMHeFjNTi0L0Vkg
Message-ID: <CA+icZUVcHfLru9SRfhNGToiRmyOY+fLw-ASEvQakZYfU1Kxq4g@mail.gmail.com>
Subject: Re: [PATCH v2] gendwarfksyms: Skip files with no exports
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, linux-modules@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, stable@vger.kernel.org, 
	Haiyue Wang <haiyuewa@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 2:58=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
...
>
> I will send a couple other fixes to Linus this week, so if nobody
> shouts, I will be picking this one.
>

Hi Miguel, Hi Sami,

I switched over to gendwarfksyms in the very early testing days.
Faster builds. DWARFv5 fan.

And was using v5 of Sami's patchset against Linux v6.12 as it cleanly appli=
ed.

Last week, I jumped over to Linux v6.17.6 and the next testing will be
Linux v6.18-rc5+ (upcoming next LTS kernel-version).

I will try this patch - might be you will get a Tested-by.

Best regards,
-Sedat-
