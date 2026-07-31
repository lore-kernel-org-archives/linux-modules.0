Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F4C305698
	for <linux-modules@vger.kernel.org>; Fri, 31 Jul 2026 14:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785507695; cv=none; b=JYBqPqqkmOa2qj0agidoRKUyoSwWXyJEdOtuxT43FN7IA0Eum9hC2d9K/qjxYRmmPDg49ueTpXJFsIPHMvF+/wVWkHS63TvQLOjN2nsVQmK87hn0GOgHq2wE9iuvNYI4SYAsdgYOAxB+DnEU8QyvUMnCR7BwS5gV4a+QAaKDBmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785507695; c=relaxed/simple;
	bh=tpcOx82T1i3wP56I++O00dhCkMEesV+OWfy8gFGewqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R0FMAiXq8cUD9tQDrv0y2ZcdjrNyA880jIdeGkfNzBpuuzjkJWFfzlAC3amRCNQz1QNf5MrTukhJR2GfF2MCMF4j1XhrVfpU8uVwRxotrYIC1JJc7TeAzEUUpCBGjrjTGIEbFpuF3pyvKc2wfotuOgHgrIMxI+RGl/0eNn1vvPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GEtANAto; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GEtANAto"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c15f020a223so157764666b.1
        for <linux-modules@vger.kernel.org>; Fri, 31 Jul 2026 07:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1785507690; x=1786112490; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3BqwAfgX6QeSnV97D/RnhlgmbHEZyyQJlqoEom+VcTo=;
        b=GEtANAtoXlxFIGbQZczHpyJ61OsCLXpeO42mdb7WFMAAW9ky84BUorpkeavvg9CPZn
         PT66+DE0iNNPxkLBQfH0Kse3I4bz/dBGEX2Az3N8BP4POprrd3hkMV5BO5BroK3PHRH+
         6ml51ClwHmZOG1ujF/7p+JuLpc5Wn5c2xxZ1Asvyu8LzPb/F+SBvPrZZoGbw7shret51
         uJ/TaW+7rw5uw+WaqtPxj2UTiW/kwkTWRx6Im/Xw2eIaGgw20qeLcJcfypYZXt7hi/Qe
         Z8EzaIyqsNPZs3Tp5/eXQYzP3tf6oyEmzno6AJK3ffas79ZHJ+KJ81hyTVo6eGEoQnsN
         16iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785507690; x=1786112490;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3BqwAfgX6QeSnV97D/RnhlgmbHEZyyQJlqoEom+VcTo=;
        b=iTIjbLhcYF1SbwK9fLCwzwTW1eOXe4U8UTaZ17ktgyuoT7TDiQwhRmy9CKZ0b1JPtJ
         HnvP9E1nWbm6Qqyoh75DFHlBqpVA/Smk4n5+3kEquHtP3+Eo3VNcb3Xv0F2GYCb7Rhal
         1m3IBLKN/EQTNGefNxaHsQ3oLZE1JvA+wOnG47i6Ub49UjKuHjon2VMgkT32eAepJ876
         RSCXsLQhS5VMOh/g7Z4dGdQ/1vu/9CdGLWyi3CGvznNaUkvOj2QGaI3ZrxCd2CUfja88
         tFjWD+J0Gld4M2UiDMWMYKhh66afOOvwovW91aU1eiMNPlQlwrvbyKEO6gTnVnll+Qz0
         v1Rw==
X-Forwarded-Encrypted: i=1; AHgh+RrAgHSgqWC5Mvs2F2iAGCKRtIdvGACwwQQPpb8b2TBExdcwe0wsUt3jjBukdX2auSkOE2vBiU3vCtpXaAWd@vger.kernel.org
X-Gm-Message-State: AOJu0YwgpPIlL2nfCLd7hfpHLqpcXLi+aJOdqqvTuk55D2pWQpaYCGna
	abZa2hw+QV4nohJZFrN8KgkO46bvoVU+ZJVgNhxf3iuBTJWl4hXER8mzXgf7+OTVN4wUGG5RyQ1
	Lnz0r8mU=
X-Gm-Gg: AR+sD13EMQWIx/TAsuatdvvE6xnO12xGrCaAOHFtQnw+OZ5uL/kdVnGzw+9cz2x1nVN
	zcDNggtAaXwckVZmtWR6EYOkUyq6Zx64mfSvRcY/PBD8UVuRWU2sLuStaxMAotJqaXfH/wZDtIp
	LVArzVvvldojO8LX3WLVruGe/EGvhTg0ZWuFsN/yrxWditTjNXqm29HBIeDU5VNxOOgxWn7s7FM
	vB1TlVpBO1NJ1ykBeO94eW+zHaCNlCH03Y2mZzjtJEdRVqarIgUZlOhu79h7mddvE6GGBIT9ZzU
	I8PHe6f5LN2n05ibTq3M/DCxHwY+UJI5ERaj5yXX/E4DYhgpYQZDMfjz/pcylbgRJmFCB3iCbPI
	NmZ2AWCtQJLwh6486z0HbXKmZldD28OBo1zbETmNe4tu3DFedqMlX6PLanG5hOf8JMGSg9wBVIQ
	WP8sTDRT24CPNkk8DeG9KBDLjY/E0Lxe1a6O4VhTzWNiPb1FVi0lEp/V8hLUlPMVDy/L2y0mC4s
	6nMyFFxuLsne16fRwLdKmvgPw==
X-Received: by 2002:a17:907:944d:b0:c15:ce72:9352 with SMTP id a640c23a62f3a-c1fd21c33c4mr165122166b.33.1785507690113;
        Fri, 31 Jul 2026 07:21:30 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:fc6c:f9a2:4a0a:6354? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fd3c90739sm162999266b.14.2026.07.31.07.21.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 07:21:29 -0700 (PDT)
Message-ID: <b5d285a0-1e72-443e-aad0-dcac32d00d01@suse.com>
Date: Fri, 31 Jul 2026 16:21:28 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] params: fix charp corruption on allocation failure
To: Jiacheng Yu <yujiacheng3@huawei.com>
Cc: samitolvanen@google.com, rusty@rustcorp.com.au, hannes@cmpxchg.org,
 yosry@kernel.org, nphamcs@gmail.com, liuyongqiang13@huawei.com,
 linux-modules@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <ff0b7cdd-8fa7-4cb8-9e21-6a7204809766@suse.com>
 <20260729123243.790023-1-yujiacheng3@huawei.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260729123243.790023-1-yujiacheng3@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/29/26 2:32 PM, Jiacheng Yu wrote:
> param_set_charp() stores charp parameters in allocated memory after slab is
> available, and releases the previous value when the parameter is updated.
> 
> The previous value is released before the replacement allocation succeeds.
> If kmalloc_parameter() fails, the setter returns -ENOMEM with the parameter
> left as NULL.
> 
> Failing zswap's compressor update before zswap is initialized can later
> trigger:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>   RIP: 0010:strcmp+0x10/0x30
>   Call Trace:
>     zswap_setup+0x3b1/0x490
>     zswap_enabled_param_set+0x5b/0xa0
>     param_attr_store+0x93/0xe0
>     module_attr_store+0x1c/0x30
>     kernfs_fop_write_iter+0x116/0x1f0
> 
> Allocate and copy the replacement first, then replace the parameter value
> only after allocation succeeds.
> 
> Fixes: e180a6b7759a ("param: fix charp parameters set via sysfs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiacheng Yu <yujiacheng3@huawei.com>

Looks ok to me.

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

I'll give others more time to comment. If there are no further concerns,
I plan to take this on modules-fixes.

-- 
Thanks,
Petr
