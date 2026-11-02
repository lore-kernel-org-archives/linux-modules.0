Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793631170;
	b=uPhbS/E/ggnMh1vpnKt5G42bRFoKMqalUWugKFSBYDJfEUCN6ruz/QgmOJI6SlAqUm9u
	 islb4Y58aBQSX0R08K3KnX51HWcnOy625PUNF/OcKUvu1T7UO9xI8xXPrnzGIBD+Q3DMj
	 EaPe8wJMdNfZ1e9Lye+5AsYL2y2ZgGHTO2qFjVgEcalBo/kDveVpbmoSHpAC20eA2xYai
	 qhEoq4hDteRkFLdgSuSRO+irH8NF4hEOzv+tY4ZVi9pv+zpMfdJVfz/gCGlEjg5yZiDnm
	 vuhJLz0UKA39cdjAazErT8DAoOZDchUl99kGiG6e/ndNZKldLvmkTlTA2EOGRVUKXJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793631170;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=DnZiEBAI8KR9amAjTpP9uVPbbO7v77L7Fo7uDbqMnxs=;
	b=Evs40FlO07ecxYhlICsMFpDUjlzlF3xyDd+D209GLFq0k0LnZxT92vaWsoUQDYXPqqRe
	 Tp+ghhjxPXUtAXVlmdQdFADfH4G0O0rdLuT+Sc7L5cuvBpYjkejHEGCScmYw/78waUoLN
	 E+xnbWkAweyJqmdi0NDCgV+Wu/4PuThhhOT8v3V7HSC9nrtL8oi7qLdWXjzdA1A66hwqZ
	 1oNkTuADFDXjbiCO4dYhq6OfPCGp/EIC/t6NYrciFe1L9aA+pSEc4JQBqvDy6Vx75E3+H
	 Af6zzCJoYVHnVue6oaG2ed0FxMqE+C/XD3pvbNWYwHXjweUn614YVgUv111SnPa/PqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b="Co/5Vhq/";
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62801606E01B
	for <linux-modules@vger.kernel.org>; Mon,  2 Nov 2026 14:52:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62801606E01B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Co/5Vhq/
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48e00eee27dso1531398f8f.0
        for <linux-modules@vger.kernel.org>; Mon, 02 Nov 2026 06:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1793631169; x=1794235969; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DnZiEBAI8KR9amAjTpP9uVPbbO7v77L7Fo7uDbqMnxs=;
        b=Co/5Vhq/L8JGGMRN8JLdcMJBKEF/RQ/Lhi9x+AnQwA6LyrEfV25iJj/fXIjEYgpLpQ
         iipaN/pRR+jXeHb19XI8ny1xA+FnMA18B6ZBXoMTzhs0wH1LFqxJI6UpjlYKszLe8PLd
         VxnnbYspqt379w0JGGojHDTAiOskyLIpVh7iTvbFs/wxgDa4Rrx27SwjIYnLMHjSQFOS
         8J7CRDUAtLNHo/d06OZ8EfLlzFtBpM2NVxVo4x83RXyZfzq8bfBHK7SCDhBE95peArhQ
         f7Udn00wyKgRw9eBcbE3WEAz6rFTMDHDcXZlCCHCtVKqvGj6riTMEmJ5UbVVaRcK246Y
         L7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793631169; x=1794235969;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DnZiEBAI8KR9amAjTpP9uVPbbO7v77L7Fo7uDbqMnxs=;
        b=vGdhp9HXAoR6yuXrGCj94oJvSEaxU5XA0/YL1D6t/FZ0r62RPYeCxjJyHO2zWnUCln
         16+UBRt88JcgK5RSlE8qONiWnV72IhO/RrxfzYDcXxI4BLjfm3q8NT7ycThiHEQTGjC1
         awC0buRwmxB/TfGeieu6IkUrxVkcO+g4luCTg9z2JuKvRpHQk8/wzEFDFee0Ejuq26tn
         XKYefZI1K6cIyVcDmW7NH67L0n/Z/0ucno9SW0EpImaZsyLilFLvnQhuByhAlT1Tbbu/
         IXKUK6YldnElumBMjJilDQqz31U2Kcty8l75bxgpH2y0WYnkeHJfGiUn5JcsstEKZ1na
         yUbQ==
X-Forwarded-Encrypted: i=1; AKwUvBxL0Pnm65l0cvx6HZKmJb9OUIbCHwv7tKVF+TaXn1eFaefYLbZJNF/yeXiS+iJ7dl7xXzxtEbGsqbHQlKeH@vger.kernel.org
X-Gm-Message-State: APuU4Z/eSIGPDsgvLlZHj89fyLeoPqi5itlowgjRtOiS3YgZMTRlcXxr
	y1K1abvDyaVN3qmdBfOXzi74yYSvG89J5q5u+JOT7VN5xcpV+c173lMAMfruP4hVVEI=
X-Gm-Gg: AYBFou0klqAXEgnQgpfa1IW2uKnKpHj2ifMtXGg8gdSw7jofZYS6DyCaC+U7/mZ3vhW
	PMexkXmq6CFI2kwrDS2scsZoYoesNC6KNj1/58WJdTysm4+KewKDI6FsPnIQzeJrDv8frsCpGLX
	QGTrXLBMldMMDni1v4X4oQYszosKTrU7dP0Y3tvJS+EX3Y85+Ujm6KkLt8pDS8QiYzpfUh+v/ZF
	ZtzWv2OJAPu7mLnYX6bxZMpao9iu283wDNoSHBEneTv2ie1Knp3eb8Rfrd79v/X/g8n4PdtHHkQ
	tyVnxCq9R1A4DcG3jnfHqtkZViZxzpoBSO4swn2VDByr4C4Ph2FxxU5MMwcqol9HcNr8nD2A1NZ
	yJLkPxWTjM0otsO0V6tz/5AX5iJ2LtyeVuxmZnKPfIrcoLdVvu4h+7o4M3HXFTvkM25qURmSmI7
	Ud50xhEmkj/alMecL9OBRD6cMRiuRNQPdFI5O0RucsaoW1BH71YAkEtL582GJBzoA+I+puWhsBM
	1jndib6TV5Tb5LbjYGk+POgTPa4ar14N/6fSgb1jmC2sh03mBkg5DDSjQsRvhxU+Enw5XU6yIIH
	PiLybp32rN/Fpp8dhmxwkfiyN2JoVmzY6y7M0BlKu0YJJV+Suej8h1Dveg5wC5AjNFPjOeYPN5K
	Z7XK56BtuXg==
X-Received: by 2002:a05:6000:40dc:b0:48d:e61d:68da with SMTP id ffacd0b85a97d-48e6e2fa50dmr24136852f8f.20.1793631168401;
        Mon, 02 Nov 2026 06:52:48 -0800 (PST)
Received: from ?IPV6:2a07:de40:8100:0:89a9:fd0e:583d:4a53? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b78a4csm20266085f8f.23.2026.11.02.06.52.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 06:52:48 -0800 (PST)
Message-ID: <cbf60391-ebd5-4e3d-b38d-45b8d86d1574@suse.com>
Date: Mon, 2 Nov 2026 15:52:47 +0100
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
Subject: Re: [PATCH] module: drain external refs before freeing a failed-init
 module
To: Mahanta Jambigi <mjambigi@linux.ibm.com>
Cc: mcgrof@kernel.org, da.gomez@kernel.org, samitolvanen@google.com,
 atomlin@atomlin.com, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 pasic@linux.ibm.com, =wintera@linux.ibm.com
References: <20261007083956.2488796-1-mjambigi@linux.ibm.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20261007083956.2488796-1-mjambigi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/7/26 10:39 AM, Mahanta Jambigi wrote:
> When a module's __init makes it externally reachable (e.g. by registering a
> protocol family or a bus driver) and a later __init step fails, do_init_module()
> frees the module while callers that entered through that interface and called
> try_module_get() may still be executing module text.
> 
> The normal unload path in try_stop_module() refuses to proceed while
> module_refcount() is non-zero. The init-failure path has no such check and races
> to free_module() immediately after synchronize_rcu().
> 
> Fix it by waiting for all external references to drain before calling
> free_module(). Add a per-module struct completion refs_gone inside the existing
> CONFIG_MODULE_UNLOAD block that is initialised in module_unload_init() and
> completed from module_put() when refcnt drops back to MODULE_REF_BASE and the
> module state is MODULE_STATE_GOING. The fail: path calls wait_for_completion()
> (guarded by the same #ifdef) after dropping the loader's own reference,
> replacing the previous implicit assumption that no external refs exist at that
> point.
> 
> Also move wake_up_all(&module_wq) to before the drain so that concurrent loaders
> blocked in module_patient_check_exists() are unblocked immediately once
> MODULE_STATE_GOING is visible, rather than after the drain completes.
> 
> Fixes: 1fb9341ac348 ("module: put modules in list much earlier.")
> Signed-off-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
> ---
> Link: https://lore.kernel.org/all/5dc1fe2b-289e-4786-b9e9-e181dda8d4e9@linux.ibm.com/
>       [RFC] module: init-failure path can free a module with live
>       try_module_get() users
> 
>  include/linux/module.h |  2 ++
>  kernel/module/main.c   | 33 +++++++++++++++++++++++++++-----
>  2 files changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 96cc98568eea..0dee2ed02a2d 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -562,6 +562,8 @@ struct module {
>  	void (*exit)(void);
> 
>  	atomic_t refcnt;
> +	/* Completed when refcnt drops to MODULE_REF_BASE on init failure. */
> +	struct completion refs_gone;

Having a per-module completion that is needed only during module loading
is a bit wasteful. I think a global waitqueue, similar to module_wq,
should be sufficient. This would also avoid the use-after-free condition
described in my next comment.

>  #endif
> 
>  #ifdef CONFIG_CONSTRUCTORS
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index c1b34dc1e89a..655c693bd8e2 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -655,6 +655,7 @@ static int module_unload_init(struct module *mod)
>  	 * refcnt == 0 means module is going.
>  	 */
>  	atomic_set(&mod->refcnt, MODULE_REF_BASE);
> +	init_completion(&mod->refs_gone);
> 
>  	INIT_LIST_HEAD(&mod->source_list);
>  	INIT_LIST_HEAD(&mod->target_list);
> @@ -956,6 +957,14 @@ void module_put(struct module *module)
>  		ret = atomic_dec_if_positive(&module->refcnt);
>  		WARN_ON(ret < 0);	/* Failed to put refcount */
>  		trace_module_put(module, _RET_IP_);
> +		/*
> +		 * If refcnt just dropped to MODULE_REF_BASE and the module is going
> +		 * away due to an init failure, all external references are gone. Wake
> +		 * any thread waiting in the init-failure drain path.
> +		 */
> +		if (ret == MODULE_REF_BASE &&
> +		    module->state == MODULE_STATE_GOING)
> +			complete(&module->refs_gone);

module_put() can run concurrently with delete_module(). The module might
be gone after the atomic_dec_if_positive() call so this logic could lead
to a use-after-free.

>  	}
>  }
>  EXPORT_SYMBOL(module_put);
> @@ -3206,16 +3214,36 @@ static noinline int do_init_module(struct module *mod)
>  fail_free_freeinit:
>  	kfree(freeinit);
>  fail:
> -	/* Try to protect us from buggy refcounters. */
>  	mod->state = MODULE_STATE_GOING;
>  	synchronize_rcu();
> +
> +	/*
> +	 * Unblock concurrent loaders waiting in module_patient_check_exists() on
> +	 * module_wq. finished_loading() returns true once state is GOING, so they
> +	 * can now proceed. Do this before the drain below so a failed init delays
> +	 * only this task, not every other loader that raced to load the same
> +	 * module.
> +	 */
> +	wake_up_all(&module_wq);

This wakes up only modules waiting in module_patient_check_exists().
However, most duplicate loads using the newer finit_module() syscall
wait in idempotent_wait_for_completion(). They should be woken up as
well, so at worst only the current load gets stuck waiting on its
references to drain.

> +
> +	/* Drop the loader's own reference taken in module_unload_init(). */
>  	module_put(mod);
> +
> +#ifdef CONFIG_MODULE_UNLOAD
> +	/*
> +	 * Wait for all external references taken before MODULE_STATE_GOING became
> +	 * visible to be released. module_put() completes refs_gone when refcnt
> +	 * drops to MODULE_REF_BASE. The hung-task detector will catch any module
> +	 * whose error path leaks a reference.
> +	 */
> +	wait_for_completion(&mod->refs_gone);
> +#endif
> +
>  	blocking_notifier_call_chain(&module_notify_list,
>  				     MODULE_STATE_GOING, mod);
>  	klp_module_going(mod);
>  	ftrace_release_mod(mod);
>  	free_module(mod);
> -	wake_up_all(&module_wq);
> 
>  	return ret;
>  }

-- 
Thanks,
Petr
