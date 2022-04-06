Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CD1C433F5
	for <linux-modules@archiver.kernel.org>; Wed,  6 Apr 2022 22:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiDFWXY (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 6 Apr 2022 18:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbiDFWXV (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 6 Apr 2022 18:23:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC11125585
        for <linux-modules@vger.kernel.org>; Wed,  6 Apr 2022 15:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ib85NRW2kD92MBUyWoM4smHEWGf1LHvQvfCyj+16iVo=; b=M09rnJxytHLfFvjVC3jf91vzPJ
        Tovmj3NJ4AcdATBUAqKvLQpPjRlnrqIhl2XGXKppU1xtFDvco2L6G3q7d0v6r9IhI3ZCg3eaMNv56
        chX5eZlcyQPYnyKD7nF+OB+SrnTZwJdr4E6T6vPMJ/R3sJkfvSXE1m800srRWpsRdzQ4JJupLqu7X
        xDL0kakQMvffn1BibS8HMMlzDPmyewLjvigHHCL/Cxn5vxhJaeEk9gisMLYHEaNnt9A1bu/pEBMQI
        VHq0Y3fOwDP3f0koST48QnjfB+bVL7vi3vhrktEfaWAuvAVy+IE6z4Hv8p1V8nBZrFeMA0YMFa8oX
        NP5fmUzA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ncE1j-0087gi-OT; Wed, 06 Apr 2022 22:21:23 +0000
Date:   Wed, 6 Apr 2022 15:21:23 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     linux-modules@vger.kernel.org
Subject: Re: [PATCH 3/4] modprobe: Move check for remove_holders to caller
Message-ID: <Yk4SY9vILxx450tY@bombadil.infradead.org>
References: <20220329090540.38255-1-lucas.demarchi@intel.com>
 <20220329090540.38255-5-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329090540.38255-5-lucas.demarchi@intel.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue, Mar 29, 2022 at 02:05:38AM -0700, Lucas De Marchi wrote:
> Do not mix the flags with and additional boolean from arguments.
> 
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
