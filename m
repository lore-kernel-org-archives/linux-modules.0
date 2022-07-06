Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C46C43334
	for <linux-modules@archiver.kernel.org>; Wed,  6 Jul 2022 21:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234526AbiGFVQI (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 6 Jul 2022 17:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233838AbiGFVQI (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 6 Jul 2022 17:16:08 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF878C0C
        for <linux-modules@vger.kernel.org>; Wed,  6 Jul 2022 14:16:05 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id k30so12684081edk.8
        for <linux-modules@vger.kernel.org>; Wed, 06 Jul 2022 14:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hThyagx/3gO75R3ByObu2jcXCn9gsg8eLIOZEOFTgW0=;
        b=qxZxOVueXL4xlVup4HqnHuiID4ylYROtcIuMl/Z9Mo0Y57haMDDPOImjOILx8fPqt1
         k6leDDEur87IiyUGE53yyulvaw0GG6VKKGKtC5TW74SIRBupHfYMrbhWton1G/KnqORy
         Vo8KeFFXMqVBr7tP8UiplZ9ls+YJYM5Y24fTkbZVIxZ5SybAUUJGxNmObIIV8U8HW/Gd
         IYIUjRvth7RP3GtrWLzmNsMl1vQPCgBoGHad5roS56vxNwWFlt94iAMdufbaKZZP73Xs
         /lgqaSE/9c+5UqZmchyK7DTRYBZunag3dRo3yGYzMSfRvdmxdC1DDlGqGsMXCpIL4MNU
         HVjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hThyagx/3gO75R3ByObu2jcXCn9gsg8eLIOZEOFTgW0=;
        b=5hsujiD2PvCWgYdmEitCUbp1qeQfb0gd7mz6JedS/TU0P+1YSTffTCXSo/IidTbLg0
         e5STYVPFbnK1srSIWXZ1KLIIk7ZfuJ8aoex6BTsw0OvbmLtApgI+3hZuh3274QDUwUS9
         /9QVNl6KFcALzDcFHknIlNHs0W5bDd5JMrShyNhpeK3afPXmQ1couYj0mtNgRFWAfXs6
         +EBj62ZPqP52FIgqu8LjTbbvAi6QbDFUZnOrIzIG56NIMQnFSr9aXX3mcuobx+8L3kyt
         IYHvGj49VXZy8kqGmvlLeAPXMVxmD3zhzhKpoWpjOZuOgunftEtK8+YY5gu6SgiEjtvj
         ZZmg==
X-Gm-Message-State: AJIora+yI+JIFQ4lhH/qQakGgnlt99P9bwAneu5mDJvZgAiNzztr9Evn
        IhoMSFXZDYHeLsA2Y6+qEfPlFJgaNAfFnywtj2GG5w==
X-Google-Smtp-Source: AGRyM1sPbJFOfgds1z44L+2x0LeSz+WDXIcXmrmRGKcnUJOHvArk6m1Yo9JIVaHoclX4irKL2BmvvO9xvoY4Zp4J2ko=
X-Received: by 2002:a05:6402:90a:b0:439:c144:24cd with SMTP id
 g10-20020a056402090a00b00439c14424cdmr33905014edz.209.1657142164310; Wed, 06
 Jul 2022 14:16:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220625050838.1618469-1-davidgow@google.com> <20220625050838.1618469-3-davidgow@google.com>
In-Reply-To: <20220625050838.1618469-3-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 6 Jul 2022 17:15:53 -0400
Message-ID: <CAFd5g46ftDZwaPDdr8p2tRsd86uEQhFGfv+y6S3EVDtHCEa4zg@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] kunit: flatten kunit_suite*** to kunit_suite** in .kunit_test_suites
To:     David Gow <davidgow@google.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Longpeng <longpeng2@huawei.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?TWHDrXJhIENhbmFs?= <maira.canal@usp.br>,
        linux-mmc@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, linux-usb@vger.kernel.org,
        linux-modules@vger.kernel.org,
        Matt Johnston <matt@codeconstruct.com.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Sat, Jun 25, 2022 at 1:10 AM 'David Gow' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> From: Daniel Latypov <dlatypov@google.com>
>
> We currently store kunit suites in the .kunit_test_suites ELF section as
> a `struct kunit_suite***` (modulo some `const`s).
> For every test file, we store a struct kunit_suite** NULL-terminated arra=
y.
>
> This adds quite a bit of complexity to the test filtering code in the
> executor.
>
> Instead, let's just make the .kunit_test_suites section contain a single
> giant array of struct kunit_suite pointers, which can then be directly
> manipulated. This array is not NULL-terminated, and so none of the test
> filtering code needs to NULL-terminate anything.
>
> Tested-by: Ma=C3=ADra Canal <maira.canal@usp.br>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Co-developed-by: David Gow <davidgow@google.com>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
