Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9121B320CBC
	for <linux-modules@vger.kernel.org>; Mon, 15 Dec 2025 10:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765796360; cv=none; b=RJqrfkNSOzTHN95Nv/tFkXBPbrSooQo1bMo3cwK9TVQfyn8eV+8n5+X1e3zkz13r2e7ElMpdes5PY99yohLx9V6DlPL0XO6lZp5nODEDgaSQG8ociuKrUZau1JGxst1GRu4LNshzAFAWOQKLNTNSg49ntQzOLkRbXumgd9kyDFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765796360; c=relaxed/simple;
	bh=O3ylDXd2wp+fOvrlCk0eTmzvTZv3R8RdsrSBBcQcx5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y/3gYh/xS8embqOB66FUZv4wEUeRm/9Os9X5KMdWv6fmAxcScnoEkNsCcH7nvMZidXaSpjJlPW2S83KXqLa7KKiHbNbNwyaoBjt3cDPPEbI20m+c4Yy1IO2cGOaNZs4NTf+3d6EKFZvVo1O1hwi24unSCYxwVtIfFj3Rx6NDHUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZDv9kezz; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZDv9kezz"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4779cb0a33fso40347315e9.0
        for <linux-modules@vger.kernel.org>; Mon, 15 Dec 2025 02:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765796356; x=1766401156; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R15EbBXLRtAH9+gHZDHDZ3rwyNbVtrgUFIAVNiEEgjw=;
        b=ZDv9kezzkwIT3pY0D2nmJwiqW2KJcV1MbZLkC6afyYrKi6H4lm79s1cvsA5UpNJXIn
         /KxrckZch4dX9me1VnLkmQRo8JnsSlsm+AxMOflPeDslmajpPRyWfh9rx/g2DAyV83J8
         cOM5aou7K+pR4ib8I6Ow1EOtAyy4Agouvq37pSp65aUj7yTnI+Lt48CkXdy9sGdiduw5
         ZOKYzlP34lYTKespXL0FVfvHnxOzBqzxTJVauQxVtz4sqF2bvqETT9LNpWrU/r0YRO9d
         ZhaC4hFbhvJR2F1G+Vfhi+ognSTPlYtIGjMRljh3uZACfp0aatxnkLZ7Kpm8oyTLds7z
         WPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765796356; x=1766401156;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R15EbBXLRtAH9+gHZDHDZ3rwyNbVtrgUFIAVNiEEgjw=;
        b=ddWUmHYF205U91QWSXYuXn5YeCPzlyGu0FR4m5Gzk2NIE7TMRWhzHoEP97taLpidnp
         DDdahQeUv55boHDZvUvGNltXk5VOd7/FTnTSRsaQjydCp5ZlzOGKsW/Sbhhz72ZRI+es
         FeRgi2V4l3E5yWMQccxq45t3pISZwr8N6en3GCTXBpWee+hZdy0H8aqe0cFwADKkWFV/
         IftHBQq1z570oB5vWI+2KsKg4ubBd3umPYxlkID94xdntZfqzI14VaeWR7bnkouYG4Hn
         FT1cFoidRHhNx/5d17/lCpYataBcZ93C+cvL5Cf3fipkIj0LqFxwRQP+wlp967J6VEwu
         q3iA==
X-Forwarded-Encrypted: i=1; AJvYcCWceCRs3rJflTu4f6/z+n6cRNFoQhX6AfeCMEAew8aTqV3QA7YmPjEVYtGBDPrayvdnWFaYns0Te4URN0jB@vger.kernel.org
X-Gm-Message-State: AOJu0YwBvA7xFOepyOK+bH7sqY5zV2cE7wJD+Pp6pCZ8B4yrn1qDbDIT
	igPZoJH/DNAXMROg78cnlYhwlaVhN+3rcgHnS8F6pwQANlaKVCEiVyedCgeDDnw0HRw=
X-Gm-Gg: AY/fxX6m5UsTF53HBFZHTUgCmM8uz0Rrfu4YfFvax1dxrhTCY2PJeDP0n2IPyhM2pQe
	R/RL60HWXjN+aYuxVXoGXlhcWQUBD+1GxVa10ZuyvyY3hThtUtJpN2MLfD8Ppo6g0eOnx4C27nT
	JGpIfP1sUwvvgrhk+hEQvxeRuGPr/t+69kK2BYo82n3EeLMNToAlFNHOrDsQWnI2YXcVnqlJIis
	ce7d8LP8ZHUoOIwRSDYC+gaSwSRIr4ZNofodv9z7re63+1MSdS2YjV6OfsAswFdOnSu97WBrwYH
	naIyWZeoF9yHXzSOstgQjbPP8wwefNBVfMV0EPCj6ECaCwuicgwUqZ0MCXr5r+9ADgJXLpGCwch
	03BkY82F7d+6DV3lXBnP0APsNqyUTv82bK4ARrLjpm1GgzX0iPe0NMk7s3MjVJGAcchPGLbhLy0
	Hcbi1S8HYKkzCoG3uihiYXnPwhV/v7BeCTLPdRtI9A
X-Google-Smtp-Source: AGHT+IFf/yBFaW6oUwtQi0X+HsXnii2FAvU5kVyPxMiPMtWMDlqyy5u5Yzjk5LScwzB0tVsLptPDyA==
X-Received: by 2002:a05:600c:450b:b0:46f:b327:ecfb with SMTP id 5b1f17b1804b1-47a8f8be22bmr112395745e9.9.1765796355799;
        Mon, 15 Dec 2025 02:59:15 -0800 (PST)
Received: from [10.0.1.22] (109-81-1-107.rct.o2.cz. [109.81.1.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f775012sm179506555e9.7.2025.12.15.02.59.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Dec 2025 02:59:15 -0800 (PST)
Message-ID: <86018f05-1be3-46c9-a983-31cf677a4933@suse.com>
Date: Mon, 15 Dec 2025 11:59:14 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] modules: moduleparam.h: add kernel-doc comments
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251214202357.2208303-1-rdunlap@infradead.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20251214202357.2208303-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/14/25 9:23 PM, Randy Dunlap wrote:
> Add missing kernel-doc comments to prevent kernel-doc warnings:
> 
> Warning: include/linux/moduleparam.h:364 function parameter 'arg' not
>  described in '__core_param_cb'
> Warning: include/linux/moduleparam.h:395 No description found for return
>  value of 'parameq'
> Warning: include/linux/moduleparam.h:405 No description found for return
>  value of 'parameqn'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Nit: The description is somewhat misleading as it mentions adding
kernel-doc comments, but the patch actually involves fixing the existing
comments. I guess this can be adjusted by a maintainer who picks up the
patch and there is no need to resend it.

Looks ok to me otherwise.

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr
