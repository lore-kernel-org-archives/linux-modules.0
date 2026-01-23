Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E32D34DCD2
	for <linux-modules@vger.kernel.org>; Fri, 23 Jan 2026 09:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769160991; cv=none; b=TOlrDYZayGitFwJCXVqvzLlOgqPsgphAKzoYzz8/TjioKUALhNYud+DSjrgSp0pZ06F4m1a3R6bC9gTI+yMFV9wrdhBv4OXcJ6dzwGIJRkmCT3uwsbgKabLcU+8XugKvI3NxIGvGtNfCw2I958jQRHnnpHpM50S/dZAo3vJEaNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769160991; c=relaxed/simple;
	bh=UHCtzZUwNmJVex/PidjG1QhsgZr3sHuco2k9/TFidh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gNSQ7a9aQYLy4ejyAs6TLRl+UsfgsBM+QNCwF/8yFHt8n0V7xAaX+VuLYMEsj47oXqxxXKwcGvZkeUi0GREY7M+UvKJsanO/bUuYhQlp7y9J/aQ4qJI1fxIMjBkiuixWpqfhBUZdLXjk+CVvW89B/LVxWeUmcimdFJbii0/tTGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=d7Tzg02M; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="d7Tzg02M"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4801c731d0aso15295755e9.1
        for <linux-modules@vger.kernel.org>; Fri, 23 Jan 2026 01:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769160981; x=1769765781; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ml193Cxw+2y2CyhUl9eY/flN/zutVC5TnFaQhjrJlN4=;
        b=d7Tzg02M22dfWu8JPYQY/z9qZRSZdRQaQ2Duc6QTYQ/IumvpC4DyB7alcAanyqOXCx
         9OLd8E33DmgQyREZ3zDxq7O9oxNSJ6S4FfudiZ4zWh71h97dV8mYA+LWBf7quEnx8O1U
         ORikHgVJ4LEjLuvAZNfcwcKbNvQi0uZs8v0oBLCaNLo+r7hpxiov2MbuO3ABwszn84Im
         KvFIbLMF1Z2dSKocCzeT1iBCRvLlYK7iAtEP2n3rpBuAvaTmKArLs+LY7qIFAf+L9zE1
         qoFRd123269oyJO0KqtAOb/Xlkbny+XuyiyhZSHQx6aF7/8JJOwr2iCYZrTSOq7ZqDdo
         +QcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769160981; x=1769765781;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ml193Cxw+2y2CyhUl9eY/flN/zutVC5TnFaQhjrJlN4=;
        b=ejI0qIrCOhRR63MpdpXF7a9jKg34lX8GLVuNsSWE4BqZS90UPOOD4TL9cL4bIANsNJ
         ZM9NCofvtxX7BPg5g3dltGnFFX7aeMBbcv7i+cIA8qQfqlDHgHxxt3JvYAuUfDiotGvW
         kCqkj3lpfp2V/9vaCai4yO8O87jkLAAxxfn8jSi2R6uqNdrDEmIuluq6zyEpOZPBgLIV
         tyiVDtJxTRZyKVlu0HQTct1RDEtd8oQ0wrCwYn7rmPZrMCqJekc5SpyxyFViyw5zw1S0
         e5zYunWEXlsMOkd3BKSdn94/56xUiZAhqOsGwX1jLmX09njKkcNiW6VJz6l0+PpWXs/d
         4gVw==
X-Forwarded-Encrypted: i=1; AJvYcCWaP1XszxRbY7nSorkIT4qHn8v1JxnO+ubwtReQadVrthAiHunRkWcDgPm3g9fnFNLNIBjOBVHqauNtzxZB@vger.kernel.org
X-Gm-Message-State: AOJu0YwxDxDZfSR7JkQMSGd6XPzRxc4AqCVGPj0vAq6/+XUYy/isNblc
	Ivi+1r624hs7MgE1qbdWQ2XKbQkPJt5hBLJMVG9AxOhviK10Pz488CycFdcGkuK1DZo=
X-Gm-Gg: AZuq6aJoGjYrcdXVr92DzrhfwV3HHRAuGoIG3/CgQDdfvR67728yDPJ2VIdE828MhxR
	WzHiT4R5VSDN+dGVI4rKyZjoQWe9RBBvHd5otbjhjh7/QSWrGuy54uCir8OyXf0mxkE1a/l6HHf
	6zLTDuV7yx9P3Xz4MHuUf2EWeNM5CPKV3K08RPxbYj1aOsV2KncPASpLYj9nuXU1fXO+a/7f0MP
	ag8lvO8HfR0iP6FkO9xpXarkOpi1nYTYlOgbeqJ+hS5QhK1erAYDBt/1vaVMqRJWnqj1FdryAJ5
	nsX2qQmrYhqAkWQU+Q0DtNKV5UW5DfIlbQHUTPyBdAaroPIyNsGfU7Fvtoj8erwBuYghAl7lCw1
	POhG9ipggJkEg1PiUQyoAoag5cwA2XVQr2X+XO7aeEdV4Y1B2pgV7BguwmMA5DecCG+ihx2AniI
	+U9hI7lMso13ZuhwNugh11ymsHR80CNZF0yrKgs2q/
X-Received: by 2002:a05:600c:6095:b0:480:4d39:84b3 with SMTP id 5b1f17b1804b1-480511e4ec0mr12497115e9.6.1769160981070;
        Fri, 23 Jan 2026 01:36:21 -0800 (PST)
Received: from [10.0.1.22] (109-81-1-107.rct.o2.cz. [109.81.1.107])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1f7b4d8sm5009841f8f.38.2026.01.23.01.36.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jan 2026 01:36:20 -0800 (PST)
Message-ID: <198d1ca0-031f-459c-89bd-6d438a84fcb9@suse.com>
Date: Fri, 23 Jan 2026 10:36:20 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] module: speed modprobe by adding name_crc to
 struct module
To: Jim Cromie <jim.cromie@gmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260122234621.3403276-1-jim.cromie@gmail.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260122234621.3403276-1-jim.cromie@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/23/26 12:46 AM, Jim Cromie wrote:
> "modprobe foo" currently does strcmp on the name, this can be improved.
> 
> So this commit:
> 
> 1. adds name_crc to struct module
> 2. modpost.c computes the value and
> 3. outputs it for "modinfo foo" to see/use.
> 
> 4. adds hotpath to find_module_all()
>    this uses name_crc to do quick "name-check"
>    falls back to strcmp only to guard against collisions.
> 
> This should significantly reduce modprobe workload, and shorten module
> load-time.
> 
> Since it alters struct module, its binary incompatible. This means:
> 
> 1. RFC for its wide "blast radius".
> 2. suitable for major version bump *only*
> 
> 3. it opens door for further struct module reorg, to:
>    a. segregate fields by "temperature"
>    b. pack out paholes.
>    c. improve cache locality (by reordering coldest on bottom)
>       name should be cold now.
>       bikeshedding is appropriate here.
> 
> NB: this isn't a substitute for CONFIG_MODULE_SIG.
> It reimplements crc_le(), doesn't reuse kernel's version.
> 
> CC: Luis Chamberlain <mcgrof@kernel.org>
> CC: Petr Pavlu <petr.pavlu@suse.com>
> CC: Daniel Gomez <da.gomez@kernel.org>
> CC: Sami Tolvanen <samitolvanen@google.com>
> CC: Aaron Tomlin <atomlin@atomlin.com>
> CC: linux-modules@vger.kernel.org
> 
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> 
>  '#' will be ignored, and an empty message aborts the commit.

This patch looks as if it were generated by AI. If so, please avoid
sending such changes. Otherwise, the commit description should explain
the affected workload. This should be backed up by actual measurements,
showing how the change improves the situation.

Implementation-wise, I don't think this is the right approach. If
searching by a module name is a hot operation, a hash table can be added
to speed it up.

-- 
Cheers,
Petr
