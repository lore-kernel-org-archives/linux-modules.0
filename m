Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C46BC6FD1C
	for <linux-modules@archiver.kernel.org>; Thu, 23 Mar 2023 19:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjCWTnb (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 23 Mar 2023 15:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjCWTna (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 23 Mar 2023 15:43:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005C44C0D
        for <linux-modules@vger.kernel.org>; Thu, 23 Mar 2023 12:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5yJfIe5AUdz8YxsM3LDQKh1/yTMOmCVAnTDLU8HRRHk=; b=tjbOzY8VPSS7pdbbnHU3aLu9W3
        KxtQYIQH4+trRmzaCEMTGVa/WSmRtvHA48PzshjBhBRrsd1E5DpFN6WU6yPmk7EcZBex7dxfgVf80
        ERcOHI7jjRppK5wlN1qY+v2SNRG3U89Me50FX2TsOszjlOCicodGwqeKdTzDKe8CM7dy5AKXlc2rC
        HK6uysIiSVqz3wGWkDx4besUX6ANhDpo/8jh0TK6t0Bv9CDWfddb4xVDx5/GXu/n1qGeOupsnDIvf
        hyCMwFYsZE05uEixt/dZTOH9ubPH0VMg9CtNZeQS1ZagWUpDTVd3flv5S9s6CiXpSx+SojAYn9HyS
        ERV3S+7w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pfQqP-002qy6-0y;
        Thu, 23 Mar 2023 19:43:29 +0000
Date:   Thu, 23 Mar 2023 12:43:29 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     linux-modules <linux-modules@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: module_license tree refreshed against linux-next
Message-ID: <ZByr4Wpg+OHX93lf@bombadil.infradead.org>
References: <87mt46s8i3.fsf@esperi.org.uk>
 <ZBncDHaZfKEHAjGu@bombadil.infradead.org>
 <87r0tiqc6z.fsf@esperi.org.uk>
 <ZBuQOXi+my7bnXzR@bombadil.infradead.org>
 <87zg83mn75.fsf@esperi.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zg83mn75.fsf@esperi.org.uk>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, Mar 23, 2023 at 04:45:02PM +0000, Nick Alcock wrote:
> [Cc:ed Steve because I think he wanted something like this]
> 
> % echo 1 > /sys/kernel/tracing/options/sym-unambiguous

I'd like to really hear if Steven is really super excited about this or not.
You keep saying he wants it, but I haven't him say it yet on the lists.

  Luis
