Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF1740DFD7
	for <linux-modules@vger.kernel.org>; Tue, 10 Mar 2026 13:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773149446; cv=pass; b=rHvoq5CqXLJ9QJ0NKdyrHM0C8ErcTb8qj/ruNF81EtB3vHEdXqa+MDa6uvfEGFOdAFarR7mlCjkG4jl/khXaMZzvOGcINypHHvz23YEWLCrNiHn5Lh76aRQOMrmu1Vx0pYPgqvVUfEUqVfSMXkWvbWWCAvBci67Oizg1f0yyqek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773149446; c=relaxed/simple;
	bh=EKF54KzxKlJVD1XBwMORf7RVmOwJS+QH4KErVJ0IlsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kIcTPhG+CZEoshAjeYMGG0XBqzgDIBSspr4jwYevEbQZryUkjPlO/mDAYjbtG4HxG89X4zrF//ov/pPdZp1HOYF/b9JO3lHD9SemzT4s7DQiAMhbLXlZrPn/KcSNi/TlZXMfAKT0ngMkY/ZpL2HN2+98xwltKVWQjdKkrj0V1Cw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=isfkHulX; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isfkHulX"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7986c7b8076so138649677b3.2
        for <linux-modules@vger.kernel.org>; Tue, 10 Mar 2026 06:30:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773149444; cv=none;
        d=google.com; s=arc-20240605;
        b=d6vpryWB0T9HsR83UJ1imhQjML+4t5fKY71mzIgzYc49AfhfEwMBYLclo0kWWX87ec
         3cHtbkJiOpGHnLnJ1xBTZr744ERldzqOcFCXASzMloJveWiFO9Y7SholdeWhNrEX6trv
         yPMpoCE0FmnoKn2KJdrJPhTvfBZyZBCoPBFKJE0+yGGStQ0vgRC4Lld4PURjG/yAYHKn
         BJToElaN4InDK2+ragymX5X+kOGU1wxmHzYkuykF141P7nKrxzNMA9NmJrnergMU1FZM
         qsx181RuWZeVzaOWkDz2aXjKOC2djKORdIKkXPMUk/CWxomZKPKEL8F7wQi8KUgi7rj4
         NzRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mp83KXB07/DXqMEadIQ1d3ZnAyWsa/PWubPlcc7G7wc=;
        fh=DbMWf1FtYEdnC2Dc6p9Ol5HtkZtcEpxGx981PoIZFF8=;
        b=lPwakwoERYvBA/Per/lg2EY1llDgZJUj4SUWzYsAvvuEMOgpAfkSj6GUEcHzKhKPdU
         x9qFUjOe7PlPBUTPv95yR69h66ye3/TjSIdPQHBv4LX2alrv/jmh6PAw+Fcty6O1cWQz
         ZxgSYaq7An11GQRvWtWpUlOr/JpS8BxhREAGSWWJdd0hcZ+x0LmHKqg4TnEXPUZvkoly
         zOzipW1u6dRxM68s9nHsyH6cuMF07xvDazVmtkJpBVhvqq21Hi2Gywp4OqUtqUjefRAZ
         YGsY/Tn9RxKu2QsqVG8vU+/mMbZFuhzAt++ymKbwCJajWiiNbSZkKa1lx9cOjPeL/2z9
         JSjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773149444; x=1773754244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mp83KXB07/DXqMEadIQ1d3ZnAyWsa/PWubPlcc7G7wc=;
        b=isfkHulXip0wM+q8CVIJlYhDCgTCLAUiX4qmXS1l02p2ZJBV85TwSX3yHWxkhRIhjR
         zdPJ3fV5qfSWv4aTa1uLaHmJmbmBuGeYHnjVtaky3fVwP6NLrOF31QZRCgBTCU70tAKw
         Ec2NELJyKA7LsNCzAP53LUoVWN9kIe8h7IKaFaF5kQ3g+aPzGXs/5BfzONACueivt1X4
         09I6aZjuLpFAgymmGBG6tM8u9RLF/eMIRQc68RmiKfXMv71ZKljlzJMgItLy706vzMTu
         38gvNJkL3bG1LHpd8/ZRmyhLhWJn3j7dPHVqn40Df4+Ze93wyCfkHdmMb2cJ15npxpZg
         2i8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773149444; x=1773754244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mp83KXB07/DXqMEadIQ1d3ZnAyWsa/PWubPlcc7G7wc=;
        b=NmFHB5CyUeaXaOq04r9Che+JL2ohzvS5gGEtCTUA2LMmR70MSLEcrV9YIDZLf2gSKI
         2Wv0rpyhKISQ4ZudT7xbmipvkY4WRiyzjHuBedu3NuqIcd8lgR6LEkwRnPpk/ojhWnZl
         FS2Z3CYTn6D/aYLJQPnDqT/d73lVSIqSwsoSlDHJV9gIZCegbdhyfODGEbc3Ao+m9Yph
         m8rlKVH9Bmj/HqilTr6iH1E4HDHIKHkVRCzuZTwGzPzZLZKSdG2axc58iLX+mOf2g6ah
         dSNRhc5LyzASoxBFqR41HfqSInWDqhBpdL5lmDYlZ7TgBKqZd2SfY3gaZ0J5Yuc2Hr+e
         4/PA==
X-Forwarded-Encrypted: i=1; AJvYcCWvlx/y7cQT8T8GCUuYdTxfp+QNZTbsCUK9EitlSrEkrJr83VI2TpcaFiVNDFws2Ptvsq1DNuHU0R2Hsk7e@vger.kernel.org
X-Gm-Message-State: AOJu0YzsGHkyBppBM5XSPJiP1X/Hj6M4sQNqwtwpEeqnmkYFLTQ2uqbM
	Sacwv1izO8S+Ppu0ybOg94EySRc7z2zLL9wEX/GMcF7iJtPL/2aYE/GurhqrmDoIVBviIgDwFmQ
	SK/J8FMI6No3a7JoBhXnd3YEmiYKZGwDmVGQ0dqk4kA==
X-Gm-Gg: ATEYQzxbilRFDHA50mWfB65zdw3hDQq1ZFAka2m+ZZoOsMqHL66EOZxNGXZVYChhj2n
	vTBp3h1hTjvZIxHJxKB/7gTseDRBMCJNHNaiabstV9OsfX5qCjWMPunmj8sHe2Gt7O5oDNtwaFr
	EpI6ZP3IsBZ+CMfbQ/81Tw+OmUv15hawgZbA8lVxrLnPwa710TXXDysxa0CjRGmIIMZpibSQFgp
	tJ0WSW2ECkyM2P8MMdnbvPmmRXJBk3v5IjYfezyectFZ5oKE763QA0PbXkvGB0zbfbH5pvp6zBx
	NzumMtnT
X-Received: by 2002:a05:690c:6b12:b0:798:caad:ac9e with SMTP id
 00721157ae682-798dd7d338amr131546297b3.61.1773149443059; Tue, 10 Mar 2026
 06:30:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aa-6wILF90Y4ndnd@infradead.org> <4215f061-488b-4c2b-98b3-45db4aabed5e@gmail.com>
 <abAXjc6OihRcdoAA@infradead.org> <CALOAHbA3g=UVavYgxJXH_5v0TYMLd6QKUTd=HDbD74Cp+9Kgvg@mail.gmail.com>
 <abAZSCbSEGUhTdUn@infradead.org> <CALOAHbBpAi_FM=odrNkGwXGj1d-ydn=cwURXkUGLawzOMUufuQ@mail.gmail.com>
 <abAa03DO9aLxWcwX@infradead.org>
In-Reply-To: <abAa03DO9aLxWcwX@infradead.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 10 Mar 2026 21:30:06 +0800
X-Gm-Features: AaiRm52QOjEvdUTF-3_IvWKZyg5wEZP6lacpxE3UiyV319Wzgq6Cl_yhJCjeDvI
Message-ID: <CALOAHbBoX00_eDLq4X6vTrbdLG5X=9-07jW=Ba+Oa-QjtZX3MQ@mail.gmail.com>
Subject: Re: [PATCH v3] module: print version for external modules in print_modules()
To: Christoph Hellwig <hch@infradead.org>
Cc: atomlin@atomlin.com, da.gomez@kernel.org, linux-modules@vger.kernel.org, 
	mcgrof@kernel.org, petr.pavlu@suse.com, samitolvanen@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 9:21=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Tue, Mar 10, 2026 at 09:19:22PM +0800, Yafang Shao wrote:
> > Given that the Linux kernel officially supports out-of-tree modules,
>
> It does not officially support them as a first class entity.

But out-of-tree modules are still a supported entity by the Linux
kernel, correct?

>
> > we should aim to support them where reasonable. My change is generic
> > and improves the core code without being tied to any specific external
> > module.
>
> It adds overhead

Could you please explain what overhead this might introduce?

>  to the kernel just for leechers like you that don't
> actually contibute their code upstream.  That's always a bad idea.

I am not the GPU vendor, so I am unable to upstream the relevant code mysel=
f.

By the way, here is a record of my contributions to the Linux kernel
over the past few years:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/?q=
t=3Dauthor&q=3Dyafang

Given this history, I am puzzled by the "leechers" characterization.

--
Regards

Yafang
