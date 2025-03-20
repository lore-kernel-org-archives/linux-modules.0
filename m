Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC5522173F
	for <linux-modules@vger.kernel.org>; Thu, 20 Mar 2025 09:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742462577; cv=none; b=LYUR0K0pnKita0msxsDPum6L4Vk/f9yz/mGZPy98gO76AxoiLgEalAxDaPDJCyp7yJ8Rf6PujXzEnfbMI6eCUWgC4M7IHpW/0/wBdSW+4wEPejysgjdYvndIRHkufqTzx2sfmltHJ+FbqSd33KREUPRmFbyuRrVrq/o97Z/uEDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742462577; c=relaxed/simple;
	bh=v1HzjTFaFAns1qXAyZ3BA8WOSz6IElFgZDI4xKBb5Qw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F8fXO2i+hPq16qSmfW0pIoc6EsPzKuJ7PXvJ+a8MjjV9WnYHJTzX4TDR80zc0geWC6fmMgiwS9s0ztYcfsKHD7tDnQ30kpx9x0DJEO8I4LNOdCXPih4R/eVcu6BCW/wRAfyHbHO0nVf6s4pSSv/qk2TjTTkR61jRN5SapjGxEOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=J8X46BQa; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="J8X46BQa"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43d04ea9d9aso2228485e9.3
        for <linux-modules@vger.kernel.org>; Thu, 20 Mar 2025 02:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742462574; x=1743067374; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=myg67gk9wPhxLbBgzBdtkm9d24LaKIZKxjxSO7e8nL8=;
        b=J8X46BQayLn6KljvOk0Sc8yPh/qBtxKMIdJLUr6jtEte8vmoBJ24WEW8oyooDzkObB
         /edN/3FhrZ2zL6nQDw/o4PI/NNSUI3e68y2kERGg+fum8TTpDwPfS25gmm6W2vsxmqXI
         pEmbI8rM0TnlTgAsZESjJngs6UomGdHtLoSJR3yi5cTaPKtdtLjvTnUplN2YIDAs3I0Q
         Ub+tAeA6ru1NoCZLlxXn/+bkvR/Kcrw5mbcaHHK0ydgin/tT15gas9szddwnW+k3783K
         d/5aRsF5CzdjCUw6Si/CMy4ZMH3cAM570WVriteHjCxlG5KAPU25xPN7xlxBZD+odhJg
         bxAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742462574; x=1743067374;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=myg67gk9wPhxLbBgzBdtkm9d24LaKIZKxjxSO7e8nL8=;
        b=PWPSiDmjKVj+81WbOydV7X7KAcDow0xPxVyOvI48TYZzZle7ir89RqZVbf+VfQcLto
         Fpiqs2a1TCaBV/EIKW1KyraeqyIcRRLvdsPijkgxueAe7tqMFhCjbyRtJl51t1U+stQc
         zJi48B5JRfBw3IefTH19/1jCCVLpWaDgIw4nVaTTmoPlZMIaMRjLdRUNdW67woVoUt/i
         mqX98luFMyUqb/TOgpzte3ITZlSbq2P4D51ILSaggUMy4Tfl2KGgCXIKAoCAIzKUArwI
         Uz58JDBP652dMqXCIQVvh43BpcjXgWh6OKiRciyDsnSpck0j7lIpbpGa6oZ5P8xhT/hs
         ImlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdpCLH08YAH1MFQKQRpWJO9dFLuemYV9i6Akquaqu4r388U/DrV1UShN+m/s5DczPGNXkGqHDB3U8pvW8u@vger.kernel.org
X-Gm-Message-State: AOJu0YwCXBpPKrdh1Ig6nK+dwu3wfIAiT269PFbhIyTK4l0mUBbbFfL4
	FkL1pbXNAX8vAqyjw47+eaJRVV1FR0KYdOmpGUjdiIPzM9pqWcvcbeVjx9NjGfU=
X-Gm-Gg: ASbGncsleUJdrM/MQmJNKGqkJ3zsOcHGsSijOTpvt8AfPgmjuBCEo7KXjq7NYqvIqbC
	XkIHOEjHxqMtqv6581YVtJADIr1HzbTtFeKdppMLff1sN3Ps+evtqtvRRQNx+BbzeRMs+eHIN+k
	U4jLJFB/0dugvDWktnOZr/WrAnRs7oB6ida0T8ZOOYHq8HSS9YRjULJQcBR/2mL87/r9URijJPX
	vF9ybl4UnsvOHoySKVXFoho1DOxNpVOLn8d/eVP749C42Ct7kuo8pP3HH4AODBIawkl2FPFIQGJ
	/Ku7yfMwx/3Of9Orewt6jPqwVyo86SRHCHk/1cc0eBuLMQd5
X-Google-Smtp-Source: AGHT+IEMUCCcXqS90NjR0ffhPXJJO2ODfxWqE3skotURWyXG5oZbBCdgiIvZjGWPov7RW/+OZqmhDQ==
X-Received: by 2002:a5d:64c3:0:b0:391:3028:c779 with SMTP id ffacd0b85a97d-39973b03ebemr4709575f8f.45.1742462573769;
        Thu, 20 Mar 2025 02:22:53 -0700 (PDT)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb40cdafsm23399381f8f.62.2025.03.20.02.22.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 02:22:53 -0700 (PDT)
Message-ID: <ea258e7f-85fe-4dc8-8150-90c78b6e3962@suse.com>
Date: Thu, 20 Mar 2025 10:22:52 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] audit,module: restore audit logging in load failure
 case
To: Richard Guy Briggs <rgb@redhat.com>
Cc: Linux-Audit Mailing List <linux-audit@lists.linux-audit.osci.io>,
 LKML <linux-kernel@vger.kernel.org>, linux-modules@vger.kernel.org,
 Linux Kernel Audit Mailing List <audit@vger.kernel.org>,
 Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@parisplace.org>,
 Steve Grubb <sgrubb@redhat.com>
References: <b96c64d522cf1c46dce1b8987e83f2f41ff2e5ee.1742231027.git.rgb@redhat.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <b96c64d522cf1c46dce1b8987e83f2f41ff2e5ee.1742231027.git.rgb@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/17/25 20:57, Richard Guy Briggs wrote:
> The move of the module sanity check to earlier skipped the audit logging
> call in the case of failure and to a place where the previously used
> context is unavailable.
> 
> Add an audit logging call for the module loading failure case and get
> the module name when possible.
> 
> Link: https://issues.redhat.com/browse/RHEL-52839
> Fixes: 02da2cbab452 ("module: move check_modinfo() early to early_mod_check()")
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>

The change looks reasonable to me from the modules perspective.

Nit: Viewing the linked address requires a login, so I'm not sure it's
appropriate for the commit message.

[...]

> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 1fb9ad289a6f..efa62ace1b23 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -3346,7 +3346,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
>  
>  	module_allocated = true;
>  
> -	audit_log_kern_module(mod->name);
> +	audit_log_kern_module(info->name);
>  
>  	/* Reserve our place in the list. */
>  	err = add_unformed_module(mod);
> @@ -3506,8 +3506,10 @@ static int load_module(struct load_info *info, const char __user *uargs,
>  	 * failures once the proper module was allocated and
>  	 * before that.
>  	 */
> -	if (!module_allocated)
> +	if (!module_allocated) {
> +		audit_log_kern_module(info->name ? info->name : "(unavailable)");
>  		mod_stat_bump_becoming(info, flags);
> +	}
>  	free_copy(info, flags);
>  	return err;
>  }

Nit:
		audit_log_kern_module(info->name ? info->name : "(unavailable)");
->
		audit_log_kern_module(info->name ?: "(unavailable)");

-- 
Thanks,
Petr
