Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6F719DF41;
	Thu, 25 Jul 2024 15:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721921987; cv=none; b=Zb1Kt5YOg8ErqBWC+nEw57FoxNSpckKiWdULmlKXFxNdTEuDFPb/crn0fSzDuLW5wfnwNbyx773DsO5P1WnARm9Pw7RCbPnQoGNViSHkWNLw6yBguv8ctSV8Fk2dxRcua/VA3NgmnWHyh7dUAApV0DGR4LXs6DNWWcw2XjJ9J5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721921987; c=relaxed/simple;
	bh=v+vDbZ9ZQ3ucsT4jO/1Z14DM40ZA3a7Wl6/IGsmK3Lo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rU1qgwh/viSR2caByvScQYdEyeRItHZrrwVBpeIqQL7LhNwA/D2BkK8jFLf08mhPPzKmnOEu+E6qQnIndBh9YvfAocOVo7pnhFrniocvrq2HN3ZSqIFa9yeSwEMGQfVQZyBRyoACbVwcNWa5n+Bmt+ZKDnc/fbgNUNJc59bMOUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ABB921007;
	Thu, 25 Jul 2024 08:40:09 -0700 (PDT)
Received: from [10.1.29.30] (e122027.cambridge.arm.com [10.1.29.30])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C537D3F766;
	Thu, 25 Jul 2024 08:39:42 -0700 (PDT)
Message-ID: <1393cce9-bd64-469d-aa2b-0fb768bf9e87@arm.com>
Date: Thu, 25 Jul 2024 16:39:40 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module: Add hard dependencies as syntactic sugar
To: Lucas De Marchi <lucas.demarchi@intel.com>,
 Dragan Simic <dsimic@manjaro.org>
Cc: linux-modules@vger.kernel.org, mcgrof@kernel.org,
 linux-kernel@vger.kernel.org, didi.debian@cknow.org,
 Boris Brezillon <boris.brezillon@collabora.com>, Qiang Yu <yuq825@gmail.com>
References: <04e0676b0e77c5eb69df6972f41d77cdf061265a.1721906745.git.dsimic@manjaro.org>
 <gcykzencr7rmeiy3rmclxrbbvuryo2uyb6plqqovee3bsme42b@g6pwzbgitgka>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <gcykzencr7rmeiy3rmclxrbbvuryo2uyb6plqqovee3bsme42b@g6pwzbgitgka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 25/07/2024 15:29, Lucas De Marchi wrote:
> On Thu, Jul 25, 2024 at 01:37:46PM GMT, Dragan Simic wrote:
>> Panfrost and Lima DRM drivers use devfreq to perform DVFS, which is
>> supported
>> on the associated platforms, while using simple_ondemand devfreq
>> governor by
>> default.  This makes the simple_ondemand module a hard dependency for
>> both
>> Panfrost and Lima, because the presence of the simple_ondemand module
>> in an
>> initial ramdisk allows the initialization of Panfrost or Lima to succeed.
>> This is currently expressed using MODULE_SOFTDEP. [1][2]  Please see
>> commits
>> 80f4e62730a9 ("drm/panfrost: Mark simple_ondemand governor as
>> softdep") and
>> 0c94f58cef31 ("drm/lima: Mark simple_ondemand governor as softdep") for
>> additional background information.
>>
>> With the addition of MODULE_WEAKDEP in commit 61842868de13 ("module:
>> create
>> weak dependecies"), the dependency between Panfrost/Lima and
>> simple_ondemand
>> can be expressed in a much better way as a weakdep, because that provides
>> the required dependency information to the utilities that generate
>> initial
>> ramdisks, but leaves the actual loading of the required kernel
>> module(s) to
>> the kernel.  However, being able to actually express this as a hard
>> module
>> dependency would still be beneficial.
>>
>> With all this in mind, let's add MODULE_HARDDEP as some kind of syntactic
> 
> Sorry, but NACK from me. This only adds to the confusion.
> 
> hard/normal dependency:
>     It's a symbol dependency. If you want it in your module, you
>     have to use a symbol. Example:
> 
>     $ modinfo ksmbd | grep depends
>     depends:        ib_core,rdma_cm,nls_ucs2_utils,cifs_arc4
> 
> 
> soft dependency:
>     A dependency you declare in configuration or in the module
>     info added by the kernel. A "pre" softdep means libkmod/modprobe
>     will try to load that dep before the actual module. Example:
> 
>     $ modinfo ksmbd | grep softdep
>     softdep:        pre: crc32
>     softdep:        pre: gcm
>     softdep:        pre: ccm
>     softdep:        pre: aead2
>     softdep:        pre: sha512
>     softdep:        pre: sha256
>     softdep:        pre: cmac
>     softdep:        pre: aes
>     softdep:        pre: nls
>     softdep:        pre: md5
>     softdep:        pre: hmac
>     softdep:        pre: ecb
> 
> weak dependency:
>     A dependency you declare in configuration or in the module
>     info added by the kernel. libkmod/modprobe will not change the
>     way it loads the module and it will only used by tools that need
>     to make sure the module is there when the kernel does a
>     request_module() or somehow tries to load that module.
> 
> So if you want a hard dependency, just use a symbol from the module. If
> you want to emulate a hard dependency without calling a symbol, you use
> a pre softdep, not a weakdep.  You use a weakdep if the kernel itself,
> somehow may load module in runtime.
> 
> The problem described in 80f4e62730a9 ("drm/panfrost: Mark
> simple_ondemand governor as softdep")
> could indeed be solved with a weakdep, so I'm not sure why you'd want to
> alias it as a "hard dep".

The simple_ondemand dependency sadly isn't visible as a symbol. It's
currently 'fixed' by using a softdep, but that has drawbacks and doesn't
actually express the requirement. A "weakdep" works, but has the
drawback that it implies that the dependency is optional. This patch at
least means that the driver can express the dependency, even if
currently that just gets output as the same weakdep.

I'm not sure what the logic was behind the name "weak" - what we
(currently at least) have in panfrost is not a weak dependency by the
normal definition of the term - the driver will fail to load if the
ondemand governor is unavailable.

This patch doesn't solve the confusion, but at least means panfrost
doesn't need another round of churn in the future. The alternative
presumably is don't merge this and panfrost will have to wait until a
proper "hard dependency" mechanism is available.

Steve

