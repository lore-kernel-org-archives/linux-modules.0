Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1628F3E8C44
	for <linux-modules@vger.kernel.org>; Thu, 28 May 2026 12:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779972249; cv=none; b=jtPwj5tBtW+pkTLZ6pcoKJ0smsqgkzqpmFdr4yCBN/umSbTDtKzRXEJ7ZwodWDWBA2MgwcKLbLkUA4g9sFM/WAVYk6xVWZV5bcCFdzbW5iwp7gAJyJWxpjibRmLW9xmKyTTqMiewmtFBcbmsYgp6qhCjfKRyE4P78KWBntFYtGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779972249; c=relaxed/simple;
	bh=70IgCyzZvW9ptI+ck3UExaY4DyLyamKX7zZGqqkjRlQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QMegUU7GlTQmwIyiKb0x2pSc1Zfd5XxB/kKotnJ7rR/8P+5Kpuq+XtRKnW12h4ipsQKXMfrbGRjtPAmSBGOQLm6faSUhrNXojiRQT0oUmRQNtzkKjL1u3xR+GeHFQ174ryevJQ0oEWpuaRRtBKT1PsFVQMp98XXveq2GeUsNchY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CLITt5Ma; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CLITt5Ma"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-49050ff7cbdso52284725e9.2
        for <linux-modules@vger.kernel.org>; Thu, 28 May 2026 05:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779972246; x=1780577046; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JOsam8NjoAr1MmJMyDY/LLfJ9CvvvTbgnZHck1lUMzM=;
        b=CLITt5Ma6XDQi/57vx+zuVU36I/CRsYmI1OjcZOYI9CM9UiCETJYGU1tj4UGA1MayQ
         wnyJAnnuPt6/Yq3vQtcgQu4ZdFiUwQH5bFPmGzF5UaWqf9GAU3ys7IOtcrz2oDhwC1qV
         bsQgVjZJv4OlZ6wZWZCfnlW1x+akLY8Xnc7fWi/QVpWV3/CEZfx+aa7aWvTiaLkPNcNu
         MJKTbDcauwdfL9w3mkYTMLblUBpBkgarZySbhbHIfFv/CQQGEwcGWxCiQi2TOfEn9lFE
         yGsnDnuQXmeDniOVF9ZCJ4v2ICLcpMR6kff4YzLZeuK18wJtHji15ulNx+mnvfmq3Gyl
         foPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779972246; x=1780577046;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JOsam8NjoAr1MmJMyDY/LLfJ9CvvvTbgnZHck1lUMzM=;
        b=TRyoFOHRPEBmP/ve4aMwF/8lmyBkPLLEFv3ot8cMnGPPlrvHHQ7m0CT8HAN4SMIsEG
         dnRTHfpF73udVZkzqs66FEtEASar+m/vhuGiTipLMqttxHsliLuKQpxroyO069HiQnQN
         Koi4lz1zmwxzG6g/w+CtZpnr+gjt6HlI6X4e3ynKkhfNHEP/3NO0ofAise6n+3DuzPFL
         SfD8/KLB6Dj6yXfmR8dLkM12K14NJqtGe54iu7A/qC2kG+aVrsxddwK35dOZXOdvLuiR
         CRiTj0usNS9yh2m+idlNRCk8GBIuCwgK2lqSnoHTlHOpD0GSr5lS5jJC50Y0aWjMXx22
         DG/g==
X-Forwarded-Encrypted: i=1; AFNElJ9nl+lBEh5BrEq+lClnHmbTec5T+l0Pjvwgo3S/wUgBJfKgCnV1cf5EwD9HN1vY/v7gQ2iC0qqOWe0kGJJe@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg8zPakiZlYEZ4SnFU60aztXVwO0mtVoVS2ttvVnXxr3t8HbS/
	sFaAm5bfI3f2CCde6dhCI7y2mTALoyUA7AgAhZhyFY5dUbXo7hlsYGbthXXVGW33k9U=
X-Gm-Gg: Acq92OHykwCwtFv7K1VLRCmmZFbjjH3RGQcT//L8Cw0/rVd5M4Gm8O4TFoEf3a88y/u
	1+H/P/ts9PE+yrzLzArEtyFEcNYBxJDoE5kD19TjDVm3+gFqnTyqn4uZ7PAiNWJJkyxVR1toAM2
	5rw9a7UHfar4f56Kg5fdh7ZTgZNNh7DsmHsiY8T+ROVCNlwuIV0QwzkwpvZBKk9GzfyQldVTfHe
	eyJNeVb5iv+lkv2iW5fPczlUWcZsIbqJOQ8XR2VFy7FvWNpxhKDtD8U3EXjjo8fx/A+qe4F7m8R
	D/ULRDLGhOtVqZb/LwFVlMwud4qzxIpOUEGcXhOwdISA4CKW55B0N8Amw87y0YKfdkYxxdFR+xI
	c88fUlC4tL3ZLFr+hd54x2QizkWKcNlGPihDj3K9w8nhGTq/yo0n/oGwprnXIGvZ57a7IIaqVNw
	6ouCLawFBUpaInlD5raz2F34OnB3btIJ/nZzJLAs11vD5aCqU3r+4STCHzpgIbXOnNpw==
X-Received: by 2002:a05:600d:8444:20b0:48f:e230:2a21 with SMTP id 5b1f17b1804b1-490428ee28emr338403185e9.32.1779972246309;
        Thu, 28 May 2026 05:44:06 -0700 (PDT)
Received: from [192.168.42.79] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5579b8sm13618311f8f.9.2026.05.28.05.44.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 05:44:05 -0700 (PDT)
Message-ID: <a1bd5c1f-bf45-4eb1-a790-936fa13bc8b8@suse.com>
Date: Thu, 28 May 2026 14:44:04 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: module.lds: fix unwind metadata for merged .text
 sections
To: Egg12138 <egg12138@foxmail.com>
Cc: Russell King <linux@armlinux.org.uk>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Petr Mladek <pmladek@suse.com>,
 linux-arm-kernel@lists.infradead.org, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <tencent_69DC6E2A5B77E4D567CA4F552DD3A835590A@qq.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <tencent_69DC6E2A5B77E4D567CA4F552DD3A835590A@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/21/26 5:57 PM, Egg12138 wrote:
> Commit 1ba9f8979426 ("vmlinux.lds: Unify TEXT_MAIN, DATA_MAIN,
> and related macros") made scripts/module.lds.S merge module input
> .text.* sections into the output .text section.
> 
> On ARM, the paired unwind input sections keep their original names.  A
> module can therefore contain .ARM.exidx.text.unlikely with sh_link
> pointing at .text, while .text.unlikely no longer exists.
> 
> This is a valid ELF relationship, but ARM module_finalize() does not use
> sh_link when registering module unwind tables.  It derives the target
> text section from the exidx section name instead:
> 
>   .ARM.exidx.text.unlikely -> .text.unlikely
> 
> The lookup fails and the unwind table is not registered for the actual
> .text range.  This can make module stack unwinding fail with:
> 
>   unwind: Index not found
> 
> Keep the ARM module unwind output names in sync with the text sections
> that scripts/module.lds.S now produces.  Coalesce the .ARM.exidx/.ARM.extab
> sections associated with .text.*, into the
> stable output names expected by the existing ARM module unwind code.
> 
> Fixes: 1ba9f8979426 ("vmlinux.lds: Unify TEXT_MAIN, DATA_MAIN, and related macros")
> Signed-off-by: Egg12138 <egg12138@foxmail.com>

A Signed-off-by tag should use a known identity, see
Documentation/process/submitting-patches.rst, Developer's Certificate of
Origin 1.1 [1].

> ---
>  arch/arm/include/asm/module.lds.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/include/asm/module.lds.h b/arch/arm/include/asm/module.lds.h
> index 0e7cb4e314b4..dc9adf8fa50e 100644
> --- a/arch/arm/include/asm/module.lds.h
> +++ b/arch/arm/include/asm/module.lds.h
> @@ -1,4 +1,12 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef CONFIG_ARCH_WANTS_MODULES_TEXT_SECTIONS

The Arm architecture support doesn't select
CONFIG_ARCH_WANTS_MODULES_TEXT_SECTIONS, so this #ifndef is not really
necessary. I suggest leaving these linker definitions unconditional, or
alternatively use '#ifdef CONFIG_ARM_UNWIND'.

> +SECTIONS {
> +	.ARM.extab		0 : { *(.ARM.extab .ARM.extab.text .ARM.extab.text.[0-9a-zA-Z_]*) }
> +	.ARM.exidx		0 : { *(.ARM.exidx .ARM.exidx.text .ARM.exidx.text.[0-9a-zA-Z_]*) }
> +}
> +#endif
> +
>  #ifdef CONFIG_ARM_MODULE_PLTS
>  SECTIONS {
>  	.plt : { BYTE(0) }

Besides the above nits, the patch looks ok to me. Please don't forget to
put it in Russell's patch tracker [2].

[1] https://github.com/torvalds/linux/blob/v7.1-rc5/Documentation/process/submitting-patches.rst#developers-certificate-of-origin-11
[2] https://www.arm.linux.org.uk/developer/patches/

-- 
Thanks,
Petr
