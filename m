Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1B81DFDB9
	for <linux-modules@vger.kernel.org>; Mon,  6 Jan 2025 19:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736192707; cv=none; b=ewlQRp86ER7tSa7k+tzSU3Qd3c169NFXJRmcpvc3Oo/vfwWlBBI+56DTGusLauc/QMwrFYD5xmaB7j8dLzi+ETYjms9uK9F/VXG5v8f2vwIys9hwAUE8DBWqSTtS4dZNrJi7EaHC+WIWivwhdEJbEQ/aRRfuHu8tgiU4MYVx7j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736192707; c=relaxed/simple;
	bh=zQ3dDNxwAVqmUONVZQGHhMKpUxfHfRjY40yicSGUeAQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=uq4MiASenpT9+NI1xOrA2woZFs/pYTPZj+TwF8BouQtN5tiR/BqEgL5wRnaC+RqygvUrsxXQsMiUazhaLzYj9KBaGc0T6Uo8x8UxVcykqgAREUTiPqMW3VbAHD4x58pRFFuE0sDp3oimzNewQw8EysXCkgUd21R9/PCKMaNOA2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PGZAwgVp; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PGZAwgVp"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43624b2d453so152576175e9.2
        for <linux-modules@vger.kernel.org>; Mon, 06 Jan 2025 11:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736192703; x=1736797503; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0aLwuHOfqts1r2RamlRiGd6YK3rscuDAhXgMPSkYQ/I=;
        b=PGZAwgVpjBrPdePP4Qwn3cWInbRollvCxbhGAXxX9UZ8jYwvfY07tNGb2PDMd1EeSg
         8D6Ohen3Ej7OrSJsU+nqkVaEnjToaDr3WZR3x+0xFF5lYWcMHyG1RD99yJpoV465Eb0W
         rc8fsNmKXOPjYds8I2NvRmvScNs1q4qO90ahjmytjMK/uwlalRv+UdIKzFbDf26xhqDD
         xp+sq9/k7lg2ZZrRleQGJGAspQXpXgBYryEfI6Gk7eDURvWTgYXlUSeD7MSbQQCuV1WV
         tS/T7oMXkbesInyGv62VqmhT2bFdg3dJh4+Jm8m+zB7PD0UcmDICYrOW2nPwOtUWWFYM
         5H/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736192703; x=1736797503;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0aLwuHOfqts1r2RamlRiGd6YK3rscuDAhXgMPSkYQ/I=;
        b=iPU2N1Z/gSRX78Kf+pk0ei4TLQ/4ijUygndHHktzHZMAoX5gqexP2m5kIkU0y6opy1
         nRTZd41+ItN2LNoX3R6Zvo9Fo1PnL9Ynp7GV0aOx035k1TOoPMg2ova0KgJ860aVkwar
         nmBYsdkp373Z5Lf/aDLhnGpI2hadWfklOBZvguMbPE1bMI8FOcqdFZcJl30W3qbdaMWH
         mKDc5vF2CCL1Z1EKOx7xOeA1rfLkWH5uw72r5UjY1FZqDczJLJfpVP4GMuk5v0OgrtjC
         K5/tpp9Lx3aRlsOKbhTl89YWkSit+UDV1LQ1gkjpW72aodfklshUmAF+7sKJBqeOMQ0C
         loLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKqOfp+mrVEu6ERfEcsNw4dC/RMAo+Q+onT27uoc7QqYNjXQT5Rd+UXgWLdvdKHTUPQ2BYarjsHwVOBoiP@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5K6batqnnoCzWJ6pwkixlHokOWHvaP7wiS3mlLzP0ZHltcOMf
	fyWExcOgj98m29wmzZJG7OBx9ul5ehd+AAB8HdE+jukpjaxOhPtA5/PaALSJUcI=
X-Gm-Gg: ASbGnctzcN7le7XpLs+RKyE8S+F3NKwTR1oRrZrjafADOf9XrxfrSssULeUDnMnwgR9
	rYxG4gsWAF62YmdPCSvP0c+tfbDvic1HEfJN9CEu1yRETcgcfekrovOLhtybmYqzjjvt5EG/Kh1
	LWWixH6lgh1JHw5T7mF1z9HpfaaDgXhOcgnGwymoT377LZJjSMtyVK25ZwvILhU2qIkCipaxVVo
	IabiV1/dg80QkjXjeCSoVwlf55BfhW2q9jxyZO58QLuo2r7ICvv2lR3hsfe
X-Google-Smtp-Source: AGHT+IH2BY0sTS8enQiAP1KtexhKyJ6/pVUM0cYmW/vvBj8QsCYf2kLQBIcE4NYHTcKNybVDe0O0QA==
X-Received: by 2002:a05:600c:3b13:b0:436:488f:4f5 with SMTP id 5b1f17b1804b1-4366864420bmr511100335e9.19.1736192702985;
        Mon, 06 Jan 2025 11:45:02 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b013a1sm614843995e9.11.2025.01.06.11.45.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 11:45:02 -0800 (PST)
Message-ID: <0530eee7-f329-4786-bea3-c9c66d5f0bed@suse.com>
Date: Mon, 6 Jan 2025 20:45:01 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ROX allocations broke livepatch for modules since 6.13-rc1
From: Petr Pavlu <petr.pavlu@suse.com>
To: rppt@kernel.org, akpm@linux-foundation.org
Cc: =?UTF-8?Q?Marek_Ma=C5=9Blanka?= <mmaslanka@google.com>,
 mcgrof@kernel.org, regressions@lists.linux.dev,
 linux-modules@vger.kernel.org, linux-mm@kvack.org,
 live-patching@vger.kernel.org, joe.lawrence@redhat.com, jpoimboe@kernel.org,
 pmladek@suse.com
References: <CAGcaFA2hdThQV6mjD_1_U+GNHThv84+MQvMWLgEuX+LVbAyDxg@mail.gmail.com>
 <c37395e2-1ab5-4175-9920-5144cf60e25e@suse.com>
Content-Language: en-US
In-Reply-To: <c37395e2-1ab5-4175-9920-5144cf60e25e@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/5/25 15:51, Petr Pavlu wrote:
> On 12/30/24 01:09, Marek Maślanka wrote:
>> Hi Mike and others,
>>
>> I discovered that the patch "[v7,4/8] module: prepare to handle ROX allocations
>> for text" has disrupted livepatch functionality. Specifically, this occurs when
>> livepatch is prepared to patch a kernel module and when the livepatch module
>> contains a "special" relocation section named
>> ".klp.rela.<MODULE_NAME>.<SECTION_NAME>" to access local symbols.
> 
> Thank you for the report. It is possible for me to reproduce the issue
> on my system. An annoying part is to create the
> .klp.rela.<objname>.<secname> data, for which I eventually used one
> floating variant of klp-convert [1]. To hit the problem, <objname> must
> point to an object that is different from vmlinux. Such relocations are
> processed by the livepatch code later than regular module relocations,
> as you pointed out after mod->rw_copy is already reset.
> 
> I think the bug should be addressed in principle by Mike's recently
> posted rework of the feature [2] but unfortunately, its current version
> makes my system also unbootable [3].

A simpler fix could be:

diff --git a/include/linux/module.h b/include/linux/module.h
index 94acbacdcdf1..b3a643435357 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -773,7 +773,8 @@ void *__module_writable_address(struct module *mod, void *loc);
 
 static inline void *module_writable_address(struct module *mod, void *loc)
 {
-	if (!IS_ENABLED(CONFIG_ARCH_HAS_EXECMEM_ROX) || !mod)
+	if (!IS_ENABLED(CONFIG_ARCH_HAS_EXECMEM_ROX) || !mod ||
+	    mod->state != MODULE_STATE_UNFORMED)
 		return loc;
 	return __module_writable_address(mod, loc);
 }

Hm, is it expected that Mike's rework to drop rw_copy will make it into
6.13 or should I properly post this minimal fix for review?

-- 
Thanks,
Petr
