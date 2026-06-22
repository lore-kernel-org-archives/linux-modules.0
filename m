Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0D435E93B
	for <linux-modules@vger.kernel.org>; Mon, 22 Jun 2026 06:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782111358; cv=none; b=YiCkrMhe44VypC5YMCjeywprezaEB01s7wNb7PXCmII7Lde19hVqK4HelR1GW88zCxItwfUKQvzm40TOAJfPaDUpUUmh5VtKndbCjzqKcVNcZXK4CWpi120pQGnaUtGhWf2hmmIWHvTRgAgDXCYGKyo5Q4dTZfTsN9ZlZaF4AfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782111358; c=relaxed/simple;
	bh=LobeI6BatW/+X4E0fI8DO3vMW5iN/E/V97YIWdhrcDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SFuX9MoMWKVYzzq6wsvpeFPVQhdEPv9pXT4DEd21tnj/osQSo0M3pDMXbNMCKCSF0GYMf1TbDD5R1liZERfo8V2q+uMcch92Nj6kJo1MWUDfBXmgXu6xo7vlwDqtnk4Fo2Vg4XM6Y7v8HqcF/zcwLR5RzAxrIAJthJQXVCH+CsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Nm0B2Ypz; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Nm0B2Ypz"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490b64c8311so38380605e9.3
        for <linux-modules@vger.kernel.org>; Sun, 21 Jun 2026 23:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782111355; x=1782716155; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NCxlVcySBiicleY7qeBVFRSV3oYj70sPP3NaBi6h7e4=;
        b=Nm0B2Ypz81abGlsvNG2lcGu/zGwU32M0N0wHb+9yD0EcOtmilFrEaBPJg97+6dgYL0
         dfCHZs3De6KoFbaPEI8MI6EPlb/IkefgmBJoVUBuaDu5VGcPBRypngohK3MJzwf0dSwb
         pXF1W3w4mZgPH9rK72KB4+UA61HiRdhEuUlghg47wjMiqCtiuR7qqhB3N8+IZ/FCqOcA
         ZfImPLZssmMbzqeDjpd8/kPQh3q8xaxm++Xn4jDob0AXe6TqfWNXSFzJAVXuVNwRq5UC
         D05YEMigCNxLEG/oLuIrFroi/76Ppt3mQ3VYc/pbt71TJleGJ3G1l9wS+zYlaID8Ixvn
         9eNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782111355; x=1782716155;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NCxlVcySBiicleY7qeBVFRSV3oYj70sPP3NaBi6h7e4=;
        b=F9oI3Kms/jVUi8/WM3PG1gLE0XIv7l+Evh1IU1mZlKSnVnD1vsUOhuswYY6ZBeFitX
         nlgZd6VcG5fPTBTcUGOGMxWlxbVs+ncbsPkm/4d7uXwl6xwy+FbimIkmVE6w5g3DvuMP
         BOIoxIU64zMMLy1uRbZ1LEcABhW7SKOi0TGtyipERMgw3L1ZTgIttpWUJRKO71Er1Aa2
         /a2LL7n+AO/UiC1CEL+orTrXthHXW4/eAMRFnwqOGRgYmNz5ZaGdHPcLxzMnQ6Dn77vY
         nt1HDOPZMiMRhgb9kGj1fyLrRz6UuVV/XUg2MiGX55aBmjy8fAwq+YWvS5AFbgrHV/L1
         C3qQ==
X-Forwarded-Encrypted: i=1; AFNElJ90qPsRGVoqyBN8wkF9965oD051HNG8DbCNZoT/3IRO5j8diljIbsUwVwR4l3Q/uS03AcAss1mdXPvfHJXu@vger.kernel.org
X-Gm-Message-State: AOJu0YxFJdOmzjUC0utd2JFJsvSPNy7DFH7xvUrCiJo0VdMrVqNEiq6D
	mS3bCT2kqas+cLoeALORQ+OhMQEUKDH0ciDHMfEdJ3IeMNSaC7+TV64rzH9Y3kLrao4=
X-Gm-Gg: AfdE7ckELhl4z+M4bXQE3HMPKeKNDBzPs7NCe89Ar7Efud5DPk40WPQ+5H0fhvFoQKr
	91Q2WRCqKKB2LpaMPWbiGZt5rw1xAE+n1uD+Bd6RgALcps9JYXa+Ztt7uoX4v5PTrXxUdfsKv/N
	VLqStY6VSKHePUFKDcB6aNufdaKgBq2rLGBRmT7vowLHjMt/j6VPWPjvg6BoVNgGlBBGEz9Ylcr
	gFSf5BidrvhctGHImAJPZEWfE+Gs6ICShVnKHoESMBGEVDaEwB7BuFRz+FEkHDY7mtpvaxouX7e
	OVCwasm4er9Zk56VITAM9RT/uPl3UHHoQK1JyMEvHhw6R99Q1/Y+aZAXCnCJooMWXv3kOK/Lx0u
	zr0Qy0219ORdpVxQ9USJq5SfobexyxS3BymTHXgDwJC8hrF3PSM8qwdoJAvteKH4tWtC+b5lvRM
	nLmOXCPa2cGejFjRl0/xXFmuBsF9f3uqun6sR42kDmw9B+5gJjjZNsXaZbl7u6mGKEQyIXhF5of
	fNI8uNZo4iNkAcshLd62BRkzSrtgdPk/p0+84xpkBWyneMVqbPQ9+vIEHdIFlFWEhcJ9w==
X-Received: by 2002:a05:600c:e555:10b0:490:e5c1:b8c6 with SMTP id 5b1f17b1804b1-49240dfd165mr151460045e9.8.1782111355381;
        Sun, 21 Jun 2026 23:55:55 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fd30078sm269910715e9.7.2026.06.21.23.55.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jun 2026 23:55:54 -0700 (PDT)
Message-ID: <31db63df-0a81-45db-97de-67bbe1a1be2a@suse.com>
Date: Mon, 22 Jun 2026 08:55:54 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module: annotate failed-module stats list traversal
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: mcgrof@kernel.org, da.gomez@kernel.org, samitolvanen@google.com,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260621091905.3555074-1-runyu.xiao@seu.edu.cn>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260621091905.3555074-1-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/21/26 11:19 AM, Runyu Xiao wrote:
> read_file_mod_stats() dumps dup_failed_modules while holding
> module_mutex, but the loop uses list_for_each_entry_rcu() without
> telling lockdep about that non-RCU protection.
> 
> The same list is already traversed in try_add_failed_module() with
> lockdep_is_held(&module_mutex) as the RCU-list lockdep condition. Use
> the same condition for the debugfs stats dump so CONFIG_PROVE_RCU_LIST
> can see the documented protection.
> 
> This was found by our static analysis tool and then manually reviewed
> against the current tree. The dynamic triage evidence is a
> target-matched CONFIG_PROVE_RCU_LIST warning; the change is limited
> to documenting the existing protection contract.
> 
> This is a lockdep annotation cleanup. It does not change the list
> lifetime or serialization rules.
> 
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
>  kernel/module/stats.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/module/stats.c b/kernel/module/stats.c
> index 3ba0e98b3c91..79c227a72a21 100644
> --- a/kernel/module/stats.c
> +++ b/kernel/module/stats.c
> @@ -382,7 +382,8 @@ static ssize_t read_file_mod_stats(struct file *file, char __user *user_buf,
>  	mutex_lock(&module_mutex);
>  
>  
> -	list_for_each_entry_rcu(mod_fail, &dup_failed_modules, list) {
> +	list_for_each_entry_rcu(mod_fail, &dup_failed_modules, list,
> +				lockdep_is_held(&module_mutex)) {
>  		if (WARN_ON_ONCE(++count_failed >= MAX_FAILED_MOD_PRINT))
>  			goto out_unlock;
>  		len += scnprintf(buf + len, size - len, "%25s\t%15lu\t%25s\n", mod_fail->name,

The same fix was posted previously in:
https://lore.kernel.org/linux-modules/e4za26n3jj3366oqt47hdwfze2rvsyjcujjhjj4jvbtihkleg6@kxasstqoia22/

-- 
Cheers,
Petr
