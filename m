Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E07C6FD19
	for <linux-modules@archiver.kernel.org>; Thu, 16 Mar 2023 08:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjCPIyn (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 16 Mar 2023 04:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjCPIyB (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 16 Mar 2023 04:54:01 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA0EB5B60
        for <linux-modules@vger.kernel.org>; Thu, 16 Mar 2023 01:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678956764; x=1710492764;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=T9mQ8sxIQb2uf8TfweMRvq1t+6hv3jrWGoUDNdPA40g=;
  b=F1eG/246I0xfHncTiRGkFJxnsbCrwyXNzaopIpHNvem1w88Y012JLc2I
   tUeTBOTiCM0I3VlTFAIoUKhZVoPyx8hlz89+DQxmDRGEbl4iR3FqRDNBK
   awGSEC6VsszjU6FctzVLIfw4pPfx3EAaqZGaJrnGEt9jUN0jCHvBu58MM
   VwhcK56O4kgajrNiiaxWw3FaoedpBLd2IQnXvcBUVUbpEXLcb6aIMFTQG
   0vF3Y7LCU5xUVHnZErTNOtAgWW24c4q6Ay8Ev5aIkMw6KzTULV9FKtOg8
   AYz7dUfulHrcr/UNQNVN5v6rKUYZbf2j0QE4KhLbqwyT4lqkEjLb/88k0
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="339459296"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="339459296"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 01:52:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="925690664"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="925690664"
Received: from janvanof-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.63.88])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 01:52:24 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Dave Airlie <airlied@gmail.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-modules@vger.kernel.org
Cc:     dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: enhancing module info to allow grouping of firmwares
In-Reply-To: <CAPM=9txaQfHkjs6nWcwBtnYQXtr996dyht7wasJ7QOovjepmAw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <CAPM=9txaQfHkjs6nWcwBtnYQXtr996dyht7wasJ7QOovjepmAw@mail.gmail.com>
Date:   Thu, 16 Mar 2023 10:52:22 +0200
Message-ID: <87v8j19iyh.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, 16 Mar 2023, Dave Airlie <airlied@gmail.com> wrote:
> Hey moduly/firmware people,
>
> We are facing a problem in the future of NVIDIA providing giant
> firmwares for their devices that are version locked with unstable
> APIs. Even if they weren't version locked we'd likely have to support
> multiple major versions over time.
>
> Now this becomes a problem because when you generate multiple
> initramfs and stick them into /boot over time the number of firmwares
> MODULE_FIRMWARE will match will increase and dracut will shove them
> all into the initramfs.
>
> I think one way to mitigate that would be to provide some sort of
> grouping of module firmwares that are acceptable, and having dracut
> only pick one from the list to provide in the initramfs (hopefully the
> latest one). That way the driver can provide a list of MODULE_FIRMWARE
> lines and userspace knows they are a group.
>
> I've just little idea how we could expose this via current module
> info, happy to try and come up with an enhanced scheme maybe with a
> fallback to just include all of them but was just wanting to get some
> feedback on whether this was something that anyone has ever considered
> before now.

A related problem is platform (or hardware generation) specific firmware
blobs that are listed with MODULE_FIRMWARE, and thus added to the
generic initramfs. What if there was a way to limit them to the specific
platform you have? Sure, a generic initramfs would need them all, but
the vast majority of installs would only need the firmware for the
hardware on the system.

See 'ls /lib/firmware/i915/ | grep -o "^..." | sort | uniq'

I don't want to distract you from your original goal, but if you're
adding some grouping mechanism, maybe try to keep an avenue open for
grouping and filtering like that too?


BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
