Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB66A35970F
	for <linux-modules@vger.kernel.org>; Tue,  9 Jun 2026 14:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016661; cv=none; b=b4Q3/B0tqjIkqVQOpxRu+gbieZnv3CLWETLCuddBtl1xTi/IBjRugrh9Vo+XbQROwQfag/3trBr8bYSEczNO4vusNfKSnc0qvJkg/QG7fUNoShHS4n7BEIMevcBuF9fqyP0b1M5otiYNp8o7xQU95kqD/nHRryyHOmw9aPCT93A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016661; c=relaxed/simple;
	bh=mf1HUDle1WUGiJkUpH1a4Nc4jxEdXDDU2aM4xHAA2N0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k4YZWNunZL5Xa9T3kfeOf0SaL2kx3wGSaAVR/l+Fwo0Gq/bw+fuWNEygGSAIIVNxPEBcyUufW28LURuIiYeaMW62J2/9c2kjr76bCmylJTtFFYd+XDFhuJN+AfoRAHf7BLsSB0Y5ObXm12R0XysILtgKSb7iG0JFuEEEk2MTduk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=E+YOsstV; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="E+YOsstV"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490ac357c55so61613905e9.1
        for <linux-modules@vger.kernel.org>; Tue, 09 Jun 2026 07:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781016657; x=1781621457; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q92fKDa7/rVm6OlNEnz6UaasYMrx115XbzpwtLvtIjc=;
        b=E+YOsstVfrrR0T6dHb9ILXbwUvH08BejWL4sfD0xAjaajq6mYaZmH3uGeVl9QiWp/J
         CWWfWalSjbz9Ij2PCqLOHu0GnSyW83IwUJ1mZCb5nfYkO0AdmwwK1M7k+5eSTVr4etDF
         gw8Yyz049VmDcqWkM6/T0b3iB+92cSKlbm3sKQ7tBpz98YHr1cHoVgR1sKYJP7ALS4+E
         P8t6fqjo/E5qghL8okLIj5+dl1rHGHZJQEaeLOcnxyvAe3J+cN9igNGUFeT4wHhA2/Sc
         BOUpkvIdEdczUtJAk77g7Yv9uuMHfGYvjoETzid+3qQQz1Lrj/vtyJc84bd7pKn9yF6B
         fXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781016657; x=1781621457;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q92fKDa7/rVm6OlNEnz6UaasYMrx115XbzpwtLvtIjc=;
        b=qtCUJIyQte8SiKDAxdhNBxmrHIiB7LtNdJtHCkDdbx9paR7GCbmzezSro2u0am/ICm
         fZH9lY5RK3dwiQb3AQtfu7IyZXDn/Zf3X3Il2WdxBPwktZ4+OxueNDssWQH/EjNk7hgY
         LNCzAHpbGB6TwGELfqEB3xDAo9de3K0F4bSOqR8a6y/V5oU9fBpKKMTbYIVm6+ykRR+H
         4jim1uaLzQgaZEny6wysMxwSkLNc+IAW91RUxqpoVp8gXGIbnrE3WFXr8GcOvwy50RVF
         10sYtvMybY5FRdwcMdsnK+orLyiD1lNwco/WVyJpqmZUPKq8DiRDaQSEHYI0J3ktd5zD
         VpIg==
X-Forwarded-Encrypted: i=1; AFNElJ/o2TAgVySqseyPl30lL+gVRrw++k2SxXwJRYjSAE+9cUpA+HtD2ClO64ZABqt9QEMLNLMJ1gbuQ/LVaBLX@vger.kernel.org
X-Gm-Message-State: AOJu0YxBOWfvIirTtaVpMoQq4k6ur8mdKa0Z8LX+9Z28MY4yacWWRUKh
	BghYk8wd0OyVKquEOHWyW/IGg/4CzxiTc2XslR0LBG1jBxD+NNOuLX0Zr2kw3fGw8m8=
X-Gm-Gg: Acq92OFoBAvvbRIlTfJBySOno/sn2YhVPMdzsUm+r6Q3ndelyTPFKLQ7euQ3ZjIOUAH
	+mUQEZrTJyqMCIks6HtTwECCD1Ui5Y0jan8QBTl5GfNjw347fLPKzjPVdwPgks22HWXPvhvzf8t
	961jkyc7dmHM/Xjp4KmOMlfjw1F2CPcwPUavGAEKlvQU9t0z4hFhws23/hH3k9+gEZBED88FZw9
	AJmziHmLzhe1MplnzZIEtzxE0lPcO1jbFHxmLj1ECNgzPH1Oslca9lgxfqye9K8fhOY8WIO7YVq
	QFso0bxlRsLK4bRNje7AJAcXSha5Yajz8R0d+SupK6QX87kZukqu/mDMY+8ddhyf7rLu6jfga9k
	fgXsQCaRsYHmDuOedGI0cUShzrEqbOTCt3cw3eO1QwggMJErGSvv8kU/3gD1hKD69W2kw/l4RXk
	E1FMuruS8sBYqBxDemtSnaFAia6RgtkkGj6Q==
X-Received: by 2002:a05:600c:3e15:b0:490:adb6:793d with SMTP id 5b1f17b1804b1-490c25f67d9mr335335985e9.26.1781016657089;
        Tue, 09 Jun 2026 07:50:57 -0700 (PDT)
Received: from [192.168.75.2] ([62.77.90.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490be1f69bcsm526283115e9.8.2026.06.09.07.50.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 07:50:56 -0700 (PDT)
Message-ID: <d67387e6-6531-4257-b11c-bb5ff0190824@suse.com>
Date: Tue, 9 Jun 2026 16:50:55 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] module: use strscpy() to copy module names in stats
 and dup tracking
To: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
Cc: mcgrof@kernel.org, da.gomez@kernel.org, samitolvanen@google.com,
 atomlin@atomlin.com, linux-modules@vger.kernel.org
References: <slebbzn7p6c4ybokolvey2sgvrooit66zjewwggqac2755ujgp@ptanmtdclmw5>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <slebbzn7p6c4ybokolvey2sgvrooit66zjewwggqac2755ujgp@ptanmtdclmw5>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/4/26 7:45 PM, Naveen Kumar Chaudhary wrote:
> Both try_add_failed_module() and kmod_dup_request_exists_wait() use
> memcpy() with strlen() to copy module names into fixed-size
> char[MODULE_NAME_LEN] buffers. Neither performs a bounds check on the
> copy. Current callers always pass names originating from
> mod->name (itself char[MODULE_NAME_LEN]), so this is not exploitable
> today. However both functions accept a plain const char * with no
> documented length contract, making them latent buffer overflows if a
> future caller passes a longer string.
> 
> Replace memcpy() with strscpy() in both sites, which bounds the copy
> to MODULE_NAME_LEN and always NUL-terminates.
> 
> Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr
