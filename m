Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE426C433EF
	for <linux-modules@archiver.kernel.org>; Tue, 15 Feb 2022 07:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbiBOHnX (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 15 Feb 2022 02:43:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbiBOHnX (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 15 Feb 2022 02:43:23 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E855A1BEA
        for <linux-modules@vger.kernel.org>; Mon, 14 Feb 2022 23:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644910994; x=1676446994;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LXOwu1xjXEj6oSLye37/JS23mpMtE6+TqegPA9N3p9w=;
  b=k4K2Q29A3mjyhNhbdy0AOL/VLDrxn4fRci2v+mFrK33gaJkdOvpDs5Ex
   2vTAiPIfayDVoIUsZqx8UWUlKAFUwBN4Im7kp/luP0oO98j1eoaC38V4D
   ks3QxES0mN9K7rS5hAewp8i4S1RQYUJ7ijHZ7diIjvq5BtijLvZSDYeVC
   6XeF6Wimz1fcWJnaW+g+SbPiLBqe/Qjx3bM/E7JJOD/8oqMQGBeL2/+wQ
   YBbivLNupRY+k1fO/1OuAh++c3Td7LrVWF9IwUHigTZVLkMBdr9/47/aR
   dgjoD3lA/dFIrSlS2dgQF6e68EsRO5EwRg/rRCgW3Ayl9ps31jbKqliva
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="311007710"
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="311007710"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 23:43:13 -0800
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="502274852"
Received: from eashley-mobl.amr.corp.intel.com (HELO ldmartin-desk2) ([10.209.79.197])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 23:43:13 -0800
Date:   Mon, 14 Feb 2022 23:43:10 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     linux-modules@vger.kernel.org
Subject: Re: [PATCH v2] libkmod: Prefer builtin index over builtin.alias
Message-ID: <20220215074310.is2umkvdnsx5lk25@ldmartin-desk2>
References: <CAKi4VAJs8mC23vpvkryrdJiX2fJgkPPzb763Og4Y0vZv_JH8Gw@mail.gmail.com>
 <20220213074335.15774-1-lucas.demarchi@intel.com>
 <20220213131339.yxi3rq3q6xexqbbx@example.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220213131339.yxi3rq3q6xexqbbx@example.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Sun, Feb 13, 2022 at 02:13:39PM +0100, Alexey Gladkov wrote:
>On Sat, Feb 12, 2022 at 09:43:35PM -1000, Lucas De Marchi wrote:
>> The modules.builtin.alias.bin is way larger than the
>> modules.builtin.bin.  On a normal "distro kernel":
>>
>> 	21k modules.builtin.alias.bin
>> 	11k modules.builtin.bin
>>
>> >From the kernel we get both modules.builtin and modules.builtin.modinfo.
>> depmod generates modules.builtin.bin and modules.builtin.alias.bin
>> from them respectively. modules.bultin is not going away: it's not
>> deprecated by the new index added. So, let's just stop duplicating the
>> information inside modules.builtin.alias.bin and just use the other
>> index.
>
>The modules.builtin contains only module names. The modules.builtin.modinfo
>contains full info about builtin modules including names.
>
>I thought that if there is complete information about the modules, then
>reading the index with only the names does not make sense. And only in the
>absence of modules.builtin.modinfo, you need to fallback to the index
>with the names.

yeah, but most of the time we really need only the module name, so we
can optimize for that. And since we are not getting rid of the other
index, we can simply use it first the same way that for modules we first
do lookup on lookup modules.dep and only later on modules.aliases.

>
>> ---
>>  libkmod/libkmod-module.c | 12 +++++++-----
>>  1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
>> index 6f7747c..6423339 100644
>> --- a/libkmod/libkmod-module.c
>> +++ b/libkmod/libkmod-module.c
>> @@ -576,13 +576,15 @@ KMOD_EXPORT int kmod_module_new_from_lookup(struct kmod_ctx *ctx,
>>  	err = kmod_lookup_alias_from_aliases_file(ctx, alias, list);
>>  	CHECK_ERR_AND_FINISH(err, fail, list, finish);
>>
>> +	DBG(ctx, "lookup modules.builtin %s\n", alias);
>> +	err = kmod_lookup_alias_from_builtin_file(ctx, alias, list);
>> +	CHECK_ERR_AND_FINISH(err, fail, list, finish);
>> +
>>  	DBG(ctx, "lookup modules.builtin.modinfo %s\n", alias);
>>  	err = kmod_lookup_alias_from_kernel_builtin_file(ctx, alias, list);
>> -	if (err == -ENOSYS) {
>> -		/* Optional index missing, try the old one */
>> -		DBG(ctx, "lookup modules.builtin %s\n", alias);
>> -		err = kmod_lookup_alias_from_builtin_file(ctx, alias, list);
>> -	}
>> +	/* Optional index missing, ignore */
>> +	if (err == -ENOSYS)
>> +		err = 0;
>>  	CHECK_ERR_AND_FINISH(err, fail, list, finish);
>
>Yep. Looks good for me.

thanks
Lucas De Marchi

>
>-- 
>Rgrds, legion
>
