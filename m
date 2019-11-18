Return-Path: <SRS0=PaVa=ZK=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7EAC432C0
	for <linux-modules@archiver.kernel.org>; Mon, 18 Nov 2019 22:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A1E6222EF
	for <linux-modules@archiver.kernel.org>; Mon, 18 Nov 2019 22:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfKRWp7 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 18 Nov 2019 17:45:59 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:48177 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbfKRWp7 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 18 Nov 2019 17:45:59 -0500
Received: from windsurf.home (lfbn-1-2159-45.w90-76.abo.wanadoo.fr [90.76.216.45])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 9B8DB240004;
        Mon, 18 Nov 2019 22:45:57 +0000 (UTC)
Date:   Mon, 18 Nov 2019 23:45:56 +0100
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc:     Fabrice Fontaine <fontaine.fabrice@gmail.com>,
        linux-modules <linux-modules@vger.kernel.org>
Subject: Re: [PATCH] Makefile.am: filter -Wl,--no-undefined
Message-ID: <20191118234556.21a4984e@windsurf.home>
In-Reply-To: <CAKi4VAKB1myn8AuMaV3SjBrthNiTxc8TkE18w95BPdRuzQBn2g@mail.gmail.com>
References: <20191118215617.395319-1-fontaine.fabrice@gmail.com>
        <CAKi4VAKB1myn8AuMaV3SjBrthNiTxc8TkE18w95BPdRuzQBn2g@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4git49 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Hello Lucas,

On Mon, 18 Nov 2019 14:18:07 -0800
Lucas De Marchi <lucas.de.marchi@gmail.com> wrote:

> On Mon, Nov 18, 2019 at 1:59 PM Fabrice Fontaine
> <fontaine.fabrice@gmail.com> wrote:
> >
> > Commit 1d14ef82f4a3be741bcdf6b1c6d51ce9dce43567 does not completely fix  
> 
> CC'ing Thomas.
> 
> Lucas De Marchi

Fabrice also submitted this patch to Buildroot, and I merged it.
Indeed, the -z undefs option was only introduced in binutils 2.30, so
any toolchain using a binutils older than that is not able to use -z
undefs.

So I'd say that Fabrice's proposal is fine. Another option would be to
detect if the toolchain support -z undefs, and only use --no-undefined
if -z undefs is supported, for example.

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
