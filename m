Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7EF409100
	for <linux-modules@vger.kernel.org>; Thu,  9 Jul 2026 11:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783597715; cv=none; b=KvKDDaKdOw4o8ffIH9hLr5vP1ZCscQ6vFnAvgXCneaY+DV3//P8850gyPiNBH+7BmuJQUQmR1if8ImNggw1KV29xbs2m5c90dkDdWebGX4ZXM4wH7zODxJj6mlT7I4TsUMYUz+Bv7s2WfrpX0DP7E4584HbBgj3vEk1KXnwGz50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783597715; c=relaxed/simple;
	bh=YcrbCGbp9yVb3kD+7VwZ981MYBaNshwP+EjRjcaw6ew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pmnEpY1yfkL94anc+ki9CkieY2G+/daUR6N0uL3nFJNIGE4i69Wo/+gUfq5Ks75HqwLZzGJZ6b1EmlG0zm3wXXGTNS4sMrEWUUDmw8cHlC65IiOUHlk2d9HFTZSPnVsa0p1MnxoQc4GWi0JaI/+Rb5mJ6aP57UOYW7NQn2msBbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PaFBy+x+; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PaFBy+x+"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493c7902f47so13855595e9.1
        for <linux-modules@vger.kernel.org>; Thu, 09 Jul 2026 04:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783597711; x=1784202511; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/xhIPKXuDtakaGagT1mNyUeziKP6acuLSpzf74bewak=;
        b=PaFBy+x+7SHjflPNCa+CDICA8wvgiDxnvtDKWQjjeU9EhcvOyejEfUI6r98O1nJGFu
         NVp5Zk80Qk2OF9/raQgIZYDp/STvbfY4aZSFRWHHufLmGF3IxiadXQwR86YptPyrH2T/
         H1ZNEWqd80EM2J5EzfWGSLiJVo9DAiH4p5e9gtldTY15wBjlO2iHakylbjvlJVPIwmK9
         VGvg1RvG+wfLcWm/OlAjROU+uiNNbakrhyWYcLUffwgf9ALB+0Rt3gD0K5aKIR0TAF46
         sjqpbW3Z6Jji0OqvCxF2DvGmcDAKtEVkWCIssowaYD+ujzQun4MHVRx2nUyKFaqarEmE
         CQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783597711; x=1784202511;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/xhIPKXuDtakaGagT1mNyUeziKP6acuLSpzf74bewak=;
        b=Ivv+2SXrCimLrzGdrkHbuMSJRVhCfJeYSKFQm9RraxWqnHp7mKIsieMFrsqZB7P8TC
         E5VJFhnXZOXnvhZQovhE9HEUsu4fiAo9QgNKhlxp4T4qvR4qk/fzr6jr/BymE4VGcle+
         bFISqDnkOQFR27n+KQmL3FwFzOU2h9m4/IfGB9ZnI2I/0dtVNGSj82QlY+whhImYwg5g
         Tez/OML8GuL7oLGvxn9gpH7Cwkk35RXpCwjvdX5DKbnh9Siu1yrdEveap/9/u/1lP8NK
         LJzbWrp3QvLpB4+l4vynl4bjgxxaXQkFjoS9gJ6v43cxONRW4ml5DcP4DclNnnN2Pk3m
         +urA==
X-Forwarded-Encrypted: i=1; AHgh+RofsEe925TsjeDpLGmc9hbi74I/D4rWgWrZ83Apo/9XaBSMoi4gnA98MjVw9RpPSQ1iXztX5Z7l4tOJ5ufx@vger.kernel.org
X-Gm-Message-State: AOJu0YyAw0i5fCjsMXxuDAPLxSz98gr8kjVPhZV+b+27oHztfUjio1a8
	mFX3bAQRE9ScV367u+43iKnreV6Jm94SF8nIbRmi/xqSY7v7tpwcGg/nKR9jfKtFasE=
X-Gm-Gg: AfdE7cnqq5r3tvisUg3mTlz9dBle3Er4BvI0Qwjt8j5Y6UU1MNgDu/KfcY6u7ndZioM
	jlMAPLq8LXPA+/23aVg7wi0gwSbAEt9fBvR2oEnmMFHLy+Ee4L4As4GpyhGXDqhXsu0HLzgIV0X
	wMJW3F2Oue3CxLGUifNJiKz0Rqi23kvU1+dfLXzGP3OBLjkW1M5zrdhs5VCUv1iBKw376NLvEMY
	0qbgT6IscAry7MlGZXm60U+7cmyiitFhLYeQh1lkXo0suSteyGnQaQZR5J+DWY1hoy4/DM5KApm
	kEzViPjX9F4ImJ4BMRdEKPXKixO/wBCOT9bFKBPjbGv9GJeHlmblxVjYzeHgta4urDdTZYzwZfc
	UAfXGaoEN9cH6uIkmTFlIy4Buu5qw4t0aWtsM+agXtdRfbUKA5ZZU8b+2xCk9SVNlOCW7ELIzl0
	bgf4yxkur2Pfj+rgq5CpWwOfy22HB6T5D19w==
X-Received: by 2002:a05:600c:3e07:b0:493:de89:61b with SMTP id 5b1f17b1804b1-493e6868766mr66384865e9.26.1783597710634;
        Thu, 09 Jul 2026 04:48:30 -0700 (PDT)
Received: from [192.168.42.79] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6df417sm55696575e9.8.2026.07.09.04.48.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 04:48:30 -0700 (PDT)
Message-ID: <52feb9b1-2073-4fcf-b2d1-a7f42f1e72a5@suse.com>
Date: Thu, 9 Jul 2026 13:48:29 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rust: module_param: return value by copy from `value`
To: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
References: <20260601-modules-value-ref-v2-1-12ebbf0510c9@kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260601-modules-value-ref-v2-1-12ebbf0510c9@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/1/26 12:17 PM, Andreas Hindborg wrote:
> For `Copy` parameter types it is more ergonomic to retrieve the
> parameter value by copy than through a shared reference. Change
> `ModuleParamAccess::value` to return `T` by copy when `T: Copy`,
> and rename the previous reference-returning accessor to
> `value_ref`. Update the in-tree caller in `rust_minimal`.
> 
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

@Miguel, please let me know if I should take this patch on modules-next,
or if you'd prefer for it to go through the Rust tree.

-- 
Thanks,
Petr
