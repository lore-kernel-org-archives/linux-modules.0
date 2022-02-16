Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96671C433F5
	for <linux-modules@archiver.kernel.org>; Wed, 16 Feb 2022 20:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbiBPU0v (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 16 Feb 2022 15:26:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbiBPU0p (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 16 Feb 2022 15:26:45 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB11FD3E
        for <linux-modules@vger.kernel.org>; Wed, 16 Feb 2022 12:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YGZLKorzkJ9+bxl/htH8R7Xt5McR28qYw6TZ+JyHW2E=; b=Z7JVU0QXKzjKIpBWwXbhOe+cwE
        fzEdwe5fbv6AW7HvBs1qQjXXA9osZ8JrOWidOUd7LlpR9f8daHZ41MhOTsphUqSmTvobr90p5wxZO
        BogfmNOmc4pHDoHPcUslCy9Yk3ADA8T4/Mgyn/CReYd6SLQUb6i3WODUQJgXt/ZhCkdWmtjAJ6wNx
        ARIsYMstWG+b88aNPAEC2vXPJEMbARNxz9OPRrt9UnbCvHyg2YAmxbF65ECiX/Wo54szLoYHVu12q
        B93MMvub563OEqiadZHDwgFi1suTBiYV1IcFTEHp49b/qKI9SdKNHPPOAg+movojQ5Hm3Z3LDej07
        HEsPk14w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nKQsf-008KKF-Pm; Wed, 16 Feb 2022 20:26:29 +0000
Date:   Wed, 16 Feb 2022 12:26:29 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     linux-modules@vger.kernel.org
Subject: Re: [PATCH 8/8] modinfo: Allow to force arg as module name
Message-ID: <Yg1d9VihEBqbhp0X@bombadil.infradead.org>
References: <20220216075533.185693-1-lucas.demarchi@intel.com>
 <20220216075533.185693-9-lucas.demarchi@intel.com>
 <Yg1GyO6wDQVtveQC@bombadil.infradead.org>
 <20220216195730.nixxq7qe7pelihhf@ldmartin-desk2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216195730.nixxq7qe7pelihhf@ldmartin-desk2>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed, Feb 16, 2022 at 11:57:30AM -0800, Lucas De Marchi wrote:
> On Wed, Feb 16, 2022 at 10:47:36AM -0800, Luis Chamberlain wrote:
> > 
> > You know a --is-built-in option might be nice while you're at it.
> > Unless we already have something like this on another tool.
> 
> to just check if a module is built-in or not?

Yup.

> Not sure if it would be in modinfo or modprobe (since modprobe
> historically got the -R to resolve an alias).

You would know better. But having that would be wonderful.

 Luis
