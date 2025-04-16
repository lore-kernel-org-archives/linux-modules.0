Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF62B1D5CF9
	for <linux-modules@vger.kernel.org>; Wed, 16 Apr 2025 13:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744811979; cv=none; b=LbQNIKSmsHFMQQlQnkJXcodB/ejetuY7TFwwR4v0dNnZyDPnGG+VohHORbX65Ss1ViknuVFSay/7E3vPVsEtZnfdb+pR5UFkEIQwOBauGaqe1Fw43e/V8hznW7NlxD81N0hw5hrbDigfDD6JtgU6abDi6eFv7PWvwVlub3eMRAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744811979; c=relaxed/simple;
	bh=PrXWueJELQClhsRoDZoa/OuljX1rJijZLuQXa9z6ewA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ef9EOKI/KpOx/sD7Fnc4ssKla7c/U5MkJKTADjdgvWjXXCmcrGgmGE6Z+hl6/NhJATFlHSejSbQ1Nh2/AAdbsb++Zs+YCoL+CD5jqQsenm+mCk0yMSfuNtbG7kjFU0XRC0wFooU+VSAjwa+m155CAsuLrle/0mQixnk55FJ720s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VQgfCytX; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VQgfCytX"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43d0618746bso53307955e9.2
        for <linux-modules@vger.kernel.org>; Wed, 16 Apr 2025 06:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744811975; x=1745416775; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D58Ch4hi8djKlPVHC4ID+DAXWkOZ6h8jrefgNN0XtNg=;
        b=VQgfCytX2s1Rtn5PSnv/YDXAGdYzskOhaEv4pnJ6l9klesECs6JZnOdKPm8SF2p9MB
         uEiVPwqLy9zN2HOSf6P8E24p9FfeX2/j3fhLDjS60yLpCDfcV5hr9rrw+TRKBiuOzKfc
         /fF595J/1hsQ/XKGM8MdJhvmGPKxbRCkKwMmTg6XtELXemfJldMx5HGhx8JZ9sOmrh40
         7dgoO7B1/pvkb3vJr/7T1gG05WD/lbMNG7LPBJnK64WZbS5VQSacP9hWLWM3U9HVo5rn
         6J6wxQUur6JsE3/jAukmCNeHdHDzNCWJ9dIQj04LSNyhd2D7t+rioARz4WG9D/sEIERl
         xDhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744811975; x=1745416775;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D58Ch4hi8djKlPVHC4ID+DAXWkOZ6h8jrefgNN0XtNg=;
        b=ocEwRQ3xC0gpquBVnVKbD7x59MRmecEbojKfpX4hOTTFS/Ny3n1X/1B/rDWWoTwTab
         IU0TuMUnb6NtFUCtyLEQediOzheGBz84DCj7T4euxTj9GW5CK4BAchTHuzAtqw08cKE+
         msSq38IRmLW1FmMyx4NwSJZrFTVtXq4CmhY4YiBEV7bRmKZTLRndG0rdky7Evs+x5HR1
         F1T9RXdnI7qD4/Iwc7OcZVxXW60yf6qFZbnDR26H/2H5Q9rkYIZe8Z0QwXasf5MUD49M
         wQFAThMcqGb29n2XgiXf1wovzpbGsbiy3hvx5jEOY823I4h8hn6cKZx+SvrMUiCiwegW
         EQKQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5AD/u844o/uGpBb0BW/pYSOJLrau18D2ZqkxOz5p51Vpof0FDmABZ62LNHFr/Z8Q9zojyomg0g1rsCpTU@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0G6hLv/HNpEptdoBFGKMZaI5YVUGqhZ5+js15Kh7txrteySTL
	jpWkVEJYgzna8QffeXfa3js3asQSnvKkLjN3CSVk2LYQkdxrw/k/otarUstP1GA=
X-Gm-Gg: ASbGncsxRbW5RG3Gi/aShmvHKpm+kqAMtU3NIAjEf4sfI56WOhOx+aM9eZmzKkYUJSW
	F136zXUX/QVr2ehh2ILhDPzwhaF0sBTQX1a4TtqFrDW53lsbYZmx9b4IIuqabN74dk65fyzWGAc
	W/aBmFqyabeEpXzuKkxGJWhJcCs7Zi0GoUUVAtQIqP4lBFRtwJAhK5D0gebEjD+O07SXVIvo2Zm
	ViHYpYbLdaiu9VM0+N4gVckxUEc9If5Ma8NK7oOnYmWQH1wL9AMlaTS0L8uH64eOtWmxm8Xf1eJ
	Rl6n6Q6yY+8FHGyDZVoSz6/xg4ulwPnNycun4ZsxOOE=
X-Google-Smtp-Source: AGHT+IHTIaWFA3QfhyJicogJ8cBkQ/je47l8+mLeE8Qjo2zZQg1uZN/gNAJBrvAGrFgjsLsXF8IfqA==
X-Received: by 2002:a05:600c:1c04:b0:43c:fb36:d296 with SMTP id 5b1f17b1804b1-4405d6ab656mr15696095e9.25.1744811974863;
        Wed, 16 Apr 2025 06:59:34 -0700 (PDT)
Received: from [10.100.51.48] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4405b58cc4csm22365265e9.25.2025.04.16.06.59.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 06:59:34 -0700 (PDT)
Message-ID: <de64c91f-efd5-49c2-8e24-b41aafe800fb@suse.com>
Date: Wed, 16 Apr 2025 15:59:33 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] Properly handle module_kobject creation
To: Shyam Saini <shyamsaini@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 code@tyhicks.com, linux@rasmusvillemoes.dk, christophe.leroy@csgroup.eu,
 hch@infradead.org, mcgrof@kernel.org, frkaya@linux.microsoft.com,
 vijayb@linux.microsoft.com, linux@weissschuh.net, samitolvanen@google.com,
 da.gomez@samsung.com, gregkh@linuxfoundation.org, rafael@kernel.org,
 dakr@kernel.org
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

I've queued now the series on modules-fixes, with some minor cleanups to
the commit messages.

I changed the "Cc: stable@kernel.org" tag on the last patch to "Cc:
stable@vger.kernel.org". Documentation/process/stable-kernel-rules.rst
recommends using the latter address by default, unless the patch is
fixing unpublished vulnerabilities.

I've removed "Fixes: 96a1a2412acb" and "Cc: stable@kernel.org" from the
first three patches because only the final patch contains the actual
fix. I suspect the stable tooling should automatically determine the
dependencies in this case, but to be explicit, I added a note to
stable@vger.kernel.org on the last patch indicating that it requires all
other patches from the series.

-- 
Thanks,
Petr
