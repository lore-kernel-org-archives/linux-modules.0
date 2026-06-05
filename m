Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9E03A641C
	for <linux-modules@vger.kernel.org>; Fri,  5 Jun 2026 18:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780683926; cv=none; b=NJO2CK1V8BXkyvrA60ZGYa/47APHJWvCPVTDIEQguXJ4l0OG0GYOAdD0TXjt3fcGsxd7biObfMMFFTd5AneBf3DjBXt0dVDfdEaPCg0ZIAYqW4hqkpiXXbP23v/N7h+JUIMBHuI0at6jVsUv9gNYB9z0inWj7nroYwKzd4uzaQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780683926; c=relaxed/simple;
	bh=ODQinMMdxsaY6RL0hYX0pZOFbL9zrSNm1pmSWChLaA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T0dZuDTD4XDDinD0igbN0+CN3Xm0VvCTUgnsebIdoW7bYnEUXW8eE09VILlW/Pvv3hmDzJlkYqZ65+wkObsZuuXpzUG//80MQakDo6VMc8KKG6/WpHTNwkv6Hc59WMWJgQGvi+LnlS2yhLBmcSibkuSUvLusO5CeXYlI+cC2jX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iiuICafn; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iiuICafn"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2bf22c18ad3so166395ad.0
        for <linux-modules@vger.kernel.org>; Fri, 05 Jun 2026 11:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780683923; x=1781288723; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6t9Y3TUDX8gOECAz6pcChptmfsUqRuuX+pFwbulAEyA=;
        b=iiuICafnvH8RuQx0+dpLIBD9tvUC6/HmIb6q3PxVV3k7YDOLj+eAWZ1mShsgSHs6gc
         MLmStcZp6Z12piph3rME9XGOsVwTXUIVpgWMCcn0cJnFP4MDljuwT6XGfFnf6q0cihs+
         oljC4fV43Sid9Fk+C16048vY/jeLcKKMylyKNBQLU8vCdOJVdPN5d5gGa/HyFlIJnaDb
         +t0jMctZtQq+6FpG3vnM8nw5EQ5Ibd08kiVZWfFlozdfjsCskii1zHWArZjTADziJiWl
         OyXE/w7tdV2JrybeYlU7AmzoTQP1woikGJZxGwnHeQR5n38StKIZAnsnyir/YROuAOBo
         YVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780683923; x=1781288723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6t9Y3TUDX8gOECAz6pcChptmfsUqRuuX+pFwbulAEyA=;
        b=a18uAm9feYlbiIPtUmuMUtwcdkSOxWRucLQax3IcY90VkQKSeuEIraUPomcr59Ou1b
         x8w/V4ZjeXlXvMtHse1vnlFZQV3oNyc1tnQ3Az+QZrcuH+lkyZ1Ew5k7zAFV+R6PslhN
         V6xQPsT3s86dcWi8EmpWmW2FYc4BhJmvbPyUjUEub9kC+Iys2K5ElxGqYKjJKecl+b2l
         JlB5fVNpmhTn3gmbiw0oxi1G3PuuRmipQ21jicQkbqcqdLzQJwZv0UehD9TaUTadERDz
         A7qGiiFnBcSbwd0JAamBPepSUR6AXzRQ2Az8LDioYR8LnUX7m7qswY6+VBZx7RMdtd2N
         kTjA==
X-Forwarded-Encrypted: i=1; AFNElJ9dHRpeW+fa8MmR0WW4Ae/lDsP4QWeveafp2WnnORI8inUOhp/Aus2w/BXB22b3ysO8Mm/IjK5plh1IKJIP@vger.kernel.org
X-Gm-Message-State: AOJu0YxbBniqmPKqyL+LAnkL5Xz0JgM6Rity2h4yBsiIVC5pxobAn6V3
	FolB9ioGfZRIaFvxsgb5i+PANzlb/kA9VRNJNG2+GBUqXj/M4esuM+k7L0ey+bhnjw==
X-Gm-Gg: Acq92OEwyEXLM72t5RR5M4/9ZtrPKfhduEMptfgn5Wx4CyvXYlJfYaX8FgwjSH+cwSX
	azUE2a/oRxmDOjx7rr3+pQ0EQt9cbcmV5Kf9yn973RGkhFiXhNPl8LOvcL3vAD9WbEjsxsoS5PG
	3Y8H3VQaJo0QhY/hI0mEEonSzxhc7dsyosEqAEUri1oPWIoybehUqqZQYGS1xPfuubnp6474+py
	KgN6NofoGNECLJpaJGofbPnk7U3BtIFb2uyJHoh5k5h4YTVMldMivAAko25e+sahM+0DwZxxGPX
	HbMSdyMHocCZBXAPMC++/a0YKRZbEat59H/gze24QQXYgVTLHDxj1RkTXB70ICM5xbfta26/I+V
	9NddwB8Ml5BKmHIRjz2+sLwuCXOSXYvGcxcRKChRCWildjyfUU81HFsRToAGdnHlR6n0jLvBoK6
	Cg6THY3l3HqlGVThyOq1QxuoDvQEAiyx00nkLXL0sKe3G+zDoEtKsgTKUAVv9yr2gO080wZzcIC
	jqUGA==
X-Received: by 2002:a17:902:e842:b0:2bd:6dad:3df9 with SMTP id d9443c01a7336-2c1eb744312mr2068635ad.23.1780683922744;
        Fri, 05 Jun 2026 11:25:22 -0700 (PDT)
Received: from google.com (171.46.125.34.bc.googleusercontent.com. [34.125.46.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6e86dsm100327885ad.8.2026.06.05.11.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 11:25:21 -0700 (PDT)
Date: Fri, 5 Jun 2026 18:25:17 +0000
From: Sami Tolvanen <samitolvanen@google.com>
To: Michal Gorlas <michal.gorlas@9elements.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org
Subject: Re: [PATCH 1/2] module: add CONFIG_MODULE_RESTRICT_AUTOLOAD
Message-ID: <20260605182517.GA2939956@google.com>
References: <20260515-autoload_restrict-v1-0-40b7c03ddd04@9elements.com>
 <20260515-autoload_restrict-v1-1-40b7c03ddd04@9elements.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515-autoload_restrict-v1-1-40b7c03ddd04@9elements.com>

On Fri, May 15, 2026 at 07:20:19PM +0200, Michal Gorlas wrote:
> Add CONFIG_MODULE_RESTRICT_AUTOLOAD and modrestrict parameter
> documentation.
> 
> Signed-off-by: Michal Gorlas <michal.gorlas@9elements.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  5 +++++
>  kernel/module/Kconfig                           | 15 +++++++++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 03a550630644..1013104f0943 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4185,6 +4185,11 @@ Kernel parameters
>  			For details see:
>  			Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst
>  
> +	modrestrict=<bool>
> +			Control the restriction of module auto-loading to
> +			CAP_SYS_ADMIN. If no <bool> value is specified, this
> +			is set to the value of CONFIG_MODULE_RESTRICT_AUTOLOAD.

Doesn't this default to true if no bool value is specified? It only uses
the config if modrestrict is not passed to the kernel at all.

>  	<module>.async_probe[=<bool>] [KNL]
>  			If no <bool> value is specified or if the value
>  			specified is not a valid <bool>, enable asynchronous
> diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
> index 43b1bb01fd27..c9e01bb848c0 100644
> --- a/kernel/module/Kconfig
> +++ b/kernel/module/Kconfig
> @@ -337,6 +337,21 @@ config MODULE_SIG_HASH
>  
>  endif # MODULE_SIG || IMA_APPRAISE_MODSIG
>  
> +config MODULE_RESTRICT_AUTOLOAD
> +	bool "Restrict module auto-loading to privileged users"
> +	default n

You don't need to specify default n here.

Also, I think you can just squash the two patches. There's no benefit
in splitting the config/documentation into a separate patch.

Sami
