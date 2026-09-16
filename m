Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FE1598BF9
	for <linux-modules@vger.kernel.org>; Wed, 16 Sep 2026 16:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789576340; cv=pass; b=ld/9PKGad5Vae6rNhl3neQdQTZ+HkukcVgzDuoQvtIKUGRhxdNXf+AkgRnezUjJ3/UtDhNQ+gmqActWTGX4zVDWMes+d2QDpx7UPETKsUefhiSG1k2BApO0zvtkEFE7t8IRpQQq3DfkpdT5efUxX8FTrHQkFPiBM/429R7p+B6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789576340; c=relaxed/simple;
	bh=jzI0/3psf3wVtPf9Shhf21d5CPCoSmdvQs1bzsuLWKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ANME4zg5XbY/pgLIFSdDSxR59oDdSGX8B7ByIhQS1em4JQcHk6lUROxbI0lFkDk7LppeTCY8EVpX3AcmynecmFU0pwB8iSp53EUCadxmaxsgt/dwn0aCBDVDivxydD8D8vnbu+dzCSXRr+CzZiAWtWYrBeDqaZybMAXKx2mEm70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mZrociJ5; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mZrociJ5"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-53012819c04so296221cf.0
        for <linux-modules@vger.kernel.org>; Wed, 16 Sep 2026 09:32:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789576331; cv=none;
        d=google.com; s=arc-20260327;
        b=UuB4gA7lSr5Dhs8DPXoxr9iU4m4V1QBpohXAh7yVAsX9DMP4mV2Onz7iG2OPanekNs
         Jg/AJSaJRqFKaFgq0SUYqg7uggJT0WbKy95ffLy41e334bzxrgJ+SSB46Z6PjZxeDFcw
         4teu1HGRYRxUe+Mpk0YJb5NylO7D5ioRrk+9HrRGxibD/IAVylXQhltQYNfqYRbULgWp
         OXDxcNykD3NVoqfJZ8QNnLKz84dddQIMoA8rfiXtKVwyfHuiTv31zmDKMYWldQ0XrsCv
         Yi7Ui6U3Rcp69IeTU9YrObVOKwperH6FL8qWjS57/ST4jas4YPaSH4BiPREgNADljPck
         0mSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tUDhjbftqgjAL9HivD9mk/nQ9a+7BLYF9Ygx6CAW0uc=;
        fh=+YyC/2hdMjtM7D+0izc47dcPB8FRs2xjLokYtEUlL+M=;
        b=C4wKjD6VHERiLlUBgQrBubStpc+OG1Za8kfFqIzHLeTzQpO+o5R1QqZYiQpdNfcVu1
         aRL54mF0juq2sTrrvcPG6z+4d8Nx+XtV360Na6rlkiNuCu1wpjEsVNSOXQdht73gPI6H
         y0jdGgJ0koe6OytqH/50Uwkagt/c2faWpzTkXv7ZuZ9Hoiwj8Aje/6j7jrZrmc9Bq0+s
         HkqHUpjSHN1bcLOQnINwXUwnVl44aEOYpzmbJxSbFUM+C+ljhki+O6/yL+vT/MbHQ/2f
         82VG9mTAPONFM3HnZZ3hGRQyZrQHX2aWZ6dJB5v9MvH84C4eb0e+1/R9huN3kqkqDM6d
         AxTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789576331; x=1790181131; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tUDhjbftqgjAL9HivD9mk/nQ9a+7BLYF9Ygx6CAW0uc=;
        b=mZrociJ5yOgIJGyleAhdomFHPF1EsxO1gF3/88LipOCvVhQ5ujBvKVaa3NIjp6Q13e
         Le+8wWTvC4OSAtZH01ZXnU0hl8929uHy9HJZCWgFrbiucbIhCMmJSQ22golOh0AbSagt
         382UDRE+53EKdYIUdFr4RvjNirtOA1n9uxDcfwu9YAlW3eHcPo1xiu/FxZIXQvsh8rYb
         qsVukY8i02hZTP9uHDnlsHqn/A6gllUbYT0p7BPQbhiJkzcmUsDCIs3CtWGXEwAnAvDm
         oytwPTig9wYsfDe2Ger9yx7slATE5QwP1kTJEcWPrIdi/Aj7yfIIHj3UsfqLWnOU9Pnq
         8BiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789576331; x=1790181131;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tUDhjbftqgjAL9HivD9mk/nQ9a+7BLYF9Ygx6CAW0uc=;
        b=kJZrZLziZ14NJHGeRz63NcvV+3ahd4yy+YAoJAYzPF4gwki7VSo2EHAKmqGA1fVv34
         +iNR4v5GJiOiDA5/oK0Q6iE7meMwbecwQlF6B+AxiLIrQ5wIuZCB9EOTObQ4ST+sUpBJ
         2qH2NQx52ZqK7FIfYWYGRot4h505caLATYlykU+5TLMjErN/hRM+frhfdCdMPRu+0oEy
         PUQiXhz5XTzkuREPlgdmp0iSQGVfFt3q/KHULH8m7nXMqUildTiOwjrwEbYsjP8kHsGW
         rIhGIvc+5zmnOjPNOh9lPjrhoiex7VcQK7E2deMvxJHPiwrb0BI1zplWy3hib2wh4/OY
         oE1A==
X-Forwarded-Encrypted: i=1; AKwUvBzJkOnZi82jTHu8Jan5IHFSbRT9JihWFNewIMqQUrm02e13vnuwKLgWG4NfOesNnR8FhxKAuwStUkBjEcNL@vger.kernel.org
X-Gm-Message-State: AFuF++nU99coBFGK6dtl9PKCcrSIa2PK4yK50lM3t4RWGekEwIMgOWwu
	z2CsbwcJdz1L0sSKuPFwC4QQA05FZf2osXrCP1piYaoCklnRYCmlA9ICEoYwFu2XRCLsKf8yCrG
	BbsLdiGSPD4bIruC+Qf8wlj7+027S16knmNxl8Nhw
X-Gm-Gg: AYBFou3ebB+12GjRcBQ5MjQ2pU/Z1JhPc+W3K2nmhnHEhsbrHPUBYXx8CTM4w7lW3X+
	PRD4vdZ40TT2jZSlrfHio/6ztP9aAjKe/JBIjVj8xgUS+QvjD/BDDxRHgclKijY8bJZhZT0p36S
	o/CjRFiLHmntsPMMUXt766BLLT/sO4MVU7DcvYDqZ5F3wIeXoMNPpj2u8DKi+6ZpFEf+nd77Az2
	FA6knzdQ1oIB/pf82z3xuEJ22sLEU1JUXGmW5MPI3RaEEk8Ssl/YYIJMWCS2wOh5wWnw7EiPUiu
	mqmDkRl0KVYqqvSWeRUvho2UPfC/VX1mgEYVdlPI9fLcZLe0dXluwwg3II5zW0mQOh94ExTYfW7
	IYtFO8t57Sg==
X-Received: by 2002:ac8:594d:0:b0:530:e00f:7768 with SMTP id
 d75a77b69052e-5327eb6f730mr14653271cf.0.1789576329678; Wed, 16 Sep 2026
 09:32:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915070001.113559-1-hao.ge@linux.dev> <20260915070001.113559-3-hao.ge@linux.dev>
 <CAJuCfpHJSwNhgotMVpmjVvdv=m52_7Kvzpztf0WcN0AaoSeGGw@mail.gmail.com> <60642a7f-2949-428a-8290-40d69c989a77@linux.dev>
In-Reply-To: <60642a7f-2949-428a-8290-40d69c989a77@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 16 Sep 2026 09:31:57 -0700
X-Gm-Features: AcwNN1Ui51wqsB_O4pl6c8tWHX6Ce9XwML9-1bQ7rL4qQiN8F18j46JxhZ3BkmQ
Message-ID: <CAJuCfpG3d7n=z5WnUQYZsqvrt1pemF8TFvGiGyZGLO7ykVvqAQ@mail.gmail.com>
Subject: Re: [PATCH v10 2/6] alloc_tag: clean up the populate failure path
To: Hao Ge <hao.ge@linux.dev>, "David Hildenbrand (Red Hat)" <david@kernel.org>, 
	"Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-modules@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 11:00=E2=80=AFPM Hao Ge <hao.ge@linux.dev> wrote:
>
> Hi Suren
>
> Thanks for you review.
>
> On 2026/9/16 05:09, Suren Baghdasaryan wrote:
> > On Mon, Sep 14, 2026 at 11:59=E2=80=AFPM Hao Ge <hao.ge@linux.dev> wrot=
e:
> >>
> >> The reservation is already stored in the maple tree when
> >> vm_module_tags_populate() fails. A failed load never unloads the
> >> module, so nothing releases the entry. Release it and roll
> >> module_tags.size back. Without the rollback a concurrent load that
> >> already passed needs_section_mem() can reuse the freed gap, skip
> >> vm_module_tags_populate() and write to unmapped memory.
> >>
> >> vmap_pages_range() may have installed some PTEs before failing. A
> >> retry to populate the same range would BUG on them, so undo them,
> >> but only if vmap actually ran.
> >>
> >> Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compr=
ession")
> >> Fixes: 0f9b685626da ("alloc_tag: populate memory for module tags as ne=
eded")
> >
> > If a patch fixes two other patches, it likely needs to be split so
> > that each part fixes one patch only. But read on please. I'm not sure
> > if one of the fixes is correct.
> >
>
> Kept them in one patch because they only make sense together.
>
> After a failed populate the reservation is released and the
> size rolled back, so the next load takes the same gap and calls
> vm_module_tags_populate() again, and that retry would trip over
> the PTEs the failed vmap left behind.
>
> Without the rollback a load that already passed needs_section_mem()
> just reuses the gap, skips populate and writes to unmapped memory.
> So splitting them leaves each half broken.

Yeah, that's why I think vmap_pages_range() cleanup should be a
completely separate patch with vmap_pages_range() doing cleanup
itself.

>
> >> Reported-by: Sashiko <sashiko-bot@kernel.org>
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> >> ---
> >>  mm/alloc_tag.c | 10 ++++++++++
> >>  1 file changed, 10 insertions(+)
> >>
> >> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
> >> index 2070e682fe10..95ddf5b743d0 100644
> >> --- a/mm/alloc_tag.c
> >> +++ b/mm/alloc_tag.c
> >> @@ -804,6 +804,13 @@ static int vm_module_tags_populate(void)
> >>                                      next_page, PAGE_SHIFT) < 0) {
> >>                         release_pages_arg arg =3D { .pages =3D next_pa=
ge };
> >>
> >> +                       /*
> >> +                        * vmap_pages_range() only runs once all pages=
 were
> >> +                        * allocated, and it may have installed some m=
appings
> >> +                        * before failing. Undo them.
> >
> > If vmap_pages_range() failed to map the range, why should we need to
> > undo it? If it indeed leaves some partial mapping when failing then I
> > would argue that vmap_pages_range() should be undoing these partial
> > mappings itself before returning the error.
> >
> Yeah it does - none of the paths under vmap_pages_range() undo themselves=
 on error.

Hmm. I wonder if this behavior is intentional or requires a fix. The
only possible reason I can think of is performance but I can't imagine
a failure to map is a performance-critical case.

+David Hildenbrand (Red Hat), +Lorenzo Stoakes (Oracle) what do you
guys think? Shouldn't vmap_pages_range() undo its possible partial
mapping when it fails?


> pcpu_map_pages does perform cleanup on its own as well. There may be othe=
r similar sites.
> https://elixir.bootlin.com/linux/v7.3-rc3/source/mm/percpu-vm.c#L255
> so I did the same here.
>
> If we really want vmap_pages_range() to handle this cleanup internally, I=
 believe that would
> be a relatively large change, and we would need to consider many more cas=
es. So I think we keep
> the current behaviour for now.

Yeah, I understand it would require a deeper cut but if that's the
right way to handle this we might as well do that. Let's see what MM
folks think.

>
> Thanks
> Best Regards
> Hao
>
> >> +                        */
> >> +                       if (nr =3D=3D more_pages)
> >> +                               vunmap_range(phys_end, phys_end + (nr =
<< PAGE_SHIFT));
> >>                         /* Clean up and error out */
> >>                         release_pages(arg, nr);
> >>                         return -ENOMEM;
> >> @@ -947,6 +954,7 @@ static void *reserve_module_tags(struct module *mo=
d, unsigned long size,
> >>                 return ret;
> >>
> >>         if (module_tags.size < offset + size) {
> >> +               unsigned long prev_size =3D module_tags.size;
> >>                 int grow_res;
> >>
> >>                 module_tags.size =3D offset + size;
> >> @@ -961,6 +969,8 @@ static void *reserve_module_tags(struct module *mo=
d, unsigned long size,
> >>                         shutdown_mem_profiling(true);
> >>                         pr_err("Failed to allocate memory for allocati=
on tags in the module %s. Memory allocation profiling is disabled!\n",
> >>                                mod->name);
> >> +                       release_module_tags(mod, false);
> >> +                       module_tags.size =3D prev_size;
> >
> > Yes, this one is a valid fix. It fixes 0f9b685626da commit.
> >
> >>                         return ERR_PTR(grow_res);
> >>                 }
> >>         }
> >> --
> >> 2.25.1
> >>
