Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC091AA1E0
	for <linux-modules@vger.kernel.org>; Mon, 17 Mar 2025 16:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229706; cv=none; b=jsU1iN5QIZNPhSQ8f5cPXq7z3ozPC69TpMF50Osxwx+guNe6TrCLraFMV+UNmusmNMX+EpfZYKSLa37r/A6/s1w9uU1AV0MFlrxWspdmFhJzrKA00Pbvg7R+SuG0oiv19E6nwEUcrI0XcwQyZhhZFoO3TCT/4PsKFKO118OMn+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229706; c=relaxed/simple;
	bh=5iUIlaBwM9u3v5QQqv3rwUuNzswIS61vXVZ9uDI3UDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UOc3JnWoEoDS2eoeBVk6ruGnYpkAJXw36kEqv3kQ8b8yj+p3uO3Uc3A02dulmpD1QD8kKoRGKz2p4FTi3alN4IewRJwSWtQpgKoRYFBGEKyIbFO4VLsYk0Dy2dgMiFNg0MmITS+qmA/FV+OieZwUZCMJ/s29sQJmM5FOrF7wI+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IU4DAywv; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IU4DAywv"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac2af2f15d1so676268366b.1
        for <linux-modules@vger.kernel.org>; Mon, 17 Mar 2025 09:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742229702; x=1742834502; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SP15XEs4ihxSPIGfYJR7aJt2lx0C1YHnw8AJSADx2mM=;
        b=IU4DAywvNRq4hjnFcoIEnVIWr4eBoyyDTq9CZBfAhIAyA3jXWFNkbKbzJI3Nlms8lU
         yuCsm7Phz4MItJ8yScCFNOISKgPmuWgAMUHksfYepHeKXS5vCdpH3Bx6uG55c05svNJa
         i6YFg9x1Pcp+hIp8qQ6MFsaCJ457T1NPow6brUbdsW+IO2nNJ7nCTQCxrGlefbR3Zw/w
         mx3e9U69zs70LtvXwpTvfWmvFl2yVZLs6ZqyUHZYJu43yrAbOom8zzWuxOxhmjeiYIrE
         nMmg9kt1W90lhrAzy2e/A9uOd5bUNoEzT+KtXE44mwIsQHY+BbqYWRl+6uptEjXo/6nZ
         lZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742229702; x=1742834502;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SP15XEs4ihxSPIGfYJR7aJt2lx0C1YHnw8AJSADx2mM=;
        b=b2x2zgdLhI+xzFgkkbRlWtW6g2XUIa4+JEp1oyzf4cFyCNkfKqWnONtxLAXmL8LQo9
         ztkjWasXNYNsNmjNeqJkoXpGmCPdqAqDepnYOo6DXH6BYNsy1Rbl1rjPc7iq1RP/1Nfx
         s584LMGPjJRR/OPPeElescu5zIXUG+iBphIJ2eeWjMu+NWoaRxre7TEa7TfFx+bFXLCf
         S31Mjabh4CBwAPKxY2XuvyL4P78/9abbz5Ky9XJm1DcL98HKjS6mLJP38i/jGn4qXtcS
         YrcOysu4nZqJnUZ2bWsJjR5sehBvzTTAx25Z/P6bIzWvYilbwIAv5BtxQzCiJ9uhk25b
         cG9Q==
X-Gm-Message-State: AOJu0Ywm2X/1WMYMUR2mgUw9UFLSYIyvGJN3Fx2x7GVMha5LfoSSYb/K
	ONInKa57D3pqDYULz80Mv4e2YQ9z5WnLpH78qDNTusHz1RBLqgPYhh7ylsFfoZdNgZOKWAHY8aY
	E
X-Gm-Gg: ASbGnct3zSKIuLgz86X6Voeqs5CuWf/gcmU3tW4FadrxQIn9j3CaphNO5rEDaiNIZtl
	7niCERgzChwZW+D3S7xEncC0t5Q5THnr1D0qqtpsVy7d7R3af/ElPj2UXsoZ3f0sooFsCSgJWGU
	jwzRHfjStAkNe+KPo2cW/kfo4kL+ah0DIs5aUI4j3zZmQQZCsGCJIwe1O9M6QnIm5ZCN0neUGZ9
	pHiYJOXeYdrXvMNUOQ+hO6/E1/iBOpaEc6yv/TR2/T+X7nogg1edPMBw+0gG5YHjmAv1kgsnztn
	UvCM/8CA/xpODrhn37+D5dkRhbKSDjQ3UkrDqUNid58X0Fx5jr/C9ex/s6s=
X-Google-Smtp-Source: AGHT+IFoLOD3jAxOmX2klAd8yu/dVdRFFJgGIVbntXlZeKBEbrCYBaa21+HHzjSV2+fGh80HEXS5/w==
X-Received: by 2002:a05:600c:c10:b0:43b:cbe2:ec03 with SMTP id 5b1f17b1804b1-43d389ec82dmr3861535e9.27.1742229239634;
        Mon, 17 Mar 2025 09:33:59 -0700 (PDT)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1ffc49adsm109352555e9.24.2025.03.17.09.33.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 09:33:59 -0700 (PDT)
Message-ID: <0d4d5530-7e0f-4ccb-ba53-135e1eb65b89@suse.com>
Date: Mon, 17 Mar 2025 17:33:58 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module: Use rcuref_t for module::refcnt.
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: linux-modules@vger.kernel.org, Daniel Gomez <da.gomez@samsung.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Sami Tolvanen <samitolvanen@google.com>
References: <20250309121914.pN6eBMvI@breakpoint.cc>
 <2362aa50-67fc-4535-b0eb-26f50066710b@suse.com>
 <20250310212416.K2OGvLw7@breakpoint.cc>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250310212416.K2OGvLw7@breakpoint.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/10/25 22:24, Sebastian Andrzej Siewior wrote:
> On 2025-03-10 15:28:23 [+0100], Petr Pavlu wrote:
>> On 3/9/25 13:19, Sebastian Andrzej Siewior wrote:
>>> By using rcuref_t the atomic_inc_not_zero() and atomic_dec_if_positive()
>>> can disappear. By design rcuref_t does not allow decrementing past the
>>> "0" reference and increment once it has been released. It will spill
>>> warnings if there are more puts than initial gets.
>>> This also makes the put/ get attempt in try_release_module_ref() a
>>> little simpler. Should the get in try_release_module_ref() fail then
>>> there should be another warning originating from module_put() which is
>>> the only race I can imagine.
>>>
>>> Use rcuref_t for module::refcnt.
>>>
>>> Signed-off-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
>>
>> I'd understand changing module::refcnt from atomic_t to refcount_t, but
>> it isn't clear to me from the above description what using rcuref_t
>> actually gains. Could you please explain why you think it is more
>> appropriate over refcount_t here?
> 
> I seems easier to handle without the atomic_inc_not_zero() and
> atomic_dec_if_positive().

I think the use of atomic_inc_not_zero()/refcount_inc_not_zero() is
a common pattern. The call to atomic_dec_if_positive() would be with
refcount_t in this case replaced by refcount_dec(). That looks fairly
comparable to me to the rcuref_t version.

> rcuref_get() is implemented as an implicit inc and succeeds always as
> long as the counter is not negative. Negative means the counter has been
> probably released and the slowpath decides if it is released or not.
> Eitherway you get rid of all the WARN_ON()s and the dec/ inc dance in
> try_release_module_ref() where you simply attempt the final "put" and if
> this one fails (because a refence is still held) you attempt to get the
> inital reference and can decice if it was successfull or not.
> If the puts outweight the gets then you see a warning from the rcuref()
> code itself.

Sure, but having these warnings would be the case also with refcount_t,
no?

I see that rcuref_t is so far used by dst_entry::__rcuref, for which it
was originally added, and k_itimer::rcuref. I'm not sure if there's any
guidance or prior consensus on when to use refcount_t vs rcuref_t.
I understand some of the performance advantage of rcuref_t, but I wonder
if code that doesn't substantially benefit from that, such
module::refcnt, should now use it, or if it should stick to the more
common refcount_t.

-- 
Thanks,
Petr
