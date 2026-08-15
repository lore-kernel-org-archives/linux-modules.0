Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0830535C68D
	for <linux-modules@vger.kernel.org>; Sat, 15 Aug 2026 06:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786774545; cv=pass; b=OpIP0rdXu5fAZWQV37KSs4ErZMjumL+xvavUcZgISjIm+A6VrcWfVlSM6Mx95Tc2nUNXJgnhhBDcscPyFUaqdsv2djLXmk2kP7Lsvdlw82qkMGVwfre3slVO8uKVUUcw1QeFAomZBNLA6IsJb7JeTpaIRoiQt3FDmTl9GfyWUXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786774545; c=relaxed/simple;
	bh=RgkMbGkIaaqLvLQiJ+SaFaYos+tOzhXUuLaDbSc3ytI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JHsjMbuoiykwPsMddpHXHtOez/w83lOX1tRVJJ8eHjyVUd8geMYWJSjziiiBsQWNoNGl+RhCDAAMcp/h+JhXhDTsRPQKNyr6jVaIu1gC1B0ocRARb9jXNIDeeTKauUPVlyCtY+X8WXdb6DcgDT03QL1HKeqTxigN2RHXZVpmaA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SsCxvSsx; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SsCxvSsx"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c15a5b265so418041cf.0
        for <linux-modules@vger.kernel.org>; Fri, 14 Aug 2026 23:15:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786774543; cv=none;
        d=google.com; s=arc-20260327;
        b=fTA/ztbKo2UMlHUhLT36d/iK+X2gSVwyPDIFBpmluFS69WBto/tG0vuVa/cuMt+VBY
         74I7e3K5p9EPzAyolco4eFRgK5LKeSUiFQAcm+WS2hiGSKr9wOOBrpoWxQpiSfPn0ZYC
         C+T53brnbViLOROG1CXTTj+UwJBFyz6e6N/37vNOoz1DdGURFUDthnCLOyE9GtVGds7c
         zEO+m92wq5/l0qZ/EVvIgw6QioNcx0ifmvg3GqN8GYKJMiDEP9f9mBE8/atnpccor24s
         joZWZuM0H7Y/QwJF8aT49aQXgH0EE3pKPELAAFqL+hZHw3RKOfL/kfDHzn5ulB5LZlVK
         KWTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CeWrvay8OBGyEYR6j0JzJMygxdhU+kGusNMdV7+ciFk=;
        fh=puArhc8DrlTLKPJMGbKt9hdOwDKEhLeoC4/hup9kjdQ=;
        b=q2vtLyMVoVL192hp2HE21Cz2wUpDoKXJ5zyqmPkip+zzf8sV4Y5wCxUwXOFPu7/3hA
         PNqCHwjcm1ElKZtgsW0Zr1x7vAriOfBKygYN9FYz32A/gT8BYEbkJ/E55ghYTOSEB4v/
         FwkQXYkmJoVwi5VvOjWHlz6S6M6i+7dVbdH4oojpl/Q5uza5H2Y/umkDH+PZ7EYWCq5x
         Sv+NKzwWhVaWN/UMmAY3DAuKUAg4eQEceQNC+t3A3zvqjAkd01WeEb+JfUmwcqoU641U
         DRJ4h6N/BLhdRailZ7rkSWgRZmf0ltXCzT8DtdQftLbYGsghkMTakn29BklMY16WUEBt
         NmXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786774543; x=1787379343; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CeWrvay8OBGyEYR6j0JzJMygxdhU+kGusNMdV7+ciFk=;
        b=SsCxvSsxQ+8VKCcaBhDPR+9n69fPkmyxd77SFXjzDNMWMElsIQNiAKcak6ShJrDQHA
         TFWPveFdJa/O2pZ1U/JFL/JCVV0vy6NTPFa5U9kSELVX20nnzyI8bOznU/SvGZYqQXcV
         mhKN0+zfW1A+/0li5qoArB3nKDnMFiQ/YNbDqe0LXaFXvda1j4MXEzi+RgvL+r5Nxme3
         9UlYHDpVUmTrsak0vaAwjGYQ5engQD+5qLIgSLO1/Te/9tmg+2Al9vN8w1ol9N7FqRQM
         H7q1OZvJYOkMolIAJStGZz2Ce8S61OiEuXnhzco44Pl4HyFnrHcprIPVl49D6ZFG3cqJ
         1qiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786774543; x=1787379343;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CeWrvay8OBGyEYR6j0JzJMygxdhU+kGusNMdV7+ciFk=;
        b=tUh3UAC/HNxMo5tDoVVrBz0kovPYjhIV/lqCKaqQHOpy6PO5YM/ImS6RHB5xsXsJR6
         +HRZhknHZvwbL0IbRE2HxHvPTvtIrGNb/AZrG5haVP5zn7UdlRU7bLRuZ5iHX4O+0o7/
         GSU0fXJmBbSqDcVU4bCdmbux0k4MDz9bGhQTb3ULV5QSCXoAZXU/3wATPtr+tLu751RY
         H5Np+7F+jKr0ENucdcX+Ibf6dgIZ9PxGkVSGnTQuIsYJqRMJkvVfyxKkJAvEAkZxKPO5
         tmV9fb6YJKgyyHF7evZ8moakytNzV9z3XbNte79wMOgy/twYCO2UBpuQG3hDMIVGENC7
         IUPQ==
X-Forwarded-Encrypted: i=1; AHgh+RrkYUnXpRpMMh3vaRtVp0SHqb4GNcm1Xmsjqx9DbqZemjjuEgZO9sjE2G3CgL4vU9CzHHkRz5xjMl0izA6K@vger.kernel.org
X-Gm-Message-State: AOJu0YykZyS1dEKFXYY9rAoFzY+W7VvFnxl2uCWI1/c2qMUXD8USA2Yb
	fi7sheTHzh+nsI8AXVUfiVYmweLOYZr1WgRcVYUypiGylC6UUWZvnHoSXNXVAhhrEOtKVq1FwzG
	YhUg1faz1OQ8tbh72AR1hJKkR7Jv1gRU7fDO2UWaY
X-Gm-Gg: AR+sD10yVvO15z1jXgj6QnzW1Iw1JyHr2VahfIZLBeNzZ2D4r53CuIcr3OqRKYg8Zel
	/93KUnyMVUM6T+tzZghC7cA7c64NkBuFI8v18G8ch3VsK7O1Wshc/sogQ15Oxlq9Fdeq2odlQHv
	6MjiuTu2N3hSkbCPBkccjHxSv4aP0jxkcD5wgqHErKr2awBPBznCMI4slSCjU1eQ3cAMRxQtlb+
	OMVAlk5dzVg7qg2FLxJSMkoaBjEe8YGNQ+8n59u1AYRcfODUZqlMV4fq0Ao/g+iBOe9bi8FcTfZ
	j5LIyqFEOtubPCIVU/QFL4Wi6Bq9ticDwJsUodAFW/GHnIuIcFmg5T1dGzA=
X-Received: by 2002:a05:622a:4c0f:b0:51c:ae6:a57 with SMTP id
 d75a77b69052e-52d862f6fe8mr30547411cf.11.1786774542180; Fri, 14 Aug 2026
 23:15:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813093421.135230-1-hao.ge@linux.dev> <20260813093421.135230-2-hao.ge@linux.dev>
In-Reply-To: <20260813093421.135230-2-hao.ge@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 14 Aug 2026 23:15:31 -0700
X-Gm-Features: AcwNN1VOSUdc7S9dQw7NoH9eXwXWzpOpXmtX7H1BYFB9QOUwq4hMXPOjuGhLgWM
Message-ID: <CAJuCfpHAzhCC1Sx3uJr7kbhBzc7RFqwLhMyjo04hqZz=HBJH8Q@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] alloc_tag: skip percpu counter allocation when
 profiling is disabled
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
> After shutdown_mem_profiling() clears mem_profiling_support,
> needs_section_mem() returns false, so later modules have their codetag
> section placed as regular data and never enter the alloc_tag maple tree.
> codetag_load_module() still called load_module(), which allocated a percp=
u
> counter for every tag; release_module_tags() could not find these modules
> on unload, so the counters leaked.
>
> Return CODETAG_MODULE_EXCLUDED from load_module() when profiling is off:
> codetag_module_init() drops the module's cmod and no counters are
> allocated. codetag_unload_module() now always calls free_section_mem(),
> since an excluded module may still hold a reserved section.
>
> Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compress=
ion")
> Signed-off-by: Hao Ge <hao.ge@linux.dev>

Thanks for the fix. I think it could be done simpler, see below.

> ---
>  include/linux/codetag.h | 4 ++++
>  lib/codetag.c           | 8 +++++---
>  mm/alloc_tag.c          | 8 ++++++--
>  3 files changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/codetag.h b/include/linux/codetag.h
> index a25a085c2df1..88081c618673 100644
> --- a/include/linux/codetag.h
> +++ b/include/linux/codetag.h
> @@ -52,6 +52,10 @@ struct codetag_type_desc {
>  #endif
>  };
>
> +/* module_load() return values */
> +#define CODETAG_MODULE_LOAD    0       /* module loads with its tags */
> +#define CODETAG_MODULE_EXCLUDED        1       /* module loads without i=
ts tags */

I see no reason for adding these special values. You could simply
return -ENOTSUP when profiling is disabled.

> +
>  struct codetag_iterator {
>         struct codetag_type *cttype;
>         struct codetag_module *cmod;
> diff --git a/lib/codetag.c b/lib/codetag.c
> index a9cda4c962a3..8506ecab9ea7 100644
> --- a/lib/codetag.c
> +++ b/lib/codetag.c
> @@ -238,9 +238,10 @@ static int codetag_module_init(struct codetag_type *=
cttype, struct module *mod)
>         }
>         up_write(&cttype->mod_lock);
>
> -       if (err < 0) {
> +       if (err) {
> +               /* Error or excluded: cmod is dropped, free it. */

IIUC here you want to call kfree() if profiling got disabled. If you
return -ENOTSUP instead of CODETAG_MODULE_EXCLUDED then this condition
does not need to change.

>                 kfree(cmod);
> -               return err;
> +               return err < 0 ? err : 0;

Here you can do:
                    if (err && err !=3D -ENOTSUP)
                            return err;
                   return 0;

>         }
>
>         return 0;
> @@ -388,7 +389,8 @@ void codetag_unload_module(struct module *mod)
>                         ++cttype->content_id;
>                 }
>                 up_write(&cttype->mod_lock);
> -               if (found && cttype->desc.free_section_mem)
> +               /* an excluded module may still hold section memory */
> +               if (cttype->desc.free_section_mem)
>                         cttype->desc.free_section_mem(mod, true);
>         }
>         mutex_unlock(&codetag_lock);
> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
> index 0a7b657fe2de..461fa87fbb0b 100644
> --- a/mm/alloc_tag.c
> +++ b/mm/alloc_tag.c
> @@ -977,9 +977,13 @@ static int load_module(struct module *mod, struct co=
detag *start, struct codetag
>         struct alloc_tag *stop_tag;
>         struct alloc_tag *tag;
>
> +       /* Profiling disabled: load the module but exclude its tags. */
> +       if (!mem_profiling_support)
> +               return CODETAG_MODULE_EXCLUDED;

Return -ENOTSUP here.



> +
>         /* percpu counters for core allocations are already statically al=
located */
>         if (!mod)
> -               return 0;
> +               return CODETAG_MODULE_LOAD;
>
>         start_tag =3D ct_to_alloc_tag(start);
>         stop_tag =3D ct_to_alloc_tag(stop);
> @@ -1002,7 +1006,7 @@ static int load_module(struct module *mod, struct c=
odetag *start, struct codetag
>                  */
>                 kmemleak_ignore_percpu(tag->counters);
>         }
> -       return 0;
> +       return CODETAG_MODULE_LOAD;
>  }
>
>  static void replace_module(struct module *mod, struct module *new_mod)
> --
> 2.25.1
>
