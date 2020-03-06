Return-Path: <SRS0=p+Rv=4X=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073ECC3F2D2
	for <linux-modules@archiver.kernel.org>; Fri,  6 Mar 2020 00:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4C4520801
	for <linux-modules@archiver.kernel.org>; Fri,  6 Mar 2020 00:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgCFAKz (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 5 Mar 2020 19:10:55 -0500
Received: from mga07.intel.com ([134.134.136.100]:60656 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbgCFAKy (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Thu, 5 Mar 2020 19:10:54 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 16:10:54 -0800
X-IronPort-AV: E=Sophos;i="5.70,520,1574150400"; 
   d="scan'208";a="234606811"
Received: from ldmartin-desk1.jf.intel.com (HELO ldmartin-desk1) ([10.24.14.222])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 16:10:54 -0800
Date:   Thu, 5 Mar 2020 16:10:54 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Matthias Maennich <maennich@google.com>,
        linux-modules <linux-modules@vger.kernel.org>
Subject: Re: [PATCH] depmod: account for new namespace field in
 Module.symvers (for kernel versions >= 5.4)
Message-ID: <20200306001054.j4q5l4bsdotrgjbt@ldmartin-desk1>
References: <20200221165243.25100-1-jeyu@kernel.org>
 <CAKi4VA+uO-mdZ=gKpWdU6vq2_VJjhDkHS3KVZb3_6N2YGVhgiA@mail.gmail.com>
 <20200304091833.GA14910@linux-8ccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200304091833.GA14910@linux-8ccs>
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed, Mar 04, 2020 at 10:18:33AM +0100, Jessica Yu wrote:
>+++ Lucas De Marchi [03/03/20 22:28 -0800]:
>>On Fri, Feb 21, 2020 at 8:53 AM Jessica Yu <jeyu@kernel.org> wrote:
>>>
>>>depmod -e -E is broken for kernel versions >= 5.4, because a new
>>>namespace field was added to Module.symvers. Each line is tab delimited
>>>with 5 fields in total. E.g.,
>>>
>>>        0xb352177e\tfind_first_bit\tnamespace\tvmlinux\tEXPORT_SYMBOL
>>>
>>>When a symbol doesn't have a namespace, then the namespace field is empty:
>>>
>>>        0xb352177e\tfind_first_bit\t\tvmlinux\tEXPORT_SYMBOL
>>
>>Why is namespace added in the *middle*? We remember we specifically
>>talked about compatibility back when this was added. Why is it not at
>>the end so tools that don't know about namespace don't stop working?
>>
>>Lucas De Marchi
>
>Sigh, I do remember we had a short discussion upstream back in August
>[1] when we were tossing around Module.symvers format preferences. It
>is my fault for not having pushed the backwards compatibility option
>more instead of thinking it could be patched up in kmod tools. I think
>maybe the best course of option is to revert this upstream instead and
>Cc:stable.

Yeah I didn't follow that series thoroughly as I should. I agree that
the best course of action now is to update the format and CC stable.

Lucas De Marchi

>
>Sorry about this. :-/
>
>[1] https://lore.kernel.org/r/20190828094325.GA25048@linux-8ccs
>
