Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C4D366DBE
	for <linux-modules@vger.kernel.org>; Fri,  6 Mar 2026 17:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772817746; cv=none; b=gjAe+ojcsyFeRpkh6LDCLXRki+W/v9Qd0lBMtwW61OuYzECjckZYbtsji0+dlctaiaWoEeHm4I3cLh2MnGny3FTTbhiHzpehI7bF3PD3lh+HXBWR43RJs+/tmesOMr82iKz4I5lWntZDV955EhDHDHDYVFqC0ay7h4CbhAuA87Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772817746; c=relaxed/simple;
	bh=xxB+8H55hbL/yjvhqnz15bcDlScKmxdX8S07eoZ8gKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NMUc2Gwh4zIAG8TjIQ519kX2oB7BbySmvtSEN0XGS26ZOaE/LhG8dsxO/hwFd9ZijiLGjHOoDBb3o8Mf99e87RnSqWVYVCQ+F4VgJJv8SYAoqU1V1LMwKdt+iEYGWuM4RhjtW3JQ47QjIlDg6VeaI0XCyx9wUTlTG0l+x1+NV8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=au0Yn6VX; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="au0Yn6VX"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-439c9eb5d36so3011754f8f.2
        for <linux-modules@vger.kernel.org>; Fri, 06 Mar 2026 09:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772817743; x=1773422543; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YCiYsbFiG6El5+CfgRgDUsrrJZ9QgM65vIFR8M6oVrU=;
        b=au0Yn6VXmh/3GeqfKl4apMtNpJp0XpBswNmJxziLQVYxn5wnfW2+xemwWPQa5P+0gG
         LqtQWmeUH3q/+zTn7Me69tny7suju6D4+WyMJ4R0nuKXc0Pb96zc5enTtyI9Vxlpztid
         LR795Xzzb4As04AwHUFgucNfSHw3DF5+HvzRWv9dOVD/Lf0HsMVJsrsou8UCCT2bKBaF
         DYG2/IzepUKBa6RpzZBGZi80/d7GlVq2veF88uq8N5dailwBKE54cJqXCoPWKfamWelY
         kK6jkwoAic5nTSGbIbI2xZuljCmFo1oW6/g8xPWP+OtAwPrTR1qkC5aHmPXBmp+S+ErS
         lpEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772817743; x=1773422543;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YCiYsbFiG6El5+CfgRgDUsrrJZ9QgM65vIFR8M6oVrU=;
        b=ExILOUxnbh8D4Ht4nblgbS1I8ZfTmLL/K2pA314zck8cofFrsqq3udzd+n2Jv/LfE8
         eepF08TmMI2F0759B7LqQqa1doa5wxOxtG8Beyka5lYL+nT93WblkXizN2SRx5Z5mL3j
         A+AshwflWRIvgLJaLWMcKWUG2vky57MIr8GVEvLOgp2Ftjv70zbmfDfxi04OhmvgcOk3
         9PhcgS6WYDyS8oHu0Fp7icFzoSE7n428au/ktttT2mxdHC48dEP86SoL3KQSMkobLTlI
         pj4YkNis8T8ewdkrecwv5gZHOsPYqKJ0Zl8BfBNAjO6rwcqaBSOcHxUbVkjgiMVFQA1o
         Voeg==
X-Forwarded-Encrypted: i=1; AJvYcCVT2PTSRIMtcQiWbxT3KFgsM3+6U7l2aCUyA6uegoCFnqt2VrsHTQq07xQW5L2iN1+pR3ugegMN1BZtfxu3@vger.kernel.org
X-Gm-Message-State: AOJu0YwQdTDimZrrp0RbieCh9OhPuOSq3ZH/cw9BJ/9NR+EKNZ3/7klD
	ant1KEWQbxs93EWu6M3/W/55iCvUfiariEyKtAquzxEuRiAVUUS97cnShM0V3xehASw=
X-Gm-Gg: ATEYQzx+ByBbIH/HzK9/vb2ZcBZDbKkhAEDw3JPJgOjzyPeozOqniHYun5IPUTdPcVB
	s9LdTcuifswCC3Ua24u0BRV4xrgsXeTXzxh0sbTyrHfcCgRWGDfjgK3+IKaEvRqm4k4vzoNaOPV
	o0+lCxgp8znM5RGZS66C3fNlx8BEPqBJBkZ9oH+6SLE/OulBaeFXoSq4Qr3HMxj+pwQut7W/OJn
	pHTFLv8KThAgQ1y/0xFWxDGQP2DvnpJ+lcZhE3GeEIhqRBID4gDj988zwESsoxN8VxnvcFhKhzs
	sZ3emfDVVDa9OFAnDSuTl7HJTcQjz7aQH0hJ4pFzwWhhqhGMkUgXUGjMgmwZUmmdcLReA8iILki
	azv+ksf8JerqHlhEIF8jGJ7YnvcdScvc55eIIRjIlgDUz3raxDMmInn3nMs/aP8L9yvc+NLXGUX
	R0P+I/FberwqeF1zkScDNJPxyAXbELa86opo8QPB1GAZS3
X-Received: by 2002:a05:600c:548b:b0:483:78c7:e1c1 with SMTP id 5b1f17b1804b1-4852693046bmr52154805e9.12.1772817743033;
        Fri, 06 Mar 2026 09:22:23 -0800 (PST)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4852ad0ce60sm30982035e9.12.2026.03.06.09.22.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 09:22:22 -0800 (PST)
Message-ID: <488d93b9-d13c-4269-b7d5-ede1536f5701@suse.com>
Date: Fri, 6 Mar 2026 18:22:21 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] rust: macros: add early_param support to module!
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
 <20260226234736.428341-7-thepacketgeek@gmail.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260226234736.428341-7-thepacketgeek@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/27/26 12:47 AM, Matthew Wood wrote:
> Allow module parameters to be registered as early boot command-line
> parameters via the existing __setup infrastructure.
> 
> Add an optional `early_param` field to the parameter block in the
> module! macro.  When specified, the macro generates:
> 
>   - A setup callback that calls ModuleParam::from_setup_arg() and
>     stores the result via ModuleParamAccess::set_value().
>   - A static string in .init.rodata with the command-line prefix.
>   - An ObsKernelParam entry in the .init.setup section linking the
>     two together.

The early_param() macro on the C side creates an obs_kernel_param entry
with early=1. However, this patch handles the new early_param setting in
Rust by creating an obs_kernel_param with early=0. Non-early
obs_kernel_params are processed by obsolete_checksetup() during the
parse_args("Booting kernel") call in start_kernel(), which also handles
regular kernel_params.

Actual early parameters are handled by parse_early_param(). Note that
the command line parsed in this case is marked as __initdata, so it
would not be available for the kernel's entire lifetime, as the previous
patches assume.

So I'm somewhat confused by this patch, or perhaps I misunderstood
something?

> diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
> index 0c36194d9971..83dcc89a425a 100644
> --- a/rust/macros/lib.rs
> +++ b/rust/macros/lib.rs
[...]
> +                    #[link_section = ".init.setup"]
> +                    #[used(compiler)]
> +                    static #setup_name: ::kernel::module_param::ObsKernelParam =
> +                        ::kernel::module_param::ObsKernelParam {
> +                            str_: #setup_str_name.as_ptr().cast(),
> +                            setup_func: ::core::option::Option::Some(#setup_fn_name),
> +                            early: 0,
> +                        };

-- 
Thanks,
Petr
