Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA2A1E503C
	for <linux-modules@vger.kernel.org>; Mon, 12 May 2025 14:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747061420; cv=none; b=CTaoD+EuxDALUNVAkW2p2f7TCKPW0kgUHOxY3mqPARqvfJtGAlNTMiUz1Ug/+uo7fQHX25K1gBf0pA1MDolNZHj8brKnF+hIQG40JaShp25V4jh1ptqm5LiMISnSjtLxU1YysLNGAioI4od7VtFTh/hgzZdBAzfaj3K3RnmutRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747061420; c=relaxed/simple;
	bh=qRQcaOUpeo+w9STztCfLsnLWPkkRfSGsi9z619ONGvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hdxQbDjnF4Xg8Zbxk5eMKfVK5MImGqtWatQXnxCcvqnbhddT7z75tmfDM8DAefj6hljyEEaxOAgwWrC1Xk550a9Z8NVP0ronKwQhvT1v7GCx8/RJAvK+u/5liRPPXqyDz86tKIYpxPSY6cmhxrpCL31kZHidg4EdvNIFswLNb/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CUe3jbED; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CUe3jbED"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ad21a5466f6so618166366b.1
        for <linux-modules@vger.kernel.org>; Mon, 12 May 2025 07:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1747061417; x=1747666217; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=00F8vgPv2qdGuX6Cd8Cq3yaacUVZeZ+szyLkg5+fpw4=;
        b=CUe3jbEDkc4Y4TNfnyPpRbK+dk5tU4RdOlyekKWeW6am0rcUelpzh62wG7kr/BenpV
         wugC1SnTrNqRQ4xo+pbI7H4PV2jPcBO9REK7VoYcwQElgJDYoKzt/We93tEJDqviGrXl
         kFTdr9xn51IIffZkFsG+MfXRUHzvjm4PSIwNoFcKB8ienFcekCedw8oLyMT2x+6p23NJ
         DP9+FHjrMRUDYsHJ03U2mJGluPf/itFBVgJtmn1qO8VaB0oMP/kBlw2QMgjEXgUohi4W
         OpecpjwcQmj/GBKkl8NQHIvj44tcM7fb7Nh3F/u9D7zlQUdlwBu0IHdwjhbYRV2wZb0F
         /ilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747061417; x=1747666217;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=00F8vgPv2qdGuX6Cd8Cq3yaacUVZeZ+szyLkg5+fpw4=;
        b=aFGLjRx15aNIASQWyuLtQX4bl9tw4bwED4RjUNF3OR6MN/ds5a7CywAkltP0OZEdk/
         rb0QMw/lUZCX/vjTr78/ZueXfX84b0yEgJV9jGfsSFVXuItlq5kI1PalYBILjU7cbnOF
         D3h5oJP2Ip9Jq80L3juprITba4yhs3lI/ZFSjkCGFxqsq5MvhBLVl+Z7mi6AYOy/Stp2
         zjgsU14FZXWwIs5cSkL0VLbwGQlkJNTklw2qyjcAziIjchKxFLHB3PtbX0VgZ9iYGlI6
         wfzi21jqbzSsWSY2qt3N3mLDikaR6yyF6R3b4uY3yhKExLnfTo8BcdzB7IWguqDz9/hE
         10uw==
X-Forwarded-Encrypted: i=1; AJvYcCW9kafm2GayEO9SuS/ueiXmxUruEXnAzZNUWOSu/EusfoJIHziw7elkFxhcb8e+qu/IQow/c8/B5fgT3msL@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ7UmWoIOLk51bTGi3nu5pl5pxo5HuUHxF5fc8c7cTQGFjGnzF
	u8Jan1L2F68JYaLsR1MYVMQqMg42Sr4fkuCarUvWLbZxZvawVOVBpekt4cpRMS4=
X-Gm-Gg: ASbGncv9ttkvxkxBO0U7kJAxou0dM7N3npwUMMfuU0g5kEP3jTnQgeYIWqzMT5eq7us
	HUfn2QTm6Ny8V6qZZRjoIpvUHucDYWUCcF2Xk/z5dON/uWf6REjNmF1YfmnYhPuSbCBDw6L2mak
	bDsxm07S9gET774BboYYIQIrDuRkL8FF6D+0TMp8kflGz+kclqgARzEalf1Om2p3ajfi6tBK167
	tH6hbnMBpOoE4QtDPNVhxlDlrNV0peDZVUzu34Ivecovf2eO7zt2Si/Yp+E25cGFfBvnFB9c1k4
	XMUo4Wrv0D580tENUh9tGwMTbefHQiuyjxQN2YQ/9CVIm2uwT+MovA==
X-Google-Smtp-Source: AGHT+IEAugwrNbmdiwL9waoe9elCWs6yrSk4vexACydUYW5x12Eutr3ba2qSc5mhsZMIdM3Hq6hQ5g==
X-Received: by 2002:a17:907:7f2a:b0:ad2:52fb:e899 with SMTP id a640c23a62f3a-ad252fbeb25mr487001566b.12.1747061417129;
        Mon, 12 May 2025 07:50:17 -0700 (PDT)
Received: from [10.100.51.48] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad24677c9e1sm303738166b.88.2025.05.12.07.50.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 07:50:16 -0700 (PDT)
Message-ID: <1b80a538-aa2c-4695-a67b-f253367d91a4@suse.com>
Date: Mon, 12 May 2025 16:50:15 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] modules: Add macros to specify modinfo prefix
To: Alexey Gladkov <legion@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas.schier@linux.dev>, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org
References: <cover.1745591072.git.legion@kernel.org>
 <20250509164237.2886508-3-legion@kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250509164237.2886508-3-legion@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/9/25 18:42, Alexey Gladkov wrote:
> The __MODULE_INFO macros always use __MODULE_INFO_PREFIX. The only way
> to use a different prefix is to override __MODULE_INFO_PREFIX, which is
> not very useful.
> 
> The new macro will be used in file2alias.c to generate modalias for
> builtin modules.
> 
> Signed-off-by: Alexey Gladkov <legion@kernel.org>

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- Petr
