Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213F01C8FBA
	for <linux-modules@vger.kernel.org>; Wed,  5 Mar 2025 08:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741164475; cv=none; b=UHYg1t7sL0olb7pRC4Hy9NQsnmxkYyNnRPiTaxB735fRKQg5kCDR4Z+83TkOqt80I7iZVJxUpzdi9KVMGMQ+1Rd9qPAbBakYjY9NG2bGjkDprSB0gY1iIickD8rmFCpmue8x2v0Fi2+6Vjbiw1rqOBHXy1C2OCr8bgwT4Zc9RNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741164475; c=relaxed/simple;
	bh=JKybJjCoE0B/n2lncmdSGTssjYFaX+FTdZIDp/sCbx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CgfQqRv/hJ8SyP8JCpn8u5+cQHr2IAIOZtPaPqwMyAjmm0lLulRlwmK32UbrkEpzcxIPCTxNMRp4G2cv8pcuAUMMxl414t0fuhd2Yt9HoA//y9iWFOFMwN87ZBanNiHMAadjWFvN0Wal2Ul5q408cvFXTwfKDYSnaACzHEIOI5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gXCWjgNS; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gXCWjgNS"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-390e3b3d432so4339614f8f.2
        for <linux-modules@vger.kernel.org>; Wed, 05 Mar 2025 00:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741164471; x=1741769271; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zvpBTp2BY7pS5ECRfbZtHxBeNysVHVR+CVs88T54ai8=;
        b=gXCWjgNSk6nkFKhEXYKdcHk39drO7yuz13WakTs4xv6ae1wGXdHuRHfCzdEb2uN1yv
         5erIEhN+KLRbfJHlwe9neNjBuTnacbRNOf4eBmL9HGDiracE4fsfbyzRB7C0TPLlpyrE
         f75wd0aoHcJ5Sx0MUyGyuA7E4T4c2ajX42pGpLXbEnMFreTTLJXqcLPXjDTdu1i4V5qA
         OnxD+Ug1fRXcc8TGi1QpzffbUcj07vXtc7qiKO18UdZKAlF9zBcZfyM+q3/aHFWMGaxV
         drYHo59+7hhV96wnqwD4AQSm6KZI/33M+IS0xbHBUmUiBqepOu4qH+J3bfotGXHUFVsT
         rtog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741164471; x=1741769271;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zvpBTp2BY7pS5ECRfbZtHxBeNysVHVR+CVs88T54ai8=;
        b=HlN4Ub5tYYZEvj3xqAHAroFC3/TQDXYkSdPaJDVQW1Z+PRrz4+jxM54eNQ5xtCJPTb
         a6oR/jWdhCO78QpdBX6Hp7jhaRvqxKzJos2fSfBP6fjwsBgDpArhsY9bMwTI6jD84l0f
         1QYkQrh+ZhGFNXdRAPEDGsSJA24971xLyKUjnke9XqvNRmsNpVT2hqYxgLd3elUy4xDp
         54dMxXmVvwl2rdl2MAOsUyIXEHZjb3qiNq8VOux61R+cD1ykkan0+V6QRj799/Xv0F94
         RjCX8SLAvmkvZFd1jzJtdEXic7485NRZigDuzjzWadXrEOWmpSx7xjy56jhteNw7aads
         CWpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRJPYt38LiDMTruRxaoquyW9RSIKBYcFJInrbqhSl72KYlaBkf1J7ibwgNa+4IgsKypctt6ihiYxcqE13u@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3CyNreu73x9RqOoTrt4Tsp53YqglSrnCO99aHPV1JNbIbdiyC
	SSLWWH75+j6AO6cprqJ8ZmtpYkNY0unPJ/Rq9LZ6iEiYMq1v1RugSvKkAZGGbT0=
X-Gm-Gg: ASbGnctIf4aygzwC2oq/YX+5v9CvFDrZFzfjIug1tNei5k1nhggN42bTuep4f0RTJxL
	4EutDwc5pgREZbyhrKSuLtoUN1WNr2PEwgYPFOLqRmj9N7324DaxiQPcagM+RrLtqqfL6MJLPXm
	5+/v8NXD1+IfX2x32WkUg2AOZUypHh1thf/y1sWst3JuXcGzbIRv/jCdGnqoovNFklo/+M9b/li
	qPcr0bp5gsMl8auECJmfCnLs7AeAiS5S5EOrSoakZbnOO6fxk5kaNBuBdAc6WgucRITPJqKBPOI
	UsMqZl2PrUt1bTmGQlpz+nQVlWX2MWX6IKyrzAoJ/bRXnek+
X-Google-Smtp-Source: AGHT+IFqiG5KUBY477piOlIYHBpXnTArndch8RArWHQORojdj7IkUy39eZX+lXOVE16msF37clFMxQ==
X-Received: by 2002:a05:6000:1a88:b0:390:fe05:da8e with SMTP id ffacd0b85a97d-3911f75796emr1473006f8f.28.1741164471313;
        Wed, 05 Mar 2025 00:47:51 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd430c2e9sm10640655e9.33.2025.03.05.00.47.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 00:47:50 -0800 (PST)
Message-ID: <17c0cce7-03c7-488a-b61a-6c41d5bacfa1@suse.com>
Date: Wed, 5 Mar 2025 09:47:49 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/8] module: Add module_for_each_mod() function
To: Steven Rostedt <rostedt@goodmis.org>, Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, linux-modules@vger.kernel.org
References: <20250304012516.282694507@goodmis.org>
 <20250304012548.433669427@goodmis.org>
 <20250304095714.47a171fa@gandalf.local.home>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250304095714.47a171fa@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/4/25 15:57, Steven Rostedt wrote:
> 
> Luis,
> 
> Can I get an Acked-by from you?
> 
> This follows the changes you have in linux-next.

Hi Steven,

I'm not Luis, but we started rotating the modules maintenance every six
months and I'm currently looking after the modules tree. I see Luis
seemed ok with the change in the previous discussion and the patch looks
reasonable to me.

Acked-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr

> 
> 
> 
> 
> On Mon, 03 Mar 2025 20:25:21 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> From: Steven Rostedt <rostedt@goodmis.org>
>>
>> The tracing system needs a way to save all the currently loaded modules
>> and their addresses into persistent memory so that it can evaluate the
>> addresses on a reboot from a crash. When the persistent memory trace
>> starts, it will load the module addresses and names into the persistent
>> memory. To do so, it will call the module_for_each_mod() function and pass
>> it a function and data structure to get called on each loaded module. Then
>> it can record the memory.
>>
>> This only implements that function.
>>
>> Cc: Luis Chamberlain <mcgrof@kernel.org>
>> Cc: Petr Pavlu <petr.pavlu@suse.com>
>> Cc: Sami Tolvanen <samitolvanen@google.com>
>> Cc: Daniel Gomez <da.gomez@samsung.com>
>> Cc: linux-modules@vger.kernel.org
>> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>> ---
>> Changes since v2: https://lore.kernel.org/20250215034404.902259250@goodmis.org
>>
>> - Use RCU guard instead of disabling preemption
>>
>>  include/linux/module.h |  6 ++++++
>>  kernel/module/main.c   | 13 +++++++++++++
>>  2 files changed, 19 insertions(+)
>>
>> diff --git a/include/linux/module.h b/include/linux/module.h
>> index 30e5b19bafa9..9a71dd2cb11f 100644
>> --- a/include/linux/module.h
>> +++ b/include/linux/module.h
>> @@ -782,6 +782,8 @@ static inline void *module_writable_address(struct module *mod, void *loc)
>>  	return __module_writable_address(mod, loc);
>>  }
>>  
>> +void module_for_each_mod(int(*func)(struct module *mod, void *data), void *data);
>> +
>>  #else /* !CONFIG_MODULES... */
>>  
>>  static inline struct module *__module_address(unsigned long addr)
>> @@ -894,6 +896,10 @@ static inline void *module_writable_address(struct module *mod, void *loc)
>>  {
>>  	return loc;
>>  }
>> +
>> +static inline void module_for_each_mod(int(*func)(struct module *mod, void *data), void *data)
>> +{
>> +}
>>  #endif /* CONFIG_MODULES */
>>  
>>  #ifdef CONFIG_SYSFS
>> diff --git a/kernel/module/main.c b/kernel/module/main.c
>> index 1fb9ad289a6f..927a2e0ffd5f 100644
>> --- a/kernel/module/main.c
>> +++ b/kernel/module/main.c
>> @@ -3809,6 +3809,19 @@ bool is_module_text_address(unsigned long addr)
>>  	return ret;
>>  }
>>  
>> +void module_for_each_mod(int(*func)(struct module *mod, void *data), void *data)
>> +{
>> +	struct module *mod;
>> +
>> +	guard(rcu)();
>> +	list_for_each_entry_rcu(mod, &modules, list) {
>> +		if (mod->state == MODULE_STATE_UNFORMED)
>> +			continue;
>> +		if (func(mod, data))
>> +			break;
>> +	}
>> +}
>> +
>>  /**
>>   * __module_text_address() - get the module whose code contains an address.
>>   * @addr: the address.
> 

