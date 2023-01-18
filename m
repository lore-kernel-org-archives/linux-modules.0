Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69127C38147
	for <linux-modules@archiver.kernel.org>; Wed, 18 Jan 2023 15:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjARPHm (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 18 Jan 2023 10:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbjARPHi (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 18 Jan 2023 10:07:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3591A4AA;
        Wed, 18 Jan 2023 07:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=xhFVQwoO2lkjv9nSA2b817JkR90qQlSjNN6ZfOzjzd0=; b=pOKfESI7xIN2zuFLgcHfU7E+J6
        I6dzZsWXkpu4laeHuUhFIlCVEf3uhb/e5JxiHDAWTcqdJVCVagDuzi3TrAHCouwRUFKcwQ94WEI0M
        DJqtglvitIE0PO94WhXZsK0MuT5bRIFZUTeCSa4OwX+yXpMbMakT+HZIlW7cvk7CKD2zqSQAKl7Zk
        8PfNyN5qzZlyjP2w9CpfHh+LAScS/unEneETNJfcRE3Np3ys0WOtdZYFnJINgz4MTHFM+lbc/fvLe
        6Qik9F00/hV2RqZiajh/F32dkI8f/3hJ7I4pyF1utZk3wD2BZERs+WBNVQCvRBRupx0SKoY6JLSgg
        lSiEn69w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pIA26-0005bw-Tj; Wed, 18 Jan 2023 15:07:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DC77430012F;
        Wed, 18 Jan 2023 16:07:17 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 97A9420A60F37; Wed, 18 Jan 2023 16:07:17 +0100 (CET)
Date:   Wed, 18 Jan 2023 16:07:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Song Liu <song@kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "songliubraving@fb.com" <songliubraving@fb.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH/RFC] module: replace module_layout with module_memory
Message-ID: <Y8gLJYA3ibA8De58@hirez.programming.kicks-ass.net>
References: <20230106220959.3398792-1-song@kernel.org>
 <83941b74-7585-235b-ee54-3b127ca70d9e@csgroup.eu>
 <CAPhsuW6S8qJWFzSLpVf_4ZpyM0Cxty=-pS2_K=tgF52s95Zhag@mail.gmail.com>
 <CAPhsuW7+BG9wYaoD6EYH-jnWqX30JdgNr5_733sO-++SzR5v3w@mail.gmail.com>
 <154ed99c-5877-35f6-5e7d-9d7abada7d33@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <154ed99c-5877-35f6-5e7d-9d7abada7d33@csgroup.eu>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue, Jan 10, 2023 at 06:31:41AM +0000, Christophe Leroy wrote:
> Le 09/01/2023 à 21:51, Song Liu a écrit :

> > Do you mean one tree will cause addr_[min|max] to be inaccurate?
> > 
> 
> Yes at least. On powerpc you will have module text below kernel, 
> somewhere between 0xb0000000 and 0xcfffffff, and you will have module 
> data in vmalloc area, somewhere between 0xf0000000 and 0xffffffff.
> 
> If you have only one tree, any address between 0xc0000000 and 0xefffffff 
> will trigger a tree search.

The current min/max thing is tied to the tree because of easy update on
remove, but module-insert/remove is not a performance critical path.

So I think it should be possible to have {min,max}[TYPES] pairs.  Either
brute force the removal -- using a linear scan of the mod->list to find
the new bounds on removal.

Or overengineer the whole thing and use an augmented tree to keep that
many heaps in sync during the update -- but this seems total overkill.

The only consideration is testing that many ranges in
__module_address(), this is already 2 cachelines worth of range-checks
-- which seems a little excessive.

(also, I note that module_addr_{min,max} are unused these days)
