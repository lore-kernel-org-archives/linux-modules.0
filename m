Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF65DC433F5
	for <linux-modules@archiver.kernel.org>; Wed, 23 Mar 2022 22:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241415AbiCWWGY (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 23 Mar 2022 18:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238850AbiCWWGX (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 23 Mar 2022 18:06:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A225C657;
        Wed, 23 Mar 2022 15:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qz8Mrr1vvhIviVxzytKKgxEzTZ2ALl7zs8j2iG5kO0M=; b=oBwC1VYqseknEAhNxuaF2RgJjh
        aMuVDBkNx/nU5HXhdC9WG1APPv9tbIGs0J91Cmw2OVSB+2LQyCtilNsK6CjNv62FUOkTXwjSfYPM5
        xOm5TW2LBsp/HJj8rd3clV5WMrAU0rYrxcC1HX3gLQlL0fEtoq+SBWGeXs3mlW9Fhvc9ptdxF0od1
        iecMADrl1pp48+Gu/VhXMXoBPRwBtAIzDAAYHZHJY7vCU+mKXb/Tgf9clk3Hj71wBbmK5mPzu812f
        M6M1FVbqjGKw8LNolDrT2lIdHdgwBADXu5qIFL7cshh9SqpRmE8kErVGIsACADZa349Hy2KdPVTLK
        0EfFhg/Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nX95f-00EvDT-6D; Wed, 23 Mar 2022 22:04:27 +0000
Date:   Wed, 23 Mar 2022 15:04:27 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Maninder Singh <maninder1.s@samsung.com>, akpm@linux-foundation.org
Cc:     pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        wangkefeng.wang@huawei.com, v.narang@samsung.com,
        swboyd@chromium.org, ojeda@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        avimalin@gmail.com, atomlin@redhat.com, keescook@chromium.org,
        ndesaulniers@google.com, rdunlap@infradead.org, void@manifault.com
Subject: Re: [PATCH 1/1 module-testing] kallsyms: enhance %pS/s/b printing
 when KALLSYSMS is disabled
Message-ID: <YjuZa8Jd2+gpiM3J@bombadil.infradead.org>
References: <CGME20220323164758epcas5p2d98f696230aaa5e2d6a8820bc2f13f0c@epcas5p2.samsung.com>
 <20220323164742.2984281-1-maninder1.s@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323164742.2984281-1-maninder1.s@samsung.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed, Mar 23, 2022 at 10:17:42PM +0530, Maninder Singh wrote:
> ---
> module-next -> module-testing: Petr's review and test tag is picked from previous version,
> current version has slight changes (module.c -> module/main.c). No functional change in patch,
> only init_build_id() function is moved to module/main.c as it can be independent of
> kallsyms.

Andrew,

I see this patch is merged on your tree, any chance we can yield until
the next release and I can then take it under modules-next ? It would
help given the slew of changes I now have queued up not for v5.18 but
for v5.19. I'm delaying the modules changes for v5.19 given the timing,
it is too soon to merge for v5.18 as I want tons of testing on this
all on linux-next after v5.18-rc1 is out.

  Luis
