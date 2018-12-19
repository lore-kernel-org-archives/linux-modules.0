Return-Path: <SRS0=c/4a=O4=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F87FC43387
	for <linux-modules@archiver.kernel.org>; Wed, 19 Dec 2018 19:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79407217D7
	for <linux-modules@archiver.kernel.org>; Wed, 19 Dec 2018 19:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbeLSTYj (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 19 Dec 2018 14:24:39 -0500
Received: from mga14.intel.com ([192.55.52.115]:57194 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726993AbeLSTYj (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Wed, 19 Dec 2018 14:24:39 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Dec 2018 11:24:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,373,1539673200"; 
   d="scan'208";a="120178562"
Received: from ldmartin-desk.jf.intel.com ([10.7.200.65])
  by orsmga001.jf.intel.com with ESMTP; 19 Dec 2018 11:24:38 -0800
Date:   Wed, 19 Dec 2018 11:24:38 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     linux-modules@vger.kernel.org, ykaliuta@redhat.com
Subject: Re: [RFC PATCH 0/2] Unify symbol access API
Message-ID: <20181219192437.GE6410@ldmartin-desk.jf.intel.com>
References: <20181123215322.5438-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123215322.5438-1-yauheni.kaliuta@redhat.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Fri, Nov 23, 2018 at 11:53:20PM +0200, Yauheni Kaliuta wrote:
> Hi!
> 
> I'm not very happy with the naming, but how do you like the idea in general?

I don't like the naming, too. The idea is good and I like the
de-duplication of the implementation, thanks.

These are all symbols, but coming from different elf sections. I wonder
if we can add a kmod_module_get_symbols2() with an additional
argument.

then we would still have kmod_module_symbol_get_symbol(),
kmod_module_symbol_get_crc() and add kmod_module_symbol_get_bind_type()

And these will need to be added to the testsuite

thoughts?

Lucas De Marchi

> 
> 
> Yauheni Kaliuta (2):
>   libkmod: module: introduce common symbol API.
>   libkmod: module: make old symbol access API as wrapper to the new
> 
>  libkmod/libkmod-module.c | 387 ++++++++++++++++-----------------------
>  libkmod/libkmod.h        |  12 ++
>  2 files changed, 171 insertions(+), 228 deletions(-)
> 
> -- 
> 2.19.1
> 
