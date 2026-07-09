Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178F03E5A01
	for <linux-modules@vger.kernel.org>; Thu,  9 Jul 2026 08:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783586997; cv=none; b=upAJ2sn9cAQIAW4OVunqL1N9cWsiCxjzC/uO11Hs1im4T+x21BXZ2XPclV1D2DCXa287zxj55XfkQ8oHtOEbBHm3WjwFKxts5Ns/J+98hzLP+hormu5O62umL9rwOhlFgZOy66tD92EPLcNeJF7+jew5/IBAyOj3KQQCdGWuS8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783586997; c=relaxed/simple;
	bh=D3G7vyx1LaryI7C/ZaZOPVqV5turY+pAK3gJb0LWiRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FS1e2YJaZf/026gakivkj0d6dNJowBQQORoT0tjxZdGDnooHBZlUO6N35MB1FnNNMETVYgOvzU6FaBfk1kUhh8qohZABbl1Ri6+vHUZXlxESqCL28DfQSoVXvPkM4d8SPbQqY2zKnDZuolsBtPaIrBT0GQD0uLBUiiWDHMRdW/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NN/CR5eV; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NN/CR5eV"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4938d5f86f3so4729575e9.1
        for <linux-modules@vger.kernel.org>; Thu, 09 Jul 2026 01:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783586993; x=1784191793; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s58vYGL0ZU4Qa0OIc631IRExqLjBaMvN8Phb7wDl8/0=;
        b=NN/CR5eVKzpEgO8wSrWf/i4GTJ+iV64vk4Y5G/qwMNYyB2JXW4o/TWpCW2aWQ7g9Ua
         mI61rBcFuEwVcRZHRNoxxafTN/XlS+vdjctCnz4aTt/j1b0MHWgyR48XFeD+Bth1hR2e
         dUKwFiQPtkUUwuoZA/nXO6dTvdEv6zd4bEHaDxnqaUc3PQ4P6m0VuenFBYGP+cTM8TKU
         I96MYckzzOkSQ4TtI0SMKqvinJ/qeX0cXlyJb0BxCN5eelqK3ccIcEnf4uFeI46G2D3q
         iTrq8kcJ9FQ6RU5zEMbEqg0WTwQAyu4IgzAaQ1DVGlTgfEh5o6XVbjjpZ6VgxZhevz3Q
         sFQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783586993; x=1784191793;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s58vYGL0ZU4Qa0OIc631IRExqLjBaMvN8Phb7wDl8/0=;
        b=YZpXD0+7j0OyFxCGMzak7ky2mg7eEUSvaN2iWHZdkU2QrkzkG/A+i86321J4ZtS+2F
         fvOqlvqNvEN5Djai+Z7RUlY2KCaf0gp++CnAHdlNuPT58ycura4J8F2oh58ahThtHMIl
         gxaWBgtJDXiPOi67IB8zg3Xoz+Rc1DMFB+FJRk+93SrX3BC36m3EdMaZOgM/Frrt94e3
         j5lmjj5Ou5mzM0qvh1x5Ye+d7wdWLLVcoyQgMrYxzyMmLoC7veNHtIxgQ6DbVvsoB+Y+
         4ljou5RCydh0DcYPdIRIatAHSCMKWz31cvgjhELY0GpG4SgVO+YUzWeRKAutvX0GgRXD
         Lr7w==
X-Forwarded-Encrypted: i=1; AHgh+Ro1uX3N5Y1tmffaLGSEjm+192NkW6wKVuDVHftfXFr3fmS9Hbf+MUB1dKD+eivAbTuCDxlCgGqTvBIwPAlF@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe5TlKeefiFU9mHdTWbsXTYj42DGUWf8kYfth9U3x/4/1MgUYS
	2JccNqLK76YVCoKnmDU+zJSDemcPZNV6JqxdX+IMhTRL/LcILSgfhOrPjkSXok3JHvo=
X-Gm-Gg: AfdE7cmsdMFgR5UKcUYRFOpIaUZ8zYTW6HwIR4tEweg1QBWl9Pwvth1GavFqoft+0ee
	nDDQ2XWhm9J4ylj55wtypeOzxDE+G/o6qKBboKYQHJ8XVjxmhmY5bmacruotqjhtc94kkFlT4XG
	tHEEk0WNPNGKKYjVsTJBiUvoYV4uyfCwYaGiu3lF8iYEN0URooHTfwMSUOTF+lpoa3b+DBq8wLV
	YGOqwq32HW//0Jhhz7Ase6u/2Uigvw7hKmhz9ITqQFrF8qkVds/G7czy4XOy9D3UcFfJqzoUKkq
	Dap0iD4pEBRL1AlZfgkEWOUq3synrctCM9t/PHikVRuled/3wOH0nmyFk38fmsocIyASHN4KgD2
	Xmwtl9+g89oB9O8jrt3QePXoTTMfznuZBm7/wOVQ3sDASCrtd8Epguc5SRE2a43kJHwGhrcio3A
	EYJHZ2TTpCB/e/LCT+EwfNmg94SQ9Q4rrEOQ==
X-Received: by 2002:a05:600c:8885:b0:492:7025:13fd with SMTP id 5b1f17b1804b1-493ec32a1a9mr12943745e9.0.1783586993281;
        Thu, 09 Jul 2026 01:49:53 -0700 (PDT)
Received: from [192.168.42.79] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb70a372sm45258815e9.7.2026.07.09.01.49.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 01:49:53 -0700 (PDT)
Message-ID: <19204b0b-8c42-4df2-92a7-26af32e15d50@suse.com>
Date: Thu, 9 Jul 2026 10:49:52 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module: Remove unused DISCARD_EH_FRAME definition from
 module.lds.S
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Aaron Tomlin <atomlin@atomlin.com>, Ard Biesheuvel <ardb@kernel.org>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260612133920.1919352-1-petr.pavlu@suse.com>
 <CABCJKueO3NkVrsR9H6JxFpEf=UsGZ2PCPSrs6hXJh+cdBjikVg@mail.gmail.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <CABCJKueO3NkVrsR9H6JxFpEf=UsGZ2PCPSrs6hXJh+cdBjikVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/17/26 9:29 PM, Sami Tolvanen wrote:
> On Fri, Jun 12, 2026 at 6:40 AM Petr Pavlu <petr.pavlu@suse.com> wrote:
>>
>> The linker script scripts/module.lds.S contains an unused DISCARD_EH_FRAME
>> definition introduced by commit 68c76ad4a957 ("arm64: unwind: add
>> asynchronous unwind tables to kernel and modules").
>>
>> As shown in an earlier version of that patch [1], DISCARD_EH_FRAME was
>> meant to be used by SANITIZER_DISCARDS in the same file, as follows:
>>
>> -# define SANITIZER_DISCARDS    *(.eh_frame)
>> +# define SANITIZER_DISCARDS    DISCARD_EH_FRAME
>>
>> However, in the meantime, SANITIZER_DISCARDS was removed entirely from
>> module.lds.S by commit 89245600941e ("cfi: Switch to -fsanitize=kcfi").
>> Eventually, the mentioned commit 68c76ad4a957 only added the new
>> DISCARD_EH_FRAME definition to this file without actually using it.
>>
>> The file include/asm-generic/vmlinux.lds.h contains a similar
>> DISCARD_EH_FRAME definition for vmlinux to discard .eh_frame sections that
>> may be present when CONFIG_GCOV_KERNEL, CONFIG_KASAN_GENERIC or
>> CONFIG_KCSAN is enabled. Testing these options on arm64 with LLVM 19.1 did
>> not show any unexpected .eh_frame sections in modules.
>>
>> Remove the unused DISCARD_EH_FRAME definition from scripts/module.lds.S.
>>
>> Link: https://lore.kernel.org/linux-arm-kernel/20220701152724.3343599-2-ardb@kernel.org/ [1]
>> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> 
> Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
Thanks, queued on modules-next for v7.3-rc1.

-- Petr
