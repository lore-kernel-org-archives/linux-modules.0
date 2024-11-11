Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF7F13E022
	for <linux-modules@vger.kernel.org>; Mon, 11 Nov 2024 17:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731344757; cv=none; b=C9EdR+G3GmrnRh5FEJS3CuEYkDEeEEhZMyu55CmUnkw5gy9ZrP+GyBgvqn8IBZSUymNnIuAA/hhCcrlZrau2EtbwSUUGtPJQfed0M66/7vUZD7V9NfuePs1JNstbKOiSthwv66HLPw6zOl/eiRUGyCWKsTVBnBM/YMPTHw0BNnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731344757; c=relaxed/simple;
	bh=9Vxu4PVNL5H9HSoxipc0S+5ubdT+EHw1LzDtaf7KFgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WdjwnN5AF8QeFMUxPosB412oTuWpk2iyYzLHeL5pSoNytQ7PLAhZqOEZM0tyu22zu9/fSBK94MD/lot33zLYqff85+CImHdTE15SLbAV3Ae/CYxetTCs7MyuUq1iX+P0+RtB/TxjjVZrsrpsTIfs9Rgh/JBdoCnyduy9lPVTEzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SDKeN6gz; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SDKeN6gz"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4316e9f4a40so40794355e9.2
        for <linux-modules@vger.kernel.org>; Mon, 11 Nov 2024 09:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731344754; x=1731949554; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VhwVnEvd/icTbdtV0Bsqw2Le6kUPshvavFqFjWXtU9A=;
        b=SDKeN6gzYO5B9F1crf+ERz/4vXTRnqN+d22dEW/AFokqaxMpdXUaaT0aPQp5Uoh24P
         YMZIjU4BGduY6xaRBfqq4N3M1ORlEq8qNsTbM9aj/GiBnS5EZpE6FNZKZmoD132BREGV
         phYuPExjy+//45U2R+aKjHCpcUlY7YYzbE1V2dCaxq7ePSb6T/LHAKY+vEk6yGPsBdv7
         wGKguZ2kBayhD8qzGBKt5e53MyD8pl4KrgfoqQcZRTY9oTmsI1rpwjwoeMKmsjJ3Y1UV
         NUJBLf2JoLEr0sqNN8X8K10z7IU6QzyDPb1EquPxqXxu1XVZCaM4K+jfx6lvGn+unrmD
         Yp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731344754; x=1731949554;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VhwVnEvd/icTbdtV0Bsqw2Le6kUPshvavFqFjWXtU9A=;
        b=jxkMtuSZTbtSJmU/JUD+fIUGlPeKnlGwRWnNoYU1u6AoVRY1D6lywmcWFcGF03Bij8
         QrxlDXKuO319GvlxRJAh9RuCXeCHWZ/8H/7iapThqklDMRv02OtcDUg7EmAqVh7PG3jm
         O8BrdizidDcXOW7eztqrNMQIvc2fRUuRDJxFT/FDjLvjMkYedvKM6S7WA37JKodZTaNX
         hAe6evGD4Am0gxzSqaAHGWUJkcS6LkypOYl/upyTGpSRIPDIxcrMpYwV2LbpnY1wA9kn
         9cK3c+JGJNd7CZi0PWvnFK2be0EuxQ+Qy45LiLzINCl6dCadoZmqz3MakoCTOEi02rrK
         NCBA==
X-Forwarded-Encrypted: i=1; AJvYcCVwufIXQMo21V3H57zdqX918NfO3vOpNHk+v+tVhlfp3+TRCDkX1wXdYFVOnAsnUQbyYk49cVhT+nF7C3ej@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq3itX3OVonxsBa5xMUTttlcQ2VSoiPX62fFSyUh0tiszisJ8a
	utQtvAPhyKmDi6SsEKxNzDoFFUUlQ+S1wvrsfZqOnoWvEV4HugG7cfCBFo52Hps=
X-Google-Smtp-Source: AGHT+IGmxEngfhr8mOFW4iGYAg8DChGdAiotEKJEfg+dwPTD2oqfbLS3GUMXXOepidKKbY3RfbZf2Q==
X-Received: by 2002:a05:600c:8608:b0:431:46fe:4cc1 with SMTP id 5b1f17b1804b1-432bb99a52emr92207255e9.10.1731344753731;
        Mon, 11 Nov 2024 09:05:53 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa6b2c32sm215555395e9.10.2024.11.11.09.05.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 09:05:53 -0800 (PST)
Message-ID: <f2c8b587-117b-401d-a5ab-ae59dae1dfd3@suse.com>
Date: Mon, 11 Nov 2024 18:05:52 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/3] module: Don't fail module loading when setting
 ro_after_init section RO failed
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, Kees Cook <kees@kernel.org>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>
References: <737f952790c96a09ad5e51689918b97ef9b29174.1731148254.git.christophe.leroy@csgroup.eu>
 <164e5f22f8ab59d1d516e3c992efdd9f83ab4819.1731148254.git.christophe.leroy@csgroup.eu>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <164e5f22f8ab59d1d516e3c992efdd9f83ab4819.1731148254.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/9/24 11:35, Christophe Leroy wrote:
> Once module init has succeded it is too late to cancel loading.
> If setting ro_after_init data section to read-only fails, all we
> can do is to inform the user through a warning.

Makes sense to me. If I'm looking correctly, set_memory_ro() could
mostly fail when splitting large pages. If we wanted to fix this
cleanly, I wonder if it would be possible to divide the function into
two. The first one which does the necessary splitting, can fail and is
called prior to a module init, and the second one that eventually
updates page table attributes and is called after the init.

> 
> Reported-by: Thomas Gleixner <tglx@linutronix.de>
> Closes: https://lore.kernel.org/all/20230915082126.4187913-1-ruanjinjie@huawei.com/
> Fixes: d1909c022173 ("module: Don't ignore errors from set_memory_XX()")
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  kernel/module/main.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 2de4ad7af335..1bf4b0db291b 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2583,7 +2583,9 @@ static noinline int do_init_module(struct module *mod)
>  #endif
>  	ret = module_enable_rodata_ro_after_init(mod);
>  	if (ret)
> -		goto fail_mutex_unlock;
> +		pr_warn("%s: %s() returned %d, ro_after_init data might still be writable\n",
> +			mod->name, __func__, ret);
> +

The __func__ magic constant here expands to "do_init_module" but the
message should rather say that "module_enable_rodata_ro_after_init"
failed.

>  	mod_tree_remove_init(mod);
>  	module_arch_freeing_init(mod);
>  	for_class_mod_mem_type(type, init) {
> @@ -2622,8 +2624,6 @@ static noinline int do_init_module(struct module *mod)
>  
>  	return 0;
>  
> -fail_mutex_unlock:
> -	mutex_unlock(&module_mutex);
>  fail_free_freeinit:
>  	kfree(freeinit);
>  fail:

-- 
Cheers,
Petr
