Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0658BC433EF
	for <linux-modules@archiver.kernel.org>; Sun,  3 Jul 2022 14:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbiGCOOs (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sun, 3 Jul 2022 10:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbiGCOOM (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sun, 3 Jul 2022 10:14:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA15E0;
        Sun,  3 Jul 2022 07:13:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9BFD6B80934;
        Sun,  3 Jul 2022 14:13:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 324D5C341CA;
        Sun,  3 Jul 2022 14:13:46 +0000 (UTC)
Date:   Sun, 3 Jul 2022 10:13:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, christophe.leroy@csgroup.eu,
        cl@linux.com, mbenes@suse.cz, akpm@linux-foundation.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, void@manifault.com,
        atomlin@atomlin.com, allen.lkml@gmail.com, joe@perches.com,
        msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, pmladek@suse.com,
        daniel.thompson@linaro.org, hch@infradead.org,
        Chuck Lever III <chuck.lever@oracle.com>
Subject: Re: [PATCH v11 09/14] module: Move kallsyms support into a separate
 file
Message-ID: <20220703101344.59710a42@rorschach.local.home>
In-Reply-To: <20220703135708.kn535pdrqv24f7kn@ava.usersys.com>
References: <20220310102413.3438665-1-atomlin@redhat.com>
        <20220310102413.3438665-10-atomlin@redhat.com>
        <20220628000526.11c57cd8@gandalf.local.home>
        <20220628081906.jln2ombfej5473xi@ava.usersys.com>
        <Yr92YtG12f+II+ea@bombadil.infradead.org>
        <20220703083324.az24ou7nrngvp73v@ava.usersys.com>
        <20220703092305.1e5da4c2@rorschach.local.home>
        <20220703135708.kn535pdrqv24f7kn@ava.usersys.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Sun, 3 Jul 2022 14:57:08 +0100
Aaron Tomlin <atomlin@redhat.com> wrote:

> Hi Steve,
> 
> I completely agree and noted.
> 
> > You even stated "no functional change" which was a lie. Converting
> > strlcpy() to strscpy() *is* a functional change!  
> 
> Understood.

Sorry about being harsh. It's something that was engrained in me when
doing kernel development, and something I found useful for all software
development.

Honestly, the hardest thing about kernel development is the review
process. The easier we can make reviewing, the better the code will be.

Cheers,

-- Steve
