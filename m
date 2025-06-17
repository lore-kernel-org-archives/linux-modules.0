Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FA6293B53
	for <linux-modules@vger.kernel.org>; Tue, 17 Jun 2025 09:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750152463; cv=none; b=NdeU0aXtCPl2EX/U2lhnGPe/9hTbD/9laDO5u8nvUWUQcYZpzi3S+sjcMugCMUIoN3W/Kd1ZYMLezJ0b+yle2pBfA3e7i7s2TMU8krxrbvECHRbfTgqqaPKllY+6GpcAA9UaLQk6t3QpB+Q/FSu8wynQxA749ku0zM7TMOiNLH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750152463; c=relaxed/simple;
	bh=f3FXbCp1zJT2e/y37zile6+NsyCTyyggM8rYqlTqvGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rA8SAbl6sP4b9m2cI4o9+cqS9EWzuk9SaJxb+pUeWRmtd8jowGoKVy7NLBAY3ZhvnAIFdFk80lp7SWF4mizyYlyvBSrj7YUrMaLdJERt1fReE7f8XaPeLbSIPPSv0r0Tf4ZKrzrnJ4c755Fcueqqh2ffylBDFuzevlenTotZ0Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HfaFhXWh; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HfaFhXWh"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-3a536ecbf6fso3660430f8f.2
        for <linux-modules@vger.kernel.org>; Tue, 17 Jun 2025 02:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750152460; x=1750757260; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=boN3t4QQQ5CJaq9F2B9aIVemxFll5K0ZGpv67UpOwpI=;
        b=HfaFhXWhDA6c/ysVVOaYkIshY6amQ6jMyyRlRTgXilO33yD0L5Gwt70j+8+S5hy7f9
         FCKkZrirayOh2DCyT5oll6krNLYGAIBPl5gpc7bSxOdkIYntMGrmw2ioqWPswjXk2kRB
         LpfJv/Cn1f4Uk8SNPEok7e3hzUVmeND3FP5mawsihpE9f3GiwOAw22ENxnCWtWoZGS/8
         of/6VYb+E8tKheFtFsy0XOXrvHLfuusuv7+we0mqDAPMtekgoAaUVUNuGNDzHGR4rMHt
         CKC9mMRca3gsL1G88cpDB9JHJxl1v6ve/WpzGqDFruJVLqUlg7OqrnnK9R5S0L5P4SU7
         FXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750152460; x=1750757260;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=boN3t4QQQ5CJaq9F2B9aIVemxFll5K0ZGpv67UpOwpI=;
        b=MN2l6KSJLwrn1jirn/9BITFtmQwh9G5Xn/H2eNtSENAtoJh5BTVdy/8+XTEiAZ49Vq
         XBJrviTK/Fnadi/28rFRf7Q6KDKLHNN5KPfLYFmTjCwcNVf16m4dI8Iw41AnCE2CECIO
         AdH5i/nG4yK9hKtMGLJhxrZLh5/tRCGB3F8s0IQaN63/LzOpz5Cv+e6o+sZwbVAiy/As
         9mAUEOp+T4ckO2zZxvwRfgvgNlB9y/FrqzZdt5DvwQyPkCBWaiyR4C5VTXDAvKTDa969
         JICaZ0IV+3R/qoRtyDsMpKcqcis5/7Bw2SG+VpSgPtM6niW0CVeQmRV5O8Q1ZSLKSn+I
         n4OA==
X-Forwarded-Encrypted: i=1; AJvYcCV1fZYNQYQbMJ+cNx0rPyPvA/MWAlKiJtwjmHw17CyhEwdqQo4I9yFSov1L0qTqaLQJ2vH+PBtf0KFuZ8hU@vger.kernel.org
X-Gm-Message-State: AOJu0YwpxfC3YI4kGtO2retEkgynblP6WXoHqSKaqpJMQNm4I+ZXmrnz
	I/qQH4jyM4bhi9vx2ys2nLqP/aDvRRMzVdZN/41LNVZN414qioUGY4BFMYSAOzRpg2Ojw1KbaoI
	tJ45IFa6E+Ez0
X-Gm-Gg: ASbGnctxrRsBn8o8KxLn5//Vz7O5F4bzT5OxE/7UpCo2oi1CZjnKnYNLtuLWpc4xZhh
	Xfe74dwSFBd3z5TciAMqYGEO3Y7MLs8pc6YkzGE9z1HSfQxHsls/cA+R2WNfcar2MU9q9/JQuL0
	gJpsNcUUfKlOEFxwqJcI0Vco2lkUefmoN98+UYUlzqY8Gtq26FIk+0ndlAhVTOAiaepJ0pJ1rfF
	nwNsPh7OFINUJy9c37aBwc4zArvnyGraWdwxXgGtfplmAVo3p44XbY+dBkPo5RISYTbNn7Of12j
	C/tKkj3q97OHFjKWNOT5+ejHHauG9jWXbV7fOdWCFCf6AAlijM96/O4rc7WlKhXPhQ==
X-Google-Smtp-Source: AGHT+IFM9Lj5qJWTtP6+l5n+/04TRA1i4YBOucx2CbKedvvZJIa35JF0Mqa14giJEb7sodnjrvIhwA==
X-Received: by 2002:a05:6000:708:b0:3a5:5278:e635 with SMTP id ffacd0b85a97d-3a572367577mr9469207f8f.3.1750152460099;
        Tue, 17 Jun 2025 02:27:40 -0700 (PDT)
Received: from [10.100.51.209] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b18f96sm13555006f8f.66.2025.06.17.02.27.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 02:27:39 -0700 (PDT)
Message-ID: <2cd3947a-63d9-4a79-a24a-eb1ae8164169@suse.com>
Date: Tue, 17 Jun 2025 11:27:39 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] alloc_tag: remove empty module tag section
To: Casey Chen <cachen@purestorage.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-arch@vger.kernel.org, surenb@google.com, kent.overstreet@linux.dev,
 arnd@arndb.de, mcgrof@kernel.org, pasha.tatashin@soleen.com,
 yzhong@purestorage.com
References: <20250610162258.324645-1-cachen@purestorage.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250610162258.324645-1-cachen@purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/10/25 6:22 PM, Casey Chen wrote:
> The empty MOD_CODETAG_SECTIONS() macro added an incomplete .data
> section in module linker script, which caused symbol lookup tools
> like gdb to misinterpret symbol addresses e.g., __ib_process_cq
> incorrectly mapping to unrelated functions like below.
> 
>   (gdb) disas __ib_process_cq
>   Dump of assembler code for function trace_event_fields_cq_schedule:
> 
> Removing the empty section restores proper symbol resolution and
> layout, ensuring .data placement behaves as expected.

The patch looks ok me, but I'm somewhat confused about the problem.
I think a linker should not add an empty output section if it doesn't
contain anything, or if .data actually contains something then the extra
dummy definition should be also harmless?

This also reminds me of my previous related fix "codetag: Avoid unused
alloc_tags sections/symbols" [1] which fell through the cracks. I can
rebase it on top of this patch.

[1] https://lore.kernel.org/all/20250313143002.9118-1-petr.pavlu@suse.com/

-- 
Thanks,
Petr
