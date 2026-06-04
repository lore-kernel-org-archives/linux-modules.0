Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEEA495504
	for <linux-modules@vger.kernel.org>; Thu,  4 Jun 2026 17:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780593592; cv=none; b=u//Vb5cX3+wHZT9RDrzoA+Y9lyerwoTXhwi9LFTB+MeBTrNBRmFYz2wv+uU8mYij00vgmNBvzCyTUV5WDqEVosdIEFfJAvR2hIsGQB8zV2E6Jsdtfep7cpK0g+oRuqVmEqA3nVQO2i7iJL37jBkXg79JlJiIiT6qQL/55k/noTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780593592; c=relaxed/simple;
	bh=dYLsH/8LO/uLy/x+MUfB/fZEOkT7MzXcTrsqeBKbvZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rV5eRB/Xhd1mtxPYWie4oxT6akHcE4Fw7QYmwhImttnmpdOrtW6lQX8SV1BgAV8w6WiEcibf96iuEAqyUNsFrEwI5rynlCSy8mFPCjjr9mGxIZBJn6IoW7Ms2JwBP0l2cUQgyeMf6GiK2g7nsqinPWE/NogO2Nd6dIb/7YLNwEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QGqgzhP2; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGqgzhP2"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2bf237e1433so11960165ad.1
        for <linux-modules@vger.kernel.org>; Thu, 04 Jun 2026 10:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780593590; x=1781198390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DPB2+YubXzWxhd5apad+fcnPTslFyu1F87W6IEfa1EU=;
        b=QGqgzhP2QwHgoYt7T4UUTu+ufGKj2QLgj0Cv3QV/myJELCjNuviSGxTj9oCwWE35oT
         WsmTVuojMr/wqJZljCq/xXFiAZ5CNAakTsGyHezQ85nPY+VscfebGc1BkbFL82IeMRS6
         Gg1ewJtf44Y9qWqIFoMo4CiPooV2/yITivr4pLi5lkCCw8n5FhlfqtaKNL+xk6tqpMcP
         H7mGT8tyahPrJvRpqcFlwAT16MYEPw5fT809clhrvj2ubknZfIBF0KCGeKTJIgJMO1c5
         0iFYM21kBubR6RkuS2cnLfjyvL47BcPAQhruCaYDEO+z6iXQdVTbIbsDbLeXfS7z0PjL
         bWJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780593590; x=1781198390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DPB2+YubXzWxhd5apad+fcnPTslFyu1F87W6IEfa1EU=;
        b=dkIdoZsazh11zPnuMh3HG+kIu30HBzCmYhEdQKZSLm7yGQccABWGNztYrUDhLNG6Gt
         BsiNr8XHSbS9tIjZAmSTqYqAaFFDjvMZi1faHHSuLyuJfAbQctG5yuMxqeNAfwevVGVi
         OhCIapPY5KHhJ8CzQBmaunplJAGFjBWpm1JMdNs95e3wLU52lR0JEoDYj+Xfhaws7cQi
         cL2gWn/JdQ4BTHb3w8n3K0/fUOPpUHeTUfBDJoRZ1Nf1LB0PyHLaW5UikoKFkegne17M
         RA4qR49HGfN+SXm/znyg1PWN+z39uafBtGhxl4rkG0xj5dqv8RnPtLahHgK4tnvzaeOs
         9C1g==
X-Forwarded-Encrypted: i=1; AFNElJ8fJCEwLArtSx+cV/WHHDithY/0BMtLpsR4RFi8IB7gR8+L6dkMbPq6LcMdLx1a4yMZoWnn3g07RNNMTMr6@vger.kernel.org
X-Gm-Message-State: AOJu0YwMYcGUaUr54N9wG9lyKHDzscwUyv52GMFV+JAE/B0oCbDfGcLU
	2l3TUHNvxhU8od8VJB5XFuijVOzFuqFWy8pJYxwRq7ZqL7SHjDK0Zmi6
X-Gm-Gg: Acq92OFcQwPhh2zZr8sUSklOq/xJT4Y8L2lYtfV+Py+0ln15KIhDxWcrlQHRj5M15J0
	ldOGFVt27Sb0u457hrgvvDaEumBuZS0UYXJ4JAqWURFN2xDLVBSkuwIItGIyOzGVMWfYQNHGwO3
	suf4YAlJV7+zudjq5h5llUI+3VKF7BlaxryxtlTjGK4OGf6/gL0T3mY24i9UTTX1aMxHRjxCtv8
	H0TlxVKOu6hXgKQoZy8sDTiQATZSg3VeO3eK6zcnyjTZQC26sS06IC2K55fV3VsHS88ADiJU0l0
	3FsNmTI9wKtvUQXRhkRPeFrbPihHU8lSyzZ9RwVC3m0FsSN3KDGTjPYWnF5TSa7XF2g0DYHJS78
	4qC554sD7o9U0+fUEjoh/kSI8TBBZ5aurcqjJnW0kbUuRtRLAx9mRsIv4A+a9V0AeMI7jH3f3qv
	bbMHxZIpKyZxvzqRnJtZE2HKRO41BisUsiQzo=
X-Received: by 2002:a17:903:1a4e:b0:2bd:8dbb:293e with SMTP id d9443c01a7336-2c163a58d7fmr91444905ad.14.1780593589582;
        Thu, 04 Jun 2026 10:19:49 -0700 (PDT)
Received: from localhost ([2405:201:4027:a919:e2b2:8560:26ea:4d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e234sm66476235ad.53.2026.06.04.10.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 10:19:49 -0700 (PDT)
Date: Thu, 4 Jun 2026 22:49:47 +0530
From: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: mcgrof@kernel.org, da.gomez@kernel.org, samitolvanen@google.com, 
	atomlin@atomlin.com, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: stats: add lockdep annotation for
 dup_failed_modules list traversal
Message-ID: <afzfogkqgihkqga47jbwtp2azr5oxohkae7atlxj5m7fahlojw@qbcmtzfxn53y>
References: <e4za26n3jj3366oqt47hdwfze2rvsyjcujjhjj4jvbtihkleg6@kxasstqoia22>
 <2d797a44-bdd4-4b37-8bdd-2e2052c6dd38@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d797a44-bdd4-4b37-8bdd-2e2052c6dd38@suse.com>

Thanks Petr. Noted.

On Thu 04 Jun 10:40 AM, Petr Pavlu wrote:
> On 6/3/26 6:22 PM, Naveen Kumar Chaudhary wrote:
> > read_file_mod_stats() traverses dup_failed_modules with
> > list_for_each_entry_rcu() while holding module_mutex, but does not pass
> > the lockdep condition. This triggers a false-positive "RCU-list traversed
> > in non-reader section" warning with CONFIG_PROVE_RCU_LIST=y.
> > 
> > The warning can be reproduced by:
> >   1. Racing two loads of the same module to populate dup_failed_modules:
> >        insmod dummy.ko &
> >        insmod dummy.ko &
> >   2. Reading the stats debugfs file:
> >        cat /sys/kernel/debug/modules/stats
> > 
> >  =============================
> >  WARNING: suspicious RCU usage
> >  7.1.0-rc5-gae12a56ba16a #1 Not tainted
> >  -----------------------------
> >  kernel/module/stats.c:385 RCU-list traversed in non-reader section!!
> > 
> >  other info that might help us debug this:
> > 
> >  rcu_scheduler_active = 2, debug_locks = 1
> >  1 lock held by cat/128:
> >   #0: ffff80008288f7a8 (module_mutex){+.+.}-{4:4}, at: read_file_mod_stats+0x46c/0x5ec
> > 
> >  stack backtrace:
> >  CPU: 1 UID: 0 PID: 128 Comm: cat Kdump: loaded Not tainted 7.1.0-rc5-gae12a56ba16a #1 PREEMPT
> >  Hardware name: linux,dummy-virt (DT)
> >  Call trace:
> >   show_stack+0x18/0x24 (C)
> >   __dump_stack+0x28/0x38
> >   dump_stack_lvl+0x64/0x84
> >   dump_stack+0x18/0x24
> >   lockdep_rcu_suspicious+0x134/0x1d4
> >   read_file_mod_stats+0x554/0x5ec
> >   full_proxy_read+0xe0/0x1ac
> >   vfs_read+0xd8/0x2b0
> >   ksys_read+0x70/0xe4
> >   __arm64_sys_read+0x1c/0x28
> >   invoke_syscall+0x48/0xf8
> >   el0_svc_common+0x8c/0xd8
> >   do_el0_svc+0x1c/0x28
> >   el0_svc+0x58/0x1d8
> >   el0t_64_sync_handler+0x84/0x12c
> >   el0t_64_sync+0x198/0x19c
> > 
> > The traversal is protected by module_mutex, so pass
> > lockdep_is_held(&module_mutex) to inform the checker.
> > 
> > Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
> > ---
> >  kernel/module/stats.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/module/stats.c b/kernel/module/stats.c
> > index 3a9672f93a8e..a62961acd8e3 100644
> > --- a/kernel/module/stats.c
> > +++ b/kernel/module/stats.c
> > @@ -382,7 +382,8 @@ static ssize_t read_file_mod_stats(struct file *file, char __user *user_buf,
> >  	mutex_lock(&module_mutex);
> >  
> >  
> > -	list_for_each_entry_rcu(mod_fail, &dup_failed_modules, list) {
> > +	list_for_each_entry_rcu(mod_fail, &dup_failed_modules, list,
> > +				lockdep_is_held(&module_mutex)) {
> >  		if (WARN_ON_ONCE(++count_failed >= MAX_FAILED_MOD_PRINT))
> >  			goto out_unlock;
> >  		len += scnprintf(buf + len, size - len, "%25s\t%15lu\t%25s\n", mod_fail->name,
> 
> I mentioned in my reply to your previous patch fixing the use of
> synchronize_rcu() in the module dups code [1] that the overall RCU usage
> in this code appears to be incorrect. I also noticed that Sashiko
> reported the same issue. I think it is not very productive to try to fix
> these specific RCU-related problems and instead the code should be
> properly reworked. It most likely should not be using RCU at all and
> kmod_dup_req should instead be reference-counted.
> 
> [1] https://lore.kernel.org/linux-modules/ajydyxgaea27rhcopp5eauji24znotu65d2b4uw344yvmwcc6f@7l5re6f2xcuk/
> 
> -- 
> Thanks,
> Petr
