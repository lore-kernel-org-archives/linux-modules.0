Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A001487D8
	for <linux-modules@vger.kernel.org>; Fri,  5 Jul 2024 14:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720189519; cv=none; b=lUPtQ/dMQM0ZfAHSYW+KLgghCSpDlCDJ7vLbzBFr+OnySQJ45XKhnSBwl62gAFonoAercQM7zmXLr/C5T9cr0KQ4+Qy5JYdR1VUUFCQe/ErDgvSQITCe+NEkAqKX+IJLNXqg2FSwNQ04bssXCFFvSUwbvnhQ/eFnvCOiZB+Vfhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720189519; c=relaxed/simple;
	bh=C4tqAmHM8v4mD3hhTZJZUBWCm1/4vg81FUX8llaVkDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qxY5QAiwQb8XqrjT5u/eLnnwq+jk78DhdsJFbYTXLW44JCBmi5DL1Kf8V31xTDrmejUcsokwpKjVdnu0n48rYGgbyLjss1dmWdxLommgI0lDCKqIjAFmbr/G8rtC1RrP47cMm0WhQxLhpMWPrtDDmBiTYD7ZPbpB+oZO0AYbH34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LZO90tDo; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LZO90tDo"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-702233310b0so997393a34.2
        for <linux-modules@vger.kernel.org>; Fri, 05 Jul 2024 07:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720189516; x=1720794316; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nXc3UlGjeR76mLpFRQ7ArGxbQkbw5AvjaQ5WOZ1mVMs=;
        b=LZO90tDoQpkYiCjah/eBNdundKCGXg/5lM3mmBLTq4oTGMPIF70T2xosVQZcSysImg
         Mxz1EftZEwGcHhi+qDJ2gRd0DM4J0MsmSvIpCv7KcLFo9CruSP4hY2f/3OFzI5ez2n+y
         JNKnqK04I8MPcopXkYx/cXXzUxwLTQv38PtOsXprp7hJoA9utoQtguG8RonQAO5p56jG
         Ld6c7myuTMgDM8AGG6y3F2DR9PbjubAM1HO3uPta6q8zeEUG3mfBOODy2ulvt9QoJEEs
         nXudxSOeWhIpEevDNIb4/wUgQ2LIkwexmQmvB0L08OBeZ9khb+RQJj9CuHHdDE5iOFE0
         0y9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720189516; x=1720794316;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nXc3UlGjeR76mLpFRQ7ArGxbQkbw5AvjaQ5WOZ1mVMs=;
        b=mlGYwuBh7ztmTcUcBwuHCDm7cT1n6/5T/5AseIeoMRgy7C98QjCNOdLfi1Zp+Fsek7
         5Yeb9R2JYTl1egQTYNmzjYHLRHER5SwarTD5w7rhDfNbPxQaBhoYYTvCYd6JeX5eqnzD
         SXse6s20wSq0j3R7wHDEh+Ora7RRbTW/akOdW9m/Uho8vKWMvd5LZ8uECuhV8CLbG+/p
         5c1h6d5GCNbZtfzLUm4tib4TRvJGmm46YRpW+ZTHsOV96BKGb2Ozf+xWjBfgG/Vh6leN
         TJNoCK4epPsQxWt3sWke1IvQ7IZvAswBdwUC5GLcKph+SSNUVzraAiL1kQ4QabLYQhIf
         Vxwg==
X-Forwarded-Encrypted: i=1; AJvYcCUpWrNDiM7aMBwGj5teaEQXzqqXyzL5sbP2mn20ikv51kYiiCRQXTco2RSrAY/mt+TQs4GpfDtPO6V+loV+o5bAzrBpeQxINXX8OaX/kw==
X-Gm-Message-State: AOJu0YzIGOHIhYEO9UHrDtmzKkS8i+R1paw15lWufF+APZkNUKfF02Kq
	yUNejcDzDo9TWYPezvANplI9iEb9xEI48H5sepP20MWVKuQN8s5Adoz4QjRVVS8=
X-Google-Smtp-Source: AGHT+IHPlj4ATuT25r3JDKsOmpgXkUlB9bwlGVA8tDvmU40oqlMbYDXNcAQKERtcZUZ6QmueddNTAQ==
X-Received: by 2002:a05:6870:8182:b0:25e:2208:6c8a with SMTP id 586e51a60fabf-25e2b8cf279mr4072132fac.4.1720189516448;
        Fri, 05 Jul 2024 07:25:16 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:45d:774f:47f7:bb6a])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25e4be5ae0fsm209740fac.29.2024.07.05.07.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 07:25:15 -0700 (PDT)
Date: Fri, 5 Jul 2024 16:25:14 +0200
From: Dan Carpenter <dan.carpenter@linaro.org>
To: =?iso-8859-1?Q?=C1gatha?= Isabelle Chris Moreira Guedes <code@agatha.dev>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	patch-reply@agatha.dev
Subject: Re: [PATCH v2] init: staging: Fix missing warning/taint on builtin
 code
Message-ID: <19a4a521-2e68-402d-83d0-618c299f2c10@suswa.mountain>
References: <n5plxnkubcnbuyv7l24i4cwsauh4odwk6g5yiys6oiiwj3i34r@izcjggvv2om2>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <n5plxnkubcnbuyv7l24i4cwsauh4odwk6g5yiys6oiiwj3i34r@izcjggvv2om2>

On Thu, Jul 04, 2024 at 09:20:49PM -0300, Ágatha Isabelle Chris Moreira Guedes wrote:
> +#ifdef CONFIG_STAGING
> +/**
> + * staging_init_taint() - We need to taint the kernel whenever staging code
> + * is initialized (from built-in drivers) or loaded (as modules) and issue
> + * a warning the first time it happens.
> + */
> +void staging_taint(const char *code_id, bool module)
> +{
> +	char *code_type = module ? "module" : "builtin driver";
> +
> +	pr_warn("%s %s: The kernel contains code from staging directory"
> +		", the quality is unknown, you have been warned.\n",

I wasn't going to say anything but since you're resending anyway,
please, don't break the line like this so it starts with a comma.  The
comma can go on the line before.  But if it couldn't then we would move
the whole word "directory," to the next line.

regards,
dan carpenter

