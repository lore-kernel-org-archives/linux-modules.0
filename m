Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B322E7F20
	for <linux-modules@vger.kernel.org>; Tue, 17 Jun 2025 15:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750172733; cv=none; b=i/aCvZfP2VVi8JlJNdZ0072lI9V8dKBEnS+aG5+VgivHsEMsaXrOBQM8oJ+toJeC6yxomTmMjWpaWaI/4AIOhE8/QfByxJGJBqRKsD36MEY5oOOpRx1bg9dITUDqDPI+o48lq3DtcHUVPo2Zwx32khkFyv6SvOU9IGPWZ+A/G8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750172733; c=relaxed/simple;
	bh=GbeqsHHd1vL8W4r3bOtXBX0HxgW5+uwomab9h1t1d8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q7Gn6TMapB3vXrwwBEMgPiU1eIeNzc0fl9vDj2Ul+9OOZhHeDQNF2ou9GcK5XWVRFgv6dP3tKaj0Iuhfij8AWMuw01+JoOXUGSk8CsxOfix11ncTaQyWqGCCmIJPzAy8LPNTM1YYMlIS8skCyALNKeautZ42K/4RBz4rBMSdR/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gyl2XYtY; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gyl2XYtY"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6000791e832so10107a12.1
        for <linux-modules@vger.kernel.org>; Tue, 17 Jun 2025 08:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750172730; x=1750777530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xdDBWUy9j2pqUSBQx3kBN47BSA5JF5clYU2Pq1utjBw=;
        b=Gyl2XYtYAM9whj7zekxDf3mSDC/qTL5iL+O1/QxxCZqmS4f7HZO0gdVRtbMyDWssrd
         OvtyJDlbd0f0xKivWVSBzGMrAn/R8IKKJxmCwcfvnuJ/7taJqX8jKTZwXNbL/YOtLLe5
         QlvEzpG/de+KSovIct14jdZQD2mcCnPDjWM1F4X2TY7l7SRmG7th8Wk8fFoUzCjMlmaU
         Iw8sBiz/CeytgfUzZgaXpxawH1tRxzE/UnMRFvUuJePFgjVzyNvt2hmwKB8ApOZGCe5/
         lc5PiQhvQta/MY58KzBxxWiEiCrPYqZeJPh/Ne34ZaHyMZ4pSNE0j5swdHej3O7AyNwN
         eO9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750172730; x=1750777530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xdDBWUy9j2pqUSBQx3kBN47BSA5JF5clYU2Pq1utjBw=;
        b=VbCongBeSwqipxY6in5L6OnDZAh3ss84IE7DYov5MUrUai8ccawG5ZxODFZ7LkJnGZ
         6Hr3eON6H0ZEeq5sbJ0SdtUfUyMlDxkffLNk6mCoUabBEl2o8XyFRn2ko98/Sk0s0Ys1
         a38dl57Qk4jRTEN0tDwP/pkwLDEYo+bZEMmmUVOMTdUZn8yH9cNMt7P7sCIUByvivYdG
         yGYUBXJ4AIT/XHrlzFcY/EZFGz1siS5QAhD1Guswl4GaiuAPvXW5HPowG5+ewqItEIzf
         r/qdUB3kuFP3X2GGDdhWKcI3PMbmwtnAUwJ/vlc7Dk+YELU9eBgFddjsIfDQaraFmXTJ
         ZLPw==
X-Forwarded-Encrypted: i=1; AJvYcCXtg3acAo4FeFn2/NWOtbsW3ErwDW7WWR9dTtDclBd5G9rSC3lMYqe9NvYNQqwDMt4wVMpK+feuiQnl5ZDi@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx2fwFhSOuCjam80W9twcG+/qslDQRSUx3mEWbVZdpexiYVwcw
	OPwWdI89endgnY43mP3bbyiYZlb8fQEbqybSwE1UsLcy6xEdm9VFXxt3g+beTbiLPbpWvg1qOtZ
	8wqYjBMlgF/oYN0YYW6iRVaQtfhMIJrVmxBGbhftz
X-Gm-Gg: ASbGncs2FISrkyisLJRC2Up7oCNkaxtRMfXlOfgLYElew5d8pHLT3fQJIsy5r0hk4YB
	qBtLw63SvKHe1JA1TWJbCLlhCqXgvSqkc2coe8K3oKqpZM2SFRYu4o+g5yPYlwphf/eTeD91F9w
	dZM1qHALzh/Ep5nrceWI2EAxfkZlDiIDlKSx9ZsdD3KAlhw0a8HU6jyvBdCvHfJFYXxV64KshLH
	g==
X-Google-Smtp-Source: AGHT+IGRa+ebswKWFvguxlBNnkaQydcOCTcdUc1tpDY2GOdw3o8/6AoW8HLi2nmZXoRCM54Zx9JT9odQlOQ7f8488xU=
X-Received: by 2002:a05:6402:1298:b0:608:fb55:bf12 with SMTP id
 4fb4d7f45d1cf-608fb55cf20mr248560a12.4.1750172730198; Tue, 17 Jun 2025
 08:05:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610162258.324645-1-cachen@purestorage.com> <2cd3947a-63d9-4a79-a24a-eb1ae8164169@suse.com>
In-Reply-To: <2cd3947a-63d9-4a79-a24a-eb1ae8164169@suse.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 17 Jun 2025 08:05:16 -0700
X-Gm-Features: AX0GCFtqkKIf4xqb1bUZ_2PHwjODhV30fsR1AexyTYrzdWW3sQdis91nCJ5F--0
Message-ID: <CAJuCfpGxEYZ_7Ff-vpBThfM98ZbUu9pSPeoumkkKuLZiqLpORg@mail.gmail.com>
Subject: Re: [PATCH] alloc_tag: remove empty module tag section
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Casey Chen <cachen@purestorage.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-arch@vger.kernel.org, kent.overstreet@linux.dev, arnd@arndb.de, 
	mcgrof@kernel.org, pasha.tatashin@soleen.com, yzhong@purestorage.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 2:27=E2=80=AFAM Petr Pavlu <petr.pavlu@suse.com> wr=
ote:
>
> On 6/10/25 6:22 PM, Casey Chen wrote:
> > The empty MOD_CODETAG_SECTIONS() macro added an incomplete .data
> > section in module linker script, which caused symbol lookup tools
> > like gdb to misinterpret symbol addresses e.g., __ib_process_cq
> > incorrectly mapping to unrelated functions like below.
> >
> >   (gdb) disas __ib_process_cq
> >   Dump of assembler code for function trace_event_fields_cq_schedule:
> >
> > Removing the empty section restores proper symbol resolution and
> > layout, ensuring .data placement behaves as expected.
>
> The patch looks ok me, but I'm somewhat confused about the problem.
> I think a linker should not add an empty output section if it doesn't
> contain anything, or if .data actually contains something then the extra
> dummy definition should be also harmless?

I also assumed so but apparently this is not entirely harmless.

>
> This also reminds me of my previous related fix "codetag: Avoid unused
> alloc_tags sections/symbols" [1] which fell through the cracks. I can
> rebase it on top of this patch.
>
> [1] https://lore.kernel.org/all/20250313143002.9118-1-petr.pavlu@suse.com=
/

Yes please.

>
> --
> Thanks,
> Petr
