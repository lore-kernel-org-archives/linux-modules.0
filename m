Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB4CC433E0
	for <linux-modules@archiver.kernel.org>; Sat,  6 Feb 2021 04:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B71364FC0
	for <linux-modules@archiver.kernel.org>; Sat,  6 Feb 2021 04:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbhBFECH (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 5 Feb 2021 23:02:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhBFEAF (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 5 Feb 2021 23:00:05 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1B3C0613D6
        for <linux-modules@vger.kernel.org>; Fri,  5 Feb 2021 19:59:24 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id v5so11174572lft.13
        for <linux-modules@vger.kernel.org>; Fri, 05 Feb 2021 19:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OPCEVrw+h9euKbnuLkfBCqkH2rk1lWMGXw7hRkaioXI=;
        b=C3D26KIkssWCAC3jzNftYH/ROrLfPErlgKcbBxXDM78yA+H1HtZjoVK0s2iwZpvjRC
         xsZyI/S8nIB/5PlaapKO6BtYCM8FkVagtAmcbjPD5ev0ATpDcGKZqDVwYvl4obuuE8E/
         uDfBD3coDjCfZsIesUs0iCaF9nLQtIW6rREP0eDtMhOrZ5zS3SX0u5yIfrm1cLWr60WN
         WpbMY3AcjO1K7BlffgYkTcUV/E1fZXJc4LOBnCjl2bIi8CGb3iTcAA+t2a170XNjhfxn
         ovScII3oR1W4zXKwJsDNGW5zT7j3s3I6f9sT0LsVIclE65eRnXSbELSMuBM8w2wLAMmk
         AOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OPCEVrw+h9euKbnuLkfBCqkH2rk1lWMGXw7hRkaioXI=;
        b=DFyJfDAmRe34Meo5BpkMiHxATg3rfk4QbYT/JOYFn2XZRBL/a+LlNvAj+hpyGfUeYd
         BbQKMziRf5IzZTnIRD5nxrbKBPoWN3zngJWPg5Vd7zfbbaLG5Wpynqqv6kqH9o3lX33+
         X+BcYdQcOhBCt5us5uLbOCQZiHg08NCxQvIfXLxkm1FiHTz/8QZm0bV0ELod6JxLYsy0
         xlOLNh62x7jDJSF9V3Z42X84CRCdazag+nt3GPHHT8xD8vr7lJ37OYk3gMZhrKla6Euw
         QD6Cqls2J2yS8BnAUb+3l1O6jUxvFDty6yuWhUlizIOqVRBWUGLsO++H311/4lElJT9v
         BJpQ==
X-Gm-Message-State: AOAM533kHvOQEOUiry3QAQ2BZ5aTKAMSpKI0W5DADb7uWsPiK0udeZdY
        2Jzl6azAzgLGh6rLSiXktcljcYs/TyeXnJHAJSQ=
X-Google-Smtp-Source: ABdhPJyPNgzs5SCnA3mFtfAtnk0yXnPhUR9wt4ONJDFxvxIlO8K16zz1+2W6Fq5GXgsY9meKJVOnY0GeOlTbB70zHWE=
X-Received: by 2002:ac2:5e73:: with SMTP id a19mr4093326lfr.23.1612583962897;
 Fri, 05 Feb 2021 19:59:22 -0800 (PST)
MIME-Version: 1.0
References: <20210130023600.24239-2-lucas.demarchi@intel.com>
In-Reply-To: <20210130023600.24239-2-lucas.demarchi@intel.com>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Fri, 5 Feb 2021 19:59:10 -0800
Message-ID: <CAKi4VALE72Pscn14OhiuamRgXtVqv0UUaRn4g6+Q+aBzFPGWCQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] testsuite: also test xz compression
To:     Petr Vorel <pvorel@suse.cz>
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>,
        linux-modules <linux-modules@vger.kernel.org>,
        =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, Feb 4, 2021 at 2:35 AM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi,
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>


pushed, thanks.


>
> Thanks!
>
> BTW I still have issues with testsuite/test-depmod locally, but probably my
> wrong setup (testing also other configure options than this one):
>
> $ CFLAGS='-g -O2' --enable-debug && make -j`nproc` && make check

humn...  more things to fixup

Lucas De Marchi
>
> depmod: WARNING: could not open modules.order at /lib/modules/4.4.4: No such file or directory
> depmod: WARNING: could not open modules.order at /lib/modules/4.4.4: No such file or directory
> depmod: WARNING: could not open modules.builtin at /lib/modules/4.4.4: No such file or directory
> depmod: WARNING: could not open modules.builtin at /lib/modules/4.4.4: No such file or directory
> depmod: WARNING: could not open modules.order at /lib/modules/4.4.4: No such file or directory
> depmod: WARNING: could not open modules.order at /lib/modules/4.4.4: No such file or directory
> depmod: WARNING: could not open modules.builtin at /lib/modules/4.4.4: No such file or directory
> depmod: WARNING: could not open modules.builtin at /lib/modules/4.4.4: No such file or directory
> TESTSUITE: running depmod_search_order_override, in forked context
> TESTSUITE: SKIPPED: depmod_search_order_override
> TESTSUITE: ------
> TESTSUITE: running depmod_search_order_external_last, in forked context
> TESTSUITE: 'depmod_search_order_external_last' [31183] exited with return code 0
> TESTSUITE: PASSED: depmod_search_order_external_last
> TESTSUITE: ------
> TESTSUITE: running depmod_search_order_external_first, in forked context
> TESTSUITE: SKIPPED: depmod_search_order_external_first
> TESTSUITE: ------
> TESTSUITE: running depmod_detect_loop, in forked context
> TESTSUITE: SKIPPED: depmod_detect_loop
> TESTSUITE: ------
> TESTSUITE: running depmod_search_order_same_prefix, in forked context
> TESTSUITE: 'depmod_search_order_same_prefix' [31182] exited with return code 0
> TESTSUITE: ERR: sizes do not match /src/kmod/testsuite/rootfs/test-depmod/search-order-same-prefix/lib/modules/4.4.4/correct-modules.dep /src/kmod/testsuite/rootfs/test-depmod/search-order-same-prefix/lib/modules/4.4.4/modules.dep
> TESTSUITE: ERR: FAILED: exit ok but outputs do not match: depmod_search_order_same_prefix
> TESTSUITE: ------
> FAIL testsuite/test-depmod (exit status: 1)
>
> Kind regards,
> Petr
