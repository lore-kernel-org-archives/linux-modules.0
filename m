Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D73C433EF
	for <linux-modules@archiver.kernel.org>; Mon,  4 Jul 2022 14:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbiGDOp0 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 4 Jul 2022 10:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbiGDOpZ (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 4 Jul 2022 10:45:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 30F98EE13
        for <linux-modules@vger.kernel.org>; Mon,  4 Jul 2022 07:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656945923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JUaeOZcABuRzKgKBZGeq/1CmNMYL/xg0qgavZQZWuHs=;
        b=iiKqoPbzli2RKa7mF/9hJ0nINKseYkIoZOsGc2Fr3jdwmyMVpC2mx9M6c6eiCYc0JOhyGo
        Z17F6QukUz1F4JdqqhSHRFg0NuER89oC/Oh2uNEi66Kmf+CsQhMDQUFn1MqTMNjGfLiGCS
        AkNakhvZ6uWSg+mnUOcYl2HL43ZRPOA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-624-RKeLpB2JNbmDzwYWCSFq0Q-1; Mon, 04 Jul 2022 10:45:22 -0400
X-MC-Unique: RKeLpB2JNbmDzwYWCSFq0Q-1
Received: by mail-wm1-f71.google.com with SMTP id r206-20020a1c44d7000000b003a02fa133ceso347080wma.2
        for <linux-modules@vger.kernel.org>; Mon, 04 Jul 2022 07:45:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JUaeOZcABuRzKgKBZGeq/1CmNMYL/xg0qgavZQZWuHs=;
        b=ddnJA8FBu9/aleQLwgOX0NulJbzOhEsWsFEjJTov4FoC2uLBLEbe+ZbM+0G7/X1st1
         8+yD9rgKukT/maxUV5OsTMyw8o7p0+hduWXFdNpAHRnVekGw2wUAHD79cxjxOkwme6Qz
         O+YgQtA6gacEpzfyAfF20VR45gLOPcAdeBJyu9GLxQCpHoDge+Ykl0M2A2Q2/ku+4Qg4
         KQ/gJxjTvysaywrV55FssJLEwUHwfqieDYxFZZONDEwUDVcovkRBp3GlZp8ifjNgAhWg
         Jd2IFaJu4b6PjzWqKK1BDU4QZslxP80V1+eiLeCUvYkYWAwVz841fC1zhPhP3TYQso9v
         rtog==
X-Gm-Message-State: AJIora8pHXMhusYb2nNwZBuUfaNnfffpbo5GajGnfTf9qJm92GVLUtbR
        1G9h91foQtdsys+S5lswGz/UHBUX0JErI1ye0IrALqaNHq8jZyURccjLnf6AnYoMV/kOXUhBakE
        yVBKfrvK0rfVJrbHiDtM5bzAU
X-Received: by 2002:a05:6000:1869:b0:21d:6e7a:6e4 with SMTP id d9-20020a056000186900b0021d6e7a06e4mr1506221wri.295.1656945920598;
        Mon, 04 Jul 2022 07:45:20 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1s14BgUjo37HVVyUWoOAiHXHmApD2TXmLZkM1+61bzx/ROxOELV0Q4xHqfwO71nG1sCS+7XBw==
X-Received: by 2002:a05:6000:1869:b0:21d:6e7a:6e4 with SMTP id d9-20020a056000186900b0021d6e7a06e4mr1506207wri.295.1656945920417;
        Mon, 04 Jul 2022 07:45:20 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id x1-20020a1c7c01000000b003a02b135747sm19663644wmc.46.2022.07.04.07.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 07:45:19 -0700 (PDT)
Date:   Mon, 4 Jul 2022 15:45:18 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        mcgrof@kernel.org
Subject: Re: [PATCH -next] module: Use vzalloc() instead of
 vmalloc()/memset(0)
Message-ID: <20220704144518.5gjj45ldgzfl3tak@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220704120337.4119910-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220704120337.4119910-1-yangyingliang@huawei.com>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Mon 2022-07-04 20:03 +0800, Yang Yingliang wrote:
> Use vzalloc() instead of vmalloc() and memset(0) to simpify the code.
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  kernel/module/main.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index fed58d30725d..02b67abc448f 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2138,7 +2138,7 @@ static int move_module(struct module *mod, struct load_info *info)
>  
>  #ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
>  	/* Do the allocs. */
> -	ptr = vmalloc(mod->data_layout.size);
> +	ptr = vzalloc(mod->data_layout.size);
>  	/*
>  	 * The pointer to this block is stored in the module structure
>  	 * which is inside the block. Just mark it as not being a
> @@ -2151,7 +2151,6 @@ static int move_module(struct module *mod, struct load_info *info)
>  		return -ENOMEM;
>  	}
>  
> -	memset(ptr, 0, mod->data_layout.size);
>  	mod->data_layout.base = ptr;
>  #endif
>  	/* Transfer each section which specifies SHF_ALLOC */
> -- 
> 2.25.1
> 

Hi Yang,

Nice!

Reviewed-by: Aaron Tomlin <atomlin@redhat.com>


Kind regards,

-- 
Aaron Tomlin

