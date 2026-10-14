Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C38472072
	for <linux-modules@vger.kernel.org>; Wed, 14 Oct 2026 09:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791969664; cv=none; b=g2ikhmoR3BOmeoFciSJDSn8pZVps/iUjHaxLSaXque8BzydjgERb8JhBSN3kqU/t4lYnSxSGqdQL9+eXCg7iTbSBEU//aPmcHrB2hQfRHQx73KWg5IuI/DY9uf7UAcBlK8ePcVOtu0L2dsyagqeVm3mQZV8r0+BapB/KxDK3Mj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791969664; c=relaxed/simple;
	bh=Rpc3GO4+UP1CHtIfgBK47jOXKC7qTbuFu6HBwt4WZ3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l3o99lCUIFdCXzMgLCBqhZfMMMlsE5oUEHW8m1f9sxJqfYA4feXJDedVK+4jDH37gutoY4E4j96kn5SoaVtR++4Pc8hESYXCwnO/by4fU5vOJqHz2cf3+J18F7W2NnOXVVOoaCeOOZ7uocjnPse4C7huppBVlQ3s7JGW89Q6EEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DT9Zx0IB; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DT9Zx0IB"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a1635f7c89so7271925e9.2
        for <linux-modules@vger.kernel.org>; Wed, 14 Oct 2026 02:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1791969662; x=1792574462; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EyNMPvZIEMwn3spMNOwO+2v61MNWwL1mBLifJHjtoWY=;
        b=DT9Zx0IBufXfkL251NXbgBb5YlsSOGQwY+xRoHEFTf4ZEZ9qA9FzkYBXmALqwOzS4P
         Qy/6snrp/OjE6XmBT2T4A1EsGOmTqS0u75imTIirp7YeJax7EDQmahgKD0SojH5tWAMg
         vRtgdGL4L1k2o89mTK5GFxPIzZ26CgnxVJX8CteDAo46xZolXHPaMITBE5dnOgWXiOHS
         3/ClCvktlRsg7Zet15h9f9q+T0BONV4mJdzxkIUJOm/DqPknCV2oNrAQWLw+LUPgG/Ps
         VmQjTaWyM6aZNcPY67yhsacBgj/p1ouHCasS22c965ZxzxOW3pp6jplsvJbsAbh9RK2Q
         7Iew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791969662; x=1792574462;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EyNMPvZIEMwn3spMNOwO+2v61MNWwL1mBLifJHjtoWY=;
        b=JdkDRJeQh8cbVttFkCs47IqozXSl48ZpUzYOy0rWgVsaOjxB7H9HoL4MWcJzNRKQxa
         3SxdKV7C6HY5mjnVDHng87T368qRH94xnOMMwX0Pc3EiOaCvWUJCAiIpvxxoilqT9o5T
         k3QgPxT4hw5o32yWic3pcae8rkYiGYs9w5/h5hofJ4FzsIFpmLfcwUGlfPPFHPC8+MYd
         5PHGepIWl1EH8oiSzXWMfrg5bpULv0EebzjBg37a+Sji+Jabh99YqvwMjbpNJN44i/bh
         2lh7AYv7gKxYA4Mgcx5UcGrSH2pshAbuHL12CWcOHNpe9kWridxs5Q2YS2goh5SZTeeP
         1iSA==
X-Forwarded-Encrypted: i=1; AKwUvBzGhUVS4vGTAsE8gSwKYHfirPlwTLFVNvqB8gqQauu+kkTHRbWWiAXUu6ooxsSIU44YqzvjzO1lf2jYtr81@vger.kernel.org
X-Gm-Message-State: AFq9FYJnPvm+IYI28+6/T+fZSmcnf6nzXh8KmFkSNixX5N1rQvXHZBX/
	Hjyu+cXdf0Z9Aem2dNGhr+fGkk+h1vJbMhcOjLgoHuY1CFVPmA2zgnPjthTgF/lL4x4=
X-Gm-Gg: AYBFou1iW4qyLywFSmh3bA7ySCUrewFf9X2iQ6pGPpS9otki5Z0DVhWGkC08dL5BRpD
	dxSq4m9lZtWFGZ+3Ui+RZ5dSJvTSPTAt9pryAQfvsr0V8z6B49g68uwn7+mUn5kwM1yXH4orhs0
	A/fuz9xLn7Kr/p3jz7H73UK8FfAC3D/XmS9D8eEOEec8F+E4yDm4Meyl3vths2IvW0qhpBpjKyt
	pWQRjL8MlJWJL1pChQlREUdFWOht/AjhnM9lNd2ZlPBUwDfqKBgxOJHpIeLKlwkRjQrWwhSFoBr
	LDC361UX2Ghicy0twMqR5o0pJ0CNxPw2XTSvuEUzgg1jnKpn3IyyvbKgocPN/YRx3sBv1mwHivD
	DtUmjU88wYDlzowevEikt+Ih5JnSqZIuujNOAt9XaPc7bq4kzO0BGIDnR5+1/InDmmAtZkVnn74
	K6G1ohPiOzSGruPCzkxqokQjayALZ0eLGr9gjfFYCDRENb1V1zqqljPeWxERzauwHuZnqXd7np4
	ElpCEhNhvvbi1h908/zRHDV2U293ZYcA9d2hMh/vYVM9ZoJdhyXtij5ouDePZ/T9RIXkLuBIpNV
	Rxg4jnRZY9XTxxMD5l9fRuEsgeb7R7zO6FyMa0kx
X-Received: by 2002:a05:600c:3b2a:b0:4a0:2540:b46 with SMTP id 5b1f17b1804b1-4a18e4aca94mr281842445e9.12.1791969661826;
        Wed, 14 Oct 2026 02:21:01 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bea0f1csm617261045e9.9.2026.10.14.02.21.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 02:21:01 -0700 (PDT)
Message-ID: <6ebcb36b-8d0a-43cc-a47a-5b4a8af02833@suse.com>
Date: Wed, 14 Oct 2026 11:20:59 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rust: module_param: Fix potentially incorrect access
 of `SetOnce<T>`
To: Priya Bala Govindasamy <pgovind2@uci.edu>
Cc: mcgrof@kernel.org, da.gomez@kernel.org, samitolvanen@google.com,
 ojeda@kernel.org, atomlin@atomlin.com, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org,
 daniel.almeida@collabora.com, tamird@kernel.org, acourbot@nvidia.com,
 work@onurozkan.dev, linux-modules@vger.kernel.org,
 rust-for-linux@vger.kernel.org, stable@vger.kernel.org, ardalan@uci.edu,
 zhiyunq@cs.ucr.edu, dzueck@uci.edu
References: <cover.1789426258.git.pgovind2@uci.edu>
 <20260923203145.18714-1-pgovind2@uci.edu>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260923203145.18714-1-pgovind2@uci.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/23/26 10:31 PM, Priya Bala Govindasamy wrote:
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
> Cc: stable@vger.kernel.org
> Reported-by: Dylan Zueck <dzueck@uci.edu>
> Assisted-by: LLM
> Suggested-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Priya Bala Govindasamy <pgovind2@uci.edu>

I've queued the patch (v2) on modules-next for v7.4-rc1.

-- 
Thanks,
Petr
