Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF3DC433EF
	for <linux-modules@archiver.kernel.org>; Wed,  6 Apr 2022 22:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiDFWYr (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 6 Apr 2022 18:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbiDFWYp (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 6 Apr 2022 18:24:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D0A1B84C2
        for <linux-modules@vger.kernel.org>; Wed,  6 Apr 2022 15:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LiK7NQuGaRbHYbcfUwQjLfzAVyXdZJag3bwkv+g58UI=; b=qdsL398/nBFk3PifsypENgCToG
        TwzBCbobYFoKvz1RTgDdBodOyLRBG9G1FKNwoyP6RGZsSnFk0R4WgBnj0Za+dPg0TtL4Nn8OUISr+
        zV1ahfKz3OV8f74tCW4C94F4H+TCcT8HjxeSsyNdAHJg4DpqvtytLJz+F2E8QF/0TX6VzMEobln4x
        TBAcRFqGzayCQ4Z3RqRvB+nqYs2umdVQBsUgmzgk1ldacNqeYUyBlQCN7BYWN9PpKfNN+N1BisDdf
        5QeaQziIMGFJ1kvl+DoTSkUtxBE83UuG50nVvseU9fYPtnxsTYXOllthA7Ok9gX9hRogiQx0MGl2s
        5WIpVu+A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ncE35-0087vG-SH; Wed, 06 Apr 2022 22:22:47 +0000
Date:   Wed, 6 Apr 2022 15:22:47 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     linux-modules@vger.kernel.org
Subject: Re: [PATCH 4/4] modprobe: Make rmmod_do_module() contain all the
 removal sequence
Message-ID: <Yk4St0mFuGCXzKtB@bombadil.infradead.org>
References: <20220329090540.38255-1-lucas.demarchi@intel.com>
 <20220329090540.38255-7-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329090540.38255-7-lucas.demarchi@intel.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue, Mar 29, 2022 at 02:05:40AM -0700, Lucas De Marchi wrote:
> Move the remaining part of the removal sequence dangling in
> rmmod_do_remove_module() to rmmod_do_module() so we can consider this
> function is the one controlling all the module removals.
> 
> While at it, add some comments about the removal order and normalize
> coding style in this function.
> 
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
