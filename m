Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37A91A3155
	for <linux-modules@vger.kernel.org>; Wed, 14 May 2025 08:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747212491; cv=none; b=VklsveYjIH/B5DUzbNWFc5cHsaybuZfJq/2kz2sCni/JNHMMZpS4kzApK5x5LFd2Hu7WpzZuNKq988FX1cNEjs+XuX+MHlRbpgZvtjotYl/BneFLca1vKuIpTy1fj1UVreS8rCd63zi4jTRgD1yoiKXX0uZ/pJk3VT3MJfRbmB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747212491; c=relaxed/simple;
	bh=Ccun/NTDw+CoIytlHzHrLFFVWreSfKk2Ou4w0xRSMe8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JwKRvRXUZNnCvKSmHZiE4B+1uQSK9580NQBfyTa8zDgInPf7a7+Fs69zuG3tCNYyduStrgxSjyLjWxsRE8ea6jIOJSXnHMx/C94uw0mJ/42cqNl2Fn+RN24sLrVkJ3hwLMbzkkkN22x1YDDSr3ec7MJWXeGWvOC8AENGL4oZz6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=W9tfoLf2; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="W9tfoLf2"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a064a3e143so3771381f8f.3
        for <linux-modules@vger.kernel.org>; Wed, 14 May 2025 01:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1747212488; x=1747817288; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J11Tm9IxpteDcvYogIFayM49cQbKfAspMtr3deGbdkA=;
        b=W9tfoLf2xYNRKWZP1aNpy6x1Ak0IIVXZNp8OdSkUPnUAQ9cu3tBIIyXt6ZRbHQ4wCP
         guEKGSImsK0Ije+ViSzRdSrmNsATpQQNqXoPxs3beWfTn81F0vtNu1fapVT7ONLmVeXv
         Ux3064Ec4kccPCjNS6q4/YEgNHY0eGb8pL/A4qVm9MA99dLHaXbZ3GNSPZoxRuizOc7H
         CyM6uFPfQ68y9glgOo7d2dtBjbfZwGV5xwYAFPyihO5rdqeE0C8SRGzfV67LtjpFD8C4
         ZLGF7ZPhmeR2pVej5briPiQwV9/H8ayyiw2QMNqzQycQfVvvBtwNfZnDO/FW8gytQzSW
         um7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747212488; x=1747817288;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J11Tm9IxpteDcvYogIFayM49cQbKfAspMtr3deGbdkA=;
        b=wFy82OyTeZ5BfzwAmOAYt2xmj7bzyiadXf3ehjA0oU2IlGYPFgE9sPHsSnmr6fMvXy
         1JpssjBPFErWxCjrYBMaTb47ZUajLVM5bjECCEvNao/4SZ+WR1QYc/9CuNvLI2yfh0Q0
         nT10EczZ/YiCZjuY58fKDKfShpiOcIVQG+u5s99MAdUAT8BMwtuLzJIBI0zklq5VOeV6
         KbI1oOzs0vdy63LTt6ogj3zFI1nPrpfEq86flCebyXage8LEPPRtDqFOnQuKE+swi0rO
         tjE9lFY9x8x7x8XVAmc3TxC2p+1SzmjUb9PH8oM4Ac4uHu1SYIEwklPoBXAuHfnd2heF
         c1fw==
X-Forwarded-Encrypted: i=1; AJvYcCW4UTnnfK6POfH91kZkXw01KF7gjWEhDS1Y7pnzXkoPJps3AYkQAhMlt1Z9BqlZBVKuFxhexVE3IuK2wIZO@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7U4T7rzFcEWAbnINIkaJUl2WHM/ds1Mi3ALoGNS1RrG1TeF5t
	fI2q0T+QZzcpeCFKiK+kssOTE9WWoPH5I8mjMHnRKxktdxByJza2FjUgDxVj7s8=
X-Gm-Gg: ASbGncvstDHqjiM67i9n5dlfdNznmco7iSETOQ4V/D6+5G1g8bvDxFXwlDj1eQeUtrV
	3hlysXiHIkNCWXWeYTtF6xkp+jIVHp3n1UKWkA0xDykXBSTNQ2ucDx4FMmv/7cRkQNtxSRelHPR
	AEGxfup30JeZCcha5j8LeWQRo9sM8BdN76j4sbI3lAN2BE6PmMk06O6Z4qBq29JFKFYrxUUmUE7
	DQlvFNDiB4A8/paZYHFGWXdIE5SQXJon/H1Pesc/dskF3ZFyC1cVYKaX/25LtHHjtGYRb1Cq92A
	NI0DpelIdKcy/+jgauGKyHfjGBJcA9+WyACVfg9HHXuWm6KuxPYFmw==
X-Google-Smtp-Source: AGHT+IG6Ygt895dWK6xd2go5hH299uW3ziCrAKGblKyG0md7su1tSRFeV1oXO46fD6Q1GE1oUd21Ng==
X-Received: by 2002:a05:6000:2583:b0:3a0:b977:b6da with SMTP id ffacd0b85a97d-3a3496c36bfmr1777692f8f.24.1747212488190;
        Wed, 14 May 2025 01:48:08 -0700 (PDT)
Received: from [10.100.51.48] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52c63b717c5sm7334835e0c.9.2025.05.14.01.48.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 01:48:07 -0700 (PDT)
Message-ID: <49b63a7c-d323-4b13-8a1d-11ec8f0a3152@suse.com>
Date: Wed, 14 May 2025 10:47:57 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] module: Strict per-modname namespaces
To: masahiroy@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, mcgrof@kernel.org, x86@kernel.org,
 hpa@zytor.com, samitolvanen@google.com, da.gomez@samsung.com,
 nathan@kernel.org, nicolas@fjasle.eu, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org,
 hch@infradead.org, gregkh@linuxfoundation.org, roypat@amazon.co.uk
References: <20250502141204.500293812@infradead.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250502141204.500293812@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/2/25 16:12, Peter Zijlstra wrote:
> Hi!
> 
> Implement means for exports to be available to an explicit list of named
> modules. By explicitly limiting the usage of certain exports, the abuse
> potential/risk is greatly reduced.
> 
> Changes since v2:
> 
>  - switch to "module:" prefix (Masahiro)
>  - removed some patch noise (Masahiro)
>  - strstarts() and strlen() usage for prefixes (Masahiro)
>  - simpler ___EXPORT_SYMBOL() changes (Masahiro)
> 
> Not making using of glob_match() / fnmatch(); this would result in more
> complicated code for very little gain.

@Masahiro, please let me know if you're still reviewing the modpost or
other changes, or the series now looks good to you. I'd like to take it
for v6.16-rc1.

-- 
Thanks,
Petr
