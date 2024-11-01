Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF0636B
	for <linux-modules@vger.kernel.org>; Fri,  1 Nov 2024 00:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730419439; cv=none; b=l2Vw2aB74BH3d9cc8noaYXLvo5RHDkUsykxqsWnQrdNQSexIOSnum4iZgwINZfV0OLJtOnhGVVzoeG3JsBBjkVNJZtt+cCzsIDh3U66cCPNKTQpMilGUz6Bri2+bTX8f2nAKSLSmIzwtzaEG4UUoryqA4CTSnf5DIw7dpf2h99g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730419439; c=relaxed/simple;
	bh=/x5r+9UVt6Gu1GzHmtnpMxF9bs3EmZWZaJi9964n50k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bKp3QadP1x2n7cqdy5Dp9a8tUb0yPKfwObeBNLvhBqq8exyOwebxeQRF2xLY/J7pKc1ZKw7iZkyxciEMmKmy9YaPlXlgCXV0gcnxe5PeN/ZzVSAuUDkdPDzUP/CEMcJk+0ad7bZg+G6EyMtYiA27g9q3r2u9w1Z4QD/5Z9vjk9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=plGqcSRn; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="plGqcSRn"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-460a8d1a9b7so61091cf.1
        for <linux-modules@vger.kernel.org>; Thu, 31 Oct 2024 17:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730419433; x=1731024233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=13QqxlmOsu4mjaQ0FqLVXCcsygHFthO25baKCZAV/U0=;
        b=plGqcSRn3RVPlkzP5VaheSYuNvkMz2Q9GoDkWzwuKyXwW/dLzJUYBzy30HP8PDeQv+
         da2Si9eUO/8OUrhftZ16roeGbCz7xjuNuASxsmZFIj74b4SGmXuD9/H8PEYLZdIIwReT
         mhpG+tKYGzCT0yjdz/8c3g3SjnxF3ZP8likqwCcD4tQH+Oa5OUjDt+TZXTu/IGQn5dhK
         bgewMoLoygZ63wdy7pl65l51oGV+ODK6t50MIfe0S50qOnAr9lMvIuBt/5sIdLdLi5WH
         KQn2k5IeFUIzs2uWhLvCYaN5afS24/FzKxjjurSQ//t1EvwBqejfZCl5cNaUBMXEYifk
         G5UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730419433; x=1731024233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=13QqxlmOsu4mjaQ0FqLVXCcsygHFthO25baKCZAV/U0=;
        b=G8tvt5pWoZ/oZ5cyXm+rP4SUSOdx/6aorVNOA3+DMb+a/RuhipmeH1MJA8uBqlZ5C2
         cio//NV50rBNo0o6WWzolGe3DYDe9w4WU2c92El+tzsvv1V5vfd4wqyCFsEYt8OuJb6U
         TWHq15VcFRhBYFyvvGwJ7fBxfI+bqo97HFV8LmhOdpeHanp58rRMfEB223NNRvsmPElc
         K43G2NyqUhlBOP7IvH4NqpVtSIqI+fEB21W5I7rZXsnO7RPxodUbQfNjKQ/WW/rc6gOZ
         uYv137i20FKeEU4srnbMNtATUP/jpOIFufTzrs/TOH4FidbgFuQVNOJN757D2q2WWPwa
         9uGg==
X-Gm-Message-State: AOJu0YwYtKp/w09LZ3NDg/luoYIaiepR0qKfPl4eVVivst2hAcGNhgRm
	zhhiLcB380ruvf7ZAFTl40eE+jNpmg6wySJjkr9PU5XCCYo/RsDU2ODDpokPTA9KtN7S5oeleDA
	ylUUkDJvzr5/xbiQUIr97OVZ31CrarWdPUmI1
X-Gm-Gg: ASbGncvdzFT2ZipfgavpsN99BZTxK/AWZYm8HTxCKn4iOTx3D/aHTINXTAtLPykof7r
	MPtAVU7OqCeRGkp7XAjmoRNqzxaG0gmk=
X-Google-Smtp-Source: AGHT+IHpGQA2sPS4chryYCiR3Jn0y8UDiG4DI3VfkquvynzhPLouPmOKvIfNGoQlJXSwNHHQo3ssOEo/WgcYJYTXH3Y=
X-Received: by 2002:a05:622a:54f:b0:460:b4e3:49e with SMTP id
 d75a77b69052e-462ad1c30e6mr4570981cf.9.1730419432210; Thu, 31 Oct 2024
 17:03:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <50f12fa1-17c1-4940-a6bf-beaf61f6b17a@stanley.mountain> <CAJuCfpH0_vjLrME6CgYkMXr3k+rDp-GpOiVrV23zYWwVUhW-iw@mail.gmail.com>
In-Reply-To: <CAJuCfpH0_vjLrME6CgYkMXr3k+rDp-GpOiVrV23zYWwVUhW-iw@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 31 Oct 2024 17:03:38 -0700
Message-ID: <CAJuCfpGVUF0txe_8nRLOnmyxuZ8SzrOpvgUqSVhCLiAs2q3Mow@mail.gmail.com>
Subject: Re: [bug report] alloc_tag: load module tags into separate contiguous memory
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 5:06=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Sat, Oct 26, 2024 at 12:54=E2=80=AFAM Dan Carpenter <dan.carpenter@lin=
aro.org> wrote:
> >
> > Hello Suren Baghdasaryan,
> >
> > Commit e88dfe467aa7 ("alloc_tag: load module tags into separate
> > contiguous memory") from Oct 23, 2024 (linux-next), leads to the
> > following Smatch static checker warning:
> >
> >         kernel/module/main.c:2594 move_module()
> >         warn: 'dest' isn't an ERR_PTR
> >
> > kernel/module/main.c
> >     2554 static int move_module(struct module *mod, struct load_info *i=
nfo)
> >     2555 {
> >     2556         int i;
> >     2557         enum mod_mem_type t =3D 0;
> >     2558         int ret =3D -ENOMEM;
> >     2559         bool codetag_section_found =3D false;
> >     2560
> >     2561         for_each_mod_mem_type(type) {
> >     2562                 if (!mod->mem[type].size) {
> >     2563                         mod->mem[type].base =3D NULL;
> >     2564                         mod->mem[type].rw_copy =3D NULL;
> >     2565                         continue;
> >     2566                 }
> >     2567
> >     2568                 ret =3D module_memory_alloc(mod, type);
> >     2569                 if (ret) {
> >     2570                         t =3D type;
> >     2571                         goto out_err;
> >     2572                 }
> >     2573         }
> >     2574
> >     2575         /* Transfer each section which specifies SHF_ALLOC */
> >     2576         pr_debug("Final section addresses for %s:\n", mod->nam=
e);
> >     2577         for (i =3D 0; i < info->hdr->e_shnum; i++) {
> >     2578                 void *dest;
> >     2579                 Elf_Shdr *shdr =3D &info->sechdrs[i];
> >     2580                 const char *sname;
> >     2581                 unsigned long addr;
> >     2582
> >     2583                 if (!(shdr->sh_flags & SHF_ALLOC))
> >     2584                         continue;
> >     2585
> >     2586                 sname =3D info->secstrings + shdr->sh_name;
> >     2587                 /*
> >     2588                  * Load codetag sections separately as they mi=
ght still be used
> >     2589                  * after module unload.
> >     2590                  */
> >     2591                 if (codetag_needs_module_section(mod, sname, s=
hdr->sh_size)) {
> >     2592                         dest =3D codetag_alloc_module_section(=
mod, sname, shdr->sh_size,
> >     2593                                         arch_mod_section_prepe=
nd(mod, i), shdr->sh_addralign);
> > --> 2594                         if (IS_ERR(dest)) {
> >     2595                                 ret =3D PTR_ERR(dest);
> >     2596                                 goto out_err;
> >     2597                         }
> >
> > This is a false positive caused my specific kernel config. The
> > codetag_alloc_module_section() function returns both error pointers and=
 NULL.
> > It can return NULL because of the .config, because the section isn't fo=
und,
> > because the size is too small or because the desc.alloc_section_mem() f=
unction
> > isn't implemented (which is a bug).
>
> Thanks for the report, Dan!
> Yes, codetag_alloc_module_section() should return NULL if the
> "alloc_tags" section is missing or empty. That's not an invalid case
> and it happens when a module has no allocations.
> If desc.alloc_section_mem() is not implemented that indeed should be a
> different error because we should fail to load. Today I have a
> WARN_ON() but that's not enough. I'll change it to return an actual
> error.
>
> >
> >     2598                         addr =3D (unsigned long)dest;
> >     2599                         codetag_section_found =3D true;
> >     2600                 } else {
> >     2601                         enum mod_mem_type type =3D shdr->sh_en=
tsize >> SH_ENTSIZE_TYPE_SHIFT;
> >     2602                         unsigned long offset =3D shdr->sh_ents=
ize & SH_ENTSIZE_OFFSET_MASK;
> >     2603
> >     2604                         addr =3D (unsigned long)mod->mem[type]=
.base + offset;
> >     2605                         dest =3D mod->mem[type].rw_copy + offs=
et;
> >     2606                 }
> >     2607
> >     2608                 if (shdr->sh_type !=3D SHT_NOBITS) {
> >     2609                         /*
> >     2610                          * Our ELF checker already validated t=
his, but let's
> >     2611                          * be pedantic and make the goal clear=
er. We actually
> >     2612                          * end up copying over all modificatio=
ns made to the
> >     2613                          * userspace copy of the entire struct=
 module.
> >     2614                          */
> >     2615                         if (i =3D=3D info->index.mod &&
> >     2616                            (WARN_ON_ONCE(shdr->sh_size !=3D si=
zeof(struct module)))) {
> >
> > This handles the case where the size is too small.  Why not return an e=
rror
> > pointer if the section is not found or if there is a bug.  We could als=
o add a
> > NULL check here.
>
> I'm trying to treat the missing "alloc_tags" section as a valid case
> but yeah, I'm missing some checks as you noticed below.
>
> >
> >     2617                                 ret =3D -ENOEXEC;
> >     2618                                 goto out_err;
> >     2619                         }
> >     2620                         memcpy(dest, (void *)shdr->sh_addr, sh=
dr->sh_size);
> >                                         ^^^^^
> > Dereferenced without testing.
>
> I see. dest can be NULL here. I think I'll just need to correct the
> handling for dest=3DNULL case for tags section. I'll work on fixing that
> in the next version. Thanks!

I think https://lore.kernel.org/all/20241101000017.3856204-1-surenb@google.=
com/
should fix these warnings and avoid NULL dereference.
Thanks,
Suren.

>
> >
> >     2621                 }
> >     2622                 /*
> >     2623                  * Update the userspace copy's ELF section add=
ress to point to
> >     2624                  * our newly allocated memory as a pure conven=
ience so that
> >     2625                  * users of info can keep taking advantage and=
 using the newly
> >     2626                  * minted official memory area.
> >     2627                  */
> >     2628                 shdr->sh_addr =3D addr;
> >     2629                 pr_debug("\t0x%lx 0x%.8lx %s\n", (long)shdr->s=
h_addr,
> >     2630                          (long)shdr->sh_size, info->secstrings=
 + shdr->sh_name);
> >     2631         }
> >     2632
> >     2633         return 0;
> >     2634 out_err:
> >     2635         for (t--; t >=3D 0; t--)
> >     2636                 module_memory_free(mod, t);
> >     2637         if (codetag_section_found)
> >     2638                 codetag_free_module_sections(mod);
> >     2639
> >     2640         return ret;
> >     2641 }
> >
> > regards,
> > dan carpenter
