Return-Path: <SRS0=ZO2f=NX=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5854EC43441
	for <linux-modules@archiver.kernel.org>; Mon, 12 Nov 2018 23:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 053EF223D8
	for <linux-modules@archiver.kernel.org>; Mon, 12 Nov 2018 23:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wj5sZd4v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 053EF223D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-modules-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbeKMJKm (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 13 Nov 2018 04:10:42 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41842 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbeKMJKm (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 13 Nov 2018 04:10:42 -0500
Received: by mail-wr1-f66.google.com with SMTP id v18-v6so11206636wrt.8
        for <linux-modules@vger.kernel.org>; Mon, 12 Nov 2018 15:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LIkvLHzeHLDXjMz0lWn8gfaifTYiAyCa7Em1SA1yaao=;
        b=Wj5sZd4vZxD+6d1KQmaUseINBnP9zNeJ6Ig9hA0QFtVIGoJSHcHUAn9xxA5CAtwr6K
         9awuuy/Obj3h2QS0ejNWafXeb5px9NDOGrj+TFkgteuTTbjaiRE9t/BpEpSUCZTABePv
         hEWoab7h7YEYyGnxMrRpyDq4lvpVsstxR8yovnfv0qiyi9c/ggCypitDY0OhIZfecxxj
         iiYA7DRGSEI/fmJY3SROgD8YWGC0Qz9H/ugXIEQLkX6lHtXqGHfZXqSRNxFPMWqi5t8W
         ZuMP9K9npJr9mG2pFCkcZtv5OhCRxh8oBvhA0J9K1hCMjmiRelvc7Z4EvtGpbTQSgblN
         wb6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LIkvLHzeHLDXjMz0lWn8gfaifTYiAyCa7Em1SA1yaao=;
        b=NsAvxEZ1vy5pyJ72XeP319k18eV/cxQ3Yt+Tr55u5baT/oHmWqM8IfZUgr3JohrIMZ
         CRKcvnI84x+q0k3/fyy1fvAJYurhOGCs4vrRuzNEDStuLM1cy+1EBFLrSaaPwwexnDix
         SBlhU+aiUkN2addRkeQf696bpzExCZW546epR4ypn/eZ6TDmpywbu5ROfUhWJlH5XToG
         XM+xAQvMBpp3O0SQuViFK6pg9f8VunUMKWNURCbvo3stPD8aDJ3kDg1IXX2ZjUt7R+BC
         wg4bxMhOcPO6TxKYpgsWnZfDp9tVog31wcGXix/N4q8qlsE0VQokMYOCuVV8OB8qQXN2
         etHw==
X-Gm-Message-State: AGRZ1gLySXdJgkKQ0OavQVeKC5cZvBXtoXJlvrA8vbZbI9FB6/FdLU5M
        czVpZegwHCJBc3go0lTTaxkfLXZ0W/Sgis2x+v+Ykw==
X-Google-Smtp-Source: AJdET5e7Na0PnXliXkB7o5Cjj4OIUQ1vM0W8g486GbL8XWAtoY1xHpDEjdCikvYJPyWGJfhedVCN7hepSeN5RIgZkEI=
X-Received: by 2002:a05:6000:1283:: with SMTP id f3mr2675492wrx.140.1542064520865;
 Mon, 12 Nov 2018 15:15:20 -0800 (PST)
MIME-Version: 1.0
References: <20181112154918.3137-1-yauheni.kaliuta@redhat.com>
In-Reply-To: <20181112154918.3137-1-yauheni.kaliuta@redhat.com>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Mon, 12 Nov 2018 15:15:08 -0800
Message-ID: <CAKi4VA+i0NS5L2tgv951dXEcbzbcGF9WL=+VqSn9bLJtzvS-qg@mail.gmail.com>
Subject: Re: [PATCH v2] modprobe: add --show-exports
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     linux-modules <linux-modules@vger.kernel.org>, ykaliuta@redhat.com,
        Lucas De Marchi <lucas.demarchi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Mon, Nov 12, 2018 at 7:48 AM Yauheni Kaliuta
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
>  tools/modprobe.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/tools/modprobe.c b/tools/modprobe.c
> index 43605ccaf0f0..ca161d09940c 100644
> --- a/tools/modprobe.c
> +++ b/tools/modprobe.c
> @@ -76,6 +76,8 @@ static const struct option cmdopts[] = {
>         {"show-config", no_argument, 0, 'c'},
>         {"show-modversions", no_argument, 0, 4},
>         {"dump-modversions", no_argument, 0, 4},
> +       {"show-exports", no_argument, 0, 6},
> +       {"dump-exports", no_argument, 0, 6},
>
>         {"dry-run", no_argument, 0, 'n'},
>         {"show", no_argument, 0, 'n'},
> @@ -124,6 +126,8 @@ static void help(void)
>                 "\t-c, --show-config           Same as --showconfig\n"
>                 "\t    --show-modversions      Dump module symbol version and exit\n"
>                 "\t    --dump-modversions      Same as --show-modversions\n"
> +               "\t    --show-exports          Dump module exported symbol versions and exit\n"
> +               "\t    --dump-exports          Same as --show-exports\n"

all the others are show-*. The dump-* and show* should be considered
aliases for compatibility. So I don't think we need that on a new one.

Lucas De Marchi

>                 "\n"
>                 "General Options:\n"
>                 "\t-n, --dry-run               Do not execute operations, just print out\n"
> @@ -232,6 +236,34 @@ static int show_modversions(struct kmod_ctx *ctx, const char *filename)
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
> @@ -727,6 +759,7 @@ static int do_modprobe(int argc, char **orig_argv)
>         int do_remove = 0;
>         int do_show_config = 0;
>         int do_show_modversions = 0;
> +       int do_show_exports = 0;
>         int err;
>
>         argv = prepend_options_from_env(&argc, orig_argv);
> @@ -783,6 +816,9 @@ static int do_modprobe(int argc, char **orig_argv)
>                 case 4:
>                         do_show_modversions = 1;
>                         break;
> +               case 6:
> +                       do_show_exports = 1;
> +                       break;
>                 case 'n':
>                         dry_run = 1;
>                         break;
> @@ -886,6 +922,8 @@ static int do_modprobe(int argc, char **orig_argv)
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
