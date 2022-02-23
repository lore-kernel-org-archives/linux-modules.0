Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284EBC433EF
	for <linux-modules@archiver.kernel.org>; Wed, 23 Feb 2022 09:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238506AbiBWJmH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 23 Feb 2022 04:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239330AbiBWJmG (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 23 Feb 2022 04:42:06 -0500
Received: from mail.spitalcalafat.ro (unknown [82.77.66.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1305F4DA
        for <linux-modules@vger.kernel.org>; Wed, 23 Feb 2022 01:41:37 -0800 (PST)
Received: from [82.77.66.20] ([82.77.66.20])
        by mail.spitalcalafat.ro
        for linux-modules@vger.kernel.org;
        Wed, 23 Feb 2022 11:43:37 +0200
To:     linux-modules@vger.kernel.org
From:   "Cristian Crinteanu" <yoda@mail.spitalcalafat.ro>
Subject: kmod-29
Message-ID: <20220223094337.29ef4d0f@mail.spitalcalafat.ro>
Date:   Wed, 23 Feb 2022 11:43:37 +0200
X-User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:97.0) Gecko/20100101 Firefox/97.0
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

everything worked fine until i reached  

https://git.kernel.org/pub/scm/utils/kernel/kmod/kmod.git/commit/?id=82972710196442c503cc1068a05651c354a865fb
doing modprobe and/or modinfo on unexisting module throws kmod into segfault 
eg:
modinfo blahblah
Segmentation fault
any ideea?
thx!
