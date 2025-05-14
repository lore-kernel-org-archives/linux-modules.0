Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E753221288
	for <linux-modules@vger.kernel.org>; Wed, 14 May 2025 08:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747211736; cv=none; b=JIkxnTfOj3D5+4kwcca0Lkg2gMB/aRuH6bC4p0Xrwu8hcTt3xhv2c/jTB+Ga2CgBWhGSsQvJytzJTN85ySk+J8F2g1kZOLi785ub2Eo7/Sk04fovhDaQI56+i2trmUFsrwOCHMcL2i4WmJ6R3zNk89XoeevS6YL6AQSZwl1+HZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747211736; c=relaxed/simple;
	bh=LnsVWhwJpBAkpZDh+52MQNw22R/I9maYDg8qpRVBVKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qrEkOdX+wjGAV5UGGEdhfOcPVhGlB1xBaNZHPEFlMF4jHNX91jwaZj+CyoAuZmJcvifVRMNk5qBPgCuxaI04ppksTQr3R2+lbLMw+T9un2Jpv/nLXvGO7prLq/Jdjzba1hi3XBEOGzgJdLfZ0nKp6MM+JqYWor4xrFCZXfkSqBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=daTGaeUU; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="daTGaeUU"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a1fa0d8884so3111797f8f.3
        for <linux-modules@vger.kernel.org>; Wed, 14 May 2025 01:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1747211733; x=1747816533; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V9zd+GoKgmj0lz1D+LN0r99cnHBgUgWB63kqIPzuCsc=;
        b=daTGaeUU6AmMCswrVFzQZN1mjZrlMIXH9TuBa85yg9Ria2TVuVhHfIbn/0i8kNyUL2
         xrovdREeqNFk9mRsJf/yoQOIchMOc+TjrWwc7ormUT673FVPjRAbsabyjHOPXqOfFpm/
         IcEvn3N8klO1XBsFzlxuGikxrhOfaxr33b+Ye8piOOaA7H4gD3Q8D5YlWAUWj1KQ0jXF
         LyLVvKZXnqrFq4onSKfU8ZeGd38rFm3R2IMoSqwog9ngVs40tbvowOtw4OOFkFwHR8+Q
         0ag0BDyqcBTIHJXX6xy6RXhjzB4O34TPXoDSLtO7n4olCEbmS/1VfKEU4DNrtUPQ4oi3
         95Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747211733; x=1747816533;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V9zd+GoKgmj0lz1D+LN0r99cnHBgUgWB63kqIPzuCsc=;
        b=TTP5XcbNVJwR/EoGH/b/h/1oi4i+gKxvwEHhAvt/YSi/IDyxJz8whqmBLiKgvw6q8w
         zPbdwMH53wJBH3pRPICHsmkDgWah5ErvZrdle+5ZnZhmKL1W4qpxP0bQgRkkweO1+rTT
         Wwyq/9EMGe9cMzO4gEO52idMjWCASc2wr0msw+X8GnPmPAOB1Z2gfke2rMwf5bMgJ8LX
         9Gzd9fEAFl/n5bd++2mdcuS51FxCp0A0EO1bfYYB702tInBE2igvQw5U8Dk2LQn43IaD
         uYaUcYCiSWswCYhQBIPwjrgUn+0bnKDjXrrqLdqsA+TcR+M75V4CW2+Mcku0EuK+17lT
         u0nw==
X-Forwarded-Encrypted: i=1; AJvYcCVOeA8VTl0M62fCqNR+1/73yiAyq0QoGdG6e6he9AMoIRKCzZEdu/66zs8Oiw5d7NzEXaj0an8chSSsTRdU@vger.kernel.org
X-Gm-Message-State: AOJu0Yysqw6nzCMveKwatdXMNtn2QanIMchQC2l4D7QhddQg08HU86tP
	5NfqweI2uwx8sbVVENmmCLDtC3Im1uVbAQtSi5KnbTrWWMyNNn1HHBoo8eEaGsU=
X-Gm-Gg: ASbGncviIoHImHj86Y9NJ86KymWPdK5ynKxLs7W3LnW7JDsiTtLwgB/sm5mN1PL+64V
	NohmJImVr6L0+X48JrrmtTUlKbat50wopLE+nWN2tXSWLRZa+HXdk6Zyo9cfeGiwUPORhv+m7p0
	aCIOY7QlGj328Oj7nUxLr2V+CmssouG5s7Ni/t3TmwgBz2itUirdWP/xIQ2hZs6LIFDcxEDhxtZ
	Zwu592QvIuVXO986MQ74PC1tIci1gKn+iNGHp8/j+piQjYTRNvF8hYjYm/Yg3AU6a5dXxp5HGCt
	iqU4wtvRtIA9y+1al8hnwZMuxQFqVY+9S5NPnwCTAPiEKn7Cs02ECQ==
X-Google-Smtp-Source: AGHT+IGT6wMyIUernPhTKllof9XQpCI1zQrbycT2cwRsu9zmtZYLZ5dRauNiPAUk32i9JzaAtr/pSg==
X-Received: by 2002:a05:6000:2481:b0:3a0:b550:ded4 with SMTP id ffacd0b85a97d-3a3496a47f9mr1500267f8f.13.1747211733319;
        Wed, 14 May 2025 01:35:33 -0700 (PDT)
Received: from [10.100.51.48] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4df3fe369b7sm6319632137.16.2025.05.14.01.35.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 01:35:32 -0700 (PDT)
Message-ID: <eb13d6b4-3c6d-42e6-ae58-bb4454297c5c@suse.com>
Date: Wed, 14 May 2025 10:35:23 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] module: Extend the MODULE_ namespace parsing
To: Peter Zijlstra <peterz@infradead.org>
Cc: mcgrof@kernel.org, x86@kernel.org, hpa@zytor.com,
 samitolvanen@google.com, da.gomez@samsung.com, masahiroy@kernel.org,
 nathan@kernel.org, nicolas@fjasle.eu, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org,
 hch@infradead.org, gregkh@linuxfoundation.org, roypat@amazon.co.uk
References: <20250502141204.500293812@infradead.org>
 <20250502141844.154517322@infradead.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250502141844.154517322@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/2/25 16:12, Peter Zijlstra wrote:
> Instead of only accepting "module:${name}", extend it with a comma
> separated list of module names and add tail glob support.
> 
> That is, something like: "module:foo-*,bar" is now possible.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- Petr
