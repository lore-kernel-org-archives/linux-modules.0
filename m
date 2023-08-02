Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CDAC001E0
	for <linux-modules@archiver.kernel.org>; Wed,  2 Aug 2023 16:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbjHBQ2V (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 2 Aug 2023 12:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjHBQ2U (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 2 Aug 2023 12:28:20 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F4C5211B
        for <linux-modules@vger.kernel.org>; Wed,  2 Aug 2023 09:28:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D87AA113E;
        Wed,  2 Aug 2023 09:29:01 -0700 (PDT)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5FE893F6C4;
        Wed,  2 Aug 2023 09:28:17 -0700 (PDT)
Message-ID: <4f9af3c3-bafa-c536-22a0-86d427049eb3@arm.com>
Date:   Wed, 2 Aug 2023 17:28:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/3] ARM/arm64: Fix loading of modules with an exit
 section
Content-Language: en-GB
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-modules@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Jessica Yu <jeyu@kernel.org>,
        Adam Johnston <adam.johnston@arm.com>
References: <20230801145409.8935-1-james.morse@arm.com>
 <ZMk9g/muvx66HOj4@bombadil.infradead.org>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <ZMk9g/muvx66HOj4@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Hi Luis,

On 01/08/2023 18:14, Luis Chamberlain wrote:
> On Tue, Aug 01, 2023 at 02:54:06PM +0000, James Morse wrote:
>> Adam reports that Yocto can't load modules on arm64. This turns out to be due
>> to the arch code disagreeing with the core code when it comes to the layout
>> of the modules exit text, resulting in a shortage of PLTs and a bunch of
>> warnings.
>>
>> arm and arm64 are unusual here as they are counting the PLTs based on the
>> section name. This series exposes the helper that core code uses to decide
>> the layout.
>>
>> I've been unable to reproduce the behaviour on 32bit - but it looks like
>> its possible to reach the BUG_ON() in get_module_plt(). To test this, disable
>> CONFIG_MODULE_UNLOAD, and try to load modules with relocations in their exit
>> text.
>>
>> This series is based on v6.5-rc4, and can be retrieved from:
>> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git arm64/modules/exit_sections/v1
>>
> 
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

Thanks!


> Do you want this to go through the modules tree or do you want to take
> this in your tree? Either way is fine by me, at this point there should
> be no conflicts.

If Russell agrees the problem exists on 32bit arm, then I think it would be best to keep
these three together - going via the modules tree would make the most sense.

This has been broken for a while, so it can wait for v6.6-rc1.
I think the yocto folk plan to carry this out of tree until its in their chosen stable
version.


Thanks,

James
