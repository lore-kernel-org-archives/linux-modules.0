Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F9EC07E96
	for <linux-modules@archiver.kernel.org>; Thu,  8 Jul 2021 08:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9201961CDF
	for <linux-modules@archiver.kernel.org>; Thu,  8 Jul 2021 08:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbhGHIm7 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 8 Jul 2021 04:42:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:33970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230414AbhGHIm7 (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Thu, 8 Jul 2021 04:42:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 23F1461C3F;
        Thu,  8 Jul 2021 08:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625733617;
        bh=wpeHIkX4pbHNPXzG/4S2lBdfpwjjpCHtd0IIdU/Yp2Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n+49CsDTZZmpsHgMyh7iK5oCU/qlvKWKUixStynQKnXZidptKU9DvA43RVBo/skLM
         JiftOIEYkEX+BJyk4pbrVqgjqYif5h7qMT33+mamQakxr2sFyVIDkN7kOcApsS/oju
         h/LfS1xBITrB4ty9LzBs82iDxgLLZAQKH13jKAh0BLbWdcCqUyYkUI1yCI82xqbKvi
         flANLHs6O3AdOgzpaJ/FZkMq5D+0h3UVMDCVFkmBx4gjnWLZFvZoq7KPaOgGPKKHNv
         4cL6CSfIuAUfXTsu0iGPmH5oYlGC0WBA5DhiAlBy6n1pSJm8VHjuHshlbV4MN2grjT
         AqQokxKyXNqKg==
Date:   Thu, 8 Jul 2021 10:40:13 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     masahiroy@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        Eugene Loh <eugene.loh@oracle.com>,
        Kris Van Hees <kris.van.hees@oracle.com>
Subject: Re: [PATCH v2 PING] kallsyms: new /proc/kallmodsyms with builtin
 modules and symbol sizes
Message-ID: <YOa57bMUbUlxJ5Mv@p200300cbcf044300404ca642de146c7c.dip0.t-ipconnect.de>
References: <20210629221542.93728-1-nick.alcock@oracle.com>
 <20210706193334.474270-1-nick.alcock@oracle.com>
 <YOXAjHC9RPAI5QwO@p200300cbcf044300404ca642de146c7c.dip0.t-ipconnect.de>
 <87lf6ic58x.fsf@esperi.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87lf6ic58x.fsf@esperi.org.uk>
X-OS:   Linux p200300cbcf044300404ca642de146c7c.dip0.t-ipconnect.de
 5.12.10-1-default x86_64
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

+++ Nick Alcock [07/07/21 20:07 +0100]:
>On 7 Jul 2021, Jessica Yu uttered the following:
>
>> +++ Nick Alcock [06/07/21 20:33 +0100]:
>>> 15 files changed, 1309 insertions(+), 67 deletions(-)
>>
>> This diffstat is seriously _enormous_. Please don't send patches of
>> this size and expect people to be willing to review :-(. Please break
>> this up into a logical sequence of smaller patches to help your
>> potential reviewers and resend with a cover letter.
>
>Heh, this is very project-dependent it seems. I've been told not to
>split up things so finely when sending series containing 3000+-line
>commits to various toolchain projects before :)

Huh, that's interesting :) 

>Since you are in the "slice finely" camp, I'll split it up a bunch and
>resend. (This will necessarily involve adding things in one commit to
>no obvious purpose in that commit, but I'll keep the intermediate stages
>building and booting, of course.)

Yes, the norm in the Linux kernel community is to split up large
patches into a logical sequence of smaller patches, this will help
reviewers a lot. Thanks in advance!

