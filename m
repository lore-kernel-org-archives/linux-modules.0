Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF749393DF0;
	Mon,  9 Mar 2026 11:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773055568; cv=none; b=OZBDchycIt/YMcRGzErgAm9p17Vj23rOHU0FwWXOhgx4ejhEnsHjZqjSIGcB6AxoDBRW/yf7l5YvmVWSwuzMOEqVbftm4wR6PAHaU3kaqaiMrX1UdIk7JnOSwb81MVMth5Yhq7aWgtfPNYVPRYCEqf2TFQbpjyLttbwHxXFo760=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773055568; c=relaxed/simple;
	bh=A0fAyBMpc+NbFKBCHe04ulPWNomKMjNNgn3N8aHgpd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dywjxeM5TV8LYLdZmO54FuGmQgM2+dyugzRNeo8KHWfXuPFurrnyTDZNPagLaItg5eS9VKn2pW6fdoFv/ywJ2+x3Lm1myOBBvVaXGzZBXsrJx7Z3BnSvYpf4ce7HWJgrfbG5TGf2GHvm5uMUGwOdBrHf5RcdbO45JsPsrXKsuRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIIvZFDK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIIvZFDK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A660DC4CEF7;
	Mon,  9 Mar 2026 11:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773055568;
	bh=A0fAyBMpc+NbFKBCHe04ulPWNomKMjNNgn3N8aHgpd4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lIIvZFDK4Kx4AB0HA6Kx9aGeNj6+TncV0eafOPAGpDfUPRvTPBuVoedqtpycadI/M
	 lj2BTEE5yRna8fJoDuuOpvPD1du69xHLdMQYbJgksu4Vm2mllU5qmSR20/jaYMZc+G
	 zpdZ/4CjXTmz2uqPj3oRtvzxUbz1+uvKiskdqz/zI18MF7n8wcZtyjDRnR87gqxWcg
	 GNNuXPUXjLcgoY2LZYIwk+VM9qPXR4RQH6kZZ0BqHiFUaPYCZLHiHG+khpHbVcU2M7
	 um1Iw/lYB8itDNS5cm7KcEg8nEka6xF3QThhTW0z/v+O9LV8vxjBwsceVSUu2gLQBy
	 2b1UeYys4oibw==
Message-ID: <d6ae7800-f284-488b-aef8-d321e550dfa1@kernel.org>
Date: Mon, 9 Mar 2026 12:26:01 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module: Fix freeing of charp module parameters when
 CONFIG_SYSFS=n
To: Petr Pavlu <petr.pavlu@suse.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260306125457.1377402-1-petr.pavlu@suse.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260306125457.1377402-1-petr.pavlu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 06/03/2026 à 12:10, Petr Pavlu a écrit :
> When setting a charp module parameter, the param_set_charp() function
> allocates memory to store a copy of the input value. Later, when the module
> is potentially unloaded, the destroy_params() function is called to free
> this allocated memory.
> 
> However, destroy_params() is available only when CONFIG_SYSFS=y, otherwise
> only a dummy variant is present. In the unlikely case that the kernel is
> configured with CONFIG_MODULES=y and CONFIG_SYSFS=n, this results in
> a memory leak of charp values when a module is unloaded.
> 
> Fix this issue by making destroy_params() always available when
> CONFIG_MODULES=y. Rename the function to module_destroy_params() to clarify
> that it is intended for use by the module loader.
> 
> Fixes: e180a6b7759a ("param: fix charp parameters set via sysfs")
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> ---
>   include/linux/moduleparam.h | 12 ++++--------
>   kernel/module/main.c        |  4 ++--
>   kernel/params.c             | 27 ++++++++++++++++++---------
>   3 files changed, 24 insertions(+), 19 deletions(-)
> 
> diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
> index 7d22d4c4ea2e..6283665ec614 100644
> --- a/include/linux/moduleparam.h
> +++ b/include/linux/moduleparam.h
> @@ -426,14 +426,10 @@ extern char *parse_args(const char *name,
>   		      void *arg, parse_unknown_fn unknown);
>   
>   /* Called by module remove. */
> -#ifdef CONFIG_SYSFS
> -extern void destroy_params(const struct kernel_param *params, unsigned num);
> -#else
> -static inline void destroy_params(const struct kernel_param *params,
> -				  unsigned num)
> -{
> -}
> -#endif /* !CONFIG_SYSFS */
> +#ifdef CONFIG_MODULES
> +extern void module_destroy_params(const struct kernel_param *params,
> +				  unsigned num);

'extern' is pointless for function prototypes, don't add new ones.

num has no type.

> +#endif
>   
>   /* All the helper functions */
>   /* The macros to do compile-time type checking stolen from Jakub
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index c3ce106c70af..ef2e2130972f 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -1408,7 +1408,7 @@ static void free_module(struct module *mod)
>   	module_unload_free(mod);
>   
>   	/* Free any allocated parameters. */
> -	destroy_params(mod->kp, mod->num_kp);
> +	module_destroy_params(mod->kp, mod->num_kp);
>   
>   	if (is_livepatch_module(mod))
>   		free_module_elf(mod);
> @@ -3519,7 +3519,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
>   	mod_sysfs_teardown(mod);
>    coming_cleanup:
>   	mod->state = MODULE_STATE_GOING;
> -	destroy_params(mod->kp, mod->num_kp);
> +	module_destroy_params(mod->kp, mod->num_kp);
>   	blocking_notifier_call_chain(&module_notify_list,
>   				     MODULE_STATE_GOING, mod);
>   	klp_module_going(mod);
> diff --git a/kernel/params.c b/kernel/params.c
> index 7188a12dbe86..1a436c9d6140 100644
> --- a/kernel/params.c
> +++ b/kernel/params.c
> @@ -745,15 +745,6 @@ void module_param_sysfs_remove(struct module *mod)
>   }
>   #endif
>   
> -void destroy_params(const struct kernel_param *params, unsigned num)
> -{
> -	unsigned int i;
> -
> -	for (i = 0; i < num; i++)
> -		if (params[i].ops->free)
> -			params[i].ops->free(params[i].arg);
> -}
> -
>   struct module_kobject * __init_or_module
>   lookup_or_create_module_kobject(const char *name)
>   {
> @@ -985,3 +976,21 @@ static int __init param_sysfs_builtin_init(void)
>   late_initcall(param_sysfs_builtin_init);
>   
>   #endif /* CONFIG_SYSFS */
> +
> +#ifdef CONFIG_MODULES
> +
> +/*
> + * module_destroy_params - free all parameters for one module
> + * @params: module parameters (array)
> + * @num: number of module parameters
> + */
> +void module_destroy_params(const struct kernel_param *params, unsigned num)

num has no type

> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < num; i++)
> +		if (params[i].ops->free)
> +			params[i].ops->free(params[i].arg);
> +}
> +
> +#endif /* CONFIG_MODULES */
> 
> base-commit: c107785c7e8dbabd1c18301a1c362544b5786282

Note, checkpatch reports the same:

CHECK: extern prototypes should be avoided in .h files
#47: FILE: include/linux/moduleparam.h:430:
+extern void module_destroy_params(const struct kernel_param *params,

WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
#48: FILE: include/linux/moduleparam.h:431:
+				  unsigned num);

WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
#107: FILE: kernel/params.c:987:
+void module_destroy_params(const struct kernel_param *params, unsigned num)

total: 0 errors, 2 warnings, 1 checks, 70 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
       mechanically convert to the typical style using --fix or 
--fix-inplace.

Commit 4aad08ba007a ("module: Fix freeing of charp module parameters 
when CONFIG_SYSFS=n") has style problems, please review.

NOTE: If any of the errors are false positives, please report
       them to the maintainer, see CHECKPATCH in MAINTAINERS.


Christophe
