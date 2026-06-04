Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF74C380FD2
	for <linux-modules@vger.kernel.org>; Thu,  4 Jun 2026 08:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562424; cv=none; b=Ektc5no7Js3Ey5UfWUzWKvqZ7vOX+KQK91tO0UDjhxVN2wuvWsY3K7f8l/OmEY7xz5BnmjtyWLJ2/+hZLcwXEjJsmKzdcfRc0ReOiqjfX3W0xxsHRzNnm0iCMrBtwAAR1x5hkzYDU6H+TGOWWcnPwFRBOuOaxhB+lrLW1NZdgKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562424; c=relaxed/simple;
	bh=pM04+DXv91iBK7KQeCcP96RklqYpyYUmy5zuk4QLKlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tyLDlxzjHNmEaC5SOCAgbXKs0Ge5U8jPKwIo9TBeNKebNrhifGZRTxVUz1jTI0awy+C5X2cWDmio0MZeJ5KDuLOGpnWfUVQqo0R49tQVTSX2Wam8yUYqgwixRFP0SU92f8sw2nlcm0Rk3irTCl1tMAxt0aqzz7Y9RUNgAXjwBBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JhIqTjH5; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JhIqTjH5"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-490b4e1ade7so4586275e9.0
        for <linux-modules@vger.kernel.org>; Thu, 04 Jun 2026 01:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780562416; x=1781167216; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1jSbQNQtoiNgkf2FaJKbEgISgda9p9I20aht8csm5Xs=;
        b=JhIqTjH51avvYCDYH1v5xdMLAMRjuS2CYO+gbboupGISe3i3lu2HluPFJpjfD0Vqk0
         w2XbmUN4RPIlXi1IK2KaJti5EIpm7FcjH+DgrQBRcOxXJRUrVl7yRBWcD9cdBFYd2qt1
         QcBCbB4sDzYNtdJKs52pyhRMndupKHvQkTxPxOyz13KWG+lH2g8A15MBn8BSrMU5Dya7
         Z8FPcnLJuoKxp38adW0gOdvtCJ9PI7ue3DzaMHCdJsrQtF4nI4oBRWzyxXWidyWxHm+E
         xD3k4SFndKYzg/o6dgCfXSx1q4Kn6KSELUv1L/x1hq2sXi69I6zm2TDASrGm8Bs2Fd3/
         YW5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780562416; x=1781167216;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1jSbQNQtoiNgkf2FaJKbEgISgda9p9I20aht8csm5Xs=;
        b=KjobVNup0haqYCgGMRwzTB4AaYXVVzFA1Q0/YH8GefGP4EShBT3Xpma2l4RO0sXCnF
         fXHqNkWl9EBBZE0F1srmpt6K9GixZrijJVvQltgzI4naQ2MsWk3DVJ2/nyeF41B/qd/J
         H5iZbeBq2vrn8adxWPB7Xk6uXTtIuH1KCAE1OVVso5ZJ+1G5vw65iGFn/9iWSTit+nbj
         4JsoXk8zjFMlJPvg/kiqQ3CPUtr6EraSsWV2KY+mUeExkT/9bAyEzbORfPGEE/nR/4DI
         yyGga8lDjnTVtFZw7e7gB9nGCZ6vUrX/xar450lPmz6JBvkimptzr/uq4k1e0PvxIc+m
         gv3Q==
X-Forwarded-Encrypted: i=1; AFNElJ//xsWixd2ut2AthJ/RO/WYuNWzj0sw5e7DbKmnVucTj7+ihcNese/Of4XeFR6D4qR2cP3B2rClzo1FS4Z5@vger.kernel.org
X-Gm-Message-State: AOJu0YxfeeXiVpf+vIbqO0hlubM2Mtq2C22LRA4Np13NSl+XW8+xc9yu
	hvqbPbsn6gzCcWM1R/teWY6W5PwPgBWMk49BADWAKLxcaGz2Q1v7s9MD6LARbg1KDfk=
X-Gm-Gg: Acq92OFVciq06KOq/y8NxABVvaRX6JMJFsPTMbMDbAI70l9TRkZ+G/t05u4dqM6rA6Z
	8GZuF/Qk2+diPrHZuJ56BJbaXMsaQ1rnKOGu+dzc1i6I1nyaTrqkan45UOSz4QEHnPgotmYU9Nf
	6ddLkzxwyDyF+WzwB0dHIMOGAvV5URtz0Ri8UNEZnVNLYwa4z1OZ9UxmGM4eNJtUAEsgxjC9GaB
	jktm6ujb/MNgTlU7Fn8+HR20FeQw+3ikhnHGsJGtvOQloVjMv5/3AGqEMEI6DChHIcUAtogQtvK
	dUPM/j1b6S8MujS3kyfZEeYpJxEJr49BpLQw3FRv8oKhla+KLwNH4u17gI0fZmeYEcB/ABZkXmC
	qz8RXPmGiWBddaLXWb5Fj9sTquFco0i/XPMvQxxrV9LiZtg16Q1mWBfIoKJscGtm+hzvi0YkofK
	3Bsr9jcP3tS/qkqANr3ev8JpFaoG6a/X5KOs1VuHgUiX0LYlqu1xAan3RbbkA32zlwwfQ991B+t
	4g1M0Cto+flxzY6Zpxy5u74mzATNuM4DvQ6z7C/3QRJGqFW7rc4ENpbQ7KE0py2JgXfmvUqLP9b
	l6jG
X-Received: by 2002:a05:600c:3507:b0:490:be78:1861 with SMTP id 5b1f17b1804b1-490be8ae2d9mr20689925e9.4.1780562415986;
        Thu, 04 Jun 2026 01:40:15 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc391aaasm64262115e9.1.2026.06.04.01.40.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 01:40:15 -0700 (PDT)
Message-ID: <2d797a44-bdd4-4b37-8bdd-2e2052c6dd38@suse.com>
Date: Thu, 4 Jun 2026 10:40:14 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module: stats: add lockdep annotation for
 dup_failed_modules list traversal
To: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
Cc: mcgrof@kernel.org, da.gomez@kernel.org, samitolvanen@google.com,
 atomlin@atomlin.com, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <e4za26n3jj3366oqt47hdwfze2rvsyjcujjhjj4jvbtihkleg6@kxasstqoia22>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <e4za26n3jj3366oqt47hdwfze2rvsyjcujjhjj4jvbtihkleg6@kxasstqoia22>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/3/26 6:22 PM, Naveen Kumar Chaudhary wrote:
> read_file_mod_stats() traverses dup_failed_modules with
> list_for_each_entry_rcu() while holding module_mutex, but does not pass
> the lockdep condition. This triggers a false-positive "RCU-list traversed
> in non-reader section" warning with CONFIG_PROVE_RCU_LIST=y.
> 
> The warning can be reproduced by:
>   1. Racing two loads of the same module to populate dup_failed_modules:
>        insmod dummy.ko &
>        insmod dummy.ko &
>   2. Reading the stats debugfs file:
>        cat /sys/kernel/debug/modules/stats
> 
>  =============================
>  WARNING: suspicious RCU usage
>  7.1.0-rc5-gae12a56ba16a #1 Not tainted
>  -----------------------------
>  kernel/module/stats.c:385 RCU-list traversed in non-reader section!!
> 
>  other info that might help us debug this:
> 
>  rcu_scheduler_active = 2, debug_locks = 1
>  1 lock held by cat/128:
>   #0: ffff80008288f7a8 (module_mutex){+.+.}-{4:4}, at: read_file_mod_stats+0x46c/0x5ec
> 
>  stack backtrace:
>  CPU: 1 UID: 0 PID: 128 Comm: cat Kdump: loaded Not tainted 7.1.0-rc5-gae12a56ba16a #1 PREEMPT
>  Hardware name: linux,dummy-virt (DT)
>  Call trace:
>   show_stack+0x18/0x24 (C)
>   __dump_stack+0x28/0x38
>   dump_stack_lvl+0x64/0x84
>   dump_stack+0x18/0x24
>   lockdep_rcu_suspicious+0x134/0x1d4
>   read_file_mod_stats+0x554/0x5ec
>   full_proxy_read+0xe0/0x1ac
>   vfs_read+0xd8/0x2b0
>   ksys_read+0x70/0xe4
>   __arm64_sys_read+0x1c/0x28
>   invoke_syscall+0x48/0xf8
>   el0_svc_common+0x8c/0xd8
>   do_el0_svc+0x1c/0x28
>   el0_svc+0x58/0x1d8
>   el0t_64_sync_handler+0x84/0x12c
>   el0t_64_sync+0x198/0x19c
> 
> The traversal is protected by module_mutex, so pass
> lockdep_is_held(&module_mutex) to inform the checker.
> 
> Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
> ---
>  kernel/module/stats.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/module/stats.c b/kernel/module/stats.c
> index 3a9672f93a8e..a62961acd8e3 100644
> --- a/kernel/module/stats.c
> +++ b/kernel/module/stats.c
> @@ -382,7 +382,8 @@ static ssize_t read_file_mod_stats(struct file *file, char __user *user_buf,
>  	mutex_lock(&module_mutex);
>  
>  
> -	list_for_each_entry_rcu(mod_fail, &dup_failed_modules, list) {
> +	list_for_each_entry_rcu(mod_fail, &dup_failed_modules, list,
> +				lockdep_is_held(&module_mutex)) {
>  		if (WARN_ON_ONCE(++count_failed >= MAX_FAILED_MOD_PRINT))
>  			goto out_unlock;
>  		len += scnprintf(buf + len, size - len, "%25s\t%15lu\t%25s\n", mod_fail->name,

I mentioned in my reply to your previous patch fixing the use of
synchronize_rcu() in the module dups code [1] that the overall RCU usage
in this code appears to be incorrect. I also noticed that Sashiko
reported the same issue. I think it is not very productive to try to fix
these specific RCU-related problems and instead the code should be
properly reworked. It most likely should not be using RCU at all and
kmod_dup_req should instead be reference-counted.

[1] https://lore.kernel.org/linux-modules/ajydyxgaea27rhcopp5eauji24znotu65d2b4uw344yvmwcc6f@7l5re6f2xcuk/

-- 
Thanks,
Petr
