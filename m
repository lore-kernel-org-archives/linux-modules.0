Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBFAC43334
	for <linux-modules@archiver.kernel.org>; Fri, 15 Jul 2022 00:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbiGOAnY (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 14 Jul 2022 20:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiGOAnY (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 14 Jul 2022 20:43:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74B0491E3;
        Thu, 14 Jul 2022 17:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RL4a78mz5dcxQKx/h6CWF+hVgr1YJg/HzEyCO0H00p0=; b=22NYjQKf/yMyYzmGZS+w4AE+Si
        QWIN0PJWTS0QpXve8sbJkO78xFs08bKN4h8IyzRjvxXZR/Zj330AIV0AGaJHFTHtYygQtsKuwdF9O
        tEIcCX+PGoxEDFQalmE1gdQZ1f2fvbv9T9lSHw3U0p0ZJ4iXWfdDXkR9JViMkUwUM+5jFTh7FrTQ8
        k36845mcCcMWpj0NkIfqhpNMOCNty8riycMh2hBdDnbBRVAe9QjNglY0RGeAllUtgCZHrmyal4Qpa
        zgcXZ3p2Vtlve5aNQcQk1EFcJ11gdC7jf9ZW9efZIjUC35TLPOuRbooLnjQhVXtws5Tgh5dS7WJog
        DaD65xkQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oC9QL-002owg-Kw; Fri, 15 Jul 2022 00:43:17 +0000
Date:   Thu, 14 Jul 2022 17:43:17 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, atomlin@atomlin.com,
        oleksandr@natalenko.name, neelx@redhat.com
Subject: Re: [PATCH v2 0/3] module: Show the last unloaded module's taint
 flag(s)
Message-ID: <YtC4JWQqG8gOYlad@bombadil.infradead.org>
References: <20220714153933.2095776-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714153933.2095776-1-atomlin@redhat.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, Jul 14, 2022 at 04:39:30PM +0100, Aaron Tomlin wrote:
> Hi Luis, Christophe,
> 
> In addition to the previous iteration, since this particular series does
> indeed modify last_unloaded_module, I decided to use strscpy() as a
> replacement for the now deprecated strlcpy().

Nice, looks super clean now, applied and pushed to modules-next, thanks!
BTW since you and Christophe seem to contribute a lot to modules lately,
any chance for future stuff you can ask 0day folks to add your trees
and branches to get tested prior to posting patches? Then you can
suggest in your cover letter they've been blessed by 0-day or whatever.

Typically I push to modules-testing, wait and if no complaints come back
then I push to modules-next but in this case I just went to
modules-next directly as I couldn't see how this could break.

  Luis
