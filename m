Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69852C433EF
	for <linux-modules@archiver.kernel.org>; Thu,  7 Apr 2022 05:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbiDGFHn (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 7 Apr 2022 01:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbiDGFHm (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 7 Apr 2022 01:07:42 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8168825F8
        for <linux-modules@vger.kernel.org>; Wed,  6 Apr 2022 22:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649307943; x=1680843943;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nac3duThHvlxwvf0+o+tf8uvl6927X0U8/tyd/l226c=;
  b=A3kPrrHuxglbbtpX4NLK0ycNHvwCSR6XOBgH6/CN/btGjJrjrtoeOQgW
   ECFYF9sh6A67IrePmwudYsJNcWrHQsuuN3InrLnDCurig4CSySeAYZa+Q
   lm+BnyUQZtUhixiTbXAuDaqxLIKJNPuleDCC/kYFDEliR4ZI4kWu/4g4z
   5BTGwfqjskhqrIzAmMpq15JxNcUwK5/QlGajkye1PKU913kimdVUDcmla
   PAwc0PeR/YmCliWrfnyRFhWXrUKhc3dOFdK3sx6guqPYRroxkUtdBQYG9
   7M8h0ERI7Qb/nk792u/a/pTqODUpJuwc4uB0tGpiaYLQNwfI9sYNlnFO6
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="241161327"
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; 
   d="scan'208";a="241161327"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 22:05:42 -0700
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; 
   d="scan'208";a="570886030"
Received: from camcconn-mobl1.amr.corp.intel.com (HELO ldmartin-desk2) ([10.212.247.57])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 22:05:42 -0700
Date:   Wed, 6 Apr 2022 22:05:41 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-modules@vger.kernel.org
Subject: Re: [PATCH 4/4] modprobe: Make rmmod_do_module() contain all the
 removal sequence
Message-ID: <20220407050541.3y3lekn4mmpilbtx@ldmartin-desk2>
X-Patchwork-Hint: comment
References: <20220329090540.38255-1-lucas.demarchi@intel.com>
 <20220329090540.38255-7-lucas.demarchi@intel.com>
 <Yk4St0mFuGCXzKtB@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Yk4St0mFuGCXzKtB@bombadil.infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed, Apr 06, 2022 at 03:22:47PM -0700, Luis Chamberlain wrote:
>On Tue, Mar 29, 2022 at 02:05:40AM -0700, Lucas De Marchi wrote:
>> Move the remaining part of the removal sequence dangling in
>> rmmod_do_remove_module() to rmmod_do_module() so we can consider this
>> function is the one controlling all the module removals.
>>
>> While at it, add some comments about the removal order and normalize
>> coding style in this function.
>>
>> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
>
>Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

thanks, pushed.

Lucas De Marchi

>
>  Luis
