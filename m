Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0EEC38142
	for <linux-modules@archiver.kernel.org>; Tue, 31 Jan 2023 16:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjAaQLG (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 31 Jan 2023 11:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjAaQLG (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 31 Jan 2023 11:11:06 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D373415CBC;
        Tue, 31 Jan 2023 08:11:04 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675181463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mNOcDiyXlT45QhUxzQkdW7EXh4xtrNhLHK+psPr4Er4=;
        b=p57wiQGAy9I9coPv6o/oMUWk5UN9366THrAFSZFIGHwmY+R7xja/iAVFW+/RtvtgUr6oSs
        op4xUfr/P2vOGTh6VgrBHxEQA1d60lNLlvPou+2UMtrMUReQS9PpX2OFbAtxDyGlPWWMZV
        W9S3hSLXIRjNXj0Fdj52rvsQoyxRZxxbMUrtG4wtIMuuGyX4Gg6bDG9IQ1tWvMtPNjWBru
        pfalXSqsbf6f7Gwn/zEmyOBrLJwBO7etyraICiTrmBkCMycEuBPRfCHvPfa4QI4v75rHG3
        ZamI8Y4J35wZ6qZl/sw1CQb3aMF7r8rsVSGC0IKeehThRKnKFmvigdZfnCsnOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675181463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mNOcDiyXlT45QhUxzQkdW7EXh4xtrNhLHK+psPr4Er4=;
        b=xaeKKGMBx+9lC6pOAyMNRwUqY7WP3x6ehJBx5yosMrGYCn8lVpwoQphfqzbQY3nGcjbJ6O
        noVRWuNMcN6Ko+Bw==
To:     Peter Zijlstra <peterz@infradead.org>, Song Liu <song@kernel.org>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@lst.de, kernel-team@meta.com,
        Luis Chamberlain <mcgrof@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v4] module: replace module_layout with module_memory
In-Reply-To: <Y9j9Svys7eb9E2Mh@hirez.programming.kicks-ass.net>
References: <20230130182109.3571524-1-song@kernel.org>
 <Y9j9Svys7eb9E2Mh@hirez.programming.kicks-ass.net>
Date:   Tue, 31 Jan 2023 17:11:03 +0100
Message-ID: <87zg9yznu0.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue, Jan 31 2023 at 12:36, Peter Zijlstra wrote:
> On Mon, Jan 30, 2023 at 10:21:09AM -0800, Song Liu wrote:
>> This is the preparation work for the type aware module_alloc() discussed
>> in [1]. While this work is not covered much in the discussion, it is a
>> critical step of the effort.
>> 
>> As this part grows pretty big (~1000 lines, + and -), I would like get
>> some feedback on it, so that I know it is on the right track.
>> 
>> Please share your comments. Thanks!
>
> Aside from the things already reported I like where this is going.

Agreed.

        tglx
