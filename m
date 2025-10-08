Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAAA284890
	for <linux-modules@vger.kernel.org>; Wed,  8 Oct 2025 13:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759929880; cv=none; b=S9AylzREwboF3TBp2PsQMNKysrOSm6QGimby166kTcxCj0aGf1qwjutI1cYF8Gvm1ZALSOm/wNCb4GYLXWUo7zV3f88JRrwJpXEpF73jlFwu8r/IqCf49XG6Ep127zovB/kR9M8dM/VlevgH8vwmql+EBraY7yGS9GbM8qSc27Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759929880; c=relaxed/simple;
	bh=fHRL68xgbrs4S5d+Rk03mc7ClH8sihNkbqrGqaL31yo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i5pt2/PqaDZ+uxsxAhL/Hm0BUBLqnGcs+f9jA5//BaMXBXCKKCLNvW8AjsJdbm10DQ2j2HM2/PbggHYPc5rIA4hTLLq9YrjU8NFNU7whsAG9zT5Fi0QiNfqjR13zYL8qxw3BPOgdHjr+aPTyqibl7RlHnpdd/rj8bJgmasMQSPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WA3uLfNt; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WA3uLfNt"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3ee13baf2e1so5552387f8f.3
        for <linux-modules@vger.kernel.org>; Wed, 08 Oct 2025 06:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759929876; x=1760534676; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ai9bodin2zTCE30sm2MezQ75jr/Y4H7WdWVegLgSDKU=;
        b=WA3uLfNtZKVV9l37I3e/ToYZya1MGuHLUToON1sDJ/mLNk46sz/nZGuPgKgrnftm0t
         HjTiJHGd+b8TbTp8eU2AQrbPTpifE+cM4okUjyzbzXtjNNkWm6TiDG2fgLsoUvQ/543K
         broEnKIROX30s0w4pdscVGlZYdYRs1ZSg0ALpZFhRbFMD5pBMpXgG2xDETEN3s9rO52P
         ayBhwuPWIMGvmWTxzTuBPYmkuQ2YObGPFr4YCWt9S8aNBtJidU7quF6COOIeSrPQJL+4
         GPMcCr1hYobFqLfwpJzqZgyj7dW9HM4M0VnjpYnYXk0fMfT7zTnKLKA8qQhdicB8t71T
         gNFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759929876; x=1760534676;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ai9bodin2zTCE30sm2MezQ75jr/Y4H7WdWVegLgSDKU=;
        b=tOZfaWLpKIrxN7j1ch11qGXP9f5zS+Bcf+24LeqQzLhxxy10SBuKZr9mFYbAxJKYoL
         rifXlgrNZ3KSSVMxEAga6G65KyciX8UQF9KlPMVGcs7bF6FWBCDdBypLyBPOPeH9AKww
         EmYx1e2Lq18z06pK5mNOIegQPbEEp/uvjK2JHrsHwxzyfzYdAEUBD9H/NAuZTg3ieOba
         zfKsblLa6VylZA/XKeje3legJr2frkGaWDcs/fAFPc/XAVI1tYKr+l2FoPvKFLkgUwOJ
         g1V9wtdSLgqRDq9yVIJwCYivFSU0HzUQHIpj7FrDlAWFClvZzUtnDIQG2qrqPahLJX+e
         vOSA==
X-Forwarded-Encrypted: i=1; AJvYcCXgHEQIUXbrP1UUlqtG5Zkd27l5pIJRPaSpNbWuIVW4tHQYt+RW+k6iQEIxX4F7OxZjeD3lmkgYB1H/q5iH@vger.kernel.org
X-Gm-Message-State: AOJu0YwIKSz9xwEq7e3e3wOBcolAfUiK/5ZWFOASVLSa+9emeoNMKkZS
	RhQ0RlQITSzwzpLzc8NAm4QzgPTsjCYi/B3EaZtVjgiORAf12sIdAogNCzkz6IAfgLM=
X-Gm-Gg: ASbGncu5NGwVt8rtLpeYoF6H4aZQc7aeujrgR5tuPgBxHjITduKw4MTipgciqBbHi7B
	qBu7OtebKnnAY2+yGgzwbgW0+PF5/ovfFI5TGEpHvSHHV3ji63XfU9fF5OdeScrrkgfDSRKw+Xt
	qPOxdDa36mfyi7jj9dgumw/eeO8uhd+PhKWvUPwUVZhCz5tMlZ9h7MeKRxnuDKyD//ylIRM4HHa
	7v4o/jU80H0S2kCWMe6U/FthB+HWQibcXo9piovW4kpd5IhNqsu3VWhY55y0VhtSwpcYiq7f+Ph
	OUEXXNPtPpen1UMxiwKOZgSjji9230Tg2w3usK0RdKbfsIn3LcXJ8n1gJx0NG8y/jAR9H3SV67j
	bYuShY6aCU/dfmPW7vrsLDgBiwURdXv5ircLPpzqDWyboEfkTjUiv9Ch0DsyBqq1S
X-Google-Smtp-Source: AGHT+IHuhMKyjw9ZbS23OBrv8VA5JUlHXtFCz8Wrw4kfUqnmq3pfnc8RuPQ01+3mL+le3/TLouPIeg==
X-Received: by 2002:a05:6000:22c7:b0:3ec:6259:5079 with SMTP id ffacd0b85a97d-42666ab1b7fmr2477434f8f.11.1759929876072;
        Wed, 08 Oct 2025 06:24:36 -0700 (PDT)
Received: from [10.0.1.22] (109-81-1-107.rct.o2.cz. [109.81.1.107])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8ab8b0sm29892836f8f.18.2025.10.08.06.24.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 06:24:35 -0700 (PDT)
Message-ID: <b394956c-5973-438b-9e43-f7081a89fa97@suse.com>
Date: Wed, 8 Oct 2025 15:24:35 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] remove references to *_gpl sections in
 documentation
To: Siddharth Nayyar <sidnayyar@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Nicolas Schier <nicolas.schier@linux.dev>,
 Arnd Bergmann <arnd@arndb.de>, linux-kbuild@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250829105418.3053274-1-sidnayyar@google.com>
 <20250829105418.3053274-9-sidnayyar@google.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250829105418.3053274-9-sidnayyar@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/29/25 12:54 PM, Siddharth Nayyar wrote:
> Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
> ---
>  Documentation/kbuild/modules.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/kbuild/modules.rst b/Documentation/kbuild/modules.rst
> index d0703605bfa4..f2022fa2342f 100644
> --- a/Documentation/kbuild/modules.rst
> +++ b/Documentation/kbuild/modules.rst
> @@ -426,11 +426,11 @@ Symbols From the Kernel (vmlinux + modules)
>  Version Information Formats
>  ---------------------------
>  
> -	Exported symbols have information stored in __ksymtab or __ksymtab_gpl
> -	sections. Symbol names and namespaces are stored in __ksymtab_strings,
> +	Exported symbols have information stored in the __ksymtab section.
> +	Symbol names and namespaces are stored in __ksymtab_strings section,
>  	using a format similar to the string table used for ELF. If
>  	CONFIG_MODVERSIONS is enabled, the CRCs corresponding to exported
> -	symbols will be added to the __kcrctab or __kcrctab_gpl.
> +	symbols will be added to the __kcrctab section.
>  
>  	If CONFIG_BASIC_MODVERSIONS is enabled (default with
>  	CONFIG_MODVERSIONS), imported symbols will have their symbol name and

Nit: I realize this part of the document primarily discusses sections
related to modversions, but I think it would be good to briefly mention
also the existence of the __kflagstab section. The first sentence could
say:

Exported symbols have information stored in the __ksymtab and
__kflagstab sections.

-- 
Thanks,
Petr
