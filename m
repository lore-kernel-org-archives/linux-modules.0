Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CC3C77B7D
	for <linux-modules@archiver.kernel.org>; Tue, 18 Apr 2023 14:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjDROUc (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 18 Apr 2023 10:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbjDROUb (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 18 Apr 2023 10:20:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64246198C;
        Tue, 18 Apr 2023 07:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=2rFeFzYOGnZAxGCUkkdnfhhQ2rhay3tjONhb7PwAihY=; b=Rm/1kTLv9/O9KFmi/ZHaOivpFx
        ap2fSEMjaAjYT9btLD5lFPtFuOByXQNVu3l1aWRLVIf/0RJkZ5KWa+JQd6FNxCm/dKxyEEAbNBMXC
        chwgFpbSc+fSx42hHkFHeJz3K5jVfzOWGX5q7qiz0iXqwpxVJHT5MbqBp5ij2xDcybIGcbjkyMOmx
        p4u4K8Lf3wBLS7mrw2ZzPlxDXp8JD5oeoTbYedFA/broQV9x4AbmukLsu+B+LkX0jJCKAX35Rm9Sj
        YyGvZ02//WwK2yM4TuPPALWN04L+YQjWbFl8/3aMDLVeeSQVcrqnlT3ie6nG3MXbARXVj0GojhbgT
        MPFv24Zw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pomC3-002Paf-0O;
        Tue, 18 Apr 2023 14:20:27 +0000
Message-ID: <c72c3140-0beb-22fc-1231-785f454c3fc8@infradead.org>
Date:   Tue, 18 Apr 2023 07:20:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] module: stats: fix invalid_mod_bytes typo
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230418071758.3163529-1-arnd@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230418071758.3163529-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>



On 4/18/23 00:17, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This was caught by randconfig builds but does not show up in
> build testing without CONFIG_MODULE_DECOMPRESS:
> 
> kernel/module/stats.c: In function 'mod_stat_bump_invalid':
> kernel/module/stats.c:229:42: error: 'invalid_mod_byte' undeclared (first use in this function); did you mean 'invalid_mod_bytes'?
>   229 |   atomic_long_add(info->compressed_len, &invalid_mod_byte);
>       |                                          ^~~~~~~~~~~~~~~~
>       |                                          invalid_mod_bytes
> 
> Fixes: 0d4ab68ce983 ("module: add debug stats to help identify memory pressure")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> This was probably already reported, sending the fix just in case everyone
> else else missed it so far.
> ---
>  kernel/module/stats.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/module/stats.c b/kernel/module/stats.c
> index cdcd60695399..32959ec9581f 100644
> --- a/kernel/module/stats.c
> +++ b/kernel/module/stats.c
> @@ -226,7 +226,7 @@ void mod_stat_bump_invalid(struct load_info *info, int flags)
>  	atomic_inc(&failed_load_modules);
>  #if defined(CONFIG_MODULE_DECOMPRESS)
>  	if (flags & MODULE_INIT_COMPRESSED_FILE)
> -		atomic_long_add(info->compressed_len, &invalid_mod_byte);
> +		atomic_long_add(info->compressed_len, &invalid_mod_bytes);
>  #endif
>  }
>  

-- 
~Randy
