Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E34C1E98E3
	for <linux-modules@vger.kernel.org>; Sat, 15 Aug 2026 05:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786773508; cv=pass; b=kTCOtB87BYnMnszozW4PS2otAA52472HyRnFXPbVmaHqOx/h9X9HRFgrM6tgxqHRqfDof+TdKjepysMDDnYvT8VMuCMc1T8t3Vn6PlbwMYAY0D9raQRUJonYOfUilYFad22ivuF7sq3pjvFnb2cHU5a48RmchfrQ/9V9I9yGTlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786773508; c=relaxed/simple;
	bh=MAjFb91ehRZt19IwjNc2zqB7sKvI8LxKr1AycouuNvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t2eVmcsft61OvDnh2Q3o/iHXJWAhJ8/jdPK78NR6C4ZO0ZvOaRWuxQyA+QGw4yd2dUmAKdFYL6JT23p8mNeukYDJy1keFkATbMxwPXwroSdv660zdnTmq4SwmOwCtLnb9s6xQ6/jtXCcqnb0rwNhpIsMM8T50hbq1qi13PJCBIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hfj6DVQJ; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hfj6DVQJ"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d3b440b97aso168205ad.1
        for <linux-modules@vger.kernel.org>; Fri, 14 Aug 2026 22:58:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786773506; cv=none;
        d=google.com; s=arc-20260327;
        b=Ss9GXey3oxyzO3vHZop3/05BjtCla+btsmLxUCYMfIzOfOwr5zizVeXYw60lMpU3xM
         02S/pzfOuNy6finjzLlf/f649L2HfsijCuyZYslfVsGgir8uOSp9SgbgDd9ZVlG+UtEI
         WHEnpdyyFleJ9MnQ5nZL6nboAQLLv8QiYcqxPvx5bn4fKUhm2um+EqlXVdEuNOy0U1s7
         gnxgRgxiPKJlkCQ69sg5sLc823VRBC5o+E4UByuzpTNs7dnRppOaPcbLf41yE6H7g+TP
         9/6Dc6go1XJoxdjbpBJsIQmXp0dHQ1fYpcbJM+FC3GCS6Z+XGhePJNg+XwhFcRRihQJJ
         WDLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GSNHZ1rhCWbjDqMjYrewNRXpE7DLnZyqNYRIuv59LLs=;
        fh=k7MmqAWFeTEwWZEYnkHzZN6XtLMDI5AeDs0AaBm9SW0=;
        b=DceCJTX69qlxLiFYeq6UVCqwwHa6eHnBzHLLgEsPl0PCvU9RScniNDid4duMIZ3IDU
         OqS8P4x3sR7nUvC+OXwnAvPCiFP1w+RlFjbpfSDYsx0yeGce4BbCfn+clUz53BCakAvF
         WOCdmTNnPpBPkfHXoi5cMk13MFuUcn/2s/FlWnA5vT4k6W05FhZ1WjqtVojTB96EVT13
         bfJlHA5o+KDpoyfQpJ4+kDat5haJLYbNc3lWqYzTSuS8+poqfxL2+60ImrAQUlhzASX8
         c+vYgIWw8PKcaLMYhDUA8FONiVWHasTcSmGf74gkYE7UAHjFNPGuPqf0F+JrFKW7cp7I
         ui7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786773506; x=1787378306; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GSNHZ1rhCWbjDqMjYrewNRXpE7DLnZyqNYRIuv59LLs=;
        b=hfj6DVQJAlfvwzocfR3WdlwWy+sIWGGjHr7wAu+TPKjLGjWcOnO5/yaupwxuA0LN5n
         bV5E7Q7uVV79RW/vfwd7mQgHF/cJXl6/mgq7VuMX6uz/b7NbQTigANXb//uLxzO4NoZi
         BOh/fk48zlUBmjE2nRWRGFKzzyh2dt8MnuZqp6j9RVjBo1rCfqH9VwcsCm4i0YcZ5kW0
         Ga4vnVaN8Rw0paWZBFPpG3F47lfiE1NyZ2h2ZS2ySG0iWa1fMp+Y9ikhRnt3fgPRrkTe
         1DS6RNKqDGmu0Xn6I5dzzpKfx4asf3bxZv0OTnJsbKipvoImvfPXds4s5bdi+BGZSpf4
         kDwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786773506; x=1787378306;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GSNHZ1rhCWbjDqMjYrewNRXpE7DLnZyqNYRIuv59LLs=;
        b=oDGxrfck3eSeJzYw45NhzO4uRgEQ0ETY25dGQXzg3tu/CLSuEsJ9Ixkbh2kTV673Ic
         s6bDdojBLc9scX31QJ4UoM6YFcxRVW1EJR2erqk97pwOIUKcIhNeysQ6Bv1ZfjjfFspW
         JbRVRpraXrhRGts+OsuTwzrenHrXgB7xT4MWXmJbcewFUYQ4j1AdARSpnJ/DAzcOQSVk
         zAZ17TRmJIoyzE2PW0W/ocaLr+yADohGEEAq7q8NPQIYOlSf/cQQjw4rAlpktIqQUlXa
         Um33XSpySMg6/JOTdHwR/4F9Fos4D2FMzzdcI/SNjidqtCainyxq+WG80QsqV0psEW8p
         t/bg==
X-Forwarded-Encrypted: i=1; AHgh+Rpq5z9iJSm4IdwMXPW0hK0ZQMBaUp3YRS/f11djHU1R8563CMr/uNnRg08ciKU4ysE5DsT62mQms5qoSENF@vger.kernel.org
X-Gm-Message-State: AOJu0YwOfsuAxJvB3dshcP0nwAEA7chMG6FbbsdiY6shlK0PlYTtzQyK
	6DJ+WBghLXGyyhx2j9IGpKCJflzQRE3njaMK+glyaK3pqMjZhaluaZDSW1/XDRA5GVUMfTPaB9n
	4wRWRg58xiWSuCtNLx1PRoEZqbftqPXPJwzIQXowT0tKwQLH57GOcoUR7LXE=
X-Gm-Gg: AR+sD10a8SNUEqXviSvFLDAsJHNt3Wi3ITvVTyqf49XzJC9olqiQYVlO5HddxAEmPsz
	+Q4amnu3gwIjwipIXQeSpYJ11dxwpBpQuKTOPCAP5gqvQrgr4G85Jjv34KMZ+CTbWFxx/7L5ELG
	XzfnsiYX3sJRRU9l2tTHeNncU/fjjtFa+MmSz8vG0UQKDxTDjXRb530tFlZXWevajwwiyXeQn7r
	ljS6juX2Qmx/KVdO7WfaY6kO3DK97u0N55s3E+FBrNvCp5wdaHb9raxLaw+iji62P7/Q5Ulkbyi
	ppYGn45ao4NUOJINBB4mEDaVFQHPeWetv2tsrgise1JqcnzCqV2vrJo=
X-Received: by 2002:a17:903:3246:b0:2ca:bf8e:360b with SMTP id
 d9443c01a7336-2d3b49010f5mr13153455ad.9.1786773505668; Fri, 14 Aug 2026
 22:58:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812054105.102637-1-hao.ge@linux.dev> <20260812054105.102637-3-hao.ge@linux.dev>
In-Reply-To: <20260812054105.102637-3-hao.ge@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 14 Aug 2026 22:58:14 -0700
X-Gm-Features: AcwNN1Vv8e8AYIsvCRMSKDbhePjWJ2ljICkt_7vSL2FAbtl9G2kesUL9ji3umuM
Message-ID: <CAJuCfpFvdNFdsKdK2CdF2fNp8gbNgFpoeAiaqp70mpbNGCvk3g@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] alloc_tag: fix undetected compressed tag overflow
 when profiling is disabled
To: Hao Ge <hao.ge@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 10:41=E2=80=AFPM Hao Ge <hao.ge@linux.dev> wrote:
>
> In reserve_module_tags(), the tag overflow check is gated on
> mem_alloc_profiling_enabled():
>
>     if (mem_alloc_profiling_enabled() && !tags_addressable())
>
> If profiling is toggled off at runtime and a module is loaded whose
> tags exceed the compressed-mode limit, shutdown_mem_profiling() is
> skipped. vm_module_tags_populate() still maps memory for the tags and
> the module loads successfully, but the total tag count now exceeds what
> NR_UNUSED_PAGEFLAG_BITS can address.
>
> Once profiling is re-enabled, ref_to_idx() computes each tag's index
> as its position in the alloc_tag array. update_page_tag_ref() masks
> it to alloc_tag_ref_mask before storing in page->flags. Indices
> beyond the mask are truncated and idx_to_ref() resolves them to wrong
> tags.
>
> This silently corrupts /proc/allocinfo: allocated pages get attributed
> to the wrong call sites, so the statistics it reports are wrong.
>
> mem_alloc_profiling_enabled() and mem_profiling_compressed are
> independent. Once compressed mode is established at boot, it stays
> active regardless of runtime toggles of mem_profiling.
>
> Remove the mem_alloc_profiling_enabled() guard. On overflow, shut down
> profiling, release the reservation, and return -EAGAIN so that
> layout_and_allocate() retries with profiling disabled: codetag sections
> are then placed as regular module data and the module loads without
> profiling rather than being rejected entirely.
>
> Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compress=
ion")
> Cc: stable@vger.kernel.org
> Suggested-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Hao Ge <hao.ge@linux.dev>

I'm looking at your fixes for pre-existing issues reported by Sashiko
but this patch looks correct to me.

Acked-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  kernel/module/main.c | 25 +++++++++++++++++++++++--
>  mm/alloc_tag.c       |  8 +++++---
>  2 files changed, 28 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 46dd8d25a605..ed26f167be84 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2944,6 +2944,7 @@ static struct module *layout_and_allocate(struct lo=
ad_info *info, int flags)
>  {
>         struct module *mod;
>         int err;
> +       unsigned long frob_size[MOD_MEM_NUM_TYPES];
>
>         /* Allow arches to frob section contents and sizes.  */
>         err =3D module_frob_arch_sections(info->hdr, info->sechdrs,
> @@ -2966,18 +2967,38 @@ static struct module *layout_and_allocate(struct =
load_info *info, int flags)
>          */
>         module_mark_ro_after_init(info->hdr, info->sechdrs, info->secstri=
ngs);
>
> +       /*
> +        * Save the sizes reserved by module_frob_arch_sections() so they=
 can
> +        * be restored if we retry below.
> +        */
> +       for_each_mod_mem_type(type)
> +               frob_size[type] =3D info->mod->mem[type].size;
> +
>         /*
>          * Determine total sizes, and put offsets in sh_entsize.  For now
>          * this is done generically; there doesn't appear to be any
>          * special cases for the architectures.
>          */
> +retry:
>         layout_sections(info->mod, info);
>         layout_symtab(info->mod, info);
>
>         /* Allocate and move to the final place */
>         err =3D move_module(info->mod, info);
> -       if (err)
> -               return ERR_PTR(err);
> +       if (err) {
> +               if (err !=3D -EAGAIN)
> +                       return ERR_PTR(err);
> +               /*
> +                * -EAGAIN means profiling was disabled but the module
> +                * can still load without it. Reset state and retry.
> +                */
> +               rewrite_section_headers(info, flags);
> +               for_each_mod_mem_type(type)
> +                       info->mod->mem[type].size =3D frob_size[type];
> +               info->sechdrs[info->index.sym].sh_flags &=3D ~(unsigned l=
ong)SHF_ALLOC;
> +               info->sechdrs[info->index.str].sh_flags &=3D ~(unsigned l=
ong)SHF_ALLOC;
> +               goto retry;
> +       }
>
>         /* Module has been copied to its final place now: return it. */
>         mod =3D (void *)info->sechdrs[info->index.mod].sh_addr;
> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
> index af44f90379f2..0a7b657fe2de 100644
> --- a/mm/alloc_tag.c
> +++ b/mm/alloc_tag.c
> @@ -950,10 +950,12 @@ static void *reserve_module_tags(struct module *mod=
, unsigned long size,
>                 int grow_res;
>
>                 module_tags.size =3D offset + size;
> -               if (mem_alloc_profiling_enabled() && !tags_addressable())=
 {
> +               if (!tags_addressable()) {
>                         shutdown_mem_profiling(true);
> -                       pr_warn("With module %s there are too many tags t=
o fit in %d page flag bits. Memory allocation profiling is disabled!\n",
> -                               mod->name, NR_UNUSED_PAGEFLAG_BITS);
> +                       pr_warn_once("With module %s there are too many t=
ags to fit in %d page flag bits. Memory allocation profiling is disabled!\n=
",
> +                                    mod->name, NR_UNUSED_PAGEFLAG_BITS);
> +                       release_module_tags(mod, false);
> +                       return ERR_PTR(-EAGAIN);
>                 }
>
>                 grow_res =3D vm_module_tags_populate();
> --
> 2.25.1
>
