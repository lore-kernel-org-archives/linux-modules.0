Return-Path: <SRS0=Y+s7=PU=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C70C43387
	for <linux-modules@archiver.kernel.org>; Sat, 12 Jan 2019 22:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A0982084C
	for <linux-modules@archiver.kernel.org>; Sat, 12 Jan 2019 22:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfALWNY (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sat, 12 Jan 2019 17:13:24 -0500
Received: from connie.slackware.com ([64.57.102.36]:40000 "EHLO
        connie.slackware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfALWNX (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sat, 12 Jan 2019 17:13:23 -0500
X-Greylist: delayed 808 seconds by postgrey-1.27 at vger.kernel.org; Sat, 12 Jan 2019 17:13:23 EST
Received: from connie.slackware.com (localhost [127.0.0.1])
        by connie.slackware.com (8.14.3/8.14.3) with ESMTP id x0CLxlD1000652;
        Sat, 12 Jan 2019 13:59:48 -0800
Received: from localhost (rworkman@localhost)
        by connie.slackware.com (8.14.3/8.14.3/Submit) with ESMTP id x0CLxld0000649;
        Sat, 12 Jan 2019 13:59:47 -0800
X-Authentication-Warning: connie.slackware.com: rworkman owned process doing -bs
Date:   Sat, 12 Jan 2019 13:59:47 -0800 (PST)
From:   Robby Workman <rworkman@slackware.com>
To:     Daniel Kahn Gillmor <dkg@fifthhorseman.net>
cc:     linux-modules@vger.kernel.org
Subject: Re: [kmod] Fix typo
In-Reply-To: <20190112172219.13152-1-dkg@fifthhorseman.net>
Message-ID: <alpine.LNX.2.02.1901121358590.612@connie.slackware.com>
References: <20190112172219.13152-1-dkg@fifthhorseman.net>
User-Agent: Alpine 2.02 (LNX 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Sat, 12 Jan 2019, Daniel Kahn Gillmor wrote:

> ---
> man/modprobe.d.xml | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/man/modprobe.d.xml b/man/modprobe.d.xml
> index 47878e2..211af84 100644
> --- a/man/modprobe.d.xml
> +++ b/man/modprobe.d.xml
> @@ -63,7 +63,7 @@
>       module commands as underscore conversion happens automatically.
>     </para>
>     <para>
> -      The format of and files under <filename>modprobe.d</filename> is
> +      The format of files under <filename>modprobe.d</filename> is
>       simple: one command per line, with blank lines and lines starting
>       with '#' ignored (useful for adding comments).  A '\' at the end
>       of a line causes it to continue on the next line, which makes the
> -- 
> 2.20.1
>

I *think* that was supposed to be "of any files" when it was originally
typed, but either works, I suppose :-)

-RW
