Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C79F1C5D72
	for <linux-modules@vger.kernel.org>; Mon,  6 Jul 2026 05:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783314987; cv=none; b=PSJLoFfWfK9+GTgkqnsZJquqjp1WY5+v8iYUnqxrKD5PRq26xNZloYTAKp+/ejd9j3MmnV9shpOkZwPSbslKNy/UpCe5yR2eO1P5xufe+/jVwaCUaoBqYqvhfZQCAWnQI8b98O5umPOfyEr5DB4cKshgzVezJDjqb6L+FSqkFJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783314987; c=relaxed/simple;
	bh=QB2F25+RmfPdD25p/cN3YAcuun15Oe90q+NesPFL5zE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hWKxLsPyK9RTtwN8Bs/OMrkp1A6lxssIq6id05x3nciBEorCdiheu1XueD2eBFx9lZg9canHR1htCPo+mK8SNtF8XF8VWq8sLK3mzrZE7gywAXMOCA9U6bBB7rRAyWe1Rg/cYV7WxFPonVL+diXYaP3Ns/B0PRmaiCyYwxRrd/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5qyoZTM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5qyoZTM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E690F1F000E9;
	Mon,  6 Jul 2026 05:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783314986;
	bh=+9WNFb2pTW1OEIH0pRDGWLhIx9fm67amwnPthF0yxwA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y5qyoZTMKAub5ObeUfpPJaXgXYtHOCgQH5RolAJ36KvAs5jbvVOouMC85lSSmeW+X
	 p7IkoQMhNl3kv41YwAU89qNkHHG0wp7AN29EslXmv9VQvHaPJPcyD7e2sUEVT+g6tq
	 9HRx8zSR3FuEvlLjRJcCFdeNVVwaXroJU0187wYUMnKFSbuiH+IeUdos1wNfd/utlh
	 mSsIRZZ06jv8MbFMJ8VolZzCNZPFF99FD+nG1F2oNpjRnbA/ti3aiG7jOBNypBNXpu
	 8sPLq4jksNTffksyCjKaZQ1Ff0WZuJyPYTm+YzodcfNYinsNkVz9MqBGTJQvRiqdC2
	 ebkpsvl8IWaqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] module: Extend module_blacklist parameter to
 built-in modules
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260706050337.7613-1-atomlin@atomlin.com>
References: <20260706050337.7613-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 05:16:25 +0000
Message-Id: <20260706051625.E690F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Iterating the `.initcall.modnames` array locklessly in `initcall_g=
et_modname()` races with `free_initmem()`, causing a Use-After-Free for con=
currently loaded modules.
- [High] The built-in module blacklisting functionality is completely disab=
led when CONFIG_MODULES=3Dn.
--

commit aca1118f7ac6c8d2b798e7bb31a70a4f01638aee
Author: Aaron Tomlin <atomlin@atomlin.com>
Subject: module: Extend module_blacklist parameter to built-in modules

This patch extends the module_blacklist command-line parameter to apply
to built-in modules by checking them during early boot. It introduces a
new memory section to map initcalls to module names, allowing the kernel
to skip the initcall if the module name is present in the blacklist.

> diff --git a/include/linux/module.h b/include/linux/module.h
> index 7566815fabbe8..b9b0dc419aeeb 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
[ ... ]
> @@ -756,6 +756,15 @@ void *dereference_module_function_descriptor(struct =
module *mod, void *ptr);
>  int register_module_notifier(struct notifier_block *nb);
>  int unregister_module_notifier(struct notifier_block *nb);
> =20
> +#ifdef CONFIG_MODULES
> +extern bool module_is_blacklisted(const char *module_name);
> +#else
> +static inline bool module_is_blacklisted(const char *module_name)
> +{
> +	return false;
> +}
> +#endif

[Severity: High]
Does this defeat the purpose of blacklisting built-in modules on kernels
built without loadable module support?

If a kernel is built with CONFIG_MODULES=3Dn, the command-line parsing and
state variable in kernel/module/main.c are not compiled. This stub will then
unconditionally return false, meaning the module_blacklist parameter will be
silently ignored for built-in modules on non-modular kernels.

[ ... ]
> diff --git a/init/main.c b/init/main.c
> index 96f93bb06c490..893b20ddcf658 100644
> --- a/init/main.c
> +++ b/init/main.c
[ ... ]
> @@ -1379,12 +1379,39 @@ static inline void do_trace_initcall_level(const =
char *level)
>  }
>  #endif /* !TRACEPOINTS_ENABLED */
> =20
> +extern struct initcall_modname __start_initcall_modnames[];
> +extern struct initcall_modname __stop_initcall_modnames[];
> +
> +static bool initmem_freed __ro_after_init =3D false;
> +
> +static const char *initcall_get_modname(initcall_t fn)
> +{
> +	struct initcall_modname *p;
> +
> +	if (initmem_freed)
> +		return NULL;
> +
> +	for (p =3D __start_initcall_modnames; p < __stop_initcall_modnames; p++=
) {
> +		if (p->initcall_fn =3D=3D fn)
> +			return p->modname;
> +	}

[Severity: High]
Can this race with free_initmem() and cause a use-after-free if a module
is loaded concurrently?

In kernel_init(), free_initmem() is called just before setting initmem_freed
to true:

kernel_init()
    free_initmem();
    initmem_freed =3D true;

At this point in the boot sequence, the rootfs is mounted and user-mode
helpers are enabled. If a hardware interrupt triggers request_module()
concurrently, modprobe could execute and invoke the init_module syscall.=20

When do_init_module() calls do_one_initcall(), it would end up in
initcall_get_modname(). Since initmem_freed is still false, it would
locklessly scan the .initcall.modnames section while it is actively being
freed by free_initmem().

[ ... ]
> @@ -1600,6 +1627,7 @@ static int __ref kernel_init(void *unused)
>  	kgdb_free_init_mem();
>  	exit_boot_config();
>  	free_initmem();
> +	initmem_freed =3D true;
>  	mark_readonly();
> =20
>  	/*

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706050337.7613=
-1-atomlin@atomlin.com?part=3D1
