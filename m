Return-Path: <SRS0=mdKN=5K=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D20C1975A
	for <linux-modules@archiver.kernel.org>; Wed, 25 Mar 2020 17:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 102FC20777
	for <linux-modules@archiver.kernel.org>; Wed, 25 Mar 2020 17:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xu+qr+XA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbgCYRDU (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 25 Mar 2020 13:03:20 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:54014 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgCYRDU (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 25 Mar 2020 13:03:20 -0400
Received: by mail-wm1-f54.google.com with SMTP id b12so3294190wmj.3
        for <linux-modules@vger.kernel.org>; Wed, 25 Mar 2020 10:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l3qN6eq5+0WDy4LEzpixEh8FzCrEHzJHHU4i993u6Do=;
        b=Xu+qr+XA66qmFmndPNdkDCOE9G6YYEMoxnLJUKl3IoFfCalIHXJJFcY+cfX4LwN2jt
         iKNisuT6DSvIDAiEyEAOxLCzjGyQ3QPGce4UwoUhw0WcEMyxMa36IC1gtmxtO2fglAfg
         hp0z9bqV1PXZ3bn2k04x9nnZU7VDFrMpjyXCWCCHpiDUOIUpBZStg8I+GXIzv5h4VvXW
         d3U8FqFdgjxA0r/Zim3IC4IGfpkV6yVo8vPDzOVIptC3esloiAR8EGr7hoAXnSGixUTK
         JGMyEZlvygtyrP5mcqZklmwth2LHje5HekH84unR1UvOiy7XPjvGd7LaOVmRsmEb8Wjd
         1hOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l3qN6eq5+0WDy4LEzpixEh8FzCrEHzJHHU4i993u6Do=;
        b=O8yDczWGvBwqX/QiN2iibqX1sA/amK4aXaM8pjE1E2g1+/iiRqqj5bq9UXVY9U1Mcu
         T3mL0e2EAcTkGQh1LXAoK5hTJ85CoGkgWVvzp/WmUqxMrEI+ckiPMGzbrLHlqdiaCTkc
         uhuK2mwEw2aj+PSj942WQbdB2Y1nslcQ2wCTBOY9IUPdSCbn6o8p54FD34jMvnjAUrrw
         Mg1w7ObvNg1wTL7zXCSunirvZ0BFlua63/FAwe9rh8JhbMrTtIUo9vYWCOfP3Ed7Kj0w
         cmC/Jq8BsKeHOJJ2o1G8bvi980SgLc6DWDRnuMDfmrWgTntt8HscSnC6IQqi6EbeudJZ
         K8qg==
X-Gm-Message-State: ANhLgQ2J6SbuRe84HH92U1zy3lyEJyUM+5PUuRzT5aDhNbZHzLSHT4RW
        Wqbq+ww4gDgHAas/cc1jRDw+t7Wj1lCQGCpWPPQ=
X-Google-Smtp-Source: ADFU+vtBLadh4ZQDcXJnxicDvwhY80nnv00ul2eAA73ApHhUM5jNGhZqy5LSxL/QTrXqMYQnxuaeaAAWTvvUcaCNUEA=
X-Received: by 2002:a1c:196:: with SMTP id 144mr4466941wmb.100.1585155798339;
 Wed, 25 Mar 2020 10:03:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAFhXUqrBQp9Fy=RYMW4JBdJdgzjbvF20fXjze39iXi-3EG9TBg@mail.gmail.com>
In-Reply-To: <CAFhXUqrBQp9Fy=RYMW4JBdJdgzjbvF20fXjze39iXi-3EG9TBg@mail.gmail.com>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Wed, 25 Mar 2020 10:03:05 -0700
Message-ID: <CAKi4VAKv=J5_=BrLgu5Qm2UgMLJUG-2Xrt8iGx3v=u2zyOjF7Q@mail.gmail.com>
Subject: Re: question - where to file bug report for modprobe
To:     Philip Stephens <phil.stphns@gmail.com>
Cc:     jcm@jonmasters.org, rworkman@slackware.com,
        linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

It's on kmod's mailing list linux-modules
<linux-modules@vger.kernel.org>, already CC'ed here.

thanks
Lucas De Marchi

On Wed, Mar 25, 2020 at 8:54 AM Philip Stephens <phil.stphns@gmail.com> wrote:
>
> Hi!
>
> I've run into an issue I think is a bug, and I'm having a problem targeting the correct group. As you all were listed in the modprobe manpage, I thought I'd give you a try.
>
> https://bugs.launchpad.net/ubuntu-manpage-repository/+bug/1868622
>
> That's the bug (possibly), can you tell me which project to file it with?
>
> Thanks,
> Philip
>



-- 
Lucas De Marchi
