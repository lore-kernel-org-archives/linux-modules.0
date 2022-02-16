Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5A2C433EF
	for <linux-modules@archiver.kernel.org>; Wed, 16 Feb 2022 18:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234757AbiBPSrv (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 16 Feb 2022 13:47:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiBPSru (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 16 Feb 2022 13:47:50 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE3BC3301
        for <linux-modules@vger.kernel.org>; Wed, 16 Feb 2022 10:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=maOo8rtBN9C4WDX89wKGvxYWLnjGhLdkAhp8E9iqJ9I=; b=YwOlGF0Lv82e/FKCULPdfRpWkJ
        nSaKSP6He+KRRp/xeQOM/odzJMbp55BzCKMQ3hnOzAaHKf7xEkgDrwyKJ7PsQtOQwO5Fs6H/Fb1FH
        kqj+uTs9/XRaYFjv0FJa8wZWMJ2B932GHRqpt3MPzDqJYqgg1oNr61g4OAIrCV1Xqv3WWZ4vZ5H17
        L4Ehp8KuL8jb2oYH7TBLaRUPSkZ4qcdzlBV1bq4ok6TuTt4aE3rbd3qKhCdSiOhJuQxGhamem0hLB
        MrNhXfZQfrlhzJJTp69rf/mAMOo3jCWX1kx0HStKBF4fVOQlnd2/otC76mdD6tB+0yjJ1Q1l6dY9m
        f0ILhdIA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nKPKy-0089eL-Qn; Wed, 16 Feb 2022 18:47:36 +0000
Date:   Wed, 16 Feb 2022 10:47:36 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     linux-modules@vger.kernel.org
Subject: Re: [PATCH 8/8] modinfo: Allow to force arg as module name
Message-ID: <Yg1GyO6wDQVtveQC@bombadil.infradead.org>
References: <20220216075533.185693-1-lucas.demarchi@intel.com>
 <20220216075533.185693-9-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216075533.185693-9-lucas.demarchi@intel.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue, Feb 15, 2022 at 11:55:33PM -0800, Lucas De Marchi wrote:
> With the new -m|--modname option it's possible to query the information about this (builtin):

Query what information?

> 	$ modinfo --modname crc32
> 	module explicitly:

explicitly seems a bit odd, its not clear if the information below
is because its a module or what. Maybe module details?

> 	name:           crc32
> 	filename:       (builtin)

You know a --is-built-in option might be nice while you're at it.
Unless we already have something like this on another tool.


Other than that:

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
