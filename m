Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158C11876;
	Thu, 25 Jul 2024 19:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721935960; cv=none; b=qT6gH0bIsSPr1nUNx8rPieMjuD0v9VTJiyvsjdZFYIRjAT+hBUiAP1FCMtebJHO4v/bKeCICOg+sPBk6bu8HKqnsLtWRVdecneHRS1pIseZ8JKKope2fSbht5dMVLhOc7wRzLTXGqds6zH3v55Mc84gbtq+Nt44OgAvhgIWVE1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721935960; c=relaxed/simple;
	bh=FmFag/CPdRM5Dq+AMW3R4tLqs2LxrSQ4RKQ8D5qvilI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=POs8V1SkZFcaH1tHusTiyjkZDk8Dihw9vkieMZQugOEPdQaNo+knTGf8K6cie4rQ0NDFvPdasd9389r7rHioRy9Un7yCrhwRo1N+GyXWu/lfSB5yjjQ/Ke7WfH8kQIQCmITg+9vwL6GxANInRQIZglIUJicx4dBgvOsYxd0spV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=SbMiqOQl; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="SbMiqOQl"
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1721935954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vljbOj0RqWrDMZtpDrJztXT0Xh6bVenVGKqiwXx4/mo=;
	b=SbMiqOQl4iDRaVN6yXYR3VsKW+Zm/ZtlLBuSCRGCIc4mQibqbtUthhNS7nunQdpb9o48MG
	lqku3mIuXjZevYwHGMYsWSis6b/af9L8w+XqHZOWKuvLs/DZ6+riMw00GUX0qqTSKuLuUW
	zPMS6FMV1FvZYyrHrmN/kFePJae5xoJpRz/X6XUfLiuYMWTIU1LlE7Hw77N8OoKfFGJXGA
	COT51SMAG8W/nhwqo7mSBHMeu3xKfb6ffZ0V7NPgzejCESyfu8pRMHP9HvifFW07c5U6mw
	audymi0gwTEboNbQGoX2fPniY6Qh7G8qoc9ZCycplc0MCfoa3pt2WzqbgMA9ZA==
Date: Thu, 25 Jul 2024 21:32:34 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Steven Price <steven.price@arm.com>, linux-modules@vger.kernel.org,
 mcgrof@kernel.org, linux-kernel@vger.kernel.org, didi.debian@cknow.org,
 Boris Brezillon <boris.brezillon@collabora.com>, Qiang Yu <yuq825@gmail.com>
Subject: Re: [PATCH] module: Add hard dependencies as syntactic sugar
In-Reply-To: <azedppfy2e5vjycn4zpzkj4ek5mjgjmdjsxf63fm347pningpc@uuhkyeiu35yg>
References: <04e0676b0e77c5eb69df6972f41d77cdf061265a.1721906745.git.dsimic@manjaro.org>
 <gcykzencr7rmeiy3rmclxrbbvuryo2uyb6plqqovee3bsme42b@g6pwzbgitgka>
 <1393cce9-bd64-469d-aa2b-0fb768bf9e87@arm.com>
 <azedppfy2e5vjycn4zpzkj4ek5mjgjmdjsxf63fm347pningpc@uuhkyeiu35yg>
Message-ID: <202ebbd07a2484573dc7d235d847f228@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Lucas,

On 2024-07-25 19:18, Lucas De Marchi wrote:
> On Thu, Jul 25, 2024 at 04:39:40PM GMT, Steven Price wrote:
>> On 25/07/2024 15:29, Lucas De Marchi wrote:
>>> On Thu, Jul 25, 2024 at 01:37:46PM GMT, Dragan Simic wrote:
>>>> Panfrost and Lima DRM drivers use devfreq to perform DVFS, which is
>>>> supported
>>>> on the associated platforms, while using simple_ondemand devfreq
>>>> governor by
>>>> default.  This makes the simple_ondemand module a hard dependency 
>>>> for
>>>> both
>>>> Panfrost and Lima, because the presence of the simple_ondemand 
>>>> module
>>>> in an
>>>> initial ramdisk allows the initialization of Panfrost or Lima to 
>>>> succeed.
>>>> This is currently expressed using MODULE_SOFTDEP. [1][2]  Please see
>>>> commits
>>>> 80f4e62730a9 ("drm/panfrost: Mark simple_ondemand governor as
>>>> softdep") and
>>>> 0c94f58cef31 ("drm/lima: Mark simple_ondemand governor as softdep") 
>>>> for
>>>> additional background information.
>>>> 
>>>> With the addition of MODULE_WEAKDEP in commit 61842868de13 ("module:
>>>> create
>>>> weak dependecies"), the dependency between Panfrost/Lima and
>>>> simple_ondemand
>>>> can be expressed in a much better way as a weakdep, because that 
>>>> provides
>>>> the required dependency information to the utilities that generate
>>>> initial
>>>> ramdisks, but leaves the actual loading of the required kernel
>>>> module(s) to
>>>> the kernel.  However, being able to actually express this as a hard
>>>> module
>>>> dependency would still be beneficial.
>>>> 
>>>> With all this in mind, let's add MODULE_HARDDEP as some kind of 
>>>> syntactic
>>> 
>>> Sorry, but NACK from me. This only adds to the confusion.
>>> 
>>> hard/normal dependency:
>>>     It's a symbol dependency. If you want it in your module, you
>>>     have to use a symbol. Example:
>>> 
>>>     $ modinfo ksmbd | grep depends
>>>     depends:        ib_core,rdma_cm,nls_ucs2_utils,cifs_arc4
>>> 
>>> 
>>> soft dependency:
>>>     A dependency you declare in configuration or in the module
>>>     info added by the kernel. A "pre" softdep means libkmod/modprobe
>>>     will try to load that dep before the actual module. Example:
>>> 
>>>     $ modinfo ksmbd | grep softdep
>>>     softdep:        pre: crc32
>>>     softdep:        pre: gcm
>>>     softdep:        pre: ccm
>>>     softdep:        pre: aead2
>>>     softdep:        pre: sha512
>>>     softdep:        pre: sha256
>>>     softdep:        pre: cmac
>>>     softdep:        pre: aes
>>>     softdep:        pre: nls
>>>     softdep:        pre: md5
>>>     softdep:        pre: hmac
>>>     softdep:        pre: ecb
>>> 
>>> weak dependency:
>>>     A dependency you declare in configuration or in the module
>>>     info added by the kernel. libkmod/modprobe will not change the
>>>     way it loads the module and it will only used by tools that need
>>>     to make sure the module is there when the kernel does a
>>>     request_module() or somehow tries to load that module.
>>> 
>>> So if you want a hard dependency, just use a symbol from the module. 
>>> If
>>> you want to emulate a hard dependency without calling a symbol, you 
>>> use
>>> a pre softdep, not a weakdep.  You use a weakdep if the kernel 
>>> itself,
>>> somehow may load module in runtime.
>>> 
>>> The problem described in 80f4e62730a9 ("drm/panfrost: Mark
>>> simple_ondemand governor as softdep")
>>> could indeed be solved with a weakdep, so I'm not sure why you'd want 
>>> to
>>> alias it as a "hard dep".
>> 
>> The simple_ondemand dependency sadly isn't visible as a symbol. It's
>> currently 'fixed' by using a softdep, but that has drawbacks and 
>> doesn't
>> actually express the requirement. A "weakdep" works, but has the
>> drawback that it implies that the dependency is optional. This patch 
>> at
>> least means that the driver can express the dependency, even if
>> currently that just gets output as the same weakdep.
>> 
>> I'm not sure what the logic was behind the name "weak" - what we
> 
> borrowed terminology from linker and weak symbols
> 
>> (currently at least) have in panfrost is not a weak dependency by the
>> normal definition of the term - the driver will fail to load if the
>> ondemand governor is unavailable.
> 
> there are 2 options:
> 
> 1) use a softdep and let the module loading logic always load the
> simple_ondemand module before panfrost
> 2) use a weakdep and if/when needed, do a request_module()
> 
> In both cases the tools creating the initramfs should add all
> dependencies to initramfs: weakdep, softdep and dep.

I do appreciate your detailed explanations, but please note that the
way softdeps and weakdeps work is already fully understood.

>> This patch doesn't solve the confusion, but at least means panfrost
>> doesn't need another round of churn in the future. The alternative
>> presumably is don't merge this and panfrost will have to wait until a
>> proper "hard dependency" mechanism is available.
> 
> hard dependency == symbol dependency. I think the mix of terms isn't
> helping. soft doesn't necessarily means "optional". AFAICT this hard 
> dep
> thing is trying to introduce a "mandatory softdep", with a name that is
> already used to denote symbol dependency. And it currently does 
> anything
> other than turning it into a weakdep.

Please, read what I wrote in my earlier response, [1] which includes a
rather elaborate explanation of the intent behind MODULE_HARDDEP being
currently just a proposed alias for MODULE_WEAKDEP.  It also describes
why the "pinned softdeps", as I called the harddeps, are seen as 
important
in the long run, besides expressing the actual dependency better.

[1] 
https://lore.kernel.org/linux-modules/0720a516416a92a8f683053d37ee9481@manjaro.org/
