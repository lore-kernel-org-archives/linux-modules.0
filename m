Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412D4C433F5
	for <linux-modules@archiver.kernel.org>; Wed,  2 Mar 2022 16:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241584AbiCBQUF (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 2 Mar 2022 11:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238594AbiCBQUE (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 2 Mar 2022 11:20:04 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A002E0AB
        for <linux-modules@vger.kernel.org>; Wed,  2 Mar 2022 08:19:21 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id k29-20020a05600c1c9d00b003817fdc0f00so1570052wms.4
        for <linux-modules@vger.kernel.org>; Wed, 02 Mar 2022 08:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BgI8sFrydK5FTn/7e1TRvZf45as613ywq4EmjpiUGno=;
        b=mc1v4qGg4jJ2tODesV1KU6A7Y3OYtWWWQ7Zujh/RUofxBAHg0a7ysBrtKe/wQbgZGv
         fsz4H0B/IUi0AF45fckWnnSJzJozr4Hk0akezyJfX/hKJg7zLInTC4O8bsYeqrMHWARX
         MX76OjU/C6NHHVNPohTLmneuEArql5wki6hyz++VFI0Xq8spr6FvHbsu3Au2QZRjdPC7
         YKsBvI13Sp/pZlR/eumbBsZcCL+IEts7yg7u6ZojoOfnRwvy6XCKW2BnqMBSGMXffMQB
         GU9wXpS+0eTtIu203cE4VjbYPRtgqwh18YVx/65qcTg/3PkPfLZkeqseNntSDgTSnlLP
         MVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BgI8sFrydK5FTn/7e1TRvZf45as613ywq4EmjpiUGno=;
        b=xbSVNhBA+JHuDMfAeM8kZ094iWa4u3XIUTxcABln9MC3YmEdrsa/Rk5dJnsDcHW9dA
         fsatKwpyQymUF2s8jAZZYEL7uCroR+expI6pV/fDCmKdr/p8mudUd0gdEFNTHK9tHLKj
         f4fRk5KM/CTvq04v2oSsuGtgdTb1pv5M5+VPNFoHRn6CZ7yD0PW2epA1rDpJLxurvDsI
         Hqnh8BkgIj3VMmBTYyki5kuXcmEC7IJJ06oTEkrYIYrSpsQQSQel38L3ItVGAyrIkw9Z
         65ByjQIwYzTJ90DiEuZfU73J6RM5LornBrst7mAfXUIq/BMZSDBubYqVHXn3ed/hg/Qk
         QSvA==
X-Gm-Message-State: AOAM530x8zOMt0WioyqZGwfxP1pC2amPKO3IJh3XXvcggrwWF5cTAYeH
        sgDwzoUqtQeRboBlpgW68HODGw==
X-Google-Smtp-Source: ABdhPJyYA7ctJCwfna7Guslsg1HHzVclL/ntG/Oe7hbbAwqSsQv1yNoVySgOeeCulhYwPrFwYePfjA==
X-Received: by 2002:a7b:cc0d:0:b0:381:220e:a3a0 with SMTP id f13-20020a7bcc0d000000b00381220ea3a0mr435984wmh.59.1646237959729;
        Wed, 02 Mar 2022 08:19:19 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id o3-20020a1c7503000000b0038100e2a1adsm5999091wmc.47.2022.03.02.08.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 08:19:19 -0800 (PST)
Date:   Wed, 2 Mar 2022 16:19:17 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     mcgrof@kernel.org, christophe.leroy@csgroup.eu, pmladek@suse.com,
        cl@linux.com, mbenes@suse.cz, akpm@linux-foundation.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, void@manifault.com,
        atomlin@atomlin.com, allen.lkml@gmail.com, joe@perches.com,
        msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com
Subject: Re: [PATCH v9 13/14] module: Move kdb_modules list out of core code
Message-ID: <20220302161917.gx5icfszakoye4uh@maple.lan>
References: <20220228234322.2073104-1-atomlin@redhat.com>
 <20220228234322.2073104-14-atomlin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228234322.2073104-14-atomlin@redhat.com>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Mon, Feb 28, 2022 at 11:43:21PM +0000, Aaron Tomlin wrote:
> No functional change.
> 
> This patch migrates kdb_modules list to core kdb code
> since the list of added/or loaded modules is no longer
> private.
> 
> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
> ---
>  kernel/debug/kdb/kdb_main.c    | 5 +++++
>  kernel/debug/kdb/kdb_private.h | 4 ----
>  kernel/module/main.c           | 4 ----
>  3 files changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> index 0852a537dad4..5369bf45c5d4 100644
> --- a/kernel/debug/kdb/kdb_main.c
> +++ b/kernel/debug/kdb/kdb_main.c
> @@ -59,6 +59,11 @@ EXPORT_SYMBOL(kdb_grepping_flag);
>  int kdb_grep_leading;
>  int kdb_grep_trailing;
>  
> +#ifdef CONFIG_MODULES
> +extern struct list_head modules;
> +static struct list_head *kdb_modules = &modules; /* kdb needs the list of modules */

If modules is no longer static then why do we kdb_modules at all?
kdb_modules is used exactly once and it can now simply be replaced
with &modules.


Daniel.
