Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90F84DEC2D
	for <linux-modules@vger.kernel.org>; Mon, 28 Sep 2026 15:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790608595; cv=pass; b=s1nRJsaGIScPY30xhb3C1MxFmhSL0HWSUftiWfYZdvPh6MsFEIF11Lq/973woTiW/IuMTORo2iNL8wMcfPsAzYD4SneQ9kVQNzF08dR/lc068z81YjJ/T5wjEWY+WeQJpyDAvVuCZCY6FmravCG0+H9m0Z/fdElxPkXl1PRSxhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790608595; c=relaxed/simple;
	bh=3DVe5BrR2l3G/O15T8bRjXmao3k/JWb+7PgpGY5xaYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eehbHQC1yE9zFCRLh9AzIIXyEkHJgwI10Eu1N0sUff+X2mCZ35MTuKvrIockPeOwuzddO5B/c5QPFXNPzFLQiQBDRQns+ShI5NmdoxNBjynxHSey1X7DjwsFF+g7N77zvNoOtkLVtGkoATEDR4CyArM2w6U+TkhpvBmL6Ipe+UU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tBLQHjie; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tBLQHjie"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-53328262efbso386971cf.0
        for <linux-modules@vger.kernel.org>; Mon, 28 Sep 2026 08:16:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790608591; cv=none;
        d=google.com; s=arc-20260327;
        b=h1FoBdFlj3JXgQ/flw7GcZsx37Uas9PbzkI9F12Fmt/BkWtb7KAO/sQCiSKBJh2Fdr
         aaJqvhv2oHY94hJgNXmaWkSzjHUNB2B5miBa38TLSTHkxptD3KY8WOkThQB/MZlOkGGi
         paI1tue35PXAAFzY3GgavrMLNufEfM2iXA21RrFinndYj5S7U6IG8MLWAosjVV7HM9Gj
         2tPJh2VWGoEoXsJRbtZnWSDf0FQGw59KqWW7zU7ThNKzb/HqFT1UxXmjj57nUCY6RWbg
         stW8lverI27c+GjN3UGP0HweuhQe9Iwgc1wDMEg3kHNv22LMN4lW1a8DKWPSKbnL8rZn
         1AgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZqIv1Sn/rDlr9SusC1OyVWgmKaxOZca4hJRLhV2M9zg=;
        fh=Ud6Meh1AucQFpZD3WAr5g3lRfb3jXrRPW0w/60YqLgY=;
        b=Kz7fjL+si5jzMxzY1MsVs62hLoSbIfPqB1jWvnqICKUN59y4EITy33Em7kyUpXfkBh
         52cl7W0aE883jkjMw8BgH16zWCR+uvx2xgdbWM5H4zFtPTjAEq9gCV9UiRqs+/HO+EyA
         sidXkOALR+IB4YsYABEV9r3ggg0BJ8pHH5jiO1/l5i4wqH4sKz64TTbKL7H0UtQFaNI1
         lIrVAzHNcwMcd46MbmpuL4sF1eUavzpTGJU2suvOTnwgqdBBg+cCFf15woe9HiLMVC/A
         MxCnqY5xbvcYJIYc3drARE8TIKErhCIHBnXonKii/MGLWF3l7JloNl3Eg8qv3PWd4a06
         wbMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790608591; x=1791213391; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZqIv1Sn/rDlr9SusC1OyVWgmKaxOZca4hJRLhV2M9zg=;
        b=tBLQHjietEVnODOvLl5x+1idzAZhvEe4jHgjXNPVLYEB9fNm2Cny6/wsH+9cwEPyfP
         uGrV6fcZIyKoX3Rc8MUgc647LRq1np+TMmAo6XcT0nEmaAoxmRwiHtonF0+k9qBufmdb
         zEDAHnO7Lcw5+Y2vOwuCOy5br8BosDnR85EYJY5p8yKC+KSjhpKA1siY0DbthwxfhroZ
         nu8TSd9nI144VfoFe8qDJAzDJGA/vSpkRV2PNH0wwaPa2YOjyPIq65QrrYrCEq3yHn7Z
         rMG4PP6Ekiw9mUUKGzzlDImRxUbFTUTFQxCUWqAoq6iDYQr1Qb35K6iIKndV4w5c6zJk
         PACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790608591; x=1791213391;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZqIv1Sn/rDlr9SusC1OyVWgmKaxOZca4hJRLhV2M9zg=;
        b=2rjvoUlK/sxeVo6oBcQziOllKSB3YCq0Jcz9Zq78CQMqm6blIjIXYbROyZpJPyveBy
         ntDgAoHx4udFlvV2veLVK2UvSDZdU6Uc5qVWCGH7RvPAK798Hz8t0ZH800YFJ08RJ0zG
         P4NlM+BBR46Eo7dWJzq8/YXdo+IrHZP2DNhZKAwKDDdtzehlvGE8xM9jFgf5sS1qxbpg
         qE7BH+v/h69B49wAhpl3dWVOPpurTTNqbar6Ghnme5QhLifQsJtk2Kp4uxDTNtOl+Osm
         x4cQDgwmDKefSOHrY+KycyzITkmC9RgzPLCK3zYS/gmIJkD3lFXk6vo0ReiW97TWBvP0
         GdWQ==
X-Forwarded-Encrypted: i=1; AKwUvBzJqfv0kooaNoY6qD+2VgO9LoCZpRZ4icyzQ0F6epauWQO1llia2f3lbbfL8kicGV1iAygV1g9bgcBUER0e@vger.kernel.org
X-Gm-Message-State: AFuF++nRYt7ZocuVzbs3ZfXmsJXVSrFt0TNBcRSItkLr3hunr1FwsWHu
	VuYFHkj14+3PPY+ulW301hmUNxnskeuJkAUv7uzyxSfTWIThCqx0Her/7TfOsrLWpAZo5IMk2ZA
	LMuYX8bvebUuX9oicw2S9wy1MTcR4k2/tn9inhl5W
X-Gm-Gg: AYBFou0qZ4nsPhjJI4ao7GQaz1NLvZwJtb2sVhewCQH6gDhugx2kaKsGRky4JbAqEfM
	hFSkTqXeEUxCOwXf71qEiSSvWKpz7jKtML9LmOMOVj2MjoVr2tza3AxPnxkDEArHpskMuQGwas9
	+TxGex0wSun4O9eoRAbSm0JxdLnx+Fr4Rj/m1ukGpcqhe/srE50FIChoQdOgDDlA4sw9cQNiiJR
	wMC3EhuYFnYhOP/KXJK1Fto9ddsh/9UQqv5jhztyVvXOQcbU+4r5mL2j7993ovjyQaGQA+4zFRM
	CuZiPam5FxE4rFws3CPwZ7AgGcPBBpRV4CNu3rDp/e0lk/yd8ZDmunU=
X-Received: by 2002:a05:622a:1a8f:b0:532:c8ca:5ae9 with SMTP id
 d75a77b69052e-533226f9f89mr30441681cf.11.1790608590801; Mon, 28 Sep 2026
 08:16:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915070001.113559-1-hao.ge@linux.dev> <20260915070001.113559-3-hao.ge@linux.dev>
 <CAJuCfpHJSwNhgotMVpmjVvdv=m52_7Kvzpztf0WcN0AaoSeGGw@mail.gmail.com>
 <60642a7f-2949-428a-8290-40d69c989a77@linux.dev> <CAJuCfpG3d7n=z5WnUQYZsqvrt1pemF8TFvGiGyZGLO7ykVvqAQ@mail.gmail.com>
 <CAJuCfpGeRdFY6UPF-vXxwHvP2+tN=BKgRkmLR3PMLuWhxgzPRA@mail.gmail.com>
 <1dff448c-9cbe-4276-bca1-d91283b0c7b4@linux.dev> <b8005c24-ecac-45c4-840a-fd282f9693b5@linux.dev>
 <arpK2bQrrUMvEvTP@milan> <arqDHnBFGKQZm7VU@milan>
In-Reply-To: <arqDHnBFGKQZm7VU@milan>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 28 Sep 2026 08:16:18 -0700
X-Gm-Features: AclHuK8H_rn91yL5MjXERW3wss1aaZb7EVDlHwDTppCbnSE6x5WvHEULyhM7Qvg
Message-ID: <CAJuCfpHuTzFBUm2uAbkFsKF85GxcqFATmKgT50AQgWkLjf7NMw@mail.gmail.com>
Subject: Re: [PATCH v10 2/6] alloc_tag: clean up the populate failure path
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Hao Ge <hao.ge@linux.dev>, "David Hildenbrand (Arm)" <david@kernel.org>, 
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-modules@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 8:09=E2=80=AFAM Uladzislau Rezki <urezki@gmail.com>=
 wrote:
>
> On Mon, Sep 28, 2026 at 01:09:13PM +0200, Uladzislau Rezki wrote:
> > On Thu, Sep 17, 2026 at 10:32:48AM +0800, Hao Ge wrote:
> > > Hi Suren=E3=80=81David=E3=80=81Lorenzo
> > >
> > > On 2026/9/17 09:12, Hao Ge wrote:
> > > > Hi Suren
> > > >
> > > > On 2026/9/17 03:07, Suren Baghdasaryan wrote:
> > > >> On Wed, Sep 16, 2026 at 9:31=E2=80=AFAM Suren Baghdasaryan <surenb=
@google.com> wrote:
> > > >>>
> > > >>> On Tue, Sep 15, 2026 at 11:00=E2=80=AFPM Hao Ge <hao.ge@linux.dev=
> wrote:
> > > >>>>
> > > >>>> Hi Suren
> > > >>>>
> > > >>>> Thanks for you review.
> > > >>>>
> > > >>>> On 2026/9/16 05:09, Suren Baghdasaryan wrote:
> > > >>>>> On Mon, Sep 14, 2026 at 11:59=E2=80=AFPM Hao Ge <hao.ge@linux.d=
ev> wrote:
> > > >>>>>>
> > > >>>>>> The reservation is already stored in the maple tree when
> > > >>>>>> vm_module_tags_populate() fails. A failed load never unloads t=
he
> > > >>>>>> module, so nothing releases the entry. Release it and roll
> > > >>>>>> module_tags.size back. Without the rollback a concurrent load =
that
> > > >>>>>> already passed needs_section_mem() can reuse the freed gap, sk=
ip
> > > >>>>>> vm_module_tags_populate() and write to unmapped memory.
> > > >>>>>>
> > > >>>>>> vmap_pages_range() may have installed some PTEs before failing=
. A
> > > >>>>>> retry to populate the same range would BUG on them, so undo th=
em,
> > > >>>>>> but only if vmap actually ran.
> > > >>>>>>
> > > >>>>>> Fixes: 4835f747d3ed ("alloc_tag: support for page allocation t=
ag compression")
> > > >>>>>> Fixes: 0f9b685626da ("alloc_tag: populate memory for module ta=
gs as needed")
> > > >>>>>
> > > >>>>> If a patch fixes two other patches, it likely needs to be split=
 so
> > > >>>>> that each part fixes one patch only. But read on please. I'm no=
t sure
> > > >>>>> if one of the fixes is correct.
> > > >>>>>
> > > >>>>
> > > >>>> Kept them in one patch because they only make sense together.
> > > >>>>
> > > >>>> After a failed populate the reservation is released and the
> > > >>>> size rolled back, so the next load takes the same gap and calls
> > > >>>> vm_module_tags_populate() again, and that retry would trip over
> > > >>>> the PTEs the failed vmap left behind.
> > > >>>>
> > > >>>> Without the rollback a load that already passed needs_section_me=
m()
> > > >>>> just reuses the gap, skips populate and writes to unmapped memor=
y.
> > > >>>> So splitting them leaves each half broken.
> > > >>>
> > > >>> Yeah, that's why I think vmap_pages_range() cleanup should be a
> > > >>> completely separate patch with vmap_pages_range() doing cleanup
> > > >>> itself.
> > > >>>
> > > >
> > > > I think I get where you're coming from now.
> > > > Thanks for taking the time to explain.
> > > >
> > > >>>>
> > > >>>>>> Reported-by: Sashiko <sashiko-bot@kernel.org>
> > > >>>>>> Cc: stable@vger.kernel.org
> > > >>>>>> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> > > >>>>>> ---
> > > >>>>>>  mm/alloc_tag.c | 10 ++++++++++
> > > >>>>>>  1 file changed, 10 insertions(+)
> > > >>>>>>
> > > >>>>>> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
> > > >>>>>> index 2070e682fe10..95ddf5b743d0 100644
> > > >>>>>> --- a/mm/alloc_tag.c
> > > >>>>>> +++ b/mm/alloc_tag.c
> > > >>>>>> @@ -804,6 +804,13 @@ static int vm_module_tags_populate(void)
> > > >>>>>>                                      next_page, PAGE_SHIFT) < =
0) {
> > > >>>>>>                         release_pages_arg arg =3D { .pages =3D=
 next_page };
> > > >>>>>>
> > > >>>>>> +                       /*
> > > >>>>>> +                        * vmap_pages_range() only runs once a=
ll pages were
> > > >>>>>> +                        * allocated, and it may have installe=
d some mappings
> > > >>>>>> +                        * before failing. Undo them.
> > > >>>>>
> > > >>>>> If vmap_pages_range() failed to map the range, why should we ne=
ed to
> > > >>>>> undo it? If it indeed leaves some partial mapping when failing =
then I
> > > >>>>> would argue that vmap_pages_range() should be undoing these par=
tial
> > > >>>>> mappings itself before returning the error.
> > > >>>>>
> > > >>>> Yeah it does - none of the paths under vmap_pages_range() undo t=
hemselves on error.
> > > >>>
> > > >>> Hmm. I wonder if this behavior is intentional or requires a fix. =
The
> > > >>> only possible reason I can think of is performance but I can't im=
agine
> > > >>> a failure to map is a performance-critical case.
> > > >>>
> > > >>> +David Hildenbrand (Red Hat), +Lorenzo Stoakes (Oracle) what do y=
ou
> > > >>
> > > >> Huh, my gmail thinks you are still at your previous companies :)
> > > >>
> > > >
> > > > I manually fixed it on the mailing list for this thread.
> > > >
> > > >>> guys think? Shouldn't vmap_pages_range() undo its possible partia=
l
> > > >>> mapping when it fails?
> > > >>>
> > > >>>
> > > >>>> pcpu_map_pages does perform cleanup on its own as well. There ma=
y be other similar sites.
> > > >>>> https://elixir.bootlin.com/linux/v7.3-rc3/source/mm/percpu-vm.c#=
L255
> > > >>>> so I did the same here.
> > > >>>>
> > > >>>> If we really want vmap_pages_range() to handle this cleanup inte=
rnally, I believe that would
> > > >>>> be a relatively large change, and we would need to consider many=
 more cases. So I think we keep
> > > >>>> the current behaviour for now.
> > > >>>
> > > >>> Yeah, I understand it would require a deeper cut but if that's th=
e
> > > >>> right way to handle this we might as well do that. Let's see what=
 MM
> > > >>> folks think.
> > > >>>
> > > >
> > > > Sounds good to me. Let's wait and hear what the MM folks say.
> > > >
> > >
> > > I just looked into the call sites for __vmap_pages_range.
> > > And I found there's a bug in one vmalloc caller [1].
> > > When gfp_mask has __GFP_NOFAIL, the code keeps retrying
> > > __vmap_pages_range. If there are leftover PTE mappings,
> > > this can trigger a BUG(); [2]
> > > https://elixir.bootlin.com/linux/v7.3-rc3/source/mm/vmalloc.c#L3946 [=
1]
> > > https://elixir.bootlin.com/linux/v7.3-rc3/source/mm/vmalloc.c#L121  [=
2]
> > >
> > Indeed the below code is incomplete:
> >
> > <snip>
> >       /*
> >        * page tables allocations ignore external gfp mask, enforce it
> >        * by the scope API
> >        */
> >       flags =3D memalloc_apply_gfp_scope(gfp_mask);
> >       do {
> >               ret =3D __vmap_pages_range(addr, addr + size, prot, area-=
>pages,
> >                               page_shift, nested_gfp);
> >               if (nofail && (ret < 0))
> >                       schedule_timeout_uninterruptible(1);
> >       } while (nofail && (ret < 0));
> >       memalloc_restore_scope(flags);
> > <snip>
> >
> > and it should be fixed. As the __vmap_pages_range() can actually fail
> > and leave some installed mappings, we have to perform some cleanups
> > on failure or on repeat(if nofail is true).
> >
> > Below code:
> >
> > +                     /*
> > +                      * vmap_pages_range() only runs once all pages we=
re
> > +                      * allocated, and it may have installed some mapp=
ings
> > +                      * before failing. Undo them.
> > +                      */
> > +                     if (nr =3D=3D more_pages)
> > +                             vunmap_range(phys_end, phys_end + (nr << =
PAGE_SHIFT));
> >
> > we can use but we need to check if partially mapped space is not an
> > issue for the vunmap_range(). And it looks like it is not.
> >
> > <snip>
> > @@ -3953,8 +3990,15 @@ static void *__vmalloc_area_node(struct vm_struc=
t *area, gfp_t gfp_mask,
> >         do {
> >                 ret =3D __vmap_pages_range(addr, addr + size, prot, are=
a->pages,
> >                                 page_shift, nested_gfp);
> > -               if (nofail && (ret < 0))
> > -                       schedule_timeout_uninterruptible(1);
> > +               if (ret < 0) {
> > +                       /*
> > +                        * __vmap_pages_range() may have installed some=
 mappings
> > +                        * before failing. Undo them before returning o=
r retrying.
> > +                        */
> > +                       vunmap_range(addr, addr + size);
> > +                       if (nofail)
> > +                               schedule_timeout_uninterruptible(1);
> > +               }
> >         } while (nofail && (ret < 0));
> >         memalloc_restore_scope(flags);
> > <snip>
> >
> And looking further. If the __vmap_pages_range()/__vmap_pages_range_noflu=
sh()
> and friends fail, a proper cleanups should be done inside, IMO.

Sounds like we are in agreement.

>
> But i am checking callers and see that some do some not:
>
> <snip hooks.c>
>         __vunmap_range_noflush(
>                 vmalloc_shadow(start),
>                 vmalloc_shadow(start + clean * PAGE_SIZE));
>         __vunmap_range_noflush(
>                 vmalloc_origin(start),
>                 vmalloc_origin(start + clean * PAGE_SIZE));
> <snip hooks.c>
>
> kmsan_ioremap_page_range() it does clean ups;
> kmsan_vmap_pages_range_noflush() looks like does not care in shadow.c;
> __vmalloc_area_node() as noted, it is broken as there is a BUG() on next =
try if nofail;
> pcpu_map_pages() it does cleanups.
> ...
>
> and so on.

Yeah, the callers that do the cleanup should stop doing that once the
vmap functions handle it themselves. I expect an overall reduction in
code size.

>
> --
> Uladzislau Rezki
