Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF9A198A32;
	Fri,  7 Feb 2025 07:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738913743; cv=none; b=PHGSMBnZSthY+vUZ5T9No8GOXmH7HGqGDtf8bualxJD2+XlgXe9tONmaJwC/8UikqUcgJY2t98FU2vJk9KZayVFIkfSlVd6rsBBY8BGRY0TPohOc0a6XOBU4MYiAbDrqYwB3dpfNoQASQiUXbHnACOaFVr4/BHdttzAJdt/hkyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738913743; c=relaxed/simple;
	bh=3qtlZUpkljhlwXCzjKXTxq/EfyYT6h7RYLWB5MlNTbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m6vJuKV0A7kYZxINs42FYci1XqHCWWqdIh3vm22ujy6OTDhDmFwiGlKi1i0KXCUkFlHYDQrdqlsd/N9JQ2TvGuZOZRRioPstFkAoG6TGffkGGDnICzbkgRdzB9tUvBZ4dcNj6OCoJJosUxe9ZZMKM60Ar35Ht14fYWKyTr8v2WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=XvlTym/+; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="XvlTym/+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1738913729;
	bh=3qtlZUpkljhlwXCzjKXTxq/EfyYT6h7RYLWB5MlNTbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XvlTym/+4lFBs9M6lla/muHeMDVjvx/S1iHz9ISboiWyEB0t72/TE0wW4dn2QcKr4
	 /3yBOpwwNN/sjJKaozTwTnhyLzTpUcEy5uvdvV9JjX7LK8epznPEx+ht7+l85m6iho
	 sZgw6fqcKBtZ5v+QiSW8HfN7d0eNbzRANEdJXMIg=
Date: Fri, 7 Feb 2025 08:35:28 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Shyam Saini <shyamsaini@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	code@tyhicks.com, linux@rasmusvillemoes.dk, christophe.leroy@csgroup.eu, 
	hch@infradead.org, mcgrof@kernel.org, frkaya@linux.microsoft.com, 
	vijayb@linux.microsoft.com, petr.pavlu@suse.com, samitolvanen@google.com, 
	da.gomez@samsung.com, gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org
Subject: Re: [v2 2/3] kernel: refactor and globalize
 lookup_or_create_module_kobject()
Message-ID: <307ec0eb-df8e-4031-9bfa-227b1cd2fcb7@t-8ch.de>
References: <20250207054538.1110340-1-shyamsaini@linux.microsoft.com>
 <20250207054538.1110340-3-shyamsaini@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207054538.1110340-3-shyamsaini@linux.microsoft.com>

On 2025-02-06 21:45:37-0800, Shyam Saini wrote:
> lookup_or_create_module_kobject() is static and marked as __init,
> this is not ideal for global usage.

FYI missing "PATCH" in patch subject.

> Fix this limitation by refactoring and declaring this as global:
>  - Refactor it by removing BUG_ON() and 'if else' construct by returning
>    early

This does look like an unrelated change, could be in its own patch.

>  - Remove static and __init markers from the function and add its
>    declaration in module.h
>  - Mark this function as "__modinit". To facilitate this, move the
>    __modinit macro construct to module.h
> 
> Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
> ---
>  include/linux/module.h |  8 +++++++
>  kernel/params.c        | 48 ++++++++++++++++++------------------------
>  2 files changed, 29 insertions(+), 27 deletions(-)
> 
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 12f8a7d4fc1c..57d09b4e4385 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -162,6 +162,14 @@ extern void cleanup_module(void);
>  #define __INITRODATA_OR_MODULE __INITRODATA
>  #endif /*CONFIG_MODULES*/
>  
> +#ifdef CONFIG_MODULES
> +#define __modinit
> +#else
> +#define __modinit __init
> +#endif
> +
> +struct module_kobject __modinit * lookup_or_create_module_kobject(const char *name);

__init / __modinit is not necessary on the declaration.
You can remove it here and keep the #define private.

> +
>  /* Generic info of form tag = "info" */
>  #define MODULE_INFO(tag, info) __MODULE_INFO(tag, tag, info)
>  
> diff --git a/kernel/params.c b/kernel/params.c
> index 4b43baaf7c83..5d16696b1daa 100644
> --- a/kernel/params.c
> +++ b/kernel/params.c
> @@ -595,12 +595,6 @@ static ssize_t param_attr_store(const struct module_attribute *mattr,
>  }
>  #endif
>  
> -#ifdef CONFIG_MODULES
> -#define __modinit
> -#else
> -#define __modinit __init
> -#endif
> -
>  #ifdef CONFIG_SYSFS
>  void kernel_param_lock(struct module *mod)
>  {
> @@ -763,38 +757,38 @@ void destroy_params(const struct kernel_param *params, unsigned num)
>  			params[i].ops->free(params[i].arg);
>  }
>  
> -static struct module_kobject * __init lookup_or_create_module_kobject(const char *name)
> +struct module_kobject __modinit * lookup_or_create_module_kobject(const char *name)
>  {
>  	struct module_kobject *mk;
>  	struct kobject *kobj;
>  	int err;
>  
>  	kobj = kset_find_obj(module_kset, name);
> -	if (kobj) {
> -		mk = to_module_kobject(kobj);
> -	} else {
> -		mk = kzalloc(sizeof(struct module_kobject), GFP_KERNEL);
> -		BUG_ON(!mk);
> -
> -		mk->mod = THIS_MODULE;
> -		mk->kobj.kset = module_kset;
> -		err = kobject_init_and_add(&mk->kobj, &module_ktype, NULL,
> +	if (kobj)
> +		return to_module_kobject(kobj);
> +
> +	mk = kzalloc(sizeof(struct module_kobject), GFP_KERNEL);
> +	if (!mk)
> +		return NULL;
> +
> +	mk->mod = THIS_MODULE;
> +	mk->kobj.kset = module_kset;
> +	err = kobject_init_and_add(&mk->kobj, &module_ktype, NULL,
>  					   "%s", name);
>  #ifdef CONFIG_MODULES

As you are cleaning this up anyways: The #ifdef above should become

if (IS_ENABLED(CONFIG_MODULES))

> -		if (!err)
> -			err = sysfs_create_file(&mk->kobj, &module_uevent.attr);
> +	if (!err)
> +		err = sysfs_create_file(&mk->kobj, &module_uevent.attr);
>  #endif
> -		if (err) {
> -			kobject_put(&mk->kobj);
> -			pr_crit("Adding module '%s' to sysfs failed (%d), the system may be unstable.\n",
> -				name, err);
> -			return NULL;
> -		}
> -
> -		/* So that we hold reference in both cases. */
> -		kobject_get(&mk->kobj);
> +	if (err) {
> +		kobject_put(&mk->kobj);
> +		pr_crit("Adding module '%s' to sysfs failed (%d), the system may be unstable.\n",
> +			name, err);
> +		return NULL;
>  	}
>  
> +	/* So that we hold reference in both cases. */
> +	kobject_get(&mk->kobj);
> +
>  	return mk;
>  }
>  
> -- 
> 2.34.1
> 
