Return-Path: <SRS0=ZO2f=NX=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6377C43441
	for <linux-modules@archiver.kernel.org>; Mon, 12 Nov 2018 23:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F167223DD
	for <linux-modules@archiver.kernel.org>; Mon, 12 Nov 2018 23:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqqnXywO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F167223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-modules-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbeKMI4i (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 13 Nov 2018 03:56:38 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51784 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbeKMI4i (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 13 Nov 2018 03:56:38 -0500
Received: by mail-wm1-f66.google.com with SMTP id w7-v6so10066536wmc.1
        for <linux-modules@vger.kernel.org>; Mon, 12 Nov 2018 15:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XYrl8oINJ8WXnBENkkAtFEpi3sm7ftWRzNNf86DXNI0=;
        b=RqqnXywOMvuNTAkkPDDdXkkXOmOyracGq79L0ptIZR4VbpIWlapX6kf/KcVzwDwkoM
         BmLzQ3VgPyPRjpJHU1LRpjrpLiHjDvQdcDBbPGvMhVyZYJ9tKLjB5hNxj5H3Rx0oyOc2
         hhp9bF9LwFKsIU3w5YxYa+p0rmTB+1iLKcS4Wla34ZUEsN/Lk2TNbrUmOGNNrW7kLEQQ
         4lqrIxeZ0S1YEVTZ45NvDi2cHifM033j/l5BVrMEP9ZA22Tu0I3t38+vLIp5P33XtXPB
         XRCvSO+HyplsMKPEJWywQ7K9ckcSCcrdaQ/KSvyTH+NyANzOzhEhbcE+uQ6Ds2N6PHZh
         O8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XYrl8oINJ8WXnBENkkAtFEpi3sm7ftWRzNNf86DXNI0=;
        b=fEiGkHb4GeNxY9lwNpERsjtXyswePuTnVlHWuEVV4oMmqUhetSefLxuXf9j64G7LjQ
         hEJF6bGQSTt7JdhfMUGrUwNV757LXfDif181PzGinK8iJgtgYFzqOYB+O7+nCXfvPO4c
         U4F5yYQa4LgsgoOymBO2wjl73BIRMcvS86vtl10o2JvEtQQtU7e8G1Ut3uCTv6bqx+p+
         UtaNx+zcLSeqGjjbo+9mGtEqpcq9R2OWu+ra+aFfrsahZVf5odWWiUj6cr+x3DJr+rNN
         X46i9VNks1fjUZ5kK+lN+sYLqjK7YeIeQtBoz4zXJNeAsqazn7hvq6T1FwcVz56LoDzt
         TCgA==
X-Gm-Message-State: AGRZ1gKYRqrcEeFomQylCJh4ulKlD1ZngFWObike1se6KANY17yBGMhj
        N/larDOcg69D7Ucf70cOX4B5fGz5p+QtZ8JeNiZPUuVj
X-Google-Smtp-Source: AJdET5ebQlEUf+g7/xO9mI0C5yeHD/lUUqk82lyjjDcyU2SEzrPWTQAlhl1ivMqu47DeE1ajVTIrKCLo2KjTGuaN/Xw=
X-Received: by 2002:a1c:ce0e:: with SMTP id e14-v6mr1191778wmg.45.1542063679520;
 Mon, 12 Nov 2018 15:01:19 -0800 (PST)
MIME-Version: 1.0
References: <20181108115637.27597-1-yauheni.kaliuta@redhat.com> <xunya7mjda94.fsf@redhat.com>
In-Reply-To: <xunya7mjda94.fsf@redhat.com>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Mon, 12 Nov 2018 15:01:07 -0800
Message-ID: <CAKi4VA+yvASp_vivTZWgvPqihP=FKo=iyG2q+n5d6SR-ONAsjA@mail.gmail.com>
Subject: Re: [PATCH] modprobe: add --show-exports
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     linux-modules <linux-modules@vger.kernel.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, Nov 8, 2018 at 4:29 AM Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
>
> Hi!
>
> Actually it doesn't sound good because of the API:
>
> [...]
>
> kmod_module_versions_free_list(list);
> kmod_module_unref(mod);
>
> It is supposed that the list produced by
> kmod_module_get_versions() only, not kmod_module_get_symbols(),
> even if the structures actually have the same fields.
>
> Would it be good if I change the internals a bit, to use only
> struct kmod_module_symbol (it is possible to keep external API
> the same for compatibility)?

it's in the TODO file:
 * review API, maybe unify all of these getters:
    - kmod_module_version_get_symbol()
    - kmod_module_version_get_crc()
    - kmod_module_symbol_get_symbol()
    - kmod_module_symbol_get_crc()
    - kmod_module_dependency_symbol_get_symbol()
    - kmod_module_dependency_symbol_get_crc()
    - kmod_module_versions_free_list()
    - kmod_module_symbols_free_list()
    - kmod_module_dependency_symbols_free_list()

However this means breaking API, so it was never a great appeal. Maybe
we could add new ones
and keep the old functions for compatibility.

Lucas De Marchi

>
> Or there are reasons to keep them different now?
>
> >>>>> On Thu,  8 Nov 2018 13:56:37 +0200, Yauheni Kaliuta  wrote:
>
>  > modprobe has --show-modversions switch, which dumps symbols with
>  > their modversion crcs from the __versions sections.
>
>  > At the moment the section contains information for the dependency
>  > symbols only, while exported symbols add to symtab entries with
>  > __crc_ prefix (the format may differ, see 1e48901166ef libkmod-elf:
>  > resolve CRC if module is built with MODULE_REL_CRCS).
>
>  > The patch makes it to show exported symbols as well.
>
>  > It refactors the --show-modversions code to avoid duplications.
>
>  > Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
>  > ---
>  >  tools/modprobe.c | 26 ++++++++++++++++++++++++--
>  >  1 file changed, 24 insertions(+), 2 deletions(-)
>
>  > diff --git a/tools/modprobe.c b/tools/modprobe.c
>  > index 43605ccaf0f0..97da4e6986ce 100644
>  > --- a/tools/modprobe.c
>  > +++ b/tools/modprobe.c
>  > @@ -76,6 +76,8 @@ static const struct option cmdopts[] = {
>  >      {"show-config", no_argument, 0, 'c'},
>  >      {"show-modversions", no_argument, 0, 4},
>  >      {"dump-modversions", no_argument, 0, 4},
>  > +    {"show-exports", no_argument, 0, 6},
>  > +    {"dump-exports", no_argument, 0, 6},
>
>  >      {"dry-run", no_argument, 0, 'n'},
>  >      {"show", no_argument, 0, 'n'},
>  > @@ -124,6 +126,8 @@ static void help(void)
>  >              "\t-c, --show-config           Same as --showconfig\n"
>  >              "\t    --show-modversions      Dump module symbol version and exit\n"
>  >              "\t    --dump-modversions      Same as --show-modversions\n"
>  > +            "\t    --show-exports          Dump module exported symbol versions and exit\n"
>  > +            "\t    --dump-exports          Same as --show-exports\n"
>  >              "\n"
>  >              "General Options:\n"
>  >              "\t-n, --dry-run               Do not execute operations, just print out\n"
>  > @@ -204,7 +208,9 @@ static int show_config(struct kmod_ctx *ctx)
>  >      return 0;
>  >  }
>
>  > -static int show_modversions(struct kmod_ctx *ctx, const char *filename)
>  > +static int show_versions(struct kmod_ctx *ctx,
>  > +                     int (*get_versions_f)(const struct kmod_module *, struct kmod_list **),
>  > +                     const char *filename)
>  >  {
>  >      struct kmod_list *l, *list = NULL;
>  >      struct kmod_module *mod;
>  > @@ -214,7 +220,7 @@ static int show_modversions(struct kmod_ctx *ctx, const char *filename)
>  >              return err;
>  >      }
>
>  > -    err = kmod_module_get_versions(mod, &list);
>  > +    err = get_versions_f(mod, &list);
>  >      if (err < 0) {
>  >              LOG("could not get modversions of %s: %s\n",
>  >                      filename, strerror(-err));
>  > @@ -232,6 +238,16 @@ static int show_modversions(struct kmod_ctx *ctx, const char *filename)
>  >      return 0;
>  >  }
>
>  > +static int show_modversions(struct kmod_ctx *ctx, const char *filename)
>  > +{
>  > +    return show_versions(ctx, kmod_module_get_versions, filename);
>  > +}
>  > +
>  > +static int show_exports(struct kmod_ctx *ctx, const char *filename)
>  > +{
>  > +    return show_versions(ctx, kmod_module_get_symbols, filename);
>  > +}
>  > +
>  >  static int command_do(struct kmod_module *module, const char *type,
>  >                              const char *command, const char *cmdline_opts)
>  >  {
>  > @@ -727,6 +743,7 @@ static int do_modprobe(int argc, char **orig_argv)
>  >      int do_remove = 0;
>  >      int do_show_config = 0;
>  >      int do_show_modversions = 0;
>  > +    int do_show_exports = 0;
>  >      int err;
>
>  >      argv = prepend_options_from_env(&argc, orig_argv);
>  > @@ -783,6 +800,9 @@ static int do_modprobe(int argc, char **orig_argv)
>  >              case 4:
>  >                      do_show_modversions = 1;
>  >                      break;
>  > +            case 6:
>  > +                    do_show_exports = 1;
>  > +                    break;
>  >              case 'n':
>  >                      dry_run = 1;
>  >                      break;
>  > @@ -886,6 +906,8 @@ static int do_modprobe(int argc, char **orig_argv)
>  >              err = show_config(ctx);
>  >      else if (do_show_modversions)
>  >              err = show_modversions(ctx, args[0]);
>  > +    else if (do_show_exports)
>  > +            err = show_exports(ctx, args[0]);
>  >      else if (do_remove)
>  >              err = rmmod_all(ctx, args, nargs);
>  >      else if (use_all)
>  > --
>  > 2.19.1
>
>
> --
> WBR,
> Yauheni Kaliuta



-- 
Lucas De Marchi
