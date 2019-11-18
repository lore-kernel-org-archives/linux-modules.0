Return-Path: <SRS0=PaVa=ZK=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA56EC432C0
	for <linux-modules@archiver.kernel.org>; Mon, 18 Nov 2019 23:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74AD320708
	for <linux-modules@archiver.kernel.org>; Mon, 18 Nov 2019 23:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfKRXRY (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 18 Nov 2019 18:17:24 -0500
Received: from monster.unsafe.ru ([5.9.28.80]:50728 "EHLO mail.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726795AbfKRXRY (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Mon, 18 Nov 2019 18:17:24 -0500
Received: from Legion-PC.fortress (ip-89-102-33-211.net.upcbroadband.cz [89.102.33.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.unsafe.ru (Postfix) with ESMTPSA id ADE09C61AF3;
        Mon, 18 Nov 2019 23:17:21 +0000 (UTC)
Date:   Tue, 19 Nov 2019 00:17:19 +0100
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc:     linux-modules@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Add modules.builtin.modinfo support
Message-ID: <20191118231719.dz57yyino6k7bboo@Legion-PC.fortress>
Mail-Followup-To: Lucas De Marchi <lucas.de.marchi@gmail.com>,
        linux-modules@vger.kernel.org
References: <20191108172524.468494-1-gladkov.alexey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108172524.468494-1-gladkov.alexey@gmail.com>
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Fri, Nov 08, 2019 at 06:25:19PM +0100, Alexey Gladkov wrote:
> The kernel since version v5.2-rc1 exports information about built-in
> modules in the modules.builtin.modinfo. Now, kmod can show complete information
> about the built-in modules as well as about external modules. Also kmod can
> understand aliases of built-in modules.

How about this version ?

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
> 
> v2:
> 
> * Don't use kmod_file() to parse modules.builtin.modinfo. Instead, parser reads
> the file into the buffer by chunks, which reduces the amount of memory.
> 
> Alexey Gladkov (4):
>   libkmod: Add parser for modules.builtin.modinfo
>   libkmod: Add function to get list of built-in modules
>   Lookup aliases in the modules.builtin.modinfo
>   modinfo: Show information about built-in modules
> 
>  Makefile.am                |   1 +
>  libkmod/libkmod-builtin.c  | 329 +++++++++++++++++++++++++++++++++++++
>  libkmod/libkmod-internal.h |  10 ++
>  libkmod/libkmod-module.c   |  73 +++++++-
>  libkmod/libkmod.c          |  25 +++
>  libkmod/libkmod.h          |   1 +
>  tools/depmod.c             |  63 +++++++
>  tools/modinfo.c            |  39 +++--
>  8 files changed, 514 insertions(+), 27 deletions(-)
>  create mode 100644 libkmod/libkmod-builtin.c
> 
> -- 
> 2.21.0
> 

-- 
Rgrds, legion

