Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788582BB17
	for <linux-modules@vger.kernel.org>; Wed,  8 Jul 2026 10:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783505451; cv=none; b=X7aXgHqvo4Nzdazzeqc+KZ4y5t2STZUTajB8snck4jSV8B9X25uB6CjSz+/HCUTBLBYhYV7XVXEpqEjBdjtl7mjJ1wzM8ofa+Vb572ETWtKHd3TGJ04lU0OWHBBslAv1Cx5Mn0qmgOuTenGAIPELGMNIjRhCcJJBh9yeLF0Dzlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783505451; c=relaxed/simple;
	bh=ecF2cTn5AYhAAM68s9B/PAUIJM5SNBc7WXxDZmZ73mo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kGS5PG08oVs7QbyN7BarsaOL3Y4K87l0P6KCo3IBxAxG6p+PwVIRbB2O7NapC8tUyI4zmCC3xalwsVCu8AU3dEgPonlLoWD2wmWv7aWzjrZJau7xCHDfY06QtMmeUfkTWDp+zloXVzkYvpS+iIlQJgw2BYYogakPI367bKPDOM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cX/uMt1R; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cX/uMt1R"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493b691cb44so3254995e9.0
        for <linux-modules@vger.kernel.org>; Wed, 08 Jul 2026 03:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783505449; x=1784110249; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JNhfZKXmPDIRApTD3u3cceCo1e7KoMWEMGSpd5WD324=;
        b=cX/uMt1RSfp0n/7y9fyGVoExl7JnbjQQtYqyosKI6Up334zNll97aeFqpf/AJARIzp
         KOXS4t3NsVDjNslte7VDW4gVwbMPOm3f/OUfySnXs4WIsd0dbSQWhP+SqmXEEToeir1S
         D1G3PMLsJgmYQD9a5WTxu7ARw2xrorFuXb/GWZtKNOi1q5dTQpgn/mURcdmE2lYgmPSQ
         iQ64J2GQ/jUX6jlbvjmUVT+DQiZfh02bTJEhRdHBJNM+4N8Yyl/eh8z8YASKgKc+Om7i
         3CSZFxq4G54qEoYLRWwXSCm5iY8BZU3r8IYXKeIz4eLc30AmBYuxp1jFUO90Hi/OXwjP
         xunQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783505449; x=1784110249;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JNhfZKXmPDIRApTD3u3cceCo1e7KoMWEMGSpd5WD324=;
        b=PZDZWDmG7Jx6sVRGehA3K1VWTwsQ02SqrC/aILBvRHf+AykmBiAlD2u58gyM41BQbI
         tlH0uwoytjf+1fQvHeJZMu9CDDI1Zec+ZqQfJAq/OKGaVdgouwZDL+nWGVqAYnvTGoVm
         uLFNiwQdP6FytQWxP8LB6N9qYkvUD8+2mrRVsLjWeHHlNV/J3QRt1PnRsp9Swt/s+7/c
         rELa9+pXIOML1Yq6bZmrpAUnxids+oQVyMyqCCf1w4aORvlQ0x5vN3wGTn6+mlPc9lgr
         mAimDRYBMVsL8GxPEHBKa6ybzZE1vDJJKqL/581f76eXsUNzPAro5RXTwa9pTwoRav5+
         RuWQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro5CeYK8YgyRSsCAOhjj/DVz8IJkneNiWqYjnZ00CmZmkbil1r2e3LR5G/DTV7/0Ia+/gPWKiBNk+xyZb2o@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+mRJzXNeNfQ5u1DTfcnSDrkaImcR/lrKcW6OoCRdLITKrcAjW
	1VunHgSGWovJtfv70eA3kaWVG0MxBEgfdCZclnbX9iVTWc1BeDIh1R083tUo3+u5Omo=
X-Gm-Gg: AfdE7ckjZFX3qjm2FJlVbF/k7eChK6xdso4+4PeqNWLpPep85+tg8zOqNOSOC3GIuhx
	cFtIl1G/tKmnppsmoAKtrI/T46fsqaqkcXK0pUXNeFDcw9bd7OsPfzanAtUsuAY+5PgiUKWNSNx
	ALknyPjJqxGEAzKXSKHInNl4FLan1V9UPzQK3MvA6nKl0rxrIh8LR97UFT4NQVgjUyZm/ErMFVE
	kB7uvpex2yvLVlncDVmvnKzdcHaZuEEOTnsM4wwFqnMB7LSs2OjNaLVExVFomRtnKuZ/asXvIMI
	yd2seNfEMi0AVEtot5tY/s1Q6utbXfy4NKJfxbZUDV1yOvR7y6XXwed03LcYXOo0sXY1XZhYNYe
	J5wIa23Qp027n+DSGwIjf7QPRObDQhzmaHAyT/yaCZGwM/hopVj1e8KJHbriwd4jbqQ+EjaOad0
	nWZFAdSYildGcOnoPVxw3pGT4hnH52luEi2g==
X-Received: by 2002:a05:600c:4f91:b0:490:be14:bfda with SMTP id 5b1f17b1804b1-493e6859a48mr17703585e9.6.1783505448853;
        Wed, 08 Jul 2026 03:10:48 -0700 (PDT)
Received: from [192.168.42.79] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0fbb410sm130766595e9.12.2026.07.08.03.10.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 03:10:48 -0700 (PDT)
Message-ID: <883098de-dc3c-4c72-abf4-75b67c0c3351@suse.com>
Date: Wed, 8 Jul 2026 12:10:47 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] tpm_crb_ffa: Include linux/slab.h for kzalloc_obj()
 and kfree()
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
 linux-modules@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
 linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>
References: <20260707153819.4172541-1-petr.pavlu@suse.com>
 <20260707153819.4172541-4-petr.pavlu@suse.com>
 <20260707154337.CE2901F000E9@smtp.kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260707154337.CE2901F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/7/26 5:43 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] The commit message incorrectly claims that the file uses `kzalloc_obj()` instead of `kzalloc()`.
> --
> 
> --- Patch [3]: [PATCH 3/4] tpm_crb_ffa: Include linux/slab.h for kzalloc_obj() and kfree() ---
> commit a56e4cf89267d12126bd70f7981a05c846959016
> Author: Petr Pavlu <petr.pavlu@suse.com>
> 
> tpm_crb_ffa: Include linux/slab.h for kzalloc_obj() and kfree()
> 
> This commit adds the missing linux/slab.h inclusion to tpm_crb_ffa.c.
> It removes the reliance on indirect inclusion through linux/module.h.
> This prepares for the eventual removal of linux/elf.h from linux/module.h.
> 
>> tpm_crb_ffa: Include linux/slab.h for kzalloc_obj() and kfree()
> 
> [Severity: Low]
> This isn't a bug, but there appears to be a typo in the commit subject.
> Did you mean kzalloc() instead of kzalloc_obj()? Looking at
> tpm_crb_ffa_probe() in the driver, it correctly calls kzalloc().
> 
>> The drivers/char/tpm/tpm_crb_ffa.c file uses kzalloc_obj() and kfree(),
> 
> [Severity: Low]
> This isn't a bug, but the same typo is also present here in the commit
> description.
> 

I don't see a typo here. The code uses the kzalloc_obj() macro:

https://github.com/torvalds/linux/blob/v7.2-rc2/drivers/char/tpm/tpm_crb_ffa.c#L339
