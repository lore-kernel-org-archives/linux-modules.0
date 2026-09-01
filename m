Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFF14921A1
	for <linux-modules@vger.kernel.org>; Tue,  1 Sep 2026 18:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788287822; cv=pass; b=nhmzTYDUF9PXp9Dxz59nPP6GJY/UiGAm2N7Cf2ZoEB8n48kcKGTq1j31KftLU9OWSJtMZHKLZo0CoX1mmAWJZYG1MmO56aNkGbTS10pTv/kd7X78uxU/YJMTJLneogB/Zd6Gwn+nLJL9Fr/du6WU/2oi6x5Nz1ZolVfMBhvc2Qk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788287822; c=relaxed/simple;
	bh=i7l3f/T9kKF5TN4Wa1LIlLBpN3SB+N4kLu22MC4+OoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lOcuSgUS6gpUZx0LjT9V2tTpljPRtMtJ+l/u+0u2dFqayvT5z1wkNw3SAQh6lz2q+5DD9+pzxxUg7vfZo1zfie4feLiJHuH7ILXZlndvkhlhZWxMDUH7OOB66bwodrs5cUJRfDLVqIY+jzZbmBcQys3xXGYtkicK2RH0HUnFEOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ahYFmD3x; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ahYFmD3x"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51c01c79467so57281cf.0
        for <linux-modules@vger.kernel.org>; Tue, 01 Sep 2026 11:37:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788287819; cv=none;
        d=google.com; s=arc-20260327;
        b=lQKtRjTczAFiix3oSBPLkXaarMUu3S0idrRxXsBB1mPhjYQJpPvsw2S8UKE4M2GC/9
         aPiXa2Y1aZLJvEi66+ZIBGb8G9rZUluhpkKyEZuaqOd2WrDy6ICDYI7yZPK4zcosbJJA
         oabLR/JqafqiolGeOgLLxlMHXjLvVKKQ2NL3vNldwvQBDrVMqlYL9OZUxueTOvHdrnnI
         /IXTdRChMYWksXXooUJKXud54GDjDLH8LAzPU704OG4njur4qpOFG/aTTrbYLcPheHCd
         +NuikzQ63SYFrvSC8HqNp8sNpLb/P1MOxW3Ji11z6/bAwm09I5L4CMwx9vV+42MtF1xH
         K6Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=deSloNnROwXtYwAsI/oPSWN8BS0rUlZqZlnebW2ETcc=;
        fh=/CyXpTreCMrs2md8DeRyjxUw/XzC5zG59bwYWHUdolo=;
        b=eajFIFWc6/jRGz2OfXZ3KgYZKY2eTBVQ/Vf+UG82LwrZe8rymwLquWeXHlduRaXjvm
         3yYuiBcfDjftS3Yl5s6R3luboTcUzU7lXTYbFjfrpC2H3ZWSfOGSPFWjfYs4ZmuXx/iC
         Y0siCPv8Yjg5JWKFAy9DjRKB4vGbq5jh/oTnFgKJ2v4htav7oVmORJ81/3t1hyAr0wkJ
         y7QZFe180bTZXu5J5HG+1ib79fKBKjV6wOo2eFAUUX+p13oQqfyq4rLgaK7u5+3kzazE
         IIkL2JTV9b7kXxE7oQnrj5Jo1OSezOyDmfB7d3pB5AqtFXLojbrdOxRacOBuMPuB/RFo
         +smA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788287819; x=1788892619; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=deSloNnROwXtYwAsI/oPSWN8BS0rUlZqZlnebW2ETcc=;
        b=ahYFmD3xble2mWEyqbcVOtJ6gwbyKcI2zvpInilhUNTDPpw1qnc3UBtNyYK1OvZHOD
         e+0kdKpq//C10O/3QW8dy07Wtmwi4HifP+rhZqq7SCR8F/ZbMd4u2xRGvDV5Pu1LfFP1
         OLxrNX2HjMdGpqHdk0OUT1TBbEibPpGJLF6hZzabRyqdic6AAMyXzF9Bf9GmHsqyM9vO
         ygCQWbvbpy1S9ZGGisUFCdtefft4eJIVk2lS4tLDDoy6XG3db7bufLHpSdFVh7AGuUKj
         8YEYCQf37zY5UFmu4ET7M8s27OJZf7HHDI2dcjmfMNwcs8173uXUpPzVobWYGrbCqV7X
         gJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788287819; x=1788892619;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=deSloNnROwXtYwAsI/oPSWN8BS0rUlZqZlnebW2ETcc=;
        b=dXfBgkVnQoaTcSrY/dz9My2ELqAfRbk/lhOvePhnArpl9UtDAJQqg73qJCKHOpCOiT
         ODt/QktIkZro6B/HWIsqdjHnXoR6EyvF8lScUGMBSlqAXZeYhTUm2EHkyPsJ2yGghsFj
         rZ5vhutoMnaj/uDv8sI6ss2/QsdCwfCywj24ebIj2UfP08X4MAIMy6Kw8gdXbIKsHCO6
         hC+x2x3PYUlPx8MXJfCWF3e9v4ZuiPhjkzBVMoN15ZUZ2WmqSIhYFa4ErzKjIAEzQGQ2
         AnDHXOUaRNunaOLgInoTIpEErteZSkQiRbeRkYxDJ3YYDOzl1q1dbZyZasZj8IwOSZZP
         Sruw==
X-Forwarded-Encrypted: i=1; AHgh+RoRYS8EoCZECVnJvh0qHgetPKsfHMqOYeIw/aOm6ru5m60GyS9TeSEluU+EtYGFy7QmRupTMvSsfbKWSMWC@vger.kernel.org
X-Gm-Message-State: AFuF++n16LVJ7GWv1bFnbTx2F2ywyXlFnplwrT9LVa0qLm7rB+uru1/K
	xwXs82uUwYRXY6cxmfA3ZOWkK3q2fD8cwgzzVFCbn7jwQ1epFW1GxeIOnHngirnpcaD93s+Kuc9
	EiBbVO1CrB5RIRZiQw2fbuucB5f9qckk7Bgq9Tf/5
X-Gm-Gg: AR+sD12/FRM3K6UUyidQMTHmKSJsrBYd75iw619daQmeGwgsloMyJWIKfIlWt/5xnVC
	V+hExd7X9b7SzeXuj3gBlNnZjrZfi07QGaBxOlFiw1ScZ0E5Jl36u1/+KcTcx0aPrJYh71fixRC
	J6jRCyezljnmcnZA/l8IMTsBcjqi4ZsfbTqYq7g7zso96HoWLIvHCd1OP//ekq8whsOZqhyXrRM
	aY4Ib4RZ2bMFcSzuhni7ql5x8T92rov8Pgt2ZdPrfpATroXuIFIQXZZAVlP0S2HoI60nPIRPbVW
	K5CQ4kH4xEHtQgZk/s7oSF7mtqAg1pHztLgtdrrvmjmu5IGYxxtYnsAZuW+h7IkT7fjYfS216MU
	=
X-Received: by 2002:a05:622a:4d08:b0:51c:ad5:93be with SMTP id
 d75a77b69052e-53033af32b6mr1814531cf.8.1788287818532; Tue, 01 Sep 2026
 11:36:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831072104.120197-1-hao.ge@linux.dev> <20260831072104.120197-3-hao.ge@linux.dev>
 <37eb07db-332c-4da1-a671-6ef1cb753cb3@suse.com>
In-Reply-To: <37eb07db-332c-4da1-a671-6ef1cb753cb3@suse.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 1 Sep 2026 11:36:46 -0700
X-Gm-Features: AcwNN1WbKynZXiNJyf1x2DIabxhn9qVzOBQ2684ipzpY8wSQGNsJHC44kdS54cE
Message-ID: <CAJuCfpHdevUVms+WPHXET0M912hxRo_+QiV2zh2+O5ZCNTy+mA@mail.gmail.com>
Subject: Re: [RFC PATCH v6 2/2] module: allocate codetag sections before the
 regular module layout
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Hao Ge <hao.ge@linux.dev>, Luis Chamberlain <mcgrof@kernel.org>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 8:04=E2=80=AFAM Petr Pavlu <petr.pavlu@suse.com> wro=
te:
>
> On 8/31/26 9:21 AM, Hao Ge wrote:
> > Whether a codetag section goes to the codetag region is decided by
> > layout_sections() and asked again in move_module(). A concurrent
> > load can shut profiling down in between, and move_module() then
> > copies the section to offset 0 of its regular destination,
> > overwriting whatever is there.
> >
> > Decide and allocate in one pass, before the layout. Allocation
> > errors fail the load. On a tag area overflow profiling is already
> > disabled, so -EAGAIN makes the section fall back to regular module
> > data and the module still loads.
> >
> > The overflow and populate failure paths of reserve_module_tags() now
> > release their reservation instead of leaking the maple tree entry.
> > When profiling was toggled off, the overflow check did not run, a
> > module could load with more tags than the page flags can address,
> > and re-enabling profiling then silently corrupted /proc/allocinfo.
> > The check no longer depends on mem_alloc_profiling_enabled().
> >
> > Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compre=
ssion")
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Based-on-a-patch-by: Petr Pavlu <petr.pavlu@suse.com>
> > Cc: Suren Baghdasaryan <surenb@google.com>
> > Signed-off-by: Hao Ge <hao.ge@linux.dev>
> > ---
> > Changes against Petr's prototype:
> > - allocate_codetag_sections() returns an error instead of void, and
> >   only -EAGAIN falls back to a regular section. Any other error now
> >   fails the load. The prototype fell back on everything, which can
> >   leave live tags in module memory.
> > - reserve_module_tags() releases its reservation when populate fails
> >   too, that path used to leak the maple tree entry.
> > - codetag_free_module_sections() on the move_module() error path uses
> >   info->mod, the local mod is assigned only after a successful move.
> > - The percpu section is marked only when index.pcpu !=3D 0, otherwise
> >   sechdrs[0] gets marked.
> > - Dropped the SHF_ALLOC check, .codetag.* sections always have it.
> > ---
> >  include/linux/module.h   |   2 +
> >  kernel/module/internal.h |   4 ++
> >  kernel/module/main.c     | 120 ++++++++++++++++++++-------------------
> >  mm/alloc_tag.c           |   9 ++-
> >  4 files changed, 75 insertions(+), 60 deletions(-)
> >
> > diff --git a/include/linux/module.h b/include/linux/module.h
> > index 7566815fabbe..33548daa31a3 100644
> > --- a/include/linux/module.h
> > +++ b/include/linux/module.h
> > @@ -325,6 +325,8 @@ enum mod_mem_type {
> >       MOD_INIT_RODATA,
> >
> >       MOD_MEM_NUM_TYPES,
> > +
> > +     MOD_STANDALONE =3D -2,
> >       MOD_INVALID =3D -1,
> >  };
> >
>
> It might be better to split this patch into two: the first to introduce
> MOD_STANDALONE and use it only for the percpu section, and the second
> with all the codetag-related changes.
>
> The introduction of SH_ENTSIZE_STANDALONE should also allow us to clean
> up the current resetting of SHF_ALLOC for the percpu section, and now
> also for codetag sections. The problem is that find_sec(".data..percpu")
> can currently return different results depending on whether it is called
> before layout_and_allocate() or later. In addition, apply_relocations()
> needs a special case for SH_ENTSIZE_STANDALONE, where it could otherwise
> just test SHF_ALLOC.
>
> Instead of resetting SHF_ALLOC for percpu/codetag sections, both
> __layout_sections() and move_module() can check for
> SH_ENTSIZE_STANDALONE to determine whether a section is handled
> specially and should be skipped.
>
> I think it would be useful to include this change in the first patch
> introducing MOD_STANDALONE, but I'm also ok with the current version.
> I can send a separate patch later to make more use of
> SH_ENTSIZE_STANDALONE in this way.

I ran some tests on my side and nothing blew up.

Petr's suggestion to split the patch sounds good to me and
release_module_tags() change in alloc_tag.c could also be done in a
separate patch. It's the cleanup after we do shutdown_mem_profiling(),
so I think it would be correct on its own.
Thanks,
Suren.

>
> > @@ -2966,18 +2967,23 @@ static struct module *layout_and_allocate(struc=
t load_info *info, int flags)
> >        */
> >       module_mark_ro_after_init(info->hdr, info->sechdrs, info->secstri=
ngs);
> >
> > -     /*
> > -      * Determine total sizes, and put offsets in sh_entsize.  For now
> > -      * this is done generically; there doesn't appear to be any
> > -      * special cases for the architectures.
> > -      */
> > +     /* Allow codetag sections to be allocated separately first. */
> > +     err =3D allocate_codetag_sections(info);
> > +     if (err) {
> > +             codetag_free_module_sections(info->mod);
>
> The usual convention is that functions clean up after themselves on
> error. That means this codetag_free_module_sections() call should be
> done ideally by allocate_codetag_sections().
>
> --
> Thanks,
> Petr
