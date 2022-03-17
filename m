Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D31C433EF
	for <linux-modules@archiver.kernel.org>; Thu, 17 Mar 2022 15:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbiCQPFQ (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 17 Mar 2022 11:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234155AbiCQPFP (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 17 Mar 2022 11:05:15 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10DBF1E97
        for <linux-modules@vger.kernel.org>; Thu, 17 Mar 2022 08:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647529439; x=1679065439;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=S5ZEVpV2Xf32oj8w7DkTAu3LkpVjB01L0xNItazm8iE=;
  b=UcibONJgGY/JZKWt7t96n6tyYtTGtFbDeMXnfUoHPdiwlEg5s4UqlEj4
   PZR4sIYPsgsmAxWC1n6+xqpDwUiiBfDNRbT2NsWHf6wWbCFmGv82rxChf
   ng3vL4sNnqE2z1wBENTcl24lwJUUElyXzSaEzMXvxPEgoM8B8zWVqDfvd
   k1ZAUmBKaSdB+gaGkS4gSxxt1NlfqjZfITwJQY7KB3yjzG6EzaKwfT1+l
   puiVp+Jt2rXzL8h7SBV5mOOEgcwopRb32nLsaZ7f4lV+g97NvYg/FbQpS
   MZajL20C6l3Czym4YbReYVdsYgnkBPH7gKIaK/+6q0fT40GvFRAFJbIGp
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="236829913"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="236829913"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 08:02:44 -0700
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="516792040"
Received: from cjmartin-mobl.amr.corp.intel.com (HELO ldmartin-desk2) ([10.209.31.111])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 08:02:44 -0700
Date:   Thu, 17 Mar 2022 08:02:42 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Saul Wold <Saul.Wold@windriver.com>
Cc:     linux-modules@vger.kernel.org
Subject: Re: depmod scanning / priority question
Message-ID: <20220317150242.g5rduzbk6sbpyqsd@ldmartin-desk2>
X-Patchwork-Hint: comment
References: <4b6c4e71-c7e7-f9f2-3072-bd0a66926143@windriver.com>
 <20220309182552.zxlaj3at4sja2b3t@ldmartin-desk2>
 <2f6ef6e8-3202-32ec-e07f-8bc512276e95@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2f6ef6e8-3202-32ec-e07f-8bc512276e95@windriver.com>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, Mar 17, 2022 at 07:38:02AM -0700, Saul Wold wrote:
>
>
>On 3/9/22 10:25, Lucas De Marchi wrote:
>>Hi Saul,
>>
>>On Wed, Mar 09, 2022 at 10:09:58AM -0800, Saul Wold wrote:
>>>
>>>Hi Lucas,
>>>
>>>I work on the Yocto Project and we recently started to add kernel 
>>>module .debug info in <modpath>/.debug/<module>.ko.  When depmod 
>>>is run, we are seeing that it might pick up the debug module 
>>>instead of the correct module.
>>>
>>>This will cause an "Unknown symbol" failure when it picks the 
>>>.debug .ko file.
>>>
>>>I am wondering if the correct solution is for depmod and kmod 
>>>related tools to ignore the .debug directory instead of traversing 
>>>down and processing those modules? I think the code in 
>>>depmod_modules_search_file() should maybe ignore the .debug 
>>>directory.
>>>
>>>I looked at depmod and see that it compares priority and seems to 
>>>randomly choose between the 2 if priority is equal as sometimes 
>>>the non-debug .ko is selected.
>>
>>>Thoughts?  Concerns with a change to ignore the .debug directory 
>>>in depmod?
>>
>>I think this is very specific to the way you're adding debug
>>information. I'm a bit worried about ignoring a few special directories
>>inside the modules directory. Maybe all you need is to ship the debug
>>info to side directory and configure depmod.d to search there (if that
>>is what you want)?
>>
>Adding the .debug directory is a well documented part of binutils / 
>gdb and the Yocto Project / Openembedded environments use the .debug 
>subdirectory to store the split debug_info. The splitting is done to 
>help reduce the size when creating an embedded target system. But we 
>need those files when working on debugging the target system, so they 
>are optionally installable.
>
>>See man depmod.d. This would probably what you'd need for a side
>>"debug/" directory, where you give preference to the debug one:
>>
>>     search debug built-in
>>
>This is kind of opposite of what I think is needed.  I don't want to 
>search the split .debug/<mod>.ko files as they are just needed for 
>debugging. The debug_info related <mod>.ko will typically fail to load 
>due to missing symbol info.
>
>>Would that work for you?
>>
>Honestly, not really as the Yocto Project / OpenEmbedded uses the 
>.debug directory to deliver the split debug_info in the standard way 
>as defined by binutils/gdb and other tools.
>
>I think an ignore vs search directive might be better.

yeah, an ignore directive to depmod.d would be ok to add. So, do you have
a .debug per directory in /lib/modules/$kver/?

>
>Hope this helps to clarify the reasoning.

yes, it does.

thanks
Lucas De Marchi

>
>Sau!
>
>>Please consider Cc'ing linux-modules@vger.kernel.org to get additional
>>feeback from other distros/people.
>>
>>Lucas De Marchi
>>
>>>
>>>Thanks for your time.
>>>-- 
>>>Sau!
>
>-- 
>Sau!
