Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D62313E2D
	for <linux-modules@vger.kernel.org>; Tue, 16 Dec 2025 08:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765875471; cv=none; b=dRmNqvDfFxQtLk6pQ1SIAT1EdB1QAugGZdprmFluam+ND/YwvD0vWOmVOtblZvKrMIlAQCKAQI6JfMP+1T/KY9OKCMw4d0raWdO916jLX1fMa+zuEcNHmWpWVr/3RL20urmZGefguD0Te58nkXnryjQFQiiVNzCyYfusWvMbtJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765875471; c=relaxed/simple;
	bh=X+XYBQa3q8jynRoCNw7ZJKTmmADQNeO3n8pFxlrVVxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N/dhoYU8MxYqgAZulONMi2KrawdyB01E0CegMPJSVnw5WyGQabJiZ49thmm9wEU9fhXo4eUt3br1buaNUojijOtmQhcrLhqs+moN0fdFuTKlBsh8DM3SUahWw19r96N6fvXm0p7I3XsKVKknYxcQh/G+HOYw/a+MDDK7RHkY9Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=O50eXj3V; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="O50eXj3V"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-477b91680f8so42615325e9.0
        for <linux-modules@vger.kernel.org>; Tue, 16 Dec 2025 00:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765875467; x=1766480267; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7aHjZdlpuTA/+VCFeB3kYuF7dkzrIWScBxYjLRTmNGs=;
        b=O50eXj3VxnrzavlxbuEiZOPzJI39Sm2ICTwxWQayLlVige7+I1sLg1WDywK7UZHb1D
         rlswk6ZIX3GYk5nrpki2lyRviNBE4dlVUvQuUYFyI2gzsAB4aq9VD9H7IzXFlVLjy1Vz
         oXmm1lGgC/LgAR25Fdmq2cGe/3Ib+oY4CQPGPSmIrvEk2dezoRSC8qkUGLhB+PT/mMi2
         sNhaouGIt6kSJ3rWWz9RJrqyDnWOHY88hGpYBQvy3iEQbqenWr8pHn25ONoa+1En0J+n
         6loRskcClrQkxvpRvhDGZ7hSTugnwND0gkOpaif1GgnCWh2xZxU4lWElILe1gqI7KStB
         j+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765875467; x=1766480267;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7aHjZdlpuTA/+VCFeB3kYuF7dkzrIWScBxYjLRTmNGs=;
        b=ALnZsWuHyKvqUxGjxeRZt/8wQRwl3Au6Ebxq0r2/s0kb9Gz7HHsgdgiVHJaF1m3Dey
         R/O4WySgKyBiCQuiRv6DAOhhDsg+SqN8f/BvgwzBaa2gMtn0RiFYYTZcNKxvt9FeK1a7
         t+YFYVmQ1OwsQEwl83keeBjG+/n2PeFfof7ngdBLi1n7JBC8M5EUmbboyTjkC/kLtkW3
         rTPBzU+trai9G81uJWeiOJYhmyBiiirgOx3u+QzuS3d/mk71+ssrPncgknGPDbUeHZTZ
         tjOo/0wndtj58P1qordRznstjb7WMvBQ7GZL8CSnNrM7FUkbZ+Ah/AahGXBmAsrUR0F2
         0W7g==
X-Forwarded-Encrypted: i=1; AJvYcCXrhILrapaU61FXQfm/Myn0CeubAFDwxlmMBPQViXmrlQNMT7TRgA3hSIHux7qJep2GqyatltbOqaRCGxiZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyVoXY/q51PyYMRWEufiKxSWxAvO2tzlNbY4ZcLkAyLsqSMpHN1
	MiCu5KSs5aVmPnt5/Zt/WOzUlVHANvUSk6k9v50ajgLrrn+gEIDJubgujnQvJVRHKFI=
X-Gm-Gg: AY/fxX6g/ReJiAOhI/Is2OLvD0f8kPEPw5AmO5b+BsxPWetQzhr72CwbNZIHIsr9RDR
	c1CSdPhfurJe03cTEme+rxYf0Gmjz2et9j8j4ZJfySYDKO4Y1rsKbdlyuAgRQw+nP2CG7sshsIb
	TOz/Z79IddYqB7vMzQRrY697n+22B3SqTxRHBpwvThLqiArwfc2YjZlA61oZh/h+m1NKou860Ml
	t9L9rKHDgL9T++nyMPyZkRWF1uXnS1Q8E+TuXc64qlwK8rlkaaXjEaPpkpSuUcSwlkMfsRGimL8
	qVk9WQ1p6+uibEQV855m3iJpLR/wmT1Hhtkp2dnwrL+eZgENgqlzO+N/W0xfoVQKmFUdVL8PB4M
	6wgzDpArdqv0BTQ4zZ7tFBFYoko3NRnj1FQZNcVS+o+iBmjLfdFobi8xeSQUQLXZlWobkuDw6Tv
	d0f4e+RFeTznY/KRbbf2mitgMiTXrpivTQ
X-Google-Smtp-Source: AGHT+IG5jFcwmF7uFSS85paOtFSZF/44GwLBDnZ1eFIgf1fMXDKgGhHNsxDk2WI8viRGoT2D70AGbA==
X-Received: by 2002:a05:600c:450f:b0:477:b642:9dbf with SMTP id 5b1f17b1804b1-47a8f910f90mr124720995e9.32.1765875466988;
        Tue, 16 Dec 2025 00:57:46 -0800 (PST)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f6e58c1sm226892755e9.12.2025.12.16.00.57.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Dec 2025 00:57:46 -0800 (PST)
Message-ID: <be8b5b62-f8ac-4221-b537-b9d458d329ac@suse.com>
Date: Tue, 16 Dec 2025 09:57:46 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update module subsystem maintainers and
 repository
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Aaron Tomlin <atomlin@atomlin.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251215215545.1332626-2-samitolvanen@google.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20251215215545.1332626-2-samitolvanen@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/15/25 10:55 PM, Sami Tolvanen wrote:
> Add myself as a maintainer for module support as I'll be handling pull
> requests for the next six months according to the previously announced
> rotation [1][2].  Also, update the git repository link to point to the
> modules tree, which is already used by linux-next.
> 
> Link: https://lore.kernel.org/linux-modules/Z3gDAnPlA3SZEbgl@bombadil.infradead.org [1]
> Link: https://lore.kernel.org/linux-modules/20251203234840.3720-1-da.gomez@kernel.org/ [2]
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Acked-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Cheers,
Petr
