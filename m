Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BBD145FE0;
	Tue, 15 Apr 2025 15:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744730990; cv=none; b=S+1XrXOcKcslfUseqt8q401r4q1HwOSO058mABVjZeLRJP1rvefUsUNvfjurquS1PhX/2PdqYbEi8q+u+QMb/Uudd7ZYGZO7CilBQkgGTwDHLXf6u7tbWFUGZgJTe3LfrVy9fgloXYW9OL3edwWdYZogKRqV/SZguJSb3CZRh0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744730990; c=relaxed/simple;
	bh=dPGucQf30xfK8uBOtJ0iEsLmxYFmROsJSFUyouZE5zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nykIOKk6UpbM90F9NqlbIp4ege/y3N2TkKsgtji7DqVqnH3BPlUO91fI7iSPfOvSgpQlPlLojhsGb/c6wravONKuHJAEChz4HU+/fNgmPzaCwCWd17njlklM8+x8mR5b+hn73acToPhU6te//poLZtff38BrnaMyhGyMvKWzfps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZQdgT24c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZQdgT24c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC80C4CEEB;
	Tue, 15 Apr 2025 15:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744730989;
	bh=dPGucQf30xfK8uBOtJ0iEsLmxYFmROsJSFUyouZE5zo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZQdgT24c5icprcudK/z9ESiXZffsqiHZGp7KM/Bpezy2s4C1K1ma8lJS2qayFrNOP
	 HeaTPJYb4np35A3ZimG/VnX36KzePj3+X5blukibFCHYo9McmMXF+g1mzP5HMHxqnb
	 /AnjCguRUORU9T+irLxQSggFQoIUrykWa3/cfpJg=
Date: Tue, 15 Apr 2025 17:29:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shyam Saini <shyamsaini@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
	petr.pavlu@suse.com, code@tyhicks.com, linux@rasmusvillemoes.dk,
	christophe.leroy@csgroup.eu, hch@infradead.org, mcgrof@kernel.org,
	frkaya@linux.microsoft.com, vijayb@linux.microsoft.com,
	linux@weissschuh.net, samitolvanen@google.com, da.gomez@samsung.com,
	rafael@kernel.org, dakr@kernel.org, stable@kernel.org
Subject: Re: [PATCH v4 4/4] drivers: base: handle module_kobject creation
Message-ID: <2025041538-coming-busload-3813@gregkh>
References: <20250227184930.34163-1-shyamsaini@linux.microsoft.com>
 <20250227184930.34163-5-shyamsaini@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227184930.34163-5-shyamsaini@linux.microsoft.com>

On Thu, Feb 27, 2025 at 10:49:30AM -0800, Shyam Saini wrote:
> module_add_driver() relies on module_kset list for
> /sys/module/<built-in-module>/drivers directory creation.
> 
> Since,
> commit 96a1a2412acba ("kernel/params.c: defer most of param_sysfs_init() to late_initcall time")
> drivers which are initialized from subsys_initcall() or any other
> higher precedence initcall couldn't find the related kobject entry
> in the module_kset list because module_kset is not fully populated
> by the time module_add_driver() refers it. As a consequence,
> module_add_driver() returns early without calling make_driver_name().
> Therefore, /sys/module/<built-in-module>/drivers is never created.
> 
> Fix this issue by letting module_add_driver() handle module_kobject
> creation itself.
> 
> Fixes: 96a1a2412acb ("kernel/params.c: defer most of param_sysfs_init() to late_initcall time")
> Cc: stable@kernel.org
> Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
> ---
>  drivers/base/module.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/base/module.c b/drivers/base/module.c
> index 5bc71bea883a..218aaa096455 100644
> --- a/drivers/base/module.c
> +++ b/drivers/base/module.c
> @@ -42,16 +42,13 @@ int module_add_driver(struct module *mod, const struct device_driver *drv)
>  	if (mod)
>  		mk = &mod->mkobj;
>  	else if (drv->mod_name) {
> -		struct kobject *mkobj;
> -
> -		/* Lookup built-in module entry in /sys/modules */
> -		mkobj = kset_find_obj(module_kset, drv->mod_name);
> -		if (mkobj) {
> -			mk = container_of(mkobj, struct module_kobject, kobj);
> +		/* Lookup or create built-in module entry in /sys/modules */
> +		mk = lookup_or_create_module_kobject(drv->mod_name);
> +		if (mk) {
>  			/* remember our module structure */
>  			drv->p->mkobj = mk;
> -			/* kset_find_obj took a reference */
> -			kobject_put(mkobj);
> +			/* lookup_or_create_module_kobject took a reference */
> +			kobject_put(&mk->kobj);
>  		}
>  	}
>  
> -- 
> 2.34.1

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
