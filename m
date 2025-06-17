Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827F728C2A3
	for <linux-modules@vger.kernel.org>; Tue, 17 Jun 2025 07:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750146294; cv=none; b=V1+MA9AwqAAvCWho7LHYEFS83+Vsd2ky5aHRhsiOY+CaTrpBYvuexYM50opfXyCgXy5n0TIxgu/h1X8BldiOOuxXycvPoIDz7Qjn2JnrpcyDsdqN9zFTEzFWZ7u6qIgjj68qI78h91W02Sh4mHocr0HuUGXBKx/ux2o38xaWfw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750146294; c=relaxed/simple;
	bh=mrm9OvjabzG4ehnGWZbOBKsIPmkYF4NA6I7pS1JLPj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q5OnJCD8qaL7C23F7hdJiP3PrpgKEVavYd1ITIfslhxVJTN1988MsEsAlQM35ytqDZhmb6s3wKjd2+mQ3ajH3E9RPPy02mzqvxBNMomU/lhMQlZ0XXFGXwTNobipbXYowP0JUsAG9lZkuEnsohvQ2+yBSrl23bOcW5IObZB0DKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AP9dpqG3; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AP9dpqG3"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-451e2f0d9c2so4267995e9.1
        for <linux-modules@vger.kernel.org>; Tue, 17 Jun 2025 00:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750146291; x=1750751091; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m2PZPtZXiD/pv22zShXPiBng+Z7Vv94EbItbn+tfTVw=;
        b=AP9dpqG3rRuNzZLOlpQqsz3GBQuA+fBi0dAQJrTqN76W9Nnw2RMdTYfK9Q5cFI1buu
         N8ggVHG6gRYnRGw61EW/0LfKlON4oqytAv9je72mPqgs4iX5ri1VDACrSF4LRkJAVJYC
         7/PCqxz1DoNFi7gsxe2gB3KDWw0UnUe22vai/jvOMnGClOeJyV4tNAZOZ12ybtz2fZrM
         ibiWrCgcewz+DPaNbKzGhDPdjua7uk7gJo9+lin+0xr6RUWuZQhEvrusqbusbfdGUM0M
         g7AAEXOmkJrYNoMwSVBb/A8wytOFsnGAjkSigU0yC7Rm3BiY60S4WNilMKC/mWlCI4p0
         e3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750146291; x=1750751091;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m2PZPtZXiD/pv22zShXPiBng+Z7Vv94EbItbn+tfTVw=;
        b=UO2Rb1zBjWMj/yi4AVLMYHja6X9UTHzW4MspDrglj2oYx6yks53R6nzxxI3buqxlhu
         VYdBRmFX8YHW4IOsxhwWApweTRF4fXIqWyATyunvIf82tArMuhB82HlaUJnZw64dIUSu
         eR/S8qCVogl9ER3t5YemrP4Pdnm9zbzAlwjD+ZvF35kXT/b5s+hZQTiJ9YRqbEkoA59i
         ZVjt/Nea8IHsV3NQRrxwynkV7MBEYmkeY3YPkgbLMEZ4Q2DDd0JJHiQjYbSnDHXpVHwk
         UM28Mf90uue7jOgXJPngU9r8TjwJhBD1LlRS0CvUoNiu+9L/ro1XQktuqymbdiIznbeL
         OWxg==
X-Forwarded-Encrypted: i=1; AJvYcCXj6OjC72oY7kFEe5EG8qyZ24dgIBOewiRflFsaNRPJ8+Vm3cP5tSCMWfShHroP5+DzInEugnoW92IKrpTf@vger.kernel.org
X-Gm-Message-State: AOJu0YxKqMqyAFujbBq5OZvp2hxlvn7oEfi9CbcKQ9QaKTjMftK1rAot
	6lQbV1yrLGc5KBh9Sf3HjMIGUNPW8fLHytXhA2Fnqbj34wiviW8clINhkcIc4TXO8Uc=
X-Gm-Gg: ASbGnct0ZuqpkC2jBhpOihHurjF1D+xq03Qk/rxa8EndjhnRwY39tpJhTP98pDc/EEV
	rY3et5Vss6frCmNXXPhmp6dau9IV7cZXHvX/BQXYjs4MMdils10qHFxJAvpEeyZ6BCsJrM7rC8W
	Pg8FItcvvCF6oaePZoxyr946SjIYAYT3eVhAWWr0YS6s1IlOTT7f7MUfCpfzRCwTay5WDbqGMTU
	4OvYbQkzfZ6A4/fU/+HOVTASy9qnRZ/LTYNIafM/zpeSSAvsbCagGBCoJoAFxm1z+jPZ1rVCrPT
	41WzywPderXfXxzuaXOCTN72vnT4m5LniA01qHN6U/uG/4DtbX+/i5mOCZmPzzwJAw5Jg10FgQR
	T
X-Google-Smtp-Source: AGHT+IGLrB0zawXGR//1I7qhDmE02rezk4o0VJxdGCMaX/Yej/wVeBEiSTFkvWU979RCy9khYyBucw==
X-Received: by 2002:a05:600c:1797:b0:43c:f3e1:a729 with SMTP id 5b1f17b1804b1-4533b27e8e6mr84371805e9.12.1750146290758;
        Tue, 17 Jun 2025 00:44:50 -0700 (PDT)
Received: from [10.100.51.209] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e195768sm167991085e9.0.2025.06.17.00.44.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 00:44:50 -0700 (PDT)
Message-ID: <fb2a41b2-a872-4fcd-8a97-df3a946c6a81@suse.com>
Date: Tue, 17 Jun 2025 09:44:49 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] kunit: test: Drop CONFIG_MODULE ifdeffery
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
References: <20250612-kunit-ifdef-modules-v1-0-fdccd42dcff8@linutronix.de>
 <20250612-kunit-ifdef-modules-v1-3-fdccd42dcff8@linutronix.de>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250612-kunit-ifdef-modules-v1-3-fdccd42dcff8@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/12/25 4:53 PM, Thomas Weißschuh wrote:
> The function stubs exposed by module.h allow the code to compile properly
> without the ifdeffery. The generated object code stays the same, as the
> compiler can optimize away all the dead code.
> As the code is still typechecked developer errors can be detected faster.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

I'm worried that patches #2 and #3 make the code harder to understand
because they hide what is compiled and when.

Normally, '#ifdef CONFIG_XYZ' or IS_ENABLED(CONFIG_XYZ) directly
surrounds functionality that should be conditional. This makes it clear
what is used and when.

The patches obscure whether, for instance, kunit_module_notify() in
lib/kunit/test.c is actually used and present in the resulting binary
behind several steps. Understanding its usage requires tracing the code
from kunit_module_notify() to the definition of kunit_mod_nb, then to
the register_module_notifier() call, and finally depends on an ifdef in
another file, include/linux/module.h.

Is this really better? Are there places where this pattern is already
used? Does it actually help in practice, considering that CONFIG_MODULES
is enabled in most cases?

-- 
Thanks,
Petr
