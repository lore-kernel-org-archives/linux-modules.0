Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E8541D659
	for <linux-modules@vger.kernel.org>; Tue, 28 Jul 2026 10:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785235595; cv=none; b=KgtG+ju77s9Gr3IYnvQoJsTlyEDNUIimy2hfaMZ/9u+FJinz1EYd/urbsv4jNJwlTv/aO8m99Yz6nmlEDJ4YzD6sePdBrKKxEloRtmMYkvSVxpYPdOU+3jJUhToKQbqExDpETp55AKpNFLdY6mUbaduSwIJ6xSYOcWNRW6p6h20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785235595; c=relaxed/simple;
	bh=xOrAplYyS+pNrXAKjyHCqHir2UTZzh7Gyle/Rd7RHV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pr71FqlmW46wErnKES6kM3E1uQxE9yINJXHOhQ6mYLd71dn6Vyw8FN3CE+SvZpd04u9T0B2CDham7gvHi1yOzs3MFjS0WZBA1BYDzI6eXiZNtjFX1ZX9CIBuNPYsMIftuEDUmh6kycROLNb/sFWvtvsmBYh9cKiB0xGDAyqKbOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UuE0DD2L; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UuE0DD2L"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4728c12ba97so2208248f8f.0
        for <linux-modules@vger.kernel.org>; Tue, 28 Jul 2026 03:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1785235592; x=1785840392; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FIC3b/7o8AMFrBQ283uf6ujNtCi93IZpkLlkVl6wgK0=;
        b=UuE0DD2LlbosO/+IjEubNwaItrz04MSnydiTWKGmG9OfK0JZSjGa//On+3IdEphGaA
         BfttduW5214Dk+GxX/j2lE68FYh+xDCfPiRXrq1IfcQnOxwY421jgT7akj4ZVRDwofUs
         zDqzQaMxIQ8mGGtnl/i+QzZJwBx/E29sJkxdXil5Ug1p7sB3+MTIqq1BUA+kUFE0P5OR
         4CQlZjwC4IE/FlR1j+Ghd/6qKGAH/ysWD6YW8mZhPlcaZgQ6N7AkDi7MJQliiTJGTlJc
         pNxnSVPvmFp1O/AjdUcwZolSwWhzoKD4S/v0mc1izYhjor/vvUSeTbskgVmr6RhnDAcn
         zgAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785235592; x=1785840392;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FIC3b/7o8AMFrBQ283uf6ujNtCi93IZpkLlkVl6wgK0=;
        b=I/HaEjf2d4jOsCHBIaWq521CDYLe9+fEUaUlYYny9CeO3TPqRFjgXnwLz4bqhylGUg
         n2vSM+p8ybTrhgFDR1eaP4EfBD5SRLU0AihJU41mVpjV+JFF9UrVpMMJ9LwG562NkLDZ
         qV7eZdwRXMBCv0E9hrzkXW7sdmsfCZaWKDwi40+CCqPqfCCTJ4TydkXUbhoJdizBRqdk
         yaj6Rj1BrH/t/ZJoSwfQUDcciPWKCdvBfqec41/myLPQajYaAPXwGM70towafrZsjmkK
         GQrsW3IOD6ttaBgBi5RzJJ0kmB+TZ1bmKfZykvfyVz+T/2xZyQ0ir93kq6eYAaKP6s2Y
         SIjQ==
X-Forwarded-Encrypted: i=1; AHgh+RrRkVPR4d2QIgP5nusEuKuUpdDpsJQ8j4elPMU5PtOi3xWpPZs0yQhKII7HWiJuYKlDpNh7Yo4gx1YoRCOE@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+56ZHIox5T/aiGNS9vYnJ4PfADuQqCxpfA0QwDWWPfJ8QzwTO
	m5o3U1YNcblKYA+oDwgm5HisxIeNzA/0CXGrMRw7EEsnyzt9a7K/20z/gvGxuUcQ7wg=
X-Gm-Gg: AR+sD11SeMu5EBVHCujjN15NhXmPfzCj9p6Hvpvdssi71KTxzGs5/2GFWo2AyTqTPbV
	r76l/2N48u5ohv+cSjYPMrCOEui9hFQCYQ/zz9ycRrM8ZI2OKcWS8gkxMA/+q5qVRO5nlVt+mUi
	m6TPsmoMmstuHt344NfbvQbEJ+Vq+rzuH5jTHN69EZl/RFvHVdxcftOM0+8nchIjAjj8Z5xZSG5
	iY0S6ejDslg1sM4e88SAWxjl9P5OmJuET8SyqgU9mqzbJitYwY+UsnOBN7+U4ak85Bwv6ygDEJ4
	Ilkmrpq0FT1sxuTuGAVewfmhkqljuxZrtPY3JH+C4JRg6bfQpGIzmtCyRhFUZ1z0lNzaDGt/+k8
	EaQi1ZICjoyW72zAFVoYz54+/n9/TDMuiMktowfgiGGV/XwTa2+GXaLpN2l8X2SFkAZevo12LdH
	MjgMKqXxnmEkUaZFH0TXfdZpiuX1bS8OOALjDQFiM=
X-Received: by 2002:a05:6000:1884:b0:47f:9096:3c54 with SMTP id ffacd0b85a97d-47fb1ecc318mr2141112f8f.11.1785235591768;
        Tue, 28 Jul 2026 03:46:31 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:fc6c:f9a2:4a0a:6354? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c6e9a2sm59717727f8f.35.2026.07.28.03.46.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2026 03:46:31 -0700 (PDT)
Message-ID: <dfe25916-0f2e-44ed-8f49-d7448a0e28fa@suse.com>
Date: Tue, 28 Jul 2026 12:46:30 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] params: fix charp corruption on allocation failure
To: Jiacheng Yu <yujiacheng3@huawei.com>
Cc: samitolvanen@google.com, rusty@rustcorp.com.au, hannes@cmpxchg.org,
 yosry@kernel.org, nphamcs@gmail.com, liuyongqiang13@huawei.com,
 linux-modules@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260728085518.3865621-1-yujiacheng3@huawei.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260728085518.3865621-1-yujiacheng3@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/28/26 10:55 AM, Jiacheng Yu wrote:
> param_set_charp() stores charp parameters in allocated memory after slab is
> available, and releases the previous value when the parameter is updated.
> 
> The previous value is released before the replacement allocation succeeds.
> If kmalloc_parameter() fails, the setter returns -ENOMEM with the parameter
> left as NULL.
> 
> Failing zswap's compressor update before zswap is initialized can later
> trigger:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>   RIP: 0010:strcmp+0x10/0x30
>   Call Trace:
>     zswap_setup+0x3b1/0x490
>     zswap_enabled_param_set+0x5b/0xa0
>     param_attr_store+0x93/0xe0
>     module_attr_store+0x1c/0x30
>     kernfs_fop_write_iter+0x116/0x1f0
> 
> Allocate and copy the replacement first, then replace the parameter value
> only after allocation succeeds.
> 
> Fixes: e180a6b7759a ("param: fix charp parameters set via sysfs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiacheng Yu <yujiacheng3@huawei.com>

It makes sense to me for param_set_charp() to have commit-or-rollback
semantics. The set callbacks of other standard parameters behave this
way, with the exception of array parameters.

> ---
>  kernel/params.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/params.c b/kernel/params.c
> index a668863a4bb6..e4f2b71dde1e 100644
> --- a/kernel/params.c
> +++ b/kernel/params.c
> @@ -261,6 +261,7 @@ EXPORT_SYMBOL_GPL(param_set_uint_minmax);
>  
>  int param_set_charp(const char *val, const struct kernel_param *kp)
>  {
> +	char *tmp;
>  	size_t len, maxlen = 1024;
>  
>  	len = strnlen(val, maxlen + 1);
> @@ -269,19 +270,20 @@ int param_set_charp(const char *val, const struct kernel_param *kp)
>  		return -ENOSPC;
>  	}
>  
> -	maybe_kfree_parameter(*(char **)kp->arg);
> -
>  	/*
>  	 * This is a hack. We can't kmalloc() in early boot, and we
>  	 * don't need to; this mangled commandline is preserved.
>  	 */
>  	if (slab_is_available()) {
> -		*(char **)kp->arg = kmalloc_parameter(len + 1);
> -		if (!*(char **)kp->arg)
> +		tmp = kmalloc_parameter(len + 1);
> +		if (!tmp)
>  			return -ENOMEM;
> -		strcpy(*(char **)kp->arg, val);
> +		strscpy(tmp, val, len + 1);

What's wrong with the plain strcpy() here?

>  	} else
> -		*(const char **)kp->arg = val;
> +		tmp = (char *)val;
> +
> +	maybe_kfree_parameter(*(char **)kp->arg);
> +	*(char **)kp->arg = tmp;

Sashiko reports [1] that there is a pre-existing use-after-free window
between freeing the old parameter and updating kp->arg. However, this
issue doesn't appear to be valid because any concurrent access to
a writable charp parameter should be protected by kernel_param_lock().
This is documented include/linux/moduleparam.h [2].

>  
>  	return 0;
>  }

[1] https://lore.kernel.org/linux-modules/20260728075803.AA13C1F000E9@smtp.kernel.org/
[2] https://github.com/torvalds/linux/blob/v7.2-rc5/include/linux/moduleparam.h#L124

-- 
Thanks,
Petr
