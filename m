Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB84AC6FD1C
	for <linux-modules@archiver.kernel.org>; Thu, 23 Mar 2023 23:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjCWXI0 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 23 Mar 2023 19:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCWXIZ (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 23 Mar 2023 19:08:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331E2769F
        for <linux-modules@vger.kernel.org>; Thu, 23 Mar 2023 16:08:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9A26628EE
        for <linux-modules@vger.kernel.org>; Thu, 23 Mar 2023 23:08:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9CDFC433D2;
        Thu, 23 Mar 2023 23:08:22 +0000 (UTC)
Date:   Thu, 23 Mar 2023 19:08:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules <linux-modules@vger.kernel.org>
Subject: Re: module_license tree refreshed against linux-next
Message-ID: <20230323190821.38b9c5af@gandalf.local.home>
In-Reply-To: <87v8irmcet.fsf@esperi.org.uk>
References: <87mt46s8i3.fsf@esperi.org.uk>
        <ZBncDHaZfKEHAjGu@bombadil.infradead.org>
        <87r0tiqc6z.fsf@esperi.org.uk>
        <ZBuQOXi+my7bnXzR@bombadil.infradead.org>
        <87zg83mn75.fsf@esperi.org.uk>
        <ZByr4Wpg+OHX93lf@bombadil.infradead.org>
        <20230323160022.2e4331e9@gandalf.local.home>
        <87v8irmcet.fsf@esperi.org.uk>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, 23 Mar 2023 20:38:02 +0000
Nick Alcock <nick.alcock@oracle.com> wrote:

> Oh the name is dreadful! Better name suggestions much appreciated.

And kernel developers are notorious at picking bad names.

> 
> > Perhaps "sym-file" ?  
> 
> ... Yes, except that it also decorates with built-in module names.
> 
> > Or does this happen only when there's more than one function? Either way,
> > let's try to come up with something other than "sym-unambiguous".  
> 
> It happens only when at least one symbol in a given (object file *
> built-in module) pair would be ambiguous with respect to some other
> symbol with the same name without being given at least one of those two.
> It's a bit hard to pack into a couple of words... sym-unique is even
> worse, sym-objname is deeply unclear (what's an objname?) sym-filenames
> maybe? The question really is what property users care about, and I was
> hoping it would be that with this option turned on you can always tell
> all symbols apart from all other symbols.

 sym-nodups ?

 sym-differentiate ?

I don't think sym-unique is worse than sym-unambigous

We could always put this question out to social media.

-- Steve
