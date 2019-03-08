Return-Path: <SRS0=VdMu=RL=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E021C43381
	for <linux-modules@archiver.kernel.org>; Fri,  8 Mar 2019 17:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CA9D20851
	for <linux-modules@archiver.kernel.org>; Fri,  8 Mar 2019 17:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jW/oCrYK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbfCHRQY (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 8 Mar 2019 12:16:24 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53683 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfCHRQY (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 8 Mar 2019 12:16:24 -0500
Received: by mail-wm1-f66.google.com with SMTP id e74so13222879wmg.3
        for <linux-modules@vger.kernel.org>; Fri, 08 Mar 2019 09:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A7/g/ODyQfrGbIXED11b7KXbAqt6F+r+XUwFjLJMU2s=;
        b=jW/oCrYKmYfcXwvJFJWmwfmZXgWtjgDYukZF/J8nnPmaRZ7VkOvIEjc70h6D4F782p
         Zm6LccxeT+8V+teuGXZhE50b7QN6gUQA4dt7p5A9NdUaQkBEfYBFAD15gowsOGod+YrA
         7z6KwpDJCJAYTo/8kTu9mRkwcxb1o9NcsF4OZ1kFg27XSyFnthQal+movm1Bkdy5nnhC
         fY+4venQWQPJ6nKTP9sjvbRgOiaoLEQ4evqPu1Ywp37fyFRmyTsMW+LDOynynQfE2m/2
         vYBUdMrLoROwOjdLV1yxVRpb9dSUiQkZTCcEuowV7IMsoivKZQ3ftbwZbf9x87wQOd/1
         Earg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A7/g/ODyQfrGbIXED11b7KXbAqt6F+r+XUwFjLJMU2s=;
        b=AU+MpWqcXlxkISlk64Qfv+cZPo+eCTBJ8pGMZHtDlimNX6qvDYUWpM9+qVHKAqKnQQ
         CSO4kRk4OQLZTbnEXmi3Vk2/8Nk3hToH3t3COpWPM3eWoRaRtBFfAd5unRp0q6So9AsP
         TDxdPH4qylAhzofHOy89mNNBlItYhNtDgoEo4YRMMasst1ACxEacZdieLh5FIpmUuPx4
         LVddpJzIREQ+0iDnv6IiJ0PnQBrJjRdNDaD/wn03YyU3brBRgJA4SJmqxap92yZqo7Mn
         JMPy46TCTugU1lL5R2qwSlL6qOO65fOUA+gcm144EM7pnwwSKq3ArOpAVRgTR6JGESmN
         DY+g==
X-Gm-Message-State: APjAAAXmi2sAPmw2d5GzwyazmGwbX6NaOMnCy1vzH61LysW+K6dcd2mT
        Ef7tavN8Cx8IcbPrxfOBfRz7YyVIhvhenkWtRmuYTQ==
X-Google-Smtp-Source: APXvYqxc5lUX7QOaUXuadLkJqL1lDWZ0Eqhcs6PWwRnz8H3EotBD96u0A8HVId7OGKn2DAfc9wr/dSHDmHvabRRvxP8=
X-Received: by 2002:a1c:4408:: with SMTP id r8mr9867858wma.149.1552065382736;
 Fri, 08 Mar 2019 09:16:22 -0800 (PST)
MIME-Version: 1.0
References: <20190307202606.1488-1-heirecka@exherbo.org>
In-Reply-To: <20190307202606.1488-1-heirecka@exherbo.org>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Fri, 8 Mar 2019 09:16:11 -0800
Message-ID: <CAKi4VAJPxDftDwF0=Aj3XYPUeuHPs=M7hKZBMJ8gWRDYw9fkog@mail.gmail.com>
Subject: Re: [PATCH] Only use _FILE_OFFSET_BITS with __GLIBC__
To:     Heiko Becker <heirecka@exherbo.org>
Cc:     linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, Mar 7, 2019 at 12:32 PM Heiko Becker <heirecka@exherbo.org> wrote:
>
> It's a glibc specific macro. With the musl libc {,l}stat64 are just

Is it really glibc-specific? Just grepping uClibc for example returns
the macro there - this would probably break this libc. Do we have a
macro like this to test for musl? Another options would be to check if
these "functions" are implemented like macros and avoid the wrappers
in this case.

Lucas De Marchi

> a macro defined for compatibility and off_t is always 64bit. The
> former's expansion causes a build error though:
> "...testsuite/path.c:191:21: error: redefinition of 'stat'".
> ---
>  testsuite/path.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/testsuite/path.c b/testsuite/path.c
> index fa5fceb..74db898 100644
> --- a/testsuite/path.c
> +++ b/testsuite/path.c
> @@ -187,7 +187,7 @@ WRAP_2ARGS(int, -1, mkdir, mode_t);
>  WRAP_2ARGS(int, -1, access, int);
>  WRAP_2ARGS(int, -1, stat, struct stat*);
>  WRAP_2ARGS(int, -1, lstat, struct stat*);
> -#ifndef _FILE_OFFSET_BITS
> +#if defined(__GLIBC__) && !defined(_FILE_OFFSET_BITS)
>  WRAP_2ARGS(int, -1, stat64, struct stat64*);
>  WRAP_2ARGS(int, -1, lstat64, struct stat64*);
>  WRAP_OPEN(64);
> @@ -198,7 +198,7 @@ WRAP_OPEN();
>  #ifdef HAVE___XSTAT
>  WRAP_VERSTAT(__x,);
>  WRAP_VERSTAT(__lx,);
> -#ifndef _FILE_OFFSET_BITS
> +#if defined(__GLIBC__) && !defined(_FILE_OFFSET_BITS)
>  WRAP_VERSTAT(__x,64);
>  WRAP_VERSTAT(__lx,64);
>  #endif
> --
> 2.21.0
>


-- 
Lucas De Marchi
