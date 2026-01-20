Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2E744BC87
	for <linux-modules@vger.kernel.org>; Tue, 20 Jan 2026 17:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768931330; cv=none; b=Y3+egkdwUbpicEmklXB6fdA8N4OD684miREnxtZDeI67XoFi2+D+Zl71zpn1/sWemprgTaSFq3W7bvrCSVbKGSosm/cnouXLjvwQ6CXDnjW49A2FGUfqgM6zi+Zg8i8rflLxgeTx/8x4uL3NtEC4DCYrCj7XI0vMu819kxg8BwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768931330; c=relaxed/simple;
	bh=p9HBvfleLKD9Mm3BCduxT+gNH4pFHTcfkAq3YRn3pp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EIkP37IAGn9hKKWN0XB5axr9Xfbg/je3KRJNrvr18Jtx2ab/hv4+mRwW0b+/5wUSQQRboxMKwMM3OuMT0yGryah/PTNwIT4iGJ8au1VixUeH6C/KkbTOf3Otn7pNBwomti2W2sBu65taWCFnzem4EFzTtD+4CYZz+d8eCo/Oj7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KUuGFci/; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KUuGFci/"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47d59da3d81so650975e9.0
        for <linux-modules@vger.kernel.org>; Tue, 20 Jan 2026 09:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768931327; x=1769536127; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y4NQyrvOF1Xb3Li7xprOo6Y0AJeuh4LSApnAookisqA=;
        b=KUuGFci/SfOQDNHrWq2dsSTPS0XRYjIjmHf8qMs6vJwl3MY3CWakxBmxUje8FjsVpg
         yG4H8k1QhpFgw4bD/CkpO8aZq9oG6ade6RBkbE2Z82w7Ldnn9GH/SOp5wF4i+Dpfu4ei
         IB6+nWOq2X0SCMnUHzYlgHrcPJ28P7cXAvsiH/2nUkFT62QOWoAl4TpxBCL3kT8dcVIv
         TpYUulhf6DELnQHfiUf/Ef3t4q9qj+7O/dblet5N/tHDZMBP5XyLUxofETf1323m0qpS
         U1m4UyOeZVAHUwPFY/nNwauxI1/lKbok9itERNK8nv9X+eLbxwzZFjDN4OF5/iSZXBDf
         ZMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768931327; x=1769536127;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y4NQyrvOF1Xb3Li7xprOo6Y0AJeuh4LSApnAookisqA=;
        b=Y/Zt3NDJHcdnQm9FJYGSysde9XUWd4Dyp1B6sFcvxarQD3hZ6Swk1CSoog/vVwdz+m
         5CW0wfMTbkb45OEHcj7JTw1D4lemu71ELUN4TjMYjT8pTV1+CUb6BijClnCz0kyUloje
         l0Kc4G5yjgX669LoubJlqXGhwsUmh7ESH38r+TX0piP9+CJzWs81G61xXB7SdU/zTpQn
         Hxn/DIgPJ2TqQfzh74PKyoUvuBL4vqKKnN4hNzK92PdVPE2QaSV0jPMjE3SkDwdt+u5a
         gt8RTu5reFZ+/fvUXJbFySM1stGhlwHwDfz0w6CElsnca6llzea1XuBNXjdDV5OPj+7c
         fGGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhwplsnMT1eKdcIsUyTglzuxanv2mnAmyxLztf92EfJDoDsuQuH9EDrrOY/LRQ/YqCOlm8SMEZEX6K4MjJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5dYIYz0eP/3LJPcgwmX9Mc3YNgyvD+XVeUPu9/hElop+5ryfa
	jkhUlx4VKL+0USJv09UbNQnhvqHBULw9afMGf2efsoVtg6YkeVWOBFPTb4kBkERD7G8=
X-Gm-Gg: AZuq6aKioaqav+AHRyLqJt5g5K7jW5X6gOnU+UW/yERPX+hwkfYa4In7FuQ05Vnv2vz
	MJF2Jq5OkEvF/6AubPYvIK0q7OOeV1qsaf0cyO5Yzjuj/gWJMwzdgod8KD1/EMnIJJ22Y0PaZSR
	vSauQ0Y9ssgtPjnzgYDSCFfkujjeg6pae+8qStC9uqnbWZ693MVcWwjX2HarILUJlOZNUarj7Iy
	GVvYiy3mVUNPRNS/jez9Uv0wuO78ChTyfXAFJR8jilD9LHHsND60jtDDO4D5E74gqsh1qqpsXV6
	7JbCQqq1nbfktMYdSI/zEBFMwFWaU4Xq37BPVL24GcHF3LvlR647FxRHwcFxEfhSnzkjpaENE4X
	wF3rt1Qu0uKEOTiYR22zSPAMoPtc3y50L+ml2/+u8i8FVwE3GQLxc/N2SqFhuCZDwSI79PTUJo3
	SpZpwKjQY+rVrhji+d/pds0cYKLS1h1g==
X-Received: by 2002:a05:6000:4312:b0:430:f593:aa34 with SMTP id ffacd0b85a97d-434d75c15a7mr29786562f8f.17.1768931326921;
        Tue, 20 Jan 2026 09:48:46 -0800 (PST)
Received: from [10.0.1.22] (109-81-1-107.rct.o2.cz. [109.81.1.107])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356996cecasm28562475f8f.26.2026.01.20.09.48.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 09:48:46 -0800 (PST)
Message-ID: <c753a5cc-e654-433c-84be-189185182250@suse.com>
Date: Tue, 20 Jan 2026 18:48:45 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] livepatch: Fix having __klp_objects relics in
 non-livepatch modules
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Peter Zijlstra <peterz@infradead.org>, live-patching@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260114123056.2045816-1-petr.pavlu@suse.com>
 <20260114123056.2045816-2-petr.pavlu@suse.com> <aW6uCQNXj0Y7IGnz@redhat.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <aW6uCQNXj0Y7IGnz@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/19/26 11:19 PM, Joe Lawrence wrote:
> On Wed, Jan 14, 2026 at 01:29:53PM +0100, Petr Pavlu wrote:
>> The linker script scripts/module.lds.S specifies that all input
>> __klp_objects sections should be consolidated into an output section of
>> the same name, and start/stop symbols should be created to enable
>> scripts/livepatch/init.c to locate this data.
>>
>> This start/stop pattern is not ideal for modules because the symbols are
>> created even if no __klp_objects input sections are present.
>> Consequently, a dummy __klp_objects section also appears in the
>> resulting module. This unnecessarily pollutes non-livepatch modules.
>>
>> Instead, since modules are relocatable files, the usual method for
>> locating consolidated data in a module is to read its section table.
>> This approach avoids the aforementioned problem.
>>
>> The klp_modinfo already stores a copy of the entire section table with
>> the final addresses. Introduce a helper function that
>> scripts/livepatch/init.c can call to obtain the location of the
>> __klp_objects section from this data.
>>
>> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
>> ---
>>  include/linux/livepatch.h |  3 +++
>>  kernel/livepatch/core.c   | 20 ++++++++++++++++++++
>>  scripts/livepatch/init.c  | 17 ++++++-----------
>>  scripts/module.lds.S      |  7 +------
>>  4 files changed, 30 insertions(+), 17 deletions(-)
>>
>> diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
>> index 772919e8096a..ca90adbe89ed 100644
>> --- a/include/linux/livepatch.h
>> +++ b/include/linux/livepatch.h
>> @@ -175,6 +175,9 @@ int klp_enable_patch(struct klp_patch *);
>>  int klp_module_coming(struct module *mod);
>>  void klp_module_going(struct module *mod);
>>  
>> +struct klp_object_ext *klp_build_locate_init_objects(const struct module *mod,
>> +						     unsigned int *nr_objs);
>> +
>>  void klp_copy_process(struct task_struct *child);
>>  void klp_update_patch_state(struct task_struct *task);
>>  
>> diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
>> index 9917756dae46..4e0ac47b3623 100644
>> --- a/kernel/livepatch/core.c
>> +++ b/kernel/livepatch/core.c
>> @@ -1356,6 +1356,26 @@ void klp_module_going(struct module *mod)
>>  	mutex_unlock(&klp_mutex);
>>  }
>>  
>> +struct klp_object_ext *klp_build_locate_init_objects(const struct module *mod,
>> +						     unsigned int *nr_objs)
>> +{
>> +	struct klp_modinfo *info = mod->klp_info;
>> +
>> +	for (int i = 1; i < info->hdr.e_shnum; i++) {
>> +		Elf_Shdr *shdr = &info->sechdrs[i];
>> +
>> +		if (strcmp(info->secstrings + shdr->sh_name, "__klp_objects"))
>> +			continue;
>> +
> 
> Since this function is doing a string comparision to find the ELF
> section, would it make sense to open up the API by allowing to caller to
> specify the sh_name?  That would give scripts/livepatch/init.c future
> flexibility in finding similarly crafted data structures.  Disregard if
> there is already a pattern of doing it this way :)

Makes sense. I'll change the function signature to:

void *klp_locate_section_objs(const struct module *mod, const char *name, size_t object_size, unsigned int *nr_objs);

-- 
Thanks,
Petr
