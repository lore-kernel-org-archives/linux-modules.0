Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794486118;
	b=H+MgzE4OuGkQZ+KorGuKSq0vxOFIApPjBsBtca1dhjlf/ORS6khJFu+TFTrzG0YPQUPA
	 u9t5YamzGvnK5Aoy8vmkhjY2OjLu+y88chO5cTl9ggfpXJIOG3YzxhGar0cbROQqDbQwf
	 objhpb/IA3mVcUlKTP7OMXM5Y0iaue/mDs9EBOupyXuSnVujIwbqtOMLNiivuCdyCFeMe
	 zdJTN2Dyd5sF7SHdL7b2Box3vr3GskCgahE2g0iZjjJ4fdJWJYkDdZRI3/Fs8U1YTGyY1
	 P86ENFZiTCIyo+FDJelvjsAV8NqlrlXS52CgWVDOjbNl8WlgbIExVj6xhEgQoD7l5VA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794486118;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=rsZeRRNh8oLy7q5YMbD2ezj6sE80Huqu5ljd47eq5As=;
	b=RLoLXytXWziVPGDbYVIcfqWXlhTo0M8e/t7H7OYvPJbSxsaFvNsHPqofh9LgDvu+gYjg
	 eTMc41ZK5uSHWggxQ+pWcfObT6jRA9Ou0i6uvepxZOiole/qG8IYsvk9MWtzx6OQOOlEp
	 Rzklscqk+YZ/4j/sOyfSTpEffdxr/yola53VDqiFcu3wLtNAkcdUI67qx2rRn3UFjyDJG
	 99QAOsraFQFEUmKGVHzQP2XWlCDNBNeQA/6My3+YUJRRXtYljZ1XgEw/hUs5YXILGhV7P
	 BngmmV/eSOHZDrxr5sdKWPtqKyRYCWIqjXaZLBQNs6r5Y94Rx/V43fzhSjKOxX8DIVw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ePiqYl04;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC94606A327
	for <linux-modules@vger.kernel.org>; Thu, 12 Nov 2026 12:21:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FC94606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ePiqYl04
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5383c97c8cfso193981cf.1
        for <linux-modules@vger.kernel.org>; Thu, 12 Nov 2026 04:21:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794486117; cv=none;
        d=google.com; s=arc-20260327;
        b=AqKEklxEVTqydUV6ZUBdcwVes41WJ5pTQLuJCyLOGH8mJ7PvLaZDmZW8NwJTWjcG+W
         CksdRTGD7r3VpJw2dmc6uKWluTqPrFSAxqRE+mJAZ83rvgpC8UuinyHRsHhXSPZwwWRm
         I72xve3f3X/ooa6Hy1sKeqr+4p+RvKpoKi7U+jr7oXlRBew6n5OG0czZfBshX5EYWh6N
         ixU9Wq0VnJJUcRbP74FZW+k2k4iKs9maun+iZCiBKD2nj3JohSIW0St2DGzXBABCtONt
         hP8201ldFrjIUfQbrbVpeFNeiy5mDkaa9YyH0c05ObKBqHZIkSPGVUhtonopY/6jBRhe
         ceSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=rsZeRRNh8oLy7q5YMbD2ezj6sE80Huqu5ljd47eq5As=;
        fh=9GsEdCP729ruxvYk13/l1hTyUOT19z08RYNtvUwvoVA=;
        b=rADUbKxgVnlw2OT6GUWzzRok/e2f3mOLXndQ2Yu0xEwSBvouLU2iCs7L2CGGshRKkY
         RQUBJsakteb75lML52LOmiesg6ci/KLfcLBMTtmGY5pS7FZQ4jsrFkD1gfdHvj2tqlru
         c9T81wvllD+LL2uhSrEF9WR/mrr/WHDSwBGR8OkOOcgolTM6FTe8pUCG9NaQsWg7P3Qb
         mVttNbfRva7vlhnR8Vmx+V/RFaAYzr18/sAmEHzO7lrSJkkD0vJOOuwhI8D9o3IVfeSl
         se43NUeLzV2sObONLNet16BrhKYD3CaiLosYh/B+JS1tRB+TycovIPNwefoZLbd73sjl
         fSOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794486117; x=1795090917; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rsZeRRNh8oLy7q5YMbD2ezj6sE80Huqu5ljd47eq5As=;
        b=ePiqYl04MUfZ99cbOruTfFOl4lmSKQcpYZLhfEPcb5o9pPqNswmpqNrNk8V47eKTDc
         uGsxEMNyUBH3lescsaOB0/V54P56sK4Z35CaYOId1tzE4xL6j/vSu7zl2y8S4J+p4ZJT
         J5LCVHHwPM3uuP1OxXfGSBv4t4m9zblRmmQjN3m6AyEMutOkg4Z9WYRohnrFAT42o7GZ
         APp/EHwQZUkYXVl1IGcVSwrrOg3dho4idkM7uGKvxK1yzXofP8YrUkH2BwAoOVh5MuO3
         YLkErRZVtNPftfLe9d+xdnOC+7/Nkvp2XY+olCXOLsXwhN0VFpOkZSID711tSc4Qq14B
         qEMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794486117; x=1795090917;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rsZeRRNh8oLy7q5YMbD2ezj6sE80Huqu5ljd47eq5As=;
        b=nstGt8TitRN3Pw9VjouX61y/gmlQ93YjobLHKMCIyNTQfx03LDEJ7ynfL7svVAGM1e
         coZ+u1I/2JhfoDatHovDgKfUoq7TWwZx0AYqxIuIg2AufWI0MmH+DSIbOb1azW+Y4zb8
         i3LjZvEBQecqdZOjfZ31INu2rtXJ96yqGMJnT6E+b0wfIdq4mAhnjiYCqfPylW8CPYDI
         JNaw2aZbTPPyVNrE0x27nmLQJNhK4hkAtmQ6tDZrIN8zlJdaIIgudktznDXwN0VBo8m6
         WrNanlonaS0L7aBXEgSURce9ncwkuG2HGNNwh+Zagizd6Bn9tvlJN3QSRaNitFT6rsd0
         4UOQ==
X-Forwarded-Encrypted: i=1; AL+hErHEMwlOsPTU64KarirUhVxLJJil5Vlqou6Q4Q+xAEG0g5t5LvpepEptTxO9tSf4RmQeX8VPZi7Oo0PGcncM@vger.kernel.org
X-Gm-Message-State: APuU4Z/o+2VN1E0ap0Y6FzUQV3zyKMjfylDwM2SyQoU58g5jpjnbJshI
	aYY3DMPBeOfZsnfJQz4glukKu72GN1Risa1ClaAfQCJlbuMjz+aokLMC0vNwWtVi01Ur0YzpJ0N
	TXB9QbC6LCaRJOrmnxMoNN7iGDtYO51EFkPPTrqgp
X-Gm-Gg: AYBFou2N4ACaq0Z7OTaX1k7CY3naBx78HFEFzSQ36diCSzaKkMWFYt0vN32BofOdtCp
	pezaevBYRvkJ59gCzY+EzJRlJ+41iZi1/nfRVuYMvj9VJ8iYgpJuMdEFY6fPKvK7qD1MmW92SXz
	rbe5zDX4IHBs/5nk7872fT/q2Rzac4fA2IVzmxTLhCYGeVhCuy+5cVytHEJKFauq+Ji1nkbyHFv
	5XPQUWA/MP8SCGBiaEvxoxUAOPX8tySN1O//dDIhK+De0vwJityOMFoN0izAkO2anjhCf+kTp5G
	YLFh+UHkXQhyDYn7R1MAnSCq6+81GlU1t8cusQenls0u6T3FXMuRFHvTnRW4UJtcyTHKJU3CIMa
	WXyLGpOTcr1ZAIgrMpz9i5IFbx5tiM9AdJsVPZ+u+uJmxwdBzX040mER4KDL2Sj8qnWE=
X-Received: by 2002:a05:622a:c14:b0:532:8423:1e78 with SMTP id
 d75a77b69052e-55990231239mr15577971cf.10.1794486116576; Thu, 12 Nov 2026
 04:21:56 -0800 (PST)
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112121512.1670347-1-gprocida@google.com>
In-Reply-To: <20261112121512.1670347-1-gprocida@google.com>
From: Giuliano Procida <gprocida@google.com>
Date: Thu, 12 Nov 2026 12:21:17 +0000
X-Gm-Features: AclHuK-ZnF36Bp6-KcmNcD7p51zS42N80zoX_4OQmZM994MWkcuG-BVKoqDMU48
Message-ID: <CAGvU0Hm5OjUa5hoa2ibxmCznmLYO4HE+_=-u4BSu7U-VpPdyPw@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] clean up EXPORT_SYMBOL_RUST_GPL
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	linux-modules@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>
Content-Type: text/plain; charset="UTF-8"

Oops.

On Thu, 12 Nov 2026 at 12:15, Giuliano Procida <gprocida@google.com> wrote:
>
> This is a complete rework of the previous series to switch to assembly
> as suggested by Gary Guo <gary@garyguo.net> in a review comment.
>
> The first change in this series is a miniscule safety fix that will be
> obsoleted once the Nova driver Rust symbol handling is itself cleaned
> up.

Sorry, that's a lie. This is the prep work for the next two changes.

The tiny safety fix relating to `arm` is in the nova-core change itself.

> The second and third changes switch symbol export to assembly.
>
> The fourth change tweaks a related test file.
>
> Giuliano Procida (4):
>   kbuild: respect skip_gendwarfksyms in cmd_gensymtypes_S
>   rust: convert exports.c to assembly
>   gpu: nova-core: convert nova_core_exports.c to assembly
>   scripts/sbom: update rust export macro in nm parser test
>
>  drivers/gpu/Makefile                                 | 11 ++++++-----
>  .../{nova_core_exports.c => nova_core_exports.S}     |  8 +++-----
>  rust/Makefile                                        |  2 +-
>  rust/{exports.c => exports.S}                        | 12 +++++-------
>  scripts/Makefile.build                               |  4 ++--
>  scripts/sbom/tests/cmd_graph/test_savedcmd_parser.py |  2 +-
>  6 files changed, 18 insertions(+), 21 deletions(-)
>  rename drivers/gpu/nova-core/{nova_core_exports.c => nova_core_exports.S} (62%)
>  rename rust/{exports.c => exports.S} (72%)
>
> --
> 2.56.0.567.gdb80ae8cd5-goog
>
