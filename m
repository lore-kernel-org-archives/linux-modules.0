Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E96A1E3777
	for <linux-modules@vger.kernel.org>; Tue,  3 Dec 2024 11:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733226853; cv=none; b=aTQzngoZFrY9azr1cxM7wJBWJtqEeqRcz9kfy5haIPUMAdAVESqGGavLV8kFtijezX6AxmDNTvkLqZxsz2fU9H0Y8bSBzAX6fajmcmeJZKBxVdy+L3jQMatyYUcAXINtgjkZZTA4/o4Bkh0t6sVkEAz84i238LZkgqVTlje1CP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733226853; c=relaxed/simple;
	bh=iZ6iZsYDGgn6+nosV/i7U3c9sBZT+1+wu183Z3mPfA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fRoyQvTP3QeeUoHw0pyOpl1K8LTe4vpyz8lbl3HQSkk/U8ZCAFBo+E+ZFuRHG2nbOvesYHrE6dx7/+b1qAsMDGrdmguO/m6wpUsp8leP/lZ1mijxxUrDCbFvvpKhSaroJcBQLCEka8QO5C1RCsE+oDfpd2LcJOGVhtAPs+ecD84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=C1+/yZjI; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="C1+/yZjI"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-385eed29d7fso1607556f8f.0
        for <linux-modules@vger.kernel.org>; Tue, 03 Dec 2024 03:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733226848; x=1733831648; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZR6c9RoUjrM3dk40cs7PLYguaqe6xp835zylMe9vPV0=;
        b=C1+/yZjIPX22lJxVL5/59K8t2UzOxMgAMsfcH7jg7yWyPNbsHsdhExoI8UqKrCzj1D
         GYnWn2J1/IwyGF9bUNQOJRKG+ChCpUfdZno9hxSl7tfeIau8TMi206ETwDV7y7/n8Pp3
         KwzqWMkVebo2qOEgODlPjYMW99OEMCyIFwW3JUn5BM6lXh0p/t1oJWKCEmkdJOHqES9e
         QMfhKZ/heaYvjqad3m5S55UqsQmj1FwBcnmrrgoYIlrTMrOHgbdDKrYj2lvuQ/Py7ZU0
         C1BgnUljwa9mdnCWBb+1L6GHQR7Y8E1KmTi+yR95Wz4Hp7ScaJPPu+J9m+INB9zj1efY
         yuCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733226848; x=1733831648;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZR6c9RoUjrM3dk40cs7PLYguaqe6xp835zylMe9vPV0=;
        b=qnjXNSKwTXXpABZU14VSw9yK3jEdxyPvVVOUGU2CfTqTWr/gXA5SHMMpREvtXHzCKw
         +kSnd4KgwWI39myvJtu8aeeBA1SQzUlmhKvdIkM3yciCsDEcBP9tGe9Xn08MSapXJYdp
         VVTRV+DyA6qiL0NrbT71NKG0HEvkTN02Xss6vf7R6qn5NN0L2Nr9aavlc+1CMICCP2jA
         opCWBNVQA0Efr9tESJw5ELCZKBM/9eFbX7lCZ1FvCNF1tiXypxlZFLxEA2bOzL+HBGuV
         vtzgupRBSLiHhlDIbuPdNz1hJueBCa0CFDiG1JJKzqj5jMF25Rjp2RigdrwA/q4aVG8S
         EAIA==
X-Forwarded-Encrypted: i=1; AJvYcCXq/MKtphzhk2mYqZSfD+K5RZbH6Z4wFgUV8KSXJ2BBVFhNjaEYyBB4BBVAPKFtvtlsM8v01r3dGYis64dv@vger.kernel.org
X-Gm-Message-State: AOJu0YwuojFOwGyjGanl4dJQPkmlota69s/W7yCYT5xGWSybVvHq8dmo
	2vYQANwAhpX+ov9SBms1Y1yjz4p6K9uCf3bKL3FrEgVpCFhzTU9vPiK6pY4Gjwo=
X-Gm-Gg: ASbGnct/ML2D5L5uxPVVKY1RVEiWGCmfGajyh3SNcM9KkkPubNlEfZqpzRDLsDOBw+U
	+kFCxac00ErqmBiclCVgVbxZWvrIlUFNs1I1uWxnJwlxh1gdFHbSrsmGbDgt9jW/kyLJtllGZ7V
	sUW0U1LiSPs+OJ6ajFGBCObLxqDix7ALVCx4UcROI+Q4NG5oQ91A+iHNrtlXtwL3AG4wdXr/KUl
	nrHf5RZ2Pem1HFl8C2PPQtOH8doQgjdVG2uNdR7kKzeIIZhQ6hqGw==
X-Google-Smtp-Source: AGHT+IF3C+gAe9enWE6coDrJOE0PJBinw+OtrvrTgQQOl+8HAIq0aTYlzIw7cnuVNYgk8Zd7vO+IRQ==
X-Received: by 2002:a05:6000:2c2:b0:385:e8e7:d09a with SMTP id ffacd0b85a97d-385fd969071mr2152487f8f.2.1733226848550;
        Tue, 03 Dec 2024 03:54:08 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385fa330ca0sm3064430f8f.11.2024.12.03.03.54.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 03:54:08 -0800 (PST)
Message-ID: <32fdbc0a-ba70-4d99-93c8-15ec8ebe6f70@suse.com>
Date: Tue, 3 Dec 2024 12:54:07 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/18] gendwarfksyms: Add symtypes output
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@samsung.com>, Neal Gompa <neal@gompa.dev>,
 Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>,
 Miroslav Benes <mbenes@suse.cz>, Asahi Linux <asahi@lists.linux.dev>,
 Sedat Dilek <sedat.dilek@gmail.com>, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 rust-for-linux@vger.kernel.org
References: <20241121204220.2378181-20-samitolvanen@google.com>
 <20241121204220.2378181-31-samitolvanen@google.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20241121204220.2378181-31-samitolvanen@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/21/24 21:42, Sami Tolvanen wrote:
> Add support for producing genksyms-style symtypes files. Process
> die_map to find the longest expansions for each type, and use symtypes
> references in type definitions. The basic file format is similar to
> genksyms, with two notable exceptions:
> 
>   1. Type names with spaces (common with Rust) in references are
>      wrapped in single quotes. E.g.:
> 
>      s#'core::result::Result<u8, core::num::error::ParseIntError>'
> 
>   2. The actual type definition is the simple parsed DWARF format we
>      output with --dump-dies, not the preprocessed C-style format
>      genksyms produces.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr
