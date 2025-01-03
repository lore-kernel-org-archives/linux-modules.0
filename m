Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B28E1FAC38
	for <linux-modules@vger.kernel.org>; Fri,  3 Jan 2025 16:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735921445; cv=none; b=WV96KYRU44Xyjz4Wo1w8jXBHkJSV49FPAxXjEneKQG0escLu0bBs5jkKRA+aROEsahoX1za3cwMFIfASOC5YQtaLCkiE6DUtxnWGldjUZ7w4KKWfPMJxu0qT8hb0CfO+BHQIgDHQvVb8qSAGh6+mHdoZ8yOBD310XRxnoqKrzes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735921445; c=relaxed/simple;
	bh=MmXx0Sp/jmYn3iIyoO5TB5AdoARn2QLyZowKdFIwboA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FBYWT7ZxxbY0kEFaKYlLBqP8BTEUxwLc79SazBMaAW5JaAdai/7UQN1hNNbyzODdFEU+KpvUhPJz64sCWKEYOnnu5k4vaXChlrlBhhKe3om3CNR2R2bD3bfUtweD0uJpkNfDITU6K8B0+BqSkVbYAvstSVGApjoT4MZMS1wOXiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XvVDIXY9; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XvVDIXY9"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-436637e8c8dso126325905e9.1
        for <linux-modules@vger.kernel.org>; Fri, 03 Jan 2025 08:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1735921441; x=1736526241; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H70R/03uyVJydSB72SdV3FQ3ClX94+TJHaXoQZlfiJU=;
        b=XvVDIXY9kPOIjFgqMuNiR7tKcCik7SqIZHtHaziB/SbLoOW/nSWkQg4+/glAfn8kaG
         6Xx9GXV6g0VuVwVIGbDDAdp7ld/VB3r+WNar63iPHx/cdozomBTSs4dXHGX/0oWmLtnA
         iSw8W0lXERzHb33YyB2Bf1XCEthfXsEg4u2PL1aP5Uxt4f2WoscZ96z6+3/O8JLkOAir
         mxpJc4fw4qBwanvUyUwCtb2PyUVB0bJy3iAJfyc1ZIy/mtxhrx/90bChGLEalnjIkrNk
         jVB0ZOb7Q7Xg6c4eAKg+j4zJ/z4smocXphf2BDBLfDkRnYPoCXkI3wvPSPWH5ILk5OOZ
         HRiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735921441; x=1736526241;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H70R/03uyVJydSB72SdV3FQ3ClX94+TJHaXoQZlfiJU=;
        b=tOvwuu4hmz+9ZuuSK6RQ9knJs43tH4to8MJJlXvSWDXeX5RFzmMqdkA5CgmLmECKC+
         NCtLXzy+I6HyIE/OC67Up+RrjLklFlz8d8bGIeb8GE4T4X3Hnhpwg1CZPIlWOC1QXd5r
         kL5qs3OrNTe/dQfkp0Iy/S7FyF8K/Xe8FoGOqq+DQZBioWcckJvmOOJvbG6/MXAQs+3+
         Qjyrjre0A89Y4gWwDyFnDTizNW3SjQe/q3CJ5gs6RSWqrDjJEVMfOD8c78i6ppZYO11H
         dJczKBcsBCwPpW32mSk6SrMyZqCe0zO07DQhwH6dC9tHjxyYntsksJZjZWwkl0eQHuog
         N7Jw==
X-Forwarded-Encrypted: i=1; AJvYcCWUPfPx6O1F8ft8MrulZYfOUWi0Z4ImRLKdZcjQzCoKPCS2tNjLNBSaW3vNp3AdXn/wr8L5x9DQ/MvDje7w@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpo+UkgMsaby/kPsWMKqf6pAe6UGBN0DYsxKPGX78uc2n8/6h7
	OSj4rxMJUm+C+Gtp4iIJd/0/srIEEEV5N7zJFEtyxUnijixqVI1ayfpWhrynQRQ=
X-Gm-Gg: ASbGncsEjwBbngiOh9L2etI5iKd12RIjgSUtLXYcON6VUkwPWUVt5QJvTkYekiX1qei
	lgK9qhUqPHAptyyMfZX33JfB4Z4YtWmDMCzKssUQ8P1OeHIO/SRuYjJZLcEcC9au7H1E3Oil2ax
	Lpf0WrnaZbTMgw4zHoIZhzUrsTwBujNFa7/nY115R1MAevnB9fzgsQ0ohq2yqamG9IBRP5IUO5C
	Oow6AYAUDtPJ2z2VcsfOi2gA6wkyh1FlF8wiQEUvZci/bmmcCdDW+lrINxs
X-Google-Smtp-Source: AGHT+IFf/SR4dRWvmRC+B1P+ShyzB1KWIoOj33kNBa7ANLe3lDJzvpxnZzTKtFIWSacPwzar1KWNkA==
X-Received: by 2002:a05:6000:188c:b0:385:f0dc:c9f4 with SMTP id ffacd0b85a97d-38a221eaeb6mr38517281f8f.20.1735921441384;
        Fri, 03 Jan 2025 08:24:01 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8288b8sm40703084f8f.11.2025.01.03.08.24.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2025 08:24:01 -0800 (PST)
Message-ID: <e587d63f-f28c-460a-8815-efbc61cb6d93@suse.com>
Date: Fri, 3 Jan 2025 17:24:00 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] module: Make .static_call_sites read-only after init
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, Peter Zijlstra <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ard Biesheuvel <ardb@kernel.org>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241223093840.29417-1-petr.pavlu@suse.com>
 <97beceb2-dd87-4b7f-a269-b6612e5557a3@csgroup.eu>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <97beceb2-dd87-4b7f-a269-b6612e5557a3@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/3/25 15:06, Christophe Leroy wrote:
> Le 23/12/2024 à 10:37, Petr Pavlu a écrit :
>> Section .static_call_sites holds data structures that need to be sorted and
>> processed only at module load time. The section is never modified afterwards.
>> Make it therefore read-only after module initialization to avoid any
>> (non-)accidental modifications.
>>
>> Petr Pavlu (3):
>>    module: Constify parameters of module_enforce_rwx_sections()
>>    module: Add a separate function to mark sections as read-only after
>>      init
>>    module: Make .static_call_sites read-only after init
>>
>>   kernel/module/internal.h   |  7 ++++--
>>   kernel/module/main.c       | 18 +++------------
>>   kernel/module/strict_rwx.c | 47 ++++++++++++++++++++++++++++++++++++--
>>   3 files changed, 53 insertions(+), 19 deletions(-)
>>
>>
> 
> We have a problem at the moment with ro_after_init sections, isn't it 
> better to fix it before adding new stuff to ro_after_init ?
> 
> This series conflicts with my series which aims at fixing up 
> ro_after_init handling in modules, see 
> https://patchwork.kernel.org/project/linux-modules/cover/cover.1733427536.git.christophe.leroy@csgroup.eu/

Sure, this is a fairly minor change to keep what the modules loader does
in sync with how the same .static_call_sites data in vmlinux is handled.
It can wait.

> I was expecting my series to land in modules-next, do you or Luis plan 
> to take it anytime soon ?

Sorry for the lack of clarity. I've been waiting with applying that
series as there was still some discussion. I have now replied in its
thread [1].

[1] https://lore.kernel.org/linux-modules/f0e892c7-43cd-4310-9d60-1d6e839f5bb2@suse.com/

-- 
Thanks,
Petr
