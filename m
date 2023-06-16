Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB60EB64D7
	for <linux-modules@archiver.kernel.org>; Fri, 16 Jun 2023 05:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjFPFMZ (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 16 Jun 2023 01:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjFPFMZ (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 16 Jun 2023 01:12:25 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F017C26B3
        for <linux-modules@vger.kernel.org>; Thu, 15 Jun 2023 22:12:23 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-514ab6cb529so3029476a12.1
        for <linux-modules@vger.kernel.org>; Thu, 15 Jun 2023 22:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686892342; x=1689484342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wOrrcCFvwQH8qhEF8IbHbhb4jspxXrIicKYgnKHzUfE=;
        b=peQ90CnPCSeGA/C+IXAyjTpXfPg8EC77rvCTE84hXVWIiHuEJBHpd4Z7wY+0LJ1LCg
         Kwx74NKcozI+L9EHd0/b71Pb9mH9gV2nRfCQgwIKsFyV8jYGzntBvdhWecYVY/GqYajE
         bfTKiPZZ2eSIisw0mWoG7rLWmuTerD8QQaS+RZu3I4L7Send1JwDepXUIRqlLzjqQflB
         6N2Q/eTvaCAvcIWkPu7+GT8RYE3+yorFoeHbuvN0pKiZ1zzopP/99jwP94NltGK/hS7W
         2I+woiiD0gcnTD+jnRlTNfTvv5n6sihVVLsCSp9IFI7Ap9nExJmBGmKhLi+NnAE/4ZOe
         efcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686892342; x=1689484342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wOrrcCFvwQH8qhEF8IbHbhb4jspxXrIicKYgnKHzUfE=;
        b=WYpYQsx88d105cn5PJk+qI057qKKHIRg5+x/bC7IsztwlD55TN9/hgyYrGH8tOMvWC
         4LdzGD7ryruy1V7iRrDAWnMAcRNZwcpJnFLHl6SN8Haap4/j7FMr809HbFy2/kWhFfi/
         TP3S+/chxdpMym/B2oPMV8idAADyKKcR8+PtSXUMyYH3Xy8XTCjmuDRVx3+H5BZBpQvh
         lURHGF3aK0du1saQipH9aWWlwRMsOdOA76UWQ/WcFZfuqqb+a2qM3eGun1E5HEwRc7jA
         QBo0HmWWuG7sGOQEbcR48Xqq4bZvdba0o6hB0BxRf8TfIea67NVdogjRgGn48nq47YWr
         d6ww==
X-Gm-Message-State: AC+VfDx1sA8Tw4QGNo/2DpFb1vIabbHcJw8Vv655wiXKMUMHD2NgBIfv
        czGwtHqitL6aoXiGmW+TybY=
X-Google-Smtp-Source: ACHHUZ5CV/gBbz8VCvVQhDHhcbOYvOhPqUN+4e33/sUx+NvOGi1P4c2tBtiVY1YhLpfi3rEI5zVOQg==
X-Received: by 2002:a17:906:5d12:b0:982:7e17:6ea2 with SMTP id g18-20020a1709065d1200b009827e176ea2mr589509ejt.6.1686892342231;
        Thu, 15 Jun 2023 22:12:22 -0700 (PDT)
Received: from ldmartin-desk2.lan ([134.134.137.82])
        by smtp.gmail.com with ESMTPSA id fi5-20020a170906da0500b00965d294e633sm10281604ejb.58.2023.06.15.22.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 22:12:21 -0700 (PDT)
Date:   Thu, 15 Jun 2023 22:12:15 -0700
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
To:     Emil Velikov <emil.l.velikov@gmail.com>
Cc:     linux-modules@vger.kernel.org
Subject: Re: [PATCH 5/5] libkmod: Use kernel decompression when available
Message-ID: <fdftww4ijeh5tngo6koko3syzk7ubtb3n5ixdadfc3lutjqrom@r7cjuzf3qm64>
References: <CACvgo53yHOd964PoQkM_oX3LGcr+qCagz64T+sxcP-eAveS85g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CACvgo53yHOd964PoQkM_oX3LGcr+qCagz64T+sxcP-eAveS85g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, Jun 15, 2023 at 10:36:31AM +0100, Emil Velikov wrote:
>Greetings Lucas, list,
>
>I've pulled the email off lore.kernel.org manually (haven't played
>with lei yet), so chances are the following will be "slightly"
>malformed.

One easy easy if you want to pick single patch series is to use b4

b4 mbox 20230601224001.23397-1-lucas.de.marchi@gmail.com
neomut -f ./20230601224001.23397-1-lucas.de.marchi@gmail.com.mbx

or instead of neomutt, import the mbox to your favorite email client.

>
>Above all - hell yeah, thank you for wiring this neat functionality.
>
>Out of curiosity: have you done any measurements - CPU cycles, memory
>or other - how well the kernel decompression performs vs the userspace
>one?

no, I didn't.  I think one important aspect is when paired with the
patch to the kernel that deduplicates the module loading. With
compressed modules, that would be irrelevant as libkmod would go the
init_module() path rather than finit_module().

A reasonable test would be to create a VM with a bunch of CPUs (so we
get many parallel requests or the same modules) and then measure
a) 6.4-rcX
b) 6.4-rcX + that kernel patch
c) 6.4-rcX + that kernel patch + this patch series


>
>That said, I may have spotted a small bug, namely:
>
>> --- a/libkmod/libkmod-module.c
>> +++ b/libkmod/libkmod-module.c
>> @@ -864,15 +864,24 @@ extern long init_module(const void *mem, unsigned long len, const char *args);
>>  static int do_finit_module(struct kmod_module *mod, unsigned int flags,
>>     const char *args)
>>  {
>> + enum kmod_file_compression_type compression, kernel_compression;
>>  unsigned int kernel_flags = 0;
>>  int err;
>>
>>  /*
>> - * Re-use ENOSYS, returned when there is no such syscall, so the
>> - * fallback to init_module applies
>> + * When module is not compressed or its compression type matches the
>> + * one in use by the kernel, there is no need to read the file
>> + * in userspace. Otherwise, re-use ENOSYS to trigger the same fallback
>> + * as when finit_module() is not supported.
>>  */
>> - if (!kmod_file_get_direct(mod->file))
>> - return -ENOSYS;
>> + compression = kmod_file_get_compression(mod->file);
>> + kernel_compression = kmod_get_kernel_compression(mod->ctx);
>> + if (!(compression == KMOD_FILE_COMPRESSION_NONE ||
>> +       compression == kernel_compression))
>> + return ENOSYS;
>> +
>
>Old code returns negative -ENOSYS (negative), the new one a positive
>ENOSYS. Where the fallback, mentioned in the comment just above,
>triggers on the former negative ENOSYS.
>
>Mind you I'm still sipping coffee, so chances are I'm missing something here.

no, apparently I didn't have enough coffee when I wrote this.
I'll fix this up on next version.

thanks
Lucas De Marchi

>
>Thanks again and HTH o/
>Emil
