Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6938B370AD7
	for <linux-modules@vger.kernel.org>; Sat, 15 Aug 2026 06:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786774934; cv=pass; b=oDugYKBUe35s9e3mRqFY7CA2VxmX5DdWS9iCY691EW9TP7QqWschAM+TWRECqDjEy4qSs4QvuigJ8vQXM3BVrYPxw1CbjhG0dsyMYrCFESNCvhd9wNAMIzqPqylgV/dqtbbVjjy3aB+qctHYoiipUdex/C4kBJ06IZOmqdNrTes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786774934; c=relaxed/simple;
	bh=zJxk6Wum0TfUdifa+ET6oavSctHiWrkHFEmb2mrQB48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RMo9mm90s0C+PCw1/fvJfA0Ry8DVc7Ty2udvhG2WFl6DQKuQaHes6SWqHKEzPucAfKIMQeuUQ2Lb8fAvyPdK+8fgQLSdfZC9oYDlywFT44sSa7UK8T2Fb9BIzpaUFywTjOwi2XNTWqdmS8nAc181bxJ/s5ep6vqdnuc4A1E/zh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E2Ww2hcB; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E2Ww2hcB"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51c15a5b265so418391cf.0
        for <linux-modules@vger.kernel.org>; Fri, 14 Aug 2026 23:22:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786774931; cv=none;
        d=google.com; s=arc-20260327;
        b=o79EaVKldaGNPcp/pKYz5ds9ORgZirTXBwpaZsC5dcrc79j/QmxwbPKakkFc6IPCWt
         wz7JBq9GO9jPbhQVH3mxI/gfz0d63feANDiuJD0muR2q/a6PD7iNo+Ri7E1V0kyYhpic
         z0ucsN0DsfyW/YxaMIvo425N3ktD+xlLdGzkK0GhAFVDMQBTqavRFLNdPq7tQ3XjxrgG
         1YFNyQF9OZwvo/oAVQu1nL5eOI6Q18TXU8ewGeujJHXCekbs4a3cG65jLrpBn4MSoeKa
         YYREMMdlUw+L796tlEWBvKOc9v3ED1ywq5Lsv1luBP/gqLsbtfnNvPmaFBq0j1koJZbM
         im9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OBKzlS6zgLX7HjDf60a09oLwp2mBkH0MhIIWPg5JjtQ=;
        fh=2UpjNBakis2lP2TZWCGuRwo/TQHEuVWcZy6JHbwalIE=;
        b=fO2jDpBtc2iiJheU3iK9pawFTpfM5CkTMtvy9qCWfoy8JCvbw0ou7kxbPUdySi/83V
         GcCeNPogsX5mIqi4zZiKd5+S5MyW68gqCFSx/euoMJk2Hg1+LzD46StCLgkP9Wt8ZWTr
         v7SrwUJgc9OOcYWt0u4Mc9pHBeynCVGh2Ck+oAYzKzFZjqhToJCNBhM3x5SfQk2G/V9i
         xCc3GGh6iT/C0ty4UxziVD4/OMk2eXrBXfriJrkEHK4+cPXvAQdepPMhtg+px2tPa+WJ
         +NIP7ETfjOQQpW+3Mby0dhNaSXvv+NLKCqvwZBtvuU2TX0d8Fhwjp0Y/FNDESSNs56D9
         XtLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786774931; x=1787379731; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OBKzlS6zgLX7HjDf60a09oLwp2mBkH0MhIIWPg5JjtQ=;
        b=E2Ww2hcBnPGWnzJIPH14nuE4n50iU12RVxpvKYXksphzPAnGTJtwW/LMrRutZciYmS
         Ur2fAp8rnCsW7v64HYqZmWq4wu4GRDyZYxLA/Ze6RNQorP6UyDRQ0eeT1QlIDW/HaZed
         bI62Mz9ZNkU0dhWx8KQKI8+ICghDwd2XPHqjWhvskifYDwpEXT9fGybs8OB1OS5o3H0A
         7hErQRRtPCc8QDAX6Yr4hzQLDXkcq+r1CC54wbbXvWaSS4R4FNSOJd0dotaUxuHmH+1q
         GJi7Y+M1+2zpEsu5n4jUhB7oUYJu5EZJ29yfoK9/lHpJM3/t/sffzoHQzPZJoMRnKvZL
         UXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786774931; x=1787379731;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OBKzlS6zgLX7HjDf60a09oLwp2mBkH0MhIIWPg5JjtQ=;
        b=tNaMTrxa7KW6oRp1nDwegaR4jIrFPvAENA/ab5k9MN1DnWhlhqcG2vCXME453wDeJb
         HMsTreMYJY+Ejh/9nMtIHxEQZ2Uz5ezi0NmuuPiznKG3p6y5EiRfznABp1/cwqGVmztr
         mLVzM5AvICo2uKfmrfCsI+9z+xndeaOfPj4EQAQJ6MtRm4KUvSKlunYpGnaYZ9DKTiEr
         oUcsIwXBotuDt2ENSvvLTCI2EnDUlFJQOsIgGNA26iLG8gJfpMv1Q/DXIprLNMr+KPQI
         +yESKdTO7lA1+lQoGNuHsUTmKuKxiJxFMxTxRT+2N4jLDN58WpDkM/Xo4RDZFJ0jDPRm
         Y9EA==
X-Forwarded-Encrypted: i=1; AHgh+RpvJrZgWEfeUZ3a7KWBwczTxItpnOQCWNzn1gM2inVg8pZKcC0Mze9z8lf/e7rrLejA5+5HykpNKpk2yR8o@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7wRr6hoIw89/a3YC9FRwjl78k+M48/SKFYTZwMfAtUjG5dEGY
	BZ+2sCbttV16tloDLfSlyIoMLpIsjyJ6VnROmjyZmTILWuWLyc6lDyz2n7fzOlLd/Ih0H+YyN7A
	A/qAPfP9if+6sZtqm4TeQCSZtrp1Cx2PAXc78+Cp2
X-Gm-Gg: AR+sD110FciwG/Ap3lZk/33ACCitEQmMGIRkeJmalLPIBBkb0Bm8M4VFiGzPBrPZ+gL
	nC8D573MTIId2CFuRTKA0KeF3/dADHYXhbMELiT9tOoBi40ZywEToHvMh2408+WsdlIa+QIppg9
	gt71kUtVn+zYfTkKPO42hrpl7hxaoyIaSCr0unG+wcBTa8Xc1DXZ987F73ziFKyK1gBpF6dU9nV
	tPagSHBeTbpqrjTTTkgqkF4GcDzBVUHnY5Yf4m+jPMoktgoWuuG18u9wix3hhUTUrCoXgz+Dira
	SDyBVomFEuTh1ouoa/Prwlq9jHpbHGI2d/TXXIiGXE0=
X-Received: by 2002:a05:622a:591:b0:52b:4ec6:52ba with SMTP id
 d75a77b69052e-52d845c0170mr30884361cf.6.1786774930473; Fri, 14 Aug 2026
 23:22:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813093421.135230-1-hao.ge@linux.dev> <20260813093421.135230-3-hao.ge@linux.dev>
In-Reply-To: <20260813093421.135230-3-hao.ge@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 14 Aug 2026 23:21:58 -0700
X-Gm-Features: AcwNN1XREKpTOkn7MwudQ1sU-GPxwXHRR1fNjOfp72xmvYqYjGc-85rvjZBIN9o
Message-ID: <CAJuCfpHBWFZh5yHHK01CT1i-z=OP74kzGobfYskkqKgBBLx_EQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] module: move codetag section placement decision
 to layout_sections()
To: Hao Ge <hao.ge@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 2:34=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote:
>
> codetag_needs_module_section() is called twice per codetag section, once
> in layout_sections() and once in move_module(), and both depend on
> mem_profiling_support, which changes without a lock. If profiling is
> disabled between the two calls, layout excludes the section (offset 0)
> while move copies it as normal memory to offset 0:
>
>   CPU0 (insmod A)                    CPU1 (insmod B)
>   ----------------                   ----------------
>   layout_sections()
>     needs_section_mem() =3D=3D true
>     sh_entsize: type, offset =3D 0
>                                      reserve_module_tags() overflows
>                                        shutdown_mem_profiling()
>                                        mem_profiling_support =3D false
>   move_module()
>     needs_section_mem() =3D=3D false
>     offset =3D sh_entsize & MASK =3D 0
>     memcpy(mod->mem[type].base + 0, ...)
>        -> overwrites the first section there
>
> Record the decision in layout_sections() in sh_entsize using a
> MOD_MEM_CODETAG type, and have move_module() use that instead of asking
> again.
>
> reserve_module_tags() returns -EAGAIN if profiling was disabled after
> layout, so the loader retries and places the section as normal memory.
>
> Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compress=
ion")
> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> ---
>  include/linux/module.h | 11 +++++++++++
>  kernel/module/main.c   | 17 ++++++-----------
>  mm/alloc_tag.c         |  8 ++++++++
>  3 files changed, 25 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 7566815fabbe..a02016528e1d 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -328,6 +328,17 @@ enum mod_mem_type {
>         MOD_INVALID =3D -1,
>  };
>
> +/*
> + * If CONFIG_CODE_TAGGING is on, modules get a .codetag section.
> + * codetag_needs_module_section() says where it goes: the usual
> + * mod->mem[], or off to the codetag region.
> + *
> + * Mark the codetag-region ones with MOD_MEM_NUM_TYPES.
> + * It's just past the real types, so it doesn't index into mod->mem[]
> + * and for_each_mod_mem_type() skips it.
> + */
> +#define MOD_MEM_CODETAG        MOD_MEM_NUM_TYPES

Ok, it feels a bit hacky but it's probably the simplest way to mark
codetag regions.

> +
>  #define mod_mem_type_is_init(type)     \
>         ((type) =3D=3D MOD_INIT_TEXT ||     \
>          (type) =3D=3D MOD_INIT_DATA ||     \
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index ed26f167be84..2337bf604f58 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -1728,11 +1728,8 @@ static void __layout_sections(struct module *mod, =
struct load_info *info, bool i
>                          * preallocated contiguous memory.
>                          */
>                         if (codetag_needs_module_section(mod, sname, s->s=
h_size)) {
> -                               /*
> -                                * s->sh_entsize won't be used but popula=
te the
> -                                * type field to avoid confusion.
> -                                */
> -                               s->sh_entsize =3D ((unsigned long)(type) =
& SH_ENTSIZE_TYPE_MASK)
> +                               s->sh_entsize =3D ((unsigned long)MOD_MEM=
_CODETAG
> +                                                & SH_ENTSIZE_TYPE_MASK)
>                                                 << SH_ENTSIZE_TYPE_SHIFT;
>                                 continue;
>                         }
> @@ -2815,11 +2812,10 @@ static int move_module(struct module *mod, struct=
 load_info *info)
>                         continue;
>
>                 sname =3D info->secstrings + shdr->sh_name;
> -               /*
> -                * Load codetag sections separately as they might still b=
e used
> -                * after module unload.
> -                */
> -               if (codetag_needs_module_section(mod, sname, shdr->sh_siz=
e)) {
> +
> +               enum mod_mem_type type =3D shdr->sh_entsize >> SH_ENTSIZE=
_TYPE_SHIFT;
> +
> +               if (type =3D=3D MOD_MEM_CODETAG) {
>                         dest =3D codetag_alloc_module_section(mod, sname,=
 shdr->sh_size,
>                                         arch_mod_section_prepend(mod, i),=
 shdr->sh_addralign);
>                         if (WARN_ON(!dest)) {
> @@ -2832,7 +2828,6 @@ static int move_module(struct module *mod, struct l=
oad_info *info)
>                         }
>                         codetag_section_found =3D true;
>                 } else {
> -                       enum mod_mem_type type =3D shdr->sh_entsize >> SH=
_ENTSIZE_TYPE_SHIFT;
>                         unsigned long offset =3D shdr->sh_entsize & SH_EN=
TSIZE_OFFSET_MASK;
>
>                         dest =3D mod->mem[type].base + offset;
> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
> index 461fa87fbb0b..7481180dadd2 100644
> --- a/mm/alloc_tag.c
> +++ b/mm/alloc_tag.c
> @@ -893,6 +893,14 @@ static void *reserve_module_tags(struct module *mod,=
 unsigned long size,
>         if (size < sizeof(struct alloc_tag))
>                 return ERR_PTR(-EINVAL);
>
> +       /*
> +        * Profiling may have been disabled by a concurrent module load.
> +        * Return -EAGAIN so the loader retries with profiling off, layin=
g
> +        * the section out as ordinary module memory.
> +        */
> +       if (!mem_profiling_support)
> +               return ERR_PTR(-EAGAIN);

I think this requires your patch [1] from another patchset to work
correctly, correct? If so, I would suggest sending this patch as part
of that patchset since there is a dependency.

[1] https://lore.kernel.org/all/20260812054105.102637-3-hao.ge@linux.dev/


> +
>         /*
>          * align is always power of 2, so we can use IS_ALIGNED and ALIGN=
.
>          * align 0 or 1 means no alignment, to simplify set to 1.
> --
> 2.25.1
>
