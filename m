Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4223BC64E7B
	for <linux-modules@archiver.kernel.org>; Tue,  1 Dec 2020 10:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C281B206E3
	for <linux-modules@archiver.kernel.org>; Tue,  1 Dec 2020 10:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pwHWR9+f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbgLAKHo (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 1 Dec 2020 05:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgLAKHo (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 1 Dec 2020 05:07:44 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A10FC0613D3
        for <linux-modules@vger.kernel.org>; Tue,  1 Dec 2020 02:07:04 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id l11so3063658lfg.0
        for <linux-modules@vger.kernel.org>; Tue, 01 Dec 2020 02:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HNTA/5B8lrtDr22NnR1NqqHk2IAnRyM75zqGk1aAs7o=;
        b=pwHWR9+f3VoVUgtuxK0+XA745nJSa+EdxzmDjG1Zj94EZp7+D4GcIckc97H9dTWXVV
         zV9vUUmbRIpWktDmyIUl8+F+jkzRlFECLSHVnhxOEmO292fJkzlkW5gRxtVIARCaLHnc
         xpefomGTsa3B2BcThZ7s3bGBA5bQQZFtKaaRbpZPPRhFfkgKlkFa1K6Wt87eSQqGU/Rh
         /bs3cD54z2bicut9TDjYbg6QeQ2R2CmymKuhLhhy01R4thXo4o8yTTe+Fagnr26YMQpX
         cEEoMQOWI0R5eu2syJehy5Gcv9+a9I7uYLiwZGZhvgBo8KDhzLL8yqUTU3KWN7myyBRh
         NTjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HNTA/5B8lrtDr22NnR1NqqHk2IAnRyM75zqGk1aAs7o=;
        b=o7PIUx8No4rgjSPIq7UEOlZNHCETa2FjKuecP5er73Iy3xA7WlnArtlRT56vaR04Cf
         ZzBGINPlrNKSd97f7OajPmcp8fbLumz0uRaBncl2cLMdT+VwyUYObTgDyvhBPDkaB99v
         52yNvuWQ+Bz72/Hq7ovXZEllNzkW55m9F9xV38kU5GAtz6yDSvJOU8ytya05wXz5RbxT
         lPserJGhQRtP71049983llJM1wovhLndSqYJqSOp0lZlTJlzQSmg38va+vjsBQS2b3hK
         OxOdf+2C2O/X+ez1CuaEDhqKcvCaIoia0nsl+kNiyISEFj7UDE3ABRKldmp4PCjKfTOL
         eWag==
X-Gm-Message-State: AOAM532Vi1mhayW5Jaa91MZwd1izFU17UFbAvkGUAEfwpL0R35F8Kg0g
        NZhVYci3piz+duKHgxlOI2MzjmLGX1hwLQVZ9el4xfRC
X-Google-Smtp-Source: ABdhPJzah5F1OmF8mwkLn8kewenbSUnBVM4mmn+dL0pXeivk6uE4oyop9L4YWUCDN195oxqkv82xiDBL9g7zcGq9G74=
X-Received: by 2002:a19:154:: with SMTP id 81mr874265lfb.161.1606817222623;
 Tue, 01 Dec 2020 02:07:02 -0800 (PST)
MIME-Version: 1.0
References: <20201129164737.135866-1-yauheni.kaliuta@redhat.com>
In-Reply-To: <20201129164737.135866-1-yauheni.kaliuta@redhat.com>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Tue, 1 Dec 2020 02:06:50 -0800
Message-ID: <CAKi4VA+kaWfLZ_Ue-teaJAvDQjfM6G-WK3KmMWVinR-Zg6T64A@mail.gmail.com>
Subject: Re: [PATCH 1/3] libkmod: kmod_builtin_get_modinfo: free modinfo on error
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Thanks, those 3 fixes were applied.

Lucas De Marchi

On Sun, Nov 29, 2020 at 8:47 AM Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
>
> The function allocates array but on building it if get_string()
> fails it returns the error leaving the array allocated. The caller
> does not care about it in error case either.
>
> Free it to fix memory leak.
>
> Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> ---
>  libkmod/libkmod-builtin.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/libkmod/libkmod-builtin.c b/libkmod/libkmod-builtin.c
> index aaec5ddb0609..fc9a37644261 100644
> --- a/libkmod/libkmod-builtin.c
> +++ b/libkmod/libkmod-builtin.c
> @@ -314,6 +314,7 @@ ssize_t kmod_builtin_get_modinfo(struct kmod_ctx *ctx, const char *modname,
>                 offset = get_string(iter, pos, &line, &linesz);
>                 if (offset <= 0) {
>                         count = (offset) ? -errno : -EOF;
> +                       free(*modinfo);
>                         goto fail;
>                 }
>
> --
> 2.29.2
>
