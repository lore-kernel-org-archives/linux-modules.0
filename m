Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192F1C433EF
	for <linux-modules@archiver.kernel.org>; Fri, 22 Apr 2022 08:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445426AbiDVIY2 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 22 Apr 2022 04:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444942AbiDVIYV (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 22 Apr 2022 04:24:21 -0400
X-Greylist: delayed 585 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 22 Apr 2022 01:21:29 PDT
Received: from gentwo.de (gentwo.de [IPv6:2a02:c206:2048:5042::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABB652B0D
        for <linux-modules@vger.kernel.org>; Fri, 22 Apr 2022 01:21:29 -0700 (PDT)
Received: by gentwo.de (Postfix, from userid 1001)
        id 740E9B00798; Fri, 22 Apr 2022 10:11:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 72A4FB00100;
        Fri, 22 Apr 2022 10:11:38 +0200 (CEST)
Date:   Fri, 22 Apr 2022 10:11:38 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
To:     Aaron Tomlin <atomlin@redhat.com>
cc:     Oleksandr Natalenko <oleksandr@natalenko.name>, mcgrof@kernel.org,
        pmladek@suse.com, mbenes@suse.cz, christophe.leroy@csgroup.eu,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, atomlin@atomlin.com,
        ghalat@redhat.com, neelx@redhat.com
Subject: Re: [PATCH v3 2/2] module: Introduce module unload taint tracking
In-Reply-To: <20220421145757.zfn6zxh6rx3dp75o@ava.usersys.com>
Message-ID: <alpine.DEB.2.22.394.2204221009390.1397495@gentwo.de>
References: <20220420115257.3498300-1-atomlin@redhat.com> <20220420115257.3498300-3-atomlin@redhat.com> <2100545.irdbgypaU6@natalenko.name> <20220421145757.zfn6zxh6rx3dp75o@ava.usersys.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, 21 Apr 2022, Aaron Tomlin wrote:

> > > +		if (len == strlen(mod->name) && !memcmp(mod_taint->name, mod->name, len) &&
> >
> > Here, two strings are compared, so I'd expect to see `strncmp()` instead of `memcmp()`.
>
> Good point. There are other examples of this throughout
> kernel/module/main.c; albeit, I will use strncmp() here.

Comparing the length first may be an attempt to avoid the expensive
memcmp. But here we need to first execute strlen() to obtain the string
length. This is already accessing all characters so this
check is wasteful and a straight str[n]cmp is better.

