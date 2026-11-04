Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793755131;
	b=mnhObAIgv3uRVAds+YcQB7zLTj6jNLvGOCLvnH/nJkcSOW8z54UTh0cKwxO6C0z3e9vH
	 CUjph9pSGi+gzeEX6IbIhrbv7qs7tZA7wEDseZqn7E2EP9DXLqTJkyltM4i/4sChsZmZX
	 iAs45FFsRRXyDsXM4f7zDJ0V3OGHKzp5/BBTQmNv4BF8bBh+c81Ji5EGFrv6N6C5nvzwg
	 j7kW1M2x/c8S3Z8A5Cn4UYwNvhA/XWntk/2OvrdCIAkFzsrx0skYFESn/fMCXo//ZZSbg
	 ehraI0BqMvNk1vxLKOQW1HkpBUhxuV5cLU2fKGmXwB9Eg5MH4v5m9oB3mHVjkZ6TUOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793755131;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Tofk4DAa89+ADIAKHIR2Vai/+L2kQBAdRyCdNLpk7aw=;
	b=Mzqb0vTWKEztc7WXvlsG9XLRVsqqliAU1ngneibXvwyvEjWitSO5pntc+JCP0WhaS1tw
	 jiVFat37So1ye5YVMzblNTSnRJET+CnzKiirxm7o5KNH3LXxtDOf+GhV80OzCsICwwzqU
	 CRfeH3cNWHdOeLzDOIGB2FJQ2DniSrQ5AyzJyEFiMq8oy5owFEyMJINgEE+Vxv6p5Y9Qe
	 gGRrbD51ez4C1JI28mPQvtCZaLpo3jHEuaIdqXAhxpmt5ToRb5XVOvJTypimAOCh5rwom
	 EzxC6afucWe51RPE61Lg/93gJWOin8zG56sq+eFOSwg5SC9PZ20ypQWqp/1/uUdRjyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=i3jOzUb8;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7F5606A326
	for <linux-modules@vger.kernel.org>; Wed,  4 Nov 2026 01:18:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB7F5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=i3jOzUb8
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e9f6a16afcso15885ad.1
        for <linux-modules@vger.kernel.org>; Tue, 03 Nov 2026 17:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793755130; x=1794359930; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Tofk4DAa89+ADIAKHIR2Vai/+L2kQBAdRyCdNLpk7aw=;
        b=i3jOzUb8ds4zFfDftO7lYb+6CfK6KPgDxXwk6C0I//DyWLHtEGU+9uze/n9FRRuoCa
         83KfNuIU3ifdtd33KmgRN+j0U2eeGobnP5+3bVMIu83OAvrH1gOnUJz2nt24+6XkIfAe
         dxYCxXrXI1nZFt8uvo1FEQEiZZ/LfbFOaJG4quxKoQbKp+F2u9Hsk2DdZ81hOh8He+VO
         Iv+Ts1EL7D10ncd/x3DX2B1Um94xsmsYRpAQS4XPzwH5efqXwmLlejq7fMKHKCVwGsXg
         MnLa+C5cUGvyBGXOmcn8XNlj3u1BZVVAzPYWslzXUQWKrtwkqUKikPGkvP4RgGCf23E/
         Ovbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793755130; x=1794359930;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tofk4DAa89+ADIAKHIR2Vai/+L2kQBAdRyCdNLpk7aw=;
        b=egglbXaiCytDj9LJ/8vQPeFNvn4vu0tRkFlgKb+7iXs6NiAbBWzVXJ6t6L64VnaeOQ
         zvkb0BvxPZeMWIKOv9/SGh6eyOPLyWoTE00EKNRVdnFiRlICN6Pc9dghnjJGjEchxxLb
         3u6Q/w3O13bPBaECJusOT1OzAbDl60VHeuNDe6XWoDg0/bOhapeXiTHXrEdH7GzbIJDn
         LwCLUeds29ybi2cFR1O0EJlb1odBYj0tuN0LOaDlLajTVxpva+4s6p8aFLCxK6KC/QDm
         8iK/Pzwy81Pl9NqiFi7d5ylai6vlX2+Z27JhAp6Tp+fVz3SeluFu+UiEuke1w7nGJ6e/
         8HcQ==
X-Forwarded-Encrypted: i=1; AKwUvBx/i+qC/GRE5IyOstZtF2LOismD9ZTyjLNhKz3Ho1rv0vUEPpVdheYqcHxaAVXGPmO2koLi7Obekf1/RBtI@vger.kernel.org
X-Gm-Message-State: APuU4Z9t78DkrlIG2yuQuraVUfE06J5taw9b9uEoOxWouwb+9USpH+fk
	Mhyn9GYuXPUkCxN3dSXWAulIcIsk2G8qHn0+bWTc6TPdtSCuqfW/R03gmYTj9z1u/A==
X-Gm-Gg: AYBFou3Sn6xEgxeZXw/4PBHNX9RsT3Xy+r96aw/8BG87bYyntfp3rtBZNV5r8m1nEO1
	0vNPWZ+jeLQizkvNnzTACmeVwNhvX2xmLrF4vCUjaxfBJl0xgHkSnw22eKWOyDfP3wcgWtySqhv
	pACpDmpDcK8/BdseSEOXLhroMhvVerakRzbQ+NpdL4miaqMhh5QHXAsjbuYQVsIINJeQXMPDZ2J
	BuyYqGxwny83fKH7jmqPsoEMOY1Xk1aDJZl7I+YHvEDFtOqn2bnQStPzFW2/2pqJwxjYH9ZhZUy
	O28FqVWvbW9Sqwm1tdPIzqYBF83kXNgQNFeUJT6ZVxjBdZC8q4oPF/ext+I6gUyvx/cVUJ250Zj
	isL0e71E4wsb5Ph9I046tPwc80vRm24Y4apl7RLIkZeKJtlnkILayGkllnKuAhWqt/LYyDKuJtE
	/+2zKCo7KdYTe2E92PBtceZ6k1yR8Fh8E5MmBrO43dFlG/82nSvtPSPNw4mDymZn78I2Cfa5zNZ
	49cKi16xNW0tiWCHF0ZzSqneqF+aSOhxwBZHRiphcfV9TpFqBr5gILjhRkQKefZ5JAmX8D1l5r/
	iqakq1qFyHuzPH43QShedbX26/XN4Q6z4G1KzMG11w0JmJdiRMb/MBOs77ZF2Yz5bndrZxMcfQo
	=
X-Received: by 2002:a17:903:3888:b0:2df:96ca:d7c7 with SMTP id d9443c01a7336-2ed07aee78fmr1533795ad.10.1793755129511;
        Tue, 03 Nov 2026 17:18:49 -0800 (PST)
Received: from google.com (210.109.125.34.bc.googleusercontent.com. [34.125.109.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b08759344dsm4468133a91.13.2026.11.03.17.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 17:18:48 -0800 (PST)
Date: Wed, 4 Nov 2026 01:18:43 +0000
From: Sami Tolvanen <samitolvanen@google.com>
To: Giuliano Procida <gprocida@google.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org,
	Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	linux-modules@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>
Subject: Re: [PATCH v4 0/2] clean up EXPORT_SYMBOL_RUST_GPL
Message-ID: <20261104011843.GB1247794@google.com>
References: <CAGvU0Hm04LXTywU0eL6KN4=SoOAC+LU3BKqENnLR-WV-sHsuNA@mail.gmail.com>
 <20261103165833.418845-1-gprocida@google.com>
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103165833.418845-1-gprocida@google.com>

Hi Giuliano,

On Tue, Nov 03, 2026 at 04:58:31PM +0000, Giuliano Procida wrote:
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

For the series:

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

As a side note, starting a new thread for each version would make it
easier to navigate the patches in email clients and lore:
https://docs.kernel.org/process/submitting-patches.html#explicit-in-reply-to-headers

Sami
