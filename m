Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219A1C433DB
	for <linux-modules@archiver.kernel.org>; Thu, 28 Jan 2021 13:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C549764DD8
	for <linux-modules@archiver.kernel.org>; Thu, 28 Jan 2021 13:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbhA1NTz (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 28 Jan 2021 08:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbhA1NTu (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 28 Jan 2021 08:19:50 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21656C061573
        for <linux-modules@vger.kernel.org>; Thu, 28 Jan 2021 05:19:10 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id c18so6267360ljd.9
        for <linux-modules@vger.kernel.org>; Thu, 28 Jan 2021 05:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P/xCooW3uFGckZuUVegVeYfuixVFsMHhPM7MAzFtiB0=;
        b=edAiwhDoXjOjIUpokc7+JghVpuYvWYD207/8yMbi6+Yd8+FERvpzpL7K1T9zg1aKXk
         WD/BXVm9ADorOblZZu3gbY0kbh3+rScC0xauVaJ0gK/X+WwdWwxbxo8jcaE6eA9x+TQJ
         +vpuWrgDB0rb2GE41HbqDf/OLg/AfeqrBTWiRCHxdt5I/SGC6UFMSYjZ/CVnDENu3A+b
         8AAwbO4Wrt/gtRLiHn7dWkPTOlkgl3rH9ADhHnLKKgrbeTJwnHU8uorWqxoqdV51AM0r
         EZ/p7v4SkTY9TRoc0tx7qfotklXZG+vdwxmb4Qrv5LZsy4NB04P+jp4Av7Obpn0smNa/
         KT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P/xCooW3uFGckZuUVegVeYfuixVFsMHhPM7MAzFtiB0=;
        b=ZjWBTUEE+488kKz/R15YGx3QENXzht44bIwpxbRDTlxBPSWtZx5jhZnzyRMMkuwfcL
         NZazZ6/7lrlKz1+lFP1aqUsSncauhg9hlbE9zJW/LfA6QlPnw0aWVKbnvz2lIMZrF2J1
         Dh3ptLXW/ddM+v1nVHQ9FhAtlCkINBqw6kwd121rg0hjHYHvjYI3P3jK8S3Lt0+lKqEk
         Io7ls5EGpT475oDgt8s9j0F6FqOkku03Z7r4CmQz8qFEH8wYA0ogHP5dOgDtF0M05zN+
         Tl0gUhRepjFcMrGlrj1EW+bbZHmrGvxRXOL7aPBsyu8xJiylzE56+n+M+3VDlyH8bYuF
         rq8g==
X-Gm-Message-State: AOAM530GRKXYrI2DA+oT7K5Hohg4qQeaPAd9Kw22W+EHWn7YiATg8k/J
        1/VSd7J3gHbAbsv6Cvpi/mlNU8IkCI7X4OoS27iCtwpSIhZuuw==
X-Google-Smtp-Source: ABdhPJzOq53EcKob5KsuBU/jh7luBx5nMFP+OmF7NUQEmGq7Yo5uAPNKKkDmThGN0Qmfpy8szkPxgIWZiKYHo6fKUSg=
X-Received: by 2002:a2e:94d0:: with SMTP id r16mr8606159ljh.332.1611839948588;
 Thu, 28 Jan 2021 05:19:08 -0800 (PST)
MIME-Version: 1.0
References: <20210128130026.GH6564@kitsune.suse.cz>
In-Reply-To: <20210128130026.GH6564@kitsune.suse.cz>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Thu, 28 Jan 2021 05:18:56 -0800
Message-ID: <CAKi4VAK6PB1UxwcaPwmL0b0dByq8QcZYuWj5SZVaGjtRuu7BmA@mail.gmail.com>
Subject: Re: depmod test fails when zstd not available
To:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     linux-modules <linux-modules@vger.kernel.org>,
        Petr Vorel <petr.vorel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, Jan 28, 2021 at 5:02 AM Michal Such=C3=A1nek <msuchanek@suse.de> wr=
ote:
>
> Hello,
>
> kmod version 28 adds support for zstd. The support is optional but when
> not enabled the depmod test which unconditionally tests zstd fails.
>
> As kmod supports more and more compression methods I think it is not
> reasonable to expect everyone has all copression libraries available.
>
> Do you think it is reasonable to fix the tests to only use teh
> compresion methods enabled by configure?

We specifically added support for skipping tests when the build
options would imply that the test
would fail. It should not be failing, we probably screwed something up.

Lucas De Marchi

>
> Thanks
>
> Michal
