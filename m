Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF457439F75
	for <linux-modules@vger.kernel.org>; Tue, 28 Jul 2026 12:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785243471; cv=none; b=uabgvw6ZzpDuswSl48xi2OJnNm7mDyQoBs/bqenMLsGNxsVOIM44EzNFmDMtgAnhiiUJc4yUZoX4oBH80tpRD5noZtieQvyKUK5iU76fnbASzFrla9ly1YJoyzeChknjuZ82lxmCUkJ33YdzsRtQQepls57WCnX7BMrHvRI345g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785243471; c=relaxed/simple;
	bh=TW87QvdQZ8BHmUf8Z7mT2GUcz8XaXspQ0T5WESzY1Rc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LzuxXydK9Jb8kHlIB4Eo6xnAu+rarbJEdPQoYOmK+Rn2ijrIhdnJO1uTC5yRvExcrZ3EFa0h4rqbEF8Y1G53GIkuCx1SCyGg53d9sw58GVIU+kBcvghHbhafpS44uifcmI6rc98kr5eTnG2FQ2rIFp/EFdLWfU9DL4tcLWAlKMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EtU99ShT; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EtU99ShT"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47f3b39f2a1so3243563f8f.2
        for <linux-modules@vger.kernel.org>; Tue, 28 Jul 2026 05:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1785243468; x=1785848268; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7c8BG2Wsd8VTOe0aUX7OoWEuZQdz0YbW80d8DVt3rm0=;
        b=EtU99ShTBJaSbqs4DUrs9ar+Tlx+Ityu8XqvzO6++0RjOqGZO8eZj21WV3Fnlmlufc
         3VRRqHL1JY81RCijQjbmGAO39ncah3R1WyaJcRWynwEpNls+wvjmB064kUZVFOQAugnw
         zMyjOyZW3BmjSQxu2tIG5Ui327Pix1QYQzWgjb+K/8vpLFMRiDi+YhDDlF0saLTOOsUz
         vAC7zP43rY22DvdAAOQsi9FXPtiMHeoa3MVpVmzgq4ImgLAdPUZsm4Ly3VLONJwML2EG
         Srg8hDY8iIVfyHy0tQlX42+/u2SXoO7ekUR5jICkRS2hxzrF/71o8GeEFneo8wYSA3Sf
         Pamw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785243468; x=1785848268;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7c8BG2Wsd8VTOe0aUX7OoWEuZQdz0YbW80d8DVt3rm0=;
        b=TpSxSbPtuyqE2VeWXPnRdlHf4k4IoaKJZT8vWS21tcxkME0Us1blW1dHGVtGCHwXvb
         SyGyUVpT1ldyqd/45rpDCKzZA5MJO4YEV4F8y6wNDqZIMkjFgjiZli2aaANEO3/mUVDY
         r1+tnaO6yz63HnjFWuz2xE1b0UZndfSu+xuOVib5QAcmZKP+nmVDOWCFvbKFD8onLGHn
         I3FvXLLMC+W81e/ZtWUSs5S/6NShWPE36ZhKb2GtoGzpyEUENGdfz5hazdOPGDT9WEvv
         3suvjsc0v9NfQvR9xx/5doBEBxK0FC2PUrwqgzEtBvGZsOS4ZfdKB5GCbI9Sump+kEV9
         F/vQ==
X-Forwarded-Encrypted: i=1; AHgh+RpUF+4LeIjTAnoC+JS4hsAJI2pQ51geEwHkGxKAQ9Kta4Yu10m8gLkOC3xBqlnHGOANYo7qhHvsyVFPWkl7@vger.kernel.org
X-Gm-Message-State: AOJu0YxwD1uDmIJhc7OOmjrWcm/KPRLUXOTVAXnr0VqCTra5d/Gd5gU5
	fbDk4A+nzzOkv3Na+i6Fp5i2kZ2eqaX7x226+vNuAiOwNlkHTYi22bi/vB9ilCqrTIaH67qdkwe
	dxQ5sgMU=
X-Gm-Gg: AR+sD13sovotNcDwwN2zdLTWR8iJ+w2joHend64Kc4kzblWwY4CqHOjMQCfx2cwascB
	jKjrhTbKX5vg49q3KaxYKjIsxW6KsmDKepDeU2J/oG9OrJzNMMd3ozFfURYvHIIrPkDn7RBRQ8T
	A6mQ3ib6UJ6kHnjM3Jdl0n+g5b5WNHN51P3bJY2sXrC86R173kWCQGZtIWYWioCUseZt9NaQTL8
	UbUt4/SrNvKO3xrTgJ21h3bhmjBXH/FuZKgwRL3xMEMlXqtXjGM1NgDttwurmEBX/dXDhrToUj9
	sP6oca+FsLXv2h5oM6YCdH/raG0QYqYjCsiajB8+BQM7xkM4wL5iJ0JoWjP/nDFoLT1YJj9oSr7
	1vWlgI+ZZWrOC+rNj4+fy6JihCQJ/yuU5P35SEoE6zTcIr/LYt+/MGCbaPKJ4zomu1/snp0BvN/
	urmUYRQm6dq9Tz2HpKh0VUgj0CVnUlS2/oAtw58pA=
X-Received: by 2002:a05:6000:22c5:b0:47f:838c:4256 with SMTP id ffacd0b85a97d-47fb1e6cd19mr2838433f8f.16.1785243468095;
        Tue, 28 Jul 2026 05:57:48 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:fc6c:f9a2:4a0a:6354? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c67339sm61318643f8f.31.2026.07.28.05.57.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2026 05:57:47 -0700 (PDT)
Message-ID: <ff0b7cdd-8fa7-4cb8-9e21-6a7204809766@suse.com>
Date: Tue, 28 Jul 2026 14:57:47 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] params: fix charp corruption on allocation failure
To: Jiacheng Yu <yujiacheng3@huawei.com>
Cc: samitolvanen@google.com, rusty@rustcorp.com.au, hannes@cmpxchg.org,
 yosry@kernel.org, nphamcs@gmail.com, liuyongqiang13@huawei.com,
 linux-modules@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260728085518.3865621-1-yujiacheng3@huawei.com>
 <dfe25916-0f2e-44ed-8f49-d7448a0e28fa@suse.com>
 <c9643f86-f196-4c99-8129-2314a33a990f@huawei.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <c9643f86-f196-4c99-8129-2314a33a990f@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/28/26 2:22 PM, Jiacheng Yu wrote:
> On 28/07/2026 18:46, Petr Pavlu wrote:
>> On 7/28/26 10:55 AM, Jiacheng Yu wrote:
>>> diff --git a/kernel/params.c b/kernel/params.c
>>> index a668863a4bb6..e4f2b71dde1e 100644
>>> --- a/kernel/params.c
>>> +++ b/kernel/params.c
>>> @@ -261,6 +261,7 @@ EXPORT_SYMBOL_GPL(param_set_uint_minmax);
>>>  
>>>  int param_set_charp(const char *val, const struct kernel_param *kp)
>>>  {
>>> +	char *tmp;
>>>  	size_t len, maxlen = 1024;
>>>  
>>>  	len = strnlen(val, maxlen + 1);
>>> @@ -269,19 +270,20 @@ int param_set_charp(const char *val, const struct kernel_param *kp)
>>>  		return -ENOSPC;
>>>  	}
>>>  
>>> -	maybe_kfree_parameter(*(char **)kp->arg);
>>> -
>>>  	/*
>>>  	 * This is a hack. We can't kmalloc() in early boot, and we
>>>  	 * don't need to; this mangled commandline is preserved.
>>>  	 */
>>>  	if (slab_is_available()) {
>>> -		*(char **)kp->arg = kmalloc_parameter(len + 1);
>>> -		if (!*(char **)kp->arg)
>>> +		tmp = kmalloc_parameter(len + 1);
>>> +		if (!tmp)
>>>  			return -ENOMEM;
>>> -		strcpy(*(char **)kp->arg, val);
>>> +		strscpy(tmp, val, len + 1);
>>
>> What's wrong with the plain strcpy() here?
> 
> Functionally, plain strcpy() is fine here.  The preceding
> strnlen(val, maxlen + 1) either finds the NUL byte within the limit or
> rejects the string, and the new allocation is exactly len + 1 bytes.
> 
> However, when this patch rewrites the line to use tmp,
> checkpatch --strict reports the following warning:
> 
>     WARNING: Prefer strscpy over strcpy
> 
> Since the line is being rewritten anyway, I changed strcpy() to
> strscpy() to follow that preference:
> https://github.com/KSPP/linux/issues/88

I don't see a benefit to using strscpy() here. The length of the string
is already known and the tmp buffer is correctly sized, so using
`memcpy(tmp, val, len + 1)` seems most appropriate to me.

-- 
Thanks,
Petr
