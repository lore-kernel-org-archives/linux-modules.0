Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298AAEB64DC
	for <linux-modules@archiver.kernel.org>; Mon,  3 Jul 2023 13:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjGCNr0 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 3 Jul 2023 09:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjGCNrZ (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 3 Jul 2023 09:47:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB37109;
        Mon,  3 Jul 2023 06:47:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 706231FE05;
        Mon,  3 Jul 2023 13:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1688392043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9+N0VjVRFE1zzVTBOOOhUhNg8OhdkcIpMNa/toTvU6g=;
        b=pUhlzrK+n0mvTNUhJACawFkzwc0mc0Xi2brODsJVWEkNx3xMYnqZS7b2rCdSMr6OkvOG5j
        zkRBlHxA4AozbCnGdJDmFZD7UQArFQHyyfiwcsjtJm+pck058/7JJRwqm55iFB4edz7ejQ
        xL3bDDlnnD9XBd8xpwpVp40SZYYYg+M=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2542C13276;
        Mon,  3 Jul 2023 13:47:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Bx4TB2vRomTHJgAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 03 Jul 2023 13:47:23 +0000
Date:   Mon, 3 Jul 2023 15:47:22 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Jean Delvare <jdelvare@suse.de>, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: print module name on refcount error
Message-ID: <ZKLRaq3pzzE2gfws@dhcp22.suse.cz>
References: <20230626123252.73dbc139@endymion.delvare>
 <ZJ9fvQZ4k+zFfXbN@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJ9fvQZ4k+zFfXbN@bombadil.infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Fri 30-06-23 16:05:33, Luis Chamberlain wrote:
[...]
> What prevents code from racing the free with a random module_put()
> called by some other piece of code?

Wouldn't be ref count a garbage already? How can you race when freeing
if module_put fail?
-- 
Michal Hocko
SUSE Labs
