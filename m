Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86AE2D0C84
	for <linux-modules@vger.kernel.org>; Thu,  9 Jul 2026 08:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783586755; cv=none; b=jyLTCGR8TrJncZFrS8nZ/lFtcCoibFuW2lU5VTb22pnNVttkRfKcK3LVduYIhQa9R23ZR1ilskt6y9tN1P46f1kT3lomskDTxA4/PLR5P4M2SB1uOjBY238ZfPKUSGud1PYEb0WPRwYSzeWMLjie8cCIOlwANwN/0cbA4/AYdGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783586755; c=relaxed/simple;
	bh=ynT6B9doQBr4QnMKJT8OvOstsRR5sbOUWDQiApjd+Kc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HHrLQ0kM/D1KyjnbavTFKJmyQ/ZTMJVobarMRKrgHk0sx6cdBqF15LvQTNJ+EYtLHA4GSSanmeGccDC52o7nJXio6hnzm3/UpvJPDPwS3uCru/ry8a9VqMUZE+5kLE74HnE8g9cmw211Da13ZQmBMCOwMKrIevt33Wx3jtNTDSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZR5FXLin; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZR5FXLin"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493d92b7db3so16776925e9.2
        for <linux-modules@vger.kernel.org>; Thu, 09 Jul 2026 01:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783586752; x=1784191552; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2H1sJlDeDwrabVk5ic1tNKSA+bZv0m1/b5bTIxeOaRc=;
        b=ZR5FXLinlC1HDJZCgpxMIKhXh5Yv09ce9C1YfCEDBc4tr2m8ySJIjUk1pTLNS9PrrF
         0KNZ4KYx02l04a0eocqCbBeQNL4PuqAbaaipuwaCj20G2K3qlonM6+NTQ1wf2QBzWIVl
         TvMoMcZOFywDJduJq6LQhXtJjbS0KDtjdRsMg/Q+vRbY0p3JVYCF7NYh0vdgg9r/W2zy
         yOieJvN1TI+HFRwFNo9wMpCxXkRgfhufveeRHj2cZAA9cnWksxXOdfJJWZn7EGtzRIC/
         XAd7rC7qGsAqaaDIvSbFG/J4U7T+VmBjgPbOhZAklqXqoXd/yiM075cwYyHYgI1affKb
         zXHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783586752; x=1784191552;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2H1sJlDeDwrabVk5ic1tNKSA+bZv0m1/b5bTIxeOaRc=;
        b=ZIe7pNapY/t+Ir0F8hMMAv5P/Xi8ln0QiNA+q5VN2jlSa4TAgXgsUphNjdnCXLW4Sk
         YvGtlbwh/s2rP8QQ/rtpuKhgha7BvEmruCt4QlChumiXoH65gAePesbFghl5aop4SuRd
         canefhlz8QskiojG6FMky/wYriqjrT+pL9I1dQ4D0/xiWZduQFPrCuAH71YRWEAg7GYq
         +BifmkfHOJ9Edlp295MAX3sk1NwHEwwWvhmkAPuE57VbR1vcL1jrQz0h1FKvmHwTZXXn
         bozKa6fRm1FRub+9sGea/P39vUrPSVsgvqMIIpYv24YvgeFJcYASoNvshGmDhAT/11sB
         jdaA==
X-Forwarded-Encrypted: i=1; AHgh+RoMt3MQK3jgjQ3X3DGy8cE31htP48UnojqrqeqTJQBleAHanp2vu2uU+rTn+pdohSZUzY3/vCc6U+EkOXR3@vger.kernel.org
X-Gm-Message-State: AOJu0YzkfRV7zWoS8IrTNp6S8L+nqN+X+RdfravhWxYX0c0zcKAIOTIQ
	zwfoGnKLVZIImk+uNd0L3W6HZ3vdoMRwDcA4i6CQa8V70nb2sYqDMXGn0JMkfVignxs=
X-Gm-Gg: AfdE7ckLxBiRN7FDBKhupT4jR8H1RwrjH1+R+qS098OL1ffCRUY2FIIy/tdElvPpcHZ
	//kbwZTbKelmZhc7fgjg3di54NcZKc0FDllbkbtseBOddzsbMcvMxXg4T3mdW++fV8/hU7o/nsL
	0BLP9FABm+HP+Q6a6hhoJz9AsRk3mSUymeRoeMsiNvXu2Xh6z+m42KE04P3MBuoeNTUCfUVqYDy
	+tiuo2m3hiP7mbWJ4s6oCsF+DX+yrffbKif5CusttfpTCCmLdTc91s4Uq2ImZ9f21F9QNs1+Bhd
	WeOCww3leHiWjQiRl/sW3h5E75YZ4TxJaDcvLSgwV+f1poAvxnj7TEekfWr1sPzF+9iloPi34w5
	34T+toh/FjE23vZHfcVn7qPlVyty62C7I65jArbVaR+rPVrg7ubPp7RcoUJirUpG9eoDCFffIn/
	nUNlvBEHF5MGvM7lkGs/I8utrW6/17mjFIUQ==
X-Received: by 2002:a05:600c:828c:b0:493:bed9:b53d with SMTP id 5b1f17b1804b1-493e68ee07cmr52838085e9.31.1783586752103;
        Thu, 09 Jul 2026 01:45:52 -0700 (PDT)
Received: from [192.168.42.79] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb73ae14sm42599555e9.11.2026.07.09.01.45.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 01:45:51 -0700 (PDT)
Message-ID: <833ca499-09aa-4eca-a023-e3a7168066ed@suse.com>
Date: Thu, 9 Jul 2026 10:45:51 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] module: procfs: fix signed integer overflow in
 module_total_size()
To: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
Cc: samitolvanen@google.com, mcgrof@kernel.org, da.gomez@kernel.org,
 atomlin@atomlin.com, linux-modules@vger.kernel.org
References: <bl63xtwmzo42pw4636lr75u7duhuejp5tariokl27x3wnvdu24@3xf5cupsskka>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <bl63xtwmzo42pw4636lr75u7duhuejp5tariokl27x3wnvdu24@3xf5cupsskka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/7/26 6:18 AM, Naveen Kumar Chaudhary wrote:
> module_total_size() returns unsigned int but uses a signed int
> accumulator. While the result is numerically correct, the type
> mismatch is misleading.
> 
> Change the accumulator to unsigned int to match the return type.
> 
> Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>

Queued on modules-next for v7.3-rc1.

-- 
Thanks,
Petr
