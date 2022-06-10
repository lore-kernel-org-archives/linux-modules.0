Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32809C433EF
	for <linux-modules@archiver.kernel.org>; Fri, 10 Jun 2022 21:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348091AbiFJVmJ (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 10 Jun 2022 17:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350950AbiFJVmH (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 10 Jun 2022 17:42:07 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5671A79803
        for <linux-modules@vger.kernel.org>; Fri, 10 Jun 2022 14:42:06 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id c4so404700lfj.12
        for <linux-modules@vger.kernel.org>; Fri, 10 Jun 2022 14:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hTuTxAMjCajC/1vYQQYpCYbbAjPzudqNWU9h993rD9s=;
        b=tis3vvo11BQYB2E6Oe6sgEpUUdvySDAEHAmTA5sN8t8hLwD8OrV0zl1LSRWVLNGBQD
         2ms4/NuoNN8d7c85d6BAhws1lHMrlYszE0croUX07GJTqn+1kEsE/MKQ8NRGOEC9B1PV
         m6a4SCGWXQVDnFFDBEr9nV9FQ+1UbkIfonwAUumofP4MtAje4cDnmK7yjpDxLZ0XF0tJ
         0JkV3WnWO8LGE195rkgmfWcx6Xa9h82pJLsfQVRvRv3RBXhnylIhWF2YmSIMbz681N/R
         m09Hy+6t9JbACCnW3S4Low0Bs9RnwmtHhc0NKxR/oemYeRCskBMbpxduBdBsHGiPt0yX
         4B7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hTuTxAMjCajC/1vYQQYpCYbbAjPzudqNWU9h993rD9s=;
        b=Ke39vuHtNFoShpqvImfonRzuqKG7f3qBd3NRM9G11eyOxG9+Ly90WN1aHnvlV+ECeM
         jihWinHZWk185+3Xsxo61QEc6FKF+D+Hv3fslFvfZk3BVpYMFHpyAv7i+Z8c8+BC8wcn
         hqTgUMw2YLAoqVH3V6jAG5+DFtIQqMphAKWOnn//udD0ZWT+fR2kTCLpfAbqZLMPRwvi
         jH9avlrmFaRSo9SUsscd7oLNMTNzqqwyMQsXDwkrcqvZMola+dBHPvJOVbrGg7GYZNFN
         +57iyK74eUypcOZzSgpWsBpaETyd7gwG+41avw4zZgXTleTGTDBit/BJAwd8gFUBL3BE
         vfRg==
X-Gm-Message-State: AOAM530YG5/2LFGupKxD+kXS6uhvub4BIEnnbXcQWDQ1+Kg5QAyKyjqK
        N0wqbFxa2H/ppljzApscjTd29AVkkRxHDhmAB7hK7Q==
X-Google-Smtp-Source: ABdhPJwU+oIxHw35O4RStA/C+Kb3V+Ogfc+yp0teH8QGDM6HLjVR4XKGUpms34V5zg5NaaQcgcd4YD0Z5qjPR/Ppdns=
X-Received: by 2002:ac2:5c44:0:b0:479:11e1:36f7 with SMTP id
 s4-20020ac25c44000000b0047911e136f7mr26779320lfp.432.1654897324408; Fri, 10
 Jun 2022 14:42:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220610183236.1272216-1-masahiroy@kernel.org> <20220610183236.1272216-3-masahiroy@kernel.org>
In-Reply-To: <20220610183236.1272216-3-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 10 Jun 2022 14:41:52 -0700
Message-ID: <CAKwvOdn+fYiiU=x7tqxp68Zkb3E88suEg6oNNucom3AehqayJA@mail.gmail.com>
Subject: Re: [PATCH 2/7] modpost: put get_secindex() call inside sec_name()
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Nicolas Pitre <npitre@baylibre.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules <linux-modules@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Fri, Jun 10, 2022 at 11:34 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> There are 5 callsites of sec_name(). In all the places, sec_name() is
> used together with get_secindex().
>
> So, it is simpler to merge two function calls
>
>     sec_name(elf, get_secindex(elf, sym))
>
> into one call:
>
>     sec_name_of_symbol(elf, sym)
>
> While I was here, I also inserted this array range check:
>
>     if (secindex >= info->num_sections)
>             return "";
>
> This will make the code robust against info->sechdrs[] overrun.
>
> sym->st_shndx is 2 bytes (for both 32 and 64 bit systems), and the
> range 0xff00..0xffff is reserved for special sections.
>
> For example, a symbol specifies an absolute value, sym->st_shndx==0xfff1.
> get_secindex() remaps it to 0xfffffff1.
>
> There is no corresponding section header for such special sections.
>
> The existing code does not hit this issue, but it is better to check
> the array range.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
>  scripts/mod/modpost.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 620dc8c4c814..b9f2a040f185 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -339,8 +339,19 @@ static const char *sech_name(const struct elf_info *info, Elf_Shdr *sechdr)
>                                       sechdr->sh_name);
>  }
>
> -static const char *sec_name(const struct elf_info *info, int secindex)
> +static const char *sec_name_of_symbol(const struct elf_info *info,
> +                                     const Elf_Sym *sym)
>  {
> +       unsigned int secindex = get_secindex(info, sym);
> +
> +       /*
> +        * If sym->st_shndx is within the special section range, get_secindex()
> +        * will remapit to a big number.
> +        * Bail out here, otherwise info->sechdrs[secindex] would overrun.
> +        */
> +       if (secindex >= info->num_sections)
> +               return "";
> +
>         return sech_name(info, &info->sechdrs[secindex]);
>  }
>
> @@ -649,7 +660,7 @@ static void handle_symbol(struct module *mod, struct elf_info *info,
>                         const char *name, *secname;
>
>                         name = symname + strlen("__ksymtab_");
> -                       secname = sec_name(info, get_secindex(info, sym));
> +                       secname = sec_name_of_symbol(info, sym);
>
>                         if (strstarts(secname, "___ksymtab_gpl+"))
>                                 sym_add_exported(name, mod, true);
> @@ -1217,7 +1228,7 @@ static Elf_Sym *find_elf_symbol2(struct elf_info *elf, Elf_Addr addr,
>
>                 if (is_shndx_special(sym->st_shndx))
>                         continue;
> -               symsec = sec_name(elf, get_secindex(elf, sym));
> +               symsec = sec_name_of_symbol(elf, sym);
>                 if (strcmp(symsec, sec) != 0)
>                         continue;
>                 if (!is_valid_name(elf, sym))
> @@ -1457,7 +1468,7 @@ static void default_mismatch_handler(const char *modname, struct elf_info *elf,
>         if (strstarts(fromsym, "reference___initcall"))
>                 return;
>
> -       tosec = sec_name(elf, get_secindex(elf, sym));
> +       tosec = sec_name_of_symbol(elf, sym);
>         to = find_elf_symbol(elf, r->r_addend, sym);
>         tosym = sym_name(elf, to);
>
> @@ -1559,7 +1570,7 @@ static void extable_mismatch_handler(const char* modname, struct elf_info *elf,
>                                      Elf_Rela* r, Elf_Sym* sym,
>                                      const char *fromsec)
>  {
> -       const char* tosec = sec_name(elf, get_secindex(elf, sym));
> +       const char *tosec = sec_name_of_symbol(elf, sym);
>
>         sec_mismatch_count++;
>
> @@ -1593,7 +1604,7 @@ static void extable_mismatch_handler(const char* modname, struct elf_info *elf,
>  static void check_section_mismatch(const char *modname, struct elf_info *elf,
>                                    Elf_Rela *r, Elf_Sym *sym, const char *fromsec)
>  {
> -       const char *tosec = sec_name(elf, get_secindex(elf, sym));
> +       const char *tosec = sec_name_of_symbol(elf, sym);
>         const struct sectioncheck *mismatch = section_mismatch(fromsec, tosec);
>
>         if (mismatch) {
> --
> 2.32.0
>


-- 
Thanks,
~Nick Desaulniers
