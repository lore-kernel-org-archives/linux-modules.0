Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4204EC668
	for <linux-modules@vger.kernel.org>; Fri,  4 Sep 2026 15:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788536210; cv=none; b=AvW0TnOc08oTKtWpLGGUr+QXXEoMokvISSytGGI2xhqYXa0zebqXdpZILr6uo51QGMzEKVaEGgOpVwr8CHF+Vn1uBA3mEv1+muZhYiQF1q5a2AeezlVv5kiE9k+3EoElmONoflXg+1DcK75Yv5l4JEsWYg0NT8NXwwlvyZW2Hak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788536210; c=relaxed/simple;
	bh=aaZIP2ylDVjQUtzurgdQ9wq0pNSQxBzXiVQVyeKHPJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xv3SLzogo9UozGOnVMYNDN7VDHIH1l15a8rVO+PX+U3AefvQd8ocgLn5vqp/UuUv9ztL1UUH5Ia8jV4GRksNpA2J+NmNTUEYWAfd0naN5eAKziOM48b7g0MvuaKFxNPXQnocR51lmyiwl0FbvZvRdd7vQVpwwH1PVaEJgrMmMCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CqyFV6Xe; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CqyFV6Xe"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48441fa5c37so783301f8f.3
        for <linux-modules@vger.kernel.org>; Fri, 04 Sep 2026 08:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1788536206; x=1789141006; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LsB/pfsHs0wy5wl2WAyEdIegLrat6VbBoQVukEgDfgo=;
        b=CqyFV6XeE2iPSCzk6+O/m23NWilPd2Smy+mM2MKJ5ZJWNCGy54GcaJto9wt+h9Mg8n
         zYoTDai2HA42UhptJ+knw9JM5TZXUkRdv8eyad9XFN9zBdYjEsMmrdO51edXk+UKSVUx
         hMDtEu2ArAwarUPEH3Ve3+hXGXb6XB1vZsb6/cveP6PAMaybbCtMVLK3FZSkbhiEoTVw
         dlnOhQ7asxq3bNB7o2Z6PmCdS7iHz38dHteLsP0sXlph/NvJq18khoP6ATmpl6NuvSNG
         +M1GPP1///TqT5k1boTtZGpiXmg3t7iZaagIQ+EmYH8le0CiFCwetKAAfg+o7CKA65x1
         keug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788536206; x=1789141006;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LsB/pfsHs0wy5wl2WAyEdIegLrat6VbBoQVukEgDfgo=;
        b=WjDaOR5srHNUamolppkN4+sfg2eB+Q3qoFu7Yfxzc7RYVuV8CQI1C+pBqPLQ3YsxGq
         mR/bN/rWcfeUB2KTZefKaSLy/hgYb4aYCOU5jFXL4M8lEjdIg5VJYZ/DsQd0R7lnI/HV
         a/QurFR7oqFSx+gol3cbXEa3WO19if2jeOpaceFPDeRs/uYt2I/iB7XO/sIz86ThTCtQ
         kuf1LoNbz1QY88kTKDzSSmePVQlgicCwgREDHRn+RSTH3j59fOVC7LV0LpeRKRCe/xtb
         wJga4wz1NOwbPS79hftPxdpvqYJz2Ai+404jbuM3a8egiHNjLkRs14sOza/3by9S/RXX
         N09A==
X-Forwarded-Encrypted: i=1; AKwUvByruJB8gn/ttfHKORjXI9Erb4dZCZ9xrTX29dRFwqXvXkszfIstRru9camU9+Asiu1ycVv58I7i9tYet6sr@vger.kernel.org
X-Gm-Message-State: AFuF++kLS4KElfpqioXK4mBuMdkcGDKcsKrM1WmQOUgmlttBOiOrt7N6
	8hwo/LJzbtiCrlFK4C+dSj/eOPwrUaYL+Qu+UaooQc19ECl0RIQzfniJWbG+WvxEV0M=
X-Gm-Gg: AYBFou35u5Bt2nDpzc0PNfIq50ruV9C6xmhFsXsoYts0NDofmqhMVsd5H7X0ti/mkSy
	vTcR5bQ8pFzJlpqqAVJKfm6EzpCjh0qP9iCdj1TVHXjrL7qXcNj0QwkMs6dzCpkv4ntfqrrevng
	H/JlLeJehXKtn0jeNDeLiAeCADbI33oZE5GTawUJoEJ18NMaGL3nDdbf6nH+gpTpWjmziypqJlm
	9pmyDzimR1XkbhYLPxncfHONa98uP94HDbyGrsgjBBzwFJp2lwzIYTWbcZgW/paxMluKbhl6zRE
	fG0RHKWQg2Lmri6ybgdvftUR7jBqcIZm6DOb3NGQ3PwSn/jfZrxLmhvKMfkwrfG8IAtI/7NDhaP
	7d7V9eG1DFUExwl/1XGcmGEIVGjPagCYGscxwEdlCrEr0rhfD2zUA77d30y6DEwjKOnr1/fApld
	u+70MvNb+OBjKOqTYwDZ1zWqirix6Zfn7bY4VuO1VChZE1zmVjZWxns1lAWcCewCKffOiwLXh13
	4kh/HC7JP2hMwntKfCoxgJjjz9EGIUCz2rq4A==
X-Received: by 2002:a05:6000:1863:b0:482:e6b5:61c with SMTP id ffacd0b85a97d-48587098310mr9747937f8f.8.1788536206395;
        Fri, 04 Sep 2026 08:36:46 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:89a9:fd0e:583d:4a53? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c6ba4sm7833177f8f.25.2026.09.04.08.36.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 08:36:46 -0700 (PDT)
Message-ID: <33487133-b587-42f8-9716-b0bbe2f1511b@suse.com>
Date: Fri, 4 Sep 2026 17:36:45 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] module: pull out add_taint_module() to be public
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Bradley Morgan <brads@mainlining.org>, Aleksandr Nogikh <nogikh@google.com>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-usb@vger.kernel.org,
 driver-core@lists.linux.dev, linux-trace-kernel@vger.kernel.org,
 Johan Hovold <johan@kernel.org>
References: <20260904-bind_taint-v3-0-30025465f38a@linuxfoundation.org>
 <20260904-bind_taint-v3-1-30025465f38a@linuxfoundation.org>
 <a79a6a06-cc48-4036-882d-95e9b4cc01cf@suse.com>
 <2026090432-outlying-glitch-9295@gregkh>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <2026090432-outlying-glitch-9295@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/4/26 2:19 PM, Greg Kroah-Hartman wrote:
> On Fri, Sep 04, 2026 at 11:25:01AM +0200, Petr Pavlu wrote:
>> On 9/4/26 7:10 AM, Greg Kroah-Hartman wrote:
>>> diff --git a/kernel/module/main.c b/kernel/module/main.c
>>> index d0e1e0bd2ad0..444d990c9983 100644
>>> --- a/kernel/module/main.c
>>> +++ b/kernel/module/main.c
>>> @@ -191,11 +191,21 @@ static inline int strong_try_module_get(struct module *mod)
>>>  		return -ENOENT;
>>>  }
>>>  
>>> -static inline void add_taint_module(struct module *mod, unsigned flag,
>>> -				    enum lockdep_ok lockdep_ok)
>>> +/**
>>> + * add_taint_module: add a taint flag if not already set for a specific module
>>> + * @mod: pointer to the module that caused the problem
>>> + * @flag: one of the TAINT_* constants.
>>> + * @lockdep_ok: whether lock debugging is still OK.
>>> + *
>>> + * If something bad has gone wrong, you'll want @lockdebug_ok = false, but for
>>> + * some noteworthy-but-not-corrupting cases, it can be set to true.
>>
>> Nit: The final paragraph is mostly copied from the description of
>> add_taint() but I don't think it is quite right. The parameter name
>> should be lockdep_ok, not lockdebug_ok and the values are
>> LOCKDEP_STILL_OK / LOCKDEP_NOW_UNRELIABLE, not true / false.
>>
>> I suggest updating this part for both add_taint() and add_taint_module()
>> to something like:
>>
>>  * Use @lockdep_ok = LOCKDEP_NOW_UNRELIABLE if something serious has gone wrong.
>>  * For noteworthy but non-corrupting cases, use LOCKDEP_STILL_OK instead.
> 
> How about I add another patch to the series that fixes up the
> documentation for both functions?  They both should be fixed up and I
> might as well get them in sync properly.

Makes sense to me.

-- 
Thanks,
Petr
