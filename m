Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDA32FD1D6
	for <linux-modules@vger.kernel.org>; Tue, 26 Aug 2025 09:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756201250; cv=none; b=ch5P+gjKFv8CTZL/+VUhA+eZn4hcs8orz8jtlPyhv/Bt98jN/uCE6FdwRpGoZmMhEcivbRv6dp4TLiu3zSjn7VRYpDN/iL1yl0gWOKyuABxyGAxlG3aSZFT4fEEgaDNxcIgcEHHiNoMJwd1bMMx2ApVVLWrxVjC7Hrw4frPTFDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756201250; c=relaxed/simple;
	bh=AGBn8Pm5ZQvv47t7Fbng001CdFdEU98XiOFr+OF2kX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=dlyaa3NE3Z/TAbSZCtWeKYfdadSgxg5jkmHHlL/qTWMG9twOYTIMydLp6lYcM9qpXClY/yOR5HxYoXTfUHmh39RNpPmPfAaaoq6ZZTWGPE5KK0AVmS8vLa7hC96JIv/qus/56/k80IJF+BwK7YmvOQR5fU9h+IU2oFRsCmMbtpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RnhpfBZn; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RnhpfBZn"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45a1b0c8867so44214135e9.3
        for <linux-modules@vger.kernel.org>; Tue, 26 Aug 2025 02:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756201246; x=1756806046; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RmW9WVClm3f6KinkC1PQhkR7i8nz98kjlYD1LHvaqNI=;
        b=RnhpfBZnrBv6+iAI/5vYJcSNUwejx6Twj+j4Tdafr/rfqZ5LzZ6rsjy3NjVqwGYzNI
         WuaKtquZpR96c+WYAr/HkdxHEOoAeqkEZEt2pY+2wxRXz+wJKlZ6N+eC1W52uKrIKcGQ
         x4Muy+voz+y/n9aHLE3LkwPxs/O4PZddUv+FS9yQrLZXdymL09X7uUgtfWEJmOKeKyUu
         EeiKZJuqcGA66h6MdK8IoHDQAklJuUoshX559AuxiB4GRoXA4lNhkE4i66giJg1rgg31
         jc8ffI4W+ilvtDc+ilvAWyDpeFxifQ0JK362efschcGm31kNCJCGN6JvLt8C3ynosiEC
         R42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756201246; x=1756806046;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RmW9WVClm3f6KinkC1PQhkR7i8nz98kjlYD1LHvaqNI=;
        b=JQV5xkM2eSuVcbB4rLzcluhipO1uFFKPRngr5BjxBUKHSHcr+OUuZfJypUGjFMgJ7F
         oPaTifCRlmfZsakT3RMjW2pLivnuyS6WOXaB1xQ7iaC8I1MXSbVFc3pnQk+EVe4fwlql
         pNAlFuEDjq90LsybYILd0z3zND/+x4epwrQooFVZvhByPVJYfS3zp1d4nouq1qJXLHAS
         GSENb5iC9jLIw2oxdvfbsdl3PLzjGha107wGzCqYza0a3zBQTslp3IHU1F7Nx+EOhWeb
         N/JfmtCaQ87AjhZDAy7EoT4ZfWFWwkUlc8uf2+VBcwDTWR8rtkKpKCD73XaK2vaV0JtL
         /scw==
X-Forwarded-Encrypted: i=1; AJvYcCXpgwL8Q0v5TOfQd7x3k+ecqgNidBF+Nd5LCsntv9rvOC7qlKLwHK6B7Twp3L1C6g76r3MewHV6T3dW9Pcg@vger.kernel.org
X-Gm-Message-State: AOJu0YyFebMGiEyYHgyEq7oADb1ZymQd/FpAFIYaaBQaNPkQqW5ajbgK
	jUUaPfce5KK0t+9+vTjXdbgGSU2zCcfS7dsT2iF1FrYMJKtcLOqRoW0DfCF5hEcw+fI=
X-Gm-Gg: ASbGncuN6w4EQIF9kHGyJW4HBJ/FsatRDGzI57rKfDuzCgvmT4sqrJHQf1fIvZsi/Ad
	/HWbSyEmwCqvQdHOE0iQzMaIna3e4VzhdN/XUYYVx2EwA26+nHCoWW3R9FNlmnM/vB3d5Sc1WWU
	158OLBdS0HuLbtEMHbrQBezQAVtuuCLgHAR2JbW30xXTdRH/3nYqAHhcYxsThaIwjDuUmnL1zwo
	F+y1uYG6oa2yLjB5RZiV+GusGOZcGu003irUiZYyqOwg53YYaskzxblQUczwWAzJWRVn+A9URIp
	mIFCSmMVaqVIkUL+Q/DMhlCeDp7g0Aw4cN5LO1NHFfs2rC/8bfAWXnfSof6duOx+RCUkkVuP/hm
	mo/zeUPT8LN+dciT1ggUXOQWiWDfd2yLquxcK1H8bENA=
X-Google-Smtp-Source: AGHT+IGadEAi5vgTIHfrDTRU1InxzIYf1pFLVSduxjE5Rz0z6YNs/7SKhuJkC+bMVRkDVFaBXt1NrA==
X-Received: by 2002:a05:6000:26d1:b0:3c9:24f5:46ff with SMTP id ffacd0b85a97d-3c924f54977mr4477737f8f.34.1756201246265;
        Tue, 26 Aug 2025 02:40:46 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24882c84b6esm612705ad.6.2025.08.26.02.40.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 02:40:45 -0700 (PDT)
Message-ID: <14e0f072-59e6-4657-8ab1-fe1fbc30ac43@suse.com>
Date: Tue, 26 Aug 2025 11:40:39 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] module: centralize no-versions force load check
To: Jinchao Wang <wangjinchao600@gmail.com>
References: <20250825091545.18607-1-wangjinchao600@gmail.com>
 <20250825091545.18607-4-wangjinchao600@gmail.com>
Content-Language: en-US
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250825091545.18607-4-wangjinchao600@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/25/25 11:15 AM, Jinchao Wang wrote:
> Move try_to_force_load() call from check_version() to
> check_modstruct_version() to handle "no versions" case only once before
> other version checks.
> 
> This prevents duplicate force load attempts and makes the error message
> show the proper reason.
> 
> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> ---
>  kernel/module/version.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/module/version.c b/kernel/module/version.c
> index 2beefeba82d9..3f07fd03cb30 100644
> --- a/kernel/module/version.c
> +++ b/kernel/module/version.c
> @@ -41,10 +41,6 @@ int check_version(const struct load_info *info,
>  		return 1;
>  	}
>  
> -	/* No versions at all?  modprobe --force does this. */
> -	if (versindex == 0)
> -		return try_to_force_load(mod, symname) == 0;
> -
>  	versions = (void *)sechdrs[versindex].sh_addr;
>  	num_versions = sechdrs[versindex].sh_size
>  		/ sizeof(struct modversion_info);

Removing this return completely means that when versindex == 0, the
function incorrectly looks at the dummy section #0 and eventually
calls pr_warn_once("%s: no symbol version for %s\n", ...).

As I outlined in my prototype patch previously [1], I think this should
be changed to:

	/* No versions? Ok, already tainted in check_modstruct_version(). */
	if (versindex == 0)
		return 1;

> @@ -81,6 +77,11 @@ int check_modstruct_version(const struct load_info *info,
>  	};
>  	bool have_symbol;
>  
> +	/* No versions at all?  modprobe --force does this. */
> +	if (info->index.vers == 0 &&
> +	    try_to_force_load(mod, "no versions module"))
> +		return 1;
> +
>  	/*
>  	 * Since this should be found in kernel (which can't be removed), no
>  	 * locking is necessary. Regardless use a RCU read section to keep

I suggest that the reason message should say "no versions for imported
symbols" to indicate which version data is missing and to be consistent
with check_export_symbol_versions(), which uses "no versions for
exported symbols".

[1] https://lore.kernel.org/linux-modules/3992b57d-3d8b-4d60-bc4a-f227f712dcca@suse.com/

-- 
Thanks,
Petr
