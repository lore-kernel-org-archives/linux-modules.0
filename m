Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998542EA470
	for <linux-modules@vger.kernel.org>; Tue, 11 Nov 2025 21:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762897972; cv=none; b=TVJTTnqFVI9EPL1iTLZ8H16vcf73Jcp/kIcYUo/CTTZWnaLTGQVCQpNEFEQesS1/MCM+xDmCczwtkPBRAZWoEWL5j4cnv8Bo37jmBt3yNSjvyODPO0MpR39bGUWCkj08UulPtT/2gwAWBl3UzZ7c+kz1LghHAPHV1KJVay4hVGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762897972; c=relaxed/simple;
	bh=/QNM/X5XSQpv+FQQDdZzB/lI65SBmqPTlRzLtg/G38Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ty8hrapjERsWvEWE7v7k/WkAS5v62J/G5XpcQTTGgKYTBz5BlYiFbGb8DEUUjIxV0dICQER3yPEsnWFWstDdWMB9EYtdEmcd1yyi+jOilpXJdL1rz/Ohqyf/9pPJCrXsABM9hzM0vOFMtdYegoENIzrvHQzdUjTQYs6RoIdiRp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X31TeZJJ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X31TeZJJ"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2980343d9d1so20655ad.1
        for <linux-modules@vger.kernel.org>; Tue, 11 Nov 2025 13:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762897970; x=1763502770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5VvFajYi15kIWiai7n5Hcqwg/6HJ3wZiBhWSzTOg9vo=;
        b=X31TeZJJTS2OAcZIg9EZeJi6NN0aBtnpmXyOhgXRoCs/LO28/TF5rp8jN9Di0FRZBg
         wCcu/HptH2DO/LDRc35gaDbmMUMWSVBis0Bd6yReoKg4r9s3XMhZ3cx+7Yd/bEPAOY+e
         CvyQkyx4BdpT4REKv/Yfoz+I4uzkNvsCeDsp/yxxcma9LUnHDHTddILOqHw4x+igUoeA
         C3zzmLg0sfnvPf7fuBaSpeJwUY3TjfqY98pxqtF08yx2E0oNRwgZhdpSYwI0Z/uNZyON
         upBk71DwlgBeGV1JlIHH0y/Nf3WwH4NGWiQwGxoHI5mUWG55sg+/eUiUskyMdiI1MLGN
         oM+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762897970; x=1763502770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5VvFajYi15kIWiai7n5Hcqwg/6HJ3wZiBhWSzTOg9vo=;
        b=hHjIcMTuKWqz2JWbfbqPbVsScDF3GPpmTZSbqi0huIWMQqw+t0219Ss/vAGCri2p1s
         cDxfDdmNHVuk4opMQXzGpHftzl7lzFqAHApgZeLzR8RJmOCDg1usx7QEn77Vh7e5IcQJ
         dOnUyxq35UClsQofnIeCig+GBCwr+vmv8MZMu72V6MmfrDPLQ3eZ+SeC5Fxa7XhzupgZ
         B7BzBeZy7K0AaRfjwVyvVmZ6LXj0hFV8dR/6t2ykNUvJY/qBQIwErez3mBVG8OyssaKN
         K50nTBai2mssvNWm7twtV4de122CSUi1rRnizMhUVwxB5nlch8GWUcWVhN8fT9OSy0Ak
         SifA==
X-Forwarded-Encrypted: i=1; AJvYcCWcANBl57w21NchV5cFqEAgMuS5Rj4sVKBfUpEVlFHsEcGgEdNS7148/OmKfVxPfvD3i2IW299+qcHhhHAo@vger.kernel.org
X-Gm-Message-State: AOJu0Yzet4ZjHB4gqywo49+6bV3xatpimayCpoEfTRqmGrjjG+9s1si3
	ecOCxuAYQISNgk8ZcuMu3x2ylUK2C/Z+E9WQ1bdVx4okX+//ZyyFhJG6+eVu/8UoI+j96YwprUG
	sKaVXRllfR8iNXBRqasG5wr9xnzITlS8vkdRaW/ld
X-Gm-Gg: ASbGncvELQ0bHDJPlWNgg7olI8SIirlGzNkIBJbB5TIYsiOuBQNGx92wS57+izIkuh3
	y2fvgdDBClYnJviEgwaWAmK1iQPnttZe12AFZCzLiMjJCL49d2p3eqNI3BxP51YakXM+HXdZclx
	f/fHuEgvLJHtodyIFO2BA5uX2fnpQhDmfuVSpxWSsfaZQvlAzIvlPwl1eO2gZAjOlBKT4M5OgpK
	HdREQxz49jFwFRKvBahEd5njiJcyiEBO5LNEPymuFWRzWNh5NrTeJupAliJvKfAMr1i5TpcmXJh
	2RRfc8vhYhHcdCg6VvtWZWVtW5wifTgIK1LmOKfb0+vzlQ==
X-Google-Smtp-Source: AGHT+IGAB93LHQL+r4WuB4/Ph0LFWIrxxzhVMChdM4Z+1uSkD0vwZigeDvDGyHITXjaZ7Sx0ge3nq4/BLlDcgc8jDqc=
X-Received: by 2002:a17:903:1105:b0:295:30bc:458e with SMTP id
 d9443c01a7336-2985074cdcemr378845ad.3.1762897969460; Tue, 11 Nov 2025
 13:52:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b8c1c73d-bf8b-4bf2-beb1-84ffdcd60547@163.com> <CANiq72kX4Yep3pNVq8Ge=txQbPnMO=zKsci5cPgz5LDS=D6NoQ@mail.gmail.com>
 <CABCJKud0G+Xh+Wbtg4SDGvk4Yh5nmt5YgHEPj-H0y8GO5R3Amw@mail.gmail.com>
 <CANiq72mw66ADx7LoUuqY6h9KCU=uFzcNQXZ21kMP7jBjCyyaHQ@mail.gmail.com>
 <CANiq72=OFO8fBpJ6xvGunYrx5hXfcjQJ=YDqFxtMPWDzfzwpKw@mail.gmail.com>
 <CABCJKue1xeY7CGHScG04PdHT6TOPgsOpZVKWwgzO65qwAcbEJg@mail.gmail.com>
 <CANiq72ncHgjjJ_c2fdTgOO9LxmmotRS8S6pwyckLmPJG_4GPNg@mail.gmail.com>
 <CANiq72kcRsTWPhQVJ18P6RUxL=+c1Z8BJkyK_kRR8EBmmH+cWg@mail.gmail.com>
 <20251108044206.GA3038215@google.com> <CANiq72mLbEVqX-uBtqy+_wru9CRRb3PL3qFqYEcjpZdNyZGd2w@mail.gmail.com>
 <CANiq72n09yx9ZjOtOb3-3rPfpPLKaJZ2fs_Bmpbz28Y8U05snA@mail.gmail.com>
In-Reply-To: <CANiq72n09yx9ZjOtOb3-3rPfpPLKaJZ2fs_Bmpbz28Y8U05snA@mail.gmail.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Tue, 11 Nov 2025 13:52:12 -0800
X-Gm-Features: AWmQ_blNo6f4wsXHyITG7HidznvwA4riTyEbTpdABn5ekbyYeCZL85bPH0bxaHw
Message-ID: <CABCJKuc-jkz3HfOvAi3cJh9C9JmOpMpPY8PR4ETXBUpUQ8R_gw@mail.gmail.com>
Subject: Re: Only rust/bindings.o build fail on rust-1.91.0
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Haiyue Wang <haiyuewa@163.com>, rust-for-linux@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, linux-modules@vger.kernel.org, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Miguel,

On Tue, Nov 11, 2025 at 1:41=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Sat, Nov 8, 2025 at 6:08=E2=80=AFAM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > Exactly, that is what I was suggesting in the other thread about
> > editing the `cmd` command or directly teaching `genkallksyms` to
> > auto-skip, but I didn't know if there was a reason you didn't do that
> > originally instead of having (some of) the `skip_*` lines in the
> > `Makefile`.
> >
> > If not, then I assume we could already remove some of those lines,
> > e.g. the one for `ffi.o` (no need to do it on the fix, of course,
> > better to keep it minimal, but just to confirm there is no hidden
> > reason there).
>
> For (cross-)reference: I sent "v2" of the fix, essentially taking your
> patch and my commit log and putting them together -- please let me
> know if this is with you!
>
>     https://lore.kernel.org/rust-for-linux/20251110131913.1789896-1-ojeda=
@kernel.org/

Yes, that looks good to me. Thanks for picking this up!

Sami
