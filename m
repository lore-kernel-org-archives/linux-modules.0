Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E61B37B
	for <linux-modules@vger.kernel.org>; Sun, 18 Feb 2024 00:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708217060; cv=none; b=b3CvAcrt1IYmAL2YrtxKnr5lwa0MfHltj5950UVijHL9BR+tCU+FZbBWX0DCswbhgAI+Nt1NYL2Z9MfN5ClBdypmOv/Z69l+eHrj0f2f/ONkiNoj6ka56UoAOC2Yk6Kttjh7OppBvCH9gK6YjBXQ/HW8vUpXJsQQlf7UE2ejjXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708217060; c=relaxed/simple;
	bh=eObXZNCrhmMoAtoJx0M+KCXazEG8uiFRYjucowDmnr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FUdT4WnQ42Nqb3p2qSymItbUjxgGt3GOEuHgFBuuSK0SoW7ddS6B0q6EsXAw9v1QlbUDU9ug/toBu6WHJy4BUrMykoH30YIZGBp6eTBRTi1Wwfpged3Hgj/bMeo070KhGjoYKmPV6bYO8yT0hqiUMSv7aS2T8ct3HPwtS2ULXiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T/xwhoLJ; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T/xwhoLJ"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-60802b329c4so18457457b3.0
        for <linux-modules@vger.kernel.org>; Sat, 17 Feb 2024 16:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708217058; x=1708821858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFEGcM8EospHG4JmqyUXYLdSoH1Alzf1U0lPv6eqJTM=;
        b=T/xwhoLJPGVdk1V/HhrRgMZsfbN6nYRAHY5lwofz/l8q5zNjsBdJVXHBeS39CuSKox
         oqZe9CArJF37hHdFcyB5oiFH4ujlXu4RT29aK9L9rAZCvLrzgxNAndKlFHnw4Em75p+K
         eE/5z2hTbf2OGDYB0xQNRG48TSeSBUr/9TVi5eFpo8xxObEsGC6nEnrLNaYSUIa+x4oD
         Fe+W3UaU3cJXUBmqIgQ0Fq9wm5jDazohABpGuT1uZ2A6O+/4Atyt1q0Z3BBgfyWd05Uy
         yWqNIE2qrm1W/0DpZtWfEZFltW6lBPHP4XgwnjDduBKb5WSU3rF9Np+VyvH5zaXEZ//3
         viqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708217058; x=1708821858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cFEGcM8EospHG4JmqyUXYLdSoH1Alzf1U0lPv6eqJTM=;
        b=FwKnVKfQiMZOB+XjCt2xf0TNLpbmlu7jWzFZxC5WzvYA0EBczuniR3qS+vBtiQmhOy
         Ixagmu+Frl0f+lB9HKWJ/uH71iUvt2faO5eioyJvKXgXGoIyWkpThkS/jB6c3l9yBLqw
         x6/Tuz2RaGungft2lu6OWrCTxgJbjz29+yrqCpXPlFFq6fY9rvHHML9yrdRL0DFCX4Jn
         KBJj2p/5KI32FtulmkxHv6VBh/VfR8/YE6GsNUfpigt9rbbAOR/gFtDbLTr8eYYDRhf8
         QweOzuCQnziyfhIuUo7D3Sx+mV6j695mGUFjr5T4ZZ/33amzPW0m7zX0R8Qq43e+kWlq
         uemw==
X-Forwarded-Encrypted: i=1; AJvYcCVbpyQvT3JnbAYiCsdA3p12tzMkO121TiM/gL9PLoXr20pfJHcZrSVYf8vSEQXAjqpJ9BIfWlur/EEaC6UInsF0tuhXRznElw4Q3ftX1w==
X-Gm-Message-State: AOJu0YzLYeN4lzWuQcN8vK1LLDTuEFqK87WoPUxBTg0FFTYMBXbZgWL5
	Q62camsF7ZWMWywWt/X+7DfDvef8uJMUmKF04/oKKlSBDs/B+QQPSOiq5mL6pwGLcggGTzn6B9u
	9G8MZDZsDuzuRuGQTCuiF6s1F+PFXyZC8lcBl
X-Google-Smtp-Source: AGHT+IF0zbur3ZnS0QBbUiRVZnclSCZcw12C5kwuIUJh6ZOEbr9od3x9F9LKEta3pcFjU0rivXF1DW3eH5+/zL6adzk=
X-Received: by 2002:a81:914a:0:b0:604:f681:a1 with SMTP id i71-20020a81914a000000b00604f68100a1mr9152837ywg.16.1708217057719;
 Sat, 17 Feb 2024 16:44:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com> <20240212213922.783301-19-surenb@google.com>
 <2e26bdf7-a793-4386-bcc1-5b1c7a0405b3@suse.cz> <CAJuCfpGUH9DNEzfDrt5O0z8T2oAfsJ7-RTTN2CGUqwA+m3g6_w@mail.gmail.com>
In-Reply-To: <CAJuCfpGUH9DNEzfDrt5O0z8T2oAfsJ7-RTTN2CGUqwA+m3g6_w@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 18 Feb 2024 00:44:05 +0000
Message-ID: <CAJuCfpFvSOtz7DaYdv=FXRvTvoRbMziXctFXqSpP_u97uNsFSQ@mail.gmail.com>
Subject: Re: [PATCH v3 18/35] mm: create new codetag references during page splitting
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 4:46=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Fri, Feb 16, 2024 at 6:33=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> =
wrote:
> >
> > On 2/12/24 22:39, Suren Baghdasaryan wrote:
> > > When a high-order page is split into smaller ones, each newly split
> > > page should get its codetag. The original codetag is reused for these
> > > pages but it's recorded as 0-byte allocation because original codetag
> > > already accounts for the original high-order allocated page.
> >
> > Wouldn't it be possible to adjust the original's accounted size and
> > redistribute to the split pages for more accuracy?
>
> I can't recall why I didn't do it that way but I'll try to change and
> see if something non-obvious comes up. Thanks!

Ok, now I recall what's happening here. alloc_tag_add() effectively
does two things:
1. it sets reference to point to the tag (ref->ct =3D &tag->ct)
2. it increments tag->counters

In pgalloc_tag_split() by calling
alloc_tag_add(codetag_ref_from_page_ext(page_ext), tag, 0); we
effectively set the reference from new page_ext to point to the
original tag but we keep the tag->counters->bytes counter the same
(incrementing by 0). It still increments tag->counters->calls but I
think we need that because when freeing individual split pages we will
be decrementing this counter for each individual page. We allocated
many pages with one call, then split into smaller pages and will be
freeing them with multiple calls. We need to balance out the call
counter during the split.

I can refactor the part of alloc_tag_add() that sets the reference
into a separate alloc_tag_ref_set() and make it set the reference and
increments tag->counters->calls (with a comment explaining why we need
this increment here). Then I can call alloc_tag_ref_set() from inside
alloc_tag_add() and when splitting  pages. I think that will be a bit
more clear.

>
> >
