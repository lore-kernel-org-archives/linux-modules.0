Return-Path: <SRS0=C6ur=4O=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A578CC4BA0E
	for <linux-modules@archiver.kernel.org>; Wed, 26 Feb 2020 10:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84C9E20838
	for <linux-modules@archiver.kernel.org>; Wed, 26 Feb 2020 10:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgBZKOt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 26 Feb 2020 05:14:49 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:48592 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbgBZKOt (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 26 Feb 2020 05:14:49 -0500
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 1493E72CCEF;
        Wed, 26 Feb 2020 13:14:47 +0300 (MSK)
Received: from table.localdomain (109-252-52-89.nat.spd-mgts.ru [109.252.52.89])
        by imap.altlinux.org (Postfix) with ESMTPSA id E90ED4A4A2A;
        Wed, 26 Feb 2020 13:14:46 +0300 (MSK)
Date:   Wed, 26 Feb 2020 13:14:46 +0300
From:   "Anton V. Boyarshinov" <boyarsh@altlinux.org>
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     linux-modules@vger.kernel.org
Subject: Re: [PATCH] Add kernel-version dependent configuration directory
Message-ID: <20200226101446.11f3f8b3@table.localdomain>
In-Reply-To: <20200226100756.aup6bwj23tynxhhu@comp-core-i7-2640m-0182e6>
References: <20200226080449.6c997cfd@x230.localdomain>
        <20200226100756.aup6bwj23tynxhhu@comp-core-i7-2640m-0182e6>
Organization: ALT Linux
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-alt-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

В Wed, 26 Feb 2020 11:07:56 +0100
Alexey Gladkov <gladkov.alexey@gmail.com> пишет:

> > +
> > +		configs_count = sizeof(default_config_paths) / sizeof(char *);  
> 
> Is it ARRAY_SIZE ?

Yes, will be fixed.
 
> > +		tmp_config_paths[configs_count-1] = get_ver_config_path("/lib");
> > +		tmp_config_paths[configs_count] = get_ver_config_path("/etc");  
> 
> Please use SYSCONFDIR. All other parts of the code use it.

Thank you, will be fixed.
