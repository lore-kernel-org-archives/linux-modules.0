Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794232055;
	b=KemT2DjwY8i3nSVYwm2OLUPo1g+zd+2YI8d66sJMLgFPLKEbZHVeMpDiAYDRMU8Ihypk
	 xvUwh9IKXYzpMUIWkgMO/q7zp3K6FPnXQI3MiQlZ2X5YRrvVLokBnzZM7nhOAzlyCVqZa
	 DpJarSAAs0TGjPyMBuuuonTZRFoGP3VSAD9e6102c/2TlC46BEclWmQss9AtH9h4HFs2P
	 PiS/aML69lIIuJBS9nRmQrInFbsO+veu2yczudfvOJRlGgWIyw4n1A+SxA9jimcKQQWtW
	 6ImLppfiMUGvzQD4XZiRUnbuI3aoedfeNhqgQ9BMAfEXgB/GdFVrq2XpPP++tCPmLCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794232055;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=C2U0969ScVYYtAYSRmO3+08a5jB4pOxymunLPcJsNN8=;
	b=Rj/qj8MpumemBAVwBAJBjTPM3OPPDafNIHD/Ga8MMYpZdcDDE6ujw3SUkPJ2HNDRF5Wy
	 xyr0JEjZ14RizQaSNXOXZSl7Mas5qlVJokTho/oqJmD6cFrMcjJsIe1Sht7mdaApINc1g
	 1Qjri+ziKssg1AZXRhiklrjoeiXIOJu6QD7NZ0eCW2WOBKI8OMzCglt+IBW48GsvmX9MZ
	 9RpvPXk8HXvp6LVyqwELvBW8xWO3xCSq5XIGt//K/Z0USKUvipvWZm6119RRuo8luTkTL
	 p0SE5XaIgcwFG0SXQ5/SYE1IZRc0nVzDv3fNoZrPLWlYwxq0Rpcr+B+xQ/KifuZqJDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Wlr6LMsO;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBFD606A322
	for <linux-modules@vger.kernel.org>; Mon,  9 Nov 2026 13:47:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DBFD606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Wlr6LMsO
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a20bde60a0so9754355e9.3
        for <linux-modules@vger.kernel.org>; Mon, 09 Nov 2026 05:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1794232052; x=1794836852; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C2U0969ScVYYtAYSRmO3+08a5jB4pOxymunLPcJsNN8=;
        b=Wlr6LMsODBqo/wrW/v8ywEqMF87AyeKYptSQJIoQ4TcGi2QEfKeQRi/1qU+4tSUqqm
         M7U1xZdUtuGjN5ywbl6Oe5ajIDSKksvOsDz0B6lOHCk6k5sDBm6D1q3tvWa4V4NOMv33
         lgV9IasN8gA8ZpirGwWUUXW6WWiNVHUrByvX/P+jaoH51QtVuviZK0qPYsFaIrGl5zZt
         nqFVKT3pAxZZt0QExo66Nfp5MEkCnMMPOQbnko1VDcmuBYVFcTKiYmsnh7L5mq94vAfR
         ivI2Qw9etXDzE4CA5KgdDJrnrnxicsGT+yVVtirENaLikgmC+xrRv/INy5+L4gr3rJCl
         0/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794232052; x=1794836852;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C2U0969ScVYYtAYSRmO3+08a5jB4pOxymunLPcJsNN8=;
        b=DppQwfr1u0TO/86DC/JWbhA22o4N/YTudBlexVUdiBxRMgbq52cBbjBE9IfA6uS75Q
         8FLAzKkgJHX6EP4Q2MXL9RlyK3lrVq62AoGV8Aush+k4Kf5kS7SKczn4uP3EyAHhCIpP
         KZ2/HCNwtTP8azqnXfm649WbxIzG97Ncl3jwJpU8TIMOqltO2Je8T/JtlESbMDqwDLyc
         LCn7+fmoIcBzcoW6MYITwOnjApmToqBjwEyUlaSIheU5j0q65jso92klnoJRWzzr7P1a
         hL9hohW7cP4Ni+9oUX4zkm5lWqPw4oQbXRG/8v2E0KbTMKKZP+OyY68uUVuWb3Uaf+Zl
         4/ZA==
X-Forwarded-Encrypted: i=1; AL+hErHS6WXVAiQYcXN7lQr74BX6W/p83SDekC23nAGZJxJyoHriDRrCaeezvVqt8C0I5zSJZOcSZSIYbAZEdQnS@vger.kernel.org
X-Gm-Message-State: APuU4Z/l9VB9IPY8XZf9STm6t0/lwEw0k67v0637ItMZmEF7Yu/4OrEH
	a5KPrKAkDs2CakXQV05ej+Iv6KzpukBF3gSVrGCDYo27ILfO7fFiuMiRDcRUk2chPvY=
X-Gm-Gg: AYBFou3RC5+w2Jt/PuwEoqe3HhwSJQwKl13X8o9H+BxohTdGkDIhDUkkdsZP1U/sq9N
	EpTdKuUx6C2RmeyhSacsCtd5vFrPFE7bt1MxhSj7lC5bw8UgOrin8e3UYJgNLvY71o2aMmjLIW4
	bxTVJ3BcYGP36ne5HpqZnJn2a0SsFIW+serp3iHKDIRvLmzfDFnRpWO3GMm4G3I4tN9HR67O3wp
	WXnRi2r33dzqS/QprTis+yKRXM/vypJ4+xlRydx06xrnH6jR4VWK7lrW4zZGBZYw4d/fclsHc+c
	gxUH+yMuYg8X/Mp2GXfNCa8BmwdiB1vfW8K8jpBr3FJi+yHzsnbo9ym5MM+tHZNgc5bcO0rDawy
	K6Hs/p/IBCEHLyxa2c0b+byBZr7CZhiYiLhhmFU2Uo77beifgZga+84WcPjW2Nha6tSuW60Dx/N
	VDZRMXDgi5BhGwTbrW5De50kfYDmCZ8juL7nU2bAmca3J8g0H1C5rQDH1hxeoTZmLTDAJqDwZfg
	1GzIiuHdiOiwxVu2ei4upB5G5S0z0dYnHWpj+KhJNmHmCx1qea6nQDCBX27g5Py7mddVQ+Wgbj+
	l9iIkFHtmg926eaOjrqwnIA8MyrudEjoWzWhUnjnhrtCDkdo4EGhTdCtDrK1GPn8
X-Received: by 2002:a05:600c:8b70:b0:4a2:fd2:985d with SMTP id 5b1f17b1804b1-4b963c73ab1mr77214205e9.12.1794232052530;
        Mon, 09 Nov 2026 05:47:32 -0800 (PST)
Received: from ?IPV6:2a07:de40:8100:0:89a9:fd0e:583d:4a53? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b96cd012e1sm129149595e9.8.2026.11.09.05.47.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 05:47:32 -0800 (PST)
Message-ID: <2fd1031c-7a86-45cc-a595-bbd13e102d43@suse.com>
Date: Mon, 9 Nov 2026 14:47:31 +0100
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] module: Fix use-after-free in module_put() tracepoint
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: mcgrof@kernel.org, da.gomez@kernel.org, samitolvanen@google.com,
 da.anzani@gmail.com, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261022184517.66438-1-atomlin@atomlin.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20261022184517.66438-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/22/26 8:45 PM, Aaron Tomlin wrote:
> A use-after-free condition can arise in module_put() should a thread be
> preempted immediately after decrementing the module's reference count
> while the module is concurrently being unloaded.
> 
> In module_put(), the module's reference count is decremented via
> atomic_dec_if_positive() before the module pointer is passed to
> trace_module_put(). Consider a scenario where CPU 0 decrements the
> reference count without reaching the baseline MODULE_REF_BASE level and
> is immediately preempted: it relinquishes its reference while still
> retaining a local pointer to the module. If a concurrent CPU 1
> subsequently drops the final active reference, the module's reference
> count reaches MODULE_REF_BASE. This permits the module unload sequence
> (via delete_module() or the initialisation-failure tear-down path) to
> proceed and invoke free_module().
> 
> Function free_module() invokes synchronize_rcu() and subsequently
> releases the memory backing struct module via free_mod_mem(). Because
> CPU 0 was preempted outside an RCU read-side critical section,
> synchronize_rcu() does not await CPU 0. When CPU 0 eventually resumes
> execution, it passes the dangling module pointer to trace_module_put(),
> which dereferences mod->name and mod->refcnt, culminating in a
> use-after-free. This sequence of events is illustrated below:
> 
>     CPU 0                                       CPU 1
>     -----                                       -----
> 
>     module_put(module)
>       atomic_dec_if_positive()
>       [preempted]
>                                         module_put(module)
>                                           atomic_dec_if_positive()
>                                           // drops final reference
>                                         free_module(module)
>                                           synchronize_rcu()
>                                           free_mod_mem(module)
>       trace_module_put(module, ...)
>         mod->name
> 
> Resolve this by moving trace_module_put() prior to
> atomic_dec_if_positive(). Because the caller holds an active reference
> to the module at this point, the module structure and its name are
> guaranteed to remain valid throughout the tracepoint invocation without
> requiring preemption disabling or RCU synchronisation.
> 
> Fixes: cb0b50b813f6 ("module: Remove preempt_disable() from module reference counting.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>

This version #2 looks ok to me. I plan to pick it up on the modules
tree.

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

The additional version #3 [1] seems unnecessarily complicated to me. It
is ok to report the value of module->refcnt before it is decremented. As
noted earlier, other code, such as xfs_group_put() and objagg_obj_put(),
takes the same approach.

[1] https://lore.kernel.org/linux-modules/20261103163103.13195-1-atomlin@atomlin.com/

-- 
Thanks,
Petr
