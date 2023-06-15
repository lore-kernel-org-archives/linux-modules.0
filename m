Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066F8EB64D9
	for <linux-modules@archiver.kernel.org>; Thu, 15 Jun 2023 09:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343509AbjFOJiN (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 15 Jun 2023 05:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343512AbjFOJhx (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 15 Jun 2023 05:37:53 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3A730FE
        for <linux-modules@vger.kernel.org>; Thu, 15 Jun 2023 02:36:42 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-56896c77434so17374117b3.0
        for <linux-modules@vger.kernel.org>; Thu, 15 Jun 2023 02:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686821801; x=1689413801;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EX2NQ9PLvdiDfuIOKNB9u2VzouUa2IJsIRy4s9EAWJM=;
        b=jDLV1bL4qqIIkPwjdf3GymON4EgupOyDzp0KprAmdmg+dL0TQqB0X0tIzfEZr9IznP
         2Qq0081Frlknxd3whBcm/Ako2mpxZRDZPYS2yC/n93amLXxJyLXMihW24DGSefS8k9Ei
         EMMEIbOoJ5qAP8uLTPoKBU4LzagSDFdqBhUXrhyaZG8gZkTpMTgxT3uJMVvEkpy3bps2
         okvS3Xvgle+YXQgB0gNRFLyMxNDuugu0qViM8Apm596ME83ippk/aUA3MEkSCnxzNw9x
         o5w25w7zrKoQuEImbE1wGV/rSeqCiIALwBoXn00BixTlGfCFKpOOr9iBNg2Z3FJn21zO
         bsrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686821801; x=1689413801;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EX2NQ9PLvdiDfuIOKNB9u2VzouUa2IJsIRy4s9EAWJM=;
        b=GwzMgu7SSgok/rbP5Kd0w8GDdL9uIuPSYnb+d2V8fz3J+BEkBP30cO5TXXHVxu1os6
         M3K5xpsQDBF6I7dUsOW4dvII2eVRZ8MuV2I+teShN6L+H6+mAEoHs+6A8UWUZnMIBRSw
         HC/IlTS46SxQUCjMlGlqdGC14WuZpc5FzJfiUHuluJeMuzjMF8lXG3bQKb5dsazM9jZD
         t+bjLzRYFbzYV4sw11/z35frV52yocJs4pltPC3IA0i4GdENe51Mn8XpY3Engu9N/PPa
         CxyUGgZShVmTuzQr2BW4ulyKwc+VU9CH5pyVS/fqu783OEUF+mslKoE2YikM//sPfKLc
         +Urw==
X-Gm-Message-State: AC+VfDwvUowHwH+vKFa3djIcPOQtJwKUUpEyBnORyKY03XfK8U0XtOZ7
        MguJh1A3o619f/v7dxbGXQybvblIG27gJ5MO+9L4NPJowU8=
X-Google-Smtp-Source: ACHHUZ4AOEIS5TzQccENcpLUsoqfNupcZQpRpMsBoEqL/FI3riXStNfiu7tuUxLdSDsI7PXl1qXpjxJd4g9+c3h4iXk=
X-Received: by 2002:a25:5050:0:b0:bcc:3522:de8f with SMTP id
 e77-20020a255050000000b00bcc3522de8fmr3674061ybb.44.1686821801538; Thu, 15
 Jun 2023 02:36:41 -0700 (PDT)
MIME-Version: 1.0
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Thu, 15 Jun 2023 10:36:31 +0100
Message-ID: <CACvgo53yHOd964PoQkM_oX3LGcr+qCagz64T+sxcP-eAveS85g@mail.gmail.com>
Subject: Re: [PATCH 5/5] libkmod: Use kernel decompression when available
To:     Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc:     linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Greetings Lucas, list,

I've pulled the email off lore.kernel.org manually (haven't played
with lei yet), so chances are the following will be "slightly"
malformed.

Above all - hell yeah, thank you for wiring this neat functionality.

Out of curiosity: have you done any measurements - CPU cycles, memory
or other - how well the kernel decompression performs vs the userspace
one?

That said, I may have spotted a small bug, namely:

> --- a/libkmod/libkmod-module.c
> +++ b/libkmod/libkmod-module.c
> @@ -864,15 +864,24 @@ extern long init_module(const void *mem, unsigned long len, const char *args);
>  static int do_finit_module(struct kmod_module *mod, unsigned int flags,
>     const char *args)
>  {
> + enum kmod_file_compression_type compression, kernel_compression;
>  unsigned int kernel_flags = 0;
>  int err;
>
>  /*
> - * Re-use ENOSYS, returned when there is no such syscall, so the
> - * fallback to init_module applies
> + * When module is not compressed or its compression type matches the
> + * one in use by the kernel, there is no need to read the file
> + * in userspace. Otherwise, re-use ENOSYS to trigger the same fallback
> + * as when finit_module() is not supported.
>  */
> - if (!kmod_file_get_direct(mod->file))
> - return -ENOSYS;
> + compression = kmod_file_get_compression(mod->file);
> + kernel_compression = kmod_get_kernel_compression(mod->ctx);
> + if (!(compression == KMOD_FILE_COMPRESSION_NONE ||
> +       compression == kernel_compression))
> + return ENOSYS;
> +

Old code returns negative -ENOSYS (negative), the new one a positive
ENOSYS. Where the fallback, mentioned in the comment just above,
triggers on the former negative ENOSYS.

Mind you I'm still sipping coffee, so chances are I'm missing something here.

Thanks again and HTH o/
Emil
