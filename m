Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB0FC43334
	for <linux-modules@archiver.kernel.org>; Sun,  3 Jul 2022 23:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbiGCXSq (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sun, 3 Jul 2022 19:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbiGCXSo (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sun, 3 Jul 2022 19:18:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F415FE9;
        Sun,  3 Jul 2022 16:18:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29366B80BEB;
        Sun,  3 Jul 2022 23:18:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E4DC341C6;
        Sun,  3 Jul 2022 23:18:38 +0000 (UTC)
Date:   Sun, 3 Jul 2022 19:18:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Aaron Tomlin <atomlin@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "cl@linux.com" <cl@linux.com>, "mbenes@suse.cz" <mbenes@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "void@manifault.com" <void@manifault.com>,
        "atomlin@atomlin.com" <atomlin@atomlin.com>,
        "allen.lkml@gmail.com" <allen.lkml@gmail.com>,
        "joe@perches.com" <joe@perches.com>,
        "msuchanek@suse.de" <msuchanek@suse.de>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>,
        "jason.wessel@windriver.com" <jason.wessel@windriver.com>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>,
        "hch@infradead.org" <hch@infradead.org>,
        Chuck Lever III <chuck.lever@oracle.com>
Subject: Re: [PATCH v11 09/14] module: Move kallsyms support into a separate
 file
Message-ID: <20220703191837.0157546d@gandalf.local.home>
In-Reply-To: <df94b5f9-764f-6334-f142-51773c3911bd@csgroup.eu>
References: <20220310102413.3438665-1-atomlin@redhat.com>
        <20220310102413.3438665-10-atomlin@redhat.com>
        <20220628000526.11c57cd8@gandalf.local.home>
        <20220628081906.jln2ombfej5473xi@ava.usersys.com>
        <Yr92YtG12f+II+ea@bombadil.infradead.org>
        <20220703083324.az24ou7nrngvp73v@ava.usersys.com>
        <20220703092305.1e5da4c2@rorschach.local.home>
        <20220703135708.kn535pdrqv24f7kn@ava.usersys.com>
        <20220703101344.59710a42@rorschach.local.home>
        <df94b5f9-764f-6334-f142-51773c3911bd@csgroup.eu>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Sun, 3 Jul 2022 17:58:15 +0000
Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

> When I started submitting Kernel patches years ago, I was given those 
> guidelines:
> - Always submit checkpatch clean patches.
> - Try to never modify the same line of code twice in a series.
> 
> Which implied to always fix codying Style while changing or moving code.

Yeah, I figured as much. I'll go back and read the coding style and see if
it mentions this. If not, it needs to be updated.

The exception is when you move code. Code moving should never have any
other changes to it, because it makes it much more difficult to know what
changed.

-- Steve
