Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE601EB4BF
	for <linux-modules@vger.kernel.org>; Thu,  1 Aug 2024 19:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722541146; cv=none; b=AvB95CoiKn+zX7zkWI4rUAbHTSgKSpRL5CiIdDEq+JJNo03aoHzyqjnWH/lEFSdvHGmH6J0yU9hVqiNsOwpO68z7nzrPqh2eCDyMTRK1oJTAFw6OM1/BDXO3uR9coL4dNmQ4kF63yYQ2M7ZbEY+BtkgEmllC81eUKBZ8iLdMe+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722541146; c=relaxed/simple;
	bh=594P5XzwskbETUT36Fts+eHHT1pKYXxLK7ITeT54cLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J6f8jSZ+6bRbCDK1LUalRI4K+RZjDFDIFROc/9fId7lv/xUrR4ZHovPkhtpMSQP/TcYbb3hOfsO/FHN5m4ZV97oNxSR9E3rcZ1Z/2pXfot6CxXuURc5rnNk14AuFrk5MqX41133k3nZ9JK6f5byurVacpaEhLMpzZSSfBcaNmZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BG8ShvbD; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BG8ShvbD"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-709428a9469so4085921a34.3
        for <linux-modules@vger.kernel.org>; Thu, 01 Aug 2024 12:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722541144; x=1723145944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=594P5XzwskbETUT36Fts+eHHT1pKYXxLK7ITeT54cLY=;
        b=BG8ShvbDl4zHA87oCytrBdg9fZ2uQlv77o5+kM8nTWoPfHBG/BzYfSum8olne2kLOT
         Z5lVpdRXGb5kYlB7KQziTd/YTn4LvYV0PiGy6R85t+InK60FbWz4wZKt8WJSVFrA3rfY
         44ug7kglZFZMTCmkI/Ltn3/PbBAS5p2rC2+PZ4UAyzaSbTOEI9LLU+srfafC8iUTDpix
         k6o3MHDxyfY0muNwrayAfWW7Srr7WdgKkPmH9oOPRAZ7yQmcEg727gkUAEx2QVPRs+sh
         0iJEFlt6orxTkSjD5IQbfMy1N06SohOmZZmYHKro/+2P8uZnCjv3HI0GvbL6Pi887ZqM
         WYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722541144; x=1723145944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=594P5XzwskbETUT36Fts+eHHT1pKYXxLK7ITeT54cLY=;
        b=siJ1qum/pcmq0Syr2FJF2hrAjiq6GlJfp1mm9oVQWN2fPJAmFrokMnpzSY/nC5+2KF
         9JF+WheDYZenvr4jHe0sBQ2rTeYI1uymkj2o96r8Aq/Pj6GMtY8RrML8Wl/ucQGPmxeC
         Zu3ha3lKXLFBa1Absha8gafDbanBCpahcLkH/qSNUDd+wAlF12qd5Afj684tRdncWCjR
         A1sdc2p+JBpr0lfSY+t+8zOZtC4zuPCpbIG7Bejd6WwBDzSpKyxvKn/T31+1THqS1KQE
         7Y9aqCDoGFlK2Ckh8+40iZJAMJolbfBYPaplBmJil6aPLSKZAlIYHllP7260MiNd8vTL
         5fTw==
X-Forwarded-Encrypted: i=1; AJvYcCVTmBb/DLC5ZgXsXGPQy2y6zW8HUetF3MgassFBDyNo8Vf3LNZ4tbLkRZc8UNUyQyaUenouAi83d2Fyo/eqsK5d3vPkgUxejIm5K9kExQ==
X-Gm-Message-State: AOJu0YxSvUPr0DrOr3SWdxNhD09uUcqAI70PKIYeN8SHAtO01P6HUeZV
	Y4BN3T5hlt7D7SCTlU28DVhM+o2D+R1HzJw+x+AtPAfmScBb2q1eLp6QsiP0NaWLSs3Yd4aMCdx
	dpI6+ZduzLJLT0KsRbbWhb687s7b92CAPQL1n
X-Google-Smtp-Source: AGHT+IFc3YHkqxrwEoxXwpgLm2CQXNdMsNg3Ac2IO/Rh0opRhVly3THqWe+FTE/9DxHlnE0bTmB/pcYqRJ3qaEuuNto=
X-Received: by 2002:a05:6358:50c3:b0:1aa:b7fa:4f59 with SMTP id
 e5c5f4694b2df-1af3bac330bmr106834155d.30.1722541144062; Thu, 01 Aug 2024
 12:39:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617175818.58219-17-samitolvanen@google.com>
 <0b2697fd-7ab4-469f-83a6-ec9ebc701ba0@suse.com> <CABCJKueGRBdFfGW-cvOvqxc-a85GpxtwPmLdE_1RiAkNLrEg+g@mail.gmail.com>
 <00714a65-953f-4885-9229-1990543c4154@suse.com> <CABCJKucj7zjc4=EiFdSnzNDBvQmaWBBt_KJsTq1ybp=Vegp5eQ@mail.gmail.com>
 <f08678b1-260f-4200-889b-a4ec016fc7e1@suse.com>
In-Reply-To: <f08678b1-260f-4200-889b-a4ec016fc7e1@suse.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Thu, 1 Aug 2024 19:38:27 +0000
Message-ID: <CABCJKueScjymx3TR-DCVynfgSg93-17cKC0s0b3A5KpiFEOiEA@mail.gmail.com>
Subject: Re: [PATCH 00/15] Implement MODVERSIONS for Rust
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Petr,

On Thu, Aug 1, 2024 at 4:22=E2=80=AFAM Petr Pavlu <petr.pavlu@suse.com> wro=
te:
>
> STG is an interesting tool. I've played with it a bit last year. To be
> frank, I was surprised to see a new tool being proposed by Google to
> generate modversion CRCs from DWARF instead of potentially extending
> your STG project for this purpose. I'm not sure if it is something that
> you folks have considered and evaluated.

Yes. STG is fairly large and written in C++, so it didn't seem like a
great candidate for inclusion in the kernel tree, and it's presumably
not shipped by most distributions, so it's not really ideal as a
dependency either.

> Sure, it might be necessary to extend the symtypes format a bit, for
> example, by allowing spaces in type names. What other problems do you
> see?
>
> The example I showed preserves the DWARF tag names in type descriptions.
> Cross-references and the target type names use the s# prefix as they
> they need to be distinguished from other tokens.

What I meant is that genksyms output is basically preprocessed C with
references scattered in, so if you want something that's fully
backwards compatible, that might not be possible. However, if you're
happy with just the same database structure and don't care about the
exact type description format beyond that, that should be doable, but
like you said, still requires extending the format to support more
complex type names.

> What I think is needed is the ability to compare an updated kernel with
> some previous reference and have an output that clearly and accurately
> shows why CRCs of some symbols changed. The previous reference should be
> possible to store in Git together with the kernel source. It means it
> should be ideally some text format and limited in size. This is what
> distributions that care about stable kABI do in some form currently.
>
> This functionality would be needed if some distribution wants to
> maintain stable Rust kABI (not sure if it is actually feasible), or if
> the idea is for gendwarfksyms to be a general tool that could replace
> genksyms. I assume for the sake of argument that this is the case.
>
> Gendwarfksyms could implement this functionality on its own, or as
> discussed, I believe it could provide a symtypes-like dump and a second
> tool could be used to work with this format and for comparing it.
>
> From my point of view, the current --debug format is not suitable for
> this purpose because its expanded and unstructured form means it is
> bloated and hard to compare with a previous reference.

I do see your point, there's a ton of duplication in the --debug
output as each symbol expands all the types it uses.

> I'm also not quite yet sold on using separate DWARF tooling, such as
> libabigail or STG, to actually understand why gendwarfksyms produced
> a different CRC for some symbol. Using these tools makes sense in the
> genksyms world, where genksyms operates on the source code level and
> this additional tooling can only work on debug data.
>
> With gendwarfksyms working directly with DWARF data, it doesn't seem
> appealing to me to first run gendwarfksyms to produce CRCs, compare them
> with their reference, and if they are different, use a second tool to
> process the same DWARF data again and with some luck hopefully get an
> actual answer why the CRCs changed. I'm worried that users might
> encounter inaccurate answers if the two tools interpret the input data
> differently.

I agree, there might be other DWARF changes that we don't care about,
but that nevertheless make it harder to figure out what caused the
actual CRC to change.

My initial thought was that simply running a diff between the --debug
output would be sufficient, as it would directly tell you what
changed, but I didn't consider that the size of the output dump would
be of concern as well. I'll look into adding a symtypes-style output
format in the next version. Thanks again for the feedback!

Sami
