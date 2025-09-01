Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7AE307AE5
	for <linux-modules@vger.kernel.org>; Mon,  1 Sep 2025 09:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756719015; cv=none; b=s9qLarUrmHqeZ1GDR68/rAa16Imx7Zjsrk1e/JvcFcydbDPNN2LsLQdh+k86iuHNxsksNM30s87G+xoUMHAhBAIKZCCX4xoOAZMXWoCWyJqnmqwc+xmMeQIKsMbYx4pzAGWF9S0worFj1WQuoxjcNJ1xo6PLJW3l9D6KmxCTxZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756719015; c=relaxed/simple;
	bh=a0NDcR75d+O/mfjnpFO7rOU4DSlH61V/u19FiJLYD3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=PSjv9fkAe9kyntE2PzNR5BeG/+LY6dKuu+o31rVHebi5F8Y3CRi6EbA61wVeBKxlfI1glN0gpoz4Il4hvuvy5kEEce52jR+CrZsokMYo+9q7eDCujnk/4hnSLnznSRNMDKphzUHX/rrRTfYHeGf6PfuQYOQLFJ508AvP+dDnu9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KQDJez3P; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KQDJez3P"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45b804ed966so10647305e9.2
        for <linux-modules@vger.kernel.org>; Mon, 01 Sep 2025 02:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756719012; x=1757323812; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3O46In+nyvkhXwMUza5HjmWuLjmeqVrP/Df0WayjpU4=;
        b=KQDJez3P8MXsZNd7CIFUg3YNM3HXEhEomN7FQnIqo4JoKepCjpPJxT4wVa5Yh1n1gd
         3/gxTJR6VYiGEcsffnGgQsMaL71vLGQmFxYSf49LKVAzLlP7TjPTMRhSOTy9vX6gD499
         5gnDAqda7T0epqZgNmKo23CIR0qD2HMqF86zhs8VJ96h80nSY7NqNu9PKuFMV2Xbsv57
         TOQ7IykewhvTA7DAPLkjO3oKF6MatpgoPPymxgfHNneD2IJqWDFq/5UZKTOIUIpOJfxI
         rMWhGUtn2XvipeaJOd0t/J+qBe8lsV+BRL3BPEG3VvZHfkkHxY+62zSPmXGhXsw4a9xP
         k1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756719012; x=1757323812;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3O46In+nyvkhXwMUza5HjmWuLjmeqVrP/Df0WayjpU4=;
        b=onlC+aN3onPVUZqrbp9fHkWfophugZ57FHlJxXfHx4r2pK4uyV3MHjHCkkh/0bfUvq
         LHwPfTGD8yA7GXOdDTRcBL+DEaooIvusucZHLHRYCgrb9vQQViFmz4e7x2OKXzTiMvaY
         PUhFxfr+1hpKzSsUHIl2r0Ui7KT5XPX6mkRmJWYqS0EmcSd30uDqDBXgXLjD9eblCB1K
         pDjhZoQ/hw/sk1BvrhGAv63UKsQiSEgjKHmIVZ8uLu6VEoGbZh2MMikzfqluWZnngX9n
         PvOJwogX1BygHd7rhU82VRPXspSEJHnZ6Xc31iWxt0WMi09oyykh5l9dpwtZlfrnTFBO
         xyuw==
X-Forwarded-Encrypted: i=1; AJvYcCXiIjPD361Rf539r4oiTL3nxE00XJ5gr1ET+UERmgyGbHejPIDQp6SLw3DRVnvWwx5wBb8ACc5RWuL4uOF/@vger.kernel.org
X-Gm-Message-State: AOJu0YzJBPeNrRmG5w1fVkMbtdqI9jXYQCQ2BW0Fbr/MCn3GdIyLUrya
	YYPAXBVO70zPqnPBZr/Y+9QTnQ2FZ1q0UY54vQFitqvD/gWdrDiYzX4EmsJi+zJodaY=
X-Gm-Gg: ASbGncuWiWYRT/kxVV3Wj0MFzNRCJUh0hQV8SSIejPbN7arLHbQHMyYDXb/izyYJCpz
	aDUuDU9Thde2KiRhvkEi6DQwQyenRY+JzUsmW542npIUD2DNONXP3msdkDTBV44oK6zzI4HU6+G
	RxzBGxWq5oYOxokJA/CzseDgsAvgGKiflG+uQu7vGirRfgz6HXO3UOgUCvV8jd9AkRkSeX27a4C
	0gW/9FoUbL1D+12Um1/OgeILuI7KK2EqwcMNcC8L/S0XZ3crw/8d8h1q7u4etKQKzIFIi6a9cJZ
	jWFa2UZHr3Mjd9agnY21R9thnSUBsfk61zpJUIrT3PO+LfBuWaaWJOL2mkSG5XGRTt5wxvV0GEX
	buIO6vJBTBrmGCHqFIHZEmkqfHoydUXzUjO1HdQ0Gj/AvDd9LSkujkg==
X-Google-Smtp-Source: AGHT+IHbfldmXalTHs74Qjn+LCgHIRtognchtI6YU5kylx/Aeh4PMN+YtrSztzHAM0TUn6JS1ozS9A==
X-Received: by 2002:a05:600c:3543:b0:45b:8822:d683 with SMTP id 5b1f17b1804b1-45b88321c6dmr44024635e9.4.1756719012076;
        Mon, 01 Sep 2025 02:30:12 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b73cf86f4sm207103535e9.6.2025.09.01.02.30.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 02:30:11 -0700 (PDT)
Message-ID: <5ac979fd-7a84-4633-a53a-55be955faed4@suse.com>
Date: Mon, 1 Sep 2025 11:30:11 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] module: centralize no-versions force load check
To: Jinchao Wang <wangjinchao600@gmail.com>
References: <20250829084927.156676-1-wangjinchao600@gmail.com>
 <20250829084927.156676-4-wangjinchao600@gmail.com>
Content-Language: en-US
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250829084927.156676-4-wangjinchao600@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/29/25 10:49 AM, Jinchao Wang wrote:
> Move try_to_force_load() call from check_version() to
> check_modstruct_version() to handle "no versions" case only once before
> other version checks.
> 
> Suggested-by: Petr Pavlu <petr.pavlu@suse.com>
> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> ---
>  kernel/module/version.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/module/version.c b/kernel/module/version.c
> index 2beefeba82d9..7a458c681049 100644
> --- a/kernel/module/version.c
> +++ b/kernel/module/version.c
> @@ -41,9 +41,9 @@ int check_version(const struct load_info *info,
>  		return 1;
>  	}
>  
> -	/* No versions at all?  modprobe --force does this. */
> +	/* No versions? Ok, already tainted in check_modstruct_version(). */
>  	if (versindex == 0)
> -		return try_to_force_load(mod, symname) == 0;
> +		return 1;
>  
>  	versions = (void *)sechdrs[versindex].sh_addr;
>  	num_versions = sechdrs[versindex].sh_size
> @@ -80,6 +80,7 @@ int check_modstruct_version(const struct load_info *info,
>  		.gplok	= true,
>  	};
>  	bool have_symbol;
> +	char *reason;
>  
>  	/*
>  	 * Since this should be found in kernel (which can't be removed), no
> @@ -90,6 +91,11 @@ int check_modstruct_version(const struct load_info *info,
>  		have_symbol = find_symbol(&fsa);
>  	BUG_ON(!have_symbol);
>  
> +	/* No versions at all?  modprobe --force does this. */
> +	if (!info->index.vers && !info->index.vers_ext_crc) {
> +		reason = "no versions for imported symbols";
> +		return try_to_force_load(mod, reason) == 0;
> +	}
>  	return check_version(info, "module_layout", mod, fsa.crc);
>  }
>  

Nit: I would prefer this to be formatted as:

+	/* No versions at all?  modprobe --force does this. */
+	if (!info->index.vers && !info->index.vers_ext_crc)
+		return try_to_force_load(
+			       mod, "no versions for imported symbols") == 0;
+

Nonetheless, it looks ok to me functionality-wise.

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr
