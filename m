Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5562B38DF9
	for <linux-modules@vger.kernel.org>; Sat,  8 Nov 2025 05:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762578633; cv=none; b=mDazuwAsKrJDpfsNLKUhy0xpf2LyyiO10UP/D1DMXss3vFMGbAsX2fDoN6W963fq3DrU7JsYOjgQna/hSw8FVFFLUvCy9J3zLuRrusdsjpW3cXYEQI7YOcqvAyHQVunaHy8/u4pIMsXxUrvYRoLKSbnP5bra6fbWACdfkH44rV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762578633; c=relaxed/simple;
	bh=INEsrDL3ZFOVJV6ZxDDmepCrXJUSxIqBndjxXSBnJHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MibbIAK6Nkholps+U0iZpv0Ih9sGn72Kz1q7JmDzNngh1tXZ97+5DXc/5++IvjWQ/i8tlyhc7kbVQdLylcP5HQCEuxfXyOxnbWJ6HqYi21r8y8SlUqMo2CC+QTsuFnIuYjNKzsQJ85fQZCeDw0mMEMqF29I73Yapk2PP8buyCCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kOOedfTI; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOOedfTI"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-28d18e933a9so1150135ad.3
        for <linux-modules@vger.kernel.org>; Fri, 07 Nov 2025 21:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762578631; x=1763183431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=INEsrDL3ZFOVJV6ZxDDmepCrXJUSxIqBndjxXSBnJHM=;
        b=kOOedfTIxhWVBJqaOnoL7JiSFy1med7LiUggHTUM5euZtZQjRUFBcZd7dbiJnJN8x/
         KMqwqbd3N0oznq2Au+97Nx2ZXEUcUl1Q6hPC6k4hysF+XxBe1OjtTCLdqaOgG5EVbHug
         VoQYyqa3MIfBqVPh4m7cvh7/SUMR+U1SPvPRvQNgmLxxR1PevjdVLY0YQenBP2fScYBg
         QpCQoh6JsLkDhW42fnl+GzQBmwyphkBSF1lgt32Y/UgqL3DjrD0/aqHLl8jBg0cr6jBb
         un67yYShxFcuKH4yAHOajILRGfW1XvMyKVMWVMJefRKiLdfFZwaZW9EGbHo/teKb67Kn
         k4WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762578631; x=1763183431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=INEsrDL3ZFOVJV6ZxDDmepCrXJUSxIqBndjxXSBnJHM=;
        b=n6PeCjyXAWodro7RCKjg7T/sMwh5Br/rBD+BZEc65XWK+/US6zmGMc5L0BRs0egOrU
         sLx1SKTgW4h0xtk/ycwKm894Zv/AX8AUdl9sapIflQs+u/4eIw2RWEDCovFAyZuv0xoZ
         VnjYDGY5kDoqspqrP2SvAUgdjcIRtAnATB6vSTr1moTZXlj+KeV7D+4Jcy3KGsRCI1f/
         66cHzB9LSsTkuuP9lmH7Q+sK7bNEEMuAwVBJIzlGyN4ZlI5qeIWI8vhl1HFaVdVBQ+a2
         +kCz5MF+jvcnLGhJKnGEiKMfnt+L1rPCBWMkYiR1TqRQlY3SRtnIg9SXW4OjAxqaL6Io
         +Pgw==
X-Forwarded-Encrypted: i=1; AJvYcCVutkxDCZOqG/OIGBnrg5ol1Do0OKnCgtwthUgwZ7u4uY+h/fDMW5WvsdeqdSx9LGoAeyCud6HfGSkXv3gI@vger.kernel.org
X-Gm-Message-State: AOJu0YwH8aa76ynFMNijwI7jkI57XBxuHmtHxp1dfgo1zE5NyKTgZYEa
	wEvmpQXfxhtWwipMNf980loXHx/JuhBZvQNvTIjhujYVCyaL9/5TRXfQkOQGzestPSgaWkbroTT
	clg/wequfbCWpfWIxM2N5slJRJbLZKos=
X-Gm-Gg: ASbGncthVpoqxZFJLi1iPg3WdjoYw6SEYKTIb9dH+YZaP7oimImcvjTxLwtxQgVddX1
	jUeGnjLyd/kcvkbUw0MewcMBbiTYSTa8OIHVaWeW9R1nz3teu+UYIamCLzLuuOPkE7BYebjaDqX
	tu3GZ81ETJIgov04wOuC66V8n4i3t9VWQzH/lIQy8JlvNMB3avcWrnjrR/81h/4W55ZX6U3rqiK
	WOl/X8dnzxilAoLkuWbluhJKXEeP7Kjbcsq9KjNSRFasUSwYClURQmvaAiZd/ii9zswQkm3+gqe
	++c9p8v/YXbXlgRIjA8HXcqxyJQN9NwWMm+thr4AZkzaBDxw0x/UdUb7ji4P/OgFNjGm6Sjudog
	IAu8=
X-Google-Smtp-Source: AGHT+IFpkWjaZPfFIdXLCNNvaUpFsNrIzi/soaYDSl43HhGv5JtmjMSLTRnBgkPYtWq32m0IIjqkxR9ElEvFzEQGC18=
X-Received: by 2002:a17:903:3848:b0:295:f926:c030 with SMTP id
 d9443c01a7336-297e5611fe0mr11021635ad.2.1762578631544; Fri, 07 Nov 2025
 21:10:31 -0800 (PST)
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
Date: Sat, 8 Nov 2025 06:10:19 +0100
X-Gm-Features: AWmQ_bm_JWCStYGdxhk5txWeRYQcMcxjFaV5hIKidHxgDSHYk_c2QUGj1XKDqWY
Message-ID: <CANiq72=c8j6DvbY7JiaR-JygXcd0AESeNpuot9CpFaA3ueupTg@mail.gmail.com>
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
> I'm not sure it makes sense to silently export unusable symbols. I
> feel like we should either ensure there's debugging information for
> these symbols, or just not export them.

(Now that I saw your other reply and things are clearer, replying here
as well for completeness)

No, I didn't mean to silently export, but rather to avoid failing due
to missing DWARF if there is nothing to do for that object file
because there are no exports. That is, what we manually do now with
some of the `skip_gendwarfksyms`, but dynamically, which unties us
from the inlining decisions of `rustc` which could hit us in e.g.
small crates in the future or edge cases like the bindings one.

Cheers,
Miguel
