Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F19C433DB
	for <linux-modules@archiver.kernel.org>; Thu, 14 Jan 2021 09:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21B5E239EB
	for <linux-modules@archiver.kernel.org>; Thu, 14 Jan 2021 09:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbhANJzT (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 14 Jan 2021 04:55:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:39490 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726858AbhANJzP (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Thu, 14 Jan 2021 04:55:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2725FAFA0;
        Thu, 14 Jan 2021 09:54:35 +0000 (UTC)
Date:   Thu, 14 Jan 2021 10:54:33 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc:     "Dmitry V. Levin" <ldv@altlinux.org>,
        linux-modules <linux-modules@vger.kernel.org>,
        Marcus =?iso-8859-1?Q?R=FCckert?= <mrueckert@suse.com>,
        Takashi Iwai <tiwai@suse.com>,
        Dominique Leuenberger <dimstar@opensuse.org>
Subject: Re: [PATCH] modprobe.d: load from /usr/lib.
Message-ID: <20210114095433.GH6564@kitsune.suse.cz>
References: <20210112160211.5614-1-msuchanek@suse.de>
 <CAKi4VAJKxUVtqFGkCkeL5hc+Uuyh94Nzt+c1zLpSEdbvzjjwaQ@mail.gmail.com>
 <20210112222226.GA31541@altlinux.org>
 <CAKi4VALOXOqrb34gZMqa29+=5MF8n7VnGPuEWbeu3JpZCJ1F=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKi4VALOXOqrb34gZMqa29+=5MF8n7VnGPuEWbeu3JpZCJ1F=g@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Hello,

On Wed, Jan 13, 2021 at 06:08:41AM -0800, Lucas De Marchi wrote:
> On Tue, Jan 12, 2021 at 2:22 PM Dmitry V. Levin <ldv@altlinux.org> wrote:
> >
> > On Tue, Jan 12, 2021 at 12:56:05PM -0800, Lucas De Marchi wrote:
> > > On Tue, Jan 12, 2021 at 8:06 AM Michal Suchanek <msuchanek@suse.de> wrote:
> > > >
> > > > There is an ongoing effort to limit use of files outside of /usr (or
> > > > $prefix on general). Currently all modprobe.d paths are hardcoded to
> > > > outside of $prefix. Teach kmod to load modprobe.d from $prefix/lib.
> > >
> > > /lib came from module-init-tools and we kept it for compatibility. It
> > > became a non-issue when distros
> > > decided to just merge them and do a symlink /lib -> /usr/lib following
> > > https://www.freedesktop.org/wiki/Software/systemd/TheCaseForTheUsrMerge/
> > >
> > > what distros didn't do that?
> >
> > FWiW, we decided not to do TheUsrMerge at all.
> 
> It looks like we will need to put this behind a compilation option
> then: --enable-split-usr.
> Then we only add the additional dir if split-usr is being used.
We could also stat the directories and skip the current one if it's the
same as the last one.
> 
> If it's not used, we may actually change the path and corresponding
> docs to move it to /usr,
> but that is another separate change.
Yes, the man page uses hardcoded paths rather than the actual paths.
There is no support for expanding configure variables in it at the
moment.

Thanks

Michal
