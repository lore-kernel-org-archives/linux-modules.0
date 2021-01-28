Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2ACFC433DB
	for <linux-modules@archiver.kernel.org>; Thu, 28 Jan 2021 13:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8542364D9A
	for <linux-modules@archiver.kernel.org>; Thu, 28 Jan 2021 13:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbhA1NBK (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 28 Jan 2021 08:01:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:56596 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231284AbhA1NBJ (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Thu, 28 Jan 2021 08:01:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 29A2CAE76;
        Thu, 28 Jan 2021 13:00:28 +0000 (UTC)
Date:   Thu, 28 Jan 2021 14:00:26 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     linux-modules@vger.kernel.org
Cc:     Petr Vorel <petr.vorel@gmail.com>
Subject: depmod test fails when zstd not available
Message-ID: <20210128130026.GH6564@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Hello,

kmod version 28 adds support for zstd. The support is optional but when
not enabled the depmod test which unconditionally tests zstd fails.

As kmod supports more and more compression methods I think it is not
reasonable to expect everyone has all copression libraries available.

Do you think it is reasonable to fix the tests to only use teh
compresion methods enabled by configure?

Thanks

Michal
