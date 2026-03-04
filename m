Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EF63DA5D9
	for <linux-modules@vger.kernel.org>; Wed,  4 Mar 2026 19:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772652805; cv=none; b=XmK0zIkDD9WcLOi9V2ufCYVwQ0/deSHLeqH6uMDK9OMCgbdc8qqeXh0IiKJNfbkCzVJoQ+Iz5Ve5SDA0uOt8NaFYBmO7IxY0T6N9lu/ZXCxGLMLGBnVsFkwaTX7fC6IMvWpoas/lZ/mNOc0KjzKE0C2pbbHIgj7ArIRDhGelgyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772652805; c=relaxed/simple;
	bh=xt5LSQtF8djT3pyh6r+qKCISkQKP4j4fbWDR874CSjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lKiIZqoySvDO3/c30xWOIVjw5gD0VynO7R4gB2PfCg3JHAbBSGACsgg0Neri2GivGkv737X13JFIQ1tNPvmtyqWRkXYL7P4XLIosJzeX0CVpwuy0ty+qL1iDz1hVkqBbNZFwgg+sYI7DGO2QUFGNAo2UvAFgV3+tKL93Cudmly0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gEWztoWX; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gEWztoWX"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-483a233819aso71473095e9.3
        for <linux-modules@vger.kernel.org>; Wed, 04 Mar 2026 11:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772652801; x=1773257601; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TwcPWqbwdgcIHoSyNaDrWJ+mjlZF6CriUiUT+57GEbo=;
        b=gEWztoWXqCLaoGxFCo19El/NexvLKLoqTwu08ruwIf+so4Gtl17kvBney8WCpi5AEy
         EUed9onVozK6I/ruQcOYcKVkhyy2447NVTbmfFeAlXaHSB1LovWDbuh67Dd9Psq1eNZS
         SJelWsAbEHHJkEJjMhHZJ4HAgPWNwZlHsos9YE8GRBPyKkWNHBB5ldyX6fDDsIzg1grT
         lXymfGw+r2pOGAy8XmRfctFdV/eWgnUfd12G91ROgoXgsIbWVCIZoIJhk3MIkSNf1sRs
         KYTablQH3xW4NV6T8PNNG/IJFqdMzLOYAvtJltyIzN1KDpoPXvosGSCOTYmOIwBhEQ3Q
         4W2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772652801; x=1773257601;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TwcPWqbwdgcIHoSyNaDrWJ+mjlZF6CriUiUT+57GEbo=;
        b=XBjNcSNL5ifpxc2zlEuNc1RVPlp9wZA5utOFwda8DJfDV3dKOB78HAED3iP4QELvsl
         gM/ZwvC4o/2n22scm4B7jgcHPQUIrQnuW9IO/9rnff0P6veM86oSk8kr8kYTzdGpBrwh
         QxD+dDRK/BZacJyRuYQnx7CdRau1NBkdne/3y7zJpmkb6ORKnzchmyhHEbUrNpOi1XmA
         1mnjLUTYyt+M3hxfFwwrt0g56C2tC5vOkBWQxurRuXYDLhxAwkHKwQHK1C8IqcQLkfQL
         pjhB5KnQFdizjx28Jh1vet8JgbqWJJCRZBBOYCHfq/YxC5XV+oduPfJLi5eVe46kZhrj
         Ogyw==
X-Forwarded-Encrypted: i=1; AJvYcCVCyzUJ3Ho3mbpPHzjvVlwbictxd0jCKYXUv/q2Bg++gdUuE+4lPhjBOrWYGlzMbCQNpDX/dzlbZlIwS2n+@vger.kernel.org
X-Gm-Message-State: AOJu0YzEvDwCjhQb8FBuhlxAjaAPbINELsigGMXMN0bb9EtTMIrlkbid
	DMzKFEfHlE4U4ifGXvzjt0Vnid7x6/iZkOKJRYregzRHVKUu4smDKgJd+FYIE0kawGA=
X-Gm-Gg: ATEYQzwdmqa2c5tfapyXnWtLBF48ziMP/Rit4+BrNNRanO3VCvvCH8SXK14LOkobZhy
	A7WahvHnI4cvw0E6+OikStorY/MP1rFn6ugk2s65BzCajcGKKPxiTlKv3cHyGNgiEYBtyS1PWG5
	nXhWKL/5UH317WlJ5ETyreY6vXV5GSE96i3yV3eAPwNTM/jRuuQsnqPE3FuQhGviBGVInBnKkK4
	yycJM7NiGVgGRBNSwDC3niIIBHSJ0CVrw/iznzxMDOs255D14hMAYcUcjEBhiYNzjq2+3iDysGa
	HVhbws/BTXQ+Js0WprzwZT2mtskqstbLAG1zCiooDAmsHVqo28ZCzjT8YjwCEXgeCCuisN8TQau
	iZxkTgKu7G0Ht1hnmt/qB6JjTHS03bmdUA5yl30hMjobozTweaxUG0Axt7vHfmkWSpJz2CE7WeR
	O/sx7tvtdOYM+8UXm0o1e1alfAsdXTBeV65f5ajM/Wx5RChBdzptwWkwaOIFJRw7uA1zdQTmLKw
	rYYkBlLTyaEjaAtw/QAwFsv4Z7OiCWwH/6S+ljvTv7JRNV7u7kE/JyLcNykM4hJApMupQ==
X-Received: by 2002:a05:600c:c8a:b0:477:79c7:8994 with SMTP id 5b1f17b1804b1-4851989f6e3mr51545915e9.30.1772652800743;
        Wed, 04 Mar 2026 11:33:20 -0800 (PST)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851a8a9542sm40206455e9.1.2026.03.04.11.33.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 11:33:20 -0800 (PST)
Message-ID: <505a3a22-caeb-4351-a97c-2995275dff27@suse.com>
Date: Wed, 4 Mar 2026 20:33:19 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module.lds: force 0 sh_addr for .text, .data, .bss, and
 .rodata sections
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Petr Mladek <pmladek@suse.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260304160611.143862-1-joe.lawrence@redhat.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260304160611.143862-1-joe.lawrence@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/4/26 5:06 PM, Joe Lawrence wrote:
> Commit 1ba9f8979426 ("vmlinux.lds: Unify TEXT_MAIN, DATA_MAIN, and
> related macros") added .text and made .data, .bss, and .rodata sections
> unconditional in the module linker script, but without an explicit
> address like the other sections in the same file.
> 
> When linking modules with ld.bfd -r, sections defined without an address
> inherit the location counter, resulting in non-zero sh_addr values in
> the .ko.  Relocatable objects are expected to have sh_addr=0 for these
> sections and these non-zero addresses confuse elfutils and have been
> reported to cause segmentation faults in SystemTap [1].
> 
> Add the 0 address specifier to .text, .bss, .data, and .rodata, and also
> to __patchable_function_entries and __kcfi_traps which had the same
> issue.

I had this issue with non-zero sh_addr values on my list of small things
to clean up for some time. I didn't realize it could cause an actual
problem. :/

> 
> Link: https://sourceware.org/bugzilla/show_bug.cgi?id=33958
> Fixes: 1ba9f8979426 ("vmlinux.lds: Unify TEXT_MAIN, DATA_MAIN, and related macros")
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> ---
>  scripts/module.lds.S | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/scripts/module.lds.S b/scripts/module.lds.S
> index 054ef99e8288..e1cab3cee3f7 100644
> --- a/scripts/module.lds.S
> +++ b/scripts/module.lds.S
> @@ -32,30 +32,30 @@ SECTIONS {
>  	__jump_table		0 : ALIGN(8) { KEEP(*(__jump_table)) }
>  	__ex_table		0 : ALIGN(4) { KEEP(*(__ex_table)) }
>  
> -	__patchable_function_entries : { *(__patchable_function_entries) }
> +	__patchable_function_entries 0 : { *(__patchable_function_entries) }
>  
>  	.init.klp_funcs		0 : ALIGN(8) { KEEP(*(.init.klp_funcs)) }
>  	.init.klp_objects	0 : ALIGN(8) { KEEP(*(.init.klp_objects)) }
>  
>  #ifdef CONFIG_ARCH_USES_CFI_TRAPS
> -	__kcfi_traps		: { KEEP(*(.kcfi_traps)) }
> +	__kcfi_traps		0 : { KEEP(*(.kcfi_traps)) }
>  #endif
>  
> -	.text : {
> +	.text			0 : {
>  		*(.text .text.[0-9a-zA-Z_]*)
>  	}
>  
> -	.bss : {
> +	.bss			0 : {
>  		*(.bss .bss.[0-9a-zA-Z_]*)
>  		*(.bss..L*)
>  	}
>  
> -	.data : {
> +	.data			0 : {
>  		*(.data .data.[0-9a-zA-Z_]*)
>  		*(.data..L*)
>  	}
>  
> -	.rodata : {
> +	.rodata			0 : {
>  		*(.rodata .rodata.[0-9a-zA-Z_]*)
>  		*(.rodata..L*)
>  	}

This looks ok but the same should be done for sections created via
MOD_SEPARATE_CODETAG_SECTIONS, namely .codetag.alloc_tags.

-- 
Thanks,
Petr
