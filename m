Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6477A2EFD9B
	for <linux-modules@vger.kernel.org>; Wed, 13 Aug 2025 08:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755075592; cv=none; b=u7tad+hqmiwbL6ihw4pZHFbZXSEPIxa1iFiVGu3Mxa4Jg5pQAWD2WnYreCvMT3vMnIKvAsvZiQlrEdDJSnP2RWgkup9AL+ZTrNOinoVPRQMX/BpMDgm5SUsgxKgqqV3h5GNJP2C3M1rO2Aw1hS6g8KfGB+qdzFW5hLcJF9tgOWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755075592; c=relaxed/simple;
	bh=TILoiC+yDDDqcfdNIPmI1egXG/gTAY6xycjZ6xBYkDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W+4TPFMw2aDaB+u8BPXE4leAV2YeBs4bhtbYu7j/OTx6LlyyhNufdqlZciCkELmz4CALVxdHe9ZthmrFwPjAkkTQDkP7GxT5bzF+oHlgqA6ZQ4tWlwmiw6y9Q3dPzGIekDldKy/iNSfXmcNlLnC9B1YBdik9JSNkcnxa1iiyYU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ATgXGvwb; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ATgXGvwb"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b78294a233so5230728f8f.3
        for <linux-modules@vger.kernel.org>; Wed, 13 Aug 2025 01:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755075589; x=1755680389; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qtj4/WEbNwRSQHhO++7+YA5ErLrLz6A6JAvn0Mu/4d4=;
        b=ATgXGvwbzB+2skF61JzFz8lJEhnPzVnMQUSsMxJ5Omy0yL4qxCbQ3dOohXoJ3t2Zp2
         fau0RFUxdGVKzMb8Tw0IAA5rI/vtSAlXb1v8xRqmEPfF/A79E3n/FacKWhmPSnBYFE+m
         +bbUt+nmxFN12ikIhsQOv/m4WQAexsVbEYTMX7KxKc5ZehE36Dqv7ll5eb9cMZGhVFKo
         sjDUnXrDSOVh9jIM86wuvwBmXUb1vAyAkg/cNpG8WfDJNt4UHX0bp8nMGgJEDcxa0RvD
         fhNVU7/s/745U6Vza+W3XQz8snOM2XpKNl/p2U467srgucKHvaNFC5+0DXnqW/Ny7Gbz
         YhzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755075589; x=1755680389;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qtj4/WEbNwRSQHhO++7+YA5ErLrLz6A6JAvn0Mu/4d4=;
        b=nFLiXa27u2Xx5s80qciKWgfvijABky/N0Gf1O42j7ojreN1PkOtlvD2bZCYTsK0ZOF
         5W/dPfS63vMtqOBoC9oJOHD0JlO5D8pT2drLkyxW94wml0KwcEugIYPLcSN8EPUcOgnX
         zHHqWYa+GKBXSgAvu7/wZgJmc18OMO4OLH5T2PN4t/UXOGwfZQd1EW2kIewr6KuU5iTy
         rf44S0es3a85ryUX+zfvMJmYCk3kIriEt5bBSuaVaBUAWkT/Z+g3NnJnf9GdmhTDf0u2
         v4rPSGQy2pfKNWd18ggO2dnT1Lv7ND4Gd0v/aN96U9ZRFh39fifsGRPlun6ww7zc1yyv
         5qvQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1e93b8OYxlyazVkXoDf7HftEXDcofPNN3xm0zZcMExYveJvUEL5VVheJppzcx+pvsq8YDOSn6BuGvMpPP@vger.kernel.org
X-Gm-Message-State: AOJu0YzEvf1gEwMbYCZTj9mQ7FGTpOk49oX0UXYaM38gC2xPo/Nvr7EK
	Tmf2WVLNq/R0kr3Y7KgRGgZSk7mEeJmbCzDZXo4lXcj8H2PwiIHHm5dk1hDDlceH5f8=
X-Gm-Gg: ASbGnctihdZCDhUoyR9leoF6beQW2oPGN3qmYMxI2cDOBUKljLeqDiD4tXjNHoGM7mK
	cbGnTLO0K697dTJeXiufm2muZYuNC/bkdSBeD5agT7NZEJ1Y34meCEaNZ5aCTpcqSnPcSXjYnBF
	vhwUlvG47tKOtVq3BKharzeYoxKN046ghHnHgSrjVpmSnGEqT3ycf8Q0y0FBGiMNslSdlQRQoLH
	CgAWDqZUDUsYQdKAo0Jc3oitrlxbzPa5NXpmNfViA1OitpaqrsFk+S5vrEh/EgTf8QnmkS4t8Sr
	0nkbMnkM2PQIIuar4a86O4NNwjIO5zLS24DKQhjGpVJGhK3S/HXEjeFBOo4y83Z6VmrhCrJ2jls
	Lhtuav2MS3LF+6VGzRtC0hv35P4F3L0NhLjhLkz3v7zQ=
X-Google-Smtp-Source: AGHT+IGaTDCoJ+kAt1k5FF5FNe8D9nk06zpCSukuqxJZfbJr9Vlf54sV1t7YxAWYaxEoW0fpOoWn1Q==
X-Received: by 2002:a05:6000:1445:b0:3b9:10c5:b321 with SMTP id ffacd0b85a97d-3b917ec3767mr1598443f8f.44.1755075588635;
        Wed, 13 Aug 2025 01:59:48 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b424ca987desm21976600a12.40.2025.08.13.01.59.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 01:59:48 -0700 (PDT)
Message-ID: <5d334a1f-0dbd-4e25-bbc5-b01aca369385@suse.com>
Date: Wed, 13 Aug 2025 10:59:41 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] params: Replace deprecated strcpy() with strscpy()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Shyam Saini <shyamsaini@linux.microsoft.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Dmitry Antipov <dmantipov@yandex.ru>,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org
References: <20250810214456.2236-1-thorsten.blum@linux.dev>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250810214456.2236-1-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/10/25 11:44 PM, Thorsten Blum wrote:
> strcpy() is deprecated; use strscpy() instead.
> 
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  kernel/params.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/params.c b/kernel/params.c
> index b92d64161b75..88765f2d5d56 100644
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
> +	strscpy(kps->string, val, len + 1);
>  	return 0;
>  }

Since the code already calculated the length of val and that it fits
into kps->string, is there any advantage (or disadvantage) to using
strscpy() over memcpy()?

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

I think this can go through the modules tree. I've CC'd the mailing
list.

-- 
Thanks,
Petr
