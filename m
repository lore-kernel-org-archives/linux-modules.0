Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46242C74A5B
	for <linux-modules@archiver.kernel.org>; Thu, 23 Mar 2023 20:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjCWUA1 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 23 Mar 2023 16:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbjCWUA0 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 23 Mar 2023 16:00:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4198225E3F
        for <linux-modules@vger.kernel.org>; Thu, 23 Mar 2023 13:00:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1E0B628A0
        for <linux-modules@vger.kernel.org>; Thu, 23 Mar 2023 20:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D23E9C433D2;
        Thu, 23 Mar 2023 20:00:23 +0000 (UTC)
Date:   Thu, 23 Mar 2023 16:00:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Nick Alcock <nick.alcock@oracle.com>,
        linux-modules <linux-modules@vger.kernel.org>
Subject: Re: module_license tree refreshed against linux-next
Message-ID: <20230323160022.2e4331e9@gandalf.local.home>
In-Reply-To: <ZByr4Wpg+OHX93lf@bombadil.infradead.org>
References: <87mt46s8i3.fsf@esperi.org.uk>
        <ZBncDHaZfKEHAjGu@bombadil.infradead.org>
        <87r0tiqc6z.fsf@esperi.org.uk>
        <ZBuQOXi+my7bnXzR@bombadil.infradead.org>
        <87zg83mn75.fsf@esperi.org.uk>
        <ZByr4Wpg+OHX93lf@bombadil.infradead.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, 23 Mar 2023 12:43:29 -0700
Luis Chamberlain <mcgrof@kernel.org> wrote:

> On Thu, Mar 23, 2023 at 04:45:02PM +0000, Nick Alcock wrote:
> > [Cc:ed Steve because I think he wanted something like this]
> > 
> > % echo 1 > /sys/kernel/tracing/options/sym-unambiguous  
> 
> I'd like to really hear if Steven is really super excited about this or not.
> You keep saying he wants it, but I haven't him say it yet on the lists.

I'm not "super excited" but I'm also not against it. But I don't like the
option name.

Perhaps "sym-file" ?

Or does this happen only when there's more than one function? Either way,
let's try to come up with something other than "sym-unambiguous".

Thanks,

-- Steve

