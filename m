Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F559381AF8
	for <linux-modules@vger.kernel.org>; Wed,  4 Mar 2026 08:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772611987; cv=none; b=lW305d2+nJCHbdomeZOP2kW/G3h6+VKml2UtU6Kw5dihBJxGZm3QPLlw1EYxevv27BysP17AoB4dZsT92bigmTebZh4KiEU8kCdsn2OkOBneQHwaKn+jdcPQ45B+Vhu5rXxxKEK+rktv8wjSv1mjt29Af+XyBXiSdFEvF9tHC2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772611987; c=relaxed/simple;
	bh=crWmgNqlnMBQ03nDgNxxQUvIWj21atNNvKm8ubqqak0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aS2l/Nuv1hmfSx45RLeMeuNDfE7BysPw0FQUi9BB4LeQhO086/KEQ2t3IIzbx6MH+o6+m0C4Sm6RUiv+d2dWU7x5J+bsvFcQgEXrkMSsrFbLHJtFxZvfaE3NdqOD2hWOe42AI9DJDDhCqPWrJU7wc9KyBIrpXcckwRt/E/VAVk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RNHuSUO8; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RNHuSUO8"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-439b9b190easo1901782f8f.2
        for <linux-modules@vger.kernel.org>; Wed, 04 Mar 2026 00:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772611983; x=1773216783; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lkljEEI7m7cvv1eaHcluPEw1Mfpi3L3tnqN5jye2x18=;
        b=RNHuSUO8Nix+PnIrKdsux+HzYnBwJJzG/fUSeLzNICww/skyl1gwIGV1OfoxYlJ63Q
         f5uk1WA3nsukO8gRf7+eU9/xeasxp3bA6GLdDzzkboFCLGqO+uThKdfgXHf0xjkZOZKk
         vIJQ6/3pYuLReI992EkGhKchXpg8RZjJlj5cUZ+wE6qoWxeAQouVPcHlSowxAJ25Mp1a
         aCcpd/Cv6uEZuG6SY4zjGOPPsflDR8B04kTi1cBEBrLfzA1TH3DbtpP4lOYP4G2LfNfK
         ifv8W+LzNoadTtzFxiiXtr7pkIoUim+PqZA2NgyqnJbv/A3VWeetLAGxJV2BaeZ3GQm/
         zteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772611983; x=1773216783;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lkljEEI7m7cvv1eaHcluPEw1Mfpi3L3tnqN5jye2x18=;
        b=apyMfWE0lte7SNtDgSdexGMVsMGJg5ZlBu2iqbxDKljskwVHBFfEleaReqPH3Xau/l
         kj39/gJsFyRPJpVegbL4tIM3vN+TIJrjKDDVvaJP+bluOAYPqxeS4XUdNw6xbX9aVzcW
         HTYbtaR9wMnsunri+NrvaIVoBMbn7j0DhyCFd6Ba1XSYIIh8tJq5op5lZ2ZqRu86lmGf
         1WdTcsi3niIbCkKIVFU/3uNjLLlTM4tqklbWMH00CaOf7Hhqj/HxwKpvmyIeU2GEVWJ0
         ojgxLWEfoH4A+a8hlvCgU14oyC+7wkFu1V4nbbGY/KGoU6rQ3fAS2GX/neDBZBzFZitZ
         Uy/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWZTAWAPppUpHl5Ya9u0RGe1y8283g+cAIBFCOjhnA5c2smctNFzl5QabfCdEX+xFuuHbLnypbcHtx/0DDh@vger.kernel.org
X-Gm-Message-State: AOJu0YwVuVfhQNAgbq+13FuyY0n5zefDYm0JKB4HpmntVPcH1X/3tetJ
	ThRw8qhbzAlJln7BHpbN1Xho0kk8xYo4hMnyA/ThmZU8RmSyExKUAO4saqHJtXldQXU=
X-Gm-Gg: ATEYQzyUpfsuseJcY3RyWCkTYXCkyiGmU27gf7MciRogxAYTM8Ge5dXLvONSrL0kDOs
	j+4bik7niNFEX7/eklHynMqq5J1hmyx8Kydw6KjFINej0xa5BbQXR8FPJzu2/QhJd/KWsNi+1i4
	/qEneK2YpuS43AIFhrApnLSwzIV60uwgEho9SeenAodKD09iYYTwWiIVOotQ0VuzPjzr9I5/BHg
	nSgtLAD+UDsofgp5y1nCMfdJez2Jx8hzokIm6daHpRmstLYXCHw5x/FzsaGzbhLPY6WOriv9f5Z
	0MBKcAsAZEH/JzKYGnuIrxK7uH3ZkXX1ebiGEBps4Cun5KhBvPPdGMBu10ZywyhTsTEbYfh8ren
	WwCXczqbHd68SrxSvuqVaL2KXcR3c9aKiP25dyRjkwu5TF17qF3BLuvHxyNj2YXTHf1f7lmDafH
	yoq6WELxKAIclu2RbZpReMRl6beYpnt7mOv3LZtsaNcvdzYmrnZATdWd/2LNTvkMakB7F1RXBj0
	5SDWpEFQcdNj8lbs+Lmx5TR3DTcY8fd4ZlwDj/5OLQ6vRYwJT7b1EL7DzW4KbuLxzMETw==
X-Received: by 2002:a5d:5d0b:0:b0:439:a9a5:d3e9 with SMTP id ffacd0b85a97d-439c7fd3cfbmr2326625f8f.30.1772611983540;
        Wed, 04 Mar 2026 00:13:03 -0800 (PST)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b0549600sm26602877f8f.35.2026.03.04.00.13.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 00:13:03 -0800 (PST)
Message-ID: <f88cefdd-3366-4be1-a1a1-3b48d500138c@suse.com>
Date: Wed, 4 Mar 2026 09:13:02 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] rust: module_param: wire StringParam into the module!
 macro
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
 <20260226234736.428341-3-thepacketgeek@gmail.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260226234736.428341-3-thepacketgeek@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/27/26 12:47 AM, Matthew Wood wrote:
> Add support for `string` as a parameter type in the module! macro.
> 
> On the runtime side, add:
>   - set_string_param(): an extern "C" callback matching the
>     kernel_param_ops::set signature that stores the raw C string
>     pointer directly into the SetOnce<StringParam> container, avoiding
>     an unnecessary copy-and-parse round-trip.
>   - PARAM_OPS_STRING: a static kernel_param_ops that uses
>     set_string_param as its setter.
>   - ModuleParam impl for StringParam with try_from_param_arg()
>     returning -EINVAL, since string parameters are populated
>     exclusively through the kernel's set callback.
> 
> On the macro side:
>   - Change the Parameter::ptype field from Ident to syn::Type to
>     support path-qualified types.

Why is it necessary to change the type of Parameter::ptype? My
understanding is that this token can currently be "i8", "u8", ...,
"isize", "usize". Additionally, the value "string" should now be
accepted. When should one use a path-qualified type in this context?

>   - Recognize the `string` shorthand and resolve it to the fully
>     qualified ::kernel::module_param::StringParam type during code
>     generation.
>   - Wrap string default values with StringParam::from_c_str(c_str!(...))
>     to produce a compile-time CStr-backed default.
>   - Route `string` to PARAM_OPS_STRING in param_ops_path().
> 
> Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
> ---
>  rust/kernel/module_param.rs | 48 +++++++++++++++++++++++++++++++++++++
>  rust/macros/module.rs       | 42 +++++++++++++++++++++++++-------
>  2 files changed, 81 insertions(+), 9 deletions(-)
> 
> diff --git a/rust/kernel/module_param.rs b/rust/kernel/module_param.rs
> index 80fe8643c0ab..67ff6f2ea9c2 100644
> --- a/rust/kernel/module_param.rs
> +++ b/rust/kernel/module_param.rs
> @@ -86,6 +86,36 @@ pub trait ModuleParam: Sized + Copy {
>      })
>  }
>  
> +/// Set a string module parameter from a string.
> +///
> +/// Similar to [`set_param`] but for [`StringParam`].
> +///
> +/// # Safety
> +///
> +/// Same requirements as [`set_param`].
> +unsafe extern "C" fn set_string_param(
> +    val: *const c_char,
> +    param: *const bindings::kernel_param,
> +) -> c_int {

The safety comment is somewhat inaccurate because set_param() says that
the input value needs to be valid only for the duration of the call,
whereas set_string_param() and StringParam require it to be valid for
the module's lifetime.

-- 
Thanks,
Petr
