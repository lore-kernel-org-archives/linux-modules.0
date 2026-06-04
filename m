Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5503D6CA9
	for <linux-modules@vger.kernel.org>; Thu,  4 Jun 2026 08:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780563175; cv=none; b=WyU6yB3DEgVGUbdsp+EB7fi9RKzX3BPtYcNFwjW4twL2UOyLzUvE7bdOUaCHFo4ekhNsYuIVek6e1MwYgHJ2M1I0rruvChewdxf+4rNK8XPqpSx6Iyi64HqRxzMRFQDq9Jkl2oXiVxZY0fICNYzrh6v70de3wT+IYMrex6RjPe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780563175; c=relaxed/simple;
	bh=OR8e0jhledTTlXozyWBtIzMaN5sAq5VFvYyiL+tIXU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sIQe/vUI4NxsFoXyn4v+r0I24VALJ3x/PiHgksbO+Hh2hO5CYjKKRtJiOhdTyLfFQI+6e7C4VOarfOosMOoHbh5sAjU8nIHPPoKU42OgTjJpXBlbX5sdhKYbtP9BqQLXvn9Xy9boKPTiKXDix2R1xLvB9xCAnm3cSJE85jOAPxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Cx/EFnre; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Cx/EFnre"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-490b9318997so3065675e9.2
        for <linux-modules@vger.kernel.org>; Thu, 04 Jun 2026 01:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780563172; x=1781167972; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yMZS0JDsy7N0YnZBiLRPxIJYHot/xoEDAJ7Md2NCBMU=;
        b=Cx/EFnreq1KYTuJ40FD6pmocZLeTd1VgaYpOuB35y/CpQCi0fDQse3HRGwyTCVJx+8
         F6krglk2RvfYiGAbD5QimBPhuhVoKeNkO1hH2qahl9dpR+1byNT+9ec4AUrBqXbl+qac
         eaVV62KB9wArz5ORvwCsoeS+RduiopOPnVZ5Hkdo1pySNwPO+PCgO61R+zLEo3Alyk/W
         UxkiyyEfcs1353n66xQEbit5RCyy8fceDim0cCUbs3ryjmi5XGZ1rzMvKggcZ9AwCJGl
         w4qV7YhI68rGSzk3NvaKLih9eT5DznfkgY9IY7VQJCqxbIkMpkdROXoqlJ6aaq1irxMf
         1TGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780563172; x=1781167972;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yMZS0JDsy7N0YnZBiLRPxIJYHot/xoEDAJ7Md2NCBMU=;
        b=BybOnpHINasAiMlbxd0Cpl9KcA6gzwqzqOqYXPZ1gLjhuEKeFaLtejfhHAzPHaJcPc
         ehdhtERlan1iWxNQ+7d9dW5cMAqgWmf6h1RTl/fr06wnvB5kmSDv0HfadhbTMR/XEsm5
         Cul5WrSClzx3T8ZX9T+2CpvFdtP9MtmpNPpv9DlwY5DiwxWXgH1F/Hp8BYV82hgIHQwq
         6surwGEl970SU/IC8tCfCAT7qowz4FNy8nQb31Szx9d4R+krQRQZFOFm6/zzrmgT2sF3
         9OyYZdmMM0z+j0I4AuTzuBZYU1oS2IokG6X4a3Z0ox3Yg2+csYRvRxUnupu198aKF4vk
         6gYQ==
X-Forwarded-Encrypted: i=1; AFNElJ+pqaiVHYF2f8LdX8ye8EX/eflH6Uw1Rvmd6i0AIUctFfTuEIps0AMoRd4ImeUo3XIWMy2FsTs7gX4oil1W@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzj2STB5Zh756JpVUnaXqRSphp42YafmwgDlCzmCMEgOTv4Rik
	YmDSi3LDUzwt1ZKD9UmW04X8KG497jhwMv3jrUA2b0Xap+7PGtuOomInGkM7y5CaACE=
X-Gm-Gg: Acq92OGqSWfUl9N8kkn/c2KM4wtS/nVObnUq09f3727CcPmtz3SztlTZzme9CbH4Fyd
	VI0Fy4TH4VREzmM0xVktTtpVcMknF2+WPCRJLf769tNKP/jVZNumIMMwTCK9AGtLaBGNXlH9jn8
	ke8qc4UFT7IDd60WCL/OW+ll/dQC0kCisTWFpujOOpSybL850VMLqghdIT8Leen5tFyS874svyw
	1G44/Tr0v5rlkt8jXt7WhHudh73/9Igan50YrMs8qCHJMAlFt3l3nPmjb9j6DQts4S2uOby4/QN
	igZB15Mu5/4pR7OGTdPtfSt9VpRY2zUM/Ok4BxkAk/pLXhYZKgMEv5MZkr7sAbw0v3o/7mdIPPl
	kUG3/4AtzgYMjR45M2D1v1f64/QAdrjytOIyQABNQD/MPPMTSqJjs6p+YZ8W82+/x2AmDeo2PWl
	QzLhBs4lGGEgJUkouFb4ADTXWXcJwLv9aCBY136IEM2ve6V1p1of0dUJvlRP5U7wZYxU4V8rg9D
	tHDGS2Oha83KV2c6wcoq7kciQQskoS2uZ/uhwbLyRfqj8qBWo2jwRwxwunjSa8sj+/p1Ieqyrra
	ysF1
X-Received: by 2002:a05:600c:a088:b0:490:b58a:e6ff with SMTP id 5b1f17b1804b1-490b5ee1a6amr114572025e9.22.1780563172322;
        Thu, 04 Jun 2026 01:52:52 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351d40sm14467980f8f.26.2026.06.04.01.52.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 01:52:51 -0700 (PDT)
Message-ID: <59c7b5d1-643b-4ca5-94ad-eaf82a66fc9e@suse.com>
Date: Thu, 4 Jun 2026 10:52:50 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module: dups: use strscpy() to copy module name in dup
 request
To: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
Cc: mcgrof@kernel.org, da.gomez@kernel.org, samitolvanen@google.com,
 atomlin@atomlin.com, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <v546667lngoo6dxwb7gqzf7liya2opdfeevrtar7iipsbkipfc@uh5fuaofcrty>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <v546667lngoo6dxwb7gqzf7liya2opdfeevrtar7iipsbkipfc@uh5fuaofcrty>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/3/26 6:25 PM, Naveen Kumar Chaudhary wrote:
> kmod_dup_request_exists_wait() uses memcpy() with strlen(module_name) to
> copy into new_kmod_req->name, a fixed-size char[MODULE_NAME_LEN] buffer.
> This does not bounds-check the copy and does not explicitly NUL-terminate.
> The buffer is zeroed from kzalloc_obj() so NUL-termination happens to
> work, but the pattern is fragile and lacks an explicit bounds check.
> 
> Replace with strscpy() which bounds the copy and guarantees
> NUL-termination.
> 
> Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
> ---
>  kernel/module/dups.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/module/dups.c b/kernel/module/dups.c
> index 1d720a5311ba..33bddfb57317 100644
> --- a/kernel/module/dups.c
> +++ b/kernel/module/dups.c
> @@ -129,7 +129,7 @@ bool kmod_dup_request_exists_wait(char *module_name, bool wait, int *dup_ret)
>  	if (!new_kmod_req)
>  		return false;
>  
> -	memcpy(new_kmod_req->name, module_name, strlen(module_name));
> +	strscpy(new_kmod_req->name, module_name, MODULE_NAME_LEN);
>  	INIT_WORK(&new_kmod_req->complete_work, kmod_dup_request_complete);
>  	INIT_DELAYED_WORK(&new_kmod_req->delete_work, kmod_dup_request_delete);
>  	init_completion(&new_kmod_req->first_req_done);

This can be shortened to:

strscpy(new_kmod_req->name, module_name);

I also suggest merging this patch and the second patch [1], which cleans
up the same issue in the module stats code, into one.

[1] https://lore.kernel.org/linux-modules/jmm7r4r3k3qt767tl7lojglosgc3umhc63cdp2fckdkgb3fzki@3fgvxgvzo5ex/

-- 
Thanks,
Petr
