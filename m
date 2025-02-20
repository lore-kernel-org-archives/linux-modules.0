Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA9E1EA7FC;
	Thu, 20 Feb 2025 12:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740052900; cv=none; b=SlzVKoY1gruLm2IxG1lPTyhh7P9KeYhD7gyOqTCqFjLGl1XoEg2Pfk4mAbYQG1LzTnUkPxX/z7qjnqPQvp74An2On6BqYzvZZc4CRoCM/+j187skJYVwTlLI9rCaGIPSVe19nvNHX2Xovn90oVTAYfkZIRcdCEIx4ArAVvHqnA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740052900; c=relaxed/simple;
	bh=hA50rkgyko0jeGAcJn8herB4h8Rxh9VgmCjMsRnEcfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDExc21tnYL8odLWGZ4QSK1RJlldgmpEpDjmZr9wWpijPlWWj8hRik+8Oi1loImtCOcz5aTVXzGms8grunCQ+3UoPoWChUW7rVM/dXORLEab7CMfpZHXWo3C3SjHG9ZDo+Uu3X3Ymt+ZKdcttz0olNmOW2OtnhLB2WxeiDLzWXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mQKQ80ab; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mQKQ80ab"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D11C0C4CED1;
	Thu, 20 Feb 2025 12:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740052899;
	bh=hA50rkgyko0jeGAcJn8herB4h8Rxh9VgmCjMsRnEcfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mQKQ80aby2XYC6vG3hHsxpZRr+wLx/p6u7xY2oEd5txsgxHEqliU9aFDn9UNCY5u8
	 vHhLtn80CJq8QBLe0oefw7f9AAr5DxihqFYtmu5xqfPi2GMoWSMxC0ro7s4gA58yC8
	 RVki+cplXwtew1E4iMRFyyArY3S1vFj8jjq3RQSo=
Date: Thu, 20 Feb 2025 13:01:36 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Shyam Saini <shyamsaini@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
	code@tyhicks.com, linux@rasmusvillemoes.dk,
	christophe.leroy@csgroup.eu, hch@infradead.org, mcgrof@kernel.org,
	frkaya@linux.microsoft.com, vijayb@linux.microsoft.com,
	petr.pavlu@suse.com, linux@weissschuh.net, samitolvanen@google.com,
	da.gomez@samsung.com, rafael@kernel.org, dakr@kernel.org
Subject: Re: [PATCH v3 4/4] drivers: base: handle module_kobject creation
Message-ID: <2025022028-choice-basics-592b@gregkh>
References: <20250211214842.1806521-1-shyamsaini@linux.microsoft.com>
 <20250211214842.1806521-5-shyamsaini@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211214842.1806521-5-shyamsaini@linux.microsoft.com>

On Tue, Feb 11, 2025 at 01:48:42PM -0800, Shyam Saini wrote:
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
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
