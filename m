Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A66C6FA82
	for <linux-modules@archiver.kernel.org>; Thu, 22 Sep 2022 17:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiIVRNv (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 22 Sep 2022 13:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbiIVRNg (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 22 Sep 2022 13:13:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A01103FCF
        for <linux-modules@vger.kernel.org>; Thu, 22 Sep 2022 10:13:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7E987B83945
        for <linux-modules@vger.kernel.org>; Thu, 22 Sep 2022 17:13:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF86BC433D6;
        Thu, 22 Sep 2022 17:13:23 +0000 (UTC)
Date:   Thu, 22 Sep 2022 13:14:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules <linux-modules@vger.kernel.org>
Subject: Re: kallmodsyms: just checking my expectations...
Message-ID: <20220922131425.5b3461cf@gandalf.local.home>
In-Reply-To: <87mtaricb5.fsf@esperi.org.uk>
References: <87mtaricb5.fsf@esperi.org.uk>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, 22 Sep 2022 17:49:50 +0100
Nick Alcock <nick.alcock@oracle.com> wrote:

> Just syncing up briefly after LPC: thanks ever so much for your
> attendance and amazingly helpful comments, the session worked because
> you were there :)
> 
> 
> So, I'm planning for the next version of the kallmodsyms patch series to
> have objfile disambiguation via {...} for otherwise-ambiguous symbols in
> the core kernel, but not yet in modules (because that's considerably
> trickier and can be incrementally added to a working kallmodsyms). I'll
> redo the cover letter to emphasise its role as a way to disambiguate all
> symbols from each other.
> 
> ... was there anything else? I can't recall anything else myself and my
> notes don't mention anything, but I could be wrong and I'd rather not
> waste your time with a patch posting that is doing the wrong thing.

Best just post the patch. My mind is lost for what was discussed ;-)

-- Steve
