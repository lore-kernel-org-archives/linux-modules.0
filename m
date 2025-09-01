Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5E330F523
	for <linux-modules@vger.kernel.org>; Mon,  1 Sep 2025 09:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756718802; cv=none; b=pM0HLoRR31yeHs99IWCBfC1jp5Gp+KgAjojpXlVA+/VxXvBNeSLk4nY9ZYkdK/Thty6sgR6lt4DR6xiyiJ5HTTBRHuGvyigMASN+ypwPHUUFDiQsKtiNY80i84iqbHvl4ve9tMz0xoNC8aj9To3hrbyuKZckjzuIq94pcwk97wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756718802; c=relaxed/simple;
	bh=PuOTylrxKSJkQjeSq7Xik4IP/OVb/FZm1rqZ2JBYkn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=iKFI8ApT4xK2F9fMZYlq2+BSvzRsC43yVRJCIDm+vBCxrC8Elowxnqtko3NjmG2uVNW1z+PgYejcTZQDSFhNiILQ2JsX3TAcbmLgUwyY/CyDM9rR8ibRKvs/YfbD0l6hu1s4mT4nVIHoBABEE0D50lRV7SR4vr9ba3L29Zfnga0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OfIhd5jm; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OfIhd5jm"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45b8e28b3c5so3246525e9.1
        for <linux-modules@vger.kernel.org>; Mon, 01 Sep 2025 02:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756718798; x=1757323598; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mOvkZu19+8XAACEUVfl5Tq7zDnwb7HvxWJivbhcsb7g=;
        b=OfIhd5jmA362+JAOUCmlSoETbHKYlUt5xhV+AK+i1oZXAHmCk+44tm4aLwBMoKHZVZ
         3wFsgAAz2tIjZ/6tzlJatl6G/tVd/I1lsWgiLNVjvSi5jstd1pObRVPZB12BD//XBGqA
         Br2Lf5uHLJ/m325sF5QaBYZ0uOn9dAJE/lFQXTtbFsIo15ocsHJYBu0y8UG/5nCI2s3b
         o2WeEnewBy930Vksc8gh87sM7pyG+JMoCZ6X9cezYLgWykTRMdobj5+SvkoRpJHZ4Iah
         73v80UgbJJ0/p6nwBJAr45DdPiIOiJl8u9hk2qCI6607p43O+25TJdQRkXrT9R6AVtjZ
         0K4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756718798; x=1757323598;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mOvkZu19+8XAACEUVfl5Tq7zDnwb7HvxWJivbhcsb7g=;
        b=QOt4aGpwyQVLohGSuvKO8CiBfBU576la1y7RU0GKGFEm04I40FW7s2z5Zt6oq28AHq
         Z5OwQIDBl6RMub4mOzgbyotk1eBT+BXqomZNdJlogkG1DDAxUO2DeFkYkBJRxjtI9Xjz
         VVIt7+BvGQNuXWMC/Xq0YkofyvHR7hvut0PJaQIlgLOSFKu0aLnF68TC14WDtKbOAg4g
         2bjKbAZUqOWrpEUXPZef45LPuMn64oIChoWbaNE1GdLV3jPlWU4EM1/TblQ4Kzc+54Sz
         BLvtUVIqFBIXy0ahPyRmS+6KoVkZdfNWspA9FKv6w++WWzPRuChD8RgKB8U7qMLk2G4+
         bwkA==
X-Forwarded-Encrypted: i=1; AJvYcCWxPODwNngjSHtbliCpFZ+7ea5QxkMUV0clfusPBOstrcWfkLc/grhX3+SLwpTwNL/+52SWXycz042aPSfM@vger.kernel.org
X-Gm-Message-State: AOJu0YyuJJ1qLwbL+UXsYBWzFm7pNbM+v3kt4zMHAGIYKwCvYBxMK1IK
	uFg0fB+a6WE/lSxpmuQVZs2lykyN7jPwcWWKWJs0z/763ppePrcD03mJ26DCaY7yR8g=
X-Gm-Gg: ASbGnctt0KAHtbeDZ4q8A3uIxrY2tlK1uZzpArD908VN1o5l8EWyRYzHqMq5fzGBjA3
	n8yb3lPPoR/Y53jRURfuwv7hXQvdy5J1lv3Ha27nyxSFCgmywmAyqMwsjIWNbBK5XPOuHrmp3tq
	lBltW2EX0JCnNsdF3zHBEvKcN9JT5wjztNVXS5XFxKeJjibDDk1JHZb+s4RV95uKANoo1v5NYFU
	MrPhNeWECVYqgJ3ZCowLwtcJxCOv5iv4MJ5XHYqTrodzFa7C2tN1hd/9HSNnYP7GfjDKW+4L64a
	El/WeVadnxiXuba0jbVZnCzI67j3T3C3gDF02ZPs0tGTPfDPSU/XW0cn+cYmYUwFVenm/SW1dtn
	2jOuluqJmb9UAiTo1MomW+tXQSSYrG7B06thiZX3TqRY=
X-Google-Smtp-Source: AGHT+IG1Kp1xJPG5uw2vE2hCaImIqhYqS1Z1P3fiEdun39Ri2iyt3w69ScnK0oY5gByY6uFnftmpxw==
X-Received: by 2002:a05:6000:18a9:b0:3ca:b6da:a5ce with SMTP id ffacd0b85a97d-3d1b1af2a09mr5596571f8f.23.1756718798498;
        Mon, 01 Sep 2025 02:26:38 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf276d5816sm14425964f8f.25.2025.09.01.02.26.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 02:26:38 -0700 (PDT)
Message-ID: <e4bd094a-9302-4a8e-af52-496deb57eeeb@suse.com>
Date: Mon, 1 Sep 2025 11:26:37 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] module: show why force load fails
To: Jinchao Wang <wangjinchao600@gmail.com>
References: <20250829084927.156676-1-wangjinchao600@gmail.com>
 <20250829084927.156676-3-wangjinchao600@gmail.com>
Content-Language: en-US
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250829084927.156676-3-wangjinchao600@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/29/25 10:49 AM, Jinchao Wang wrote:
> Include reason in error message when force loading is disabled.
> 
> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr
