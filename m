Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837A58F7D
	for <linux-modules@vger.kernel.org>; Tue,  6 May 2025 14:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746542984; cv=none; b=hfUuPXEJNwqwn68eCQ2fKWDrI/LjiHjN81qjVhJJBQP92SM9XsM9M7t8So8rTJSnOcL5YWDDyEv1ZecisW2F+/vGQakBszogco75xxDu4ntGkc+wzPkeJStuUxJ4Q2sGzBXiG19eS5I/gCpJcmZWn8IQ4ICBWlWNmv+eO4ivFD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746542984; c=relaxed/simple;
	bh=m9nk5zfJ4XrB9POeeLCvYgB1CboqaBEws4iQQH/bdfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sY1Gw7UJrKPldWRW52kjJgDkEwUdeQtM8wQe6Uo7EYFnn8pAKmj4iQZmW6t8lnvqi/KUj3UD6vgyAbuVN5B1fA/wSOlmB0SKelT3hchZqF40R6JaWJq6yfaYYHR5saGJg5fFGC88uquMr7k4Neiz6rhvWvdHsiMGqBAe07sS9JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=APPjBkye; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="APPjBkye"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ace3b03c043so879308166b.2
        for <linux-modules@vger.kernel.org>; Tue, 06 May 2025 07:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746542981; x=1747147781; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LLm3kMm3ILayWCfux8ao/n0VoWx916s4kxMfMwenZNI=;
        b=APPjBkyeWHsvURMwHHcE9pZqbohC6W7LDFF0I9Ndmt7xIvAa/BUBhiLvoth2TzUxmy
         Gsr16vwhI5NaQUB1jBbdt890G6ar3wKHwzalf0Tm297az0WhScd0fMVOEwDoTsGKePve
         l7InTRRJGsC1tSOQ8Ky7ht6m6lOBXYoVzuz/eux3047HOjShtHBEbnP0lTpjeecCfsFI
         Lb18PH/TS6j7zSRq1Eb24lIjI/fqDLhYPQtExy9oXz9j7yKhmypdLodHvGpwOonvTlc8
         Iv7AJF9WUtDD4f/TocK5MUaDRs2lZPEBIksGT4OumhpGwkIsAXQdbQItabw7RTFNMWvW
         rCTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746542981; x=1747147781;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LLm3kMm3ILayWCfux8ao/n0VoWx916s4kxMfMwenZNI=;
        b=mu5BqwvAPWtCgpVeHHRuTbIQHNS7T9da9hJv3ct3HI1UNhU6VDDPY0RpH1fqU9H/xD
         /ew9FStNS4THvDtEx572e+zGhJjSgJbIZp0LqzpsQmrlITUU/Lrgr8vs5RgBFJEtjA34
         /STCupXz4JPtj5Zib7DTdrAg+wcmpAml6FEZ32fKHNxjECoJ/QuSCoicDbBsrqZONAWE
         Ki8tc/wBdtSfjJRh+55aPilBossq4GdJQwy3sbPSJntieuII2qbPlhveUKspxg/9vpoA
         C6DEVa2IE+vnhwn/s/I3xOsthzvzi8rDGpkWidx1EeL6xm84Vdr4wglVVsP1/YwbUh6j
         y/cQ==
X-Forwarded-Encrypted: i=1; AJvYcCWv4/sRMQDj4D3eQkF8UPGNHgI6+BLA/G/lmrMnlTCUdkUHRdH9p7KrA7tmUzSQduzTKNVLfVVy1dl9XZ8O@vger.kernel.org
X-Gm-Message-State: AOJu0YyQc/8Bj41504KF2tCHiCrRdYdHBUEapVcGegSZFvp0DtcCkQLj
	e8SHFWVY42jZ+HSKp8Ol02jLJyvknb8IZf5oZBlTIkkrQCgOtypxsA1+R4Cugs/HFlUo7kQU9yI
	4rt8=
X-Gm-Gg: ASbGncunCm5hoJY67bcEITgi8CTXFNutpOKzOunAedVKa0PKoFXxO7FAMHfvmSv2+dy
	paGTzkdzvAZSFo2N2yy/oQGhQeX/Pj/olN+QoFDEhpnj2Coa/Av4qhtleXnUfVPr62yAuENUHN5
	l/qwzoFPpIJABc9gUnA3eT2Zv+NGUpKZOVZLmT1cPKO/L/TfQZQpgfMdmFDpnMiMZxD/sxNjYbi
	K4laHQ2rYP3NKqjgIqRRbP4ZOyJYE6VTeiTcv+tkxqII6pfDewbtrKFpqy3lcpHNWM2PkGeHQbi
	WLFZVp4OoTe/rQIWspSrVTLABt2tqjtz6yWebFFUJy8=
X-Google-Smtp-Source: AGHT+IE8VrZLLqKslcL188rLajfAM34SilsnBbD9W0WnpdKzzh54APHGTR/FM4gVgTAiG44i8wR3zg==
X-Received: by 2002:a17:907:6ea5:b0:ad1:8f1f:6961 with SMTP id a640c23a62f3a-ad1d469315amr303992366b.43.1746542980641;
        Tue, 06 May 2025 07:49:40 -0700 (PDT)
Received: from [10.100.51.48] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad1895090a1sm719542666b.137.2025.05.06.07.49.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 07:49:40 -0700 (PDT)
Message-ID: <443b9765-3677-4bff-a6b6-a89f6c73cb67@suse.com>
Date: Tue, 6 May 2025 16:49:39 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kernel: fix error handling in
 lookup_or_create_module_kobject()
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, Shyam Saini <shyamsaini@linux.microsoft.com>,
 linux-modules@vger.kernel.org,
 syzbot+7fb8a372e1f6add936dd@syzkaller.appspotmail.com
References: <20250506111742.3109640-1-dmantipov@yandex.ru>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250506111742.3109640-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/6/25 13:17, Dmitry Antipov wrote:
> In 'lookup_or_create_module_kobject()', an internal kobject is created
> using 'module_ktype'. So plain 'kobject_put()' causes an attempt to use
> an uninitialied completion pointer in 'module_kobject_release()' and
> 'mod_kobject_put()' should be used instead. But if the driver (e.g. USB
> gadget as in this particular case reported by syzkaller) is configured
> as compiled-in, THIS_MODULE is NULL and there is no relevant module
> object to call the latter against. So introduce an internal wrapper
> '__module_kobject_put()' which is expected 'struct module_kobject' and
> so fix error handling in 'lookup_or_create_module_kobject()'.
> 
> Reported-by: syzbot+7fb8a372e1f6add936dd@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=7fb8a372e1f6add936dd
> Fixes: 1c7777feb0e2 ("kernel: refactor lookup_or_create_module_kobject()")

I think this specific commit is harmless, rather the underlying problem
was introduced already in 942e443127e9 ("module: Fix mod->mkobj.kobj
potentially freed too early"). Commit f95bbfe18512 ("drivers: base:
handle module_kobject creation") now allowed the problematic code to be
reached by more paths and enabled syzkaller to find it.

> [...]
> diff --git a/include/linux/module.h b/include/linux/module.h
> index b3329110d668..2b4ab389c1bc 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -891,6 +891,9 @@ static inline void module_for_each_mod(int(*func)(struct module *mod, void *data
>  #ifdef CONFIG_SYSFS
>  extern struct kset *module_kset;
>  extern const struct kobj_type module_ktype;
> +void __module_kobject_put(struct module_kobject *mkobj);
> +#else /* not CONFIG_SYSFS */
> +static inline void __module_kobject_put(struct module_kobject *mkobj) { }
>  #endif /* CONFIG_SYSFS */
>  
>  #define symbol_request(x) try_then_request_module(symbol_get(x), "symbol:" #x)
> diff --git a/kernel/module/sysfs.c b/kernel/module/sysfs.c
> index b401ff4b02d2..7519920f4f55 100644
> --- a/kernel/module/sysfs.c
> +++ b/kernel/module/sysfs.c
> @@ -323,11 +323,7 @@ static int module_add_modinfo_attrs(struct module *mod)
>  
>  static void mod_kobject_put(struct module *mod)
>  {
> -	DECLARE_COMPLETION_ONSTACK(c);
> -
> -	mod->mkobj.kobj_completion = &c;
> -	kobject_put(&mod->mkobj.kobj);
> -	wait_for_completion(&c);
> +	__module_kobject_put(&mod->mkobj);
>  }
>  
>  static int mod_sysfs_init(struct module *mod)
> @@ -362,6 +358,15 @@ static int mod_sysfs_init(struct module *mod)
>  	return err;
>  }
>  
> +void __module_kobject_put(struct module_kobject *mkobj)
> +{
> +	DECLARE_COMPLETION_ONSTACK(c);
> +
> +	mkobj->kobj_completion = &c;
> +	kobject_put(&mkobj->kobj);
> +	wait_for_completion(&c);
> +}
> +
>  int mod_sysfs_setup(struct module *mod,
>  		    const struct load_info *info,
>  			   struct kernel_param *kparam,
> diff --git a/kernel/params.c b/kernel/params.c
> index e668fc90b83e..2cf1f17840e0 100644
> --- a/kernel/params.c
> +++ b/kernel/params.c
> @@ -780,7 +780,8 @@ struct module_kobject __modinit * lookup_or_create_module_kobject(const char *na
>  	if (IS_ENABLED(CONFIG_MODULES) && !err)
>  		err = sysfs_create_file(&mk->kobj, &module_uevent.attr);
>  	if (err) {
> -		kobject_put(&mk->kobj);
> +		/* Not 'mod_kobject_put()' because THIS_MODULE may be NULL. */
> +		__module_kobject_put(mk);
>  		pr_crit("Adding module '%s' to sysfs failed (%d), the system may be unstable.\n",
>  			name, err);
>  		return NULL;

This looks as a valid fix, but I wonder if it wouldn't be simpler to
have module_kobj_release() check if mk->kobj_completion is NULL.

-- 
Thanks,
Petr
