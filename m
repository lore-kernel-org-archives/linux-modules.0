Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2433C333727
	for <linux-modules@vger.kernel.org>; Thu, 20 Nov 2025 12:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763641867; cv=none; b=FO1pQY82Vn3uHB3Lte6thlFH3+tN1ZOjcyswFYFQL2ZyI7OWb+y3DSdDw+zFS9g2wlLp07dI/goXjVx9PPYOm2Rux3+E5Q7PcvV56JXy3kOWA5nmYY2aLWRL63AuvKH/2h3h1DDWbSnq35zZQNTjyrAccbVFzkTUmlkDCC5ZTWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763641867; c=relaxed/simple;
	bh=7IwoWSZlfeD5okirxUpGyO7IwlQwYODhU3cln4El7rQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SFYdeI1eRtGuzKApq2UfHOfU+eVGtPOzpPZbobiCIzJbb/5ZicLiwBNXkvFVKovG3IB1ePLqxmIpH0IxMQbZLnYbJgoGfkHWWvyKT4H0cQLWOamTrU8Ul9ikSXixeF7VfyMBUsIGx6TqBHLAlx+OF7x/TaTT++/nhQ4XgQmLY3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fJJi+OBf; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fJJi+OBf"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4775895d69cso3731095e9.0
        for <linux-modules@vger.kernel.org>; Thu, 20 Nov 2025 04:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763641861; x=1764246661; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jS56hEMd80c4W90b7ePqVGHkDPIjZ5fhyUWu6DxnmCI=;
        b=fJJi+OBfGFM9GCZnEFoF1MhBSfUq3xlsDysp1Lg3PzWBysuTGBcxIMCrgx+C3dcHVp
         pT1H6w75IwBK5psjAJSj4lY3QubWMt7y1rgixg59qpVHOQFjlQKCUqyrrtt/ct6t7vLZ
         Z7PgVJS6omX+ia+KR2yyYDXofwyKgKxdqqBbxAORyeaXhu8BvBlUAVplRxNXDxevhMm4
         QoLAori+pk0MABy9Ye8mFNYs24dZlIyEnT3VfTkkBGMGQrD7fIWgpn/r87vE+iCwsBYL
         mm7qzDXU8CWpZUZpDaRr5iEd1Dk0DjykQ4F+E4+v3AbPzISynQUkyulqd+D2O+H/0Wrl
         IQSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763641861; x=1764246661;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jS56hEMd80c4W90b7ePqVGHkDPIjZ5fhyUWu6DxnmCI=;
        b=ZqJv7/ImpPBrjbhXuHLcMJYLtCOmsUKDzxj+9+YLTLxsOiovYRbp+UPHh2zEda/7RS
         npWFBV3M0GJ9l7sORUd8xnNIMEp2XJCJ62qkiYjhhoZ2C2gMwTkH2lUnOmxFEJ2TYyna
         lbNyIVf+H04/s4dnYKOWDegRuTrgwT6XVfS4Z8VxNOlMcFNdGNFY0MPdnooF4Djq2js5
         bEjdVdqB7mrL/kQdxajP5FCxXDwyGdgw6TtJHH47xllM5RjZTBJXK7A7Z5w3uaLd9zeR
         O1FpjFNJ/wAsXczAWzduFv3TF3IyshQ67hNaxp9I1+JOGTD5blaiUdfFVL6Q0Vc6RRtL
         e6Ow==
X-Forwarded-Encrypted: i=1; AJvYcCUAp1VVxGBq17TbbFKsK1OWfnQagbW0paFXj8Nh3xbzV7JA+upnMOGRcNVHdBHgUluftrGoqStbFVgmjHAw@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6bj/aceXiabD3QQ67y0PFSL+g7ZYA79JU+wClRheqVpJVvEtQ
	2lsTSHdID+d6IWJ5q3dQzd2CcxxFaAj6dyIv1vzi6runCgWMoABhW+jhsUCoRFzyAeA=
X-Gm-Gg: ASbGncuLRp1e45KRQcVZiQx9R9FJdbfOHKnfow1MvbbynlpOEaD7GtrDV4EINlt9adW
	Yz8YSNh5yn8wxTaMxDuf9AyzR0CtipxR4l7RL/HK6rNscXNbiRyFrSJQI/KKIZWOx3/4eMczSl7
	6Wu5rB+YTFQMgTD2Y2DsKIXj9+0ofFa6V29LGBlebgrtyok13XzBgHlLWlQUzGdkk1hf3Shx5Fe
	huoWjGAzqL7tBQWbXT9WUiT1XnWvt6e+8QxfJV3om/rYBdjk6aqL8ka+a7lD5USk/v4WMqk+AYi
	HhOcQ251CBm/Dj3YDFY7ZU1Dvs5V+2KZ14TWkLptjw/4vMtpWFT8sC2cIIFwzxMql8A3eC960F5
	y93mi5qVu+LRvZ02Wf4Nw+ztXJ2UWdy8g0mlV3QsXllmUQw/DZie7sFN3g05EerfidvGdZZa5SK
	l1e2M/W711w7/Sw+1nFYbCQz4E7aXsA2/CIIVVFTMo01o9JwGzqXwOrGT2E6y78F+YGRpovsYY0
	sqGB09wmmu0F54L1YJ2Yh7PG7mPKC07B41uLs9f17Xz3gm1Nd3+hav0vxer6fYFw6a4
X-Google-Smtp-Source: AGHT+IFwX0UGM0SSqywlXCPNUwgxiVVdpIXKUYy8u1ykfZN73v1I5KjuFyvBESlgJXXjTswqxF6tTw==
X-Received: by 2002:a05:600c:1f86:b0:477:73e9:dc17 with SMTP id 5b1f17b1804b1-477b8c935d2mr35700965e9.35.1763641861394;
        Thu, 20 Nov 2025 04:31:01 -0800 (PST)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b82cc6b9sm46456965e9.3.2025.11.20.04.31.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 04:31:01 -0800 (PST)
Message-ID: <d6632fc3-17e2-4d06-abbc-413bb6478db4@suse.com>
Date: Thu, 20 Nov 2025 13:31:00 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module/decompress: Avoid open-coded kvrealloc()
To: Kees Cook <kees@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, linux-modules@vger.kernel.org,
 Daniel Gomez <da.gomez@kernel.org>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20251119225439.work.741-kees@kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20251119225439.work.741-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/19/25 11:54 PM, Kees Cook wrote:
> Replace open-coded allocate/copy with kvrealloc().
> 
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Petr Pavlu <petr.pavlu@suse.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Cc: Daniel Gomez <da.gomez@samsung.com>
> Cc: <linux-modules@vger.kernel.org>
> ---
>  kernel/module/decompress.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/module/decompress.c b/kernel/module/decompress.c
> index 474e68f0f063..36f52a232a12 100644
> --- a/kernel/module/decompress.c
> +++ b/kernel/module/decompress.c
> @@ -17,16 +17,16 @@
>  static int module_extend_max_pages(struct load_info *info, unsigned int extent)
>  {
>  	struct page **new_pages;
> +	unsigned int new_max = info->max_pages + extent;
>  
> -	new_pages = kvmalloc_array(info->max_pages + extent,
> -				   sizeof(info->pages), GFP_KERNEL);
> +	new_pages = kvrealloc(info->pages,
> +			      size_mul(new_max, sizeof(*info->pages)),
> +			      GFP_KERNEL);

Nit: Using the array_size() alias of size_mul() might be clearer in this
context.

It looks ok to me in any case.

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr
