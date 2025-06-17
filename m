Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2462DF3C9
	for <linux-modules@vger.kernel.org>; Tue, 17 Jun 2025 15:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750174886; cv=none; b=iIuW2ABj16Bt2wsf9ofvfRD/7P/a03rUpf9QM/8BV/bsoHXwRzoGJoGNERap5eLnyAuPX8mkoeL0ZoKNe9rVz8oJ3gnLZsr1JdDeDbCC7L0MIpSA/NpjevIRiSA8VMf3bOSbpSH9mKQ47g0idTWQ+GuMpYngvcmIfjWwLVjV7+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750174886; c=relaxed/simple;
	bh=YEaWsZ0wi7V0Mecrq5nmKoKbpvyYouj783eYF+zdy80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X+9vGVOPNfVTtmz8VKD0ivVqL+l5G+sMSH69bFJDvugjqz2/rfP0qbwon9dL3WHJjwIF80Y4Q+A96Gux4a5U0tOotGRq4UjShafX5kzJlVPjmzWGNMKynXDgNigMKw6R6pCjL744YxTgNiNWHYGecbXhTOkQ0Xd1F4OqgDFHfX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=V0wh0vPi; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="V0wh0vPi"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-450cfb790f7so47200755e9.0
        for <linux-modules@vger.kernel.org>; Tue, 17 Jun 2025 08:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750174883; x=1750779683; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UEyoVi/uOGo/A3hwmraEWtZd9MgKdLDFA01pXxqB4cI=;
        b=V0wh0vPiCMbZIRnsSmqIYnHCmDCT1fVFfOUX0ij/1zZvZEWm+2NV0bIvtEhVlNzXSX
         kT+j0D6zN7KmIqj69+B3iRPZNsOzG23AhiPIIVe5Jt5EXQwUo8TbbWJaaJi1oAhjDD4w
         aJ8ofwOhcdslW8rqbfllfsLrDbSvPJgUdUziF6oVwn39mWsQss8cDTcfhJ/gmNyLYfrT
         5ucix6dtkrJX7SmjK3+tCC7Mp8xOvq136rGbQ3LFvX5jkHyXM3slHWzGn9Geba3ImoGQ
         AuPSI1l5FNikCCdRz/oQPjCdJ/95QjSYrALzj7PmUGBSbYz+PWYUQSpjPwIpgEG3LhtQ
         K18w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750174883; x=1750779683;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UEyoVi/uOGo/A3hwmraEWtZd9MgKdLDFA01pXxqB4cI=;
        b=dAXl4DWOKWrh7cRC24wPKDOjkxFsRtbVzYZ8mx8vtfI0L1bhZ//Yv5i34i4wp5yk9T
         lQVXDcr5l/iBu90jctWQOae7opKaBQzUG8rvoHyFebYzsdUlAAoIzJwoQ/6fSM+Zd8Qa
         btmghW2KaZO3MDlt71B7+YqmtQ9X6WTPTLsEnkZ/LkBUiCvVdZmgczb8sxx5Y9+dO20E
         3sINeIa0Iclh0th6lX1H3zRQl7rsPaKtfdPJNCgpLGmsYPBgswufPpd2CrNHHPHN3srA
         Pt0OnW8MMICTGUMZKXYpw2m5frAuW/JxggjWEe0ojbSGNPcyvjeyJDyh4YtJxHdY9nAa
         L1ug==
X-Forwarded-Encrypted: i=1; AJvYcCV8jyh7meS0tAXuNR0yPZvAca9VXRkgODyQGyCLxHmTyMTnY8wfJOAUqxT3ceS61y/UZ/lZIq2kScJo2S+p@vger.kernel.org
X-Gm-Message-State: AOJu0YwobeMBGBgYQWBdCFefiTuyAUZCS8XjM4vRxBXziumjJF4adFJQ
	wym4EM8oIOVhwnF3Q0KtXMRt6d+ud1/s41fmEYcmulpADpd1Le5MpKWicoj5Pz+bnFg=
X-Gm-Gg: ASbGncuS2yQf7tcmzlcILvWIBLIKKwlaZ6JTCQZTNE+zRushcYXH1SoTFwaQxCbPZkO
	Z3vgDz51n6l3S3wKqSlJLOpF8cPkvVmELU7Co0fMtgydKHVlSOkQlHdqAfd8pniEFnIw7K20k2T
	I4qwl1o/1Kv9KjesiEi8vDv6GpRZk14kmS1eCYUh/QJE4jcWh3UtOHjFr8/2b/yckPjmmYvfNZW
	DWC+NSB14p9CAStENqeJDdedpE3hE6E1/3v8LOLp+nsmrMFMx2EIyGYKnqWd4XMDWqiD/SvG42r
	fL7nO99jlsZF2EuDZGqNeGgzvtDVbNcbs6n75CmwLFOdrKMQirvbFRqwUWQiuiYaKA==
X-Google-Smtp-Source: AGHT+IEamICd2vufiU+uPyME8Ge0sakIyA0pSNU6/lqNJ/Z9dPqn3+6rpt7i4Y3hevVN4H/gRpO5wg==
X-Received: by 2002:a05:600c:3513:b0:43c:ec0a:ddfd with SMTP id 5b1f17b1804b1-4533ca464a9mr135611535e9.6.1750174883104;
        Tue, 17 Jun 2025 08:41:23 -0700 (PDT)
Received: from [10.100.51.209] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e254396sm184091565e9.28.2025.06.17.08.41.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 08:41:22 -0700 (PDT)
Message-ID: <2c277bfe-3086-4007-bf04-ef229e6cbfb7@suse.com>
Date: Tue, 17 Jun 2025 17:41:22 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] module: Fix memory deallocation on error path in
 move_module()
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250607161823.409691-1-petr.pavlu@suse.com>
 <20250607161823.409691-2-petr.pavlu@suse.com>
 <ae967353-71fa-4438-a84b-8f7e2815f485@kernel.org>
 <c7dbb33d-98b6-45da-be77-e86b9e6787ee@suse.com>
 <7cf40cd1-fe0d-4493-ac15-e70c418e54a5@kernel.org>
 <97f26140-bf53-4c4d-bf63-2dd353a3ec85@suse.com>
 <732dedee-c7c5-4226-ad87-f4c2311b11b3@kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <732dedee-c7c5-4226-ad87-f4c2311b11b3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/17/25 11:47 AM, Daniel Gomez wrote:
>> Do you mean the following, or something else:
>>
>> static int move_module(struct module *mod, struct load_info *info)
>> {
>> 	int i;
>> 	enum mod_mem_type t = MOD_MEM_NUM_TYPES;
>> 	int ret;
>> 	bool codetag_section_found = false;
>>
>> 	for_each_mod_mem_type(type) {
>> 		if (!mod->mem[type].size) {
>> 			mod->mem[type].base = NULL;
>> 			continue;
>> 		}
>>
>> 		ret = module_memory_alloc(mod, type);
>> 		if (ret) {
>> 			t = type;
>> 			goto out_err;
>> 		}
>> 	}
>>
>> 	[...]
>> }
>>
> 
> Yes, that's it. From your patch, moving MOD_MEM_NUM_TYPE assigment to the
> initialization and use the while() loop suggested later on.

Ok.

> 
> One thing though, we are "releasing" the memory even if we have skipped the
> allocation in the first place. So, I think it would make sense to release only
> for the types we have actually allocated. What do you think?

I noticed this too, specifically because move_module() is inconsistent
in this regard with free_mod_mem(). The latter function contains:

if (mod_mem->size)
	module_memory_free(mod, type);

However, my preference is actually to update free_mod_mem() and remove
the check. The function module_memory_free() should be a no-op if
mod->base is NULL, similarly to how calling free(NULL) is a no-op.

-- 
Thanks,
Petr
