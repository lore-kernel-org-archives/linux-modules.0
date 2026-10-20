Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792524142;
	b=MxSyFdwhxtnZTT08qmXwg6Ptx4OxpF0RL77cb3p7z1jBsqoioCRA01jvT3N8H1tjkNmV
	 t4xDbn40hwFrVCB5QVDoDQp36k2fzsY0/Lh1oMwzkXTPIlVmdAZLS+NPQkQa3ywwCR5tQ
	 mY3Pj43TQuiZZLKGqjsgvWzlwHpR3KfAzsX51VSPmKdUcHX93O9LyEb5+iRZIP1P44QT3
	 PsbERAf8u0q8H6DFvu7oAPwRcCM+aPIkwPu0RC2kIYWAjAYcGzCBiiROIYSKo05SoMGa/
	 xOsWSO5OyqC3n2x7flxWurMZruaAUBoZg3ILvOjKmob8YyO6YByFjGpOTBYIzWlpjyg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792524142;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=y6pW1Np65YgMNQpZAz08cJlPZzgj3oRGZ7hLNsVmwfA=;
	b=2KOZ2sxG2ZpC4C91PYlHd/qURZCVGS5y/wrCT0BFxzT70JSsY96XWZLIDiQpsx4mvxcE
	 janMmeta8UNl5fYLsYxIBGKjyXcQ/KbiqPSBRq0VnY0GsNlTCHDUeLSipJLJRDsewtctZ
	 JnrjB3gBYbKBQgdPwfg7wVin6k+LzBiHTJrXnrLupJFRxxufaRiOXfoj5FJle/th/ANyt
	 iu5oOO+NUtbe+zBowU4N2sCYfCWn3eLpUcwNjD5jWjoihjyif40e1EgDH84hQmrb4CZEc
	 pFCuED3xIKKeImU9yyqy4I3utJOrHX0jnI16OMYvWPpxXY7QF5UdsB9YaDfvAz6SaPg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FdVLlQeb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C8F606A31B
	for <linux-modules@vger.kernel.org>; Tue, 20 Oct 2026 19:22:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43C8F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FdVLlQeb
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3550dd02c9cso299492eec.0
        for <linux-modules@vger.kernel.org>; Tue, 20 Oct 2026 12:22:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792524141; cv=none;
        d=google.com; s=arc-20260327;
        b=c000/6HP4vuyz9zx7KzuSUWfqMBRuSMAwO1UvZh8F6QEmcElxv6xdp4uXczKLk2Hoc
         FSEpAfC9wB5tYzYTv9eEr0sNc0GcGCZ4g849OPBCyeQzc+WzrROWSuCMner18AroKOOW
         65ReKmIqzvRmIWLqL2li7J28aGKM4dIv6uonneXOqZWz1u2sShGcZP0WUJhclVhb3ceT
         R5zBexknNlkDzXRd5LUhTm1T6/2sfMI1VO/hMGYAFBa1cWqfiYPBkjBNiGTYSe+t9muo
         x8B9lETCZ/OmxfatREK69wfghy7bPO3j+No5hcdyUnxXY3CrKIM2SlPWuNUkaM9ZmpkZ
         1oVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y6pW1Np65YgMNQpZAz08cJlPZzgj3oRGZ7hLNsVmwfA=;
        fh=IrOUSVcrshzmEeeN+tk5tDYkD1ir3o5z38jZw1KyXqE=;
        b=osC68aOWMxHc5ERtQ2pOLZkh8d0K744jN2kc+42KKNKJoDwQwXren27pz3SGBEElP0
         iMvZqyY5NA3Tt9zQNWolL/uNVclDWj1BdFeckytGfyDRr7jVlpqmnQYEuVW/Sb/FPRwP
         3sXhOI4AqTPosGZ9tyz+MuDm1M7E84BKXIeWNVqyMHrdx4TFy5VdXfL7Gwzc7xm8mbxt
         0jzy07ZrVH+8iZuueYk7O8xdjEu1+8nopQ3m0oGPXX+vnaqgsxSay+4xODn1ERmFeelM
         f/J96hb31SqnYodLU1kGoFmsqBzSqjCgqhs2HG3iICU6E7lhY7Q9D/7mLyvZawxkKpT8
         nzrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792524141; x=1793128941; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y6pW1Np65YgMNQpZAz08cJlPZzgj3oRGZ7hLNsVmwfA=;
        b=FdVLlQebghmNvLxXgbuZKTIAmJvt9BwS3tERVySriRZ70dWkKvjz/xqm3oLrZ1R4Tg
         O8rrr/uv1nqGHzILbHpKq8LWOBEV5kf3uCo5qJe7X28cVK3HWgvSw9V/OB2OtvLkJfG6
         9tl4gHOQpGsRVZ6oSqH45edWhT25Mc59DqkqlieRw+lIJHE34/EkHbsdbeH4wBveiAXe
         e4+UrZnlijmA4q52HAMGYu76l8gIxFJtavs1Dx0nf8u4Hq+8B5e7ZE0RZPRLyxRcc/cp
         +Ac+3amZz/6YgnP9jCkx17SXnHq3AQaUCQF+BQHYpVbdzhqNbC0sffBk7J0H4zuW9+0a
         ZICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792524141; x=1793128941;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y6pW1Np65YgMNQpZAz08cJlPZzgj3oRGZ7hLNsVmwfA=;
        b=ba4eCOUaWIMg/2y6IUxiP0uRoceM8EuaxonUTg5aiTCQ2dj6XxK5BJw2pb8qU1ntJd
         CviXxU3/EhvnJtmY8uVVrktXRPpE3J9lYABlDUqpH52So9k2wNqXkS3xJ6Tn1oWXoqL2
         l/clYW27lfrBEa3vLKmQ8zuThjRDUbfTWGzN8UIO5/Dpjl6nMvc38SjoqH5Av9F0as9n
         5UEu+Bs9JuIXIm8b6/7ebzb2fkhLu3wkI2wcQrpnV4JB5qTPxlAorjAJZr45+MWk85Zv
         8nuFjYbYYwVhgoH4uhCmkOl3Wzj9M9lfLr62jOwT6E9rCbVIhYDN+1HS7jkBF4hPSt/t
         5E/A==
X-Forwarded-Encrypted: i=1; AKwUvBxMDRof3q1gGSDbo9E/JzKoQnYBl7YUqAILvW9f0k3FAaZGcUMUAh/yuWQY1+FAqQNHbvXZZQhi+vrmMPe3@vger.kernel.org
X-Gm-Message-State: AFq9FYJkswOyBvUUX9rmSVVnUiJCUTCZDD/hemSoSNj0nY+wqdMuU5vO
	LLTRZPoVaHAYj8zEsktGRNVloGrCcLq9+LDdRX2GxQayl7A6VeLW1s2x1W+Yuh2Ur4H8qPbcha+
	ddCEYS+yor3J1N852n4g6DT4u27v736s=
X-Gm-Gg: AYBFou0j3J8ul0l8+jEZ4+JmQW/GyjFq3wXarG+F7/15DPqIcBh6rf+3RUpenoxtL0S
	TiaQNfkT+fT14NOYao3UGsN6iQM4pcP3mGdYGrnzMOo+MZszKsRfBQZOa4QfSZuQ0Imlx9vvOJp
	jxBQ18EjTEaLp0khrSJ9xbDT3yZiuMqbznkkNlTEShfai4W0NAtpC97d3yQ4PpMqdjrh6yHEW25
	gEWUYGLRMSCkSvNNMfR8qCd4xpPTM5CxZ63pS1dcNZF45DpClquFLxMi46hiGR5U1LlkpN7Z9u9
	yBHsCOUIWOStYQZlNYPFHizaerzyD+fGqtkrIva7VCyma2qKx4O6uM8Os0ZtHgV8/IVWrwjg9nb
	vcVCg/ac+4IyFIGoYF8Mj8yraHUPXFK8xfJF08SQS1basS8vqSc+mYKrV5QFPlEQkFuN0EGWj/7
	aLs19MeE3iTtITdy+i03iA98iG6QQRhZHA8Zmi9+LdzeGxugeSSJG3aJzIp1Rz4ZoNxe7eDZwbY
	xA48OwUWv7t32c40aYraOqoHLUu3/W1TDpY
X-Received: by 2002:a05:7301:6196:10b0:367:2bed:e7a5 with SMTP id
 5a478bee46e88-3674d54de76mr374081eec.2.1792524140925; Tue, 20 Oct 2026
 12:22:20 -0700 (PDT)
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019151243.1595858-1-gprocida@google.com>
In-Reply-To: <20261019151243.1595858-1-gprocida@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 20 Oct 2026 21:22:07 +0200
X-Gm-Features: AclHuK_Q4B91U235uOypRate9HJl6NJQSOf6P4vyvpd5ZbK3OTSCP3Lki8_RDRA
Message-ID: <CANiq72nqq4oGBWVtSMBhXS6G4H7fYg07ysD7SjnOWWt7R9_ajw@mail.gmail.com>
Subject: Re: [PATCH] rust: exports: emit ___EXPORT_SYMBOL without C declarations
To: Giuliano Procida <gprocida@google.com>
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

On Mon, Oct 19, 2026 at 5:13=E2=80=AFPM Giuliano Procida <gprocida@google.c=
om> wrote:
>
> This change defines `EXPORT_SYMBOL_RUST_GPL(sym)` using
> `___EXPORT_SYMBOL` directly:
>
>         asm(__stringify(___EXPORT_SYMBOL(sym, "GPL", "")))
>
> matching the `__ASSEMBLY__` path in `include/linux/export.h`.

Hmm... It says it matches the `__ASSEMBLY__` path, but it matches the
`#else` path, no?

Cc'ing the `RUST` entry and modules too.

In addition, I wonder if we should avoid hardcoding the particular
form of that `asm(...` and instead expose it from the C header. That
way we avoid repetition and getting it out-of-sync -- that was part of
the original reasoning.

By the way, I am right that you noticed this via GCC builds?

(Nit: please write the commit message in the imperative form:
https://docs.kernel.org/process/submitting-patches.html#describe-your-chang=
es)

Thanks!

Cheers,
Miguel
