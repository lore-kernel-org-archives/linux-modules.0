Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE4828E611
	for <linux-modules@vger.kernel.org>; Tue, 13 May 2025 13:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747141611; cv=none; b=SnrZQd7ojmdzfszaXSzvqN6BWjHZ47lRbo+jOSeU/uHmhHby/Rvn7l1DDoD0cTSQuxkwS7Yh8/jnJk0SsjvY4qgXCreb0tei6q/8e4xrBJitdr+m7MmCoSvEH63HbAjpqaaVvU0JJpNFGjo+mJPnh1SiusVMaUPKWcCoA0owoaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747141611; c=relaxed/simple;
	bh=hVxo/npMN4zYqz9X0VffCxpBUoVEYQSD7AVUmgZ3Sl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3McpKh9m4IR8bn4dD1dvPBk+voZN480Oq8BLw5KGbW1HFxz1cw89xZnHO+MCW7xtuNrozAnt62cEIRutMWn6F/e/zi5/DFvyCjufBwQdh8KwiaxO++HrFuG+dImy6Gc4byCbHN6lRQRjJiO7DFRM3r3xRvj0jWbH6bbP+PWh2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r2yM2m2n; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r2yM2m2n"
Date: Tue, 13 May 2025 09:06:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747141606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DvgF8TbBuC+o8Uz5j0Jj6vYCgEZB6txpMSu0vuk6MQ0=;
	b=r2yM2m2nTnEh+q0Ny1mlUqXZx3RuVAzTaV1j9e/GcU4ObVUQrirVd7a1NEk5bKL79RuZwh
	TrydSyoUYAoQaeTo6bJjgGtkgwN7zlzE/NKIdu9bhdk2Ev/KfOIdG6EkP4XPg0Rdtih6eh
	ZWe1pA/bBY7b3f1lsbkJEXzgApd+t+0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, 
	linux-modules@vger.kernel.org
Subject: Re: [PATCH] params: Add support for static keys
Message-ID: <xeivxiix7dk2bmht22xeocmluom4nkcel35qa672mm52cq2ynx@rago3au3x6dy>
References: <20250510210126.4032840-1-kent.overstreet@linux.dev>
 <84e82d74-312f-4c6c-b197-b44e59e9470c@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84e82d74-312f-4c6c-b197-b44e59e9470c@suse.com>
X-Migadu-Flow: FLOW_OUT

On Mon, May 12, 2025 at 03:51:00PM +0200, Petr Pavlu wrote:
> On 5/10/25 23:01, Kent Overstreet wrote:
> > Static keys can now be a module parameter, e.g.
> > 
> > module_param_named(foo, foo.key, static_key_t, 0644)
> > 
> > bcachefs is now using this.
> > 
> > Cc: Luis Chamberlain <mcgrof@kernel.org>
> > Cc: Petr Pavlu <petr.pavlu@suse.com>
> > Cc: Sami Tolvanen <samitolvanen@google.com>
> > Cc: Daniel Gomez <da.gomez@samsung.com>
> > Cc: linux-modules@vger.kernel.org
> 
> Please Cc also the "STATIC BRANCH/CALL" folks on the next version.
> 
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > ---
> >  include/linux/jump_label.h  |  2 ++
> >  include/linux/moduleparam.h |  6 ++++++
> >  kernel/params.c             | 35 +++++++++++++++++++++++++++++++++++
> >  3 files changed, 43 insertions(+)
> > 
> > diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
> > index fdb79dd1ebd8..0fc9b71db56f 100644
> > --- a/include/linux/jump_label.h
> > +++ b/include/linux/jump_label.h
> > @@ -107,6 +107,8 @@ struct static_key {
> >  #endif	/* CONFIG_JUMP_LABEL */
> >  };
> >  
> > +typedef struct static_key static_key_t;
> > +
> >  #endif /* __ASSEMBLY__ */
> >  
> >  #ifdef CONFIG_JUMP_LABEL
> > diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
> > index bfb85fd13e1f..2494e7e67453 100644
> > --- a/include/linux/moduleparam.h
> > +++ b/include/linux/moduleparam.h
> 
> The module_param() macro in this file has a kernel-doc that describes
> all currently supported standard types:
> 
>  * Standard types are:
>  *	byte, hexint, short, ushort, int, uint, long, ulong
>  *	charp: a character pointer
>  *	bool: a bool, values 0/1, y/n, Y/N.
>  *	invbool: the above, only sense-reversed (N = true).
> 
> The static_key_t should be added to this list.
> 
> > @@ -488,6 +488,12 @@ extern int param_set_bint(const char *val, const struct kernel_param *kp);
> >  #define param_get_bint param_get_int
> >  #define param_check_bint param_check_int
> >  
> > +/* A static key, which can only be set like a bool */
> > +extern const struct kernel_param_ops param_ops_static_key_t;
> > +extern int param_set_static_key_t(const char *val, const struct kernel_param *kp);
> > +extern int param_get_static_key_t(char *buffer, const struct kernel_param *kp);
> > +#define param_check_static_key_t(name, p) __param_check(name, p, struct static_key)
> > +
> >  /**
> >   * module_param_array - a parameter which is an array of some type
> >   * @name: the name of the array variable
> > diff --git a/kernel/params.c b/kernel/params.c
> > index 2509f216c9f3..991f49e138e7 100644
> > --- a/kernel/params.c
> > +++ b/kernel/params.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/overflow.h>
> >  #include <linux/security.h>
> >  #include <linux/slab.h>
> > +#include <linux/static_key.h>
> >  #include <linux/string.h>
> >  
> >  #ifdef CONFIG_SYSFS
> > @@ -412,6 +413,40 @@ const struct kernel_param_ops param_ops_bint = {
> >  };
> >  EXPORT_SYMBOL(param_ops_bint);
> >  
> > +int param_set_static_key_t(const char *val, const struct kernel_param *kp)
> > +{
> > +	/* Match bool exactly, by re-using it. */
> > +	struct kernel_param boolkp = *kp;
> > +	bool v;
> > +	int ret;
> > +
> > +	boolkp.arg = &v;
> > +
> > +	ret = param_set_bool(val, &boolkp);
> > +	if (ret)
> > +		return ret;
> > +	if (v)
> > +		static_key_enable(kp->arg);
> > +	else
> > +		static_key_disable(kp->arg);
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL(param_set_static_key_t);
> > +
> > +int param_get_static_key_t(char *buffer, const struct kernel_param *kp)
> > +{
> > +	struct static_key *key = kp->arg;
> > +	return sprintf(buffer, "%c\n", static_key_enabled(key) ? 'N' : 'Y');
> 
> The 'N'/'Y' values are the other way around.

Thanks, fixed these
