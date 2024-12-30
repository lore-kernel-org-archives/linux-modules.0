Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D351B040A
	for <linux-modules@vger.kernel.org>; Mon, 30 Dec 2024 22:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735597842; cv=none; b=Nr3LF8erALLlBlAB5E4AbCsYBJ2ou9ocSTnleSt5XlsHHz5rg7bY+PW+RiwdJJlH3ep7hm004f9bAribtqgW24nVzqfC4wd5QCVX3o3A3ST6DlIqwhJ9NpWrDajlkiuDdTUdp4ibSgVags13EIgrxkOGTYcjfz9/dszp1D0iwmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735597842; c=relaxed/simple;
	bh=OfARBdrSO25YJUBOotWgeA+0nMfy8zMZa0sJjFrf0fc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IYBXVT8w69IoLGOSw6MSo4VgF9qKOtLIRNCNS9lDQ2qAac96rr9JzksTdPLob9eHRKUsXsRkSS2XF8xPhBfh1ZBNTM0Zs9gWniZTzLTj8NMP0mXJGm1qmkOjRN4ejca4NSo8klveN+Z6JyVJZ1uoxY9mNeG2xTl6ZtQOnU7+aJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I/ms1JnD; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I/ms1JnD"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ef9204f898so12698041a91.2
        for <linux-modules@vger.kernel.org>; Mon, 30 Dec 2024 14:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735597838; x=1736202638; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NnqTVWJzvIfhKg7Bjweyg4HBEOW+h34t+hptux0JJqo=;
        b=I/ms1JnDgCxUTHXMOhxypcwSvfBkyZNaN44E3JRyDvU+MT6a0GX8LAy2QMtHskDWs9
         cQH5M7oogYdMOaUI2GOZTf7GeL9ST28v+rZ2JJihvhx6JUIdoSgHFRYO7+oJOio7LhzV
         bFybTRYvdSJfgqdH/ElA9cxPXt40/96ebRwiCD9grBk8n1g2/AdWlJezMhgN1nMQ2kOI
         WtSM7zBJ3/4eJB5YHu5LVub6nr4iEu2SR7/qbBHzVQmDCFYcV8vF8LrG5a7xFdlcJcL8
         HqLEPVD0j9H1hAnrBcm1K6QwPtnUTjT0niAqlA9sDcLUy0JwSlfxQOdEkLnKk/DVRaZ/
         JdhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735597838; x=1736202638;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NnqTVWJzvIfhKg7Bjweyg4HBEOW+h34t+hptux0JJqo=;
        b=SrSRb7kGHnKGfYvRY9R0DQPgSKhe24Fw+E7aqcB6CxNhhrGOpa36LjcLhbT5n7qd90
         i+SLrCTRuhp39lxwnBmxc5pnZgL7PH19AiyXN5s/VD0wSzc+/WCdoecWS8RbVvOfoAO2
         knSGjHeCrPrgTSZ/dsTXC0JohnJaSYY5kyYZvNApEIyLpYONeFihN9zDLUQz4oDDXOdQ
         1AgBHzP6yHRqDdJR80K4prSUU1Ed/AOUzDkb5VGfjoBG6crJYsvAyXmDoUi3ipIrrwcs
         +5C5oj8kgNoy9YNlXHRSlMJl4a5V74S2hBJpSZODl23/0FITvfWMCBt8BzPvGRdfft13
         gIdg==
X-Forwarded-Encrypted: i=1; AJvYcCUEFo8BIYKFc9y8BMkn5BQTxc7R4Z/Ruecr79QSe8tb3BU2wgBXsUwb7JDETcEECawExofLSt3dw3GYi8T4@vger.kernel.org
X-Gm-Message-State: AOJu0YzyBclNg2t2UwDBNEmpkREFRJxvjemhMf7cD5Eqfnrn5Sa207p1
	HIzDQgvLWtQdnBGofepx5JzsKZQt4u23G1OB6cN8zHPOqXb1vcYR3bdLASJlF9/boOq9oz/302h
	CofyTpg==
X-Google-Smtp-Source: AGHT+IFMck7sG1YUWeTfEcOH6dNd+wV09AW/dPHDuIx5ugJMQ49LP0NvW7hR4YYpwEjy4ooSIIuNJ8r5Movf
X-Received: from pfbbe16.prod.google.com ([2002:a05:6a00:1f10:b0:724:eefc:69ef])
 (user=mmaurer job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3286:b0:725:b201:2353
 with SMTP id d2e1a72fcca58-72abdec8856mr57170402b3a.13.1735597838524; Mon, 30
 Dec 2024 14:30:38 -0800 (PST)
Date: Mon, 30 Dec 2024 22:30:32 +0000
In-Reply-To: <20241230-extended-modversions-v12-0-296a6a0f5151@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241230-extended-modversions-v12-0-296a6a0f5151@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20241230-extended-modversions-v12-5-296a6a0f5151@google.com>
Subject: [PATCH v12 5/5] rust: Use gendwarfksyms + extended modversions for CONFIG_MODVERSIONS
From: Matthew Maurer <mmaurer@google.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Daniel Gomez <da.gomez@samsung.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Jonathan Corbet <corbet@lwn.net>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, 
	Matthew Maurer <mmaurer@google.com>
Content-Type: text/plain; charset="utf-8"

From: Sami Tolvanen <samitolvanen@google.com>

Previously, two things stopped Rust from using MODVERSIONS:
1. Rust symbols are occasionally too long to be represented in the
   original versions table
2. Rust types cannot be properly hashed by the existing genksyms
   approach because:
	* Looking up type definitions in Rust is more complex than C
	* Type layout is potentially dependent on the compiler in Rust,
	  not just the source type declaration.

CONFIG_EXTENDED_MODVERSIONS addresses the first point, and
CONFIG_GENDWARFKSYMS the second. If Rust wants to use MODVERSIONS, allow
it to do so by selecting both features.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Co-developed-by: Matthew Maurer <mmaurer@google.com>
Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 init/Kconfig  |  3 ++-
 rust/Makefile | 34 ++++++++++++++++++++++++++++++++--
 2 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index c1f9eb3d5f2e892e977ba1425599502dc830f552..b60acfd9431e0ac2bf401ecb6523b5104ad31150 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1959,7 +1959,8 @@ config RUST
 	bool "Rust support"
 	depends on HAVE_RUST
 	depends on RUST_IS_AVAILABLE
-	depends on !MODVERSIONS
+	select EXTENDED_MODVERSIONS if MODVERSIONS
+	depends on !MODVERSIONS || GENDWARFKSYMS
 	depends on !GCC_PLUGIN_RANDSTRUCT
 	depends on !RANDSTRUCT
 	depends on !DEBUG_INFO_BTF || PAHOLE_HAS_LANG_EXCLUDE
diff --git a/rust/Makefile b/rust/Makefile
index a40a3936126d603836e0ec9b42a1285916b60e45..80f970ad81f7989afe5ff2b5f633f50feb7f6006 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -329,10 +329,11 @@ $(obj)/bindings/bindings_helpers_generated.rs: private bindgen_target_extra = ;
 $(obj)/bindings/bindings_helpers_generated.rs: $(src)/helpers/helpers.c FORCE
 	$(call if_changed_dep,bindgen)
 
+rust_exports = $(NM) -p --defined-only $(1) | awk '$$2~/(T|R|D|B)/ && $$3!~/__cfi/ { printf $(2),$(3) }'
+
 quiet_cmd_exports = EXPORTS $@
       cmd_exports = \
-	$(NM) -p --defined-only $< \
-		| awk '$$2~/(T|R|D|B)/ && $$3!~/__cfi/ {printf "EXPORT_SYMBOL_RUST_GPL(%s);\n",$$3}' > $@
+	$(call rust_exports,$<,"EXPORT_SYMBOL_RUST_GPL(%s);\n",$$3) > $@
 
 $(obj)/exports_core_generated.h: $(obj)/core.o FORCE
 	$(call if_changed,exports)
@@ -401,11 +402,36 @@ ifneq ($(or $(CONFIG_ARM64),$(and $(CONFIG_RISCV),$(CONFIG_64BIT))),)
 		__ashlti3 __lshrti3
 endif
 
+ifdef CONFIG_MODVERSIONS
+cmd_gendwarfksyms = $(if $(skip_gendwarfksyms),, \
+	$(call rust_exports,$@,"%s\n",$$3) | \
+	scripts/gendwarfksyms/gendwarfksyms \
+		$(if $(KBUILD_GENDWARFKSYMS_STABLE), --stable) \
+		$(if $(KBUILD_SYMTYPES), --symtypes $(@:.o=.symtypes),) \
+		$@ >> $(dot-target).cmd)
+endif
+
 define rule_rustc_library
 	$(call cmd_and_fixdep,rustc_library)
 	$(call cmd,gen_objtooldep)
+	$(call cmd,gendwarfksyms)
 endef
 
+define rule_rust_cc_library
+	$(call if_changed_rule,cc_o_c)
+	$(call cmd,force_checksrc)
+	$(call cmd,gendwarfksyms)
+endef
+
+# helpers.o uses the same export mechanism as Rust libraries, so ensure symbol
+# versions are calculated for the helpers too.
+$(obj)/helpers/helpers.o: $(src)/helpers/helpers.c $(recordmcount_source) FORCE
+	+$(call if_changed_rule,rust_cc_library)
+
+# Disable symbol versioning for exports.o to avoid conflicts with the actual
+# symbol versions generated from Rust objects.
+$(obj)/exports.o: private skip_gendwarfksyms = 1
+
 $(obj)/core.o: private skip_clippy = 1
 $(obj)/core.o: private skip_flags = -Wunreachable_pub
 $(obj)/core.o: private rustc_objcopy = $(foreach sym,$(redirect-intrinsics),--redefine-sym $(sym)=__rust$(sym))
@@ -417,13 +443,16 @@ ifneq ($(or $(CONFIG_X86_64),$(CONFIG_X86_32)),)
 $(obj)/core.o: scripts/target.json
 endif
 
+$(obj)/compiler_builtins.o: private skip_gendwarfksyms = 1
 $(obj)/compiler_builtins.o: private rustc_objcopy = -w -W '__*'
 $(obj)/compiler_builtins.o: $(src)/compiler_builtins.rs $(obj)/core.o FORCE
 	+$(call if_changed_rule,rustc_library)
 
+$(obj)/build_error.o: private skip_gendwarfksyms = 1
 $(obj)/build_error.o: $(src)/build_error.rs $(obj)/compiler_builtins.o FORCE
 	+$(call if_changed_rule,rustc_library)
 
+$(obj)/ffi.o: private skip_gendwarfksyms = 1
 $(obj)/ffi.o: $(src)/ffi.rs $(obj)/compiler_builtins.o FORCE
 	+$(call if_changed_rule,rustc_library)
 
@@ -435,6 +464,7 @@ $(obj)/bindings.o: $(src)/bindings/lib.rs \
 	+$(call if_changed_rule,rustc_library)
 
 $(obj)/uapi.o: private rustc_target_flags = --extern ffi
+$(obj)/uapi.o: private skip_gendwarfksyms = 1
 $(obj)/uapi.o: $(src)/uapi/lib.rs \
     $(obj)/ffi.o \
     $(obj)/uapi/uapi_generated.rs FORCE

-- 
2.47.1.613.gc27f4b7a9f-goog

