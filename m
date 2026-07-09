Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9F4340419
	for <linux-modules@vger.kernel.org>; Thu,  9 Jul 2026 08:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783584989; cv=none; b=HWMXXvlPJgx1v+ltmgUUWtZQaxbPPcdE6DjkQerlMkpoV2zhYVjWErB0vhi6s/ZbKu5fBAx9itysljUk7fUjeCB0+zhtSyyWrvpz4Bh5z0Lkpj1GRZlrjOO5ARPCL7bhwqzMy3zjrKAIEoBkeRRbRNBiigrQfrsT42Id7maKU6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783584989; c=relaxed/simple;
	bh=kLOJ7RxIgm/eRoGa85IctbDCif/WtYipesfp+JWhIdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GOiRRRtjKOHlf7WidvyKKPM+9YST1bkqi5v6zknH5KBU/kPkRWAsHuylgsZCSTXNSfmVzyqOtU1OToCl+kQiFT4gf4Q8v8TFnbbc6UV9Uo1Jz1YSjdegZFThrYP/1GHxE1UgxOguVd6JczECJfrI8itvBS9Iq5MT6zkmUiE8JEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FBVvKhcn; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FBVvKhcn"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493c19bad03so14533585e9.2
        for <linux-modules@vger.kernel.org>; Thu, 09 Jul 2026 01:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783584987; x=1784189787; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HAVnh7peTN8HcGY/83AlObHV/8XMNSyCJ0EV5LzmUC4=;
        b=FBVvKhcn9/sX+VZZtJVFgKIE/3oxhEzabfsAMlmS3HigWq44JgFbP6CuLs/JJjJ1/E
         528czYgWL9LCDSEnPxlrMxFwTnxgnxK2+NUMerWPUqVLkU7NdmFQLznxFVv/wtMk5kNl
         z4WL5QgY54+i9VEW/xGPq1Sqp663J1aghCiEk0RrhFux5NJw7DxMY+iMcp9yaUAYMscm
         9C9L+iTBrU51flUdIiyl61IB8ShDpsM1P2kYcK/PgmniqPXZMbjL0eliND7kp4C6QcqP
         3IioNMeqE2+ff46rhV0l4qvDpd28V98hdVFIebyS+Ae95nxItlfhi2O3oVXEDEcEz2NC
         zb5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783584987; x=1784189787;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HAVnh7peTN8HcGY/83AlObHV/8XMNSyCJ0EV5LzmUC4=;
        b=bHRq+9LdLuGoiRbnAO5YNWNx8Gq3xnYO3fB5CYjK7cZ5ruFC0nqA4kM4xXOGSUM3ie
         XrXxPZ0u47NQ/AWvKPFH78X0kDCYg/xgQ/LumbIsBYTXI3B5O/YS7Jud+PLAz+QRSU9P
         ads8yzRt8gwZOgQB4vpH/Q0CgemyfUE5LIrqW4ncPfYrtHcMBy6xPArcCMNCvTF8whd0
         W58+X5Dtph6khkQSyJJgLxWEN8GOy4qXhuJZJkVuNqkiYxE5JQRCnBVIdC9blz6yj3Dv
         e1NlHBb2+hoMjyRvuJQEE2BZhXlgfdSFaLZnvmYGCZcCJgrfPtSfFEVANgLgF30rLuGE
         +Nsg==
X-Gm-Message-State: AOJu0YwDOfDj4kFJAQtwAyv+OFpQsHqftps5Xyjo6G8AY6A1IHcrwIom
	9Q7BYmAwa4yGf/U3wu1Jrb7V+hdlHs7L3/eDCEv8VwnFt5eo861PMbHDdCOmt4f9eKA=
X-Gm-Gg: AfdE7cn5B8+5C2gWPUOBJfRPPpn3RIikr1j9A3ScVbaStA+e1bcTcyBWvjbjKr0OLJp
	K8krAY2m7ebbVVqgVK/hvMQoZtUKCf5ZwDNZ/SdMybljdD6YrV/HXOZFspOkWvZSccD+RUQVL+7
	f08fDjmXe6DrLEfXdJIJNczozVztxmjb4yyFjZsvn+y4TW85el0MhGBp+bgKCqDgIV16m7QnBOv
	pCms040RQSb0zogDhhQGvTpGpXk4TRonADjkLXrPhRzI2Vn2NdSsqeM9vYsgnxLQWDUCQOWHPeG
	Omme59+6q3YxJ7aZdJQdne9NVZT/VB0HYckpMspKj/NIdskST1IS9KVaic6hx0R5z0ljVXsLHeY
	dBXmrwyj8dohTzVWG6DG7QhNTjkaRQDB7zifrVuIkg9iGUFrJcmNr9+ESWOLyb5/zZycGqJJU6U
	p2Kgl8BwKVB+MRKE7WxePhq6S2vWKARRQmkA==
X-Received: by 2002:a05:600c:82c3:b0:493:be13:98b with SMTP id 5b1f17b1804b1-493e685f507mr55181865e9.23.1783584987070;
        Thu, 09 Jul 2026 01:16:27 -0700 (PDT)
Received: from [192.168.42.79] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6df6d9sm51611015e9.7.2026.07.09.01.16.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 01:16:26 -0700 (PDT)
Message-ID: <49369f43-7cc2-4ec3-9bb6-d30ad6dc88b0@suse.com>
Date: Thu, 9 Jul 2026 10:16:25 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] params: fix path of /sys/module/XYZ/parameters/ in
 comment
To: Zenghui Yu <zenghui.yu@linux.dev>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 mcgrof@kernel.org, da.gomez@kernel.org, samitolvanen@google.com,
 atomlin@atomlin.com, rdunlap@infradead.org
References: <20260621082223.11439-1-zenghui.yu@linux.dev>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260621082223.11439-1-zenghui.yu@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/21/26 10:22 AM, Zenghui Yu wrote:
> The comment wrongly references to /sys/modules/XYZ/parameters/ directory
> instead of /sys/module/XYZ/parameters/. Fix it.
> 
> Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>

Queued on modules-next for v7.3-rc1.

-- 
Thanks,
Petr
