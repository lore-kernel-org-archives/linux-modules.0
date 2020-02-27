Return-Path: <SRS0=uawh=4P=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8745C4BA3C
	for <linux-modules@archiver.kernel.org>; Thu, 27 Feb 2020 08:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 975E82467B
	for <linux-modules@archiver.kernel.org>; Thu, 27 Feb 2020 08:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJ4byFzn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbgB0IoC (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 27 Feb 2020 03:44:02 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46354 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbgB0IoC (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 27 Feb 2020 03:44:02 -0500
Received: by mail-wr1-f68.google.com with SMTP id j7so2170429wrp.13
        for <linux-modules@vger.kernel.org>; Thu, 27 Feb 2020 00:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mLUOzi+75LC+LpoTw1P0vq9GAVyNQdTNfnYIoamCwiI=;
        b=QJ4byFzneM2HNtD2ZPh+4ytuXQKSh6kNZz20CdKv4r23brJM/XZwlm6VEy7gUIjPfN
         2cmD1NZ9ubJEYO7mcopsS+FTeqEmw0lY/Zs0+FZ6AMe8U17G6jiTwH4+QJpiinY+1553
         fVobtz58xOUJVHp7uDr+TDbyBtTKbKJvg+ste1/BDsuvuQnJ0A+cjfzMDXAlae/YI8QV
         yCVhmwudlg3oNCiFn0S0XXCax+68v2F/Gw8L01S7qYgx3gx+8x2JPJf5surN2CWpFLiI
         1sAhvhnLnTxOLkEDszd6S7649KyimlCVSNkjrsyiuLMAInh37sIq/s3QsEqzWalCJpiT
         jD/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mLUOzi+75LC+LpoTw1P0vq9GAVyNQdTNfnYIoamCwiI=;
        b=ccUlJOW+mgTPSY2D+xq8Tmc99/W2ViRPgVsRDqes71EJjidC4V4GvSKbYTXfHzUDFX
         z6jzN/WSu5x27Zisid1Mnnaf1qq6nizPgqEH5e0Uf7oQ63I2vvg6Zamoe00HvitMYrUx
         fM/xRC0w+DdCCEnyH1KDzv4C2P48eGy4nPuNvIqBzwpHDtI8UcJ9XavTQfZJ5rv1c2a3
         yfQ8X55YbvZtiSFFIYkaDda8URoIdOENt7fkt31XXfC9AFbhVTCjYS7+2eB4H+67TuzI
         01LFsdqscooEsISflI98li/d87IvuLcLMze5oVtvPKyt2iL4bAPZBNQVk3vHFcYFmwwh
         zx9g==
X-Gm-Message-State: APjAAAVFISbQKKPGz6W1jeBd8qVZPyrYaXx6HDsHMGlX2ip4I0qPGP72
        gRuos9JvJZNe4J1vraramAI8q6UXA90CetWjaJrO5avyNl0=
X-Google-Smtp-Source: APXvYqxFMhwK7xef1nfX+SPPgpYJPVgyTV9DyW2W3NkihozPY3OXoaa7FKpfdzsBUbNMnRqSVv3cxLm2FYXBNlPVvzk=
X-Received: by 2002:adf:94a3:: with SMTP id 32mr3831449wrr.276.1582793039616;
 Thu, 27 Feb 2020 00:43:59 -0800 (PST)
MIME-Version: 1.0
References: <20200226133221.44342a57@table.localdomain>
In-Reply-To: <20200226133221.44342a57@table.localdomain>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Thu, 27 Feb 2020 00:43:47 -0800
Message-ID: <CAKi4VA+8o=3HASrtuFNwts35q09xR_bUAY8Bd8_tc0ebj4DZ=g@mail.gmail.com>
Subject: Re: [PATCH v2] Add kernel-version dependent configuration directory
To:     "Anton V. Boyarshinov" <boyarsh@altlinux.org>
Cc:     linux-modules <linux-modules@vger.kernel.org>, legion@altlinux.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed, Feb 26, 2020 at 5:32 AM Anton V. Boyarshinov
<boyarsh@altlinux.org> wrote:
>
> In some cases it looks reasonable to have kernel-version dependent
> modules configuration: blacklists, options and so on. This commit
> introduces additional configuration directories:
> * /lib/modprobe.d/`uname -r`
> * /etc/modprobe.d/`uname -r`

Thanks for the patch, I really like the idea of supporting this. I
have some suggestions below.

>
> Signed-off-by: Anton V. Boyarshinov <boyarsh@altlinux.org>
> ---
> Changes from v1: ARRAY_SIZE and SYSCONFDIR macros are used
>
>  libkmod/libkmod-config.c |  5 +----
>  libkmod/libkmod.c        | 44 ++++++++++++++++++++++++++++++++++++----
>  man/modprobe.d.xml       |  2 ++
>  3 files changed, 43 insertions(+), 8 deletions(-)
>
> diff --git a/libkmod/libkmod-config.c b/libkmod/libkmod-config.c
> index aaac0a1..5cc348a 100644
> --- a/libkmod/libkmod-config.c
> +++ b/libkmod/libkmod-config.c
> @@ -711,11 +711,8 @@ static bool conf_files_filter_out(struct kmod_ctx *ctx, DIR *d,
>
>         fstatat(dirfd(d), fn, &st, 0);
>
> -       if (S_ISDIR(st.st_mode)) {
> -               ERR(ctx, "Directories inside directories are not supported: "
> -                                                       "%s/%s\n", path, fn);
> +       if (S_ISDIR(st.st_mode))
>                 return true;
> -       }
>
>         return false;
>  }
> diff --git a/libkmod/libkmod.c b/libkmod/libkmod.c
> index 69fe431..b718da0 100644
> --- a/libkmod/libkmod.c
> +++ b/libkmod/libkmod.c
> @@ -225,6 +225,21 @@ static char *get_kernel_release(const char *dirname)
>         return p;
>  }
>
> +static char *get_ver_config_path(const char * dir)
> +{
> +       struct utsname u;
> +       char *ver_conf;
> +       static const char appendix[] = "modprobe.d";
> +
> +       if (uname(&u) < 0)
> +               return NULL;
> +
> +       if (asprintf(&ver_conf, "%s/%s/%s", dir, appendix, u.release) < 0)
> +               return NULL;
> +
> +       return ver_conf;
> +}
> +
>  /**
>   * kmod_new:
>   * @dirname: what to consider as linux module's directory, if NULL
> @@ -251,7 +266,7 @@ KMOD_EXPORT struct kmod_ctx *kmod_new(const char *dirname,
>  {
>         const char *env;
>         struct kmod_ctx *ctx;
> -       int err;
> +       int err, configs_count;
>
>         ctx = calloc(1, sizeof(struct kmod_ctx));
>         if (!ctx)
> @@ -269,9 +284,30 @@ KMOD_EXPORT struct kmod_ctx *kmod_new(const char *dirname,
>         if (env != NULL)
>                 kmod_set_log_priority(ctx, log_priority(env));
>
> -       if (config_paths == NULL)
> -               config_paths = default_config_paths;
> -       err = kmod_config_new(ctx, &ctx->config, config_paths);
> +       if (config_paths == NULL) {
> +               char **tmp_config_paths = malloc(sizeof(default_config_paths) +
> +                               sizeof(char *) * 2);

See documentation above this function. This breaks the case in which
the supplied array is empty,
i.e. a single NULL element.

I wonder if for implementing this it wouldn't be better to leave this
function alone and implement it
in kmod_config_new():

1) we create ctx->kver that points to the end of ctx->dirname. If
dirname is NULL in kmod_new(), then
it's assumed we are actually not running for the current kernel, so we
might leave this logic alone.

2) conf_files_list(): after "opendir(path)" we try a opendirat(d,
ctx->kver...) and just ignore if it doesn't exist.

then we run the rest of the logic as usual.

This should ensure that a) we don't break the API, b) we honor dirname
== NULL meaning "don't treat this ctx as
one for the currently running kernel" and also c) we allow
kernel-version subdirs for a user-provided list.
What do you think?


Lucas De Marchi

> +               if(tmp_config_paths == NULL) {
> +                       ERR(ctx, "could not create versioned config.\n");
> +                       goto fail;
> +               }
> +
> +               memcpy(tmp_config_paths, default_config_paths, sizeof(default_config_paths));
> +
> +               configs_count = ARRAY_SIZE(default_config_paths);
> +               tmp_config_paths[configs_count-1] = get_ver_config_path("/lib");
> +               tmp_config_paths[configs_count] = get_ver_config_path(SYSCONFDIR);
> +               tmp_config_paths[configs_count+1] = NULL;
> +
> +               err = kmod_config_new(ctx, &ctx->config, (const char * const*) tmp_config_paths);
> +
> +               free(tmp_config_paths[configs_count-1]);
> +               free(tmp_config_paths[configs_count]);
> +               free(tmp_config_paths);
> +       }
> +       else
> +               err = kmod_config_new(ctx, &ctx->config, config_paths);
> +
>         if (err < 0) {
>                 ERR(ctx, "could not create config\n");
>                 goto fail;
> diff --git a/man/modprobe.d.xml b/man/modprobe.d.xml
> index 211af84..d1e254a 100644
> --- a/man/modprobe.d.xml
> +++ b/man/modprobe.d.xml
> @@ -41,7 +41,9 @@
>
>    <refsynopsisdiv>
>      <para><filename>/lib/modprobe.d/*.conf</filename></para>
> +    <para><filename>/lib/modprobe.d/`uname -r`/*.conf</filename></para>
>      <para><filename>/etc/modprobe.d/*.conf</filename></para>
> +    <para><filename>/etc/modprobe.d/`uname -r`/*.conf</filename></para>
>      <para><filename>/run/modprobe.d/*.conf</filename></para>
>    </refsynopsisdiv>
>
> --
> 2.21.0
>
>


-- 
Lucas De Marchi
