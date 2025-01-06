Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362261DDC36
	for <linux-modules@vger.kernel.org>; Mon,  6 Jan 2025 14:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736172102; cv=none; b=WTV5bb7YIzns77z+4UNSC1e//flrSl3Pu4ZzzeOofoP80nGvXYejfwwzO2AVOhlJI5Kj020/QXNS+rilu5Kis4xOy0VxhOz4IYvmFbUPvBLuAtonXHTHvtEJCMTpTSxwtU1Usgyt/iUUqi5+q8SPXmzBdN1Ip58KyXkp8GTSaXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736172102; c=relaxed/simple;
	bh=6o1p7bSAyUdFOyTYgPnXNPCjcv+NuR5a8rCEuH6SKjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p6hRz1GrfvNEt5G1Ws4nBSoJ1pMocWW0e75nPM7SjihLdAa1hsLBPcLkBWf9GUtILUdZTMxFcXheDHvKjVuDkP1N+hYKmtlKsUY0YYDoFko/TTFwxDzA9usNuCow2YeAHpQ1r90rsJwCsb9xFOISj2fTGSJDAVDkbtW3F5uhSXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cs4vs+nH; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cs4vs+nH"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-385ddcfc97bso12203650f8f.1
        for <linux-modules@vger.kernel.org>; Mon, 06 Jan 2025 06:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736172097; x=1736776897; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4G6xfD8m9Su4PolHZXeeunbkFOaPtopwcrcak99j7Xw=;
        b=cs4vs+nHxTnegrvdbb42ZzoS2D50ypdkLJJ23yGC47n+jRdBTpjyfOJiBAkc3877tn
         83rVuq6+S8NVhV0YRYhGqUJMmGRA8+Jv8iT94/d4vlhB0cHiRJIoo43rpDaUw7nRIia6
         +8KUHS/usIJskby0ujF/AnrFBUBaIbWhqUqN7xDmQpQgSkslpAzyLzTIXmQih7KM1YGY
         uw0unmSWYtziJgGULj5L3g26H3XZHzDeo5g4gUhMQRjQbGF6/ogD4dJ30ElYwcS5zHeP
         2VZ/K6+l4yPiRqjtX23UD85a1OMN6w1Y7FSe74HQLVklOy3AbEqumV1JjSINoxYTf62F
         +OVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736172097; x=1736776897;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4G6xfD8m9Su4PolHZXeeunbkFOaPtopwcrcak99j7Xw=;
        b=hdyoS+Si2S0NQmlRrdnDjIEQK5vKzgSVvG84A9yP5MKAneM5VzQ8xK4sTilopD2i8U
         2eu1YQwsDn1+axazlTdFqhgcJwEngwJQQeDm1crbdmX3c2WQ28QH5LmWQTtTRRORBMnz
         xeo886f123iY8So2G1/HOvY5CcnKDp88HJ2Y49FCbdPmN/Vany0sYyAtzVKHv++04B8n
         +I4l1DIG/fmjZlGdo5QqeeJpKAN+SM7/2Z2NWtEwe+jZ7RHkQbh7t2d85ex2OBHX8VrL
         8L3++7wShYTDix74An2yNEAsJQy/AHoJ+z7j+0yi5C/3yp29UuZm0TtASwlguaP7Si/5
         s6tg==
X-Forwarded-Encrypted: i=1; AJvYcCWHedUH1Ht9XPb5fuOMzXOO20VUEKK7BZ/f1TW68w5bb4CcGDZAhI0EXjaDWrZlyfPLIEwHKRW5LEr+qKq7@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/ZdOc3PLBvW0yqw9+OGa1jWuUphNzEmBWUlrq6IpGuOW2yFmG
	aO7D0TkF+M83gBDZ23cvxC05wruUmYwLwrTDHnaOWRcA4OuOhhA1C3Udmlod75o=
X-Gm-Gg: ASbGncvG56SQGFBA70U+PPUQrFJgNr+8Ocl2KUe818O6MbzFyqasEqt0lIQJRjwTUVZ
	4YizU4ncY+3oRtmxErcJQYV4PepTEbiHqg1NIzYhpGqI29eq6vJ70YTJj1Ksef2AsjwW1/Y8FHU
	igpjyVmonyi5eYitckj4RZ6rl2KYIrQzEG/rfMQQJuMCxW6R3AXqpXdzUsTLa4xTUHPgsvu3Z1N
	p7kAZtQn6q+pcCLCG9PQoMAqevOlcituSZvXNsnMQMs2vtwcg9Fo5ysyoOK
X-Google-Smtp-Source: AGHT+IE1VfGt12mWAlo4CGUZChw1sowXE1RhqjYG8FuFMUXwqDN36gT8iWfPxbGKriztKErymwxFCg==
X-Received: by 2002:a5d:5847:0:b0:385:f6de:6266 with SMTP id ffacd0b85a97d-38a221fd10cmr46011063f8f.24.1736172096914;
        Mon, 06 Jan 2025 06:01:36 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c89e375sm48757272f8f.73.2025.01.06.06.01.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 06:01:36 -0800 (PST)
Message-ID: <b6d9c890-ad72-4295-9b9e-dfdba99583d2@suse.com>
Date: Mon, 6 Jan 2025 15:01:35 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] module: Don't fail module loading when setting
 ro_after_init section RO failed
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, Kees Cook <kees@kernel.org>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Mike Rapoport <rppt@kernel.org>
References: <cover.1733427536.git.christophe.leroy@csgroup.eu>
 <f0e892c7-43cd-4310-9d60-1d6e839f5bb2@suse.com>
 <3a961c7a-d793-4319-ab78-af11f46587ff@csgroup.eu>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <3a961c7a-d793-4319-ab78-af11f46587ff@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/4/25 08:39, Christophe Leroy wrote:
> Le 03/01/2025 à 17:13, Petr Pavlu a écrit :
>> On 12/5/24 20:46, Christophe Leroy wrote:
>>> This series reworks module loading to avoid leaving the module in a
>>> stale state when protecting ro_after_init section fails.
>>>
>>> Once module init has succeded it is too late to cancel loading.
>>> If setting ro_after_init data section to read-only fails, all we can
>>> do is to inform the user through a warning. This is what patch 2 does.
>>>
>>> Then patch 3 tries to go a bit further by testing the ability to write
>>> protect ro-after-init section prior to initialising the module.
>>
>> I've been holding off on applying this series to modules-next because
>> there was still some discussion on the previous RFC version [1], and
>> I wanted to give people more time to potentially comment.
>>
>> Mike Rapoport also recently posted a series with a patch [2] that
>> proposes restoring of large pages after fragmentation. Should the last
>> patch here be then dropped?
> 
> Indeed, if the large pages are restored when bringing back the 
> ro_after_init to RW, it defeats the purpose of patch 3.
> 
> So I agree, let's first apply patches 1 and 2 in order to fix the actual 
> bug then see how we can improve as a second step.

I've now queued the first two patches on modules-next.

-- 
Thanks,
Petr
