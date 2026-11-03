Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793725124;
	b=GLNjwPky9ZUkE7n4gtVfk0hCnW3gCnPoIpnaEAz2GYZ5hsezu0RBtkrYMmwqH1jbEi8n
	 TKp6F2T2lYv3l46+sgPacDbr+l654AnDRn5m7Qr0QKGZVI40i48mzMO6afztDoRVMlVx+
	 2KvqREO1Wt+h/IPy7kWofTXFrEMeoR63/2I2ovVuWr7tZG0P3bR4x3rDiCA8RhZRFBnoB
	 smiKhtbM21zuzhGxAaJ9/SGLe8FSK9uQdFssD4lAlcSTz4EntJAFTPgOSaggS7S9dAXbJ
	 mm1pIFIpzYjRxRZzGjj+nk8QV++y8D4IpFgMUOAczMPf/QHM4P5ldJKBD2orpRNRVpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793725124;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=XA8gwtcBTdgYB+sh1p56Z459oRwVTCtDjhOE2Ccb1U8=;
	b=e4PRtVI2E9RezhM5RMKmEbom02KjeW1A3uA8tA59ARlooL2bMcdZVGx/W6SRdJJtvdOv
	 Wt610KOBoPA8zYBoWOKk2ZlsEbhwfG1alYnGPAFFnx7pW3dWbQouzweZRNAh5GdaqejUI
	 B/OP4uSVKsiH7mUF/+4eDBZl5QqPMJyJOofE3OzaHqDsWSa78Ite4rqK1yXhlwtfxKZ6a
	 9xWKjcxX0TlJl+x2PVFZEYVDlya6KOd+DFqtkXdQUrPi9OPatudTZefHGL4h46pO7vXtM
	 niH5lzSumX8XF8Pi7flxwQmpWUKCysCC9ZwplRlfniJwuQheVubOFL7Cnho1c+WOW2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--gprocida.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pB8etkic;
	arc=none smtp.remote-ip=209.85.208.71
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0ABC606A32C
	for <linux-modules@vger.kernel.org>; Tue,  3 Nov 2026 16:58:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0ABC606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gprocida.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pB8etkic
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6b3dc91781fso4096602a12.0
        for <linux-modules@vger.kernel.org>; Tue, 03 Nov 2026 08:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793725122; x=1794329922; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XA8gwtcBTdgYB+sh1p56Z459oRwVTCtDjhOE2Ccb1U8=;
        b=pB8etkicOYe00DZzvop7+bECMfFT4oJ+zMB0lVQp8Z1ANPzDVHcJOjau3Gofrbcfv1
         OLKgLtl6i2hbfKGD+zW6UjtIW+7BvNL6MW8CYC4nch2sndEBEP9WipJg6BifdF7pNQjR
         DFhEyzVMlsiv0C5LsKIxpbyJgELrgdtU5FRKbpajMfEAKWyceUolca8zdp0Trh71T/a7
         WrH85phxF26uAgKazsWjTdCQSS0q9OL39KT1KljyZdE4BcKztjNUTH5EOHMjqgj0iO04
         3UsJN9GQn+w8dESE1mH9A6jw4BgTYX4tWTb7cuKmUrUTooRXbiFbeNYxTDtUIihypahg
         kvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793725122; x=1794329922;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XA8gwtcBTdgYB+sh1p56Z459oRwVTCtDjhOE2Ccb1U8=;
        b=2Xkl7IxeHjoo/EQ0hwGJawtqwkvLuPwOt5VWlTi+Ejc5mCYzfmCV92EflYnOT43U6M
         jn/x05qUsWx6274gYkAJb0s9HtKWCUvl01Wzt/wh8EPzNkBSZG+8xrFhnNi0rurzjYuf
         sF0v/rjDKJZlaygEDDNmGFOsMGsQgZ4HdsccR9/oVsh/Ts8DBfX/FeShR9NBj7dQPxTS
         +s8Nix5Kp2NyavPtptG23kdeX6j+Z3/BFjYrgSl5dLebqPsoazVi1cla/6Fq+NWTmacK
         YTeX5GHbyfuH+FPjXfG7n1I+YLGEmMJBMuHgHfEfXWieqCXLz0Mu3XHsK6Xhx3y1Ne3d
         Pw1w==
X-Forwarded-Encrypted: i=1; AKwUvBx4vLalFER93znwu51DnEmkwLZBU3g+sZ0ZQ9/16gtgzGsbiU1o2ev4EmOtRF/kkbLsrTqUJ8jP/N9EyvcB@vger.kernel.org
X-Gm-Message-State: APuU4Z/O5mk57EyTvqs4GIk/cuR8XIRjW3UPaLYD86NhWKVo4XHu5GBc
	mQbQDkfdh9dW4JHuGV+UQ7nBf4TRSGTxkc8r/e/CFqmtaXVgsrnbQ28HJmxljEXCvKkUPZSY+dj
	8tOve4S3xdesjxw==
X-Received: from edew28-n1.prod.google.com ([2002:a05:6402:a21c:10b0:6b4:ba34:851e])
 (user=gprocida job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:c514:10b0:6b3:c74e:b287 with SMTP id 4fb4d7f45d1cf-6b4d4c70be6mr6988759a12.22.1793725121995;
 Tue, 03 Nov 2026 08:58:41 -0800 (PST)
Date: Tue,  3 Nov 2026 16:58:33 +0000
In-Reply-To: <CAGvU0Hm04LXTywU0eL6KN4=SoOAC+LU3BKqENnLR-WV-sHsuNA@mail.gmail.com>
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <CAGvU0Hm04LXTywU0eL6KN4=SoOAC+LU3BKqENnLR-WV-sHsuNA@mail.gmail.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261103165833.418845-3-gprocida@google.com>
Subject: [PATCH v4 2/2] rust: exports: emit ___EXPORT_SYMBOL without C declarations
From: Giuliano Procida <gprocida@google.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	"=?UTF-8?q?Onur=20=C3=96zkan?=" <work@onurozkan.dev>, linux-modules@vger.kernel.org, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Giuliano Procida <gprocida@google.com>
Content-Type: text/plain; charset="UTF-8"

Define `EXPORT_SYMBOL_RUST_GPL(sym)` using `___EXPORT_SYMBOL` directly:

	asm(__stringify(___EXPORT_SYMBOL(sym, "GPL", "")))

matching the `__ASSEMBLY__` path.

Previously, `EXPORT_SYMBOL_RUST_GPL(sym)` declared `extern int sym;` so
that it could invoke `EXPORT_SYMBOL_GPL(sym)`, which required `sym` to
be a declared C identifier for `typeof(sym)`, `__ADDRESSABLE(sym)`, and
(when `CONFIG_GENDWARFKSYMS` is enabled) `__GENDWARFKSYMS_EXPORT(sym)`.

This resulted in the compiler emitting DWARF debug information in
`rust/exports.o` and `drivers/gpu/nova-core/nova_core_exports.o`
describing every exported Rust symbol, functions and data alike, as a C
`int` variable.

Although `rust/Makefile` sets `skip_gendwarfksyms = 1` on `exports.o`
and `drivers/gpu/Makefile` runs `gendwarfksyms` on `nova_core.o` rather
than `nova_core_exports.o`, the bogus `int` DWARF entries were still
present in `vmlinux` and `nova-core.ko`, where they conflicted with the
true DWARF types emitted by `rustc` and confused DWARF consumers such as
debuggers and ABI analysis tools.

Omitting the C-level wrappers from `__EXPORT_SYMBOL` is safe because:
- `__GENDWARFKSYMS_EXPORT(sym)` is unneeded because `gendwarfksyms` runs
  directly on the defining Rust and helper object files rather than on
  `rust/exports.o` or `nova_core_exports.o`.
- `extern int sym;`, `extern typeof(sym) sym;`, and `__ADDRESSABLE(sym)`
  have no effect in `rust/exports.c` or `nova_core_exports.c`: the
  symbols are already emitted in separate translation units (scraped via
  `nm --defined-only`), the fake `extern int` declaration never produced
  kCFI function type IDs, and `___EXPORT_SYMBOL` already emits a
  `.quad`/`.long` reference to `sym` in `.export_symbol` that satisfies
  both ELF linking and LTO module-asm symbol resolution.
- `DEFAULT_SYMBOL_NAMESPACE`, `__DISABLE_EXPORTS`, and `__GENKSYMS__`
  are not used by `rust/exports.c` or `nova_core_exports.c`.

Signed-off-by: Giuliano Procida <gprocida@google.com>
---
 drivers/gpu/Makefile   | 4 ++--
 include/linux/export.h | 9 +++++----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/Makefile b/drivers/gpu/Makefile
index e372fc02139f..1269ce862ad2 100644
--- a/drivers/gpu/Makefile
+++ b/drivers/gpu/Makefile
@@ -47,8 +47,8 @@ $(obj)/nova-core/nova_core_exports.o: $(obj)/nova-core/exports_nova_core_generat
 CFLAGS_nova-core/nova_core_exports.o := -I $(objtree)/$(obj)/nova-core
 
 ifdef CONFIG_MODVERSIONS
-# The C export shim declares Rust symbols as `extern int`, so reuse its export
-# list but generate symbol CRCs from the Rust object instead of the shim's DWARF.
+# The C export shim has no DWARF type info for Rust symbols, so reuse
+# its export list but generate symbol CRCs from the Rust object.
 $(obj)/nova-core/nova_core_exports.o: private cmd_gensymtypes_c = \
 	$(call getexportsymbols,\1) | \
 	$(objtree)/scripts/gendwarfksyms/gendwarfksyms \
diff --git a/include/linux/export.h b/include/linux/export.h
index 4aeb422d86af..2a0362cc54e1 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -94,16 +94,17 @@
 #define EXPORT_SYMBOL_FOR_MODULES(sym, mods) __EXPORT_SYMBOL(sym, "GPL", "module:" mods)
 
 /*
- * A hack to export Rust symbols for loadable modules without having to redo
- * the entire `EXPORT_SYMBOL_GPL` logic in Rust.
+ * Export Rust symbols for loadable modules without having to redo the entire
+ * `EXPORT_SYMBOL_GPL` logic in Rust.
  *
  * This requires Rust's new/future `v0` mangling scheme because the default one
  * ("legacy") uses invalid characters for C identifiers (thus we cannot use the
  * `EXPORT_SYMBOL_*` macros).
  *
  * All symbols are exported as GPL-only to guarantee no GPL-only feature is
- * accidentally exposed.
+ * accidentally exposed. There is no support for symbol namespaces.
  */
-#define EXPORT_SYMBOL_RUST_GPL(sym) extern int sym; EXPORT_SYMBOL_GPL(sym)
+#define EXPORT_SYMBOL_RUST_GPL(sym)				\
+	asm(__stringify(___EXPORT_SYMBOL(sym, "GPL", "")))
 
 #endif /* _LINUX_EXPORT_H */
-- 
2.56.0.385.gac671c819a-goog

