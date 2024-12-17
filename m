Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3401F76C7
	for <linux-modules@vger.kernel.org>; Tue, 17 Dec 2024 17:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734457522; cv=none; b=Q8FlsUX2qqVUyDsxKagA99f7FImV5tXReHmoFbo4VydnZpiom1ZdBSyrbmIPoonovqGjQJUF+KKyKv0dM2AoixXH1ZnpvMovv75BsJK/AYoyn11IuzXFrjiuTKAN9t9KGKTrvXtKKi2r9Epuui+9x5MIEEwtLpWWXe2ZiPBoXlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734457522; c=relaxed/simple;
	bh=uF2QxkbdwYGBDuspin/06l8N8afAX84HoqYIkjMvILI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MiL4lEFRuEN+mOs3dqaA5zKawZmYaEnjzGXHNfX4NheA/eP73WLW7E1D+eiCzNAYoRHJd6KcK2MTGdGmp8/dqvj/eAw+T4vZlUsmngOPkZdvU6U/BMz67YhJa3vX/j4RIM98TNXXQksrLDlWQuVqh3Ud4Cr7OIDWT8B+WO+B0+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dSB2ocQZ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dSB2ocQZ"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4364a37a1d7so11094275e9.3
        for <linux-modules@vger.kernel.org>; Tue, 17 Dec 2024 09:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734457517; x=1735062317; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=guzXMmcogdP4Q7ZaoG1GlbeOyFsvryanY60rqbwUifI=;
        b=dSB2ocQZH5V0lOteUBwcyopIvrmnOyNaJXR94EK3+7phItx4evPRKuP2OyxvAqUIap
         neAunqBuIfpneToZ7CNrn9s3YZoXk+fx6kwr9GTlMe7SJYlvBPS1UWj3RHGaqG6OkHiI
         vS9PaWizwMa5IzvAxxrZ1JZA4QMHQ90qDszNwmJe4cZyiJRsglCl1xMqChusiZx6vuFv
         Xt1JlJF+EXAgUqlH49XKvF7GtkqMo2Ar+JU1EqlRR0CuzJRXtwDZo+VoruqvFhKHlA8U
         cH7j/ZYw3F+WF2dP6IhnR5X97iTz9HRnmQRUYGIBUI+4N7f0AHzAq8hU8CTvpNypKlAM
         WPug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734457517; x=1735062317;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=guzXMmcogdP4Q7ZaoG1GlbeOyFsvryanY60rqbwUifI=;
        b=AnLgtzEUynzFBol/ZG1chhOasukjWHA37rAp8Qyxv8q2u6aoCHq9+/jRzSM6Az7KOh
         67th+2bRiUkA9nQdTSvbe10SNaHeSRimORtARELcSRZoFzhuzDTwn/JvhtuvB8zC9c4U
         s9M6uJZ7YueoCZvYOJQkXOXNzDdBXna/6WxnQLxdxRqLT4chcse3Zph30608PYV/7SdC
         /tSxB5x/XJkytDcIguTH8qoiIINMup5yrdVBirXKIGIJiR93SJolMaMUxhyqGD5OZbmM
         dXXX07DxRmdnbTiAMYT6ojw6yGDMr+lUQUG0ssQUTTgCP00WhLgEnCPtTPZz+Cq1U1qb
         ppPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfRq19plSufwB32ybTnkdjIwGdBVVuD2BNwsHom9j/FbDiR3hgSMUkFQdbOixQBDNxZrUmtgu6IcIFZw/A@vger.kernel.org
X-Gm-Message-State: AOJu0YxC6CDZIg6C6aII9GJL1U6gqpdp+StVGL07WYKHMWS/10l4LVcn
	xkLRbO9bXsEIWNTID5aU1LQD53fgx+vlHutMkdKFt1EApaZtGd9CoKDlpawEY5M=
X-Gm-Gg: ASbGncvr60qhYKU71XPQMiO8oR1ToS0ijm/0+yDj2Ml06Ya9PL9X7vxA5g3Z0O62O/W
	7xS/vDhKbi9X/QckI4VLqUVYGDJsmFpPlVK/UNGIyT9u9Y374XU3+qhIkawPihYK6h2a7lvyB2e
	TDcTqdO/Z9OHNYi5SV9MvehykMcU2XH90pDFUSxUtFDLFuzqipoEUMzjjCs3LQfBKb+n1VWJMaJ
	vd89xonvJyvtlteCM1vXgQcrIC8ygu3hZA5ey8Bm+IG5pRHTcE1Tzo5TdS4
X-Google-Smtp-Source: AGHT+IHh7ct8eaePkucDEFV58KLJO8R3EO5zdjf3vBCZcZJe01PsEvPnBbD8xACvsgbd8KkOpWoPJw==
X-Received: by 2002:a05:600c:3b24:b0:434:a1d3:a306 with SMTP id 5b1f17b1804b1-4365306d45emr2189525e9.5.1734457516775;
        Tue, 17 Dec 2024 09:45:16 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4362557c696sm177414435e9.17.2024.12.17.09.45.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 09:45:16 -0800 (PST)
Message-ID: <7a41a098-52bc-4e96-bf08-fa86b58e0075@suse.com>
Date: Tue, 17 Dec 2024 18:45:15 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] module: Constify 'struct module_attribute'
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241216-sysfs-const-attr-module-v1-0-3790b53e0abf@weissschuh.net>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20241216-sysfs-const-attr-module-v1-0-3790b53e0abf@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/16/24 18:25, Thomas Weißschuh wrote:
> These structs are never modified, move them to read-only memory.
> This makes the API clearer and also prepares for the constification of
> 'struct attribute' itself.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
> Thomas Weißschuh (3):
>       params: Prepare for 'const struct module_attribute *'
>       module: Handle 'struct module_version_attribute' as const
>       module: Constify 'struct module_attribute'
> 
>  include/linux/module.h   | 10 +++++-----
>  kernel/module/internal.h |  4 ++--
>  kernel/module/main.c     | 40 ++++++++++++++++++++--------------------
>  kernel/module/sysfs.c    |  4 ++--
>  kernel/params.c          | 22 +++++++++++-----------
>  5 files changed, 40 insertions(+), 40 deletions(-)
> ---
> base-commit: 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8
> change-id: 20241204-sysfs-const-attr-module-927afe76eda4

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

I'm going to wait for a few days if others want to comment and then plan
to queue this on the modules tree for the 6.14 merge window.

-- 
Thanks,
Petr
