Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869F770817
	for <linux-modules@vger.kernel.org>; Tue, 12 Nov 2024 12:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731416198; cv=none; b=Ij9GZ435d5sMGfrFaOvXPVfBtEAFU/TPDxnknIl/LaEK6x2LchZ8Dn3uRYbZRRPdG3gprfRPZv1v/+XWe9nMfzQX+LSHJsU+669WOoXI+l5S4sremsvWEjTYhBCocucy/vRyl+dVYICVojMWwVWXp/+PWdzrmrVbkXGSP/MIRRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731416198; c=relaxed/simple;
	bh=hkl5Gk8YUbuDBxdtA+tYz3gdF4iHZdjZ8ozB0FFI3ao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OJQU9QKcdaj3207v5J8SiW2RCJ6F5boPFfV6o3j4jg72b4VjfHxOlLDYK21xHAaQJ5KXQCg6fFVj/d34e8ZKB9qd/b40UkTJS7PT3bOTdBgFeHedpvBxfc3xHZpmGPnQoJLEmd/s2lK4QJIvIOltVnNOF03Bklc2ynwE4guKphU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FkjbSyCJ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FkjbSyCJ"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43162cf1eaaso70941215e9.0
        for <linux-modules@vger.kernel.org>; Tue, 12 Nov 2024 04:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731416195; x=1732020995; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=keMm/XcdzWtgvAlvRE4Z0oHWM/adVb8nKQNHCCCRVCs=;
        b=FkjbSyCJyThEQerT3Qu37cx88lIePMpQh6EzS33HXd024pRNNz29hc0AQYL4PBiW8L
         RYykJZKwFFsWSLRyLr+FOYNMU0PZeF4XmZ73y25Ayb/WTXiciUyVx4dSsTYC87ytJ0sS
         YO2f/voGGGw7LH9PqpY+HaWzPyjkNLEAsDySVWwqYNnAWJ8sj8i//S2U5UmpRw9O8tJ/
         9TbgUPgv06sprCKMI9l3PwBZoGMh6f0Jg7hWYRs7M5TSrfXkcH8v7WVexXdkdHk2Uf79
         zBEFfTJwkrvMXe5l1PxZVMn9/N3W/K+oAHrTrYBdPhyc6uGExJeTYDaXRj2YCNAF6UH2
         48QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731416195; x=1732020995;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=keMm/XcdzWtgvAlvRE4Z0oHWM/adVb8nKQNHCCCRVCs=;
        b=cjNzvVkFMmfZ6UkwXnhgFzDU990tMRvS5c2y0n7HZKhNphYmdZcCMfkImUF8fCMxvc
         MbJnY4cQ5dT8C/6hVnatmwKtwIwLjBJ7+gpo0CO7FGKnoo8Y95Rqf82gG1LteykY9RxL
         UFTEz5yukklO0XOnKeeI4Q0NU5rO7nTVlnJ8BPMWLQgG+PFHawjnM5y6r1+5Qlim14Xo
         oSzq8jKt1wW834w/TN/fcj0vZ6JZkKW4CGxLLPe33sOrd+HdbGGFJA3+j26XSzJARPC0
         8TM+/kjusaqwuYtum2Bm5LSAtfTej8fQIjDY0gjqsufFfW/U81YOjADQE4I0KAHv4kp6
         4dcQ==
X-Forwarded-Encrypted: i=1; AJvYcCU02uLMOxAhQ7LYDac3XI1mPEL+xcsXjUSTI/yRdLgBdPm9v/vSDUA1oN2DyJu9Qcrmvdi9iKyn3zy0VQ3A@vger.kernel.org
X-Gm-Message-State: AOJu0YxQlTipCzkOPOa3249p/WjAFmCR37RRIcj2PBCe74lJF7Psyypa
	TbO5Go67mYqYFlUepl+vVzkDnIeGN/VWJ27er5/FduvWVPvR6xt02ekys3nFNpg=
X-Google-Smtp-Source: AGHT+IHx4AX9fOB5xlL/QIFvvYmdjXr9d1ms4fnr49vSvOp0bowmImpsJgEZIIv5Qgt3XhI7LklPZg==
X-Received: by 2002:a05:600c:4f10:b0:431:52a3:d9d5 with SMTP id 5b1f17b1804b1-432b74a07femr190104935e9.0.1731416194895;
        Tue, 12 Nov 2024 04:56:34 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381eda04211sm15351807f8f.94.2024.11.12.04.56.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 04:56:34 -0800 (PST)
Message-ID: <21423aea-65c3-430e-932d-2ba70b6b9ac3@suse.com>
Date: Tue, 12 Nov 2024 13:56:33 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kmod: verify module name before invoking modprobe
To: Song Chen <chensong_2000@189.cn>
Cc: mcgrof@kernel.org, samitolvanen@google.com, da.gomez@samsung.com,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org
References: <20241110114233.97169-1-chensong_2000@189.cn>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20241110114233.97169-1-chensong_2000@189.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/10/24 12:42, Song Chen wrote:
> Sometimes when kernel calls request_module to load a module
> into kernel space, it doesn't pass the module name appropriately,
> and request_module doesn't verify it as well.
> 
> As a result, modprobe is invoked anyway and spend a lot of time
> searching a nonsense name.
> 
> For example reported from a customer, he runs a user space process
> to call ioctl(fd, SIOCGIFINDEX, &ifr), the callstack in kernel is
> like that:
> dev_ioctl(net/core/dev_iovtl.c)
>   dev_load
>      request_module("netdev-%s", name);
>      or request_module("%s", name);
> 
> However if name of NIC is empty, neither dev_load nor request_module
> checks it at the first place, modprobe will search module "netdev-"
> in its default path, env path and path configured in etc for nothing,
> increase a lot system overhead.
> 
> To address this problem, this patch copies va_list and introduces
> a helper is_module_name_valid to verify the parameters validity
> one by one, either null or empty. if it fails, no modprobe invoked.

I'm not sure if I fully follow why this should be addressed at the
request_module() level. If the user repeatedly invokes SIOCGIFINDEX with
an empty name and this increases their system load, wouldn't it be
better to update the userspace to prevent this non-sense request in the
first place? Similarly, if something should be done in the kernel,
wouldn't it be more straightforward for dev_ioctl()/dev_load() to check
this case?

I think the same should in principle apply to other places that might
invoke request_module() with "%s" and a bogus value. The callers can
appropriately decide if their request makes sense and should be
fixed/improved.

-- 
Thanks,
Petr
