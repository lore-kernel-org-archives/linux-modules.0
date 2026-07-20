Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CF5418A58
	for <linux-modules@vger.kernel.org>; Mon, 20 Jul 2026 13:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784554130; cv=none; b=nAGyQmkwrzHGKDK5YvUouPXLRtJikqD06hyLVBUGwBpJB14LyNHpfI4fEuFJNM1R2un4qQeEHdA4Wf06e/IMsAaGcLlBfdYqD4wF4E784VRYIeL6Oti6s9OB1L/ipaNPBuGXWyTH2kYPaL9Vv7ZdXrcnXyKwZLMZxQpO9N43nmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784554130; c=relaxed/simple;
	bh=a1dT4T2rg25BuLqB3IXHvcJ/DhyM0LaFghciO/e5KnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V8NAS1LaYt2n570rLr7hsoQFfGAAu9LZ0zdDVxkJhwDO8X6MpEYJC0eOSebiciXfeLEAOZw3XjGVHrKnOH8rNDnNLUJrevrR4UPAn6w2dUqQ+sWzVtDhJW7PNz6/qvB4z/p0kKeAWcPkUSbUy36D8fjICUMKlzdfqogJRjAjxFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=etkG0Zr3; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="etkG0Zr3"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4953e04ef16so43176855e9.2
        for <linux-modules@vger.kernel.org>; Mon, 20 Jul 2026 06:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784554127; x=1785158927; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6/czDj3io+OIqwlJnYUmkw5KpDAkmwxo4+tPoyggzt8=;
        b=etkG0Zr31NfBlQDZqcy0sJMwennnyMil44DbN/z69ZgH/WCZ1QN0nYi8dE3OJO4etk
         T0jBz4BoSbxQaHaIFqtE5ok+0z8Sj0RDrKmz8LQXZ5+bN7LV/Mcvm5a9fWu2yYVXElnN
         XSin5OYiNzzckpjlhFA9AkWH/1vJIlZRql3t0wU0FK1ElisQx1cOSUf+3Da/gW+vxxBU
         LRmLl+oTIWq47dyijmfipjHNkvgK1mimlZQXUSm8ZCrlpIVr+y1fvlt0RvFpX51mv5ag
         vj6c1LIPbPrtVUpSE8uhDAFQjo5xYfjZWm+CNByF4uTDVPDQ1iMBgfKgvW1CI2ScqdyB
         eMbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784554127; x=1785158927;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6/czDj3io+OIqwlJnYUmkw5KpDAkmwxo4+tPoyggzt8=;
        b=rKrH7vX9BLf7SJpmcDlNqxfmRGr3JTq0yJcSc2ZOp2eKMOjLTnLTH1bVmjXc/ObSlx
         UcD1WgRucwESN5X9S2FoQ4aQGqdt3jAWv7u4yqs6LHlg4oxAN8lYb8mf0uKkD7Humj8L
         yI2rtHrMQAfLT3Ey3QrzDRYKC/QOJvmHfMF2zi5V6WcdOkydebOaIrpGk95Tvy/MwBN7
         JeR3D+4LSDui/m57ROc7WbfY1BybGJTdnDQbuOyMhptBohg6DaLWyeH6oWO8BJmm5rz8
         dbTqlx9NYYnrUkdsIO0ZVU8Z7HSIjiQtuuEufo7/QFP+tCSnZP3l2Y/4F4S87XE+vFZ2
         BtSw==
X-Gm-Message-State: AOJu0Yw7JOW9srba5aVPlgYZSO8tv2KAeL0pJV+kvkuBfSZY0Hdp+z76
	stOwVruy01vJjOJuFli+RBGe6t8IuRwbuExbmUt0eaGLFVZKGwC+kX3d16Ag269Jl5yLUwIioRM
	AsyX3sik=
X-Gm-Gg: AfdE7ckrQu53jou+tHV56896pQohNA++MWt9aXcpKI19kOgfL5BQSxfSqcobNYgWlai
	K5ohsx6WAONCPL39D+RaQ7C0h3ZTV1in1SneYY9SKOkJ0IFtDojiiLnzIXB1ZzIq7adFL770HUA
	tQmlBqLG+4CxT2bkvZ23dO9QX5qENll/2891+kuzLf+mH/FmrYps7DWbW+WEprki9d8KJrI4L6R
	SO9sHlwDLj2fyZ2mcXgEho9BtzL594ECYAi8yxRuwRZnkPy9kdteXuBihRrGgs2qpCeUXPBBbr/
	K3v8jdRWRqNNMNbyOnJQDpT519beScGC5f5iZJkkDH8a0ag2rPXWcd4vjKUKF6tXYJc8Z/kGpJJ
	COK8LDIhElUGbBha8LKaB0caVVqY1zXobm1YuLxoaXkerGZcD9RUIfr2ocu1hLg5txgvrmibCZg
	n2Xk55Y3Z7aNFJI0gmjTtejZALyrZN16VVFUN3mehsTQOOBa7I4A==
X-Received: by 2002:a05:600c:4505:b0:493:f176:dc69 with SMTP id 5b1f17b1804b1-4954a413087mr149688055e9.37.1784554127449;
        Mon, 20 Jul 2026 06:28:47 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:fc6c:f9a2:4a0a:6354? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63eeece9sm28679042f8f.37.2026.07.20.06.28.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 06:28:47 -0700 (PDT)
Message-ID: <e4087c28-c79e-4261-8881-68034fada860@suse.com>
Date: Mon, 20 Jul 2026 15:28:46 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] module/dups: Use scoped guards for kmod_dup_mutex
To: sashiko-reviews@lists.linux.dev
Cc: linux-modules@vger.kernel.org
References: <20260720121621.750661-1-petr.pavlu@suse.com>
 <20260720121621.750661-4-petr.pavlu@suse.com>
 <20260720122533.1F9661F00A3A@smtp.kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260720122533.1F9661F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/20/26 2:25 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Mixing goto-based cleanup labels with scope-based cleanup (scoped_guard) in the same function.
> --
> 
> --- Patch [3]: [PATCH 3/5] module/dups: Use scoped guards for kmod_dup_mutex ---
> commit 3299ca2ac8ae46392f412ae7c186f4907e7f8201
> Author: Petr Pavlu <petr.pavlu@suse.com>
> 
> module/dups: Use scoped guards for kmod_dup_mutex
> 
> This patch replaces explicit mutex_lock/unlock calls for kmod_dup_mutex
> with scoped_guard to shorten the code and clarify the lock's scope.
> 
>> diff --git a/kernel/module/dups.c b/kernel/module/dups.c
>> index f0bdd7560d7e7..a62619ec057ed 100644
>> --- a/kernel/module/dups.c
>> +++ b/kernel/module/dups.c
> 
> [ ... ]
> 
>> @@ -122,10 +121,13 @@ bool kmod_dup_request_exists_wait(char *module_name, bool wait, int *dup_ret)
>>  	INIT_DELAYED_WORK(&new_kmod_req->delete_work, kmod_dup_request_delete);
>>  	init_completion(&new_kmod_req->first_req_done);
>>  
>> -	mutex_lock(&kmod_dup_mutex);
>> +	scoped_guard(mutex, &kmod_dup_mutex) {
>> +		kmod_req = kmod_dup_request_lookup(module_name);
>> +		if (kmod_req) {
>> +			get_kmod_req(kmod_req);
>> +			goto dup_req;
>> +		}
>>  
>> -	kmod_req = kmod_dup_request_lookup(module_name);
>> -	if (!kmod_req) {
> 
> [Severity: Low]
> Does this mix scope-based cleanup with goto-based cleanup in the same
> function?
> 
> Looking further down in kmod_dup_request_exists_wait(), there are still
> several goto statements that jump to an out label for manual cleanup:
> 
> 	if (!wait) {
> 		/* ... */
> 		*dup_ret = 0;
> 		goto out;
> 	}
> 	
> 	ret = wait_for_completion_state(&kmod_req->first_req_done,
> 					TASK_KILLABLE);
> 	if (ret) {
> 		*dup_ret = ret;
> 		goto out;
> 	}
> 
> 	*dup_ret = kmod_req->dup_ret;
> 
> out:
> 	put_kmod_req(kmod_req);
> 	return true;
> 
> According to include/linux/cleanup.h, the expectation is that usage of
> "goto" and cleanup helpers is never mixed in the same function. All resources 
> that need a "goto" cleanup should either be converted to scope-based cleanup, 
> or none of them should.
> 
> Should put_kmod_req() be converted to use scope-based cleanup as well, or 
> should this function avoid using scoped_guard() to keep the cleanup pattern
> consistent?
> 

Fair, I'll clean this up.

Sashiko also reported the same issue in a reply to patch #5.

-- Petr
