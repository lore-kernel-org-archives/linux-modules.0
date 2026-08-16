Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF3114EC73
	for <linux-modules@vger.kernel.org>; Sun, 16 Aug 2026 15:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786893409; cv=pass; b=Jnu65/hOEW1/gwEoxtjUSKeXTnNHePDhxWwF1nlicosto9jBfhVYSSZ8nSxgDXoLAWrzrDLEpVhnBSSUKWy61qpolWQ/m8kafotPS6jcsMBal3OnuFQAqQ6HXUHF613QpwufXOP++9+KXA5wtvPyt3D7H5uYKNwEcmgSV7lMlts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786893409; c=relaxed/simple;
	bh=nTQYatXTuo/oI/IsZwKNVXTQE999UX8l9kqBpb11hlk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e1yNFWs+WvQhMU8K+5gcoiCBNr+4erX++JNqF/8oYlh+5I/D5aKp4VydEVu5PXbB4AlkQg771GAKSmUfInH2t+d3YrEm4VISjpF+W0tzaDh/c2D8O5vfr5lzqABdo5Y+QSnvrvw8EdDFkrSjnNcWGSnFMFUABggrQ0F1QqDBF/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iiIyU1XV; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iiIyU1XV"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51c10e86e52so479821cf.1
        for <linux-modules@vger.kernel.org>; Sun, 16 Aug 2026 08:16:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786893406; cv=none;
        d=google.com; s=arc-20260327;
        b=UttQIdSAfEjZ29ewlQ196fEd1WXnJOuyXT6cpKbyfxW7zwODudMzm0yltXsigBN5WI
         BBZ7U2bg1WzB02G+09qGxrt+NqK2XmU+hpDklU2LeBJ4YIlwQTPc2VwOEOOy1LfiQfu1
         QOJsU7TMgspHpIIcywniiDQkAqh4iHa9PhC7bhZw1PMG0G3QEQWniIYkaVUJEcL6ExaR
         1UcKPN8ZMcWzdiRaxL5S0yxzPtJPv2JyygeQc2JyxjF7+qa97Nh9mlUZnlOZeeM6pXEg
         kuwJljq8VnoGdTH1LXA+oDQVeEMTVFHROqfsWEVWeerGkF6YelLPez/o4h/jpATmov/i
         FriA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=paElrpHQlE8g3P6OtIHexotZleQW+QuOt1CzJnnLFjc=;
        fh=X2z137MJ3nl9vJWptPgeahGZWbMFfQ5oVIkK/+804j0=;
        b=S+DAAxzWX0I3cmT1WsOeVmbBbAmxePUYNE9O9YqfN1fbBuYafIDw4r5ung8qRnCQy+
         xn0Zd/qpEqy32x7Ze2YvLSBOWTbfWHNfzxs+tRikCvoS3rsXocrZg3dEhDjqA75DqJAj
         0hjZA59ntDUpoKs154wY/kkpNbpMG1pNE8hT9p8ouVRuGAoWBHpAtuoracRT8xZ47N2p
         jfpqAmziiHReCHRgyZbwHEzqSdYDlFqzdWy9ucavtYUUIYAX9004fyt4HJkCZdsbzTx5
         931SmP/qDsSW24IWj0e6381D4BbQQLnDXWZKcpK5mHzsYwKiwBWfQNp3tR0rP81+8DFh
         dveA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786893406; x=1787498206; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=paElrpHQlE8g3P6OtIHexotZleQW+QuOt1CzJnnLFjc=;
        b=iiIyU1XVANX+/lvpdh/C92MD/gI1aZa2VLbw4vkBA5UogzJyi433p9RQxlCpP+8A5M
         smkk0iswmpmYeVXIdzVL5FK3DXhFw4NVPobm5ve+HOTswU/WYrF8GVXuAkCwB8+Vm5Qi
         02XIWvzr/pCuLUAh1uR5E4E64boWSYAeoKHZQrgQIlAvCRZIYH+jLZC/KnrmrhLpEZ8w
         mSLu82zViXgIj7LurCFKcLkQGAKFbGF9bOE2t1KnR8pnbffPVxE62Ncb9+vlBlkBn2cd
         6hoCAzA9ZZ/w4HZkPVWsPV7vCWGe0qpYQpXhONdMDfScysYNsXiar1ZVFipNdPNwRIUt
         D4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786893406; x=1787498206;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=paElrpHQlE8g3P6OtIHexotZleQW+QuOt1CzJnnLFjc=;
        b=dSPox47z4jwNX4+Iq4jzYTSDiaXAQ29C4Kb7m+6oC/LshBQMvxbS0aXzfCOF2xOvYE
         JzZML2AFFGRvBmXsvKswMXvXSFbPf78/rCtSmjM3lOAVy5J6ELtTHa4Vv3NaYtkAgW2T
         0YbJLLjR+JevBYrgBJo+guGEb+giojDfWAzqeZK5mBv34HUf4V+M3L73jEvR7TLW4Okd
         h0HYJFuFCQw18VKdfGWHfCJ4jWEQLJTZ0EjGlaq6TWF3EaWQHZ3e2NaEuN6OBwwBonDN
         flQB2ryAM7EVbPg/88vnX5QmfbnAJDIU+2ILSExOmvjq/OsjeT1CQSVzICk39eq/btDQ
         iuUA==
X-Forwarded-Encrypted: i=1; AHgh+RqhgBjyg0G137au6At55Qw4GxzaDE+KiJi8Oj01dtk/VZrVxlhazCukAUvBcz81tYtr/oGl47u5oke0vjAO@vger.kernel.org
X-Gm-Message-State: AOJu0YwhHyxC11loXikeZvX8INfbPYpwfUKqpXNag/7U2CfJyCQJopmI
	y0SlYCiPb+DG09G/t+7Kxnx4sEZLYa+kCS/l4bEpkz2oDAIa1xQLOKjEirFSZWQTFIhFwo2o5zG
	N7xMYjK0hnynGOCSCi44+6dNdKKgKx39XAPtWmE6f
X-Gm-Gg: AR+sD11pga702C1zviINoID+ZU1keUa65DLHSpVqKiMNYLlFsa2e7TwmrwtoOVcwSmZ
	Pn83g6FFODfmNVXk+MxX+BbVknYqeOPzJfW+entSRnI1rrf+d92ODKA8t904Sm/ksRAaiYQyTo2
	OxfO3bIlUmLMLK4X1CdcLVt8GSN0rAec2mRHLUgmqFW4jEKxzVSPxODmjROz3TMnoK10VhsW3i5
	v3TFOgF4wYlJajBD/enMuGeBLN9WXGcrZCSa9eiZTG0E8P1ntEnP8gxwsisfH3Tq4RDoiXJHGAW
	rmVSyv6RN8I6ChlbN0RMnr4Ghn08+w6vJbRKa1j3eGE=
X-Received: by 2002:a05:622a:291:b0:517:6010:7c71 with SMTP id
 d75a77b69052e-52db07b97ffmr678631cf.4.1786893405340; Sun, 16 Aug 2026
 08:16:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812054105.102637-1-hao.ge@linux.dev> <20260812054105.102637-3-hao.ge@linux.dev>
 <CAJuCfpFvdNFdsKdK2CdF2fNp8gbNgFpoeAiaqp70mpbNGCvk3g@mail.gmail.com> <143a37b5-93a2-4038-8be9-29e13263e743@suse.com>
In-Reply-To: <143a37b5-93a2-4038-8be9-29e13263e743@suse.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 16 Aug 2026 08:16:33 -0700
X-Gm-Features: AcwNN1X1kkHyn9OSKgwwnu-af8eWVC7nq_5zQzZp6a8dGSxkkhZX0C7kT05sApM
Message-ID: <CAJuCfpF1pWqhc+P9zPg8FT_CcdQxRuEpJ2DtYja1BeMXhW7-8Q@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] alloc_tag: fix undetected compressed tag overflow
 when profiling is disabled
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Hao Ge <hao.ge@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 15, 2026 at 3:45=E2=80=AFAM Petr Pavlu <petr.pavlu@suse.com> wr=
ote:
>
> On 8/12/26 7:41 AM, Hao Ge wrote:
> > In reserve_module_tags(), the tag overflow check is gated on
> > mem_alloc_profiling_enabled():
> >
> >     if (mem_alloc_profiling_enabled() && !tags_addressable())
> >
> > If profiling is toggled off at runtime and a module is loaded whose
> > tags exceed the compressed-mode limit, shutdown_mem_profiling() is
> > skipped. vm_module_tags_populate() still maps memory for the tags and
> > the module loads successfully, but the total tag count now exceeds what
> > NR_UNUSED_PAGEFLAG_BITS can address.
> >
> > Once profiling is re-enabled, ref_to_idx() computes each tag's index
> > as its position in the alloc_tag array. update_page_tag_ref() masks
> > it to alloc_tag_ref_mask before storing in page->flags. Indices
> > beyond the mask are truncated and idx_to_ref() resolves them to wrong
> > tags.
> >
> > This silently corrupts /proc/allocinfo: allocated pages get attributed
> > to the wrong call sites, so the statistics it reports are wrong.
> >
> > mem_alloc_profiling_enabled() and mem_profiling_compressed are
> > independent. Once compressed mode is established at boot, it stays
> > active regardless of runtime toggles of mem_profiling.
> >
> > Remove the mem_alloc_profiling_enabled() guard. On overflow, shut down
> > profiling, release the reservation, and return -EAGAIN so that
> > layout_and_allocate() retries with profiling disabled: codetag sections
> > are then placed as regular module data and the module loads without
> > profiling rather than being rejected entirely.
>
> When the described overflow occurs, why should codetag sections be
> placed as regular module data? Will the codetag support use them in any
> way, or do they simply waste space? Is the issue that alloc_hooks()
> creates relocations pointing into .codetag.alloc_tags?

Correct, alloc_hooks() will have references into .codetag.alloc_tags.
With mem_profiling_support=3Dfalse they should technically never be used
but I don't think it's a good idea to skip .codetag.alloc_tags section
allocation and to leave dangling pointers. Also the case described
here is an outlier, so optimizing it would not yield much benefit.

>
> >
> > Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compre=
ssion")
> > Cc: stable@vger.kernel.org
> > Suggested-by: Suren Baghdasaryan <surenb@google.com>
> > Signed-off-by: Hao Ge <hao.ge@linux.dev>
> > ---
> >  kernel/module/main.c | 25 +++++++++++++++++++++++--
> >  mm/alloc_tag.c       |  8 +++++---
> >  2 files changed, 28 insertions(+), 5 deletions(-)
> >
> > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > index 46dd8d25a605..ed26f167be84 100644
> > --- a/kernel/module/main.c
> > +++ b/kernel/module/main.c
> > @@ -2944,6 +2944,7 @@ static struct module *layout_and_allocate(struct =
load_info *info, int flags)
> >  {
> >       struct module *mod;
> >       int err;
> > +     unsigned long frob_size[MOD_MEM_NUM_TYPES];
>
> frob_size is used to store values of module_memory::size, which has type
> `unsigned int`. The types should match.
>
> >
> >       /* Allow arches to frob section contents and sizes.  */
> >       err =3D module_frob_arch_sections(info->hdr, info->sechdrs,
> > @@ -2966,18 +2967,38 @@ static struct module *layout_and_allocate(struc=
t load_info *info, int flags)
> >        */
> >       module_mark_ro_after_init(info->hdr, info->sechdrs, info->secstri=
ngs);
> >
> > +     /*
> > +      * Save the sizes reserved by module_frob_arch_sections() so they=
 can
> > +      * be restored if we retry below.
> > +      */
> > +     for_each_mod_mem_type(type)
> > +             frob_size[type] =3D info->mod->mem[type].size;
> > +
> >       /*
> >        * Determine total sizes, and put offsets in sh_entsize.  For now
> >        * this is done generically; there doesn't appear to be any
> >        * special cases for the architectures.
> >        */
> > +retry:
> >       layout_sections(info->mod, info);
> >       layout_symtab(info->mod, info);
> >
> >       /* Allocate and move to the final place */
> >       err =3D move_module(info->mod, info);
> > -     if (err)
> > -             return ERR_PTR(err);
> > +     if (err) {
> > +             if (err !=3D -EAGAIN)
> > +                     return ERR_PTR(err);
>
> The move_module() logic is non-trivial. -EAGAIN could be returned by
> other code, now or in the future.

That's a good point.

>
> > +             /*
> > +              * -EAGAIN means profiling was disabled but the module
> > +              * can still load without it. Reset state and retry.
> > +              */
> > +             rewrite_section_headers(info, flags);
> > +             for_each_mod_mem_type(type)
> > +                     info->mod->mem[type].size =3D frob_size[type];
> > +             info->sechdrs[info->index.sym].sh_flags &=3D ~(unsigned l=
ong)SHF_ALLOC;
> > +             info->sechdrs[info->index.str].sh_flags &=3D ~(unsigned l=
ong)SHF_ALLOC;
>
> Why is it necessary to reset SHF_ALLOC for .symtab and .strtab here?

I believe layout_symtab() sets that bit and to retry we need to reset
it. But I might be wrong here.

>
> > +             goto retry;
> > +     }
> >
> >       /* Module has been copied to its final place now: return it. */
> >       mod =3D (void *)info->sechdrs[info->index.mod].sh_addr;
>
> I'm not sure this is the best approach. It's complex logic for what
> appears to be an edge case related to a debugging facility. It will have
> the usual problem of error paths not getting enough testing and breaking
> subtly over time.
>
> An alternative could be to reset SHF_ALLOC on the codetag section to
> remove it from further processing and have relocations that point to
> this section resolve to something else. It seems that alloc_hooks_tag()
> could tolerate this, since it only needs to reference the associated
> alloc_tag when mem_alloc_profiling_enabled() is true and that gets
> disabled by reserve_module_tags() on the overflow.

Hmm, yeah if we redirect the references into .codetag.alloc_tags, that
would be much better.

>
> It is also not an ideal approach, but I feel it could be less intrusive
> to the module loader. I can put together a prototype if needed.

If your approach does not cause module loading to fail when we disable
profiling, then that sounds like a good idea. If it's not too much
trouble, could you please send an RFC?

>
> --
> Thanks,
> Petr
