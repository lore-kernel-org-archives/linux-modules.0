Received: from mail-wr2-f36.google.com (mail-wr2-f36.google.com [74.125.225.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A3735DA55
	for <linux-modules@vger.kernel.org>; Fri,  2 Oct 2026 11:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790942332; cv=none; b=e3dq4BJcU1arPdk2z4sCQWLPc2yLFDPkBAugiHVGSQp0fs92sRxLGYSS2PdqfDk0Gm1McoBVCOoN/zii9pYDKYLmJyGT4YgfMGkPlU0Ey0iIg35GAULVjyxYFAyt2vobOK3y6/HyM42I8m09B9XQcIjXa+PtNi6+03gQOfhCysU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790942332; c=relaxed/simple;
	bh=LlZxGGTvdojYdT8k3tDVdc8QzvkSYhyl3Z1KAuLonF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cGTrPxzkVeu/YPrMfoBTwtVnlDZdtKOiB3fP4DKUO4gguOqpz2oEBWsca3Hwq0PYAWuln4xuYAhsSIipAS1p2gBNbkqwFAaUvsBuKGVZhcsw+TarqXk6uTdnN2JrfqomZuLgiQuOvTMXfTAko0uOFWv4+Zd8tRUEsaB4cXcBiXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JqMo3hrz; arc=none smtp.client-ip=74.125.225.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JqMo3hrz"
Received: by mail-wr2-f36.google.com with SMTP id ffacd0b85a97d-48b0fc598f8so977790f8f.2
        for <linux-modules@vger.kernel.org>; Fri, 02 Oct 2026 04:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790942329; x=1791547129; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HuDPir+q4FERrKXQ8zp3kgZyGxkcWGZ+Inj9ACfB8ZM=;
        b=JqMo3hrz7sWDZ2agS3eNLncKtt9asHtxtV0TwN43KVm46LnnrlccnZTxafbPUdLXnI
         Qlcu20MPHyiDPlfoz6Ot+vgmfXA+WaDKX75fWE49/PpjvnKAOuk9bt1Tiy2K9itS/6hL
         9uWuuQNw8dPgBXkX+LvrOJKXfTahvNkRLJ0qo3Rdisc+eJ17Oizwbqcfh+L4bkiUNo9k
         0PAcG/T8sqT4Ft2iuy1kuqly8l55a1pscv8mqpoaQXB55H5F/j6KBX0byDurKu+lANtY
         fEPFaUM8YKE50mpHCVVK2sEh1j6y2BxXg1VShzVXMoQGU15WOX84Bl83u/fKoCWvi2HL
         UEVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790942329; x=1791547129;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HuDPir+q4FERrKXQ8zp3kgZyGxkcWGZ+Inj9ACfB8ZM=;
        b=V6lcburTWjOIwzMODMvtXDZBHMETQDNCIjUgcl8R+8s0oIh9TDvRjPR7ttuQF3XxGD
         WAi/ekpK+qSz6WXg4V9AAdSUpSdD22zXOSVHVfoG/UbNQXVZrbNH3tT3BKsLmBqv82kj
         sGeB5N5M4H/rhFiWf+oZ+wcgjAqLYpKhCI+I1uUQVjUF7ujsK0qI5+P86/6i2HiwEIiw
         NNO4KFpn3IDjA9F1VKhjdv1OUdI8ntplBBwwsWIKdWtiY2kOpIVEn+TtwR9n1CJ8moGK
         wHvyvSHIxaN7fVvqhRjqUCm0eW0HjkZZsQ216IlOcweVDZX/5aQHVfd5ojz2Vfv/aLLI
         Az7Q==
X-Forwarded-Encrypted: i=1; AKwUvBzxo3tVHxN7E+5VAhzhDPbeAoXV1UBLtAZMtD2BssHxQE+wuxwc1MdoM8V2bbOTwuiGHg2gib59CfImisAh@vger.kernel.org
X-Gm-Message-State: AFq9FYInRFzfP6ZK5iOMvENyhcHrAFmpgEJRogpvB0k2gPe+ZsW8AA7a
	c/jZEURtpK2jUHwnFwqObypdb1DSoWIpO70YkvPv57zNJPpIhcWzBdwSNMx/mI2MzUs=
X-Gm-Gg: AYBFou2cH/L4uQ92LZTuDJACTdNVSoL93+zeRc8Mn7AAYmxtN991lahSrDLF59ISeIG
	HOyiS5JdTIMsKWm1pvf4yWYpKp5Nhy72hMjp/xZPo1wQovsHFoCtWoGdjS6Dq2AcsBnY4jYnIh4
	Pw/iuq0yrMXP+u9HdJm2/fg4uz4FWL4XNYYAxQptOjCTHqN8KH/5mi1jQwpfq+gmwXD69gSlovL
	Mv8joTxCjCOfZUb8b1q0AmmVnjKQhZjvBoVfIgm2+uWZcsjFJ6Nu5ZUPtQ2DHyq0Sh6CPHNZyvK
	JgRTpzT87StcbT2u2mvFNQUlOM73svtKXjpHn4MIyMWlw5UXpgshdJ3kBDgI+AAxQnX604vFKmU
	NyXxIlh45To713FPv3K43D/8YHZCA56IHi1Mf9yuFXya2tuHqWiL1rYiTtLTSWCLou8/Ov3QUZo
	qbxozAFfPyj1Sfe4D74Enm7TQoBcebBsOl6L4DPlHWKNh/OqxoZnXa2gmLYkAHGHSfkHqNNYYz/
	JMt7aTyuYvNErjsCZ3UAx32NohtgI9LXmU=
X-Received: by 2002:a05:6000:27cd:b0:486:f620:63bd with SMTP id ffacd0b85a97d-48b125a19fcmr3400232f8f.0.1790942328677;
        Fri, 02 Oct 2026 04:58:48 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:89a9:fd0e:583d:4a53? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b380faaeesm5023947f8f.18.2026.10.02.04.58.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 04:58:48 -0700 (PDT)
Message-ID: <c166a29c-14f4-44ee-81ac-d79c82175fc8@suse.com>
Date: Fri, 2 Oct 2026 13:58:48 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] module: Add stubs.c for CONFIG_MODULES=n
 module_put_and_kthread_exit()
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, linux-modules@vger.kernel.org
References: <20261002-module-stubs-v2-1-a0d8c6ad1738@suse.com>
 <20261002091451.D4FBC1F00893@smtp.kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20261002091451.D4FBC1F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/2/26 11:14 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] bpf: resolve_btfids build failure with CONFIG_MODULES=n and LTO/GC
> --
> 
> commit caaeb9d0651743944c690c066494bb16509c01e9
> Author: Petr Pavlu <petr.pavlu@suse.com>
> 
> module: Add stubs.c for CONFIG_MODULES=n module_put_and_kthread_exit()
> 
> This commit introduces kernel/module/stubs.c to hold stub functions when
> CONFIG_MODULES is disabled. It moves the stub implementation for
> __module_put_and_kthread_exit() to this new file and removes the
> corresponding #ifdef from the BPF verifier's noreturn list.
> 
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 72a3f5998dd27..be70f10e49682 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -20417,9 +20417,7 @@ BTF_ID(func, __ia32_sys_exit_group)
>>  BTF_ID(func, __kunit_abort)
>>  BTF_ID(func, kunit_try_catch_throw)
>>  #endif
>> -#ifdef CONFIG_MODULES
>>  BTF_ID(func, __module_put_and_kthread_exit)
> 
> [Severity: Low]
> If CONFIG_MODULES=n and dead-code elimination (like CONFIG_LTO_CLANG or
> CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) is enabled, will this cause 
> resolve_btfids to fail?
> 
> Because the #ifdef is removed, this unconditionally requires the function to
> be present in the BTF. If there are no callers in the kernel, the linker 
> might discard the stub function, causing a missing BTF ID and a fatal build 
> error under CONFIG_WERROR.

This is a valid issue. I think a simple solution would be to mark
__module_put_and_kthread_exit() as __retain.

-- Petr
