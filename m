Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C0DC43334
	for <linux-modules@archiver.kernel.org>; Wed, 13 Jul 2022 15:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236584AbiGMPYr (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 13 Jul 2022 11:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236484AbiGMPYp (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 13 Jul 2022 11:24:45 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AC145062
        for <linux-modules@vger.kernel.org>; Wed, 13 Jul 2022 08:24:44 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id z132so1285266iof.0
        for <linux-modules@vger.kernel.org>; Wed, 13 Jul 2022 08:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cIzmuCZhcyQbk8eSHv2sqFPZ0r/TfvGha/933Vn+Tqg=;
        b=FMAPG3lpSqY+4/JOG6woLiJpYlD3Akz7uW2GlrJp4lfUtiQ4uHcP+78MDlN11xnhb3
         MZdJMDgdEZ6p63mRU7a5Egb0HttFCxlm1GlHz/HqmrT/IkJEbrf1RndiGXBcDJ7pmZTQ
         tGBeyWcn9eUzSG+diIO5qwz5FH2o1Rji2IUNzSKdpyEwqDEOmamWLpNw6E3IT/rWTfDC
         s6+utrSezcOmGHTgICZRCXffgedlAUJdXA1+ez2cwS59lJiRC5yAyxhiCBNQedE/c+da
         KKB1/Q4UskXOepImCPuBs5dm9Q3TW17hdFH8VgxQ1I2Eqp+k31vTBZX1FkOeVWWvtmCG
         nXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cIzmuCZhcyQbk8eSHv2sqFPZ0r/TfvGha/933Vn+Tqg=;
        b=T3VF1hw4lYMPN/T9T6q+Dj4H4BXEwbTX+NtvPJnftK+oPy1h+ne4zXXymeM+d4w1EA
         MENMqvKjELvrkBQkv1t1gG1o72Sk/KFd8PCEtiXE7Z/Wwk+OIr0Wnz35FZM+D1bWAtKt
         0afHzw6FU4p9PBaqSAEBx+w71WfiVrf4QTvCsLph/6mzVJ4aKKJXXfqIRevnA/bF+yBL
         4hjPDDkUqmz32l+w69seJbK6EjzNGSaOweOsOvxhjxZiwIuZHJzjQtVFjCax1nmFH4na
         C+tkiNFfHB1cjQ6bXSUk7rKFn9oytz13Y+RRDtPBvb68tn1MXZR1k7DH/uSwc6N6MnQa
         ocOg==
X-Gm-Message-State: AJIora+/GD6mrhIPNq8XG2mhb8cYdHTgUjfhdmsiaNvV8HraS8+QACNf
        TXZ50inkG8SxJeMSQpUBBbSz5iJAL4rh+O4YwNEOvw==
X-Google-Smtp-Source: AGRyM1tGpK1Jb0GzgDSuTPT0r4ZCKW4BCOjdF0Cbi6ycvY5CUshQoiFJjaXVaZHvy4/7CYsR64P2FpdhqSwWviTA0YM=
X-Received: by 2002:a05:6638:190c:b0:33f:8585:6ef3 with SMTP id
 p12-20020a056638190c00b0033f85856ef3mr1609961jal.153.1657725883559; Wed, 13
 Jul 2022 08:24:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220713005221.1926290-1-davidgow@google.com>
In-Reply-To: <20220713005221.1926290-1-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 13 Jul 2022 08:24:32 -0700
Message-ID: <CAGS_qxrNKnrWXhOfptz9iL5c_sixhKjpAfR2RLQi1XqL6m2Tpg@mail.gmail.com>
Subject: Re: [PATCH] module: kunit: Load .kunit_test_suites section when CONFIG_KUNIT=m
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        linux-modules@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue, Jul 12, 2022 at 5:52 PM David Gow <davidgow@google.com> wrote:
>
> The new KUnit module handling has KUnit test suites listed in a
> .kunit_test_suites section of each module. This should be loaded when
> the module is, but at the moment this only happens if KUnit is built-in.
>
> Also load this when KUnit is enabled as a module: it'll not be usable
> unless KUnit is loaded, but such modules are likely to depend on KUnit
> anyway, so it's unlikely to ever be loaded needlessly.

This seems reasonable to me.

Question: what happens in this case?
1. insmod <test-module>
2. insmod kunit
3. rmmod <test-module>

I think on 3, we'll call the cleanup code, __kunit_test_suites_exit(),
for <test-module>, I think?
But we never called __kunit_test_suites_init().
My fear is what breaks as a result of this precondition break.

E.g. In the case that CONFIG_KUNIT_DEBUGFS is enabled, this includes a
call to kunit_debugfs_destroy_suite() with no previous call to
kunit_debugfs_create_suite().
That will include a call to debugfs_remove_recursive(suite->debugfs),
where suite->debugfs is an uninitialized pointer.

Maybe we can treat it as "undefined behavior" for now and proceed with
this patch.

In terms of long-term fixes, perhaps insmod kunit could trigger it to
1. run all built-in tests (IIUC, it doesn't right now)
2. run all the tests of currently loaded modules
3. track which modules already ran so if you rmmod + insmod kunit
again, it won't rerun tests?

Daniel
