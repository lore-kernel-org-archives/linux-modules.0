Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4572952BE41
	for <linux-modules@vger.kernel.org>; Wed,  9 Sep 2026 10:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950923; cv=none; b=bYYNcrzW2RGAINdggw9Il1BC80lH7ifQaNhVi8GvqvGcIDbYvZupICn+asWRM0b8qzNxt8N4i8nL69t6pKGXycx5Dp25EYTg2NTOYK8BqcJb+ATNhcvcQSWvQztOPBwOW3beGO20e5WglU+XRqSO8/KV3clcC66JePFzSLX+Hto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950923; c=relaxed/simple;
	bh=RfICaU7xfsnGtopcY/8+e+49SBrE57+bxnvz+o7EC9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OLr8sCshKSkfWuyNE/ozKWkPftNJeSFzKSPoKzmnWXVoDRoexe3CooluagN1VFzxmWiqEQ4PyGkCukxJj/o4ByTBk0ZHl5XgZz2aQVVGb6KxHi0unTJkcc1RB1JZx12r0faLtmBubjYgRhjJXJBiZ0K0ULrENMzmPP5RKcPbU6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Sq4+JJ9h; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Sq4+JJ9h"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6356256so915732f8f.1
        for <linux-modules@vger.kernel.org>; Wed, 09 Sep 2026 03:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1788950919; x=1789555719; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fp9cDcIgqv9R0GmI0T3fSlFaJIuRkiEzDQkxcvyJO8s=;
        b=Sq4+JJ9h3eSGv31LrDnEy/Y9tPm7N/RPd3uAqGMMqzS6O2od/jwTofKpMB1YygBHaJ
         s55WbP2BC3Ovq4l/l8vKrYlrV8+wekKQpYdt+Yg/kguv02OgtM2VnI9fu6PcCGsf8dIw
         pQng1G6eFIF9aNgiPqGehnC+FOFZ3gdiYFCSCvk+Sa3onnQ6edJxUr2BygeWTNaR/qOX
         OJlfhhBe6H0HI5ZfNzEDReR+bMm4OzBRkJptkweQE21a8KbTAm7TIpCgbUsj57L3TuTy
         pCnPAZawJ++Qi2YMx9mBI3FRclUlQFcUX+z1GpfGgTMA55haS9ZBrBahtJP5ZIrbiWR/
         9Axw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788950919; x=1789555719;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fp9cDcIgqv9R0GmI0T3fSlFaJIuRkiEzDQkxcvyJO8s=;
        b=dYnkyNRv9dVkRR3MmnKKVVQ3rQw6gahtr1GH56DsJzFYbPxvU/kHwbDeo9RBKx5+8F
         3gaLWgurKpXP050ah4vFuSXnLxU5TJkl40GuSV41wmFUKKcDIFzAKmsHmEDfoGJ2Cd8l
         7tSzT1ed3PSbBb7EpKhRjo/E6LkRfk6cWcPTWesHxGRXDhrt/7Rnxvsvv90Xhtr89c0+
         QTmrCxTu+NY/W0+XRwy+KFZWJ8lKq99rOflxosKC8pK2M0OHjFnSMgogiDxqPy7aCWeY
         d9pS7Gkt7qTQ4mjGBCJ7JJ9YPYNTkC/P72S86wMr05z22hA1SkgBaUe1l4rQC1oJ8gtr
         naCQ==
X-Gm-Message-State: AFuF++ktKNrOnNePTYA51Z713IXCNmuYl2+f3HEPtnPGtZROfDQ0OZQe
	WIK2RR1sSkH6yE4abFwB5Bd298yPQttE6pUszpqD9YKw6mKgeTM2br83t99zoXExqmquCDYfwyx
	7i13v69o=
X-Gm-Gg: AYBFou2rQje0hI2RuwkNYHBDbP0fLPBFHe6dvVI3VSB127EnSpO+HfxQ+Jag0EHKgrs
	0n0golQ/JXDXJKxivdR9A7HkytY3D9RigOIzMPfZkyXq0/zI71uEYrpvuaf7pXtvdCmxwtR182P
	0FHeq2a08iMUDTtAp89lf2YrUq91DS4rwoMtbUQXsUXM/08uui5m5VE9V10xQqj8Z3TnB0d3bEJ
	SkKhaZiOXF0qTVMSmsB51YEDoswHGyNrEeEisz9mhPEopQ1KiPBsLII/g1utMS3wBwMAdXEXM49
	Ri9QfOEASpHHw8NE2xKxvmeexsR0AYQwnyqEqXJV5jNB3YzWW5HbDqVFTUF53esGXxvysQOF601
	1tbxgKFmh2hKO5hnMOiIUvHxohQdxqHBuIhFqYOWU9pJ5nVfHKykcqNUAUw5vJDXHOmtX+RxKzI
	NVjM2iS66qdnqqi5VcV6uG1VBItGXECkSoIJfYSjUYwYLQYVJylzmCMoMe9657pyXcMlwSGlAGA
	qqpxmhB54m8vXYjvI/fItCse6+1bF0x+0U=
X-Received: by 2002:a05:600c:4752:b0:499:59fd:dbfc with SMTP id 5b1f17b1804b1-49d175439dbmr130746725e9.1.1788950919460;
        Wed, 09 Sep 2026 03:48:39 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:89a9:fd0e:583d:4a53? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5d476esm601637165e9.1.2026.09.09.03.48.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 03:48:39 -0700 (PDT)
Message-ID: <312a7fa3-28e5-4d73-8d67-591fcf825c8f@suse.com>
Date: Wed, 9 Sep 2026 12:48:38 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] Ignore local labels and mapping symbols during
 module load
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: linux-modules@vger.kernel.org, loongarch@lists.linux.dev,
 Josh Poimboeuf <jpoimboe@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Huacai Chen <chenhuacai@kernel.org>
References: <20260820125007.22943-1-yangtiezhu@loongson.cn>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260820125007.22943-1-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/20/26 2:50 PM, Tiezhu Yang wrote:
> This series prevents compiler generated local labels and mapping symbols
> from leaking into /proc/kallsyms for loaded modules. This ensures tracing
> tools like bpftrace can resolve accurate kernel stacks on architectures
> like LoongArch.

I've queued the series on modules-next for v7.4-rc1.

-- 
Thanks,
Petr
