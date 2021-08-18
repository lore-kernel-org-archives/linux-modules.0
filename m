Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80EF6C4338F
	for <linux-modules@archiver.kernel.org>; Wed, 18 Aug 2021 11:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CF756104F
	for <linux-modules@archiver.kernel.org>; Wed, 18 Aug 2021 11:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233798AbhHRLmi (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 18 Aug 2021 07:42:38 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50906 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235698AbhHRLmh (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 18 Aug 2021 07:42:37 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BE3381FFB9
        for <linux-modules@vger.kernel.org>; Wed, 18 Aug 2021 11:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629286900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ultDOZYdDU7TZNz6W8rGRtvt5nA/jshN0abeiN5v5LI=;
        b=iPnjw35FnQLB3QXKwdlLblHanzZWG0NB4FtfpZeJr6c/8QkZUXdI3cMQztT5K5BwJJBeq5
        aYCB5vPmRnprjUUwndOuT+DPuC5IcN7FtqUcVzvhinDr+3UkKRCopFrASshn4TeFZl6kHA
        vgVWZ7OjKntIgqbSg4zdNIiSgZocIxs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629286900;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ultDOZYdDU7TZNz6W8rGRtvt5nA/jshN0abeiN5v5LI=;
        b=m+AW7XZ6uIZZEbYKRjeUoDOAz9Gr8mOwtpUxYp8U6ekq5TJD+Hp4Za5m2d6U8StTHw9J8X
        Od+BHymg2Tif9XAA==
Received: from kunlun.suse.cz (unknown [10.100.128.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B50D9A3B96;
        Wed, 18 Aug 2021 11:41:40 +0000 (UTC)
Date:   Wed, 18 Aug 2021 13:41:39 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-modules@vger.kernel.org
Subject: Re: [PATCH] modinfo: don't parse built-in for explicitly given
 module files
Message-ID: <20210818114139.GG153889@kunlun.suse.cz>
References: <20210818112203.24863-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210818112203.24863-1-tiwai@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed, Aug 18, 2021 at 01:22:03PM +0200, Takashi Iwai wrote:
> A recent bug report showed that modinfo doesn't give the signature
> information for certain modules, and it turned out to happen only on
> the modules that are built-in on the running kernel; then modinfo
> skips the signature check, as if the target module file never exists.
> The behavior is, however, inconsistent when modinfo is performed for
> external modules (no matter which kernel version is) and the module
> file path is explicitly given by a command-line argument, which
> guarantees the presence of the module file itself.
> 
> This patch addresses the regression by checking the presence of the
> module path at first before checking the built-in module.
> 
> Fixes: e7e2cb61fa9f ("modinfo: Show information about built-in modules")
> BugLink: https://bugzilla.opensuse.org/show_bug.cgi?id=1189537
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Reviewed-by: Michal Suchánek <msuchanek@suse.de>

LGTM

Thanks
> ---
>  libkmod/libkmod-module.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
> index 6e0ff1a99604..9e878a5345a1 100644
> --- a/libkmod/libkmod-module.c
> +++ b/libkmod/libkmod-module.c
> @@ -2292,7 +2292,8 @@ KMOD_EXPORT int kmod_module_get_info(const struct kmod_module *mod, struct kmod_
>  	assert(*list == NULL);
>  
>  	/* remove const: this can only change internal state */
> -	if (kmod_module_is_builtin((struct kmod_module *)mod)) {
> +	if (!kmod_module_get_path(mod) &&
> +	    kmod_module_is_builtin((struct kmod_module *)mod)) {
>  		count = kmod_builtin_get_modinfo(mod->ctx,
>  						kmod_module_get_name(mod),
>  						&strings);
> -- 
> 2.26.2
> 
