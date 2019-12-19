Return-Path: <SRS0=K4hl=2J=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B302C43603
	for <linux-modules@archiver.kernel.org>; Thu, 19 Dec 2019 19:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C12C24679
	for <linux-modules@archiver.kernel.org>; Thu, 19 Dec 2019 19:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D86cErbe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfLSTtJ (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 19 Dec 2019 14:49:09 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:35674 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbfLSTtJ (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 19 Dec 2019 14:49:09 -0500
Received: by mail-io1-f65.google.com with SMTP id v18so7029035iol.2
        for <linux-modules@vger.kernel.org>; Thu, 19 Dec 2019 11:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GaZVb0CWb5w611krK6EUuglsM+ivwaut5Gr7wwoUB6w=;
        b=D86cErbepYyqSTNgwDREDzOh49dubYTimbgFYSHHen2rH3u3oLH8KhLXPByyPJxdfT
         wqorcEXP8R/qU6IlhE7jY9WQSwSSB6z45sd2YlFIEI5Mra/O6IiW1KO32DANwFsewCDM
         2JDF2OWXq5fqzMqfo0Si0lmQWIdXxexRWUhKxuHV7vmIESeQRyaMV80vuarzCLq0G+yr
         6i54XnY8GerKbmf1ZW7JrB4cqbfjxQ1BH3u5M1UKiXOyx8qdeh8k2Ea0qvYMUqVRtd1E
         ivQq9bfbhHcLMNYLeMC5BG0FJqypMiYTc1vAZoXzxvvog5WuBJTvXWIC9xmLwa8nIDgU
         v4jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GaZVb0CWb5w611krK6EUuglsM+ivwaut5Gr7wwoUB6w=;
        b=dXZpdZSflM2ZLaB3PdBuJZsLz87jZ+Q5ISeVcB1mGnPwIUExty8qKohe3ANb9MzLuv
         HLDr/8Y/tCsfV5VdSQOttM4QGExCpu95U4BrPrTaRtfZUaqsIUXVLG3KxJi2MwKZfAQB
         /vA/7gum9baLd/A7N9D238eta+3ustRlAbcjSStuIm/qTkqWZtZYk/bTWqV2evd0zoo3
         qpBO+APSNU2ow2QR2XykJWQEwKg3GGlh/uSa1Yp3T/s8JYx6esXa8J7Ir8bES7qhd/+A
         Y2QyBsxv4T8O1NT4jlW2jeTh1G1kjrswGB8LgpiTvoYbrTumiwmqe25Js9/FEVPVW8BV
         QDLQ==
X-Gm-Message-State: APjAAAVEyIdN48sbPkNwgKbi3Owss56JjMJ8SenrPN+LX9YGue6y3GzD
        +7TVhtooFt91ziRulIbDNTLgowr6EptYMrvR39V+xs0WmR9EZA==
X-Google-Smtp-Source: APXvYqw6EmVAKN0hh5rvGIU9UsOzChhtqk7dA2gzQxaUwkPfLi8l+iC8NZ3r+FDqAkJg0USCRFVVAEFsSx3udZJZnnM=
X-Received: by 2002:a02:1041:: with SMTP id 62mr8661854jay.51.1576784948681;
 Thu, 19 Dec 2019 11:49:08 -0800 (PST)
MIME-Version: 1.0
References: <CAKYuF5QhGCPCazHQjN-=kFc5kHs7Ok8WqmmGLo31CiOEN8TYdA@mail.gmail.com>
 <20191219004538.aqlw354ivugk7vym@ldmartin-desk1.jf.intel.com>
In-Reply-To: <20191219004538.aqlw354ivugk7vym@ldmartin-desk1.jf.intel.com>
From:   Jorge Lucangeli Obes <jorgelo@google.com>
Date:   Thu, 19 Dec 2019 14:48:57 -0500
Message-ID: <CAKYuF5T6fVDjgwY1hReOEp-gBKDy4M1Of6=sMeeDYYb3QvT5oA@mail.gmail.com>
Subject: Re: Buffer overflow in modprobe
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

I am not the author of the change, the change was suggested to us as
part of the report that we received.

I can still try to send it in as a patch.

Cheers,
Jorge

On Wed, Dec 18, 2019 at 7:45 PM Lucas De Marchi
<lucas.demarchi@intel.com> wrote:
>
> On Thu, Dec 12, 2019 at 02:16:18PM -0500, Jorge Lucangeli Obes wrote:
> >Reset the state of was_space to false between passes.
> >For your assistance, we have provided the following code:
> >
> >--- libkmod-config.c            2018-06-21 17:59:48.633600181 +0100
> >+++ libkmod-config.fixed        2018-09-12 21:42:34.499453017 +0100 @@
> >-333,6 +333,8 @@
> >                memcpy(dep->name ,modname ,modnamelen);
> >+        was_space = false;
> >+               /* copy strings */
>
> this looks reasonable. Are you the author of such change? Could you send
> this as a patch with git send-email?
>
> It would be nice to have a test added to the testsuite too if you can.
>
> thanks
> Lucas De Marchi
>
>
> >               itr = dep->name + modnamelen;
> >               n_pre = 0;
