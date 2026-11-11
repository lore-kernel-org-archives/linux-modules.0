Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794409311;
	b=HZ7QdFReI0y9dYCliZz2rVPqxpTNV8JEFIoT2HrvQECCHeu/ffS4PzMxdKlC56M7n3Rg
	 PZcO7VQQkngKxOW67cazlYffmYHwJccBb1b2cv2FQAax1vqdQs4MfycsKYTiryDFZrp6v
	 iuvRbr20Y8b3h3LvDW8K5yHr8CtOu7ZqVknorWrz1/t5kjNqx8mCtCWiPwKBc/PiygPXi
	 kkOjYqjFtFz9g7GO8PdRrEFAlo0sSNa2RVd5FWLuD0vRNAHym44V4c+Iy55YWOYJbCMqu
	 NxVSpv229gxSx0uidNkUvZH1gatw43PGIyvmr+RF5SvSduCgyx7r7OpRSVmssAdeV9w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794409311;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=LuH/FchAPzPfL0iN+E/sfDlagGItJpnZueLbNz7+kkE=;
	b=FQTDtQ8Cw/NI6QuanjSXso8juKAB8XjMoUFK1BMjZ+GEmEwEO0z6H9u9sA8Sz80mcSlj
	 g+bDWiYFWRUG5QEEvoYvUof6xPJP2tMwA4bqfE16fbFZPkAWurDjW3nTVqBtHfHF+gRBc
	 xxqEtUhgZBqIv/856uEQ196EqD/lSNaqC18+MQ+skpZHqysDWHN2umQZ/K6sZz5jOw7fS
	 4Ep9CjNTN7vnHHhbWUKDI8Da1jwyyfdSHIV58SjQzorzgbYefXWakXSWzZB8HD8ubZSVs
	 fdGzEVuCy54C9zAkGFySuap6hwGtyWDCIYKMHkjKEPb3F8djcE4inLBPDMYzHOYkYuA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JW2l2QPg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835FF606A32D
	for <linux-modules@vger.kernel.org>; Wed, 11 Nov 2026 15:01:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 835FF606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JW2l2QPg
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b56c90b38eso9210a12.0
        for <linux-modules@vger.kernel.org>; Wed, 11 Nov 2026 07:01:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794409310; cv=none;
        d=google.com; s=arc-20260327;
        b=UJ0s1JisH5cZrvJBv0noimEBiNf8/COYR29vnz1G5yjZzM90qZPuJYBf6PNKLa3llb
         pUDHJN2Hr9pYyVg4vs/T0aP+0WLq45wxboa0bqbr7WAQ8B5t3QkK9xKAtx9GS2AqptXY
         OEzvoQh9Obojnmu52IggEc2ZqI45W9b+iLUztbhXK/hTtMme06S1SielAB4d7AQx0ZzR
         H8XUcPfRlu99aTq+zZEhL/CFYkWm4HSqNwdoV/Q444VO4iNSG8N6MrSh/8Tmvm0nZF1p
         xHUVG6VE5MpmuLHTjpPOyBw4Y0OMq5pUB9xI4RBhDNTXHUxo+JdLdaIbhQ3tXbEpX7z+
         wT2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=LuH/FchAPzPfL0iN+E/sfDlagGItJpnZueLbNz7+kkE=;
        fh=0MfvmsEn00wO9dXZodjEkY62GRSeB4g0ib7cCVkGfJY=;
        b=lv4PBrxeg64uTbWg1hUhwW2yWC0ciulYJsF4mc99abm+4QN/FlTIZW0Tdu9EDf9j43
         FReoF7Q1hasoG1vNURRbGYf4gXYuBpjIEx/zg/G04dWDJ8GmcKAJtNUru3VVtpE8gf/v
         lFEm38b5CeeJoa9wbNyWe3Iu8OkFvnTidMWB7hdYMY7gxXTSg1riKvYMM42VKuaI6QdR
         Mer0fTLCVbuv5sjb67fPJkd20YNx2vwLpvCPv2V5wbIHJ3ZbptLxSkVpn2OPjxSSolHh
         B+IOBXr3SCkd7s75W3ObAaAP3oHOsuI2eO5tsslMNZoEJHRMADT+Z3VK9pr/0+abmou8
         6bxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794409310; x=1795014110; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LuH/FchAPzPfL0iN+E/sfDlagGItJpnZueLbNz7+kkE=;
        b=JW2l2QPgEKsDzGNiWMx+apYofish0b0DwrClK/hBnStbtouCu5GGOKazzLlkaPWKXj
         O3nF2U/06VEFSCKucvY1jlo3naqCryWRocrEGa4zY+2zgBvqiVwnCMayO0olxMMOX4Qk
         jNyHektRMTArR89PIpBI9TKiUSrP9FF6e9ZL6v5l7PzpPbpE5Skyf26pakUybsgkiPB5
         YyiN7jQEkdfAknNxADgSmbW0tx75pix7nHbM/j29CFXhA58utrzYQt9TNn2uVbJoGMVa
         3eylzRkwEQEp9P3RYCHoHpVFFk/YZdXGSNj/R+mU2QSDa3QEf2GI6WMmOC8+Y1Dqx8Jn
         +WdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794409310; x=1795014110;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LuH/FchAPzPfL0iN+E/sfDlagGItJpnZueLbNz7+kkE=;
        b=0VDFZa+1xLeyLpE2sutcuohsOZM9TDYSfF2UlT0bPnGQv2qNTfuEGA32elpiFBsxYb
         yjTBvpZFf5b9UvZDztmuyRpUR0T/10hG7eWLc/Zrhc41LDosjQ+v65SfQPli3vTxzCbA
         DVcDsszbc0sqqsWgSCRXaY9F6fpThaZhWgx8Sa9OKgr9W/ONXC1oAQxgCtw+pgjQKeCj
         XJNk6CCEKDl9AQbngcF22kcwJUUxNB1F3GKi1WBewiuGji1c4vkcS1fJlbhiRQKW4nqH
         LBG6DZ/oWw1kki+iAx1kO7WVyLheF5L0dOWQqAvBro60+ZlnrYk9EvEnJQ8GaPAtbWBp
         K/lw==
X-Forwarded-Encrypted: i=1; AL+hErHwDZDMSUN7++osNxBLGLVsVfvLSro8LdBVsJNmNFV5db4cwUQO8uf9a1k9V99r0TvIVDDGHcHX1SSB7d+N@vger.kernel.org
X-Gm-Message-State: APuU4Z99S/PPe0H1mTtHZJ6UIlK3R5M4ljOlq+sbiQTYGiJGtFLZU/OR
	7ZJyB8a/mAmB+klc3XGoqB0IATK38vifupC9OzcW8UlTSckbuENwi1B5WMrrZ4ogSrAwhEweRfz
	bBp2/YMy/c4QnwDOYb6mACO9HEgugrPsbst+QwY4g
X-Gm-Gg: AYBFou04MCQdbBPYtd4WryCAMyVyAYOy6HxfqRWcV49aCd5u7PuVosVB/T3u6sBITtG
	UtyMGtn51NT+fUVIn9wtj/GZ/pWHoZ9Elu1C19lQ+FGLgx2pdYXxCOl4AHsOl5h7ie1+Z0wsGUm
	+vaca8wxfj6RETY8wLozK+Ohu/gLiT5dehCd4/CeN6+HhyMKEuroaj7XM4QIhxE1pyhIqn6M9t9
	Rh00Z6YCI38orCyclWZIjE/6KDlewWIZjYiym1NeQbZJseIQhuj8czKEcEeB1494RrEAscbjIY8
	zNtPVPu8oNBZxAvx0+zNiNVi2mci4YwIITG8TZz828lk20mhmcM91Ec8dvck2a8vqOgD+uW5IvD
	OTTa0vz5ACn+Q5ZN37pne3iTDNvJYDR6Bxe6P4w==
X-Received: by 2002:a05:6402:46d6:b0:6b5:70a4:c77c with SMTP id
 4fb4d7f45d1cf-6b77da26eb9mr68980a12.11.1794409309341; Wed, 11 Nov 2026
 07:01:49 -0800 (PST)
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAGvU0Hm04LXTywU0eL6KN4=SoOAC+LU3BKqENnLR-WV-sHsuNA@mail.gmail.com>
 <20261103165833.418845-1-gprocida@google.com> <DMQS0SH6975Y.23Z4V64W0HWN5@garyguo.net>
In-Reply-To: <DMQS0SH6975Y.23Z4V64W0HWN5@garyguo.net>
From: Giuliano Procida <gprocida@google.com>
Date: Wed, 11 Nov 2026 15:01:07 +0000
X-Gm-Features: AclHuK_zSrM-gyIFWZ7VxtFpClMKugomAWhetmW2iYZri8o7Wvx2yOx0wVwL_M4
Message-ID: <CAGvU0Hn00iMkAEMLBZmaJ+ub+Q2aJTtvJXgdqWfbjDyFUus2mQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] clean up EXPORT_SYMBOL_RUST_GPL
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Boqun Feng <boqun@kernel.org>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	linux-modules@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Nov 2026 at 15:14, Gary Guo <gary@garyguo.net> wrote:
>
> On Tue Nov 3, 2026 at 4:58 PM GMT, Giuliano Procida wrote:
> > Move EXPORT_SYMBOL_RUST_GPL definitions into linux/export.h and
> > prevent the emission of bogus type information for Rust symbols.
> >
> > Addressing review comments, the first commit now ensures the moves do
> > not trigger warnings from scripts/misc-check about missing symbol
> > exports by extending regexes to match EXPORT_SYMBOL_RUST_GPL as well.
> >
> > Giuliano Procida (2):
> >   rust: move EXPORT_SYMBOL_RUST_GPL to include/linux/export.h
> >   rust: exports: emit ___EXPORT_SYMBOL without C declarations
> >
> >  drivers/gpu/Makefile                      |  4 ++--
> >  drivers/gpu/nova-core/nova_core_exports.c |  5 ++---
> >  include/linux/export.h                    | 14 ++++++++++++++
> >  rust/exports.c                            | 12 +-----------
> >  scripts/misc-check                        |  4 ++--
> >  5 files changed, 21 insertions(+), 18 deletions(-)
>
> How about just getting rid of EXPORT_SYMBOL_RUST_GPL completely? The only reason
> that it exists is because EXPORT_SYMBOL_GPL in C expects the symbol to exist.

At some point there may a desire to limit which Rust symbols get exported
on a granular level like for C. But that's out of scope here.

> We can simply change change rust/exports.c to rust/exports.S and get rid of
> EXPORT_SYMBOL_RUST_GPL completely (plus saving a C compiler invoocation):
>
> Something like this:
>
> diff --git a/rust/Makefile b/rust/Makefile
> index 0165626decbe..75de47028b60 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -571,7 +571,7 @@ rust_exports = $(NM) -p --defined-only $(1) | awk '$$2~/(T|R|D|B)/ && $$3!~/__(p
>
>  quiet_cmd_exports = EXPORTS $@
>        cmd_exports = \
> -       $(call rust_exports,$<,"EXPORT_SYMBOL_RUST_GPL(%s);\n") > $@
> +       $(call rust_exports,$<,"EXPORT_SYMBOL_GPL(%s);\n") > $@
>
>  $(obj)/exports_core_generated.h: $(obj)/core.o FORCE
>         $(call if_changed,exports)
> diff --git a/rust/exports.c b/rust/exports.S
> similarity index 86%
> rename from rust/exports.c
> rename to rust/exports.S
> index 1b52460b0f4e..efe6bff0f983 100644
> --- a/rust/exports.c
> +++ b/rust/exports.S
> @@ -13,8 +13,6 @@
>
>  #include <linux/export.h>
>
> -#define EXPORT_SYMBOL_RUST_GPL(sym) extern int sym; EXPORT_SYMBOL_GPL(sym)
> -
>  #include "exports_core_generated.h"
>  #include "exports_bindings_generated.h"
>  #include "exports_kernel_generated.h"
> @@ -25,5 +23,5 @@
>
>  // For modules using `rust/build_error.rs`.
>  #ifdef CONFIG_RUST_BUILD_ASSERT_ALLOW
> -EXPORT_SYMBOL_RUST_GPL(rust_build_error);
> +EXPORT_SYMBOL_GPL(rust_build_error);
>  #endif
>

This doesn't cover drivers/gpu/nova-core/nova_core_exports.c though.
