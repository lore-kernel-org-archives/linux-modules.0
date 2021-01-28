Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E57FC433E0
	for <linux-modules@archiver.kernel.org>; Thu, 28 Jan 2021 04:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF1E864D92
	for <linux-modules@archiver.kernel.org>; Thu, 28 Jan 2021 04:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbhA1EIb (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 27 Jan 2021 23:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbhA1EGy (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 27 Jan 2021 23:06:54 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD83C061353
        for <linux-modules@vger.kernel.org>; Wed, 27 Jan 2021 20:05:23 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id b2so5834273lfq.0
        for <linux-modules@vger.kernel.org>; Wed, 27 Jan 2021 20:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YwmCjvTTtj4JWrmphbodI6XBGoqSzxBTcEkYGUebx24=;
        b=p0DJ7vRy/7+ax7jSv5JhGRo+AIEIqNgd7uWQBrnYapWy5eKHsjtbdh4QtF2URt5W1h
         o97a5UOXkIbGOegB67AJIQ+IkYxtwotwrPkfIQtyyBZ4DQu22CVaRLZNB5Iiyushasqd
         L6XrZIBRFpkxezFz8tkmbBmLlmm9j6Bi2xi667zIfsVskDdJoj8gOoyefnHstKVNzZ5s
         odO/c1fA4XkXhxqCS7AaN3gTx6idsM/PaR3sN44UjKZqc2PmwDL45sXZTyBtuLcjbAK+
         DTulfFkgliTnIgHGcMFxxhNCYk33h/cQDjNPZKJislj3gO4VkI+G++emWCJPrYVb7fiO
         xaWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YwmCjvTTtj4JWrmphbodI6XBGoqSzxBTcEkYGUebx24=;
        b=RqSh8BvY+XdRvaHO/MUjABDuh/f+v+VXaWDgml8BzqaCrpwNX0BstSyJuMh0tVr1Vy
         mtY4iHcfHG/YuHYwHaTc7Mzg7I3xfUbsVh60ifkuyqhmTQUUosN37qJJhcLNhqMZYsJ1
         HhgYWfO86nDf5edmItSpzGVOMEBzKQkn7/jbxxeJ0sg/4BSz5mNki+oHfsdMqKXGPkix
         8DWO3J07WEJsJDQxreiOtWGYcouQLVjELZBGQ7HlDoW+EsyyGR94QYKHq60zsEX1gAWh
         Ja0REINexamk9La2ZBROkafj/0ip7Km+Tyc1ljLUYDMDkNZpM8ny/d9PiuNL1rOjmw9s
         W/2A==
X-Gm-Message-State: AOAM530NQhNNubBx1LXqYBrSV0cYSHi4w0oQ9NKtGPbTnTqGsxY4anWm
        lGuCHj1rGzCda5V75AxfnNxdZuK30J6uY/ZXxIvwbCJv/xndGw==
X-Google-Smtp-Source: ABdhPJyF3agRAHqkiqylRJNKiekgnTnDCYe0VVm0SSZdEWlu8zCrwlMQZrMSi1wukftJK9AjOlP50dRt/1kMumM43lE=
X-Received: by 2002:a19:7109:: with SMTP id m9mr6375946lfc.351.1611806721718;
 Wed, 27 Jan 2021 20:05:21 -0800 (PST)
MIME-Version: 1.0
References: <70f1ef6c-d016-de57-82a8-db9d9cc414ef@kernel.org>
In-Reply-To: <70f1ef6c-d016-de57-82a8-db9d9cc414ef@kernel.org>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Wed, 27 Jan 2021 20:05:09 -0800
Message-ID: <CAKi4VALc_8pAuW0UtvzgZbT0nb=uGgSLZV0Xq8z5mw=vSe_exw@mail.gmail.com>
Subject: Re: libkmod mishandles parameters re-quoted by grub2
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Mon, Jan 25, 2021 at 10:06 PM Jiri Slaby <jirislaby@kernel.org> wrote:
>
> Hi,
>
> when one passes to the kernel a module parameter from grub2 such as:
>    parport.dyndbg="file drivers/parport/ieee1284_ops.c +mpf"
> the kernel receives:
>    "parport.dyndbg=file drivers/parport/ieee1284_ops.c +mpf"
> as grub2 handles quotes this way. It may be a bug in grub2, it was even
> tried to be fixed, but there is no all-cases-working fix yet:
>    https://bugzilla.suse.com/show_bug.cgi?id=1181111#c10
>
> The kernel parses the parameter correctly, though:
>    parse_one: doing dyndbg params: parport.dyndbg='file
> drivers/parport/ieee1284_ops.c +mpf'
>
> But libkmod doesn't. When parport is modprobe-d, this parameter is not
> passed to it.

yeah... if kernel parses the parameter correctly, we should accept it too.

>
> kmod_config_parse_kcmdline ignores the parameter as:
>    if (is_quoted) {
>      /* don't consider a module until closing quotes */
>
> I am not sure how to fix this, can someone look into it and make the
> parser similar to kernel's?

I will take a look soon.

thanks
Lucas De Marchi

>
> thanks,
> --
> js
> suse labs
