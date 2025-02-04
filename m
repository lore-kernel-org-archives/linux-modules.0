Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49503143C5D;
	Tue,  4 Feb 2025 09:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738662606; cv=none; b=tSYUnKrJ/elcbgPTL/xk2mitRa6foAvv3IUO4+L8TwRxzBNA/1DPzKdZk+9tSoiPsYoYaA5QR+B5wYFdXWrM29CenWxBzpXsRw6V3J2eiO0AvSq0WH4O2rO9qiMMuNqgBtUcV3hCWfVNWTKq3EUA46B21ScaVMdjn1Y9aoNcc9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738662606; c=relaxed/simple;
	bh=7qbynCn/gy/uw9OtIo6wbbN4xeODM0unKVxt43kSitw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XfZsUUyDwjiIaLoy8LLjgfRoK6JnVNW2eBzYF1+sGeCsDbbzyYh3K7UVRHJg6pP1bkouzbAidMOUaqg/7w1eJuRRprO5uqu6sBVJvfmsAaripqXWwFU7hVKkz7Skzk7USEfu5hfxBcTbbvXnv8lKgV4/P9TdXPQCYWuIhEujptk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4YnJ2k5807z9sRs;
	Tue,  4 Feb 2025 10:28:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0Voh3-2F0DYF; Tue,  4 Feb 2025 10:28:46 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4YnJ2T73yBz9sSR;
	Tue,  4 Feb 2025 10:28:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id DA8228B765;
	Tue,  4 Feb 2025 10:28:33 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id fUnL5h2Ji_JM; Tue,  4 Feb 2025 10:28:33 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 1461D8B763;
	Tue,  4 Feb 2025 10:28:33 +0100 (CET)
Message-ID: <d0227f33-7b3f-426e-b731-b9a1f17020ed@csgroup.eu>
Date: Tue, 4 Feb 2025 10:28:32 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v1 2/3] include: move
 lookup_or_create_module_kobject()/to_module* to module.h
To: Shyam Saini <shyamsaini@linux.microsoft.com>,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org
Cc: code@tyhicks.com, linux@rasmusvillemoes.dk, mcgrof@kernel.org,
 frkaya@linux.microsoft.com, vijayb@linux.microsoft.com, petr.pavlu@suse.com,
 linux@weissschuh.net, samitolvanen@google.com, da.gomez@samsung.com,
 gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org
References: <20250204052222.1611510-1-shyamsaini@linux.microsoft.com>
 <20250204052222.1611510-3-shyamsaini@linux.microsoft.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20250204052222.1611510-3-shyamsaini@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 04/02/2025 à 06:22, Shyam Saini a écrit :
> [Vous ne recevez pas souvent de courriers de shyamsaini@linux.microsoft.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> Move the following to module.h to allow common usages:
>   - lookup_or_create_module_kobject()
>   - to_module_attr
>   - to_module_kobject
> 
> This makes lookup_or_create_module_kobject() as inline.

Why an inline ? It looks quite big for an inline. Why not just make it 
global ?

> 
> Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
> ---
>   include/linux/module.h | 39 +++++++++++++++++++++++++++++++++++++++
>   kernel/params.c        | 39 ---------------------------------------
>   2 files changed, 39 insertions(+), 39 deletions(-)
> 
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 12f8a7d4fc1c..ba5f5e6c3927 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -894,8 +894,47 @@ static inline void *module_writable_address(struct module *mod, void *loc)
>   #endif /* CONFIG_MODULES */
> 
>   #ifdef CONFIG_SYSFS
> +/* sysfs output in /sys/modules/XYZ/parameters/ */
> +#define to_module_attr(n) container_of_const(n, struct module_attribute, attr)
> +#define to_module_kobject(n) container_of(n, struct module_kobject, kobj)
>   extern struct kset *module_kset;
>   extern const struct kobj_type module_ktype;
> +
> +static inline struct module_kobject * __init lookup_or_create_module_kobject(const char *name)
> +{
> +       struct module_kobject *mk;
> +       struct kobject *kobj;
> +       int err;
> +
> +       kobj = kset_find_obj(module_kset, name);
> +       if (kobj) {
> +               mk = to_module_kobject(kobj);

Would look cleaner without the else. Something like:

	if (kobj)
		return to_module_kobject(kobj);

	mk = kzalloc(sizeof(struct module_kobject), GFP_KERNEL);
...


> +       } else {
> +               mk = kzalloc(sizeof(struct module_kobject), GFP_KERNEL);
> +               BUG_ON(!mk);

Why a BUG_ON() ? Why not just return NULL and let the caller handle the 
failure ?

> +
> +               mk->mod = THIS_MODULE;
> +               mk->kobj.kset = module_kset;
> +               err = kobject_init_and_add(&mk->kobj, &module_ktype, NULL,
> +                                          "%s", name);
> +#ifdef CONFIG_MODULES

This #ifdef is not needed, module_uevent is declared at all time in 
module.h, IS_ENABLED(CONFIG_MODULES) should be enough.

> +               if (!err)
> +                       err = sysfs_create_file(&mk->kobj, &module_uevent.attr);
> +#endif
> +               if (err) {
> +                       kobject_put(&mk->kobj);
> +                       pr_crit("Adding module '%s' to sysfs failed (%d), the system may be unstable.\n",
> +                               name, err);
> +                       return NULL;
> +               }
> +
> +               /* So that we hold reference in both cases. */
> +               kobject_get(&mk->kobj);
> +       }
> +
> +       return mk;
> +}
> +
>   #endif /* CONFIG_SYSFS */
> 
>   #define symbol_request(x) try_then_request_module(symbol_get(x), "symbol:" #x)
> diff --git a/kernel/params.c b/kernel/params.c
> index 4b43baaf7c83..3c0798b79f76 100644
> --- a/kernel/params.c
> +++ b/kernel/params.c
> @@ -537,10 +537,6 @@ const struct kernel_param_ops param_ops_string = {
>   };
>   EXPORT_SYMBOL(param_ops_string);
> 
> -/* sysfs output in /sys/modules/XYZ/parameters/ */
> -#define to_module_attr(n) container_of_const(n, struct module_attribute, attr)
> -#define to_module_kobject(n) container_of(n, struct module_kobject, kobj)
> -
>   struct param_attribute
>   {
>          struct module_attribute mattr;
> @@ -763,41 +759,6 @@ void destroy_params(const struct kernel_param *params, unsigned num)
>                          params[i].ops->free(params[i].arg);
>   }
> 
> -static struct module_kobject * __init lookup_or_create_module_kobject(const char *name)
> -{
> -       struct module_kobject *mk;
> -       struct kobject *kobj;
> -       int err;
> -
> -       kobj = kset_find_obj(module_kset, name);
> -       if (kobj) {
> -               mk = to_module_kobject(kobj);
> -       } else {
> -               mk = kzalloc(sizeof(struct module_kobject), GFP_KERNEL);
> -               BUG_ON(!mk);
> -
> -               mk->mod = THIS_MODULE;
> -               mk->kobj.kset = module_kset;
> -               err = kobject_init_and_add(&mk->kobj, &module_ktype, NULL,
> -                                          "%s", name);
> -#ifdef CONFIG_MODULES
> -               if (!err)
> -                       err = sysfs_create_file(&mk->kobj, &module_uevent.attr);
> -#endif
> -               if (err) {
> -                       kobject_put(&mk->kobj);
> -                       pr_crit("Adding module '%s' to sysfs failed (%d), the system may be unstable.\n",
> -                               name, err);
> -                       return NULL;
> -               }
> -
> -               /* So that we hold reference in both cases. */
> -               kobject_get(&mk->kobj);
> -       }
> -
> -       return mk;
> -}
> -
>   static void __init kernel_add_sysfs_param(const char *name,
>                                            const struct kernel_param *kparam,
>                                            unsigned int name_skip)
> --
> 2.34.1
> 
> 

