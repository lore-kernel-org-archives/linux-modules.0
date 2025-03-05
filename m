Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013CB205E09
	for <linux-modules@vger.kernel.org>; Wed,  5 Mar 2025 09:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741168509; cv=none; b=UExvPj25B2C9nNLJwqZfT9J/NfTIWuN+yNq8I7oCywMNLOJEwToENJ59nqdkgKADqO37cAZs5/+wHYYfFRW+pkgPBKrOdGchx7eyEZ9Ab/YgxOW5TvvBRD/9MpJA4n3RO2sOw3ytKe/VsMnCdaTItO+LmQx0T1biwdXaYaOmywQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741168509; c=relaxed/simple;
	bh=PTcgVomCwM2FB96hrOlD05ZxuTqCJVF3mwzVAg+5LPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W+c7lMvh5ynPZTvXwA4c7ySloJeuK2729X2msfe3fBQQ3xQuhq+V6ijOtPe3k7u0k+SN3zMk0792N6e5g7qaQqi+yKhBYUXU39+ue2sg2OYvf6MtZN++EwOk1OXADk0Xu4vrE0pmmv7QevuYnRz+he/iCcSz4lPTtlQr6J4qAME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=A3bhkRyp; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="A3bhkRyp"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-390eebcc371so2947875f8f.0
        for <linux-modules@vger.kernel.org>; Wed, 05 Mar 2025 01:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741168505; x=1741773305; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ydQTMdZO9ERtZacB96542Tb/ntd2ZAMm3PztulH/kfE=;
        b=A3bhkRypX+HzWwhud1wdgsTdo8XuRYzQrjtF3EkiXReb1OUg7nBvkBfmW3dm7hoR4c
         AQQmCUKyEjonET6KnD1UpUKlLhnD8YpfdrUf0tDxIjX/2bNvwf11aKP70tUb+L/uwqIV
         Vhc0+jIoyVrcLz15MvP6SV+IlHY/GWjxAVtAbTP3LTagjTffRcUmPleiYnYOE09VzvFO
         9G2fH4bDyHcCQ/fgXs1hvwQhxwMTVxsH/HOpxIFce47FkWuRWltMyk7r5a2Ysxw60Bol
         aA25IGYnYKKUBX+gpTzrFkkdSKBGgjFkhTiqAkhRGIE5mnye+2AhpndD7/oDCx7CPmxt
         oB6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741168505; x=1741773305;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ydQTMdZO9ERtZacB96542Tb/ntd2ZAMm3PztulH/kfE=;
        b=ueokPA8Wa28qHtRmnxt5hK575HKvW6svJKxgqxYc7QswOXERtLRnRXQCV6WCMscjMY
         fKcNJ8eO7qPX9z1XerJiMGAuNbTUWKy3WOxo4WnVzw3OMovaeqeaauLBb9Qwbxz8Gxqc
         SNoo/wF/Ax7U12K9eLvDADFZu8n3y+SRUJheapDW/znAGsx903wfE2w9oIZpoJWsqD6B
         h1A0bww6n08b/nFSmYJAa4TaUlRlfDzTipcZeVpFjlJ9KBEyMXxFr+qxjx+8j3rz8/lY
         Q3nXXyqW/g9QbB5R0RjhWjAvuxGhkYnRreUCovma5qquaOuYar/Jh718Sho8fHZSnWSo
         CU7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXgTHJXAbhRAHy5wXlOuxoVKYv+6VgrvV8coZBBWV4Il+daFV4pPrLEkMmnBLU12PfYYTcDqPfTsF/kVtDj@vger.kernel.org
X-Gm-Message-State: AOJu0YyoJGaorfCtc5Y6XJxeDPH4OfKq0yxBRBz4V+YEVCAZPhpEnYtZ
	+3bitjpi/ZdQwfF1kbumwOb7ajYh1iTSFAPHcndyUjNnKkqTcvzdCMmrbFX+0a4=
X-Gm-Gg: ASbGncve5jsNQwNBiM85Jsre8FqbLeAOvVQHKWUChzg311UVicObU5cf8KHRnD9EekK
	J1KokG3uC/HzfjK/3QPFBYsqan5KSOigtzO1lERXEWumWD7YSGFhpFV0ry0XkqgSsBkCuXdHTx8
	aIYQjRo4tZpWHFBPYrnzB2UPYJkfO/v7BktYHaWoSxKpkpsQBhhH56AQyZtSwU9+MuZlDvTEDCA
	x09lcmMkz1UEyoZVWkRTnRY0kQ1OE7TWCJNhsej9S7bQ0jCFgwtx1XR31C6Qh0WaBwvlCvud1u2
	sRmdrW9sDl1+Q1akN8+OO29HgW1C40GuUjj8W9//UIFtU2vq
X-Google-Smtp-Source: AGHT+IEK9mhVF3kogJq2vdC9eYsKgrFlFs3HwNqnKMY7zadk2AoV9tzmwVZnh/heIO/idk5U0kjlTA==
X-Received: by 2002:a5d:6c65:0:b0:391:34:4fa9 with SMTP id ffacd0b85a97d-3911f58eb5fmr2213679f8f.0.1741168505120;
        Wed, 05 Mar 2025 01:55:05 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7d69sm20900121f8f.60.2025.03.05.01.55.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 01:55:04 -0800 (PST)
Message-ID: <ae1f74bd-4e8c-4031-8175-240f5f8d7f17@suse.com>
Date: Wed, 5 Mar 2025 10:55:03 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] Properly handle module_kobject creation
To: Shyam Saini <shyamsaini@linux.microsoft.com>, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 code@tyhicks.com, linux@rasmusvillemoes.dk, christophe.leroy@csgroup.eu,
 hch@infradead.org, mcgrof@kernel.org, frkaya@linux.microsoft.com,
 vijayb@linux.microsoft.com, linux@weissschuh.net, samitolvanen@google.com,
 da.gomez@samsung.com, rafael@kernel.org, dakr@kernel.org
References: <20250227184930.34163-1-shyamsaini@linux.microsoft.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250227184930.34163-1-shyamsaini@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/27/25 19:49, Shyam Saini wrote:
> Hi Everyone,
> 
> This patch series fixes handling of module_kobject creation.
> A driver expect module_kset list populated with its corresponding
> module_kobject to create its /sys/module/<built-in-module>/drivers
> directory.
> 
> Since,
> [1] commit 96a1a2412acb ("kernel/params.c: defer most of param_sysfs_init() to late_initcall time")
> Call to populate module_kset list is deferred to save init time so that
> external watchdog doesn't fireup on some boards and Linux can take
> responsibility of feeding watchdog before it spuriously resets the
> system. However, [1] this fix caused another issue i.e, consumers
> of module_kset can't get related module_kobject during driver
> initialisation and hence can't create their
> /sys/module/<built-in-module>/drivers directory.
> 
> Consequently, [1] breaks user-space applications for eg: DPDK, which
> expects /sys/module/vfio_pci/drivers/pci:vfio-pci/new_id to be present.
> 
> The second issue was reported and the [2] revert of [1] was
> proposed. However, [2] the Revert doesn't address the original issue
> reported in [1].
> 
> This patch series addresses both issues reported in [1] and [2].
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=96a1a2412acb
> [2] https://lore.kernel.org/lkml/20250130225803.321004-1-shyamsaini@linux.microsoft.com/

This looks ok to me. I only think the Fixes: tag should have remained
solely on the last patch in the series as that is the actual fix. I'll
adjust it when picking up the patches.

I'm going to wait for a few days if others still would like to comment
and then plan to queue this on modules-next.

@Greg, could I please get an Acked-by from you on the last patch in the
series as this affects the code in the driver core?

-- 
Thanks,
Petr
