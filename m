Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F90128031D
	for <linux-modules@vger.kernel.org>; Tue, 30 Dec 2025 12:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767098495; cv=none; b=ucPIKOJRpVNZrkamgRLI5pM0kvhuQaySZ7eB7bspTBcJtHdEHCVWhDyUnXD538rhi3fwS/SaDBZxbXn26YFX99ruJw/TN3ULsYyzxVNyyrHBsUssd5pEi5CyBGj/kkXEF6j779UiNHdf0iY+4HjvMDQe9JGFlY6gWHxVhe5gKJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767098495; c=relaxed/simple;
	bh=95UjQqrFVvDaAggf01I5Uh6sXulEVNrPuCcBOQMEolI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RE7Gb0kpLojEQ6tehTNh4Z4/Cv2gMCR4Pwilq45WEFKWlhNS4zuEgpP/b1lr+w1GL36Z4daWgxIijGP0uLFVup0P27MT5tBhj1jFGTu1H8n/nNE4Qcd93yA5mVHn89R1QBpZ1kNU/pOw7Mek4T+/0iv5t3TiPr1yXIsh0nVedpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dNS4pL90; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dNS4pL90"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47a95efd2ceso89863675e9.2
        for <linux-modules@vger.kernel.org>; Tue, 30 Dec 2025 04:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767098492; x=1767703292; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GLMHDAkBFbz2fegdpxqXp81Kc/luuCmmPKmYMWEf3jk=;
        b=dNS4pL90bvzZS3SuaN10BSiZdAXs6EVrwghLILka+R6xkLrhNyU5NyMtv5Du9SpeeI
         W8wHhWlQJsLDruh4o90+wtk2lBIhHumtUDm0L+CQPm0mrlsBkmNlgehy+V1kleYN7fOd
         ywkfrBr9lb2wYGtbM6bAtAJu/eZDA5dKcYet1NfWDRqaZxq5pXmBo2bVJtyqoGiGyeQQ
         1rxJlqpd5S2OY98DHBog4v3xfB//aO3ezZYrz6BJ3moKvDVR2mJB/8i3WS8Echg6KV5Q
         woKyKf6YvmGUQk1aHsjVvXnoCH87Ri/IT/3t2wYrV6Hl8rtPOMz8OG4O9Dg8tAQkG1EL
         XZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767098492; x=1767703292;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GLMHDAkBFbz2fegdpxqXp81Kc/luuCmmPKmYMWEf3jk=;
        b=LB7YR1/ZXivcRKK0/7PUGTOKBdaogGwMZDMUXSeeSAQRrqFWv1Tfol9pNPcUf0ueie
         dEYG+sWVI5joHGgya9Kh6JfcFntAVxHoENxw5mST6xFixJvqR+8OpPokVKdQM/tvM7Re
         b2S0K+XGvDWORSGP85wn74ympjy35kiw+NcEAScZu0dDEPGP3p6kWlupu19rWYwQymKd
         L1nIyt0JdsawDpG/dvKKaTWEXr89v3N75bT253mywRj6j4L1bH+oBZJNfi3/O3Iixwhk
         geyEiPrpO2WRzcVDhV+kLnjclcnly6J+gUPDVyMuPkIxJ+u8B7Tr3WMgPYnb3n9pjE9/
         8Ykw==
X-Forwarded-Encrypted: i=1; AJvYcCWyUMjJW9Xp6hwUQiZ8S1crvWaBnyngy5mgodYLUrGxdM3NrXKD8nlABcgmHz4RirSLe5DTU8RvhbH1fGrW@vger.kernel.org
X-Gm-Message-State: AOJu0Yzixfc4t6XatRGreUxL3q5XAGybpQpk00n2+fYXHmr/pt01qSlF
	0lqrxr2ADGC+arYu8R8d4GMY0Q2BveAlxazOhyeuXRiryQ7FmntKJU9GLHw9ymHJdp0=
X-Gm-Gg: AY/fxX7VN2a9uUbQNmZ+kSdzl/o3i6EdvB7f8AYF68RtRQPIyGjTiCSICZUZI5hXLUx
	LjABOCEVuUsEAWMO8JgJT4t/xz9lQVB7L+smjca9p1JnU7+0MKA3tglhEpyiaz2wqMsmEVWvFP6
	1f8wqLLrWXis4Rh46ufmgzLtTtDVK6W9437RxfWmfGswbF971zSsLHMK2bTYGfhlT5rGeWMeXKF
	VnS/9CiTVtmpfQ2Sau/NNuemOmFuuSdl0RvuGuu2C9kXiuMYTuKsdVQEcj6HEI84OecnatugbWO
	qJYCQBNI3PCan4tz0uI16W3wnyzaGDXo5ALaTe1XFJXa5IcHs9+rCTPuwxwBXS7LT5WlT4hmfcu
	hAi0fKfl+EDPx+RhsS0FXbhHUJEdVbGskgXR9Uv8k5e4YT2DbQBB7PcZUBBtQFB+sYOSNXdcuak
	1vYXtdu5WiEgRuGQL5cepeZuDaNuhwv/Ua+0W5l1m5Dr+9d/eS/Q0=
X-Google-Smtp-Source: AGHT+IGW4l1DxRVB8m+ItlGHN+6ap8mjehe8ozMWe13Kg0E5z+nekfUu+byTtuQhyrDZ6An6C0WEYg==
X-Received: by 2002:a05:600c:3b0e:b0:477:b0b9:3129 with SMTP id 5b1f17b1804b1-47d1955b7d1mr379930345e9.3.1767098491667;
        Tue, 30 Dec 2025 04:41:31 -0800 (PST)
Received: from [10.0.1.22] (109-81-1-107.rct.o2.cz. [109.81.1.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3a40a14sm278790645e9.2.2025.12.30.04.41.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Dec 2025 04:41:31 -0800 (PST)
Message-ID: <971b1fd7-5702-4cf7-ba84-aedde0296449@suse.com>
Date: Tue, 30 Dec 2025 13:41:30 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module: show module version directly in print_modules()
To: Yafang Shao <laoar.shao@gmail.com>
Cc: mcgrof@kernel.org, da.gomez@kernel.org, samitolvanen@google.com,
 atomlin@atomlin.com, linux-modules@vger.kernel.org
References: <20251229024556.25946-1-laoar.shao@gmail.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20251229024556.25946-1-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/29/25 3:45 AM, Yafang Shao wrote:
> We maintain a vmcore analysis script on each server that automatically
> parses /var/crash/XXXX/vmcore-dmesg.txt to categorize vmcores. This helps
> us save considerable effort by avoiding analysis of known bugs.
> 
> For vmcores triggered by a driver bug, the system calls print_modules() to
> list the loaded modules. However, print_modules() does not output module
> version information. Across a large fleet of servers, there are often many
> different module versions running simultaneously, and we need to know which
> driver version caused a given vmcore.
> 
> Currently, the only reliable way to obtain the module version associated
> with a vmcore is to analyze the /var/crash/XXXX/vmcore file itself—an
> operation that is resource-intensive. Therefore, we propose printing the
> driver version directly in the log, which is far more efficient.
> 
> - Before this patch
> 
>   Modules linked in: xfs nvidia-535.274.02(PO) nvme_core-1.0 mlx_compat(O)
>   Unloaded tainted modules: nvidia_peermem(PO):1
> 
> - After this patch
> 
>   Modules linked in: xfs nvidia(PO) nvme_core mlx_compat(O)
>   Unloaded tainted modules: nvidia_peermem(PO):1
I feel that module versions are not particularly useful for in-tree
modules nowadays. They rarely change and therefore provide little
information about what code is actually running.

This is supported by their limited use in the kernel. In v6.19-rc3,
I see the following:

$ git grep '^MODULE_LICENSE(.*);$' | wc -l
12481
$ git grep '^MODULE_VERSION(.*);$' | wc -l
605

Moreover, in the event of a crash, the log should contain the kernel
version and usually also the vmlinux build ID, which should provide
enough information to identify in-tree modules.

However, based on the example in your patch description, it seems to me
that your main interest is likely in identifying external modules. If
that is correct, I see why it might be helpful to quickly identify their
versions. This assumes that developers of external modules actually
update MODULE_VERSION() in their releases, but I don't know if this is
generally true.

As mentioned, most in-tree modules do not specify an explicit version,
so in terms of bloating the information about loaded modules, the patch
should have minimal impact in practice. Alternatively, the version
information could be printed only for external modules.

-- 
Thanks,
Petr
