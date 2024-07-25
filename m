Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FE019D8A7;
	Thu, 25 Jul 2024 15:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721921983; cv=none; b=sue/FQbZ1mxBAbeZ2gwWNRH17WgZpAqIvlCAvO+JBxSWDJpXdPSYV34Y7hKYGZs+4e9CeKJZgVkArss5bIq4qZ4iBC30Lme3+qdVI+5jmBVKOImd9uGDXG9JRhERIgo+FgfzQ978BS/siOSozagx9kypRbVTQbsv9+i0eQgcfec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721921983; c=relaxed/simple;
	bh=/Q6LIwSXhl9w92fZ1x0zh6nl/6FRDk+HvHN6mbe9gvY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=sd06qnhjmgYrZT7iMJVL+Z59C92ww5lEycczkcIec5wnnFj6Xa9D04U7MIygCH+Nof7nFRIXMCjHPU3yh7HpghO850WSKFDYwLvLL3mI644bmloyq6X48UU/HRMPAantDHR52mG5TFOV6NEbOyluvZl+D03gYf1Pi5CCEfi3nSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=mSsR1/UL; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="mSsR1/UL"
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1721921977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lm30dDQVqW/J+G07pqjob65g5GHevsNWLvfXIuMQvmU=;
	b=mSsR1/ULP6oqUL6WuFDMYE47yoVC4k7Py62pGy+1IylC3URFAtnAdc00/Zv9GqsaZJ7KAA
	6FPvinYd1RN/15d5fVJoTtzmgnFoece4FFCaFfpQ5P404OGGyTW0B7Hd5lRrYdtQxjEGuN
	CqM9XJpOmYIn2vqtbX2Xn9fWUf7c+o+VucuDgYzLvfC5g+b9rbvD55Lfs0tPp9BS3ccNCL
	c8bSU/eMMmqCdxN1If6HEqfiXcpbzK/XUns7W+8ZQ0q4+09ViySzk/v3V6R1Zzb+xUmoHr
	WrlV7dH9TvCBN/LU3LNn0mdkeyX3RG6vuL459f4MerUnQg7ap+8aGQdU+kA9Og==
Date: Thu, 25 Jul 2024 17:39:37 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: linux-modules@vger.kernel.org, mcgrof@kernel.org,
 linux-kernel@vger.kernel.org, didi.debian@cknow.org, Steven Price
 <steven.price@arm.com>, Boris Brezillon <boris.brezillon@collabora.com>,
 Qiang Yu <yuq825@gmail.com>
Subject: Re: [PATCH] module: Add hard dependencies as syntactic sugar
In-Reply-To: <gcykzencr7rmeiy3rmclxrbbvuryo2uyb6plqqovee3bsme42b@g6pwzbgitgka>
References: <04e0676b0e77c5eb69df6972f41d77cdf061265a.1721906745.git.dsimic@manjaro.org>
 <gcykzencr7rmeiy3rmclxrbbvuryo2uyb6plqqovee3bsme42b@g6pwzbgitgka>
Message-ID: <0720a516416a92a8f683053d37ee9481@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Lucas,

On 2024-07-25 16:29, Lucas De Marchi wrote:
> On Thu, Jul 25, 2024 at 01:37:46PM GMT, Dragan Simic wrote:
>> Panfrost and Lima DRM drivers use devfreq to perform DVFS, which is 
>> supported
>> on the associated platforms, while using simple_ondemand devfreq 
>> governor by
>> default.  This makes the simple_ondemand module a hard dependency for 
>> both
>> Panfrost and Lima, because the presence of the simple_ondemand module 
>> in an
>> initial ramdisk allows the initialization of Panfrost or Lima to 
>> succeed.
>> This is currently expressed using MODULE_SOFTDEP. [1][2]  Please see 
>> commits
>> 80f4e62730a9 ("drm/panfrost: Mark simple_ondemand governor as 
>> softdep") and
>> 0c94f58cef31 ("drm/lima: Mark simple_ondemand governor as softdep") 
>> for
>> additional background information.
>> 
>> With the addition of MODULE_WEAKDEP in commit 61842868de13 ("module: 
>> create
>> weak dependecies"), the dependency between Panfrost/Lima and 
>> simple_ondemand
>> can be expressed in a much better way as a weakdep, because that 
>> provides
>> the required dependency information to the utilities that generate 
>> initial
>> ramdisks, but leaves the actual loading of the required kernel 
>> module(s) to
>> the kernel.  However, being able to actually express this as a hard 
>> module
>> dependency would still be beneficial.
>> 
>> With all this in mind, let's add MODULE_HARDDEP as some kind of 
>> syntactic
> 
> Sorry, but NACK from me. This only adds to the confusion.
> 
> hard/normal dependency:
> 	It's a symbol dependency. If you want it in your module, you
> 	have to use a symbol. Example:
> 
> 	$ modinfo ksmbd | grep depends
> 	depends:        ib_core,rdma_cm,nls_ucs2_utils,cifs_arc4
> 
> 
> soft dependency:
> 	A dependency you declare in configuration or in the module
> 	info added by the kernel. A "pre" softdep means libkmod/modprobe
> 	will try to load that dep before the actual module. Example:
> 
> 	$ modinfo ksmbd | grep softdep
> 	softdep:        pre: crc32
> 	softdep:        pre: gcm
> 	softdep:        pre: ccm
> 	softdep:        pre: aead2
> 	softdep:        pre: sha512
> 	softdep:        pre: sha256
> 	softdep:        pre: cmac
> 	softdep:        pre: aes
> 	softdep:        pre: nls
> 	softdep:        pre: md5
> 	softdep:        pre: hmac
> 	softdep:        pre: ecb
> 
> weak dependency:
> 	A dependency you declare in configuration or in the module
> 	info added by the kernel. libkmod/modprobe will not change the
> 	way it loads the module and it will only used by tools that need
> 	to make sure the module is there when the kernel does a
> 	request_module() or somehow tries to load that module.

Thanks for a very nicely written and detailed summary.  Alas, I knew
all that already.

> So if you want a hard dependency, just use a symbol from the module. If
> you want to emulate a hard dependency without calling a symbol, you use
> a pre softdep, not a weakdep.  You use a weakdep if the kernel itself,
> somehow may load module in runtime.
> 
> The problem described in 80f4e62730a9 ("drm/panfrost: Mark
> simple_ondemand governor as softdep")
> could indeed be solved with a weakdep, so I'm not sure why you'd want 
> to
> alias it as a "hard dep".

It's obviously true that the described problem with Panfrost and Lima
can be solved using weakdeps.  However, solving a problem and going
the extra mile to future-proof the solution are two rather different
things.  The proposed introduction of harddeps tries to go the extra
mile, and to future-proof any possible changes to weakdeps, as already
described in the patch description.

To sum it up, harddeps would be something like "pinned down" weakdeps,
that must not be removed by any future size-related optimizations of
the initial ramdisk contents.  While it costs us nearly nothing to add
support for that now, it may provide reasonable returns in the future.
And can be easily reverted at any point, if the later conclusion is
that the expected returns didn't pan out.

As an example of the differences between just solving a problem and
going the extra mile, let's have a look at the commit d5178578bcd4
(btrfs: directly call into crypto framework for checksumming) and the
lines containing MODULE_SOFTDEP at the very end of fs/btrfs/super.c. [3]
Are all those softdeps candidates for straight conversion into weakdeps,
i.e. can the kernel load all those modules by itself?  Perhaps, but
also maybe not, meaning that all those softdeps need to be investigated
and tested before the conversion, incurring additional cost.  OTOH, if
Btrfs went the extra mile and used some "syntactic sugar" instead, we'd
probably have the conversion ready to go now, at zero cost.

That's what the proposed "syntactic sugar" harddeps try to do, to save
us some time and effort later down the road.

[3] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/btrfs/super.c#n2610

>> sugar, currently implemented as an alias for MODULE_WEAKDEP, so the 
>> actual
>> hard module dependencies can be expressed properly, and possibly 
>> handled
>> differently in the future, avoiding the need to go back, track and 
>> churn
>> all such instances of hard module dependencies.  The first consumers 
>> of
>> MODULE_HARDDEP will be the Panfrost and Lima DRM drivers, but the list 
>> of
>> consumers may also grow a bit in the future.
>> 
>> For example, allowing reduction of the initial ramdisk size is a 
>> possible
>> future difference between handling the MODULE_WEAKDEP and 
>> MODULE_HARDDEP
>> dependencies.  When the size of the initial ramdisk is limited, the 
>> utilities
>> that generate initial ramdisks can use the distinction between the 
>> weakdeps
>> and the harddeps to safely omit some of the weakdep modules from the 
>> created
>> initial ramdisks, and to keep all harddep modules.
>> 
>> Due to the nature of MODULE_WEAKDEP, the above-described example will 
>> also
>> require some additional device-specific information to be made 
>> available to
>> the utilities that create initial ramdisks, so they can actually know 
>> which
>> weakdep modules can be safely pruned for a particular device, but the
>> distinction between the harddeps and the weakdeps opens up a path 
>> towards
>> using such additional "pruning information" in a more robust way, by 
>> ensuring
>> that the absolutely required harddep modules aren't pruned away.
>> 
>> [1] 
>> https://lore.kernel.org/dri-devel/4e1e00422a14db4e2a80870afb704405da16fd1b.1718655077.git.dsimic@manjaro.org/T/#u
>> [2] 
>> https://lore.kernel.org/dri-devel/fdaf2e41bb6a0c5118ff9cc21f4f62583208d885.1718655070.git.dsimic@manjaro.org/T/#u
>> 
>> Cc: Steven Price <steven.price@arm.com>
>> Cc: Boris Brezillon <boris.brezillon@collabora.com>
>> Cc: Qiang Yu <yuq825@gmail.com>
>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> ---
>> include/linux/module.h | 8 ++++++++
>> 1 file changed, 8 insertions(+)
>> 
>> diff --git a/include/linux/module.h b/include/linux/module.h
>> index 88ecc5e9f523..40e5762847a9 100644
>> --- a/include/linux/module.h
>> +++ b/include/linux/module.h
>> @@ -179,6 +179,14 @@ extern void cleanup_module(void);
>>  */
>> #define MODULE_WEAKDEP(_weakdep) MODULE_INFO(weakdep, _weakdep)
>> 
>> +/*
>> + * Hard module dependencies. Currently handled the same as weak
>> + * module dependencies, but intended to mark hard dependencies
>> + * as such for possible different handling in the future.
>> + * Example: MODULE_HARDDEP("module-foo")
>> + */
>> +#define MODULE_HARDDEP(_harddep) MODULE_WEAKDEP(_harddep)
>> +
>> /*
>>  * MODULE_FILE is used for generating modules.builtin
>>  * So, make it no-op when this is being built as a module
