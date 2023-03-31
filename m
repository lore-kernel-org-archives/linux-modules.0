Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FB2C76196
	for <linux-modules@archiver.kernel.org>; Fri, 31 Mar 2023 07:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjCaHAG (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 31 Mar 2023 03:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjCaHAD (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 31 Mar 2023 03:00:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4EAAD0D;
        Fri, 31 Mar 2023 00:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=osScnoo8TL5BiOd6R4ozuuVkhPFMoQ4zL9oQF6cBOEg=; b=YfTBVGvRE/RvvQntBfCYvHiytP
        mTByV3+JpT4EdI5LcIvhbGKNhUb5PQcVE/AwquTEc6OnM2khM3YxCmXQqIwdPaT1t/JM+1KdstCDw
        iwSnG3G+9dBkGi1tyH3hb3O4rSbWql//abWBDaqTQFmhEQ9+GkMZkDOckouf31b2wPF/UzoK36UNe
        KwhV2FAxP6O4DaITuBhs4Oj5NivtBZmI7MZMTlqZ+mmabQlwl/joD/4WQAmICVV0HZkXpBKpK3ojw
        nEE/iIesu9W0nMh5cGX94MPAkllgxbZ/pmUzXz4LPJVRTeAGcEQJZtJ8qk3b9D6HmL8oWUaygo8bc
        Vw8LglQQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pi8jv-0065y8-1n;
        Fri, 31 Mar 2023 06:59:59 +0000
Date:   Thu, 30 Mar 2023 23:59:59 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     jim.cromie@gmail.com
Cc:     linux-modules@vger.kernel.org, song@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: kmemleaks on ac3b43283923 ("module: replace module_layout with
 module_memory")
Message-ID: <ZCaE71aPvvQ/L05L@bombadil.infradead.org>
References: <CAJfuBxwomDagbdNP-Q6WvzcWsNY0Z2Lu2Yy5aZQ1d9W7Ka1_NQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfuBxwomDagbdNP-Q6WvzcWsNY0Z2Lu2Yy5aZQ1d9W7Ka1_NQ@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, Mar 30, 2023 at 04:45:43PM -0600, jim.cromie@gmail.com wrote:
> hi Luis, etal
> 
> kmemleak is reporting 19 leaks during boot
> 
> because the hexdumps appeared to have module-names,
> and Ive been hacking nearby, and see the same names
> every time I boot my test-vm, I needed a clearer picture
> Jason corroborated and bisected.
> 
> the 19 leaks split into 2 groups,
> 9 with names of builtin modules in the hexdump,
> all with the same backtrace
> 9 without module-names (with a shared backtrace)
> +1 wo name-ish and a separate backtrace

Song, please take a look.

Thanks for the report Jim, what kernel are you on exactly?

  Luis
