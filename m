Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA1B34AB1D
	for <linux-modules@vger.kernel.org>; Fri, 18 Sep 2026 00:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789692835; cv=pass; b=X0y+9D3WDWKJu5uBIpirQF0ZNjC4YQgVLZOBQetKN/QTecbLZEqAGpCJ3q+1Fnb9x+hqNrbF6VftFC/wGfI18V6pekj70E6NZAMjA7I/QXYPk/CIzqIzX81DwCgwzrucMZWqWaR6YVJkJ90d+SRYJIni/dtl0i3Kahm/AWrVtsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789692835; c=relaxed/simple;
	bh=+0FEERhuCrNALhxt5BYqoKVl7HbeqQe4QtB0NTjTiQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KeoQvF5FMKFGXW4TAEJ4KEO7tozM3c6N+x5/1H8/JPbMTPEM6NMgbtbUvACpBfYgBptOtxZLv0Kv8JIOyviDovr0spbIw7AcDkMjeXLG4YHkH6IU3EeOPoFYquMVBmHqQmHaci6583pB2W4+TR7RijamiejsGpEheq2hEnJqypY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r3i0Z6xw; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r3i0Z6xw"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-53113d72966so101691cf.1
        for <linux-modules@vger.kernel.org>; Thu, 17 Sep 2026 17:53:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789692831; cv=none;
        d=google.com; s=arc-20260327;
        b=IKcyOz768lr2mxHs+1Dd8+H0G7kYosakC7YAi/ew3UjdVSofzgObjcHEaByv8+I9gG
         JAWFxbOzl2d/dfjOuQ6o5mt0lfZ1UywYWpHFCTqEyaCQEDxPFr0cfXQ7Rtwp9HaTDNCt
         rvt72uLKktMHYYgMM4UmCorIKC3xzwBClq/MoW74ZakKiR7IlSke+s1xUZ42OUFVY1uz
         vTGUM1o9rOZs/GpqyOwkinREeax9WtArf/I3MK8NhHCr9tFdfOtudH+FD+Qhk2oe1K74
         9xkhSmR4nmOyS0FDIC8aLfzcBXzCYXiKJCMohFResVwPs+H/WdbdGXBpTCf873EuceWc
         uF2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pChmIbk5dvBz2x+ATGHEFGjZSAwLQf4D4OxFleYq/PI=;
        fh=A3r+Sv53pMMMWoaSXILXugZJOyYZceZTULdt/M4eCzI=;
        b=R5N36ipVP7N2Fp8fP+UcaPd+ZU0frIcQ6j28Jv0HFOmpgyM2Y6y5uYXWhDtByBGtXY
         GwohKz0TsPD/muq6nePnPMAssPOy81qS4MXESfiJG0UYrb7QmPZHPm1K3AJfS6i4VF4C
         wXtvMrKEFd2Li4yEo59jHYqQiQDDVZL5PPFVPiNLXg1eRyq0WQHRwDS60r/d31Y681f4
         QuxWQKq0MG0SgjWUQHHNyQz10PPYt/NGjRQlJKh8xn6MiByCTPB0dTk3u5ugIhU2/Zib
         43jSQt8yj/J94j9cclIpWBlkPcfNILJVq5ZA7SBR+04e7oijezMO/4AFiAZQArUPfDj/
         P+Hw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789692831; x=1790297631; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pChmIbk5dvBz2x+ATGHEFGjZSAwLQf4D4OxFleYq/PI=;
        b=r3i0Z6xwdGZnSt9mDh2RVZCRb25qtWmuHncKV3cCVzvoZ28oqbQ6Dcndu1gVfBd44j
         otvXSfSaOTwIgK+o29nOvfkBGYCytVxFZrcFqIMCt7MYDXzkc3a4LvKQoiB3WAW/mEsg
         DuWkPt8ERVcQIawIJXVDSqrmlhj1LT3Rgia0plnemp4ngRXYpyolkuVakeGrpuITkSlZ
         F8q0UFlcPJU54oKSuJXDmdkKjukHLyk/3/iPc9urCEHu5NQNewcGuI1jDutf4zFFED9x
         3i11Kx/xTVzsxUyfOH44DZ/Caa1CTzm4OV6i0a+4Xnx9CRJ9eMpBa9zYbZumpKfCBgiv
         bgeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789692831; x=1790297631;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pChmIbk5dvBz2x+ATGHEFGjZSAwLQf4D4OxFleYq/PI=;
        b=YbuO4tNPdRQ7M4YIyLKtGqPmAKuB0H3WeEEbJycM47/YXPuVWg/4H98WK4D9Iy5SZy
         S5aOgYvpdD0OHSdxV6l/DG52kgHntaO4w3fexGtvsGcmQazalPjq4u53s6diwB/JAQdV
         wtbNxtM1WDPp+1RzwY8BUSqwpWkVwELZFqDBsWUeD9mcdUv3BLvKR1+r5ZFKmRVQE8FL
         e9JxmzpuFeTzLL+tmQRXNEJezlRs/bRkt9vw2ocWg7DgJV5EB7dwrTAxkPSMjXzpuY1z
         kQSXYIjlKSOCbpiCgn/uIWNKp9kOajxCYzPKtITKeGXpbOobH7tJbf1smYSSzk/7JY6Y
         PXUw==
X-Forwarded-Encrypted: i=1; AKwUvBxU84cddCEj7lGsZ0/S7RpYD6z+JDXeVYxmlxgBvw7DjX4aN4xUO0lVyMz/zBNZfetYyAvc6FWPSpnYW7r5@vger.kernel.org
X-Gm-Message-State: AFuF++nl78a0yuKxpzMPyFdfn9twcHOV7bIfBeyJ7mKQJodFCTCuh8YS
	FReYMpy6Sl8+X4TbijVkg1YQo3q8sikx5nFCQ1mvD6+RIBD6N71hPoNxLB5yPoLAVyu/rQva2W9
	KFHmzQcwNdd2rg2jsvrddpCFNZlk7AAtZPnEU2Txi
X-Gm-Gg: AYBFou3f15S5CS+GZo0NQmpgt9Me2iaJBUDMyrj7BH3rcNrDfzgropaWP6QRw3SSuus
	NGG5N3VrrN/7p/gbu6/mkAuEsoIiOClq1o5/jh7yT0QaK8KR4hEb6oqBIH4pfmGXYJvIeZvIl/l
	rYYzjJrLAWzROCTgZvtRr/Hca744bjtIrDiIWDI+16OZvw7jeyL/gWfzuZ9kGX2OgLtg32APaRQ
	gncjsvKq2pwi9vCGfOZlyqYUTbHwHEqIFzh1jc0Jmf/zL4jvPKccgxOohfWRAR2GekHEIsl+GCh
	jPYBGW+xM4ipxcBFbHwCH9uE/jps9KemDjsVV36Eo2CCFlbniAij30CX7QlElVho
X-Received: by 2002:a05:622a:649:b0:52f:9ed4:8d74 with SMTP id
 d75a77b69052e-5329d7ebce3mr7543761cf.14.1789692830152; Thu, 17 Sep 2026
 17:53:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915070001.113559-1-hao.ge@linux.dev> <20260915070001.113559-6-hao.ge@linux.dev>
In-Reply-To: <20260915070001.113559-6-hao.ge@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 17 Sep 2026 17:53:39 -0700
X-Gm-Features: AcwNN1VY0P1eKa2RzQfSlte4wi4uAKsbNqye2Ulhzad_L0NMHnJfbc2fVWd5zEE
Message-ID: <CAJuCfpFKGxOy9W+ZY9KasU5YaDVG4kbGsV6AYb2NNRyW4gT0mw@mail.gmail.com>
Subject: Re: [PATCH v10 5/6] alloc_tag: skip percpu counter allocation when
 profiling is disabled
To: Hao Ge <hao.ge@linux.dev>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-modules@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 11:59=E2=80=AFPM Hao Ge <hao.ge@linux.dev> wrote:
>
> After shutdown_mem_profiling() clears mem_profiling_support,
> needs_section_mem() returns false, so later modules have their codetag
> section placed as regular data and never enter the alloc_tag maple tree.
> codetag_load_module() still called load_module(), which allocated a percp=
u
> counter for every tag; release_module_tags() could not find these modules
> on unload, so the counters leaked.
>
> Return -EOPNOTSUPP from load_module() when profiling is off:
> codetag_module_init() drops the module's cmod, no counters are allocated
> and the module loads without its tags. codetag_unload_module() now always
> calls free_section_mem(), since a module whose module_load() returned
> -EOPNOTSUPP is not in the idr but may still hold a reserved section.
>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compress=
ion")
> Cc: stable@vger.kernel.org
> Suggested-by: Suren Baghdasaryan <surenb@google.com>
> Acked-by: Suren Baghdasaryan <surenb@google.com>

Yeah, I guess I didn't think about alternatives...

When mem_profiling_support=3Dfalse, why can't load_module() skip
allocating percpu counters, zero out the whole area between start_tag
and stop_tag and return 0 as success (mem_profiling_support is not
enabled, so we acted accordingly)?
Module will be added into maple tree and later codetag_unload_module()
will find the module, call release_module_tags() (which is a NOOP
because tag->counter=3D=3DNULL) and finally call free_section_mem(). This
seems more natural than special-casing with EOPNOTSUPP. WDYT?

> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> ---
>  lib/codetag.c  | 10 ++++++++--
>  mm/alloc_tag.c |  4 ++++
>  2 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/lib/codetag.c b/lib/codetag.c
> index a9cda4c962a3..a0b600720afc 100644
> --- a/lib/codetag.c
> +++ b/lib/codetag.c
> @@ -240,7 +240,9 @@ static int codetag_module_init(struct codetag_type *c=
ttype, struct module *mod)
>
>         if (err < 0) {
>                 kfree(cmod);
> -               return err;
> +               /* -EOPNOTSUPP means we can load the module without its t=
ag. */
> +               if (err !=3D -EOPNOTSUPP)
> +                       return err;
>         }
>
>         return 0;
> @@ -388,7 +390,11 @@ void codetag_unload_module(struct module *mod)
>                         ++cttype->content_id;
>                 }
>                 up_write(&cttype->mod_lock);
> -               if (found && cttype->desc.free_section_mem)
> +               /*
> +                * A module whose module_load() returned -EOPNOTSUPP is n=
ot
> +                * in the idr but may still hold reserved section memory.
> +                */
> +               if (cttype->desc.free_section_mem)
>                         cttype->desc.free_section_mem(mod, true);
>         }
>         mutex_unlock(&codetag_lock);
> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
> index 5836803898ad..1ca0409b492b 100644
> --- a/mm/alloc_tag.c
> +++ b/mm/alloc_tag.c
> @@ -988,6 +988,10 @@ static int load_module(struct module *mod, struct co=
detag *start, struct codetag
>         struct alloc_tag *stop_tag;
>         struct alloc_tag *tag;
>
> +       /* Profiling disabled: load the module without its tags. */
> +       if (!mem_profiling_support)
> +               return -EOPNOTSUPP;
> +
>         /* percpu counters for core allocations are already statically al=
located */
>         if (!mod)
>                 return 0;
> --
> 2.25.1
>
