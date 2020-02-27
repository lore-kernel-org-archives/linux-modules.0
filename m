Return-Path: <SRS0=uawh=4P=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3575C4BA24
	for <linux-modules@archiver.kernel.org>; Thu, 27 Feb 2020 12:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D91B24695
	for <linux-modules@archiver.kernel.org>; Thu, 27 Feb 2020 12:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbgB0Mli (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 27 Feb 2020 07:41:38 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:59992 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728977AbgB0Mli (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 27 Feb 2020 07:41:38 -0500
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 5290972CCF1;
        Thu, 27 Feb 2020 15:41:36 +0300 (MSK)
Received: from boyarsh.office.basealt.ru (unknown [83.220.44.62])
        by imap.altlinux.org (Postfix) with ESMTPSA id 44B0A4A4A16;
        Thu, 27 Feb 2020 15:41:36 +0300 (MSK)
Date:   Thu, 27 Feb 2020 15:41:34 +0300
From:   "Anton V. Boyarshinov" <boyarsh@altlinux.org>
To:     Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc:     linux-modules <linux-modules@vger.kernel.org>, legion@altlinux.org
Subject: Re: [PATCH v2] Add kernel-version dependent configuration directory
Message-ID: <20200227154134.45fab57b@boyarsh.office.basealt.ru>
In-Reply-To: <CAKi4VA+8o=3HASrtuFNwts35q09xR_bUAY8Bd8_tc0ebj4DZ=g@mail.gmail.com>
References: <20200226133221.44342a57@table.localdomain>
        <CAKi4VA+8o=3HASrtuFNwts35q09xR_bUAY8Bd8_tc0ebj4DZ=g@mail.gmail.com>
Organization: BaseALT
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-alt-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, 27 Feb 2020 00:43:47 -0800 Lucas De Marchi wrote:

> See documentation above this function. This breaks the case in which
> the supplied array is empty,
> i.e. a single NULL element.

I've review this code and disagree with you. It doesn't break
single NULL element vector. In this case config_paths is not NULL and,
so no version-dependent configuation will be created. Single NULL will
be passed as is, like any other custom configuration.

   if (config_paths == NULL) {
	/*creating version-dependent configuration */
                err = kmod_config_new(ctx, &ctx->config, (const char * const*) tmp_config_paths);
	/* free resources */
        }
        else
                err = kmod_config_new(ctx, &ctx->config, config_paths);

