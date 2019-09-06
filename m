Return-Path: <SRS0=554M=XB=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541DEC43331
	for <linux-modules@archiver.kernel.org>; Fri,  6 Sep 2019 13:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F31D20842
	for <linux-modules@archiver.kernel.org>; Fri,  6 Sep 2019 13:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567776160;
	bh=F+5+j0hKHkPlII4mJBazwLBvW2FnavVO0cGYYhrJaCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CUx+fo1N7S6wWSCo9nJlYtjLGyXwf8kGiE2mfW6sCPUF8/+Oyh487DXHXgnX5mg5L
	 0C1txo9f912YsiogpMGwuNcGCJzUAB6yJnH/b1+H4LTKh67A1OxKpzTgIWxYqCUyvt
	 VmWkpJSCwGoKRD6eFs2mZYKsxao7XBaP1KGi2G50=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393266AbfIFNWj (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 6 Sep 2019 09:22:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:39576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389315AbfIFNWj (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Fri, 6 Sep 2019 09:22:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87B85206BB;
        Fri,  6 Sep 2019 13:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567776159;
        bh=F+5+j0hKHkPlII4mJBazwLBvW2FnavVO0cGYYhrJaCU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gdhwqgHzrty8ug0LWYyHfJC2LuFizBFsAeBK3mDDpX09UZEPGQm3nGIcMLNub3hNY
         oroBiG2qFlSBxjICeacuDwAmVt+uWN5fZZ3n+KBz3UsJFrvyN/lAcKZYqWu5M5r9cy
         yzonJ6LwGUOnNy40Yv71iisbzwzEBVXBgjO7A1HQ=
Date:   Fri, 6 Sep 2019 15:22:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Matthias Maennich <maennich@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        arnd@arndb.de, joel@joelfernandes.org, lucas.de.marchi@gmail.com,
        maco@android.com, sspatil@google.com, will@kernel.org,
        yamada.masahiro@socionext.com, linux-kbuild@vger.kernel.org,
        linux-modules@vger.kernel.org, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net
Subject: Re: [PATCH v5 10/11] usb-storage: remove single-use define for
 debugging
Message-ID: <20190906132236.GA4107@kroah.com>
References: <20180716122125.175792-1-maco@android.com>
 <20190906103235.197072-1-maennich@google.com>
 <20190906103235.197072-11-maennich@google.com>
 <20190906125942.GA31531@linux-8ccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906125942.GA31531@linux-8ccs>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Fri, Sep 06, 2019 at 02:59:42PM +0200, Jessica Yu wrote:
> +++ Matthias Maennich [06/09/19 11:32 +0100]:
> > USB_STORAGE was defined as "usb-storage: " and used in a single location
> > as argument to printk. In order to be able to use the name
> > 'USB_STORAGE', drop the definition and use the string directly for the
> > printk call.
> > 
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Matthias Maennich <maennich@google.com>
> 
> Greg, didn't you pick this patch up for usb-next already (for the 5.4
> merge window)? If that's the case, I could apply the series omitting
> this patch (once there are no more comments or complaints).

Yes, I already have this in my tree, but there's no problem with you
taking it in yours as I think it's needed for the one after this to
build properly.

git will handle it properly when merging :)

thanks!

greg k-h
