Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A501876;
	Tue, 22 Jul 2025 03:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753153698; cv=none; b=Gg1nfzunjduBSf3QebBQAbtHxXcNpSZpR7t3RM0XH68iTJgRUy1YazQwJTtcUVeErJOdBrZBQYc0PGeq42yAHlMj/34qc2Ji3L3BWsLOgM5Ng7Epr2r7EhTo7gHH9YocuWhfuBlIq5+TvQWMXKwC48jSYaJ9pxMj1LZVjuJd3l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753153698; c=relaxed/simple;
	bh=N0ppqD3iPhVW3SEcGthSL7Disqsys4eXBsyqDHoHK/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G/spzDY7PhsazaYE4Hue9AVi7YgS/gnOALOXIBYrJvwYUp7pE83vmli7uBNd5kfpKqz+neX7R0Eei7EaglqvgYUc7378KmNLzCMf8DKSotgY+t1EuJ/aqG3vnXO+DJwz0E9CTSlOH8FpEGm4FoHgwCPUqWBCjM+fFisSXfj3YAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WW53QRx9; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WW53QRx9"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-74931666cbcso4074037b3a.0;
        Mon, 21 Jul 2025 20:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753153694; x=1753758494; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a09rOehOFiPa39OyIrUgdGlVsxxlVZ4BHJ+RpVZi3iQ=;
        b=WW53QRx9HQe1+Rg3zavqAECcfdrJv1CSIABkb59PIPP3qrddCw3XNCLZe9zz21x4H+
         lQ8sbXdS1VrE0DfLolwLay0yVQC9yQ9iBWLga6I7zczFCvagGFkDRkZxEptqnsxZLRPY
         8TmF9CjLNe1whQTsPdaQaqAz0jn2gGXNNtq40hiD3lAxcE9AqArlJmZvHjEyWNau6Idt
         9hYaRXYP8wtP68zrzT5utF8Ljw3NRYmFmpln3EEKuOTi/gp5wwY3vhQmsBaUbxBumKMw
         0Vrxah2sDBUNIKciCKwmFRuBSZ7VV7VGyASsFBh+Pnp0raeoThO6KhkvNq4QwQ0YTxlC
         IoVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753153694; x=1753758494;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a09rOehOFiPa39OyIrUgdGlVsxxlVZ4BHJ+RpVZi3iQ=;
        b=OMbvGJd4WREQddfkhb3nvy6z6E6Yji+GjRvRhCQNHK34RsaUQC+nzoomERRw2MQ9Zg
         wtfyC4gLXkid7kfrtmFupLlN3DyzQlewEPKMLncSI9qC3rmYSjO5HGgnP4Sng261HrT1
         PyWzs8pZYoZHwolyWtGI73sDL7DV5gSVcNI5lMDweGqZCXc9Jxm+FIDvnwzMarWlmejB
         GnC+v8fNNd13my7YPEVOYlvFec/X30plVYiS8J6YVpPpKB4/t3YtKfHpNiqMP74a7R1m
         RXeFqnUGlp3tg9CyyZ4b+41GJYBMGi+6ywdJV5zhawNSmW/aI5F01WEPtlooTOeOWl89
         CLyw==
X-Forwarded-Encrypted: i=1; AJvYcCULtESmdR/PHgQKU9jCg3ci4Xc3bS9yjZ2CZZb8WFSR9CKlX0DZNj4Uv/Dlo1lHOSeC4s3PN6lp9eG+E4Q=@vger.kernel.org, AJvYcCWRyAj33dTn8TJk0cVxUIV5q22lPSaOyAc/bLWwCJHGKQgmVCGGgBs8+iaNx/Lrg7p1/VUuKtMsJ2PbD13+EA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz788zYrrCGcSog0BnTkTKX2y8GC4Yx4L995VzXUOcsqVvrO+ct
	sbUMzlBaMYFxzalv4eCD5ZLy3Nnw7VJ7GgiGQpEPcgg28zq6w8idtNFAouMcdb5hhRNbpw==
X-Gm-Gg: ASbGncvQHcgtZvRfE47yY4674ybIZoP2SetHoAfglCM6XKwQDDnaZSXePitgK9pyk3Y
	DOU3P0zpL3NDGGmUzK0yCFsYwf4wlibl05a4cWIYxa3gUcgQk8rMKmgn1uJmlx4f89kRabwS1ED
	raMFWTjO31D7/U605L/wGw1j48CIzjjK6UmPBqcO96JA+29TsdfmmDjG+QWR6FnBruInMFK9qUa
	tCUR3s5T5XqMcjyU7S15aDN3acf/Zt4RgFslVfYQRcMKEQeseT8/VH9nzkPI1O6Ggg5dsTQ3wDm
	q/jPo17yay55MGez/JHjJew2zpEPCpSpczvE3KJbmMxPLPvsxjvGPFKCNfcthvL/BN6BgyIARjH
	HX4y4tCr5RbbCv0M=
X-Google-Smtp-Source: AGHT+IFicKX58TzzqZOoWpySyRm5i0Dcmmj1iOve2wezUmILZuwXvtalP53unAtWnJoNDV5R1wU8Rg==
X-Received: by 2002:a05:6300:2418:b0:239:1fad:a3c4 with SMTP id adf61e73a8af0-2391fae1bd2mr12586077637.16.1753153693816;
        Mon, 21 Jul 2025 20:08:13 -0700 (PDT)
Received: from [127.0.0.1] ([2604:a840:3::3004])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb76d691sm6614262b3a.103.2025.07.21.20.08.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 20:08:13 -0700 (PDT)
Message-ID: <86062810-ff6b-4181-83b7-dfe443ff4012@gmail.com>
Date: Tue, 22 Jul 2025 11:08:08 +0800
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module: pr_debug when there is no version info
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org
References: <20250721045224.391745-1-wangjinchao600@gmail.com>
 <3992b57d-3d8b-4d60-bc4a-f227f712dcca@suse.com>
Content-Language: en-US
From: Wang Jinchao <wangjinchao600@gmail.com>
In-Reply-To: <3992b57d-3d8b-4d60-bc4a-f227f712dcca@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/21/25 22:40, Petr Pavlu wrote:
> On 7/21/25 6:52 AM, Wang Jinchao wrote:
>> When there is no version information, modprobe and insmod only
>> report "invalid format".
>> Print the actual cause to make it easier to diagnose the issue.
>> This helps developers quickly identify version-related module
>> loading failures.
>> Signed-off-by: Wang Jinchao <wangjinchao600@gmail.com>
>> ---
>>   kernel/module/version.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/module/version.c b/kernel/module/version.c
>> index 2beefeba82d9..bc28c697ff3a 100644
>> --- a/kernel/module/version.c
>> +++ b/kernel/module/version.c
>> @@ -42,8 +42,10 @@ int check_version(const struct load_info *info,
>>   	}
>>   
>>   	/* No versions at all?  modprobe --force does this. */
>> -	if (versindex == 0)
>> +	if (versindex == 0) {
>> +		pr_debug("No version info for module %s\n", info->name);
>>   		return try_to_force_load(mod, symname) == 0;
>> +	}
>>   
>>   	versions = (void *)sechdrs[versindex].sh_addr;
>>   	num_versions = sechdrs[versindex].sh_size
> 
> I think it would be better to instead improve the behavior of
> try_to_force_load(). The function should print the error reason prior to
> returning -ENOEXEC. This would also help its two other callers,
> check_modinfo() and check_export_symbol_versions().
> 
> Additionally, I suggest moving the check to ensure version information
> is available for imported symbols earlier in the loading process.
> A suitable place might be check_modstruct_version(). This way the check
> is performed only once per module.
> 
> The following is a prototype patch:
> 
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index c2c08007029d..c1ccd343e8c3 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -1053,6 +1053,7 @@ int try_to_force_load(struct module *mod, const char *reason)
>   	add_taint_module(mod, TAINT_FORCED_MODULE, LOCKDEP_NOW_UNRELIABLE);
>   	return 0;
>   #else
> +	pr_err("%s: %s\n", mod->name, reason);
>   	return -ENOEXEC;
>   #endif
>   }
> diff --git a/kernel/module/version.c b/kernel/module/version.c
> index 2beefeba82d9..4d9ebf0834de 100644
> --- a/kernel/module/version.c
> +++ b/kernel/module/version.c
> @@ -41,9 +41,9 @@ int check_version(const struct load_info *info,
>   		return 1;
>   	}
>   
> -	/* No versions at all?  modprobe --force does this. */
> +	/* No versions? Ok, already tainted in check_modstruct_version(). */
>   	if (versindex == 0)
> -		return try_to_force_load(mod, symname) == 0;
> +		return 1;
>   
>   	versions = (void *)sechdrs[versindex].sh_addr;
>   	num_versions = sechdrs[versindex].sh_size
> @@ -90,6 +90,11 @@ int check_modstruct_version(const struct load_info *info,
>   		have_symbol = find_symbol(&fsa);
>   	BUG_ON(!have_symbol);
>   
> +	/* No versions at all?  modprobe --force does this. */
> +	if (!info->index.vers && !info->index.vers_ext_crc)
> +		return try_to_force_load(
> +			       mod, "no versions for imported symbols") == 0;
> +
>   	return check_version(info, "module_layout", mod, fsa.crc);
>   }
>   
> 
> As a side note, I'm confused why with CONFIG_MODULE_FORCE_LOAD=y, the
> code treats missing modversions for imported symbols as ok, even without
> MODULE_INIT_IGNORE_MODVERSIONS. This is at least consistent with the
> handling of missing vermagic, but it seems this behavior should be
> stricter.
> 
When debugging syzkaller, I noticed that the insmod command always 
reports errors. However, to get the exact information, I need to trace 
the kernel, so I casually submitted this patch.

Based on your response, I also feel that the meaning of force_load here 
is somewhat unclear. It would be better to create a mask or a clear list 
to indicate which fields can be forced and which cannot. Once this is 
clear, we can create a function named may_force_check().

In addition, check_modstruct_version also calls check_version to handle 
tainting. So there's a minor issue with the logic in your example patch.

-- 
Best regards,
Jinchao
