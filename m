Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:12360 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750744AbaEISpJ (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Fri, 9 May 2014 14:45:09 -0400
Date: Fri, 9 May 2014 15:45:03 -0300
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
CC: linux-modules <linux-modules@vger.kernel.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Gustavo Sverzut Barbieri <barbieri@gmail.com>
Subject: Re: [PATCH] depmod: Make dependency loops be fatal
Message-ID: <20140509184502.GC584@intel.com>
References: <1399659299-31241-1-git-send-email-lucas.demarchi@intel.com>
 <CAJs94EbuDx4Wj4HEMjepc1s8a5oWKBp6Q1DOU53GuFx9RExCDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <CAJs94EbuDx4Wj4HEMjepc1s8a5oWKBp6Q1DOU53GuFx9RExCDg@mail.gmail.com>
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On Fri, May 09, 2014 at 10:25:09PM +0400, Matwey V. Kornilov wrote:
> 2014-05-09 22:14 GMT+04:00 Lucas De Marchi <lucas.demarchi@intel.com>:
> 
> > Since the beginning depmod just warned about dependency loops and upon
> > creation of modules.dep{,.bin} it skipped the modules that were part of
> > a loop. However just skipping the modules may come as a surprise to
> > kernel module developers: they will need to try to load the module (or
> > to pay attention to the log messages) to notice thavt the module has not
> > been put in the index. Also, differently from module-init-tools we were
> > not skipping modules that depend on modules with dependency loops,
> > leading to a segfault in depmod.
> >
> 
> Do I understand you correctly that your patch fails to create modules.dep

I'd say it avoids losing the previous, valid modules.dep.

> when there is at least one cycle? If so, I think it is too aggressive
> approach. Everything else besides the cycle remains functional. However,
> this would make developers put more attention to resolve the loops in
> different configurations.

This is what I'm arguing for... dependency loops are bugs in kernel
modules that should rather be fixed instead of papering over.

Btw, I don't think they are that common since we never received a bug
report about this in kmod. I'm open to people chiming in, claiming
otherwise.


-- 
Lucas De Marchi
