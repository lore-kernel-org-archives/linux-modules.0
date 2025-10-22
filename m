Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CF8274659;
	Wed, 22 Oct 2025 22:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761173712; cv=none; b=DpL8DD3PwOWtbFsuRb3qbjjrWY3i6QQLPV2YNatS2HP0sPmGGTZ2ITXfovCFzyQkR7ZoZP4sifLybkw9m97FlKD6wYgTn5FE/ZXbVfY9sT0RCnLhlFmiCrxFtt/VbIGC+R5w1ek+Yt0ecVMgLzTWNTT9bwTxYypBYhNErQKTijY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761173712; c=relaxed/simple;
	bh=+pYBa67RShkMWV2hg7HneFrjRzoP/lCRV/hmSOMkOMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=urm7NoCtgoByE5YVpbpIS4NPRD5tWEMY6S+vMBob5NBuVJyWApBiztXpvTKNlE15MqoRqI6Sh7pCaEtcpx0tYWBxkqLWRv8Sex3SjFuvD6ILtTUReLle5ghLYjV1EMS9gq7tcXibwEif07b4cGz544jKnULRnBeZZ5CSM5niMlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LoPl1ONl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LoPl1ONl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50FDCC4CEE7;
	Wed, 22 Oct 2025 22:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761173712;
	bh=+pYBa67RShkMWV2hg7HneFrjRzoP/lCRV/hmSOMkOMg=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LoPl1ONlG72YosXH9EYgAE2cSNlhHikE9VvYnwkamBSE4X/3YXeFX11pmEROjJc5g
	 9JZxLiyCQzTIQ+0sKpRM25J0I6P9yYt/9ghk94zPH0C5pm/1aqZurNli7cP5ersGXy
	 MQ/pKks0cn7CA43DQ9lkzDSyHlxK7AwalYGmuaZnpOD7B4Osx9GjfZzJn9j8W9S5yF
	 yK0QkeNM6bG0nFiPa78u+REm9QpMLWGuyHcAXHf5bPmAs5T6Gs5JQz9SK9wqdB7ZF6
	 GKCfinlrmlsdeQA+VLMBqzno6YUjEF2/4JqvlqlXgPIz1M6Y0XAZkUHiqSmYjOgaHK
	 AScl0V43lw2Dg==
Message-ID: <de87b16e-420d-4fc7-8bd4-5b03939f0355@kernel.org>
Date: Thu, 23 Oct 2025 00:55:08 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Subject: Re: [PATCH] params: Replace __modinit with __init_or_module
To: Petr Pavlu <petr.pavlu@suse.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>
Cc: Shyam Saini <shyamsaini@linux.microsoft.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250819121248.460105-1-petr.pavlu@suse.com>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <20250819121248.460105-1-petr.pavlu@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/08/2025 14.12, Petr Pavlu wrote:
> Remove the custom __modinit macro from kernel/params.c and instead use the
> common __init_or_module macro from include/linux/module.h. Both provide the
> same functionality.
> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>

Reviewed-by: Daniel Gomez <da.gomez@samsung.com>

> ---
>  kernel/params.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/params.c b/kernel/params.c
> index b92d64161b75..19bb04f10372 100644
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
> @@ -625,9 +619,9 @@ EXPORT_SYMBOL(kernel_param_unlock);
>   * create file in sysfs.  Returns an error on out of memory.  Always cleans up
>   * if there's an error.
>   */
> -static __modinit int add_sysfs_param(struct module_kobject *mk,
> -				     const struct kernel_param *kp,
> -				     const char *name)
> +static __init_or_module int add_sysfs_param(struct module_kobject *mk,
> +					    const struct kernel_param *kp,
> +					    const char *name)
>  {
>  	struct module_param_attrs *new_mp;
>  	struct attribute **new_attrs;
> @@ -760,7 +754,8 @@ void destroy_params(const struct kernel_param *params, unsigned num)
>  			params[i].ops->free(params[i].arg);
>  }
>  
> -struct module_kobject __modinit * lookup_or_create_module_kobject(const char *name)
> +struct module_kobject * __init_or_module
> +lookup_or_create_module_kobject(const char *name)
>  {
>  	struct module_kobject *mk;
>  	struct kobject *kobj;
> 
> base-commit: be48bcf004f9d0c9207ff21d0edb3b42f253829e

