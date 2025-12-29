Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C2427146A
	for <linux-modules@vger.kernel.org>; Mon, 29 Dec 2025 15:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767022740; cv=none; b=EubIO3BJHbFwzqJNo6HguFc9VnjAtf2dPCd75U77vOpWvSg6wxYX5yx0S5yv2O7gWz9rcuPmuqnyUZsb/1IOsI/pZk00EPhfSqBxetbEZCyRlK+ntXFK31Y++7xxz8ELzCM7nE9pH0/v7woQ8VXrmtYxOTcAUo840OGb7EUJrqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767022740; c=relaxed/simple;
	bh=p8NQDeJBS17yfZJntJlNw3a5ovlyjsL6sgzJoP70Ypc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I7PakmUZP5XSIQ1ib2K18pmLAUSAoo6oMe4WM3eCt1LBs7Crr+YHirrKePFAuMbh548bNfCj0mlSALG/bwxPqnMxnect002qDt7t8qe0b1a+ECs+lhjCBzFk3WOL6HyeN+S8GbiyupW55Bc4KEiroI+tlZuRr9ytMT+b/PrTj0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cgTExvX+; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cgTExvX+"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-477632b0621so57161295e9.2
        for <linux-modules@vger.kernel.org>; Mon, 29 Dec 2025 07:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767022736; x=1767627536; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0hpBHNimI777YQXeIIJaZ32AWcU/YYqoRMfm4vRAio0=;
        b=cgTExvX+6qUL1eb3O1NUzHp38mUcElwrhDLP1hC7pO09CsJQIRFUXeiEnFvj5JbLKQ
         3U/g4uNl65OOh8kw0EYsgDn5sDILvq0RE3iuTqtxEbwowmGcelZ8YcKloNLCC35/w3WN
         /0Py5ndoEnhcNgc8aZLQ5UzL78EZHtIR2S+m5Qx1mHhC+jSV0kPyKccDwqtxrnt4tUje
         TR63C3gZd+gudVZQo5/M6Wxe1KYBPQQZO5rlLhV13IWN6Hj7S8W1/D3HiJQaMiG31twz
         l1q1SDL3AcvH1NcOH6sGyuZBljAE3TyhthjMTc9ZYzjzxOPVgKNlt4gKfHOyTJSNKykm
         p/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767022736; x=1767627536;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0hpBHNimI777YQXeIIJaZ32AWcU/YYqoRMfm4vRAio0=;
        b=kqkEnDMptIiY4E4HygdsmFyRPBM+/z8le1aVGSAym8DZQ7HaKOX/JOTyRL9wFsnZBj
         An7OU3UA9PxvhTOBFh97RLQMTcK5VAmoZhoXfxfOXRK69qXTwiyJ7A/nksjvdg76V3Ka
         PfKeGLOzoP0xgvyT7fT+mn7tL3xGhyarm1AA5dw+gVvE4OiDDvvTmhnl4ELtChP4eH3o
         rjCNwhjte8KifeRjXyapw/cE9+qK0/6jURK3uPbvjl7T6m1axy2+925Yh8oLYJIUXmGk
         hwX/jrpGEtyxJq/bTfg2M88dQnjpoLb1TyO7wdmot0aCjLi+14qRLbqWPW4MtfNtniB4
         vtsg==
X-Forwarded-Encrypted: i=1; AJvYcCWm4UtAKL1m3DyvEEMVtVRfmzqQ2utmIj5PKU17EQXyAi3/P5F2nKLAMkeybYfIvuwsMLwdz+SAFbtV0z/x@vger.kernel.org
X-Gm-Message-State: AOJu0YxuR968mWPmMlppmSfdtLtUu2sQBm1Q8mJqiEc4wLP8XrDImk9D
	T/oFAqf1QexhLngUe0A6xT/bvW1+7yzg4sEMRCH4R6ZNB4My3bgbifa0cwL/fjLF2Xk=
X-Gm-Gg: AY/fxX6s3GlLy01KB9faUL+tR6Vi9obV2hCvuM85k290QmVTWErsxF+LOCVwQsVBQym
	xUv7sPXi6IKxG3VnwFVP1cnQi15Z5JK9hfqKl41lJQwj5sMPnK9USDEeHUQ3rAk5kj8EnH2UQek
	7pmeFjQW1DpTjwM59hD5SP9Db/enCGjQdsYkXtU5PpjQ06Mb4Fsde/jZCP71RuqfdaTpv4j+ruS
	XbuswvrSZbjwqtp6qBQyPWwAulfZ9jpxrve+InViR9+Jn5qBgF5H90uPky26X1tg7ix9iDjP1OZ
	OrLoy/BlzT0I5BBG6GqU/lvahGstO0m5lHP6+lkz48cc+msLXLYjKuJGFLDbZbTX+rfSvJ8g/T+
	uvLQNvwziHB+WzZ7e4rygc4gyAKRZpdSiO/8pTymdC6BbT+7Lp6lzBmy2aPrcA4nJM62Cd7FYU6
	v4FQrb/xqTk4nN8qfuL1z8GokUZHC0Auju2D8xLEgEvmfFYA1VXeu0wWN6NRNi8ZVfoLkBggzXb
	r+APGQYj82nMw4QqGsZYKVW1NYsz6tfMpNNd3i38C7rO27GK0Dl9GRPZg==
X-Google-Smtp-Source: AGHT+IFTf8aTyLe52yy20tx+SjQGKIxvtSnffR94oR1Awv2CQz+ujTojwKTfjV6zdnsRmt/1x/Tvag==
X-Received: by 2002:a05:600c:4711:b0:47a:9560:5944 with SMTP id 5b1f17b1804b1-47d195c1a71mr388059575e9.34.1767022736324;
        Mon, 29 Dec 2025 07:38:56 -0800 (PST)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d193522cdsm522624635e9.4.2025.12.29.07.38.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Dec 2025 07:38:56 -0800 (PST)
Message-ID: <d75b767e-d0c0-4d27-9fe9-192b84c8a920@suse.com>
Date: Mon, 29 Dec 2025 16:38:55 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ANDROID: gki: kallsyms: add
 kallsyms_lookup_address_and_size.
To: Yunjin Kim <yunzhen.kim@samsung.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org
References: <CGME20251224043158epcas2p217889374e0ea4b1722371ca143741d85@epcas2p2.samsung.com>
 <20251224043157.59289-1-yunzhen.kim@samsung.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20251224043157.59289-1-yunzhen.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/24/25 5:31 AM, Yunjin Kim wrote:
> This methods are used by AKKstub-ARM Kernel Kstub.
> 
> We need to implement an automatic kernel-method mock that streamlines the
> mocking process during kernel-method testing and enables fully automated
> operations. This mechanism must traverse the binary instructions of the
> target function in memory, locate the appropriate instruction, and replace
> it. To perform the traversal, it must know the function’s entry address and
> the size of its instruction range.
> 
> Bug:
> Change-Id: I5a318f762d4412e70b0c8dcf2dfed326312bdc65
> Signed-off-by: Yunjin Kim <yunzhen.kim@samsung.com>

I'm confused by this patch. It seems like it should be sent for review
and inclusion in some Android-specific downstream kernel, rather than
the official Linux kernel. As it stands, without more context, the patch
only adds dead code to the kernel.

-- 
Thanks,
Petr
