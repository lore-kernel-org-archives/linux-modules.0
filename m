Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795430829;
	b=qBmSB1HlWCKhq39gqX9Mb4sT+fzlIbl35v+hhwA8CQvogLkmx+ogr9ViW0FPVoJqx9EG
	 sFocpOop844XxFhLYg5+zz2/tpCLl1CQVFTyIWbl/fy+Y7HL8khdNJZM9vDchxj/vgxy+
	 KCm0fEsANEY+M3azBU3PL4pgHx7Utmz4izBNx11BXmFxNGHkecoAXNxYXCoFyehaadgo1
	 Ew+MnRAQPfHGynHLszFv0Rlzhn6S29m2/t8T5V5nSBupYUJua1zcPG+qbMY3Qx/7JrN5M
	 A2TNVuKDIZg2137qBmodxQSxgz5XR9Gw1K9Feck3BdqayK3LVMOsMKrrc4BN9deCBnA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795430829;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=lJTNJvK/vFyDGMC4BFIud7Ij0yzJ3uEUnuTL/MBh418=;
	b=Lz5ldXnrf1d0Rd7CewVi6J/fZPUBGyldWNflCZOr/DSaIIeDbxBLgYCUwkPDqkv2kj7t
	 wmeAB6WWEOaNw/SQEwmNqueSb1ID40sPimlc4XxXqfxrJYwpWnLvxpgMpZFXDd4RtHreZ
	 A3jOXN5ICtPHHd/l1+iTEf53nLV+JmOhnoboMKmMgpwfesxgNNbjYVW9wiZZwanf1z/TW
	 5KAjG6hPJaDYp5jOqiPmD6suBgx4Vl/fiLogDZMqJZ7wIcWcknJhur/guZXR43TL5Ax/3
	 8Shb0LsW2hXpUJM0Bmx0OKjuc+uNSKMZInmG6IUSAh6172RmPa8JxzzMeOZ5KJWHiUQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iicDxWmx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40B9606A31A;
	Mon, 23 Nov 2026 10:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iicDxWmx
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795430829;
	b=vfUW8StOGUneAjYjMNtnjbWTUPyJNQRH9cHqN4GPtnfbyNvnUsr2YZwqzpffdneMvyJV
	 p43gEjfE9chlxjUvHyUBF8fR0mGc1axnAl1/+jXrMKvz56JKUEaVFwwiTjb9Q9SA1ysww
	 qNUMkwz/bEjgxZiSpGauZImt7bwwp87j12OWj6vWE32l0FrgS1hTaJdLLl8n8LnKdrxPd
	 KTcfxapa8FxkUQ2DqNpcETdr9PSTt9FcxZAxpilYi4j8gwgAcDDTPaYHPIR8fVKD4G33q
	 v9X61MKXcDuWxEb23Q9srTs9AdUFcTkhny2iQbwLVA1GTNp7W6eZWNp5jeg1vL0YIRQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795430829;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=lJTNJvK/vFyDGMC4BFIud7Ij0yzJ3uEUnuTL/MBh418=;
	b=qzcqVeGk8cj73swTK5RhHPHSTkpFUaCsyyiw9VAgkHvqIJLAxBtroCdFzH9Y36C6mL2i
	 6D0rG+n/cZIqZrJVkUwv6Y89oAZwqW/w9nMfXQ/JZGOm/YcAwZBfdvLXndDke3HLVKWac
	 4NV5DPmZoh3G2h3EhUMOu9jNJC0u2XrAN2ljjxfobM2UOZULyEmi40vMHMb+ejjtiQXe2
	 +l7aro1bWM8FsDOwT9Br2k6chQdkQsOkq+/xEhnMPEfPMocni69Zg324AQSRUIa/y1jns
	 4Fy3A+EUsz3pvAw9E2XB5Y4ssC/CQLWUFll0OTeYAcNoOX+u832EGAHSCdU9Zd1UZQg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 993371F000C0;
	Mon, 23 Nov 2026 10:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795430829;
	bh=lJTNJvK/vFyDGMC4BFIud7Ij0yzJ3uEUnuTL/MBh418=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=iicDxWmxS0Wd7KWS36yTRzZAZVxdqoK0Ve6dlzrBNlvx4/TWZxrz80RLDtgBUFuSa
	 50VP9yQgKuQcU8DAw8dAzaWBExZpFehlO3ePkWNu8CGiFqrSJfcNGGMetkUCnja3AY
	 6Ju6Ga/BK0CN6YzMKWKwXTXVWhfMSlwrnY90HowDQBXAcr+I+xSV+/68TbrIBzALlF
	 iprn42nQt0YDQ9vJhTr2JTuf+ilLHj5Pmyx/ncQ2DJ76qf4Ev6MBQCve4Jz0CQFhsn
	 2vyOif91X+us+dsBKgEW9cLSnAmpx0b51hwgQcZH3QSmvDP5kpVKt06aYmI6RWo3fm
	 rQ03ZoXLEmw4Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 276D94C423;
	Mon, 23 Nov 2026 10:47:03 +0000 (UTC)
From: Peder Bergan via B4 Relay <devnull+peder.bergan.gmail.com@kernel.org>
Date: Mon, 23 Nov 2026 11:46:58 +0100
Subject: [PATCH v3] rust: put C helper exports in a dedicated namespace
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
Message-Id: <20261123-rust-helper-namespace-v3-1-b83e2923324b@gmail.com>
X-B4-Tracking: v=1; b=H4sIAKEZBGsC/42QwW6FIBBFf8WwLq8CAmqa5v1H0wXgoDQqFtS0e
 Xn/XtCkadJFm1ndydyTO/eGIgQHEbXFDQXYXXR+ToI9FMgMau4Buy5pREsqCKElDltc8QDjAgH
 PaoK4KAOYS6gNkwCysyh5lwDWfRzcl9dTx02/gVkzLF9oFQHroGYz5FXGPv7CJluA95jvBxdXH
 z6PoDvJ3L8y7QQTzHSjSs45s1Zc+0m58WL8hHKmnf6LQhOFVIxwwWvLG/hJuZ+vpYxbam49/0X
 JGtXRXFs8nXhC03BCL0TIklUyMfsleOM6de2970fIwOfvYpKY3NoWWqjGKlYZqEgtjRZNxwyva
 1Vpba1hxADvdG1TlPsXEvqpwswBAAA=
X-Change-ID: 20261120-rust-helper-namespace-57e8c37ee7df
To: Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nicolas Schier <nsc@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>, rust-for-linux@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Wedson Almeida Filho <wedsonaf@gmail.com>, 
 Giuliano Procida <gprocida@google.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795430822; l=7943;
 i=peder.bergan@gmail.com; s=kernel-contributions;
 h=from:subject:message-id;
 bh=nZ0NjEBZ990zQIlXVxBFgN/g8WkVDdpgNRTJN2ixXEs=;
 b=9ix/Ys9EtXKgSNM40MJy7DNpB9HTMGLqhOxzyrbpi3OU/QRslYPIvbIAxDAhi6F3vE+Y/8jAY
 FYxK3s4dpWGBVibSQd9+uOugPX/dahWNWSXQ+a3yUyQbrqbMPWV0Bc3
X-Developer-Key: i=peder.bergan@gmail.com; a=ed25519;
 pk=39790pn1YZCulHBoUG1uiQI1Hm01EvhBEa2zVrS/yN0=
X-Endpoint-Received: by B4 Relay for
 peder.bergan@gmail.com/kernel-contributions with auth_id=1395
X-Original-From: Peder Bergan <peder.bergan@gmail.com>
Reply-To: peder.bergan@gmail.com
Content-Transfer-Encoding: 7bit

From: Peder Bergan <peder.bergan@gmail.com>

The rust_helper_ prefix marks these C wrappers as Rust implementation
details. Export them in RUST_HELPERS so modpost can detect accidental
dependencies at build time.

Rust generics and inlining can introduce calls through ordinary Rust
abstractions. Have Kbuild mark modular Rust objects when the helpers
are out of line. The marker survives composite module linking and is
discarded at the final link.

When an eligible module uses an export from RUST_HELPERS provided by
vmlinux, have modpost generate the import unless the module already
declares it. This covers mixed-language modules such as kasan_test,
whose module metadata comes from C.

Suggested-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/216
Signed-off-by: Peder Bergan <peder.bergan@gmail.com>
---
This patch applies on top of Giuliano Procida's v5 series converting
the Rust exports to assembly.
https://lore.kernel.org/rust-for-linux/20261112121512.1670347-1-gprocida@google.com/

In a strict x86-64 build with DWARF-based module versioning, I
verified that modpost generated the import for modular KASAN and the
Rust samples that reference helpers. I also confirmed that modpost
rejects an external C-only module that uses a helper without
importing RUST_HELPERS.

OpenAI Codex assisted with coding, the commit message and build validation.
---
Changes in v3:
- Generate the namespace exports on top of the assembly conversion.
- Use simply expanded Make assignments for the literal export formats.
- Generate imports in modpost for modules with Rust objects that use
  the helpers. Drop the module! and KASAN-specific imports.
- Link to v2: https://patch.msgid.link/20261120-rust-helper-namespace-v2-1-14315658f59e@gmail.com
---
 rust/Makefile          |  5 ++++-
 scripts/Makefile.build |  4 +++-
 scripts/mod/modpost.c  | 20 ++++++++++++++++----
 scripts/mod/modpost.h  |  3 +++
 4 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/rust/Makefile b/rust/Makefile
index db1690c87e9b0..a6fce0d830ba4 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -569,9 +569,10 @@ $(obj)/helpers/helpers.bc $(obj)/helpers/helpers_module.bc: $(src)/helpers/helpe
 
 rust_exports = $(NM) -p --defined-only $(1) | awk '$$2~/(T|R|D|B)/ && $$3!~/__(pfx|cfi|odr_asan)/ { printf $(2),$$3 }'
 
+rust_export_format := "EXPORT_SYMBOL_GPL(%s)\n"
 quiet_cmd_exports = EXPORTS $@
       cmd_exports = \
-	$(call rust_exports,$<,"EXPORT_SYMBOL_GPL(%s)\n") > $@
+	$(call rust_exports,$<,$(rust_export_format)) > $@
 
 $(obj)/exports_core_generated.h: $(obj)/core.o FORCE
 	$(call if_changed,exports)
@@ -585,6 +586,8 @@ $(obj)/exports_core_generated.h: $(obj)/core.o FORCE
 # function either. Therefore, we export all symbols from helpers and bindings.
 # In the future, this may be revisited to reduce the number of exports after
 # the compiler is informed about the places codegen is required.
+$(obj)/exports_helpers_generated.h: private rust_export_format := \
+	"EXPORT_SYMBOL_NS_GPL(%s, \"RUST_HELPERS\")\n"
 $(obj)/exports_helpers_generated.h: $(obj)/helpers/helpers.o FORCE
 	$(call if_changed,exports)
 
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 873a9ed62a181..d9c49e0ce8a4e 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -364,13 +364,15 @@ rust_common_cmd = \
 # i.e. the outputs we would get for the different single targets (e.g. `.ll`)
 # would not match each other.
 
+# Mark modular Rust objects so modpost can identify them after a composite link.
 quiet_cmd_rustc_o_rs = $(RUSTC_OR_CLIPPY_QUIET) $(quiet_modtag) $@
       cmd_rustc_o_rs = $(rust_common_cmd) --emit=$(if $(CONFIG_RUST_INLINE_HELPERS),llvm-bc=$(patsubst %.o,%.bc,$@),obj=$@) $< \
 	$(if $(CONFIG_RUST_INLINE_HELPERS),;$(LLVM_LINK) --internalize --suppress-warnings $(patsubst %.o,%.bc,$@) \
 		$(objtree)/rust/helpers/helpers$(if $(part-of-module),_module).bc -o $(patsubst %.o,%.m.bc,$@); \
 		$(CC) $(CLANG_FLAGS) $(filter-out $(CC_FLAGS_LTO),$(KBUILD_CFLAGS)) \
 		$(CC_FLAGS_RUST_INLINE_HELPERS) -Wno-override-module -c $(patsubst %.o,%.m.bc,$@) -o $@ \
-		$(cmd_ld_single)) \
+		$(cmd_ld_single), \
+		$(if $(part-of-module),; $(OBJCOPY) --add-section .discard.rust_helpers=/dev/null $@)) \
 	$(cmd_objtool)
 
 define rule_rustc_o_rs
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 75374c64b8cc7..209a33e9ec8f9 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -29,6 +29,7 @@
 #include "../../include/linux/license.h"
 
 #define MODULE_NS_PREFIX "module:"
+#define RUST_HELPERS_NAMESPACE "RUST_HELPERS"
 
 static bool module_enabled;
 /* Are we using CONFIG_MODVERSIONS? */
@@ -534,6 +535,8 @@ static int parse_elf(struct elf_info *info, const char *filename)
 		} else if (!strcmp(secname, ".no_trim_symbol")) {
 			info->no_trim_symbol = (void *)hdr + sechdrs[i].sh_offset;
 			info->no_trim_symbol_len = sechdrs[i].sh_size;
+		} else if (!strcmp(secname, ".discard.rust_helpers")) {
+			info->has_rust_object = true;
 		}
 
 		if (sechdrs[i].sh_type == SHT_SYMTAB) {
@@ -1617,6 +1620,7 @@ static void read_symbols(const char *modname)
 	}
 
 	if (!mod->is_vmlinux) {
+		mod->has_rust_object = info.has_rust_object;
 		license = get_modinfo(&info, "license");
 		if (!license)
 			mod_error(mod, "missing MODULE_LICENSE()\n");
@@ -1797,10 +1801,15 @@ static void check_exports(struct module *mod)
 
 		if (!verify_module_namespace(exp->namespace, basename) &&
 		    !contains_namespace(&mod->imported_namespaces, exp->namespace)) {
-			modpost_log(!allow_missing_ns_imports, mod,
-				    "module uses symbol '%s' from namespace '%s', but does not import it.\n",
-				    exp->name, exp->namespace);
-			add_namespace(&mod->missing_namespaces, exp->namespace);
+			if (mod->has_rust_object && exp->module->is_vmlinux &&
+			    !strcmp(exp->namespace, RUST_HELPERS_NAMESPACE)) {
+				mod->add_rust_helpers_import = true;
+			} else {
+				modpost_log(!allow_missing_ns_imports, mod,
+					    "module uses symbol '%s' from namespace '%s', but does not import it.\n",
+					    exp->name, exp->namespace);
+				add_namespace(&mod->missing_namespaces, exp->namespace);
+			}
 		}
 
 		if (!mod->is_gpl_compatible && exp->is_gpl_only)
@@ -2143,6 +2152,9 @@ static void write_mod_c_file(struct module *mod)
 	add_extended_versions(&buf, mod);
 	add_depends(&buf, mod);
 
+	if (mod->add_rust_helpers_import)
+		buf_printf(&buf, "\nMODULE_IMPORT_NS(\"%s\");\n", RUST_HELPERS_NAMESPACE);
+
 	buf_printf(&buf, "\n");
 	list_for_each_entry_safe(alias, next, &mod->aliases, node) {
 		buf_printf(&buf, "MODULE_ALIAS(\"%s\");\n", alias->str);
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index 666beca685e48..58709cdd6ff25 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -126,6 +126,8 @@ struct module {
 	bool seen;
 	bool has_init;
 	bool has_cleanup;
+	bool has_rust_object;
+	bool add_rust_helpers_import;
 	char	     srcversion[25];
 	// Missing namespace dependencies
 	struct list_head missing_namespaces;
@@ -149,6 +151,7 @@ struct elf_info {
 	unsigned int modinfo_len;
 	char         *no_trim_symbol;
 	unsigned int no_trim_symbol_len;
+	bool has_rust_object;
 
 	/* support for 32bit section numbers */
 

---
base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
change-id: 20261120-rust-helper-namespace-57e8c37ee7df
prerequisite-message-id: <20261112121512.1670347-1-gprocida@google.com>
prerequisite-patch-id: 7b267dee3ce26971877fd38d926d288ec5ebceea
prerequisite-patch-id: 803b08369cbc3be752a8173381f29272b02a52d5
prerequisite-patch-id: e3377b86c82f833182ad5e9aff7c1a32c889ed50
prerequisite-patch-id: 9ada5f687d87e2cbbe26870986d94afeef7dcc10

Best regards,
--  
Peder Bergan <peder.bergan@gmail.com>


