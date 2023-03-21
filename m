Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1041C6FD1D
	for <linux-modules@archiver.kernel.org>; Tue, 21 Mar 2023 16:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjCUQcO (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 21 Mar 2023 12:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjCUQcO (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 21 Mar 2023 12:32:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B8938013
        for <linux-modules@vger.kernel.org>; Tue, 21 Mar 2023 09:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CeHfwObIptdaQg0r027ULh+GjNmQ9kdptpSJMiXFg84=; b=uMxC/YFAz07M1hmEkbCjtcqXXG
        NKbWi2EyIpFtoRkIl9whuQ3jUWCZoQe00tLTJP7pEheiUvkJ9ajL9NcUSPWvmnI7uGRUGMzyfK//M
        uuTBzQv9pGCAr4XnjyorqqUaX5t+mve4PHyWsO5/EYqj2Ks9TvDNeWrZdAzr4MnEulsyM25ger73L
        A+hVxPd/pywzbEEMKj8OrBfhej61j9Zy1GIzblgizO2/cmkuxeioao5Y32SrmL1zbXgMQM1MGZyG7
        Cf+C8oQhdcokF1haKvZOSmo/g4hvXBfCede26QQK1Rzm2UKPgO5IdcxBFmkHsUy6m5QznjWQGm35i
        OHjn2KkQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1peeuC-00D5MC-2F;
        Tue, 21 Mar 2023 16:32:12 +0000
Date:   Tue, 21 Mar 2023 09:32:12 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     linux-modules <linux-modules@vger.kernel.org>
Subject: Re: module_license tree refreshed against linux-next
Message-ID: <ZBncDHaZfKEHAjGu@bombadil.infradead.org>
References: <87mt46s8i3.fsf@esperi.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mt46s8i3.fsf@esperi.org.uk>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue, Mar 21, 2023 at 10:29:08AM +0000, Nick Alcock wrote:
> I have not dropped commits with Greg K-H as maintainer simply because I
> kept on oscillating on doing that, so I thought I'd leave the commits in
> so you have the option to do either.

No, I don't want to do that work, please drop Greg's drivers.

  Luis
