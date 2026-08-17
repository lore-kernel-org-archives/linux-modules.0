Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C24431E76
	for <linux-modules@vger.kernel.org>; Mon, 17 Aug 2026 14:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786975889; cv=none; b=owPnpe1H405ZT2MKoZjDWzOw8TQ18WOM3M7qYHFCu9MSH2xE4qK/Lw3581YZWQ5hwFLh1gd+msthUw6q3bPQ7gljLfbfa9lhyUexc7K7TWRQKVu318FcBraeXL1YXv1Q/Mzat/Me6lfDlt4LCGwZEB2NQu97K+EYj6WWIFm8s90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786975889; c=relaxed/simple;
	bh=qnOg0D4/8diPtWN+T3DOk2D5jQRcfRdXpNqDQU/QDgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mnc+SAvlemJhmAb42BzyVoGotOLSVBKTy8HyGsx0NiKWQXGOE8iZfGF7ytdALx0ngaVrFHBobw2RDNbRNKA6h+N+lzpAl4C/Eu8g8Fa3D8+tk/wHM1m6CFQ92NSOrTYXlth4jRZyu75KBIY/1CA6Ejl1uaml71vZajIC9+1/58s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BnqjfGcf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BnqjfGcf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD79D1F00A3F
	for <linux-modules@vger.kernel.org>; Mon, 17 Aug 2026 14:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786975887;
	bh=SYKcaJ0mHUjl0bhwe5EZhlEr2W0alTSpd/bA190hrI8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=BnqjfGcf+ixEAaqA4x0x8SnWPnmB73aFtWBnmstoeHqjTc0JERkeEWCd2zFt0atn9
	 NCZn/GltW4TsbrnXQBy6fPIIvfBOfjR0F9idiHJcj5BEa7jBLlXpT0vZl1NNOAW0tb
	 6SRKYF32YHdXvYo4iv2Pz8BpAbAg33SnUTnDlTMT4cE734rr5wwBOGId16oaGUnEX6
	 cmQB4Qf3pfn20QDM/KwFL40pUIZa8K9RcMbwWqIStH3uCaZQ3XKJOvcB4BBOVRPfJc
	 wGp2/CLCm7moDObNQkuiPzvkM6LxG9c2i6RgalKkx3OgRwh+inZPLFP77yJ9NYCmfM
	 izyKj8lSEx0Vw==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c20ce3c118aso67125166b.0
        for <linux-modules@vger.kernel.org>; Mon, 17 Aug 2026 07:11:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RodzZC9f3Sgm0K8dKzifU/1Ub63PjozzFSqWzC0RJgwbqSnuyW+squ84EnjmNVfjhpaCklZ0ZrNqzlzn5NR@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4PSKfEKmNRpI2zSMqcCrosdD4LYwIAUr1MRgkeR56VnBF2kPF
	XJvuLpfFXUGIkauw76sjeln73QCCx4H2xoyQWkzpDoRZ518roLZ+Q29gSPRLMP9j5Mbw7WOpQLi
	Z2//JrEyMa3rHmlL7gXosk15bHdpqK3k=
X-Received: by 2002:a17:906:4788:b0:c20:ec9c:441a with SMTP id
 a640c23a62f3a-c210a21501dmr1624172066b.12.1786975886564; Mon, 17 Aug 2026
 07:11:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812032807.15034-1-yangtiezhu@loongson.cn> <CAAhV-H5w8VVW_L6cRes-syjEvhbWmevSKWrZWPFapRkuemmjaw@mail.gmail.com>
In-Reply-To: <CAAhV-H5w8VVW_L6cRes-syjEvhbWmevSKWrZWPFapRkuemmjaw@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 17 Aug 2026 22:11:19 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4RzYY7KsVguLTFMip6uKX8csbDcssJV5vh3-CDxfcNbg@mail.gmail.com>
X-Gm-Features: AcwNN1WbZm96lcAD50BeHds08TJmf_MRkLcccoa0xy48ekZ0232MIMZ-fBNyZYs
Message-ID: <CAAhV-H4RzYY7KsVguLTFMip6uKX8csbDcssJV5vh3-CDxfcNbg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Filter out local and mapping symbols during module load
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, linux-modules@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 11:17=E2=80=AFPM Huacai Chen <chenhuacai@kernel.org=
> wrote:
>
> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
>
> But I still don't think renaming is_core_symbol() to is_kept_symbol()
> is necessary.
And this series needs to backport to stable branches, no renaming can
reduce the difficulty.

Huacai

>
> Huacai
>
> On Wed, Aug 12, 2026 at 11:28=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongson=
.cn> wrote:
> >
> > This series prevents compiler generated local and mapping symbols
> > from leaking into /proc/kallsyms for loaded modules. This ensures
> > tracing tools like bpftrace can resolve accurate kernel stacks on
> > architectures like LoongArch.
> >
> > Based on the v2 discussion, the changes are now refactored into a
> > clean three-patch series to eliminate code duplication and clarify
> > naming.
> >
> > Tiezhu Yang (3):
> >   module/kallsyms: Rename is_mapping_symbol() to
> >     is_local_mapping_symbol()
> >   module/kallsyms: Refactor current symbol filtering into
> >     is_kept_symbol()
> >   module/kallsyms: Filter out local and mapping symbols during module
> >     load
> >
> >  include/linux/module_symbol.h |  4 +--
> >  kernel/module/kallsyms.c      | 59 ++++++++++++++++++-----------------
> >  scripts/faddr2line            |  2 +-
> >  scripts/mod/modpost.h         |  2 +-
> >  4 files changed, 35 insertions(+), 32 deletions(-)
> >
> > --
> > 2.42.0
> >
> >
