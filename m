Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D854185935
	for <linux-modules@vger.kernel.org>; Mon, 10 Mar 2025 14:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741616910; cv=none; b=JGcHvSuvD9p7iahm4aAPcBLx/AIKaGFdXjG6e9GnnxwazvSZ01krwx9bUGQP4geBKJdPstJxzZ0iNGEwQ2sVevUyNG6hXwl2sdm7F7daCQ2dOrp1kjwoGsoyF8OZrjCTiXE4mF+ZqO4dVNAW9uSZx3VRry4uyOK5HnjM4CsWYnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741616910; c=relaxed/simple;
	bh=mUxr8tV+J39v5sJIyDi7gwzWKwiHLq/G9sSzT80R14M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jnge8gFjfgCtLLNn6lWw8Znaz75e5mGLlmY5muM4b/XaatMyVw8/3LyGQC2VMZ+kQ0i10zka8emoq17HCYD6DUoqmzGBYlLfE5J/DEa1Pd4dn9B/8kmB2xdkekGsKGXYuaeMpeWP/9D038s6//Tq+A+BCbZMtgnkNThcRVnSvCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FhJYsDsb; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FhJYsDsb"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43948021a45so36905835e9.1
        for <linux-modules@vger.kernel.org>; Mon, 10 Mar 2025 07:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741616906; x=1742221706; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DxFKqcaH57aKjAQ0XaA5Pil5eLcUjqDLmvmRoAiJI3Q=;
        b=FhJYsDsbL8cgfJyAnT+tIv+tyBHFCmzHjt0n0Lkfm7hQ/y6lwLt6jKqZmKBZCnKs7q
         KA1MwQYAIC6JW3HQfaa4IVzZsz9ovJFvSucP7WYPRDaZNA+/++3OFKPb/t3KSjgDbwSS
         EuIlcmZL1WS2k+EC32cQs60zA6EJ85HzuLS+TpTqiL8+I28opdQS2q7ePe0twAJUJeuo
         9RfZ663DZ/zaEEz05TJM70fUuWSRACdnmJ2rBHrd5TWFshgEk8KB3+JRphaKwSDeIq6u
         gfttESMUjfxJxaTcgLQbpXTjDs8tD6zVFWbb42cL5eRQS6CoWm+myG04qtRvUyhp35we
         Zgnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741616906; x=1742221706;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DxFKqcaH57aKjAQ0XaA5Pil5eLcUjqDLmvmRoAiJI3Q=;
        b=Gf1BrlFJsZiukGBDDogZvSIVRceQI5QXspE3NkqPwuOFjkU5ylp3rwO0juR9rtSnPc
         mGC9O4GiUohOTgy+HvY8jdgaVtqS+I9a6AE7V9LByL0E58XzrHmfUwMkmOdYKwfMuUT/
         AGr+xmOgUTuruUw+m1mVjr8Vu2p41doznnrMtv3SfeyA6Y5W/fq1d+siodTqySp2YRNk
         ItkCfdnWPPNz9rb6munyI7Hn0InVt2ifkqkvjDO0fG52CGmTK/95Snsl20SEbZ+lZTEk
         aR0W1YLlX+3/09V6AG934CxHV0pmuqKpyf2AJHXySJAm5bv71N93WflMHJ/LBUgOoEAz
         MsBA==
X-Gm-Message-State: AOJu0YxS0NllKgnPHwPrN7HkOtNvhUU6UdYJXFSXI9AINa6C34xZhq70
	MiRpKTbCVNP+5XYK5X534bh+jjeaOKaONd609zSqKViQlQUPG/qHvbmOoGgqcqE=
X-Gm-Gg: ASbGncv9YlED89Vty62vYkDEkCCZbjtABBXZZ9RFjIKq9juF6pfvW+HUI2EHGhuUsm9
	JfMpkBWce6t+r7tw58L6QMyoL7GnRfkHURe0iWL69YGhfAGA9+ICwrlR32e/B7pkpq5oBU3qOga
	w3MbAW0HZDxmIUNpTHuNY4DxEoP2aFnIuyyVAdFNG8+QdPma+OjpGPdOD6WzfK09paVCtMrISEb
	Pog5Da46kyPUswIPq9Sf+vkXyJmqOuWYnzEsQkKYvUmEIHEc/2BQRYGYcLqRw9rNrT86FuTy9YY
	Q7x8KhgPoPphUwoLcMEz3UnK80y9rrTh7+TED314Du8p92FH
X-Google-Smtp-Source: AGHT+IE+4QHFiFoY2UBkFTlo1Vi8vjiUNJSbf9WSyYSTNA76cegr6QrgXcYQam1NkTM+arlpReKFfg==
X-Received: by 2002:a05:600c:1990:b0:43c:fda5:41e9 with SMTP id 5b1f17b1804b1-43cfda54388mr18294685e9.31.1741616904718;
        Mon, 10 Mar 2025 07:28:24 -0700 (PDT)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c1031fdsm14691616f8f.89.2025.03.10.07.28.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 07:28:24 -0700 (PDT)
Message-ID: <2362aa50-67fc-4535-b0eb-26f50066710b@suse.com>
Date: Mon, 10 Mar 2025 15:28:23 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module: Use rcuref_t for module::refcnt.
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: linux-modules@vger.kernel.org, Daniel Gomez <da.gomez@samsung.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Sami Tolvanen <samitolvanen@google.com>
References: <20250309121914.pN6eBMvI@breakpoint.cc>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250309121914.pN6eBMvI@breakpoint.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/9/25 13:19, Sebastian Andrzej Siewior wrote:
> By using rcuref_t the atomic_inc_not_zero() and atomic_dec_if_positive()
> can disappear. By design rcuref_t does not allow decrementing past the
> "0" reference and increment once it has been released. It will spill
> warnings if there are more puts than initial gets.
> This also makes the put/ get attempt in try_release_module_ref() a
> little simpler. Should the get in try_release_module_ref() fail then
> there should be another warning originating from module_put() which is
> the only race I can imagine.
> 
> Use rcuref_t for module::refcnt.
> 
> Signed-off-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>

I'd understand changing module::refcnt from atomic_t to refcount_t, but
it isn't clear to me from the above description what using rcuref_t
actually gains. Could you please explain why you think it is more
appropriate over refcount_t here?

> -/* Try to release refcount of module, 0 means success. */
> -static int try_release_module_ref(struct module *mod)
> +/* Try to release the initial reference of module, true means success. */
> +static bool try_release_module_ref(struct module *mod)
>  {
> -	int ret;
> +	bool ret;
>  
>  	/* Try to decrement refcnt which we set at loading */
> -	ret = atomic_sub_return(MODULE_REF_BASE, &mod->refcnt);
> -	BUG_ON(ret < 0);
> +	ret = rcuref_put(&mod->refcnt);
>  	if (ret)
> -		/* Someone can put this right now, recover with checking */
> -		ret = atomic_add_unless(&mod->refcnt, MODULE_REF_BASE, 0);
> +		/* Last reference put, module can go */
> +		return true;
>  
> -	return ret;
> +	ret = rcuref_get(&mod->refcnt);
> +	if (!ret)
> +		/*
> +		 * Last put failed but can't acquire a reference. This means
> +		 * the previous owner has put the reference.
> +		 */
> +		return true;
> +
> +	/* There is still a reference on the module */
> +	return false;

The updated version of try_release_module_ref() no longer uses the
MODULE_REF_BASE constant and silently expects that it is equal to 1. We
could trivially get rid of MODULE_REF_BASE and similarly hardcode it
as 1 throughout kernel/module/main.c, but I assume the purpose of it
being a #define constant is for explicitness to make the code clearer.

I realize the new code cannot use MODULE_REF_BASE because rcuref_t
currently doesn't have functions to add/subtract an arbitrary value from
the reference counter. I guess this goes back to my first question about
why rcuref_t is preferred over refcount_t.

>  }
>  
>  static int try_stop_module(struct module *mod, int flags, int *forced)
>  {
>  	/* If it's not unused, quit unless we're forcing. */
> -	if (try_release_module_ref(mod) != 0) {
> +	if (try_release_module_ref(mod) != true) {

Nit: -> 'if (!try_release_module_ref(mod)) {'.

-- 
Thanks,
Petr
