Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F46CC433B4
	for <linux-modules@archiver.kernel.org>; Fri,  9 Apr 2021 15:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D304610A7
	for <linux-modules@archiver.kernel.org>; Fri,  9 Apr 2021 15:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbhDIPNV (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 9 Apr 2021 11:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbhDIPNV (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 9 Apr 2021 11:13:21 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A635FC061760
        for <linux-modules@vger.kernel.org>; Fri,  9 Apr 2021 08:13:06 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id j18so10276766lfg.5
        for <linux-modules@vger.kernel.org>; Fri, 09 Apr 2021 08:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hhYqTV2XdrvbAdxcIDc02VBPlod/YaBuF62hfUeMCfA=;
        b=S7uRKvZG5s2+MH/ElBZDhnV5yn3dW9ZgAQ0eRcmOJymu0HSTKwqIS2IUSKxtuVSdmt
         IgZY7aRIyZGNH2SWocf0eMZ2ZNmMz9DPmrq1g1cjpBTBoi1rMJLK/qLIzW7BAzIn1Vxy
         D2lzlK56kej42STuHexMSPTn+T6YnR499bb5y3xFTeZ6yxnGWee3aPX6TE4p7G1Hwr3e
         TBylBZvIHPRGkg9oqv5KdlHmuChK+qvB2I7nYoRRsFv6+9UUJNLcAAjr3DaTJ9D6gaLq
         5OBPlLCyvmUIweJRlceIK7+JIc6CY/S8Mg0nHlSdSnnQUmBKHNEqCTAMTCEYjJua2mch
         KxJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hhYqTV2XdrvbAdxcIDc02VBPlod/YaBuF62hfUeMCfA=;
        b=YNWeMo3UdGg5kLh1lmPr7sfq6iOuGuslFocliYlclYgLGLZZNFhWgbDnpEks5fetG+
         9EmYJ2m5J2fXDvMzawFYXfvtNIJw8w2zTljGPyMvN9TdAIsavIbCVSA0UOJ3LNG9MZ+k
         790jLGk2LxTcUuJ10C/VjLgWez/1/QnFrwlhQOL0zDfffdnocwqeEUiTE706OTJAWi6w
         w9SikTQKvv/Ryc9IU5EuQVkl3kemLSBqaSTvbKsoyxqVAyTHZu8aaenCgEcBGM4aoBQz
         inq9cW44CqPQRjsj006AplIWts9wueaI4iNycrhkW3T5tzQ2eK87zmPB5BfDdSgEyeFZ
         viXg==
X-Gm-Message-State: AOAM530iuci1F3mcUj1iQjkzmTxPkUrxIYArojQzZAXn9SWXJmRLlkaH
        w6gD5SNQAY0sg9zENrpobS8R5yVRZAjWOaTsZPg=
X-Google-Smtp-Source: ABdhPJy+QeDFyMcK4RuwbHjECS8XyYoOIcIhArYl3uBccGYuqX3noImK9hfYYSXp6JZQbyiEEgicl6Vpv2iqQaghMBg=
X-Received: by 2002:ac2:5a49:: with SMTP id r9mr10479211lfn.23.1617981185141;
 Fri, 09 Apr 2021 08:13:05 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20210409094133epcas1p2cfb973c9ea1065ffbb018e98f9a60b10@epcas1p2.samsung.com>
 <20210409094423.966-1-sw0312.kim@samsung.com>
In-Reply-To: <20210409094423.966-1-sw0312.kim@samsung.com>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Fri, 9 Apr 2021 08:13:29 -0700
Message-ID: <CAKi4VAL2q0TUcR3ZFjJiwA=7xmBmJ1VcwSkY_HYW16WFmxv5aA@mail.gmail.com>
Subject: Re: [PATCH] libkmod-config: fix a memory leak when kmod_list_append() fails
To:     Seung-Woo Kim <sw0312.kim@samsung.com>
Cc:     linux-modules <linux-modules@vger.kernel.org>,
        sungguk.na@samsung.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Fri, Apr 9, 2021 at 2:41 AM Seung-Woo Kim <sw0312.kim@samsung.com> wrote:
>
> From kmod_config_new(), when kmod_list_append() fails,
> fix not list-appended kmod_config_path leak.
>
> Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>

Applied, thanks
Lucas De Marchi

> ---
>  libkmod/libkmod-config.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/libkmod/libkmod-config.c b/libkmod/libkmod-config.c
> index 4fdd40f86dea..e83621b34157 100644
> --- a/libkmod/libkmod-config.c
> +++ b/libkmod/libkmod-config.c
> @@ -909,8 +909,10 @@ int kmod_config_new(struct kmod_ctx *ctx, struct kmod_config **p_config,
>                 memcpy(cf->path, path, pathlen);
>
>                 tmp = kmod_list_append(path_list, cf);
> -               if (tmp == NULL)
> +               if (tmp == NULL) {
> +                       free(cf);
>                         goto oom;
> +               }
>                 path_list = tmp;
>         }
>
> --
> 2.19.2
>
