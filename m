Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CEE1EB64D9
	for <linux-modules@archiver.kernel.org>; Mon, 10 Jul 2023 05:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjGJFnK (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 10 Jul 2023 01:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjGJFnI (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 10 Jul 2023 01:43:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94422E5;
        Sun,  9 Jul 2023 22:43:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 311611F88C;
        Mon, 10 Jul 2023 05:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1688967782; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QTUCd5bhRzZqL696Dl4zEq9/KAElJc5NIHYqYWy4AGw=;
        b=XYXfFF8qZg9n7PDMOFDNbSn9kF7hlvTlbOh/YbfOBZ2hZelht0N7/xqiKqmzHfxlkSUOPd
        e0kHu096r6zkGi/2cVV48k1IvMeWgt48plGf+nVn6jpW4Kt3RIazkGWcTuAEL8LMELzN3E
        mbKnVe273QamIMDBW4SzIDN/JGyKn+U=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0FEE41346D;
        Mon, 10 Jul 2023 05:43:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cJblAGaaq2QvQAAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 10 Jul 2023 05:43:02 +0000
Date:   Mon, 10 Jul 2023 07:43:01 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Jean Delvare <jdelvare@suse.de>, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: print module name on refcount error
Message-ID: <ZKuaZepw51Nriqr8@dhcp22.suse.cz>
References: <20230626123252.73dbc139@endymion.delvare>
 <ZJ9fvQZ4k+zFfXbN@bombadil.infradead.org>
 <ZKLRaq3pzzE2gfws@dhcp22.suse.cz>
 <ZKhf8bi/eBDhaihD@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKhf8bi/eBDhaihD@bombadil.infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Fri 07-07-23 11:56:49, Luis Chamberlain wrote:
> On Mon, Jul 03, 2023 at 03:47:22PM +0200, Michal Hocko wrote:
> > On Fri 30-06-23 16:05:33, Luis Chamberlain wrote:
> > [...]
> > > What prevents code from racing the free with a random module_put()
> > > called by some other piece of code?
> > 
> > Wouldn't be ref count a garbage already? How can you race when freeing
> > if module_put fail?
> 
> It could yes, ie, so this risks at all being junk.

Could you be more specific please? I still do not see a scenario where
module string name would be junk while refcount itself would be a valid
memory.

> So best IMHO is
> to tidy up all the get / puts and add respective tests to fix all
> this mess with proper messages as needed. My cursory review of the
> refcnt stuf is I see some races possible.

It would likely be better to use refcount_t instead of atomic_t.

> While I'd be happy to help debugging aids, adding accesses to random
> memory for a string seems more risk prone.

If there is really a scenario when module could be unloaded leaving
dangling struct module behind then we have a real problem as this is
exported to userspace IIRC. Not to mention module_get/put calls
modifying memory (UAF).
-- 
Michal Hocko
SUSE Labs
