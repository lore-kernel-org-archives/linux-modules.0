Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795192876;
	b=Nr3IGUFQeduqhJNsLT3pYRrJn49lOpWGErHBwDdOm8ErtZSmI5FNF9HUjsiUvjH0mTv/
	 Q//bhjWU3PYMndhmmd3fcfC0QFmb6ZjKZGszvGhQyRsBTCfNfGe6vFdTakj0xF2sGv3sU
	 VD6iW1+QUBqjAiJzLcZwDEfY5rbXGdi/Oa2A/uL7CDttYd+rVvXCqCxaZrPiDw7A8n2om
	 un9iTc/xdXftTENrE113tERkzpcTpoGgj3rGjg4zs9CUnlAjDtYd5ssamhm1shMN4fXMh
	 FzpssMWqNqQ8IyMoO6y0U0taU6KyobFiElLhVrYhPd47VmPv1x+kTwSRTsN3zTlzA4Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795192876;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=5LKcQCSmGSFWH7cFrHCRUFRL7czFDZ0JoEIiivjm0J0=;
	b=xuJ92Wg0Dav39RvmtPk4U9gZTjQyl2Cz0bi1F/FBCnbnnfyK4EpfA0mR4jd/cE5RKYXU
	 1e8gGc/jznyZur4ayOlHcxD+WjlVbBmJ1wbSDoS2FLScaOkn/IL1sU0IcG1oDiR6Fvx2G
	 lseinowwu76K9vs9L1YZRxgpTP3I+G8j146e8pTl3WewlR7i2wEXTd5O9BWSqMBjDB0/C
	 sRBfy/IOQHNjHEr0P2T5+mv/FCOHw81fF0qGFIniSRJn4zfOAQ16rcqrMZIle22/h/N+C
	 xOXyw7fm724AfkNKBOuB2rT4WoBH68XpDA48FLqtHzDR8ROo50PgAZcysCSNaGYzoog==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CR6kwwm1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C07E60A2605
	for <linux-modules@vger.kernel.org>; Fri, 20 Nov 2026 16:41:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C07E60A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CR6kwwm1
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4bb6860f867so61185e9.1
        for <linux-modules@vger.kernel.org>; Fri, 20 Nov 2026 08:41:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795192872; cv=none;
        d=google.com; s=arc-20260327;
        b=HX7y6QM2heVcfE7R6omAGWef4mhyY1osJSCLetp3W3LjyPfdaFGs4Q6wr/rsXpbz8g
         4cAA/JY2e/48ueCKlLNbOXOPNXTHEFVJrCSUPvZcrV/o6jfTQ1/3PS33cevFy++UsjN4
         UwqAGpUMRUPbqT6csvzIIuaj3R/rRYSzrDHyHCTg61uy3CbG/v56eE/RTdz7qdJzDOYi
         0EQ8ltG3CG14qtcZu3NJ/psG2c74iq3IS8FZ8tm5kaJrbI3Zcr0I7Zp6hGzVN6Si9yhk
         c750/AvUzgoki/38EPSTRZPhEem2bnmf+YICjiCow7KVzaSaEiyeB3FWPvnzpyBkKcA1
         GfTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5LKcQCSmGSFWH7cFrHCRUFRL7czFDZ0JoEIiivjm0J0=;
        fh=H0L9V6A46gcbu2BHTDa1F51amHJImU58HXZ3u4DlTVU=;
        b=fcGh1tTPO4OrJ/y970pAFp4mbz+IMbddChnnRZvyp0VzKNwmYo/KwBru6PRlrB3tZ8
         sBJAGgI61ORIQiA+zVUiE5poZqMSYoc+Fd9w01BjsLhy2TU3/cYi7t8dkBIB3yuE8NUo
         8yYxjGr3+xOWFSf9SyqYPUeF6p6JjMU+XgVJ5rWzxeUmsc3+Y8TMFRxfRU2426tb0Nlu
         zAVGcZYmM7RK6YJ2rXZpi/VJ2P1wRYGCaOzpAJKYPlqnYu9lmpIsQLB2HTbSqXMktkXu
         bARuVlg3yUm20boU+Y5QwUm5Gwt9F1kOsldmJiSOD5GakFnsN61pwzwoxP+mRdJyps/T
         Rl0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795192872; x=1795797672; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5LKcQCSmGSFWH7cFrHCRUFRL7czFDZ0JoEIiivjm0J0=;
        b=CR6kwwm1oHbSxVATbOmkl8qKoYaBhgBn5D9snZ0tnQQ3Mum6vvcKkI/UYRjN3sbMsU
         Q3lP7ctTQ8Lb7hgMXk7ZerlRr75y+f4aYQidLl6z3oJYiMaKDGK3/R7U9pbJ6Y0C+4OB
         UKhhnMEVyFTIgUtmL1tvROIZwAd2MQkwQFMbsoAeySbHFbwa3nzNeVShfEzrmGx/jv+o
         Tj4RmDVqM90h5lRnDknyA1JU+t8COdH4pwqC/b9DqLWfgwD/2mKyrQ9XeJCVEaIOuWsj
         x/oFen3mIU0fyVzeYnYKAU/8YM/lNctAhZmTQ6Lp/G+PeuM8bChEd+t4yQXKFCshyHwU
         Um/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795192872; x=1795797672;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5LKcQCSmGSFWH7cFrHCRUFRL7czFDZ0JoEIiivjm0J0=;
        b=BQoiC80b53YGUvEZ3V6CYkKb2fwfszqQmcF1rYnVr9P+ZmoP2xOWIzceFCavh0QpL2
         WCezfvyh2JroNTpKvaykpHqis7K815Ypw7Wxm4pUCik4BzgUecEXqrTivtdOxBoX0tNu
         pFEk/zYszooOK0fcEzDlZ+z4xedmzindvEcEunO7Teo6HnqPfJFNyN14704jHy8lag1h
         Hyi0un9dzsbknB/pIaOiNre0s0trljqwdjwqiJTew3WYgecg3k3zBvYWjDWRgWJUVxC3
         3UqsLr/2xjqDYs7UjXr0sesSFk6OZeXDsLtaxdfjPozX7ecbpJ0bCZqAk7t8uwPqe/KI
         Y0Ig==
X-Forwarded-Encrypted: i=1; AL+hErH6wAcBLx7EsFloLjb1/WhmLBXrxaWqTza9fysoa9PKnv26Cuc8/QykKKngLJK70RtI1HKBFv2ipPFLP6ih@vger.kernel.org
X-Gm-Message-State: APuU4Z8mZKIjGkp4C4Gj4rA1Sk9efnhsi2JnfgViYnXdka9kKha4u475
	LWF5P2XhM0Vjz5XcRc0+uxrT4pT1jqJWVH+A1hd5pU5oqMGy2laZp2yVQlM+AIhBEP7mZA+uO2z
	r86x8h8mcG1xTAj0GtUvye2lksI5xuQT2N4ptffx2
X-Gm-Gg: AYBFou32gkPX9+jqOrCDlHb2BQ0qOYo5rmfPN4ysh7HFLmE2uLfRyTzw1PRG7ZWgY4I
	mAZ5tY23ari2ouPl0Fmbhg9YuKJTVS5HgEJpn1/BLGYfDkUfNUyXGpHKnZdjjYr0k/ZdEVcpasQ
	pYBRr2AiyVHB+OzX7cJ1PddX63sYTTgV4gD3A+lFAhZnuPHrEWrO6fpTdib7Xa44m2gl4iPkuxK
	epWK+tFQ6l5FBcs9EybmbiigYkcmOP8Xo/zmRQj6AIxejcnIm4vywbydn/SNIsjPW7IfHpdvcV+
	m22VQun1r8MDKWfKM9ZdXOnZG8GEGVCnRILEWMGdFNnCl9sg0ZgFZx3n8MDPrAv/3euPpsflxYj
	Ju791/3S4s/7yxZPZnOcmy9MvGDcJ6oQZ9g==
X-Received: by 2002:a05:600c:3ba4:b0:4a2:bd1:a80a with SMTP id
 5b1f17b1804b1-4bb89619133mr1203705e9.2.1795192871012; Fri, 20 Nov 2026
 08:41:11 -0800 (PST)
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119-fix-rust-build-error-modversions-v2-1-1c2271cbcab5@gmail.com>
In-Reply-To: <20261119-fix-rust-build-error-modversions-v2-1-1c2271cbcab5@gmail.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Fri, 20 Nov 2026 08:40:33 -0800
X-Gm-Features: Aa3M54oct8MRe9MZBWMaHsVotwxFhMb4AgWLlWpoCWN9GDOy9iSx4jSZ3IW3NJ4
Message-ID: <CABCJKufYm_PXLzoTSyj6jFjz9fO4hoUQT5eTqxofg7ARMg=2UQ@mail.gmail.com>
Subject: Re: [PATCH v2] rust: kbuild: generate a symbol version for rust_build_error
To: peder.bergan@gmail.com
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Matthew Maurer <mmaurer@google.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 2:19=E2=80=AFAM Peder Bergan via B4 Relay
<devnull+peder.bergan.gmail.com@kernel.org> wrote:
>
> From: Peder Bergan <peder.bergan@gmail.com>
>
> CONFIG_RUST_BUILD_ASSERT_ALLOW exports rust_build_error to modules.
> When CONFIG_MODVERSIONS is also enabled, modpost warns that the export
> has no symbol version and records a zero CRC because the build_error.o
> rule skips gendwarfksyms.
>
> Let the existing Rust library rule run gendwarfksyms for build_error.o
> so modpost gets a version calculated from the Rust definition.
>
> Fixes: ac61506bf2d1 ("rust: Use gendwarfksyms + extended modversions for =
CONFIG_MODVERSIONS")
> Reported-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> Closes: https://github.com/Rust-for-Linux/linux/issues/1201
> Signed-off-by: Peder Bergan <peder.bergan@gmail.com>

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami
