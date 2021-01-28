Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF616C43381
	for <linux-modules@archiver.kernel.org>; Thu, 28 Jan 2021 16:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93C7064DF9
	for <linux-modules@archiver.kernel.org>; Thu, 28 Jan 2021 16:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbhA1Q0Y (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 28 Jan 2021 11:26:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbhA1QZ7 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 28 Jan 2021 11:25:59 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB866C0613ED
        for <linux-modules@vger.kernel.org>; Thu, 28 Jan 2021 08:25:18 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id l12so6030184wry.2
        for <linux-modules@vger.kernel.org>; Thu, 28 Jan 2021 08:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ctwt3njQESeVdDNbxPLBPANBPsZquqUZzNLFg1wOAy4=;
        b=k1MhJvAfXhiPFWAu0o65a55RhOpgpVgEX+u288hbw8Ybg8MCC981EmUrqQErjtkleM
         1ghncH5XmsBhxNrDCE7oazfSc83LmMi3E+UmDBqU+QF5UvvgHBoO6xTCs0qN9Je5F7XK
         Qu7UngudWTqztxyzbToouLcv4WcHnt0xLC26CYc98gdiItBJKBavxdHlxuNDKS63ssSl
         h9g7T5mVAW3EHyr/oEbpnstauh6nEJMPonMTtt32dVV/xsdU9TMovAr9v8Rl1HdVPZIg
         WtmpI0TH8LKqkLDCFVADbtSci2Iz/o8wZ26vJtngXXNys5C698vJdp/JmWSTbLs2MnXP
         m+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=ctwt3njQESeVdDNbxPLBPANBPsZquqUZzNLFg1wOAy4=;
        b=uTiohyv0mAvq446ppx5L1W+IVbgZ7JKnfxfmZkoIF9VtuLK7N3bs0FPpX80WQr5QoK
         sj7z2uuYL/P6a82VSmocl7r5A3feOZmEl+5Uv/m2qY6SZ25kN5asPkKnESLINLc/9XZX
         XqlFxqscEBJ9xN2tdcy6OXYVcphMihlYLMj5/M7tuHFIzoRK+dTq/qXEzchRXg7zJX34
         iFnEnsi4h2JcZuf+Viykcr/17D3HjRVJOshybwHDJVHsYS+AInBnn5p2BgrUEWlVnvHK
         WT1OWZzwtcjOGj/Yn6MaR5LJcUSELKaYfXO+PjlkFmTTnZ1JR0H5djhDAETA08ZnRNzT
         bAeQ==
X-Gm-Message-State: AOAM533T90wxuF9Wc6CnSwo8R09GQhFCGlOx41PtE7/FGrSGBrajp6OM
        ZaIWHsGHMW5sjKNPuX0BQjc=
X-Google-Smtp-Source: ABdhPJxpO6f/UzpwoNYkpYzBwyPYYRwBPM509i2Cn2qrpf6dE5RkLVLrJgdHh8Xs15brRKcXOLUYPQ==
X-Received: by 2002:adf:efc2:: with SMTP id i2mr16714920wrp.422.1611851117505;
        Thu, 28 Jan 2021 08:25:17 -0800 (PST)
Received: from pevik ([62.201.25.198])
        by smtp.gmail.com with ESMTPSA id c11sm7436939wrs.28.2021.01.28.08.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 08:25:16 -0800 (PST)
Date:   Thu, 28 Jan 2021 17:25:14 +0100
From:   Petr Vorel <petr.vorel@gmail.com>
To:     Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc:     Michal =?iso-8859-2?Q?Such=E1nek?= <msuchanek@suse.de>,
        linux-modules <linux-modules@vger.kernel.org>
Subject: Re: depmod test fails when zstd not available
Message-ID: <YBLlai0GEEnhg68X@pevik>
Reply-To: Petr Vorel <petr.vorel@gmail.com>
References: <20210128130026.GH6564@kitsune.suse.cz>
 <CAKi4VAK6PB1UxwcaPwmL0b0dByq8QcZYuWj5SZVaGjtRuu7BmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKi4VAK6PB1UxwcaPwmL0b0dByq8QcZYuWj5SZVaGjtRuu7BmA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Hi Lucas,

> On Thu, Jan 28, 2021 at 5:02 AM Michal Suchánek <msuchanek@suse.de> wrote:

> > Hello,

> > kmod version 28 adds support for zstd. The support is optional but when
> > not enabled the depmod test which unconditionally tests zstd fails.

> > As kmod supports more and more compression methods I think it is not
> > reasonable to expect everyone has all copression libraries available.

> > Do you think it is reasonable to fix the tests to only use teh
> > compresion methods enabled by configure?

> We specifically added support for skipping tests when the build
> options would imply that the test
> would fail. It should not be failing, we probably screwed something up.
I noticed that and backported both related patches during backport:
847247a testsuite: Automatically skip tests that fail when sysconfdir != /etc.
b5683f4 testsuite: Add facility to skip tests.

but it failed.

Also running master with:
./autogen.sh && ./configure CFLAGS='-g -O2' --enable-debug  --with-zstd --with-xz --with-zlib --with-openssl && ma && ma check
fails on testsuite/test-depmod:

depmod: WARNING: could not open modules.order at /lib/modules/4.4.4: No such file or directory
depmod: WARNING: could not open modules.order at /lib/modules/4.4.4: No such file or directory
depmod: WARNING: could not open modules.builtin at /lib/modules/4.4.4: No such file or directory
depmod: WARNING: could not open modules.builtin at /lib/modules/4.4.4: No such file or directory
depmod: WARNING: could not open modules.order at /lib/modules/4.4.4: No such file or directory
depmod: WARNING: could not open modules.order at /lib/modules/4.4.4: No such file or directory
depmod: WARNING: could not open modules.builtin at /lib/modules/4.4.4: No such file or directory
depmod: WARNING: could not open modules.builtin at /lib/modules/4.4.4: No such file or directory
TESTSUITE: running depmod_search_order_override, in forked context
TESTSUITE: SKIPPED: depmod_search_order_override
TESTSUITE: ------
TESTSUITE: running depmod_search_order_external_last, in forked context
TESTSUITE: 'depmod_search_order_external_last' [649] exited with return code 0
TESTSUITE: PASSED: depmod_search_order_external_last
TESTSUITE: ------
TESTSUITE: running depmod_search_order_external_first, in forked context
TESTSUITE: SKIPPED: depmod_search_order_external_first
TESTSUITE: ------
TESTSUITE: running depmod_detect_loop, in forked context
TESTSUITE: SKIPPED: depmod_detect_loop
TESTSUITE: ------
TESTSUITE: running depmod_search_order_same_prefix, in forked context
TESTSUITE: 'depmod_search_order_same_prefix' [650] exited with return code 0
TESTSUITE: ERR: sizes do not match testsuite/rootfs/test-depmod/search-order-same-prefix/lib/modules/4.4.4/correct-modules.dep testsuite/rootfs/test-depmod/search-order-same-prefix/lib/modules/4.4.4/modules.dep
TESTSUITE: ERR: FAILED: exit ok but outputs do not match: depmod_search_order_same_prefix
TESTSUITE: ------
FAIL testsuite/test-depmod (exit status: 1)

Kind regards,
Petr
