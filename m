Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CC51C07E5
	for <linux-modules@vger.kernel.org>; Mon, 10 Feb 2025 13:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739192681; cv=none; b=rEpv9HcZTLtbfwuNKvjGlDLnlglwp8qHINxX5IPkDGf6WQfOvfRh9B9/lV6okDz7mODwrSWv3TxyQMY0am6hbaex2A8Ibz+Nk9j/ENqK1DodkoJcv43lFKI9OqyXBALWvWMlodFIp/AF6QyAe9m9+3L/wkmbKcUtNg7u2zH/88A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739192681; c=relaxed/simple;
	bh=TMe25nCM0BHpCbFZSwZOPmaumdXtOGeDx95yM36MDSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IZNXpSt/Re+hw7CApZA3WFG9mNutX12ZLz+dCvtcN1Y9cEjFGossdvREk1ZUgIx7TQDA91Y2+P3zUwJUGIFdrKzf0M25OoB5+WTwg7rWj8bjnjMTlWK1RypZYbh3bif+yOZyACbJwty1OwffSWBVnMPQ21kKcIzxXT9H3LaAKMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gQ3w6er2; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gQ3w6er2"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d9837f201aso10516252a12.0
        for <linux-modules@vger.kernel.org>; Mon, 10 Feb 2025 05:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739192677; x=1739797477; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hm9uRlDDCQDIAslcQYKmjR+S5BDffyTf8LS/XZbmUrI=;
        b=gQ3w6er213XUxlgk/RMCeoc0mHIlQZYk7+2lU/fswduk3U6EkRRpvM6it721Wf7H6l
         bgE+hVidsYfeOC+YTkIrNN4lvRJH4XHwtJbkvComKoGRUr2lORoYBaVrFYP1LedgRmyo
         jSCtxcLTQjUJJRci9YR5SYNnAGvPp8XvZ7+7Xb/aQBCI5F7oSNuHOiJhD5KG1IhDh2B6
         HT+VAcNuJsh5RDVsoSgB3eYunlSA3fTkRUTRiBXJ6hHouqNq/VUEhxGEbQxYt2vgtcp9
         jVc9HZPjSb91bOOfNH9+MV0kcU/PwCCH2tGwGXuUq5QxxpemtMsRI0odMv2iYbfVUk54
         D2zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739192677; x=1739797477;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hm9uRlDDCQDIAslcQYKmjR+S5BDffyTf8LS/XZbmUrI=;
        b=Ag3Ja7uH10D2oKOqIRWkD+tMH2wwESHr8FVS8I+8m+pfBOYCXFlDkeohbHQ232xnTP
         Cwur9xtzCHvmcVlgWDBIyuhF9psTdVGlupCQE0JL913k9ZbZek2R/AYNyapWZghlzk5o
         W8y2uADzxRZRFjU5RwnO9rINCAYhWWG/qjj65yK4iWtUTgc/YEsc5HsOAto4xAdrPRVL
         DDRWTSwiHWCRoHRTJ5DJi1zFYVgaU1MTUaLggCHNcaDapI6wfh8KK0QOT6/LtA081u1z
         MHtzjGuVDqfxLsBh3XMtGjyAMVGUXaFdthSIHjEkj04K+BFVv+uqpFCSe4WyoAlRAqou
         rEpA==
X-Forwarded-Encrypted: i=1; AJvYcCWmDa6ALwegTRM6mArKLUB+YJDMZLBYpHWrks/o9OtnNTvshAw0NHaKGmM+Lf2OlYGGHKEWLyePpu1joXcW@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ+HUgLORw5kkES2oFe5R8jF7mpS4sc3XmOGFgEbzJcF/x8SW4
	f5DHKRnwk+IMbpriH7vhBzzqGlun2lWr7JTNzcdjQ516aC861DOmyPIcYH5cNkw=
X-Gm-Gg: ASbGncvDnlEmI1tdO1FzuSyMh6ktTmScuePejnuyDL4ThUvvgY7VQavTybN43JCR+mk
	M3g5ySHMv8EgmNya9TBi9ONfunggAF6nYHYZs/x3AZUHOrHgAevr7p181U0wRguHh2RE1m+DmZc
	i5CckmYcgjHaqfb7OOQepNALQYn9jmDzBHwMW+QroXQk4HROR+OOdpWbk+cl/ILT5ThYPVL+eMw
	T9C+RKYzcmB3lsqA7yqaCy1B3Oj/oXJKxAmh53WRH37E9hCwLr7MdObO5WnuX1Mvv/vps3M8pcS
	A1AEbedP4AEmRYH6PN4=
X-Google-Smtp-Source: AGHT+IH5bimbp5Prf9r8LGmM1cwj8tMFGXaNtz3i9nu0Q13JcpFZkivfkOpeikGkVqCydxuQyh1dFQ==
X-Received: by 2002:a17:907:2ce1:b0:ab7:cd14:2472 with SMTP id a640c23a62f3a-ab7cd146884mr168695366b.23.1739192677096;
        Mon, 10 Feb 2025 05:04:37 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab786aa2c60sm759297266b.102.2025.02.10.05.04.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 05:04:36 -0800 (PST)
Message-ID: <bfe05b54-9714-46bc-9b59-ad091897c62d@suse.com>
Date: Mon, 10 Feb 2025 14:04:35 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] module: Add module_for_each_mod() function
To: Steven Rostedt <rostedt@goodmis.org>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>,
 linux-modules@vger.kernel.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20250205225031.799739376@goodmis.org>
 <20250205225103.760856859@goodmis.org>
 <20250206142817.91853f475c681bc2ef7ca962@kernel.org>
 <20250206102720.0fd57129@gandalf.local.home>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250206102720.0fd57129@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/6/25 16:27, Steven Rostedt wrote:
> On Thu, 6 Feb 2025 14:28:17 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
>>> --- a/kernel/module/main.c
>>> +++ b/kernel/module/main.c
>>> @@ -3809,6 +3809,20 @@ bool is_module_text_address(unsigned long addr)
>>>  	return ret;
>>>  }
>>>    
>>
>> It is better to add a kerneldoc for this API.
> 
> Agreed, but I was planning on this changing. Waiting to hear from the
> module maintainers.
> 
>>
>> /** 
>>  * module_for_each_mod() - iterate all modules
>>  * @func: Callback function
>>  * @data: User data
>>  *
>>  * Call the @func with each module in the system. If @func returns !0, this
>>  * stops itrating. Note that @func must not sleep since it is called under
>>  * the preemption disabled.
>>  */
>>
>> BTW, do we really need to disable preempt or is it enough to call
>> rcu_read_lock()?
> 
> Bah, as I expected this function to be changed, I didn't spend too much
> time on looking at its implementation. I just cut and pasted how the other
> loops worked. But yes, it should not be disabling preemption. In fact, I
> think the module code itself should not be disabling preemption!
> 
> I'll have to go and look into that.

The series "module: Use RCU instead of RCU-sched" from Sebastian Andrzej
Siewior cleans this up [1]. It is currently queued on modules-next (for
6.15-rc1).

The new function module_for_each_mod() should then use "guard(rcu)();".

[1] https://lore.kernel.org/linux-modules/20250108090457.512198-1-bigeasy@linutronix.de/

-- 
Thanks,
Petr

>>> +void module_for_each_mod(int(*func)(struct module *mod, void *data), void *data)
>>> +{
>>> +	struct module *mod;
>>> +
>>> +	preempt_disable();
>>> +	list_for_each_entry_rcu(mod, &modules, list) {
>>> +		if (mod->state == MODULE_STATE_UNFORMED)
>>> +			continue;
>>> +		if (func(mod, data))
>>> +			break;
>>> +	}
>>> +	preempt_enable();
>>> +}
>>> +
>>>  /**
>>>   * __module_text_address() - get the module whose code contains an address.
>>>   * @addr: the address.
>>> -- 
> 

