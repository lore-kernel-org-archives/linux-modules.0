Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794992931;
	b=IZjG4z2XI1PAdZweugASlUJgdxXMU2lnYLnWoTVbrJoSDoeJyof4bzV0uNcyAoM7aTHd
	 BmF70eIeipJRYbfxzxWvrIH18Vgc3NCvgEM08w2Oh3NKTQtiTujone79YcRnSr7t7ZLt+
	 wESSauQooXHF/La0UWzWJ7KEZxwu9+J6DkYekloBAi1Ejt19CEIQt7e5HmxatzTLUEkh8
	 K90ZtZgBl+kQxcju7xB82SsZ7FwLaIQGaXoB2oNT5OO7KLYxTOMjViZmo78L3u7VEfzYt
	 zssr36hlH4EBrI+kH4R+M/MEGcPvwAcHVbFiAoYeeI+S+ryqM+8wm0329Xp1BqDhA2g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794992931;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=AL/L8BBoMuh5RxZuA7Vq9fjpLcJFyNh6WrlsR3XYHdU=;
	b=ShPfl8fW9flgGBLZSB3vymDPMG7oQlFEd5RnIyi9R4+qlQcjMfiLVzc5nVgXh+1M4wXY
	 glb9w4mMRiCIa+7cCYPqYRT83vwx43AyAbtjBbRYUGB6wh2HWe1LifFmZ/UOGblDmWPlp
	 Y8MagT1r+efVUhqQNWBkSmNnRLTSZXWy3I333s0tU4dmBMCxFFc+HtKrHanFF9RWhI9c2
	 MQHiuSCDD5Sk4RLGyKlgc+uji24QNiizzniFxLhgN2FW1ANaquFibtM79Je2g9+jXNIZE
	 yvL88ZBgG9ioSXzfLhT1Q46UFEPs5jb0Huguj8yNwTZbF8P+AP00oenotTSOiDW7e5w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gzzq4FJF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF938606A889;
	Wed, 18 Nov 2026 09:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gzzq4FJF
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794992931;
	b=tWYt29IW4RVbDmmoGymUh4qrfDoLF8CV/atUldroTrZW8W6D6XSgwEqsZXfakTd9DCe7
	 Ei7Q7Edi+iW/iScTLS0hVsHefaYrOeeyS0WzFot6rsqdgRFJMw7QpKcfHWtHEbTC9QC7Y
	 un/zZ/nqBQdp2uIigMpSfE2taAmODB6W8N8ZOBnDozHm9y2aBIeBb2xyBiNsezIxRN8U7
	 Xn98iC1yHuv8GkSWiLEebxryj7Hu8n4Va27SnMMSrP7OdELKobMJpubxzFzCfhfwzF+5j
	 Aw7oWvGNKeAJ4Z7pSqce7gvZeKLssFSDnYxHtMP7aWz5bQYMvVcoZqBTP6BNk8FBoxQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794992931;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=AL/L8BBoMuh5RxZuA7Vq9fjpLcJFyNh6WrlsR3XYHdU=;
	b=g9CLEN24FdMbImEBAUsu1EGNSySnsoO7omSJ184ugYQ6EbsmfgSihkp1eb5ruCdDbA5q
	 OI7Sy466OmUK6Hzvr/O71g36pFQw2hV6PKTJMzeoLTD/FEeE+a3CHU0COBetPfaQXbUPJ
	 J4opzKWzvGqNVc/oAIvTnFxwpgAMDcorJcVjdKwzehvmOZT+Ai+6pUzyAa6t+svArm1LD
	 tjWm+2Q1ARfv3G5isD4mf4PgIoMU1WroTK06qsW8DtLKwrZ/JOXZOCeKUVkR8/N1Y+Dzq
	 ITtdcNAs+LfThXX5QqjWHKMaDd7worAAAuPDpu57kIMO5JNt8iXu+XUGxsF41cE8eaA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 96A8E1F000CA;
	Wed, 18 Nov 2026 09:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794992931;
	bh=AL/L8BBoMuh5RxZuA7Vq9fjpLcJFyNh6WrlsR3XYHdU=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=Gzzq4FJFuKfpGAgoHeCJfqnfgVCUUIWV5A4f9TVfDQ9ODtCZghv4sN68iYj47o8Ui
	 scRkCc4cAqHY+vopWh4aWNPKbl5q/g6hVqs6gnrpvyFyQYSXkI3sj8cchJESa791cT
	 7QWn2rO/x//GNI409UxIFnmdfMVusFIX35nicB31Sh5GW9ObCZzS+NeHPgyPJ0N5iK
	 jpYEloFwSDTuXGQH6bJ64LT8XNI8N5eSZTU51cb15xO8rzlF4sAdu6vurxSYD2NOCn
	 UveJqcNWpZ1F7ptlPp+6kq7zS3pXuZwJZVIW8bTIllsng90uopDx0D04tKqs8XNysw
	 cqJabqAdVWQpA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 138E34ACAA;
	Wed, 18 Nov 2026 09:08:50 +0000 (UTC)
From: Peder Bergan via B4 Relay <devnull+peder.bergan.gmail.com@kernel.org>
Date: Wed, 18 Nov 2026 10:08:50 +0100
Subject: [PATCH] rust: kbuild: generate a symbol version for
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
Message-Id: <20261118-fix-rust-build-error-modversions-v1-1-7c1023764f30@gmail.com>
X-B4-Tracking: v=1; b=H4sIACFr/WoC/yWN2w6CMBBEf4XssxttFaP+ivGhl0VqpJDdlpAQ/
 t0WH89kzswKQhxI4NGswDQHCWMsoA4NuN7EN2HwhUGf9FUpdcMuLMhZEtocvh6JeWQcRj8TV1f
 wYrr23JJ3d6uhzExMxdkvnq8/S7Yfcqnu1oY1QmjZRNfXKE+SmMxw3G8iLQm27QeUqHuzqQAAA
 A==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794992929; l=2134;
 i=peder.bergan@gmail.com; s=kernel-contributions;
 h=from:subject:message-id;
 bh=iwv1qR5QyWs5FUrFMluYyHlgGOi5NpHY1vMGZeZUJRU=;
 b=NwD6BfBA4WLob4JLWPSWapwm4CZS3A7yc5jvskFd0xanhimNfBdKYJ6oPbN3P2DqnFUHqZ/RS
 z4EPoyo3A7EC6m2QxLn1urUhN9JCBklyXWBl1CvPG6Yij6lqo4TXdgd
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

Generate the checksum from build_error.o with the existing Rust library
rule. Make build_error.o depend on rust/Makefile when module versioning
is enabled so incremental builds pick up the change. Kbuild's saved
rustc command does not include the gendwarfksyms step.

Fixes: ac61506bf2d1 ("rust: Use gendwarfksyms + extended modversions for CONFIG_MODVERSIONS")
Reported-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Closes: https://github.com/Rust-for-Linux/linux/issues/1201
Signed-off-by: Peder Bergan <peder.bergan@gmail.com>
---
An incremental x86-64 build with LLVM=1 CLIPPY=1 clears the modpost
warning. The kernel export and a Rust module that references it both
record the same nonzero CRC.

OpenAI Codex assisted with coding and testing.
---
 rust/Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/rust/Makefile b/rust/Makefile
index 0165626decbe..dd5b0a958d0c 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -773,8 +773,9 @@ $(obj)/pin_init.o: $(src)/pin-init/src/lib.rs $(obj)/compiler_builtins.o \
 # treated as such so that we pass the same flags. Otherwise, for instance,
 # `rustc` will complain about missing sanitizer flags causing an ABI mismatch.
 $(obj)/build_error.o: private is-kernel-object := y
-$(obj)/build_error.o: private skip_gendwarfksyms = 1
-$(obj)/build_error.o: $(src)/build_error.rs $(obj)/compiler_builtins.o FORCE
+# Rebuild when the symbol version generation rule changes.
+$(obj)/build_error.o: $(src)/build_error.rs $(obj)/compiler_builtins.o \
+    $(if $(CONFIG_MODVERSIONS),$(src)/Makefile) FORCE
 	+$(call if_changed_rule,rustc_library)
 
 $(obj)/ffi.o: private skip_gendwarfksyms = 1

---
base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
change-id: 20261118-fix-rust-build-error-modversions-4af535edc9b2

Best regards,
--  
Peder Bergan <peder.bergan@gmail.com>


