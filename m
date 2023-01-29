Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B55C61D97
	for <linux-modules@archiver.kernel.org>; Sun, 29 Jan 2023 02:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjA2Cay (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sat, 28 Jan 2023 21:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjA2Cax (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sat, 28 Jan 2023 21:30:53 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6E5234C3;
        Sat, 28 Jan 2023 18:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zA38YMzjpalk5LMI/syb7IIPcIWJIaeVFFL9YzUdJWw=; b=qaPG+KfCNoXPyS9+3Oy7TM2F04
        Nejzniaw6RdAeUqJb+GNMGRLTYxevKwY2aUSTIZ4LRR8nWWUa2mYlUBN0Vpc9O3zwWnyMlZxFsJFP
        w9wTMUYON+g8VezA4cnanlahejw+wDb1zPUVYTCpoPruqc3TvBhZ3Szf+2338yUIZxo/CeIEUVCDy
        JwUIyavipCfoQIWM3NEG0k1uSEoA/ZKkg3utH0PknOCNwBpnc96VkzETPo2k83bsLvEStlHganyXS
        X3HOeUltcRcAM34IVNbPpYqeENnKq+zqf2Ogx3zYi7glp1kofFzalRuaS3TyYMKIAfUa4b1vIhShh
        CB9ZIk4w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pLxSw-000ucg-5K; Sun, 29 Jan 2023 02:30:46 +0000
Date:   Sat, 28 Jan 2023 18:30:46 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Song Liu <song@kernel.org>, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3] module: replace module_layout with module_memory
Message-ID: <Y9XaVtrNOxTGRJMJ@bombadil.infradead.org>
References: <20230126233606.1317794-1-song@kernel.org>
 <20230127204011.GA45594@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127204011.GA45594@roeck-us.net>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Fri, Jan 27, 2023 at 12:40:11PM -0800, Guenter Roeck wrote:
> That is the only failure reported by my test system.

I thought your rig does some form of boot / runtime tests too?

  Luis
