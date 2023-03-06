Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34523C6FA99
	for <linux-modules@archiver.kernel.org>; Mon,  6 Mar 2023 17:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjCFR1i (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 6 Mar 2023 12:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjCFR1h (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 6 Mar 2023 12:27:37 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A319B4BE94;
        Mon,  6 Mar 2023 09:26:57 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="335639571"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="335639571"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 09:25:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="653682588"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="653682588"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 06 Mar 2023 09:25:43 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy@kernel.org>)
        id 1pZEak-00GXoC-0F;
        Mon, 06 Mar 2023 19:25:42 +0200
Date:   Mon, 6 Mar 2023 19:25:41 +0200
From:   Andy Shevchenko <andy@kernel.org>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     Lee Jones <lee@kernel.org>, mcgrof@kernel.org,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Subject: Re: [PATCH 04/27] mfd: intel_soc_pmic_crc: remove MODULE_LICENSE in
 non-modules
Message-ID: <ZAYiFZ7VgBl3mOzq@smile.fi.intel.com>
References: <20230224150811.80316-1-nick.alcock@oracle.com>
 <20230224150811.80316-5-nick.alcock@oracle.com>
 <Y/joT9FM5Q8Fz7Hw@smile.fi.intel.com>
 <20230303110155.GD2420672@google.com>
 <87lek97qvc.fsf@esperi.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lek97qvc.fsf@esperi.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Mon, Mar 06, 2023 at 05:04:55PM +0000, Nick Alcock wrote:
> On 3 Mar 2023, Lee Jones spake thusly:

...

> If this is generally annoying I guess I can rejig things to use --cc-cmd
> instead, somehow, but it was very convenient because it meant the
> machinery which split up the commits could also compute the Cc list at
> the same time without having to record it separately, but I assumed it
> was routinely done from the number of Cc: trailers already in the kernel
> tree...

For myself I have created a "smart" script [1], which I use on daily basis.
Feel free to take it, use it, give a feedback, etc.

[1]: https://github.com/andy-shev/home-bin-tools/blob/master/ge2maintainer.sh

-- 
With Best Regards,
Andy Shevchenko


