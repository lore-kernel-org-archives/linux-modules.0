Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:38864 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762722Ab3ECGcs (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Fri, 3 May 2013 02:32:48 -0400
Message-ID: <1367562763.9430.3.camel@jlt4.sipsolutions.net>
Subject: Re: [PATCH] modprobe: don't check refcount with remove command
From: Johannes Berg <johannes@sipsolutions.net>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-modules <linux-modules@vger.kernel.org>,
	david.spinadel@intel.com
Date: Fri, 03 May 2013 08:32:43 +0200
In-Reply-To: <CAMOw1v7cpGCxWKOstCf-h6mMVe9Op18BU-E_nvR4FnKmedrHgA@mail.gmail.com> (sfid-20130503_044803_937283_B0C7BBD1)
References: <1367501008-10459-1-git-send-email-johannes@sipsolutions.net>
	 <CAMOw1v7cpGCxWKOstCf-h6mMVe9Op18BU-E_nvR4FnKmedrHgA@mail.gmail.com>
	 (sfid-20130503_044803_937283_B0C7BBD1)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Hi Lucas,

> Thanks, patch has been applied.

Thanks.

> However.... I'd like to strongly advise not to use install/remove
> commands for simple dependencies like this. It's much simpler and
> faster both for kmod and for who is configuring to use softdeps. Your
> example could be very well replace with the single line below:
> 
> softdep fred pre: barney

Yes, however, I was just copying the man page example for illustration
purposes.

> I think we need a better explanation on man page and even remove this
> example from there. Install/remove commands are only there because of
> the legacy stuff that would stop working otherwise.

Makes sense. However, the use case we have for this is slightly
different, and not a simple dependency -- we have a bit of a reverse
dependency tree:

 modA1 and modA2 depend on modB

However, modB contains the driver struct, so modB is loaded first
automatically and pulls in either modA1 or modA2 depending on some other
information that can't be encoded in direct dependencies. Then, after
having loaded modB, you can't unload modB any more, and David noticed
that a configuration like

remove modB /sbin/rmmod modA1 modA2 modB

(actually it's a bit more complicated, but for no good reason I think)
no longer worked.

johannes

