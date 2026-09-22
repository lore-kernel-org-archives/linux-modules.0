Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B45D541453
	for <linux-modules@vger.kernel.org>; Tue, 22 Sep 2026 12:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790079419; cv=none; b=l1ed0AS6lR0VDPA9CIfjduWpcVv+OHJC1SWDajpcXOrS+Q187q/dQxrSLOcsYHD4yoJvdiqbApiKiL5Zf0F+XuACuIUopzKGQXWEmnn3AJs8N8mBOYgXMT66Qr1Epk/bCbWbndkA6g4NumPJK14Oh7GUqlBI6LWFqiu+mXij7Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790079419; c=relaxed/simple;
	bh=be2Y1OoUX2Z3H8XLQu3ekiAnAW4Ns+iopXrYkhiGjFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FCyWbHMcs1WOLilhsBLtGA8gkqJvpJwZMrAgImEe2zpFCc9xCZ+o5Pq20fq68LFb3JLh81dPwHx1pb1WJq/yolRF6PfA2B/b1dV9ho8+J4X11TxoPK8VzwJMeVCHaDuBs9wYZAM6omcuaUtUoQBUauHvOX0XbKRjgYCQx3iHxPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OQZUocIX; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OQZUocIX"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6350f91so2425481f8f.1
        for <linux-modules@vger.kernel.org>; Tue, 22 Sep 2026 05:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790079415; x=1790684215; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qYZAQI2MQFIAWvU45KsUnqIxxfeReE1kdzg/hPVRdMU=;
        b=OQZUocIXA25N0fPKAIruZntV3ZEP5EN9YvzISI0VjBPrjdipX7NzMz+lzmuBsDyf12
         9VR0htwPwVJwwbAHd5/2A7+BQA1G5ZkIgbBWZC7fbWneEEZwTF7Uka1iUjEAVx4dg5t5
         /D+F2VwTjsqGwdh65OAFeJjLmbxfmmAATZqA2d7K2fUdG7Tvj+1z5jMLgq2Orf0uR2VP
         TwamgpEB0xHuLK2LLBRWj06zls6MheTHDsXVcFQrMVY+iwn7avH3pUwxw8JGOsojM3PB
         CcNt/a8PcNZqY26jA0M8wD5sEQHLamKAWgOe/al5LPnuhQq9bMGJ3LERbDD09cqhMYL2
         wecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790079415; x=1790684215;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qYZAQI2MQFIAWvU45KsUnqIxxfeReE1kdzg/hPVRdMU=;
        b=TPdxmmhh9HKI63h25Wt3IuP2rswH2b7MB0vfdf+ij0N4zPbzXuywWq4ZQ5Oj8+pMan
         DvL1Ht+vantTgeqz8XKvPZEb/HQ3n+Esq4EmmW+qwogUuMWuhvod5rlWzZEPTXK4AH+3
         +VSwsdZRq+EkbQ7ubJcgvXFvwBeA0adMHQIKGAV3R8w9Q8G5kcCOhMBMxD92opc9vULU
         9kSAwwzF+88368dc3LdLEO6U3tJwlHdRObQ5rgPSFJxT+WwcIYbxeqhB4YYpM+8ZMHUA
         c/AytGnn7yTVlD7+jFVpaVKw3VbHB4Ygaa7TvNK4T/h35z9vl/iPytA55GYTiYJeDp9p
         fYFQ==
X-Forwarded-Encrypted: i=1; AKwUvBzXbfH+CdT781yq6EsfCAQ3ise7CvdFparoln2OFtxSmr40b+z/DW7q6+Vd09RU/jNG7fY3+OSXmgNuxyZA@vger.kernel.org
X-Gm-Message-State: AFuF++kzsEGMgiIeq8oUiAN9Y/RQNQ6zqU4chn5VfmHGIMhAFVWaKZYw
	yKSNqGhHAefltJN5MODEbZOSqi3SeHg3MK7wb/r6gS0qmbcjoUTfV75+pPNXLCRappY=
X-Gm-Gg: AYBFou3IiwPxBm/BoVEQUn+GCJd5HmJx5Cr5kuy/e2RouH+ToEupOm18GhdlIJ5OAzT
	5T/EN+d8bphzpBc4Qyf6JYbegpGA7p7Uw6NliaVbnc8vYcrbZxu4Bp44IX8rrIm4/tPEmEjO3/p
	wSdd1QtfOigIiQ5wcIBSjDOWnEl08QspFK9OQuAN0LywlKPg1xdeLyeIQnFjeEi8Eq7F2lZPu1X
	VtGa6K6ydiSLulUOQDt7gecE5sORF7FzJfSaS9Ch45Tz01LbkumcT5jV0GpdRIZXc4QBu01t6su
	z5J6NrdulgXBznL8OADdavKGBuSZaXpOcxY09rMFoVSieHfxHkOsdn5htkazsGpQHfbUnwWMvqa
	nenPxEHtgaXFzvrxGoz28ITwu10BSl/pidSd41xRrAdT4z11gqtiTFmAHQ1s1P/UaUZc4JpBXmP
	9u+fHf/JpNHJWVwqzTEhUsJ/dFduThOMChOnRPOP9VHYvl9RAG9cRtwBru+uqv+nAzLqndrfFwW
	ipztCyCo1lf/cQ3Ri3e+oj0cidGDnD8N8YTOdB+SNJ5cRfaEFI3CR+ecvcYRZ4FWdHOHxKKbZBk
	BI5IgeAdcDY12g4EnPw+S9UFBBR8i4yarQ7vgaVkGmMlsf8W/7U=
X-Received: by 2002:a05:6000:29d7:b0:488:5d3e:bf47 with SMTP id ffacd0b85a97d-4885d3ec41fmr4775296f8f.33.1790079414556;
        Tue, 22 Sep 2026 05:16:54 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-488627937b5sm4088822f8f.30.2026.09.22.05.16.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 05:16:54 -0700 (PDT)
Message-ID: <0f8f5dd7-06b6-4145-8b85-ed62504e2d4f@suse.com>
Date: Tue, 22 Sep 2026 14:16:53 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] rust: module_param: Fix potentially incorrect access
 of `SetOnce<T>`
To: Priya Bala Govindasamy <pgovind2@uci.edu>
Cc: mcgrof@kernel.org, da.gomez@kernel.org, samitolvanen@google.com,
 ojeda@kernel.org, atomlin@atomlin.com, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org,
 daniel.almeida@collabora.com, tamird@kernel.org, acourbot@nvidia.com,
 work@onurozkan.dev, linux-modules@vger.kernel.org,
 rust-for-linux@vger.kernel.org, ardalan@uci.edu, zhiyunq@cs.ucr.edu,
 dzueck@uci.edu
References: <cover.1789426258.git.pgovind2@uci.edu>
 <e65203759411aeca4805e3f619f3dd20839dba35.1789426258.git.pgovind2@uci.edu>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <e65203759411aeca4805e3f619f3dd20839dba35.1789426258.git.pgovind2@uci.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/17/26 7:43 PM, Priya Bala Govindasamy wrote:
> The `set_param` function casts `kernel_param.arg` to `*const SetOnce<T>`
> But the Rust module macro in rust/macros/module.rs initializes `arg` with
> `#param_name.as_void_ptr()`, and `#param_name` is a `ModuleParamAccess<T>`,
> not a `SetOnce<T>`.
> 
> ModuleParamAccess<T> has default Rust layout but `set_param` accesses its
> first field SetOnce<T> assuming it to be at offset 0. This is not
> guaranteed by Rust and could cause type confusion leading to data
> corruption.
> 
> Fix this by casting `kernel_param.arg` to `ModuleParamAccess<T>` and
> then accessing the `value: SetOnce<T>` field.
> 
> Fixes: 0b08fc292842 ("rust: introduce module_param module")
> Reported-by: Dylan Zueck <dzueck@uci.edu>
> Assisted-by: LLM
> Signed-off-by: Priya Bala Govindasamy <pgovind2@uci.edu>
> ---
>  rust/kernel/module_param.rs | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/module_param.rs b/rust/kernel/module_param.rs
> index f9a14765a926..7ae87ffe1d6b 100644
> --- a/rust/kernel/module_param.rs
> +++ b/rust/kernel/module_param.rs
> @@ -75,7 +75,9 @@ pub trait ModuleParam: Sized + Copy {
>          let new_value = T::try_from_param_arg(arg)?;
>  
>          // SAFETY: By function safety requirements, this access is safe.
> -        let container = unsafe { &*((*param).__bindgen_anon_1.arg.cast::<SetOnce<T>>()) };
> +        let param_access = unsafe { &*((*param)
> +            .__bindgen_anon_1.arg.cast::<ModuleParamAccess<T>>()) };
> +        let container = &param_access.value;
>  
>          container
>              .populate(new_value)

This looks ok to me, except for the formatting. I plan to take it on the
modules tree, after giving others a bit more time to potentially
comment.

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr
