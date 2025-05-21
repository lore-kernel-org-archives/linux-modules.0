Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A464B1E76
	for <linux-modules@vger.kernel.org>; Wed, 21 May 2025 21:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747863058; cv=none; b=WEyctQHbzLM4r/M/WUnEVGDn69e2GeFHNU14s9NPSaAKzTVHy7S4gzexspzuWETNk9moDq00+drV3i04aQwDYUA8sqNKVQ73R03ci4uirV/HTL93X4EYgjqgvEbawOmnLsGUHXpv6rYf/TKctz7M4+FrsoddAbtyHde5RJQzYEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747863058; c=relaxed/simple;
	bh=4IsUBObZyCqxdYnBUATUNrl8vZQG6USZkZ1mnqy7LKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W+H2ONjUDct2TTzKjpqZ7gaG1TIeO+qv3kaTemVITZTCH20/9Z5Flalwz0llQDpq7SPO131X4QKV+irQqyV/MXMCbrFDLCHb5SagRefBt6YD4uguV4nOSbonCA+eVmnqW0E1MyXFvyMmVGfJxfU6JepYHR55gWNznd6uN9gjQEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=06CXl+IK; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="06CXl+IK"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-47e9fea29easo1911771cf.1
        for <linux-modules@vger.kernel.org>; Wed, 21 May 2025 14:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747863056; x=1748467856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWdOovJf964fqY7rP1f70MsVKty0VjlMR4j1MeuRSSY=;
        b=06CXl+IKWehGh6KpVDoN2AW82P8eJQ02m9fqn8ycn89kH+AZKKHxq5iAGZ7HKuKjts
         PrA8WIXRWGAAY5yoD9QLrKf6Utc25ta82zTOLtkiW8uFrE+YxJvdHoGl6HVH/oIDhrek
         lrnA9ZqdawlvW8v5q4Iu767tGV2Os6WVd0CJczHeEHzrWrAmRroNKhNcmXxpc4lzapL9
         5JkcSzexYPMgpS+OAdzryT2E6ZHXPo5NaWe5c9jkCnEORmRaO3wymIsMrFV+UJqbXFjd
         rr+97BptMOUOtSfUKZPWDx/Zwf4HXUjGItaEQo9XdhaF1lGrvJCSExa6XH2RBb6U970w
         4Cog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747863056; x=1748467856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bWdOovJf964fqY7rP1f70MsVKty0VjlMR4j1MeuRSSY=;
        b=ogQN4Po3vYW6VxPI5LfMZswixyhq+Jhpzo3rdz20/2/WoSVBNnqSeAETGwdBvuRhK8
         NkWVKSBHf1Zrj3ckiKF7G+pX0IaTrO4SIX+CGGHXdZ4+reajluoFHEmjDRTyQYpsvuQ1
         schfhCmQ1UjdWv43BW09MKafLgMqBmGyc+BIsGyXjh0K2DDjeGsCB0qsFNfGMLRsZ8W3
         1pSF0MmISR0mdynQ9ZRg+JMtnLWX3jDkdqZM79Si0C3SBH9QaWPXr6WnmMcZfcnGeO68
         /Cq6BA/uX+opizhSRF/nvHPaXstIOds2mvlxrASuxs0NgrPg1ZOGmhhua96X6T1g7n5P
         iTPg==
X-Forwarded-Encrypted: i=1; AJvYcCUA3/D+viZYFxxxM11Q+jelRDeqpGdfkXHHMNI2I8zkIQeDOWpwdjtdfZzGdh7HXX7AqE7IhWiBWPutEQPT@vger.kernel.org
X-Gm-Message-State: AOJu0YxELxZicH1ZyTPcN6xMttUoeYgidYo20GjRCQbSA0Irj+NpKMEl
	x5k2f4lewDaJQ+JPgFqPUsckBA2vrxwTR9IEywjDRuJDef2UvWUFSMpDwsgVnYE3x0qifM2zDrW
	JYf3aCe13gqOxgAOZg3KTPL+Sp4ZXxZjBhW6A3Z3i
X-Gm-Gg: ASbGncvG4oM1tL+0jcKcOE3YHOmOwBoPBqLA6L+xnp5vPzbXtf7Tf1QHXFtiuq4fNRM
	kugbpWkfCpAy5RCRLAwOoqbInLynQ3VOy/qHNWePPwEMdW507WunOmMN7zMf0+KJ6yh7H3GUhv3
	cJDKC/hdTQqLTbfEWgjQF29CNOEuVY+X/eGs1qTiCL6Q==
X-Google-Smtp-Source: AGHT+IGHW1Le+Th0rF31ilk1bMi7uSr/wQssgDMLiHfYo3VTiUKmx6GZR0ECB2AxON+cYr0kcIlo3a3/BRVv1Ddt61I=
X-Received: by 2002:a05:622a:101:b0:494:4aa0:ad5b with SMTP id
 d75a77b69052e-49cefbe04a6mr422601cf.2.1747863055480; Wed, 21 May 2025
 14:30:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521160602.1940771-1-surenb@google.com> <CALCePG2f+aXvabQiJ-=jYL1c4Z-RZW-=Rkj3LLxXDW+WFXwuBA@mail.gmail.com>
In-Reply-To: <CALCePG2f+aXvabQiJ-=jYL1c4Z-RZW-=Rkj3LLxXDW+WFXwuBA@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 21 May 2025 14:30:43 -0700
X-Gm-Features: AX0GCFsaZ4v0KFQhyMLGDjF1IPg4de-UDXi21dVKxL3pD1IRz55dfTMPWlc_JzU
Message-ID: <CAJuCfpHVXa=ou=y9oJHLJPCL_x_wbhuMK6YGyaDBema9qpF=Wg@mail.gmail.com>
Subject: Re: [PATCH 1/1] alloc_tag: handle module codetag load errors as
 module load failures
To: Casey Chen <cachen@purestorage.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mcgrof@kernel.org, 
	petr.pavlu@suse.com, samitolvanen@google.com, da.gomez@samsung.com, 
	00107082@163.com, linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-mm@kvack.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 2:04=E2=80=AFPM Casey Chen <cachen@purestorage.com>=
 wrote:
>
> On Wed, May 21, 2025 at 9:06=E2=80=AFAM Suren Baghdasaryan <surenb@google=
.com> wrote:
> >
> > Failures inside codetag_load_module() are currently ignored. As a
> > result an error there would not cause a module load failure and freeing
> > of the associated resources. Correct this behavior by propagating the
> > error code to the caller and handling possible errors. With this change=
,
> > error to allocate percpu counters, which happens at this stage, will no=
t
> > be ignored and will cause a module load failure and freeing of resource=
s.
> > With this change we also do not need to disable memory allocation
> > profiling when this error happens, instead we fail to load the module.
> >
> > Fixes: 10075262888b ("alloc_tag: allocate percpu counters for module ta=
gs dynamically")
> > Reported-by: Casey Chen <cachen@purestorage.com>
> > Closes: https://lore.kernel.org/all/20250520231620.15259-1-cachen@pures=
torage.com/
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Cc: stable@vger.kernel.org
> > ---
> >  include/linux/codetag.h |  8 ++++----
> >  kernel/module/main.c    |  5 +++--
> >  lib/alloc_tag.c         | 12 +++++++-----
> >  lib/codetag.c           | 34 +++++++++++++++++++++++++---------
> >  4 files changed, 39 insertions(+), 20 deletions(-)
> >
> > diff --git a/include/linux/codetag.h b/include/linux/codetag.h
> > index 0ee4c21c6dbc..5f2b9a1f722c 100644
> > --- a/include/linux/codetag.h
> > +++ b/include/linux/codetag.h
> > @@ -36,8 +36,8 @@ union codetag_ref {
> >  struct codetag_type_desc {
> >         const char *section;
> >         size_t tag_size;
> > -       void (*module_load)(struct module *mod,
> > -                           struct codetag *start, struct codetag *end)=
;
> > +       int (*module_load)(struct module *mod,
> > +                          struct codetag *start, struct codetag *end);
> >         void (*module_unload)(struct module *mod,
> >                               struct codetag *start, struct codetag *en=
d);
> >  #ifdef CONFIG_MODULES
> > @@ -89,7 +89,7 @@ void *codetag_alloc_module_section(struct module *mod=
, const char *name,
> >                                    unsigned long align);
> >  void codetag_free_module_sections(struct module *mod);
> >  void codetag_module_replaced(struct module *mod, struct module *new_mo=
d);
> > -void codetag_load_module(struct module *mod);
> > +int codetag_load_module(struct module *mod);
> >  void codetag_unload_module(struct module *mod);
> >
> >  #else /* defined(CONFIG_CODE_TAGGING) && defined(CONFIG_MODULES) */
> > @@ -103,7 +103,7 @@ codetag_alloc_module_section(struct module *mod, co=
nst char *name,
> >                              unsigned long align) { return NULL; }
> >  static inline void codetag_free_module_sections(struct module *mod) {}
> >  static inline void codetag_module_replaced(struct module *mod, struct =
module *new_mod) {}
> > -static inline void codetag_load_module(struct module *mod) {}
> > +static inline int codetag_load_module(struct module *mod) { return 0; =
}
> >  static inline void codetag_unload_module(struct module *mod) {}
> >
> >  #endif /* defined(CONFIG_CODE_TAGGING) && defined(CONFIG_MODULES) */
> > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > index 5c6ab20240a6..9861c2ac5fd5 100644
> > --- a/kernel/module/main.c
> > +++ b/kernel/module/main.c
> > @@ -3399,11 +3399,12 @@ static int load_module(struct load_info *info, =
const char __user *uargs,
> >                         goto sysfs_cleanup;
> >         }
> >
> > +       if (codetag_load_module(mod))
> > +               goto sysfs_cleanup;
> > +
> >         /* Get rid of temporary copy. */
> >         free_copy(info, flags);
> >
> > -       codetag_load_module(mod);
> > -
> >         /* Done! */
> >         trace_module_load(mod);
> >
> > diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> > index 45dae7da70e1..d48b80f3f007 100644
> > --- a/lib/alloc_tag.c
> > +++ b/lib/alloc_tag.c
> > @@ -607,15 +607,16 @@ static void release_module_tags(struct module *mo=
d, bool used)
> >         mas_unlock(&mas);
> >  }
> >
> > -static void load_module(struct module *mod, struct codetag *start, str=
uct codetag *stop)
> > +static int load_module(struct module *mod, struct codetag *start, stru=
ct codetag *stop)
> >  {
> >         /* Allocate module alloc_tag percpu counters */
> >         struct alloc_tag *start_tag;
> >         struct alloc_tag *stop_tag;
> >         struct alloc_tag *tag;
> >
> > +       /* percpu counters for core allocations are already statically =
allocated */
> >         if (!mod)
> > -               return;
> > +               return 0;
> >
> >         start_tag =3D ct_to_alloc_tag(start);
> >         stop_tag =3D ct_to_alloc_tag(stop);
> > @@ -627,12 +628,13 @@ static void load_module(struct module *mod, struc=
t codetag *start, struct codeta
> >                                 free_percpu(tag->counters);
> >                                 tag->counters =3D NULL;
> >                         }
> > -                       shutdown_mem_profiling(true);
> > -                       pr_err("Failed to allocate memory for allocatio=
n tag percpu counters in the module %s. Memory allocation profiling is disa=
bled!\n",
> > +                       pr_err("Failed to allocate memory for allocatio=
n tag percpu counters in the module %s\n",
> >                                mod->name);
> > -                       break;
> > +                       return -ENOMEM;
> >                 }
> >         }
> > +
> > +       return 0;
> >  }
> >
> >  static void replace_module(struct module *mod, struct module *new_mod)
> > diff --git a/lib/codetag.c b/lib/codetag.c
> > index de332e98d6f5..650d54d7e14d 100644
> > --- a/lib/codetag.c
> > +++ b/lib/codetag.c
> > @@ -167,6 +167,7 @@ static int codetag_module_init(struct codetag_type =
*cttype, struct module *mod)
> >  {
> >         struct codetag_range range;
> >         struct codetag_module *cmod;
> > +       int mod_id;
> >         int err;
> >
> >         range =3D get_section_range(mod, cttype->desc.section);
> > @@ -190,11 +191,20 @@ static int codetag_module_init(struct codetag_typ=
e *cttype, struct module *mod)
> >         cmod->range =3D range;
> >
> >         down_write(&cttype->mod_lock);
> > -       err =3D idr_alloc(&cttype->mod_idr, cmod, 0, 0, GFP_KERNEL);
> > -       if (err >=3D 0) {
> > -               cttype->count +=3D range_size(cttype, &range);
> > -               if (cttype->desc.module_load)
> > -                       cttype->desc.module_load(mod, range.start, rang=
e.stop);
> > +       mod_id =3D idr_alloc(&cttype->mod_idr, cmod, 0, 0, GFP_KERNEL);
> > +       if (mod_id >=3D 0) {
> > +               if (cttype->desc.module_load) {
> > +                       err =3D cttype->desc.module_load(mod, range.sta=
rt, range.stop);
> > +                       if (!err)
> > +                               cttype->count +=3D range_size(cttype, &=
range);
> > +                       else
> > +                               idr_remove(&cttype->mod_idr, mod_id);
> > +               } else {
> > +                       cttype->count +=3D range_size(cttype, &range);
> > +                       err =3D 0;
> > +               }
> > +       } else {
> > +               err =3D mod_id;
> >         }
> >         up_write(&cttype->mod_lock);
> >
>
> Overall looks good, just one small nit: should we not increase
> cttype->count if there is no module_load callback ?

No, a codetag type might not require module_load callback but can
still have a non-empty tags section.

> Personally I prefer having tag allocation and counter allocation at
> the same place in move_module() by calling something like
> codetag_alloc_module_tag_counter(). But your approach looks more
> modular. I don't have a strong preference, you can choose what you
> want. Thanks!

Yeah, I try to keep the codetagging footprint in the module loading
code as small as possible, so let's avoid adding more hooks there.
Thanks,
Suren.

>
> int codetag_alloc_module_tag_counter(struct module *mod, void *start_addr=
,
>                                         unsigned long size)
> {
>         struct codetag_type *cttype;
>         int ret =3D -ENODEV;
>
>         mutex_lock(&codetag_lock);
>         list_for_each_entry(cttype, &codetag_types, link) {
>                 if (WARN_ON(!cttype->desc.alloc_counter_mem))
>                         break;
>
>                 down_write(&cttype->mod_lock);
>                 ret =3D cttype->desc.alloc_counter_mem(mod, start_addr, s=
ize);
>                 up_write(&cttype->mod_lock);
>                 break;
>         }
>         mutex_unlock(&codetag_lock);
>
>         return ret;
> }
>
> Casey
>
> > @@ -295,17 +305,23 @@ void codetag_module_replaced(struct module *mod, =
struct module *new_mod)
> >         mutex_unlock(&codetag_lock);
> >  }
> >
> > -void codetag_load_module(struct module *mod)
> > +int codetag_load_module(struct module *mod)
> >  {
> >         struct codetag_type *cttype;
> > +       int ret =3D 0;
> >
> >         if (!mod)
> > -               return;
> > +               return 0;
> >
> >         mutex_lock(&codetag_lock);
> > -       list_for_each_entry(cttype, &codetag_types, link)
> > -               codetag_module_init(cttype, mod);
> > +       list_for_each_entry(cttype, &codetag_types, link) {
> > +               ret =3D codetag_module_init(cttype, mod);
> > +               if (ret)
> > +                       break;
> > +       }
> >         mutex_unlock(&codetag_lock);
> > +
> > +       return ret;
> >  }
> >
> >  void codetag_unload_module(struct module *mod)
> >
> > base-commit: 9f3e87f6c8d4b28b96eb8bddb22d3ba4b846e10b
> > --
> > 2.49.0.1112.g889b7c5bd8-goog
> >
