Return-Path: <SRS0=cK9R=4V=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF3BC3F2CD
	for <linux-modules@archiver.kernel.org>; Wed,  4 Mar 2020 09:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A75F21739
	for <linux-modules@archiver.kernel.org>; Wed,  4 Mar 2020 09:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583313518;
	bh=xffv0+upK8HzauhdUFpS9EWa70+FnnQ5/7Pzd2dSvLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=r1eQ8YwnAN68dgZJ7cxYGBoPR9+6iOVhOYAQvINkkp485umAorRQkkF3STtWEVv1w
	 aT6zrb53rEpT6kZglMGoztMWOmBt/tp1ZlqTZjGmhjOeyP3MeEuhOdgLG6dYUt9P+n
	 XXAmq8aAoC3Li3JsJyplG4HJxVCJVzRMoDvwylM0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgCDJSh (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 4 Mar 2020 04:18:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:35854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbgCDJSh (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Wed, 4 Mar 2020 04:18:37 -0500
Received: from linux-8ccs (p5B2812F9.dip0.t-ipconnect.de [91.40.18.249])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3393020705;
        Wed,  4 Mar 2020 09:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583313517;
        bh=xffv0+upK8HzauhdUFpS9EWa70+FnnQ5/7Pzd2dSvLo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aa2R0Kci+pifyhO+jPT/livDHt0Nfo37+ZvopZr/D+yH43hLRyEAM0zn6tKSHe625
         p4W99E5X51Uw7B6CC1soCcYk4M97Q4GL/Vim1ap4FWP9cDRlIs/UK/F7nEzAbxJYVv
         BFBYyxXfZ0Kn7itDajm81sUenjVVHNW4MfIoA2zk=
Date:   Wed, 4 Mar 2020 10:18:33 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc:     Matthias Maennich <maennich@google.com>,
        linux-modules <linux-modules@vger.kernel.org>
Subject: Re: [PATCH] depmod: account for new namespace field in
 Module.symvers (for kernel versions >= 5.4)
Message-ID: <20200304091833.GA14910@linux-8ccs>
References: <20200221165243.25100-1-jeyu@kernel.org>
 <CAKi4VA+uO-mdZ=gKpWdU6vq2_VJjhDkHS3KVZb3_6N2YGVhgiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAKi4VA+uO-mdZ=gKpWdU6vq2_VJjhDkHS3KVZb3_6N2YGVhgiA@mail.gmail.com>
X-OS:   Linux linux-8ccs 5.5.0-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

+++ Lucas De Marchi [03/03/20 22:28 -0800]:
>On Fri, Feb 21, 2020 at 8:53 AM Jessica Yu <jeyu@kernel.org> wrote:
>>
>> depmod -e -E is broken for kernel versions >= 5.4, because a new
>> namespace field was added to Module.symvers. Each line is tab delimited
>> with 5 fields in total. E.g.,
>>
>>         0xb352177e\tfind_first_bit\tnamespace\tvmlinux\tEXPORT_SYMBOL
>>
>> When a symbol doesn't have a namespace, then the namespace field is empty:
>>
>>         0xb352177e\tfind_first_bit\t\tvmlinux\tEXPORT_SYMBOL
>
>Why is namespace added in the *middle*? We remember we specifically
>talked about compatibility back when this was added. Why is it not at
>the end so tools that don't know about namespace don't stop working?
>
>Lucas De Marchi

Sigh, I do remember we had a short discussion upstream back in August
[1] when we were tossing around Module.symvers format preferences. It
is my fault for not having pushed the backwards compatibility option
more instead of thinking it could be patched up in kmod tools. I think
maybe the best course of option is to revert this upstream instead and
Cc:stable.

Sorry about this. :-/

[1] https://lore.kernel.org/r/20190828094325.GA25048@linux-8ccs

