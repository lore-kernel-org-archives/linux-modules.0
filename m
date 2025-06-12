Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDA4231A32
	for <linux-modules@vger.kernel.org>; Thu, 12 Jun 2025 10:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749725304; cv=none; b=pck5Xrxbau5qIb/4uu3qXCmhR7kHJwcAh61F0FL4e3ZH1+lOTgjmTYijozKLfepLhzO6kJg/QzMu25e5O5wPFJRmSpZaDgsjzUy75Ot3r66MCSnXY2fN6i7/w2M09DHpToeYkXemGxPjxUnudnYYWLO785BGPyr3PT9BaX+CLlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749725304; c=relaxed/simple;
	bh=HNDqJvbrM3YoJTFiv4uqxRukmDC/kioQTcqiuAA2cac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E++7//TjKGmdoHkKnCclSpd9S47Th6ps5RIJnJVWzGf5K7gGnBgSMIRwiZu8YiTFEpHLKCPl27OpNICxIhzKDAp8DWwhEirOi5FodmmGBSlza8DLW3ZB3aiHw0lHvK7WJZabFcIjAy9rpg9gYKf0DUMszTAOVJP/+7dKCseNHb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VKGzRxSh; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VKGzRxSh"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a54700a463so486516f8f.1
        for <linux-modules@vger.kernel.org>; Thu, 12 Jun 2025 03:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749725301; x=1750330101; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O9eVd27nL1eqHZbw4F9ds6pBpZa05pK5xdu04RGTqP0=;
        b=VKGzRxSh71/QF8p8wnUQ7PEGwC0EUpZkw7hv4LYxPDa7j4XDSOth5nk828JYDek1HH
         gyVQZfml7PkpMgWORHIN6L5J4O0dbGuWYWf3SdM6mHoN69ENGQC3uHa1nBqkq0siUJi3
         5Hs6IsYvlv41WztZIOdtoOof0W+m9AvXIw20bVXixzeqjj04ZJIbyem3HTHuXpFUoJnh
         kocp75cCpvXWbWxRNgYl83NQdPsX8kN1A8iBNUh6QUK+C0M4Q+1QUx+csaDXMRxRAGKl
         RdBq+F4t5VAEuNsA2bNtnC3/F5zoQpcYX/F46KVzSg2QMSF0mA59uuKAnBlfYLBe2uMc
         tbUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749725301; x=1750330101;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O9eVd27nL1eqHZbw4F9ds6pBpZa05pK5xdu04RGTqP0=;
        b=jdE6MbeZp0V6FynSaYed3+o56DQVGJlCypaYY2kO+B7vyJ98UR0S0UIWoM/kzFH9Zw
         iLgYeUzu8AGLUh7Of7DXeSp9OOExXDGYnb3nm8Q7gzibp+rm98arq6GIru+O2osxMcuq
         Wp92MkXB0ixoUUq5JEhEpyvbdWF3B+twOG6LJOy12I/xOAW3entDG4/Fq012djWnAw86
         f64XYPLZfTJEFiyfGczVTz9JG3CCzuucAIjeXE7qGV+Z1cvKK/wB6ZMcMkPcYoMK2gUZ
         hn2CWWLAenllzxeiQ8aW5h9qL97d8CHhGgknpV9LyBy9k3oj0OJql6xWD/yZ4E+TRo42
         WTew==
X-Forwarded-Encrypted: i=1; AJvYcCW+6xtfTTWEVkS4XG+X5j/66rtFEVNeA9Ror7t1UU6SQt/NR2mnj+qrWv9qSGjM50FOmRmusie9XpNCTENq@vger.kernel.org
X-Gm-Message-State: AOJu0YwhriRbNEyfn7e/IXZm++hiYPIlJNfta11EDvpGxo9nEXJRnDV0
	jd9F6SgWy41X3tX9KVeG96qR0W26Hs6fld/F2M3xADDXIrtkB8xRDiXGhNWVqmGeezA=
X-Gm-Gg: ASbGnctbduS0jeifFf76rqZ5S7+5vKSA9J9ozLoufIFSZvhS0L0Lz58IiQ0AravmZTz
	0tXrWqPiyP0Ym+Y/Joa+CZK/epHChXt+MteP2kBvWGqEmoPHKa9IB1EvAqX7B6WkV9EKlHQXP85
	qA6m+SaxmvDk1XGPO+Obg2kC5Fh/TZfwa8HL6ZxlYrPN236OCcIG3Hg4o+TXInVGCPEG5oVRpsM
	ht79mOtztc0OdqRFpfznMDDycDgNsuo6WfrYbgTVyXOwgrNGCnFHt0LUIff6o72QcviwUU6YOvl
	IrylLtGbuTaFJxfax0ZUstSQyqLV3gQ0uyh/6sQhCi8TnzkW1enHUZvBbpl5ybM0EVbGujcmaY5
	5JpnU
X-Google-Smtp-Source: AGHT+IEaAyozngycLd0mG65hkJuHuQ/++UMGDBEwmcvUNmlN9HEgHszswErmF9JjhOS7OFHmrHQ5zA==
X-Received: by 2002:a05:6000:3107:b0:3a4:ed9a:7016 with SMTP id ffacd0b85a97d-3a560827df3mr1956811f8f.26.1749725300756;
        Thu, 12 Jun 2025 03:48:20 -0700 (PDT)
Received: from [10.0.1.22] (109-81-1-248.rct.o2.cz. [109.81.1.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a561976a20sm1655934f8f.19.2025.06.12.03.48.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 03:48:20 -0700 (PDT)
Message-ID: <c7dbb33d-98b6-45da-be77-e86b9e6787ee@suse.com>
Date: Thu, 12 Jun 2025 12:48:19 +0200
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
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <ae967353-71fa-4438-a84b-8f7e2815f485@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/10/25 8:51 PM, Daniel Gomez wrote:
> On 07/06/2025 18.16, Petr Pavlu wrote:
>> The function move_module() uses the variable t to track how many memory
>> types it has allocated and consequently how many should be freed if an
>> error occurs.
>>
>> The variable is initially set to 0 and is updated when a call to
>> module_memory_alloc() fails. However, move_module() can fail for other
>> reasons as well, in which case t remains set to 0 and no memory is freed.
> 
> Do you have a way to reproduce the leak?

I was only able to test it by directly inserting errors in
move_module().

> 
>>
>> Fix the problem by setting t to MOD_MEM_NUM_TYPES after all memory types
>> have been allocated. Additionally, make the deallocation loop more robust
>> by not relying on the mod_mem_type_t enum having a signed integer as its
>> underlying type.
>>
>> Fixes: c7ee8aebf6c0 ("module: add stop-grap sanity check on module memcpy()")
>> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
>> ---
>>  kernel/module/main.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/module/main.c b/kernel/module/main.c
>> index 08b59c37735e..322b38c0a782 100644
>> --- a/kernel/module/main.c
>> +++ b/kernel/module/main.c
>> @@ -2614,7 +2614,7 @@ static int find_module_sections(struct module *mod, struct load_info *info)
>>  static int move_module(struct module *mod, struct load_info *info)
>>  {
>>  	int i;
>> -	enum mod_mem_type t = 0;
>> +	enum mod_mem_type t;
>>  	int ret = -ENOMEM;
>>  	bool codetag_section_found = false;
>>  
>> @@ -2630,6 +2630,7 @@ static int move_module(struct module *mod, struct load_info *info)
>>  			goto out_err;
>>  		}
>>  	}
>> +	t = MOD_MEM_NUM_TYPES;
> 
> Why forcing to this? I think we want to loop from the last type found, in case
> move_module() fails after this point. Here's my suggestion:
> 
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index ada44860a868..c66881d2fb62 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2697,7 +2697,7 @@ static int find_module_sections(struct module *mod, struct load_info *info)
>  static int move_module(struct module *mod, struct load_info *info)
>  {
>         int i;
> -       enum mod_mem_type t;
> +       enum mod_mem_type t = MOD_TEXT;
>         int ret;
>         bool codetag_section_found = false;
> 
> @@ -2708,12 +2708,10 @@ static int move_module(struct module *mod, struct load_info *info)
>                 }
> 
>                 ret = module_memory_alloc(mod, type);
> -               if (ret) {
> -                       t = type;
> +               t = type;
> +               if (ret)
>                         goto out_err;
> -               }
>         }
> -       t = MOD_MEM_NUM_TYPES;
> 
>         /* Transfer each section which specifies SHF_ALLOC */
>         pr_debug("Final section addresses for %s:\n", mod->name)

This seems to be off by one. For instance, if the loop reaches the last
valid type in mod_mem_type, MOD_INIT_RODATA, and successfully allocates
its memory, the variable t gets set to MOD_INIT_RODATA. Subsequently, if
an error occurs later in move_module() and control is transferred to
out_err, the deallocation starts from t-1, and therefore MOD_INIT_RODATA
doesn't get freed.

If we want to always start from the last type found, the code would need
to be:

		[...]
		ret = module_memory_alloc(mod, type);
		if (ret)
			goto out_err;
		t = type + 1;
	}

I can adjust it in this way if it is preferred.

-- 
Thanks,
Petr
