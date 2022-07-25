Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F2FC43334
	for <linux-modules@archiver.kernel.org>; Mon, 25 Jul 2022 16:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236537AbiGYQnK (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 25 Jul 2022 12:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236458AbiGYQnJ (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 25 Jul 2022 12:43:09 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E978F73
        for <linux-modules@vger.kernel.org>; Mon, 25 Jul 2022 09:43:08 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id z25so18998619lfr.2
        for <linux-modules@vger.kernel.org>; Mon, 25 Jul 2022 09:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6GXN4LpbvWNFX8wB7bFkXQ9JIKeCsqQJeuvH6j+VamE=;
        b=TPKDQMzbZgN6H+Ftdpl/d2CbZ3dOR41Yd+IPC/laL4QqRJjOysTqT8QIwhZbrffX7X
         5Z7F/PBdnMSca6lEOHBKW5d1OFdVCsXJ+SGNbiHfhaWfICEfLuKqNRPT4O1sYTpAh4Wb
         v/4TCGjMp//GWe26w2moqZaozrOgRarYBe5oeosA15mAGVDZ8SM2IgcvUsaUeDrhMSoh
         A19vzL8jV4t7yfANUFrDgaDTGD6xJw3S20Jw5mtAFWztKOoft6+Lhg6jRnWcJayWJcDd
         ss0oUhDETHNFMojUC9KfVhIPJHHFm5RYRa8xQtG9LAv3X939LJ3z1RpsI/8MyHw4XY9Z
         Wkqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6GXN4LpbvWNFX8wB7bFkXQ9JIKeCsqQJeuvH6j+VamE=;
        b=P/HyDL1ElgOEdcqkVhJPfnAfZ8QsxuquZ8LjWmz5E0Xclvo7DGiGB7cubzv4JJyant
         /xA7k0jAq7RCJ4HmrOi9dORIZInXSlTBcd0yR4+JZlHKmmdahYu7RiakckmL5ebl/RRj
         gsCxIaLZOET2EXWWyVW8Ep/+aikZFZVqzPCmqA4GpdVrfgSdrspA7fn84qGih79aDP+N
         RgrpMwPeK+n1DJw6HhIWYTp8cqNDhlCuOdQGfhvQeMS1cdh1w2j3kfvLvIcSHND6mAxP
         QslQ/Kk6MPw4sPE3G4J5Lj70ebzvD04N/He1XuslOVAuAcpgjvm3HCxeckjJOBUQqW8S
         q19A==
X-Gm-Message-State: AJIora/Wh90A6tP3rh5T3VoryxooM8MUUzKV6Cq7So1sa4LmPhlQnIUe
        XFwRjD+br/iok3jNyC4Lk6AU3m+UDT3A48J7jz+WqQ==
X-Google-Smtp-Source: AGRyM1u4LwpNuQcu1clupnA8Af/UahPp2RV+KMGfCQyROw4AGJp8En2cKS+W4Z+fOHQP0sy6Gu3dzkyLOpdpNlLaNXw=
X-Received: by 2002:a05:6512:3e24:b0:48a:97af:d76e with SMTP id
 i36-20020a0565123e2400b0048a97afd76emr985048lfv.432.1658767386174; Mon, 25
 Jul 2022 09:43:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220610183236.1272216-1-masahiroy@kernel.org> <20220610183236.1272216-8-masahiroy@kernel.org>
In-Reply-To: <20220610183236.1272216-8-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 25 Jul 2022 09:42:53 -0700
Message-ID: <CAKwvOd=TCSWmG_sca9e49V-h3ZRdtP+cEazoO26vf475mJfyzg@mail.gmail.com>
Subject: Re: [PATCH 7/7] modpost: use null string instead of NULL pointer for
 default namespace
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Nicolas Pitre <npitre@baylibre.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Fri, Jun 10, 2022 at 11:34 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> The default namespace is the null string, "".
>
> When set, the null string "" is converted to NULL:
>
>   s->namespace = namespace[0] ? NOFAIL(strdup(namespace)) : NULL;
>
> When printed, the NULL pointer is get back to the null string:
>
>   sym->namespace ?: ""
>
> This saves 1 byte memory allocated for "", but loses the readability.
>
> In kernel-space, we strive to save memory, but modpost is a userspace
> tool used to build the kernel. On modern systems, such small piece of
> memory is not a big deal.
>
> Handle the namespace string as is.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Sorry for the late review.  If this is still useful:
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Feel free to ping me via mail if I'm falling behind. Otherwise you
should join us on IRC. (#clangbuiltlinux on libera)

> ---
>
>  scripts/mod/modpost.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 0db2cbb74a2a..5a1785645943 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -296,6 +296,13 @@ static bool contains_namespace(struct list_head *head, const char *namespace)
>  {
>         struct namespace_list *list;
>
> +       /*
> +        * The default namespace is null string "", which is always implicitly
> +        * contained.
> +        */
> +       if (!namespace[0])
> +               return true;
> +
>         list_for_each_entry(list, head, list) {
>                 if (!strcmp(list->namespace, namespace))
>                         return true;
> @@ -371,7 +378,7 @@ static struct symbol *sym_add_exported(const char *name, struct module *mod,
>         s = alloc_symbol(name);
>         s->module = mod;
>         s->is_gpl_only = gpl_only;
> -       s->namespace = namespace[0] ? NOFAIL(strdup(namespace)) : NULL;
> +       s->namespace = NOFAIL(strdup(namespace));
>         list_add_tail(&s->list, &mod->exported_symbols);
>         hash_add_symbol(s);
>
> @@ -2117,8 +2124,7 @@ static void check_exports(struct module *mod)
>                 else
>                         basename = mod->name;
>
> -               if (exp->namespace &&
> -                   !contains_namespace(&mod->imported_namespaces, exp->namespace)) {
> +               if (!contains_namespace(&mod->imported_namespaces, exp->namespace)) {
>                         modpost_log(allow_missing_ns_imports ? LOG_WARN : LOG_ERROR,
>                                     "module %s uses symbol %s from namespace %s, but does not import it.\n",
>                                     basename, exp->name, exp->namespace);
> @@ -2201,7 +2207,7 @@ static void add_exported_symbols(struct buffer *buf, struct module *mod)
>         list_for_each_entry(sym, &mod->exported_symbols, list)
>                 buf_printf(buf, "KSYMTAB_ENTRY(%s, \"%s\", \"%s\");\n",
>                            sym->name, sym->is_gpl_only ? "_gpl" : "",
> -                          sym->namespace ?: "");
> +                          sym->namespace);
>
>         if (!modversions)
>                 return;
> @@ -2471,7 +2477,7 @@ static void write_dump(const char *fname)
>                         buf_printf(&buf, "0x%08x\t%s\t%s\tEXPORT_SYMBOL%s\t%s\n",
>                                    sym->crc, sym->name, mod->name,
>                                    sym->is_gpl_only ? "_GPL" : "",
> -                                  sym->namespace ?: "");
> +                                  sym->namespace);
>                 }
>         }
>         write_buf(&buf, fname);
> --
> 2.32.0
>


-- 
Thanks,
~Nick Desaulniers
