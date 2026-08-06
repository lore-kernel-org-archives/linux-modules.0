Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67523A83B1
	for <linux-modules@vger.kernel.org>; Thu,  6 Aug 2026 14:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786027896; cv=none; b=nXaIkNXkHnlKpZoP+emIJCFQXMZcGlbO+JvYzCFOztDpOBfwyMOBKknmYrsku9iHfLxKRwpA80M+LC8WCdP5ZWt4NzeW4PaSaaPVgIIzwCiSesj+KAXvkLT6oLOVmxbnwoXOT6yLeMZ4wJMVXZtqU8lWVz4QVTzNg1mDSGQlwtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786027896; c=relaxed/simple;
	bh=Gm4zNo7nyEAnT3TTokUnwY/mnWxoTFTXubMv/mHPneo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XWqOB7Om9MEwJao77SMJ0ksB6sQuUTzVPnlJApRWDDS+kx+0053dk94pRykznPX4VsCxuaK8qViOUIHWEuHw91h2JvVmJbeaE3Je5/0BegqQXMxDtdNgI54MzMKxNgDARYbNSz3tlx9de1BBxVNzStcwyLREcAgrhTioL/59Jbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Yp3p2i7d; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Yp3p2i7d"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso8133655e9.0
        for <linux-modules@vger.kernel.org>; Thu, 06 Aug 2026 07:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1786027893; x=1786632693; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GWpFkxMOaVwGZ0w80zyQ1pa/gmhP6MxYxEbTBlhIS5E=;
        b=Yp3p2i7dBZL59CsRLcTgTy5EYsDbPruGf31RT5WFWdJJX7B4qpfFcZy+NdaXqvy5Mo
         UDSTyaDyC0IoNiVaNNX2sRAPJ0UEL9GDZiRL3RfPdOhrTP5US3RSv6C/LI2NVIpo9OfX
         n2BLsy7qgZx5gpeW98IsQswHIXQ8Me+c7UtTC5lABPx3ldLUNfRw9Mb5W6o6Apwn/THO
         2Z763En6rY3i1+BD37ZglkHDdC/m86l0EwmKMUdjtWu1mmeTE635H5Jx1rNorZYrq/Xd
         xy4RNZ4g2LRMNmGtGhmZd4L/+e+hMeSGSBrZVbnT2TSPHkX//sAe7j2y7zw4upgqRUgK
         pHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786027893; x=1786632693;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GWpFkxMOaVwGZ0w80zyQ1pa/gmhP6MxYxEbTBlhIS5E=;
        b=m4wdPtQIhCMtyCnYY6CRR+Xk1nS6SEAcFWxYVz/Q04yG2yAT0X7/2brbyCJPheVvOi
         FgjVA3RTS3LXrWZYmu0Z81wp33A+1DNIlE2mLAY/X+x+L7bYNdeKII1r1IWGdFaydvhA
         7m0u3k+qAGWBgTvB5mMCCvg46uPGF9gUAmG8pcFMQEDlta7CLGv3oAWlzsyu64DGqBNy
         8esq7keGuvZ332iZW3xQAiBeZFzTKt9OuhiJKQK8E+6RWhsTHj7yg7eK2n1SqJbR23y+
         JwPKyv7An8KrdAN6HPhRR5p7ar8gGXrjUzGBAIuoPil82jQvgMqFoalHiy//XZDgIN2P
         16Jw==
X-Forwarded-Encrypted: i=1; AHgh+RoG8MRMCYktPk53e5x7C9/5lnKnmlJG4Dbcg8XAhSgGg0S3j7cgA0phvS6h+GewNW4c4BW7j9E+T5akiEZA@vger.kernel.org
X-Gm-Message-State: AOJu0YxAbIsWPWSZdLdccqW54CimLQ5EkQN8/UNOqiVZq2c0PYG9RLoP
	NKkuhJ6RuW7rZCI6h9MnY2O7HCDlXcEhNkEG4Sc3+z38AdNUd+8cMLq47CBcGRONyGo=
X-Gm-Gg: AR+sD12eiqLK8umAQ2TgpFvGr/H5k6Bc9PgcpCoVDWZB6kdNrEw365Ug6SJYipVj6zM
	E9Z/p2H+OoHGCFd19mGx7W269/ZQJtZCtw0i6Ed6gKga27qSh/F44exJEcOlKluTzurllmkXqKd
	JDov7CLOm17vm85pQcGITPy5MKvEvd0Bz3ty91N+GkGDnQTTZ6yA0846SL327CmmdHher9NDFx+
	oT6x1hyEa42h5wtSGnHAvuhwH29trZsdtmgaQT2eIlyPsqJ1fg4voYcXQPEAM2JCDlEdCd/GeQa
	R+qUAaf7/14GHMpINS5bQGp9WnvGM0bW64VUwQOGp0hswzPzVx+GdwQ8vsONDtZ9kOmWpXeTmnU
	XYmcGV/8alQuBHyLEfWeez9WumZLR3Ob8tz8RQqxJRG3A0cBI86jigW2oqMqA3GRxHGgDYX2upV
	9YZuZ+uh1RPFsMroXIKgn+f3nN/mPshGiOtekYT6r+j22MeN018owhmS8lP3KAaEWj7o89dFJN3
	L+RBD/9IJIG1vQrH8MXjhPO+g==
X-Received: by 2002:a05:600c:4fc5:b0:497:ff5a:38b9 with SMTP id 5b1f17b1804b1-499553f8440mr50043225e9.9.1786027892968;
        Thu, 06 Aug 2026 07:51:32 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:fc6c:f9a2:4a0a:6354? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995421b1e2sm85741405e9.8.2026.08.06.07.51.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 07:51:32 -0700 (PDT)
Message-ID: <cbe5e31c-1bf3-4b25-b85e-dc98bf0263f5@suse.com>
Date: Thu, 6 Aug 2026 16:51:32 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] params: fix charp corruption on allocation failure
From: Petr Pavlu <petr.pavlu@suse.com>
To: Jiacheng Yu <yujiacheng3@huawei.com>
Cc: samitolvanen@google.com, rusty@rustcorp.com.au, hannes@cmpxchg.org,
 yosry@kernel.org, nphamcs@gmail.com, liuyongqiang13@huawei.com,
 linux-modules@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <ff0b7cdd-8fa7-4cb8-9e21-6a7204809766@suse.com>
 <20260729123243.790023-1-yujiacheng3@huawei.com>
 <b5d285a0-1e72-443e-aad0-dcac32d00d01@suse.com>
Content-Language: en-US
In-Reply-To: <b5d285a0-1e72-443e-aad0-dcac32d00d01@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/31/26 4:21 PM, Petr Pavlu wrote:
> On 7/29/26 2:32 PM, Jiacheng Yu wrote:
>> param_set_charp() stores charp parameters in allocated memory after slab is
>> available, and releases the previous value when the parameter is updated.
>>
>> The previous value is released before the replacement allocation succeeds.
>> If kmalloc_parameter() fails, the setter returns -ENOMEM with the parameter
>> left as NULL.
>>
>> Failing zswap's compressor update before zswap is initialized can later
>> trigger:
>>
>>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>>   RIP: 0010:strcmp+0x10/0x30
>>   Call Trace:
>>     zswap_setup+0x3b1/0x490
>>     zswap_enabled_param_set+0x5b/0xa0
>>     param_attr_store+0x93/0xe0
>>     module_attr_store+0x1c/0x30
>>     kernfs_fop_write_iter+0x116/0x1f0
>>
>> Allocate and copy the replacement first, then replace the parameter value
>> only after allocation succeeds.
>>
>> Fixes: e180a6b7759a ("param: fix charp parameters set via sysfs")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Jiacheng Yu <yujiacheng3@huawei.com>
> 
> Looks ok to me.
> 
> Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
> 
> I'll give others more time to comment. If there are no further concerns,
> I plan to take this on modules-fixes.

I've queued the fix on modules-next for v7.3-rc1.

-- 
Thanks,
Petr
