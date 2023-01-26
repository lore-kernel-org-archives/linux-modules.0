Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80065C05027
	for <linux-modules@archiver.kernel.org>; Thu, 26 Jan 2023 06:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjAZGNc (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 26 Jan 2023 01:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjAZGNb (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 26 Jan 2023 01:13:31 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99441BAF9;
        Wed, 25 Jan 2023 22:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BehbOmePOSoauc26KOEYq2rdGF1nzlM8sK4yXo0PJvo=; b=33wfUfmv9Eo29dCd2AIRlvvhEE
        WTxaeCLwPIIRCuVn3YcWn4bEAYFgmbWwjP21Qu/pal3PYF2ZFynouJdSyG0l0XvYjpE7yRF8sQ5wm
        Z7n6SoY1B98pB0oiQcrPqMdfjFJPwSdx3HVZzuqdN4nC7zWgGvRDF4UNXE/QKH4kqaG2nFei+u4ul
        Q11kGofcGNW5v0n/ELYaLU3sGPHaTxL7QtAU2/s9bOI5TFfVTXI76o33p7ZUCLqLdnkLRwh3bV4HL
        W7L8KxOR9/9NW4WVkUD/1ddYapSiIPX1Q3huKZBwo8QMNOmEGhzp9+DXgkwyI5cnGBA5zsi9ZINa0
        aM6AieFg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKvVo-009ind-IF; Thu, 26 Jan 2023 06:13:28 +0000
Date:   Wed, 25 Jan 2023 22:13:28 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] module: replace module_layout with module_memory
Message-ID: <Y9IaCEj+lbKf9FPW@bombadil.infradead.org>
References: <20230125185004.254742-1-song@kernel.org>
 <Y9IYTI3pWuKbJ3bC@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9IYTI3pWuKbJ3bC@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed, Jan 25, 2023 at 10:06:04PM -0800, Luis Chamberlain wrote:
> I'll queue this onto modules-testing to see what blows up. After at
> least one more review I'll queue this onto modules-next.

I had to manually address a small conflict on modules-next, for your next spin,
can you base it on modules-next [0]?

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=modules-next

  Luis
