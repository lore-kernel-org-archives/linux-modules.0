Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429C028D8EE
	for <linux-modules@vger.kernel.org>; Tue, 17 Jun 2025 07:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750145917; cv=none; b=BLqWEL0RZL5zALg28voyCtFas87r4ouN8KY0mVqnds9ffTKjyouWyVZ1CiiUeISR026LYeMLXhw3sJFOuqHkcddLRokmts1XcELNZMoLrSfTGWIQ0T1KdlIHUOe/s3cz4FO48q0oecZKTsLdev1hAlmIesOm33goo1uu5DKv9L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750145917; c=relaxed/simple;
	bh=8hre+ioZSV1ApKk0mMHgtp6YNV3r2Lv8bwiGE/XHevY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l45EsYroaiA+xL0FSfJ37pOgHwztxp3hMOfLPuY3VRMu9OF4DD3ojQl0WJyaotxS3bF/6on3aK/MbLXMatzKaIhIObyNJ0Wq8GYlaDUNoE/M9A0/q1annXeQ0Aegh3yv+luzW/kk/XQhuG05tNCEbv4al6U/gTVe6U1W6U//VTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZAFvrA8H; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZAFvrA8H"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a588da60dfso218624f8f.1
        for <linux-modules@vger.kernel.org>; Tue, 17 Jun 2025 00:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750145912; x=1750750712; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=06WdrqrgwMt+XD3JlxWH3rD2dWkzuQMHj217UXJd1mk=;
        b=ZAFvrA8HheWATGw+r3/dK2tdOyWQDuFedteaxpkni/rcBlxdgd++CPXH7Y6nZMf0wd
         wkD9L15kea2H0sxy9YfJmNw0IMpfhw9smRFsAGj1MNsvAXkuGyP6ty/wsRtJg/tlSKy+
         3Tk8kfRzFoiHNFaaYeh0YSQ7S5yNkgMH64aMYFs7qkVym4l1SWFhKN9Tq4c9SSnH8eqY
         U46FWVAw3ihWfZbSTVW6DJdBaSH2o0K5bVQggXvqBxYju2NiXi/x7x/3hZL1j/uUTk6A
         AvrvFlr5rtRiipI+138Afw9eu2izvgYuZUrADc3SEMaa4qZv0qIRpoy3ow7DFAVZkKTv
         OZ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750145912; x=1750750712;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=06WdrqrgwMt+XD3JlxWH3rD2dWkzuQMHj217UXJd1mk=;
        b=g+VedLbB6o2XqoNhkJt7FS81BDRO9dcgh0oikYd199ypTRo05bl7YGP26Tb+kzialx
         mrOL3jFCcA1xWJktFudKUS51qmes/+DJRyP3CT24hdQ0Pa2Azqbbvbc40SDhbFKRJU0T
         HvQ8cOZViVkmfhCK+sPEtECupCPES2ezVhwUPZhcbfGsPB352QJQMk9K0qD2JJH+LERj
         +nWETEnm0CpAj28Wx3rtWqpyfAcKvI84ZP3Kn2OGdjW7EJdqDOYBCi2Z7akBgJ2lXKPw
         n222IIfEW8f9yGFXksCkPKkvSH9ClCZ9k0tPWdRoosskSdz5pJAoQ4AcKYSNeLmkd6Jf
         RznA==
X-Forwarded-Encrypted: i=1; AJvYcCVtU/lmS3mgiH1iSasRk8zrCpLu1Apj+nC8PsrkM127JAieXptwOi9Fw5dkOcRR7wyEtg/AMiMI9YpPMKmz@vger.kernel.org
X-Gm-Message-State: AOJu0YzRWEg9RMGkS9jZOerRSO38+a1Krf95dcMshM3fi3qMF3D6+BYw
	4GRMpSsiwLzkNpaIdmh9agZIPmvu9f6JBwv0GVH2qaKQXbXlQrrzEYcOC+zUKhxrSH4=
X-Gm-Gg: ASbGnctB4VPi58juQsz0QxjJDuJjBf3olENEEtq5PIroQzD7BNstOxZbY2WWEExOinU
	KlWZf5e0OOTPsHd6LIv9n84+luiDoRfi4Mb/h6O6QHii8xNC0OssQg+o5yvm4YDobnf9o8uR60x
	5ZJ6h/05AQ46xuMe0nQCYmANfPB8J+RX1KSbeAXYtYFQrdDFwhYIdUUXz/qs7WgTX6WQJk2c+Dv
	O5SQCQw8+uLxda/idwRPBV/2NA/fr7SuKAllHJZRbXNlaLL1dJJo1tKdfYKvghrxYkjj0xfp2fh
	7u5HagoHLXb4E9ge5N2Y/8qmUj9Hc++Do7KlFGLr3YHTE1NrHNQPfeCUNPDqLukgiDizAIvvzQ/
	Q
X-Google-Smtp-Source: AGHT+IEsDXzygzUiu5hDuvAS7nNYSt4nrUBrznqidImzQhFxIgxXYCsglRc9gafDTyPOPS+m5grryw==
X-Received: by 2002:a05:6000:1ac8:b0:3a5:2653:734d with SMTP id ffacd0b85a97d-3a572e7a1eemr9910886f8f.28.1750145912511;
        Tue, 17 Jun 2025 00:38:32 -0700 (PDT)
Received: from [10.100.51.209] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e1838fasm164856835e9.38.2025.06.17.00.38.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 00:38:32 -0700 (PDT)
Message-ID: <87e3de90-ffa8-40b7-a81b-70f5e5b8af20@suse.com>
Date: Tue, 17 Jun 2025 09:38:31 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] module: move 'struct module_use' to internal.h
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
References: <20250612-kunit-ifdef-modules-v1-0-fdccd42dcff8@linutronix.de>
 <20250612-kunit-ifdef-modules-v1-1-fdccd42dcff8@linutronix.de>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250612-kunit-ifdef-modules-v1-1-fdccd42dcff8@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/12/25 4:53 PM, Thomas Weißschuh wrote:
> The struct was moved to the public header file in
> commit c8e21ced08b3 ("module: fix kdb's illicit use of struct module_use.").
> Back then the structure was used outside of the module core.
> Nowadays this is not true anymore, so the structure can be made internal.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr
