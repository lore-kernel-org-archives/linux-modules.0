Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4362F0C70
	for <linux-modules@vger.kernel.org>; Sat,  6 Dec 2025 16:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765038695; cv=none; b=dfdX7BF6hUtC85Y2Eq/wAxU+AOjUFmH3RqLdNFuA8cQTur+/sO3HIoyVjk27CVHZV0LNo5JueVnpn7k3iy+q1SHhXFHJ9e3ILN9JGApXOz84NLvKT6t48QOE2Ihv6e2OHa7LEkvNyfTv/LN44GnV8I9SwJuGZp1hGby59HnRAWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765038695; c=relaxed/simple;
	bh=6ZshacmXlFbGVBg5zvCt/j8h+A+y7g0+u7PF9j6DLCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lNJnrtuL4qmWvlie6Xf2NxRgiUHP9AAHTPP1CN6aw7IvKJTIIhjbh0CUZqBg5eOaxfkplJ3fvaxyYXScGppzgPaTugOq4npx38xgIWlKE/xf6f3oJu0mR5S305JjblV2CnneKabBb4Ox2Ysl0BPvkLlHrkcfNjCPMoz2BOMZeT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=W/ATa/lf; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="W/ATa/lf"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-640aa1445c3so4621460a12.1
        for <linux-modules@vger.kernel.org>; Sat, 06 Dec 2025 08:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1765038692; x=1765643492; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iQgF4Rp1bTaePaM88Pq3Oz1YAu8g85GpEQo8qr5d8wo=;
        b=W/ATa/lf2GonPG5kg9Fc4xB+D9wkXnWNJCHJ5vlaLTBLoQt4xKCzqptmNPqnM5ySC+
         ard8gA53ayZeUAS6Em+HhmArazt+hFgtbBn4lNZ7fafYwzeml4dE10D8SOMGllY5Ctmq
         filb7dXMY47X3PtCA0Vt22Sv4La5iv4bqhJz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765038692; x=1765643492;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQgF4Rp1bTaePaM88Pq3Oz1YAu8g85GpEQo8qr5d8wo=;
        b=o47ydDk8tXvxrkROKxMPtizOoNlIZy2noKUHwHrjBc/kAs2CvjVm76K++CdsbQnP2U
         oU2X/tYTeCjYYabqoxRMTbiMqmD53PvPEoZpCRpjrXGKr9Dlp71UteugHy7VlCLObazP
         Vzcb5Ic1VVCr1kcr2OvdAB6IQ0c3vUhh7i76YhExtR4TdHKaWjkE1dmpD69RxhI8zXb3
         cx7A7JDOVcfmKWbaOYsuBtGIk+ouXb0uwNfGd0rkz1e6+CvYttq/uNd/+uFbo2ZaVFTt
         6RtgNi3vMfj0zh0H/0tZclUOuTaPOCOf86br7GmEBgxe9frmTN94hEbbit1M4+p5Ov0R
         FX8w==
X-Forwarded-Encrypted: i=1; AJvYcCVmDAg68wjZzh1SL/aDBp/lnKssnpTTMnvGpJqqGzbp91l/kPyVNsmkSkfMFkSPgiuyQe/nPpp8LxgXr35+@vger.kernel.org
X-Gm-Message-State: AOJu0YxZonjZ93HX6vzdTyzZ3N/H3VERrUfP+pqCcSodVwno+hqMsZM9
	Xqi0vhj1E9oZO4igaSOnqkfZJRURzsahdf2o0WlY7P1wjtP9KoLtZHHCWdZGSWX/mE+bgpLYZHM
	EhlDSTL8tTg==
X-Gm-Gg: ASbGnctlKAr9LPO8g6ENeYmfQjmwJmn4jhj1Q2q18TtMTvJ2Ppv7O9udVepFpwGQMXB
	CJfhSJ5SPZ6qD1Wy0oC6Nbvy/xwsRFdQV5Lw/ygANi/SgRNGHy7uJeO7aImVxz5pkFy8ESsnn0i
	Ta3cuQCSvl8Q/PVIc3/N6uSuZPIJ5NZH0gFev0C1BlZ7yW3bF4w1OxHiu/fpEIHsHF3Kr9o3xJX
	gLmF2ER+4e+UIqu6T9fY5o6Mn9yQPkTTbDGJt5l/BVemiQrvFe0nUfSuD+pLiYs2F7hrQmBhSB/
	scy3TwYkGW+d1SmP2d6OJ4HM+sxnT2tqD7Zvgzhw6m3ndKzPlE+V8ZXCTEEHJjhCXEGKSNuxCfk
	luU/7zMjPpSOousr+g3Ud+cV3BHC2F+WYJWZREFFpYjI2+r+Erm+6ODaACtZ7UZgCSEsH4866dy
	OODzh1AEnX8jeaSyU6bu3AAd2RQiz+/Nrcjkg4aadBzemJo949ke4Ls7nTCUTX
X-Google-Smtp-Source: AGHT+IEDq4ILVBOhp7Gm49vIHqx6Cp5Uus6Iq5ITSvL+Kjq+k/RnzI9V605+E6Y512CdWtywm6kJXg==
X-Received: by 2002:a05:6402:2550:b0:641:3189:a183 with SMTP id 4fb4d7f45d1cf-6491a400e9fmr2040459a12.14.1765038691918;
        Sat, 06 Dec 2025 08:31:31 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-647b2ec2d8csm6766082a12.5.2025.12.06.08.31.29
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Dec 2025 08:31:29 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-64080ccf749so5068017a12.2
        for <linux-modules@vger.kernel.org>; Sat, 06 Dec 2025 08:31:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV5/rMODUf25CSLjnhhe2eK2rG0TSOuWziFRjjUA6yl7boT00X8riatFgE4tLjWTk5KiosuCeTmfMzU5eIv@vger.kernel.org
X-Received: by 2002:a05:6402:51c6:b0:649:2af5:940a with SMTP id
 4fb4d7f45d1cf-6492af59477mr425146a12.17.1765038689069; Sat, 06 Dec 2025
 08:31:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203234840.3720-1-da.gomez@kernel.org> <7dc0f103-ab0b-40db-b246-a1af40afe4d3@kernel.org>
In-Reply-To: <7dc0f103-ab0b-40db-b246-a1af40afe4d3@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 6 Dec 2025 08:31:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=whF62tP0bqS12B1WfEtMUj7Sx-Q5j6K_q_7cKaakR5oaQ@mail.gmail.com>
X-Gm-Features: AQt7F2oEspGBpXZ3PVxnVPrkN_XNeNOa9vqEtazShyE1iXIutiO2TfFHBqE3llk
Message-ID: <CAHk-=whF62tP0bqS12B1WfEtMUj7Sx-Q5j6K_q_7cKaakR5oaQ@mail.gmail.com>
Subject: Re: [GIT PULL] Modules changes for v6.19-rc1
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil <hverkuil@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Aaron Tomlin <atomlin@atomlin.com>, Kees Cook <kees@kernel.org>, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Dec 2025 at 03:52, Daniel Gomez <da.gomez@kernel.org> wrote:
> >
> >   ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/modules/linux.git/ tags/modules-6.19-rc1
>
> I know the preference is to use git:// but my git config resolved to the above
> link.

I do automatic conversion from the private ssh address to the
externally visible git one for kernel.org addresses.

So when a maintainer sends me one of those "only available to
kernel.org accounts" links, my scripting will make it show up as the
public one instead.

I do that for visual consistency, but also so that people who _don't_
have an account can follow along at home.

Put another way: no worries. As long as you use the standard syntax,
it gets corrected for public use anyway.

              Linus
