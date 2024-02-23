Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E896312D
	for <linux-modules@vger.kernel.org>; Fri, 23 Feb 2024 11:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708686338; cv=none; b=l7I7PYoRJ3H0fplh+42F/QV8f6UCeFA1O/WY1oU3shmOpz/XSTg2S4zrlbO3SFe+URxFX94xTG2t/8UobEbQPmf7GL2IWKGpQ0eXFyx54vgpdBbUrnBiCQighc5zMN2CP8DOPEMPBcezey3QsKmOfimWdicQ0cW2qWL7C80WD5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708686338; c=relaxed/simple;
	bh=gLF893H01+4CIbxVyEqixtUnHdy+Hc9VAq7Ht4oUyeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GM5jiJxmKvt8u64Y9NabIKzwMMsaf/6aDVQPFgv8BbAanvaCvC0SXsEfcj5xhaOaezJszUQD5uHjvw48bdzDEb3rd9nE0L3odpvI2RCxCqXuMadfcWqY6ykf+6FizaRiEIZHke9E3ppD7rlq/qSVSJMyUmHZAVovZ3P68SIXbXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVT/kvJ+; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVT/kvJ+"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dcc80d6004bso701574276.0
        for <linux-modules@vger.kernel.org>; Fri, 23 Feb 2024 03:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708686336; x=1709291136; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j51sFr4+svbsg210/vmMJ0Gv39Rziz4dgFzodiJo6j8=;
        b=OVT/kvJ+owbqyyIhHaR6ZZsd7rI2CeeNy71vmOAApfWTSH4D+0FK2v02KXXKRBU+MQ
         ueXJ3LKpWIe1xs/hRSjhgbhWgWuzVCw/M4adbt5Aq9ZQ2pSHHij9UaUjR54I6nrGslVG
         FJQFs8HHT98SII3cT3wSkwn3fn0ANOz2DGhJR/HlJg+kqxK61ppdk3WTE8xuUmLBnpV/
         DYjNClhrDER2U1mN8lNFHIAUBUZYvdgX+nOEaU5HA8rdZnfh3K3PDgy4MeGUg70zMkee
         4+b2ZsYigivl7jr7sBvMU5HChOjtKotw7/pI/w5klKleB2N8w+FsEP0O1N1kryVxEBMb
         Qs1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708686336; x=1709291136;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j51sFr4+svbsg210/vmMJ0Gv39Rziz4dgFzodiJo6j8=;
        b=vdddf3K5NBAzOTi/QcJCZE/R0azmxbZqm4US3gUErGlal3dtBlEDS75B7ZchR0kwVz
         Lt+EPd7pIv005C0fUJkDC4tOYaFmHLd80z3GbyjGvUl2IRIYAvxY3Y5qUen81inJGGF+
         FKx2uZ7/WGgDZ8swkef05RJ+Op8LndpKMfDeuDOeuFQ6Ccr3tkJZexfOMEVRvP4i/Kio
         UThn7Q/6SY98QepHTjU0+iFfynXthxVauZj4a3YzUIu12u6UuK/Iw6TX3p2q1/RmMzmy
         f4oenB88dpYGyFCis9dbchxv3FRKBl+LTVFPhCplWu7/2KzWzxfGlwd6oyo+/7Z/u1Lr
         H/bw==
X-Gm-Message-State: AOJu0YxI+8yTAgIXe5C1F+2ytI7xv1i+DVOmftAo5/eZ8B8nGwQ8dRyW
	/KGYXp+jTWlxq/QqpjwyvSGqtw49m00Q0wIMbDh7OEee0Y9LzFt6dhgIPXL59K1tjReyj18hxbm
	idxbq32AOxtt15kekgY+8cg1hYBvQAqoA
X-Google-Smtp-Source: AGHT+IFkSbXEjgVYcaFepf6XeG6SzpjPKFwLTe0kxxQIIWwfUn34f1PjR7NgrvfIlrIC/rxYu4zVU8OZk+1qFRsUN2E=
X-Received: by 2002:a5b:bd2:0:b0:dc7:4a94:d867 with SMTP id
 c18-20020a5b0bd2000000b00dc74a94d867mr1607325ybr.36.1708686335634; Fri, 23
 Feb 2024 03:05:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240217-autoconf-manpage-warns-v1-1-e1570cfc286e@gmail.com> <63an63knqvcxyxh5ejx64bsxgpooikbba5inrd2kzbxuhuuenc@nk644hvv5j2p>
In-Reply-To: <63an63knqvcxyxh5ejx64bsxgpooikbba5inrd2kzbxuhuuenc@nk644hvv5j2p>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Fri, 23 Feb 2024 11:05:24 +0000
Message-ID: <CACvgo53NkaRHbgBkWbiDwSKfUXGRDqV48-zD_NyakjqxUjF8Yg@mail.gmail.com>
Subject: Re: [PATCH kmod] man: silence autoconf warnings
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Feb 2024 at 21:56, Lucas De Marchi <lucas.demarchi@intel.com> wrote:
>
> On Sat, Feb 17, 2024 at 04:01:26PM +0000, Emil Velikov via B4 Relay wrote:
> >From: Emil Velikov <emil.l.velikov@gmail.com>
> >
> >Currently we have a pattern rule, which effective states that two output
> >files are produced - %.5 and %.8. Although that's not the case in
> >practise, since each input xml will be generated to a single manual
> >page.
> >
> >Add the manpage section as part of the xml filename and tweak the
> >pattern (match) rule, accordingly.
> >
> >Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
> >---
> >Noticed, while wondering if I should add sanitizer support to the
> >autoconf build.
> >
> >A few, random questions:
> > - are there any objections to adding sanitizers support?
>
> no
>
> > - would a meson.build be acceptable? Giving us sanitizers, coverage,
> >   scan-build, etc out of the box
>
> yes. A few years ago we converted to meson but I think a few things were
> not working properly and we never finished that. If you few like adding
> that for the next version, feel free to use that as base:
>
> https://github.com/falconindy/kmod.git meson
>
> > - writing xml is fiddly, would people be OK if we convert them to
> >   scdoc? here are some examples of the raw file [1] vs the man [2]
>
> first time I hear about scdoc. syntax seems simple, but I do wonder how
> common it is in distros compared to e.g. pandoc or other options to
> produce manpages.
>
> I know mkosi writes markdown and converts that to a manpage
> (https://github.com/systemd/mkosi) and dim uses rst2man
> (https://gitlab.freedesktop.org/drm/maintainer-tools.git)
>
> Any of those options seems better than writing xml, so I won't oppose to
> scdoc if it's available in multiple distros out of the box in a version
> that is sufficient for us.
>

Neat, thanks for the input and pointers. Will do some digging and
provide a summary wrt scdoc/rst2man

-Emil
