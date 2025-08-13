Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415B32F3C05
	for <linux-modules@vger.kernel.org>; Wed, 13 Aug 2025 11:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755085370; cv=none; b=c74UqmgOQQuxbHs4hiuL+87wiZ3dCKqGim3mMgFSlIqCIrsjhkIJHbkFd6XzrduUipXrwNPPEJqH082cnYEE2y47bVVbmKJfnQ3XKNBgXQMf/gUbUYrO3lGHbrxEAe6wfH2L8SPo9XM54IJAbinPb09Xfco5+lJNmttlaEiY3a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755085370; c=relaxed/simple;
	bh=X7U+mjFH3gmS1vRftuxVLMIOTLTXZCBjm/MT4N3gEuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wmm28W5xjmzBlkA5LDVd4SXDtWmxBtik7pydZFsTj7c9ZzhzvHo2Dy5AdpqSg9ZqmX/nyZJ0HjOMAE74jtDoWF+bl3yPvpLZojY+IhzDG51H1bVb0sFbORWWoApzCyIHcwiXMwsXE7apl/x+J7lKrK5oGCZVoAiWWbBE4vSZMEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=R+QtCxW9; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="R+QtCxW9"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b7825e2775so5922036f8f.2
        for <linux-modules@vger.kernel.org>; Wed, 13 Aug 2025 04:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755085366; x=1755690166; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aTo7s378Kcf6UuSFAtVXg7XgG7my/qL2nbdzH+wimf8=;
        b=R+QtCxW9o3ZQsYC16n0Q7pOU+pVjRG3iTLR+uK7myKq2Ze9NL1m12LRJbehwg24eXX
         7JTfJiVIl5C6GZK2Mb3Yl8OPyovg2yedICpBFfEHBNusWvb1JRA/6+qfrUcT0UX2zRmL
         smT2hs7k5eP3F9eDoBztBk7h+JeXaG5gKY5uRQYBqBMW9td62LULBXrodu331NNixT+p
         AkdGIbwzXIupQnI3M82ESbZNvWn3HmjP+wsCFKJDs6ZLfXq1PE7IyztcXRAel+fahSpi
         i+nXVYRoxrJ3UJyBIB73orVBqdsxVE13o4X3NZrU5I/Mzszb1puvcABU+SKzDAIJNYWf
         zLTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755085366; x=1755690166;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aTo7s378Kcf6UuSFAtVXg7XgG7my/qL2nbdzH+wimf8=;
        b=JYHmu737xgQaZi9LTYj+UvMxmt6N29N5tPswvX/6gIz/Sq3oESEzUqrh+8FLPGOD7D
         KuWNd9NLQtz3syAKbzBwm7wvYreF2vh03u5rBCXiVv7UkZdi+5fITDFls3GNRuHzCs3i
         OaprOqPNh4X3zlaI82r2UHev8WH+qClsw7vnzbn+Vkvghk8rxsjqL7LwDasFES0gME8I
         e4Ufu5C8cxxMv4q2LYVoacmIWvzE6WkHnJM7fKtLctY37wvcnNhIAl4VFZJbc6SCw1Or
         /Aq9w66fKW4aXWAAeopcPG7nfycr/x4SKrTgL53oyw/l+xdHEjBnqGLs9FOc/ivXBYhT
         liYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLbR/vh8puDbsht7b3YkpDsLVbI7E3u6y1i7YV4gsrGhwif2VSVLsr9TrMAjMC0eBTdev+BaQItjSGJedA@vger.kernel.org
X-Gm-Message-State: AOJu0YzNs1iJH/leDmXGdI4Y/AS2jyTdiwexKGKPAH133CW9motB3vQe
	04gsZGvZL7Zvw3JYrMGXvePOoCpvNyjn+8BmW57mlEQQETJ/1PstpvU7vZabDnnZmhFoAaODgpD
	kPMXR
X-Gm-Gg: ASbGncsPzAbO8t850ErISNJMK2HmuH/viL92rd6eSVTEfZXeidJZ/Pg/EXahGasPpPJ
	zW33mSHta4TNvTqxSM8Yv3ttCojh9hy6WIXMBDALrLvaQwFZUpv5WYXNOuytfX3oEJ6TbcKBQsx
	E+IcPa0x0XUcXcFUj2e/E+51NZOJTyijeoLIX70bbf38i0nWsQFrlPKNtp+DtGfL6LZrmw+Wcv9
	vTOoM1OjUMmVC0C6Zr1a/aZvMmrRZEooiErObqgrzC4dWy5pZaBkD8yVrHd24ptDDv64PC9O2fc
	Jf+cplVJmwgyjAU/IgnOY9FxNanaVO2y6Q1ctGc1ZzSO6jB1xFk2boObT9VWo6o4drj65jeRrp1
	yc9RPGiJmQr36Gbr8HSvyqo+Yo/iWc2fkXgBSuUCwnWA=
X-Google-Smtp-Source: AGHT+IEEcwZO9dERKhXqxNNV3ptLVu6kRq96H/stbNfOwPybl4evUuT0V+47uqfXsIc4PEZUdJ7tdA==
X-Received: by 2002:a05:6000:4282:b0:3b7:8412:4540 with SMTP id ffacd0b85a97d-3b917eaebcdmr2106980f8f.27.1755085366500;
        Wed, 13 Aug 2025 04:42:46 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef8204sm324578415ad.34.2025.08.13.04.42.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 04:42:46 -0700 (PDT)
Message-ID: <f0a77c72-8fad-4fc5-9198-2a9c7c97a489@suse.com>
Date: Wed, 13 Aug 2025 13:42:39 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] params: Replace deprecated strcpy() with strscpy()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Shyam Saini <shyamsaini@linux.microsoft.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Dmitry Antipov <dmantipov@yandex.ru>,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org
References: <20250810214456.2236-1-thorsten.blum@linux.dev>
 <5d334a1f-0dbd-4e25-bbc5-b01aca369385@suse.com>
 <F640B308-C8C4-439B-8217-98FFC10BB76B@linux.dev>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <F640B308-C8C4-439B-8217-98FFC10BB76B@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/13/25 11:33 AM, Thorsten Blum wrote:
> Hi Petr,
> 
> On 13. Aug 2025, at 10:59, Petr Pavlu wrote:
>> Since the code already calculated the length of val and that it fits
>> into kps->string, is there any advantage (or disadvantage) to using
>> strscpy() over memcpy()?
> 
> strscpy() guarantees that the destination buffer 'kps->string' is always
> NUL-terminated, even if the source 'val' is not. memcpy() just copies
> the bytes as they are.
> 
> If it were guaranteed that 'val' is always NUL-terminated, memcpy()
> would be fine too, but since param_set_copystring() is exported, we
> probably can't make that assumption.

The function param_set_copystring() checks using
'strnlen(val, kps->maxlen) == kps->maxlen' if val contains NUL in the
first kps->maxlen bytes. It can use memcpy() instead of strscpy() to
avoid repeating this work.

-- Petr
