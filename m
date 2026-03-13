Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927EA355F58;
	Fri, 13 Mar 2026 15:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773416772; cv=none; b=ctI2oANlBuzkSoKTkFdJ+AN4dP5yBTOx7yg5wEIxf4UgaGHumqqaA2oOTGPipPAB9n4qtjSH1+/anrTG70C9rnOfIGvrrWvV7E9Wyz2nK4QfeQZP4XR5LNJEsLQqfm1OGsWYk6tTr9s9AAU62iJhWj1mcKA2tVlUZ4hMXPyYG3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773416772; c=relaxed/simple;
	bh=QBg0P3i6TrcPBF+Kz4X9evfITG3pLu6eqqjmL0ymkkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D7N7+FZ4cOcKca/Rl/N3alGDaa/RdnjntjdtjNs8bFy9X1EAx08UkW/fETlor93ZC0ywakS9Ye6GcMf/DXGdvPLn4WWLgNtc45zXyRCUjaDalB4S+PnzBU3vRvVoKL+T6ekWmZQlMSHJXycEDOAaMfvcrvDCHCpKw10dJoHLXBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ieMFhs9q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ieMFhs9q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD88C19421;
	Fri, 13 Mar 2026 15:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773416772;
	bh=QBg0P3i6TrcPBF+Kz4X9evfITG3pLu6eqqjmL0ymkkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ieMFhs9qa5yNqz7puTTH+1OxKkPpjNHLjBzhsuDU9jQQmdHWMlQEymRU5IlzTZmEn
	 Kje5TR3THZbtFWoWYDNtsxS+RSoF/JsXAi0J4FABOhAGpLysrOYa9zK6THXPWgXjEH
	 o5cUx3zPPhysYQzChHP68MQnJ1f1PExqE3Je3uVg=
Date: Fri, 13 Mar 2026 16:46:06 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Shyam Saini <shyamsaini@linux.microsoft.com>,
	Kees Cook <kees@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] module: remove MODULE_VERSION()
Message-ID: <2026031303-prelaunch-creation-3fce@gregkh>
References: <2026031341-evolve-repeater-987b@gregkh>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026031341-evolve-repeater-987b@gregkh>

On Fri, Mar 13, 2026 at 03:20:42PM +0100, Greg Kroah-Hartman wrote:
> Module "versions" do not make sense as the kernel is built all at once,
> the "version" is the overall kernel version number, so modules can not
> really be described as having a unique version given that they rely on
> the infrastructure of the whole kernel.
> 
> For now, just make this an "empty" define, to keep existing code
> building properly as the tree is slowly purged of the use of this over
> time.
> 
> This macro will be removed entirely in the future when there are no
> in-tree users.
> 
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Petr Pavlu <petr.pavlu@suse.com>
> Cc: Daniel Gomez <da.gomez@kernel.org>
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Cc: Aaron Tomlin <atomlin@atomlin.com>
> Cc: Shyam Saini <shyamsaini@linux.microsoft.com>
> Cc: Kees Cook <kees@kernel.org>
> Cc: Thorsten Blum <thorsten.blum@linux.dev>
> Cc: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  include/linux/module.h | 56 +++++++++---------------------------------
>  kernel/params.c        | 30 ----------------------
>  2 files changed, 11 insertions(+), 75 deletions(-)


Sami just pointed out to me off-list that maybe I should also drop the
srcversion stuff too.  I'll gladly do that too, does anyone know if
anyone even uses that anymore?

thanks,

greg k-h


> 
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 14f391b186c6..37cb369b4c3a 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -62,15 +62,6 @@ struct module_attribute {
>  	void (*free)(struct module *);
>  };
>  
> -struct module_version_attribute {
> -	struct module_attribute mattr;
> -	const char *module_name;
> -	const char *version;
> -};
> -
> -extern ssize_t __modver_version_show(const struct module_attribute *,
> -				     struct module_kobject *, char *);
> -
>  extern const struct module_attribute module_uevent;
>  
>  /* These are either module local, or the kernel's dummy ones. */
> @@ -256,43 +247,18 @@ struct module_kobject *lookup_or_create_module_kobject(const char *name);
>  static typeof(name) __mod_device_table(type, name)			\
>    __attribute__ ((used, alias(__stringify(name))))
>  
> -/* Version of form [<epoch>:]<version>[-<extra-version>].
> - * Or for CVS/RCS ID version, everything but the number is stripped.
> - * <epoch>: A (small) unsigned integer which allows you to start versions
> - * anew. If not mentioned, it's zero.  eg. "2:1.0" is after
> - * "1:2.0".
> -
> - * <version>: The <version> may contain only alphanumerics and the
> - * character `.'.  Ordered by numeric sort for numeric parts,
> - * ascii sort for ascii parts (as per RPM or DEB algorithm).
> -
> - * <extraversion>: Like <version>, but inserted for local
> - * customizations, eg "rh3" or "rusty1".
> -
> - * Using this automatically adds a checksum of the .c files and the
> - * local headers in "srcversion".
> +/*
> + * Module "versions" do not make sense as the kernel is built all at once, the
> + * "version" is the overall kernel version number, so modules can not really be
> + * described as having a unique version given that they rely on the
> + * infrastructure of the whole kernel.
> + *
> + * For now, just make this an "empty" define, to keep existing code building
> + * properly as the tree is slowly purged of the use of this over time.
> + *
> + * It will be removed in the future when there are no in-tree users.
>   */
> -
> -#if defined(MODULE) || !defined(CONFIG_SYSFS)
> -#define MODULE_VERSION(_version) MODULE_INFO(version, _version)
> -#else
> -#define MODULE_VERSION(_version)					\
> -	MODULE_INFO(version, _version);					\
> -	static const struct module_version_attribute __modver_attr	\
> -		__used __section("__modver")				\
> -		__aligned(__alignof__(struct module_version_attribute)) \
> -		= {							\
> -			.mattr	= {					\
> -				.attr	= {				\
> -					.name	= "version",		\
> -					.mode	= S_IRUGO,		\
> -				},					\
> -				.show	= __modver_version_show,	\
> -			},						\
> -			.module_name	= KBUILD_MODNAME,		\
> -			.version	= _version,			\
> -		}
> -#endif
> +#define MODULE_VERSION(_version)
>  
>  /* Optional firmware file (or files) needed by the module
>   * format is simply firmware file name.  Multiple firmware
> diff --git a/kernel/params.c b/kernel/params.c
> index 7188a12dbe86..1b14b1ab5fcb 100644
> --- a/kernel/params.c
> +++ b/kernel/params.c
> @@ -846,35 +846,6 @@ static void __init param_sysfs_builtin(void)
>  	}
>  }
>  
> -ssize_t __modver_version_show(const struct module_attribute *mattr,
> -			      struct module_kobject *mk, char *buf)
> -{
> -	const struct module_version_attribute *vattr =
> -		container_of_const(mattr, struct module_version_attribute, mattr);
> -
> -	return scnprintf(buf, PAGE_SIZE, "%s\n", vattr->version);
> -}
> -
> -extern const struct module_version_attribute __start___modver[];
> -extern const struct module_version_attribute __stop___modver[];
> -
> -static void __init version_sysfs_builtin(void)
> -{
> -	const struct module_version_attribute *vattr;
> -	struct module_kobject *mk;
> -	int err;
> -
> -	for (vattr = __start___modver; vattr < __stop___modver; vattr++) {
> -		mk = lookup_or_create_module_kobject(vattr->module_name);
> -		if (mk) {
> -			err = sysfs_create_file(&mk->kobj, &vattr->mattr.attr);
> -			WARN_ON_ONCE(err);
> -			kobject_uevent(&mk->kobj, KOBJ_ADD);
> -			kobject_put(&mk->kobj);
> -		}
> -	}
> -}
> -
>  /* module-related sysfs stuff */
>  
>  static ssize_t module_attr_show(struct kobject *kobj,
> @@ -977,7 +948,6 @@ static int __init param_sysfs_builtin_init(void)
>  	if (!module_kset)
>  		return -ENOMEM;
>  
> -	version_sysfs_builtin();
>  	param_sysfs_builtin();
>  
>  	return 0;
> -- 
> 2.53.0
> 
