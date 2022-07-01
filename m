Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13BEC43334
	for <linux-modules@archiver.kernel.org>; Fri,  1 Jul 2022 21:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiGAVyW (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 1 Jul 2022 17:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiGAVyV (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 1 Jul 2022 17:54:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C14B6F37D;
        Fri,  1 Jul 2022 14:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kwaV21aI98J9eQWnMTeGY4/ZCRsVEnaxnrHura0TvR0=; b=J6tNZrlo5hXk9SCHaMlucvUinC
        Gj0utyF0ftc2HMNo+NNQ7dcF3FRTw/BeYfL0Ef1QMF0fpuDG+nuZKfW+mQ+fD4qVg4u8LrDGelg3q
        IOOV5eJsVt8ChzS/qwtDZkZBQ9GRtqQQRv+NkptTQy4IxI+18n2kMwwbmmrAGZp0skPsW00OLXo7P
        3RBlLN3sqdZ2eUqrxeb4Z0nabCpbZ6bFHSUQQnQs5Pb2Vq98cxHcZ5h5/pUSPhp58DBj74zQcMuUZ
        0yp1STiTzrVimsk99B1bAU6WK21NoVvpYI1hunqFWq+7YCFnNqGojSccs8Ye4giYcJ2XhXpIpNT7q
        6DcJV3iA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o7Oah-0076wh-Cd; Fri, 01 Jul 2022 21:54:19 +0000
Date:   Fri, 1 Jul 2022 14:54:19 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org
Subject: Re: [PATCH v2] module: Add support for default value for module
 async_probe
Message-ID: <Yr9tC2TDVKiJVTgY@bombadil.infradead.org>
References: <20220604010101.719508-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220604010101.719508-1-saravanak@google.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Fri, Jun 03, 2022 at 06:01:00PM -0700, Saravana Kannan wrote:
> Add a module.async_probe kernel command line option that allows enabling
> async probing for all modules. When this command line option is used,
> there might still be some modules for which we want to explicitly force
> synchronous probing, so extend <modulename>.async_probe to take an
> optional bool input so that async probing can be disabled for a specific
> module.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---

Queued up thanks!

  Luis
