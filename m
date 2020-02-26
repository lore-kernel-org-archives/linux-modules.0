Return-Path: <SRS0=C6ur=4O=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F41C4BA0B
	for <linux-modules@archiver.kernel.org>; Wed, 26 Feb 2020 10:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FBB924656
	for <linux-modules@archiver.kernel.org>; Wed, 26 Feb 2020 10:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbgBZKOs (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 26 Feb 2020 05:14:48 -0500
Received: from monster.unsafe.ru ([5.9.28.80]:49468 "EHLO mail.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbgBZKOs (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Wed, 26 Feb 2020 05:14:48 -0500
X-Greylist: delayed 407 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Feb 2020 05:14:47 EST
Received: from comp-core-i7-2640m-0182e6 (nat-pool-brq-t.redhat.com [213.175.37.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.unsafe.ru (Postfix) with ESMTPSA id AC576C61AB0;
        Wed, 26 Feb 2020 10:07:57 +0000 (UTC)
Date:   Wed, 26 Feb 2020 11:07:56 +0100
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     "Anton V. Boyarshinov" <boyarsh@altlinux.org>
Cc:     linux-modules@vger.kernel.org
Subject: Re: [PATCH] Add kernel-version dependent configuration directory
Message-ID: <20200226100756.aup6bwj23tynxhhu@comp-core-i7-2640m-0182e6>
References: <20200226080449.6c997cfd@x230.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226080449.6c997cfd@x230.localdomain>
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed, Feb 26, 2020 at 11:04:49AM +0300, Anton V. Boyarshinov wrote:
> In some cases it looks reasonable to have kernel-version dependent
> modules configuration: blacklists, options and so on. This commit
> introduces additional configuration directories:
> * /lib/modprobe.d/`uname -r`
> * /etc/modprobe.d/`uname -r`
> 
> Signed-off-by: Anton V. Boyarshinov <boyarsh@altlinux.org>
> ---
>  libkmod/libkmod-config.c |  5 +----
>  libkmod/libkmod.c        | 44 ++++++++++++++++++++++++++++++++++++----
>  man/modprobe.d.xml       |  2 ++
>  3 files changed, 43 insertions(+), 8 deletions(-)
> 
> diff --git a/libkmod/libkmod-config.c b/libkmod/libkmod-config.c
> index aaac0a1..5cc348a 100644
> --- a/libkmod/libkmod-config.c
> +++ b/libkmod/libkmod-config.c
> @@ -711,11 +711,8 @@ static bool conf_files_filter_out(struct kmod_ctx *ctx, DIR *d,
>  
>  	fstatat(dirfd(d), fn, &st, 0);
>  
> -	if (S_ISDIR(st.st_mode)) {
> -		ERR(ctx, "Directories inside directories are not supported: "
> -							"%s/%s\n", path, fn);
> +	if (S_ISDIR(st.st_mode))
>  		return true;
> -	}
>  
>  	return false;
>  }
> diff --git a/libkmod/libkmod.c b/libkmod/libkmod.c
> index 69fe431..1ebdeb4 100644
> --- a/libkmod/libkmod.c
> +++ b/libkmod/libkmod.c
> @@ -225,6 +225,21 @@ static char *get_kernel_release(const char *dirname)
>  	return p;
>  }
>  
> +static char *get_ver_config_path(const char * dir)
> +{
> +	struct utsname u;
> +	char *ver_conf;
> +	static const char appendix[] = "modprobe.d";
> +
> +	if (uname(&u) < 0)
> +		return NULL;
> +
> +	if (asprintf(&ver_conf, "%s/%s/%s", dir, appendix, u.release) < 0)
> +		return NULL;
> +
> +	return ver_conf;
> +}
> +
>  /**
>   * kmod_new:
>   * @dirname: what to consider as linux module's directory, if NULL
> @@ -251,7 +266,7 @@ KMOD_EXPORT struct kmod_ctx *kmod_new(const char *dirname,
>  {
>  	const char *env;
>  	struct kmod_ctx *ctx;
> -	int err;
> +	int err, configs_count;
>  
>  	ctx = calloc(1, sizeof(struct kmod_ctx));
>  	if (!ctx)
> @@ -269,9 +284,30 @@ KMOD_EXPORT struct kmod_ctx *kmod_new(const char *dirname,
>  	if (env != NULL)
>  		kmod_set_log_priority(ctx, log_priority(env));
>  
> -	if (config_paths == NULL)
> -		config_paths = default_config_paths;
> -	err = kmod_config_new(ctx, &ctx->config, config_paths);
> +	if (config_paths == NULL) {
> +		char **tmp_config_paths = malloc(sizeof(default_config_paths) +
> +				sizeof(char *) * 2);
> +		if(tmp_config_paths == NULL) {
> +			ERR(ctx, "could not create versioned config.\n");
> +			goto fail;
> +		}
> +
> +		memcpy(tmp_config_paths, default_config_paths, sizeof(default_config_paths));
> +
> +		configs_count = sizeof(default_config_paths) / sizeof(char *);

Is it ARRAY_SIZE ?

> +		tmp_config_paths[configs_count-1] = get_ver_config_path("/lib");
> +		tmp_config_paths[configs_count] = get_ver_config_path("/etc");

Please use SYSCONFDIR. All other parts of the code use it.

> +		tmp_config_paths[configs_count+1] = NULL;
> +
> +		err = kmod_config_new(ctx, &ctx->config, (const char * const*) tmp_config_paths);
> +
> +		free(tmp_config_paths[configs_count-1]);
> +		free(tmp_config_paths[configs_count]);
> +		free(tmp_config_paths);
> +	}
> +	else
> +		err = kmod_config_new(ctx, &ctx->config, config_paths);
> +
>  	if (err < 0) {
>  		ERR(ctx, "could not create config\n");
>  		goto fail;
> diff --git a/man/modprobe.d.xml b/man/modprobe.d.xml
> index 211af84..d1e254a 100644
> --- a/man/modprobe.d.xml
> +++ b/man/modprobe.d.xml
> @@ -41,7 +41,9 @@
>  
>    <refsynopsisdiv>
>      <para><filename>/lib/modprobe.d/*.conf</filename></para>
> +    <para><filename>/lib/modprobe.d/`uname -r`/*.conf</filename></para>
>      <para><filename>/etc/modprobe.d/*.conf</filename></para>
> +    <para><filename>/etc/modprobe.d/`uname -r`/*.conf</filename></para>
>      <para><filename>/run/modprobe.d/*.conf</filename></para>
>    </refsynopsisdiv>
>  
> -- 
> 2.21.0
> 
> 

-- 
Rgrds, legion

