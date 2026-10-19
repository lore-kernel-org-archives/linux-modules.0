Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBEA31B83B
	for <linux-modules@vger.kernel.org>; Mon, 19 Oct 2026 08:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399728; cv=none; b=cAgI8DPfOh5hcmnmvZ2hOBl4MkSQLXfIddAkGNj8q1lZKAWyMdRME9XvtEnNPX7snoFFhFCCjhG/tkBhNsO5myoPg7pKf5uciscY4gwdhOfD5DXb3gKOZNuymN5ciCEWlT0/UElQAyPd06vcOYQ8wE+sIPaF98h4QuqaYnJvwzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399728; c=relaxed/simple;
	bh=sb5OAQk035axqsNZnHTPq/79awUPyZHiyt1IlMeqiqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L0TGrqMld584brI59aySyYpwtdig0STKRKSrxRunGvIHWBq2zQ1ZPKMJ8YKpeljj1hXzIDY+t+YAZ5EbChD2mz8YJcZ84BiIEKfHCfVY6PTQ1PLkMrpPj3W7QUf5+7cFzIZUkmhGANGMpJzO64XwnHCZibBuRfmYqRBQu6y8Wjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IYsXIGaH; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IYsXIGaH"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48b042c0759so1081297f8f.2
        for <linux-modules@vger.kernel.org>; Mon, 19 Oct 2026 01:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1792399725; x=1793004525; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zhb9KBNNDc70nbYUzj5CK3HSxDzK6SdhdJzDzxQ8m7c=;
        b=IYsXIGaH2F5+rg4bt3QE/fMAGI9Ny8oevFctZStJ4WwzfUOtwpoSuIPspBmTWCZvdH
         aDzbfIa/BMfRjm1OhdtPKUfwAkuXv48lFuTnRNemSoGIZh1nLycuUUNxuv6kgqXuc80Y
         FaaMJOyBif6xfUod/zUx+AJdSx2l6iPJDzaBJR7y2AFgvSOc6g4oykbuLXWNcksyBGeR
         yUXPaM1nWdR73gK6gJJleEajfYZMFb4e4PrdI7/b+jQKne5QMUcHMiWSqiBnXHc/hOf5
         jaEV0n28J3ohTM0Z6ywx4PFB7bqLKcAMHNy4XDoKZiFHCwULVqP3RKtwm27ZmXd06Xqq
         qnVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792399725; x=1793004525;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zhb9KBNNDc70nbYUzj5CK3HSxDzK6SdhdJzDzxQ8m7c=;
        b=NFBjhKlKkFrRurwPH0R+a3NimcWc0MjGktmoIW7cHKLxvAkbEzGMPHlt4IZ2QEaNl1
         MHBFs9U2uJBdU1ViAKZyKJ/ey4vkjyoXOG3nfwBNchKGLYERPBwWlDIFZOsUD0WEcK5f
         ZXkRMO0KrKDat2TCwKtXVYHmt5zJVJQg3Eg+Dey9hYs4sWhWry+W86fT/fYbMD7KWZ9z
         y3QClcmVh9qr/bnskmIUj5hDqTZAH8TXn3K8ZvIKLG/G4hWUI4G++JYT5e/2kHG6wMBr
         EMifYcKbp9dOuA61H3D+nqf8m8UPDM6nAD8pHCrUVNWMh0SXVpJAZ2uEAGgGT03HrFyM
         igvA==
X-Forwarded-Encrypted: i=1; AKwUvBy5Xx6hXPozW+fTOKUo6SCBB4gW70h+KRPy4TS0jZ/y3JUlClrSAasogI4uNk2gBiNf0sb2mg1UdZANEH7p@vger.kernel.org
X-Gm-Message-State: AFq9FYJ9Vy9Xr8RwNY2H2LzsF9kMGDY3l4mjW6jLMV+MzwlfsurYcQXC
	qn5I4JjzrIjlNmQjwjMSyXK+Eb2RqVybmueodLL4oa1iuIW++3YwpKlJDyLGjIPszVSALTftEm2
	fxlh43Xg=
X-Gm-Gg: AYBFou3uAzEofK6ZsINeJmLFFtdC8QSmPFqg/ZMGT9eaWXv3SX3rEvRj3GML7l9oFrz
	bCZHhu5IfkHzHc5ePCFRLDzZoyivl6X+a8Mqi3+VEnKa33HLInZOPcSnUCpy8Sa7vHb0n7Kvqhg
	eEfWaGWbYovMt3gYs6UWf8FTgHNPZIGTW7dTFDjHbHvHmhzwNOO101/R5GzhfEs4xkhireCj1kS
	lgMCmlTnEa6LpuOtYmaRt2D0sVTJ02uqcb1B/LKJsgLje+8ipU58vcGE/9LqRoAXDyqnHSDS5Yy
	MSuqXgB3w3oX7BuN+8NHZQcDRmm1iWlvNzAiCNY1dHVMppM6L4EP7XqaRC0wJuz1R8JYwYlyFLQ
	Ik/uzIkVxcS4kw+RRdzSvPFzMkIL477lEUTgU2S/rpDot0ILbWjJRsm/Mm1f7pCDwb5163+Jwjj
	TRLfGYtRQyHRZ9lduZLhk3pNjQm++yFMcxhTrkmhsahcRXltKxtoNca6HnwsfC9ygGt/DYNTOD0
	4GWEBTNPPGhAQju46y30bp2kYg6i8Nsfc0=
X-Received: by 2002:a05:6000:240d:b0:48e:e28:ada8 with SMTP id ffacd0b85a97d-48e0e28ae03mr9960593f8f.52.1792399725638;
        Mon, 19 Oct 2026 01:48:45 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:89a9:fd0e:583d:4a53? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd510201sm22585242f8f.55.2026.10.19.01.48.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 01:48:45 -0700 (PDT)
Message-ID: <a5e66dc8-155d-4eb1-add5-8c182879cefb@suse.com>
Date: Mon, 19 Oct 2026 10:48:44 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module: Fix use-after-free in module_put() tracepoint
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: mcgrof@kernel.org, da.gomez@kernel.org, samitolvanen@google.com,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261019034857.654569-1-atomlin@atomlin.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20261019034857.654569-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/19/26 5:48 AM, Aaron Tomlin wrote:
> A use-after-free condition can arise in module_put() should a thread be
> preempted immediately after decrementing the module's reference count
> while the module is concurrently being unloaded.
> 
> In module_put(), the module's reference count is decremented via
> atomic_dec_if_positive() before the module pointer is passed to
> trace_module_put(). Consider a scenario where CPU 0 decrements the
> reference count without reaching the baseline MODULE_REF_BASE level and
> is immediately preempted: it relinquishes its reference while still
> retaining a local pointer to the module. If a concurrent CPU 1
> subsequently drops the final active reference, the module's reference
> count reaches MODULE_REF_BASE. This permits the module unload sequence
> (via delete_module() or the initialisation-failure tear-down path) to
> proceed and invoke free_module().
> 
> Function free_module() invokes synchronize_rcu() and subsequently
> releases the memory backing struct module via free_mod_mem(). Because
> CPU 0 was preempted outside an RCU read-side critical section,
> synchronize_rcu() does not await CPU 0. When CPU 0 eventually resumes
> execution, it passes the dangling module pointer to trace_module_put(),
> which dereferences mod->name and mod->refcnt, culminating in a
> use-after-free. This sequence of events is illustrated below:
> 
>     CPU 0                                       CPU 1
>     -----                                       -----
> 
>     module_put(module)
>       atomic_dec_if_positive()
>       [preempted]
>                                         module_put(module)
>                                           atomic_dec_if_positive()
>                                           // drops final reference
>                                         free_module(module)
>                                           synchronize_rcu()
>                                           free_mod_mem(module)
>       trace_module_put(module, ...)
>         mod->name
> 
> Resolve this by acquiring an RCU read-side critical section via
> guard(rcu)() in module_put(). This ensures that synchronize_rcu() in
> free_module() blocks until trace_module_put() has run to completion, even
> across preemption under PREEMPT_RCU configurations, while avoiding the need
> to disable preemption and preserving the post-decrement reference count
> tracing semantics.
> 
> Fixes: cb0b50b813f6 ("module: Remove preempt_disable() from module reference counting.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> ---
>  kernel/module/main.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index d0e1e0bd2ad0..8e2d0ab96e6e 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -953,6 +953,7 @@ void module_put(struct module *module)
>  	int ret;
>  
>  	if (module) {
> +		guard(rcu)();
>  		ret = atomic_dec_if_positive(&module->refcnt);
>  		WARN_ON(ret < 0);	/* Failed to put refcount */
>  		trace_module_put(module, _RET_IP_);

I think a simpler fix is to move the trace_module_put() call before
atomic_dec_if_positive(). It would change the refcnt recorded in the
trace from the post-decrement count to the pre-decrement value, but that
isn't particularly important. For instance, xfs_group_put() and
objagg_obj_put() take the same approach.

-- 
Thanks,
Petr
