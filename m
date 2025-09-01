Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD4530BB87
	for <linux-modules@vger.kernel.org>; Mon,  1 Sep 2025 09:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756719251; cv=none; b=a0hywwWL34Nyeux60NGeG0tmA/JDMdsXFs/XdSAi7e2mIPXNBCyugNmY1KzzE7Cj2NKWVdq8w2PPiy957lEyexnEgqFYadNajjfEF44n7TIlnxspRehbanUPl4M4dlJ/1XbnKA+y8wDPEcxc0p1Id0XvQVRwkhoBb0Ne0qggkfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756719251; c=relaxed/simple;
	bh=GuDLxhxkpxUrJF0zaAYoCSBFOVzvpSqpOZRoh7Feu5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=irRfte5wdcjGHMxNWOorZ80YpEh5iwFPReWuYkmJHMG2JH10sUcGZ3vdAgDxuyTlah54t48ISTJkjiSJQTLb/YKoZ9E+aPLnd1PlJBwpBCYAdDX7FNWM7J9QbQ8UKl00gYR0rlSvZmUedEGPW+Jhiua4S200rpEQWh94/lpaHV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=X3GoD57z; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="X3GoD57z"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45b7da4101fso10055985e9.3
        for <linux-modules@vger.kernel.org>; Mon, 01 Sep 2025 02:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756719247; x=1757324047; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3yK7qoa0SBXqccrleO0ZiLm7b34YGW1LnytieNZ12nU=;
        b=X3GoD57zboSXhysbQ4WLRXld9DZN0bhTWZ1iN735FGUV1tTvUyqX5gJMzvj+yPRQ8b
         dKxYCHYtREG11SiAGao9DyRzIqoS+whvhtZvWqGDsC6BM2sj8Az3UUrr1uZqodEgHjdN
         T6dvIz8Xf3cT7YW3HQidSdbRNw94Q4QZYizlLSSNHCjrlazGC9GSbTA4ShDT0Mt0NL48
         Yad97wfSTMsqLqbQ0c4BJmLfUIaMswbPkqD/p1+0ey+Xfy2aIm8fO8/K9IXfkiDvFgLp
         ep1GKhfZfD2pweWPGWiQ27DXhuv4u76Rc2ePNwryJKfQurzQ29+HZD0DVeCNJx3r/LS7
         MaXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756719247; x=1757324047;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3yK7qoa0SBXqccrleO0ZiLm7b34YGW1LnytieNZ12nU=;
        b=sHWE2OamY2s1ngMQB0mdr+/tQS6+zdiXzRXzYsrmxthRIeNbSOX2SMPWcBYaszyfHq
         0GE8vDbIRxuXoR5aV4SXp0tjgBmQoe3goEGbwdKejI4324PMHkMi4rdR8tZrFst16/Rs
         VkxkR31skFpYv4CTl+9UpBVxCe3JcTVYG6I0tPOyyZBS4pwkD6bbtfYZJhX5B3240jv+
         NJwka3B+eTmC+PsdujbwZecnp1RuwyCjULKefY7g1tb5KgzZjCiexDbnFG+Vbi1+xE3m
         LbKgSAqYdqszKPR87IabbpzUTid+b/e1AQ6rXDHiiaCTqBPAhvwQof/KcFlMYTnME67r
         U1tA==
X-Forwarded-Encrypted: i=1; AJvYcCXuhqe00+GJaKEg/x5KpKF5/q3r3EBmDdn29iL6KaImOZH2VMiJQsH+YFQ3yJO7g4iHk+iO8trdzkE/1JWm@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1EVTc7y09y6dR/BZC4W/rqN0xWnTWqZqOjs9v2rZV8AxRNRDN
	Fb13regQiSe4ntXJJQCAsJ8B0XzMM+Nk3R3uH9knqfE89HDo1v0KRmUNuNWyXaVOPcQ=
X-Gm-Gg: ASbGncunnkMut+f/tmLnAYBwFxLloAfcQ4DsGBvrPbTs0biFJe/SJInwaTQ3Ypt0ixR
	GN5L6q50Qbt314QBgd0WJcriT5MaaDZGmihTW7HjTDmLXufnQ38skLK2PPCSrS2T+z7GMQYnCDp
	bR2W55CAfvYtrhu+1bOzv/AqEILm50VXuw0gNy1F/KaTVOGjMl6XvXtTG3wPXdayzbKl3euL0Jt
	hFqYGKEh/ZWdkF1b/aNB2M+5Ei+pCyeRjZcW8JbwkdnoAUnm/SnX2XSQH0bImYxKm3Fh41COgLl
	A57hEPR/1nEG4HVihl4HJDI6cLsX7en4AYCL4+OQhAb9RMC57M5O4DnfR7berTpsURoxfrIZgCH
	00ozVt3c+HtGzEoY9i/hNAzACPUtxO52+U6+WtLSo6Z8=
X-Google-Smtp-Source: AGHT+IFMdrsS+cI/EkOu1sec3q2m/EBe3g4qDLbZmrgtH+8JAW+UKFNhDhaZyh3huGcLSAsClTBY8w==
X-Received: by 2002:a05:600c:3111:b0:45b:8c5e:5f8 with SMTP id 5b1f17b1804b1-45b8f43c876mr10235375e9.28.1756719247418;
        Mon, 01 Sep 2025 02:34:07 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf33fbb3ccsm14628150f8f.51.2025.09.01.02.34.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 02:34:07 -0700 (PDT)
Message-ID: <919b4262-37aa-4cde-a2dd-ebdf553178f4@suse.com>
Date: Mon, 1 Sep 2025 11:34:06 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] module: separate vermagic and livepatch checks
To: Jinchao Wang <wangjinchao600@gmail.com>
References: <20250829084927.156676-1-wangjinchao600@gmail.com>
 <20250829084927.156676-5-wangjinchao600@gmail.com>
Content-Language: en-US
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250829084927.156676-5-wangjinchao600@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/29/25 10:49 AM, Jinchao Wang wrote:
> Rename check_modinfo() to check_modinfo_vermagic() to clarify it only
> checks vermagic compatibility.
> 
> Move livepatch check to happen after vermagic check in early_mod_check(),
> creating proper separation of concerns.
> No functional changes, just clearer code organization.
> 
> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr
