Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EFC15697B
	for <linux-modules@vger.kernel.org>; Thu, 13 Feb 2025 15:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739462171; cv=none; b=l4CHu7R33TjBVqFMNvaGWB7g444zNXCFORR7ZJQ8YM8yM6peq7WzsBUk7xlIyUBBj/TH3HzCI3V2Za/ZesKla6pX13Pa6Ha1ApMXFuO1ilFEkMZUBEJ/9uTKRIvsSETppZ1Ubt8udD78S/5SlZOs5VGT2rqpu459bbyD+6yCVs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739462171; c=relaxed/simple;
	bh=7i6V9OUku3e/q/hSkEcFP0qGhYQ8Xso/nVD/tvXD9sQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P52jYJ68sw17mF1HEfZLPzgQuzhJukej5+pV1Ta6i79mm22jkcY3cy7bkg4XXnoDgT8SwGNFoUIZLwvFPAAnwS9w1H6LkUDFD/GutjavvPduTRfvPjrbIPk4xFKoewzzwHg0tLAfvmVwZQswQyT44JW9NwBlxnJB+g8yMGgEY5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZPj+SSAU; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZPj+SSAU"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54506b54268so994377e87.3
        for <linux-modules@vger.kernel.org>; Thu, 13 Feb 2025 07:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739462167; x=1740066967; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qLAli4Gnmcw4fIPwE54pea1emeVcN0oq6/R3bNPrLic=;
        b=ZPj+SSAU8vW5HyIN9EiQkMt8k+I56bhCy0UL30YyzjIoLYVr145hFIH7lWa0jMynEK
         s3rzXBC0PkeaEmDBZlNQp0CoMHSmD+XvHPH652et2vBPTY3CTqR9f1FYJVXwfMSOkSmu
         7f9MgLXT95teNbSKeghMIz77WdjuTfYnYSKKIu885tur5/ILjvtIVDQgdWpYmvmBOKeh
         Y5msnJCoFqgFA/2TM8vPd/gdgP9IODPaduvL79vaJhxzkUnW9iJAQTJwWjsk1E6Bl+zw
         ogjJ8P8evyFYYdLYlpJiVfMQCbQMHorloSPlImgKyX/557uneDZA7g3xolzLLxmHmRwf
         Zuag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739462167; x=1740066967;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qLAli4Gnmcw4fIPwE54pea1emeVcN0oq6/R3bNPrLic=;
        b=nc/YJeuP7U1R95rtR1AUo4eW7xDwDLfVn0JxHYpB/gp5Ot9SJpalsVoWeFaZF2/us2
         SKASAS5d+F4zsigHGwXLR5O/Bt7ak4BtwlYVpomLq8qkngPh/5KaWh19YPsTWMkbEbdB
         ZzTaaLPd2sT8AmQ54Z5tqUZm+czntGBIgGnr3ibCyiYhYsRtu0yvW1AgvWveH8PcviXR
         XGyOP/Kxs9HaNWRg5DJNDpukmHhiR0faQjorm+HMsfx2b5xS3Dz28VaY087qRhmdovCl
         XF5x76kxdwI6doLeHq0HMfRVhS0uj9miazhymRAPAgZ/tFlQgjB9CbyBOWC7BbFEbEdx
         5u1Q==
X-Forwarded-Encrypted: i=1; AJvYcCU4oI4Bi7cmuIZKqrdWOkqIPxSg3Wx6rcHn/kCRUBwt95HsIB01eVr98ww9hHEwUeW2Kx5ejLCdAsm7gW9r@vger.kernel.org
X-Gm-Message-State: AOJu0YzsVGia/UcMKs8SwCgZWqqo7u/trluOibE0RnH2JdRreq8JVhnR
	FtWIHFFtcb2X7Eugt8o5WntGYZIx1zfYnjqJUQKAx9DlCQ2R3GKPyRROuvXGkZ0xmdcktPRwYY1
	Q
X-Gm-Gg: ASbGncvXf9bYuzsH4dU2bVx6QgFVPeRLSxAbdWXKKIlKAHjBtc2STh5k2wJIcPt4yln
	drHuKYax3cSmQa6dpBb+vN8E7VRTrPF7jKRkDjWUBiDW2Zj1t8P7WVIDv2IIt9VDkzfKNtYZSPe
	5L62wojDefHerq3c0d0j2gjQ+Jx4wxVkeIM0q1nJo3m0dxogMziHVfQX+7MN3GAx2jztKgzWgvf
	QNTl+vZFoT61waV509ddVJ+vwv8QcwaPsRDlHjd4rTvEWrrDeGh+DVaupzmK+A+fiXbW8cnHPCs
	z2/VwoMLH5lIVziDf6Y=
X-Google-Smtp-Source: AGHT+IEoXf8IM0BCiy1988JuJo2B9cXIjndci1o/MsuJC/BDML4b4xU7aji+rhA42cW+Qk30XmAwPw==
X-Received: by 2002:a17:907:3fa6:b0:ab9:137d:f6e7 with SMTP id a640c23a62f3a-aba4eb88dd8mr355840866b.7.1739462156201;
        Thu, 13 Feb 2025 07:55:56 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba5339d7bfsm155245866b.141.2025.02.13.07.55.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 07:55:55 -0800 (PST)
Message-ID: <4039ec74-8b46-417e-ad71-eff22239b90f@suse.com>
Date: Thu, 13 Feb 2025 16:55:54 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] kernel: refactor lookup_or_create_module_kobject()
To: Shyam Saini <shyamsaini@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 code@tyhicks.com, linux@rasmusvillemoes.dk, christophe.leroy@csgroup.eu,
 hch@infradead.org, mcgrof@kernel.org, frkaya@linux.microsoft.com,
 vijayb@linux.microsoft.com, petr.pavlu@suse.com, linux@weissschuh.net,
 samitolvanen@google.com, da.gomez@samsung.com, gregkh@linuxfoundation.org,
 rafael@kernel.org, dakr@kernel.org
References: <20250211214842.1806521-1-shyamsaini@linux.microsoft.com>
 <20250211214842.1806521-3-shyamsaini@linux.microsoft.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250211214842.1806521-3-shyamsaini@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/11/25 22:48, Shyam Saini wrote:
> In the unlikely event of the allocation failing, it is better to let
> the machine boot with a not fully populated sysfs than to kill it with
> this BUG_ON(). All callers are already prepared for
> lookup_or_create_module_kobject() returning NULL.
> 
> This is also preparation for calling this function from non __init
> code, where using BUG_ON for allocation failure handling is not
> acceptable.

I think some error reporting should be cleaned up here.

The current situation is that locate_module_kobject() can fail in
several cases and all these situations are loudly reported by the
function, either by BUG_ON() or pr_crit(). Consistently with that, both
its current callers version_sysfs_builtin() and kernel_add_sysfs_param()
don't do any reporting if locate_module_kobject() fails; they simply
return.

The series seems to introduce two somewhat suboptimal cases.

With this patch, when either version_sysfs_builtin() or
kernel_add_sysfs_param() calls lookup_or_create_module_kobject() and it
fails because of a potential kzalloc() error, the problem is silently
ignored.

Similarly, in the patch #4, when module_add_driver() calls
lookup_or_create_module_kobject() and the function fails, the problem
may or may not be reported, depending on the error.

I'd suggest something as follows:
* Drop the pr_crit() reporting in lookup_or_create_module_kobject().
* Have version_sysfs_builtin() and kernel_add_sysfs_param() log an error
  when lookup_or_create_module_kobject() fails. Using BUG_ON() might be
  appropriate, as that is already what is used in
  kernel_add_sysfs_param()?
* Update module_add_driver() to propagate any error from
  lookup_or_create_module_kobject() up the stack.

-- 
Thanks,
Petr
