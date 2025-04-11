Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6272E259491
	for <linux-modules@vger.kernel.org>; Fri, 11 Apr 2025 18:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744395828; cv=none; b=NYycGoQCT77vNXCWkvJlCpVrA+WXBpBQhZLy8fNbDpyLERCrXJ7tnQuEE0D2dZt5ZJ3sXjxTkRnki93YkYLFIpRj6D7yK+1aHu4rwsfyXTui31mCMfyiGjoClcCObHYJJD8iVbOzNPhlPVpPpiP7azUdnrdkvIc9k+ypeGPrvPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744395828; c=relaxed/simple;
	bh=wRp633fAvN432QNkHOn3Sh2WuHOXAZD5y1ya/0TaED8=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=Cxgfmd2ubcesllxkberNtF9EsNd9+EIfa3fqjMkqIx2LTV3dqh72h+2Y7bxN5KjDlfA/NBJ69m3x2cQ+NSyyevzLSJ5gDlyK8TSQLAf35BtrsC1ucQ5fggxaTy0y+8IhBHXtH4j6HRkKPaho1+Qsk+QDaO32AFr65vTXPwLRu28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=b7dCwIxt; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="b7dCwIxt"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c5675dec99so220090885a.0
        for <linux-modules@vger.kernel.org>; Fri, 11 Apr 2025 11:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744395825; x=1745000625; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xJ5YQmBzzxkqZ4hz8rzQpHRMLyXN9+w+kR88cQLsbB4=;
        b=b7dCwIxtJARe7cspE3HpNPoA6XonETix6GDMvhiVaRSoridHQj21256YEf1KrI0Rd6
         TSvKxg5eBXaEiBdBhzZyyHMoWoZ6uJvV72QBetB4dq+udymWe7wloEieO//bqtMNacVJ
         9jVoVh/brFLnrT9tz0uq86OMtjU6ZV32P3dv5ldohSgyBwGzfOTPquIInT82LlwNLdMj
         H5jLHfzougCW2PH26L3f58eT8eHnwvdmlTLs/z199Wt4yIy9lMpr9zk5e1IpM9FiX/5Z
         QWRwyWl6IJ4RCtuXkAr5W6s3TR5rURWmiWeGeC7OhqtY2r8Ymk+QSmTlezdV9K9ZyBkx
         p3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744395825; x=1745000625;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xJ5YQmBzzxkqZ4hz8rzQpHRMLyXN9+w+kR88cQLsbB4=;
        b=iQTWz0jWWJXpAIylRW7PQnKgp5DcG/plbGyJr/CELeZK1R01QklrkAsmeKhM8F0dcE
         J3luMb8slZssn6BsQKJ93ZFwXrfVN9fK2DQ/yIjpZNL4zkSHgl3MaanJZ1HBVXUbKocV
         Kj/+0/M3zSo+kOi71Qg4hnPiLMAqMEPgUIKkMrtJJV8iPhjp53OTKxxtMyerQgXg7XGe
         Z/Vaas9u3/2lHTrcP9D3enAezxYXs5GQGOJXZuCfcnfBoHHk7nwMkVKN2KmqjYY0zdSR
         d7DGcoemHOFDKPqbVvnVIDhXfqOkQ86khAs93ykEM+/pr26zKilEblyIlTLSAY7vPCFO
         8ROg==
X-Forwarded-Encrypted: i=1; AJvYcCWF0gU7XdJTq7WaD3b6giizcsdPnXcYsKu8RtkZ0iZaB2mJO7Ts5r2QA00tNJbmJbkdFUBbo4xfzFPr73ok@vger.kernel.org
X-Gm-Message-State: AOJu0YxFR/OCDTdqm5Ad5DXNc3qb2ok/vgJME3AZa3YKKDjB0LMcjAsP
	Qfgi5jBYifnRbOls/j0N20nH4qKPs4yB+GZdy/9KMDfQU9fZ872I5yAmq7giT6p/gI++i16HM7g
	=
X-Gm-Gg: ASbGncvpGxL7eFcz/LozjF+2M4ljbKnadVgcgYRSOK/vzOeLlx9HUkx5HLJmSee326X
	B4mzCu2j7QuNjSzGQdKX5uuo1qhj1e7QqAf+GntndBxdbleHjm9DHdXc3oBOIEb8UIati3FWySb
	vGCj737oZ88VP6GL2+uqhI/57B1gLX4743ZpC3dw16FTBl+RdQ3YePKa+OB3q1uBm8xkfJEa3u+
	gyClYNeI+A5v1NRLw9mfAC0loZmNYx6x+GYXL3MtYiRA49+UHPX+vhy47ChfzirVhKM66ZXR6vs
	OZJKPFdMiVyCvEyKNgx5+tTaxguE8QcTnx5st5+BvVvWyPZ6nDf7Hjk0kc9+8AEdwsWIcEhCfkX
	9guzYJaq3iq6eLaF7618+
X-Google-Smtp-Source: AGHT+IFpxoHsqE2rqU3QKNPJxTXFDKVYNRpkbdRdb3VY4DSQsTti4hjvh96mfKN0WMPjfhsC18cy/w==
X-Received: by 2002:a05:620a:25c8:b0:7c5:48bc:8c77 with SMTP id af79cd13be357-7c7af0f7486mr546571885a.12.1744395825315;
        Fri, 11 Apr 2025 11:23:45 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c7a8943834sm296919185a.22.2025.04.11.11.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 11:23:44 -0700 (PDT)
Date: Fri, 11 Apr 2025 14:23:44 -0400
Message-ID: <92e9622d6dd1bd3e59a36269275aa1fe@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250411_1406/pstg-lib:20250410_1510/pstg-pwork:20250411_1406
From: Paul Moore <paul@paul-moore.com>
To: Richard Guy Briggs <rgb@redhat.com>, Linux-Audit Mailing List <linux-audit@lists.linux-audit.osci.io>, LKML <linux-kernel@vger.kernel.org>, linux-modules@vger.kernel.org, Linux Kernel Audit Mailing List <audit@vger.kernel.org>
Cc: Eric Paris <eparis@parisplace.org>, Steve Grubb <sgrubb@redhat.com>, Richard Guy Briggs <rgb@redhat.com>
Subject: Re: [PATCH v2] audit,module: restore audit logging in load failure  case
References: <b96c64d522cf1c46dce1b8987e83f2f41ff2e5ee.1742231027.git.rgb@redhat.com>
In-Reply-To: <b96c64d522cf1c46dce1b8987e83f2f41ff2e5ee.1742231027.git.rgb@redhat.com>

On Mar 17, 2025 Richard Guy Briggs <rgb@redhat.com> wrote:
> 
> The move of the module sanity check to earlier skipped the audit logging
> call in the case of failure and to a place where the previously used
> context is unavailable.
> 
> Add an audit logging call for the module loading failure case and get
> the module name when possible.
> 
> Link: https://issues.redhat.com/browse/RHEL-52839
> Fixes: 02da2cbab452 ("module: move check_modinfo() early to early_mod_check()")
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
> Changelog:
> v2
> - use info->name for both audit_log_kern_module() calls and add const
> ---
>  include/linux/audit.h | 9 ++++-----
>  kernel/audit.h        | 2 +-
>  kernel/auditsc.c      | 2 +-
>  kernel/module/main.c  | 6 ++++--
>  4 files changed, 10 insertions(+), 9 deletions(-)

Agree with Petr's previous comment about the URL in the commit
description, if it isn't publicly accessible please don't include it in
the commit description; I'm going to remove it.

> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 1fb9ad289a6f..efa62ace1b23 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -3346,7 +3346,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
>  
>  	module_allocated = true;
>  
> -	audit_log_kern_module(mod->name);
> +	audit_log_kern_module(info->name);
>  
>  	/* Reserve our place in the list. */
>  	err = add_unformed_module(mod);
> @@ -3506,8 +3506,10 @@ static int load_module(struct load_info *info, const char __user *uargs,
>  	 * failures once the proper module was allocated and
>  	 * before that.
>  	 */
> -	if (!module_allocated)
> +	if (!module_allocated) {
> +		audit_log_kern_module(info->name ? info->name : "(unavailable)");

In keeping with audit tradition, wouldn't we want this to be "?" instead
of "(unavailable)"?

>  		mod_stat_bump_becoming(info, flags);
> +	}
>  	free_copy(info, flags);
>  	return err;
>  }
> -- 
> 2.43.5

--
paul-moore.com
