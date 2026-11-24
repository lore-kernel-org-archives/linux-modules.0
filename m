Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795522889;
	b=hP05n8brB7zg23FbPTJMFV019yYHyWOYsmZRd5errTj//morC4XOh2BN56CVl/xJgFD5
	 UN66jJGw/0kQlCo4ZyjrBF2g9pYmcxu3qsCeMCWFEEZIFBrGiFFL+zBUA15Y1YzrrkpTm
	 tlw1HPZidcrG8ak4RL9eCTXi5Zlp4tbITSuy+LL9pCMyehGve5NaU5JYfvA5nOIiEcTrZ
	 FxChEQbPoZE+ZBLt3ih7MWvYB4ABcWGvMWCey0rVZFT0sfoF/iTuK5PFONDI5HV/updZc
	 rzOUpsf+GEzhwYS9ba2CTe6Sd3lJ1RfLoleasMQENoHaxSuyTFi2vqf+KH0aX8Zoyiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795522889;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=BjOfKecaDq8wEAUnqGtB4mDYnoTQs3eK3b1SK9f2Fkc=;
	b=irHt7Ph5kGWEmqTTNGG63hV06Xl12RBs4Sf1jaquFsd4s7pOxcea95aPwlJviLusc82X
	 U3MkEOV/01TDJxUtAAFvo08MTrCj3q4srfto6t+D5StHKC0DS539X9iNCaQOxK/MVeqeB
	 aqXucKqWbbYu0ZxM2JAxVI1OP6rnMDTh5h2yX0V7kzHpavlIgirWiDwxYh2XupLf3ZGaX
	 L/PN8go7S+a9yioZV2Fqnmrkk7vlMbHqBr817RocTSWyVKB1Rg9PGFPep+uqiMG1khR4a
	 BHzx+zkHIOhQodhFFnSwT+ua8nBCmKOd3119bIMTlcjrntcJDDRga8/4GOagOMGDgCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BMmMyyh5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A675D606A321;
	Tue, 24 Nov 2026 12:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BMmMyyh5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A481F000D3;
	Tue, 24 Nov 2026 12:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795522889;
	bh=BjOfKecaDq8wEAUnqGtB4mDYnoTQs3eK3b1SK9f2Fkc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=BMmMyyh5vtow9S1jYfDwbpA0eMmnBQzOfG0MbJ0vt9M6kNQ4MD7oYd7rY16GfUtML
	 3eDUH0BzZutKl+YiJj3IW7tRZLCtCrVksyJLL6+gVJ9QFir2dKsbqUrORGyTr1bVmY
	 BrloULFanvL7yq+4HvVS9IAMpFVPV5WmPGzcadbv0YBuoPl6yfBfZyh5ullUuVK7t0
	 Pp9b3Ifvsk0ScEoTSsAS5ygAkSoNtGXKppXQwbqP1AXozUUHpv2IMq+82w+bFky01a
	 5jEcgK1UhFpskGHbgSLLTfqyeZflOEfi5x5i+GB/rd2Dgq9aSeiTX3iLV7i0WJvcPv
	 EPx/pMF53lmow==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Tue, 24 Nov 2026 12:20:17 +0000
Subject: [PATCH v6 7/7] kbuild: build rust crates in parallel with the rest
 of the build
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-build-speedup-v6-7-141a4f861c67@kernel.org>
References: <20261124-build-speedup-v6-0-141a4f861c67@kernel.org>
In-Reply-To: <20261124-build-speedup-v6-0-141a4f861c67@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Nicolas Schier <n.schier@fritz.com>, Kees Cook <kees@kernel.org>
Cc: ljs@kernel.org, linux-kbuild@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 linux-m68k@lists.linux-m68k.org, linux-modules@vger.kernel.org, 
 rust-for-linux@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4608; i=ljs@kernel.org;
 h=from:subject:message-id; bh=5MzJBqb7zsETYjPaIMd7AEqIq2d58l2NTrQXEnXTB9k=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLJZG/7XLrlpGcg37S7/5NiXDgdTX8Qm8jKkqjrxLX2yp
 6DDYdmPjlIWBjEuBlkxRZbnX8T3B4mEzeu84O8GM4eVCWQIAxenAEzEkZOR4YeJSX5O5oV/DktF
 94rXx3hcYRHX+sgZuZQncfO/RTtnczL8lQp+fyajUCrUUN/bX2Pdtu7/G42sLKdnLwj5pyNgbhv
 EBQA=
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

When CONFIG_RUST is specified make prepare builds all of the rust
components before descending into the tree.

This means nothing can be done until all of these are compiled, resulting
in a stall at the start of every clean CONFIG_RUST build.

This also implicitly slows down every rust-capable LLVM allmodconfig build
as this enables the CONFIG_RUST option.

Fix this by allowing rust crates to be built alongside the C code.

Remove the rust build from the make prepare step, then establish a
dependency between rust code located elsewhere in the tree upon rust
components contained in rust/.

Do this by establishing a top-level list of directories containing rust
code, KBUILD_RUST_DIRS, upon which the dependency is expressed.

Finally, ensure that no rust code is located elsewhere and fail the build
if any is found to ensure that nothing is missed in future.

Care is taken to ensure the rust/ dependency is also established for any
module being built to account for external rust modules which rely upon it,
and that only one rust/ build will be performed at any one time.

External rust modules builds are unaffected - make modules_prepare ...
(where ... are other goals) will build rust/ first.

The rustdoc and rusttest goals invoke rust/ directly rather than via
Kbuild, so build rust/ first there too.

Every Rust and C object was confirmed to be byte-for-byte identical after
this change.

Whole build, 128-thread Threadripper 9980X, best of N runs:

                                         before   after     delta
                                         -------------------------------
  x86 defconfig+RUST, clean                36.5s    32.6s     -3.9s (-11%)
  x86 allmodconfig, clean                 297.0s   278.3s    -18.7s (-6%)

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 Kbuild                 |  5 +++++
 Makefile               | 17 ++++++++++++++++-
 scripts/Makefile.build |  5 ++++-
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/Kbuild b/Kbuild
index a6a0192dea08..9670556059dd 100644
--- a/Kbuild
+++ b/Kbuild
@@ -115,3 +115,8 @@ obj-$(CONFIG_NET)	+= net/
 obj-y			+= virt/
 obj-y			+= $(ARCH_DRIVERS)
 obj-$(CONFIG_DRM_HEADER_TEST)	+= include/
+
+# Rust code elsewhere in the tree depends upon rust/.
+ifdef CONFIG_RUST
+$(KBUILD_RUST_DIRS): | rust
+endif
diff --git a/Makefile b/Makefile
index b41f613e42e4..879d124e1f69 100644
--- a/Makefile
+++ b/Makefile
@@ -1416,11 +1416,14 @@ prepare0: archprepare
 	$(Q)$(MAKE) $(build)=. prepare
 	$(Q)$(MAKE) $(build)=scripts/mod
 
+ifdef CONFIG_RUST
+export KBUILD_RUST_DIRS := drivers lib mm samples
+endif
+
 # All the preparing..
 prepare: prepare0
 ifdef CONFIG_RUST
 	+$(Q)$(CONFIG_SHELL) $(srctree)/scripts/rust_is_available.sh
-	$(Q)$(MAKE) $(build)=rust
 endif
 
 PHONY += remove-stale-files
@@ -1767,6 +1770,14 @@ modules: modules_prepare
 # Target to prepare building external modules
 modules_prepare: prepare
 	$(Q)$(MAKE) $(build)=scripts scripts/module.lds
+ifdef CONFIG_RUST
+# Avoid two instances of rust/ being built at any one time.
+ifneq ($(filter modules_prepare,$(MAKECMDGOALS)),)
+ifeq ($(filter all vmlinux modules %Image% dtbs rustdoc rusttest,$(MAKECMDGOALS)),)
+	$(Q)$(MAKE) $(build)=rust
+endif
+endif
+endif
 
 endif # CONFIG_MODULES
 
@@ -2035,13 +2046,17 @@ rustavailable:
 # Documentation target
 #
 # Using the singular to avoid running afoul of `no-dot-config-targets`.
+#
+# rust/ is built alongside the rest of the tree, so must be built first here.
 PHONY += rustdoc
 rustdoc: prepare
+	$(Q)$(MAKE) $(build)=rust
 	$(Q)$(MAKE) $(build)=rust $@
 
 # Testing target
 PHONY += rusttest
 rusttest: prepare
+	$(Q)$(MAKE) $(build)=rust
 	$(Q)$(MAKE) $(build)=rust $@
 
 # Formatting targets
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 7b652f169a8f..ec4e220d6831 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -381,8 +381,11 @@ quiet_cmd_rustc_o_rs = $(RUSTC_OR_CLIPPY_QUIET) $(quiet_modtag) $@
 		$(cmd_ld_single)) \
 	$(cmd_objtool)
 
+rust-dir-ok = $(or $(KBUILD_EXTMOD),$(filter rust $(KBUILD_RUST_DIRS),$(firstword $(subst /, ,$@))))
+
+# Ensure that any rust code located elsewhere from rust/ is listed in KBUILD_RUST_DIRS.
 define rule_rustc_o_rs
-	$(call cmd_and_fixdep,rustc_o_rs)
+	$(if $(rust-dir-ok),,$(error $@: Rust code in a directory not listed in KBUILD_RUST_DIRS, see the top Makefile))$(call cmd_and_fixdep,rustc_o_rs)
 	$(call cmd,gen_objtooldep)
 endef
 

-- 
2.56.1

