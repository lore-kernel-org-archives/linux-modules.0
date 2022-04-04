Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB2CC4332F
	for <linux-modules@archiver.kernel.org>; Mon,  4 Apr 2022 15:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377948AbiDDPTG (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 4 Apr 2022 11:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359409AbiDDPTG (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 4 Apr 2022 11:19:06 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336CC3C4A6
        for <linux-modules@vger.kernel.org>; Mon,  4 Apr 2022 08:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649085430; x=1680621430;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JlqkdKYnjsjwrVyDLQ5C9Ytx+1UzmLMEDAcQXlePkXk=;
  b=Nb+dxnrwLzDSvB9RootnICurv4MNXlFgxxgfyJL10VAIYhFcsQ+7lpvp
   wGiCllFFOD8Bg1m6p3n9ppiP5+2BFtUwW25HtTgJpNSq85aHqNmTBf1oj
   OxFyp0ZZkNkluSMlmSlXeLOSrCc+kUBIHsvor7IF7YhQfzWW4ndDXDano
   yxMiNHCBYMa3jiMTw85Ypo4AzHN1Pl7NWvb0ZnGeRgZeY2mH0XLQcDkwy
   E2qruTCi8t9uUSE6q4E4OFYO6ndF68gaBDKaStOrv13ldc1a2sps3lLX3
   CpiY41bECDALOHHkP/tTspfLm+NTfPPcZTmr/KNtz4kVgehv68t2kZ1bT
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="259367252"
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="259367252"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 08:17:09 -0700
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="850076632"
Received: from sdavis-mobl1.amr.corp.intel.com (HELO ldmartin-desk2) ([10.251.18.44])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 08:17:09 -0700
Date:   Mon, 4 Apr 2022 08:17:09 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-modules <linux-modules@vger.kernel.org>
Subject: Re: [PATCH 1/2] modprobe: fix the NULL-termination of new_argv
Message-ID: <20220404151709.vntov5ibaenms4ki@ldmartin-desk2>
X-Patchwork-Hint: comment
References: <20220210021423.3388827-1-masahiroy@kernel.org>
 <CAK7LNAS+NK7dmBcqpO3x_MOhqjWyt3SLkwJE1O-zvGUH255ZsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAK7LNAS+NK7dmBcqpO3x_MOhqjWyt3SLkwJE1O-zvGUH255ZsA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Mon, Apr 04, 2022 at 01:57:41AM +0900, Masahiro Yamada wrote:
>Hi Lucas,
>
>Ping?

sorry for the delay. These 2 patches look good to me.

Applied. Thanks

Lucas De Marchi

>
>
>On Thu, Feb 10, 2022 at 11:14 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>>
>> The number of new arguments is (i + argc - 1) as it is set to *p_argc
>> one line below.
>>
>> The correct location of NULL termination is new_argv[i + argc - 1].
>>
>> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>> ---
>>
>>  tools/modprobe.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/modprobe.c b/tools/modprobe.c
>> index 9387537..b6b2947 100644
>> --- a/tools/modprobe.c
>> +++ b/tools/modprobe.c
>> @@ -743,7 +743,7 @@ static char **prepend_options_from_env(int *p_argc, char **orig_argv)
>>         }
>>
>>         memcpy(new_argv + i, orig_argv + 1, sizeof(char *) * (argc - 1));
>> -       new_argv[i + argc] = NULL;
>> +       new_argv[i + argc - 1] = NULL;
>>         *p_argc = i + argc - 1;
>>
>>         return new_argv;
>> --
>> 2.32.0
>>
>
>
>-- 
>Best Regards
>Masahiro Yamada
