Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878AE2857C2
	for <linux-modules@vger.kernel.org>; Wed,  8 Oct 2025 13:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759930535; cv=none; b=oztVUIPjTHfjEs9uFuKAcSq0tINLKvCWETmWVrvOmzHbnn49EhdBHGQQaI6XLTs/23AOQVLy+HbIQAnQuVMxDTHhG858AVEtGpDsIk0+iung22I62ZbnxONnfE3hO3nm2zXxOrL0yKfts5LTjbHQikhvP1hfuE7gxjPNnYN+Epw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759930535; c=relaxed/simple;
	bh=7vGH8N/m6PE6lnr/uLWOIY85RQ6MjHgDYrjIeFb+YNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u9rM5RB6p4INQXYgJ/Vu0LyBCK9uo2c+xUXrZ+ChPMo34NH8cnVFylChzUrjErz/ao0X6/KM/KaxKN6/OLFtd00mOHjD0cC/s0WiHMY4dVhg3D5XddDWgbubSw1c/d0aEKz2suM4VGGM3KBUbbF4jN/z27X5XXwJHab7nU0BOI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dywjDn0h; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dywjDn0h"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46e29d65728so42185955e9.3
        for <linux-modules@vger.kernel.org>; Wed, 08 Oct 2025 06:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759930532; x=1760535332; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hDHlNMCgPWfKcx9mEMfAa7rnZ2ePjEXMkf1KPca5jNs=;
        b=dywjDn0hZVcYnCqsGOJwB9zIwhAuPBx6/MnaRssTC2JfxFetIhJNqVQHO9Glfw/Mzl
         jdCKVnXimtkCw+nFxD3dFnOx4hTdnFv3SbJ5xkAh87EiDw6ziOab7IrwKFiDG1dvfCNd
         zBYEFhKO89Acm6ztRue/IbFMpeXzKHV5zH5R+BhNi/y0az0Q0aLDXYMhdJKVuVLQsclY
         yZcjxPi+91EiGK8WBuDigRSxaFesJlkjC1nKNfND+ejLHMimqJvAFU/kRvEiRA7THLqA
         odnmDDe3Drz2vcYt5g/ZyOvD3MWFevAngP95s6KBpFuSxrjXluGXf9FpghAzLon+0V8D
         T86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759930532; x=1760535332;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hDHlNMCgPWfKcx9mEMfAa7rnZ2ePjEXMkf1KPca5jNs=;
        b=kY8RxHvLvhDZ/7HcyWvR0dHCXUmh9Znd58dtqj8n1NLJXzwgBDbjheEI/hk0ZmnqAk
         s1Z+5yGMpkyNHFmADzJuayb+GSauHGPDnHpItN1mC3uhO49cBtXacij/hL/0dZa1A64Y
         iQibaEZVwapJTdRXnzbTXvYAMyq9WXfmwwVyamrrJEq2xidVgvnDLULODZOzOsiU8wlw
         a69Icl0PX5+WyROjPEimAX7eYGGhjywChX/lkJwgUydmHQNeoB77BnLH6RUd9+ZnEBOj
         zLZzCwUDpKPJzZQQdxaeHVgB3HdHC8ymitUgvcacu74Z2zdbg5Z/JgypN542256UzVAo
         yYUg==
X-Forwarded-Encrypted: i=1; AJvYcCUKxNQXduGqtT4gvFVgC9V60e7eR2od/1YackcfvAsIMVHIQmQDPci71i/7IoittawjaPWA2XFEvtVF6Ubl@vger.kernel.org
X-Gm-Message-State: AOJu0YyYQMiytJh6SOqZ3SPj0WYf5BDrcwPfyoNjkEDtL2wEGjHSLq+7
	IhHFfKDcE4s/1v2oVV3Iu+YhCCog28jvPtElLdyDgl3FIEewxhytgigN1c4PtINMSQM=
X-Gm-Gg: ASbGnct3PlnfbRGwf7bAT8ZEbMKNUB0z+ZvjqVOuY2ab+JXCxxL8zK0sdOW0o3/zr2g
	Dk71lT7Kb/UOEM6ETcPNiX+m46RsxfOAcy1jXlsaVQu5CXtGgKZuNzxBkwXxFSvNovlKROP7wsF
	imZlJHwVF1iWkKGvryuQKSwcRDc0+lbdvaIk1xXjHmkEQaZHg7E63lCbowyewBNK4x66NQHiIYG
	4MIjkcBAlqxGfF7fCQ8oB1c5U/WM5N48o5c0Q18EkQFdjMAOk1/fGayup1qBiNYYNXh2kMrshys
	x66GrPjTFAGYeh5wbAqKnpzo5TfVu3tGZUa7r+oPU7cqrjh9LgERgiRR8pwLU2pFBiIi+j0Rjmz
	P+z2mzBwtR7WhKT63KIthMx+nZIiz5kHOacvNdBM+1Oab6JHluTIuBCdlOXgfUV/U
X-Google-Smtp-Source: AGHT+IEXN1OK+uUWcZYHcu8mGQCE4xlOe4D5UqEffJSE6zNfCHiuL17ImKFC3KKJ16P8hPWOZxwfnw==
X-Received: by 2002:a05:600c:4f92:b0:458:c094:8ba5 with SMTP id 5b1f17b1804b1-46fa9a96588mr24061795e9.12.1759930531814;
        Wed, 08 Oct 2025 06:35:31 -0700 (PDT)
Received: from [10.0.1.22] (109-81-1-107.rct.o2.cz. [109.81.1.107])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8e9762sm30365608f8f.38.2025.10.08.06.35.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 06:35:31 -0700 (PDT)
Message-ID: <6e057525-ca8d-4f96-bb52-cca6cafbe835@suse.com>
Date: Wed, 8 Oct 2025 15:35:30 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] modpost: add symbol import protection flag to
 kflagstab
To: Siddharth Nayyar <sidnayyar@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Nicolas Schier <nicolas.schier@linux.dev>,
 Arnd Bergmann <arnd@arndb.de>, linux-kbuild@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250829105418.3053274-1-sidnayyar@google.com>
 <20250829105418.3053274-10-sidnayyar@google.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250829105418.3053274-10-sidnayyar@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/29/25 12:54 PM, Siddharth Nayyar wrote:
> When the unused exports whitelist is provided, the symbol protection bit
> is set for symbols not present in the unused exports whitelist.
> 
> The flag will be used in the following commit to prevent unsigned
> modules from the using symbols other than those explicitly declared by
> the such modules ahead of time.
> 
> Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
> ---
> [...]
> diff --git a/include/linux/module_symbol.h b/include/linux/module_symbol.h
> index 574609aced99..96fe3f4d7424 100644
> --- a/include/linux/module_symbol.h
> +++ b/include/linux/module_symbol.h
> @@ -3,8 +3,9 @@
>  #define _LINUX_MODULE_SYMBOL_H
>  
>  /* Kernel symbol flags bitset. */
> -enum ksym_flags {
> +enum symbol_flags {
>  	KSYM_FLAG_GPL_ONLY	= 1 << 0,
> +	KSYM_FLAG_PROTECTED	= 1 << 1,
>  };
>  

Nit: The ksym_flags enum is added in patch #1. If you prefer a different
name, you can change it in that patch.

-- 
Thanks,
Petr
