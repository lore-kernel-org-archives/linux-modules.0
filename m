Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B71D28F958
	for <linux-modules@vger.kernel.org>; Wed, 21 May 2025 21:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747861462; cv=none; b=TeAggj8Htq79ZFaPMqlBfZfSrk0PZ+IRuIpSziauISwi/cteBSzGfitiIy89BTs16evRzCvZf/kgQ3c5ZLg/a39EX8cuAEjJRpUDeABmDcsx4d+Qn6tKc/09qeq3KbTQ0lk8XSq9uSy/uFL2Ujv6mKb5lsUEIt1BebA9r3TEO9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747861462; c=relaxed/simple;
	bh=JzJvkSy83wbjXuXRYHa0uZFurnD/wkEJrnn5mEpke7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KupYPecMzFA5Bm9+0I84qHed4jc0o2kqcieQq0n4AMV7pUhvc854aG/HrDA29cFoOSitZeVrnvP+d8ol9D4pjZaTRIFZVry+KflUSjdZbdAV5xswWVe7Q4ZER8uW09WA6EJ5/OuvhJMIdGVRrVmpRxumEwy1m7l3B8sR6sP+ttg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=G90upe9/; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="G90upe9/"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-30e85955bebso993168a91.0
        for <linux-modules@vger.kernel.org>; Wed, 21 May 2025 14:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1747861459; x=1748466259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a8E8wJ2KkrPpB4/N0ejd9jMNIZBIK2MiFknrDOo+EPg=;
        b=G90upe9/oAIDS/7Oinivr+q4+aY9GvoAtFBv+1EA49A9uGIXPNyq6XJwKRIAj1ZQls
         X13a6x8C6WvzrJQH3byvUMeedA0KPA2SQhGu38NxMFmfMfRHXdQphvHCKukAwFsWLi3e
         cKyBqDiHmrcxb4lb/z6LIv/B4L295eYOqamElhclqj4/jUPaCdKXhWd/bdoAmd5cROYA
         lBUe5JtEkZNpd8xKBkKorn/eIL58IvrjO32HtNFvDMMcAjbKA9vdCz3uJ/PnzU24Eqou
         JQrYccMy+6WAK+L+3DwvuTYmjOI44+mpsDCoMepc+BBFs2IzO/8MgIOJb+ks+6qkl6ks
         Inpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747861459; x=1748466259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a8E8wJ2KkrPpB4/N0ejd9jMNIZBIK2MiFknrDOo+EPg=;
        b=sUXl2nFnhdqqEsbVR5+O2wzmawN05cvIV9ZpuWzt3QnL6Fw8KwJVkoUxn4Ij9SC5Jj
         sY6h9W3dnCsjZ0gRuX/m8+TfpsjVpBVcP7RzOWTk1K46eRtLRZJb02VYJDTR8A774Se8
         UAqcU8G5HWoTHbkVlKlHK8m3LcIdkmX+kcnxiYjnAx/j8Mk16SZEHdIzyy/+Nn7vCn7d
         lBWd50K6lqIM0rMA98LuaZFKBQ7EdIG62Iah4OeWxWjpIArU480WVE98Vz6u+p/Djmcr
         JoAyffiG5QnzgTfXA98y4Rnn3wCm3CgjgAye4bTpjCL1+fbBC++MkG/mBQv3wV/+P8DK
         2g6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUya79ghBWAEjPkRKj8rW1goLZ2baaDHrszFC5c5EY2qYjdwuOZtS+ZDTneXfhAByRM9fxqc1O9nWH0o3wa@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+/lltj5RnOAREQFCZuUoCav3xEKYdzOS7g99pNSFlfRJ6QV40
	UV1TRSKJYJIk6kxJTfKhsMGyvoGxgJaJehUZxV/JUQI2vEyUxFPdw7R0V4p9XAgVOF2foGI9b7V
	0CgwGcPNj0YTedf/VCb7bXhNuWMIhQyffeUGDf7R2yQ==
X-Gm-Gg: ASbGncsYPsYZha5CxXLMhATmsX6sfxqQCwneiGcluaAtq3HeAeOL3nlsiRZTwGNQvBH
	QKtw2jaWD1MudUAEwdl0b3zKIWE14m9KNX7wH+3v1xwWYw+PJGxBGMag5ey7CPaGxWMQhTk2z36
	95CPib0gyFiuy4/KeoIeLxuXWkIR/H0U1V
X-Google-Smtp-Source: AGHT+IFrKr2jOATSh5phGB7JDX3d0p2qTLIwC0enPg9MgjlANV5ZNeu2VZnogm+JbvBPSdfOD03MBfWftCNR0tBRptM=
X-Received: by 2002:a17:90b:3142:b0:30e:6ac1:372a with SMTP id
 98e67ed59e1d1-30e7d691099mr12156692a91.7.1747861458366; Wed, 21 May 2025
 14:04:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521160602.1940771-1-surenb@google.com>
In-Reply-To: <20250521160602.1940771-1-surenb@google.com>
From: Casey Chen <cachen@purestorage.com>
Date: Wed, 21 May 2025 14:04:07 -0700
X-Gm-Features: AX0GCFvHkqtUFc-QqB9enzcf-M5GCvbCgMbexO38pxocJAzfC9FE27WWxlR2Ro8
Message-ID: <CALCePG2f+aXvabQiJ-=jYL1c4Z-RZW-=Rkj3LLxXDW+WFXwuBA@mail.gmail.com>
Subject: Re: [PATCH 1/1] alloc_tag: handle module codetag load errors as
 module load failures
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mcgrof@kernel.org, 
	petr.pavlu@suse.com, samitolvanen@google.com, da.gomez@samsung.com, 
	00107082@163.com, linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-mm@kvack.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 9:06=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> Failures inside codetag_load_module() are currently ignored. As a
> result an error there would not cause a module load failure and freeing
> of the associated resources. Correct this behavior by propagating the
> error code to the caller and handling possible errors. With this change,
> error to allocate percpu counters, which happens at this stage, will not
> be ignored and will cause a module load failure and freeing of resources.
> With this change we also do not need to disable memory allocation
> profiling when this error happens, instead we fail to load the module.
>
> Fixes: 10075262888b ("alloc_tag: allocate percpu counters for module tags=
 dynamically")
> Reported-by: Casey Chen <cachen@purestorage.com>
> Closes: https://lore.kernel.org/all/20250520231620.15259-1-cachen@puresto=
rage.com/
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Cc: stable@vger.kernel.org
> ---
>  include/linux/codetag.h |  8 ++++----
>  kernel/module/main.c    |  5 +++--
>  lib/alloc_tag.c         | 12 +++++++-----
>  lib/codetag.c           | 34 +++++++++++++++++++++++++---------
>  4 files changed, 39 insertions(+), 20 deletions(-)
>
> diff --git a/include/linux/codetag.h b/include/linux/codetag.h
> index 0ee4c21c6dbc..5f2b9a1f722c 100644
> --- a/include/linux/codetag.h
> +++ b/include/linux/codetag.h
> @@ -36,8 +36,8 @@ union codetag_ref {
>  struct codetag_type_desc {
>         const char *section;
>         size_t tag_size;
> -       void (*module_load)(struct module *mod,
> -                           struct codetag *start, struct codetag *end);
> +       int (*module_load)(struct module *mod,
> +                          struct codetag *start, struct codetag *end);
>         void (*module_unload)(struct module *mod,
>                               struct codetag *start, struct codetag *end)=
;
>  #ifdef CONFIG_MODULES
> @@ -89,7 +89,7 @@ void *codetag_alloc_module_section(struct module *mod, =
const char *name,
>                                    unsigned long align);
>  void codetag_free_module_sections(struct module *mod);
>  void codetag_module_replaced(struct module *mod, struct module *new_mod)=
;
> -void codetag_load_module(struct module *mod);
> +int codetag_load_module(struct module *mod);
>  void codetag_unload_module(struct module *mod);
>
>  #else /* defined(CONFIG_CODE_TAGGING) && defined(CONFIG_MODULES) */
> @@ -103,7 +103,7 @@ codetag_alloc_module_section(struct module *mod, cons=
t char *name,
>                              unsigned long align) { return NULL; }
>  static inline void codetag_free_module_sections(struct module *mod) {}
>  static inline void codetag_module_replaced(struct module *mod, struct mo=
dule *new_mod) {}
> -static inline void codetag_load_module(struct module *mod) {}
> +static inline int codetag_load_module(struct module *mod) { return 0; }
>  static inline void codetag_unload_module(struct module *mod) {}
>
>  #endif /* defined(CONFIG_CODE_TAGGING) && defined(CONFIG_MODULES) */
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 5c6ab20240a6..9861c2ac5fd5 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -3399,11 +3399,12 @@ static int load_module(struct load_info *info, co=
nst char __user *uargs,
>                         goto sysfs_cleanup;
>         }
>
> +       if (codetag_load_module(mod))
> +               goto sysfs_cleanup;
> +
>         /* Get rid of temporary copy. */
>         free_copy(info, flags);
>
> -       codetag_load_module(mod);
> -
>         /* Done! */
>         trace_module_load(mod);
>
> diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> index 45dae7da70e1..d48b80f3f007 100644
> --- a/lib/alloc_tag.c
> +++ b/lib/alloc_tag.c
> @@ -607,15 +607,16 @@ static void release_module_tags(struct module *mod,=
 bool used)
>         mas_unlock(&mas);
>  }
>
> -static void load_module(struct module *mod, struct codetag *start, struc=
t codetag *stop)
> +static int load_module(struct module *mod, struct codetag *start, struct=
 codetag *stop)
>  {
>         /* Allocate module alloc_tag percpu counters */
>         struct alloc_tag *start_tag;
>         struct alloc_tag *stop_tag;
>         struct alloc_tag *tag;
>
> +       /* percpu counters for core allocations are already statically al=
located */
>         if (!mod)
> -               return;
> +               return 0;
>
>         start_tag =3D ct_to_alloc_tag(start);
>         stop_tag =3D ct_to_alloc_tag(stop);
> @@ -627,12 +628,13 @@ static void load_module(struct module *mod, struct =
codetag *start, struct codeta
>                                 free_percpu(tag->counters);
>                                 tag->counters =3D NULL;
>                         }
> -                       shutdown_mem_profiling(true);
> -                       pr_err("Failed to allocate memory for allocation =
tag percpu counters in the module %s. Memory allocation profiling is disabl=
ed!\n",
> +                       pr_err("Failed to allocate memory for allocation =
tag percpu counters in the module %s\n",
>                                mod->name);
> -                       break;
> +                       return -ENOMEM;
>                 }
>         }
> +
> +       return 0;
>  }
>
>  static void replace_module(struct module *mod, struct module *new_mod)
> diff --git a/lib/codetag.c b/lib/codetag.c
> index de332e98d6f5..650d54d7e14d 100644
> --- a/lib/codetag.c
> +++ b/lib/codetag.c
> @@ -167,6 +167,7 @@ static int codetag_module_init(struct codetag_type *c=
ttype, struct module *mod)
>  {
>         struct codetag_range range;
>         struct codetag_module *cmod;
> +       int mod_id;
>         int err;
>
>         range =3D get_section_range(mod, cttype->desc.section);
> @@ -190,11 +191,20 @@ static int codetag_module_init(struct codetag_type =
*cttype, struct module *mod)
>         cmod->range =3D range;
>
>         down_write(&cttype->mod_lock);
> -       err =3D idr_alloc(&cttype->mod_idr, cmod, 0, 0, GFP_KERNEL);
> -       if (err >=3D 0) {
> -               cttype->count +=3D range_size(cttype, &range);
> -               if (cttype->desc.module_load)
> -                       cttype->desc.module_load(mod, range.start, range.=
stop);
> +       mod_id =3D idr_alloc(&cttype->mod_idr, cmod, 0, 0, GFP_KERNEL);
> +       if (mod_id >=3D 0) {
> +               if (cttype->desc.module_load) {
> +                       err =3D cttype->desc.module_load(mod, range.start=
, range.stop);
> +                       if (!err)
> +                               cttype->count +=3D range_size(cttype, &ra=
nge);
> +                       else
> +                               idr_remove(&cttype->mod_idr, mod_id);
> +               } else {
> +                       cttype->count +=3D range_size(cttype, &range);
> +                       err =3D 0;
> +               }
> +       } else {
> +               err =3D mod_id;
>         }
>         up_write(&cttype->mod_lock);
>

Overall looks good, just one small nit: should we not increase
cttype->count if there is no module_load callback ?
Personally I prefer having tag allocation and counter allocation at
the same place in move_module() by calling something like
codetag_alloc_module_tag_counter(). But your approach looks more
modular. I don't have a strong preference, you can choose what you
want. Thanks!

int codetag_alloc_module_tag_counter(struct module *mod, void *start_addr,
                                        unsigned long size)
{
        struct codetag_type *cttype;
        int ret =3D -ENODEV;

        mutex_lock(&codetag_lock);
        list_for_each_entry(cttype, &codetag_types, link) {
                if (WARN_ON(!cttype->desc.alloc_counter_mem))
                        break;

                down_write(&cttype->mod_lock);
                ret =3D cttype->desc.alloc_counter_mem(mod, start_addr, siz=
e);
                up_write(&cttype->mod_lock);
                break;
        }
        mutex_unlock(&codetag_lock);

        return ret;
}

Casey

> @@ -295,17 +305,23 @@ void codetag_module_replaced(struct module *mod, st=
ruct module *new_mod)
>         mutex_unlock(&codetag_lock);
>  }
>
> -void codetag_load_module(struct module *mod)
> +int codetag_load_module(struct module *mod)
>  {
>         struct codetag_type *cttype;
> +       int ret =3D 0;
>
>         if (!mod)
> -               return;
> +               return 0;
>
>         mutex_lock(&codetag_lock);
> -       list_for_each_entry(cttype, &codetag_types, link)
> -               codetag_module_init(cttype, mod);
> +       list_for_each_entry(cttype, &codetag_types, link) {
> +               ret =3D codetag_module_init(cttype, mod);
> +               if (ret)
> +                       break;
> +       }
>         mutex_unlock(&codetag_lock);
> +
> +       return ret;
>  }
>
>  void codetag_unload_module(struct module *mod)
>
> base-commit: 9f3e87f6c8d4b28b96eb8bddb22d3ba4b846e10b
> --
> 2.49.0.1112.g889b7c5bd8-goog
>
