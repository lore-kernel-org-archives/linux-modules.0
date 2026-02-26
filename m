Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A524C2DECBF
	for <linux-modules@vger.kernel.org>; Thu, 26 Feb 2026 13:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772111401; cv=none; b=NKwIOFZIKKSqcLjbIDRXZu3U3WeLHkxByyxNKC7UR0pjjYPnLWoP1B2LLQRfxLTVOBZk77hXyRZrCitMeWT8Ye/9sGKq5u3mgICGAeAW2Ma8QGZ65UzsfWT6ORC7p0QHFQ9onGXE+Zq9/mu+dqBVWxGbqMnDdSqtm/bPgicYyb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772111401; c=relaxed/simple;
	bh=a1p1msLbl85XGiJLc5pnzixV/EAE95C8WZQeXpg7yPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oI9pAJ/j4O48Ro8Gk3yklKdgBBMoiIBRvszVKZOcH4u4d+0PP92Ebs+MSZYaqKgtkbFOU9zI3FVoJZnrxVew4+r5yM5w4mUlQOTapg8EvKUw8beJq54ia42A1NyiDWPmOuYWBaaK4IqszZzsediqt/5FU/M2yvCNJEMJqyCGxCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-94acf9ce1b7so661352241.2
        for <linux-modules@vger.kernel.org>; Thu, 26 Feb 2026 05:09:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772111399; x=1772716199;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFo4C5bqe5c13AwLxjM1MlDIBZrqfqokVA35lsfZfy0=;
        b=ZpQfTmiDLeE6jYaJsbxi9hFYxo2d89+cTHywEQ0kTIzMXkscvRJbOcVaPDeZkV+aQK
         oKeLfBkrrbvz+CtdAjOpmU80B8kAFW09HvIku/EVFG4NUy8TK/syVj9oEWdBMYqgHEXS
         xdDO/AFn+KqQwTcD0spKW1uHKxIzST0E2x1hDSLBOLhfRWYSI7gCsh8xxUMNNew5Lmab
         5Biu4B/o+2tXAk0/btCukDoBHA+PikA5mpIRQ9vSOAtiIPjL7+NO9+mVyq4FS9EFjhOO
         jroNWMLLpJbYcoCnB06Dgu/z5Jk4cm/o53JAcF3DETmGV1hCyZ6xR2qRgkB17rEy1tHa
         vS1w==
X-Forwarded-Encrypted: i=1; AJvYcCXIzRojKa95ZBsmcKNjyebVhLJ2uXPxWsoA7rXF96zYNxO/zRCB9VF1jeFMYz4AemFk/9Js1PCXFf7I3OjQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0LvNg90mqN4yQymXa/SepS6lgTPHcqstls6Kz+XeYWkFbwvEL
	2bsYR1y/3keB7WlXaEVUk/QPMZYs5gPGlmhPYPh4PPq2u7CFnS+JjfTHE9d0v0Zd
X-Gm-Gg: ATEYQzzhahF3LZ0+Ux/l1Y9bJC/zgvzj5p6bb25b7EBaA0O6yiUxXl2Mj+mPaUTtxX/
	SXgjCXyru7qx1MlnEFUa6sxB2eXVL0Ne0h9Rv/Zw9SQ/r3PcfF78MQdw+VKrwhKq3h1p98+TP18
	1frRHt+mEs4eqyBVmbSVE7QfQ2atpUREa6+QlDCIb4+8qZHhIJT/wzPnK4y2W4DiYDZWCcIFb1c
	S+v51T7pqKafMkFZJ0HuEUUkUnapsi0EveXEfN1nrmy6vUHYiAwVPUMhwsHJyYzNlFtUNPjvAgG
	3VJpNj3WSrWp/69DoTbwht1Tgok/22B5osI/QBHbQMdg2Wr8PUDBxRU/cisD6crxYMUg36QnAy8
	a1PwMMEiaX5mO1p1qEPsElP9BDvkrj92wpPOf3h2jxPFAHMy3N7DLSsqsZaI8/pMvp6y4NkkrVY
	KzWhriLKfuWL/xnfk7F7XGvLbbAOM0cwC+WZEy8VWtNtS50FV44sc96QqVKnvB
X-Received: by 2002:a05:6102:370d:b0:5f7:2568:abb2 with SMTP id ada2fe7eead31-5ff209d5ed2mr1090252137.6.1772111398590;
        Thu, 26 Feb 2026 05:09:58 -0800 (PST)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94df63d6695sm1584250241.1.2026.02.26.05.09.58
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 05:09:58 -0800 (PST)
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-5ff19e74779so520116137.0
        for <linux-modules@vger.kernel.org>; Thu, 26 Feb 2026 05:09:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUvSntkDFMFXW7x7razW1Yi1FNh4uTwOhqIc2wJjw3VK4UrKC52uc33SgdsBAngKQSl2x4yKEGM4w4ngwg5@vger.kernel.org
X-Received: by 2002:a05:6102:5112:b0:5dd:c3ec:b66 with SMTP id
 ada2fe7eead31-5ff20c30021mr989167137.30.1772111398038; Thu, 26 Feb 2026
 05:09:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251214181712.29132-1-ebiggers@kernel.org> <20251214181712.29132-3-ebiggers@kernel.org>
In-Reply-To: <20251214181712.29132-3-ebiggers@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 26 Feb 2026 14:09:47 +0100
X-Gmail-Original-Message-ID: <CAMuHMdULzMdxuTVfg8_4jdgzbzjfx-PHkcgbGSthcUx_sHRNMg@mail.gmail.com>
X-Gm-Features: AaiRm51PaPKg5xcCQeCnUb9vy0Lr9tZrrIwLkmaSIGSq-OyO54vQniCM8N9qQps
Message-ID: <CAMuHMdULzMdxuTVfg8_4jdgzbzjfx-PHkcgbGSthcUx_sHRNMg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] lib/crypto: tests: Add KUnit tests for ML-DSA verification
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, David Howells <dhowells@redhat.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, "Jason A . Donenfeld" <Jason@zx2c4.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Stephan Mueller <smueller@chronox.de>, Lukas Wunner <lukas@wunner.de>, 
	Ignat Korchagin <ignat@cloudflare.com>, keyrings@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"

Hi Eric,

CC kunit

On Sun, 14 Dec 2025 at 19:18, Eric Biggers <ebiggers@kernel.org> wrote:
> Add a KUnit test suite for ML-DSA verification, including the following
> for each ML-DSA parameter set (ML-DSA-44, ML-DSA-65, and ML-DSA-87):
>
> - Positive test (valid signature), using vector imported from leancrypto
> - Various negative tests:
>     - Wrong length for signature, message, or public key
>     - Out-of-range coefficients in z vector
>     - Invalid encoded hint vector
>     - Any bit flipped in signature, message, or public key
> - Unit test for the internal function use_hint()
> - A benchmark
>
> ML-DSA inputs and outputs are very large.  To keep the size of the tests
> down, use just one valid test vector per parameter set, and generate the
> negative tests at runtime by mutating the valid test vector.
>
> I also considered importing the test vectors from Wycheproof.  I've
> tested that mldsa_verify() indeed passes all of Wycheproof's ML-DSA test
> vectors that use an empty context string.  However, importing these
> permanently would add over 6 MB of source.  That's too much to be a
> reasonable addition to the Linux kernel tree for one algorithm.  It also
> wouldn't actually provide much better test coverage than this commit.
> Another potential issue is that Wycheproof uses the Apache license.
>
> Similarly, this also differs from the earlier proposal to import a long
> list of test vectors from leancrypto.  I retained only one valid
> signature for each algorithm, and I also added (runtime-generated)
> negative tests which were missing.  I think this is a better tradeoff.
>
> Reviewed-by: David Howells <dhowells@redhat.com>
> Tested-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>

Thanks for your patch, which is now commit ed894faccb8de55c
("lib/crypto: tests: Add KUnit tests for ML-DSA verification")
in v7.0-rc1.

> --- a/lib/crypto/tests/Kconfig
> +++ b/lib/crypto/tests/Kconfig
> @@ -36,10 +36,19 @@ config CRYPTO_LIB_MD5_KUNIT_TEST
>         select CRYPTO_LIB_MD5
>         help
>           KUnit tests for the MD5 cryptographic hash function and its
>           corresponding HMAC.
>
> +config CRYPTO_LIB_MLDSA_KUNIT_TEST
> +       tristate "KUnit tests for ML-DSA" if !KUNIT_ALL_TESTS
> +       depends on KUNIT
> +       default KUNIT_ALL_TESTS || CRYPTO_SELFTESTS
> +       select CRYPTO_LIB_BENCHMARK_VISIBLE
> +       select CRYPTO_LIB_MLDSA

These two selects mean that enabling KUNIT_ALL_TESTS also enables
extra functionality, which may not be desirable in a production system.
Fortunately CRYPTO_LIB_MLDSA is tristate, so in the modular case
the extra functionality is a module, too, and not part of the running system
by default.  Unfortunately CRYPTO_LIB_MLDSA is invisible, so this cannot
just be changed from "select" to "depends on". But as CRYPTO_MLDSA
also selects it, perhaps the test can be made dependent on CRYPTO_MLDSA?

> +       help
> +         KUnit tests for the ML-DSA digital signature algorithm.
> +
>  config CRYPTO_LIB_POLY1305_KUNIT_TEST
>         tristate "KUnit tests for Poly1305" if !KUNIT_ALL_TESTS
>         depends on KUNIT
>         default KUNIT_ALL_TESTS || CRYPTO_SELFTESTS
>         select CRYPTO_LIB_BENCHMARK_VISIBLE

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
