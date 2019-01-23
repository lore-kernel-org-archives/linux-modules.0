Return-Path: <SRS0=Dw8b=P7=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D99C282C3
	for <linux-modules@archiver.kernel.org>; Wed, 23 Jan 2019 01:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76AFC20868
	for <linux-modules@archiver.kernel.org>; Wed, 23 Jan 2019 01:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfAWBZc (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 22 Jan 2019 20:25:32 -0500
Received: from connie.slackware.com ([64.57.102.36]:55742 "EHLO
        connie.slackware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfAWBZc (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 22 Jan 2019 20:25:32 -0500
Received: from connie.slackware.com (localhost [127.0.0.1])
        by connie.slackware.com (8.14.3/8.14.3) with ESMTP id x0N1PM3k024823;
        Tue, 22 Jan 2019 17:25:22 -0800
Received: from localhost (rworkman@localhost)
        by connie.slackware.com (8.14.3/8.14.3/Submit) with ESMTP id x0N1PMel024820;
        Tue, 22 Jan 2019 17:25:22 -0800
X-Authentication-Warning: connie.slackware.com: rworkman owned process doing -bs
Date:   Tue, 22 Jan 2019 17:25:22 -0800 (PST)
From:   Robby Workman <rworkman@slackware.com>
To:     Lucas De Marchi <lucas.de.marchi@gmail.com>
cc:     Daniel Kahn Gillmor <dkg@fifthhorseman.net>,
        linux-modules <linux-modules@vger.kernel.org>
Subject: Re: [kmod] Fix typo
In-Reply-To: <CAKi4VAJQ_XjwcoAFCwT0x9aZMWAvNQ4OuMcEax8OALP4fqS6dA@mail.gmail.com>
Message-ID: <alpine.LNX.2.02.1901221724180.24744@connie.slackware.com>
References: <20190112172219.13152-1-dkg@fifthhorseman.net> <alpine.LNX.2.02.1901121358590.612@connie.slackware.com> <87imyrhuxp.fsf@fifthhorseman.net> <CAKi4VAJQ_XjwcoAFCwT0x9aZMWAvNQ4OuMcEax8OALP4fqS6dA@mail.gmail.com>
User-Agent: Alpine 2.02 (LNX 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue, 22 Jan 2019, Lucas De Marchi wrote:

> On Mon, Jan 14, 2019 at 12:32 PM Daniel Kahn Gillmor
> <dkg@fifthhorseman.net> wrote:
>>
>> On Sat 2019-01-12 13:59:47 -0800, Robby Workman wrote:
>>> I *think* that was supposed to be "of any files" when it was originally
>>> typed, but either works, I suppose :-)
>>
>> I'm fine however it gets resolved -- just please don't leave it with the
>> broken text.
>
> a little bit of archaeology:
>
> this line originally came from the module-init-tools' man page written
> in "doc/modprobe.conf.sgml".
> Grepping that repo shows that it probably was a copy of
> doc/depmod.conf.sgml that
> had phrase "The format of <filename>depmod.conf</filename> and files
> under <filename>depmod.d</filename> is simple"
>
> So, whoever copied it over forgot to remove the "and". Not that any of
> this matter... your version or the
> other are perfectly fine today :)


Yeah, oops here. I called myself proofing all of that as I copied it,
and I made quite a few changes along the way, but oh well. 
Thanks Daniel and Lucas :-)

-RW
