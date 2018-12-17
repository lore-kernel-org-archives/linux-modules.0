Return-Path: <SRS0=eugf=O2=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D36C43387
	for <linux-modules@archiver.kernel.org>; Mon, 17 Dec 2018 18:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2659C20675
	for <linux-modules@archiver.kernel.org>; Mon, 17 Dec 2018 18:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7FbMWFB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbeLQSTm (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:19:42 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43750 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbeLQSTm (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 17 Dec 2018 13:19:42 -0500
Received: by mail-wr1-f66.google.com with SMTP id r10so13283017wrs.10
        for <linux-modules@vger.kernel.org>; Mon, 17 Dec 2018 10:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LYGddb8YYrMJ3UN8pSjOsZ0d+DKLubud0sJErM3ynMk=;
        b=N7FbMWFBPcWhXxx/dWANJLKUCRml3fPp8iqD2rNJeeX2ku3OrdMIPMHCjXuxmLIkAX
         47j5wTxqL7nqafB3vvUa3NeANbHY8BKu1TyNGOthc6CNyCslpWmjAcmFjp5VG4mBQtIo
         BaTmoVehu3QBjxe9nNeJqMSHFJS+QGP0il7vQSqGJPzhwgpzAcDS7ROfhc880lQ731AC
         ifY5xh8ZsnX+7yq81sa49ccoVFL2F6FMDz7vvmWPu+3ncmK+tHjLFNxaF0FL9+NwmEZp
         6Ahtj1tlS3a4J2hbgzPxRBU1tdBPwZiB04+IETi+WOu3fYMQUNRsqDvB/ASar7EYzTxi
         9Zew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LYGddb8YYrMJ3UN8pSjOsZ0d+DKLubud0sJErM3ynMk=;
        b=cbHxEEjNh014y67EDidQQwuOQvK7Le06qPi4LP/BgsjimfcDMoUTRDg6JB/S8fyTlR
         w4BCIFzgFFQWecnUSbF55o4cVaTR7sIe++/vlEiuf6jWAyaercVKoopeRnntTmTYfk/H
         auQh1w5q+WANLYnx8cMZk/ms34mjD625CI9uKHQfeLa7hlbem1oUJqx08hSfhIDkvNA9
         n99vmKtsfKQLsMwzCtaIjA5jbYgiujhLDHcOm5gPqa6TOiPW0b4L4TkPGQlrfC1FyOsU
         XOgDxZ99bHAfeVV3gcMPOxFYNboWTHJtH1S4kirZUF+l9vOA/0pXWaq2w5JKBONCoFOL
         6IIw==
X-Gm-Message-State: AA+aEWaudvDtDm6uY8DPcA0XlT1tALfVcs60kyKH8Wj9GyOuVuGXGYNJ
        ljU0goLW9bdpd1k8cfmxaQiS8jcVOGch1worZ5wXUA==
X-Google-Smtp-Source: AFSGD/XOfstzccGpDBVh3s3YUtBJzQYKV3jPyUGhJGMT4/um9YQ6NvwvUPmsjExP2ohM/BF0dkHUooBxhlCKMjiomjw=
X-Received: by 2002:adf:b716:: with SMTP id l22mr12260705wre.186.1545070780556;
 Mon, 17 Dec 2018 10:19:40 -0800 (PST)
MIME-Version: 1.0
References: <cover.1544476531.git.msuchanek@suse.de> <b45014c93b47d9100d0add3d9458e6ec29d0f188.1544476531.git.msuchanek@suse.de>
In-Reply-To: <b45014c93b47d9100d0add3d9458e6ec29d0f188.1544476531.git.msuchanek@suse.de>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Mon, 17 Dec 2018 10:19:28 -0800
Message-ID: <CAKi4VA+pe9ZiXYjL9YZbJCuwevPGRU7db0ZX1Qe_Sj=RX_8Ynw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] depmod: shut up gcc insufficinet buffer warning.
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Mon, Dec 10, 2018 at 2:03 PM Michal Suchanek <msuchanek@suse.de> wrote:
>
> In a couple of places depmod concatenates the module directory and filename
> with snprintf. This can technically overflow creating an unterminated string if
> module directory name is long. Use openat instead as is done elsewhere in
> depmod. This avoids the snprintf, the extra buffer on stack, and the gcc
> warning. It may even fix a corner case when the module direcotry name is just
> under PATH_MAX.
>
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>  tools/depmod.c | 51 ++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 35 insertions(+), 16 deletions(-)
>
> diff --git a/tools/depmod.c b/tools/depmod.c
> index 3b6d16e76160..fb76f823c016 100644
> --- a/tools/depmod.c
> +++ b/tools/depmod.c
> @@ -1389,19 +1389,42 @@ static int depmod_modules_build_array(struct depmod *depmod)
>         return 0;
>  }
>
> +static FILE * dfdopen(const char * dname, const char * filename, int flags, const char * mode)

coding style here is not consistent with the rest. We don't have space
after "*".

> +       {

and this is wrongly indented.

Other than that this LGTM and I can fixup the styling issues while applying.

Thanks.
Lucas De Marchi

> +       int fd, dfd;
> +       FILE * ret;
> +
> +       dfd = open(dname, O_RDONLY);
> +       if (dfd < 0) {
> +               WRN("could not open directory %s: %m\n", dname);
> +               return NULL;
> +       }
> +
> +       fd = openat(dfd, filename, flags);
> +       if (fd < 0) {
> +               WRN("could not open %s at %s: %m\n", filename, dname);
> +               ret = NULL;
> +       } else {
> +               ret = fdopen(fd, mode);
> +               if (!ret)
> +                       WRN("could not associate stream with %s: %m\n", filename);
> +       }
> +       close(dfd);
> +       return ret;
> +}
> +
> +
> +
>  static void depmod_modules_sort(struct depmod *depmod)
>  {
> -       char order_file[PATH_MAX], line[PATH_MAX];
> +       char line[PATH_MAX];
> +       const char * order_file = "modules.order";
>         FILE *fp;
>         unsigned idx = 0, total = 0;
>
> -       snprintf(order_file, sizeof(order_file), "%s/modules.order",
> -                depmod->cfg->dirname);
> -       fp = fopen(order_file, "r");
> -       if (fp == NULL) {
> -               WRN("could not open %s: %m\n", order_file);
> +       fp = dfdopen(depmod->cfg->dirname, order_file, O_RDONLY, "r");
> +       if (fp == NULL)
>                 return;
> -       }
>
>         while (fgets(line, sizeof(line), fp) != NULL) {
>                 size_t len = strlen(line);
> @@ -1409,8 +1432,8 @@ static void depmod_modules_sort(struct depmod *depmod)
>                 if (len == 0)
>                         continue;
>                 if (line[len - 1] != '\n') {
> -                       ERR("%s:%u corrupted line misses '\\n'\n",
> -                               order_file, idx);
> +                       ERR("%s/%s:%u corrupted line misses '\\n'\n",
> +                               depmod->cfg->dirname, order_file, idx);
>                         goto corrupted;
>                 }
>         }
> @@ -2287,18 +2310,14 @@ static int output_builtin_bin(struct depmod *depmod, FILE *out)
>  {
>         FILE *in;
>         struct index_node *idx;
> -       char infile[PATH_MAX], line[PATH_MAX], modname[PATH_MAX];
> +       char line[PATH_MAX], modname[PATH_MAX];
>
>         if (out == stdout)
>                 return 0;
>
> -       snprintf(infile, sizeof(infile), "%s/modules.builtin",
> -                                                       depmod->cfg->dirname);
> -       in = fopen(infile, "r");
> -       if (in == NULL) {
> -               WRN("could not open %s: %m\n", infile);
> +       in = dfdopen(depmod->cfg->dirname, "modules.builtin", O_RDONLY, "r");
> +       if (in == NULL)
>                 return 0;
> -       }
>
>         idx = index_create();
>         if (idx == NULL) {
> --
> 2.19.2
>


-- 
Lucas De Marchi
