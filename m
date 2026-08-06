Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CAE389116
	for <linux-modules@vger.kernel.org>; Thu,  6 Aug 2026 11:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786015227; cv=none; b=SZU7XOHBCSNjKNrKP+k3zc93tEkK/bPswdSNu50EtcV2HjqXfN1UX5j0B+ASv5Hj5FEYzKUTJeP5B52gsNNB6dfjILd4OS3/WQJLgAlGBqakjwgmCi3wWzGx6oOI519OOoohWlhEtPfuWyO0B+1U2bZV+4f/4Gfska0LjUjZDSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786015227; c=relaxed/simple;
	bh=PiHaEbFbsbuk3xWfpHJf3iZCAXPgh1x3mz6btgM7DeE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tXKVUeQt/o8Xi1yLuTby58JS9GIKY9yDrLNQvyUqjISqQ2Wy6yV/biz1NVPLjpUtquT+NuXtfKz04Qs5xgkUBqGOXYDXWX6KP9G0q9W/vM4qQKr7XU+3ILczXNamDbcHdfne/WTPamjN2cGGEAjg433HUW7F49LlJfvr2e9fIMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XNB8HIKq; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XNB8HIKq"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-495757ccbc1so22061265e9.2
        for <linux-modules@vger.kernel.org>; Thu, 06 Aug 2026 04:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1786015224; x=1786620024; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4iqPDnpSytCdb2l+5MS0mIwH5n9oUyHF76yraGYuJXY=;
        b=XNB8HIKqooDT0o3V5AMaFLUPQBxeA5pnHhtUu23/9KJquXlDduwwaN57sDwOc/fNgD
         Q5f9g02wLhtrmbGsIjD6xSRbBKQuXhkWWNh5N15SzPMb0smJrytKJIdSTDL5goyXr0i5
         w6a1ZR3PU1LZaqDYddAynK5shLUnZXoQJDoFsmS3Mmm5tbXKQ/dQBcTzjCUJfloTISAe
         ben3vG0YFQKDUir8IV6M12I9FHssCUNPqyjwZlCOUtzgPl55Gr7SKY9vkTHjemeXfgDZ
         QauclwcPUU1/BcbtvE1gMrfJWOLhYaqLm0FedgOSiZH04M+iiY0LdbPx4Y13vNhnjGte
         GiDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786015224; x=1786620024;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4iqPDnpSytCdb2l+5MS0mIwH5n9oUyHF76yraGYuJXY=;
        b=ibSv4v4HlaRU7ZuuravopfnyoX9BveQEpJeOBH+G2Mqn7clGLgJU3etMr1AlwLAYiz
         2w2cEUkYbcdZE0k129+Rq9+cK+1KM/6vq/mOHVVVW+8s0HP2eTI4Ddw3cnDO6ZW65JZS
         M3khpNL1nEk/AmrvTMonADxx0+Vo+/tiva2K90Ypswow8V4kKKgkWXLoaMTDNSBimidB
         d99IGMxRQsvmFgz+Qt/goILSIM2Tsk9Pcz1GhyZtiXpPhk3Ywkc3EzXhxwTSSs851gpi
         fVjLp2rDuKlPuzljKNho5wppqvBkX3jvuVT2PWx2AKRUAAqzfyqbqRndI5RlTYxvzTtE
         iqJw==
X-Gm-Message-State: AOJu0Yz1mXe0TZE+77+2FZ7v9FAyPEhCRoqyYqtgdly+74koZ7vLflsE
	5jJUHalrdPpsnHiVZU9hRuG+qtC4vIyxSMRdsIRv7SlSP6EUVKAM3sZSf9MY9zc+TdS/9MuMGUi
	pO5WZMN0=
X-Gm-Gg: AR+sD10QC7PxXNnQEwJTp9h8znACjyyNZV3ivvfn3wW1NMM3iQSplupzm6cUMcibXeJ
	+O+wtdkqklNTEuRnUNHcdN7abvXrEX2rabvpOkSFP3Okf3Z9IW3E2xbhcX4g++sWFOYo4qfS/ef
	wadZMI+tFrLSkm8H3qBI4P1EfEk/FYjPg2wl7wE4kAHn47QqG87JONs7og0gBa0lArQniqIoCOM
	KAo1EQy4RIG4Kh0mMVHouQZZuhX6XuQQpADFA/C0iEaD+wRheahyhqvCLeLzcvoS2moLGRbVcTY
	7MLAZU1slRQ5TNV9ngtjWIaLCvAOWkQijCtDYEeOuo07fZx1Pbmo1dGth7XojrR/euNWR92eHiL
	l8Os5aT8fOFi1qF1IgqOPDSneA79ylhdfa1t0tHfOR6dPZPwC+62na9AIE2Z2wVtGqdVR5fQWkE
	rQKu+L38kYBFqGYCeGTiTbv0ZAiOFDvECu+uQtjyfGtHxYhzega2E9ACroQ4bt/flKTBGGRxalq
	PO645GJOrBHrb+z1xLfRAhrSC5B2n/ALRJF
X-Received: by 2002:a05:600c:a47:b0:496:c379:b2a1 with SMTP id 5b1f17b1804b1-4994e71296fmr181515805e9.2.1786015223817;
        Thu, 06 Aug 2026 04:20:23 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:fc6c:f9a2:4a0a:6354? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499541b525dsm67037675e9.0.2026.08.06.04.20.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 04:20:23 -0700 (PDT)
Message-ID: <c2075a81-4e2d-417b-a5c0-3909c063591b@suse.com>
Date: Thu, 6 Aug 2026 13:20:23 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] module/dups: Avoid unnecessary kmod_dup_req
 allocations
To: sashiko-reviews@lists.linux.dev
Cc: linux-modules@vger.kernel.org
References: <20260806-module-stats-rcu-v3-0-2b0331106f00@suse.com>
 <20260806-module-stats-rcu-v3-3-2b0331106f00@suse.com>
 <20260806094202.A5A981F000E9@smtp.kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260806094202.A5A981F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/6/26 11:42 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] A `request_module_nowait()` call can prematurely complete a concurrent `request_module(wait=true)` request, causing synchronous waiters to proceed before the module is actually loaded.

This behavior is intentional.
