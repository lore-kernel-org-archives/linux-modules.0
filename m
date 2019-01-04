Return-Path: <SRS0=6D95=PM=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B87EC43387
	for <linux-modules@archiver.kernel.org>; Fri,  4 Jan 2019 22:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1B6421872
	for <linux-modules@archiver.kernel.org>; Fri,  4 Jan 2019 22:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbfADWkx (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 4 Jan 2019 17:40:53 -0500
Received: from mga17.intel.com ([192.55.52.151]:57223 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbfADWkx (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Fri, 4 Jan 2019 17:40:53 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jan 2019 14:40:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,439,1539673200"; 
   d="scan'208";a="133044567"
Received: from ldmartin-desk.jf.intel.com ([10.24.8.113])
  by fmsmga004.fm.intel.com with ESMTP; 04 Jan 2019 14:40:52 -0800
Date:   Fri, 4 Jan 2019 14:40:52 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     linux-modules@vger.kernel.org, ykaliuta@redhat.com
Subject: Re: [PATCH kmod 0/2] testsuite: abstraction to compare file
 descriptor
Message-ID: <20190104224052.GA17384@ldmartin-desk.jf.intel.com>
References: <20190104214134.23971-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190104214134.23971-1-yauheni.kaliuta@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Fri, Jan 04, 2019 at 11:41:32PM +0200, Yauheni Kaliuta wrote:
> Factor out common code to handle comparation of stdout/stderr to the
> template.
> 
> The first patch is made to make reviewing of the change of the
> original logic easier.

LGTM, thanks. I'll push them soon if they pass CI.

Lucas De Marchi

> 
> Yauheni Kaliuta (2):
>   testsuite: track number of descriptors instead of their state
>   testsuite: factor out fd related parameters to a structure
> 
>  testsuite/testsuite.c | 362 +++++++++++++++++++++++++-----------------
>  1 file changed, 219 insertions(+), 143 deletions(-)
> 
> -- 
> 2.20.0
> 
