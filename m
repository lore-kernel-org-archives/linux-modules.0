Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795101031;
	b=wHyjiW0xQDKf5jj2EcMq8hLV6SKYAEAmZbhhHa/cXTE02j3gfJ8XCPB6Uz2YIDSmubnB
	 c+b+YbPgjTYgKovKaChbXdHg5gqPMuYefwQl0i/KkY1cgE8bxWry4FFjW060oP1jPDpmo
	 iQx2mJ18sF7K2baSNUtBgaJTOw7PiKJJykUPCa6It1hQv78pqRI2a1uIHtBZApMcwq7pH
	 TfCq4Y8f7A8VA1ZWIwTDh/3pB20QOJtXRx87MvmU9wA8p2Ha5D9fLwr3KdhC39KGczihz
	 mSD9wIHi/9Z+L9JsUPwY9T0AMi13iiON0jcIKP/kAe9mW+do/clQq0rmOYqeGSg+f5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795101031;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=2PmdBMJLldvL6rUsB8Z9mUP9W+rlN8TqadiI6ssq/LU=;
	b=Y7bNJE5U1woSdCuoJoZoN99ORDg99aIpy8FLf/aTIm3jL4j1zh9CBXGe8znxRJHsA3A2
	 3/5sdQHIQ3oQP0WKQLe5tRXg+/+EnYH3L8O0YwYoiXyFNw+if9Heuif9KrM9VQ1ntxqiS
	 P6cEri7bVmEujnrRCeMnVxqBW8oDcozzYGMgpqtp1mreMdKOHvSe3kwnwU2rmbQ5CUHtZ
	 cFdCMW3131ZgQPw5XGLzhQ2D0s6s6ViIUYL0ySCc9U6r9QieouwXNmKlzREnpSk85apdg
	 hObiFWSjL9xNu13/X5lS/ySZg8/I37Y3wsGP7dJsBNi9OA/lXwAGnFI9uy8sN6N+9vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=TQGnfAoe;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11ACE606A326
	for <linux-modules@vger.kernel.org>; Thu, 19 Nov 2026 15:10:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11ACE606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=TQGnfAoe
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a14so24231825e9.1
        for <linux-modules@vger.kernel.org>; Thu, 19 Nov 2026 07:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795101029; x=1795705829; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2PmdBMJLldvL6rUsB8Z9mUP9W+rlN8TqadiI6ssq/LU=;
        b=TQGnfAoemqxFHDALlcUveefKoG/0tcoTDR+TGhWnyoTN/EKmCR5hRqxQXcBZafh2xV
         cq3oc256os0z75BQ1cx006iBr/ioAIUJTEUe2v2x+Bke35VhG4MjdmPuKFmIr3k2bPua
         OV7oRdd73ZxpmDPIjSPe454c3o/yE7RWnAwOM6W5ue0rTSK3QhgmqQ9tcOl1bu8UmvmO
         cFQAemajzrKm0PVS7nx5CJMAoEwnftQ76BIl0dnFkaB1i96mffwU6dujbMJjS1IG6wmo
         anlSgxomoKcUyzH2CHJ7hNrXcwUwFok5/LMktwU4erMk88IveqgbVSM3QG5OGV4AHHZ/
         rCtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795101029; x=1795705829;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2PmdBMJLldvL6rUsB8Z9mUP9W+rlN8TqadiI6ssq/LU=;
        b=Qsek5UsxJrZ8esSXMkez9pznrRDENGGyHxyfmWfd7QtvKV1+5IOJaFCO3bgpPMzpNE
         6UErJBj/Vu99vC7zw4XwOwm1i8K8uTmkRkAmytrUfo0WwLvQKOnwatNoehzjrJEfKVpg
         TtL0mAdM6cs7p0NCJjWxRiCYhKSC5FgDMI9x39R8wQGOkxC/HjrSLvodB22GF2GbZSod
         KjqBi/9MMYHXocX3CpOUVsXmWQhlwv2LeObfFcVgTnvocbQd2yOFPoigI4l6nYCn1KFZ
         1kWaYD827z/d16TpPnQkkHVcLQnR6MGCMZnJ5N6gTMAF90HUvIjN2ByFH8N0Lw4WLnEr
         tMMw==
X-Gm-Message-State: APuU4Z+K5BePg+NFniDMTz/2J/AU6i6JyNKlcts0dSJMXLfTVmfvJ2PQ
	Nf8ADwumw6sSB50952zpn62SzG8shsJA/aVIi+vX9MTkiP/bK5bcNmWq80IicCQIVElTPKD5mih
	/S9RcNb4=
X-Gm-Gg: AYBFou3tv5OZ98ds0XKa+ocdPtk764+ODJaZhw4Ya2FNv7A5wth1UK2e9Jrti0UnOOm
	0Hwc5/zdUMYHGmBpsFzem8Vk8jlewF9IlqcOyfsNXRWtPh8yDa8Hl/YQg3tP7rfyblsrZ1JQazO
	5oYG0+REW3haWzjZTI4nQivduvhg3FglEMl9iyecfa6mRQ7OiTjXUxjmuKGqCkN+V11mDxl7zVC
	BuT8G8UXmCeFsPlKDRSmkuAS3B01Y98to+T0nFBV36VMBDDWsmq9Lf80PTECcyWZwETCnSJRXSW
	ZG4gj6YfY9/B+w8MUnmjWncSY3M0NgoHM/JBYFZmSIYd9igWHI5D+zQ32Gyu1yj8RVpU/r3owrB
	Tlk40Z6TqulCTKIYzQUag8TtyrlS3tU21Jg4REY28uQ1KvFH1yCnRo6ozNvPwc7c1NTxW6NPFJb
	ItUtP7b827+4+3Ggo2Z5Vr80beJKQYwbpPmhtBHdijbuhsmSWESXm2YuvyrYQIz0qEJ2X6YdCk1
	emwqZvaG8DSblkw+Tk6Hy1taOybs7vUf9k2rdCWOtn4ZzfnfCjlS5/G1gKYY0pScaGuFjonOrxC
	osKYdmaOnM1sgKG9mhLILJpZYVW4Jw7EzZINjaGCfQ9xkAfzkM0an57N+H4YgjR/wg==
X-Received: by 2002:a05:600c:34d2:b0:4a1:6992:f861 with SMTP id 5b1f17b1804b1-4bb7d6d1f21mr128058615e9.1.1795101028949;
        Thu, 19 Nov 2026 07:10:28 -0800 (PST)
Received: from ?IPV6:2a07:de40:8100:0:89a9:fd0e:583d:4a53? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884b7515sm4229285e9.13.2026.11.19.07.10.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 07:10:28 -0800 (PST)
Message-ID: <2344f228-f6fe-4b18-9587-53063f93de50@suse.com>
Date: Thu, 19 Nov 2026 16:10:28 +0100
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
Subject: Re: [PATCH 2/3] module: Fix data race on mod_unload_taint::count
To: sashiko-reviews@lists.linux.dev
Cc: linux-modules@vger.kernel.org
References: <20261020-taint-unload-v1-0-d1c764889afc@suse.com>
 <20261020-taint-unload-v1-2-d1c764889afc@suse.com>
 <sashiko-outbox-179099@kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <sashiko-outbox-179099@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/26 4:13 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] module: data race and uninitialized read of count in try_add_tainted_module()
> --
> 
> commit 742b3a34fee074246edb757213ccfc148f6e7300
> Author: Petr Pavlu <petr.pavlu@suse.com>
> 
> module: Fix data race on mod_unload_taint::count
> 
> This commit fixes a data race on mod_unload_taint::count between updates
> serialized by module_mutex and concurrent RCU readers by changing the
> field to unsigned int and using WRITE_ONCE()/READ_ONCE() accesses.
> 
>> diff --git a/kernel/module/internal.h b/kernel/module/internal.h
>> index 061161cc79d90..70ef20b97c84a 100644
>> --- a/kernel/module/internal.h
>> +++ b/kernel/module/internal.h
>> @@ -257,7 +257,13 @@ struct mod_unload_taint {
>>  	struct list_head list;
>>  	char name[MODULE_NAME_LEN];
>>  	unsigned long taints;
>> -	u64 count;
>> +
>> +	/*
>> +	 * Number of times a module with this name and taint combination has
>> +	 * been unloaded. Updates are serialized by module_mutex and use
>> +	 * WRITE_ONCE(). Readers that may run concurrently use READ_ONCE().
>> +	 */
>> +	unsigned int count;
>>  };
>>  
>>  int try_add_tainted_module(struct module *mod);
>> diff --git a/kernel/module/tracking.c b/kernel/module/tracking.c
>> index 5bcd1c2701f07..873fceb305268 100644
>> --- a/kernel/module/tracking.c
>> +++ b/kernel/module/tracking.c
>> @@ -28,7 +28,10 @@ int try_add_tainted_module(struct module *mod)
>>  				lockdep_is_held(&module_mutex)) {
>>  		if (!strcmp(mod_taint->name, mod->name) &&
>>  		    mod_taint->taints == mod->taints) {
>> -			mod_taint->count++;
>> +			unsigned int count = mod_taint->count;
>> +
>> +			if (count != UINT_MAX)
>> +				WRITE_ONCE(mod_taint->count, count + 1);
>>  			goto out;
>>  		}
>>  	}
> 
> [Severity: Medium]
> Does try_add_tainted_module() in kernel/module/tracking.c still have a
> data race and potential uninitialized read on mod_taint->count when
> allocating a new entry?
> 
> Further down in try_add_tainted_module(), a newly allocated entry is
> published via list_add_rcu() before mod_taint->count is initialized:
> 
> 	mod_taint = kmalloc_obj(*mod_taint);
> 	if (unlikely(!mod_taint))
> 		return -ENOMEM;
> 	strscpy(mod_taint->name, mod->name, MODULE_NAME_LEN);
> 	mod_taint->taints = mod->taints;
> 	list_add_rcu(&mod_taint->list, &unloaded_tainted_modules);
> 	mod_taint->count = 1;
> 
> Because kmalloc_obj() does not zero-initialize the allocation and
> list_add_rcu() publishes the entry to unloaded_tainted_modules first,
> concurrent RCU readers in print_unloaded_tainted_modules() or
> unloaded_tainted_modules_seq_show() can observe mod_taint and execute
> READ_ONCE(mod_taint->count) while mod_taint->count still contains
> uninitialized slab memory, or race with the plain store setting it to 1.
> 
> Should mod_taint->count = 1 be initialized before calling list_add_rcu()?

This issue was addressed separately in commit 7a5c13cfdfcb ("module: Fix
uninitialized count read of unloaded taint tracking record") [1].

[1] https://git.kernel.org/torvalds/c/7a5c13cfdfcb1871050fdbe00ac223993f8925fa
