Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17184199939
	for <linux-modules@vger.kernel.org>; Mon, 21 Oct 2024 16:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729527804; cv=none; b=SZUDfx4/fWQnwMKcAwPOSpECXMHe742nhAV8d5+kDED10I3wKD9Tm6wxvY7MTV4q9x1Ih7A93qlhX91ekrca7RprvW4SVHMiDUwVtj33lYpM7MWSHb1DRGxuNZ437e46Fz3adrQHwAdyz/EOWzLL8z2YOyQ+dnlrWjwPldThS9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729527804; c=relaxed/simple;
	bh=JVqXq55LQdHL10is0MvisiD3g8F8n1bWChdE8ZjOpqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GNmIuzkMB2Lmk5kvEB/MO04tMuZ9WTv9vsytTh/vVxxCg+oZixfwizqEfcTGnM4s8uuEkhG44JkWOmnzThSGpORm3zveEI+G/7O6ElohYCTOiP14wTookuGAT7hTJ+Mz0NNupd1snHl8ITGbYIDZPp8Dm/IeyM2GJuR46qOVBvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AGCbbQcU; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AGCbbQcU"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9a1b71d7ffso747583566b.1
        for <linux-modules@vger.kernel.org>; Mon, 21 Oct 2024 09:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729527800; x=1730132600; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Lr/AUAtx/FQMtUh6AmIuvX+izsQVav8JTwTXqT9niQc=;
        b=AGCbbQcU3shfyQuaz/8Dg6P1REInYUfWdNspAWhoL+IbeEcCVV1J7sMe0BD8VzWSff
         esWhZirrZR5Ovo/EaLEKmTJiVbVEmtliobJQ7wPDHxOIHESWFttoxQSHjN2CPz/2rtlt
         KM9ebGlpVCwPEiYSwly7ui5fls0C+eDp9Ld0sqFf9kYsshV7zQn5lWoWWBNaf13eBy4j
         Xw4z9IjNi1qth7uAqlpo1imtIWOwvp8S7yq3oO/5oFuy6DXSpJcEzgtEiKRi8EmIuck1
         eD52coLuhws0A87Q5YLOXSaRgvN/zmrKVSOA+AbECKavzdiqpdiH00dLPaJp2kDfPUd9
         u0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729527800; x=1730132600;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lr/AUAtx/FQMtUh6AmIuvX+izsQVav8JTwTXqT9niQc=;
        b=lQKzUFzXP+dlcLUdx2hvYNYp2q7NCMHLEw9KlFYthR+QvQ+glxsCIqXC54zJRDbNh4
         chX+Ki0yW7f+KtXIMgu6RxT0Dz/MsND1dkDSOupB42dPFG9R2cxd+OgmmBpY5nvxV1gi
         b4UiugRMK0RSPY1+zPA7n3sktCEjQDxv1jHkn7MzPjPt52fUIL9/xqAu9P1J2gxR5Dd7
         kSqI8Kr7zO1VKTf/UceWco+roVbQlKNDYXPEZhRTsK/bB74AzgSHmK/QVyhvZnxuMCDA
         tx6O8H080Y7+DNilSON8l1MiFXPDzVOXEanWjjHhQVa/MDasGhnC7YpgQgTOC7PlaZlL
         Dpvw==
X-Forwarded-Encrypted: i=1; AJvYcCXg3LeuPI+y7UNdd7rLafMEZKpjnot5Sfv5VegcyFbWJw0l4+4z4XLQpPDSFgAorZl8xrevt+/HCUOekfmp@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwq0g1shShzbZus6Nbz7DMgA+9XXBJL9zjDOBhbaSCveppbkiP
	WNIX0UYC99DADTnmhmMqS+5b1AyxSBj6RmBy66hL9ZHSE7O3RhuO+D+I6TVJArY=
X-Google-Smtp-Source: AGHT+IGr0R5dZljnxHV96zyk0UIMCnazXHXjSfRrcJo+cGBtb2Xy0gcW6CKVZ25Le/NX8RyC9vegyw==
X-Received: by 2002:a17:907:a4a:b0:a9a:5a14:b8d8 with SMTP id a640c23a62f3a-a9aa8a05ebcmr63573166b.43.1729527800271;
        Mon, 21 Oct 2024 09:23:20 -0700 (PDT)
Received: from localhost (109-81-89-238.rct.o2.cz. [109.81.89.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91306fc0sm220180266b.91.2024.10.21.09.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 09:23:19 -0700 (PDT)
Date: Mon, 21 Oct 2024 18:23:19 +0200
From: Michal Hocko <mhocko@suse.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: David Hildenbrand <david@redhat.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Yosry Ahmed <yosryahmed@google.com>, akpm@linux-foundation.org,
	kent.overstreet@linux.dev, corbet@lwn.net, arnd@arndb.de,
	mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org,
	thuth@redhat.com, tglx@linutronix.de, bp@alien8.de,
	xiongwei.song@windriver.com, ardb@kernel.org, vbabka@suse.cz,
	hannes@cmpxchg.org, roman.gushchin@linux.dev, dave@stgolabs.net,
	willy@infradead.org, liam.howlett@oracle.com,
	pasha.tatashin@soleen.com, souravpanda@google.com,
	keescook@chromium.org, dennis@kernel.org, yuzhao@google.com,
	vvvvvv@google.com, rostedt@goodmis.org, iamjoonsoo.kim@lge.com,
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 5/5] alloc_tag: config to store page allocation tag
 refs in page flags
Message-ID: <ZxZ_99yLDhRMNr3p@tiehlicka>
References: <ZxKWBfQ_Lps93fY1@tiehlicka>
 <CAJuCfpHa9qjugR+a3cs6Cud4PUcPWdvc+OgKTJ1qnryyJ9+WXA@mail.gmail.com>
 <CAJuCfpHFmmZhSrWo0iWST9+DGbwJZYdZx7zjHSHJLs_QY-7UbA@mail.gmail.com>
 <ZxYCK0jZVmKSksA4@tiehlicka>
 <62a7eb3f-fb27-43f4-8365-0fa0456c2f01@redhat.com>
 <CAJuCfpE_aSyjokF=xuwXvq9-jpjDfC+OH0etspK=G6PS7SvMFg@mail.gmail.com>
 <ZxZ0eh95AfFcQSFV@tiehlicka>
 <CAJuCfpGHKHJ_6xN4Ur4pjLgwTQ2QLkbWuAOhQQPinXNQVONxEA@mail.gmail.com>
 <ZxZ52Kcd8pskQ-Jd@tiehlicka>
 <CAJuCfpFr2CAKvfyTCY2tkVHWG1kb4N2jhNe5=2nFWH0HhoU+yg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpFr2CAKvfyTCY2tkVHWG1kb4N2jhNe5=2nFWH0HhoU+yg@mail.gmail.com>

On Mon 21-10-24 09:16:14, Suren Baghdasaryan wrote:
> On Mon, Oct 21, 2024 at 8:57 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Mon 21-10-24 08:41:00, Suren Baghdasaryan wrote:
> > > On Mon, Oct 21, 2024 at 8:34 AM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Mon 21-10-24 08:05:16, Suren Baghdasaryan wrote:
> > > > [...]
> > > > > Yeah, I thought about adding new values to "mem_profiling" but it's a
> > > > > bit complicated. Today it's a tristate:
> > > > >
> > > > > mem_profiling=0|1|never
> > > > >
> > > > > 0/1 means we disable/enable memory profiling by default but the user
> > > > > can enable it at runtime using a sysctl. This means that we enable
> > > > > page_ext at boot even when it's set to 0.
> > > > > "never" means we do not enable page_ext, memory profiling is disabled
> > > > > and sysctl to enable it will not be exposed. Used when a distribution
> > > > > has CONFIG_MEM_ALLOC_PROFILING=y but the user does not use it and does
> > > > > not want to waste memory on enabling page_ext.
> > > > >
> > > > > I can add another option like "pgflags" but then it also needs to
> > > > > specify whether we should enable or disable profiling by default
> > > > > (similar to 0|1 for page_ext mode). IOW we will need to encode also
> > > > > the default state we want. Something like this:
> > > > >
> > > > > mem_profiling=0|1|never|pgflags_on|pgflags_off
> > > > >
> > > > > Would this be acceptable?
> > > >
> > > > Isn't this overcomplicating it? Why cannot you simply go with
> > > > mem_profiling={0|never|1}[,$YOUR_OPTIONS]
> > > >
> > > > While $YOUR_OPTIONS could be compress,fallback,ponies and it would apply
> > > > or just be ignored if that is not applicable.
> > >
> > > Oh, you mean having 2 parts in the parameter with supported options being:
> > >
> > > mem_profiling=never
> > > mem_profiling=0
> > > mem_profiling=1
> > > mem_profiling=0,pgflags
> > > mem_profiling=1,pgflags
> > >
> > > Did I understand correctly? If so then yes, this should work.
> >
> > yes. I would just not call it pgflags because that just doesn't really
> > tell what the option is to anybody but kernel developers. You could also
> > have an option to override the default (disable profiling) failure strategy.
> 
> Ok, how about "compressed" instead? Like this:
> 
> mem_profiling=0,compressed

Sounds good to me. And just to repeat, I do not really care about
specific name but let's just stay away from something as specific as
page flags because that is really not helping to understand the purpose
but rather the underlying mechanism which is not telling much to most
users outside of kernel developers.

-- 
Michal Hocko
SUSE Labs
