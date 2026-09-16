Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A573DDB0A
	for <linux-modules@vger.kernel.org>; Wed, 16 Sep 2026 19:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789585655; cv=pass; b=q2EMt/dR+bcp7wzTdAU9wRdf2OkjrkGxk1BksQBCrFuZ8Wu2CU+qQAA9U0o7dF+umWbEJMKGutTc/u+rMGHiu56HfSjueL7/u5h3AQ432vJ8ONj1ekEpi6bSSJCKwfAx1iDEg6YuGVtFeqR+7hz93e/63FdnbCylxNLntdZDhUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789585655; c=relaxed/simple;
	bh=KPU7IzR69Ng/j6m8YHFvvjb5SqAkfnaH0qbM64QKGw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E1X/GA930QDfTGfA346NUeUKshc02rhYbbVpmSxwpYoQJZv21K37L3DhytFf6ZwQhAWGl26BggmAzwb/IJlTy4IaxHI037h8tff3gajY4wxQOWG/IRT8uUcC4R1SoMonTzN2rmUyXyjgVhnC7Md29NyiCBMjfxPlRjcDwCK5tuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pLGZDAmz; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pLGZDAmz"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-530411c7ee1so16861cf.0
        for <linux-modules@vger.kernel.org>; Wed, 16 Sep 2026 12:07:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789585636; cv=none;
        d=google.com; s=arc-20260327;
        b=JsXsN8RToTyxa1c7rkT9IM+KxAPUMB6s/33SqmBQSJXexstNbFpZpfK/AJNssC3O1s
         Bnso1p6n7ntbOGu/o5AbUu2Y55vjxus0A7/jHP0UAo3hGX0hrnZiJelwbYCZ8OVh8we9
         x9OIoVSh+DnBucVca8lqBXtkufKUWKVPePA0pe/edkVYLK3NL7+wDIjBuPnb5/0q3WHj
         W25ZlCOnd5RO7++Duo3Bq8U0WXT6BsKbpkM/6OFutjOd0/1aMViT2is3Ae+NawIlrP+p
         b9fQtPvpaNbOJ8oKkDQTYbcq+B5XdwQUba3AMxnvA6oXjOKapXOpvw2EHFY6DU5OCpOz
         2pMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yHbOQrPgVkpK3KZeBIodImpdgvuoykZQvSNB9/nSIAA=;
        fh=UA4cxe/zAMKlheiuv7oGAjZou/jmmCF2mJghpX4XMS0=;
        b=obpbSbdia2fhgCvpG8NjMkvifXlc9maMkOisd380WOl3FS/myPFYFFV3xx0ynZZOar
         SnPQ0/yAIL8xN+pscjzUQfihwAFLJyNV3d2PQb46gPdhLGpaPk5PFSH/Dq7yNActX5ud
         +Ss+wDnUFSx9Cusga6PEbnyxcX23Jfrvcqb66selWDFbfeZYCoDYldfhVMv2khIiwTzp
         5sF+0WmJ9oZwzVKxdpz6wH9j63qKKdSEG4nSLY6of92QAw+lyYw37T+M+Ir3bblHelQe
         v5kaeHv3FoAVvXakf8iUW0sypEu0e4f1a5W/PbxGxGXgockMMaw4lcwFGRzpgD+8Q94C
         UJxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789585636; x=1790190436; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yHbOQrPgVkpK3KZeBIodImpdgvuoykZQvSNB9/nSIAA=;
        b=pLGZDAmzQ08KzFc52ap3MYWk74pjCc7iZ/F71hMicfBuGQWIgM8sQDfGik6QpS06v6
         Fe3Jl6IufGTvhmwW/3IORClfKj9QqPONSfgygQibdntnKyOPBwiABuTDFQEJ3AiW14x8
         fg5y3xQaGaA2m9dUPIIJdbfep2RThpfHq+V9HGK+UsORDr3mvPIATsbhsIl9eOJKz2X+
         PYe9Kb+cqal4TuK5bRKZr1g+cS3osrqjnKfYLMOYmAxgArb3+SDuwmVQQcZPTEUO26vv
         C0Ed/S67xWwkFtd5ltYz0YAsDU919YZMgsDVXmZjNUABr6yk/vkhOcUVrER32pKQ6zf4
         QhSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789585636; x=1790190436;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yHbOQrPgVkpK3KZeBIodImpdgvuoykZQvSNB9/nSIAA=;
        b=swj99A59UmYoxLavyGUIlBtCTlC+EwaX2O3M/FZBUfKQwGz6x2prefmiJgm574r3Io
         gyy+oicJc0MMpYC7rxOnhtcOI4H+ifwDaOhwuFDsegQYXiZ5TYXz64VWqt2byu7wjv2n
         J2f2A6tBoKOXAK8C0jvy15hZPVXbCEzz6ZW7Ki2/ukmW5BVOuZ20XNhl/03YJGNBg8ZC
         2DbJNR6s/VzGMz0ewZ51bJ7I0weswwM+suviL5/47Ba5JNBhcyc3DB65NQzrIdSTn7KU
         nfQxSAOzXk73YaFOngq2427BioLEun4DWJug5CHyo/AJRoEyd/TffAB8o7O3iKT7A65P
         2+Jw==
X-Forwarded-Encrypted: i=1; AKwUvBxBX338977o+BwNQJhx8u0NEwXn5TBF1LSh/DKfAAurOV07WkcS9xiABy3m2icC+zfJPky6hVv/6/e64PIk@vger.kernel.org
X-Gm-Message-State: AFuF++mVwql1FZ0ZfyspxaTmxgHDTY7Rai8ga5h/+a3CGCQn2te+H4Eq
	PKHoYY6ktvsKOlTEopJDgwm0d8DpzAr82He17P/iGlZFCQphU+HeakO2HQHfn+V0lwLlyVVekiP
	7MT/za1ttsVuUZfbS12KKMn8aWH/RKgyBQ5RRm1FS
X-Gm-Gg: AYBFou0lMyiQTk68cOO8JPjdOsESIu+j6Vj2q7FYeI8BOOZSvOhhCUsx6bQ8GMQ0bLD
	ArIgNicGqicD8XhuC7SPJV0JhkATARTvs5dwzepGqgLhQVlr09wl/t3zdN5nu4hsXXCQrcKb6dv
	9Zq2Q35H9ghYDSpelszfxjJUDIlwFEK0UhX3eeoffCVNzaw/epy3FwVktTbVskVbZdavDiONRDB
	fime24/oCIGVtUPiI+iptCklOZnOWh9Pkc/Oo8ET5ypuPhqBmMoJ+Q3Hzq7MKgi6UZX8Sr+Hi6t
	ejoBcOd52HFCa6xR62jjnDp0I8vhnTPibZ0KZqr3uuticP0VnGeimXm6HhGRLYJv/C6QPozvnbC
	ZlqZhWtZ/Tg==
X-Received: by 2002:ac8:5d10:0:b0:532:858d:e791 with SMTP id
 d75a77b69052e-5328dc0bc4fmr2243931cf.8.1789585634800; Wed, 16 Sep 2026
 12:07:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915070001.113559-1-hao.ge@linux.dev> <20260915070001.113559-3-hao.ge@linux.dev>
 <CAJuCfpHJSwNhgotMVpmjVvdv=m52_7Kvzpztf0WcN0AaoSeGGw@mail.gmail.com>
 <60642a7f-2949-428a-8290-40d69c989a77@linux.dev> <CAJuCfpG3d7n=z5WnUQYZsqvrt1pemF8TFvGiGyZGLO7ykVvqAQ@mail.gmail.com>
In-Reply-To: <CAJuCfpG3d7n=z5WnUQYZsqvrt1pemF8TFvGiGyZGLO7ykVvqAQ@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 16 Sep 2026 12:07:03 -0700
X-Gm-Features: AcwNN1U77eJFNHkPfe6Ppe6tyXfOBb0DKmw4ydlFrQQ2j_8G2MzMCljaOX2F-Do
Message-ID: <CAJuCfpGeRdFY6UPF-vXxwHvP2+tN=BKgRkmLR3PMLuWhxgzPRA@mail.gmail.com>
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

On Wed, Sep 16, 2026 at 9:31=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Tue, Sep 15, 2026 at 11:00=E2=80=AFPM Hao Ge <hao.ge@linux.dev> wrote:
> >
> > Hi Suren
> >
> > Thanks for you review.
> >
> > On 2026/9/16 05:09, Suren Baghdasaryan wrote:
> > > On Mon, Sep 14, 2026 at 11:59=E2=80=AFPM Hao Ge <hao.ge@linux.dev> wr=
ote:
> > >>
> > >> The reservation is already stored in the maple tree when
> > >> vm_module_tags_populate() fails. A failed load never unloads the
> > >> module, so nothing releases the entry. Release it and roll
> > >> module_tags.size back. Without the rollback a concurrent load that
> > >> already passed needs_section_mem() can reuse the freed gap, skip
> > >> vm_module_tags_populate() and write to unmapped memory.
> > >>
> > >> vmap_pages_range() may have installed some PTEs before failing. A
> > >> retry to populate the same range would BUG on them, so undo them,
> > >> but only if vmap actually ran.
> > >>
> > >> Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag com=
pression")
> > >> Fixes: 0f9b685626da ("alloc_tag: populate memory for module tags as =
needed")
> > >
> > > If a patch fixes two other patches, it likely needs to be split so
> > > that each part fixes one patch only. But read on please. I'm not sure
> > > if one of the fixes is correct.
> > >
> >
> > Kept them in one patch because they only make sense together.
> >
> > After a failed populate the reservation is released and the
> > size rolled back, so the next load takes the same gap and calls
> > vm_module_tags_populate() again, and that retry would trip over
> > the PTEs the failed vmap left behind.
> >
> > Without the rollback a load that already passed needs_section_mem()
> > just reuses the gap, skips populate and writes to unmapped memory.
> > So splitting them leaves each half broken.
>
> Yeah, that's why I think vmap_pages_range() cleanup should be a
> completely separate patch with vmap_pages_range() doing cleanup
> itself.
>
> >
> > >> Reported-by: Sashiko <sashiko-bot@kernel.org>
> > >> Cc: stable@vger.kernel.org
> > >> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> > >> ---
> > >>  mm/alloc_tag.c | 10 ++++++++++
> > >>  1 file changed, 10 insertions(+)
> > >>
> > >> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
> > >> index 2070e682fe10..95ddf5b743d0 100644
> > >> --- a/mm/alloc_tag.c
> > >> +++ b/mm/alloc_tag.c
> > >> @@ -804,6 +804,13 @@ static int vm_module_tags_populate(void)
> > >>                                      next_page, PAGE_SHIFT) < 0) {
> > >>                         release_pages_arg arg =3D { .pages =3D next_=
page };
> > >>
> > >> +                       /*
> > >> +                        * vmap_pages_range() only runs once all pag=
es were
> > >> +                        * allocated, and it may have installed some=
 mappings
> > >> +                        * before failing. Undo them.
> > >
> > > If vmap_pages_range() failed to map the range, why should we need to
> > > undo it? If it indeed leaves some partial mapping when failing then I
> > > would argue that vmap_pages_range() should be undoing these partial
> > > mappings itself before returning the error.
> > >
> > Yeah it does - none of the paths under vmap_pages_range() undo themselv=
es on error.
>
> Hmm. I wonder if this behavior is intentional or requires a fix. The
> only possible reason I can think of is performance but I can't imagine
> a failure to map is a performance-critical case.
>
> +David Hildenbrand (Red Hat), +Lorenzo Stoakes (Oracle) what do you

Huh, my gmail thinks you are still at your previous companies :)

> guys think? Shouldn't vmap_pages_range() undo its possible partial
> mapping when it fails?
>
>
> > pcpu_map_pages does perform cleanup on its own as well. There may be ot=
her similar sites.
> > https://elixir.bootlin.com/linux/v7.3-rc3/source/mm/percpu-vm.c#L255
> > so I did the same here.
> >
> > If we really want vmap_pages_range() to handle this cleanup internally,=
 I believe that would
> > be a relatively large change, and we would need to consider many more c=
ases. So I think we keep
> > the current behaviour for now.
>
> Yeah, I understand it would require a deeper cut but if that's the
> right way to handle this we might as well do that. Let's see what MM
> folks think.
>
> >
> > Thanks
> > Best Regards
> > Hao
> >
> > >> +                        */
> > >> +                       if (nr =3D=3D more_pages)
> > >> +                               vunmap_range(phys_end, phys_end + (n=
r << PAGE_SHIFT));
> > >>                         /* Clean up and error out */
> > >>                         release_pages(arg, nr);
> > >>                         return -ENOMEM;
> > >> @@ -947,6 +954,7 @@ static void *reserve_module_tags(struct module *=
mod, unsigned long size,
> > >>                 return ret;
> > >>
> > >>         if (module_tags.size < offset + size) {
> > >> +               unsigned long prev_size =3D module_tags.size;
> > >>                 int grow_res;
> > >>
> > >>                 module_tags.size =3D offset + size;
> > >> @@ -961,6 +969,8 @@ static void *reserve_module_tags(struct module *=
mod, unsigned long size,
> > >>                         shutdown_mem_profiling(true);
> > >>                         pr_err("Failed to allocate memory for alloca=
tion tags in the module %s. Memory allocation profiling is disabled!\n",
> > >>                                mod->name);
> > >> +                       release_module_tags(mod, false);
> > >> +                       module_tags.size =3D prev_size;
> > >
> > > Yes, this one is a valid fix. It fixes 0f9b685626da commit.
> > >
> > >>                         return ERR_PTR(grow_res);
> > >>                 }
> > >>         }
> > >> --
> > >> 2.25.1
> > >>
