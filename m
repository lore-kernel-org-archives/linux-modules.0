Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BF6C04A68
	for <linux-modules@archiver.kernel.org>; Thu, 28 Jul 2022 08:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235234AbiG1Ima (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 28 Jul 2022 04:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235125AbiG1Ima (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 28 Jul 2022 04:42:30 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C373762A61
        for <linux-modules@vger.kernel.org>; Thu, 28 Jul 2022 01:42:28 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id 129so989203vsq.8
        for <linux-modules@vger.kernel.org>; Thu, 28 Jul 2022 01:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L69tTE2sH+PMx280GbvtDkw3gNuAyH0o9/0HeA0+XoA=;
        b=j/c5UpIF73D7K3bcNVXSTIOMPDPw1ZZIwrFEIHGEmQ2hfCs63+1CtBLnwvtBjNcHIT
         W/R6yLZZlLhLjUBi0wstREns8Vn6JQNPqmYAJoK9jU3jJhhuXZT5P6P3Jeup5fcHa4mm
         xSzvcnkeWa1v1ggGp791wpOThlGf35ucdfr8bqJeQcUKz1speVD2qtWFDYGJ41Ay1DXH
         lNSj+PW0I4YOKeH0heh12zUvSg+cR3/8+X0U1mVkoRbdHUX+hyX6j1g/CymkL0M17yOF
         b4ePaT4/tswlLBf3LDopM8gfJZvgN9qdMbwbrN2ql7ZWxQW7rhlmpQLBfC8Y7Q/ynbfR
         3d8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L69tTE2sH+PMx280GbvtDkw3gNuAyH0o9/0HeA0+XoA=;
        b=q1CbQvZC/y9C1GrzLklofnpf3wK965f0tWVK6Bj9WzRB8W/YFHoAyR154UqxNAu19G
         kSJQY46WvgCiMTiuCBYHuh/A+MGoN5M+ntFRCh0pckIsY04KnLvKJG6vpEuxt90T3ZFc
         hW3gMzNj4iwM4aWsci9DXwZN9ov7v/3trUlDbSf6fRlab+jFYG6hwgBBlI45y7O8HXDO
         3HXWqjCE9D8bVKZDTUmU5wDtdJ0rbEInVcRx1BaJsPAp1kNH7sSgLXyMHWoWunLUy4F2
         d6kNlX4eqqKJ3kfZW4mfXWseCJf6ExE3Yi61jLEURS0CmQUQe2Fsr2kldUMLdBRh38Uz
         Xijg==
X-Gm-Message-State: AJIora9Didl7Nu3EvZDyWzHss5s7NQ9grh/VAXVBSixem6i/ruoHFBAj
        1OPrG+E1ZF1n9SwWrykunmonsK+GEfDuZ0LpsJZOEw==
X-Google-Smtp-Source: AGRyM1vmeHmNdG+8W3+/i8ug6s6VPZStYQfUcfiEivq89bhT6FaV5XmJFQju73GNHE+yl0qP0wG4zWViYFrmeDzIW98=
X-Received: by 2002:a67:c191:0:b0:358:5ca6:f98d with SMTP id
 h17-20020a67c191000000b003585ca6f98dmr6818737vsj.71.1658997747795; Thu, 28
 Jul 2022 01:42:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220713005221.1926290-1-davidgow@google.com> <CAGS_qxrNKnrWXhOfptz9iL5c_sixhKjpAfR2RLQi1XqL6m2Tpg@mail.gmail.com>
 <Ytbw1T6uspICqj5B@bombadil.infradead.org> <CABVgOSkpT2kqVec2F7BsTF5tyABO43bseETC2Dz238zN+sTfQw@mail.gmail.com>
 <YthllWFPAjq5YHpL@bombadil.infradead.org>
In-Reply-To: <YthllWFPAjq5YHpL@bombadil.infradead.org>
From:   David Gow <davidgow@google.com>
Date:   Thu, 28 Jul 2022 16:42:16 +0800
Message-ID: <CABVgOSnYQyRg8+nysnRAqn9-jEG+UzEdU7gSUOOEzU-aqYLSMQ@mail.gmail.com>
Subject: Re: [PATCH] module: kunit: Load .kunit_test_suites section when CONFIG_KUNIT=m
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        linux-modules@vger.kernel.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, Jul 21, 2022 at 4:29 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Wed, Jul 20, 2022 at 05:26:02PM +0800, David Gow wrote:
> > On Wed, Jul 20, 2022 at 1:58 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > >
> > > On Wed, Jul 13, 2022 at 08:24:32AM -0700, Daniel Latypov wrote:
> > > > On Tue, Jul 12, 2022 at 5:52 PM David Gow <davidgow@google.com> wrote:
> > > > >
> > > > > The new KUnit module handling has KUnit test suites listed in a
> > > > > .kunit_test_suites section of each module. This should be loaded when
> > > > > the module is, but at the moment this only happens if KUnit is built-in.
> > > > >
> > > > > Also load this when KUnit is enabled as a module: it'll not be usable
> > > > > unless KUnit is loaded, but such modules are likely to depend on KUnit
> > > > > anyway, so it's unlikely to ever be loaded needlessly.
> > > >
> > > > This seems reasonable to me.
> > > >
> > > > Question: what happens in this case?
> > > > 1. insmod <test-module>
> > > > 2. insmod kunit
> > > > 3. rmmod <test-module>
> > > >
> > > > I think on 3, we'll call the cleanup code, __kunit_test_suites_exit(),
> > > > for <test-module>, I think?
> > > > But we never called __kunit_test_suites_init().
> > > > My fear is what breaks as a result of this precondition break.
> >
> > I don't think this should be possible: any module with KUnit tests
> > will depend on the 'kunit' module (or, at least, kunit symbols), so
> > shouldn't load without kunit already present.
> >
> > If modprobe is used, kunit will automatically be loaded. If insmod is
> > used directly, loading the first module should error out with
> > something like:
> > [   82.393629] list_test: loading test module taints kernel.
> > [   82.409607] list_test: Unknown symbol kunit_binary_ptr_assert_format (err -2)
> > [   82.409657] list_test: Unknown symbol kunit_do_failed_assertion (err -2)
> > [   82.409799] list_test: Unknown symbol kunit_binary_assert_format (err -2)
> > [   82.409820] list_test: Unknown symbol kunit_unary_assert_format (err -2)
> > insmod: ERROR: could not insert module
> > /lib/modules/5.19.0-rc1-15284-g9ec67db0c271/kernel/lib/list-test.ko:
> > Unknown symbol in module
>
> This can be fixed with a request_module() call. And since this is a
> generic requirement, you can have the wrappers do it for you.
>

I'm not convinced that this is worth the trouble, particularly since
KUnit needs to be loaded already before any test-specific code in a
module is run. _Maybe_ we could put it in the code which looks for the
.kunit_test_suites section, but even then it seems like a bit of an
ugly hack.

Personally, I'm not particularly concerned about test modules failing
to load if KUnit isn't already present -- if people want all of a
module's dependencies loaded, that's what modprobe is for.

That being said, if you feel particularly strongly about it, this is
something we can look at. Let's do so in a separate patch though: this
one does fix a regression as-is.

> > Maybe you could get into some trouble by force-removing modules at
> > various points, but you're in undefined behaviour generally at that
> > point, so I don't think there's much point going out-of-our-way to try
> > to support that.
>
> You can prevent that by refcounting the kunit module / symbols, by each test.
>

Again, I don't think KUnit is any more special than any other module
here. I don't think we need to do this ourselves, as it shouldn't be
possible to remove kunit without first removing any dependent modules.

Of course, happy to look into this again if anyone can come up with an
actual crash, but I'd rather get this fix in first. At the very least,
this patch shouldn't introduce any _new_ issues.

Cheers,
-- David
>   Luis
