Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5970EC433F5
	for <linux-modules@archiver.kernel.org>; Wed,  2 Mar 2022 09:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235825AbiCBJOp (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 2 Mar 2022 04:14:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234297AbiCBJOo (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 2 Mar 2022 04:14:44 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC895AD124;
        Wed,  2 Mar 2022 01:14:01 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id AD8CE1F3A3;
        Wed,  2 Mar 2022 09:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646212440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iGHUhCKOcL2n+qE6pqmO8+pq2D/DVGIVQ+mXRoLijqs=;
        b=qvuvP3EhWuPyXu9sMldVsa/vfPluJhI6BG/09ApuutwLo2e5Le7xXS0ewEG4POuNOybSil
        TRcNJrLYcLY1mi9kVTRXkR+ZHSp4jNMXm6/ZhUpdirt7P1eTlG+gHm/6rjeniY1Cw69zKc
        yUM5ixk4GoJPB3lUz7cuCIL3ngox0+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646212440;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iGHUhCKOcL2n+qE6pqmO8+pq2D/DVGIVQ+mXRoLijqs=;
        b=2kigCNPQ+fQ+7VQ2rUnjbbn1LEzipYFTcvqL8SjD9maOmC8Mi2gLkohXdrEWBhgUZ6wooy
        9bQSWnOHHvFhQQCQ==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 45D2BA3B81;
        Wed,  2 Mar 2022 09:14:00 +0000 (UTC)
Date:   Wed, 2 Mar 2022 10:14:00 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     cgel.zte@gmail.com
cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lv Ruyi <lv.ruyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] module: avoid calling synchronize_rcu()
In-Reply-To: <20220302011306.2054550-1-lv.ruyi@zte.com.cn>
Message-ID: <alpine.LSU.2.21.2203021012250.5895@pobox.suse.cz>
References: <20220302011306.2054550-1-lv.ruyi@zte.com.cn>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Hi,

On Wed, 2 Mar 2022, cgel.zte@gmail.com wrote:

> From: Lv Ruyi (CGEL ZTE) <lv.ruyi@zte.com.cn>
> 
> Kfree_rcu() usually results in even simpler code than does 
> synchronize_rcu() without synchronize_rcu()'s multi-millisecond
> latency, so replace synchronize_rcu() with kfree_rcu().
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Lv Ruyi (CGEL ZTE) <lv.ruyi@zte.com.cn>
> ---
>  kernel/module.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/module.c b/kernel/module.c
> index 6cea788fd965..767b5f9e5819 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -4138,8 +4138,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
>   ddebug_cleanup:
>  	ftrace_release_mod(mod);
>  	dynamic_debug_remove(mod, info->debug);
> -	synchronize_rcu();
> -	kfree(mod->args);
> +	kfree_rcu(mod->args);

this has been proposed already. synchronize_rcu() and kfree() here are not 
really tied together. See the discussion at 
https://lore.kernel.org/all/alpine.LSU.2.21.2111301132220.3922@pobox.suse.cz/T/#u

Regards
Miroslav
