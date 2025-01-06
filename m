Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E86441C6C
	for <linux-modules@vger.kernel.org>; Mon,  6 Jan 2025 14:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736172311; cv=none; b=dFvUYfDajdQrclIZwDqe5/oW5rCY4MQ03ZjaeGlQpODK8r+tNWdpYo/OS9GKNMPJNW9a2v9KZuJ2THIgyVEjLfwVlAP2CZ2/4mHTYnfTXYmvf2FWeFMO+NNhOpFfJ5kweTOr6CZu1a04P8Mn3ZT+HB59TQBvxrRGhm0lUMD88+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736172311; c=relaxed/simple;
	bh=lb5ZskQWeyhOiFPZA0S4xBVXj0k2PayDSit1sTmI45g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R0AwXifC8cDeoJyCq4T/lC+wIZPUTDpdkfWEmKPgapBNNFUcI2eym/GC8v2oJkysRQD8Y43K+3TgdAcT9AijEeIrUqzROAgEuCsr+09fet+OWq6mlTiGXUCfQnDLN6aQN0/McMzzY+KZQtmcHEsm6wi6k9Ao96Yzwgz2H7x8utw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YI22MAAj; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YI22MAAj"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4361f796586so149024495e9.3
        for <linux-modules@vger.kernel.org>; Mon, 06 Jan 2025 06:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736172308; x=1736777108; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YXrxzMutOrPiBTe9b2pK033uybW0Cyj3Mtb4suAcYig=;
        b=YI22MAAjhLypecVB1dx7aURDWLYRrA1llBNtj56t35PvAVQh5KGe8PQhKfWUo1/l4A
         7YM1WGrzRLl0nSupNki3KPwvWAJJlZFy5EQGueElmmeO1VirLJc48BKJ9XFbWIzeBdWM
         9oqZyCoJ5bhCGMMhAwwkLRPRuip5+opOspdtLOrXyAgJiX4p1YaQUlbVu5nzEJ1JOH1x
         uQ1AM8+60NpT/+g3gflCzZJVEUXI4fwWxET6ltRexLCP+S+p8skB/wnSkbEdf2hpovYw
         y21cmMGjVGS0mS5PBdoUTisPXj2Xtu1Lj2NuZNiDEOVtz9pUxy42xgfye+FUnl6dqI6G
         ynlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736172308; x=1736777108;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YXrxzMutOrPiBTe9b2pK033uybW0Cyj3Mtb4suAcYig=;
        b=t7KpdhHLUIBg76ZkRb5/AB9EZ7Uftxu3j6gAG/tP2sbAKVJMGzoLvE0PGgQDhZy7eX
         xgVgROJnM+Et3BT8jRrXmaCAW2kaSSC/1fIA3Hezo013ib4+YS5VaS0UCHL4KtF+oFPj
         05flFLdaiC21E/ZvkVdXw+JJlHEGR4bqEP2Tu44u8IBTYTIW0O6opXCScP43BJ78urVQ
         UvOTmxbrryoEs/2uAA4QGt5v7Z7zLQt0xISK6r3cTmDTHyChh4IJbQA+dYNyt/nLgl/n
         y7gReqs6libEJgjh7pPN+oMaZSdueYv+OP/KUAUbAftBib1Zbx7zGqfA9VPGxGOy5F9v
         iwsw==
X-Forwarded-Encrypted: i=1; AJvYcCX0ioxuyXz0QJjzB0rLhzqhuVWw4BmjsCigDFnQIDYx9KmweyHnvS+/vxVMLzC/wt+Ro3EagFpiEbn8b982@vger.kernel.org
X-Gm-Message-State: AOJu0YxkKEmBNd1edCFLcq0UkUz5TWwJkHoAngIBzAxIcy+GTc95VUh3
	fs5iQfbFMS0ap8Raz65zANwVD9A/SrnQBUn2xec9PmVkRSxWMGXiLMU20+XE8gg=
X-Gm-Gg: ASbGnct5H3Kf9PrtwRG+uc9fzHSobOarjLkGt7a3TUklgUqrAI5saVB58bVM5IbFMwP
	Ux41jl838sJ/Yidvt4Ij7zEN5P7UooC21taOG515wGmdohte6Qb19zDuZWo0fQzTQjls5zBeakS
	dcBtd+IwDDpqPfipVc8E/6WDOqRTOXrkbw+vqrQEmj7lDAgENWJ4t+jp5EHf5vkFEgIC/0H7DfO
	6vdolNEPBisMfVu20udejRmA//tvT5jeIjYsCk0+sKyjWTF7o90Kotb7PQj
X-Google-Smtp-Source: AGHT+IER4TOxKmNFL7XQySabj9Buo0ZRW4zKb+TIcHyvqLWSuOS7yKuZ8lkaizvjM/3T6w90reldxg==
X-Received: by 2002:a05:600c:1c25:b0:434:f4fa:83c4 with SMTP id 5b1f17b1804b1-43668b5f691mr477152185e9.29.1736172307905;
        Mon, 06 Jan 2025 06:05:07 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436840b35b5sm422147405e9.39.2025.01.06.06.05.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 06:05:07 -0800 (PST)
Message-ID: <d9ace384-07bb-4fa4-9590-9f739be8e3f5@suse.com>
Date: Mon, 6 Jan 2025 15:05:06 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] module: sign with sha512 instead of sha1 by default
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, linux-modules@vger.kernel.org,
 Masahiro Yamada <masahiroy@kernel.org>, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <52ee32c0c92afc4d3263cea1f8a1cdc809728aff.1729088288.git.linux@leemhuis.info>
 <ZxQ5QJAa-iv4S6sw@bombadil.infradead.org>
 <54fc582e-1da0-410d-b410-316792e3472b@leemhuis.info>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <54fc582e-1da0-410d-b410-316792e3472b@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/4/25 10:43, Thorsten Leemhuis wrote:
> On 20.10.24 00:57, Luis Chamberlain wrote:
>> On Wed, Oct 16, 2024 at 04:18:41PM +0200, Thorsten Leemhuis wrote:
>>> Switch away from using sha1 for module signing by default and use the
>>> more modern sha512 instead, which is what among others Arch, Fedora,
>>> RHEL, and Ubuntu are currently using for their kernels.
>>>
>>> Sha1 has not been considered secure against well-funded opponents since
>>> 2005[1]; since 2011 the NIST and other organizations furthermore
>>> recommended its replacement[2]. This is why OpenSSL on RHEL9, Fedora
>>> Linux 41+[3], and likely some other current and future distributions
>>> reject the creation of sha1 signatures, which leads to a build error of
>>> allmodconfig configurations:
>>>
>>>   80A20474797F0000:error:03000098:digital envelope routines:do_sigver_init:invalid digest:crypto/evp/m_sigver.c:342:
>>>   make[4]: *** [.../certs/Makefile:53: certs/signing_key.pem] Error 1
>>>   make[4]: *** Deleting file 'certs/signing_key.pem'
>>>   make[4]: *** Waiting for unfinished jobs....
>>>   make[3]: *** [.../scripts/Makefile.build:478: certs] Error 2
>>>   make[2]: *** [.../Makefile:1936: .] Error 2
>>>   make[1]: *** [.../Makefile:224: __sub-make] Error 2
>>>   make[1]: Leaving directory '...'
>>>   make: *** [Makefile:224: __sub-make] Error 2
>>>
>>> This change makes allmodconfig work again and sets a default that is
>>> more appropriate for current and future users, too.
>>>
>>> Link: https://www.schneier.com/blog/archives/2005/02/cryptanalysis_o.html [1]
>>> Link: https://csrc.nist.gov/projects/hash-functions [2]
>>> Link: https://fedoraproject.org/wiki/Changes/OpenSSLDistrustsha1SigVer [3]
>>> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
>>
>> Thanks!
>>
>> Tested-by: kdevops <kdevops@lists.linux.dev> [0]
>> Links: https://github.com/linux-kdevops/linux-modules-kpd/actions/runs/11420092929/job/31775404330 # [0]
>>
>> Applied and pushed!
> 
> Lo! Just wandering: what happened to that patch? That reply made me
> assume that the patch was heading towards mainline, but it seems it's
> not even in -next. Were there problems and it was dropped or something?

I can't recall that there was any problem with this patch, I assume it
felt through by some accident. I've now queued it on modules-next.

-- 
Thanks,
Petr
