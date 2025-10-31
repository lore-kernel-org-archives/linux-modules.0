Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A226D34B1B0
	for <linux-modules@vger.kernel.org>; Fri, 31 Oct 2025 12:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761915436; cv=none; b=CQL/y2Na/K8T0ohegmR9cZKk5C3EzJALk2631WDy0aUJKsVhjNYDz7ENWNyWYs6lOOiRTi7PvbNhpEx+at5oklsnPuB+bz6Th9gAyEc6uPfcosYb5HvmzRHFxqmhIXyq3i/dKCWiySnYxdp3Gnej4rtYtAsfT6hjvuP2hBDn9Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761915436; c=relaxed/simple;
	bh=57XM95AelX9DUBLfU9THwVSSutS8OZT8Oj+HWgG7Ons=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D5V2GPRC7gvSiGw2zS7mpKUY15GonzpzrgHOUz2yLpoUSC/YSlcpIlQIal8qwE0rwjgjDI7/I+2ZkOZtt6nRl/5/bEVUycXsKNoEvU6oB2fVh7pB9txlmxifnE46NdFbEaCejgf5vdrT9JCE6h6azJnCIcS/UI4sF/jfAbqHC5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fx9INj2v; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fx9INj2v"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3409c8626easo59885a91.3
        for <linux-modules@vger.kernel.org>; Fri, 31 Oct 2025 05:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761915434; x=1762520234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57XM95AelX9DUBLfU9THwVSSutS8OZT8Oj+HWgG7Ons=;
        b=Fx9INj2v/zscGtylqr7LuT9oOrhVNAaptHEDLaTEIhjIXv+edlW88reBW9iWrRsvrl
         el1j+Vtv8ANRYj7wUuqVGwf8LaMzKdY5ESO2mYiYa8UE9J/dBekJ1yvfdWou4FdYmu6m
         F8T6+NZQY7atZn6LZ09MoFWF+E9O6XTsOArTbOlnBv23KAKKFpVWxiWcVsbBp7pp+27/
         y3kMy6BgMLtP4VndSGTeVz/P+R9V7vOuTCUIp4nk7ApM69jJn6VgqY3iEXJ52XCvhaTd
         iyPyFdWpDSx68PN1J0ucNN75jES6QvH8Skeo9nufrZ2SCsEqScR4gOoRHfzmitSkoqhF
         H21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761915434; x=1762520234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=57XM95AelX9DUBLfU9THwVSSutS8OZT8Oj+HWgG7Ons=;
        b=PIInznSTTpH4xUTqKQmmF/6AxV4eo8g9hpDHy6Bbu5WXcT9FWC3nSw9GPS+nnZJift
         VSIgQoJfoguYVni7l88PWF3aZifhZGHEeWuCZWPMH9yyJ4xUD4Zrjo/Wjwz3t3jR71IJ
         sf+yMFVZiMfTOJUus5nSUAAKm3sK2aABAFCHq0y3WFet1zTyTcsIwF5FeVj25Hzyqokj
         rAe6uNEBRTCuPdQOmmZpGiMfyk7kPFbG8IEJf+P7BxdiYwO8xhiW1X44PRmjkxc+Rqvw
         0aezr5Ozsw5jyHCOdIqfiwprfisQkittF8Mm4ddnEkVKoAlWutp5eXJUIIMpgz2PvxiJ
         36Xw==
X-Forwarded-Encrypted: i=1; AJvYcCWuvtEmKIzkLV8xau3j7/UnhJYl/mz4Ps51aRIns86cdTwZe+xeP+LZgQAW4cdphFnK461ajfQpoUFlM7g3@vger.kernel.org
X-Gm-Message-State: AOJu0YzwxhBqpcOvgLJ0qEdUZec/yGgIGnEbZu7S0qz88k1QwXiojqvj
	u+bAAYWYK0NeQua8cxNLGctpgwbK7cDqnIHK8xnmCiIIjmmcw1dLdHI9Nv9tiRT2hOuJAbIYnrD
	Mwm+McMc5OmGEb7GAp0EwEbk4cX8jr44=
X-Gm-Gg: ASbGncsFNbu3F2aiNRGbiQp4lg2QRGVY1M5ua3qbrBNXMiceqPi1pPAnRnrNzyNlPeU
	yrvyzJUX0AAuuXPNlqsUZZVEg7RHVVxbSW6M4OacUnzOAJG7C0LIB4GJanRvUi7Vxf/5KkOHJQB
	2UnKZNvri2HKugusSqmIpE/TKwimvBs9D7s25xUVE1UsyK7N07lgneEOu2yPWq5IHcwdxqbBS3K
	DNYLQnqyjTBO4UevJ6+GNaRpZ6W/iZlj6B9sUDptQUahsCaJVOe6AnVvjm0yIHztjMYZPWwb5Ew
	OFrSgaLV8PfZAyz7riHgEFRcX6VI/EylNKcbAvHLHDJ4EHn6sjRoOKkcsKTLJ0ytWkA3LoFMSfh
	T7AoeUF7IdOtrQg==
X-Google-Smtp-Source: AGHT+IFJM+PQMbTXmTGodnAosPHILr2GU6NSMb59LbmXplfAnvliIPhU9LCa4gpUD72tPa8WjMFa+1grBXZZatyQfa0=
X-Received: by 2002:a17:902:e887:b0:272:2bf1:6a1f with SMTP id
 d9443c01a7336-2951a3d2847mr26244955ad.4.1761915433746; Fri, 31 Oct 2025
 05:57:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028-pwm_fixes-v1-0-25a532d31998@samsung.com>
 <CGME20251028122316eucas1p2733987cd4c1eb8f83d6572d542e76d2a@eucas1p2.samsung.com>
 <20251028-pwm_fixes-v1-1-25a532d31998@samsung.com> <h3sivr3uuzr5oodqe326svchbw3rzo4f4nw4chpeee2jwzjq3j@bdtecauehkn4>
In-Reply-To: <h3sivr3uuzr5oodqe326svchbw3rzo4f4nw4chpeee2jwzjq3j@bdtecauehkn4>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 31 Oct 2025 13:57:00 +0100
X-Gm-Features: AWmQ_blGoLkmXXueKnCk5kJ5O9pXLS5GlmxYneYVuP4K75NG97cEfvhzpNZh5XM
Message-ID: <CANiq72nNxVJeMZdESrrB+LGmdRK+M5AGZbUw-x2aE-Qa-=HtJQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] rust: macros: Add support for 'imports_ns' to module!
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Michal Wilczynski <m.wilczynski@samsung.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Fu Wei <wefu@redhat.com>, Stephen Rothwell <sfr@canb.auug.org.au>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 8:47=E2=80=AFAM Uwe Kleine-K=C3=B6nig <ukleinek@ker=
nel.org> wrote:
>
> I already asked this in reply to the cover letter, but the question was
> lost on the way (no offense!), so I'm asking again. As it only really
> affects this patch, I'm doing that here:
>
> Can I have some blessing to take this patch via my pwm tree? Would you
> prefer a tag to also merge it into your tree? Then I would apply it on
> top of 6.18-rc1 and provide a tag for you to merge.

Sounds fine to me, but I am Cc'ing the modules maintainers since they
were not, just in case:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

I think we don't need the tag/merge, unless someone else is looking to
use this (is there such a user? I may have missed it).

Thanks!

Cheers,
Miguel
