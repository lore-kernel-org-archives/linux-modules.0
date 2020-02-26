Return-Path: <SRS0=C6ur=4O=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F7BC4BA1E
	for <linux-modules@archiver.kernel.org>; Wed, 26 Feb 2020 18:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A138B24653
	for <linux-modules@archiver.kernel.org>; Wed, 26 Feb 2020 18:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbgBZSb6 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 26 Feb 2020 13:31:58 -0500
Received: from monster.unsafe.ru ([5.9.28.80]:37662 "EHLO mail.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726789AbgBZSb6 (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Wed, 26 Feb 2020 13:31:58 -0500
Received: from comp-core-i7-2640m-0182e6 (ip-89-102-33-211.net.upcbroadband.cz [89.102.33.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.unsafe.ru (Postfix) with ESMTPSA id 8C8FAC61AB0;
        Wed, 26 Feb 2020 18:31:54 +0000 (UTC)
Date:   Wed, 26 Feb 2020 19:31:53 +0100
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     mahatma@eu.by
Cc:     linux-modules@vger.kernel.org
Subject: Re: modinfo must show real module info, not context if filename set
Message-ID: <20200226183153.35qmuu57svmx62ab@comp-core-i7-2640m-0182e6>
References: <dda23def071a8d087cca3538289de1e0@bspu.by>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dda23def071a8d087cca3538289de1e0@bspu.by>
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed, Feb 26, 2020 at 04:53:45AM +0200, Denis Kaganovich wrote:
> After commit e7e2cb61fa9f1db3429d91ef6accff549500d268, even if real filename
> passed - modinfo show info from context (so, I got built-in info from
> running
> kernel, but asking for new kernel's external module). This behaviour
> unobvious
> and incompatible with pre-v27. Simple use fake context for filename - IMHO
> much less ugly then current results.

Can you give an example of this misbehavior ?

I have a two kernel directories (generic and current) with
modules.builtin.modinfo:

$ ls -1 /lib/modules/{5.2.0-generic,`uname -r`}/modules.builtin.modinfo 
/lib/modules/5.2.0-generic/modules.builtin.modinfo
/lib/modules/5.2.0-current/modules.builtin.modinfo

The ext4 module is built into both:

$ tr '\0' '\n' < /lib/modules/`uname -r`/modules.builtin.modinfo |grep ^ext4.description
ext4.description=Fourth Extended Filesystem

$ tr '\0' '\n' < /lib/modules/5.2.0-generic/modules.builtin.modinfo |grep ^ext4.description
ext4.description=Fourth Extended Filesystem

Now I have build this module separately and put it into the tree:

$ find /lib/modules/{5.2.0-generic,`uname -r`} -name 'ext4.*'
/lib/modules/5.2.0-generic/kernel/fs/ext4/ext4.ko.gz

For current kernel:

$ tools/modinfo ext4 |grep filename
filename: (builtin)

For the other kernel:

$ tools/modinfo -k 5.2.0-generic ext4 |grep filename
filename: /lib/modules/5.2.0-generic/kernel/fs/ext4/ext4.ko.gz

Only the external module is displayed, even if there is a module with the
same name in the modules.builtin.modinfo.

I also have a very old kernel without modules.builtin.modinfo:

$ tools/modinfo -k 4.14.96-generic ext4 |grep filename
filename: /lib/modules/4.14.96-generic/kernel/fs/ext4/ext4.ko.gz

> Signed-off-by: Dzianis Kahanovich <mahatma@eu.by>
> 
> --- a/tools/modinfo.c	2020-02-25 13:46:38.181693570 +0300
> +++ b/tools/modinfo.c	2020-02-26 05:18:39.393790919 +0300
> @@ -359,7 +359,7 @@ static bool is_module_filename(const cha
> 
>  static int do_modinfo(int argc, char *argv[])
>  {
> -	struct kmod_ctx *ctx;
> +	struct kmod_ctx *ctx, *ctx0;
>  	char dirname_buf[PATH_MAX];
>  	const char *dirname = NULL;
>  	const char *kversion = NULL;
> @@ -437,7 +437,8 @@ static int do_modinfo(int argc, char *ar
>  	}
> 
>  	ctx = kmod_new(dirname, &null_config);
> -	if (!ctx) {
> +	ctx0 = kmod_new("/dev/null", &null_config);
> +	if (!ctx || !ctx0) {
>  		ERR("kmod_new() failed!\n");
>  		return EXIT_FAILURE;
>  	}
> @@ -448,7 +449,7 @@ static int do_modinfo(int argc, char *ar
>  		int r;
> 
>  		if (is_module_filename(name))
> -			r = modinfo_path_do(ctx, name);
> +			r = modinfo_path_do(ctx0, name);
>  		else
>  			r = modinfo_alias_do(ctx, name);
> 
> @@ -456,6 +457,7 @@ static int do_modinfo(int argc, char *ar
>  			err = r;
>  	}
> 
> +	kmod_unref(ctx0);
>  	kmod_unref(ctx);
>  	return err >= 0 ? EXIT_SUCCESS : EXIT_FAILURE;
>  }
> 

-- 
Rgrds, legion

