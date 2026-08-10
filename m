Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB672E040D
	for <linux-modules@vger.kernel.org>; Mon, 10 Aug 2026 03:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786334141; cv=none; b=rOziMAP6FUH2EWEbRWVe/57Yt+JsM3gjSOoz5Ks3ltR6W4JuAw96u/RoQutl2EpybSkxWmUk6XZB1ij9z5gtcKqom84/c3hhXMeR9gY5qt2WomDRAyiXk25UHNcpIwkyNc4Y4rBc3CZqAdUPqS7n94HZdDnKEIhstrxCobK3YQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786334141; c=relaxed/simple;
	bh=xbix/E3dJTHUwbV3DgNMJvePr490dKzztFBUWutfCr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dLaXFl3dF/UCdth7YRTIH3StNpbbajcE8Tk8xymQ185990DaEmDoKH5W2s0OGYGHmU7yQEGWRWNfMwbmqdQWUfLj+aSLKLydwBgO4OXjo3FidQPkfGckyXzyDOvLvIx5yrrhQyDEx0h7gEOkN7kF+NibhuUtvqs41OOV4JrZEN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eTK563Nq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eTK563Nq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E94F1F00A3E
	for <linux-modules@vger.kernel.org>; Mon, 10 Aug 2026 03:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786334139;
	bh=jzFHnwF8+RE791kbgBI6mkvSsTNJDuWvEFuCrdii6LY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=eTK563NqaU2FYXG0RHwdITIpVQIMZuhFpr/pOE19yQB6oPo9g1CenaGb+R43+Qoml
	 BDpH0ko/FnTxkj40TFYUOW0Yjv11kuyxK8JO8yHt8GEIATo/S+/9cb4R1O/xe56qdy
	 ycnAw3Sf944Y21aw6jNBQGEX8DKB3VKDntj4xdfkLVLqJOXVVlBEBpzSs/wtamK50p
	 /7S7tTJgXpclgPv6gi04OFe8sYTNUq8Z9rD9f4ehpuzleSdI3WFAhh4ZDGyLW6qM79
	 3xdHlfYjqRwnMth6h2xJJ7iwSYPI7dE2oqqO1A7Fq80MZXPaNPF/Ua/Naps0dCIYgr
	 lpfZRPPeMnpWw==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-69c600f76ccso1711439a12.0
        for <linux-modules@vger.kernel.org>; Sun, 09 Aug 2026 20:55:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rq+BL+jxUBAgxffCpG8rRK2T+E+6OpYyXfYvP/Rsm8MsAkK3dANer4nyrGlChSPrOktRk5xr4l1nKQMel0L@vger.kernel.org
X-Gm-Message-State: AOJu0YwoQ9o8NXiRRq7+S46h2B4teA9MO3SoVJo7FV6sjebSrUU2hhT9
	S5AejmQxo1R5VsgoLumIfELwa+qqmIsxkEg42sJdywndtcFQ87OyySbxLGiFsJmGALta2DjYuCL
	1vfVfJZl4qN54Wd6EQiSjgC86pMK+Eu8=
X-Received: by 2002:a05:6402:3906:b0:69f:fa13:ed3 with SMTP id
 4fb4d7f45d1cf-6a1f2c3ff1dmr8051325a12.16.1786334138211; Sun, 09 Aug 2026
 20:55:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260808033715.13117-1-yangtiezhu@loongson.cn> <71fe6152-65f8-cf30-08d0-004c2a7d922a@loongson.cn>
In-Reply-To: <71fe6152-65f8-cf30-08d0-004c2a7d922a@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 10 Aug 2026 11:55:26 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5wwuSKZe3k2ZzS2d7bisM+QbVAFGrx72fXXE81-zOq8g@mail.gmail.com>
X-Gm-Features: AUfX_mwQ9U1z3ySjR5WilGyUrRhCcQT7ZYwKEjDr7hd48QpO61OkhtY-wIcK0Eo
Message-ID: <CAAhV-H5wwuSKZe3k2ZzS2d7bisM+QbVAFGrx72fXXE81-zOq8g@mail.gmail.com>
Subject: Re: [PATCH v1] module/kallsyms: Filter out local mapping symbols
 during module load
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, linux-modules@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Tiezhu,

On Mon, Aug 10, 2026 at 10:07=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongson.c=
n> wrote:
>
> On 2026/8/8 =E4=B8=8A=E5=8D=8811:37, Tiezhu Yang wrote:
> > The compiler toolchains generate internal local labels on certain
> > architectures (such as LoongArch) for optimizations and relocations.
>
> ...
>
> > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> > ---
> > Based on the latest modules-next branch of
> > https://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git
> >
> >   kernel/module/kallsyms.c | 7 +++++++
> >   1 file changed, 7 insertions(+)
> >
> > diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
> > index f23126d804b2..61dd5c014a59 100644
> > --- a/kernel/module/kallsyms.c
> > +++ b/kernel/module/kallsyms.c
> > @@ -130,6 +130,9 @@ void layout_symtab(struct module *mod, struct load_=
info *info)
> >
> >       /* Compute total space required for the core symbols' strtab. */
> >       for (ndst =3D i =3D 0; i < nsrc; i++) {
> > +             if (is_mapping_symbol(&info->strtab[src[i].st_name]))
> > +                     continue;
> > +
> >               if (i =3D=3D 0 || is_livepatch_module(mod) ||
> >                   is_core_symbol(src + i, info->sechdrs, info->hdr->e_s=
hnum,
> >                                  info->index.pcpu)) {
> > @@ -198,6 +201,10 @@ void add_kallsyms(struct module *mod, const struct=
 load_info *info)
> >       src =3D kallsyms->symtab;
> >       for (ndst =3D i =3D 0; i < kallsyms->num_symtab; i++) {
> >               kallsyms->typetab[i] =3D elf_type(src + i, info);
> > +
> > +             if (is_mapping_symbol(&kallsyms->strtab[src[i].st_name]))
> > +                     continue;
> > +
> >               if (i =3D=3D 0 || is_livepatch_module(mod) ||
> >                   is_core_symbol(src + i, info->sechdrs, info->hdr->e_s=
hnum,
> >                                  info->index.pcpu)) {
> >
>
> Hi module maintainers,
>
> Regarding the feedback from the AI bot about livepatch breaking [1],
> there are two ways to fix it, which style do you prefer?
I think the first is better.


Huacai
>
> (1) Using continue
>
> ```
> diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
> index f23126d804b2..aece7aa49dd4 100644
> --- a/kernel/module/kallsyms.c
> +++ b/kernel/module/kallsyms.c
> @@ -130,6 +130,10 @@ void layout_symtab(struct module *mod, struct
> load_info *info)
>
>          /* Compute total space required for the core symbols' strtab. */
>          for (ndst =3D i =3D 0; i < nsrc; i++) {
> +               if (!is_livepatch_module(mod) &&
> +                   is_mapping_symbol(&info->strtab[src[i].st_name]))
> +                       continue;
> +
>                  if (i =3D=3D 0 || is_livepatch_module(mod) ||
>                      is_core_symbol(src + i, info->sechdrs,
> info->hdr->e_shnum,
>                                     info->index.pcpu)) {
> @@ -198,6 +202,11 @@ void add_kallsyms(struct module *mod, const struct
> load_info *info)
>          src =3D kallsyms->symtab;
>          for (ndst =3D i =3D 0; i < kallsyms->num_symtab; i++) {
>                  kallsyms->typetab[i] =3D elf_type(src + i, info);
> +
> +               if (!is_livepatch_module(mod) &&
> +                   is_mapping_symbol(&kallsyms->strtab[src[i].st_name]))
> +                       continue;
> +
>                  if (i =3D=3D 0 || is_livepatch_module(mod) ||
>                      is_core_symbol(src + i, info->sechdrs,
> info->hdr->e_shnum,
>                                     info->index.pcpu)) {
> ```
>
> (2) Using if-statement
> ```
> diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
> index f23126d804b2..b2b22b3487a8 100644
> --- a/kernel/module/kallsyms.c
> +++ b/kernel/module/kallsyms.c
> @@ -130,9 +130,12 @@ void layout_symtab(struct module *mod, struct
> load_info *info)
>
>          /* Compute total space required for the core symbols' strtab. */
>          for (ndst =3D i =3D 0; i < nsrc; i++) {
> -               if (i =3D=3D 0 || is_livepatch_module(mod) ||
> +               bool is_mapping =3D !is_livepatch_module(mod) &&
> +
> is_mapping_symbol(&info->strtab[src[i].st_name]);
> +
> +               if (!is_mapping && (i =3D=3D 0 || is_livepatch_module(mod=
) ||
>                      is_core_symbol(src + i, info->sechdrs,
> info->hdr->e_shnum,
> -                                  info->index.pcpu)) {
> +                                  info->index.pcpu))) {
>                          strtab_size +=3D
> strlen(&info->strtab[src[i].st_name]) + 1;
>                          ndst++;
>                  }
> @@ -198,9 +201,13 @@ void add_kallsyms(struct module *mod, const struct
> load_info *info)
>          src =3D kallsyms->symtab;
>          for (ndst =3D i =3D 0; i < kallsyms->num_symtab; i++) {
>                  kallsyms->typetab[i] =3D elf_type(src + i, info);
> -               if (i =3D=3D 0 || is_livepatch_module(mod) ||
> +
> +               bool is_mapping =3D !is_livepatch_module(mod) &&
> +
> is_mapping_symbol(&kallsyms->strtab[src[i].st_name]);
> +
> +               if (!is_mapping && (i =3D=3D 0 || is_livepatch_module(mod=
) ||
>                      is_core_symbol(src + i, info->sechdrs,
> info->hdr->e_shnum,
> -                                  info->index.pcpu)) {
> +                                  info->index.pcpu))) {
>                          ssize_t ret;
>
>                          mod->core_kallsyms.typetab[ndst] =3D
> ```
>
> If you have any more comments, please let me know.
>
> [1]
> https://lore.kernel.org/linux-modules/20260808035301.C3E6F1F000E9@smtp.ke=
rnel.org/
>
> Thanks,
> Tiezhu
>
>
