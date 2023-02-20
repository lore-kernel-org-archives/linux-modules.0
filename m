Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E1EC636D6
	for <linux-modules@archiver.kernel.org>; Mon, 20 Feb 2023 05:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjBTFBv (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 20 Feb 2023 00:01:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBTFBu (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 20 Feb 2023 00:01:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDB4C657
        for <linux-modules@vger.kernel.org>; Sun, 19 Feb 2023 21:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676869245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Iz5/XJcUnQF/LFQxvol9TqG2b7RW1QrWjYsgCVHX3XQ=;
        b=MaTAwLsTV4fz8yHDggqrNXI3HztrJOYA/JClU/6U0vKGOrOUyvJ5f/IEKRpdEIAZRBoMLu
        8cLZ0C+lSJr9gvhuLzn6agIZPmxP3toVYBKrkkY6Ic9r4ZzIdPQ3imFOAyEXEYuj3BfkSh
        PxiC4nyBzVCUAcSUuN/5QNZBJ6W4JYw=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-66-FpKqfZA-Om2x6fARpLQ9yw-1; Mon, 20 Feb 2023 00:00:42 -0500
X-MC-Unique: FpKqfZA-Om2x6fARpLQ9yw-1
Received: by mail-vk1-f199.google.com with SMTP id 9-20020a0561220b4900b00406400ed454so155866vko.13
        for <linux-modules@vger.kernel.org>; Sun, 19 Feb 2023 21:00:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iz5/XJcUnQF/LFQxvol9TqG2b7RW1QrWjYsgCVHX3XQ=;
        b=Q2h7pEkR448QrpE0Q1xSLkk8UI0prai7h71bG+bbdZiWoQ5TaxymYA7NjLeJqyx1AE
         P5R5RnyzanWQXILn9NTxSPiAfiXxxos0p6PpGT5Sf00ru0MD04MvGrYU/F8ndl+WvT6S
         CWtnuHkIQDUYLuV3JC8rTIJ7xDDG1qXQa6bjQxDFr5Devof4fRkjh9M/j1LJ8wTDyGJ5
         BZuBSZmTy1093r2+zkNhUDlKkl/nnB4/LQgXRfEsG1xh4t8MbX8R2+/MbVHw0A/1N2jr
         jpZ9dGAXgb2giDns8dtePhFx5IFDQ50gNcJEcqvUMC2/D3n5gDwMlQmTGXCWGbptwZzR
         f0Pw==
X-Gm-Message-State: AO0yUKV0zDEPKNLMj3f+peKWSRbpXc3hpCP9wzwZtboM1VDh5IzxYhKC
        mihdGfggw42xwGPV8UWPbno1wxheo3MfbLfPfPd7Wv0U4WRx/MUtfD3OdcG52ONKDOmwI70zxKs
        zdrT3BO9VLTBEUZNq5gBs2CNH8ag6nHURL68epWJFpKac0558nEAw
X-Received: by 2002:a05:6102:f0a:b0:411:bd2e:11ac with SMTP id v10-20020a0561020f0a00b00411bd2e11acmr165954vss.75.1676869241594;
        Sun, 19 Feb 2023 21:00:41 -0800 (PST)
X-Google-Smtp-Source: AK7set9f9ox6vr3CX95NfKEGX65cBproFKTgZSzrIfnLLXYRXGGY0eODN/Gl2kUycvwizSjQfY+ldPdK2BDBA0MyKSw=
X-Received: by 2002:a05:6102:f0a:b0:411:bd2e:11ac with SMTP id
 v10-20020a0561020f0a00b00411bd2e11acmr165950vss.75.1676869241338; Sun, 19 Feb
 2023 21:00:41 -0800 (PST)
MIME-Version: 1.0
References: <20230217141059.392471-1-nick.alcock@oracle.com> <20230217141059.392471-12-nick.alcock@oracle.com>
In-Reply-To: <20230217141059.392471-12-nick.alcock@oracle.com>
From:   Eric Curtin <ecurtin@redhat.com>
Date:   Mon, 20 Feb 2023 05:00:25 +0000
Message-ID: <CAOgh=Fyak7mxqva0qkUtrqBnsBbhMtP+AsHpOz3TNhwp4wPaAQ@mail.gmail.com>
Subject: Re: [PATCH 11/24] kbuild, soc: apple: apple-pmgr-pwrstate: remove
 MODULE_LICENSE in non-modules
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Philipp Zabel <p.zabel@pengutronix.de>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Fri, 17 Feb 2023 at 14:20, Nick Alcock <nick.alcock@oracle.com> wrote:
>
> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> are used to identify modules. As a consequence, uses of the macro
> in non-modules will cause modprobe to misidentify their containing
> object file as a module when it is not (false positives), and modprobe
> might succeed rather than failing with a suitable error message.
>
> So remove it in the files in this commit, none of which can be built as
> modules.
>
> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: linux-modules@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
> Cc: Hector Martin <marcan@marcan.st>
> Cc: Sven Peter <sven@svenpeter.dev>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: asahi@lists.linux.dev
> Cc: linux-arm-kernel@lists.infradead.org
> ---

Reviewed-by: Eric Curtin <ecurtin@redhat.com>

Is mise le meas/Regards,

Eric Curtin

>  drivers/soc/apple/apple-pmgr-pwrstate.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/soc/apple/apple-pmgr-pwrstate.c b/drivers/soc/apple/apple-pmgr-pwrstate.c
> index e1122288409a..2c15474c7b53 100644
> --- a/drivers/soc/apple/apple-pmgr-pwrstate.c
> +++ b/drivers/soc/apple/apple-pmgr-pwrstate.c
> @@ -319,6 +319,5 @@ static struct platform_driver apple_pmgr_ps_driver = {
>
>  MODULE_AUTHOR("Hector Martin <marcan@marcan.st>");
>  MODULE_DESCRIPTION("PMGR power state driver for Apple SoCs");
> -MODULE_LICENSE("GPL v2");
>
>  module_platform_driver(apple_pmgr_ps_driver);
> --
> 2.39.1.268.g9de2f9a303
>
>

