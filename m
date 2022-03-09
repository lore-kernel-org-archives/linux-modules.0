Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A63C433EF
	for <linux-modules@archiver.kernel.org>; Wed,  9 Mar 2022 12:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbiCIMHp (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 9 Mar 2022 07:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232655AbiCIMHo (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 9 Mar 2022 07:07:44 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DF517226C
        for <linux-modules@vger.kernel.org>; Wed,  9 Mar 2022 04:06:44 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id r9-20020a1c4409000000b00389d0a5c511so183709wma.5
        for <linux-modules@vger.kernel.org>; Wed, 09 Mar 2022 04:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9w9heVzYpPiBmqEaFqwp9yWy0Bb8VtkbdNSOrKleDC4=;
        b=WU8/ctVytyo6JLjL0TPYGiMIW3yR/a69nfFPLigxs0DchMWqgsFFzNLOkrjQ+MN7Dz
         HlxA0/z9+xDNMZRxRWyHpox9nBcb9EucGH14I46eHwRkQIsWByXvu8nH8sDVReeZQJd1
         g3kdz8A4RBK6+6PgeS0YFo1WZcsQlXKtXG8AgYKTy+nEA/LC2XNiPh1nSkqvQW5NOH+A
         PwVuFRrkajG/CbeW1WIlXb2El1B8QIUkgHm8LwbYbqyrraFkq3AlK476+xsSDQPlDkEw
         8y+UVPnuFUWFHpvKD72xfxyzgQ0cefCW2BquOsC2uCcFAbDHacNFbTt6HsQP4twLZg62
         9Odw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9w9heVzYpPiBmqEaFqwp9yWy0Bb8VtkbdNSOrKleDC4=;
        b=MSXGNGQJeXnh/L74x+ooEmH6sl1ArGxLEE9eLSbmuMo3n7va6NNd2jKc69Hbx1dg6h
         Ic7lcTyYJDhlqsORaZl7TbNv3RF4R4m0EWPEGWZ0VTDOZv2yTM47AjA1Xwff7gJEAVaS
         0KJncJuKJx4jqzNqV9cK7A/7pi1WCrRZgJxpzs/lX3OHynIC2RK0nnsUtElh/uCakFRn
         UtexiIPLlK42u7GZiyuPvN/BHZNf2BhlI7Vas0LQzQHsAk3rb8+5ciAn93InHql101dq
         zay1yaiQhvsB14i1596TMDW//pOvHx+KtSqrrd1KhhYVU6XzQbe/hICZrkp+Wv2qPgIM
         UAxw==
X-Gm-Message-State: AOAM531Ft9JGe8wfP197BU94PrGBE07WjTGMrGHe6yNs/xHAjH48B4Lp
        td1H1tG5VTAjbkie4Cc+i7GqaA==
X-Google-Smtp-Source: ABdhPJwLOzAS2qrrrfy5TyvWKNJ9owT27fwyrVDGuD919KVkvVJk70ON3oKCRLGfZdTh2tUZAzieIw==
X-Received: by 2002:a05:600c:54a:b0:389:90f7:1b15 with SMTP id k10-20020a05600c054a00b0038990f71b15mr3086747wmc.156.1646827602961;
        Wed, 09 Mar 2022 04:06:42 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id m3-20020a5d6a03000000b001f06621641fsm1457519wru.96.2022.03.09.04.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 04:06:42 -0800 (PST)
Date:   Wed, 9 Mar 2022 12:06:40 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     mcgrof@kernel.org, christophe.leroy@csgroup.eu, hch@infradead.org,
        cl@linux.com, mbenes@suse.cz, akpm@linux-foundation.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, void@manifault.com,
        atomlin@atomlin.com, allen.lkml@gmail.com, joe@perches.com,
        msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, pmladek@suse.com
Subject: Re: [PATCH] kdb: Remove redundant module related references
Message-ID: <20220309120640.uumh46n2l37jaddf@maple.lan>
References: <20220307174741.2889588-1-atomlin@redhat.com>
 <20220308105203.2981099-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308105203.2981099-1-atomlin@redhat.com>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue, Mar 08, 2022 at 10:52:03AM +0000, Aaron Tomlin wrote:
> Hi Luis, Christoph, Daniel,
> 
> Is this patch ok or would you rather another iteration of the series?
> Either way is fine for me. Thanks.

Another iteration makes more sense to me.

The removal of kdb_modules is semantically part of your module clean
up patch set and should certainly be included in it.

The removal of the spurious #include's in other kdb files is a
good change but it is fully independent of the module rework. AFAICT
those fixes are good with or without your changes. This suggests
these changes can be separate from the main patch set.


Daniel.

> 
> 
> No functional change.
> 
> There is no need to include linux/module.h.
> This patch addresses the above. Furthermore, we remove the list of known
> loaded modules i.e. stored in 'kdb_modules', since it is now redundant.
> 
> Fixes: 260681b3763f ("module: Move kdb module related code out of main kdb code")
> Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
> ---
>  kernel/debug/kdb/kdb_io.c       | 1 -
>  kernel/debug/kdb/kdb_keyboard.c | 1 -
>  kernel/debug/kdb/kdb_private.h  | 4 ----
>  kernel/debug/kdb/kdb_support.c  | 1 -
>  4 files changed, 7 deletions(-)
> 
> diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> index 6735ac36b718..67d3c48a1522 100644
> --- a/kernel/debug/kdb/kdb_io.c
> +++ b/kernel/debug/kdb/kdb_io.c
> @@ -9,7 +9,6 @@
>   * Copyright (c) 2009 Wind River Systems, Inc.  All Rights Reserved.
>   */
>  
> -#include <linux/module.h>
>  #include <linux/types.h>
>  #include <linux/ctype.h>
>  #include <linux/kernel.h>
> diff --git a/kernel/debug/kdb/kdb_keyboard.c b/kernel/debug/kdb/kdb_keyboard.c
> index f877a0a0d7cf..f87c750d3eb3 100644
> --- a/kernel/debug/kdb/kdb_keyboard.c
> +++ b/kernel/debug/kdb/kdb_keyboard.c
> @@ -11,7 +11,6 @@
>  #include <linux/kdb.h>
>  #include <linux/keyboard.h>
>  #include <linux/ctype.h>
> -#include <linux/module.h>
>  #include <linux/io.h>
>  
>  /* Keyboard Controller Registers on normal PCs. */
> diff --git a/kernel/debug/kdb/kdb_private.h b/kernel/debug/kdb/kdb_private.h
> index 0d2f9feea0a4..1f8c519a5f81 100644
> --- a/kernel/debug/kdb/kdb_private.h
> +++ b/kernel/debug/kdb/kdb_private.h
> @@ -226,10 +226,6 @@ extern void kdb_kbd_cleanup_state(void);
>  #define kdb_kbd_cleanup_state()
>  #endif /* ! CONFIG_KDB_KEYBOARD */
>  
> -#ifdef CONFIG_MODULES
> -extern struct list_head *kdb_modules;
> -#endif /* CONFIG_MODULES */
> -
>  extern char kdb_prompt_str[];
>  
>  #define	KDB_WORD_SIZE	((int)sizeof(unsigned long))
> diff --git a/kernel/debug/kdb/kdb_support.c b/kernel/debug/kdb/kdb_support.c
> index df2bface866e..08229ffb6b5e 100644
> --- a/kernel/debug/kdb/kdb_support.c
> +++ b/kernel/debug/kdb/kdb_support.c
> @@ -17,7 +17,6 @@
>  #include <linux/stddef.h>
>  #include <linux/vmalloc.h>
>  #include <linux/ptrace.h>
> -#include <linux/module.h>
>  #include <linux/highmem.h>
>  #include <linux/hardirq.h>
>  #include <linux/delay.h>
> -- 
> 2.34.1
> 
