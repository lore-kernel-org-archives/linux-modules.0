Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF84D214A8B
	for <linux-modules@vger.kernel.org>; Wed, 14 Jan 2026 14:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768400795; cv=none; b=UoG6nd8A+h+ECUKYYBTIsmfar9BME693+dJyfWjLoj3yy79Ecd+h2wlD84wsthaDdx6hKKO2f7nF7uq7osriEUwEsHc424nUrsvJK4dNCV/hbNDpxx9P55o5zpeUbgYJS5PuqJJmaJNQZvxT9yevmZZyeNbBROf8oe4cWMwgO9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768400795; c=relaxed/simple;
	bh=XFBlPJKIbDQKyHpiOrhsJf3rxfDuDaoLs2vYJ1ERVw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ya12ODfkch4pfKcFo1k7C7IyHQk91xKJoqU+2IyM8RuG41JNGuN9FXoXWtQEqIYG14chQkTFbPGjnHBgXerpkOrwJ1Ce0GUJA7pyxMC/ecxub6S8S5XDSUD+L4pwJNhsgTr5BwMeG30rSO7trS9Z5Z+UOMtYBDk19jk3SLgMBBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=afbxg1dm; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="afbxg1dm"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47ee301a06aso8937105e9.0
        for <linux-modules@vger.kernel.org>; Wed, 14 Jan 2026 06:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768400792; x=1769005592; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WFkWLAgT08Oj55bURIFv2XEwqSDQ0hHOA4DCqjRSAOw=;
        b=afbxg1dmJvKH2Vuw/yxkEv6TWkGnGqkBWLLmZk4BTBEA2ll9SpG8tHMQjFgSFTvU0V
         2TBBsygkdCjinQEJC3zo4M8jc6We+jr8/m14c9KGowq0nFY83Uf00cpZ+oSe+7D3ikkE
         y929RsmvjbEX0439NuB7fk5bjBoCCFqZhf0nyJFuzQ7jO24EGmRT5VQqADijQIxQBi9J
         KqLBUxxmy8skXPTfn9BUanZq2E2/6g9PTYwcWFb/QdXsGd58SBaO8Xsdtc9DwGbShP7y
         uLL43ToK2uO2IHUT1oqBTNmaz4aieRRRintrfD8/FnnZau9K8nV+HDc3N8vwsK5Hzi+5
         qyCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768400792; x=1769005592;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WFkWLAgT08Oj55bURIFv2XEwqSDQ0hHOA4DCqjRSAOw=;
        b=NULssecRXiXmmltAkTWjppoWj4sk3yalzU4LR8Q6xmLGWQBkTdVOjcr+H1XosFAEs7
         lCFQKPu5tqA22Ck90LwJrX+0uxBD+rjQU9wJFtanctayy3NvnmVbh73fYQ16+457BPxe
         HBcGc5iP2EbsZ+AQYF7/1No8zs6Ex46tfjk5qWl+Zy+sP5QZhc9bK06yEZ/M2xAFTVb7
         JcP/71nDpHsWGNeJpkw7dvialeOjQKK2ufdufQ31mt2n80iW9QX/pOIOOTivyi3ysrA/
         l/KplkuWt2Cdoz/bI9ceVw3hRZoePC2Mlu9A+mBeaHMDH3FJETiBbDPVjruOEN15IxM4
         opsw==
X-Forwarded-Encrypted: i=1; AJvYcCUov7kFLaSrELntE3JR/n54+d2LMBVYce7EfURVIapI1lYLXnQbkMF3t5G/o943QSfmUZq0dI9YQV8BTe2y@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/Nq5rm6TthhVLZV6V5TFXrT4FH6lWLNQankop4n8pKYpPrRwv
	WetmYhuVnRNUjgCFhHOG0YTUFnuxxFLetU+dVOqgjs7mYRbr6zvS/aOONSjNA7lcLbM=
X-Gm-Gg: AY/fxX6SzKzwgqwKMT0TvKXjfDpPQ9KyCGl/8a/Fo75WLDA0uIekCMfaNnlH8ftNz+1
	h56w7Rjt1WRRkkCIqn6H/AUmDN5iZyF8s7I4SXgMLQQC87DZaGad8PZBAeFNCvbsIlSUhvpNGl+
	cMHV5Zt5xZl/fCR0OraVQ6tK1E2NYopOQlD1pNr3B3K1YQTAculR9DpbHOzELvkLk7n/4MrE5oF
	k3yle/JA3N69ylAt7TaoVoNo1ejnspdlcecdRwsdUyHVLMCQqaqn+cuSDvazakQcQa6Hzi3J8OV
	+EWIaG2ugwtgXnN6rgj3gd6Nhh2wMQUY/7emU2dkpnByzxT+DeDvxjUif30ZtloT/y9MLxmUgI2
	tVlq8a3G8bMybulog7fj+t07enNLpeHXwe9k8msrA5sY1Uj7anzkJ7foUMRP+vT+pakTbxQ58+1
	mtj00y8pcb+D1/MJFTr3XCi9y2FdHzGg==
X-Received: by 2002:a05:600d:a:b0:47e:e5c5:f3a3 with SMTP id 5b1f17b1804b1-47ee5c5f57fmr18904075e9.24.1768400792369;
        Wed, 14 Jan 2026 06:26:32 -0800 (PST)
Received: from [10.0.1.22] (109-81-1-107.rct.o2.cz. [109.81.1.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee0baf482sm22736995e9.2.2026.01.14.06.26.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jan 2026 06:26:31 -0800 (PST)
Message-ID: <29c6fb60-0b5e-4822-bd49-80ce3d9eb6d9@suse.com>
Date: Wed, 14 Jan 2026 15:26:30 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 02/15] rust: add new ThisModule trait and
 THIS_MODULE impl
To: Kari Argillander <kari.argillander@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>
References: <20260110-this_module_fix-v3-0-97a3d9c14e8b@gmail.com>
 <20260110-this_module_fix-v3-2-97a3d9c14e8b@gmail.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260110-this_module_fix-v3-2-97a3d9c14e8b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/10/26 4:08 PM, Kari Argillander wrote:
> To make clear separation between module crates and kernel crate we
> introduce ThisModule trait which is meant to be used by kernel space.
> THIS_MODULE is meant to be used by modules. So kernel create will be
> unable to even accidentally use THIS_MODULE.
> 
> As ThisModule is trait we can pass that around in const context. This is
> needed so that we can read ownership information in const context when
> we create example file_operations structs for modules.
> 
> New ThisModule will also eventually replace kernel::ModuleMetadata trait
> and for this reason it also have NAME field.
> 
> To make transition smooth use mod this_module so we can have two
> ThisModule same time. Also some functionality is added to THIS_MODULE
> temporarily so that we do not have to change everything at once.
> 
> Also docs examples will need THIS_MODULE so also define that in docs.
> 
> Signed-off-by: Kari Argillander <kari.argillander@gmail.com>

Is this pattern common in other Rust code in the kernel? The situation
on the C side is that THIS_MODULE is a variable of the module struct. On
the Rust side, it is currently quite similar, with THIS_MODULE being a
variable of the ThisModule struct/wrapper. The patch shifts this and
makes THIS_MODULE a type that implements the ThisModule trait.

Naively, it seems somewhat confusing to me, coming mostly from the C
side and expecting THIS_MODULE to be a variable.

I'd like to understand this better. Would enabling const_refs_to_static
alone be sufficient, or is it necessary to make THIS_MODULE a type for
this to work? Should we be concerned that this new model could confuse
people, or do you think it actually simplifies things? Does making the
functions generic on ThisModule impact code size in any significant way,
or could it in the future?

-- 
Thanks,
Petr
