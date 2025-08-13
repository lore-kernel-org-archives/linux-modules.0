Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D42911CA0
	for <linux-modules@vger.kernel.org>; Wed, 13 Aug 2025 14:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755094493; cv=none; b=Y6Sr4ZMNbkPLctfBFJf7KWUnJ8qvUMLQFRyngXt6KvsLHPP6uYPwuKl906Rf3CWz2GQhfjeHsvznZqU3QnRLx2qnTjlBXAhPuITwydKksrCDOp7fElnxeONb+1LVzrn/q+BsvZEub2imhTBVUyDN1wl0I4LuwB5IDBUU2H3b5fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755094493; c=relaxed/simple;
	bh=QCMLg4dsgOa1eEM81Z73fL6vTE/mmW2kreT6QN5Otjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C8cOWWwTwq9cgvjgbLKakVv4ZgntOD2eDv3pBg1azro9++Q9gZsx3UMthHXeUI9mtjSWsoAeTxFrz8dOTqNmMI5YmBHJtR9x8vyIqXIbJTv5EU8D2+xnU1PFWBF8P1oynHVhNCbbS4idAOxsyVO3Q9o90j2vCBe38kjXCYk88gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=e/679PPM; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="e/679PPM"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3b7886bee77so4746792f8f.0
        for <linux-modules@vger.kernel.org>; Wed, 13 Aug 2025 07:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755094490; x=1755699290; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KVpG8bVI3r2CBlCksy8TqW11iXXZZJG0tvWEcZ4LZn8=;
        b=e/679PPM/O3RuSDpuOdIzXjmQ4pM55ed+j+0m5nXOnR0bfq+vnOG7VC5+BmqF4zVSB
         ZhYW0VTKuN4pxXUaf0PC47SPmpN4iMfeMN4nEDueXScPk1ZHV2KGgKVnzY4OInWuBzgh
         1JNYcorolGbwOxROP7X4CHEgix5ZVQ6exdZ6znGQQxzig4QscBCttnYC6dWey6C95OV8
         PiDMTX4ggucA8SiSf8RtjLKKO3G9bWV5rcibM3P//mDZwok4rSdGK6dlbwaQENTVQyp1
         Ev3hB6VOy/AKTPB2JuTTsCEAwxog05ivo1BTxFBLqJT/Mub8xbhXMelJWWXaUlRUgaXJ
         pHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755094490; x=1755699290;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KVpG8bVI3r2CBlCksy8TqW11iXXZZJG0tvWEcZ4LZn8=;
        b=emJbOfdScImuMBRTeRZsdETYS4dHPx9raK31UPyIjgliCGNDdDtwKYuJLZ7bcAsoS/
         wjI6LceSvrePNbBSy56mVOrN6Pixn68OoQkeS6fJRwBpTEeXsE3JJkoSed8R/o/lDuJI
         VaHwTScLtBZmZ1xjmmZYRgktIJgRluWi9kxI3GT2Svsp2Vw4YMHIk0fWZZDnfe05cxbd
         OkKa6fEzPiRAeDUuTtTzV5Sg15BQ4Djs1VfwtZoyQq2Y3xCKTFUH4XyvRCy6EXXopL77
         /xFxi3ZmJdJV5161jfAH5foAPxIX6xABmebA0bpr2FcFKfbpZqcOKBIpMASHtRCQSJEJ
         Kk3Q==
X-Forwarded-Encrypted: i=1; AJvYcCV5BkIso1hZRn4LwufElkPWdiZIQIINln+TZh9jEh5wEEAxWLHcTaS3tUU4vq3hj9TYagbtNuiCi2t1MMct@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7RLfZHaCunugZKxfVk1os4krs50VSsn0CkDI/UYGqX6NCjbB5
	dM+6J0AjnPZqOV2udSr/J1hdkzvoxsIoGtALVjbgbNoXRb3DJgucVGFqPJTS/5wUE5Y=
X-Gm-Gg: ASbGncuUvBiyGGzNTOqEXWATCCYmu2cuDcIYWVRrRS41AYI0Dfn9jfaW0VMx6lYkc4B
	JEB9efOSew9k2tweZqfY/s/VU5Ci5/VVsX79Lw6Aca/NtXhe6Vz15jF/JyR6AwkwNX4m4xF5QPw
	VtkG86jv6Hj9kRtKFJsTffJTzWYpebFHaj7H4zdPsimJSOzj3NtiS9vnpFtw3ISh9PjzVm7VaTA
	olO9QJyGnheeBy6pEtz7B5z/0AiCG45f7NGjajxfPitlo89uJscGR+rcRsBG7Zj9oIco0oqJ0Pg
	oYV5wFS6nsHRyx5V+EisyRRmrMAYeF53F3jSI+xi1J1ERiJiGUaM64riWoTRg/KKLHeyCeQo+0t
	3TjL3jqtIgbi4SrOUapiRy9cll4N5kIZHtXF0DIcT0GA=
X-Google-Smtp-Source: AGHT+IFm35SgYBxWt9VgUbIXjFlBOfuZ7PxWsBQOS5oI4umuCBzJ8zHC2Ue8SdOP5RfWHEQF78zD1Q==
X-Received: by 2002:a05:6000:2dc8:b0:3b8:f863:672c with SMTP id ffacd0b85a97d-3b917ea0f3bmr2554936f8f.33.1755094489545;
        Wed, 13 Aug 2025 07:14:49 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e1b99ff8asm3084354b3a.57.2025.08.13.07.14.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 07:14:49 -0700 (PDT)
Message-ID: <f60327bb-6546-4d15-8bd2-a05e85d96b4f@suse.com>
Date: Wed, 13 Aug 2025 16:14:41 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] params: Replace deprecated strcpy() with strscpy() and
 memcpy()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Shyam Saini <shyamsaini@linux.microsoft.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Dmitry Antipov <dmantipov@yandex.ru>,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 Daniel Gomez <da.gomez@kernel.org>
References: <20250813132200.184064-2-thorsten.blum@linux.dev>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250813132200.184064-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/13/25 3:21 PM, Thorsten Blum wrote:
> strcpy() is deprecated; use strscpy() and memcpy() instead.
> 
> In param_set_copystring(), we can safely use memcpy() because we already
> know the length of the source string 'val' and that it is guaranteed to
> be NUL-terminated within the first 'kps->maxlen' bytes.
> 
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> Changes in v2:
> - Use memcpy() in param_set_copystring() as suggested by Petr Pavlu
> - Link to v1: https://lore.kernel.org/lkml/20250810214456.2236-1-thorsten.blum@linux.dev/
> ---
>  kernel/params.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/params.c b/kernel/params.c
> index b92d64161b75..b96cfd693c99 100644
> --- a/kernel/params.c
> +++ b/kernel/params.c
> @@ -513,13 +513,14 @@ EXPORT_SYMBOL(param_array_ops);
>  int param_set_copystring(const char *val, const struct kernel_param *kp)
>  {
>  	const struct kparam_string *kps = kp->str;
> +	const size_t len = strnlen(val, kps->maxlen);
>  
> -	if (strnlen(val, kps->maxlen) == kps->maxlen) {
> +	if (len == kps->maxlen) {
>  		pr_err("%s: string doesn't fit in %u chars.\n",
>  		       kp->name, kps->maxlen-1);
>  		return -ENOSPC;
>  	}
> -	strcpy(kps->string, val);
> +	memcpy(kps->string, val, len + 1);
>  	return 0;
>  }
>  EXPORT_SYMBOL(param_set_copystring);
> @@ -841,7 +842,7 @@ static void __init param_sysfs_builtin(void)
>  		dot = strchr(kp->name, '.');
>  		if (!dot) {
>  			/* This happens for core_param() */
> -			strcpy(modname, "kernel");
> +			strscpy(modname, "kernel");
>  			name_len = 0;
>  		} else {
>  			name_len = dot - kp->name + 1;

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr
