Return-Path: <SRS0=6exi=Y7=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA97C5DF61
	for <linux-modules@archiver.kernel.org>; Thu,  7 Nov 2019 10:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFA512178F
	for <linux-modules@archiver.kernel.org>; Thu,  7 Nov 2019 10:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387870AbfKGKgT (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 7 Nov 2019 05:36:19 -0500
Received: from monster.unsafe.ru ([5.9.28.80]:59148 "EHLO mail.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726866AbfKGKgT (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Thu, 7 Nov 2019 05:36:19 -0500
X-Greylist: delayed 349 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Nov 2019 05:36:18 EST
Received: from MacBook-PC.fortress (nat-pool-brq-t.redhat.com [213.175.37.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.unsafe.ru (Postfix) with ESMTPSA id A3C90C61AB1;
        Thu,  7 Nov 2019 10:30:27 +0000 (UTC)
Date:   Thu, 7 Nov 2019 11:30:25 +0100
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     linux-modules@vger.kernel.org
Cc:     Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: Re: [PATCH v1 0/4] Add modules.builtin.modinfo support
Message-ID: <20191107103025.ysgffcf4fj5avknh@MacBook-PC.fortress>
Mail-Followup-To: linux-modules@vger.kernel.org,
        Lucas De Marchi <lucas.de.marchi@gmail.com>
References: <20191011081956.4127892-1-gladkov.alexey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011081956.4127892-1-gladkov.alexey@gmail.com>
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Fri, Oct 11, 2019 at 10:19:52AM +0200, Alexey Gladkov wrote:
> The kernel since version v5.2-rc1 exports information about built-in
> modules in the modules.builtin.modinfo. Now, kmod can show complete information
> about the built-in modules as well as about external modules. Also kmod can
> understand aliases of built-in modules.
> 
> Before:
> 
> $ modinfo block-major-9-1
> modinfo: ERROR: Module block-major-9-1 not found.
> 
> After:
> 
> $ modinfo block-major-9-1
> name:           md_mod
> filename:       (builtin)
> alias:          block-major-9-*
> alias:          md
> description:    MD RAID framework
> license:        GPL
> parm:           start_dirty_degraded:int
> parm:           create_on_open:bool

Please review.

> Alexey Gladkov (4):
>   libkmod: Add parser for modules.builtin.modinfo
>   libkmod: Add function to get list of built-in modules
>   Lookup aliases in the modules.builtin.modinfo
>   modinfo: Show information about built-in modules
> 
>  Makefile.am                |   1 +
>  libkmod/libkmod-builtin.c  | 231 +++++++++++++++++++++++++++++++++++++
>  libkmod/libkmod-internal.h |  10 ++
>  libkmod/libkmod-module.c   |  76 ++++++++++--
>  libkmod/libkmod.c          |  25 ++++
>  libkmod/libkmod.h          |   1 +
>  tools/depmod.c             |  63 ++++++++++
>  tools/modinfo.c            |  39 ++++---
>  8 files changed, 419 insertions(+), 27 deletions(-)
>  create mode 100644 libkmod/libkmod-builtin.c
> 
> -- 
> 2.21.0
> 

-- 
Rgrds, legion

