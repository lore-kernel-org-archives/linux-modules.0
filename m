Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8F86FC3;
	Tue,  2 Sep 2025 02:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756778806; cv=none; b=RMPfLy682g2Z6r8EO4IXe2aqofTNOyvf9VuVUoB5LiykDhPrMUe+IJ54jhv2IGTjz+XvNvSJw6FFvU4iQc8yoH20P+0ltoYVsKEMHeMlMQ4obWzJglLdvYkQtgMpRqqhWRqyjq1dnmZprua2ALavcoW5lh7W+3v1HaO111pxres=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756778806; c=relaxed/simple;
	bh=HKF7Uq1F70Kwpgymh7jE0C86slFJcf6p3imFzKXpX/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kY+Oyq9h2ePyhPx+SrM2h4FlJeX18W9Wo6lffPmW0mPhxD/iGtE6SOCTLUtAL3+3LKRl2TGOXWG1d5Xki1lFGxzMxbQqb0yuQZJOORP79Viv8o2nAE5f4cm3nd2m93nOORYRwipRRGbKNGcNrbEZbjwEczugRbsGw/17LLv42do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8xpWlnC; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8xpWlnC"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-24af8cd99ddso9109585ad.0;
        Mon, 01 Sep 2025 19:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756778805; x=1757383605; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jW9MYCTk53LCzNuCPTRNVQYG7lCrtmuE12XP1nv23mk=;
        b=R8xpWlnCVG34spWukZ8xf2qKFxlEkZhawnf5T35ZPulM4t+iKfR6P6OuAzhBMG2srf
         kmmHDTuC2tTA/pXdCphnvfjTjWsQT0Q4KIk7bvVax1e1tWs8iGmAUeh9dhGNaT8KbG6C
         mckJCEkEC4zLlPlygokm5Qe0JhgiZpJiKm1CBKJeBfAg8ShXZuKuBsS3X/fpbwAxTASL
         yPQcEwFzVBP2tp0eUTnb7ztL7OQgCrp9M560WyKVm1kbbSWQ1Yps5NG3RrfoErvlYMEq
         WgrI9ou3BMd4EciwzC9qWODatLqAGVAGMzyLsZ9h7IPvVoan43y7ZEnnOtrQNzaYs1fd
         ww+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756778805; x=1757383605;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jW9MYCTk53LCzNuCPTRNVQYG7lCrtmuE12XP1nv23mk=;
        b=Fw1G88nx5y05z3F5Bnw13ztdHeUSGcBL4E8+Zjwxq/xEpjp6QltrXv37HVbuif6Gei
         NiYBgjmslsU7naaHr2MlfFmra09Vd8uiEPnE3yNK+NSwFU3qkREidUdaydbozALAC3L6
         Km4CMfSVCHt5nOtYmZhZDxYZQSB/DZ2QMmBy3RpKlyFJagQdO2xK5CQHVQZhsOrkX69n
         gVVKaufj1vL8FzCvGmFjsZyASeX16ikWvaMqOqIBP7puGe/et6DEjTlQFbGDAd0JxLL9
         H55P1rte5tTzLddoEcASy7bYksvMD1Es8lsOXTYAVcP9Ouk1g7BayXEQvvKvncLzXnkI
         oUYQ==
X-Forwarded-Encrypted: i=1; AJvYcCU48+DWjO/nVXe6eRlxO1l9uwPaxCWauJGvv66OjQu8ORpp+5/kpdICKBb2v+eWAb+ozNKcvdC96MKiLko=@vger.kernel.org, AJvYcCVXqO7YTVr1ygsViIog0mfKOr2cTK9uypfSV8fyDSvEDK/GxXu0OUB3p11Oa+gERhWeJKaBlmHz1TXyKZU5SA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8adacM6ekaVSUQYBnNJZvI+u8VeRrpJ67zvpz/Dybdrllgh/n
	rUMVSuoPJH3e8jXEyMFwlxiCBmaltfTCArJ094k2880MlUs+Wkxjw3VSBdjvg3Mvug36Yw==
X-Gm-Gg: ASbGncuI8neCwkxINN+eTeORlAC2TFThWiB/G/26BTO+Bgof3QaSvp/oLtJ9YCWvigw
	qQ32r5DJZPwoQxD5xv1QPQNwyw0RdtLV4niLmF3kEDznHgA7aZxUKFIeSnjNDW24sWIjYQYlytN
	KWEqGafaWqQwfoGnzAyCLw3QRladjHFFryGdaklacI0+/7NcEYi30nVjtBHkPqx+9icJsf0uZr8
	DA5okmEs3Z8G13MpVrBjsCUzy1hQCfXF5V0VtaES7DUSbbLM3fI7P+bXlz/rMvZTbqbFQmLAmve
	jqi7bRZY07k1T2/+euClvvBRwt/twUKKj3LyuNenm1/NtKzxr+twF/ITlj+0uEwbrVRLOK8rWec
	W8I8cECBLcFydP22tU4o+D8+um1qvMU2jMIe50EI02YNgMIw5lE6aCH50Ag==
X-Google-Smtp-Source: AGHT+IFRHR1yrS3pX+3CXulKJValPNBkxHOddHYt0ZzaxzpUhMDiKFo8IyVJGkckl4oTxUGjK8k65A==
X-Received: by 2002:a17:902:f542:b0:24b:1741:1a43 with SMTP id d9443c01a7336-24b17411e77mr2707075ad.58.1756778804599;
        Mon, 01 Sep 2025 19:06:44 -0700 (PDT)
Received: from [127.0.0.1] ([45.8.220.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24905da3c38sm116302875ad.91.2025.09.01.19.06.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 19:06:44 -0700 (PDT)
Message-ID: <c853de6a-ab46-4228-953f-f509e0c84b74@gmail.com>
Date: Tue, 2 Sep 2025 10:06:40 +0800
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] module: show why force load fails
Content-Language: en-US
To: Daniel Gomez <da.gomez@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
 Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250829084927.156676-1-wangjinchao600@gmail.com>
 <20250829084927.156676-3-wangjinchao600@gmail.com>
 <851c227e-5d1e-44bb-80ca-d9e230e8ccfe@kernel.org>
From: Jinchao Wang <wangjinchao600@gmail.com>
In-Reply-To: <851c227e-5d1e-44bb-80ca-d9e230e8ccfe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/2/25 02:29, Daniel Gomez wrote:
> On 29/08/2025 10.49, Jinchao Wang wrote:
>> Include reason in error message when force loading is disabled.
>>
>> Signed-off-by: Jinchao Wang<wangjinchao600@gmail.com>
>> ---
>>   kernel/module/main.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/kernel/module/main.c b/kernel/module/main.c
>> index c66b26184936..e7484c6ce6e3 100644
>> --- a/kernel/module/main.c
>> +++ b/kernel/module/main.c
>> @@ -1083,6 +1083,7 @@ int try_to_force_load(struct module *mod, const char *reason)
>>   	add_taint_module(mod, TAINT_FORCED_MODULE, LOCKDEP_NOW_UNRELIABLE);
>>   	return 0;
>>   #else
>> +	pr_err("%s: %s, force load is not supported\n", mod->name, reason);
>>   	return -ENOEXEC;
>>   #endif
>>   }
> I don't think is good to inform via kernel log buffer what the kernel supports
> or what not. And definitely, not as an error.
> 

Thank you for the feedback.

When debugging syzkaller, I noticed that insmod only reports a generic
failure. To understand the exact reason, I needed to trace the kernel.
This patch was meant to make it more convenient to see the precise
cause directly.

In my view, if the caller cannot perform the requested operation, that
represents an error, and the kernel log buffer is the natural place to
report the reason. This makes debugging and testing easier without
requiring additional tracing.

-- 
Best regards,
Jinchao
