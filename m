Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795083569;
	b=YHVycdo3RARAdF6nsjw5zCzpBOpgx+t20/x81fN9bUqgUHfstFz7fNZnd940MNSFeOHY
	 KJJInxsbgkQ3jS6vEa7mIKscyIYL4Pwd//J357W09Xw79c1pJEjX4SMe+xZdgcamL+/pQ
	 ufHQN/+mg0kmeFjBRsmtNdY/Kfi5r1n/lA1AgoWZ2n2/F3Mpz8BwcNPDMr8toRSAfs7Uk
	 NnoB+AHWstLz8PuzzkMKa2cwuh6XNkH+ZPnASGcpZ0Kdn51t70k9LfiL4Iyp50p6cg7eo
	 6pAdutBmP/fxxV9yQwrYgSZfjswQ9ZARl08AZxH9de8UFMm51jwXSseeZSxPFnLf6UA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795083569;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=m53aXYmEF4AyDP57cY4Xl9wMUGGgZR0bxPJfdyWOUVs=;
	b=MkH9XBMRxuNcnTw64nD88R/lOBtu7kLSxzkRx33KywvVMy8vvlDiOXFc1iiCRhyfrE6z
	 NJWEZbttv8apkX95nL+6CsD+qaEzAjhyq2CkIQhCSYgkvZ+PPOBIIBVQSx3aWvcxcmhXR
	 1iCb/DTfK7QR1dKvxvsGxjWGXJNp0B0oSXKiLCkzNmxZRtePQfRHcV+4lRjeUGAD5P1we
	 2RxB5FCm1MClsXsrBmNFsqqHtah03Ejt7RVvpo6UqNRhr8/vorp4ni20ewU9ikeWSyHOl
	 c3Ka9Opa2GtovSSuVnPpqN0HdpHuXVAaD7Sj0aqsFarnzUhZMAYTOIoGaQUT1fUEzyg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ij04j8DC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD7060A260D;
	Thu, 19 Nov 2026 10:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ij04j8DC
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795083569;
	b=UI28g3UJPsx3bzMvU3DBuxIVLXodAvo7ac3eZM5uJKVJ6z4y85TdZ0KWL8zC5X6E7Av4
	 uRgOMJ8tjZUTNXJLRRwU2CTQAA8JiEEQVAUNz5g047bYh7Nby011+jasafP+mDq46mtQR
	 I7DMG1goOIUSVyQ1CqiEm/ZixNB/xhWdjfsbSOa8QIVlnwqXbxffaecZMqP0DA+lGzmhc
	 cT6E7WN7SWVh0kj94v3KamdnT+mQhWFByXSRXBqHdNr5iGKW834U30JYKbm77ndB1ZM6x
	 0QN0grgX6Dmf0QAzomB0quhHJAMTQbiikKtd3A6AVLs2XV0z+jDY9DlJQdNfYQMSoLg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795083569;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=m53aXYmEF4AyDP57cY4Xl9wMUGGgZR0bxPJfdyWOUVs=;
	b=cmqHubJy5Mh0+HLKSaTr0+e6OttfUdUUHAvMFpLy801Swrjaq5QGmA6BFFAWlQVxrvoh
	 bLxQwYiRI2qrwimb8CtsMXdiuTVynG4wVVNYgKAzTxH4q3sLr//6PQTqUOCaeYAs3w8+L
	 vzs1j8ZeV+GH/qE1lMbVrU3722DSPBs22k7CUlPa+Uy9BgeVXQ5jRP7I/hjCq8TP55ZUD
	 TdH1JEPBf8dlXsrLYcoaksdoqoD9+/K5PKNagqpYd24pwDwYzKwBsWHPew3MRviFOKbBV
	 CdyMJgE78usLMpGailPnwaOxTaLr0drg/wL6g3mNCwheligCxcR+Hw4gjk+8EEPteqQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D10541F000C8;
	Thu, 19 Nov 2026 10:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795083569;
	bh=m53aXYmEF4AyDP57cY4Xl9wMUGGgZR0bxPJfdyWOUVs=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=Ij04j8DC0E+YO1yse0S9bnEYe54f7CfB5kVz43rp3ZGap5AQ3hf1DnsJPzGhSVLF4
	 0rVZ187ZQ3Fe7RjNvZOeKH1aXY7urASDRh6ghVyN1BkfNUZfBM9kPx/EA62nVAo7/k
	 zSeK46EP9LJSVM9rjrHJCOSAAGk7/MfeVepeXQs22sf8FT2pc7C46Y7asi3pUlqu2y
	 AcGq/krdqXApQ5nF4UFSlXO+oVTRqTIDqVQxW7x16SnhKi34jyLxbDVPXtzignM72s
	 T4MsZiNQ8bG4+T6zRuY+ezyomTH4AqFAu/TyDHVmo1HC65Q/4O4sdqtZqMP3ZIY9nv
	 G8X6a8NyckQcQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 600E64B1FA;
	Thu, 19 Nov 2026 10:19:28 +0000 (UTC)
From: Peder Bergan via B4 Relay <devnull+peder.bergan.gmail.com@kernel.org>
Date: Thu, 19 Nov 2026 11:19:28 +0100
Subject: [PATCH v2] rust: kbuild: generate a symbol version for
 rust_build_error
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261119-fix-rust-build-error-modversions-v2-1-1c2271cbcab5@gmail.com>
X-B4-Tracking: v=1; b=H4sIAC/N/moC/5WOTQ6CMBCFr2K6dpQWBXXlPYyLtgxQQymZKQRju
 LsUT+Dye3l/H8FIDlncdh9BODl2oV9B7XfCtrpvEFy1slCZKqSUF6jdDDRyBDO6rgIkCgQ+VBN
 SyjKcdH3Oz1jZq1FirRkI18w28Xj+mEfzQhtTb3IYzQiGdG/bJI0DR0Ltj9tMj3NMptZxDPTej
 k4ylf3xaZIgobQyU3lZnOo8uzdeu+5ggxfPZVm+bFXCkgcBAAA=
X-Change-ID: 20261118-fix-rust-build-error-modversions-4af535edc9b2
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, 
 Matthew Maurer <mmaurer@google.com>, Masahiro Yamada <masahiroy@kernel.org>, 
 Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
 linux-modules@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795083567; l=2248;
 i=peder.bergan@gmail.com; s=kernel-contributions;
 h=from:subject:message-id;
 bh=dbbgO3cdXEYZnqxuqEQFpr48GQcdzVFtPCT9yziI+74=;
 b=tae+5P4ETQ7tXxOEyLVULdo6qfYAyHFcHGGYHK8B2HaCV+oz05eO5UPy0B9Ijz6zN869I5j52
 3/d3NVa5wfmAJb0zYT6QHK8/qAQl1vfSpqWRqT+A3M6W+sT3zEX4/a9
X-Developer-Key: i=peder.bergan@gmail.com; a=ed25519;
 pk=39790pn1YZCulHBoUG1uiQI1Hm01EvhBEa2zVrS/yN0=
X-Endpoint-Received: by B4 Relay for
 peder.bergan@gmail.com/kernel-contributions with auth_id=1395
X-Original-From: Peder Bergan <peder.bergan@gmail.com>
Reply-To: peder.bergan@gmail.com
Content-Transfer-Encoding: 7bit

From: Peder Bergan <peder.bergan@gmail.com>

CONFIG_RUST_BUILD_ASSERT_ALLOW exports rust_build_error to modules.
When CONFIG_MODVERSIONS is also enabled, modpost warns that the export
has no symbol version and records a zero CRC because the build_error.o
rule skips gendwarfksyms.

Let the existing Rust library rule run gendwarfksyms for build_error.o
so modpost gets a version calculated from the Rust definition.

Fixes: ac61506bf2d1 ("rust: Use gendwarfksyms + extended modversions for CONFIG_MODVERSIONS")
Reported-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Closes: https://github.com/Rust-for-Linux/linux/issues/1201
Signed-off-by: Peder Bergan <peder.bergan@gmail.com>
---
A clean x86-64 build with Clippy enabled generated the same nonzero CRC
for the kernel export and an external Rust module that references it.
An output tree built before this patch can reuse rust/build_error.o
without generating the CRC. Rebuild that object before relinking.
External modules built with the old CRC for rust_build_error also need
rebuilding against the corrected kernel.

OpenAI Codex assisted with coding and testing.
---
Changes in v2:
- Drop the rust/Makefile prerequisite after Gary's review.
- Omit Sami's v1 Reviewed-by because v2 changes incremental rebuild behavior.
- Link to v1: https://lore.kernel.org/rust-for-linux/20261118-fix-rust-build-error-modversions-v1-1-7c1023764f30@gmail.com/
---
 rust/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/rust/Makefile b/rust/Makefile
index 0165626decbe..189c5cbdf44f 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -773,7 +773,6 @@ $(obj)/pin_init.o: $(src)/pin-init/src/lib.rs $(obj)/compiler_builtins.o \
 # treated as such so that we pass the same flags. Otherwise, for instance,
 # `rustc` will complain about missing sanitizer flags causing an ABI mismatch.
 $(obj)/build_error.o: private is-kernel-object := y
-$(obj)/build_error.o: private skip_gendwarfksyms = 1
 $(obj)/build_error.o: $(src)/build_error.rs $(obj)/compiler_builtins.o FORCE
 	+$(call if_changed_rule,rustc_library)
 

---
base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
change-id: 20261118-fix-rust-build-error-modversions-4af535edc9b2

Best regards,
--  
Peder Bergan <peder.bergan@gmail.com>


