Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD37331A67
	for <linux-modules@vger.kernel.org>; Tue, 25 Nov 2025 20:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764101432; cv=none; b=aeQvmpNdWBaYrXwGorPy1GfFGCDrla4+F9fWeW80BGIfcEBR0+6hguFfWZWthgQOZXizYZ1cOJEoL9L4vMju03SMpeFTVPpQ26/PQNzpaYo4jlMsTzyfvz5h0kCu61Ek4cRPMH9P/lXdYsaWWBhHzp/yfjNiKlzeAD59rpOYTWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764101432; c=relaxed/simple;
	bh=IpmkyWu37izB9U/urDTB4FMeYG+K+Cuv8K/u3LCvyYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jOUizJhGP38Igon/i+gdTUVog45/a3dk8I6kTMy/26qPwv+/uZOed6eiRwFK2F05oC8DHg5roHJuRkt10eA9gYXsHYH8Z1gTjpt4r8wkTsRvRrsV61kMMUffwiiFa7YPYK3e7IbRKgqFbpEslxvhrsu9WFXXCEAoV9EwCTYTVOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r6XKd7Ua; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r6XKd7Ua"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2980343d9d1so34235ad.1
        for <linux-modules@vger.kernel.org>; Tue, 25 Nov 2025 12:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764101430; x=1764706230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+5vyqCrtY9XbVqcemX0lY7g/P4KxTFS1RrZs7bK+uY=;
        b=r6XKd7UaPy81HY4T8ChhRs0XIESXHy5xdnFVIvOlQa+zHomKc4QuXz6n6ueLegroZX
         62qJfSGXx3xbr6b0j4OXv4Vg/U+zu7ZVo+mjg2FfVU7nph2uj+SU2rv1/uQcMotMhb3D
         prENkAq0UzXLc6LPl2CJMj4+rlSmxdQkNGJx31U0iDjA+RbARG87K0CpkduKiG2spMPW
         0GSYg1V/IVS4p+AWbFBOfbVlBbCoCJnEHnMC2YovNlnI9Wnxf7e/UFjPM9MlSi/PFvgj
         13nEdXKJKd9PqKCbT2ZpGJb+DlOgxMtqGexiYpC4Z36HOSf+yNmM0JGbiltiJbQcG4NW
         gj7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764101430; x=1764706230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i+5vyqCrtY9XbVqcemX0lY7g/P4KxTFS1RrZs7bK+uY=;
        b=r34s7ER9I9L9w+ABPWOwm9ZI6GT7At0Ro3vq6arV5laDCBMSM2xvCvEzZ/sdW7T4vK
         yibq7YkcDLYQy9FxGYJMU2AxmnuudVVRACiD+Lr7G7jFw5Fe93GOmvDDjMTFB2Off9cF
         gPn6PcWEGaiHS22CynPWJ7ZIOGV8s/iQWrY/0eUHqB8pB+L8I9wbBRVKkXUDovdmaUIM
         DHmFTJaIPUC8A034n0aoMRJIyn5xn+Os5b7oOt1l250ifr/41c6HTQH+1BO10wekTISz
         qdQ9S3oDbfaerPAbX0GQXFVR/HJK12pxavM6GLxK4CR3w/+qdA1OPzAVFOd429DQRU21
         sQiw==
X-Gm-Message-State: AOJu0YxI7E5SSZoTqBFuyIUd4kzGAWbtWtE2HmOFhzLc4TzmzWTbl+MC
	f5jWH+BeZLHGjBM0qe3klO5s29uYQKyIfb8/SBVmutaxq/CItXhqwWyIM3jTsgq+kiH9DkG2PbV
	G6VQji7tn90QBcBxoryKatYkFtCgtQhUtUJWlA1fxzphf3M5m36JKZfUs
X-Gm-Gg: ASbGncuxJyDioEII2NKrMC8HVu0V7edB6Xk72yuZ/PHRd7xiInMz/4JhezkOWjUgA9i
	0n/pr6xz7ahFLXr1+DMmefLbys7x6sj18QVOqNoADpaMc5bJChCIPOS+8x3HQJqH80/+BgE+QT7
	QxbrSNeMKAZibYVo0cVM+LbfA/JY98NntLoH0M/beAVa1FEalUDrPnObMZZJFFTlP1pd+7t9M/z
	GS3AR+34VnpHcbh08MXtg9DRqIvwtkAwS3x5oYWDGp/Ql6fXoO7FBZE8bfrRjLK8y8C
X-Google-Smtp-Source: AGHT+IGna2ErKhNthbpSypt53IuMt3hgqHZlvYfXCyfz0EDoxhdTVpdJkiV9BuKUCjqG7mkLQMunNXHx2Y/iuXgA2LM=
X-Received: by 2002:a05:7022:a91:b0:11a:4752:4322 with SMTP id
 a92af1059eb24-11dc327e1femr21774c88.3.1764101429398; Tue, 25 Nov 2025
 12:10:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117203806.970840-2-samitolvanen@google.com> <aRycVOe5ZXSJJFpn@kitsune.suse.cz>
In-Reply-To: <aRycVOe5ZXSJJFpn@kitsune.suse.cz>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Tue, 25 Nov 2025 12:09:52 -0800
X-Gm-Features: AWmQ_blW6iMHGI7aTPQJK8iAONzA-fBA8_Io8bUpLEK98GyzR8N3QeVQrdLSgl8
Message-ID: <CABCJKucc0bxLJ=b9rkiwWts6uA=ReLFr32K1OP9WH51D-hO4+A@mail.gmail.com>
Subject: Re: [PATCH] gendwarfksyms: Fix build on 32-bit hosts
To: =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, 
	Daniel Gomez <da.gomez@kernel.org>
Cc: linux-modules@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 8:18=E2=80=AFAM Michal Such=C3=A1nek <msuchanek@sus=
e.de> wrote:
>
> Hello,
>
> On Mon, Nov 17, 2025 at 08:38:07PM +0000, Sami Tolvanen wrote:
> > We have interchangeably used unsigned long for some of the types
> > defined in elfutils, assuming they're always 64-bit. This obviously
> > fails when building gendwarfksyms on 32-bit hosts. Fix the types.
> >
> > Reported-by: Michal Such=C3=A1nek <msuchanek@suse.de>
> > Closes: https://lore.kernel.org/linux-modules/aRcxzPxtJblVSh1y@kitsune.=
suse.cz/
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > ---
> >  scripts/gendwarfksyms/dwarf.c   | 4 +++-
> >  scripts/gendwarfksyms/symbols.c | 5 +++--
> >  2 files changed, 6 insertions(+), 3 deletions(-)
>
> with this patch gendwarfksyms builds on 32bit x86 and Arm.
>
> Tested-by: Michal Such=C3=A1nek <msuchanek@suse.de>

Great, thanks for testing!  Daniel, do you want to take this fix
through the modules tree?

Sami
