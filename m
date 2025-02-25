Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF3F21505E
	for <linux-modules@vger.kernel.org>; Tue, 25 Feb 2025 08:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740472395; cv=none; b=qM/o/EQrk28hVYIzzglx57eZTwmIYnlQMEwWrBDHQi8j+0RzEfee/+sLMmHzyQByUBul0brfwRmM2lcZj4Us96b+kDMRc01o++uROBgb+N3timBN8uqqiFLvJOGB3eKnlMTVl4sxt+aHc1m9FnQiPjIKYKRmPNPXVqR2HxuOOts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740472395; c=relaxed/simple;
	bh=hUvGcbX1M8/8NOUDvmKTRtGA8/5aU1g/Qz0Zf/5sQ4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JjwMKIpa/Dq5rf/vkEnmniiDwd33nH3U7l3QXqF3ZFukMWxKVqqbD+cR7IBgd5fz7vq7vtiffR0iI+vEUwVoYClMAGBe9M2v2Kf/oUcN0ULS0iOgOxN3w/xCXp7r+Pim2WAFdsw+u063TqkrelDlRVYSfMgT2tY9AsfrFDwd0g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PhL/teWz; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PhL/teWz"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5dec817f453so8891778a12.2
        for <linux-modules@vger.kernel.org>; Tue, 25 Feb 2025 00:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740472392; x=1741077192; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2uQEE0vqGhPs5ZeLO92iI9oa2Rk21hDTj79zQ7HG9aw=;
        b=PhL/teWzLJTa8BXHL5sSJzN62RWzkQzvKHEd6TvQP9C1QwkApqmRurO28WXJfnHnAB
         kvetew5oShJ/P49Q4pv6g5pq9UwaxIZvCiNs81wrDNeKVDjcT8vhWLS7QpCOsHJixIG0
         BLNyq9G2FE299LFpJjqbLvDziVUQQsqvTzC3K34zlVvCbpqt7Oj+pvmgWa0MNh+sf0Q9
         hlOUDK+61LYHVMk1lyIRUr16e4vCkC+8ATRAHNbRXn+HqewprwN3GmbRGaiAZ6aLhHmy
         YQ24oag3N3V5Vp0VvLJjltvsLdQFa2lc0VsnIYjXpga7ZEZsclQBpZsz2fgW+fvJW21A
         3AEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740472392; x=1741077192;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2uQEE0vqGhPs5ZeLO92iI9oa2Rk21hDTj79zQ7HG9aw=;
        b=sDG4NwpHySyMlGQzTv4s3Nmq/GGjDz3ePwLaTGCOkDztKfDs1nK23mDaiU5U9S33Td
         l15tQ17CWspc0uxmKhUnVi32+xBIIYaD1n+fvBPq63vbdIv+9k7wHll5fBE8SdVd3/94
         i3iDvKJnu4XazZghUlPDX6JeN8YaNLkMCY8UcN8wDaFtPI9MfRiEnOPV3awhGseUCn/9
         4DHvoImtZkFR/Vuh/md2pShNqrMPRUsuS3Z3HII4pOfLZiKWSRaAzJhnhj9duIYFnxee
         pdDFKvo7CRAmv9LYZX08Uqqr+e28xbd3lNptXnwSfLu/3nX7VYCnc7EJ7Slwwb5w1pqF
         47bQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhuJnt0J007mGu50GdFJj1qPqJiEg6bJFohBd+dhHEbTLjgKVcNdJzveloZEmeuWdUnaumyzc28K9sKwH/@vger.kernel.org
X-Gm-Message-State: AOJu0YzPiVCTiLueakRXAKVitTkvh3/V+kBOP1MWWl3HG6iL+AsUwHAe
	r6/byU4NkOUQBJdW1EjVdXLksSad6DGrNKn78DAcBALH1Xe1jMDmVvRTY9b17Mpf6WPtm9pBB3f
	V
X-Gm-Gg: ASbGncuV9L8+sHUqLzRnS8Fu5Tmtv2CBG+bu834lWm3FWWgTtbCuawpIXEp/QFnMK2p
	+YqIvuNUpF4t4n3EC9OKUdnoo1oZ6XPEph12cKamoGgGu16ZUuYbBUJxsN+ilNWM6aU2CE6D9+g
	vbK8b60RnA/9jbSmVhGda7Sl0gP/LoOMHnLph26kYT6/mn6B05o1LKuBCcatLSdrn5wcBXsSRdz
	Xns4YcfvXRXP/c0EgwztkOv6Rj7RnpYhzKge3DXVA9Srq8wfeGXBErfy4WsjPqFvidx9Ohm5Kbv
	WSuwXLWz58+wD3X8n80m/MP4UaKR4w==
X-Google-Smtp-Source: AGHT+IGqRG1lJV/HKH+NlkKHzrYTEOwjEu01RN89meeh0XD7zNegvzrfS3k6QKTJYI1ZKFpVt/u56Q==
X-Received: by 2002:a05:6402:3488:b0:5e0:51a9:d425 with SMTP id 4fb4d7f45d1cf-5e0b724ecfcmr15530079a12.29.1740472391943;
        Tue, 25 Feb 2025 00:33:11 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e460ff8694sm846813a12.50.2025.02.25.00.33.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 00:33:11 -0800 (PST)
Message-ID: <e8ba9f36-e33d-4c53-9d34-ff611cb1c221@suse.com>
Date: Tue, 25 Feb 2025 09:33:10 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] kernel: refactor lookup_or_create_module_kobject()
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Shyam Saini <shyamsaini@linux.microsoft.com>,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 code@tyhicks.com, christophe.leroy@csgroup.eu, hch@infradead.org,
 mcgrof@kernel.org, frkaya@linux.microsoft.com, vijayb@linux.microsoft.com,
 linux@weissschuh.net, samitolvanen@google.com, da.gomez@samsung.com,
 gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org
References: <20250211214842.1806521-1-shyamsaini@linux.microsoft.com>
 <20250211214842.1806521-3-shyamsaini@linux.microsoft.com>
 <4039ec74-8b46-417e-ad71-eff22239b90f@suse.com> <87wmdjo9yp.fsf@prevas.dk>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <87wmdjo9yp.fsf@prevas.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/21/25 11:42, Rasmus Villemoes wrote:
> On Thu, Feb 13 2025, Petr Pavlu <petr.pavlu@suse.com> wrote:
> 
>> On 2/11/25 22:48, Shyam Saini wrote:
>>> In the unlikely event of the allocation failing, it is better to let
>>> the machine boot with a not fully populated sysfs than to kill it with
>>> this BUG_ON(). All callers are already prepared for
>>> lookup_or_create_module_kobject() returning NULL.
>>>
>>> This is also preparation for calling this function from non __init
>>> code, where using BUG_ON for allocation failure handling is not
>>> acceptable.
>>
>> I think some error reporting should be cleaned up here.
>>
>> The current situation is that locate_module_kobject() can fail in
>> several cases and all these situations are loudly reported by the
>> function, either by BUG_ON() or pr_crit(). Consistently with that, both
>> its current callers version_sysfs_builtin() and kernel_add_sysfs_param()
>> don't do any reporting if locate_module_kobject() fails; they simply
>> return.
>>
>> The series seems to introduce two somewhat suboptimal cases.
>>
>> With this patch, when either version_sysfs_builtin() or
>> kernel_add_sysfs_param() calls lookup_or_create_module_kobject() and it
>> fails because of a potential kzalloc() error, the problem is silently
>> ignored.
>>
> 
> No, because (IIUC) when a basic allocation via kzalloc fails, the kernel
> complains loudly already; there's no reason for every caller of
> kmalloc() and friends to add their own pr_err("kmalloc failed"), that
> just bloats the kernel .text.

I wasn't suggesting to log a kmalloc() error specifically. The idea was
that if lookup_or_create_module_kobject() fails for whatever reason,
kernel_add_sysfs_param() and version_sysfs_builtin() should log the
failure to create/get the kobject.

> 
>> Similarly, in the patch #4, when module_add_driver() calls
>> lookup_or_create_module_kobject() and the function fails, the problem
>> may or may not be reported, depending on the error.
>>
>> I'd suggest something as follows:
>> * Drop the pr_crit() reporting in lookup_or_create_module_kobject().
> 
> No, because that reports on something other than an allocation failing
> (of course, it could be that the reason kobject_init_and_add or
> sysfs_create_file failed was an allocation failure, but it could
> also be something else), so reporting there is the right thing to do.

The error message says:
pr_crit("Adding module '%s' to sysfs failed (%d), the system may be unstable.\n", name, err);

I think it was appropriate for locate_module_kobject() to do this error
reporting when the function was only called by code in kernel/params.c
and in the boot context. Now that the patch makes the function available
to external callers, I'm not sure if it should remain reporting this
error.

The function itself shouldn't directly make the system unstable when it
fails. Each caller can appropriately determine how to handle the error.
Functions kernel_add_sysfs_param() and version_sysfs_builtin() don't
have much of an option and can only log it, but module_add_driver()
could roll back its operation.

That's it, I guess my question is really whether module_add_driver()
should do that and handle errors from lookup_or_create_module_kobject()
by propagating them up the call stack. That would be my default if
writing this code from scratch. I don't quite see why calling
lookup_or_create_module_kobject() is special in this regard.

The rest of my suggestion flows from that. Function
lookup_or_create_module_kobject() should then similarly propagate any
error upwards. However, functions kernel_add_sysfs_param() and
version_sysfs_builtin() can't really do that and so actually need to
report the error themselves.

What do you think?

> 
>> * Have version_sysfs_builtin() and kernel_add_sysfs_param() log an error
>>   when lookup_or_create_module_kobject() fails. Using BUG_ON() might be
>>   appropriate, as that is already what is used in
>>   kernel_add_sysfs_param()?
> 
> No, BUG_ON is almost never appropriate, and certainly not for something
> which the machine can easily survice, albeit perhaps with some
> functionality not available. That this had a BUG_ON is simply a
> historical artefact, nothing more, and borderline acceptable as lazy
> error handling in __init code, as small allocations during system init
> simply don't fail (and if they did, the system would be unusable
> anyway).

I agree, just to clarify.. the reason why I mentioned using BUG_ON() in
this case was only for consistency with what's already in
kernel_add_sysfs_param(). I think it would be good to clean up other
BUG_ON() calls in that function later, but it didn't seem immediately
necessary to me as part of this series.

-- 
Thanks,
Petr
