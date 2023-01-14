Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FCAC3DA78
	for <linux-modules@archiver.kernel.org>; Sat, 14 Jan 2023 13:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjANNkR (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sat, 14 Jan 2023 08:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjANNkQ (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sat, 14 Jan 2023 08:40:16 -0500
X-Greylist: delayed 450 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 14 Jan 2023 05:40:15 PST
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 89CFC524E
        for <linux-modules@vger.kernel.org>; Sat, 14 Jan 2023 05:40:15 -0800 (PST)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id GgeIpQmdRVDZbGgeJpIxxi; Sat, 14 Jan 2023 14:32:43 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 14 Jan 2023 14:32:43 +0100
X-ME-IP: 86.243.2.178
Message-ID: <7677faba-bd82-d49a-ad06-c42179b456cc@wanadoo.fr>
Date:   Sat, 14 Jan 2023 14:32:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 18/30] module: Use kstrtobool() instead of strtobool()
Content-Language: fr
To:     Luis Chamberlain <mcgrof@kernel.org>, atomlin@redhat.com
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-modules@vger.kernel.org
References: <cover.1667336095.git.christophe.jaillet@wanadoo.fr>
 <bb37ff26b0c748d0ca883d8f301190cd1177aad2.1667336095.git.christophe.jaillet@wanadoo.fr>
 <Y2K5v08yIDNk7sNW@bombadil.infradead.org>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <Y2K5v08yIDNk7sNW@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Le 02/11/2022 à 19:41, Luis Chamberlain a écrit :
> On Tue, Nov 01, 2022 at 10:14:06PM +0100, Christophe JAILLET wrote:
>> strtobool() is the same as kstrtobool().
>> However, the latter is more used within the kernel.
>>
>> In order to remove strtobool() and slightly simplify kstrtox.h, switch to
>> the other function name.
>>
>> While at it, include the corresponding header file (<linux/kstrtox.h>)
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> 
>    Luis
> 

Hi,

This has been R-b 2 months ago by 2 persons, and I've just resent 
patches in this serie that have neither been merged in -next, nor A-b or 
R-b.

So for this one, it is just a polite reminder. 😄

Do you have visibility on when it should be merged?

CJ
