Return-Path: <SRS0=469u=D2=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4F6C433DF
	for <linux-modules@archiver.kernel.org>; Mon, 19 Oct 2020 16:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C08072225F
	for <linux-modules@archiver.kernel.org>; Mon, 19 Oct 2020 16:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730509AbgJSQNp (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 19 Oct 2020 12:13:45 -0400
Received: from mga05.intel.com ([192.55.52.43]:58846 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730504AbgJSQNo (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Mon, 19 Oct 2020 12:13:44 -0400
IronPort-SDR: OfiBek3qKpUWYfGOE8lbVm3cSDpVrcp90Zyvx7RR/xb2u9BznQB/VKVVDOURu8vy7/HOrCRDye
 Fdc+x8ZP4pJQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9779"; a="251753218"
X-IronPort-AV: E=Sophos;i="5.77,394,1596524400"; 
   d="scan'208";a="251753218"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 09:13:44 -0700
IronPort-SDR: DBqiWZZR8kN4/tHU3DPTVHB3dFIOBYIMq9EfGQfCVBEhKaPrzGLkYivUcN+69TpjXvsc8OsT2m
 kDduvey8HOHQ==
X-IronPort-AV: E=Sophos;i="5.77,394,1596524400"; 
   d="scan'208";a="465580553"
Received: from jkboswor-mobl2.amr.corp.intel.com (HELO ldmartin-desk1) ([10.255.231.68])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 09:13:43 -0700
Date:   Mon, 19 Oct 2020 09:13:43 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Samanta Navarro <ferivoz@riseup.net>
Cc:     linux-modules@vger.kernel.org
Subject: Re: [PATCH] man: fix typo
Message-ID: <20201019161343.5g46n6ezibn4vg7j@ldmartin-desk1>
X-Patchwork-Hint: ignore
References: <20201004114333.ekwqf5hvncv5vnid@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201004114333.ekwqf5hvncv5vnid@localhost>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Sun, Oct 04, 2020 at 11:43:33AM +0000, Samanta Navarro wrote:
>---
> man/modules.dep.xml | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/man/modules.dep.xml b/man/modules.dep.xml
>index e53293a..ed63369 100644
>--- a/man/modules.dep.xml
>+++ b/man/modules.dep.xml
>@@ -48,7 +48,7 @@
>       libkmod.
>     </para>
>     <para>
>-      Its text counterpar is located in the same directory with the name
>+      Its text counterpart is located in the same directory with the name


Applied, thanks

Lucas De Marchi

>       <filename>modules.dep</filename>. The text version is maintained only
>       for easy of reading by humans and is in no way used by any kmod tool.
>     </para>
>-- 
>2.28.0
>
