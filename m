Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A92C4321E
	for <linux-modules@archiver.kernel.org>; Fri,  2 Dec 2022 12:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233631AbiLBMt0 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 2 Dec 2022 07:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbiLBMtQ (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 2 Dec 2022 07:49:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA5FDCBED;
        Fri,  2 Dec 2022 04:49:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58399622AC;
        Fri,  2 Dec 2022 12:49:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40171C433C1;
        Fri,  2 Dec 2022 12:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669985353;
        bh=INDT138p8bcV7m3f04Twlb3J2TTqgI+ElVJnf/BBk/4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ed5l3U3ZQEgVx1G4CH2CahS3+H68cRJwttunAxL9+/hYMMJtDx/PcWh+CnGKuDcYI
         uriyQ7iGHTVCL3dg9j23r3CkHT+EAiGalQMdGUWxRE7xsx2O81MvkrrOLcLthFTnwu
         hxNSoJRw63pw4/gspcmznS5geRiFWP72eksWrLFo=
Date:   Fri, 2 Dec 2022 13:49:09 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Allen Webb <allenwebb@google.com>
Cc:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v5 1/1] modules: add modalias file to sysfs for modules.
Message-ID: <Y4n0RWqSwDHVT+HA@kroah.com>
References: <CAJzde07w6U83U_63eaF0-6zaq0cOkaymuLb3CBZ++JQi+Y9JdA@mail.gmail.com>
 <20221201211630.101541-2-allenwebb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201211630.101541-2-allenwebb@google.com>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, Dec 01, 2022 at 03:16:30PM -0600, Allen Webb wrote:
> USB devices support the authorized attribute which can be used by

You don't mention USB in the subject line?

> user-space to implement trust-based systems for enabling USB devices. It
> would be helpful when building these systems to be able to know in
> advance which kernel drivers (or modules) are reachable from a
> particular USB device.
> 
> This information is readily available for external modules in
> modules.alias. However, builtin kernel modules are not covered. This
> patch adds a sys-fs attribute to both builtin and loaded modules

"sysfs"  No "-", that only goes in my last name :)

And as you added sysfs files, you have to also have Documentation/ABI/
entries that describe the new files.  Without that, this patch can't
even be considered for review :(

And maybe this should be a patch series and not just 1 patch?  Remember
a patch can only do "one logical thing", and you seem to be doing a lot
of different things in this single patch.

Would you be able to review this patch as-is if you were in our shoes?
Remember we deal with thousands of patches each week.

> exposing the matching rules in the modalias format for integration
> with tools like USBGuard.
> 
> Note that as written CONFIG_MODULES must be enabled.

What happens if CONFIG_MODULES is not enabled?  And why should that
matter?

thanks,

greg k-h
