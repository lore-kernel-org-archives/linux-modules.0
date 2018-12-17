Return-Path: <SRS0=eugf=O2=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19D3C43387
	for <linux-modules@archiver.kernel.org>; Mon, 17 Dec 2018 18:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B27C720874
	for <linux-modules@archiver.kernel.org>; Mon, 17 Dec 2018 18:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rj9F5J0A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbeLQSKw (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:10:52 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34804 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727453AbeLQSKw (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 17 Dec 2018 13:10:52 -0500
Received: by mail-wr1-f67.google.com with SMTP id j2so13305192wrw.1
        for <linux-modules@vger.kernel.org>; Mon, 17 Dec 2018 10:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p45F3g3dJLkNBJichC064//NaZ/lzybqeMdTFAd2nDw=;
        b=rj9F5J0AmabhgRVjRE2e2XwM6DlzpQkVT+e1hdGg9/dWSoAsFawdMlOQowXFDG25DC
         fu27PbcOtyfzW44wI25GZ6kvaCUMRS8HZZ7RQRNwDA1whb45IwBz8CcN9jwtkDVsxFGL
         sQs9UBnU6vsA2gg/FrS+2gwXACTQhYtcx+tySZksFOlMujbJiteAD2euX0Bm1q08ekLj
         QQUlQ2qMiwMRpDnq6Z3rttbSaANSZXNL5GATL7S5K1UhSF5nhZxLPC3SpWQspgMGrzTY
         VIxIz0TTSgusCEvuYaqYfeeXIlFmn+HxR1DPxSRwuP5+b3iJqDLhbxFjy4WvzI1RYW1I
         iV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p45F3g3dJLkNBJichC064//NaZ/lzybqeMdTFAd2nDw=;
        b=FecvlQrrqj7PcCv4A/kTUOx80Ljac6lFx+ANL6p9/83i5c0uXG9KI9byP21/HCkxkh
         Z1W1MqSAs7wivAH314HWsTogZU97YLl8qeNmNmsmDu31SQ09gJJikEfp7NQGfFXAEIJq
         7F1WhWZvgew068r67IGEQZlKlfF2SPUWX0Y9Wbv+6kpdX0jy5p5Z3Hwikfkh3kX8iHeB
         WWHHW1t0w+Wx3PPlMnqcO7ME+s5jq217xe62LtVb0+zaWtdpP7/Ky+Qiqj9F/+ihOH6o
         VEE2aQD9yeRsIOE6hVgKMl7CS7xCMW6ZdgbZBNDc2VKUUwDnM/lkIGBvWIeAsH3xrGAM
         MUbQ==
X-Gm-Message-State: AA+aEWZT4vFN4m45YZvPpgFaFP6AQD4qbyGYAzFN3RCBpqW7nLhTLmff
        uoK4nrZVDRecCs1yuD2WUirg/pnPmueLJvA6rMQlkw==
X-Google-Smtp-Source: AFSGD/WFySdQkMu2lQVTM3uhnhNioOFwIJerIaJug19pSLHvGk51zCImHfs1RI/F1n00GBBA3HnC+U9wtLW4Fw3kv48=
X-Received: by 2002:adf:e34b:: with SMTP id n11mr10940145wrj.91.1545070250205;
 Mon, 17 Dec 2018 10:10:50 -0800 (PST)
MIME-Version: 1.0
References: <cover.1544476531.git.msuchanek@suse.de> <636a25c106ac3da29803025248a237e9d23f4e9d.1544476531.git.msuchanek@suse.de>
In-Reply-To: <636a25c106ac3da29803025248a237e9d23f4e9d.1544476531.git.msuchanek@suse.de>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Mon, 17 Dec 2018 10:10:37 -0800
Message-ID: <CAKi4VA+VqSrmA1ZO4zAkumPZACupq=n7803N==7r+Uw9jtnnMg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] depmod: prevent module dependency files corruption
 due to parallel invocation.
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Mon, Dec 10, 2018 at 2:03 PM Michal Suchanek <msuchanek@suse.de> wrote:
>
> Depmod does not use unique filename for temporary files. There is no
> guarantee the user does not attempt to run mutiple depmod processes in
> parallel. If that happens a temporary file might be created by
> depmod(1st), truncated by depmod(2nd), and renamed to final name by
> depmod(1st) resulting in corrupted file seen by user.
>
> Due to missing mkstempat() this is more complex than it should be.
> Adding PID and timestamp to the filename should be reasonably reliable.
> Adding O_EXCL as mkstemp does fails creating the file rather than
> corrupting existing file.
>
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>  tools/depmod.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/tools/depmod.c b/tools/depmod.c
> index 18c0d61b2db3..3b6d16e76160 100644
> --- a/tools/depmod.c
> +++ b/tools/depmod.c
> @@ -29,6 +29,7 @@
>  #include <string.h>
>  #include <unistd.h>
>  #include <sys/stat.h>
> +#include <sys/time.h>
>  #include <sys/utsname.h>
>
>  #include <shared/array.h>
> @@ -2398,6 +2399,9 @@ static int depmod_output(struct depmod *depmod, FILE *out)
>         };
>         const char *dname = depmod->cfg->dirname;
>         int dfd, err = 0;
> +       struct timeval tv;
> +
> +       gettimeofday(&tv, NULL);
>
>         if (out != NULL)
>                 dfd = -1;
> @@ -2412,15 +2416,17 @@ static int depmod_output(struct depmod *depmod, FILE *out)
>
>         for (itr = depfiles; itr->name != NULL; itr++) {
>                 FILE *fp = out;
> -               char tmp[NAME_MAX] = "";
> +               char tmp[NAME_MAX + 1] = "";
>                 int r, ferr;
>
>                 if (fp == NULL) {
> -                       int flags = O_CREAT | O_TRUNC | O_WRONLY;
> +                       int flags = O_CREAT | O_TRUNC | O_WRONLY | O_EXCL;
>                         int mode = 0644;
>                         int fd;
>
> -                       snprintf(tmp, sizeof(tmp), "%s.tmp", itr->name);
> +                       snprintf(tmp, sizeof(tmp), "%s.%i.%li.%li", itr->name, getpid(),
> +                                       tv.tv_usec, tv.tv_sec);
> +                       tmp[NAME_MAX] = 0;

why? snprintf is guaranteed to nul-terminate the string.

Lucas De Marchi

>                         fd = openat(dfd, tmp, flags, mode);
>                         if (fd < 0) {
>                                 ERR("openat(%s, %s, %o, %o): %m\n",
> --
> 2.19.2
>


-- 
Lucas De Marchi
