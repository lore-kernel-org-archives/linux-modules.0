Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A56013AA2D;
	Mon, 25 Aug 2025 03:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756091833; cv=none; b=poRy6heyW3YmS+Ql5MLurxzjwr8CfrtozCepEks6BhTY79WseQXCHgmEADC9EYxcwUPXGIByr/DVjV6FlJr/wm0ezA/WFl3IS2lUSmRy/R8fC0xrEqpVLFaE9FEbu89V3OI1/XMxUevPM8+l3NCazV1tqKgiB5jD+e+apSr2R3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756091833; c=relaxed/simple;
	bh=PVisAZkkSA5Or3IhgaY6RiXA+8oHXNisgrd4QZoZmZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OdmlqZmqSn9r1kazdz/KM3A6YQ41Is8AEIA+7vZ2YBKco7wTHo6My/vTLEu7QGh9PTktf/RQc6j8yQ5DuVwmG2YRRpVqHEa/TlRT6wLNnFkUiapUjmWFNS6J/YBJK3ixYzCHWoMDCWhMauz5GbUtzpEMb6yYIuBobsL+VYR2dkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZxtnT2vA; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZxtnT2vA"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-323267bc2eeso2979033a91.1;
        Sun, 24 Aug 2025 20:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756091831; x=1756696631; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yMCemvyGOAP6XlHCyWPI1sNO65So4Z3QCHN0HhZWV+Y=;
        b=ZxtnT2vAvvVb6v+nDvMHnoa67dEcD0TUb/L6TinfL1q5c/wJyAFEoBRCFd9MbtlbjY
         XMpoaW2vPlTdisy7dDiE3+Vmzd//m/LR1rYb4SCKMHpvb2GzAW8G88ex4D8h2BUgeAfO
         gdxV2vMTAqpOYN0zTQmpMyFvK9ZTxP3+2/k44f3cwwNio7T6guvSIFoTFEERUIzbr4Ic
         w4ALM8Z1kh8reb5Ao63c67i8To2KYSu8ksCcehfYsqo3Rd2MeNAw5ylajdPyGMNnVRr5
         EZLT220jNl1C2IGTzEec8Go9BD0KILCeiAt9Gsew5hpUmP6izjSTFHMaPthhCszLD37f
         me/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756091831; x=1756696631;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yMCemvyGOAP6XlHCyWPI1sNO65So4Z3QCHN0HhZWV+Y=;
        b=wlVfouoo4AlH7hGRGVAIpfv7747YCL7SRraD31fdOHHw/8KtZAqpZT18D9ZRxyGEwd
         GR7KcTUjqXqjjIOFyasSkgmthWAifMvKFoRnX0bcMYj7AqIGgB9khD0qFmM2vMxQSXzj
         IxoO4myGSoCg8jDTIkh8K+//7QsKTloSXStfaHxiRlm5xkLicugjDVTYEYRVSXShPsrV
         5qqaZ4uW/u9OoYf6UZujNfawrdgBs+v+xaRiZfGTr5lmrMMj4hgvvMnPHc5qcWER47HU
         JJ52b+gu7Zw0pCGIJCGN0mha+CBBIHVRb3eiDHDi/D0YMGHrGosBET+gF4SW3uGcIeNf
         S46Q==
X-Forwarded-Encrypted: i=1; AJvYcCUK5OLfP384frv3thSoyzpRaE/SgCpG2Kk0ytQPkGsl6gIFI/z/ufLg4CA9rWdHu/BGkhPastI1IeDqiB/erw==@vger.kernel.org, AJvYcCUZZr17XGkJO/DY6i6Ato8RoboKI+GLR8TGZN+KMpK09d11wIgIBm3eUDjW/EID7RH1mCoHdZZurdeFRZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNUgWmmJKosAgiAq0JDJEuxqepdt8vmKMCmVYl8buiXL2iFII/
	G1Ow+y+aAglJWrYy/4ZONeuq8G3ADTRY6F4C6LMnYjl0cziT0omh0d5i
X-Gm-Gg: ASbGnctkwkWhY99WgQfY0MFQmyF5A+FU46IR48jRe96ZG13zKGsuhevdciwK8NtAa41
	DiU6zrRAXWR+5sdA1wGsGsVn7kmqnICsLsSzW5gZNJVSkI2byrZk1yc2sR1XjzMEwMgaI7Q2iNh
	Nz2oUy4Cl6Ij/eXLBiQcnf05pyWN+oKG9h8H3z9MYHhy3Lo5skzRIaRVCDcDBiWOJh9pUTsMAlU
	wIVnJdg0zvB1BZbWH+rSCjEzKy5m9FgYRqMqHgwCObHL+koopkQ0Lt+wR25WnwR5LNU9IsC2wD/
	HJeuLz6087hUQpb0OPJCKCggf/Eao+12fIYSB7ZFw4wosnSN9EHN4H4RGRk8L+wo0wZFQjlL860
	MuRkkX+3DjPfccFEp2ZCQBMM21gN2VW3OErSZ
X-Google-Smtp-Source: AGHT+IGwprUTeHEm122Tc4JwAuCPzFREadtOCOVdhjDErx/15BYwgFrKWMFiGHEkMHWZZlOeFcW9Jg==
X-Received: by 2002:a17:90b:2f87:b0:31f:8723:d128 with SMTP id 98e67ed59e1d1-32517b2db8fmr14263065a91.34.1756091831293;
        Sun, 24 Aug 2025 20:17:11 -0700 (PDT)
Received: from [127.0.0.1] ([45.8.220.62])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3254aa650b2sm5746696a91.24.2025.08.24.20.17.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Aug 2025 20:17:10 -0700 (PDT)
Message-ID: <6cd0f597-d56e-4a20-bf6b-42cebacdd4c8@gmail.com>
Date: Mon, 25 Aug 2025 11:17:05 +0800
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] module: Fix module_sig_check() for modules with
 ignored modversions/vermagic
Content-Language: en-US
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@kernel.org>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250822125454.1287066-1-wangjinchao600@gmail.com>
 <20250822125454.1287066-2-wangjinchao600@gmail.com>
 <CABCJKucGtbZw_DCpnbUr7cQeU+_DF97YTeDVgPX7tTyPwNabog@mail.gmail.com>
From: Jinchao Wang <wangjinchao600@gmail.com>
In-Reply-To: <CABCJKucGtbZw_DCpnbUr7cQeU+_DF97YTeDVgPX7tTyPwNabog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/23/25 03:36, Sami Tolvanen wrote:
> On Fri, Aug 22, 2025 at 5:55 AM Jinchao Wang <wangjinchao600@gmail.com> wrote:
>>
>> The current signature check logic incorrectly fails modules that have
>> valid signatures when the caller specifies MODULE_INIT_IGNORE_MODVERSIONS
>> or MODULE_INIT_IGNORE_VERMAGIC flags. This happens because the code
>> treats these flags as indicating a "mangled module" and skips signature
>> verification entirely.
>>
>> The key insight is that the intent of the caller (to ignore modversions
>> or vermagic) should not affect signature verification. A module with
>> a valid signature should be verified regardless of whether the caller
>> wants to ignore versioning information.
> 
> Why would you need to ignore versions when loading signed modules?
> Here's the original series that added this check and I feel it's very
> much relevant still:
> 
> https://lore.kernel.org/lkml/20160423184421.GL3348@decadent.org.uk/
> 
> Sami

Hi Sami,

Thanks for explaining the historical context. I think there are two 
possible understandings of "ignore."

The original seems to be "do not check, but still taint the module." My 
patch was based on the understanding that "ignore" means to allow the 
module, even if it is not signed or is signed with a different key.

Given your feedback, I've decided to drop the patch for now.
-- 
Best regards,
Jinchao
