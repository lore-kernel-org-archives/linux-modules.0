Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6A128E59E
	for <linux-modules@vger.kernel.org>; Tue, 30 Dec 2025 09:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767086059; cv=none; b=ccTrRkjLFbz3GpHrGCU2pBCIiosdSnKHBTT8aA0GbV7+POlfZ0k4Mw6nJpt45ZgN1WbH1H/wRJ35DRo+MbR/FH+CmXuhX2LVuq21ent7MuIuKculdC3c07J0SvzRgzdIa4HameOC8d01wIpjiz0j5yOzF5AZC+UAo0lezf6FrNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767086059; c=relaxed/simple;
	bh=kMYS4nDZW+xqFk8WFjUw9cG0U0R3IAGkPMZX0g8pS98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QNgoXVBgn2qSPJSWpEfUtDNc/XV6h3/i2BZ5n30BVD9wuEy7fqP0iB5XzjFpxjIp3zs0a3DPw7adti85qFNBXUwtG5tJ7EevlB4xfr33YjeaK0S1fZbvzgKDeUg3f/tNG1wbhhrvRC/QJw3zX7bthMkhQ5GIw/Zay6Ppze5u31k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WEhTu2fs; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WEhTu2fs"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-477563e28a3so59687755e9.1
        for <linux-modules@vger.kernel.org>; Tue, 30 Dec 2025 01:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767086056; x=1767690856; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V6HQy+93eKiQBXRGPg3IyKK5TzImasqN2aR2WZLtqxk=;
        b=WEhTu2fsAIgu6DnvFwF/GqOKZev7dLH4f3Asap4bWY5kgFud9tUD6X2wRgjlo11UHR
         ZqCCaBuN32tspEn2MbyOB7rlRo2Ne6CBLNtJO3tQj7MXE5L7yg59M27VgVTUlPbfMz6j
         H9002fd3pMQ8PXnYGTxbQRhtdU7HxEkNbVw8qLAg4G6wUOEewU9H25xib/+H9nJmu7hm
         RgDSzyirjQcC/88ATOMrgtVY0ndCfceX/5lms+T7j4CVfAUGUY0fMqq/KcvKFkumGBrk
         ZzTqg8ISWUgLMG7amkFvnp89ccsCe27DvsF3MyBpdHFxWukC2inYngj8DuXOWRTiRjbr
         nlPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767086056; x=1767690856;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V6HQy+93eKiQBXRGPg3IyKK5TzImasqN2aR2WZLtqxk=;
        b=EqcOt6gVew2kmRdqKKBfrG7eqfTVLzbW7jJIEpWvG89K2hsW12PAPOmcOJEkseI0y6
         eiBtPMzJe/tb1mty2i7ILIvfxkm9g33NOMZyowezGoELkEA/5ySwBdIw3VylZimYwM9s
         xpo45nvGyClZhD6fRgY4Q/JpVRYV1LifakAs4JLBzzgZ7HudBIs0BV4WLBHxprsdGNTd
         BuWVShsvjhny+PBajNd1iOVByiC9CDmJLaBodc/Xab1leKpKhUFPGha79oVfXBSkww5b
         i4UGXWtZ3GJiumCnlRF8Ivfk4ea9HHZNdjPxn2ahzVi7Eyf5VtY80qHme7aDEh0UNzlE
         WOaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWA868t28tzDBK+2VR9Fep+k3UP1+7Rkq9M84p5Gwh2adg6silzldvtX/8GWkmA9o4e5FzYXDosebPfdPPC@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0sb7gs+PmyXFFnH5TRV4R6AI15Ag+fKDNfrYjwQmBxta0Tz4R
	91ohOjEDlzVxQkEs99G7URedrunLp7nUwJncJe3ZPdl471NUGDh5ySpLJdyfcX7Lwog=
X-Gm-Gg: AY/fxX4u6KlmU4BIvu499X4WdeJp0SxotSMDU9/S7E4ohA1Zft+3T/C++9wW68XYA/j
	H4faCKIoCd96uLDfmSQB+ru6YAEFiyTLz6dPn9NzFOBOQmFued6ypTRmhLyliXUHyXckCmPOzXC
	tDAF1uXxc8wipe6WelTFvze2Th98c0+GK6iO1H++Kpas6BvoIjJ6s34gJxPVDsJC5t2sbGQ8/qj
	nrV+jP7oB5Ljdco9Tmu6SYNMPdploMWJzN+SwBYIVhwtcXWi1hTbUXZqbxNBuyKN26eitf8WC4v
	0nKOzJdDsd1Lbd2hxh+8xw0J93Aj39FGJ9vbhrjtVl9Hp+q+UfLBTTI0FhIdXWc4EaZofTwYgSz
	zqo2g2rSxsJCXXS8PkW/CvSV/i0oZrKCy/9eRPbC9c2EJ4Mi2fQwHFRLGivdPj6KB1n9efDJh4T
	9c9TE9c4DSuRZ4qicNn5khvosj7JexWw==
X-Google-Smtp-Source: AGHT+IFKv3lNIvVVFE/AcEy5+lpmg1H1P5fZOOF4vDE/CodIsqYQs0HP6/eTBXDVP5Nqswfi6ttRjA==
X-Received: by 2002:a05:600c:8b82:b0:47b:deb9:163d with SMTP id 5b1f17b1804b1-47d18b99b99mr353825415e9.7.1767086056038;
        Tue, 30 Dec 2025 01:14:16 -0800 (PST)
Received: from [10.0.1.22] (109-81-1-107.rct.o2.cz. [109.81.1.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3a5486dsm254520345e9.9.2025.12.30.01.14.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Dec 2025 01:14:15 -0800 (PST)
Message-ID: <0d82084c-e633-40ff-b9fe-ce1532f28fdc@suse.com>
Date: Tue, 30 Dec 2025 10:14:13 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1] module: Fix kernel panic when a symbol st_shndx is
 out of bounds
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>,
 Nathan Chancellor <nathan@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org, bpf@vger.kernel.org,
 linux-kbuild@vger.kernel.org, llvm@lists.linux.dev
References: <20251224005752.201911-1-ihor.solodrai@linux.dev>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20251224005752.201911-1-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/24/25 1:57 AM, Ihor Solodrai wrote:
> [...]
> ---
>  kernel/module/main.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 710ee30b3bea..5bf456fad63e 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -1568,6 +1568,13 @@ static int simplify_symbols(struct module *mod, const struct load_info *info)
>  			break;
>  
>  		default:
> +			if (sym[i].st_shndx >= info->hdr->e_shnum) {
> +				pr_err("%s: Symbol %s has an invalid section index %u (max %u)\n",
> +				       mod->name, name, sym[i].st_shndx, info->hdr->e_shnum - 1);
> +				ret = -ENOEXEC;
> +				break;
> +			}
> +
>  			/* Divert to percpu allocation if a percpu var. */
>  			if (sym[i].st_shndx == info->index.pcpu)
>  				secbase = (unsigned long)mod_percpu(mod);

The module loader should always at least get through the signature and
blacklist checks without crashing due to a corrupted ELF file. After
that point, the module content is to be trusted, but we try to error out
for most issues that would cause problems later on.

In this specific case, I think it is useful to add this check because
the code potentially crashes on a valid module that uses SHN_XINDEX. The
loader already rejects sh_link and sh_info values that are above e_shnum
in several places, so the patch is consistent with that behavior.

I suggest adding a proper commit description and sending a non-RFC
version.

-- 
Thanks,
Petr
