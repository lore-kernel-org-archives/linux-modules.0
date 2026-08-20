Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3533BB122
	for <linux-modules@vger.kernel.org>; Thu, 20 Aug 2026 07:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787211424; cv=none; b=Il6h+LS/fswQc+VbLs9w0tRaVdIxX6JRgaoQU47JwRzrbL749zpnzd+VUBCGotiEpoS0LnH8gkkFjZC6nAbaR095iCrjSkEe9QpZ8Pewuz0zGD4KU+Hrn+vYCkFuvtvlOvPfB3xDo4iJLuGacTTdiaoIzRI4OXLKmEaVTQNilCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787211424; c=relaxed/simple;
	bh=xlTg7EvbGSIUrnqCzEzXf8yzgJqpfux/IKue7xLeNgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HBd9uwI5u1PB0jFNbGUCygQxr8C1xAsNM9FadVEerVJ8+7e+PS/0HQVGFgQHyR6Si3n2ZQ7CxnSMvZj6mnqI9L4OeEwKcr3ln95sH3wtfpGb4itp5tfTmXhqPRXAU1200tvx/Gh8WOISXUr02YmPVF/VLyccg4TP7Jeo6BDMOxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ULqhYR6U; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ULqhYR6U"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49954b88fffso19028825e9.0
        for <linux-modules@vger.kernel.org>; Thu, 20 Aug 2026 00:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787211420; x=1787816220; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cNsMSJHsfVVjwAdqv5CH5q3Y+Ts0/jXpzfWxgDPSqmg=;
        b=ULqhYR6UYFeFI+LrCMzxIAhejcHxrE6M6/OybecW+SIEMmEjQgwPaSkWUZX8PLB1y8
         QPPl2xVXkMu+uHZdToa6L3Bzv1hIMJb9NP/0uXZ+fkpj4KSpXfBl/zdmaMr/C0VXxcm0
         AtukIVhZk53Jt3xGzo2hwa7BYN/LffTSTX/SBTU6HOyFTase1vjznANjeyqZv3NpNc6V
         dR9KFuP5rZd4Yzy4W5yplHv01m0/4sgKpLhxFC427AilMzekmqiBwDpwK5MYkaLoivLx
         k2T0qpB8jKeUmGipjPRLELxPhuUOWP0FCvaWAoIT+TPHiRvZ6KC5WJX4p3jMpczfIDXk
         pzOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787211420; x=1787816220;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cNsMSJHsfVVjwAdqv5CH5q3Y+Ts0/jXpzfWxgDPSqmg=;
        b=FiFJl/pyEBTCBCpFH8mVGqJHYnd0DB5E8WrWOszmb+sbVzykCZ29Nu1Ih9LrOthT4u
         8ElrkLr3rlJ2yWPX5qWufLP8P10lncgSgDJCRAhRLpdUpg47i4VXvzfvlaEtYpzfLRNj
         UXHHBNRyjUyoTBv8ZEx4x8ipjRMHdvNPQJ8BcGUwNktASufFuMIdgzPsUlhKf9qwtuB+
         hym9NV2JO7x0N99AxpsjYihur0kCI2LcQivfjhKENRge24hEedsg63nAM980i5mNLvr4
         xWeIDxRIvsiBeUfvm/js4/+6p+DWSQx/zD9euDMCplxRtsJIU3lewSubR3JI6begJfBW
         vHQA==
X-Forwarded-Encrypted: i=1; AHgh+RrCwJeFB8FE6Te4gAOqhDYBKLkzzxCF1Y3dPtQSd7L+ojSVy3LlME7/TJdp1KdCfhCIHfQavjmIVgMYQuA8@vger.kernel.org
X-Gm-Message-State: AOJu0YxcayMT0qC48/5N9ZuWfF7PTBycFvAr4U4W+oiiuadPo0m02+oS
	LNlI4RcaKKesvB1elY7LbXYCyHzit+yFwBGSLniC9J3FYnTc2JEzTtAhffLE2pt8I8Y=
X-Gm-Gg: AR+sD116bqyGV+e5K5ptq7g3aRz87nGtlc/gRon/UpoXcKA3pW62ZvK+biUQHRDUmat
	381gMOeGBeVkBfcRH2z2574g8Frv7IRZTI/chYNiQmvLvXPQS9Aq58brtdjfv8idBNleUoO0pp2
	Y470SXJJ0dwmD8p4yh2RaNtaCtMYy98tC/yd0tdigQeP3tosdx84WXmRpzB4MuhGoouv79Cu3Tk
	W4K7IVt/QqroqVGOBak/LiCKO9eHdsbTBKdscJSscyyt2etIFFJ4mkDJwmz4IEWYbMR03c2JTSA
	YRPD1z6diFp7CwCC+d0Fjqv4hddn97IyusTsrV0R/oBG0M03eRoj72irHNTtAiLB1dOhH+vVoV6
	rO03tZPJ61K7L7PCfLT2kRbnYhlzK5WbmWPwHJ4C8IdqTVR+a3JiPbduAJfNmQU9BxC51hyvz7S
	AQpz2m4o+kpWQ8D7of1mpeTrZ/ggdaQXu6DBXqvdV8RoCLBSWCY+VIv4BS6bH5e1zATp91ybKWf
	ek+Dio7ahxflKMaBa+tYDAR
X-Received: by 2002:a05:600c:37c6:b0:499:87f3:a2a3 with SMTP id 5b1f17b1804b1-499aa1c7bafmr193343735e9.15.1787211420230;
        Thu, 20 Aug 2026 00:37:00 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:fc6c:f9a2:4a0a:6354? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b2af8424sm24307625e9.0.2026.08.20.00.36.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 00:36:59 -0700 (PDT)
Message-ID: <53f739af-6408-4cd6-bc12-ca7516ad2f6d@suse.com>
Date: Thu, 20 Aug 2026 09:36:58 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [modules:ppavlu-module-include 35/37] error[E0609]: no field
 `__bindgen_anon_1` on type `bindings::kernel_param`
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@kernel.org>,
 linux-modules@vger.kernel.org
References: <202608191847.ew1wQKaQ-lkp@intel.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <202608191847.ew1wQKaQ-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/19/26 6:11 PM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git ppavlu-module-include
> head:   fcbfd3cbe0a054838436812cc0b664f71ba1d0a4
> commit: 2021aa3988f7a166b2be26c84d10fc6d1cc3d913 [35/37] module: Move module information macros into their own header
> config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20260819/202608191847.ew1wQKaQ-lkp@intel.com/config)
> compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
> rustc: rustc 1.96.0 (ac68faa20 2026-05-25)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260819/202608191847.ew1wQKaQ-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202608191847.ew1wQKaQ-lkp@intel.com/

Sorry for the noise. I didn't realize lkp-tests watches all branches in
the modules Git repository. That is useful, although this one is really
a work-in-progress branch, so I've renamed it to
ppavlu-module-include-experimental to avoid being picked up by.

-- 
Cheers,
Petr
