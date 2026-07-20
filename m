Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAB2417D97
	for <linux-modules@vger.kernel.org>; Mon, 20 Jul 2026 13:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784554088; cv=none; b=aV4KgLp/EmbNF1+qvYPMAomMNAjhK9YLy8KrzeObNjbtlafR4ZK7WqqD6zuoNS9VB0mAL+S70rOmbr3m5YD5AUmwupuZuVa6aKotRRcpBNNTNa5Qkjjnm+edxJHM8XOHhJCwIw6RqU0JWOUgK67ZmxnWjzDUhBfQZaFtVMdcGdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784554088; c=relaxed/simple;
	bh=WFsvkvo1SmgL7lQS2bCBRqIPfpJNPnGjjQa+jIXyK6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GLQtjjwgmsq61kh22dDsYnwwi68ZbLIQ+YxEhK5vjUzAyJNcJ2xGfC8X7Bc2Qp0sh6YTaxCQ71EukgecZrROvX1WAVS+CzPfEUYsqZCCcNDaagrzgwnXh/WgGGqMOsZ1YMiNJNj1J2YcgQej1yYD8iXSlfgoPnj53rldvvNu2SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GPu4P0kG; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GPu4P0kG"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49553515a8bso20522585e9.1
        for <linux-modules@vger.kernel.org>; Mon, 20 Jul 2026 06:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784554084; x=1785158884; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bi19W6oapueN1efZ+izIaahgjmtnO9MBZANr+n3yuz8=;
        b=GPu4P0kGt0ASajPETkOXh7k0IzFY3HDQ7afYRIa31nXwVOYpSdpIAdXb3MOcXLPqvy
         JFSkaW/htPoAeH1oCdf06CW4EgdGK53C2lyFVTbXf5tEuJfx/yi2crY5V+m86HpcI8j4
         GTW58tJLcPP56EGQ3Rgs1czSR+Elqaw/ktazmRyCrvN7l9UApNkfQo7mp0rt2VIFk1uh
         NIJhCvJSG9MdvWxBAhrB8SILsFcrrqZiL13yTBoakVoPLoRMSPxwmymuux0u8n8HkI2E
         LrFt1PIBLHWnd262Atmu6SPXm2qg3wl0mNoiNGVYPB0Eo6F4g+Q4LKTvr941z5AO+Z+8
         RbWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784554084; x=1785158884;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bi19W6oapueN1efZ+izIaahgjmtnO9MBZANr+n3yuz8=;
        b=GHvmKd50qPWdELzILly0HBF9/REMIubA6Sc6OkbJA0CNiLKNuF3uyVEw02c9n4wjkp
         c3xlGyfoMThKDK/VsNE8wLLEgoZynRqJJgTCMI+JEoJ7p8w28kbSV2KQFNPnK/5uNVep
         LTtBDcnXsHIVSrADCVx+4yta8FpH+PkCig9gmFKdf4qrk96ingP7fcKFr8UMuaPOFnj9
         uTKrXD8A6JAKY+YnfVaIAptPP5vny9wcGl6chP6m6hnidRGnqIw/maveCoVRsiuk0xd9
         ZsiNIhNI/HYlRX/ask63CrJfm/+z+f38xoawOky9vnZVzArWjVBxfDT58Dgw/RR4XLCU
         OIIQ==
X-Gm-Message-State: AOJu0Yyp+52d0ZQWPXpFpRJFN0BWWskJMcxm5TrrRXrkwwIToalk4yIr
	fGZ0Bi45R9PZLf9CCYCeN8w86yazmRB39apc8oTKcHQzOZgE5KIgPGRAP/VJaABH6lURvmcp6uM
	6TEBXTnA=
X-Gm-Gg: AfdE7ckaoLQjCr0r1+3R4sZ4sDG+cSRltSAAHkiEoghKtJ0nW/5lHxDYhfiatKfo45Q
	NmrPzJftUVNG1U7QVKWPPjJZDxOftUNQ1MlPj+tUoS8r1cefWu/hS49B5zsXEhSf0lKnrPHuJkI
	MFb6wlN/GZSsu5Xd4XU5bFIKh9qfpxstVJr+bKXhDBp0fbiEt5To2GFuTOUdcm+7Vsr7dnsPdVR
	2jci6Eaq3SRHOTugAqyOzPW6LQFEj57TwfogNhireCJ7qM0yGMVuDDhLelO4gXaDuRUcJBN+gTA
	KpBm7GZ3iwAuCCtsyl76LlAnC3pOfehzFHzzjOeoNufQwdpF0Rf3Hc+qjGRbJBJ3QYKO33Wmffr
	Jf07Hv+2t2alBUBfl8lNodAuiZgYQsfLlQCbUYvQsD/boZxCiNxSAc/o9nYB95rrcQK5agxV0Ve
	hYAFD3+aMMDmfp9NLPDUVFmxuALF7SsGCzZCMRklwsenaO3y+FTg==
X-Received: by 2002:a05:600c:3b91:b0:490:c6c2:52 with SMTP id 5b1f17b1804b1-4954a3d0065mr192195215e9.3.1784554084438;
        Mon, 20 Jul 2026 06:28:04 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:fc6c:f9a2:4a0a:6354? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63ec7ea1sm30908170f8f.24.2026.07.20.06.28.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 06:28:04 -0700 (PDT)
Message-ID: <36453665-f4f6-44c6-8e89-e73297df9dad@suse.com>
Date: Mon, 20 Jul 2026 15:28:03 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] module/dups: Fix use-after-free in kmod_dup_req
 lifetime handling
To: sashiko-reviews@lists.linux.dev
Cc: linux-modules@vger.kernel.org
References: <20260720121621.750661-1-petr.pavlu@suse.com>
 <20260720121621.750661-2-petr.pavlu@suse.com>
 <20260720123244.EDE231F000E9@smtp.kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260720123244.EDE231F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/20/26 2:32 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Critical] A pre-existing use-after-free exists in `kmod_dup_request_complete()` due to `kmod_dup_request_announce()` queuing `complete_work` without holding a reference.
> --
> 
> --- Patch [1]: [PATCH 1/5] module/dups: Fix use-after-free in kmod_dup_req lifetime handling ---
> commit c16274209ebc300f334c8ae6c8a5bec3494aa562
> Author: Petr Pavlu <petr.pavlu@suse.com>
> 
> module/dups: Fix use-after-free in kmod_dup_req lifetime handling
> 
> The kmod dups code uses RCU to ensure that a kmod_dup_req instance is freed
> only after it is no longer referenced. When releasing an instance, the
> kmod_dup_request_delete() function removes the kmod_dup_req from the
> dup_kmod_reqs list, waits via synchronize_rcu() and finally frees it.
> However, this doesn't work correctly because parallel users referencing the
> instance in kmod_dup_request_exists_wait() don't enter an RCU read-side
> critical section. This can result in a use-after-free.
> 
> Fix the issue by changing the lifecycle management of kmod_dup_req to use
> reference counting.
> 
>> diff --git a/kernel/module/dups.c b/kernel/module/dups.c
>> index 1d720a5311ba0..e1828e865edde 100644
>> --- a/kernel/module/dups.c
>> +++ b/kernel/module/dups.c
> 
> [ ... ]
> 
>> @@ -224,6 +241,10 @@ void kmod_dup_request_announce(char *module_name, int ret)
>>  
>>  	mutex_lock(&kmod_dup_mutex);
>>  
>> +	/*
>> +	 * Find the entry previously added in kmod_dup_request_exists_wait()
>> +	 * that is owned by the current task.
>> +	 */
>>  	kmod_req = kmod_dup_request_lookup(module_name);
>>  	if (!kmod_req)
>>  		goto out;
> 
> [Severity: Critical]
> This is a pre-existing issue, but is there still a use-after-free risk for
> complete_work even with the refcounting switch?
> 
> Looking further down in kmod_dup_request_announce(), it queues the
> asynchronous work item without incrementing the object's reference count:
> 
> 	queue_work(system_dfl_wq, &kmod_req->complete_work);
> 
> Because no reference is held for the work item, kmod_req could be freed by
> delete_work before kmod_dup_request_complete() finishes executing.
> 
> When the work executes in kmod_dup_request_complete() and dereferences
> kmod_req to call complete_all(&kmod_req->first_req_done), this could access
> freed memory.
> 
> Can concurrent auto-loads trigger this? For instance, if multiple tasks
> execute __request_module() concurrently:
> 
> Task 1 (wait=false)                 Task 2 (wait=true)
> kmod_dup_request_announce()
>   queue_work(complete_work)
>                                     kmod_dup_request_announce()
>                                       queue_work(complete_work)
> 
> Could the second complete_work execution be queued just before the 60-second
> timer expires, and run right after delete_work frees the object?
> 

I agree. The code has an issue when two concurrent request_module() are
active, one using wait=true and the other wait=false. When the
wait=false call wins and announces the result via
kmod_dup_request_announce(), it can complete the kmod_dup_req object
allocated by the wait=true call, which can later result in
a use-after-free.

Sashiko also reported the same issue in a reply to patch #2.

-- Petr
