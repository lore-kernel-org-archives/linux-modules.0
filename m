Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AA8C61DA4
	for <linux-modules@archiver.kernel.org>; Thu,  9 Mar 2023 20:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjCIU6K (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 9 Mar 2023 15:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjCIU6J (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 9 Mar 2023 15:58:09 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA2319F2B;
        Thu,  9 Mar 2023 12:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zceKrdyITtJ+tdJeVSz+INsZ8xQPZxjCEDK2Td9PBf8=; b=x4PpSZTh3M8fAYO5pAq45zenlx
        Tql6W3lAt5OTQpg2nzoQkW6xqmGfspp3AWM6HHb5LqbG6RcwPfy2v+49WsUD2NGxmAJ2as0rip2gN
        RWA8iAqpcxT6G8N/5LANGynWU8xkYwbXv6Z+QRrytmvLHiGgnETOiXRBpAR9Kyjk83GBsrgpYywLH
        dNStTCwPi1YHR+W2oHqbh4Q2hE/Qy6BZtKJ2ZMgh+cd6QT0dce+tvi0RzZS5iNrj9LX5hS+DCZtr9
        cY5MZlWtEOlAZPCVFvXsJNzSsw+6kz6PXlyOUo9FRrxy5hs14QuvwDhA3PQw3S4LGUmjWiLogfqrH
        kUOZadFg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1paNKv-00Bu1I-Jm; Thu, 09 Mar 2023 20:58:05 +0000
Date:   Thu, 9 Mar 2023 12:58:05 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
Cc:     Jason Baron <jbaron@akamai.com>, jim.cromie@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dyndbg: remove unused 'base' arg from
 __ddebug_add_module()
Message-ID: <ZApIXdMGACZJEwd2@bombadil.infradead.org>
References: <cover.1677612539.git.jbaron@akamai.com>
 <855201dc0204a1428a79d415c97df2b6e11c95c3.1677612539.git.jbaron@akamai.com>
 <CR22F969CUPF.1MU6YEMD6OE7W@vincent-arch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CR22F969CUPF.1MU6YEMD6OE7W@vincent-arch>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, Mar 09, 2023 at 07:31:21PM +0100, Vincenzo Palazzo wrote:
> > __ddebug_add_module() doesn't use the 'base' arg. Remove it.
> >
> > Cc: Jim Cromie <jim.cromie@gmail.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Tested-by: Jim Cromie <jim.cromie@gmail.com>
> > Signed-off-by: Jason Baron <jbaron@akamai.com>
> > ---
> 
> Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>

Tag applied, thanks.

  Luis
