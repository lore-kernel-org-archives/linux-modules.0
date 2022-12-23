Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0759C4332F
	for <linux-modules@archiver.kernel.org>; Fri, 23 Dec 2022 15:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236343AbiLWPDs (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 23 Dec 2022 10:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236472AbiLWPDq (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 23 Dec 2022 10:03:46 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F64A31DCE;
        Fri, 23 Dec 2022 07:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=z0e5IfMg99plUAUdI6uzi1BHGXiNthwW7ZGB4IMQKos=; b=3k8aJZpl85LmCjJqqRvQ1Ffyzs
        h4rtHe033Xy24gMk4E5EC6NItcyogaTz2IMJRcCeRLXDIpmoVlmnmPbB+Frp+8HwKWJOjiA8Fgv90
        KX9SqaPgjskW6Lfux6yfNDfjjUg6Kk+COCY085AdHYG1HwoDMRG/oivXt9krKKa+ilCfxhrRhdojd
        Y/0GR2c7YCCCN+6LjSo4yoZMY59G9AgOVLG694FQDvXJ3dkKE1bS9Y8e+i9CnaImSO1ocRnEQTCBB
        jQW7f18HEsSOC60SXV2/LHZOYpOJIds7xPkL4W+2Hs16KacSWkbh6aRnnVrHU5YlTsDtO8cfVOMKf
        vD655liA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p8jaK-009Anr-0Q; Fri, 23 Dec 2022 15:03:44 +0000
Date:   Fri, 23 Dec 2022 07:03:43 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Li kunyu <kunyu@nfschina.com>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: main: =?utf-8?Q?remove?=
 =?utf-8?B?IHVubmVjZXNzYXJ5IOKAmDDigJk=?= values from err
Message-ID: <Y6XDTzjzzQl6JnHK@bombadil.infradead.org>
References: <20221223083232.4189-1-kunyu@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223083232.4189-1-kunyu@nfschina.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Fri, Dec 23, 2022 at 04:32:32PM +0800, Li kunyu wrote:
> err is assigned before use, so it does not need to initialize the
> assignment.

Sorry no, for something so simple, it just smells like you are wanting
to incraese your commit count.

  Luis
