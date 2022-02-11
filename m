Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E48FC433F5
	for <linux-modules@archiver.kernel.org>; Fri, 11 Feb 2022 10:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239244AbiBKKpY (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 11 Feb 2022 05:45:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235287AbiBKKpY (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 11 Feb 2022 05:45:24 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5008726D
        for <linux-modules@vger.kernel.org>; Fri, 11 Feb 2022 02:45:23 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id d14-20020a05600c34ce00b0037bf4d14dc7so5327971wmq.3
        for <linux-modules@vger.kernel.org>; Fri, 11 Feb 2022 02:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fK7spISDq1+DjNefyyUtNVcGuza0FcRsoDnzaplTZCU=;
        b=lZJQHf3uhTJdZHq0M7PXOcIQ64Db3ElTT73hIrIc7I+msSD3rq7HAghvCK5UvyMr1L
         EjxCG3TkRcJdejGLEPiUO4jx13C3ITmGxUbt5KOQou6hw+mRr92Wv9xCz4eyxZlvYY4p
         j3R2yQOQTyW+tZujIzIzporVG1GtZq7Dg2xO7UbSjre0Epe+lZ7dIobTkC53RWHV1tw2
         vDHKiLenibCmba8ZuzgT8qgslzaBcNHpvT5Y7cBbCvQ5947IygpfvYctKY6tzmj9yFUQ
         dx81qmc40Y+vAVEvk3kzssXzxi5TRXHKltgWDZp6Hp1QxSJpdOb2eNfnBTFPxVjRY7AP
         Ro7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fK7spISDq1+DjNefyyUtNVcGuza0FcRsoDnzaplTZCU=;
        b=HcMKzsrbcNz3r2x/hRcsjTz8hTfohWZtJWjMPOwBqpKABBcT8fhy023uAQU8BRfg3m
         mEudsHvqQU7S1Hpu2Ztc9A194zO6MedxIZjobnBZScfoN0CGOFh2ZYVGWdrqD39GkU5n
         LWvWukKZgk3FB48iLIg8kx3u5E0w/++EYTN5Qm0mGimW612tqWispB/MKpg1zY1z+dAA
         ntzzZ5vMurW0/NRK27Oz+4+J7SUR1Mc/rK6ABoZdc9lMn0nrD3JeF/m2unT/iQwV2lcE
         Av993Dc5qDvWEbIJtJzL8JfOY4Kd1wr1a3I5gYkgj1xPTcPrIzTFOv3V5JXVSDUBwgzd
         tnqA==
X-Gm-Message-State: AOAM530lccq2NKE8HWiEiAKZjh47UADKfSFm0J+6BDVjdGFQZLwsB/7j
        RqEZOObg5XsatoSZLnxayKQ=
X-Google-Smtp-Source: ABdhPJwX5VlZZuXnrbWOZn3ftsDLmdCPb4TDNYl+V/7PmZvUq45wj/XQSnVNaMS+CgHJstqLLIsZIg==
X-Received: by 2002:a05:600c:17c7:: with SMTP id y7mr1636394wmo.40.1644576321585;
        Fri, 11 Feb 2022 02:45:21 -0800 (PST)
Received: from example.org (ip-78-45-37-102.net.upcbroadband.cz. [78.45.37.102])
        by smtp.gmail.com with ESMTPSA id u7sm12923702wrq.112.2022.02.11.02.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 02:45:20 -0800 (PST)
Date:   Fri, 11 Feb 2022 11:45:16 +0100
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     linux-modules@vger.kernel.org
Subject: Re: [PATCH 1/3] libkmod: Prefer builtin index over builtin.alias
Message-ID: <20220211104516.5i3selmqfd7rsxxw@example.org>
References: <20220211084230.4489-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211084230.4489-1-lucas.demarchi@intel.com>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Fri, Feb 11, 2022 at 12:42:28AM -0800, Lucas De Marchi wrote:
> The modules.builtin.alias.bin is way larger than the
> modules.builtin.bin.  On a normal "distro kernel":
> 
> 	21k modules.builtin.alias.bin
> 	11k modules.builtin.bin
> 
> >From the kernel we get both modules.builtin and modules.builtin.modinfo.
> depmod generates modules.builtin.bin and modules.builtin.alias.bin
> from them respectively. modules.bultin is not going away: it's not
> deprecated by the new index added. So, let's just stop duplicating the
> information inside modules.builtin.alias.bin and just use the other
> index.
> ---
>  libkmod/libkmod-module.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
> index 6f7747c..40d394a 100644
> --- a/libkmod/libkmod-module.c
> +++ b/libkmod/libkmod-module.c
> @@ -576,13 +576,14 @@ KMOD_EXPORT int kmod_module_new_from_lookup(struct kmod_ctx *ctx,
>  	err = kmod_lookup_alias_from_aliases_file(ctx, alias, list);
>  	CHECK_ERR_AND_FINISH(err, fail, list, finish);
>  
> +	DBG(ctx, "lookup modules.builtin %s\n", alias);
> +	err = kmod_lookup_alias_from_builtin_file(ctx, alias, list);
> +

assigning to the err variable looks useless. It will be overwritten
anyway.

>  	DBG(ctx, "lookup modules.builtin.modinfo %s\n", alias);
>  	err = kmod_lookup_alias_from_kernel_builtin_file(ctx, alias, list);
> -	if (err == -ENOSYS) {
> -		/* Optional index missing, try the old one */
> -		DBG(ctx, "lookup modules.builtin %s\n", alias);
> -		err = kmod_lookup_alias_from_builtin_file(ctx, alias, list);
> -	}
> +	/* Optional index missing, ignore */
> +	if (err == -ENOSYS)
> +		err = 0;
>  	CHECK_ERR_AND_FINISH(err, fail, list, finish);
>  
>  
> -- 
> 2.35.1
> 

-- 
Rgrds, legion

