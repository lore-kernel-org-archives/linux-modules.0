Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DCAC64EC7
	for <linux-modules@archiver.kernel.org>; Tue, 28 Feb 2023 20:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjB1US3 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 28 Feb 2023 15:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjB1US2 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 28 Feb 2023 15:18:28 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0699C14E97;
        Tue, 28 Feb 2023 12:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Md9JrtUu3xnfZLvaIIJNt8/gwSPrEeVyF+t3AXsCqrM=; b=hPOpvUmwE+GwgMNIE3/72oaneU
        p43UVVetRqWVxdG5BNG/nc9ExKYmcf/IqZVYIROwQVC/Hl5pnCcquA3qFbzyeJbKC89Esdwpo2q4E
        c7gE+L4mmYidlsG90i97Ux3sLGRGcp5ft3bYrgTvIc69W2Iugj2zTW8uZ8VPrq0EfHbwa5WJy37JN
        Czj3riJGPq8P48oxwo1OpxHBJU+biqO/Pd0JsdzGPSY7jf7iNlzmafWcc+9Jw10lPbz9cM6eEglgl
        fs+syII0Uubs+WtkTLny7PnA2Fhnoelboo4ZllTBrxNrtKwRNSzbv20WxUA+gPsxUlthoFNx0uUgj
        IQ+IhUNA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pX6Qa-00EBCk-UE; Tue, 28 Feb 2023 20:18:24 +0000
Date:   Tue, 28 Feb 2023 12:18:24 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Jason Baron <jbaron@akamai.com>
Cc:     jim.cromie@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org
Subject: Re: [PATCH v2 0/2] dyndbg: let's use the module notifier callback
Message-ID: <Y/5hkFJsRnAuoRBN@bombadil.infradead.org>
References: <cover.1677612539.git.jbaron@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1677612539.git.jbaron@akamai.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue, Feb 28, 2023 at 02:34:20PM -0500, Jason Baron wrote:
> Hi,
> 
> Jim Cromie hit a BUG() while toggling jump label branches in a module
> before they were properly initialized. This isn't currently an issue,
> but will be as part of his pending classmap series. Seems like we
> should covert to using module callback notifier for dynamic debug
> anyways. First patch is just a cleanup.
> 
> Link: https://lore.kernel.org/lkml/20230113193016.749791-21-jim.cromie@xxxxxxxxx/
> 
> Thanks,
> 
> -Jason
> 
> v2:
> -Fix: error: field 'dyndbg_info' has incomplete type
>  Reported-by: kernel test robot <lkp@intel.com>
>  Link: https://lore.kernel.org/oe-kbuild-all/202302190427.9iIK2NfJ-lkp@intel.com/
> -make ddebug_remove_module() static

Do you have tests to ensure no regressions have occurred? If so what
are they? If there are no tests, can you come up with some basic ones?

  Luis
