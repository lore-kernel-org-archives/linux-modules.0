Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317DDC761A6
	for <linux-modules@archiver.kernel.org>; Wed, 29 Mar 2023 13:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjC2N6f (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 29 Mar 2023 09:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjC2N6c (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 29 Mar 2023 09:58:32 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112EC449A
        for <linux-modules@vger.kernel.org>; Wed, 29 Mar 2023 06:58:22 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.96.253]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N7iT4-1qUaHc07Jy-014gOO; Wed, 29 Mar 2023 15:58:14 +0200
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id 7D4673C1C5; Wed, 29 Mar 2023 15:58:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1680098292; bh=h7Nd2Mi6vc6PN+rCmD5vTezFDtRMSlime6jIJkm28Ek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YSgs+7vdb/oBIUDVh9D8d81uHd8lgqOIccfXnM5AufFvf3vH+1uAU3Uz4zhd4ylEU
         SDVtE7mUlvslZk6xcXi88cemfMqROxZxvK1J4Ux8m388KCTDzEz+ehFA78bu3mv/Jr
         JV8YK9MImYS8AtohKInTUAFt9zSsnBJSX1JsBfmI=
Date:   Wed, 29 Mar 2023 15:58:12 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Nicolas Schier <n.schier@avm.de>
Cc:     linux-modules@vger.kernel.org,
        Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: Re: [PATCH v2 1/3] kmod: modprobe: Remove holders recursively
Message-ID: <ZCRD9CadxfBDLe5t@fjasle.eu>
References: <20230309-remove-holders-recursively-v2-0-8a8120269cc1@avm.de>
 <20230309-remove-holders-recursively-v2-1-8a8120269cc1@avm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309-remove-holders-recursively-v2-1-8a8120269cc1@avm.de>
X-Provags-ID: V03:K1:CwmgQe9M5Kh/ikO5R7mF/92OQvWvEbPpmZ6uAh+bUYoSb/3QHTN
 tsTXdX3jekRVIFLOgDiPG+wkeFxOIlPq2gpE/aC0H1NwtglvCmn6Ru+2JFYwl0qQdi8/WDk
 FUFi4XoOycmhQfsvG9FG2v9amdTcFpXah557DL2wQaMydOBbsshiM8YC4bni4TB7uk/xFFJ
 ftrjDF1553i0Stt8VL5DA==
UI-OutboundReport: notjunk:1;M01:P0:tVG6bljqQlk=;UGYoGwLO2r+rMJb6XL8y8lXtftc
 +Gh8uUs2QIoSN1f/iX2S3VvutwukJICBg2Fn37nSxO/3r7u26Cc9bniJ6Ow19LF04gUF0TYjH
 FHA5e/BQRGI0ayXpuKgLQChDn22Ey54qxAdoK65dnbQ+6ROu4IRox0GiPvgBKDjJBQUFj/bZY
 G8T4Jfi51lYSbNA03sx4gilYJzHBfuR8zMhoRhFEB8nm9TlpCvHU84qoK+iIqQZ9UYKYrgNom
 pbvf5SVdLLWRum7UbKovq8m3xd1OegwQAa4UILMxlLwzI2W0/EoUI+e6oXG5cDqOpIWX0WBat
 s3G6SuD9/fZ5wYyBw0ZJ1yY6I9vtAHvjB8NCkGEUuj+6S6auKx+Aj9fDxMGLOSTMtHow0aJ+e
 YI2HmoXXOO1QKRXRFbVssLwQpnWlOCF7QzxNX/NKbRJ0AmNm42yYFMxkAhbIgvJgTG3a2GBWH
 TmcnMPUKAEhOR580nfFODaFZ4ZsCZk9ZlDppu8Dh9cEAYk/b5IgcQDqUu/JH2Cx0zYMci6QVl
 E/NvhNQVP2ts48DAII8yFEiiYQgLjOmsqsnGNoMZEDx7J0qTtq56nJ0UbgB4ZpwjS3eFiu82B
 L8hB5340jwggWbro1hU9qUODLyrt/eXqdHrUl9Lf5Kg1aMT8M8B4csJu+dmLWGns0FN6F8P1j
 yjGpRFgzbzqEAzVp9HTp4xqMHovr1p9qHBrr0WY/yQ==
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed, Mar 29, 2023 at 03:51:35PM +0200 Nicolas Schier wrote:
> Remove holders recursively when removal of module holders is requested.
> 
> Extend commit 42b32d30c38e ("modprobe: Fix holders removal") by removing
> also indirect holders if --remove-holders is set.  For a simple module
> dependency chain like
> 
>   module3 depends on module2
>   module2 depends on module1
> 
> 'modprobe -r --remove-holders module1' will remove module3, module2 and
> module1 in correct order:
> 
>   $ modprobe -r --remove-holders module1 --verbose
>   rmmod module3
>   rmmod module2
>   rmmod module1
> 
> (Actually, it will do the same when specifying module2 or module3 for
> removal instead of module1.)
> 
> As a side-effect, 'modprobe -r module3' (w/o --remove-holders) will also
> remove all three modules from the example above, as after removal of
> module3, module2 does not have any holders and the same holds for
> module1 after removal of module2:
> 
>   $ modprobe -r module3 --verbose
>   rmmod module3
>   rmmod module2
>   rmmod module1
> 
> Without recursive evaluation of holders, modprobe leaves module1 loaded.
> 
> Unfortunately, '--dry-run --remove-holders' breaks with indirect
> dependencies.

Ups.  This is not true anymore, I forgot to remove this sentence from the
commit message.

Kind regards,
Nicolas


> 
> Signed-off-by: Nicolas Schier <n.schier@avm.de>
> ---
> I am a bit unhappy about the introduction of the 'recursive' parameter
> to rmmod_do_modlist() as it always holds the same value as
> stop_on_errors; is re-using (and renaming) possibly a better option?
> 
> modprobe --remove --remove-holders --dry-run now ignores current
> refcounts of loaded modules when simulating removal of holders.
> 
> Changes in v2:
>   * Handle modules that have just been removed, gently
>   * Fix --dry-run by ignoring module refcounts (_only_ for --dry-run)
>   * Add missing kmod_module_unref_list() calls
> ---
>  tools/modprobe.c | 44 +++++++++++++++++++++++++++++++++++---------
>  1 file changed, 35 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/modprobe.c b/tools/modprobe.c
> index 3b7897c..a705f88 100644
> --- a/tools/modprobe.c
> +++ b/tools/modprobe.c
> @@ -390,13 +390,27 @@ static int rmmod_do_remove_module(struct kmod_module *mod)
>  static int rmmod_do_module(struct kmod_module *mod, int flags);
>  
>  /* Remove modules in reverse order */
> -static int rmmod_do_modlist(struct kmod_list *list, bool stop_on_errors)
> +static int rmmod_do_modlist(struct kmod_list *list, bool stop_on_errors,
> +			    bool recursive)
>  {
>  	struct kmod_list *l;
>  
>  	kmod_list_foreach_reverse(l, list) {
>  		struct kmod_module *m = kmod_module_get_module(l);
> -		int r = rmmod_do_module(m, RMMOD_FLAG_IGNORE_BUILTIN);
> +		int r = 0;
> +
> +		if (recursive && kmod_module_get_initstate(m) >= 0) {
> +			struct kmod_list *holders = kmod_module_get_holders(m);
> +
> +			r = rmmod_do_modlist(holders, stop_on_errors,
> +					     recursive);
> +
> +			kmod_module_unref_list(holders);
> +		}
> +
> +		if (!r)
> +			r = rmmod_do_module(m, RMMOD_FLAG_IGNORE_BUILTIN);
> +
>  		kmod_module_unref(m);
>  
>  		if (r < 0 && stop_on_errors)
> @@ -448,15 +462,17 @@ static int rmmod_do_module(struct kmod_module *mod, int flags)
>  	}
>  
>  	/* 1. @mod's post-softdeps in reverse order */
> -	rmmod_do_modlist(post, false);
> +	rmmod_do_modlist(post, false, false);
>  
>  	/* 2. Other modules holding @mod */
>  	if (flags & RMMOD_FLAG_REMOVE_HOLDERS) {
>  		struct kmod_list *holders = kmod_module_get_holders(mod);
>  
> -		err = rmmod_do_modlist(holders, true);
> +		err = rmmod_do_modlist(holders, true, true);
>  		if (err < 0)
>  			goto error;
> +
> +		kmod_module_unref_list(holders);
>  	}
>  
>  	/* 3. @mod itself, but check for refcnt first */
> @@ -472,9 +488,16 @@ static int rmmod_do_module(struct kmod_module *mod, int flags)
>  		}
>  	}
>  
> -	if (!cmd)
> -		err = rmmod_do_remove_module(mod);
> -	else
> +	if (!cmd) {
> +		int state = kmod_module_get_initstate(mod);
> +
> +		if (state < 0) {
> +			/* Module was removed during recursive holder removal */
> +			err = 0;
> +		} else {
> +			err = rmmod_do_remove_module(mod);
> +		}
> +	} else
>  		err = command_do(mod, "remove", cmd, NULL);
>  
>  	if (err < 0)
> @@ -488,14 +511,14 @@ static int rmmod_do_module(struct kmod_module *mod, int flags)
>  		kmod_list_foreach(itr, deps) {
>  			struct kmod_module *dep = kmod_module_get_module(itr);
>  			if (kmod_module_get_refcnt(dep) == 0)
> -				rmmod_do_remove_module(dep);
> +				rmmod_do_module(dep, flags);
>  			kmod_module_unref(dep);
>  		}
>  		kmod_module_unref_list(deps);
>  	}
>  
>  	/* 5. @mod's pre-softdeps in reverse order: errors are non-fatal */
> -	rmmod_do_modlist(pre, false);
> +	rmmod_do_modlist(pre, false, false);
>  
>  error:
>  	kmod_module_unref_list(pre);
> @@ -975,6 +998,9 @@ static int do_modprobe(int argc, char **orig_argv)
>  	     fstat(fileno(stderr), &stat_buf)))
>  		use_syslog = 1;
>  
> +	if (remove_holders && dry_run)
> +		ignore_loaded = 1;
> +
>  	log_open(use_syslog);
>  
>  	if (!do_show_config) {
> 
> -- 
> 2.40.0
