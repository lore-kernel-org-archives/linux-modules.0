Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97497C433E0
	for <linux-modules@archiver.kernel.org>; Fri,  8 Jan 2021 03:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BC9C236F9
	for <linux-modules@archiver.kernel.org>; Fri,  8 Jan 2021 03:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbhAHDse (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 7 Jan 2021 22:48:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbhAHDsd (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 7 Jan 2021 22:48:33 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68634C0612F4
        for <linux-modules@vger.kernel.org>; Thu,  7 Jan 2021 19:47:47 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id m12so19801515lfo.7
        for <linux-modules@vger.kernel.org>; Thu, 07 Jan 2021 19:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4jo9BwhsD7kpr5t5FgReI/knwJN37Y8RZ/RcX1GUslo=;
        b=gxjaRy4N5quK0NRFXYbTZqUFHtZKrs5TDlom3Ww1vp5HCWSlSR/gNXWNMHPV8vhlH3
         zuAYc4m/OrkXb93C/MXPoRS7rNug3p5jjUf4EZArLt6mJYD0BzA9FeHQEOGko/6LVF6u
         ty9qQWVA9NgeRQ8jtjKDcvMG61Tpc9aiSjog1C1uvDSrms2Al3btnsCaa9SA5jY/XptB
         T1x0eb11yihHBNXUbwiLBmETbGNkDpr5AaaEbaU1KoIDOkX+pptwfsg8xvFhT9sdcFm+
         3FXFHIVslMBhAIVAmKsRu3xqQY8j3u6uUvm0e8ZffqkhF4hPLF1sq/XBoKqCtzkQVvNT
         Vi+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4jo9BwhsD7kpr5t5FgReI/knwJN37Y8RZ/RcX1GUslo=;
        b=ByNbYi4IoU9+tEl//QHxm+GWGrW0LiBSJ7378fDtgUi3BuQp4Dat9EQCMx4hbJaURX
         cEnIlPkvTBjNO+9ZOIzwG5mz8Jjh8CzBSyREiAgJqfSN5FXW+U4RMCk8CLfVctj9b+h4
         4DGsshTGn9U2bmxg+vH4sGeiT9vkgzSYA0XlahYtSdLCGWFvk952UozHfM53D/XbgQ/z
         keXY0RVwiIuHkZmPTSkGO7qy1fz0A6xM6NkYgar9lyR/WjTMhopdpAhkDR8KaSiHiyw0
         cEm7DhSuXcA1tl3/UguQqkergmaQRnKZRt3sLkfGP7vtyeYVdWYxgXOa+befRz3LHXHr
         Idfg==
X-Gm-Message-State: AOAM531a+bXsLx92krpMS0TgXVC6PdK+RhB9KIf7v+LxoqX3BN9bhTq/
        mKs1pxr691u3Qz82ub0d56MaKN8deM4iXsHzjks/RkAFa4znSA==
X-Google-Smtp-Source: ABdhPJz5OZRKT+XQidKUNTVjaIbp6qPhsktW6fdjABGLMVrqQ/6GQy6wjueeStB8W4mpE9HXJlYE2MdQi9oDP0K48vk=
X-Received: by 2002:a19:7109:: with SMTP id m9mr755133lfc.351.1610077665913;
 Thu, 07 Jan 2021 19:47:45 -0800 (PST)
MIME-Version: 1.0
References: <87k0yipdd7.fsf@gnu.org> <20200801160222.7464-1-marius@devup.no>
In-Reply-To: <20200801160222.7464-1-marius@devup.no>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Thu, 7 Jan 2021 19:47:33 -0800
Message-ID: <CAKi4VALQoi7g3dkVo=4NZr3cioeh0Cy2K_W0VZHxsJQK99DkLw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] testsuite: Add facility to skip tests.
To:     Marius Bakke <marius@devup.no>
Cc:     linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Sorry for the delay. This is now applied.

Lucas De Marchi

On Sat, Aug 1, 2020 at 9:02 AM Marius Bakke <marius@devup.no> wrote:
>
> The Makefile helpfully warns that some tests will fail when
> --sysconfdir != /etc, but there are no provisions to easily disable
> those.  This commit provides an escape hatch.
> ---
>  testsuite/testsuite.c | 9 +++++++++
>  testsuite/testsuite.h | 1 +
>  2 files changed, 10 insertions(+)
>
> diff --git a/testsuite/testsuite.c b/testsuite/testsuite.c
> index e46f3d8..05df553 100644
> --- a/testsuite/testsuite.c
> +++ b/testsuite/testsuite.c
> @@ -37,6 +37,7 @@
>  #include "testsuite.h"
>
>  static const char *ANSI_HIGHLIGHT_GREEN_ON = "\x1B[1;32m";
> +static const char *ANSI_HIGHLIGHT_YELLOW_ON = "\x1B[1;33m";
>  static const char *ANSI_HIGHLIGHT_RED_ON =  "\x1B[1;31m";
>  static const char *ANSI_HIGHLIGHT_OFF = "\x1B[0m";
>
> @@ -948,6 +949,14 @@ static inline int test_run_parent(const struct test *t, int fdout[2],
>         int err;
>         bool matchout, match_modules;
>
> +       if (t->skip) {
> +               LOG("%sSKIPPED%s: %s\n",
> +                       ANSI_HIGHLIGHT_YELLOW_ON, ANSI_HIGHLIGHT_OFF,
> +                       t->name);
> +               err = EXIT_SUCCESS;
> +               goto exit;
> +       }
> +
>         /* Close write-fds */
>         if (t->output.out != NULL)
>                 close(fdout[1]);
> diff --git a/testsuite/testsuite.h b/testsuite/testsuite.h
> index 7ed96bf..8029c64 100644
> --- a/testsuite/testsuite.h
> +++ b/testsuite/testsuite.h
> @@ -109,6 +109,7 @@ struct test {
>         const struct keyval *env_vars;
>         bool need_spawn;
>         bool expected_fail;
> +       bool skip;
>         bool print_outputs;
>  } __attribute__((aligned(8)));
>
> --
> 2.28.0
>
