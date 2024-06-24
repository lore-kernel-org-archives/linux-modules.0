Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C0719EEC4
	for <linux-modules@vger.kernel.org>; Mon, 24 Jun 2024 17:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719250830; cv=none; b=Ak0Qtxxl7Sj+2aSgWBw2lV6ZF+0hrM2EnvY/V2Q4M0qdSKJtVW57BNU4EEyYr9jEIE9n/iPG5YeGZslawGweo0xjqSazOLGOfXdHNgvxvWn8flDlo0wzFrvWOMixdC1SsW9Z1FeBraZs2M5CUd4h5s+yg2pYtYn7ft91cFKahpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719250830; c=relaxed/simple;
	bh=Ty+zh+pGhG1V+zyFspbF91Wp02zfhi2jjVOb2Tzfrvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l4/Acl4tGrbQroPjVuK1LaHzi7xr2UzjcqMgNp3PYlde1JPsgGjmgfk9qhkfBDkqXvY3d1ZXuKoR2hjO3iIoQhCtXioCRZycz/06Ul4ROBaPY6k5tPA03HbPBYH5U5e9w8I98MfpGGxeUz1mmW/x0ydnVXSeD/UrrX6bE1y0fr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AwtlaAj+; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwtlaAj+"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7066a3229f4so1461873b3a.2
        for <linux-modules@vger.kernel.org>; Mon, 24 Jun 2024 10:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719250828; x=1719855628; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w2Emc3UvY2acM1pv8N8ISUmypPEyopbGuL4MlmG8D7U=;
        b=AwtlaAj+zUHhvM2g+8oZQM5tYRXNflNXjx7VQdbYnBbeEfXScdquCHPVoBsYHoQgi1
         tphUXCcbL8IfrabDnTIo0tJtAbXlDZjI+N+uYDHjSMLLg8qcamhxEktjfJ7k4SyKQQPc
         XySgd6HtQGGF4Y7gvdUmMeOE5Z14t0do8f/SyqlkJQvPaMtcb9Wo98ADGvs0oY+8ZFOu
         f7V1VjuJMw97BrgR0UNnHHci5uN8c+q2z2K1rRkEHQZKwa0oExKQmOBGcrgrYUjX1T5T
         RKfA/6L9AQZRvPIpPv6vWBxKXJ/JgxQaWOLPKq/v2fck++LMfjhsgSdIUQQDoKP3+oFB
         iQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719250828; x=1719855628;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w2Emc3UvY2acM1pv8N8ISUmypPEyopbGuL4MlmG8D7U=;
        b=rpav+7cWUtjXuby4oJ+7se+8ooeRMQw/YNm0GE44yi3PqzdB3XvszHER7F6iioKiUa
         CU/5XrD7LxIsoTQAHMEXyfgnNMVenVlbN+H1qfYn6ba1HuNh9DDs8ZypBGTR+lrS/dRX
         Trvzs1W394W7LF1mPPgqaIo+SLIZpzt1yefkiWkDrTtl1aJDskKQ/Dds/2UG7VeGshvt
         FJREPWyTGKick4mBaYIP8vlCce3pVEWu4S/Amje4u/U2GliKOwEM4jQEI5IeVZVuisSY
         1eichPba0D/ae1yEyqhc7nYf2Ea1IXmNJFfs7wHvKN7PpNgN4FDz5owc/WEPja/6gaSW
         f13Q==
X-Forwarded-Encrypted: i=1; AJvYcCVfGfaHnXpiBueaZkOVRpYJPp79nAkM4INfaFATUDgcNxvwLVh26ySns8O7IK3FEYv9cMc0ajEWK6CNhl7NN+4I8ysFWD/313ftHUygxg==
X-Gm-Message-State: AOJu0Ywb1pC6cnU3tMlyT+n1FYaLpNXOVkQ2kcaYxrF6sQaNDUEIU0aJ
	BGb+qSXwsqbEuWPOSQcuc5IXC/DVTTJ2Ms7t1spZ/RYYR8GEmZ8Q
X-Google-Smtp-Source: AGHT+IG7rNqlkuBM8RSG318zrfClAqWC2MKHKnRRPR26LgSU1AiV4T7s25Q7oQmv78pof3jZcOHv1w==
X-Received: by 2002:aa7:9a04:0:b0:706:423b:2ed1 with SMTP id d2e1a72fcca58-7067459c785mr5749775b3a.6.1719250828337;
        Mon, 24 Jun 2024 10:40:28 -0700 (PDT)
Received: from [192.168.50.95] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7068e088e1esm1427002b3a.213.2024.06.24.10.40.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 10:40:28 -0700 (PDT)
Message-ID: <72c771f3-250f-430b-a7d9-f233e929ccd3@gmail.com>
Date: Tue, 25 Jun 2024 02:40:23 +0900
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] libkmod: fix result of comparison of unsigned enum in
 kmod_dump_index()
To: =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>,
 Austin Kim <austindh.kim@gmail.com>, shjy180909@gmail.com,
 linux-modules@vger.kernel.org
References: <20240622061321.9005-2-yskelg@gmail.com>
 <20240624074956.GR19642@kitsune.suse.cz>
Content-Language: en-US
From: Yunseong Kim <yskelg@gmail.com>
In-Reply-To: <20240624074956.GR19642@kitsune.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Michal,

On 6/24/24 4:49 오후, Michal Suchánek wrote:
> Hello,
> 
> On Sat, Jun 22, 2024 at 03:13:22PM +0900, yskelg@gmail.com wrote:
>> From: Yunseong Kim <yskelg@gmail.com>
>>
>> This patch fix compiler warning in kmod_dump_index()
>>
>> libkmod/libkmod.c:989:11: warning: result of comparison of unsigned enum
>> expression < 0 is always false [-Wtautological-unsigned-enum-zero-compare]
>>   989 |         if (type < 0 || type >= _KMOD_INDEX_MODULES_SIZE)
>>       |             ~~~~ ^ ~
>>
>> My compiler version.
>>
>> $ clang -v
>> clang version 18.1.6 (Fedora 18.1.6-3.fc40)
> 
> If you look eg. here
> https://stackoverflow.com/questions/2579230/signedness-of-enum-in-c-c99-c-cx-gnu-c-gnu-c99
> 
> you can see that it is not *guaranteed* that the enum is unsigend, and
> consequently a value lower than zero can be passed in.
> 
> Consequently the bug is in your compiler issuing the warning. While in
> that specific C implementation the value cannot be negative in general
> it can.
> 
> Finally I see that _KMOD_INDEX_MODULES_SIZE is defined separately from
> the enumeration itself, and would be prone to getting slale if the
> enumeration is ever updated.
> 
> Making it part of the enumeration so it automatically gets the value of
> last used index type incremented by one would be probably less
> error-prone. In the kernel there is also a pattern of defining *_LAST as
> an alias to the last used value in the enumeration, and then
> _KMOD_INDEX_MODULES_SIZE coud be defined as this last value incremented
> by 1.
> 
> Thanks
> 
> Michal

Thank you for the code review Michal, I understand your point. Would it
be acceptable if we don't need to make any further adjustments to the
warning?


>> Signed-off-by: Yunseong Kim <yskelg@gmail.com>
>> ---
>>  libkmod/libkmod.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/libkmod/libkmod.c b/libkmod/libkmod.c
>> index 213b424..fcb619b 100644
>> --- a/libkmod/libkmod.c
>> +++ b/libkmod/libkmod.c
>> @@ -986,7 +986,7 @@ KMOD_EXPORT int kmod_dump_index(struct kmod_ctx *ctx, enum kmod_index type,
>>  	if (ctx == NULL)
>>  		return -ENOSYS;
>>  
>> -	if (type < 0 || type >= _KMOD_INDEX_MODULES_SIZE)
>> +	if (type >= KMOD_INDEX_MODULES_DEP || type >= _KMOD_INDEX_MODULES_SIZE)
> 
> Why are you adding a duplicate check here?

I also think my code is really wrong. I'm sorry.

>>  		return -ENOENT;
>>  
>>  	if (ctx->indexes[type] != NULL) {
>> -- 
>> 2.45.2
>>


Warm regards,

Yunseong Kim
