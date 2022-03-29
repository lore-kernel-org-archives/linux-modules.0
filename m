Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6AFC433EF
	for <linux-modules@archiver.kernel.org>; Tue, 29 Mar 2022 19:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiC2Tjd (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 29 Mar 2022 15:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238235AbiC2Tjb (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 29 Mar 2022 15:39:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A05EB7C6B
        for <linux-modules@vger.kernel.org>; Tue, 29 Mar 2022 12:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Tgz5HJr73kqmVLtUy5C3nCmPQjaFxTPqPUUaFnygag4=; b=CGigp32Ph8CRMEQPWqr50c07KG
        xs4fn4BgDV/A6Hi9eKN1oyqhhM0CHk4BcO7JrF8076Y4pL10jllWJRKhUw7ZU4QO49Qnp+IZspr8x
        HHK8fZP+dxTE9E30ldU1MGW5xWr3kfKt5tCD0X2ezlJqHJAfNiHavnW8ntBmwoFlYovBxUYxXCwSa
        jE9uGmgc105AzFjDZRCq/ApLGvNGQ2mLlDl9VEgbKrY4Vuiw6enKJzGatL69Mk+t/U6xBnGo2NqtW
        YRzcCFhgFnMRXHe567tFbr7OwcCku+o3ShWLb/rWj7LJfZc3iVY6QL6OuMFJk8wF1UJU1XbIXzWXF
        2rsCur8w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZHf0-00DMmg-Og; Tue, 29 Mar 2022 19:37:46 +0000
Date:   Tue, 29 Mar 2022 12:37:46 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     linux-modules@vger.kernel.org
Subject: Re: [PATCH 1/4] modprobe: Rename rmmod_do_deps_list
Message-ID: <YkNgCm+l1pZRtfCA@bombadil.infradead.org>
References: <20220329090540.38255-1-lucas.demarchi@intel.com>
 <20220329090540.38255-2-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329090540.38255-2-lucas.demarchi@intel.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue, Mar 29, 2022 at 02:05:35AM -0700, Lucas De Marchi wrote:
> It's used not only for dependencies, but also for pre and post softdep.
> 
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
