Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FCF3F12D1
	for <linux-modules@vger.kernel.org>; Thu,  9 Jul 2026 08:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783586239; cv=none; b=RU1E7agU+ioUi/d8G/5Ol8NFXFb1yo6KSzZ8RidNxu8KHJxt5hrb8XkScIryOoB7DpNIib5E9g4DXwHumhXO4MFvKkAhn3jTeygbD5eDudWUfmeDiNNzvcAyhctLVA2cjr50QaVH+9k1OPikf6MVCOmyLWDwYIwdvA2sQjrFPvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783586239; c=relaxed/simple;
	bh=QtNVbnuLcaqQIXQ/zUhLE7g/Rc0EgNfdFtNEobKEkb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q6r5QyGEe7JGphoEWqnLmMmjV4USF07wwcjWEf3Ft5kgFkwX4GkwqJBhcrReoUTduHNcEoGbJ3t6B5UD1a7dycy7Ut2Sq6XQ7fXPhZNZkT1ugodnDCUPv+RSJDM5yl/U5HLCWXbnzgLWMtvZQZuXvouDLlG0C5czMrfOMFVf9Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EBPET0W3; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EBPET0W3"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493bc8fda98so11540365e9.0
        for <linux-modules@vger.kernel.org>; Thu, 09 Jul 2026 01:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783586236; x=1784191036; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2XF0Xb3j55AMyU+xdM5p/6YTtdUfJz5XJ/AYrd6MEIU=;
        b=EBPET0W36A9UE4ojwwzdzNPepWriJRuyWvkqUCrg2Bng5BZZ0AFOnLdcD2lTOyBMH4
         w6BT3nJZ31IliCMLcIyPlwap7x00EMPdLUBtxyy2k5gJO+LF/husfylie01cZHQRujk1
         ZkMvQ0EAtnC7a1RSw/QdvPbmg4ed8t7t/VE6jxAykZvNTjQMpxyy84WvffUQEGNdSx0l
         jrM3408Y9V+wCQ2YlVIb87UGYcH3lECkGRZ/jaBYk2IDs8duNsKbkpkIy3JYih8KbdsI
         EVQJSxAvAgsZPaqPMZHvRe9FUNrZmZyleu9myvF5cbjiR7Nse2MZYJQAmF4nXqmRDBXO
         BB2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783586236; x=1784191036;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2XF0Xb3j55AMyU+xdM5p/6YTtdUfJz5XJ/AYrd6MEIU=;
        b=aYSq+jN7Tx3Dgw3AaMMq74Y4vekUVoWP3opR04fcG0SC1zY+bhKSpsxV1SlMYvlJVl
         Ee63e5HKPHkC5g7ABllAL/yYTWIuukbnyVe553KcUstg7RbVwzokImOSDZXWOuoJYail
         LAdbzSGCAdHplRWaN/5MnN8QIS5kCUq54D684NTpKuNkYsdnEERq1HVOT7m/q1/K2puj
         QD7pFt3W6U/WGHh8MNGFIZZLnV3SWignvQl7xx/xlMHLiyZb8jdvlUNpGBfzQjkusuYT
         B9oQfhUXWErHjVtASX7dJhgpdr+gsohWNEc4/j/um97ALKbO512VhG5JG9AAdLHxXj+j
         vwkw==
X-Forwarded-Encrypted: i=1; AHgh+Rpn00nlygY/KN0FJ+s09+U+R8xJCqlkOj/Wfbo/vgX2JfKDBB9NEMQt8Mnyep/fnkeHxcZAYmXeYmdeMrSQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3S0qujHshHHig7l80tV+DnAe6HiTvmfObJnso0rkwubxgHbgn
	RDE6QNsqiUXVLQdqgEXboch2S8svbM25y7+fPk9Sy8fdk1c//505oFCpRLknGTRIies=
X-Gm-Gg: AfdE7ckSOKezux0/yafnv0jEG90gkuJTgyR86m5Gd26wgC0Z9b+PQMb7CF6t6xHyfKC
	AVh+DHNdqYtYHwGWJ+JNSzOXjmFES30q0akkJi84EtzDQSgYrN3HWbKK0myADM9A8IBlSTPKRx4
	aXHLFG+OFlmDp48Y32Ex/Df5Mt2QKqb643m1U7GH2N0fWij1edTih2EmKjhR0SsVdgvXxcuGQmz
	POhzUV1+j8MyumS5kzq6xX83jBHGqspJrECVdzQXgh7EZZ8FBZJdQZxfTrnwskntSU/hOW9WQl2
	AHBXHHuYE6WLyOpSRQLE6EvAgA7gRuTEHTEcl9thjaMpZxb6mcE0IupMSGkuxlyGp8g1EzxlEIa
	Qd8ZwPRlQtobmv3yDU22hLXveS7Wt51HUhsEvHbyjYqw+RYayhTckHilMsCghLxHHQ/EQ2ov7uY
	YhT/yidRFynNf6F2tLGnFAC9tHrEOBF+aO0A==
X-Received: by 2002:a05:600c:8a1a:10b0:493:b646:dc2f with SMTP id 5b1f17b1804b1-493e689fd8cmr44935165e9.13.1783586236372;
        Thu, 09 Jul 2026 01:37:16 -0700 (PDT)
Received: from [192.168.42.79] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f21328sm50396081f8f.32.2026.07.09.01.37.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 01:37:15 -0700 (PDT)
Message-ID: <226dfc41-33bc-46bb-a5eb-a72ea9a7b645@suse.com>
Date: Thu, 9 Jul 2026 10:37:15 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] module: use strscpy() to copy module names in stats
 and dup tracking
To: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
Cc: mcgrof@kernel.org, da.gomez@kernel.org, samitolvanen@google.com,
 atomlin@atomlin.com, linux-modules@vger.kernel.org
References: <slebbzn7p6c4ybokolvey2sgvrooit66zjewwggqac2755ujgp@ptanmtdclmw5>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <slebbzn7p6c4ybokolvey2sgvrooit66zjewwggqac2755ujgp@ptanmtdclmw5>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/4/26 7:45 PM, Naveen Kumar Chaudhary wrote:
> Both try_add_failed_module() and kmod_dup_request_exists_wait() use
> memcpy() with strlen() to copy module names into fixed-size
> char[MODULE_NAME_LEN] buffers. Neither performs a bounds check on the
> copy. Current callers always pass names originating from
> mod->name (itself char[MODULE_NAME_LEN]), so this is not exploitable
> today. However both functions accept a plain const char * with no
> documented length contract, making them latent buffer overflows if a
> future caller passes a longer string.
> 
> Replace memcpy() with strscpy() in both sites, which bounds the copy
> to MODULE_NAME_LEN and always NUL-terminates.
> 
> Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>

Queued on modules-next for v7.3-rc1.

-- 
Thanks,
Petr
