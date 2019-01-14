Return-Path: <SRS0=pmuc=PW=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A087DC43387
	for <linux-modules@archiver.kernel.org>; Mon, 14 Jan 2019 20:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C08020659
	for <linux-modules@archiver.kernel.org>; Mon, 14 Jan 2019 20:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfANUao (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:30:44 -0500
Received: from che.mayfirst.org ([162.247.75.118]:38129 "EHLO che.mayfirst.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726777AbfANUao (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Mon, 14 Jan 2019 15:30:44 -0500
Received: from fifthhorseman.net (unknown [38.109.115.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by che.mayfirst.org (Postfix) with ESMTPSA id E1B31F99A
        for <linux-modules@vger.kernel.org>; Mon, 14 Jan 2019 15:30:42 -0500 (EST)
Received: by fifthhorseman.net (Postfix, from userid 1000)
        id 2ACF32013C; Mon, 14 Jan 2019 14:59:30 -0500 (EST)
From:   Daniel Kahn Gillmor <dkg@fifthhorseman.net>
To:     linux-modules@vger.kernel.org
Subject: Re: [kmod] Fix typo
In-Reply-To: <alpine.LNX.2.02.1901121358590.612@connie.slackware.com>
References: <20190112172219.13152-1-dkg@fifthhorseman.net> <alpine.LNX.2.02.1901121358590.612@connie.slackware.com>
Date:   Mon, 14 Jan 2019 14:59:30 -0500
Message-ID: <87imyrhuxp.fsf@fifthhorseman.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Sat 2019-01-12 13:59:47 -0800, Robby Workman wrote:
> I *think* that was supposed to be "of any files" when it was originally
> typed, but either works, I suppose :-)

I'm fine however it gets resolved -- just please don't leave it with the
broken text.

thanks for maintaining kmod!

    --dkg
