Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08803D4131
	for <linux-modules@vger.kernel.org>; Mon, 25 May 2026 07:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779695411; cv=none; b=CzQ8govfLIoJhmNl3CIVTXk9e7uDFJ0yRcWjibsZ/GtLEr9c3a4XVtQRrGM8Exq7r7gDub6Fr5CeMuU6NrtgYZWzgxNJAy1UfbjkRm40+vMzVNAaoyNwAuB1Xi9sc3cTLI9PJsbEVxAVUgnd/nra6aIZtXjyk0EaZV6wGKs+CNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779695411; c=relaxed/simple;
	bh=NR8ERBteiNpEvT/i3MkwfQhIOdqEBtmpkWicvVoDvSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NFko0cI1bl+v+LjrYuoWyyBaq5thqdxwiVVJktjodVy5KVbdOsrDesz6WBFLHerKAHgYL0uJhALrYnTK2kjEVkomF4I6WUa0DklAxxoSGANLz9BqOO/Gh+T8WexgS50fsTAKgbYNJz/llyOQeseUhgHGvel32swvRGtBdu/TKgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JATo0DsK; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JATo0DsK"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-44a044cb827so6940708f8f.0
        for <linux-modules@vger.kernel.org>; Mon, 25 May 2026 00:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779695408; x=1780300208; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PoBZmEEKJgwumlmFRTQvrYGlkjtr/HeYrTo4cMXpiV0=;
        b=JATo0DsKUAIwiaib334nnvCZvfCMDNZfB/zXSFLAtU2RuUxxOUe4vb+ypPbpcCpjfj
         lC9aW1xMFrdczvsLF8Zw2hdPHXsMFh2AOFnhGllgmyahxo9FLCPExKoOW7oYNK5ey6jY
         Bs8Iq9wQjANHSan6nRaH8e+mb10duHfhD32Iey1+BN3WdOTrjKIzzjsiH5i/kufnUUrv
         i4uMYy63SS2AkhtSBeM9q5VhS2iWHpMMaRYPClcIp/jwGRDmGFd95sjEArDVuvHi0CxA
         LIOVwIwj+pHZqz+QNEzg7ZvxcvKENS0/WntYoVwrrkR9XT6UdQiXeOdYJVA5KeYi9SsL
         7FmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779695408; x=1780300208;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PoBZmEEKJgwumlmFRTQvrYGlkjtr/HeYrTo4cMXpiV0=;
        b=hwvyqMtV+7EslIKYr9lvfaaQZDvDWz03r//+N8weRangP2wpiZiOtNdD98JH28pVjN
         jxA3TRegb1JWxT81LxMgDcZp+dRulY/fsEIguybcl5KcHjFCca2boSIhmbgzNx1RKNBl
         nlc61mYhvrsldCFgzy5NJSsWse7BT05VaER9u7Tntl85zbZ/XImOGjv0YjRu5+7s07Uu
         9T5/GM7n47f7L+G7yD4+rjdHRvSJfvxsnSsB0lQmzJ7UAZ+sotX4ZPXRmCkowFkVAgB/
         EghjW2yNSw7YWvxbeh0cs1KTr2+141Tjh0471JxoI8p+ndRPDt+HvFdVnnVMIqPYm/mx
         1A3w==
X-Forwarded-Encrypted: i=1; AFNElJ8bN3JbUUIuOiQ6DXlZ01lDvQ2Hk/pB++QJ1Ho8F84iG2kyrQMdLCZjGggrB84VjRifsluq/3fXOIeM9/2A@vger.kernel.org
X-Gm-Message-State: AOJu0YxvZOHo0iVOPyuA5IYjfhKwTYRgFfK2/i8N3C1N81sdHIOnm5/r
	mbsBJACTpWYCZSw5L5zJFTbmlqImyyHZ3OhHiOFjJTjFQ6DCYir7Lh/UrxD2gQToH+0=
X-Gm-Gg: Acq92OFMZNPr9kLybSD76DMi/D5yqmyKdi/dlieSmrrYxpS8idSxDAPl3ncIIUgogWx
	4xcCUgudpSZHwi66tNTdd/tp20jJxnhgCZyW14/63hU3zxeU+kBHAMAKEl3c6SvS6oMgk5AVEvx
	HoAXdcnloYyJb/qq6I++wlHmKtjmPG0352Z1ZtAdYb7543m7zmdrcX1vdlOwvLfrw+wEXuYPJWb
	SuOZ4qvBKku6Qlwo3u9PoLjAGN6L8t709lmLUEr8hBTeTdTJS8tXuPFDkVKRMLIYJZAaWtAJSJ1
	xNexmLyvXtn+EIRM4eEJDtzuPRngLYxdke9caGc65fExFv4HcHEuMfTCYLMeNwpqBl18tOArLPm
	EheSRfh069ghvCi+4TXFxXR6zJsJaQ7e4ezD6Z/uvzeyGSvK4Avk6abBlJu7HzuGvMjRCuZkHx5
	K0G1Y1onvXqJ71e3NlgxPtx00iPQ1FCZwq3XRUH4dlqCRHqDVfoLjd1hHBO8ga0I0bF/ebwYowF
	ryBJ7ApZU4Bo3U14b/Fc3lZqTy3Qcfidn1r7AVfzsAnwgxdutvNZEw0s2d0ZEOePwPhCQ==
X-Received: by 2002:a05:6000:1882:b0:43d:7d24:b4ff with SMTP id ffacd0b85a97d-45eb38a80b5mr18489748f8f.40.1779695407785;
        Mon, 25 May 2026 00:50:07 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6c9ba2esm26039629f8f.8.2026.05.25.00.50.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 00:50:07 -0700 (PDT)
Message-ID: <5d1b8b13-d590-497d-9185-609494135348@suse.com>
Date: Mon, 25 May 2026 09:50:06 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] genksyms: Support arm64 CRC32 hardware acceleration
To: Wentao Guan <guanwentao@uniontech.com>
Cc: masahiroy@kernel.org, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-modules@vger.kernel.org
References: <20260525070344.1564886-1-guanwentao@uniontech.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260525070344.1564886-1-guanwentao@uniontech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

+Cc: kbuild, modules

On 5/25/26 9:03 AM, Wentao Guan wrote:
> Use hardware 'crc32b' to partial_crc32_one() when support,
> it shows 2x speed up than crctab32 way.
> 
> I think it will be scaled to more architecture.

Could you please provide measurements showing how this improves the
runtime of genksyms and affects the overall kernel build time? Are
CRC calculations actually a hot path in genksyms? I don't think it is
worth complicating the genksyms code with architecture-specific
optimizations unless there is a clear benefit.

Additionally, many distributions already switched to gendwarfksyms last
year. Unless someone provides a good reason to keep genksyms around,
I expect it will be deprecated soon and eventually removed. It would be
more valuable to show whether the same optimization is worthwhile for
gendwarfksyms.

-- 
Thanks,
Petr

> 
> Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
> ---
> changelog:
> 1. remove change in partial_crc32(),
> for partial_crc32_one() already use crc32b.
> 
> ---
> ---
>  scripts/genksyms/genksyms.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/scripts/genksyms/genksyms.c b/scripts/genksyms/genksyms.c
> index 83e48670c2fcf..80b7797c842aa 100644
> --- a/scripts/genksyms/genksyms.c
> +++ b/scripts/genksyms/genksyms.c
> @@ -116,8 +116,40 @@ static const uint32_t crctab32[] = {
>  	0x2d02ef8dU
>  };
>  
> +/*
> + * Architecture-specific CRC32 hardware acceleration.
> + */
> +static int crc32_hw_available;
> +
> +#ifdef __aarch64__
> +#include <sys/auxv.h>
> +#include <asm/hwcap.h>
> +
> +static void crc32_check_hw(void)
> +{
> +	crc32_hw_available = (getauxval(AT_HWCAP) & HWCAP_CRC32) != 0;
> +}
> +
> +static inline uint32_t crc32_hw_byte(uint8_t c, uint32_t crc)
> +{
> +	asm volatile(".arch_extension crc\n\t"
> +				"crc32b %w0, %w0, %w1" : "+r"(crc) : "r"(c));
> +	return crc;
> +}
> +
> +#else
> +static void crc32_check_hw(void)
> +{
> +	crc32_hw_available = 0;
> +}
> +#endif
> +
>  static uint32_t partial_crc32_one(uint8_t c, uint32_t crc)
>  {
> +#if defined(__aarch64__)
> +	if (__builtin_expect(crc32_hw_available, 0))
> +		return crc32_hw_byte(c, crc);
> +#endif
>  	return crctab32[(crc ^ c) & 0xff] ^ (crc >> 8);
>  }
>  
> @@ -740,6 +772,8 @@ int main(int argc, char **argv)
>  	FILE *dumpfile = NULL, *ref_file = NULL;
>  	int o;
>  
> +	crc32_check_hw();
> +
>  	struct option long_opts[] = {
>  		{"debug", 0, 0, 'd'},
>  		{"warnings", 0, 0, 'w'},
