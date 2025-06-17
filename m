Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1ACD1E2602
	for <linux-modules@vger.kernel.org>; Tue, 17 Jun 2025 15:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750172858; cv=none; b=myujr1h8TO9VJ+bddQtEgN9AO+rW0UkOch4rVEVYIa3J1H86jNxrykTI0cxZ6q8zaqM+SQRkZ2rlq+X21LTAJuJq9O2WY1kwV2K1MhMieiInc9ZYwxfJSy0f669i0bxov3ssavDshy5KBlEPBnSBRjAcBe12xSmENkcmaJv5J7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750172858; c=relaxed/simple;
	bh=pf3mbNNCBaoa+Q8rkyFdnWm1f//ZilqgGf8nwGrFL50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YaviwAWGCd8EqGeIn0dbdlQyYufFtUwCqfqFWC2dRZ4pXr4S5ndivcNwC3SJKu8aReOC3zdkSohlwZ4hoeGDURIiK8e39vfu8x5NziCvPEokOyso3uPcaReJIfXiAncT7Y7qSAcW9021FOVn3Z+tHuHL1Iq7pY7NxpbC6Yktfyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ry/r1+nq; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ry/r1+nq"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4531e146a24so36125155e9.0
        for <linux-modules@vger.kernel.org>; Tue, 17 Jun 2025 08:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750172855; x=1750777655; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ILCJmIUaqb1ZxYNljoCiDSpEgRAkdZcWul2gnHHS/uI=;
        b=Ry/r1+nqtYhFYjET2QNPM+jFZ2M3klU41N2rEBOX6Nab9gdsoOCQ9cHeo3gW4Snm2f
         N0jQrtv/y/DNMyLmUw6LdiLG2wMAkPUwOeVeY5MStpiWqae1JLz0JRugS7zgiVVnChUu
         +nfoeGOmgSWWOJ36zRiYhfhIx2e1dFZiWYgRiJKPWl1UmXF9yEY4HJeW/AJkcDsOIe7W
         fBLfjf1xLzgF/vdmesx3WcEq4rp9nOrcZIUWI6eWv50W5V1sWtGgv+jatJmodTLoaVC0
         9b4LYDGQn47p4134GVoR1CdEaCExHgqcoEKZ2vexU3r3GaJUCd+pA398K6hxOi+bjacn
         wnQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750172855; x=1750777655;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ILCJmIUaqb1ZxYNljoCiDSpEgRAkdZcWul2gnHHS/uI=;
        b=L3fnUXO/Xi6qYSdUq8xDrx8fIn+fZSMUYu0PV5gV1RWcUI2etQJYBysxQQgVEhI9VZ
         7iw2JF5AFXl40pg794jU1aR9gvk4Ubj3jbtbuHB/xmmPiegOArWxOOf1+d1XEnZCQzss
         mIFx98VPZtcNgK+SG/x1ZC15G2MZMfgYpUbsURzCaI8vitR3si68n/uMSGb4UOr/aoZB
         IlWKivaIHutTUkELo4LxCAxCmzJs5iwTq4jQI06gLGOZDc/sta/5j4PHvYd/1sYxsyHe
         XYcyjyEgMjUfGlagHW3o6bRJu5DB0Uo61Fg3zoangOUC1Mboq4V0lBuGfra35llVVQY4
         yQ8A==
X-Forwarded-Encrypted: i=1; AJvYcCW3F0cN9+zha6oJwHX0ixFxfZbz4B+Nsjrh6CiXOnb1Doo0HzxlBMuqhoRLhcS8O4BCGm44LZ9ntIMhHSt0@vger.kernel.org
X-Gm-Message-State: AOJu0YzyebeqAarVAG1jqqSEyqhxwzb0FCZtw6WQvbWmytdyyX7/UHjv
	ddkbVcCNMg34Iwz676KoTpXM7AzKyyoU+Z8y5EEm5IH/UKp7rLATvsLmB/Gnvx188vA=
X-Gm-Gg: ASbGnctUiD6zqwRuxa82xyefWPEtTCPnrJ9nJA2bif4sm3eTQ0rb7ETC/6PxuQPRKw6
	0BSp9LR75IypeEyF23yNQsYZIq88ejqcP8gcuLxs9DYsDjWigvulu7c0VTrLI5GLh5kqOrQXdES
	u1W1k7TJZruK/wwe0dLzRnJ8s+IaKb17K68Ihgn96zMYObLB2UIErqnOh3LhiUWYU4IOZCXp+Zw
	cJCU6Pz18f4/jZ+alrW78Q7o9FC5JEyqUcg3T6+9hzvpCjN8PhYqZTdB/axrbyqiYcquS2zkD/H
	sMJS6b06HkFALKMr8IkaD4asTVJSaudbwe9Iv6JZMR11jI4PzKz2Ml9OfVaRAxnkxXLBeikeEFP
	f
X-Google-Smtp-Source: AGHT+IFvJAhymz+MlrW7YQcbajgL5kYk/RtK6I3q6YaocDMYQM4Sy3QB0kS30GlFXiWwssZmFhkdPg==
X-Received: by 2002:a05:600c:a07:b0:453:99f:b1b0 with SMTP id 5b1f17b1804b1-4533caa5c1fmr112862035e9.20.1750172854807;
        Tue, 17 Jun 2025 08:07:34 -0700 (PDT)
Received: from [10.100.51.209] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532dea1cc5sm183871865e9.16.2025.06.17.08.07.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 08:07:34 -0700 (PDT)
Message-ID: <1f175340-d109-41c2-be1e-1c5261f9e0d9@suse.com>
Date: Tue, 17 Jun 2025 17:07:33 +0200
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
 <fb2a41b2-a872-4fcd-8a97-df3a946c6a81@suse.com>
 <20250617095936-50d985a4-ea18-49cf-9d16-dfd0dd0b627f@linutronix.de>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250617095936-50d985a4-ea18-49cf-9d16-dfd0dd0b627f@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/17/25 10:39 AM, Thomas Weißschuh wrote:
> On Tue, Jun 17, 2025 at 09:44:49AM +0200, Petr Pavlu wrote:
>> On 6/12/25 4:53 PM, Thomas Weißschuh wrote:
>>> The function stubs exposed by module.h allow the code to compile properly
>>> without the ifdeffery. The generated object code stays the same, as the
>>> compiler can optimize away all the dead code.
>>> As the code is still typechecked developer errors can be detected faster.
>>>
>>> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
>>
>> I'm worried that patches #2 and #3 make the code harder to understand
>> because they hide what is compiled and when.
>>
>> Normally, '#ifdef CONFIG_XYZ' or IS_ENABLED(CONFIG_XYZ) directly
>> surrounds functionality that should be conditional. This makes it clear
>> what is used and when.
> 
> #ifdef is discouraged in C files and IS_ENABLED(CONFIG_MODULES) does not work
> (here) without patch #2.
> 
>> The patches obscure whether, for instance, kunit_module_notify() in
>> lib/kunit/test.c is actually used and present in the resulting binary
>> behind several steps. Understanding its usage requires tracing the code
>> from kunit_module_notify() to the definition of kunit_mod_nb, then to
>> the register_module_notifier() call, and finally depends on an ifdef in
>> another file, include/linux/module.h.
> 
> I agree that it is not completely clear what will end up in the binary.
> On the other hand we can program the happy path and the compiler will take care
> of all the corner cases.
> We could add an "if (IS_ENABLED(CONFIG_MODULES))" which does not really change
> anything but would be clearer to read.
> 
>> Is this really better? Are there places where this pattern is already
>> used? Does it actually help in practice, considering that CONFIG_MODULES
>> is enabled in most cases?
> 
> This came up for me when refactoring some KUnit internal code.
> I used "kunit.py run" (which uses CONFIG_MODULES=n) to test my changes.
> But some callers of changed functions were not updated and this wasn't reported.

I see.

> 
> The stub functions are a standard pattern and already implemented by module.h.

Stub functions are ok, I have no concerns about that pattern.

> I have not found a header which hides structure definitions.

It seems you're right. I think that makes patch #2 acceptable, it is
consistent with other kernel code.

> 
> Documentation/process/coding-style.rst:
> 
> 	21) Conditional Compilation
> 	---------------------------
> 
> 	Wherever possible, don't use preprocessor conditionals (#if, #ifdef) in .c
> 	files; doing so makes code harder to read and logic harder to follow.  Instead,
> 	use such conditionals in a header file defining functions for use in those .c
> 	files, providing no-op stub versions in the #else case, and then call those
> 	functions unconditionally from .c files.  The compiler will avoid generating
> 	any code for the stub calls, producing identical results, but the logic will
> 	remain easy to follow.
> 
> I should add the documentation reference to patch #2.

This part discusses stub functions. I feel patch #3 stretches the
intention of the coding style described here. As discussed, the patch
somewhat hides when the functions are actually used, which might not be
desirable, but I'll leave it to the kunit folks to decide what they
prefer.

-- 
Thanks,
Petr
