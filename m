Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E361C433EF
	for <linux-modules@archiver.kernel.org>; Thu,  2 Jun 2022 19:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238470AbiFBTQ2 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 2 Jun 2022 15:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236417AbiFBTQZ (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 2 Jun 2022 15:16:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B84C2AC52;
        Thu,  2 Jun 2022 12:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=K9puZtQh3DSjWLLVJl6MnSNoRBK26dHjTFHK/ELQzZs=; b=JQaUP/wsbGX7hvRG+1cqGLHU9x
        bCZ+j259PCR74Foe8/X86Mr6nBldV1ftPO5k/6aq0sVLmuFUBNlbbEEOsLp54fXAzVuAL/qAPlDVu
        B1gvPuBM5ujHORlebn77fTpcNcK9bE6igkyTBY9GJN6kxqopAa4fZSbVa4n7bERCqowH0Ewhd6u2A
        FTd/xOPA2qSbiU1+vI+Z0Gldl+13nB397JV9xDj1/+5y2MTRFumFOavtpfU6qJxqX4NH/rV7e0nSd
        kHOataE+FzUH867Q7atDzhP0SzuBbx1IERwjtOkrA0RljR5Q/gysdz+YlR3aG4eqFGTrqtGj4vcJ1
        OFVJsjUg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwqIk-004377-92; Thu, 02 Jun 2022 19:16:10 +0000
Date:   Thu, 2 Jun 2022 12:16:10 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Saravana Kannan <saravanak@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Aaron Tomlin <atomlin@redhat.com>, cl@linux.com,
        mbenes@suse.cz, akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        void@manifault.com, atomlin@atomlin.com, allen.lkml@gmail.com,
        joe@perches.com, msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, pmladek@suse.com,
        daniel.thompson@linaro.org, hch@infradead.org,
        kernel-team@android.com
Subject: Re: [PATCH v1] module: Fix prefix for module.sig_enforce module param
Message-ID: <YpkMelZC+E5hKTw6@bombadil.infradead.org>
References: <20220322140344.556474-2-atomlin@redhat.com>
 <20220602035653.4167316-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602035653.4167316-1-saravanak@google.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed, Jun 01, 2022 at 08:56:52PM -0700, Saravana Kannan wrote:
> Commit cfc1d277891e ("module: Move all into module/") changed the prefix
> of the module param by moving/renaming files. A later commit also moves
> the module_param() into a different file, thereby changing the prefix
> yet again.
> 
> This would break kernel cmdline compatibility and also userspace
> compatibility at /sys/module/module/parameters/sig_enforce.
> 
> So, set the prefix back to "module.".
> 
> Cc: Aaron Tomlin <atomlin@redhat.com>
> Cc: mcgrof@kernel.org
> Cc: christophe.leroy@csgroup.eu
> Cc: cl@linux.com
> Cc: mbenes@suse.cz
> Cc: akpm@linux-foundation.org
> Cc: jeyu@kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-modules@vger.kernel.org
> Cc: void@manifault.com
> Cc: atomlin@atomlin.com
> Cc: allen.lkml@gmail.com
> Cc: joe@perches.com
> Cc: msuchanek@suse.de
> Cc: oleksandr@natalenko.name
> Cc: jason.wessel@windriver.com
> Cc: pmladek@suse.com
> Cc: daniel.thompson@linaro.org
> Cc: hch@infradead.org
> Fixes: cfc1d277891e ("module: Move all into module/")
> Signed-off-by: Saravana Kannan <saravanak@google.com>

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

Linus want to take this in or should I just queueu these up?

  Luis
