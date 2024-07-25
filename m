Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE21C132492;
	Thu, 25 Jul 2024 13:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721913257; cv=none; b=MIQpQsaWmWKbW5lUVnn8CIfTQos769PQwAwIxuPJFs4VtwqKElSq733DIjvAmthKzPUGg2nemTh0ALIhMlrQ/a37VzCkyry2mrMSjO56OP+YCInQO/KsMR68RxhgCWUksPUmt8Yw1vw9S5244SL0BeOdBoyfV6zgE+Ca4v0G3PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721913257; c=relaxed/simple;
	bh=wEVHxiu3Gg6fXP3+WspO2QY7d4BxcqzBopV5kKhQhqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X8ILxIvKX1gdYyekHj+prK5WpG80wYu8NgLV/56rjz8fKFKDthJGMQ7OR9nWMUa/O/6R4XyaK4w6ddLZIfRWt94Ft/lb52LsuzyiqnuQ08rKM/qVHA0QHA4XGdBipwCoj8ZSYaBrpawCl6frgZp+tGYC4pKmHFNYNUsSXp1dPpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A0C31007;
	Thu, 25 Jul 2024 06:14:39 -0700 (PDT)
Received: from [10.1.29.30] (e122027.cambridge.arm.com [10.1.29.30])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 672373F5A1;
	Thu, 25 Jul 2024 06:14:12 -0700 (PDT)
Message-ID: <28d1989a-106d-4cae-81a9-a7bcc8a474f5@arm.com>
Date: Thu, 25 Jul 2024 14:14:10 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module: Add hard dependencies as syntactic sugar
To: Dragan Simic <dsimic@manjaro.org>, linux-modules@vger.kernel.org
Cc: mcgrof@kernel.org, linux-kernel@vger.kernel.org, didi.debian@cknow.org,
 Boris Brezillon <boris.brezillon@collabora.com>, Qiang Yu <yuq825@gmail.com>
References: <04e0676b0e77c5eb69df6972f41d77cdf061265a.1721906745.git.dsimic@manjaro.org>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <04e0676b0e77c5eb69df6972f41d77cdf061265a.1721906745.git.dsimic@manjaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/07/2024 12:37, Dragan Simic wrote:
> Panfrost and Lima DRM drivers use devfreq to perform DVFS, which is supported
> on the associated platforms, while using simple_ondemand devfreq governor by
> default.  This makes the simple_ondemand module a hard dependency for both
> Panfrost and Lima, because the presence of the simple_ondemand module in an
> initial ramdisk allows the initialization of Panfrost or Lima to succeed.
> This is currently expressed using MODULE_SOFTDEP. [1][2]  Please see commits
> 80f4e62730a9 ("drm/panfrost: Mark simple_ondemand governor as softdep") and
> 0c94f58cef31 ("drm/lima: Mark simple_ondemand governor as softdep") for
> additional background information.
> 
> With the addition of MODULE_WEAKDEP in commit 61842868de13 ("module: create
> weak dependecies"), the dependency between Panfrost/Lima and simple_ondemand
> can be expressed in a much better way as a weakdep, because that provides
> the required dependency information to the utilities that generate initial
> ramdisks, but leaves the actual loading of the required kernel module(s) to
> the kernel.  However, being able to actually express this as a hard module
> dependency would still be beneficial.
> 
> With all this in mind, let's add MODULE_HARDDEP as some kind of syntactic
> sugar, currently implemented as an alias for MODULE_WEAKDEP, so the actual
> hard module dependencies can be expressed properly, and possibly handled
> differently in the future, avoiding the need to go back, track and churn
> all such instances of hard module dependencies.  The first consumers of
> MODULE_HARDDEP will be the Panfrost and Lima DRM drivers, but the list of
> consumers may also grow a bit in the future.
> 
> For example, allowing reduction of the initial ramdisk size is a possible
> future difference between handling the MODULE_WEAKDEP and MODULE_HARDDEP
> dependencies.  When the size of the initial ramdisk is limited, the utilities
> that generate initial ramdisks can use the distinction between the weakdeps
> and the harddeps to safely omit some of the weakdep modules from the created
> initial ramdisks, and to keep all harddep modules.
> 
> Due to the nature of MODULE_WEAKDEP, the above-described example will also
> require some additional device-specific information to be made available to
> the utilities that create initial ramdisks, so they can actually know which
> weakdep modules can be safely pruned for a particular device, but the
> distinction between the harddeps and the weakdeps opens up a path towards
> using such additional "pruning information" in a more robust way, by ensuring
> that the absolutely required harddep modules aren't pruned away.
> 
> [1] https://lore.kernel.org/dri-devel/4e1e00422a14db4e2a80870afb704405da16fd1b.1718655077.git.dsimic@manjaro.org/T/#u
> [2] https://lore.kernel.org/dri-devel/fdaf2e41bb6a0c5118ff9cc21f4f62583208d885.1718655070.git.dsimic@manjaro.org/T/#u
> 
> Cc: Steven Price <steven.price@arm.com>
> Cc: Boris Brezillon <boris.brezillon@collabora.com>
> Cc: Qiang Yu <yuq825@gmail.com>
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>

Thanks Dragan, while there's obviously a bunch more work to hook this up
appropriately, this at least lets drivers signal the actual requirement.

Reviewed-by: Steven Price <steven.price@arm.com>

Steve

> ---
>  include/linux/module.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 88ecc5e9f523..40e5762847a9 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -179,6 +179,14 @@ extern void cleanup_module(void);
>   */
>  #define MODULE_WEAKDEP(_weakdep) MODULE_INFO(weakdep, _weakdep)
>  
> +/*
> + * Hard module dependencies. Currently handled the same as weak
> + * module dependencies, but intended to mark hard dependencies
> + * as such for possible different handling in the future.
> + * Example: MODULE_HARDDEP("module-foo")
> + */
> +#define MODULE_HARDDEP(_harddep) MODULE_WEAKDEP(_harddep)
> +
>  /*
>   * MODULE_FILE is used for generating modules.builtin
>   * So, make it no-op when this is being built as a module

