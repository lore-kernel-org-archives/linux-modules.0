Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA29C1E5732
	for <linux-modules@vger.kernel.org>; Thu, 30 Jan 2025 13:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738244525; cv=none; b=fasiQdDuNFfgIKXIHg6L3cCYlocEaKgnsNTVGf/uc6kaLImpuHXnYzfcr70Yz4zGQmEFZBT5/RnS8P2p11L8nQyWt9BWfqCdGdpK5AyBLWOj3QfPuNAE32gcIza50HC2l3No3JjN/5wcMOop4ShQ8J7UmgJsDMCalx1o0zOaQ6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738244525; c=relaxed/simple;
	bh=LB8W9Gi19wlaCxvxnidBW2ODnnvKAxAT7vIEvr1oLaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bAFN+fjcoPx/y6mZD+wPmUpWkvkegsZx2DCe6gX74PDvNdm9w4KH9Ky8hv+i7eqRb1Rrmzd8WPHUg1Pt6iokJOsfAwwon4/79QBppf9lNikAQI+5UijpChVXh7IQFtQLcnJ+8zizvsKFC7srrGNcKMe+ohpk6TrKt20ccTMkWx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=G0Q5o4gP; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="G0Q5o4gP"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-436202dd730so5754365e9.2
        for <linux-modules@vger.kernel.org>; Thu, 30 Jan 2025 05:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1738244522; x=1738849322; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qtz/HUy2LAw4vxPIZP5Akzwx47L54jE5hNrKXAL7zd8=;
        b=G0Q5o4gPsikxOmQyd3RFMoha28SjFG9j0zthmKD13bW74cEftApoxE3/zTZs/yptiG
         ESCH8hnVW8x+Cxk+VFaF7h0GWe5/FBz3uulIROqt1i5fnoD976dnukx4UaQya3X11WVG
         0lIcycXYv/yAcrCKeEp24opytEa2FQJip/mnLqhKwQ64Ur+SxRqPDrtpJkisHYoSyOEU
         fATaFgN6uzpVqRDykIxdv1F4KKN5dk9drQkvK/FVcmHdErktkcHLLwxvBFLzzHBFkDjf
         oxDphpl6ru7M8O80xm3OW9+0SQ/Gvh+MbtfQhKNNCYkzDJgUI4NsVsr16eJfMtVBZlns
         HanA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738244522; x=1738849322;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qtz/HUy2LAw4vxPIZP5Akzwx47L54jE5hNrKXAL7zd8=;
        b=L7vxVO8oM+wUhrYJNdosYcmpQCct5aTMbd+YFAaW/vy1o6A5+DUjeF3J7BpNho5uUr
         PaxwdmLKVCGohrJk9+w4KJWoULUBTc3pk34SDgRNUj8nbDLJXoxGCkpBn/0HmVw+FbFz
         C2rKz6lwrTvDhHFqr5XRUYfAWepD/wGv78o0fT0eXiuQG72J34AeI7yHg7VXa/5YEZth
         OCp2b3bZ3PWuS3s2cv4hFPOjkUg+gjUo/XEQMADMj/QyvJUtLM/rNAqzlZ/E2Ul/BWMp
         hUKwF/9HNj5eJFgazPc2l2P6IYLlsflPuRbsXttf8YRxUFoK86b+Gjhz88z11p3MPCo8
         orUw==
X-Gm-Message-State: AOJu0YxB/LOcHp3LRkIqGDANUq5WZ97A9hYseYin4a0lmLZkN1y+WgMD
	/JFqwIwgfcWBoAFcJZgg+pd7HfuEaX6rrHnvbo4PQBye3Mf0ipIS+vDXeQVMkFQW1N3PTbToQNn
	Y
X-Gm-Gg: ASbGncup6lCsP/UGe/BFJnC4I5No166b9EHbKUIQNA6c4T2NE5tjsMS4Vgj2y/cKjf+
	IrLOV5ZzaK9vYzixr1ztiIpfOG6W+UjEWaFheyZhB3SUeSNUyAliWUIKyUpO8Wkjj65ZLuXfE3n
	cAKMFtW027lt6XOpcqQtzOEe9QqbX1R2q4Xf2AVOsgk7j4epZqyuxXUZRlJ7LUDgdfJB68Z11Zn
	y5UBri3Jw4gtAlRvEZMa/ENBrMzN+vXbdZbSwYsi6iWhwZx+i3FDxw+acwxA8wQeV0dRQTSzrTg
	bYpboQIxUUHeNVEAfok=
X-Google-Smtp-Source: AGHT+IFWWrhh6Xee6IasIFKO1VaJfCz458xY21Q5cw2wx1s6OqWeasQBQMT1Ow2gQZrVtjhkwde4AQ==
X-Received: by 2002:adf:f504:0:b0:38b:e109:1e0d with SMTP id ffacd0b85a97d-38c520b6629mr5594302f8f.49.1738244521844;
        Thu, 30 Jan 2025 05:42:01 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c122465sm2031008f8f.47.2025.01.30.05.42.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2025 05:42:01 -0800 (PST)
Message-ID: <cd32d32b-8777-4ccd-94f0-ac9d35ca7058@suse.com>
Date: Thu, 30 Jan 2025 14:42:00 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/28] module: Use RCU instead of RCU-sched.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 Daniel Gomez <da.gomez@samsung.com>, Luis Chamberlain <mcgrof@kernel.org>,
 "Paul E . McKenney" <paulmck@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Sami Tolvanen <samitolvanen@google.com>, Thomas Gleixner <tglx@linutronix.de>
References: <20250108090457.512198-1-bigeasy@linutronix.de>
 <f4e953a4-4458-4034-b91b-7a433f20114b@suse.com>
 <20250124174949.mqhpjdpu@linutronix.de>
 <1907b409-f2e6-4b9a-ad5a-9879100bcf76@suse.com>
 <20250129085220.U6pWGr5m@linutronix.de>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250129085220.U6pWGr5m@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/29/25 09:52, Sebastian Andrzej Siewior wrote:
> On 2025-01-27 13:22:17 [+0100], Petr Pavlu wrote:
>> On 1/24/25 18:49, Sebastian Andrzej Siewior wrote:
>>> On 2025-01-13 12:09:27 [+0100], Petr Pavlu wrote:
>>>> Thanks for this cleanup. I've queued the fix in patch #1 on
>>>> modules-fixes. For the rest, I plan to give folks more time to look at
>>>> the changes as this affects a number of subsystems. If there are no
>>>> other concerns, I'd then add the series on modules-next.
>>>
>>> #26 (kprobes) clashes with the changes that have been merged upstream.
>>> Do you want me to resend the whole series or just #26? The other patches
>>> apply cleanly so far.
>>
>> I think sending only the updated patch #26 should be sufficient in this
>> case, it's only a small adjustment. Please preferably post it as a reply
>> to the email with that specific patch.
> 
> I just sent two updates:
> 
>  [PATCH v3.5 25/28] bpf: Use RCU in all users of __module_text_address().
>  [PATCH v3.5 26/28] kprobes: Use RCU in all users of __module_text_address().

I've now queued the series and its two updated patches #25 and #26 on
modules-next (for 6.15-rc1).

-- 
Thanks,
Petr
