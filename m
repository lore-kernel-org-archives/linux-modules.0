Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD324AEE0
	for <linux-modules@vger.kernel.org>; Tue, 31 Dec 2024 15:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735657665; cv=none; b=HS/qhHvQTqkGBwxAdAU7rucgw8NzFDeCDBCYqyrIC9GlouO1ZreBAmRL4vK19WXYQPtiwlajYJfwmF8OIS1FjIiHtD006+Pg/XJYtSgS8HcuPxYppM8ldpAbO8TvZtm8x9wWBFTjBr+qULXdtcrsY4HIOg3GIhDkkK9jlB0+ttY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735657665; c=relaxed/simple;
	bh=7T4DV0auzHCqWowukXCz6tn0seEM3YlHEBwNUYhro+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iJFQFuodOkNAFGsWecHS4clDeSpo+BHQu9lUPCHfCog7bhk12p0RqI4pU5ToaeHQGnjH4NiOD5D+P97rHqbKhCqVWCz/XxdkkEDnp4+hdY9J0u0LlzdLFKTMbjC75itu6WGhkqvDTtcZ+dBHcxUL6HndpLwce7tA4Be6qXjBjGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=M62PwmXM; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="M62PwmXM"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-436281c8a38so72632375e9.3
        for <linux-modules@vger.kernel.org>; Tue, 31 Dec 2024 07:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1735657662; x=1736262462; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YGH6gwG5Xb5ESfXY/MA29Qmw2CKnxkBUQBkmVQ01IGI=;
        b=M62PwmXM48WyY6v7i4+AhAIm1tYKmtc/hIiMM7QwAzv+lQdYa8fOiPeD/7A61gNuv9
         r59dXfZ8914XBQhIYNrpAFESwHQ+/Za+cwdx9VSRDEdzmR66bccyGoDvXQPioc0RIedM
         h6uyFx+lAo7JaAFxTPSOrvgcR2IdYub53VWNFNaaoEokeTAS0eOoXSFXofl1xoyUZylY
         eQp5tOfUb+gjoYad5XizlAmB53wRpp7ezIWEDuSld1Tzk9qnXDv8olGL7BjFFThubJTs
         xJm7c1xKDhJlf12J+pk81jr6rJZAvpRIynwWbxC55Z7YWXK4rFlpsR481SGSM3Mz+JV4
         Pldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735657662; x=1736262462;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YGH6gwG5Xb5ESfXY/MA29Qmw2CKnxkBUQBkmVQ01IGI=;
        b=WDoLcmluwT8P6GufsBdJkz30PHoKwWT8wog942HuVcuUmSIl5EmSqxOxHHcBPjnlnZ
         L0pKefxu29k/azZSNrzF8tYiBJD07Wq0dLKpj3CKuVSnINPMQOzVYREFKZ+sohUTXSa9
         BvErXs2WeQp/ASavIjQI883AHxqz7DSG7Gn3oaae/+30wrNIlN0oDI00hdoH21RGItZe
         4ZQe3zblaubWnC2s14JvgNhpiOBiKM38A4cezuVhADwwIRHI5mwsudAySskYfC8dc1xZ
         CAwE1S9QkaYPOn93dE4ac3590i3fOz8qmQGIpxsUP8FsJT+LarwgO5JSd/TWzTBmCegj
         wC/g==
X-Forwarded-Encrypted: i=1; AJvYcCUKwlfZR5wzLDbr/g54nZYkpamp8B28NuS2wJboKAheKyz8elGateEoPWp1Zmj89cs1F2RCzF7NKJtfr3x/@vger.kernel.org
X-Gm-Message-State: AOJu0YxQdUBIFI42VQl/MiSkT9rA/BR4BuypnCNmYbNISOZfOnCnllLl
	ir2Ud6L/qR97AgqF5ZHHYi+yu3FJ2arxx+KYlCRy2oCCWndJDrOkF6JSXg2NToo=
X-Gm-Gg: ASbGncuGW1CQsrHrFKtK358/AtCR+otNQ9g05Ic1WYVwz9YuAWkzv/f5dO/546dbc9A
	Uk7s5jp1JhMnfPdFj22u+A6p9Z+oyZvQQgFekg1tIQD39RVW0V5xHw40PPsOjlmNztDCittUVHh
	jUVvUmNjVSC5Y0V/Fq6165ZZUveUJmsoDsYss0F2e6mATWJuGHWLxWaaEKYOjuvgtNIUvt+K72W
	EodrwmUs6/oTYvnQ7SQaf1dw04gM6iAtxMskqRQw1bftadueeslUx7pzF9Q
X-Google-Smtp-Source: AGHT+IEQX7+jmDBfEFlPjoa5E+KUjabDz97fq64ACPOl/s0+xNhI+LwPww6Bq08B/1q6pymIBBKlkw==
X-Received: by 2002:a5d:5f8b:0:b0:385:fc70:826 with SMTP id ffacd0b85a97d-38a223fd808mr30893285f8f.52.1735657661777;
        Tue, 31 Dec 2024 07:07:41 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8a6abesm33021317f8f.90.2024.12.31.07.07.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Dec 2024 07:07:41 -0800 (PST)
Message-ID: <6f2d2843-e676-4d4a-86aa-881378b1adf1@suse.com>
Date: Tue, 31 Dec 2024 16:07:40 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] module: sysfs: Cleanups and preparation for const
 struct bin_attribute
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20241227-sysfs-const-bin_attr-module-v2-0-e267275f0f37@weissschuh.net>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20241227-sysfs-const-bin_attr-module-v2-0-e267275f0f37@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/27/24 14:23, Thomas Weißschuh wrote:
> The sysfs core is switching to 'const struct bin_attribute's.
> Prepare for that.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
> Changes in v2:
> - Avoid NULL-deref in free_sect_attrs()
> - Avoid double-free and NULL-deref in free_notes_attrs()
> - Also drop 'struct module_sect_attr'
> - Link to v1: https://lore.kernel.org/r/20241216-sysfs-const-bin_attr-module-v1-0-f81e49e54ce4@weissschuh.net
> 
> ---
> Thomas Weißschuh (6):
>       module: sysfs: Drop member 'module_sect_attrs::nsections'
>       module: sysfs: Drop member 'module_sect_attr::address'
>       module: sysfs: Drop 'struct module_sect_attr'
>       module: sysfs: Simplify section attribute allocation
>       module: sysfs: Add notes attributes through attribute_group
>       module: sysfs: Use const 'struct bin_attribute'
> 
>  kernel/module/sysfs.c | 116 ++++++++++++++++++++++++--------------------------
>  1 file changed, 55 insertions(+), 61 deletions(-)
> ---
> base-commit: d6ef8b40d075c425f548002d2f35ae3f06e9cf96
> change-id: 20241215-sysfs-const-bin_attr-module-be05346937a6

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

I'm going to wait for a few days if others want to comment and then plan
to queue this on the modules tree for the 6.14 merge window.

-- 
Thanks,
Petr
