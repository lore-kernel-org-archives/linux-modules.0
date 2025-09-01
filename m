Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDCA30E832
	for <linux-modules@vger.kernel.org>; Mon,  1 Sep 2025 09:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756718754; cv=none; b=OZG1p5tTRyclkR0PuZxtgEX3wahtFr7zlx1Xr5aDfRiKMcrVsCbK4Rpt9i20NtgmGqMUVi5F/Kv/qkUIP1ywKvxKxOVW0wMaEB6/oW9x+NAPSsOf+2CNOsAe80EkXGdiFWMAqB/bXeyG2H2ITUBwSnsxepMRtTg3kuZfz3Ste4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756718754; c=relaxed/simple;
	bh=OfCtjCeji5QTOGG0VnIXm2TGKggGPa1xLAugRo6trh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=KML2pO51xd6jqYDQHCtjPpGrR9gWcpPa6GjoLvcIwzQbdADk+8E1QreRBfhmhkzZuyMX6rOE4TToxsKnpPHktO1lWgbOf8JjSXVkXLu4y/GbCCfzu6ir0+4egUuJeqtZ/6PfQOIC8DP+i8xFYleZGS82TL40x3nOT/m9vPpn9NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JnGw+/ee; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JnGw+/ee"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45b7d485204so31879355e9.0
        for <linux-modules@vger.kernel.org>; Mon, 01 Sep 2025 02:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756718751; x=1757323551; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DoiamaT9JgY6KY01GFvVf/2Zvff95izr/pO7afYWIxE=;
        b=JnGw+/eeT9GOAAeHN9/ae99UtpMGA1AcUnwwTneMkhnQt1+oXLIpOSRp54WqmkbqC5
         3lzw2lXOW1pSQIbB7UTNTkyDEIbRo8RsalkemR52eYRkxz9GFc6cs2VD5FoHxj4C400K
         o4wjLYmuh1IMd3MTa/ubtwoc2Dq6MI5WtZMmphSVmM91eFXnAypWmq7ANFhOc3pgZkN+
         FGpoR0N8MG7VuR3et3aokjWMnyyRvawmjSLFST7TmXJegx40U5s3rV8cZE/wlh5nz4M8
         MrVg0oHLuNnFUQTNcuMLPoF6DgB56RdI3wgeHQmvJasY3SDHtAkrJM81pHXv5AAHsQss
         4FKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756718751; x=1757323551;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DoiamaT9JgY6KY01GFvVf/2Zvff95izr/pO7afYWIxE=;
        b=MIuH8B3gB8bY82lnnOaOx6P+4f27O/TUVmr6VNVAJ3EGX/ft2MVQjEfyJ2pgbAiylT
         7xSxJuApc/eTntmTsJTPLDLR5XCEAhTcshyzbSPovQU5cqW8XH0kDwMi4fD0dMPb8QSr
         5FA2uyAuwHtTs5G3qtUMmyHL3jVG5giKc83eP+YNsnltJ2AdWzHEx34a1/tBOkrOVKCQ
         Bg0JtrjPGgpwDS4v8kv32qzaoezNFMSHdnuBiva8JtdUPhp7/+bYb8SuJlqtVka0TuA3
         unzeHjZsT8G9jT4/fdvSztTRPrGdCLpRogegvrVqz+/18s9snxEx4EJCytfW1qhgDc3w
         VEcg==
X-Forwarded-Encrypted: i=1; AJvYcCXnD9NzdGvoTkRx5mZX4A/29jmT753F4k5SvsZuIWsfBJM6VJuKLt0z1CjFEDqLSqyXcgQXQVa35/sENC49@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/PuoI2PjpBofViI6j2Z3ScBg2NcV3J7cSFjVp+TI0YyO/MuX0
	B+9dno33yhQk7iE92kkHNyLodBCs1BbbSk/eFrYZb+3zawVmXyrfE0BHvNOAAFsTTkA=
X-Gm-Gg: ASbGncv1PZTba7yu/Hq+qsKnrGoCWin6hysfLi0IxsNf0ti6VNDvDfrYSUZc4dDQysv
	pMc6dEUjVytWNEmPMaFXqoB8VUH5bWH2NRQtUg0fd1TqyDgKOOeaiJHLyT7lvR5tNPKj1SRuSnu
	+hCVfVXub9mqJSxhov1ZaKTZgfTXIkA0InjEn9Fli2vW6OVZvXXctcHoLccIXfRCAGwG1WjxLy8
	YVBpXnPKmEqJLnj0JSOV4ZIxMSNL9rKyzZleW6BjwptNOq7RrInh1nGXQeOPjSt2746Wd4GZFPZ
	fLH1RTMafdlnBZyICXVP3ITlM0Hs38q7JFb3Xq3ylKVt/oXEtG151dbQNGCmx8PmeRSYLZt17Vv
	N8XehBYKjV8dkSAWGCpFyghpKnH/g0ReDbWFveXCI7SxeDPDoAjEL1w==
X-Google-Smtp-Source: AGHT+IHNrzuP8R939dOcQ5k1bvyvLjPnEFrrxO3rCXhWWgMPt73dhcOA1D6sgVuJ+j5Ee6BINIieYw==
X-Received: by 2002:a05:600c:1553:b0:45b:7608:3ca1 with SMTP id 5b1f17b1804b1-45b8c90299fmr23355035e9.23.1756718750673;
        Mon, 01 Sep 2025 02:25:50 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d520eada16sm5713645f8f.41.2025.09.01.02.25.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 02:25:50 -0700 (PDT)
Message-ID: <bc8a9fe6-5563-4873-a524-cda92ac1334c@suse.com>
Date: Mon, 1 Sep 2025 11:25:49 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] module: signing: Use pr_err for signature
 rejection
To: Jinchao Wang <wangjinchao600@gmail.com>
References: <20250829084927.156676-1-wangjinchao600@gmail.com>
 <20250829084927.156676-2-wangjinchao600@gmail.com>
Content-Language: en-US
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250829084927.156676-2-wangjinchao600@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/29/25 10:49 AM, Jinchao Wang wrote:
> Make module signature rejection messages more visible by using pr_err
> instead of pr_notice.
> 
> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr
