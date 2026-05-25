Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDBC30E84B
	for <linux-modules@vger.kernel.org>; Mon, 25 May 2026 09:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779700200; cv=none; b=XaNXOSyzfDfzgvkPv2GFXUmuSseZk8uEDcuaRzF1RQWpz3T2cWgqulv8lXU0VPSm5LL42WR5U17J7KXPmjDXKDW9Uz1t5uN64Zah9thxe4TkkD0ayVFqlVA4EuReQnemjc2yj/yO+qYStLZlFlP4gcoVoJJhvfaRTqN+DuBWezU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779700200; c=relaxed/simple;
	bh=s1o8rPuKOK0mvDPXUGlimWNxmX2G9fMMtffeCke829Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=usVG0q3glL7dsF+BPUMFZf54A1tvzS4qs/v+1L+lz8/2GuX6+Ke5+3IW/KAqy/r0iv/hMOncpy5qLf3r8gwpEE3riuNY7re0bok8QW70AkQQASb021GEX+TJ6lEQWcKkYuqZPsmERNwqFiSraQE04kN1wNgSnkAlS1684p7boPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KTXSGOwH; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KTXSGOwH"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so69338395e9.0
        for <linux-modules@vger.kernel.org>; Mon, 25 May 2026 02:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779700197; x=1780304997; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G+qYWwqDH4Z0PJGC/K7SSgMve7keIPR/MKwl9QyQQyM=;
        b=KTXSGOwHtb6KCFkgtGI4L04M6625dCidOcP5hGq2jtqUA5FDgVWnhSGQKakpxnYqDt
         +/H/xmKoIiuaKUZoxS6kTFIg7KtavH7Pd0h5QiPVK2sXfnaB6PA9lKHo4CxPseI95y6t
         ZVtkNePjSqC5BFA8j0mDE5I7hnOBO+LkDICgK0/tWx0n55frMHtrPJix+YCJJ9QAgjH/
         zfaez3aXk+/7ozQZ3oJsVsV8yz8yQDjotMEsLFF+Zeak4H8Hq47b2JjV2QUtETvHoccB
         9nyZrVV2/ziKyxcMQ2YCjj2Se0A7Tme094TIn7Vmbivozzksa7pHTFF4F9/+VwBAbxJg
         NlSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779700197; x=1780304997;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G+qYWwqDH4Z0PJGC/K7SSgMve7keIPR/MKwl9QyQQyM=;
        b=OuuJ7NeR19XWiTma0XukcrnW1k8tRKLNFj9EQjWD7dHjx7E0hzfXBGZvokjQNQ4zJZ
         HuUJA5ZxVNJdjZ7zaGXG0lhb5NckmRG+Jwo+1MVWMM+NlzQDUgRBuERL1GvVUew0OsAd
         DXZ+FBrpDmqevlrpiiHOE/jrRGk8oc+jyCzjHgtpiqOKg8y6zlvyeSuaaC32E+MfowgZ
         IFMbGDCyKj4oU0QH4gCSswvQQyLPz/YAAdV9K493AeqcU5JW73e6cucLGmJcc2sKJWla
         xBScOqZrC57qykmZXem5HA5QUorqPKsRLxnKJTLcZchBqDb8wiJ9hwHb3y06NL5/71+O
         NQYg==
X-Forwarded-Encrypted: i=1; AFNElJ/C+3xNF/PYmouHsKzNFk8Zy/xHXpDU2jVinx9+a6CQByBPsYD68mZhxIN7w/zHyxIC3M+gSV0RlJjb/vle@vger.kernel.org
X-Gm-Message-State: AOJu0YwDRRvYgYNy0scURrgBHEwd8dvT1D1wRROW5dkHEvF9PdoV1Phi
	UvwWAwvPC1QslnRwNYAtzluirZGSOFNpLPZwJExzOnT1/MppiePh06ZPRRQe98/0djs=
X-Gm-Gg: Acq92OHWLNtvaXmhfxm6MhYQfnQZ739oQ1L413HAqSnjCl3hA8j5lKD5JDb2XHyMk0M
	Yy9lpdRmXSMEY2V1w/wEmVPS/k268JOqkj3IEpHWBa0o4QFQkS71RzHUF9aC6yx8EXG0val/SGa
	w8g3Q0jIwz29z3hPS2CwHMVelQ2Ngwqk9iKeq4FCDr/7f9SfeEcYnrbY3CiwVrhHZOTJVkVauFY
	1rj+msKubx+e1FfC1WYZk9ewqlQ7Tn/Y9HtDtINDrdnSvJVv1vjmgG26BGTIz+RjF3X+AZFedGg
	a+piLzeb6BiGrsyG/EozTqtiEoeoMtxJid8UuQ9kBeWrHQU6W0icfwpKlhNaPt6ZXbKfEmLeWg/
	Z3UfMqcfz2aBfBmo2tN/QgZiJ1u3w7V1zgN9sULhBrNymjmOyMrCGJrp1YvqfBxu2BhRqlTub90
	RphiV5yqIP37ZNwKCIh5IThWXBJvNBsmojNu+E7IJHo7vINZ/SicxMX2et35NB39pRIB0wwrIbC
	fF/CYreq4r0uSGmSnFEr/6liNbvtMf6chMPsSFEZHFkJ2PpNJX9fCS1GwTj1rwpaudQAQ==
X-Received: by 2002:a05:600c:8484:b0:490:3c94:a3c6 with SMTP id 5b1f17b1804b1-490428e205cmr229760445e9.26.1779700197074;
        Mon, 25 May 2026 02:09:57 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49059fb42dasm120369045e9.7.2026.05.25.02.09.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 02:09:56 -0700 (PDT)
Message-ID: <26c47a0e-7a9b-473a-818d-455e68476dd1@suse.com>
Date: Mon, 25 May 2026 11:09:56 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] genksyms: Support arm64 CRC32 hardware acceleration1~
To: Wentao Guan <guanwentao@uniontech.com>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org, masahiroy@kernel.org
References: <5d1b8b13-d590-497d-9185-609494135348@suse.com>
 <20260525080229.1570905-1-guanwentao@uniontech.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260525080229.1570905-1-guanwentao@uniontech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/25/26 10:02 AM, Wentao Guan wrote:
>> Additionally, many distributions already switched to gendwarfksyms last
>> year. Unless someone provides a good reason to keep genksyms around,
>> I expect it will be deprecated soon and eventually removed. It would be
>> more valuable to show whether the same optimization is worthwhile for
>> gendwarfksyms.
> I see gendwarfksyms use crc32 from <zlib.h>, which from zlib1g-dev and zlib1g.

Ah, I forgot about this, so gendwarfksyms should already be well
optimized. I think that is the most important thing.

-- 
Thanks,
Petr
