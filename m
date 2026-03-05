Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A8A2989B0
	for <linux-modules@vger.kernel.org>; Thu,  5 Mar 2026 12:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772714863; cv=none; b=oGxQDxjSHYhLijnnr460xCIFTX2/xXO8YdO+HzmQ15y2JAHtOZftiZKRnWOPD2u9eveF8h9NPJDYTFHwhG8QgOq11X5uth/6fa4B0z89DgZLBtjU4jsAelhrxOgo8H5eYCOO4H7uNKWK8lMPttNsEHdQMuRhoz3LKHYfvXytQIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772714863; c=relaxed/simple;
	bh=XyTZlz49dcBZy4m8+TW86YPTVZBYLxNCnLO0RL+KgGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dgxk7xvOIFQDTpZ/PODaR0fmj5SN2HfRzF+YKaV+ClsHE2QIpwT//it0Fmpmg4srPYMFDCKXrMNbO2JxNX7jNiNsnWdWpcn3DESjBVBT6pMlvruxG5IcEBKu+KoqKlawtjM5TpdZUyrleHqqrM93o3jyf8l1uqBSB1NRPYh6wS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EHILE0qi; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EHILE0qi"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4837634de51so34543185e9.1
        for <linux-modules@vger.kernel.org>; Thu, 05 Mar 2026 04:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772714860; x=1773319660; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zqNYIX4NXmfME4/eKoM3tAKNkR8+A/R/5/pglWf9PuE=;
        b=EHILE0qi21QsNQ8xMW6chZvySVvxwiEOCF35nskmYe+URb4SsSo2RUfVGJAYuTS+gS
         pVnfygoWKOVxQ5OAtMwkMFyXo9E2nKRin9usk0fbuwiCvr1Pp27JWkB4/K5Cn47ZwHlD
         baZ/T/RfmOzVv1ohvD5103oaXlhcUZzEJ3LrK8aLQaFPTPF18+QuIxzuZIGgI53oQHYT
         bqA3hMgD0ovqgtWeWHy4KsoPM+qVWei9bgZc6h5rIklJl48j96L/qRxA0y4a/fc2zHNI
         FaCIjuhO8UVnNZEUtueZgkUuWDwb1llfC9x1HrGlQcvuxQ0EMwIpJTZso/k93m2SxpxP
         GHRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772714860; x=1773319660;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zqNYIX4NXmfME4/eKoM3tAKNkR8+A/R/5/pglWf9PuE=;
        b=wiRuvHnoBNj0TYCD2zd0/slUfXIoOx6rxYhU3B/lPB1xiEZ/PnbNwu1wAu8mzdIgy9
         06ywW7jf9paE61+4FUtXPFSEzFjg3bbNthOTOUgEqaymRMWP3lPMB7ilTTwLg48GUh3W
         +piTdZUkPCmQKAmnzsVGOz3HXnmEAFWFoEiZWrNksf7B1+sbBkQYMv+MHuSMx9PlGZVD
         bisLh/UYPWNk+ZW+WcZvkNkDcJXIoj1x4io4AtEmHbCa4Dd2dDnJl8vlqu4qjTqeyhIb
         EyyAOH8DxGZAAOOElyMFoetimUuWIW0LyDMu8d9S7fptj7OZyj2XkzzcK34J9eboi7Gc
         E3Nw==
X-Forwarded-Encrypted: i=1; AJvYcCU5jiCFiBnNRVavUxphHYBaz0GBngPe5NVB1MNxT4L6MJHjgasSLNYdgi4Vm6RLlVr1mTMO1ktj74hJnni7@vger.kernel.org
X-Gm-Message-State: AOJu0YynjX0GaQQELtSpZWA4cbPrs7TCR9j7Ybi+HMDXnqLMsSwIStOM
	DRISASDAdOoLhid7365IWLNUSamzCLyXjeiVkwXvzzEB5ItfNXx1ZdlT5W/L5qh4xxE=
X-Gm-Gg: ATEYQzyFbIKipixKQESwmknX2kDE93AHVMYd2N0Sqm6Q1FqdhB2s5d96gfwRufCsXgI
	nAkJbUt4JCrGPvsT7NwU8IhOI28+BX/zAhfh6XtU0Ncgz75RU+xojdhaWiDVGZoPBX9oTwvm8PF
	mbVlPLC26T1ntqv01DysBkLtdOkhNhnMSuwY22cihliCCwQbBLLqADcWc+yjNOPTniVsIebfDYX
	O0Hbbdh2YvQmHcawNi+lobcWyJI5M0niBIJ6PC2d6N8jxHfJQaW05dB7ibfImBDe2xWLqlSpBoI
	Ja+bN3jhc5a2DWtDSMM/0CpMsnKfGk6dkyiJj9+y53tiacbZ/X/DD7FmmX/imYRHQlv2SeIJUGJ
	vQXTzoIEQ+/u46iT1DhjrHHr8xnvpHS/5HJNCgc6IPkq5ih1zp5RK8wtmwCqQmei6HFK/tfnsHX
	3rA/mSg0tOIYmGVG43qkCPRTH8+hSRv4TzBz3sTi1WXumj
X-Received: by 2002:a05:600c:c84:b0:480:4be7:4f53 with SMTP id 5b1f17b1804b1-485198c70a6mr97452685e9.31.1772714859895;
        Thu, 05 Mar 2026 04:47:39 -0800 (PST)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851a8a9542sm72254915e9.1.2026.03.05.04.47.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 04:47:39 -0800 (PST)
Message-ID: <4f09a589-c9f7-4d4e-a9e4-c3c9787a38ae@suse.com>
Date: Thu, 5 Mar 2026 13:47:38 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] rust: module_param: add StringParam type for C string
 parameters
To: Matthew Wood <thepacketgeek@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Tamir Duberstein <tamird@kernel.org>, David Gow <davidgow@google.com>,
 =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
 linux-modules@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260226234736.428341-1-thepacketgeek@gmail.com>
 <20260226234736.428341-2-thepacketgeek@gmail.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260226234736.428341-2-thepacketgeek@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/27/26 12:47 AM, Matthew Wood wrote:
> Introduce StringParam, a Copy wrapper around *const c_char that
> represents a string module parameter whose memory is managed by the
> kernel parameter subsystem.
> 
> StringParam provides:
>   - from_ptr(): construct from a raw C string pointer
>   - from_c_str(): construct from a static CStr (for compile-time
>     default values)
>   - null(): construct an unset/empty parameter
>   - as_cstr() / as_bytes(): safe accessors that return None when the
>     pointer is null
> 
> The type is marked Send + Sync because the underlying pointer is
> effectively 'static for the module's lifetime — the kernel guarantees
> the string memory remains valid while the module is loaded.

It is correct that module::args is currently valid for the module's
lifetime. However, I wonder if this is still needed and we're not
unnecessarily wasting memory. Since commit e180a6b7759a ("param: fix
charp parameters set via sysfs"), even charp parameters are kmalloc'ed,
unless they end up pointing into static_command_line when the specific
parameters are built into vmlinux and set during boot.

Similarly, if Rust modules eventually need to support parameters set via
sysfs, it will also be necessary to make copies.

-- 
Cheers,
Petr
