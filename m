Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794233123;
	b=PSH7inVNSBomOcLM4QjtS/gFZs4fksbH7aWFNbDLCSmbw3I9beKuMrv6I27D1MXEvPLR
	 +swZTrsJamP8YMF7tHAiVWoqUu9a6i+2saDSiqULO1+mjpHsDPZmIPXhGZk0UF211Ptof
	 A23ZqNoUFHJEZyUb1NLhoKfvtjAb/kb15QH2C6wqXPEf/1UJ7vfL5COkB0yTcMw7xx4sr
	 KLfB5LuX2Ddi9QxnbREQEYUN20RA5Xe5QPsdHvenq5XTHkDaQghRyZvD+TgyYZkSY8RPa
	 h9YRUh9dCJb8/srXvGWyGocUYlAMMbrfRWTwTvPLhRre0m8H8bmvSUjVkANNSlIMPog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794233123;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=jo7KQrestHbM3KQGgB2ZehvfnJkiM0RdX1i9KTgsql0=;
	b=mR02IhehUPadQe/zqikaDXCNqgdiXgYV95lZeel2Gln7AM938Wl943eeQxwc/0Hlwqq2
	 FiGOomminhWPAYkC1EFEv2Li1MZl2ln24nvYJpk121ITS2Vv9JMp+Eyzh5HFJTeTe0EoQ
	 G3dgPQmr3rJ8H0RNpWcNrKUO2ys3aP+3LUdoXM8TzMbs8XgILAZvUVzYV3i7oWPgXjBUD
	 LGSMFEjn7il6UhiPkXeFnWjP9rav6Qo///cAqbI6keOPkqxyjzfpW3AmbQ0GjqFm7iokq
	 PulzOca61Bfjrj3ln1Fv1zDsJfeRXUDK5RyEaS7g1QIvr/dAnChnthIIGrBsbwQkZyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=DUyuGSmU;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3561606A321
	for <linux-modules@vger.kernel.org>; Mon,  9 Nov 2026 14:05:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3561606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=DUyuGSmU
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a20bde60a0so9970775e9.3
        for <linux-modules@vger.kernel.org>; Mon, 09 Nov 2026 06:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1794233121; x=1794837921; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jo7KQrestHbM3KQGgB2ZehvfnJkiM0RdX1i9KTgsql0=;
        b=DUyuGSmUH5eDAXYPE494OxeHh+ehy1VF9d4zwanBWXOJRBHq0Ow7LBVP27VmCh3mSk
         TcSNoZCRGZqD1R5/q04bOSMyUVY+QmxyBoKRfnCVgeyV+Mds7bVkQlWic/V4J8MXFAgA
         bfUDaw5oAKCnEZxzmpaRDoYgBy0fABh9koMRwBo4JcooByf/NMHXhBK3Y6iNDcNGh5lE
         u7UV05xyMGeFVrcybw1AfJMtoyF0b1OA7YxIeCHVbxZNpKLi2QpmVNr0qG7Qkje2Oth0
         NgPXM27eqDCZbuOyIfUWruQL3PvktXLyMiRfPv0QvfsPvk1swAJA6wAn1Qdu+TvXC09/
         cifA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794233121; x=1794837921;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jo7KQrestHbM3KQGgB2ZehvfnJkiM0RdX1i9KTgsql0=;
        b=KKyEoAP1jQBEljeKjDUhLQYBQgaH6lOtD3fqJgTYE6Qxa52rkhvaiylSod6O6MjqPe
         0GQ6NA4yaFJ+IWXkfleGE6svMGmSJ9n5pKSTSVQBqV/XFSiG/p8dwBQ7OQmU06YlYQXP
         UXEQpaSvbvmLkIF3mjtYdaoYx9ZcV9ge314FN5q1/XRDjbyBspAfN9MnuO5tEHIbZF+e
         yghrPdvcvqYarHZ1P29Obm77njrhGSu71Kt2ejDJlBHHgVXJ29Fl4U3FAqrXLDg0edJm
         ZJFTos/MvFlo2ISjmGodvh4gCLPlCXGTvw2ovH6TAKK4dJdLHtFlj1hNzf9u4Cmju6k2
         eGyA==
X-Forwarded-Encrypted: i=1; AL+hErEC6Fy+Q4KYvMzMjiAZj5+0zcwZgJuyFH8PKVnSNqImkW/5jOeYr3pe+XX8SGrqt6dAtsF1tczgqYOyB95s@vger.kernel.org
X-Gm-Message-State: APuU4Z869ra/9CYGaOQvaO4tHSBe+Ewi8PcaEN0h+EHfzNtZIGFUadbd
	hXrE88aD67JnK0QVVxPCtL+Cd6/bFE2xsm3jk3bG+TxfnpFHHFDfhPBdTUjC8xLxQa4=
X-Gm-Gg: AYBFou18k1zNJRBehpDTL+S2FTFMG8cP4nPHkWe9J9A6QGo0RCm/e+XARuX0/1KNnzs
	MgJ+A1SsYK9gkj3wtpVwN6fcylXJ9v+Qt8KjOBJaGijQ9RgSih772htUaMdTthkCZ+7Jz4tZwVc
	Tmqs7xNM0RX5ch0PfhFUKwQJFf3UOUDDys9W010MFJXmOX8AOWShsTylXEWsaPrPioHlFDM4Lo+
	phtGLxuZqqDWBzMVbugGlqEN4BmiJBtgAqlJbjJM4PPP3E7u3m7OSmZlavlU4omLww34VEZbYKC
	ymrtfYooTnA2vm+8s6PAORz6b/h5n/vvBKhmL2CVAbbJ37BXAPr3ugziMNgF4SgBwKhSiAzHfhH
	QsSoS6aCHNdCCxXs6KHx/lvIZxFvTHgad3gLQKLI59Gk1QMXRQbwxicsfUYr5YNW/LGMaOOsQmd
	v789xH8Fjlp57oobJnXu/oZGLQzj0GJJ5zgmHeVqs7NNeWpljfgF5n+fdJQTg512OtaOQuH3IGv
	TkooTyCvcqI4bLFNDLxVyh8X6NGpyTP8jbd+XsXKSLZhbvzY2rwGrRX55zk+qiPQDgdNEkOgQiz
	pNhZjFa5L/LBMPKVGGirCnlquZzIV0YXPRdKrJDU4pTmdW6UOKH5jbJADx72EkwO
X-Received: by 2002:a05:600c:19c9:b0:49e:7c8c:361d with SMTP id 5b1f17b1804b1-4b963c855cfmr76926345e9.22.1794233120810;
        Mon, 09 Nov 2026 06:05:20 -0800 (PST)
Received: from ?IPV6:2a07:de40:8100:0:89a9:fd0e:583d:4a53? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b90f11172esm140959535e9.12.2026.11.09.06.05.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 06:05:19 -0800 (PST)
Message-ID: <b8134de7-be7f-4bb5-96a7-c36b5d744852@suse.com>
Date: Mon, 9 Nov 2026 15:05:16 +0100
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] clean up EXPORT_SYMBOL_RUST_GPL
To: Giuliano Procida <gprocida@google.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org,
 Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot
 <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 linux-modules@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>
References: <CAGvU0Hm04LXTywU0eL6KN4=SoOAC+LU3BKqENnLR-WV-sHsuNA@mail.gmail.com>
 <20261103165833.418845-1-gprocida@google.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20261103165833.418845-1-gprocida@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/3/26 5:58 PM, Giuliano Procida wrote:
> Move EXPORT_SYMBOL_RUST_GPL definitions into linux/export.h and
> prevent the emission of bogus type information for Rust symbols.
> 
> Addressing review comments, the first commit now ensures the moves do
> not trigger warnings from scripts/misc-check about missing symbol
> exports by extending regexes to match EXPORT_SYMBOL_RUST_GPL as well.
> 
> Giuliano Procida (2):
>   rust: move EXPORT_SYMBOL_RUST_GPL to include/linux/export.h
>   rust: exports: emit ___EXPORT_SYMBOL without C declarations
> 
>  drivers/gpu/Makefile                      |  4 ++--
>  drivers/gpu/nova-core/nova_core_exports.c |  5 ++---
>  include/linux/export.h                    | 14 ++++++++++++++
>  rust/exports.c                            | 12 +-----------
>  scripts/misc-check                        |  4 ++--
>  5 files changed, 21 insertions(+), 18 deletions(-)
Looks ok to me.

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr
