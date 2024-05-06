Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EE11DFCE
	for <linux-modules@vger.kernel.org>; Mon,  6 May 2024 11:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714996731; cv=none; b=kWbHud6+oMtIY5qT3qWsnb7avVWcXrJ3vQa1wL40GQ+bsG2tCDdm40tSqgyuXhhT+VOxzAIfG5HJnRLweKKbHOrfkKIwaXsi2EhIYclwrjOWHCwFOlzmEp7eT4DPH/qGaHK2WLamDW1Ti08ZsJq900/11UrbmDcgFgc1GoChDOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714996731; c=relaxed/simple;
	bh=sWUvmDi4mlQEhWCDlmCHj/BquExohn1t9zMQgm3nd5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=agLq7pmxugVlHAs6iRnhDQ6VWaIi+ZXiRY4ULzBlbaqJ0SJkmKBydlORD/Qrw445yHgT3MrixX1TzSDZ2FeUx0O28gH3dvS6yrWP5PyYcqhFASQdn14eC5KhrlI9kdHrV5kYlcQ/dy9bZdx+GKSMLT4FF1nu0pno/zBme/gQYqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JLEJfpOY; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JLEJfpOY"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41c7ac71996so15177045e9.3
        for <linux-modules@vger.kernel.org>; Mon, 06 May 2024 04:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1714996727; x=1715601527; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dm0GB/BuUD4Gbjv8PP6D/fUXtdd44/vugtWovY9sFFU=;
        b=JLEJfpOYd+SSW9+xvrpGLqjTZ4u6UNHRKjD5epOFZFVd+Wug3VEmXwrflmDB/p7Myd
         ZI/Hv/W0h6O+PvyDjQGslRShOeeD7pIXazsGYd0tML4xoGe+gBCq7PgAKtiqrKK6UjO7
         YPhL72mYkgv1eAytok4BhZy5VpfOub4LjGdLPT83grlt+Zy2JCO0HzKKvjYb6n2VdHTx
         mqHKuQBj8th+qr5mzz2o8ab8ce0rZDAwmv+Bu4adLiGadxLkWJWv9uQFALV1CDHIe/A2
         SBubgtXnu5AHWvq4VwkrWEEpc49AgRtuY6CsuS9pwiiXZwZdstuN2n/q0qPwagZfUnYT
         ct9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714996727; x=1715601527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dm0GB/BuUD4Gbjv8PP6D/fUXtdd44/vugtWovY9sFFU=;
        b=eori1vzxQX5BHY82WUdFBPBHXLlmLrRcYSDkgkc6TbBwNLUG7cz2UfM7SH5sxsBwpr
         N5DAUA9KuI/dj8XrTXlLSKIBAI5KX3Od2mfCH4X0ZrzhHTrmJd9RUOxu69uOf+dYqxL4
         obJJY2OLqGL2N4BEwSMnMjwy5OPAI+BNn5IPKuR/8YCdVvmvLZocmTZ2i5m0XrSUGgWC
         GCNsTIIbFCyyqunDFiznKXzfLN0Pc8ky3Uym+zehnbQCT/wxlBXSO48li4esS1NB+gRu
         CP/cOwkJgH8Ko3fROjsTARRmhhrsRzzhPyy/6WdK+kkTGOlxsh/KYtBlqpyAwJ143EcL
         HI1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWKYHZbw/CPtwyKNHTyDNCfxI0oNRfESO1NQ9bqPVaa+EWys6V4E9iPbndtzoCHgenUubr1fhu6YtkTdEzFkguki7Cpu7cNw8KuzgMifQ==
X-Gm-Message-State: AOJu0YzWG4HfDPuu0GonbxHAq7ljw/870yK5xVmL8RHP8KITHNlzBnFY
	OwGaA8WIZXS2rIBTqkloMv2CH0JPxDiIbJevoOBEs0WYzam3o/LZMW9eveVfmGY=
X-Google-Smtp-Source: AGHT+IHq2W1bMd8BCEB/4Fo71NJZZSz16EVbLhHtUL018DOrphhQ1gnBkliG/W3yy03Mp5O0YL7HfA==
X-Received: by 2002:a05:600c:3ac9:b0:418:df23:ae0e with SMTP id d9-20020a05600c3ac900b00418df23ae0emr6836772wms.40.1714996726905;
        Mon, 06 May 2024 04:58:46 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id s7-20020a05600c384700b0041b6f63f42esm15690084wmr.48.2024.05.06.04.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 04:58:46 -0700 (PDT)
Date: Mon, 6 May 2024 13:58:45 +0200
From: Petr Mladek <pmladek@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, mcgrof@kernel.org,
	live-patching@vger.kernel.org, linux-modules@vger.kernel.org
Subject: Re: [PATCH v2 1/2] module: Add a new helper delete_module()
Message-ID: <ZjjF9cf0nU3ORFha@pathway.suse.cz>
References: <20240407035730.20282-1-laoar.shao@gmail.com>
 <20240407035730.20282-2-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240407035730.20282-2-laoar.shao@gmail.com>

On Sun 2024-04-07 11:57:29, Yafang Shao wrote:
> Introduce a new helper function, delete_module(), designed to delete kernel
> modules from locations outside of the `kernel/module` directory.
> 
> No functional change.
> 
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -695,12 +695,74 @@ EXPORT_SYMBOL(module_refcount);
>  /* This exists whether we can unload or not */
>  static void free_module(struct module *mod);
>  
> +static void __delete_module(struct module *mod)
> +{
> +	char buf[MODULE_FLAGS_BUF_SIZE];
> +
> +	WARN_ON_ONCE(mod->state != MODULE_STATE_GOING);
> +
> +	/* Final destruction now no one is using it. */
> +	if (mod->exit != NULL)
> +		mod->exit();
> +	blocking_notifier_call_chain(&module_notify_list,
> +				     MODULE_STATE_GOING, mod);
> +	klp_module_going(mod);
> +	ftrace_release_mod(mod);
> +
> +	async_synchronize_full();
> +
> +	/* Store the name and taints of the last unloaded module for diagnostic purposes */
> +	strscpy(last_unloaded_module.name, mod->name, sizeof(last_unloaded_module.name));
> +	strscpy(last_unloaded_module.taints, module_flags(mod, buf, false),
> +		sizeof(last_unloaded_module.taints));
> +
> +	free_module(mod);
> +	/* someone could wait for the module in add_unformed_module() */
> +	wake_up_all(&module_wq);
> +}
> +
> +int delete_module(struct module *mod)
> +{
> +	int ret;
> +
> +	mutex_lock(&module_mutex);
> +	if (!list_empty(&mod->source_list)) {
> +		/* Other modules depend on us: get rid of them first. */
> +		ret = -EWOULDBLOCK;
> +		goto out;
> +	}

This is cut&paste from SYSCALL_DEFINE2(delete_module...

> +
> +	/* Doing init or already dying? */
> +	if (mod->state != MODULE_STATE_LIVE) {
> +		ret = -EBUSY;
> +		goto out;
> +	}

Same here. You only removed the debug message. Why?

> +
> +	/* If it has an init func, it must have an exit func to unload */
> +	if (mod->init && !mod->exit) {
> +		ret = -EBUSY;
> +		goto out;
> +	}

Same code, just without the "forced" handling.

> +
> +	if (try_release_module_ref(mod) != 0) {
> +		ret = -EWOULDBLOCK;
> +		goto out;
> +	}

This is the same as try_stop_module() without the "forced" handling.

> +	mod->state = MODULE_STATE_GOING;
> +	mutex_unlock(&module_mutex);
> +	__delete_module(mod);
> +	return 0;

I am sure that we could better refactor the code to remove
the code duplication.

> +
> +out:
> +	mutex_unlock(&module_mutex);
> +	return ret;
> +}
> +
>  SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
>  		unsigned int, flags)
>  {
>  	struct module *mod;
>  	char name[MODULE_NAME_LEN];
> -	char buf[MODULE_FLAGS_BUF_SIZE];
>  	int ret, forced = 0;
>  
>  	if (!capable(CAP_SYS_MODULE) || modules_disabled)

Otherwise, it looks good to me.

Best Regards,
Petr
