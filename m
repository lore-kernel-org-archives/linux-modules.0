Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9880C31AA87
	for <linux-modules@vger.kernel.org>; Thu, 30 Jul 2026 01:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785374855; cv=none; b=Efa4f0ipY7gHqNhnF7FM9pFF4ynKhwU16gbS0w2ozxJKwnqB10syv9GAzD3qoS7nT9gTd7MC8rct+gNr0M4JieMOtWXH3Hwsu19cI2JXRCGPv1cxLNPR/k+We+PkkHwfzXqa0qYhKSXbmrqUMiPsR4D5aTDBTXU7nFzIVVriYBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785374855; c=relaxed/simple;
	bh=tIwcbniDW6VXqHvpN78sWxrvYYnAIMu+XG9BFSaRj3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uPW9jwa05jre8+ltHRvdisCQ4IG7x321ne8CuRlEKcDHZ8RzoIlCggKjKW3L0APvphsfHy9odOSKpAoW8UJc7Kp8PVsPFHSoXxvAENRiuROdEMgPtB9cUtR0/9WrawlnPa+y7tjbXRUkuCC+6Ul8jLnJo3uTdoD9BGIW1A9zD1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=4MXaFguS; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="4MXaFguS"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=omWFYfLHi7FK1zZhRRQJ3JLk8jsZITDHCEyH4nDr6/Q=;
	b=4MXaFguS6e+7hJfr3xf3vcqqomBK3QSXIDxiMVwMCowTlLVtCUcytvYwlPo5GVMF1gnmbIsm7
	MWqPUZzXut4s39Kq8g34H6jHx2NfRRHI76CNMRNCvQKKkT+zs9ocU+lu+MXSOr2yhqZ6T2QHKRh
	+GtRUdw/Ss6lgv8dqauPISw=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4h9WXm2s3cz12LG8;
	Thu, 30 Jul 2026 09:18:00 +0800 (CST)
Received: from whupemo500009.china.huawei.com (unknown [7.152.184.116])
	by mail.maildlp.com (Postfix) with ESMTPS id D64DB4056D;
	Thu, 30 Jul 2026 09:27:29 +0800 (CST)
Received: from [100.103.109.247] (100.103.109.247) by
 whupemo500009.china.huawei.com (7.152.184.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 30 Jul 2026 09:27:29 +0800
Message-ID: <7999fae9-d15f-422b-a539-5af43a4f33c0@huawei.com>
Date: Thu, 30 Jul 2026 09:27:28 +0800
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] params: fix charp corruption on allocation failure
To: <sashiko-reviews@lists.linux.dev>
CC: <linux-modules@vger.kernel.org>
References: <ff0b7cdd-8fa7-4cb8-9e21-6a7204809766@suse.com>
 <20260729123243.790023-1-yujiacheng3@huawei.com>
 <20260729113900.693C71F00A3A@smtp.kernel.org>
Content-Language: en-GB
From: Jiacheng Yu <yujiacheng3@huawei.com>
In-Reply-To: <20260729113900.693C71F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 whupemo500009.china.huawei.com (7.152.184.116)



On 29/07/2026 19:38, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Use-After-Free race condition due to dangling global pointer during module parameter update.
> --
> 
> --- Patch [1]: [PATCH v2] params: fix charp corruption on allocation failure ---
> commit c59e6d7e9f9563e1394c57f9eedf07a9bb5f212b
> Author: Jiacheng Yu <yujiacheng3@huawei.com>
> 
> params: fix charp corruption on allocation failure
> 
> This patch fixes a corruption issue when param_set_charp() fails to allocate
> memory for the replacement string. It allocates and copies the replacement
> first, replacing the parameter value only after allocation succeeds.
> 
>> diff --git a/kernel/params.c b/kernel/params.c
>> index d3a4ecab4f278..8b25133fed242 100644
>> --- a/kernel/params.c
>> +++ b/kernel/params.c
> [ ... ]
>> @@ -269,19 +270,20 @@ int param_set_charp(const char *val, const struct kernel_param *kp)
>>  		return -ENOSPC;
>>  	}
>>  
>> -	maybe_kfree_parameter(*(char **)kp->arg);
>> -
>>  	/*
>>  	 * This is a hack. We can't kmalloc() in early boot, and we
>>  	 * don't need to; this mangled commandline is preserved.
>>  	 */
>>  	if (slab_is_available()) {
>> -		*(char **)kp->arg = kmalloc_parameter(len + 1);
>> -		if (!*(char **)kp->arg)
>> +		tmp = kmalloc_parameter(len + 1);
>> +		if (!tmp)
>>  			return -ENOMEM;
>> -		strcpy(*(char **)kp->arg, val);
>> +		memcpy(tmp, val, len + 1);
>>  	} else
>> -		*(const char **)kp->arg = val;
>> +		tmp = (char *)val;
>> +
>> +	maybe_kfree_parameter(*(char **)kp->arg);
>> +	*(char **)kp->arg = tmp;
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does this sequence leave a
> deterministic use-after-free window for concurrent readers?
> 
> Because maybe_kfree_parameter() frees the old string while the global
> parameter variable still points to it, any concurrent lockless reader of
> the parameter might dereference a freed pointer before the reassignment
> on the next line.

As Petr pointed out, concurrent access to a writable charp parameter
is protected by kernel_param_lock(), as documented in
include/linux/moduleparam.h.No reorder is needed here.

> 
> Could this be safely reordered to update the pointer before freeing the old
> memory? For example:
> 
> 	char *old = *(char **)kp->arg;
> 	*(char **)kp->arg = tmp;
> 	maybe_kfree_parameter(old);
> 
>>  
>>  	return 0;
>>  }
> 

