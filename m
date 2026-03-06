Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E52D34D4F3
	for <linux-modules@vger.kernel.org>; Fri,  6 Mar 2026 10:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772791846; cv=none; b=huQ65vULf1/wqBIEmDsSSTq5GOwZVhmfkrQB6Icyr1jmsyUXaUZB5iP5RFzsxVkcuP0rxapck3IeGVJrEy4wH9cKvtJmfU8ihQmNK1/zZcGhxaVAPEl1CR5hXEu3l90yMNSL5B8ZDFhiwGXdaSVXlrnSbU/aFZED1g5kGqvHDvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772791846; c=relaxed/simple;
	bh=hk8HXYbZVhzYn+Dillokb6N/doKCojXkQwQYXvL59PI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UDTjpjjE1ly0aAMR2SKMCE8zkQfZNKUTPSjSYJSMITCwlzV490u5RiBcjhcAgMqzfLlmEZM2ONo/HG0bZgp8Mcl33j5P15RV78XZ3Q/yOpVYZDnXr9xY7O04QyIB9vizXPTCjrlMJmstpHqQUxeV6KJ5YWcCd7SmAjNEgrxvaL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=K8jLlYa7; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="K8jLlYa7"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48371119eacso107252455e9.2
        for <linux-modules@vger.kernel.org>; Fri, 06 Mar 2026 02:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772791843; x=1773396643; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dx46j4mpU7caGK06wmigiME4dMSXBf+87tm/94ZnP2k=;
        b=K8jLlYa75D5Ktz2AZTL6wfZfogJpK63eg572DkDgmqvpEr2L0Jrjup/vgNFWgUtJYE
         n0y4KDl9R55iRoRT2lFnnR2E4c2+6BMm9wKVqEEN7iNBTK4LeG2Z3bswi5YGtlU+8atn
         fpXrn0zEbovR6okPA+RYe/Bt7X2oezIarjNTP1p9faMDoDjBlUbxxWBqFzjCPJg0bgpP
         gxFIKG14S9m+/8wIJkUoZsNZVwVQ2JkQLz3mchvxAhchEYLcKKzS66Of4S0CC+DCBbbg
         zJ0A0HCLKVYjvriJgSjx6ToYOVLJJO45iQZWS+Pk4tQcATYn66T6MLn1hqy/kzt0EU+H
         SRNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772791843; x=1773396643;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dx46j4mpU7caGK06wmigiME4dMSXBf+87tm/94ZnP2k=;
        b=GOw+WG+KUxipSL9rB5NyKUsaXg8TWjbLx/DpKuB8PlGPn6tOWgKsxXpumbtqaEEfZ7
         hKmQuwbWWWpz/PFLYDDwRQXbzCjbcUdUTd1T+BCodIs8ENljOtmHjuqL0tmV0TvuzrHp
         kPN1Wew3udAn6R2w2j8+m0+Xrh3kkQGwWaZD7oY1mbwiQtlS2DhwNnSEKgFFHhfmBO6t
         /kwcg+fIEB9MS5VBTeAM8dOFNgkgraStxh4dTGJIYxPSncBKcudVx5aSUEO0YgiNn+NS
         PaHbWl4/eEj6YxtagnpDBRb++ltSc1085C+Ef/nXoMf/J+5q+xfotRElD7r2BGJKMxNP
         rtBg==
X-Forwarded-Encrypted: i=1; AJvYcCXZyeX6fHmqZjOH585cbLetT2zuDu+Lvq+z5revIUCLnsD/mXf8ud38LF7QejholBbE8l1b+gWpx42BIUd3@vger.kernel.org
X-Gm-Message-State: AOJu0YzSCEG6CBzbnNvZlNYhXAGB1PI83myBeqi5uXIvWODuaf3J1JOa
	ySgsm62AYASgDUBxLgYjMaKJBzNLJsckquRuvQFNL2FZ+m5RHOpVlDpXQQSockF6Zy4=
X-Gm-Gg: ATEYQzwlRgShSeWnwxs37TSH1DubrPLiRqDy/eKD/kjrLB/Do5lGNIrkS01KXscRM7e
	ZfbYgXYEkTMi0l85ofpgaCEoxO5MBEEGjSjJZB6/KVDJrY0dtzx4h0jWMAnEpaW564GzqRn/Gtc
	GEE26Up1WGyoVYOUKeXwbDeoCK1/wsKKFwWbRI6Xh3gl13P9UKT9URwpnbxXgewC7VskN6WMy/Q
	ttMdZdLCq+aHehLzT67sVVChybxlObUXHOkbF5lDaTi8XJWAdQeEVYuPJmG77VXRYCPpbEzLBH9
	3SHsJMIxTxC5khZkMdZ2JskrY9Q3G0w5iRT+KQyI79s6pBGBBF43y765ma5WxznnRPUfBykK3S3
	4tJ0s5DSZOVwfgrJgQz9QCQG0zzexEPhc8I1Aezj4eXfutqKuUv0zoj58jlayRMPG8WqolI0kaz
	jNSwK0ZBqgn+vJTK0M37eHHbVWuZtBDWnhtu8T7JfxMxkv
X-Received: by 2002:a05:600c:6386:b0:483:afbb:a064 with SMTP id 5b1f17b1804b1-48526918f7fmr25254685e9.1.1772791843501;
        Fri, 06 Mar 2026 02:10:43 -0800 (PST)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485246ece8bsm20699745e9.4.2026.03.06.02.10.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 02:10:42 -0800 (PST)
Message-ID: <87a72531-5730-443d-8b6f-07ae9b8df6dc@suse.com>
Date: Fri, 6 Mar 2026 11:10:42 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] module: print version for external modules in
 print_modules()
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, mcgrof@kernel.org,
 da.gomez@kernel.org, atomlin@atomlin.com, linux-modules@vger.kernel.org
References: <20251231094004.37851-1-laoar.shao@gmail.com>
 <20260305234344.GA788042@google.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260305234344.GA788042@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/6/26 12:43 AM, Sami Tolvanen wrote:
> On Wed, Dec 31, 2025 at 05:40:04PM +0800, Yafang Shao wrote:
>> --- a/kernel/module/main.c
>> +++ b/kernel/module/main.c
>> @@ -3901,7 +3901,11 @@ void print_modules(void)
>>  	list_for_each_entry_rcu(mod, &modules, list) {
>>  		if (mod->state == MODULE_STATE_UNFORMED)
>>  			continue;
>> -		pr_cont(" %s%s", mod->name, module_flags(mod, buf, true));
>> +		pr_cont(" %s", mod->name);
>> +		/* Only append version for out-of-tree modules */
>> +		if (mod->version && test_bit(TAINT_OOT_MODULE, &mod->taints))
>> +			pr_cont("-%s", mod->version);
>> +		pr_cont("%s", module_flags(mod, buf, true));
> 
> On second thought, is using mod->version here safe? We release the
> memory for mod->version in:
> 
>   free_module
>     -> mod_sysfs_teardown
>     -> module_remove_modinfo_attrs
>     -> attr->free = free_modinfo_version
> 
> And this happens before the module is removed from the
> list. Couldn't there be a race condition where we read a non-NULL
> mod->version here, but the buffer is being concurrently released
> by another core that's unloading the module, resulting in a
> use-after-free in the pr_cont call?
> 
> In order to do this safely, we should presumably drop the attr->free
> call from module_remove_modinfo_attrs and release the attributes
> only after the synchronize_rcu call in free_module (there's already
> free_modinfo we can use), so mod->version is valid for the entire
> time the module is on the list.

This looks reasonable to me as a simple fix. I also noticed that
setup_modinfo() with its attr->setup() calls is invoked unconditionally
in kernel/module/main.c, while module_remove_modinfo_attrs() with
attr->free() is present in kernel/module/sysfs.c, which is conditional
on CONFIG_SYSFS. In the unlikely configuration where CONFIG_SYSFS=n and
CONFIG_MODULES=y, this can result in a memory leak of module::version
when a module is unloaded.

In general, I think this could benefit from more cleanup in the future.
Most of the code related to modinfo_attrs should be moved into
kernel/module/sysfs.c. Since module::version is now used from
print_modules(), which is part of the general module loader code, the
initialization of the variable should be independent of all sysfs logic.
Ideally, the sysfs code should only read module::version and no longer
manage it.

-- 
Thanks,
Petr
