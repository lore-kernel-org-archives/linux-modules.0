Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8257C54EE9
	for <linux-modules@archiver.kernel.org>; Wed,  7 Sep 2022 15:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiIGPX6 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 7 Sep 2022 11:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiIGPX4 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 7 Sep 2022 11:23:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114A1B7EDC
        for <linux-modules@vger.kernel.org>; Wed,  7 Sep 2022 08:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662564223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+TiBDwzUMwuA8zr/qVC4cXXeItR3hCv3DGvVOTqvT4Q=;
        b=L932411wENBieNEfqxmGBa/8SW5LhOXQSWmEijMVzW6TKWMfb+Fx1gXIdmuxiYDX2GqRg+
        FprdYAktg/gBgYDB8mf55ZyigNj5G0/gOyljPbb1iU7of38Eg5MJGc3W9c8MZKWeOYMQ37
        IA1M9o/WzvVhkkyzMi+dgsm2atcUUpo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-643-Fe-0ttXeOeSDaL6Ag-kN5A-1; Wed, 07 Sep 2022 11:23:42 -0400
X-MC-Unique: Fe-0ttXeOeSDaL6Ag-kN5A-1
Received: by mail-wm1-f72.google.com with SMTP id ay21-20020a05600c1e1500b003a6271a9718so7549377wmb.0
        for <linux-modules@vger.kernel.org>; Wed, 07 Sep 2022 08:23:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=+TiBDwzUMwuA8zr/qVC4cXXeItR3hCv3DGvVOTqvT4Q=;
        b=O/WwP5E/yqdQMgtjvL9YsYeoCdf+IhdcVhAwLio/MxWVaRCmsoKFoczVz5kreLQoTs
         AZ8qLmjGBDATpyhNZg5nMYUT+15KyFoua5iU0rKT1WPCVt9ILdR+K40B/6FC9/ceB4+I
         NG21jcP3aqPP6yOoFQZPpvHK0Q29B+OR0aeV1uA1sr4v5mNclCSZYovo+YS74y2S8wKl
         /BlXt4vsnTl7O5LdJeOyUfCOSek6deKlEe7koEChJJteP6qBOK6wPhNNA2/DfS7LLUmg
         ZhawemsGH1EvAWYdr86Od2KlVQw+KcJE9M/JE1DMKsQiDTE56Sv3my79bpmY/gHhc2Q/
         bP6A==
X-Gm-Message-State: ACgBeo0GqhyZvqNUFJREa7f0QYhC5Polw7yBzarC6/pRp5w+vzWDU9y/
        vjf1cz7Nz7bf7Gr9O1AWCcYmF3FKNj+uasR0MzXYZrRI6oOuWtxp6uE+n415jX6fjPJZS8WDFN0
        cKEBKfoRi2tsdacqjLpGZKye5
X-Received: by 2002:a05:6000:11ca:b0:228:632c:76c8 with SMTP id i10-20020a05600011ca00b00228632c76c8mr2564085wrx.612.1662564219616;
        Wed, 07 Sep 2022 08:23:39 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5mfANCJxn8n3V1FktoZGErJCkTRp1cV+ja4Vofvq0yThZoU+NK5xVFVKHN1bAfHTf1vlTUCw==
X-Received: by 2002:a05:6000:11ca:b0:228:632c:76c8 with SMTP id i10-20020a05600011ca00b00228632c76c8mr2564076wrx.612.1662564219380;
        Wed, 07 Sep 2022 08:23:39 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id q1-20020a05600c2e4100b003a2cf1ba9e2sm18051498wmf.6.2022.09.07.08.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 08:23:38 -0700 (PDT)
Date:   Wed, 7 Sep 2022 16:23:38 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     David Disseldorp <ddiss@suse.de>
Cc:     dmitry.torokhov@gmail.com, mcgrof@kernel.org,
        linux-modules@vger.kernel.org
Subject: Re: [PATCH resend] module/decompress: generate sysfs string at
 compile time
Message-ID: <20220907152338.e6bw7qlgsa3ifcpe@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220906080317.15426-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220906080317.15426-1-ddiss@suse.de>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue 2022-09-06 10:03 +0200, David Disseldorp wrote:
> compression_show() before (with noinline):
>    0xffffffff810b5ff0 <+0>:     mov    %rdx,%rdi
>    0xffffffff810b5ff3 <+3>:     mov    $0xffffffff81b55629,%rsi
>    0xffffffff810b5ffa <+10>:    mov    $0xffffffff81b0cde2,%rdx
>    0xffffffff810b6001 <+17>:    call   0xffffffff811b8fd0 <sysfs_emit>
>    0xffffffff810b6006 <+22>:    cltq
>    0xffffffff810b6008 <+24>:    ret
> 
> After:
>    0xffffffff810b5ff0 <+0>:     mov    $0xffffffff81b0cde2,%rsi
>    0xffffffff810b5ff7 <+7>:     mov    %rdx,%rdi
>    0xffffffff810b5ffa <+10>:    call   0xffffffff811b8fd0 <sysfs_emit>
>    0xffffffff810b5fff <+15>:    cltq
>    0xffffffff810b6001 <+17>:    ret
> 
> Signed-off-by: David Disseldorp <ddiss@suse.de>
> ---
>  kernel/module/decompress.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Resend: Maintainer addresses added.
> 
> Feel free to drop the to-be-expected commit message body if desired.
> 
> diff --git a/kernel/module/decompress.c b/kernel/module/decompress.c
> index 4d0bcb3d9e449..c033572d83f0e 100644
> --- a/kernel/module/decompress.c
> +++ b/kernel/module/decompress.c
> @@ -256,7 +256,7 @@ void module_decompress_cleanup(struct load_info *info)
>  static ssize_t compression_show(struct kobject *kobj,
>  				struct kobj_attribute *attr, char *buf)
>  {
> -	return sysfs_emit(buf, "%s\n", __stringify(MODULE_COMPRESSION));
> +	return sysfs_emit(buf, __stringify(MODULE_COMPRESSION) "\n");
>  }
>  
>  static struct kobj_attribute module_compression_attr = __ATTR_RO(compression);
> -- 
> 2.35.3
> 

Reviewed-by: Aaron Tomlin <atomlin@redhat.com>

-- 
Aaron Tomlin

