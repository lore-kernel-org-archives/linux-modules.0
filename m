Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D57322537
	for <linux-modules@vger.kernel.org>; Thu,  6 Nov 2025 17:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762451683; cv=none; b=EGRP7oiHnb/hp2W356+WIckGzCD1+eLp+ea1W7aAwigN54QjMuGMIvGSHYXcYva2OwCjT0jfpzaHQsnad/j9lf0QHK8jmh1D2Kc68ywUNbV4OFAx0NkjACNmFViu2XCsWexxmh7q0HaK60mRdNPgZY9/5C0nz1nMh2OMMaPQJe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762451683; c=relaxed/simple;
	bh=Ksw1O2ILTa6nbNkzQ8ESg5jM935Th6BDveZ1S58oGbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ek0P7LWIQOWT8IPIM25pNQwgNxHVmgVrL64RxbIVQipF9+9gcpCUCe1gshRC2FyEo5kEFzzhrFGJpvxGoMlH2qxPfj/63JxAeMqk36Z9AzpSXtOnuMszx0uyRiX10pM5TS6J9j9avaBQNOhnHzAidf8jimK7qEggSu/xW8zoemY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UicaYoie; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UicaYoie"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2950fab14beso538015ad.0
        for <linux-modules@vger.kernel.org>; Thu, 06 Nov 2025 09:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762451682; x=1763056482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Okn7qpZREP/wLijgmlrP2ZX+9ZeLo6Ylcde08Z9eoeg=;
        b=UicaYoieNEAJldATNlWe0ilE0H5q6doUqvzQRLUzKckS8/tstHYz4ZtbolnwwnxLFZ
         o6L8yrQN5rO4Q2sGf1NjnqfedRQmNqLSiSGto0ZHXDv1bWTgoRKn1IV/HO1SdSGMJehi
         LdH4NZm/LHGR687OVH5Bo+WAgafDuVf7suWEoohtBdMZPy/qehl7ogLH5zAg9e6Ktn6L
         sAxm1gw5yw/HlB3obsATOCC5/Fh9cCm/CPKIdpN4Bc/mVolsaTeRxANPNYM7FJmtbofO
         r1kHPbCCxGSGd9zPj2HEU2i3h+a0cxHEsIc6RZNBYjKDvAWcA7Hf9U1OSiy3Ee8Ww9zd
         Ng8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762451682; x=1763056482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Okn7qpZREP/wLijgmlrP2ZX+9ZeLo6Ylcde08Z9eoeg=;
        b=aT/jZeRDi+jUNP9jc4sQlQwFlvcew7rR+5C9DjkjL40ekuajyDyXAhucftHzbDoVre
         ny28XRAsSyxH/iyClrPk1taPWEpevxjNbOuqFWyIXH07F1cK00mgeTdMaqnrWPHbBYml
         9VybUqU88G9SAl73ixUoGBm8kHrywg1f6toUhH01OupGZ9KKWsukOytiMd4Dln5vqVeV
         7d5suEJSvbGN2lUyJNLe18WhaBtccM3gRTAQOA0ZSj7hkoasT6tyn3HLPtfAoZQeu3+7
         XeVMxSEo3WwIk5UpnK/irFBL4sxgI2ezDqSGOHALo7uLqAxR83s9egPJy3GeM13jz4Zz
         J7ng==
X-Forwarded-Encrypted: i=1; AJvYcCVvB3wlJBgdG+a0y6Yn4UCiVsPy9D5dVI04FNTicE0fsRHt3Do3jWm8ONbmd0wnUqEwdgP1AWPiDzUJakgX@vger.kernel.org
X-Gm-Message-State: AOJu0YxwXQ/IS8zqyitXklumAogFLO6jN6xNxsfMD1Hmt5gQe2AxRnZR
	b+BAyXUwELLwfyHM+h8U23fVdRlFGfqZzpP+EPFw1VlanbY598mFCK6trb7kYmddBqxyE0hvE/l
	DoOlUGVuj3YcgP/eUBcC8LT0XUIAqZ+C/DEuwg14=
X-Gm-Gg: ASbGncsRTb+JlODoNKPRWUPG3YMqZzCwDdLkwWq9B9e5WAJnkHyVSHfb6LzZ39ZRLIe
	WeZt3IF35RY6q0xsPIGvQ1BExJMv9A1B5JB1tEM1HTX3bzwgAYHZNacrXLIEETmBoPHg5TZTfcT
	sEqVsQOGV33fZzdV9LRFAOiWLFRWatt/YpxciMZ22aFg+nsfppq2GnwmB9ENZcn4liT/6/suLZz
	l2gDY06OSSwdv25LFdNH8iuKVgQ5x7JB26ZqomAjQmLKucgMlYknzyMJNPkDdhDycpyNMY6erA0
	QhRCemgxJnLvFAzJiYNL9gnQW+dLp8yMl3OVDIieGL4ftLrSHH+ixkufC7/tVQfNlzy1nXW8isE
	dqU8=
X-Google-Smtp-Source: AGHT+IEQFZLchjDduH4qWmZhyYV0o5WLbi5+ttwHSqi4gQaN3BU7nanFdl/mHX5HfcqMUadxoGA3i7/M5nE2rROJQ8c=
X-Received: by 2002:a17:903:1cd:b0:296:4e0c:8013 with SMTP id
 d9443c01a7336-297c045d1ecmr2192335ad.6.1762451681522; Thu, 06 Nov 2025
 09:54:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b8c1c73d-bf8b-4bf2-beb1-84ffdcd60547@163.com> <CANiq72kX4Yep3pNVq8Ge=txQbPnMO=zKsci5cPgz5LDS=D6NoQ@mail.gmail.com>
 <CABCJKud0G+Xh+Wbtg4SDGvk4Yh5nmt5YgHEPj-H0y8GO5R3Amw@mail.gmail.com>
In-Reply-To: <CABCJKud0G+Xh+Wbtg4SDGvk4Yh5nmt5YgHEPj-H0y8GO5R3Amw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 6 Nov 2025 18:54:28 +0100
X-Gm-Features: AWmQ_bnB7dF3A5p5iTsNbh6uHhgvWv73d0_f2Do54xO3WHnB4_rI1cr-bP8T2Fw
Message-ID: <CANiq72mw66ADx7LoUuqY6h9KCU=uFzcNQXZ21kMP7jBjCyyaHQ@mail.gmail.com>
Subject: Re: Only rust/bindings.o build fail on rust-1.91.0
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Haiyue Wang <haiyuewa@163.com>, rust-for-linux@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, linux-modules@vger.kernel.org, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 5:07=E2=80=AFPM Sami Tolvanen <samitolvanen@google.c=
om> wrote:
>
> I can reproduce the issue. With rustc 1.90, rust/bindings.o has
> debugging information, but with 1.91, it no longer does:
>
> $ dwarfdump rust/bindings.o
> No DWARF information present in rust/bindings.o

Same, reproduced as well.

Bisecting nightlies, it seemed to happen between:

    rustc 1.91.0-nightly (12eb345e5 2025-09-07)
    rustc 1.91.0-nightly (9c27f27ea 2025-09-08)

Cheers,
Miguel
