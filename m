Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C767942061
	for <linux-modules@vger.kernel.org>; Mon, 19 Feb 2024 16:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708361739; cv=none; b=cscfeo2V6xb4owTiM7gusYcVfQF6Mpe0YjUOHuxe0SgFclCGy2CsJwHl0NMhYdR7GuyHhlmG3eMEaaYOyRKD6t6tox5C4hvKSLuTCWUlz76Y/C3RinyPmXZMKEnvKbAKeDyAl3At7G9JL8Lo+7Jv1yrC1d15lJeS72uUPAvZ6+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708361739; c=relaxed/simple;
	bh=L2Wk+KfPMqWFy+4dwx61nIYX1yKhjaAyyhWHKrdqFeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rZNvWpEVnQ1bu5OgD7Lnr9JSrH8s9QSvjYTxfEwPpK55UUkYOJTP+12NhxwpOE1/jmzjp7qg7Qe1QOTfIGrL3WdtHmx3oC6rnmG4bhj7Rev5nmAvLs1qUnYDQydOXpSU7YErQ02PzOOQu81sVoyWubr8OYkxoOd31HyszOOsSEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MkZ/IxZ4; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MkZ/IxZ4"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dc74e33fe1bso4210704276.0
        for <linux-modules@vger.kernel.org>; Mon, 19 Feb 2024 08:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708361736; x=1708966536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MC1JxayV7V5FEwBjiEEHat04AtMi8UdAlknxmmQHPbY=;
        b=MkZ/IxZ4QGXfI4ZTy9QDCdF6dyp0wZD+oD0HD8XIChpTjEQYwWiVrhhdipzC9NyIoX
         wLHW5WsTCcZTnzLVnhOYOz3zmUpOSnmKSJYLgsyjrRwWTGVpsApwlptLts+qEn4Qk0Un
         /dW/ZG24LaZivpClFG7/ubvZNAzi5kJ580ayfAjWOzSsccD70WRH6FVh2D9d+2PH2YOc
         MSc7F68O3oyldG67kbMOC+F6XuYzndFaavEgloTQqjeveKnHJse9DTh2pD9aMrYwTEK6
         zlGzqZLMGn+1gmyVal04viaSjc+d0e5VrUXYKev2lgQbl5RMAAxRBv/mbKeatIQWWwjz
         /QCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708361736; x=1708966536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MC1JxayV7V5FEwBjiEEHat04AtMi8UdAlknxmmQHPbY=;
        b=tiD3ML26H4CIi0qr0d1KW9uGDs79XIiXQBreTWxdu4OQ4M0uGilT38Q/oDXyaHxbLY
         frjU6UKxLE4csdcFuy0uuLvVKm3n62P7FdzJNzAF8a+GaXulxvkEP/jjO0Q13w9Hgupe
         43wSBnBptOwF7LdoyrDiIJTifzWbR3cm7a8YkowUG8ByVAv//vfXQhXzIb06w99vLcs1
         6K9M0xyiRGKNp2feHzeIBs3ZaIHzc5o3R/8j1DSt2fT/vK9ide4mj/rlDrJNprsHkAPN
         ivvPc0N4OG+liZwPfUNj1bXv6DDB5/CK+wgO+Jy0B8KysP2YVRXH/X48X5H6mbJ100eb
         JiGw==
X-Forwarded-Encrypted: i=1; AJvYcCWrdw6xxKyQjy43mFi22fCjzR4X2CGohCGBJ29PoHxbssbIbrUw9Ux9lCF9B4e1iHQZ5B06s0v3la0/DS8RA5TASd3Gdmn5pvUUEvahxw==
X-Gm-Message-State: AOJu0YwyQjMNv5+/JjH1/oZCnDvyxopKrbD/DiOFjXVcEcD/rQ0A36J1
	4UZeEU8T3xcpiKtLudj09pySrhUMAxV4eEUOgtaTqzKEcKJ4XgxpS6iSraMgqw0Qpt6W6UB7Wcf
	s7TY4himOJM6wNW1Q6PhPBwlnBdgjzfI1LGA4
X-Google-Smtp-Source: AGHT+IE9e4H9CxOF/Wkt1BmMwgF6wG5QNpfKFX5SyoOVKH5zyjhHqyJSbZUQlTjCIfZiNsAQiQ1++39gCNndnejh6es=
X-Received: by 2002:a25:d68b:0:b0:dc6:aed5:718a with SMTP id
 n133-20020a25d68b000000b00dc6aed5718amr10952783ybg.26.1708361735183; Mon, 19
 Feb 2024 08:55:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com> <20240212213922.783301-33-surenb@google.com>
 <f0a56027-472d-44a6-aba5-912bd50ee3ae@suse.cz> <CAJuCfpGUTu7uhcR-23=0d3Wnn8ZbDtNwTaFnukd9qYYVHS9aSA@mail.gmail.com>
 <5bd3761f-217d-45bb-bcd2-797f82c8a44f@suse.cz>
In-Reply-To: <5bd3761f-217d-45bb-bcd2-797f82c8a44f@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 19 Feb 2024 08:55:22 -0800
Message-ID: <CAJuCfpHRqiV2LZEnCB0hwwoexw+8U_XzqH1f+LwLjsQxmXR3Tw@mail.gmail.com>
Subject: Re: [PATCH v3 32/35] codetag: debug: skip objext checking when it's
 for objext itself
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

On Mon, Feb 19, 2024 at 1:17=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 2/19/24 02:04, Suren Baghdasaryan wrote:
> > On Fri, Feb 16, 2024 at 6:39=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz=
> wrote:
> >>
> >> On 2/12/24 22:39, Suren Baghdasaryan wrote:
> >> > objext objects are created with __GFP_NO_OBJ_EXT flag and therefore =
have
> >> > no corresponding objext themselves (otherwise we would get an infini=
te
> >> > recursion). When freeing these objects their codetag will be empty a=
nd
> >> > when CONFIG_MEM_ALLOC_PROFILING_DEBUG is enabled this will lead to f=
alse
> >> > warnings. Introduce CODETAG_EMPTY special codetag value to mark
> >> > allocations which intentionally lack codetag to avoid these warnings=
.
> >> > Set objext codetags to CODETAG_EMPTY before freeing to indicate that
> >> > the codetag is expected to be empty.
> >> >
> >> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> >> > ---
> >> >  include/linux/alloc_tag.h | 26 ++++++++++++++++++++++++++
> >> >  mm/slab.h                 | 25 +++++++++++++++++++++++++
> >> >  mm/slab_common.c          |  1 +
> >> >  mm/slub.c                 |  8 ++++++++
> >> >  4 files changed, 60 insertions(+)
> >> >
> >> > diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
> >> > index 0a5973c4ad77..1f3207097b03 100644
> >>
> >> ...
> >>
> >> > index c4bd0d5348cb..cf332a839bf4 100644
> >> > --- a/mm/slab.h
> >> > +++ b/mm/slab.h
> >> > @@ -567,6 +567,31 @@ static inline struct slabobj_ext *slab_obj_exts=
(struct slab *slab)
> >> >  int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
> >> >                       gfp_t gfp, bool new_slab);
> >> >
> >> > +
> >> > +#ifdef CONFIG_MEM_ALLOC_PROFILING_DEBUG
> >> > +
> >> > +static inline void mark_objexts_empty(struct slabobj_ext *obj_exts)
> >> > +{
> >> > +     struct slabobj_ext *slab_exts;
> >> > +     struct slab *obj_exts_slab;
> >> > +
> >> > +     obj_exts_slab =3D virt_to_slab(obj_exts);
> >> > +     slab_exts =3D slab_obj_exts(obj_exts_slab);
> >> > +     if (slab_exts) {
> >> > +             unsigned int offs =3D obj_to_index(obj_exts_slab->slab=
_cache,
> >> > +                                              obj_exts_slab, obj_ex=
ts);
> >> > +             /* codetag should be NULL */
> >> > +             WARN_ON(slab_exts[offs].ref.ct);
> >> > +             set_codetag_empty(&slab_exts[offs].ref);
> >> > +     }
> >> > +}
> >> > +
> >> > +#else /* CONFIG_MEM_ALLOC_PROFILING_DEBUG */
> >> > +
> >> > +static inline void mark_objexts_empty(struct slabobj_ext *obj_exts)=
 {}
> >> > +
> >> > +#endif /* CONFIG_MEM_ALLOC_PROFILING_DEBUG */
> >> > +
> >>
> >> I assume with alloc_slab_obj_exts() moved to slub.c, mark_objexts_empt=
y()
> >> could move there too.
> >
> > No, I think mark_objexts_empty() belongs here. This patch introduced
> > the function and uses it. Makes sense to me to keep it all together.
>
> Hi,
>
> here I didn't mean moving between patches, but files. alloc_slab_obj_exts=
()
> in slub.c means all callers of mark_objexts_empty() are in slub.c so it
> doesn't need to be in slab.h

Ah, I see. I misunderstood your comment. Yes, after slab/slob cleanup
this makes sense.

>
> Also same thing with mark_failed_objexts_alloc() and
> handle_failed_objexts_alloc() in patch 34/35.

Ack. Thanks!

>
