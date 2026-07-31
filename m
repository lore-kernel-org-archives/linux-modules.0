Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639541A9B58
	for <linux-modules@vger.kernel.org>; Fri, 31 Jul 2026 13:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785503936; cv=none; b=W7jkosxGCN7uPL4bFJAohsEQWTMCUFtjn4jhjYMTzWjyxTHCh0iaf1DfsTf48lx4LqbiKkR2RjkV7a3nADV5oGw3cxkJir4WxWeo505zZRllhfRYyVNP0PcICLfNanX7NTP8EDIOWEuxrCOK9VAUL1Jfmgw6tRChLHCtGI0ocjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785503936; c=relaxed/simple;
	bh=rmmEuShHu/e6OInQHuCsO8+/VGob18GzHfqm1SIIdF4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MoFM7Xv/2mPKjuJHIcLhYK4Y0GfgBd4Hzkws1NhN8qelXg2NzmflHbtCw5MMoLjye8KD798C/8mXasp/icq/WI03lbi8haZZap93f2/LG2QvigydxcRdYNUVFmjrbSrPrmmD8CxWLQ5r4rGLz2sH6Whdvu11ydcuhGsr18Ktop4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BeXisBfZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BeXisBfZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B085B1F00A3A;
	Fri, 31 Jul 2026 13:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785503934;
	bh=vuBjyyrhda2KmNErA01QxtBRl7kwaOXdmmJ4mYKLeys=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BeXisBfZruUsz7GyOKGU3eUPvOR2Ch1iSyzXHIZJBVrLvIkkmlhYTifbLivS3I3VO
	 Ts5GiO/wK3odLaCWvwuq2RFP0mSynkbdfQca2YTbSDOgaudgMaTYiQLKtuS5aQ2LRu
	 wAJOplb1eSfWGuHq5udd3P89yQOZwufBYK4vVY08cFFhtWMBQ3ptIrgwtTKyxrd7F/
	 t1t7axzWDffss+vZhBsiR4CvIwXUBDxETnYVrIuGt6c6yxXcSjDjoc7pLBn4TeNPqR
	 aNiPUnIuhsGzjL8KFugRiFBt6BqhoQX192wNiAJM+O56TjDbwQBSXSdXrZXweKxzdu
	 k70NSs7Ti8LPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] module: remove MODULE_VERSION()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260731-module_ver_remove-v2-1-c9163858f382@linuxfoundation.org>
References: <20260731-module_ver_remove-v2-0-c9163858f382@linuxfoundation.org>
 <20260731-module_ver_remove-v2-1-c9163858f382@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 13:18:54 +0000
Message-Id: <20260731131854.B085B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Immediate, unphased removal of the `/sys/module/*/version` sys=
fs ABI and `modinfo` version outputs.
--

--- Patch [1]: [PATCH v2 1/2] module: remove MODULE_VERSION() ---
commit b77f8591ff850600dbc1da5c9c2f45e06be183fe
Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

module: remove MODULE_VERSION()

This commit removes the MODULE_VERSION macro and its associated sysfs
attributes. It redefines the macro to be empty to keep existing code
building while it is phased out, as module versions do not make sense in
a unified build.

Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Petr Pavlu <petr.pavlu@suse.com>
Cc: Daniel Gomez <da.gomez@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>
Cc: Shyam Saini <shyamsaini@linux.microsoft.com>
Cc: Kees Cook <kees@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>

[ ... ]
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 7566815fabbe8..209b6a388be7c 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
[ ... ]
> -#if defined(MODULE) || !defined(CONFIG_SYSFS)
> -#define MODULE_VERSION(_version) MODULE_INFO(version, _version)
> -#else
> -#define MODULE_VERSION(_version)					\
> -	MODULE_INFO(version, _version);					\
> -	static const struct module_version_attribute __modver_attr	\
> -		__used __section("__modver")				\
> -		__aligned(__alignof__(struct module_version_attribute)) \
> -		=3D {							\
> -			.mattr	=3D {					\
> -				.attr	=3D {				\
> -					.name	=3D "version",		\
> -					.mode	=3D S_IRUGO,		\
> -				},					\
> -				.show	=3D __modver_version_show,	\
> -			},						\
> -			.module_name	=3D KBUILD_MODNAME,		\
> -			.version	=3D _version,			\
> -		}
> -#endif
> +#define MODULE_VERSION(_version)

[Severity: Critical]
Does redefining this macro to empty immediately prevent the version tag from
being embedded in the .modinfo section of all loadable modules? Could this
cause a regression for userspace tools like modinfo that might rely on
extracting this information?

[ ... ]
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 46dd8d25a6058..da8be9788d130 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
[ ... ]
> @@ -1084,7 +1083,6 @@ static const struct module_attribute modinfo_taint =
=3D
> =20
>  const struct module_attribute *const modinfo_attrs[] =3D {
>  	&module_uevent,
> -	&modinfo_version,

[Severity: Critical]
By removing this attribute, does this immediately break the loadable module
sysfs interface at /sys/module/module_name/version? Would it be safer to
provide a backward-compatible stub or deprecation period before completely
removing this stable ABI, to avoid regressions in userspace scripts?

>  	&modinfo_srcversion,
>  	&modinfo_import_ns,
>  	&modinfo_initstate,
[ ... ]
> diff --git a/kernel/params.c b/kernel/params.c
> index a668863a4bb63..6c5a1eb22b257 100644
> --- a/kernel/params.c
> +++ b/kernel/params.c
[ ... ]
> -static void __init version_sysfs_builtin(void)
> -{
> -	const struct module_version_attribute *vattr;
> -	struct module_kobject *mk;
> -	int err;
> -
> -	for (vattr =3D __start___modver; vattr < __stop___modver; vattr++) {
> -		mk =3D lookup_or_create_module_kobject(vattr->module_name);
> -		if (mk) {
> -			err =3D sysfs_create_file(&mk->kobj, &vattr->mattr.attr);
> -			WARN_ON_ONCE(err);
> -			kobject_uevent(&mk->kobj, KOBJ_ADD);
> -			kobject_put(&mk->kobj);
> -		}
> -	}
> -}
> -
[ ... ]
> @@ -968,7 +939,6 @@ static int __init param_sysfs_builtin_init(void)
>  	if (!module_kset)
>  		return -ENOMEM;
> =20
> -	version_sysfs_builtin();

[Severity: Critical]
Does the removal of this function and its call immediately drop the sysfs
version node for all built-in modules? Could this cause hardware inventory
scripts or udev rules to fail with ENOENT when they expect the file to exis=
t?

>  	param_sysfs_builtin();
> =20
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-module_ver=
_remove-v2-0-c9163858f382@linuxfoundation.org?part=3D1
