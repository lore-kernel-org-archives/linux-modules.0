Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8017DC433F5
	for <linux-modules@archiver.kernel.org>; Wed, 16 Feb 2022 19:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238437AbiBPT5t (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 16 Feb 2022 14:57:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238439AbiBPT5q (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 16 Feb 2022 14:57:46 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5985222DFA
        for <linux-modules@vger.kernel.org>; Wed, 16 Feb 2022 11:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645041453; x=1676577453;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ACirr96ALAZIV9RjRnkRT/5rQUo6FV6/wNSCe7xNH38=;
  b=I7wMAOME2P0J1dmzKCsUg1772pqWBg3SZuqTAmh5VJYBPYMuKfTgTa0F
   2PQrjAOs+OBOBUGTCj2mf4zDqN0fQy9OfiW9QvYDvNuVDuBneRgNVSiI1
   1+lSJ0+4w2EsxkiMQPDM4rV1363s3yTgY2x++lhGeYi2x0CCaxh8rUa8K
   xerFIT2O1VMkCOEaK3d5iNKIVjnQUDIG8c4Ak80aVS5+DdI2IdMimnB6O
   cOhZ7cs2/Zd7bIFairKDpfRVZKeqekfh1fvEpqkdoP6eYC2IBUv3BsxYR
   x5Ek5g6Aa9b6YhV7Ew/d6WefB8KLsp++ekVPYzXIRFTK3Wc8usRIfCxVq
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="250910443"
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="250910443"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 11:57:33 -0800
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="776619320"
Received: from dcanchal-mobl1.ger.corp.intel.com (HELO ldmartin-desk2) ([10.212.233.152])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 11:57:33 -0800
Date:   Wed, 16 Feb 2022 11:57:30 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-modules@vger.kernel.org
Subject: Re: [PATCH 8/8] modinfo: Allow to force arg as module name
Message-ID: <20220216195730.nixxq7qe7pelihhf@ldmartin-desk2>
X-Patchwork-Hint: comment
References: <20220216075533.185693-1-lucas.demarchi@intel.com>
 <20220216075533.185693-9-lucas.demarchi@intel.com>
 <Yg1GyO6wDQVtveQC@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Yg1GyO6wDQVtveQC@bombadil.infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed, Feb 16, 2022 at 10:47:36AM -0800, Luis Chamberlain wrote:
>On Tue, Feb 15, 2022 at 11:55:33PM -0800, Lucas De Marchi wrote:
>> With the new -m|--modname option it's possible to query the information about this (builtin):
>
>Query what information?

any of the fields exposed by the module or builtin. The phrase got
truncated by wrong copy and paste. See below

>
>> 	$ modinfo --modname crc32
>> 	module explicitly:
>
>explicitly seems a bit odd, its not clear if the information below
>is because its a module or what. Maybe module details?

ugh... this was a wrong copy/paste in the commit message. That "module
explicitely" is not in the output at all, and was rather part of the
previous paragraph. It should had been something like:


With the new -m|--modname option it's possible to query the information
about this (builtin) module explicitly:

	$ ./build.new/tools/modinfo --modname crc32
	name:           crc32
	filename:       (builtin)
	license:        GPL
	file:           lib/crc32
	description:    Various CRC32 calculations
	author:         Matt Domsch <Matt_Domsch@dell.com>


>> 	name:           crc32
>> 	filename:       (builtin)
>
>You know a --is-built-in option might be nice while you're at it.
>Unless we already have something like this on another tool.

to just check if a module is built-in or not? Not sure if it would be in
modinfo or modprobe (since modprobe historically got the -R to resolve
an alias).


>
>
>Other than that:
>
>Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

thanks
Lucas De Marchi
