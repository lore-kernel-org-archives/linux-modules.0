Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5815C433E0
	for <linux-modules@archiver.kernel.org>; Mon, 15 Feb 2021 20:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA1C864DEC
	for <linux-modules@archiver.kernel.org>; Mon, 15 Feb 2021 20:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbhBOUTJ (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 15 Feb 2021 15:19:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhBOUTJ (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 15 Feb 2021 15:19:09 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88113C061574
        for <linux-modules@vger.kernel.org>; Mon, 15 Feb 2021 12:18:28 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id d24so12423753lfs.8
        for <linux-modules@vger.kernel.org>; Mon, 15 Feb 2021 12:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pdr1HPWpy8JOKl3qbAnJt2/D9vE+5h44lr9/UJfqrxI=;
        b=pqd0LYgZBt28+ccEWHrX86yJA6LpAHxYottaVmWcwzmJIqfDwaPg9Ybh3KstOO0aRc
         f8ggdswOBz3KSqrwwunutT0ZdFvwtjYbdL6VaAc5wAhYrJrDIjpLitkTnO1vty0Jazq+
         NgBfAiFuTSNfsmMA3MrHXaHRYZe4rY5dgK95aNytXId7P+EsUB8brMuK2bD7FGZYLnpE
         qDll+2AYQ/Lopqykkv0NbW4kcgKuaaEgaxv0CdiVXeabsQmxTIPQB5gpCT1vwDJIPKBe
         MJenXowYTDYX/iyb7sgeHjfIsEXuGj0HdPkPkGwQoNgJ/6zIgDrENMYZIGlKlQShdlyN
         gc2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pdr1HPWpy8JOKl3qbAnJt2/D9vE+5h44lr9/UJfqrxI=;
        b=ThYTh//tVYMG+19z2NeZTFsDlp5+oge7fY57CAnNwPnybdWNcLoWgoNJu/bfap7FPD
         /TVVlZXmhhy32HhayjUkmJbFk09bdRGbCStAJ9kPwOvxm9Ejvz5jhzkDts0unLi4nVJk
         SQ1hA8S8jtty/OGdIoXsFzUN9YmpmE8sibCrgewzUN6LlHhMVeEnTFSrYgyrSOeYH6oY
         UTtfkbDRtig40u3YFuMK/V9wbpLStpTw9XzX/75y1QzTN2FEHLm8/DWAQL11lZ9fGB37
         eBr36HGF2m0VXIYhdXkTbqf4IPSn0MwWMbLEkc/QTu3Wk9/gncMI2NJhUSKQ6ULPNI30
         rqtQ==
X-Gm-Message-State: AOAM533u3wjTvSNp8rfmKVxCna/PQBjnbzKWe3fLg1RMzJq4PMyLlR0J
        +jUZm8fdpVuzBDDYndUWQmkfAgoKqisN/uZvpOY=
X-Google-Smtp-Source: ABdhPJzHwQbEgub4E4E3XxUpmAQYMkmqbVFNJssfw8X7CTa+Gv9nvuvOW4Ez9Q8IEmVpxpndfWGfz06g5mfrhWgbxsg=
X-Received: by 2002:a19:6447:: with SMTP id b7mr9522855lfj.206.1613420307050;
 Mon, 15 Feb 2021 12:18:27 -0800 (PST)
MIME-Version: 1.0
References: <20210212094524.170861-1-lucas.demarchi@intel.com>
 <20210212094524.170861-2-lucas.demarchi@intel.com> <YCqTOzfcWkbguKDO@gunter>
In-Reply-To: <YCqTOzfcWkbguKDO@gunter>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Mon, 15 Feb 2021 12:18:15 -0800
Message-ID: <CAKi4VALw-mOh6e0agvQyjfV4Whh1s9POZ7iX8RQUZSV2m=NxuA@mail.gmail.com>
Subject: Re: [PATCH 2/4] libkmod-config: re-quote option from kernel cmdline
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>,
        linux-modules <linux-modules@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Mon, Feb 15, 2021 at 7:33 AM Jessica Yu <jeyu@kernel.org> wrote:
>
> +++ Lucas De Marchi [12/02/21 01:45 -0800]:
> >It was reported that grub mangles the kernel cmdline. It turns
> >
> >       acpi_cpufreq.dyndbg="file drivers/cpufreq/acpi-cpufreq.c +mpf"
> >
> >       into
> >
> >       "acpi_cpufreq.dyndbg=file drivers/cpufreq/acpi-cpufreq.c +mpf"
> >
> >However, even though we could blame grub for doing that, the kernel
> >happily accepts and re-quotes it when the module is built-in.
> >So, it's better if kmod also understands it this way and does the same.
> >
> >Here we basically add additional code to un-mangle it, moving the quote
> >in way that is acceptable to pass through init_module(). Note that the
> >interface [f]init_module() gives us mandates the quote to be part of the
> >value: the module name is not passed and the options are separated by
> >space.
> >
> >Reported-by: Jiri Slaby <jirislaby@kernel.org>
> >Link: https://bugzilla.suse.com/show_bug.cgi?id=1181111#c10
>
> Hi Lucas,
>
> Thanks a lot for working on this. I applied this patchset on top of
> kmod master and after some light testing it appears to be able to
> handle the mangled quoting from grub now:
>
>      Tested-by: Jessica Yu <jeyu@kernel.org>


thanks!

Applied
Lucas De Marchi
