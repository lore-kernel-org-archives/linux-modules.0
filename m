Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794237395;
	b=rKoIsiCz/bV3WVp3gy1WP4HI11vUiQ3C/y/x0CTtCe15bK/H8uFsLGr829aGpTvj8ZoE
	 m1oFIwudeMOzl6aMWx/+ZhxhT6LQ1K/WX75/fid/U3xDCtZk3wsEWXKiAIWw5UvZwcmAf
	 zVRrLdu3mC1gc9v1hrvoOOsDpB0AqsgO2HZppfa/MUhYd0+Ju6H+rEHH7GmSQaLog3vcK
	 gN0N63z/6MLrgfF2xin3hqJSmZgm3x8oTeeGzpxMVPea7xrFe52jWQ9XPaoN745oreG7u
	 WpQaP43ep2Zlj8gw3IwWgSt4G1dBnmbBaIAhm0SXYLjD3hL8s2oTUkMHSfVUWnve4jA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794237395;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=jkscwoMz/NtwK7adTu7thVWKraeXz1/KWC75TgatP5E=;
	b=ohvuKFuqn9TabD37NaVcln5vZwnGyO8YAjbmjMvREHtOXT2oecYr2Jl4ROsmqle2YI+4
	 yT1b1IW43DPGBdDU6cvy+DwNkaJwbeuslIXCkEVMRAbPRPMrd+JBe9SVxq2RUDsRZ7g0u
	 NWdpPhHbR45AULRgkV1g/6bOjjy6mfHavQxejsriZFIZiUllK1gPct6kw3smo5+ah279U
	 +uoRekSu17FGj9zkSTah1m5llssWcysyNuvZesyWCBZGiMfIlWSlxv4GqLj/AwGSe5fTk
	 4I7nZCD6EhTndjbV0XfTVEEXd0Ojyi1DSaFL+fF9x6AHPg98NEzTltoPEbTtldP3a4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Xs8Oszdy;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BF2606A321
	for <linux-modules@vger.kernel.org>; Mon,  9 Nov 2026 15:16:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72BF2606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Xs8Oszdy
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a20a37703bso7226455e9.1
        for <linux-modules@vger.kernel.org>; Mon, 09 Nov 2026 07:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1794237393; x=1794842193; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jkscwoMz/NtwK7adTu7thVWKraeXz1/KWC75TgatP5E=;
        b=Xs8OszdyHPnrMpzHZZO6hjZ6A2iLC0CKaCtZnwgj2MHJPWfpJLEAZq/hLIovII0Air
         kmQU4uSGZLoloyJyht8LaXc5LLx9E4P4zMskHlDWPz5z8UfByygqX2h6E8P6de2bs7GG
         zCUNfluH6GdU0bYfhCsy0zIiq/k8rL2bg/uzk4iuR/dmSlfuBGkQb4WTisfpuPXCtojt
         0htC1DRci+FVRlozeA/telQ8BkSTqzKzE+z3VBq8T3Q5P/+XEE18/TfjE1QsXRP+LERx
         rzWp+zvRamVhjiYE042jAKv/8+gU5ROH0QeKiDf+pCJ13Y0yVXWwEzlUt1V5UCgg84Iq
         +ljA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794237393; x=1794842193;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jkscwoMz/NtwK7adTu7thVWKraeXz1/KWC75TgatP5E=;
        b=oCbEU7KN1I7OWgqi7U8Ugdl+sBrNh9j5Qd9erTg1yVBsbvv5NMf99Rv7KAEHCpPFTI
         fBgxsIpAvgJst2S/LInqq8APH+5WCl1xNfkIOTwqawLZLzczGCoH7xFZPiJLK/rRSvOX
         t12vSpWuN2x6pKoFMtynfdymm8++aiQ/wvKRpi9eNIvDijz0wXkXy9QCkv1mVSRiFFZk
         cZOr9xAKptDY+UBzxZWjV9C/1tbMBml3qsD36GFFrLkq5q+yx3C1yL58iOf6Gy54cjsn
         QYJWMmBXQg+cRRmiha7s9isqaOKUdQ2r5n1pyVd9ma9hOsYdG2AKVijggI6g18tCPfg1
         CfYQ==
X-Forwarded-Encrypted: i=1; AL+hErFaqjbDV+vcw8x/ZU2UQ586p6ZbZQfaLGiVyKfRTeP0yX1JC9zmQbdaOXDY9PzY3yLGwNmVqxe8wexzm1l4@vger.kernel.org
X-Gm-Message-State: APuU4Z+0an0tv5ZwQ1SdQ32L8QTRGkaRTZqCD3gQP/y668DLZWLYeJMa
	u2eWkJH1Ym2xX9GerYs9gF3A/Hl8cr3w+QwundbcTMl77cIm/UzJZ5LRhy20VZdS5+c=
X-Gm-Gg: AYBFou3LfrsUAEIpvvu95F9mhX8oqcRnp2EhYdvV5IaQineR47Ci9uGRYGozUbB/ArY
	yknb+rU8hP9ob8ugOeKdpuGmV1PyO3PBIdyG//k6gNoFLMRZkfRbJpsktysmHb/Lxoe/GSINg9m
	P/yw/P2yN5jlwjOcFibstGojTa5iZyb5Tz+IwS8Gn0PtgxY5R5rP6IRMczWOihug4iLlwt7IDyr
	BQXjRFo5BGnztal5l6QgWicWUq1FfdEQptsjMYUc/wgN77utd8tIbSo3b0vlbT+GqBUS0SiiIFz
	TRC1Jx1WT3VWfgDPXD7+idui5tGhtUSMf6Hq8Me+gk4MuBab8WW0BTgMU0Cf5diW6Vhebr4RHYJ
	0CjPtywjceOChVCFTzBj3u1l4m66SqDEFUP+AfO5odP0VAYZlKUhuXl1wyXbLGHGJhgVzyVotPw
	7avrm5VVJMA3XOMLooT/mQvTBPl+OaIMntBCxc1hgxEp7eVn3JGrpFufYJDK5+V2LCw7CZDmrkh
	8xpcSeMhhzpY5mHeoicVF8SP4u0c5o3wX/nsn3U3DeNO9IbIr3stOqjXmIftHWHWcrOXllcu/Bl
	Y0CpDgJRwFVeRSRDDSNkLT2VRbLSSh0cCq+vCFz01MkTzqaFO8wDmaFZ2G1maS/c
X-Received: by 2002:a05:600c:818e:b0:4a2:167a:c939 with SMTP id 5b1f17b1804b1-4b963c85687mr70833595e9.21.1794237392747;
        Mon, 09 Nov 2026 07:16:32 -0800 (PST)
Received: from ?IPV6:2a07:de40:8100:0:89a9:fd0e:583d:4a53? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b79502652csm165199245e9.4.2026.11.09.07.16.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 07:16:31 -0800 (PST)
Message-ID: <97331297-3f78-4f6d-ab24-61cf329647af@suse.com>
Date: Mon, 9 Nov 2026 16:16:30 +0100
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] module: Fix use-after-free in module_put() tracepoint
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: mcgrof@kernel.org, da.gomez@kernel.org, samitolvanen@google.com,
 da.anzani@gmail.com, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261022184517.66438-1-atomlin@atomlin.com>
 <2fd1031c-7a86-45cc-a595-bbd13e102d43@suse.com>
 <zjuuet74suq7dujrlt4pfeoajtksegfrslsmokgvfjg6o6pghk@dbifrqvwrnaw>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <zjuuet74suq7dujrlt4pfeoajtksegfrslsmokgvfjg6o6pghk@dbifrqvwrnaw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/9/26 3:28 PM, Aaron Tomlin wrote:
> On Mon, Nov 09, 2026 at 02:47:31PM +0100, Petr Pavlu wrote:
>> On 10/22/26 8:45 PM, Aaron Tomlin wrote:
>>> A use-after-free condition can arise in module_put() should a thread be
>>> preempted immediately after decrementing the module's reference count
>>> while the module is concurrently being unloaded.
>>>
>>> In module_put(), the module's reference count is decremented via
>>> atomic_dec_if_positive() before the module pointer is passed to
>>> trace_module_put(). Consider a scenario where CPU 0 decrements the
>>> reference count without reaching the baseline MODULE_REF_BASE level and
>>> is immediately preempted: it relinquishes its reference while still
>>> retaining a local pointer to the module. If a concurrent CPU 1
>>> subsequently drops the final active reference, the module's reference
>>> count reaches MODULE_REF_BASE. This permits the module unload sequence
>>> (via delete_module() or the initialisation-failure tear-down path) to
>>> proceed and invoke free_module().
>>>
>>> Function free_module() invokes synchronize_rcu() and subsequently
>>> releases the memory backing struct module via free_mod_mem(). Because
>>> CPU 0 was preempted outside an RCU read-side critical section,
>>> synchronize_rcu() does not await CPU 0. When CPU 0 eventually resumes
>>> execution, it passes the dangling module pointer to trace_module_put(),
>>> which dereferences mod->name and mod->refcnt, culminating in a
>>> use-after-free. This sequence of events is illustrated below:
>>>
>>>     CPU 0                                       CPU 1
>>>     -----                                       -----
>>>
>>>     module_put(module)
>>>       atomic_dec_if_positive()
>>>       [preempted]
>>>                                         module_put(module)
>>>                                           atomic_dec_if_positive()
>>>                                           // drops final reference
>>>                                         free_module(module)
>>>                                           synchronize_rcu()
>>>                                           free_mod_mem(module)
>>>       trace_module_put(module, ...)
>>>         mod->name
>>>
>>> Resolve this by moving trace_module_put() prior to
>>> atomic_dec_if_positive(). Because the caller holds an active reference
>>> to the module at this point, the module structure and its name are
>>> guaranteed to remain valid throughout the tracepoint invocation without
>>> requiring preemption disabling or RCU synchronisation.
>>>
>>> Fixes: cb0b50b813f6 ("module: Remove preempt_disable() from module reference counting.")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
>>
>> This version #2 looks ok to me. I plan to pick it up on the modules
>> tree.
>>
>> Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
> 
> Hi Petr,
> 
>> The additional version #3 [1] seems unnecessarily complicated to me. It
>> is ok to report the value of module->refcnt before it is decremented. As
>> noted earlier, other code, such as xfs_group_put() and objagg_obj_put(),
>> takes the same approach.
>>
>> [1] https://lore.kernel.org/linux-modules/20261103163103.13195-1-atomlin@atomlin.com/
> 
> Thank you.
> 
> However, I do prefer the next iteration [1], since the use-after-free is
> resolved without altering existing tracepoint semantics or introducing an
> off-by-one discrepancy in the recorded reference count. Finally, the fast
> code path is fully preserved when the tracepoint is disabled.
Why is it important to preserve what this tracepoint reports? The value
isn't off by one, rather the tracepoint would now report the value
before the decrement.

I'm trying to understand why this case matters enough to justify the
additional complexity in version #3.

-- 
Cheers,
Petr
