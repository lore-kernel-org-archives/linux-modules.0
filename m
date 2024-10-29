Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84223621
	for <linux-modules@vger.kernel.org>; Tue, 29 Oct 2024 00:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730160403; cv=none; b=fsCwkcvA4T/Ayi54YIZLcT7zbUgFxH3Cd9k3r9cuXVgZLG/ZpS8Y/AMThzXh7ZNPBo63mUVCFCoWzZjTM4fiIUmpV1/Pic0Sp2tEEz6vjUz/6Z0FnYyvD0qpR6lXd/+a/G7wVO1/OgR8/3lKmvP+mmZm8HMNJ+clkmEXJVsuEXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730160403; c=relaxed/simple;
	bh=zx6+NMzdtmIOB7ZSBVVdFDiRJQJgvJjLjIdjrOPRd2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TWwwZgHiKByCthQYheglQE2X/JkVOrSfgdQCY+jRctmKmEq9n9Q4A0J67hLHdhit4aR04RVvsQIShd9MQGSeVBrH/vhdP8h9ll9DOAOG/axzvVMKq+CktLaHsLIAl1dJ0Spi1e5fkVFsArOx1Gu26psPmYUOzrD2vDSyqL0CfP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=16dvy+ip; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="16dvy+ip"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-460969c49f2so78341cf.0
        for <linux-modules@vger.kernel.org>; Mon, 28 Oct 2024 17:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730160400; x=1730765200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csT5rm0txWqjaPD7z5MZc/OK6RLh1pn0+eG6NrND4rc=;
        b=16dvy+ipn9IygjNqr6Y4HQXEzigfXBoLh1mRJKV22zN8oQzLETFVjrRCxO4YZzxEzW
         K3kUv62jE/WpC0ZpAM7uBa3oMvFdqhKBYi47Le8t0iKnF710tW2Xaq8Sw3glqW2j7YTO
         a849gF8jbAtD2J2IZSzC3Cf1Sxt5RpgRvNeyde6fPS0YmnWcIeBgJo9qS6twU8vAe5bi
         KNJjCj3e7Qejl3j0oDMAuw7PLc/y378BGJd9Z3gF54rfL/gKI0oorbbdlhE8CglgYDlC
         AxYMDJQUuobBGb8HcmZv7tR4+PazEDN7UVr3vhEM2qoVDEvt9bo6H4qZry4xoPKqf10N
         f58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730160400; x=1730765200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=csT5rm0txWqjaPD7z5MZc/OK6RLh1pn0+eG6NrND4rc=;
        b=a5QMap2yhjximgGrzZ3+5ixeTGW/rknmrT4j+qfL9NTOJCx8ayKmg+AA+hCa+C/z/K
         P5bC7IXuv+2KXPAO0L48etPEFaJGy5FxuicwrRDncvYx8NX8kV1fi8ZBoMkwqLHpZHiE
         wCj+cl8Mx9cNMobxZAXQyFm1OOnMU/qcoajrUtlNgZgVUWGTdUG2/ZVSEPZmnqxP6lQA
         dJadV9AfG8CQlBNr2+vkWEvyV9dDDL/3KTEvGCJanmdyWIPGSqqPbUmzpJn2OYCTKtw+
         AMY0ug3GXOm4slMi9lsWC/uxE5mWRjMjcniUOGm8D4HQRyQrf21OGQ06zIoi0NinsbVe
         fqgQ==
X-Gm-Message-State: AOJu0YyXz1aPILDDBtEVEmbuPVNnWNuOn2cI0KnV1HWUIpVNIuoQKStO
	ftOpOdS1sSoEhRNZTMCQZEDTWf4uCvo1GYadAyHIED7Es575cz0ZSfcYSHJqkjkYWIaT65nxtsy
	rOK7XmE7avIjUt0SL5+UQ9hnWXyoGdN9e5AJ2
X-Gm-Gg: ASbGnctUVjKrVPIw5otTHJ79xlRRJ61Gyv5LdNjR4fcqySSvnloWowTLgtSFuByV8yj
	80NvBWzzsQMN1Uaom+xYT/EQevB9KrN4=
X-Google-Smtp-Source: AGHT+IH0NLxVLeUy2FrsSt1MoEKDsESDoz0+h/2OK+WiNxTzBQ2ko7PchD8csy2/UOONdvK4Yx5n6phtU2U8HhZadbs=
X-Received: by 2002:a05:622a:1111:b0:461:4150:b833 with SMTP id
 d75a77b69052e-46165810ff8mr1270801cf.22.1730160400088; Mon, 28 Oct 2024
 17:06:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <50f12fa1-17c1-4940-a6bf-beaf61f6b17a@stanley.mountain>
In-Reply-To: <50f12fa1-17c1-4940-a6bf-beaf61f6b17a@stanley.mountain>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 28 Oct 2024 17:06:27 -0700
Message-ID: <CAJuCfpH0_vjLrME6CgYkMXr3k+rDp-GpOiVrV23zYWwVUhW-iw@mail.gmail.com>
Subject: Re: [bug report] alloc_tag: load module tags into separate contiguous memory
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 26, 2024 at 12:54=E2=80=AFAM Dan Carpenter <dan.carpenter@linar=
o.org> wrote:
>
> Hello Suren Baghdasaryan,
>
> Commit e88dfe467aa7 ("alloc_tag: load module tags into separate
> contiguous memory") from Oct 23, 2024 (linux-next), leads to the
> following Smatch static checker warning:
>
>         kernel/module/main.c:2594 move_module()
>         warn: 'dest' isn't an ERR_PTR
>
> kernel/module/main.c
>     2554 static int move_module(struct module *mod, struct load_info *inf=
o)
>     2555 {
>     2556         int i;
>     2557         enum mod_mem_type t =3D 0;
>     2558         int ret =3D -ENOMEM;
>     2559         bool codetag_section_found =3D false;
>     2560
>     2561         for_each_mod_mem_type(type) {
>     2562                 if (!mod->mem[type].size) {
>     2563                         mod->mem[type].base =3D NULL;
>     2564                         mod->mem[type].rw_copy =3D NULL;
>     2565                         continue;
>     2566                 }
>     2567
>     2568                 ret =3D module_memory_alloc(mod, type);
>     2569                 if (ret) {
>     2570                         t =3D type;
>     2571                         goto out_err;
>     2572                 }
>     2573         }
>     2574
>     2575         /* Transfer each section which specifies SHF_ALLOC */
>     2576         pr_debug("Final section addresses for %s:\n", mod->name)=
;
>     2577         for (i =3D 0; i < info->hdr->e_shnum; i++) {
>     2578                 void *dest;
>     2579                 Elf_Shdr *shdr =3D &info->sechdrs[i];
>     2580                 const char *sname;
>     2581                 unsigned long addr;
>     2582
>     2583                 if (!(shdr->sh_flags & SHF_ALLOC))
>     2584                         continue;
>     2585
>     2586                 sname =3D info->secstrings + shdr->sh_name;
>     2587                 /*
>     2588                  * Load codetag sections separately as they migh=
t still be used
>     2589                  * after module unload.
>     2590                  */
>     2591                 if (codetag_needs_module_section(mod, sname, shd=
r->sh_size)) {
>     2592                         dest =3D codetag_alloc_module_section(mo=
d, sname, shdr->sh_size,
>     2593                                         arch_mod_section_prepend=
(mod, i), shdr->sh_addralign);
> --> 2594                         if (IS_ERR(dest)) {
>     2595                                 ret =3D PTR_ERR(dest);
>     2596                                 goto out_err;
>     2597                         }
>
> This is a false positive caused my specific kernel config. The
> codetag_alloc_module_section() function returns both error pointers and N=
ULL.
> It can return NULL because of the .config, because the section isn't foun=
d,
> because the size is too small or because the desc.alloc_section_mem() fun=
ction
> isn't implemented (which is a bug).

Thanks for the report, Dan!
Yes, codetag_alloc_module_section() should return NULL if the
"alloc_tags" section is missing or empty. That's not an invalid case
and it happens when a module has no allocations.
If desc.alloc_section_mem() is not implemented that indeed should be a
different error because we should fail to load. Today I have a
WARN_ON() but that's not enough. I'll change it to return an actual
error.

>
>     2598                         addr =3D (unsigned long)dest;
>     2599                         codetag_section_found =3D true;
>     2600                 } else {
>     2601                         enum mod_mem_type type =3D shdr->sh_ents=
ize >> SH_ENTSIZE_TYPE_SHIFT;
>     2602                         unsigned long offset =3D shdr->sh_entsiz=
e & SH_ENTSIZE_OFFSET_MASK;
>     2603
>     2604                         addr =3D (unsigned long)mod->mem[type].b=
ase + offset;
>     2605                         dest =3D mod->mem[type].rw_copy + offset=
;
>     2606                 }
>     2607
>     2608                 if (shdr->sh_type !=3D SHT_NOBITS) {
>     2609                         /*
>     2610                          * Our ELF checker already validated thi=
s, but let's
>     2611                          * be pedantic and make the goal clearer=
. We actually
>     2612                          * end up copying over all modifications=
 made to the
>     2613                          * userspace copy of the entire struct m=
odule.
>     2614                          */
>     2615                         if (i =3D=3D info->index.mod &&
>     2616                            (WARN_ON_ONCE(shdr->sh_size !=3D size=
of(struct module)))) {
>
> This handles the case where the size is too small.  Why not return an err=
or
> pointer if the section is not found or if there is a bug.  We could also =
add a
> NULL check here.

I'm trying to treat the missing "alloc_tags" section as a valid case
but yeah, I'm missing some checks as you noticed below.

>
>     2617                                 ret =3D -ENOEXEC;
>     2618                                 goto out_err;
>     2619                         }
>     2620                         memcpy(dest, (void *)shdr->sh_addr, shdr=
->sh_size);
>                                         ^^^^^
> Dereferenced without testing.

I see. dest can be NULL here. I think I'll just need to correct the
handling for dest=3DNULL case for tags section. I'll work on fixing that
in the next version. Thanks!

>
>     2621                 }
>     2622                 /*
>     2623                  * Update the userspace copy's ELF section addre=
ss to point to
>     2624                  * our newly allocated memory as a pure convenie=
nce so that
>     2625                  * users of info can keep taking advantage and u=
sing the newly
>     2626                  * minted official memory area.
>     2627                  */
>     2628                 shdr->sh_addr =3D addr;
>     2629                 pr_debug("\t0x%lx 0x%.8lx %s\n", (long)shdr->sh_=
addr,
>     2630                          (long)shdr->sh_size, info->secstrings +=
 shdr->sh_name);
>     2631         }
>     2632
>     2633         return 0;
>     2634 out_err:
>     2635         for (t--; t >=3D 0; t--)
>     2636                 module_memory_free(mod, t);
>     2637         if (codetag_section_found)
>     2638                 codetag_free_module_sections(mod);
>     2639
>     2640         return ret;
>     2641 }
>
> regards,
> dan carpenter
