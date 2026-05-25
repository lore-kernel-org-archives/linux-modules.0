Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42772BF3D7
	for <linux-modules@vger.kernel.org>; Mon, 25 May 2026 17:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779730397; cv=none; b=HcEhjhJtd1kzwT71p6IP98XIhDcjHv21wPyfFju7VHyusoMOZrUq+LAPXL23gWzGcS0wQ8M6lTaa9ubd5bVrFr829K1CgWJcaq0JmUyYlFBX/KzWKkUD895CULqMMoqPbs4A+MJymnStEse03Kd/e2ys5R91MyFnOf5U6apjPc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779730397; c=relaxed/simple;
	bh=KS4jzXcYEGWyhvQcyiid+k+SW44m4Tzp76dkHlQp0vc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=StACW5+/NfPJaJujqAvJvfkTnpoCpoElcRp4EJp5NM7u66cWLln4DiayOkGmFSvV5cOj7TtXuFgYu30U0I3kbuMO7zk4IwyPYIpapYcCF5dy1FwsOURPty5RhxARsSNwe4OOGSuO3XI0Y1R5VM6is/EztTvCCg5tW+VExHtlYrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EwMekC7i; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EwMekC7i"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490388fd0dbso41710845e9.0
        for <linux-modules@vger.kernel.org>; Mon, 25 May 2026 10:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779730394; x=1780335194; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ke3902//gigT30lDRSKJbeulpB5AsGLO9vF808ols74=;
        b=EwMekC7iNvhGWbs6+8J1AnlXa+qE4hswY+dZQjQGPGUlb7tnhG+gB9RrN1V412Vbjq
         PVuuRzaFeCQ1wRZFaG/ZUw0h67KO022n2Q59w13GNbFk+VZ1THRkhPBMJj5PfsYw+6n+
         8Y4QA2ZUPxeb+ViqYakrSqg/WAgOaelWlEnDZTPko1U46k2JT4SZWrjOmuFDA5AO3qNZ
         GWHHPscJVxRljc0eu3UW4ZVgUUD8M8JodazqA3TwWkjTH2CDnpqjJu7FqwsOPp5iFK9U
         /0qH6xYoZqDJwh3da9U3CfK2Yfct3FioJLOsz/xD1cU2a2+CbJZr1zlJ6yBDg3O42LVk
         BQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779730394; x=1780335194;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ke3902//gigT30lDRSKJbeulpB5AsGLO9vF808ols74=;
        b=h1aJvdleo8Yl0glvGh4yo8Kj/RdcE1BlK1jczF7MVvonpzcXeoJf2qokiMoyNpI0GN
         Ph+jLfr9GcN4HEZlyGkO1xRlIBNtrmyzmrTXDCf/Po6Pjz2ADVJtpoYa0bU/4ZUc0b8e
         xyRfETwvPRjLD2ABOMZFxIKcbm61yxt6v7ThUut+HX9wOqr0So+qygW8g3Yp5pWHzhFo
         qCAIaYqnyt93fGpkmH7zcR4AjD6M1UKnqM3UnNrZE1eSFjQvfTDvR3VGQdy0BKOFDl08
         asR8eOArV7K8Tnr+z7936msY5Roj/3fae/8yx+0PPowDdjGh5PEnq7m1mWdnUI8XSYZf
         7I0Q==
X-Forwarded-Encrypted: i=1; AFNElJ9JcxZDR81Zg+mtw035dVkqvxO6NPHtbsDpW6BCRJLowowFxGU8IE/q54pKsUCfjPmZH298P6cXWZSqWYi5@vger.kernel.org
X-Gm-Message-State: AOJu0YzYZLuxtvmqpSiNs2dcr6LeK80jliTeGpPMk/Xr2SiEnPCMq5Nb
	w15SDPsI2DJPvPutcI/sVvDMc1NVXZzKvP/Mt1kRKssbdNGfXP8wwEFHi0ad2+MaSGg=
X-Gm-Gg: Acq92OEgwL5/v65vlUa9qTzbjyXQ3Q9VFurTOtic0zZVST7T0yfZuTjy4WMUGxspInf
	SH1bsO4WQRd7b3+OltszmqDwbAPM7SVcpFBqHZ6O8MNuwDUZo036XkyDStPqHJpzfQp9pkwpC2Z
	2Otg8MW7wso2zbI9Ksr8inISlM3ScMhjwmA9w9f1lehKpPCVm1CJQV1enTz073FTXK2IY6LnHqI
	qA/yi7W7Z50+88NWypHZPkBRxYWXsHDBlPLObicTNzzOYqZEAg4C9PsRVdsr1ydrUg5sMunC80u
	ed0U2pHB7OmDVy7+ybA6Y2MlSYh+abu9WmfRqmbzXPZl/TrVDCG68tp+VTg1VNfok5p23fNYh66
	ybShEPmPLdaIaMWFKFjCfvbUa8jhCYWk/kalBUfa8C+ngZticzNU/wllM1JGfLft2YM6tHQXqHm
	ewz0R2RFv8NU6rpaQAnlpfkW+ehrcAsPFgfli6/AcMHLc/7/b0UbyprPpYXRhLYxpXN1hWJ5sbX
	SVxIrS2ziWBqH0pqIJQeFA3nX1+0Np0CNZe3anP4G2UgDm3xCqKSG43vbRH6EjNsAlf601H46dW
	vh21
X-Received: by 2002:a05:600c:154d:b0:490:44eb:c1d7 with SMTP id 5b1f17b1804b1-49044ebc367mr241188825e9.30.1779730393854;
        Mon, 25 May 2026 10:33:13 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49048f70f55sm76151265e9.17.2026.05.25.10.33.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 10:33:13 -0700 (PDT)
Message-ID: <c135351a-d7cc-467b-a0c0-bea735fe850a@suse.com>
Date: Mon, 25 May 2026 19:33:12 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] genksyms: Support arm64 CRC32 hardware acceleration1~
To: Wentao Guan <guanwentao@uniontech.com>
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-modules <linux-modules@vger.kernel.org>,
 masahiroy <masahiroy@kernel.org>
References: <5d1b8b13-d590-497d-9185-609494135348@suse.com>
 <20260525080229.1570905-1-guanwentao@uniontech.com>
 <26c47a0e-7a9b-473a-818d-455e68476dd1@suse.com>
 <tencent_23032AC04EF146C803D19A6D@qq.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <tencent_23032AC04EF146C803D19A6D@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/25/26 3:41 PM, Wentao Guan wrote:
>> On 5/25/26 10:02 AM, Wentao Guan wrote:
>>>> Additionally, many distributions already switched to gendwarfksyms last
>>>> year. Unless someone provides a good reason to keep genksyms around,
>>>> I expect it will be deprecated soon and eventually removed. It would be
>>>> more valuable to show whether the same optimization is worthwhile for
>>>> gendwarfksyms.
>>> I see gendwarfksyms use crc32 from <zlib.h>, which from zlib1g-dev and zlib1g.
>>
>> Ah, I forgot about this, so gendwarfksyms should already be well
>> optimized. I think that is the most important thing.
> 
> Which way do you prefer? There are two ways now:
> 1. this work,
> 2. import zlib like gendwarfksyms and remove the huge crctab,
> but need make sure any arch do not cause performance regression?
> (Assert the user libs precompile with +crc32 is right?)
> I do some early tests show that:
> 1) zlib in x86 fast than genksym software
> 2) zlib in arm64 debian precompile slow than genksym software(crc32 not in armv8)
> 3) zlib in arm64 recompile with +crc32 same speed with genksyms hardware

I think it would be useful to first have more data showing that the CRC
calculation in genksyms is a hot path and contributes significantly to
the overall kernel build time.

-- 
Thanks,
Petr
