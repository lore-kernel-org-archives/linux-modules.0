Return-Path: <SRS0=uoCS=MW=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1F7C43441
	for <linux-modules@archiver.kernel.org>; Wed, 10 Oct 2018 21:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7C0A2087D
	for <linux-modules@archiver.kernel.org>; Wed, 10 Oct 2018 21:50:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7C0A2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-modules-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726051AbeJKFOs (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 11 Oct 2018 01:14:48 -0400
Received: from mga09.intel.com ([134.134.136.24]:24220 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbeJKFOs (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Thu, 11 Oct 2018 01:14:48 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2018 14:50:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,365,1534834800"; 
   d="scan'208";a="80443043"
Received: from cmdeoliv-mobl2.jf.intel.com ([10.7.200.82])
  by orsmga008.jf.intel.com with ESMTP; 10 Oct 2018 14:50:42 -0700
Date:   Wed, 10 Oct 2018 14:50:42 -0700
From:   Caio Marcelo de Oliveira Filho <caio.oliveira@intel.com>
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     linux-modules@vger.kernel.org
Subject: Re: [PATCH] mkosi: allow Clear to use test modules
Message-ID: <20181010215042.GA7184@cmdeoliv-mobl2.jf.intel.com>
References: <20181010205016.3462-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010205016.3462-1-lucas.demarchi@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed, Oct 10, 2018 at 01:50:16PM -0700, Lucas De Marchi wrote:
> Now Clear has a bundle for the kernel headers, let's use it.
> ---
>  testsuite/mkosi/mkosi.build | 9 ++-------
>  testsuite/mkosi/mkosi.clear | 1 +
>  2 files changed, 3 insertions(+), 7 deletions(-)

Tested the patch with 'sudo make mkosi DISTRO=clear' and all tests
passed.

LGTM.


Caio


