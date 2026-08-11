Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312C21A3160
	for <linux-modules@vger.kernel.org>; Tue, 11 Aug 2026 14:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786458176; cv=none; b=FYfaCD5pmUuDvHuRjEgbVIfhVDOb3nvNurp7y5UraxCr7no0j6AIDQwVFUakWqkSMFG3Rqf373P/pK/1aHpkRnlz9+3K/FjHnZH752QkxjqGl0XrdVvHq4xy/RS8IJ4MyvKTaRV6W32v16f9X6aWJzyhJ+IU6lgu8J6ftHGvebI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786458176; c=relaxed/simple;
	bh=InG/EN0VK9xEGxyZcSw7jCQdc/LWkm1csF7/qexU6Ic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZiNX4BXhqMUimlZHxREENxCPuy0aqRi1e7M/kwiFr8wcs85rTdV0iEEJyUqyVSZe3oh4Oxb/2TSzURN5/hxkBBfuV9233OmSjgfm88Kowffsflst8N7jYq6OcKHckAIUUZ2tXP2g9GKXq73h8tQ/Z2G1wHOIr6alT5cE+IcZYTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+frrvV2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+frrvV2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDAA71F00ACA
	for <linux-modules@vger.kernel.org>; Tue, 11 Aug 2026 14:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786458175;
	bh=CQer8aIiyVf6i0zzNRz3PRCSvJUJgcXE48zhJpc4OSE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=F+frrvV2eam3e2P0jTSRek2Qoi+r/PpKYvFo2Iw9d0tJhiBuD+pOdNLF7/eNn1wxZ
	 5zrW5bHFt8kfP9L384cRtg/QMRucq0Wbbh8OyvK0G2KabEZ842mWmA5Fxc0WVrDHG2
	 8qNA+hOPovFGRUkupC/SW/fUlPfYiGrVdkMBqzRSfofUFb6iT/xN+c3EshHnYe/g2+
	 J+Llai3ufEu6HkKx6VyRRe/tD0S4v5nw1g5U82b9hcDFtHjVdBWyWKAKruHvevgNKZ
	 p2tti/KRGTt+dcgx9yAePPtYhh47S9TDLN6buw5xjwqsW983ulU2OnNawknZHrhn9J
	 3ooajffQzGweA==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6a17c04563fso3786388a12.3
        for <linux-modules@vger.kernel.org>; Tue, 11 Aug 2026 07:22:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqtItVpCtSVbFG30/DkzSCL/zi8JTlkz2d7pYnzPGMrr9coIUswNO+2/DFBQkFg4j/lBAtDk9f3VHTQf3uH@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpgjmq+ODMpYxGXji8no9KEU1hb4t2veYI+sEsfKEMy6xK+av/
	IcuRelRFGL2NV9rD+WaJnkK/fs7NWa/ab1jPu6MMv4YKw4Q1O+k0Y+trtDAz+sXJtreEca0f5t2
	7G4LlhIyXX32JHz47AWOCErbCy2GxQ3Q=
X-Received: by 2002:a05:6402:2417:b0:6a1:ffc4:e4b9 with SMTP id
 4fb4d7f45d1cf-6a3644aeb16mr2031075a12.9.1786458173515; Tue, 11 Aug 2026
 07:22:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811071507.24043-1-yangtiezhu@loongson.cn> <39a48465-22b6-4b18-9f7e-ce258513181b@suse.com>
In-Reply-To: <39a48465-22b6-4b18-9f7e-ce258513181b@suse.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 11 Aug 2026 22:22:41 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5qN2=LEbVS+hd5Uohq6OKHgkxEWLg4GNukYFBmjEABHg@mail.gmail.com>
X-Gm-Features: AUfX_mzWId4lMwTXHu3AJgdPiGUt_E_DKuFDt_gQN8CSl88uYh5KpOKtj0VI_Ng
Message-ID: <CAAhV-H5qN2=LEbVS+hd5Uohq6OKHgkxEWLg4GNukYFBmjEABHg@mail.gmail.com>
Subject: Re: [PATCH v2] module/kallsyms: Filter out local mapping symbols
 during module load
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, Luis Chamberlain <mcgrof@kernel.org>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, linux-modules@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Petr,

On Tue, Aug 11, 2026 at 8:20=E2=80=AFPM Petr Pavlu <petr.pavlu@suse.com> wr=
ote:
>
> On 8/11/26 9:15 AM, Tiezhu Yang wrote:
> > The compiler toolchains generate internal local labels on certain
> > architectures (such as LoongArch) for optimizations and relocations.
> >
> > While these local labels are filtered out during runtime lookups in
> > find_kallsyms_symbol(), they still leak into the permanent symbol
> > tables of loaded modules, because layout_symtab() and add_kallsyms()
> > do not check for the mapping symbols during layout generation.
> >
> > Consequently, tracing tools like bpftrace resolve identical addresses
> > into confusing local labels instead of actual clear C function names.
> >
> > Fix this by adding is_mapping_symbol() checks directly into the symbol
> > tracking loops of layout_symtab() and add_kallsyms(). This prevents the
> > mapping symbols from entering the module's memory symbol arrays at load
> > time.
>
> This optimization looks sensible to me. Kallsyms in vmlinux also
> normally doesn't include information about local labels (.L<xyz>) and
> mapping symbols ($a, $d, ...), so it should be ok not to track them in
> modules either.
>
> Note that the patch description mixes up these two symbol categories,
> presumably because the existing is_mapping_symbol() function conflates
> them as well.
>
> >
> > For livepatch modules, core_kallsyms.symtab must remain a complete copy
> > of the original ELF symbol table to prevent delayed relocation failures=
.
> > Therefore, enforce is_livepatch_module() checking to skip the filtering
> > for livepatch modules.
> >
> > Reproduce steps:
> >
> > 1. Set up a LoongArch VM with "-accel kvm":
> >
> >    $ sudo qemu-system-loongarch64 -serial stdio \
> >      -machine virt -cpu la464 -smp 4 -m 4G \
> >      -bios /usr/share/edk2/loongarch64/QEMU_EFI.fd \
> >      -nodefaults -no-reboot -nographic -accel kvm
> >
> > 2. Use bpftrace to capture kstack when vCPU is scheduled out:
> >
> >    $ cat trace_sched.bt
> >    kprobe:kvm:kvm_sched_out
> >    {
> >            if (pid =3D=3D $1) {
> >                    print(kstack());
> >            }
> >    }
> >
> >    $ sudo bpftrace trace_sched.bt `pgrep -o qemu-system`
> >
> > Test results:
> >
> > 1. Before this patch (Confusing stack with local labels):
> >
> >         kvm_sched_out+0
> >         __schedule+1584
> >         schedule+48
> >         .LVL3767+36
> >         .LVL3801+8
> >         .LVL285+12
> >         .LVL425+44
> >         .LVL1419+20
> >         kvm_exc_entry+260
>
> The description should mention that this change affects what appears in
> /proc/kallsyms, as that is the important part. bpftrace is only one user
> of this data and apparently gets confused because it does not apply any
> filtering of its own, unlike perf which has is_ignored_kernel_symbol().
>
> >
> > 2. After this patch (Accurate stack with function names):
> >
> >         kvm_sched_out+0
> >         __schedule+1584
> >         schedule+48
> >         kvm_vcpu_block+112
> >         kvm_vcpu_halt+104
> >         kvm_emu_idle+284
> >         kvm_handle_gspr+1316
> >         kvm_handle_exit+456
> >         kvm_exc_entry+260
> >
> > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> > ---
> > v2: Fix livepatch support as pointed out by Sashiko bot.
> >
> >  kernel/module/kallsyms.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
> > index f23126d804b2..aece7aa49dd4 100644
> > --- a/kernel/module/kallsyms.c
> > +++ b/kernel/module/kallsyms.c
> > @@ -130,6 +130,10 @@ void layout_symtab(struct module *mod, struct load=
_info *info)
> >
> >       /* Compute total space required for the core symbols' strtab. */
> >       for (ndst =3D i =3D 0; i < nsrc; i++) {
> > +             if (!is_livepatch_module(mod) &&
> > +                 is_mapping_symbol(&info->strtab[src[i].st_name]))
> > +                     continue;
> > +
> >               if (i =3D=3D 0 || is_livepatch_module(mod) ||
> >                   is_core_symbol(src + i, info->sechdrs, info->hdr->e_s=
hnum,
> >                                  info->index.pcpu)) {
> > @@ -198,6 +202,11 @@ void add_kallsyms(struct module *mod, const struct=
 load_info *info)
> >       src =3D kallsyms->symtab;
> >       for (ndst =3D i =3D 0; i < kallsyms->num_symtab; i++) {
> >               kallsyms->typetab[i] =3D elf_type(src + i, info);
> > +
> > +             if (!is_livepatch_module(mod) &&
> > +                 is_mapping_symbol(&kallsyms->strtab[src[i].st_name]))
> > +                     continue;
> > +
> >               if (i =3D=3D 0 || is_livepatch_module(mod) ||
> >                   is_core_symbol(src + i, info->sechdrs, info->hdr->e_s=
hnum,
> >                                  info->index.pcpu)) {
>
> It is better to avoid duplicating the same logic in layout_symtab() and
> add_kallsyms(). The function is_core_symbol() can be renamed to
> something like is_kept_symbol() and can be solely responsible for
> deciding what to keep.
I'm sorry but I think Tiezhu's patch is simpler and cleaner. :)

Huacai
>
> The following prototype shows my suggestion:
>
> diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
> index 0fc11e45df9b..c86879cc5b66 100644
> --- a/kernel/module/kallsyms.c
> +++ b/kernel/module/kallsyms.c
> @@ -75,23 +75,29 @@ static char elf_type(const Elf_Sym *sym, const struct=
 load_info *info)
>         return '?';
>  }
>
> -static bool is_core_symbol(const Elf_Sym *src, const Elf_Shdr *sechdrs,
> -                          unsigned int shnum, unsigned int pcpundx)
> +static bool is_kept_symbol(struct module *mod, const struct load_info *i=
nfo,
> +                          unsigned int symnum, const Elf_Sym *src)
>  {
>         const Elf_Shdr *sec;
>         enum mod_mem_type type;
>
> +       if (symnum =3D=3D 0 || is_livepatch_module(mod))
> +               return true;
> +
>         if (src->st_shndx =3D=3D SHN_UNDEF ||
> -           src->st_shndx >=3D shnum ||
> +           src->st_shndx >=3D info->hdr->e_shnum ||
>             !src->st_name)
>                 return false;
>
> +       if (is_mapping_symbol(&info->strtab[src->st_name]))
> +               return false;
> +
>  #ifdef CONFIG_KALLSYMS_ALL
> -       if (src->st_shndx =3D=3D pcpundx)
> +       if (src->st_shndx =3D=3D info->index.pcpu)
>                 return true;
>  #endif
>
> -       sec =3D sechdrs + src->st_shndx;
> +       sec =3D info->sechdrs + src->st_shndx;
>         type =3D sec->sh_entsize >> SH_ENTSIZE_TYPE_SHIFT;
>         if (!(sec->sh_flags & SHF_ALLOC)
>  #ifndef CONFIG_KALLSYMS_ALL
> @@ -130,12 +136,11 @@ void layout_symtab(struct module *mod, struct load_=
info *info)
>
>         /* Compute total space required for the core symbols' strtab. */
>         for (ndst =3D i =3D 0; i < nsrc; i++) {
> -               if (i =3D=3D 0 || is_livepatch_module(mod) ||
> -                   is_core_symbol(src + i, info->sechdrs, info->hdr->e_s=
hnum,
> -                                  info->index.pcpu)) {
> -                       strtab_size +=3D strlen(&info->strtab[src[i].st_n=
ame]) + 1;
> -                       ndst++;
> -               }
> +               if (!is_kept_symbol(mod, info, i, src + i))
> +                       continue;
> +
> +               strtab_size +=3D strlen(&info->strtab[src[i].st_name]) + =
1;
> +               ndst++;
>         }
>
>         /* Append room for core symbols at end of core part. */
> @@ -197,23 +202,22 @@ void add_kallsyms(struct module *mod, const struct =
load_info *info)
>         strtab_size =3D info->core_typeoffs - info->stroffs;
>         src =3D kallsyms->symtab;
>         for (ndst =3D i =3D 0; i < kallsyms->num_symtab; i++) {
> +               ssize_t ret;
> +
>                 kallsyms->typetab[i] =3D elf_type(src + i, info);
> -               if (i =3D=3D 0 || is_livepatch_module(mod) ||
> -                   is_core_symbol(src + i, info->sechdrs, info->hdr->e_s=
hnum,
> -                                  info->index.pcpu)) {
> -                       ssize_t ret;
> -
> -                       mod->core_kallsyms.typetab[ndst] =3D
> -                               kallsyms->typetab[i];
> -                       dst[ndst] =3D src[i];
> -                       dst[ndst++].st_name =3D s - mod->core_kallsyms.st=
rtab;
> -                       ret =3D strscpy(s, &kallsyms->strtab[src[i].st_na=
me],
> -                                     strtab_size);
> -                       if (ret < 0)
> -                               break;
> -                       s +=3D ret + 1;
> -                       strtab_size -=3D ret + 1;
> -               }
> +
> +               if (!is_kept_symbol(mod, info, i, src + i))
> +                       continue;
> +
> +               mod->core_kallsyms.typetab[ndst] =3D kallsyms->typetab[i]=
;
> +               dst[ndst] =3D src[i];
> +               dst[ndst++].st_name =3D s - mod->core_kallsyms.strtab;
> +               ret =3D strscpy(s, &kallsyms->strtab[src[i].st_name],
> +                             strtab_size);
> +               if (ret < 0)
> +                       break;
> +               s +=3D ret + 1;
> +               strtab_size -=3D ret + 1;
>         }
>
>         /* Set up to point into init section. */
>
> --
> Thanks,
> Petr
>
