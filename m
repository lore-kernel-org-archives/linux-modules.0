Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EB63E1D1A
	for <linux-modules@vger.kernel.org>; Thu, 23 Apr 2026 09:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776936874; cv=none; b=UM8t4IofYGcdhVmqX0aJtDc9ii84wfJh2DU/PHlEhq4F8UyD2lDxQTtGKBEReU7yzWlRYyBECXn3VcsXyFU+Sr7c6K2Z1XmmpEneV7WT8huAmc4DzypypqHcoYO2/Nky+p9fuXcLVjfARQHmwis95+l/xwlVZxhTMOjIfriuZco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776936874; c=relaxed/simple;
	bh=uNBIefZDxhBdTplR4Rutsfb3Br0hvsb2IXlHcCoomHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GYgf+c+wksccoO2r/m4ac17Be+Li8B+JvZ1CgAJwQyMb+Gt/YzHM+NpZ1HCA4ccwwLm04IRNIL/qv5UKkIbTUIOypZHB61/2qzrK0GI/qPCzQFzBxiMl4fnJP26RDIGCkjBuv5ubztuaR4Woqo9/5SLRA770TZDSYmtHfq7b1ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=T4Qy0KrI; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="T4Qy0KrI"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso65578955e9.1
        for <linux-modules@vger.kernel.org>; Thu, 23 Apr 2026 02:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776936871; x=1777541671; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nlLH7AnUkh/yIK3b4miCcJ1QsnDeuZTPALrNv48Gw7Y=;
        b=T4Qy0KrIvqvZQP6GGvdG1AgYTCoO/YXqdNqENF6ULXdciv93zS2QsDbPp9rbvo8IyA
         +hsrdLosjspwO/5ruU9OkNftvl9yYt4wfK4WwvgHfr3mDsTkZwXq/7c871hMngRNNC/V
         P7G4NHE+DUtvgywwp7jOFHR5iwzwXY5GctZdKmFdrIq3VAhW+WV0mDD5NTsmwlidjAgV
         Y3HKwdcH+nlH/71cms+O1l3g/Bu5UlHpbwbRtQ+dizCFS23EtBXFf41xCcF4TY+6xJ89
         28LW00/uIO37+bh5RTNyOSXUOzQAFaxqkM7JukILc3WIerHR1izoRjJkxhCMXQRoySnu
         Opvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776936871; x=1777541671;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nlLH7AnUkh/yIK3b4miCcJ1QsnDeuZTPALrNv48Gw7Y=;
        b=GV5tvl0wTZhdLk7AZ9zZg+JgKfnpHHArPext6ozU4DySBdPnDamR+w65xrAvKisDco
         DbyvqZP2uHycukuGdHdHTXMlSXE9MS6KEbNMQtU3IEtq8st4wpraKL5rnf/Dp/Qa0eAA
         fAnTXZiH9bplJ9sxy9rBUrM3tJtbGC2kSeDJdLkMawgmokVzXjqQIKHejQUCDn4kIy6K
         AlQz7ohgWTew4+aNlvN02k+fZtz/OYO77alQg6yj9MqX93VjlcdgPM3jbsJVThn6/noj
         RdfOA5AGpSiWke9djUzXryr/5sqDFpX02CKiV+4EAa64E5mNpQLND+ZfzsVS4JjZqyCQ
         IKLg==
X-Forwarded-Encrypted: i=1; AFNElJ9q4c8pP7WA43EHeSZAWK/nk/hc5fA87Ei+vu4+w14+TB/rFbqok43bLYg6xR4qci+95q12642atnijOZ50@vger.kernel.org
X-Gm-Message-State: AOJu0YxTPHTBPWOS47rTBffxa0zA/4byXFEX2mqMjwvBICmzPAuMM+M4
	oHNuYucurt4P8IPZVV0EQiFiWkxruyxqdUxKiWkRByoZFwZx+L4kDm4Kl8DgzWgP3i4=
X-Gm-Gg: AeBDietcr+vjy7qM+WfclBb9fjedwjc3guj2ah64ghELibZNPSQflfTmGSFKPuS70i0
	s4fZv5uuTjxpzPt0PL3PN8Q3UwZW6WUPtgf1HgXQ9p8zNzy/vV9ON2KDHGWqcbChJfcodyCDXVP
	mVXh/ZvPk5bPrYKFyB7MQqjNbLf9Oguf1x4D/n94nmZjjhrs09k4XjD87xv6Z/0Q5bN0p9HlJgJ
	v3qxz8Kp3OuatZnWXJLBR+BODBMJzG/QBsJSPf2VV/IoD6lPw/OAAs9w4uglfHgKRIPxVQD7qtR
	RCc3UNywWqO9ZJcd7R4gGB47MKllpo2zfwhICdeOAkr9AaNACW5RdywrcXo2tz6rJPeP7CUJ4PX
	CzhxowTubhrZtzcms28LpyWAS+xq06naiVkFb7cWrBmyaEsBJvTYxpwL07K0SYCE/W+apKVdDIP
	R+/xrnFcPwzAKOdkVw9AqGMaJA9VKi0ZptWwYVO7PAivs+BwQ+VgXEbmg=
X-Received: by 2002:a05:600c:1d05:b0:489:1baf:8c03 with SMTP id 5b1f17b1804b1-4891baf8d2cmr224085135e9.11.1776936870253;
        Thu, 23 Apr 2026 02:34:30 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-489fec8f7cbsm237232245e9.11.2026.04.23.02.34.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 02:34:29 -0700 (PDT)
Message-ID: <3df70252-1a11-4360-8803-8a093c12ac75@suse.com>
Date: Thu, 23 Apr 2026 11:34:29 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] params: bound array element output to the caller's page
 buffer
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Daniel Gomez <da.gomez@samsung.com>,
 Sami Tolvanen <samitolvanen@google.com>, Kees Cook <kees@kernel.org>,
 Aaron Tomlin <atomlin@atomlin.com>, Dmitry Antipov <dmantipov@yandex.ru>,
 Thorsten Blum <thorsten.blum@linux.dev>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260417075042.26632-1-pengpeng@iscas.ac.cn>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260417075042.26632-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/17/26 9:50 AM, Pengpeng Hou wrote:
> param_array_get() appends each element's string representation into the
> shared sysfs page buffer by passing buffer + off to the element getter.
> 
> That works for getters that only write a small bounded string, but
> param_get_charp() and similar helpers format against PAGE_SIZE from the
> pointer they receive. Once off is non-zero, an element getter can
> therefore write past the end of the original sysfs page buffer.
> 
> Collect each element into a temporary PAGE_SIZE buffer first and then
> copy only the remaining space into the caller's page buffer.

The underlying issue is that the kernel_param_ops::get() callback only
takes a pointer to a buffer where the result should be stored, with the
implicit knowledge that it is at least PAGE_SIZE in size. The params
code apparently borrows this from the sysfs code, which is
understandable because only sysfs can currently print module parameters.

Nonetheless, the question is whether it would be better to rework the
kernel_param_ops::get() callback to also include a size argument. This
modification would prevent the copying in param_array_get() and having
an explicit size is generally a better interface. It could also be
useful for Rust integration, even though the current code doesn't
support reading module parameters via sysfs. However, this change would
require more work to update all current implementations of this
callback.

-- 
Thanks,
Petr

> 
> Fixes: 9bbb9e5a3310 ("param: use ops in struct kernel_param, rather than get and set fns directly")
> Cc: stable@vger.kernel.org
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>  kernel/params.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/params.c b/kernel/params.c
> index 74d620bc2521..8910daa12816 100644
> --- a/kernel/params.c
> +++ b/kernel/params.c
> @@ -475,22 +475,34 @@ static int param_array_set(const char *val, const struct kernel_param *kp)
>  static int param_array_get(char *buffer, const struct kernel_param *kp)
>  {
>  	int i, off, ret;
> +	char *elem_buf;
>  	const struct kparam_array *arr = kp->arr;
>  	struct kernel_param p = *kp;
>  
> +	elem_buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
> +	if (!elem_buf)
> +		return -ENOMEM;
> +
>  	for (i = off = 0; i < (arr->num ? *arr->num : arr->max); i++) {
>  		/* Replace \n with comma */
>  		if (i)
>  			buffer[off - 1] = ',';
>  		p.arg = arr->elem + arr->elemsize * i;
>  		check_kparam_locked(p.mod);
> -		ret = arr->ops->get(buffer + off, &p);
> +		ret = arr->ops->get(elem_buf, &p);
>  		if (ret < 0)
> -			return ret;
> +			goto out;
> +		ret = min(ret, (int)(PAGE_SIZE - 1 - off));
> +		memcpy(buffer + off, elem_buf, ret);
>  		off += ret;
> +		if (off == PAGE_SIZE - 1)
> +			break;
>  	}
>  	buffer[off] = '\0';
> -	return off;
> +	ret = off;
> +out:
> +	kfree(elem_buf);
> +	return ret;
>  }
>  
>  static void param_array_free(void *arg)

