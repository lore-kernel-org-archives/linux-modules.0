Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795079341;
	b=fP27pzP58cla7t3fDoqoco4w31kwYWGnU6LNHk1eKxe/DmZpslEQQitrCtN7Jz5ISir3
	 4AnHrdBgutM+J+RooMTeq0zW4FnK37Bx0fidGvZklrBmGH/cple3t/ND1sLeSZHYIuMDz
	 2YBQ9A7WuAHFnjOoe0WOXdA2IgU6Oo56EMMObLohNiEjWm0glhxhjbEYbBBgBhUqtnDIs
	 s2bNJ5HHu2pn0S+bMJMPCFmic6PV9grpXeZS1UBt2KhQ2DI5Nw9c1gbNYI62Oyr60FRNJ
	 aCmfcFYg2QyqeZsjcjpWYvEo+B5+E8qMI7vK+kEbKujCrpXoaKGLx8SJaRtlw7zov7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795079341;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=shDiFk20LC1UUo9BbkdXyMW9CI3xVCJ1NAWMbOrb6bQ=;
	b=ICk0veFhg7hFzdYklpUcnAEtI5kwrnez3Dejxqn3PSgHVC3U9H6/ZOLHr/i+H/yfTKE5
	 zG4yg052pWMKuDfEB/rHD/Ek5GYPauPgSr7bti08IO2pxkrZhd+1yJuC4D8JgBVlQcKWj
	 OlTq5QBTz3KmBCxbhYpLySqIFMnoYLyL79DRLCsZ7/5I/swIGyt9psuShX1OFsIYl+uQK
	 QsBTkHRhSHN9HL9eHLO5l7SZxGwTWpMoJZ9amIeJ4aAEfGruwakxki8GeIcUTxt3flhk9
	 QioAvr+PcC/8aUaPHxV9tyJx0nc330wtbmq/mkBD2Wy4hsLcR1F+wNGA/P+dqOkMJHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=klUf0ea1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59474606A320;
	Thu, 19 Nov 2026 09:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=klUf0ea1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAE7E1F000C5;
	Thu, 19 Nov 2026 09:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795079341;
	bh=shDiFk20LC1UUo9BbkdXyMW9CI3xVCJ1NAWMbOrb6bQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=klUf0ea1GlkGcPFLvjVSPSe0wPOsTeuf7ejM/nytnUU1rmAipyRZwakC8tbCA0cCa
	 yCiKsCX1AaVItzjNmNQpmkS676j8hhpnchAS/vKP7qWRmimfCcHBqKWVYKpJkrpxTL
	 cLs/mx2XhYUH7rz7ZHtOu6yghZJjAVOJBdx0uwwpyi2M9hOzX9M4HrTg4pOqCcdL0V
	 ZN033cFp/ZukGomSRjMMltvG5fP23DSgMO+lva5wL3cWC5u8lgIlzdR34C2PgqT/Xr
	 05rROE3VNAdhN/ManrSqazRcDt5OZ7hr+R32cRl4avNEC8HnZPRsFYt0x7wzSIPkKj
	 pVWSBh9Tl6s7A==
Message-ID: <sashiko-outbox-222788@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rust: kbuild: generate a symbol version for
 rust_build_error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Peder Bergan" <peder.bergan@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>
Cc: "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?b?QmrDtnJuIFJveSBCYXJvbg==?= <bjorn3_gh@protonmail.com>, "Benno
 Lossin" <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir
 Duberstein" <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?b?T251ciDDlnprYW4=?= <work@onurozkan.dev>, "Nathan Chancellor" <nathan@kernel.org>, "Nicolas
 Schier" <nsc@kernel.org>, "Sami Tolvanen" <samitolvanen@google.com>, "Matthew
 Maurer" <mmaurer@google.com>, "Masahiro Yamada" <masahiroy@kernel.org>, "Gwan-gyeong
 Mun" <gwan-gyeong.mun@intel.com>, linux-kbuild@vger.kernel.org, linux-modules@vger.kernel.org, "Petr
 Pavlu" <petr.pavlu@suse.com>
In-Reply-To: <20261118-fix-rust-build-error-modversions-v1-1-7c1023764f30@gmail.com>
References: <20261118-fix-rust-build-error-modversions-v1-1-7c1023764f30@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 09:08:59 +0000
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
- [Low] rust: kbuild: wrong $(src)/Makefile dependency on
  $(obj)/build_error.o
--

commit 9e904760dafd3ce72fdc411a11382bf2076cfd36
Author: Peder Bergan <peder.bergan@gmail.com>

rust: kbuild: generate a symbol version for rust_build_error

This commit enables gendwarfksyms for build_error.o so rust_build_error gets
a symbol version when CONFIG_MODVERSIONS is enabled, and adds a conditional
dependency on rust/Makefile for incremental builds.

> diff --git a/rust/Makefile b/rust/Makefile
> index 0165626decbe7..dd5b0a958d0cd 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -773,8 +773,9 @@ $(obj)/pin_init.o: $(src)/pin-init/src/lib.rs $(obj)/=
compiler_builtins.o \
>  # treated as such so that we pass the same flags. Otherwise, for instanc=
e,
>  # `rustc` will complain about missing sanitizer flags causing an ABI mis=
match.
>  $(obj)/build_error.o: private is-kernel-object :=3D y
> -$(obj)/build_error.o: private skip_gendwarfksyms =3D 1
> -$(obj)/build_error.o: $(src)/build_error.rs $(obj)/compiler_builtins.o F=
ORCE
> +# Rebuild when the symbol version generation rule changes.
> +$(obj)/build_error.o: $(src)/build_error.rs $(obj)/compiler_builtins.o \
> +    $(if $(CONFIG_MODVERSIONS),$(src)/Makefile) FORCE
>  	+$(call if_changed_rule,rustc_library)

[Severity: Low]
Does adding $(src)/Makefile here rebuild $(obj)/build_error.o when
CONFIG_MODVERSIONS is enabled in an existing build tree?

if_changed_rule checks $(newer-prereqs), which uses $? and only triggers wh=
en
a prerequisite's mtime is newer than the target.  Toggling CONFIG_MODVERSIO=
NS
from n to y in Kconfig does not touch $(src)/Makefile, so its mtime stays
older than an existing $(obj)/build_error.o and the object is not rebuilt to
generate the symbol version.

Conversely, once CONFIG_MODVERSIONS is enabled, any edit to rust/Makefile
updates its mtime and forces a rebuild of $(obj)/build_error.o, $(obj)/kern=
el.o
and all downstream Rust targets.  Tracking config changes that do not alter
the saved command is normally done via
$(wildcard $(objtree)/include/config/MODVERSIONS).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-fix-rust-b=
uild-error-modversions-v1-1-7c1023764f30@gmail.com?part=3D1
