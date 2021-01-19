Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA46C282CE
	for <linux-modules@archiver.kernel.org>; Tue, 19 Jan 2021 18:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF48F23109
	for <linux-modules@archiver.kernel.org>; Tue, 19 Jan 2021 18:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729498AbhASRYO (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 19 Jan 2021 12:24:14 -0500
Received: from mga06.intel.com ([134.134.136.31]:14317 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387543AbhASRXr (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Tue, 19 Jan 2021 12:23:47 -0500
IronPort-SDR: xSPjW5RCRs2ETP5ssQKVH6XxmPg7qEIMEy/0roAlFSV2e1PUwpYLwqR1ye5ipOMS/S/TimInEX
 go23Uh168E1w==
X-IronPort-AV: E=McAfee;i="6000,8403,9869"; a="240502583"
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="240502583"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 09:22:47 -0800
IronPort-SDR: VctKDfNYBCWSe8x4oex56n8ZwhC8i0xr8Y2qeM6UNerWFGSqyiXTnrV+LM7HSK6FIM2mi0H7OM
 O5xk6olD0a4g==
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="355700129"
Received: from caophong-mobl.amr.corp.intel.com (HELO ldmartin-desk1) ([10.213.166.105])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 09:22:46 -0800
Date:   Tue, 19 Jan 2021 09:22:42 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-modules@vger.kernel.org
Subject: Re: [PATCH 2/3] depmod: fix precedence order
Message-ID: <20210119172242.okzlqdgd5l6mtw6r@ldmartin-desk1>
X-Patchwork-Hint: comment
References: <20210119145238.12774-1-lucas.demarchi@intel.com>
 <20210119145238.12774-2-lucas.demarchi@intel.com>
 <YAb8FfR+/I5YKxUq@bongo.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YAb8FfR+/I5YKxUq@bongo.bofh.it>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue, Jan 19, 2021 at 04:34:45PM +0100, Marco d'Itri wrote:
>On Jan 19, Lucas De Marchi <lucas.demarchi@intel.com> wrote:
>
>> Configuration in /etc should have higher prio than /run.
>> Given how rarely configuration in /run is used with depmod, this is
>> likely not to cause any problems, even if it's a change in behavior.
>I agree. But the order is documented in the man pages, so you should
>change it there as well.

that is what the first patch does.

thanks
Lucas De Marchi

>
>-- 
>ciao,
>Marco


