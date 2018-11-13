Return-Path: <SRS0=A0aH=NY=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776A8C43441
	for <linux-modules@archiver.kernel.org>; Tue, 13 Nov 2018 23:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D6B12175B
	for <linux-modules@archiver.kernel.org>; Tue, 13 Nov 2018 23:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axA0oaVe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D6B12175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-modules-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbeKNJG0 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 14 Nov 2018 04:06:26 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44859 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbeKNJG0 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 14 Nov 2018 04:06:26 -0500
Received: by mail-wr1-f65.google.com with SMTP id j17-v6so15153223wrq.11
        for <linux-modules@vger.kernel.org>; Tue, 13 Nov 2018 15:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fHtQ3I/JrxKtD3n+IKGJ+YnmxVWvTuUgumCVCdBh018=;
        b=axA0oaVe/XGkAOJKObOzL7U/nGgRaU6vAb4zWIaS1A2+06xA3ptN9N/nYlgFiXo8tm
         YgdvOyz3O/N7G8vea2AG8IT5QJQFZv5WMu1UXWIrQaPONAd3caiFVjdoZWFe57I73tMb
         26qEgNoK7p+3qLjExMElEhS28tzbf0xq74ZnsWvXUylBNJi0A/7KGgj5V3/Ls/jD2rme
         Yx4BnlMZQ827oYwMsI0jVFR3d8BgVlGBJo9GvyEHY1FyId+B7VCQ6lqxo5fJzO9bbTfk
         RQP7enCax5oHDFh6s4GKD8++f2AL2nKGErv/5N558uoQF8JpioeOZjrH1aQZ2J6sezOK
         T2gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fHtQ3I/JrxKtD3n+IKGJ+YnmxVWvTuUgumCVCdBh018=;
        b=NsghC+5kbx1QeMWCiczniCJwo3D0/+4L3k6gbjdxi+8xtr1V8tG6qSBBqHoqC6Rouo
         8JNQu+hl3Xn3IWDA9FLFvcmiTAZZ93/uooJ4b223WpSMFjFO2n0BeD9mAfDmUQjsSNlu
         LGo/ybb9RULheDUEBt0lmQCvRcLACNu+H5DKVh7FBeawBqnV/MT+/iz4fMKtk4n+RoTz
         rI1kAtTIEP0MflBi/SNLMKGIS7kxWqatiGwY+GCraGUBO498ZZKMOJG7aQmvrk0+fg5b
         ziteX7csTCoflvZRHP3zZNVsEXrG6rWXUIMnbFCsvRFOMbi/elPfXjhg4Dk7NvyTjcZa
         7k2Q==
X-Gm-Message-State: AGRZ1gJqEw5lqlXxSIuhv3UvjBsGiU9JVY2PCyLmXJ1IGXLQXWcL6CZ3
        QM4ksLwX9tcoQ9vH+qsT9WIF5DUQ/5CQMZzl7Js=
X-Google-Smtp-Source: AJdET5fd2pq8zOpq51s6bjByNwfZH7RVaeLH31LErMx8AShu1MCA20gxna8c5iwueQcJnJYGEPvHIjeTs+KPYzuGL5o=
X-Received: by 2002:adf:a409:: with SMTP id d9-v6mr6840850wra.190.1542150358876;
 Tue, 13 Nov 2018 15:05:58 -0800 (PST)
MIME-Version: 1.0
References: <CAKi4VA+i0NS5L2tgv951dXEcbzbcGF9WL=+VqSn9bLJtzvS-qg@mail.gmail.com>
 <20181113090029.4075-1-yauheni.kaliuta@redhat.com>
In-Reply-To: <20181113090029.4075-1-yauheni.kaliuta@redhat.com>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Tue, 13 Nov 2018 15:05:47 -0800
Message-ID: <CAKi4VA+m9=pCPGu-odsr4=d-snRLdgAJ3Cv8qp_HfhjaxP0aTQ@mail.gmail.com>
Subject: Re: [PATCH v3] modprobe: add --show-exports
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     linux-modules <linux-modules@vger.kernel.org>, ykaliuta@redhat.com,
        Lucas De Marchi <lucas.demarchi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue, Nov 13, 2018 at 12:59 AM Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
>
> modprobe has --show-modversions switch, which dumps symbols with
> their modversion crcs from the __versions sections.
>
> At the moment the section contains information for the dependency
> symbols only, while exported symbols add to symtab entries with
> __crc_ prefix (the format may differ, see 1e48901166ef libkmod-elf:
> resolve CRC if module is built with MODULE_REL_CRCS).
>
> The patch makes it to show exported symbols as well.
>
> The function is basically cut'n'paste of show_modversions(),
> but 'version' family replaced with 'symbol' one.
>
> Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> ---

Applied, thanks

Lucas De Marchi

>  tools/modprobe.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> ---
> Changelog:
>
> v2 -> v3:
>
> - remove --dump-exports
> - amend help string to be like --show-depends
>
> v1 -> v2:
>
> - do not abstract show functions, because it requires API change
>
> diff --git a/tools/modprobe.c b/tools/modprobe.c
> index 43605ccaf0f0..a9e2331567af 100644
> --- a/tools/modprobe.c
> +++ b/tools/modprobe.c
> @@ -76,6 +76,7 @@ static const struct option cmdopts[] = {
>         {"show-config", no_argument, 0, 'c'},
>         {"show-modversions", no_argument, 0, 4},
>         {"dump-modversions", no_argument, 0, 4},
> +       {"show-exports", no_argument, 0, 6},
>
>         {"dry-run", no_argument, 0, 'n'},
>         {"show", no_argument, 0, 'n'},
> @@ -124,6 +125,7 @@ static void help(void)
>                 "\t-c, --show-config           Same as --showconfig\n"
>                 "\t    --show-modversions      Dump module symbol version and exit\n"
>                 "\t    --dump-modversions      Same as --show-modversions\n"
> +               "\t    --show-exports          Only print module exported symbol versions and exit\n"
>                 "\n"
>                 "General Options:\n"
>                 "\t-n, --dry-run               Do not execute operations, just print out\n"
> @@ -232,6 +234,34 @@ static int show_modversions(struct kmod_ctx *ctx, const char *filename)
>         return 0;
>  }
>
> +static int show_exports(struct kmod_ctx *ctx, const char *filename)
> +{
> +       struct kmod_list *l, *list = NULL;
> +       struct kmod_module *mod;
> +       int err = kmod_module_new_from_path(ctx, filename, &mod);
> +       if (err < 0) {
> +               LOG("Module %s not found.\n", filename);
> +               return err;
> +       }
> +
> +       err = kmod_module_get_symbols(mod, &list);
> +       if (err < 0) {
> +               LOG("could not get symbols of %s: %s\n",
> +                       filename, strerror(-err));
> +               kmod_module_unref(mod);
> +               return err;
> +       }
> +
> +       kmod_list_foreach(l, list) {
> +               const char *symbol = kmod_module_symbol_get_symbol(l);
> +               uint64_t crc = kmod_module_symbol_get_crc(l);
> +               printf("0x%08"PRIx64"\t%s\n", crc, symbol);
> +       }
> +       kmod_module_symbols_free_list(list);
> +       kmod_module_unref(mod);
> +       return 0;
> +}
> +
>  static int command_do(struct kmod_module *module, const char *type,
>                                 const char *command, const char *cmdline_opts)
>  {
> @@ -727,6 +757,7 @@ static int do_modprobe(int argc, char **orig_argv)
>         int do_remove = 0;
>         int do_show_config = 0;
>         int do_show_modversions = 0;
> +       int do_show_exports = 0;
>         int err;
>
>         argv = prepend_options_from_env(&argc, orig_argv);
> @@ -783,6 +814,9 @@ static int do_modprobe(int argc, char **orig_argv)
>                 case 4:
>                         do_show_modversions = 1;
>                         break;
> +               case 6:
> +                       do_show_exports = 1;
> +                       break;
>                 case 'n':
>                         dry_run = 1;
>                         break;
> @@ -886,6 +920,8 @@ static int do_modprobe(int argc, char **orig_argv)
>                 err = show_config(ctx);
>         else if (do_show_modversions)
>                 err = show_modversions(ctx, args[0]);
> +       else if (do_show_exports)
> +               err = show_exports(ctx, args[0]);
>         else if (do_remove)
>                 err = rmmod_all(ctx, args, nargs);
>         else if (use_all)
> --
> 2.19.1
>


-- 
Lucas De Marchi
