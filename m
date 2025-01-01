Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA0133EC
	for <linux-modules@vger.kernel.org>; Wed,  1 Jan 2025 12:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735735407; cv=none; b=Xve0f+ChUiFQEl5DGl7APEt/gk6Hj31dAAnyO4KA0wjaMabnf5B2WCVjR4uyZ1tK8d9rUIsg/K5vNsU3ue2Ati9xh6Rby6PO4Tub5a/A9/U2AK/KEpAZyBbVgVOZpuOm2GquPDP/KcieMGZX6GVzwNtyztnqq3ndpfH92ULOZDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735735407; c=relaxed/simple;
	bh=bQapwDS5pM4/2J4dWW7pc6+2rnICmlNg26yfAqzDYhw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lW8QH8xZJbTNiWmNfH+sC4EWei5Q89UPErPyp4qEFSuF67ovQMjDfIBE7PxdCxT4pxgyHEJyOtla6UIGDvAfTot+jxxm6LIlXn9UIXLTmhYHtJ5jniiJmB6qpxAbFaEwoDcmNxA0uLA6oqrUyakiC8pSVrJ0EzemokcxHpxrBMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HA2cHjHR; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HA2cHjHR"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4364a37a1d7so112172345e9.3
        for <linux-modules@vger.kernel.org>; Wed, 01 Jan 2025 04:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1735735404; x=1736340204; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lFBy3+tAhmZnIL8MRCPsVjcZvVDClAHK7215A2/EKHA=;
        b=HA2cHjHRD01aSGuCpZCNIKFAyEzT6IQUtyso/j6j00gLvn0yUK0+53zQ6kAQedUCp8
         +O+rHTVJ6KvF8Bw7IPNv+XR5aDIRLEcZ+L5R++7nGbhUHUrE+hu1eqRSAbjhphKxH8uP
         UM9ozgi6anfi+N3xJpxhDYUccIj0+g9Yt2DXOzkTogoeQoPl/dzriKTsjrs8EoipUpFb
         PNnM5zys6vnbBtUvXjg+bdksYt03Q020uw4GExfeEH6WlhzxIHRHJ3sdofLaAdTwqQoI
         xnq/idfpevEM/BlXexUl0eIZcfKzqb8H5Chw3fM0bL7s0FJH4RFpZwiNb9yKtIh2eHfo
         G+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735735404; x=1736340204;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lFBy3+tAhmZnIL8MRCPsVjcZvVDClAHK7215A2/EKHA=;
        b=erRoiRMwK39/+kMFkmk4qwCxaVmXsCr3tZmJKXbx7BMVLWGdnkTVlp54/IoHx8Qpty
         fsdr6/gB/554D9LJj6u8kLVBQVmdbiBSOwzReqlKBcbxfk1RhjO5RZeK8GlEj+nV1tjy
         VjGIDit6PjLWfo7RlnrMJ5VyLJcbQySJ6lxyUacrpU2n/vnsPrIQYW3mBaiOiVzsoe4K
         ujLgJvssbZKXusa/jqIdEIMS7iadoWLScIOC1zhbK9mPSxrSLqKeP98kM9DuwU2ZK9Zx
         av8lNUB8y4r1n/Oq3I3rxz/c+CJNHOMkdvDoFmXJ3cgUWOqXcdlelCyAIeV3EDZQDY4S
         GVDg==
X-Forwarded-Encrypted: i=1; AJvYcCU/VHsy2IaXoHzs6JJOPvcJL705Ed/gZiLpVc1MdtGz4PaxZNb5cK+YmhxmYn5IeYmDF926yN9KDtEP/zgv@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8wODZYmzVo9tVWAg70j/rrOFjoEn/+O5fpL60ityukNUMOldP
	OJ4iyeyYx1Fq4PDfMeU7H70voEaGthorWfj7s2zoYxcjQSqQSTc797iXlOAkhc0=
X-Gm-Gg: ASbGncudrmSAq8vJ8jJ8Lm0pYWb5YXc3MHyRxo4c1zEA9CWPxiZTcbG1t+zhX1RDQzI
	WiOH4ua//3wWh4hXbcBgffnscsVKebNDUKaEv50hzpUYS9oP90lEceNexbw2itUggVwp/Hmz2so
	tT5BFJ/p8sv7N6nJdoY65+hcvTWgS74+2NuNMU++90r4MzeMVrfeyCAWx4DGpClljSxzE9B2bTj
	HC1dTBHINBvyX1WF8yh5Tv8oxASZTWthL4RL9TRcD4zdyQGRs8yIFtds/yO
X-Google-Smtp-Source: AGHT+IGpsycIA9+LbLohNbZAJ8Bl9j9xoqnN/U+qbnBH9ZKglmui7JEu8vTh4E5oesjUZ+XMCqQfbA==
X-Received: by 2002:a05:6000:461e:b0:388:e377:8a1b with SMTP id ffacd0b85a97d-38a221f38b4mr32997697f8f.28.1735735403856;
        Wed, 01 Jan 2025 04:43:23 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c847dabsm34952907f8f.59.2025.01.01.04.43.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jan 2025 04:43:23 -0800 (PST)
Message-ID: <db0cf655-906f-40e3-a9d9-d1854a6dc44b@suse.com>
Date: Wed, 1 Jan 2025 13:43:22 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Modules fixes for v6.14-rc5
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <fedd0c6b-a870-4b8f-8f52-6e11df936678@suse.com>
 <CAHk-=wiihsw2QnwsgYr7xOTpqfjo5ojOaNTBy8hj06Gz+-BDQg@mail.gmail.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <CAHk-=wiihsw2QnwsgYr7xOTpqfjo5ojOaNTBy8hj06Gz+-BDQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/23/24 21:14, Linus Torvalds wrote:
> On Mon, 23 Dec 2024 at 02:55, Petr Pavlu <petr.pavlu@suse.com> wrote:
>>
>> Luis asked me to look after the modules maintenance for a while, with the
>> plan to rotate it with other recently added modules maintainers/reviewers.
>> This is my first pull request to you.
> 
> I *really* want maintainers to give me a heads up before people change
> and I pull from new people.
> 
> Please? Otherwise it just takes me by surprise and looks unplanned.

Sure, I think I got ahead of Luis before he was going to make you aware
of the change.

We plan to rotate after ~6 months. I'll let you know then.

-- Petr
