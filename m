Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BF93E5591
	for <linux-modules@vger.kernel.org>; Thu,  9 Jul 2026 09:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783587752; cv=none; b=cBXB9PuMtH3z3qg6ZGegm7psZr40i0ca7YDqxXouWuGmG9x1lIeR8Txy0fMrQZfS+It85nwemz4UE9/yrzAZOxq2r6qPsyxNe7DYt/hoQhgNGIVY/90ctHWBjeAqQQHUbjthtvGc6lToEcpfgHnPuxyHVVYm+uEP4z3v/+7w1kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783587752; c=relaxed/simple;
	bh=yC1sjjYLThUFHqGoQD2sQL9TFY2ezs034KA29+O9Vdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PANDr/e6uSgt1i1gjD6lfwrrVwUq2QTtFKEg+8ZV/gAWMI+nYqU+ZwKakAe+E20x8KYxvugcnr09L0jsYLfWrPnm5vgdKVdGJZksKpzISGkQiCG1KEzLbVyGIUInryLnB+9UFZHbneCxC+bLb3NlrvSo7rFEhdNP4XjTne0v16A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=O/NRCGTR; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="O/NRCGTR"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-472326ca506so1132866f8f.2
        for <linux-modules@vger.kernel.org>; Thu, 09 Jul 2026 02:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783587749; x=1784192549; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d0Wr/vs3pPNDtkRH3jKbQ+uHfzn6g6MnSZd5SVyEqvs=;
        b=O/NRCGTR1c5CqPYucGgMtKnKj5UW69i6ry59IsKIXA8uYdd+RrX1jad3bYc4bOIZgE
         VF8EM5YtJKVx4KHSGoAbLLFEAdb1QmaQTLPxX/754Xs4+lLNTDHsPUtJBQz0XApjzh/D
         rJl6PmlfyjOG6Z2qad8qSkOT7Meb14MQCjqbYB3gU6IuLqJvptDl4Yda5qwFUzYyIiJ/
         tKy4ycutBTqL3AQUPBAdSLmENX7Hd6wMlN83Dkdtf68voD1NF8VV/VrvBTAR+5cyOuHh
         rJT9LTAj4aRBcbDUeO1kaW/iY7cpsic7eLhvZI2onM8ToLmzxQSKzTGPk0sRSPhs+emj
         517w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783587749; x=1784192549;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d0Wr/vs3pPNDtkRH3jKbQ+uHfzn6g6MnSZd5SVyEqvs=;
        b=lEdxfPJfT4g6RBdqibN2ukcmnJpBMtPMEbM8DQYNiJk0c3RM1KiotWymRMtUueTddw
         iybw9zzod6Y+Vemfffmvt45bMKufJZdATGzWW2gk7Rtj1wJVUDI46sCDsWPQHfK2B9kY
         qB9dU9WMaqQnbe/KuXPoBhGDsr/lrvxpZQgXhSgrUrudm9p6IWdxxuaTfwSsf6pNsXcx
         u2fWFIViTZPv1bUjxU0YjIW5tq3vmqaF5+D2hzyKKPQTBo2+ULQc1UN/BVJ0JhmcHDRP
         VgqtMfL9Zfp2myBQjFeSP0krWJPH1mYGmeb9mc5JR3cVEEpCL2mGoBCUEMHPBxBuzEZv
         FYpQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro3kQsIYCGGqANMiKpkQMz9dVqQ+Jya19mODUdkVQSNHU2UjJG/givebN+Qf1ebdzgGUlWl421Ga4wz6vpw@vger.kernel.org
X-Gm-Message-State: AOJu0YwgsPuMNL9lNhm+f9zZeVvXazUP7P+ZiPVBLyamEilCKT50USA6
	sqtKgWkwwe+IowqNXgO+E5OdEN9SlixVVh5zN2/tRSyA2PyrGaktmDHspXIiIyviWio=
X-Gm-Gg: AfdE7ckLee8ClrDm1WcCdeqQYAIKygZUppRFOrpAIkeFhjMJyavXaawTNw8kLMTIhJF
	R3bV2AoADOr2Z9Na9wVcwGspqxFq0ODBGk9Ub0nEbsMOY2mLPwWpw1hWrbDd6VgyALUwiwB56EC
	wqvVvdYDbnOuRo1/j235p7EEnA+qABsvuaTZUwiOlCGgiQ1WtsvVO1Yv/aPf558oCT+Mw1yg48/
	OEgtVfdcAdbTqVvM4kVW4f9hrg7V6VJ31bgv4ikyfjRu0Ff5asFI3bZhAJ4P7j04VS3dafFFcXQ
	F5tSBfgO45YAym9hO5wqp0St5Ys02vERz/fEbdmZWss0t4oxy/cFYpM+Wa3S8qmusc/GHvItx8+
	eU4kTC5cP67oTgtgaRB37fRSiyORtKuNp5hNWPkFB+8QxSkKBgiBAgSX5piQtgf1Ent/Gx3IuRL
	ACWPzWbxjRLgo4WpofKiIkQGEYStzT2EUmTA==
X-Received: by 2002:a05:6000:2385:b0:476:8a:5 with SMTP id ffacd0b85a97d-47df076a5d5mr6135243f8f.34.1783587748960;
        Thu, 09 Jul 2026 02:02:28 -0700 (PDT)
Received: from [192.168.42.79] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d780csm50519133f8f.11.2026.07.09.02.02.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 02:02:28 -0700 (PDT)
Message-ID: <837ef587-c8aa-479a-9b20-597fb987d051@suse.com>
Date: Thu, 9 Jul 2026 11:02:27 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] module: Remove unnecessary module::args
To: Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>, Matthew Wood
 <thepacketgeek@gmail.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260604110455.1608038-1-petr.pavlu@suse.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260604110455.1608038-1-petr.pavlu@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/4/26 1:04 PM, Petr Pavlu wrote:
> Historically, various parameter-handling code kept pointers into
> module::args, most notably the charp support. However, in 2009,
> commit e180a6b7759a ("param: fix charp parameters set via sysfs") changed
> charp parameters to kstrdup() the input string as well. As a result,
> module::args now mostly wastes memory.
> 
> Reviewing all kernel_param_ops and module_param_call instances shows that
> the last code still relying on module::args remaining valid for the
> module's lifetime is simdisk_param_ops_filename. Update it to use kstrdup()
> and then remove module::args.
> 
> Petr Pavlu (2):
>   xtensa/simdisk: Avoid referring to module::args
>   module: Remove unnecessary module::args
> 
>  arch/xtensa/platforms/iss/simdisk.c | 38 +++++++++++++++++++++++++----
>  include/linux/module.h              |  4 ---
>  kernel/module/main.c                | 15 ++++++------
>  3 files changed, 41 insertions(+), 16 deletions(-)
> 
> 
> base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8

Thanks Max and Aaron for the review. Queued now on modules-next for
v7.3-rc1.

-- Petr
