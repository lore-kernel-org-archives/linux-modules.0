Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30B23A962E
	for <linux-modules@vger.kernel.org>; Fri,  5 Jun 2026 18:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780684209; cv=none; b=BDUD8sZfkgfzeTOXsIY1R0DRrVjwwrR2cJ29xCbwH+cQGBEKatn5Bmw3lRX3lq03bxWuVXBDCQ8BkpqC4uxdaP7pyLPBirPlqxiuVXfkdknpDD9BSJP0OdGJv1s0wO9DYhUziUCtb/Kp02SFec9lms/muzVyrucSpHzw2pOnbLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780684209; c=relaxed/simple;
	bh=wcy0f2jBXzVCMI2Wm+TBszW9WYGbTiy+Tvaz4GauPjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WxtmPaBe1Z9XRhhb1XLCMZkc8k7wNiAMU+rYjBtWip4XFLLpa5WqRTgZ2282LXZ+2kTrmKsx7x0BX4813SPkGhS+GmrEf8iCpzTgpSdzMaNKEdtzWJhJlNR/LR7VEVG2DDyHed0C56QjLLHi0bcLVmV5qNFQymF22vU2wb4eSjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pVat2Z8/; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pVat2Z8/"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2bf2911f93cso117725ad.1
        for <linux-modules@vger.kernel.org>; Fri, 05 Jun 2026 11:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780684208; x=1781289008; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9KnToTwjIOTIeerw1OtFveTTURV0LHhrMU47MZN/oSk=;
        b=pVat2Z8/cWqe2QjhIsQ78MNIm64/CNBEteK6EVoKNCKT5NS6EOrQ4mG0gxgJAI4fzc
         6tc42nx342W10DrLWeePU0U02k7ttE9vELWNoyGPmVQa0O5JLLFq4WUOLJpVGpRG7rYF
         2xijMDgTe/VsWt0s1iISY6Q+8YEaStSifTFRxCav2reiukGT3UUcVkrL0O5tNnObuIVK
         P6+HrwT0ij1vMgtLGiMRnTF6OcGOtpw6HbVFjdPmwWZSRDvIPjN+2Na/S7HHV8wVJ1sS
         oXm6MD0qKTNTqgThzY8wNwUcEZ1i5Bk83o9YzdtKniW3+id7XPezidpBF1w++6YAUCCW
         YC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780684208; x=1781289008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9KnToTwjIOTIeerw1OtFveTTURV0LHhrMU47MZN/oSk=;
        b=g0xoE7QAgmngTEJHJnLJRNPB1aTXxlqg2PgKa1+I5YtTlHGj9CZWjTMbot9G36J+6p
         IyS5Ygvn16zKh9djgevGLZdHWSNPGUQM05FJiljCoXQaJognHlU+Rqj3qmS9ALZ15Uhn
         0o/eSjvhToA89gTtSLcStd/a40o+xFQCqF0c2MYKaOE8aK5BQKZUx2S3eFuyvW0zU1Eh
         9a7ibHeDjrdOGk1DR7xBMRYS+UkiLeNrViAci11M8sAzed0EVknLg7gDp3Iv7uK7rwN0
         PD6dbl+n8FY1cUwLfR/AC/js6hgqXOlw0zMP5+Dz7pUIRWyFlyNcY//Bd3FubXt1o3oy
         vyUg==
X-Forwarded-Encrypted: i=1; AFNElJ8CboNDspv6U+Vf1TSrRbwJd6cLJ99SDa/CiStRnKTf7jCLJKqCg+MfmDJLg7V4dloIBT9+z5EbO+18i7ns@vger.kernel.org
X-Gm-Message-State: AOJu0YyNX8j0oUDIqaWESsOV+F6Ii2ihAMVZNC5OdsJ7sOtvzSNpTKJ7
	muX2Zb9YHBtWmKK9Nfltbh21XLGCS0hm9DDYTFDOaZLfSDZ5/7qKNXzfis8D/op58A==
X-Gm-Gg: Acq92OG36fth3G6Ub+AEHT/0ONWu3VQ8L9omXBe3IQ8LgmvIq1WimhQH0wRRNil95Zd
	rJtrRiKb+aHDLPxciAFE537IhZDDm9CqYjZ3dX9iLInuHSEg/epdx7OlrJxZVk7Zzvo2nfbNoDm
	DfOtbeDjMhZJYuAsOnpGGv63axXo+tokpyNqAa/Nv8gTq0vjXVnBBMW6W/99u8Svur2EHnGVaMk
	v5h7cBI6LOkkQPQl2ddSOVBwI7hZid091u4x1EcQXrcOkHpagB0TKN69q5ZwhssbZQctIu45Oyz
	YmvfCZW0yitIXfmSUOMz4azOy3oYa8Qq2nsNvi10Pq3ft9q9GyxBwUwnfw9vLNbiNSBlKOSmNg8
	JBYIWAX+4qiTgHKzVIMwYdGWRBdxoijZ4sivU67KYfDdLhRWCTfQF0r2NmDI7Y0BjXldXWSvwE4
	c/TmoHLvDfUPAL85Eo9J6ZB0eqMLmsLzetFkWpUFFuafvEakGMB516fsB7rDJBxuT/pVIR5bdTR
	9wIeA==
X-Received: by 2002:a17:902:da84:b0:2bf:193b:a195 with SMTP id d9443c01a7336-2c1eb1ded7emr2155935ad.11.1780684207442;
        Fri, 05 Jun 2026 11:30:07 -0700 (PDT)
Received: from google.com (171.46.125.34.bc.googleusercontent.com. [34.125.46.171])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6bf827e6sm9411861a91.1.2026.06.05.11.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 11:30:06 -0700 (PDT)
Date: Fri, 5 Jun 2026 18:30:02 +0000
From: Sami Tolvanen <samitolvanen@google.com>
To: Michal Gorlas <michal.gorlas@9elements.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org
Subject: Re: [PATCH 2/2] module: restrict autoload to CAP_SYS_ADMIN if
 CONFIG_MODULE_RESTRICT_AUTOLOAD
Message-ID: <20260605183002.GB2939956@google.com>
References: <20260515-autoload_restrict-v1-0-40b7c03ddd04@9elements.com>
 <20260515-autoload_restrict-v1-2-40b7c03ddd04@9elements.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515-autoload_restrict-v1-2-40b7c03ddd04@9elements.com>

On Fri, May 15, 2026 at 07:20:20PM +0200, Michal Gorlas wrote:
> Restrict module auto-loading to CAP_SYS_ADMIN if
> CONFIG_MODULE_RESTRICT_AUTOLOAD is enabled, cmdline parameter
> modrestrict=true, or kernel.modrestrict=1 is set with sysctl.
> 
> Signed-off-by: Michal Gorlas <michal.gorlas@9elements.com>
> ---
>  kernel/module/internal.h |  1 +
>  kernel/module/kmod.c     |  5 +++++
>  kernel/module/main.c     | 11 +++++++++++
>  3 files changed, 17 insertions(+)
> 
> diff --git a/kernel/module/internal.h b/kernel/module/internal.h
> index 061161cc79d9..496d8703f0c6 100644
> --- a/kernel/module/internal.h
> +++ b/kernel/module/internal.h
> @@ -46,6 +46,7 @@ struct kernel_symbol {
>  
>  extern struct mutex module_mutex;
>  extern struct list_head modules;
> +extern bool module_autoload_restrict;
>  
>  extern const struct module_attribute *const modinfo_attrs[];
>  extern const size_t modinfo_attrs_count;
> diff --git a/kernel/module/kmod.c b/kernel/module/kmod.c
> index a25dccdf7aa7..58b28c23f571 100644
> --- a/kernel/module/kmod.c
> +++ b/kernel/module/kmod.c
> @@ -156,6 +156,11 @@ int __request_module(bool wait, const char *fmt, ...)
>  	if (ret)
>  		return ret;
>  
> +	if (module_autoload_restrict && !capable(CAP_SYS_ADMIN)) {
> +		pr_alert("denied attempt to auto-load module %s\n", module_name);

Is pr_alert appropriate here or can this be a warning? Also, use the _ratelimited
variant like the pre-existing warning in this function.

Sami
