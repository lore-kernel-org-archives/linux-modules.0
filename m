Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2ECEC7EE23
	for <linux-modules@archiver.kernel.org>; Thu,  1 Jun 2023 21:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbjFAVkX (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 1 Jun 2023 17:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbjFAVkO (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 1 Jun 2023 17:40:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA8EE6A
        for <linux-modules@vger.kernel.org>; Thu,  1 Jun 2023 14:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=riDvnY73TWqcpif9Um1bOq/6HKpnvgYsBgy/YLLW4f4=; b=VKIsmPq09fyMDkl6RqHl6f/KZC
        CZ+yzEC1M9bB1NIv+7Vsia2QyBf4HCD9Ph7P1S5UobiL4IG4PIUNfAukulx+aIfjc83mn1kd/flCY
        g8EGv1fhCr/lYFkyKBDehLUK0lOMt81OG1oMSsTaA8AuupFBsgbecJJlnj/JmUX0rZ/WjElU36Qee
        WcN3NAdUKN18YBzZYmsUM6t4NuXZuYS8GYnv452r7p+UbvcwvvKp4X22Cu1jaehWG+G6PpqOBZtk4
        brziMqpVS8cc7+5/nwaFmCGrwLq2slBw77iPRoGPyQJQtbI8mYcWppPfBW+fNV5H8eviR6By12OAk
        EPAzNvwQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q4q1d-0051bv-2K;
        Thu, 01 Jun 2023 21:40:05 +0000
Date:   Thu, 1 Jun 2023 14:40:05 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     linux-modules@vger.kernel.org, stable@kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH] module/decompress: Fix error checking on zstd
 decompression
Message-ID: <ZHkQNQK5zrzo4Cq2@bombadil.infradead.org>
References: <20230601212331.567483-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601212331.567483-1-lucas.demarchi@intel.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, Jun 01, 2023 at 02:23:31PM -0700, Lucas De Marchi wrote:
> While implementing support for in-kernel decompression in kmod,
> finit_module() was returning a very suspicious value:
> 
> 	finit_module(3, "", MODULE_INIT_COMPRESSED_FILE) = 18446744072717407296
> 
> It turns out the check for module_get_next_page() failing is wrong,
> and hence the decompression was not really taking place. Invert
> the condition to fix it.
> 
> Fixes: 169a58ad824d ("module/decompress: Support zstd in-kernel decompression")
> Cc: stable@kernel.org
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>

Applied and pushed, will send a pull to Linus right away, thanks!

  Luis
