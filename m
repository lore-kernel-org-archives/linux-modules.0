Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2085348BD54
	for <linux-modules@vger.kernel.org>; Mon,  7 Sep 2026 12:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788783429; cv=none; b=CiG7re9R7f3M0GacQ0KZC+ywiu7P6y/acPPou8ZCvMAvQt5XnZ/4SvrYmrjzVAkPBB9YWyiwfY86ig0C8xxBsR5Tkfy/jCpZSt4woSR7Go/R6WXrS605aX72bszMubCQ5NxbSz/Lwexbhh8qfJC7tY38/2kovWk0kqiPOK+iF6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788783429; c=relaxed/simple;
	bh=P1JBUR6CrlGFBWEniY71OOu6dzdkNKM92VZKep2iisw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KBzP3PaB/oz+BZiVjCiSknVwAy4CGa3QMpaGT41JZ3lfUpmqZc9UF2gLN6XnBDnb0q53enuFf6J7uOhdY++MILO45WMET1mpdyt/ua5QejAT3GvzAxigCtO+ckCBqsjfssnMxivVAMnugxt0l4u0D3OiohO496PR3Tb4cQjcWFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Gj6eZkc7; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Gj6eZkc7"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-495590dde14so50035285e9.0
        for <linux-modules@vger.kernel.org>; Mon, 07 Sep 2026 05:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1788783425; x=1789388225; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jn0w3wd9DpGVfALSA66dfRIXO28kzDp/Jqd8OQTEmq8=;
        b=Gj6eZkc7F1sKQn7n5+d5fwVOYBvO8I67EfMKarBAZvt3C2JyaWqLSvttT9T5YhjygA
         GkCqtg2kG9F2ZQXQfq4tPgcaHa7adhPgLwt+j+8ZL4zkGnHjJ4gE7SDfbAhPF5lBLfgX
         ncnVzItqK5RD7F9nCEzWpUrNPqbjMiD9j0Y3A6A5F2xsVoLzAHFypao8W7q1g2ZDZ1EW
         5WU4+JV4dIfiSCIj5ZPgxi37PxyXSk8zrCdQSCArUrjkrf0HHCRgcJ7kX6pWvX9F9AJF
         M3Ajo59K8/MZw2rs8UXWwNFfZ5YxZ5oezeiB0OuZv8dmWnScfG7SofO1AoyLF2VMV/aG
         8p1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788783425; x=1789388225;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jn0w3wd9DpGVfALSA66dfRIXO28kzDp/Jqd8OQTEmq8=;
        b=kHh/ao0ufUkRnV9xPMEpfK4MnBeQY9iwbFtNN6o0UPQAz5GS3m+oyK2APsOUP379XH
         ICY9NHUNwwAROL0PSbJ+XxeptnI+xlEGg31TFt2vfBybvh7km/pS8Xs5g5j8TOkrQw30
         XOeUzxmZ/dsLSQrxHnJTB4g/1lbFf0zvDpTwJCRuK8UxKKNpAd/Vwxp3ZdNOrMdV6LnA
         rBOdMtuJ1mU3Ug37i9cfkILbcfjIqFklSdw6bAZLgM1UhE7Nv8/C2NKaADaPtbfJzDhD
         G6pLi2lE3Px++DCBumqV6N/oG7jxKNPa7OdG52UN+v+fEiUykCLsOWImPoCbMXRFWbxq
         zp9Q==
X-Gm-Message-State: AFuF++lChvfaNSgvIcSBUkVj9176ZnG5VM/T+KJmvN1wrRyiA3t7WXA7
	a8FDx5jXUi68aol5C++FGVSm5a2R/tznHhuPlbB1XIdTJYuayJtBzB6KtLSRbzLdkVU=
X-Gm-Gg: AYBFou25QLWwmeLqlVS4hq2FFkerOnuiowmh2GXZbCbJXwql5ShiJqzH6n+4GlwYaan
	G5U6vzqHeJ9SpqwsnhSKuSogelA50JNwgwwTw7pym4FJBkgemZVw0ESj8UGx2WNLsl4WNet1hmF
	WmMPZ05Ueol/HtJ16Yj5di7B1QBgZKDVG3RPZF6TTLWR49eVJ1L86juwYA+nsM1yS/w5+tu69B5
	BGpZU9LLEE0g6Cm84NvC61Ppkrakn0cgly9VpUwSOVQHtXTzN79lbiNxgGON1XGok5Zr52Jfj0I
	ZFFr+ERQX9dHaOS51LSIzm32/hXIntdNUOYsvRki7LyycFgKc/NdvFBa3IBMTnt1ul6FDxj9Zt2
	JIm9jkMrvDtuqAdQMjLjWkFg5rtnKVt4LnXofMWAZtlJKj7NXFITmzVDqDMyxHr73BYmUCePC58
	qwsJUWFlYQg8BL/1wEXLIcgKmh237EHgJK4cylMOvCATIwLxyBoKVA5nhI/D7YxVYyyEa42vB8X
	bZGGdmstEXMt5TrX9rzmRvJ
X-Received: by 2002:a05:600c:4ecc:b0:49d:870:7a69 with SMTP id 5b1f17b1804b1-49d08707aafmr181610255e9.12.1788783425050;
        Mon, 07 Sep 2026 05:17:05 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:89a9:fd0e:583d:4a53? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf5135353sm271556005e9.2.2026.09.07.05.17.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 05:17:04 -0700 (PDT)
Message-ID: <534b9178-068f-4808-8ed3-e989dee2be0f@suse.com>
Date: Mon, 7 Sep 2026 14:17:03 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/4] module: introduce SH_ENTSIZE_STANDALONE for
 separately allocated sections
To: Hao Ge <hao.ge@linux.dev>, Suren Baghdasaryan <surenb@google.com>
Cc: linux-modules@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Sashiko <sashiko-bot@kernel.org>
References: <20260902081802.146145-1-hao.ge@linux.dev>
 <20260902081802.146145-3-hao.ge@linux.dev>
 <20260902083338.706451F000E9@smtp.kernel.org>
 <cf829450-497f-4456-b229-3387fa24b177@linux.dev>
 <48658d4c-4920-40ba-afbf-65400dffc863@suse.com>
 <100a9358-1c7b-4f08-a5d2-072362aea492@linux.dev>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <100a9358-1c7b-4f08-a5d2-072362aea492@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/7/26 8:10 AM, Hao Ge wrote:
> Hi Petr
> 
> On 2026/9/4 23:25, Petr Pavlu wrote:
>> On 9/3/26 8:00 AM, Hao Ge wrote:
>>> Hi Petr and Suren
>>>
>>> On 2026/9/2 16:33, sashiko-bot@kernel.org wrote:
>>>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>>>> - [Medium] The `.data..percpu` section is incorrectly exported in sysfs with a dangling pointer to a freed temporary buffer.
>>>> --
>>>>
>>>> commit 5082dc654c1b8850af405eef473b249c0d936de9
>>>> Author: Hao Ge <hao.ge@linux.dev>
>>>>
>>>> module: introduce SH_ENTSIZE_STANDALONE for separately allocated sections
>>>>
>>>> This commit introduces a new marker, SH_ENTSIZE_STANDALONE, to indicate
>>>> sections with a separate allocation. Instead of clearing the SHF_ALLOC
>>>> flag, it utilizes sh_entsize so that sections with separate allocations
>>>> like the percpu section can be correctly skipped during layout.
>>>>
>>>> Link: https://lore.kernel.org/all/499bb60c-c6e3-43a3-bd92-95a0567ece5e@suse.com/
>>>>
>>>>> diff --git a/kernel/module/main.c b/kernel/module/main.c
>>>>> index d0e1e0bd2ad06..b114b815187a9 100644
>>>>> --- a/kernel/module/main.c
>>>>> +++ b/kernel/module/main.c
>>>> [ ... ]
>>>>> @@ -2822,7 +2810,8 @@ static int move_module(struct module *mod, struct load_info *info)
>>>>>  		Elf_Shdr *shdr = &info->sechdrs[i];
>>>>>  		const char *sname;
>>>>>  
>>>>> -		if (!(shdr->sh_flags & SHF_ALLOC))
>>>>> +		if (!(shdr->sh_flags & SHF_ALLOC)
>>>>> +		    || shdr->sh_entsize == SH_ENTSIZE_STANDALONE)
>>>>>  			continue;
>>>>>  
>>>>>  		sname = info->secstrings + shdr->sh_name;
>>>> [ ... ]
>>>>> @@ -2967,8 +2957,13 @@ static struct module *layout_and_allocate(struct load_info *info, int flags)
>>>>>  	if (err < 0)
>>>>>  		return ERR_PTR(err);
>>>>>  
>>>>> +	/* Repurpose sh_entsize to track where each section is allocated. */
>>>>> +	for (i = 0; i < info->hdr->e_shnum; i++)
>>>>> +		info->sechdrs[i].sh_entsize = ~0UL;
>>>>> +
>>>>>  	/* We will do a special allocation for per-cpu sections later. */
>>>>> -	info->sechdrs[info->index.pcpu].sh_flags &= ~(unsigned long)SHF_ALLOC;
>>>>> +	if (info->index.pcpu)
>>>>> +		info->sechdrs[info->index.pcpu].sh_entsize = SH_ENTSIZE_STANDALONE;
>>>>>  
>>>>>  	/*
>>>>>  	 * Mark relevant sections as SHF_RO_AFTER_INIT so layout_sections() can
>>>>
>>>> [Severity: Medium]
>>>> Because SHF_ALLOC is no longer cleared here, does this cause the
>>>> .data..percpu section to be incorrectly exported via sysfs?
>>>>
>>>> With SHF_ALLOC remaining intact, sect_empty() in kernel/module/sysfs.c now
>>>> returns false for the percpu section, causing it to be processed instead of
>>>> skipped.
>>>>
>>>> Additionally, because move_module() explicitly skips sections marked with
>>>> SH_ENTSIZE_STANDALONE, the sh_addr is never updated to the final allocated
>>>> memory.
>>>>
>>>> This means when add_sect_attrs() exports the section:
>>>>
>>>> kernel/module/sysfs.c:add_sect_attrs() {
>>>>     ...
>>>> 	if (sect_empty(sec))
>>>> 		continue;
>>>>     ...
>>>> 	sattr->private = (void *)sec->sh_addr;
>>>>     ...
>>>> }
>>>>
>>>> Will sattr->private end up storing an unmodified sh_addr pointing to the
>>>> freed temporary load_info buffer (info->hdr)?
>>>>
>>>> This appears to leak a stale vmalloc pointer address to userspace when
>>>> reading the sysfs file for the section.
>>>>
>>> Yes, Sashiko is correct. The fix is just one line after percpu_modcopy():
>>>
>>> info->sechdrs[info->index.pcpu].sh_addr = (unsigned long)mod_percpu(mod); 
>>
>> mod_percpu() (mod->percpu) isn't really the execution address of the
>> .data..percpu section. That section in the ELF file is only a template
>> to initialize the individual per-CPU variable areas.
>>
> 
> Yes, I used mod_percpu() to stay consistent with /proc/kallsyms.

That's a good point. /proc/kallsyms directly shows the st_value of each
symbol. For per-CPU symbols in modules, that is mod->percpu+offset.
I wonder whether it possible to make any use of such an address unless
one also knows the per_cpu_offset() mapping.

However, maybe it is really simpler not to export .data..percpu under
/sys/module/*/sections/, rather than trying to determine what address it
should provide.

-- 
Thanks,
Petr
