Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6E715665C
	for <linux-modules@vger.kernel.org>; Thu, 13 Feb 2025 15:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739462261; cv=none; b=ORShoGYq0TNkPxFNsFAcz1dLbX5PMmkuNaaQ+6Gx/PimAgs3NIv8QnsPQcrNtKA+OZVvXYL9kbFYgIlC/CejBHb5NUNaWv086a7aWhkmSkhGy/PjL9z2XPzQ7xGeIpXm/0KHsG0jlzuxbJv6GcZ5dsQ01ejE8nTOPPAcjHuHunY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739462261; c=relaxed/simple;
	bh=frjmkr3xCPkO6AhMmYzJCUdfBDQUprIUBclYA5ZTRZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B6JzWOLLS6AKKYfYjGzhu17U85E/dIWE2Q6IFbH+wHk8m8yojgorIP+T/PYfrwvEKYZYHYMPuXaIJdgAQoyiFvd3tETf2GtYU6Fp0tzQx2/OnQ12wdD5BaybEEz9Dupk8Hec5UxlKuUy62FXeI10zZ6/1F3ryfrRvpjbhrL9af4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gqTKEFJO; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gqTKEFJO"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ab7f9d87b96so168689966b.3
        for <linux-modules@vger.kernel.org>; Thu, 13 Feb 2025 07:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739462258; x=1740067058; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JZ7Cx13VrPkP8+VctSLdTrFIVV214IFQtD/nhF57l7Q=;
        b=gqTKEFJO+AomWXRN9HA7VDm/nxelvTNwQh7S+UmRqQ0HLMpulKT7mg86dWnX2yfmLo
         OT68bOQikZcCqifbXyekRMCR8NGFqtR0wUZZV/nh4U6LJw6AfUFzgHgxkOzgRcZWSHE4
         QGA0SgGZtRHZO47o2qj0yEWeRFjqV/fXhTIjZtHpxZScL4SEp1V0AkbcO0pVcgmk814l
         jXUHHS6dQ1LFuVbPeUjxgXHZPxS+mhMhNtRw4G8+ALS23wi8bHBxs/9Ndl4X01rnDT2W
         o0bf1hvh2es+0N6oyBLnIIW4F+hda5AXGERnzGVKtneSfAJfyFbk7XTdWkv62Jp9i/LX
         dhlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739462258; x=1740067058;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JZ7Cx13VrPkP8+VctSLdTrFIVV214IFQtD/nhF57l7Q=;
        b=s9mqcKJnIWyP+tr71Oj8AnVWAJcxyTscKX+vH+WvZkRAxHL4UaSzna9w5IMRLUjBH1
         KNnV6dsr0NiFSjSzK799M5aO2VFoPMoNxkWvibyveWCq0v012SH6eez5Di4ZNCOFP7HQ
         ZkEUptWC1GHSprOor84PAjPzXKVw6UkJkwIbWmctx7JyK7smwdpFIxayHdCJD6vx5ymp
         wvPC40KwSvPQnDwMq1Z6oD0ST1P/sTDaAxTo60MRG0QAiMJ080iB0VVbJi4uZXkXyWo7
         i78lrthsOmmR99agWGOFVveF4r5aQMtIcBzYUJLkRKVdnzPu0YZ/c/SHPJ0hP01hb4r+
         91kw==
X-Forwarded-Encrypted: i=1; AJvYcCWbUKGb8M0cDtqYPEaFoKSeSuVfj3bM9myTmjNFvfUIy+/OdnYFfh7QGvCHFdYvC6SFHPl1YdYCQmQQRXVS@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqp/1CoTl1Gr70fVRPiFfiVZkduMYhfHZor1rRSSFzYgnDcaGX
	0Rf9VRT5/uEOVvXaPwsEGQN5dlvW5K9YNt0/FOqe8nq/mde1PlOdkgSQb4LILKWy1+RUXENn2u2
	c
X-Gm-Gg: ASbGncsApjKxNS+NdbVBGg+gCVRpkJikUJIFgrv1+seIG3T1iS+rV+yJsFz6xGlUEaI
	n5Zb08tZdZaltXeQ7vCzEvP+XnmB8MtJzYPInp77Gp3XICiebclHaqyeVfOFHi0lU+V6uIa5IXL
	D7WFctf5j07kf/DBkPXWK6UznXltkh3YX5aY/wGgQ3Nn04nB6hXc1VRS86vIK8C5NblHREqZZ1M
	7db4Dck+z1j+LYpGoXlifADQPu7wEskJuRCKncjZsOJ7V8L0JAp+4r3qgfGB2v9m/AAfxojI4/4
	cocZ020taYVcyDzD/C4=
X-Google-Smtp-Source: AGHT+IHhqe1wbcVZq5bYL05C/nHzZU3ubfoUcIbOrRCAGceVtB02UDx0Y5OoVZE9bABlHjUFF9FIJg==
X-Received: by 2002:a17:906:f8cd:b0:aba:620a:acf8 with SMTP id a640c23a62f3a-aba620accdbmr14943566b.24.1739462257718;
        Thu, 13 Feb 2025 07:57:37 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba53376af2sm155974866b.119.2025.02.13.07.57.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 07:57:37 -0800 (PST)
Message-ID: <0631f7fb-423a-40a8-a6c1-1f307c1efe96@suse.com>
Date: Thu, 13 Feb 2025 16:57:36 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] kernel: param: rename locate_module_kobject
To: Shyam Saini <shyamsaini@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 code@tyhicks.com, linux@rasmusvillemoes.dk, christophe.leroy@csgroup.eu,
 hch@infradead.org, mcgrof@kernel.org, frkaya@linux.microsoft.com,
 vijayb@linux.microsoft.com, petr.pavlu@suse.com, linux@weissschuh.net,
 samitolvanen@google.com, da.gomez@samsung.com, gregkh@linuxfoundation.org,
 rafael@kernel.org, dakr@kernel.org
References: <20250211214842.1806521-1-shyamsaini@linux.microsoft.com>
 <20250211214842.1806521-2-shyamsaini@linux.microsoft.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250211214842.1806521-2-shyamsaini@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/11/25 22:48, Shyam Saini wrote:
> The locate_module_kobject() function looks up an existing
> module_kobject for a given module name. If it cannot find the
> corresponding module_kobject, it creates one for the given name.
> 
> This commit renames locate_module_kobject() to
> lookup_or_create_module_kobject() to better describe its operations.
> 
> This doesn't change anything functionality wise.
> 
> Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
> ---
>  kernel/params.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/params.c b/kernel/params.c
> index 0074d29c9b80..4b43baaf7c83 100644
> --- a/kernel/params.c
> +++ b/kernel/params.c
> @@ -763,7 +763,7 @@ void destroy_params(const struct kernel_param *params, unsigned num)
>  			params[i].ops->free(params[i].arg);
>  }
>  
> -static struct module_kobject * __init locate_module_kobject(const char *name)
> +static struct module_kobject * __init lookup_or_create_module_kobject(const char *name)
>  {
>  	struct module_kobject *mk;
>  	struct kobject *kobj;
> @@ -805,10 +805,9 @@ static void __init kernel_add_sysfs_param(const char *name,
>  	struct module_kobject *mk;
>  	int err;
>  
> -	mk = locate_module_kobject(name);
> +	mk = lookup_or_create_module_kobject(name);
>  	if (!mk)
>  		return;
> -
>  	/* We need to remove old parameters before adding more. */
>  	if (mk->mp)
>  		sysfs_remove_group(&mk->kobj, &mk->mp->grp);

Nit: Please restore the accidentally removed empty line.

-- 
Thanks,
Petr
