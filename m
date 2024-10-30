Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABA6217657
	for <linux-modules@vger.kernel.org>; Wed, 30 Oct 2024 23:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730329514; cv=none; b=li6gx78TszsLx1beG5msKwJq7aIj9rG1MOdK+88iHr8RnxcK/5Mwk0cQPnDiXwI76Ucl8a2gPUDpPaHfRafSWGtKOyKmfuz0eMOYqejavV/LNP8+U/7+50VzTrndaN34E5RXBJjPE3LsjUtjFmnTBfCr2W7eiYI27bNoQeZGhAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730329514; c=relaxed/simple;
	bh=wPil2ZePOaGBCbeMdHPmjyhJDTULE3Tr9nw/1oyU7eE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZLHLhRWFDcEDQIE0l5MupsrfyKVMzSEbZYfMmUalYVmNrQUI6qny9uUTmYjhOlb5ldXV3uNrDvmpqmmGqnF9bWBFXxB0Zf+WwmuIVK2hGRQo4xH2/5KwFttD/j2ldxkRCwimSWk/iQm6xTgeC3+nRSe5DAX/aaPeZPVHBc3e0dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZlRl9g0J; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZlRl9g0J"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e36cfed818so4899987b3.3
        for <linux-modules@vger.kernel.org>; Wed, 30 Oct 2024 16:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730329511; x=1730934311; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t+3KnK+Z0gtSs2Co5ku0tpPq/BkCZXZuUXUNlsOrMro=;
        b=ZlRl9g0JflIDAYJCrbZbY3cXotfqjnsL/rv1hF/KgnZQ2IWG6anFfnDMAXvKltGN8K
         /pjFf7CLsuYJU8WuGulJzLF3PRQRIjKiCQwHLfhu2cL+khjDmap9lwJuyzPTPEELTRGg
         WHz0HdORvestpNHGdiUSv1FHrLDeIXD3sCnr1dWqsGXWr/gb7f0oh2wud336iCiaqzUt
         eSKFWX6BUZma3YgdAiJ38ncGpm4i6lKH9yjBvI4GmrVQv0rrGPkaKxa62pcm7PcgkI9a
         XxZxAQwzH1lpuDmGCQ1oD852B3FWSQTmzWcH6FPINNW2R+SsY7KzHrPf3vCvnT0/NCW3
         N+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730329511; x=1730934311;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t+3KnK+Z0gtSs2Co5ku0tpPq/BkCZXZuUXUNlsOrMro=;
        b=BxpLd6DfiEeR9eqFsfbSVt9Lq0QVHOxDpCZO+HDGRuxDOQ60vf70Cvv6DQgKCpHRoE
         Jgw7cFNy1WV55JRBSNGOB/7E8aSkh//o2Hc3zfu+7kzppIjmP650PdapwUn6ZGv+EXAf
         nWPpmyO7L1qqkXZAUvjuIanFmnqmsdpkzCXOBgNyozkmSQZQl9Xjf1+ulfqDqnEZ08/C
         HZ5JVDNDRNMGrjh+x89+dyupQ4cuXVa7fBVJ00poWadbgmuM8YwNrkGZC1QcTJc6/F5Y
         CiD5zZcJsPJNg+ddHDbY3mHg5IjWfpDUuMUEZThBjVepK4AL6j6CyFVIb1I0U8qVylnj
         d8wA==
X-Forwarded-Encrypted: i=1; AJvYcCVhsE5KSpy7y88CyL+uY+iwXCjYagcKNcM6SKDEfqiLZfeEV85CxSBolnHPnZF96Dm5onIl//vhJBOxdtfW@vger.kernel.org
X-Gm-Message-State: AOJu0YyIL+KsJsHSDtyscLNKfZQH0JAe8HV1BoSI4pqiAMzrN6IdWCUd
	77jilIYj03OPDjm2eMDn/Lf5NRNZR9e/NikbWYIRje+PaXlnvf+TOu410V+R411f2w38wwQ8Qqh
	OFkWFvA==
X-Google-Smtp-Source: AGHT+IFXDvQAF6rmmyjqCuHXp7247+2WzHwGzszYhdJsIGiPI6HKKDpKzPTAlySRxwxd3AE241ZoGZd587t3
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a81:d806:0:b0:663:ddc1:eab8 with SMTP id
 00721157ae682-6e9d8b0412emr4041757b3.4.1730329511025; Wed, 30 Oct 2024
 16:05:11 -0700 (PDT)
Date: Wed, 30 Oct 2024 23:05:04 +0000
In-Reply-To: <20241030-extended-modversions-v8-0-93acdef62ce8@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241030-extended-modversions-v8-0-93acdef62ce8@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20241030-extended-modversions-v8-3-93acdef62ce8@google.com>
Subject: [PATCH v8 3/3] rust: Use gendwarfksyms + extended modversions for CONFIG_MODVERSIONS
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
	Trevor Gross <tmgross@umich.edu>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Matthew Maurer <mmaurer@google.com>
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
 rust/Makefile | 33 +++++++++++++++++++++++++++++++--
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index c521e1421ad4abd80080bce8cf1c68389cb65c69..5e6d9868705ece2b2f6b90d7ce197a4d66240b6b 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1946,7 +1946,8 @@ config RUST
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
index b5e0a73b78f3e58fc8fb8c9fab8fb5792406c6d8..0e98590082a1ac88e6ee29c28ce1b1d19982ac10 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -303,10 +303,11 @@ $(obj)/bindings/bindings_helpers_generated.rs: private bindgen_target_extra = ;
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
@@ -378,11 +379,36 @@ ifneq ($(or $(CONFIG_ARM64),$(and $(CONFIG_RISCV),$(CONFIG_64BIT))),)
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
@@ -394,6 +420,7 @@ ifneq ($(or $(CONFIG_X86_64),$(CONFIG_X86_32)),)
 $(obj)/core.o: scripts/target.json
 endif
 
+$(obj)/compiler_builtins.o: private skip_gendwarfksyms = 1
 $(obj)/compiler_builtins.o: private rustc_objcopy = -w -W '__*'
 $(obj)/compiler_builtins.o: $(src)/compiler_builtins.rs $(obj)/core.o FORCE
 	+$(call if_changed_rule,rustc_library)
@@ -404,6 +431,7 @@ $(obj)/alloc.o: private rustc_target_flags = $(alloc-cfgs)
 $(obj)/alloc.o: $(RUST_LIB_SRC)/alloc/src/lib.rs $(obj)/compiler_builtins.o FORCE
 	+$(call if_changed_rule,rustc_library)
 
+$(obj)/build_error.o: private skip_gendwarfksyms = 1
 $(obj)/build_error.o: $(src)/build_error.rs $(obj)/compiler_builtins.o FORCE
 	+$(call if_changed_rule,rustc_library)
 
@@ -413,6 +441,7 @@ $(obj)/bindings.o: $(src)/bindings/lib.rs \
     $(obj)/bindings/bindings_helpers_generated.rs FORCE
 	+$(call if_changed_rule,rustc_library)
 
+$(obj)/uapi.o: private skip_gendwarfksyms = 1
 $(obj)/uapi.o: $(src)/uapi/lib.rs \
     $(obj)/compiler_builtins.o \
     $(obj)/uapi/uapi_generated.rs FORCE

-- 
2.47.0.163.g1226f6d8fa-goog

