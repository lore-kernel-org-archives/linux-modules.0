Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C63C433EF
	for <linux-modules@archiver.kernel.org>; Tue, 29 Mar 2022 09:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbiC2JK4 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 29 Mar 2022 05:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234473AbiC2JKz (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 29 Mar 2022 05:10:55 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893463A713
        for <linux-modules@vger.kernel.org>; Tue, 29 Mar 2022 02:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648544953; x=1680080953;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yA6vnsM89lCWKXh1vWMDbKjZBeSMUxLRjYDgBLqXccI=;
  b=aojlQjrAOnB0XiwSmcYG/IEG5WM2gZf0EnKoij0gNSBh8u2SJ4QJpkNm
   BHQiMjB28GEECUBNmKfj1DNSzAQf1Y7X5oN5rnMu56JtI1xIzk1GS3ISc
   4utt3ENRtr6N51njFdHiLH/hCg6Pprx2VT3LvhLAtTKJTGEzuZ8slz4JZ
   EVe+jLd2qECYFVtw1V8hB9BLkNHpPaS1gmTYovzooeAx6AvcGJaxKAaEN
   C1GpzpzrnDvu7bG3+oZXg2cu2t3zGWV+ubYLfpHfkFYGUinwFSxo6jASc
   1tya/wYPO+9HU5sQjZR/SVa9fH380KVjs9+rpfHaCpaSGeaOhLMou+9Qo
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="319901107"
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="319901107"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 02:09:13 -0700
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="649378096"
Received: from mlopezja-mobl.amr.corp.intel.com (HELO ldmartin-desk2.jf.intel.com) ([10.255.231.179])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 02:09:12 -0700
Date:   Tue, 29 Mar 2022 02:09:12 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-modules@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH 0/4] modprobe -r fixes and refactors
Message-ID: <20220329090912.geymr6xk7taq4rtq@ldmartin-desk2.jf.intel.com>
References: <20220329090540.38255-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220329090540.38255-1-lucas.demarchi@intel.com>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue, Mar 29, 2022 at 02:05:34AM -0700, Lucas De Marchi wrote:
>Fixes and refactors that I noticed were needed while preparing support
>for "patient module removal[1][2]" in modprobe.
>
>The added functionality will be sent on top of these.
>
>[1] https://lore.kernel.org/linux-modules/20210803202417.462197-1-mcgrof@kernel.org/
>[2] https://lore.kernel.org/linux-modules/20210810051602.3067384-1-mcgrof@kernel.org/
>
>Lucas De Marchi (4):
>  modprobe: Rename rmmod_do_deps_list
>  modprobe: Fix holders removal
>  modprobe: Move check for remove_holders to caller
>  modprobe: Make rmmod_do_module() contain all the removal sequence

patches 1 and 3 were duplicate as I reworded the commit message.
Please consider the ones matching subjects above.

thanks
Lucas De Marchi

>
> tools/modprobe.c | 64 ++++++++++++++++++++++++++++--------------------
> 1 file changed, 38 insertions(+), 26 deletions(-)
>
>-- 
>2.35.1
>
