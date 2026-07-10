Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950F32E7369
	for <linux-modules@vger.kernel.org>; Fri, 10 Jul 2026 14:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783692634; cv=none; b=czWsiLeLy5mdAZcE8rrosmLazjYbbHLi53JXtuhKsgiD+/ociDwRvPp+kgZy+s8FH2V+r4SeXvAJSCFEoEUYZ6nDdNSzWUQb8xi7FNyIkMOeJPCYF2A2/b1Xl2MRB0vh4fYdp49axNMlXQX2x3gECjs8SJ08dRFrggk/TSDShf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783692634; c=relaxed/simple;
	bh=ANjkctNcuMAImXrJGww5k/0C1OC8Sw8gShkszAutm/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JeYRlOhAg2smFYDh13zqVhyZ6nWrewrT6NiS1tEPZ72UP1FfqBwFIGv8CwzZyCoB1PI/Vq4ZQBAKaq6f6YBQbj7CGmnGW/HDX1bpJ2SgQMv0CTr8IrHRaQbxz2fd6jzOj19HPIDIJ+czpzJ5TX2j58db8b0xL/PfxEJBocfzyw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Iv499Orm; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Iv499Orm"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493c19bad03so8552125e9.2
        for <linux-modules@vger.kernel.org>; Fri, 10 Jul 2026 07:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783692630; x=1784297430; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cqZ0l6LzRTJPGQYgWIe1BLhP428UFzV157W6gh6Hzlw=;
        b=Iv499Ormvk/t9jG8PTMw0ZpCupyNlJ2A+k9Ha3LXTGUFV+Z2pNgPlNoGXczSSTeoQx
         2MyCJxTJrpn0t7PQhHO6NHzs2JVXmXOHIkUQ+CIZwDAN71pY6nodP9B2laNxHx5ouGxw
         cUBK0gs/9GDy0oL8VJI23HUif2zJvYkzANECGwkvglkyooXOE1mA0DlJqvRy9/q7tNTC
         2xnbRNsP/d0ciCFSidchYcktyFpdPa6jmuZwiOZmWTSc5kVU+54EMpOxb61YIsif8Ema
         PRTj2tptR6hpcJ20hnH/lhVWtF0iROK7LmWg9B/0ZytxK4GhuKYJZ7zv2hpxeqlLCQL0
         D/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783692630; x=1784297430;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cqZ0l6LzRTJPGQYgWIe1BLhP428UFzV157W6gh6Hzlw=;
        b=Llf64bEBKPBnUc8w+AxwP6AmIHtZZzYscOcGWThVvIh7u3FdvedfC9txskrGALbP01
         qQ0gIn21OCq8K5vsrZcRsQm7Pz52BdVD/d089fZ1P1tUghwE+ZCL9M49EYaZBtbPEx30
         8bVAtzq8ql1CuMrjDaJnf+dCJNLno31Xmj6cZ8jbzxm5ESQmjkCCLnhn1UuVYVy5c1+L
         k/Dcb0OLPatyYa6wlAbe4PcCwh2ZvGlqCnY0+Kr6hxXph2UyF7KwFmpRHvYLMd6Vft+R
         Up27zQ2gVRAcCDXM4FYNH1bJBiuPA9rhA9qsfAIPim9GMqlmjVK1ez+2AJw762q/SQfY
         OyBw==
X-Forwarded-Encrypted: i=1; AHgh+RrXO6edMuuzuWqCBkMqk1HOmnLphhJqxJZ+Wt1D1TXd57O18rhUiwB1WMOnQIoZhZLv2GaySswCYQPvUnRI@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2q0hPJ28pcnW6Q6ulh/BolbzLHR+pGamggreCVMO3uN8vA8ZP
	JgAtgU6RmjPj9vUP5RXBYXfRO7SiYdZI+txflhJdboq9eaWTsaXhVvCiKpnE55u7VDU=
X-Gm-Gg: AfdE7cl/SGiZWoUkz3J6BTMldS5yPUsYkhI801r8NKCHeStggwV0wu/NpHfHxYNwAtR
	vrsGO9fWWjHtxncFVvgFEq9E2rUTSNPHYij4RqsjAmu8PUJv6eiPINGZ3bjKV7U1HWbeH7b0iDw
	aEOSEcXi/fDJOJu/FLyoalrNO28p7Y2UE6XjaWC9EF6DNwbdvRwl7XfAKiK97Gc/MDD1qccCjuX
	qcdO2NQbpZ63k8xSn/OENnPfXc8o0emh7YUhGjfsQ/MqmYdnHHyB1vmj0HJ4KgjFHX/UR/iv0Hv
	6hhtbsP1+y16tLDhwvORuHbrjUGAmeQ9KfFCFRc3hRcTn4M6/15TAd/V9JZsT1/1lJl2DScaV89
	5l+e1rgFovVxw0oa8a3c58xGez2zgvWoVSeXOwmU2MyDE7Lzxg/Ilryu4maMmGTg4hXUn0bLQOK
	koSwZRazm/EEWw5nHZefdszgMcaz+2kGUbZg==
X-Received: by 2002:a05:600c:c3cf:10b0:493:f0f5:f2dd with SMTP id 5b1f17b1804b1-493f0f5f491mr42550385e9.21.1783692629973;
        Fri, 10 Jul 2026 07:10:29 -0700 (PDT)
Received: from [192.168.42.79] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6e8844sm156565475e9.10.2026.07.10.07.10.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 07:10:29 -0700 (PDT)
Message-ID: <5b8b72b2-f832-4fb4-8fb4-9fd16b96b902@suse.com>
Date: Fri, 10 Jul 2026 16:10:28 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] rust: module_param: support bool parameters
To: Wenzhao Liao <wenzhaoliao@ruc.edu.cn>
Cc: mcgrof@kernel.org, da.gomez@kernel.org, samitolvanen@google.com,
 ojeda@kernel.org, linux-modules@vger.kernel.org,
 rust-for-linux@vger.kernel.org, atomlin@atomlin.com, boqun@kernel.org,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
 dakr@kernel.org, linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
References: <20260411130254.3510128-1-wenzhaoliao@ruc.edu.cn>
 <20260411130254.3510128-2-wenzhaoliao@ruc.edu.cn>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260411130254.3510128-2-wenzhaoliao@ruc.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/11/26 3:02 PM, Wenzhao Liao wrote:
> Add support for parsing boolean module parameters in the Rust
> module! macro.
> 
> Currently, only integer types are supported by the `module_param!`
> macros. This patch implements the `ModuleParam` trait for `bool`
> by delegating the string parsing to the existing C implementation
> via `kstrtobool_bytes()`. It also wires up `PARAM_OPS_BOOL` so that
> the Rust parameter system correctly links to the C `param_ops_bool`
> structure.
> 
> For demonstration and verification, a boolean parameter is added
> to `samples/rust/rust_minimal.rs`.
> 
> Assisted-by: Codex:GPT-5
> Signed-off-by: Wenzhao Liao <wenzhaoliao@ruc.edu.cn>

I've queued the patch on modules-next for v7.3-rc1, with the following
minor changes:

* Added a short description of the motivation to the commit message:

  Support for boolean parameters will initially be used by the Rust
  null block driver [1].

  Link: https://lore.kernel.org/all/20260609-rnull-v6-19-rc5-send-v2-4-82c7404542e2@kernel.org/ [1]

* Rebased the patch on top of '[PATCH v2] rust: module_param: return
  value by copy from `value`' [1], which required removing the
  dereference from '*module_parameters::test_bool_parameter.value()' in
  samples/rust/rust_minimal.rs.

[1] https://lore.kernel.org/linux-modules/20260601-modules-value-ref-v2-1-12ebbf0510c9@kernel.org/

-- 
Thanks,
Petr
