Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:48657 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754353AbaEISu4 (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Fri, 9 May 2014 14:50:56 -0400
Received: by mail-la0-f44.google.com with SMTP id hr17so169844lab.17
        for <linux-modules@vger.kernel.org>; Fri, 09 May 2014 11:50:55 -0700 (PDT)
Message-ID: <536D2389.7060800@gmail.com>
Date: Fri, 09 May 2014 22:50:49 +0400
From: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
MIME-Version: 1.0
To: Lucas De Marchi <lucas.demarchi@intel.com>
CC: linux-modules <linux-modules@vger.kernel.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Gustavo Sverzut Barbieri <barbieri@gmail.com>
Subject: Re: [PATCH] depmod: Make dependency loops be fatal
References: <1399659299-31241-1-git-send-email-lucas.demarchi@intel.com> <CAJs94EbuDx4Wj4HEMjepc1s8a5oWKBp6Q1DOU53GuFx9RExCDg@mail.gmail.com> <20140509184502.GC584@intel.com>
In-Reply-To: <20140509184502.GC584@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

09.05.2014 22:45, Lucas De Marchi пишет:
>> Do I understand you correctly that your patch fails to create modules.dep
> 
> I'd say it avoids losing the previous, valid modules.dep.

When building an RPM package, we don't have the previous one.

> This is what I'm arguing for... dependency loops are bugs in kernel
> modules that should rather be fixed instead of papering over.
> 
> Btw, I don't think they are that common since we never received a bug
> report about this in kmod. I'm open to people chiming in, claiming
> otherwise.

How about introducing --force switch or something like that to alter the
behavior in runtime?

For instance, the default is to fail, but with --force is to omit looped
modules.

