Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58600448BAA
	for <linux-modules@vger.kernel.org>; Thu,  6 Aug 2026 11:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786017208; cv=none; b=MIiSCfg4BCPUhbQuy48pKHVAa6V4CsDc24m19FP1opaZs+pHR5oYA3ZAlBGD+gBtE7AbqmTCIbmI7xeyGqaSB+QDgoWFHdMZp9Jb6RNjq1m/lDa+0TAIyCdRXgPa0Xuqc/rexLThBfb0VnexzYw6+qoTrFm/9zh5V/UG+CTF9/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786017208; c=relaxed/simple;
	bh=6yN/jYFsNj8OnnsOS0w4TLEfmEheJqEsUdsAn4iT3C8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sUIk9smXLzQpoAsH9rYFwTqnr9SWxZxEB0pN8pTy+fLb/nSp5RFspi+06REYyVjyel/xQazIPOr6uQ0rO7h9Wwh+Rh6yBB6ogSRYwkvFIguvyAN/9uIHEQqA5tBuZ/ViAa2ftvxWWo3ukrBkH8COelGjkYYScV5fObovep9GIz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TQ4TvB90; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TQ4TvB90"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493b966dd74so12869175e9.3
        for <linux-modules@vger.kernel.org>; Thu, 06 Aug 2026 04:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1786017205; x=1786622005; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PUwSA8jdNliZrhcRT/6N8YAFa290ZbsCRhK2xkNiszE=;
        b=TQ4TvB906XQ1nBzEq6TAaqZQZinL5hi+C+k2qs2QL3AtwB79TbSeS3xCwSc1GjuTi8
         kXwBmq2uNejeSHFdyiYInv71fxNeh1hL/LeoVHoThwNt2Wg/AbdX+3vxb9Nyhl+RTKGy
         AVLosDGDC/osNt0FVssKy8WufmOmjUdChuR09+h3CRwZ6yUUCWQtC4eAPYgCmZufOVR/
         VCGko02HzViWg+OyS+tbDZI7qn/rd/X2OUvDRkDalyUXoPUqIP3BxDuYewt3uAmCUFQT
         sKQiJyAlYaG6CCgppVZmkftRMQdNWvfOv4dGyqomW/r7MSY/YrzJUSmYpMyfc3qq5vk2
         WqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786017205; x=1786622005;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PUwSA8jdNliZrhcRT/6N8YAFa290ZbsCRhK2xkNiszE=;
        b=RPJvYanEgj3PYU7AIbvH74uSlFG3T6nwIXFHsw5c1egfza7fNE0N+jKYGyhpG/Ujj8
         fJFAiMWiHVZU+rOU8CS6obTqZOI5PFs3+q1uA4/Jt0LKyJG5twNZN+h0IzOidJj43dB0
         IosY9dMCiVd4Qx59hQ3RyhoAQN3dZm1mFFYVLsj+MXZgwvD72p9EVuyQfET1sEW23NCl
         rYmkS/glm/88wt2p9dvzrKmOrhc3w7zDZn/GL8OLW4537UCE0YVZr42vYG9veupz/L5r
         Ag/I9bLHz6zbGyKsKw2R+f/o/uoDXa+Aw736a+zjQ1IWQtPaprm+E3u2EstJaTQzIGoR
         C8qA==
X-Forwarded-Encrypted: i=1; AHgh+RqnaOffYG4YAW591FTGCR2V/zlP2gbJkFs82iCEu0sI4oygpEf6WkuyBWPyJbVHhNwsTx3FhuzEiDnCrGdL@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi4YiZR5UpXe1Ok+NgUdMyCDKbK/FyZrVrujxVSV3dM688XTar
	3uZJ+0MbtZS1W7clHCUQJ/zz6odDszQx+ugC2CihXncLfh84PCbU6O6TG81d74p+79g=
X-Gm-Gg: AR+sD11RVFPcaMT10WMBIlcWF9ChIgdtw8Db1h+6O4sUWYEb+dO4LvfrME2YIBoOHJc
	C77IrWZNGS1XRNBmq0b4UWFJPIb85YC6BqpuSXbsrmP2U61K0O4NBaH9aTSd28cpn7+CRDyZ7w5
	1M82+0IsS6yNypGs0MB9G3j51jbvy9PtkAFBokXlmxh+OkUL9fX1ndebhTEKQ13JNnYR7vVPNzQ
	dRuxfk77qfYPulPKK3z4IXFAOzUg8KGkM1S3IxGmkBHDppbfVUJHuPRF90Ht3hwLQ9l9acCG1IR
	avxuBHS/sKAbRypnQmucjtBtkquuIj4dRxgCom4uuUr8+gZPIKG80puLbccXkA8yJbvQknlNJSw
	2sHPTL8eiymD/OFiKQjGbxuTbFJ+c9+6dn7RrER/rJl7KvUKOOUCc2bBp+o4dXBijjjUl/tNszr
	HuHihnMVwuf20TkR3G/FnTbHUWBXAek/wX+NFDWaMNUpRRMw7cfZwxP/bLDS2xmMy7azrDrfbYZ
	vVI/bRKrlFC+gBLbYkmC4g72ncRFXIVpu+n
X-Received: by 2002:a05:600c:19cd:b0:498:28b:1045 with SMTP id 5b1f17b1804b1-4994e793f63mr172396885e9.3.1786017205421;
        Thu, 06 Aug 2026 04:53:25 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:fc6c:f9a2:4a0a:6354? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e98fdedsm126598535e9.4.2026.08.06.04.53.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 04:53:25 -0700 (PDT)
Message-ID: <b001c676-0215-430f-aedf-40cae43e59b2@suse.com>
Date: Thu, 6 Aug 2026 13:53:24 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] module/dups: Fix a use-after-free and improve the
 code
To: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260806-module-stats-rcu-v3-0-2b0331106f00@suse.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260806-module-stats-rcu-v3-0-2b0331106f00@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/6/26 11:10 AM, Petr Pavlu wrote:
> Simplify how the kmod dups code informs duplicate requests about the
> result, fix a potential use-after-free when waiting on a duplicate request,
> and make several general improvements to the code.
> 
> Note that the use-after-free fix depends on the code simplification
> implemented in the first patch.

I've queued the series on modules-next for v7.3-rc1.

-- Petr
