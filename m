Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F4822A4DB
	for <linux-modules@vger.kernel.org>; Sat,  8 Nov 2025 05:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762578542; cv=none; b=JG4O3PywW6DN06wYUhhdyxnEq/qATaaOLyREYqm45QeojRz3nUT+jC3L8hI3/0+0Ag6bp3xK1aIiSHyB/zDz41S1vTax+8HteDjr/NwtG1hza5yNV70YYDvpAFFZ2mO/nDdp8PKmgvlvNiTgad5p6hVyq5Kc3obaMhiGwa1fUSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762578542; c=relaxed/simple;
	bh=Fz3Y0iZrjkcgBV3u4aAleACcsYpUZ0teG1fAfHbW+Kg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=imxAb3FX/qzMhjXldS2L9/IRw7pMek7V0Vh6xJHZ6Ycf7VMmBHR+sqE4ZozNjTT0rWf80VcQYsiuuXsqXzpX+XvZhqrrJjp27YaTW9GatdaPxfb4c084Naq8tyy3rTdZkvNsFyy1y9qWC83Y/zDkn4gsaWmntpNrHF28zOht7Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xn/WuxlE; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xn/WuxlE"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-295291fdde4so1974625ad.2
        for <linux-modules@vger.kernel.org>; Fri, 07 Nov 2025 21:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762578541; x=1763183341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fz3Y0iZrjkcgBV3u4aAleACcsYpUZ0teG1fAfHbW+Kg=;
        b=Xn/WuxlEdnMid6ziRjW9qZ8KrwXxgw8O0AVDh/3Y1NhQyuX4NTbIgJgRWyR0GT3JkA
         OwU4S58GNPfZvVQOnXzn0GMTJ9iLB9+BkV/wTHP6akkwzs2bRZzTEj8XP/NGkRl6y4JL
         Q89B0PntisN3VdGTzvjuy6zEiUPtcubBt0CmuX9xtITBxCvRxviDQmBjGfp9JqwoIusA
         ytWZi546J8jvO6VsTaAu8txJHZNpgxUBkRfQBp6CmfPKUepAKXE2TdGZE+YpsSYvdfSj
         lZUCVMRDyR7Lmd8XAI6gUWi1z6cSOW271V7p9RAD+IHYBkl7eJflA+UWr3XJl5yXwxE5
         ye+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762578541; x=1763183341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fz3Y0iZrjkcgBV3u4aAleACcsYpUZ0teG1fAfHbW+Kg=;
        b=mul18mmP52nRes6ZNgZDuhqgCUcidmgvV2D5pvIntqL63zoqvTil5wQI07PDYPqMU7
         W+QWdbx5hPdksgaNcLkfYOzqOlH5ymrivqePN0nmecS0wmQ2+3Tspr42+BC9xHFy6Fnf
         R6BtbhOcugx+s68O8h10VHihHZMK0xEESMr8Iykg9/1I2G0i3odNZ9SXyzXX3amXEby9
         G1H9/CJMW7psosQ+tZEwr3dWNOsykvLo63Uj4btbbydAuvCtM4nEQiSWPGMmbFpaOI/m
         GP87VqGg/MPnKAri4Mkpe5oSt/VwE9OkUmiucn6P3LucRnIfmrV1pst3aAYsl8VDez6S
         qraA==
X-Forwarded-Encrypted: i=1; AJvYcCWi6Dzt517fKc5vkPlAdg5gTa9LsAeiYQdsCw486joW9EWSxk0Y84p0DYBRRAceSzCTnnfShNJ+Fv70H1uj@vger.kernel.org
X-Gm-Message-State: AOJu0YyVzhYmKTBNao9xS8895ovecAadnXOHDMAKHpSSICGmjLUQJz5W
	jUnRjP02RpUTnYXvNMnn1T/5mZReAt+acFZMUpYZpXS+M3XIkcI5+Zu05XD594YLMOPBoyvKwjD
	HUXMw1GG8Qwc5aerxy4XBZOhmRpnACR0=
X-Gm-Gg: ASbGncvXtH0osHu0zW4EhvS1gjoVhEB7pYJ4neptFPxBIMrODD/MaVfjCsgySlJCf9A
	cWpas/sOZuKePpSr59eT1sLT1rwbMtPmJGIQSBVU6nprQypMpiDF6Ghd0bvKEASn29pU+4aBnTi
	MyAz6ea2vDSxzTzUjvdlJUmBX22tHOUtvuVlBBO+JbvJEo/RYee+FPhlCLWuVWL35v+XGSkui0/
	jCGx0rWn2Bi+plPeWl9FcdPKOlvBCkE1+sZCo/EBXpWufuodz4ITt7oJlkrqo08qrb5WyD8iVCB
	cdmNnWMC+nSLAGdrnXYRwdYm1aiFQT4c41hlBjNjiu2G1/br85ZuZJX8NfRvyzH5qbVkFsVMiJJ
	5mR/HjevLB+GR1mL/LXnx1StH
X-Google-Smtp-Source: AGHT+IFBuCL5u2fMr5uQrCuCYqh69grOQb2YzSXclEu4sAxP/EhHfjXis6PkPrFs0zQu0KSNoHuxy2oDP2s1+XJtf2Y=
X-Received: by 2002:a17:902:ecc6:b0:267:8b4f:df1f with SMTP id
 d9443c01a7336-297e561612amr10933605ad.1.1762578540720; Fri, 07 Nov 2025
 21:09:00 -0800 (PST)
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
 <CANiq72kcRsTWPhQVJ18P6RUxL=+c1Z8BJkyK_kRR8EBmmH+cWg@mail.gmail.com> <20251108044206.GA3038215@google.com>
In-Reply-To: <20251108044206.GA3038215@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 8 Nov 2025 06:08:47 +0100
X-Gm-Features: AWmQ_bnDmDiv5nyPr_pmQnVmI3i02RmMKtbqFEl5H9h15wAaaATcklkG4Em_83U
Message-ID: <CANiq72mLbEVqX-uBtqy+_wru9CRRb3PL3qFqYEcjpZdNyZGd2w@mail.gmail.com>
Subject: Re: Only rust/bindings.o build fail on rust-1.91.0
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Haiyue Wang <haiyuewa@163.com>, rust-for-linux@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, linux-modules@vger.kernel.org, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 8, 2025 at 5:42=E2=80=AFAM Sami Tolvanen <samitolvanen@google.c=
om> wrote:
>
> Ah, nevermind. I was looking at a stale object file. If there are no
> exports, we should obviously skip gendwarfksyms.

Ah, good, thanks, I was wondering if I was missing something.

> For C objects, we use nm to check for __export_symbol_* symbols
> before we attempt to generate symbol versions (see gen_symversions
> in scripts/Makefile.build). We could do something similar for Rust
> objects too, or just bail out early in gendwarfksyms if it's passed an
> empty symbol list.

Exactly, that is what I was suggesting in the other thread about
editing the `cmd` command or directly teaching `genkallksyms` to
auto-skip, but I didn't know if there was a reason you didn't do that
originally instead of having (some of) the `skip_*` lines in the
`Makefile`.

If not, then I assume we could already remove some of those lines,
e.g. the one for `ffi.o` (no need to do it on the fix, of course,
better to keep it minimal, but just to confirm there is no hidden
reason there).

Cheers,
Miguel
