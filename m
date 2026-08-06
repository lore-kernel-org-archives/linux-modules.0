Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A701943FD02
	for <linux-modules@vger.kernel.org>; Thu,  6 Aug 2026 09:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786008880; cv=none; b=iWgFHDVQsJdX42lVlxSDNKcvxn40qS8LMD98EINfQWi2NizVi2UjlSyAqK687PsXcKslvhixFsn/MTfC4zNqLk2jwioKixlEl9hAWQrbN/tjTvMDfVyxGd9vWZdAEd6iK6m+3RCIaYiNxpGPnReVSAfVoonCkQ8roR3j3+E8L0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786008880; c=relaxed/simple;
	bh=BVvh5bpXUpmJCHSXdK3SA8ETnDjL1yp5ou0b+WDbmqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=naqaFrZF19aFGycJ9xq3kfzjxPXxUUOEYaFa2mIgPjYUQ6gHznyyONskOiNwymW2AO4aqsWlPGopfSaD3CdcSohnPXWspi87DUQPjwzA5pOY5BWFkUtD3gaU89CVLaXLGwmKDXWQ3gA2c5U49up7ZU+OKzU9Nw+nbKnVHbwZ4Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dOCqpj5G; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dOCqpj5G"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4953de5be0aso14382295e9.0
        for <linux-modules@vger.kernel.org>; Thu, 06 Aug 2026 02:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1786008872; x=1786613672; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0/gwO/ZBSh5wmPvY7qO834jSNpwf/Xm7SGaDdfmoSmQ=;
        b=dOCqpj5Gn26Ah6sUpFNRwdDMRTG1/18S3Zx7hMqg5JvShBer6d8DHDBOjkdhsw0Ra0
         DMHBUrqMkWTSCzIvXaSJrfIShLbSyHnzaFakfJ51wjH73iUyfCoB/7mPCT6CEg+JLYLC
         hc5I48rjMC8yALgJHdfch0MsHurPnR+pmb3Qq6mXdCQJR7FItfBJd98z0E9SseGFb952
         zLbJVkwzIyAF6SAW05eyrpxazY+z7NxHIx5EvjRb30jT1EA6Ya1JKxIjQMxljU1xoS14
         h15ETVP+tI/+XDAR94IJ9VWmjKgTksDJuA9TW10lW7gRG0SLyDa1bx3n3JVWIdM11rTZ
         tqmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786008872; x=1786613672;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0/gwO/ZBSh5wmPvY7qO834jSNpwf/Xm7SGaDdfmoSmQ=;
        b=Jks1+3qEemXdfZ4I1qUfwBfLwiCpIDu7CjmKgxOUbhYPGusWx1fdIhVgOS0g6YGQI/
         vL2hO46iz9eHTF7042P4nnDpaqxLNQL6NmkOJ4j0R3yQidL2B1/u/FOVQofqPDcZTkhM
         sX5jWIJ9nxqEDQKpi1LW8tCuaTwfBWQWq484qzEgxNr7OGq4EvaSOepgAra37Zhtubx4
         WFToMM2PxNxmCUW27G6crJKkLtL48o8GLb5fDIhoAri0mVbfeQmb+bIp7BTy/TLZ8It/
         iuxyOOPKJk08GkBMMW90966pkD6RX9cjyb5zHd33ZjmkZ2kZ+6P1pQ/5jL1iT6fgGkE3
         31Ag==
X-Forwarded-Encrypted: i=1; AHgh+RrUi3etZSuoyMDm8NCDiHs5RlblZ07PCgpf1us2py5KpFd1Ix/ecOEB88lEbs4zO6Ztpo7cqhZpPqOpVzWL@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcp3Uz02W4KqsubVgbjAXj1s8PLNbnYEnAMzZwz7THXirDFF6q
	HJWytZREDGc4fZrfCQeNehq6thPNlBISJQsMGOKsup8OHb6dHg3/ha72AqLJHJlqfOU=
X-Gm-Gg: AR+sD11cpGcZavvKzPvO1qHWg1Pe66c1lK1rqvALfdj2OpBYsGH697uO2ahFASAqIcw
	B5GnmI3pslg7l1Eu1pUoEdiSGGg4S4Qv6ay1Tq3W2FDGaeRZ16hnmA0gWxa9Ur33HTQvmyy9BnX
	r75gRcbdapSFxrgTPPhYqVcC6AbWO//DnRmMvLEJZf6qKi+0Jt26NeuBcFHYdoWV/nBpcNj/7lB
	kkW2jmjKR3JMRIPVKmu96mSx8JSdBA+akKEPFfkBZLTy5A91I7SLni8x1n70x9LHzF98chr6c+g
	dWDXQpzMnAQMqBtHJbadM18ro/oc5pjB1XGj9OGNjZqF73kFzbsrgwL0lFeriLdRMQOCdRPWqCe
	qxbNQdg8NEn8uoW+xf1SXUe+PtufaCJRoW/lzY5Op7TxB1N5GSrCnpVumUDWobSEdSUJVpwAOAK
	jASs3p7eOtAon/sgP7qLJrxVespEKX/n1bUwJCCa9ht4rx3MM9SCF0wY42ICAkptGK/ZQ9JfyGd
	8Kc3I5jgKGt3hDzlti+ucj2gA==
X-Received: by 2002:a05:600c:c4aa:b0:498:261:dd93 with SMTP id 5b1f17b1804b1-4994e7daa7fmr128489865e9.18.1786008872144;
        Thu, 06 Aug 2026 02:34:32 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:fc6c:f9a2:4a0a:6354? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995919df87sm11415265e9.6.2026.08.06.02.34.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 02:34:31 -0700 (PDT)
Message-ID: <bdb486c9-71c3-4bde-8216-83de021c6d79@suse.com>
Date: Thu, 6 Aug 2026 11:34:31 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ARM: module.lds: fix unwind metadata for merged .text
 sections
To: Egg12138 <egg12138@foxmail.com>
Cc: Russell King <linux@armlinux.org.uk>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Petr Mladek <pmladek@suse.com>,
 linux-arm-kernel@lists.infradead.org, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <tencent_08845B64E5F38EB7FA1779982A071AB4A607@qq.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <tencent_08845B64E5F38EB7FA1779982A071AB4A607@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/30/26 5:46 PM, Egg12138 wrote:
> From: Xiao Junzhe <egg12138@foxmail.com>
> 
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
> section associated with .text.*, into the
> stable output names expected by the existing ARM module unwind code.
> 
> Fixes: 1ba9f8979426 ("vmlinux.lds: Unify TEXT_MAIN, DATA_MAIN, and related macros")
> Signed-off-by: Xiao Junzhe <egg12138@foxmail.com>

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

As mentioned previously, please don't forget to put the fix in Russell's
patch tracker [1].

[1] https://www.arm.linux.org.uk/developer/patches/

-- 
Thanks,
Petr

> ---
> Changes in v3:
>   - Apply the ARM unwind section coalescing under CONFIG_ARM_UNWIND.
>   - Remove quotes around linker-script wildcard patterns so GNU ld expands
>     them correctly.
>   - Use conventional linker-script wildcard syntax, i.e. *(...) without a
>     space after the wildcard.
> 
>  arch/arm/include/asm/module.lds.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/include/asm/module.lds.h b/arch/arm/include/asm/module.lds.h
> index 0e7cb4e314b4..1d56c0375c18 100644
> --- a/arch/arm/include/asm/module.lds.h
> +++ b/arch/arm/include/asm/module.lds.h
> @@ -1,4 +1,16 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifdef CONFIG_ARM_UNWIND
> +SECTIONS {
> +	.ARM.extab		0 : {
> +		*(.ARM.extab .ARM.extab.text .ARM.extab.text.[0-9a-zA-Z_]*)
> +	}
> +	.ARM.exidx		0 : {
> +		*(.ARM.exidx .ARM.exidx.text .ARM.exidx.text.[0-9a-zA-Z_]*)
> +	}
> +}
> +#endif
> +
>  #ifdef CONFIG_ARM_MODULE_PLTS
>  SECTIONS {
>  	.plt : { BYTE(0) }
