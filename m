Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC94225760
	for <linux-modules@vger.kernel.org>; Sat, 28 Feb 2026 01:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772242372; cv=pass; b=g855u5e6NiMs9sk0v8qryNeVJap4Fy2ekahadXyJizrwTLzTtXYjfxwD443TSiJsi3MECJK3ycmNKzUda2cLIK/twAicTZYJCb7rxT13jRBQYmeVaiGPVGGGGjYzAsRc2hYiipDduF/LsgHLEEqUp5whP7kLRQTRWzM8z61UDhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772242372; c=relaxed/simple;
	bh=CONkaPmD6N1p8Wl41bWFdbK04Exw+AofJGxiyObuVR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=atRDfM1cikIrjy0Mj02ToXO3eEeA2vBfMyw3URByCt5E+FBw+GEttj4P18JiRGrtF4Fm2gRqes9XaIbhUlj7lHB2xg46qKMamWvvcoloXzm+SHgLGVz/u+65oqXS+w3xD0gFfDlHT5OGqTMJQQRsIBI9adV4prniwJWXRzn5hOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NpUE24zM; arc=pass smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpUE24zM"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2bde85a9cd7so77900eec.0
        for <linux-modules@vger.kernel.org>; Fri, 27 Feb 2026 17:32:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772242370; cv=none;
        d=google.com; s=arc-20240605;
        b=MD8toKWzjAb5StV+Wie2RaLJl3n+3FmPksec+hN0U0vPVKVAMkk7q1JRe+3qQtLmv2
         qw8XuMpPAm/Aon1VIhMo4SE3aAZ9iUL9cM/27/Lp12twgQKEV9/kgNpLTKg1xkVwwTTN
         +nuIcPOzzkVDBssE7nPA8Nez1fR3PRinv1dk22yhg+JRWLLPaMFJZExBHERk0PKblb0F
         IFoGATzx/ZsTAAKus9eldcWLrs4di6IFqdSSuD00x1pciYtmQ/HWr9+neN70k4q97A61
         5owhQGptChlr1zYfDYW4InLQswxanrRIC3ZL4SHg6/dGIitKyzMJgfWw6N0nHMLtq7ju
         i1LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3nsfOyCnlIaYDY7uNCziE96qb4GjGHs75Vm15QwleTo=;
        fh=JOsGAScVdx/Aq931Awe3Cjb7uCI5Rg56nnWIJThJy9A=;
        b=GMnzH2oUtVkFhtJnqRIY9CTWzOnrTTmiD45AjJPIcGp87CQvUM0zxYlj1s9TPzvgym
         /thRE0UiBHtVM9//OJfc4g/NaHrUTOUQhlHTQmSAFJI4QsNju60UCUxYjFV+HfYAFpwR
         GESUjJb+MSka2KOADVpa/Dvl7pRcDhYX4qhMQYQdaoll9SSv5CSyqZynQuNq7//ME3c4
         9h6ivoMP23ODEIq6yQ6DovpAT+NmdL06YssEAaivKr2QID1MIF5GrfqAm9P2Xds9nurh
         kmmJ0y3yZQpCO1qzLqFmHKL9NFBpycvJHL0S63527EIo1PMknaEWsOAz9ueE/vPGBH+i
         uPhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772242370; x=1772847170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3nsfOyCnlIaYDY7uNCziE96qb4GjGHs75Vm15QwleTo=;
        b=NpUE24zMqPh/loW8KERTuXfmsZAGUxZbvyw9j2dS+DkjDnT1I5i34ThZLRCXYWAY4v
         fAiR3S3Uqr24K31a8JT4uIrgKDSokVGbo33KxL8pzx7E3QZJzWCvQrzpEYl9BnTJ2CZl
         lkDdryC+Azyp/OZcStiRKoA64n+Ki8XgEjRkbD9wSUOVAJF7uPT8YxSmAbj3ryj5iek+
         BvaCPwmvO6L25JXByxE/eHs73MvwG42ctGBpqPz8cSP42YFDMQU3/haJYlCsUICOlR/m
         JoMcxVMAMGWprycSjPMa/biQLg8QycQ8JwkWfg1ydpXbvK/3GFsS++eSQtCaTywsgYG3
         O28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772242370; x=1772847170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3nsfOyCnlIaYDY7uNCziE96qb4GjGHs75Vm15QwleTo=;
        b=aCwbMaSogZYlkYR/COWRlytEgFwxY5lWnzSuZQaaBKmQc4GCGUqrqx1ypvqhfmEsv5
         76ILkIBta2tbl25PcWI3RIZKo2YmyXt7Bmvci9juOl1zyoiZBGgVvJBMIKa/lat0qFR4
         7kl0Hse/pICH5EL+pP5eg/k+jy/FjJn2uxr0IUOoOfdnfCmPvqSR0eQypJGQo8tqKnb0
         tQQCw8eH42f8FVAd/x8tFfNLnF2lDx8cSGh6QzWinN+C8zWTxIoWKcTuuJnXgSOE6gO7
         XnuVV8L9/pEonnZuUVL57cedCa/VwOpLnkBmgknHOvyclkGQpEnMptmSijy31ILnF/5l
         CVIA==
X-Forwarded-Encrypted: i=1; AJvYcCWY5Ga86n3CbuMdG5FzKBm2yscOV3EduWMhme46wDWuQ5RpsKYOdws7JKw5ehLj+rhyswp6WTDPIwVVnJvP@vger.kernel.org
X-Gm-Message-State: AOJu0YxN8PGLvtBxDPoeKN7+vMtK9WUpb/dRWPGouE9neTMoCkEf9K8i
	GwxvmDbaDv/VETbjQndCPVFnH1FfCHpI2Ihzb4TYDwJMcwhD3S4vcnV6olFo1KurEhdD9CtHMCg
	M6mhjepY197X60YS04a19KHZeZa3sxwo=
X-Gm-Gg: ATEYQzyON5CR0Itd0K45vbcoM835cQo7Cq19Syh0+7Ayg2gQC4iG4iOJcqpHEFQ5pJt
	eEt2OBIiZ3FAfWGTAeU2ORUcx1uedyvDUo1pESdMBdCjwOPrg76tG+5yGcxJbpq0OG9PTOYeora
	QlxOzddtWn6wAye2bUI9CpUYH8nGCGmJw/+3KaNsgUwUvtYCQ8KPbNtsLsN+aqEx7Twgtktj967
	yPQzqQalZXEhlkNzmnJMYYmGmF7ooeo5SQ9I4A4BkomB4xiHBz2DAj1M6xECIec+DjALHu740MY
	MeDzOPuq+V8fuwyXDiz9O4lOBQhUFuk+dOnVTERN+f+SwoTvMo3G2CLL8fHfS/+DQwk/SUk1uYA
	AK1wGsr8x0IQw/3AMa97hKGNwci+e
X-Received: by 2002:a05:7300:dc8c:b0:2b7:f145:a98 with SMTP id
 5a478bee46e88-2bde1b2878bmr1121074eec.2.1772242370097; Fri, 27 Feb 2026
 17:32:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226234736.428341-1-thepacketgeek@gmail.com> <20260226234736.428341-2-thepacketgeek@gmail.com>
In-Reply-To: <20260226234736.428341-2-thepacketgeek@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 28 Feb 2026 02:32:36 +0100
X-Gm-Features: AaiRm52ur8aq7KahUBluBVKKHjAKX3SUBCaPurx6nv1CE1SejfeUH-yosDfCUvA
Message-ID: <CANiq72=d3DmqUwe+b-btk75N9r8XMxSeqaQniShfbQQKBeFRZw@mail.gmail.com>
Subject: Re: [PATCH 1/8] rust: module_param: add StringParam type for C string parameters
To: Matthew Wood <thepacketgeek@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Tamir Duberstein <tamird@kernel.org>, David Gow <davidgow@google.com>, 
	=?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>, 
	linux-modules@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 12:47=E2=80=AFAM Matthew Wood <thepacketgeek@gmail.=
com> wrote:
>
> +/// This type is `Copy` by storing only a raw pointer. The underlying st=
ring

Please use intra-doc links where possible/reasonable.

> +/// # Safety
> +///
> +/// The pointer is only valid while the module is loaded. The kernel ens=
ures
> +/// the string memory remains valid for the module's lifetime.
> +#[derive(Copy, Clone)]
> +#[repr(transparent)]
> +pub struct StringParam {

A `# Safety` section for a type? What do you mean here?

I think you may want to establish an invariant instead.

> +            // SAFETY: pointer validity is checked above
> +            Some(unsafe { CStr::from_char_ptr(self.ptr) })

I assume you mean that the non-null implies the validity, but validity
is not really "checked" above. That is why you probably want to have a
proper invariant in the type, so that you can invoke it here etc.

> +unsafe impl Sync for StringParam {}

This is missing a `// SAFETY:` comment -- please double-check
`CLIPPY=3D1` passes clean.

Cheers,
Miguel
