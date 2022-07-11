Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327F6C433EF
	for <linux-modules@archiver.kernel.org>; Mon, 11 Jul 2022 16:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiGKQJr (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 11 Jul 2022 12:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiGKQJq (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 11 Jul 2022 12:09:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B366F7F9;
        Mon, 11 Jul 2022 09:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jtFKKqFHXDZ7AsX4ox49Z0SbEvofYL729VB8Xo+YbJI=; b=UwStMCjPYyQ/BSpqwXMF14i8GT
        GvyLkf4jM2Y81JuHeICoDZtukHEP4rcTHMsN4P6paPsaBs8UkpCjNGEWIHY3phHP4PVvaMZAap94J
        wa5FyISOFw+3FsuxmtwbWm4IlqOyRgelg8A3H1JnOO07R+i5hgfglB7P0UegiHKP2bQiv2muypDAK
        QN6ww4Oo7ZMiA4joh/qpyVjwU0LZBe3fDOlS0MVY4zl81mFkXTCiDA+Fo7zwXEyBETKq0d/TArKbT
        AiAkEhqtBZqOFnzxuZWJi3/CbdrCR5WpYPCdUzrVtghB/VdjvqSg2jGB3lQ204ZboITAI+JLkD3/b
        M0DntlVw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oAvyj-0038Nx-So; Mon, 11 Jul 2022 16:09:45 +0000
Date:   Mon, 11 Jul 2022 09:09:45 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org
Subject: Re: [PATCH -next] module: Use vzalloc() instead of
 vmalloc()/memset(0)
Message-ID: <YsxLSSXC3yjvXEx8@bombadil.infradead.org>
References: <20220704120337.4119910-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704120337.4119910-1-yangyingliang@huawei.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Mon, Jul 04, 2022 at 08:03:37PM +0800, Yang Yingliang wrote:
> Use vzalloc() instead of vmalloc() and memset(0) to simpify the code.
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Thanks! Queued onto modules-next.

  Luis
