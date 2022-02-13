Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8323C433EF
	for <linux-modules@archiver.kernel.org>; Sun, 13 Feb 2022 13:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiBMNNw (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sun, 13 Feb 2022 08:13:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236247AbiBMNNw (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sun, 13 Feb 2022 08:13:52 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87A95F248
        for <linux-modules@vger.kernel.org>; Sun, 13 Feb 2022 05:13:45 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id h6so22742590wrb.9
        for <linux-modules@vger.kernel.org>; Sun, 13 Feb 2022 05:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ljvc+/nDJPw+FsTYwUK6boujCK9jtfrqIKhKEzHsnkw=;
        b=Q24KJAn9zWuYMFFPbIxohqin4298ksBGxso+N3huor5F+NU0a2p8Tol3MNMcaHXDaM
         MCJcN5wFxWBaFOgWQ7BGERD//CcQ4XOooDoYknmOK9BSOdWTU1DDRcqALPpVxck2dodX
         JyaDKbSvkAIT3731NRz6Z37walOzKY4UHP1zOy/dbkrQ7v9rdzGRShapfbGqGwE7TWuj
         PQXBrOsSSrJkuqHi/B+yMks5ZA7aFY3ZrUfcEPewrwVsZqIz4eLsz8+m/HJ6177N/cyD
         o/DjPrKh5R8iRM/ia1yS8qK7lQ02udAUYtELfP7i4m8A4sRxpR70qdzKXJNtBNNNt1/C
         R6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ljvc+/nDJPw+FsTYwUK6boujCK9jtfrqIKhKEzHsnkw=;
        b=rQDGHyGQepUyE+xn3KKtD848pLlRVUqv7YGp03NL38PIp+YbOUn7sZDgKJy4vD2Bwn
         T8bpF2a3dOseHM8bYJNP+PsWdVWEXeocMVi7cvmm8mY6kTr6EibROsmcHw9yWBwqQ7Xf
         2TEQxVrt/G6IKCsml7oywSd1mJo8dNu1OFW9qdcOZ5BpGsIXTe2mC5CHebJQxrh8B0oW
         OyZpGmPY3SPG7ABpakp1n/3QQQTI2nFEU9ykaUXnaSrcDDrHfcADmupj9gfqfnrnuvVU
         tGgJp5BfXzEBZAfAwfk1rFcsVjwRkQceJXkdH4l+pAebMAQWm0bRsT0M67vXa39vk9yh
         euQQ==
X-Gm-Message-State: AOAM530SpLIjuX7vAOpV1JUX+L5fe6OuA1aauWdV4mqskmd/TWGejXuq
        Ppr1QZlxD+/1PIViEOak+A8=
X-Google-Smtp-Source: ABdhPJwiTGGlp+4tlftWHpWYLZKj9hBQgMotN71IdJcSj+Ir3AR9izIP6JWcTibIuBK4tp7VWzTh9Q==
X-Received: by 2002:adf:ee11:: with SMTP id y17mr7861336wrn.410.1644758024173;
        Sun, 13 Feb 2022 05:13:44 -0800 (PST)
Received: from example.org (ip-78-45-37-102.net.upcbroadband.cz. [78.45.37.102])
        by smtp.gmail.com with ESMTPSA id 3sm21422579wrz.86.2022.02.13.05.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 05:13:43 -0800 (PST)
Date:   Sun, 13 Feb 2022 14:13:39 +0100
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     linux-modules@vger.kernel.org
Subject: Re: [PATCH v2] libkmod: Prefer builtin index over builtin.alias
Message-ID: <20220213131339.yxi3rq3q6xexqbbx@example.org>
References: <CAKi4VAJs8mC23vpvkryrdJiX2fJgkPPzb763Og4Y0vZv_JH8Gw@mail.gmail.com>
 <20220213074335.15774-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220213074335.15774-1-lucas.demarchi@intel.com>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Sat, Feb 12, 2022 at 09:43:35PM -1000, Lucas De Marchi wrote:
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

The modules.builtin contains only module names. The modules.builtin.modinfo
contains full info about builtin modules including names.

I thought that if there is complete information about the modules, then
reading the index with only the names does not make sense. And only in the
absence of modules.builtin.modinfo, you need to fallback to the index
with the names.

> ---
>  libkmod/libkmod-module.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
> index 6f7747c..6423339 100644
> --- a/libkmod/libkmod-module.c
> +++ b/libkmod/libkmod-module.c
> @@ -576,13 +576,15 @@ KMOD_EXPORT int kmod_module_new_from_lookup(struct kmod_ctx *ctx,
>  	err = kmod_lookup_alias_from_aliases_file(ctx, alias, list);
>  	CHECK_ERR_AND_FINISH(err, fail, list, finish);
>  
> +	DBG(ctx, "lookup modules.builtin %s\n", alias);
> +	err = kmod_lookup_alias_from_builtin_file(ctx, alias, list);
> +	CHECK_ERR_AND_FINISH(err, fail, list, finish);
> +
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

Yep. Looks good for me.

-- 
Rgrds, legion

