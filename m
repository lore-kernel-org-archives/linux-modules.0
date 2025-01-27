Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE201FDE09
	for <linux-modules@vger.kernel.org>; Mon, 27 Jan 2025 12:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737980542; cv=none; b=JYwzMI3Kq1xfRyHfaYjgR1irj4+taIxZf0RBce16DhrGevfG/3FJYdDc8urI61I+ofQFjLB8v+OrCIOv+vcLiL3GJZ96S4c6DLmO6xhpOJZfEvwghzWM+PG/L/3l/VW5ANM+I1GLpM7Yn/nRG13HQZ6b7XiEpk0Ps9eObU5bXVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737980542; c=relaxed/simple;
	bh=fbvqk/a2jG4gAyIublTZ3i+FlWi5ys3TOA9Yl3CzQ6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pXm1iMcqfdFqyqKeloBN+8NzAkwcBwVxa/X9fpPBgw3ta+2q4MqbxVbzHof8SBnu++51S3ijZMtQVttQEvUZGnS1PR1bMpghrwNxxDR7h/DM/fOB7M5TA9GXoMhwXt/xATJDwt3CmNzdfSRnXi3I4fZKWTZm20qnAR0lEGmOUJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=F5ADx0Xt; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="F5ADx0Xt"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-436345cc17bso30647545e9.0
        for <linux-modules@vger.kernel.org>; Mon, 27 Jan 2025 04:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1737980538; x=1738585338; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iy/If3vqjuwHEdS8WNC+ry9+Rcf3nlQmzyLj0FTdgcU=;
        b=F5ADx0XtTgrCCY+ddp/oOTSzCMUOuU2VWRSnNo8wrvp5iSBDtv1ruHy2hyfC2x1/ag
         rzvKRdmmaDx4MIcyDTjPj7VRYn8HGFdGzJTHbPQT52TXPSsH80xRNOV0wHqEF+apdXNw
         ROTggAc+IHvrVHt5/LyDasQz6V+gAgZeaYW4fTR1R46djPuApfGbPMKpicwHdKDgFBRx
         8Le9KUjjn+uExTgvMSW9qfDgr8KTEqGlpuvUcQ4kxLH3DqtZZSm6BX0rrQbkYT+hyAZM
         KDdTC30rF+I+JDGCeKlMjlVqc6FAUBtJT3NjxOIawl3fO0Z/+MT/dXm3tDo410+CXZiu
         Hxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737980538; x=1738585338;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iy/If3vqjuwHEdS8WNC+ry9+Rcf3nlQmzyLj0FTdgcU=;
        b=w3K9TvXfwP99qwPQT4G5IAg+NBOMREBDIbQke6EWvgzy6S69cnu1t/buGLjF8ra2pW
         UbxWENUY3aCidbBaSUwL4vobPgX6aA2/AXzOmfLV8ncMe8khM6yAzyjeEhtVgLT3QHMS
         /yxSLTeZr3nV13Xw7CHl5XuirhUandw7JmG97eImCuUM2KjU2UxOOyLJrul17oecjq/t
         rr6ZDVrM5y9Q0MIisDWPxUBN6qK0LcCc2DpJbR3hez68zEg99o2KXxjszjyJIh1elWxE
         vOzmUimeqzSS/4Vo0oQWI7sh1MlbioF6sUFLfNbPRSlD/SnlB5LcPVlDau73YpxujUTL
         O+cA==
X-Gm-Message-State: AOJu0YxhpEsz9q4awgG2jkVQC11q7QaQqMBpHyxc4s6AY0laMEZ4sXZj
	SrvYlUjV92sguveIDFNQsO75CNk4Nh1ZiEJKEchEav3phy6qKAcE6wyT5F2PnVhhAFXMZJdg4h3
	Z
X-Gm-Gg: ASbGncv52P+Zs1Cv1CP4eBcIIoG6k045fyRec22sNVhsfmjWWb57zSrX6C+T27lop82
	2kgg4L0OQhzAc8kjXg+Qwf0SkiET0tmpL9NelC3x2OwQmEk0Dtc2SrGd5N+j9z13EuMyIRsTRCO
	6y2YKV3QNcdxihAZl9rRt5IJlo6V+I4FFDfuU6bHo/FrIQvKZdgSdK3QgM4tanld8vyx8pyn6Bk
	Eo58aBWLPJJQbXlD/AHuF62axX+j/YbHXu3ZeFcIHDSTLXaLQ1fgyTusQRNUHJtH531B0dIRlss
	zL/o41Se
X-Google-Smtp-Source: AGHT+IGVCH3+6as0ufUivrgkx+5s55yFvq7RVrlcvc22bcponB6X7mAx/35SUan01yaz0inFxfWN5Q==
X-Received: by 2002:a05:600c:46ca:b0:434:a367:2bd9 with SMTP id 5b1f17b1804b1-438913dfd7fmr434187875e9.14.1737980538528;
        Mon, 27 Jan 2025 04:22:18 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd48ae56sm129760975e9.21.2025.01.27.04.22.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2025 04:22:18 -0800 (PST)
Message-ID: <1907b409-f2e6-4b9a-ad5a-9879100bcf76@suse.com>
Date: Mon, 27 Jan 2025 13:22:17 +0100
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
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250124174949.mqhpjdpu@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/24/25 18:49, Sebastian Andrzej Siewior wrote:
> On 2025-01-13 12:09:27 [+0100], Petr Pavlu wrote:
>> Thanks for this cleanup. I've queued the fix in patch #1 on
>> modules-fixes. For the rest, I plan to give folks more time to look at
>> the changes as this affects a number of subsystems. If there are no
>> other concerns, I'd then add the series on modules-next.
> 
> #26 (kprobes) clashes with the changes that have been merged upstream.
> Do you want me to resend the whole series or just #26? The other patches
> apply cleanly so far.

I think sending only the updated patch #26 should be sufficient in this
case, it's only a small adjustment. Please preferably post it as a reply
to the email with that specific patch.

-- 
Thanks,
Petr
