Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A845BC433E6
	for <linux-modules@archiver.kernel.org>; Tue, 12 Jan 2021 22:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F1C323122
	for <linux-modules@archiver.kernel.org>; Tue, 12 Jan 2021 22:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbhALWaI (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 12 Jan 2021 17:30:08 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:42402 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394612AbhALW3j (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 12 Jan 2021 17:29:39 -0500
X-Greylist: delayed 386 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Jan 2021 17:29:38 EST
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 101FC72C8BA;
        Wed, 13 Jan 2021 01:22:27 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id D843F7CC8A0; Wed, 13 Jan 2021 01:22:26 +0300 (MSK)
Date:   Wed, 13 Jan 2021 01:22:26 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc:     Michal Suchanek <msuchanek@suse.de>,
        linux-modules <linux-modules@vger.kernel.org>,
        Marcus =?utf-8?Q?R=C3=BCckert?= <mrueckert@suse.com>,
        Takashi Iwai <tiwai@suse.com>,
        Dominique Leuenberger <dimstar@opensuse.org>
Subject: Re: [PATCH] modprobe.d: load from /usr/lib.
Message-ID: <20210112222226.GA31541@altlinux.org>
References: <20210112160211.5614-1-msuchanek@suse.de>
 <CAKi4VAJKxUVtqFGkCkeL5hc+Uuyh94Nzt+c1zLpSEdbvzjjwaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKi4VAJKxUVtqFGkCkeL5hc+Uuyh94Nzt+c1zLpSEdbvzjjwaQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue, Jan 12, 2021 at 12:56:05PM -0800, Lucas De Marchi wrote:
> On Tue, Jan 12, 2021 at 8:06 AM Michal Suchanek <msuchanek@suse.de> wrote:
> >
> > There is an ongoing effort to limit use of files outside of /usr (or
> > $prefix on general). Currently all modprobe.d paths are hardcoded to
> > outside of $prefix. Teach kmod to load modprobe.d from $prefix/lib.
> 
> /lib came from module-init-tools and we kept it for compatibility. It
> became a non-issue when distros
> decided to just merge them and do a symlink /lib -> /usr/lib following
> https://www.freedesktop.org/wiki/Software/systemd/TheCaseForTheUsrMerge/
> 
> what distros didn't do that?

FWiW, we decided not to do TheUsrMerge at all.


-- 
ldv
