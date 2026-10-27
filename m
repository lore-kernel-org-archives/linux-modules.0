Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793091630;
	b=Y0Ukd+//dIqhqoHj8KnKJhx7wyeFJ2xnjHTTfaXmb1qCG3XduXRb4FXeq1dfpnX3InWx
	 RvgYQWsyycVWx+39oW2mI5AoEdr0khIHDIqsU5FgQPCoEZ7N02Ebco7dVCo7uCzzvFqJh
	 5SfhkvszV5M0U3BJr3a1VYh7vdjTQSbIGY25AvmJm537oLy3ZpPkQtbuay2NLsM3UIJKD
	 eZDQzdY7PA60niut434uPx+NKiT5TXy71rKHOhWw0H9MMz3wZjm5cv+sZ/8VVLYPK0jDE
	 xmmiEJFJjiotZBOnG6Efc07hqXi4sM0XCckyTYmF0aoJlMavAeAKGgrx4g/r4uizMvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793091630;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=9WCkf6QzTLTdkFQ4qPzTcHJh7ncWmxtj0NsBOYpx7Cs=;
	b=c0+NfrDyM5ShMjWIr1aeOLYiADJuSD8ZDvYIFbUQEFQj9SuJr1M+nEHPOadzEyxr77Zi
	 OZ0lO+gKEZApSOwgSqfDLiHFq2ESjBvXlQej0Ri8V8bJt9yoAIxqULwW2MbTdL1rjcL1T
	 v38pMhuEKwZ7CTKJbk6MFM5ZpJ1FFUCbPBFE0MYihL1UAph6KNelSxdpSb8We0tNsEOtw
	 kwP4s1inaXW6c0qquvxeXBLSdRnpLpVRqqtIUEP85IWy5pQVSq/pWvAW5PzRlUvKGnVbW
	 cDvpS0GU2ZYUTARTi4/bcIqNVcyl11OMzJH19uOKoSKzd3uWyMEYLrP3EWUtuHVTe2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Q00wVZLo;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E066606A31D
	for <linux-modules@vger.kernel.org>; Tue, 27 Oct 2026 09:00:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E066606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Q00wVZLo
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a2072b9832so4105595e9.1
        for <linux-modules@vger.kernel.org>; Tue, 27 Oct 2026 02:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1793091628; x=1793696428; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9WCkf6QzTLTdkFQ4qPzTcHJh7ncWmxtj0NsBOYpx7Cs=;
        b=Q00wVZLocYy126NOMQG7qq9WVmZmohO8+rtmzwAThGXgqrwxgbH4bTmWPDWx6dcxGR
         cd3CXr6LLPvEAr4u8b+qwWWK6gFh0pGs9etBJfXOt1hEZ1uGK3Y4YcBCXkBaW34LDUVD
         8jN143vhuaJ66M/PLHmbOsfJ/JY5AeKtG6dEP/JPtfeqJnkK5LPyvbxFFSqBNs5W711J
         62NEmRsAJY6jJgdFsOpf/emt218T1qM8oNzhcwsGb/1LHYi68ZMF96vWZFYP+5kb+iOj
         hI1ROUwAcT2tIsKXbpXhwWWVJrQo+XxV3oNQuO1zdrWYs2hYany0znrIPgyb7hZl13vm
         u/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793091628; x=1793696428;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9WCkf6QzTLTdkFQ4qPzTcHJh7ncWmxtj0NsBOYpx7Cs=;
        b=TelQDLzg3VEtvnRA20e+h0l6XAQML8S4IhJ8QTETSQtERv6GpZYnUBYwQFSSG2ovBO
         y2qtMrp9zizCZ/PAS/ioKCtsq+J21S9qoU19pCbMZalxij13vMzc3dhHzmIy7nKtwZIg
         G7QoLFe42eEdDOAfj4oMFIurwVJgCbcxQeKhQOPyAYcVIE/VcIaOTY060Kb9VkG/k66k
         oHHmZOVdGzM0dW7QG+lkbflJHDCg7XxPMyB/DrIaN6+7nYf0mv3LdMpY8Y5rPTazWQ5d
         g6/TgOxjqkTXo12G5d+AeOJQ3ClK71fZwC/guweWdMi5U8aJhHQSOix4cZcya85HobSS
         nCPQ==
X-Forwarded-Encrypted: i=1; AKwUvBy83/cxEdqY9xjdGbwxeAhHHV8kWQpZl1sPeb+VsNuJ2Ulu5EJULMc5VE0Bdo0pSGbZ1sudoizKpSFeuCyi@vger.kernel.org
X-Gm-Message-State: AFq9FYJ16x9V39tuJteAi7mQ449ZKJfS7/9YWgKvzS0iOjpe/tRRf1/H
	zdKJdisaLeAvpe5FvY5OMD8vv6CqDe2LhyN1sLKimhQiOSBjZYRWD0Fny2Uhw3jFnUs=
X-Gm-Gg: AYBFou1WEhfq2UIeUspsMv1uYIkgL/11OpWf8IubeDREhFYynKbQ4QYqdw0enbb+dVK
	KfZnaKOaDoOGVj8rtJ6DFpLNlW9hkVsZRyW0VFwh5DLZXK40qvQSyj3FMJgfpTxJ4KYQXVmn2Pl
	pntJOkSZATP/5KFln11r7Lxzy46RY7BOsKxRJncFIowrFErCvXCybY1wt6rEfj1EJO+jPQxn5UB
	OwSTlFFDmvX5ln2CUnAjRov+n9FBFQNCQho18nowqpYZBbiRRfeONiOcNUTC5fkoHB2X6APUQZ6
	XxZHOxiIQWcWch8v4TgodUBomQtbzhR/a9CwK9GFMD3pSiq3bzYo6XviFHw2XgKPvc63O2A5IVL
	BVvWOK0Hxe9xDkvSv6b+8ybM4nmUPHG8MV4Z0QHUJkN64qsEAuzllpc9nxU21WqwmyFPQQi/VWk
	sUckKeYxkhNc0kU2nRoZ/4jI7xlEJbxqbybQISEyoqGUWcL5CDPuzmIpvNWpp+sUZuGdxzpgq4V
	XpbkrDhMUPXdahp2VBO4KA8Gd93J2iuz8ErtkNUqruZhjAjcs1hUekojxxIMTqC0/xey+hD0aIK
	Rw==
X-Received: by 2002:a05:600c:34cb:b0:4a8:a341:2377 with SMTP id 5b1f17b1804b1-4a8a34123eemr7244685e9.3.1793091628213;
        Tue, 27 Oct 2026 02:00:28 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:89a9:fd0e:583d:4a53? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a359fbb725sm251375205e9.0.2026.10.27.02.00.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 02:00:27 -0700 (PDT)
Message-ID: <3e3b9652-7de5-4391-8b5d-122f00c4b585@suse.com>
Date: Tue, 27 Oct 2026 10:00:25 +0100
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/fbdev: Replace __MODULE_STRING() with __stringify()
To: Thomas Zimmermann <tzimmermann@suse.de>, Sasha Levin <sashal@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Luis Chamberlain <mcgrof@kernel.org>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>, dri-devel@lists.freedesktop.org,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261022175543.1831620-1-sashal@kernel.org>
 <2a9b1325-386b-4460-8651-13fc43dca6c6@suse.de>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <2a9b1325-386b-4460-8651-13fc43dca6c6@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/23/26 10:51 AM, Thomas Zimmermann wrote:
> Hi
> 
> Am 22.10.26 um 19:55 schrieb Sasha Levin:
>> Commit 08abfa5a161e ("drivers: Replace __MODULE_STRING() with
>> __stringify()") converted the drm_fbdev_overalloc parameter description
>> in drm_fb_helper.c ahead of the removal of __MODULE_STRING().
>>
>> Commit 6b5a66fd9f21 ("drm/fbdev: Move fbdev module parameters next to
>> module init") moved that parameter into drm_kms_helper_common.c while it
>> still used __MODULE_STRING(), so the conversion never reached the moved
>> code. drm_kms_helper_common.c is now the last user of the macro, and
>> removing the macro breaks the build with CONFIG_DRM_FBDEV_EMULATION=y:
>>
>>    drivers/gpu/drm/drm_kms_helper_common.c:46:18: error: expected ')' before '__MODULE_STRING'
>>
>> Use __stringify() instead. The parameter description is unchanged.
>>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> 
>> ---
>> This depends on 6b5a66fd9f21 in drm-next and 08abfa5a161e in
>> modules-next, both queued for 7.4. Petr plans to remove
>> __MODULE_STRING() once his conversions are in mainline, so this needs to
>> land first, either through drm-misc after 7.4-rc1 or together with the
>> removal patch.
> 
> Dave, could we put this patch directly into drm-next? It seems like this fixes a broken merge commit.
It looks like Linus took care of this. Merge commit 5b0764a53235 ("Merge
tag 'drm-next-2026-10-21' of https://gitlab.freedesktop.org/drm/kernel")
updated drivers/gpu/drm/drm_kms_helper_common.c to use __stringify()
instead of __MODULE_STRING(). The current mainline has no remaining uses of
__MODULE_STRING().

-- 
Thanks,
Petr

