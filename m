Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96270C4332F
	for <linux-modules@archiver.kernel.org>; Tue, 20 Dec 2022 06:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbiLTGnt (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 20 Dec 2022 01:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiLTGns (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 20 Dec 2022 01:43:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85D4633E;
        Mon, 19 Dec 2022 22:43:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 935E1B8119F;
        Tue, 20 Dec 2022 06:43:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7DF7C433D2;
        Tue, 20 Dec 2022 06:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1671518625;
        bh=UhLL8h5zs+hGvnfbkW1uimiuM1ZwwKGebV/hZnfz8Do=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H0rgEDi4V0Aj+IFQtKDAfTQDjpTxIB0wtu0MGXtX/KRwPoSH0/k6nUhHm6B8yPiMd
         Jq/YCaUy9DFEc7UYtAbsIBWPxVDCrZagEeOu55eaJkhMRKZ/cnXvwo/nEvWYR3Hg4B
         xX7oLlTGTRaw9mVmqjODrDHZQgbrgHkDH9reb2io=
Date:   Tue, 20 Dec 2022 07:43:42 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Allen Webb <allenwebb@google.com>
Cc:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v9 07/10] modpost: Add -b option for emitting built-in
 aliases
Message-ID: <Y6FZniRwpogJ0HaG@kroah.com>
References: <20221219191855.2010466-1-allenwebb@google.com>
 <20221219204619.2205248-1-allenwebb@google.com>
 <20221219204619.2205248-8-allenwebb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219204619.2205248-8-allenwebb@google.com>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Mon, Dec 19, 2022 at 02:46:15PM -0600, Allen Webb wrote:
> This adds an unimplemented command line flag for writing the built-in
> aliases to a file.

If it is unimplemented, why add it?

And this needs a lot more description as to why you are changing this
here, as well as documentation for the flag you added, right?

thanks,

greg k-h
