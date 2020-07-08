Return-Path: <SRS0=Cmtv=AT=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBAC9C433E0
	for <linux-modules@archiver.kernel.org>; Wed,  8 Jul 2020 18:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C149520760
	for <linux-modules@archiver.kernel.org>; Wed,  8 Jul 2020 18:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgJii4Wx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgGHSQZ (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 8 Jul 2020 14:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgGHSQS (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 8 Jul 2020 14:16:18 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162CCC061A0B
        for <linux-modules@vger.kernel.org>; Wed,  8 Jul 2020 11:16:18 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id q15so4236045wmj.2
        for <linux-modules@vger.kernel.org>; Wed, 08 Jul 2020 11:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HtlZdASO3n4rHB6ThxIs8yKoPqbZH1OwqGHnBVEgNqY=;
        b=mgJii4WxBITR1YuYPeb0fKbhnE6X3jGg5pRP6daoThN908JbUBSXQYj6dSRzlCGtm+
         NKHOxdPyp7LlYvsZqxIsinzattZj+0SMHquJ+dxFxx9n+9cOaxmRFllSyENlqaZLczop
         dT5FA/yUFBEMoN91XMuW92iKKsF1e+Duxk9+0jzp0FQa/4cWwYsa3JFKPb723KEYX1nZ
         Imn9g5IIrZKscYoQOQfSByeGac4vu8Gbx0GBVRfaIHP+OsQ/KEvNDzSKaA/pWpkddrY2
         4WVFVkPLd8d/IZRoLERTJGujo7RdpnGQoYMLzOY+V+Gqhw2cJPDvDtElDGRUkpfqOz9s
         JEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HtlZdASO3n4rHB6ThxIs8yKoPqbZH1OwqGHnBVEgNqY=;
        b=PNV5QIIB8NeRu2N0a3h6HfT/UY0kTq+pAdxjsPINBw6HtKvxf3fgQEr865VrHg7Rus
         wfOUWMxaU7nDlfqelaME2WcXP4oYESOWluVU6k5iAaQRcUeP8txlcGk6YPPRo583f1ha
         3MZe2WfRKlDPM3ZCiZU+e6bHT+cd8ovHcw8Cb1IqsgQL61/lf9dC4TRCLkEXxZ5iRJIk
         XdMUq8E+bm3vD55fmPCxfJEA9+GYrVI4QDRQ1WwgzBnkuJcdXAQVs2aHIxqnBsN9oeBB
         c434qqfdvbvFdpd48h5LekphkPCsESz3SPE008XiA3xxCnDbtn6LFZN1HDBC0gJJgq+V
         NXHw==
X-Gm-Message-State: AOAM532qLZuYnGZYRQAKgI48Kyo60dhPgmEtlrqSH4vNjriy/N/VLoUf
        hRMTAdbvzcQi9WiTuNVMRkjUf8hAcqOAQZ9mkRZRKA==
X-Google-Smtp-Source: ABdhPJwwRoKB+HUXQcJ9NBrk8/qwANS+Y38UIDhPOSQvoc5BLkuhXwyMi0ioloa0PSyHE/Nwp9YHZAdmF3GRjw8N9Xw=
X-Received: by 2002:a7b:c38c:: with SMTP id s12mr10426881wmj.136.1594232176796;
 Wed, 08 Jul 2020 11:16:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200516125412.12366-1-marius@devup.no>
In-Reply-To: <20200516125412.12366-1-marius@devup.no>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Wed, 8 Jul 2020 11:16:05 -0700
Message-ID: <CAKi4VALpxWdmFfvSxKd9apSWisrKK3zK7pO-QaPiW_c=bby4bg@mail.gmail.com>
Subject: Re: [PATCH] testsuite: Add facility to skip tests.
To:     Marius Bakke <marius@devup.no>
Cc:     linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Sat, May 16, 2020 at 6:04 AM Marius Bakke <marius@devup.no> wrote:
>
> The Makefile helpfully warns that some tests will fail when
> --sysconfdir != /etc, but there are no provisions to easily disable
> those.  This commit provides an escape hatch.

nice... but are we missing a patch to actually make it skip?

> ---
>  testsuite/testsuite.c | 9 +++++++++
>  testsuite/testsuite.h | 1 +
>  2 files changed, 10 insertions(+)
>
> diff --git a/testsuite/testsuite.c b/testsuite/testsuite.c
> index e46f3d8..ff41057 100644
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
> +       if (t->skip == true) {

only if (t->skip)  would be less verbose and preferred I think.

thanks
Lucas de Marchi

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
> 2.26.2
>


-- 
Lucas De Marchi
