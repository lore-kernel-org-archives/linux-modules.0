Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565C3C433EF
	for <linux-modules@archiver.kernel.org>; Wed, 15 Jun 2022 16:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241710AbiFOQbf (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 15 Jun 2022 12:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356055AbiFOQbd (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 15 Jun 2022 12:31:33 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB92840A1C
        for <linux-modules@vger.kernel.org>; Wed, 15 Jun 2022 09:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655310692; x=1686846692;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x/pdN0lZ0oPaR/HhsgW8BO6vJTL/PT/jlUK2OuZ3R4c=;
  b=C7Ln//TqhcKAGG62lFkD2klgNw+0/ICjQzVb0Z+iSLhrWwF5L2jhvdo9
   jHQpd2U4Ged4dkL6p47P6lQK2r41mGek9/ryNZwyQjCd2ch6BSvnaTM6y
   Waz/iexxXAPgDevFhtL1OfxvkeVMsmRJz1TJ9zv2ks5Igk01VRoCWHVfb
   cZA1Xxcv/zeYzSKc0ba/WdCdf0l4fo+2ywqasqdRDXkWA0ieRdJ9T7vxo
   q2E0lXW2E4KQBvGm0hvGzJ+2Fj2BWjwVJIjk5vrLHp6ITc1qVwS3sEA1W
   Qg78zjExWMhCX4O3NM/2rBWiN26IPtRksDqot3Mq0xvrOBKGMQt+nrZpz
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="277816136"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="277816136"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 09:31:31 -0700
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="641089099"
Received: from gkonidal-mobl2.amr.corp.intel.com (HELO ldmartin-desk2) ([10.212.170.1])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 09:31:31 -0700
Date:   Wed, 15 Jun 2022 09:31:29 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc:     linux-modules@vger.kernel.org, mcgrof@kernel.org
Subject: Re: [PATCH 0/8] Add --wait to modprobe -r
Message-ID: <20220615163129.sy23yezwsx7xyhyj@ldmartin-desk2>
References: <20220603215047.9607-1-lucas.de.marchi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220603215047.9607-1-lucas.de.marchi@gmail.com>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Luis, are you still interested in the --wait to modprobe? If so, could
you take a look in this series?

If there is still interest for the fs tests, I want to bring this in and
then do release. Otherwise I may just leave it for the next release when
I plan to move stuff from modprobe to the library, particularly related
to the module removal.

thanks
Lucas De Marchi

On Fri, Jun 03, 2022 at 02:50:39PM -0700, Lucas De Marchi wrote:
>Keep trying to remove the module if it's failing with EAGAIN. This is an
>alternative to
>
>v1: https://lore.kernel.org/linux-modules/20210803202417.462197-1-mcgrof@kernel.org/
>v2: https://lore.kernel.org/linux-modules/20210810051602.3067384-1-mcgrof@kernel.org/
>
>The v2 above or variand thereof would be probably a better way, but
>unfortunately we can't poll the refcnt file in sysfs to get notified
>when it reaches 0. The alternative in v1, with sleep(), uses an arbitrary
>interval/maximum. It's not something I'm very  confortable to add to the
>library side. So, add a quick implementation in modprobe to allow it
>to remove the module and wait up until a maximum timeout. Intention is
>to later migrate part of the logic in modprobe to libkmod, including for
>example the holders removal recently fixed.
>
>Lucas De Marchi (8):
>  modprobe: Move -R to "Query options"
>  libkmod: Allow to ignore log message on module removal
>  module-playground: Add debugfs entry in mod-simple
>  util: Add time-related functions from testsuite
>  util: Add msec variants for time-related functions
>  util: Add exponential backoff sleep
>  testsuite: Add tests for sleep calculation
>  modprobe: Add --wait
>
> libkmod/libkmod-module.c                 | 13 ++--
> libkmod/libkmod.h                        |  2 +
> man/modprobe.xml                         | 17 ++++++
> shared/util.c                            | 72 ++++++++++++++++++++++
> shared/util.h                            | 17 ++++++
> testsuite/module-playground/mod-simple.c | 18 +++++-
> testsuite/test-util.c                    | 41 +++++++++++++
> testsuite/testsuite.c                    | 14 +----
> tools/modprobe.c                         | 76 ++++++++++++++++++++----
> 9 files changed, 240 insertions(+), 30 deletions(-)
>
>-- 
>2.36.1
>
