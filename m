Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795193164;
	b=HOm4hQPH1Pqae5wh67vJvcDCFVwRRi7UNZSg1XgYA4QenOeiIYm1F1hveSdPC+WK2ZF9
	 1oqquKJQDdJ4GwRo2YcCUTmCMmDmN4zp+uKihfzVE1MFip8phqLt76is2np7ucK23TCrA
	 g2pWY+aykGT9/rhUIXPMw5jMc1JwFibSzFLK5cSYbpl9PsgWWs821/vbib1Pg4vtbFBLZ
	 I4juhZK+F8bUmkM7d6EOe63d0fNy1QA8vNJOg3xJyc7Se1kou7Z9fO1zPDP3z/2nyaEqL
	 4NAFjsD0AFMqAG6CNtoFtQPh4wF3EDa9k6sSMq/CS5quqFe5oOuRznlBpBlcffIo6qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795193164;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Dkt10jA1AvCeLN1Vsm4v6pu6zl5kGUaCE7PhhGL0p7U=;
	b=LHpFWIYW4kK7fbR9ytYmi1odznITD5OdOCEJozwrxDLUQh8C5ocEUZSrlhtJA25kBjPa
	 aehhDZuEs/0JHU/uVw2ddNNyP605BJyO8Hso4fb0VpcpRjKWZBmUsvoeorpBgfPW493ID
	 F4GZ4KU+Z+23E6tnt5DTPYzu9Bhd8R/q7kdM3fWFTELsQg+THVOlVO5KckX1Nm5jyerJI
	 kDFq0ARXb0KXo1aKfXheTNCK1d8Q1a+dEg7yqgk4YyDcDm8oCoiC+Qg7BxM+SCIkZ0ZBE
	 gvLAjyRvw0AyPe66zyWUE/nY8MmMlKCwBRVlSfQtTf/yEtyl2Hqo0qhTPnnWoN6EZgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LaWQvPPS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F15B606A610
	for <linux-modules@vger.kernel.org>; Fri, 20 Nov 2026 16:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LaWQvPPS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04AB91F000C4;
	Fri, 20 Nov 2026 16:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795193163;
	bh=Dkt10jA1AvCeLN1Vsm4v6pu6zl5kGUaCE7PhhGL0p7U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LaWQvPPSf4Cy/v1y0LmKZS74djWoPn/LsnKbpTBfkjMuhS1kzGOMACUdgnRG4TEos
	 W1H7tgQQUhOydgN2XUUh7bZFxWnS0YX5qZ1Ktb4tUva9OoZUKowmzjyrfYAmCJ7WBI
	 ReAbWAuCR24KNsgRwnFY+gMo1d7uxv9a7TZ6BDtswYNj/ZHKWOE9OZZ72Y8jVlJgAE
	 djlO6zVE+aZfmJiEoufQ3SEyKGqIoDY0fp135lDtSJ4tP/rENOZndVJJ7qbOPqOvG+
	 okjhIWOs/+ng9OtpfE0ZLaANcAzIAwxNPBmyU87hcy7mA8U1iMP92hNIU1Uy8nTx3w
	 ad+2V7i8MXwNw==
Message-ID: <sashiko-outbox-225583@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rust: put C helper exports in a dedicated namespace
Reply-To: sashiko-reviews@lists.linux.dev
To: "Peder Bergan" <peder.bergan@gmail.com>
Cc: linux-modules@vger.kernel.org, "Petr Pavlu" <petr.pavlu@suse.com>, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261120-rust-helper-namespace-v1-1-3b9a05553ff6@gmail.com>
References: <20261120-rust-helper-namespace-v1-1-3b9a05553ff6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 16:46:02 +0000
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] rust: missing RUST_HELPERS namespace import in kasan_test
  module
--

commit 42a51ff367154ba548e8d27e3154503fd972371b
Author: Peder Bergan <peder.bergan@gmail.com>

rust: put C helper exports in a dedicated namespace

This commit moves exported Rust C helpers into the RUST_HELPERS symbol
namespace and makes the Rust module! macro import that namespace when
helper inlining is disabled.

Link: https://github.com/Rust-for-Linux/linux/issues/216

> diff --git a/rust/macros/module.rs b/rust/macros/module.rs
> index 0a7b9e24c9600..ac3376fa8fb85 100644
> --- a/rust/macros/module.rs
> +++ b/rust/macros/module.rs
> @@ -467,6 +467,11 @@ pub(crate) fn module(info: ModuleInfo) -> Result<Tok=
enStream> {
>          }
>      }
> =20
> +    // Inlined kernel code can introduce calls to C helpers in any Rust =
module.
> +    if !cfg!(CONFIG_RUST_INLINE_HELPERS) {
> +        modinfo.emit_only_loadable("import_ns", "RUST_HELPERS", false);
> +    }
> +
>      // Built-in modules also export the `file` modinfo string.
>      let file =3D
>          std::env::var("RUST_MODFILE").expect("Unable to fetch RUST_MODFI=
LE environmental variable");

[Severity: Medium]
Does this break the build of kasan_test.ko when CONFIG_KASAN_KUNIT_TEST=3Dm,
CONFIG_RUST=3Dy, and CONFIG_RUST_INLINE_HELPERS=3Dn?

kasan_test is a composite C and Rust module (kasan_test_c.o and
kasan_test_rust.o in mm/kasan/Makefile) that defines its module metadata
in mm/kasan/kasan_test_c.c rather than with module!.
kasan_test_rust_uaf() in mm/kasan/kasan_test_rust.rs uses KVec::push() and
drops the vector, which inline into calls to
rust_helper_krealloc_node_align.  Because neither mm/kasan/kasan_test_c.c
nor mm/kasan/kasan_test_rust.rs imports RUST_HELPERS, modpost rejects
kasan_test.ko for using a symbol from RUST_HELPERS without importing the
namespace.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-rust-helpe=
r-namespace-v1-1-3b9a05553ff6@gmail.com?part=3D1
