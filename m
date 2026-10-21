Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792592510;
	b=Irp8gUnq+YJrDIYcYGyb8x6UONzU9fj75ucqKCHCIyLg4JGx9bT1dJXWcW7uiOEztY+H
	 IIezS95cWxsg5ilgEd/VIrL4IBo3H4f07kp7DKJkJ3KBXK7txwASQzLYwpBpWu8w+xjDP
	 nX9Wk/VW4GUMdfahDAVR3fWU4LOttXUMMBkSM9qDCPuaIC6bLKQ9GN/LPeOn4mFU/2Wqp
	 ukTkO5lvlG+LmYnUE/bU9PdFU/W9OSVe+b2BysFW6oW8fvoHDb7+ZhI5ipAQTH6qV+6S/
	 e7IoUy6RzXO1qYldfL0zXQyJZM46vVJPCcaI/+AaAznTMp/mZxvOleIZf8ughMaHwZg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792592510;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=MU18pqCbstum74MRC3E2tHjDA1YVe+OVt1wpMi/79KY=;
	b=Rk20zd7In/wRmEtvb8uvzfsRCRKOO9EY6EO9mYs8UIyqJ0zND7NRBCVcEW112oJOFa0Y
	 qdhb3f5QJhmSTd1CS5/zwdVwJcSOwHVoYGRzT3G3plmfqb71HTx5cNHHs009tQA3mLUMh
	 BqjguRKVPUFFirtAazIT5qRDwzBgINIVliLjcRIhNfQ6EW38HWw9J+8tKhTjPxE6eDSGa
	 okZHSwU39PaV2hgtHKPxdC8uBRyB0M6KK+V7VoI3JJRBlO5uMHf5tw29BvyKPvbqMlFdL
	 ABE9znyJw6xCdINbTB1d39fzmRoApgwvVW11CU0BZiYnmbVu7N2t9ZqvLyeNedFnb1g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=eXMi+xDB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.181
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777F8606A319
	for <linux-modules@vger.kernel.org>; Wed, 21 Oct 2026 14:21:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 777F8606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=eXMi+xDB
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-535f598d126so273471cf.1
        for <linux-modules@vger.kernel.org>; Wed, 21 Oct 2026 07:21:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792592509; cv=none;
        d=google.com; s=arc-20260327;
        b=f2pEbfocMAx7wmM1X87lp6vboBAETH7ivpyQSjwK/NlMZ6QggEU+9gopCKszCer4gJ
         nG666lLMT0h26qM+G8yd/HlC2bRmL+hgo5RR5Vqt0uEB2MRtjXrUlYG01wGHPfJgXEBQ
         9x7w8UMrzzPTJIlpdNnwR0yreHvQxcYWpxfEl7kaZnOtf/pMN9+BERiG4hWPuiGKtFF5
         Loos1a8itWuanVsCMBWezl1NU3Ii/UoP4ca4LkdyEyNmJi01t+4uzENKUUNiihm/S2sa
         Wv1Q+oehKc5397CgDHxIhSY98KoE6yySJki2w3wHLFI0EKMIf8lMIGXnaHKIohEIVj0i
         UOyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MU18pqCbstum74MRC3E2tHjDA1YVe+OVt1wpMi/79KY=;
        fh=qsty6SQUhSDIDjptfTivPaE8bo2euXDKG1o3Dzw4IDM=;
        b=sypWcKjuZkOiMo/KvunNZDVshULTLuLfCho6TRDTlM21Qh+2v97kEQwPwq2hXymC/a
         jyN9qQslzqnVXP0Y6miwl+Hrer/uVV6j8aZ2Lt0+anXA8zFsItl1ULSzGcLVWoDGjGZ6
         F8V25nGiL/ieIugNYB7HtJEo1AboYsTdhIoAmWM+mhHXVRGUxUAi58hoXRBpNmfKaRIF
         a3v5wHH+Fgz4oSkWbTMPV6Y93L/SEH/NkfcrGz52loXEGRO9bFYS2ge4wugcMzTnlhTX
         qXnIVFhmImX5t8SnA70uqv3zBoNccnUXwQhYOeESg6FvCz00yQCejNzLSW4pBs16vo5J
         ixvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792592509; x=1793197309; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MU18pqCbstum74MRC3E2tHjDA1YVe+OVt1wpMi/79KY=;
        b=eXMi+xDBTKhMHuKRmDzePfPRvEaWkq5mjGmCWwH+v5ZX2W9l5KFUCcXFmsiXBUa7l4
         zgIeORaEeuH1kEKQS/cXAxh0yvzWXzrrF6PCSPKEoM3DM3Bq/glMf+fma9fKTxbI0IMu
         2E6bhTkl5oMUDvVzw2jsVz0FRtnwxVOBqPZcmIKMCRxhwY02IahS/YRGF4dCFO/NCgP9
         smOlLFY/AaEIJIs3wVocEDAFtdDPUZGpho6olrtNztJWHLxrwKE8KTqYlFlG4z/S/lAm
         oEW6cBb+ZolBUb9uqbxCAfcmU1m11//gMkcOkuQngLKdpsLdxa7LWH/7O+iLkjCWfYCf
         fprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792592509; x=1793197309;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MU18pqCbstum74MRC3E2tHjDA1YVe+OVt1wpMi/79KY=;
        b=1zzeUCIbdJaTxZEYS1CJLDRBshup8CoUYLg278NfILWcHcrzMBqnliG45bLOjFsPh3
         osHleQSw7L2Clh43s7POVl7HH9wRKBk51glBHJr3tnkGk3gfgF44SgzZF/tPqZgBMkT8
         IusRNAnFRgUGhmYTni6jzM7ZsWSmG1oJhxxTPc4AO+MPmBSiH9jj+hDV9dBdRq74SbNC
         Uk2My6U6hyALtG/90CHSK4nkzdwcn7iWMzoKbRlVaBV42lf/06Ih5XGF/SW9tKDICcP0
         048OPsWmDyfS1DJQQUicbKsGGNBhweInohnkQIdrU0QfAtFvul4bsyLbjLBd9AQ0TxGH
         6eAg==
X-Forwarded-Encrypted: i=1; AKwUvBxU09JWXm8nB6HxFEBhTp5XwMKLTQAMvP6HK8/fKAcZtBD/CeU/8ro+ucnKVoEAjvE9np8WR2KAdVQZdF0d@vger.kernel.org
X-Gm-Message-State: AFq9FYL5a8BEUhIS0mkjKEu42hKzwS8yMbqpdXC6f4s3SZ7ZtHVQ0Xdt
	apiSkkB8Q+5efZDSSL0Acz9bxk/ImgQsUW1bsrSJ54SbWw9+KwwtEZ1tdYDW2L3k2xhoI6EZVoT
	3lK78tmo9ybMxAX1aULeB8OhCkdZ1oRG/hPm/8FwM
X-Gm-Gg: AYBFou111QmgEqo5qECpzEV0g0UgL11zipcCIF+2SIbyetcgUgaN2ZnT0thvNV1jBkk
	4RiR3LzCEx8AH8dZ+9biD3rOD6WMbR9tIl25m0xIDgvQFYY1J1P6lTheCpzf49b7m90DCliB+JT
	FmiuXAXrUi71a9OFVJOXEOjBjBPglzubwPEI574Tfyqw9c4gDTFe/Ogwb1KzwR1YcBn4zNOsp5i
	1V8iysVF+GwEcI1sz9brWeNO0ki82bCrtOvvGBbks2kZA+TAeERZS30CQPpcFvBTLjm0b2W4CWQ
	U6jYTb1ZFOqvYsiFzCqaotGF9WeOgR41a5mz/AbubMJc40g8rSsrJUNyClQ4qN/3BbOkkvMiz59
	j55Vi+C+N498HqGoNc4OVcZcbmn3EJDRobY6TYPG46gZ0wjYhGCt6CLJFgkdXnYSVG4hS
X-Received: by 2002:a05:622a:354:b0:536:78de:775f with SMTP id
 d75a77b69052e-5368b3f333cmr33969951cf.15.1792592508742; Wed, 21 Oct 2026
 07:21:48 -0700 (PDT)
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019151243.1595858-1-gprocida@google.com> <CANiq72nqq4oGBWVtSMBhXS6G4H7fYg07ysD7SjnOWWt7R9_ajw@mail.gmail.com>
In-Reply-To: <CANiq72nqq4oGBWVtSMBhXS6G4H7fYg07ysD7SjnOWWt7R9_ajw@mail.gmail.com>
From: Giuliano Procida <gprocida@google.com>
Date: Wed, 21 Oct 2026 15:21:11 +0100
X-Gm-Features: AclHuK_l_GB8NMqOM7xhy5i6_g75rv7YJWm1OfYD9VBDfvjZnP8GuutQTREMq9c
Message-ID: <CAGvU0HnBuoVMf2JwEhRCijxRn9MPnrX=yxxbo3YywT+RqCTheg@mail.gmail.com>
Subject: Re: [PATCH] rust: exports: emit ___EXPORT_SYMBOL without C declarations
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
Content-Transfer-Encoding: quoted-printable

Hi.

On Tue, 20 Oct 2026 at 20:22, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Mon, Oct 19, 2026 at 5:13=E2=80=AFPM Giuliano Procida <gprocida@google=
.com> wrote:
> >
> > This change defines `EXPORT_SYMBOL_RUST_GPL(sym)` using
> > `___EXPORT_SYMBOL` directly:
> >
> >         asm(__stringify(___EXPORT_SYMBOL(sym, "GPL", "")))
> >
> > matching the `__ASSEMBLY__` path in `include/linux/export.h`.
>
> Hmm... It says it matches the `__ASSEMBLY__` path, but it matches the
> `#else` path, no?

The description was AI generated, but it is accurate. Both paths use the
triple-underscore three-argument macro alone.

...
#elif defined(__ASSEMBLY__)

#define __EXPORT_SYMBOL(sym, license, ns) \
        ___EXPORT_SYMBOL(sym, license, ns)

#else
...

> Cc'ing the `RUST` entry and modules too.
>
> In addition, I wonder if we should avoid hardcoding the particular
> form of that `asm(...` and instead expose it from the C header. That
> way we avoid repetition and getting it out-of-sync -- that was part of
> the original reasoning.

I wondered the same thing, but that would introduce yet another intermediat=
e
macro.

> By the way, I am right that you noticed this via GCC builds?

No, Android kernels have been built with Clang for years.

We post-process DWARF information with STG for ABI purposes and noticed
this interesting side effect there.

> (Nit: please write the commit message in the imperative form:
> https://docs.kernel.org/process/submitting-patches.html#describe-your-cha=
nges)

I will do so in the next version.

> Thanks!
>
> Cheers,
> Miguel
