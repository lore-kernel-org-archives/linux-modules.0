Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216F01442F4
	for <linux-modules@vger.kernel.org>; Thu, 12 Jun 2025 11:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749728845; cv=none; b=W1ZKy1Sj+xe5T4q6AR2HVfEiluxHhzcgyiJKZEwQZVenraRe8EuVO4lXD8XqWcp2Il2rj5X62FRRyVMExXZ2rZjXQobKFIvzGAQq1EuGaTRMZp7MI96Si1yZ909j0YKfJKvFPjHeDizg6KXnCUjsY/+Fd5OGHGDLmJX33UOTuiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749728845; c=relaxed/simple;
	bh=mDOZZv4brJY4/QapOk8eT0uTuWK+79TDLNRGhMWLFZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j8uw+7T2Ker02hmedhLvsPBMI46Gc22pI4uMEzal7BOgGTBtV/stX62v2juNgNfHIJooHSHEWwjMVAJ/gLUEuIAlpWE6Kn2UvMzfC6urJP8sFB8jpHlYXqkPNmsFpNkJMiqX7LciZ2bfs6sgWwKXmpGPsUnF+Dn67BTF922W33c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=V5BdoBah; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="V5BdoBah"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-3a361b8a664so773490f8f.3
        for <linux-modules@vger.kernel.org>; Thu, 12 Jun 2025 04:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749728841; x=1750333641; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IkRlDYSNjelZTYRzyvEVnicQpoztUlVI19tQWHJuwsU=;
        b=V5BdoBahnJLRKJ+Kkrv+X3mqEg+BRu+p4sUDUKw6f715HTQd8uW+cY9dnSHA1qhfDU
         FeRr+AYRaGUwue9vd1Ti26xm54Z9b7rGA1mI32HzjqYqNgFyYJODde5c/Uj0QCANeJcY
         m4/GJnuTFwrLdAEDaz2lXsWAFAh4HZcrT8rZCOLMYsigPtOOHGNu7U0lklyF6Wu/KQOa
         /yIg2vf63Vn6n4j2K5CAmCjW0NMEHLvMMgCG3PsVEO30xFoganz0J1TqtfRbPEZWR6x3
         CfyhJ5FXEju3ixMOR0g8jdcMIy4mI7fHowOA3hXMJh3I6mDRHTkeWlzi2NbKIZwSEO9o
         NX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749728841; x=1750333641;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IkRlDYSNjelZTYRzyvEVnicQpoztUlVI19tQWHJuwsU=;
        b=i3J6bYnTDVdxmozeZtHjUWxxkrN9JyBoienuWVmUB8Hsn2k8tjReqgY8oiE5/S3ijU
         mUMEZuzSNAWDcxCZzWRor20N2NTDQkL7mfvWcrHnY/MKTL84YHCcIZs8ro4VfzKa4Ehz
         VvbavS6OWhxGwI6Kv7bRiS+tZVAE6aQTd8RS0stkFDsLB8glRJdVAFfYYWxczsQIqmiU
         lPVtlN4OTkDaVl+MDqFOmKOhH9keYAVErkp/76LpsIOF72xLm2h6lLNGczlhxLCkz+wQ
         Ts/QwfCXSz5kjmGYZDky3axTXRguJL1/BRZXBX3HrdcgrzvfHyua457iWyXGAkD/Px4S
         iZGg==
X-Forwarded-Encrypted: i=1; AJvYcCUvBzDZqnbGr/NsvxNrmKwet9CRftAWIWfNXfG1uXeV0XNoyt/n95ylsXvvbikg/Ov3hTS1cciVJsU5k2sp@vger.kernel.org
X-Gm-Message-State: AOJu0YydEEuxyWyoYRSyGrJ6LMHN2MmBzDw7usyP+aVXhUWTwY6NV1Sq
	HRgtNMLaPwcSqjiy0HX4Jpnx7ghxYU2WJTT5FqKkurPvb4JxIVhn5dHQoLx5LQ+TqbW7uZfOXnt
	VVAt7Btq8Kw==
X-Gm-Gg: ASbGncvt3x/7BmcjjPeiZ8gTMiGJ+xQXlAihP0sM90BNKxwhoTBg1GPI+v3XnDVPVpE
	Grx0lTYu08YWvdSwbku4FkZp9EboY3n50kK2mURJDzgPYBjtDKmrSRrgnRL5WuTNk0qGS5VQnN5
	myXemDEtPEoFqETyex2mmQ0nlIO2eGqV5MhbZV+2O46rFLZ/bI7cnO2+LKujjlb/Y3NLUNPPgkF
	ro9m4Pe7Zumsx32tKsuqi0rVdT2HDbxJNrabA6lbs5oUzGxwPofs+8u8bKNAnikg6i1YBbOmFLU
	qZbwI4vF+C18nCuFe/RtohxXQkPxBraAPDc/xUKuZiLvyQyyajZtggpCjDUOU8DdzWoi3/p0Xy5
	ajGum
X-Google-Smtp-Source: AGHT+IGzA6c/9Ksw51jAcAdQ9/4Zanxxg8q2o+OhtN8FkIYA91VuOepHLC6Iijz6lOz1M5zSupPVXA==
X-Received: by 2002:a05:6000:26c5:b0:3a4:d0fe:428a with SMTP id ffacd0b85a97d-3a558a27540mr6074151f8f.28.1749728841536;
        Thu, 12 Jun 2025 04:47:21 -0700 (PDT)
Received: from [10.0.1.22] (109-81-1-248.rct.o2.cz. [109.81.1.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a561a3c763sm1769577f8f.62.2025.06.12.04.47.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 04:47:21 -0700 (PDT)
Message-ID: <a16d9e82-3c26-4954-a767-a7c46b01f348@suse.com>
Date: Thu, 12 Jun 2025 13:47:20 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] module: Make sure relocations are applied to the
 per-CPU section
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-modules@vger.kernel.org
References: <20250610163328.URcsSUC1@linutronix.de>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250610163328.URcsSUC1@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/10/25 6:33 PM, Sebastian Andrzej Siewior wrote:
> The per-CPU data section is handled differently than the other sections.
> The memory allocations requires a special __percpu pointer and then the
> section is copied into the view of each CPU. Therefore the SHF_ALLOC
> flag is removed to ensure move_module() skips it.
> 
> Later, relocations are applied and apply_relocations() skips sections
> without SHF_ALLOC because they have not been copied. This also skips the
> per-CPU data section.
> The missing relocations result in a NULL pointer on x86-64 and very
> small values on x86-32. This results in a crash because it is not
> skipped like NULL pointer would and can't be dereferenced.
> 
> Such an assignment happens during static per-CPU lock initialisation
> with lockdep enabled.
> 
> Allow relocation processing for the per-CPU section even if SHF_ALLOC is
> missing.
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202506041623.e45e4f7d-lkp@intel.com
> Fixes: 1a6100caae425 ("Don't relocate non-allocated regions in modules.") #v2.6.1-rc3
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr
