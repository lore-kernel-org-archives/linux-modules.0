Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B7325525F
	for <linux-modules@vger.kernel.org>; Tue,  8 Jul 2025 09:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751967586; cv=none; b=uxE+j2pTLPI6jHVbLrQgh4n7cbgLOQCXDw4RlAu6TbrtHMkP9QJAGUe3ie0C3RhrdOc+9rBaX6AUhdUC2wNwthY0xsVLr30XI33gfvdr8XRjWhYvTy0CXTG/vLIrcOLd3w+oYrOyvCmULcmyx5nPwLG9qlTcl+T7odLryAhs13U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751967586; c=relaxed/simple;
	bh=w0YOPULSSxvyU5kdaBpMpPOCESPVNkbbxq18LHihViE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HJLGSpWS4FXsa2LhEiVPxQZ2ZooCFCyNxotWWZcinIs+pYKmcwquu2rkGpMHsYKCK5s00+V50kyc+sgx+oInWUVnsBIQcMK6pigD7mZt6vicY+Q3yQosHaMnM+4qSMQgfD/nSP6dO/0VFGIHvxWrwrthMki4GCZsY4hrKIWfaE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Xecoq2Er; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Xecoq2Er"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a57c8e247cso3098015f8f.1
        for <linux-modules@vger.kernel.org>; Tue, 08 Jul 2025 02:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751967582; x=1752572382; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qVAMgZjiytlKTltSVRaWqREvVS7taIwAdxD4AMeAYLU=;
        b=Xecoq2ErBjmAYAGXuu+q/W1cz/PJD2QVwP090PJI1V2MJ+3aoM78ovIruXcmVMmhTx
         IXq5nahKH5S/qMlutsXt1hkuhfdoNiuXypDVlJ803whyQ6SrGqDDWVzkRe+9rsUbpakp
         8n6q3lhePAuk/88CBsgFEOFKLzWwQqMo0ioiY7beYlb1PCfE8t6S2k3kGuGR6st7xo4+
         vBaB91xI/lXWRDTutiomCLwhzdk0Y7/PCKDG3MwzWMikksiVeZZIXmnc4T4C6zfx66MP
         omkpn4CzmRkjOnOxhgfj7ZgQYj8/HhDRKI6Tn0zuVVWkOEEe5/rkc3Na0gyUhjUvVbj7
         ZMUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751967582; x=1752572382;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qVAMgZjiytlKTltSVRaWqREvVS7taIwAdxD4AMeAYLU=;
        b=dc85CaqwUJiMarLK+bBh249qSQ3J5FGcmtOyrVU2WtZ49u/Ltp7qZi5YX215gFgGG7
         jhAD0+0cA40IKZqSShgMuDjCRXM53ejsBDb4vNakxr0UPqQTB9j7J1s1dJGfjygNnsGn
         wfldwLx7EjpbiT/c/OHQY1XC7MpDtq13SnxIG6nJICq3jFzyKQqGSxsEgFkeBYQbFCmt
         +7SIp82MFQbavb4Rkn4ib12I9mUxihg5xVUO1f65sFZEQGSiRGmqcd7kZOrwQzQM3u3X
         p+MUHEdqFTZnvwK0duLRnZ8+95/XX937du6j7akaa5Gjn5GiQH+INrWMvK4d2e9SaeWd
         mlrA==
X-Forwarded-Encrypted: i=1; AJvYcCWG8KPVNri03/nbfL8jL79iqcdQLZ1LbIFk7k+Jog/0En113zN/g9AF+QBEKG10W76NBE54N5n2WmMVMBMo@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8nWtPkB+WCO2fENekAnUNtm2X9VwvIZxDCRwNn9S7xArhbOnv
	5Iq9csw+QmQ/0hk3vhbpLVjAPDJNqRDEYszHucznhjXtc+QsHmFdemetBbehVX07hys=
X-Gm-Gg: ASbGncuGiLEv/627rtzVxWn9EFVVIfyf5/31fJPuZE+5wcqfmzKqNJS4Bl312IkqlVu
	9ccOoHkRSxsGsyOlZzOy9BPFHx4Izk5TEFcNw3FHRUP/NrU+9X9TgDJQsDFzOu+ShSuHaSCI/86
	CJKq3AJYsvuCtOAVw43FpGHDuxlo1aYhCDptID8wVOdhMZxfrGiULvEyK37Y65mMWg1YLdTFSOp
	22UbJXouC8BXmzYDP7cXj9qQmPEurXVQuZ3Ter1bJ3UrQJ8mK/oGKFp1Hn/z81LhPL3x2opMBz7
	bZV2ekKF4oPFlY5q1+02GvaQuRaV1wYb5cC1so5YbcLXwbaq/cxgszHwcD4Iso5DFA==
X-Google-Smtp-Source: AGHT+IE8YM/OZ8CV631FC3za9fedEJqw2j98fUm8X6Ex7BoBBdzx8ToTsk4PmU9Yt2992ZZiuntlAg==
X-Received: by 2002:a5d:5f90:0:b0:3aa:caea:aa7f with SMTP id ffacd0b85a97d-3b497042696mr11914245f8f.56.1751967582242;
        Tue, 08 Jul 2025 02:39:42 -0700 (PDT)
Received: from [10.100.51.209] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47285c919sm12569553f8f.92.2025.07.08.02.39.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 02:39:42 -0700 (PDT)
Message-ID: <9e5669e5-fc7e-4297-b12f-ceb9dcf36d91@suse.com>
Date: Tue, 8 Jul 2025 11:39:41 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] module: make structure definitions always visible
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
References: <20250612-kunit-ifdef-modules-v1-0-fdccd42dcff8@linutronix.de>
 <20250612-kunit-ifdef-modules-v1-2-fdccd42dcff8@linutronix.de>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250612-kunit-ifdef-modules-v1-2-fdccd42dcff8@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/12/25 4:53 PM, Thomas Weißschuh wrote:
> To write code that works with both CONFIG_MODULES=y and CONFIG_MODULES=n
> it is convenient to use "if (IS_ENABLED(CONFIG_MODULES))" over raw #ifdef.
> The code will still fully typechecked but the unreachable parts are
> discarded by the compiler. This prevents accidental breakage when a certain
> kconfig combination was not specifically tested by the developer.
> This pattern is already supported to some extend by module.h defining
> empty stub functions if CONFIG_MODULES=n.
> However some users of module.h work on the structured defined by module.h.
> 
> Therefore these structure definitions need to be visible, too.
> 
> Many structure members are still gated by specific configuration settings.
> The assumption for those is that the code using them will be gated behind
> the same configuration setting anyways.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
>  include/linux/module.h | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 52f7b0487a2733c56e2531a434887e56e1bf45b2..7f783e71636542b99db3dd869a9387d14992df45 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -302,17 +302,6 @@ static typeof(name) __mod_device_table__##type##__##name		\
>  
>  struct notifier_block;
>  
> -#ifdef CONFIG_MODULES
> -
> -extern int modules_disabled; /* for sysctl */
> -/* Get/put a kernel symbol (calls must be symmetric) */
> -void *__symbol_get(const char *symbol);
> -void *__symbol_get_gpl(const char *symbol);
> -#define symbol_get(x)	({ \
> -	static const char __notrim[] \
> -		__used __section(".no_trim_symbol") = __stringify(x); \
> -	(typeof(&x))(__symbol_get(__stringify(x))); })
> -
>  enum module_state {
>  	MODULE_STATE_LIVE,	/* Normal state. */
>  	MODULE_STATE_COMING,	/* Full formed, running module_init. */
> @@ -598,6 +587,18 @@ struct module {
>  	struct _ddebug_info dyndbg_info;
>  #endif
>  } ____cacheline_aligned __randomize_layout;
> +
> +#ifdef CONFIG_MODULES
> +
> +extern int modules_disabled; /* for sysctl */
> +/* Get/put a kernel symbol (calls must be symmetric) */
> +void *__symbol_get(const char *symbol);
> +void *__symbol_get_gpl(const char *symbol);
> +#define symbol_get(x)	({ \
> +	static const char __notrim[] \
> +		__used __section(".no_trim_symbol") = __stringify(x); \
> +	(typeof(&x))(__symbol_get(__stringify(x))); })
> +
>  #ifndef MODULE_ARCH_INIT
>  #define MODULE_ARCH_INIT {}
>  #endif
> 

Nit: I suggest keeping MODULE_ARCH_INIT in its current position,
immediately after the 'struct module' declaration, because the macro is
directly tied to that structure.

-- 
Thanks,
Petr
