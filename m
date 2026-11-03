Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793710780;
	b=BRYXeG0QbDWhChqzsxBNQPloXyfQXCq8MnsfdgfUvf5YXyYqFUn3XUvnVyo9ZwAFgyPA
	 6co5pQHumfxpm3kMt8ekl4pli02OU3eROyD0AjSSgZAHb06L5V8vtKWd5SJmO/OwCprAF
	 fEDHqL/aqwIGXehQv0ZqPtw63OHpKJKFTtefko4tRV2kaD+ihQeM28d9c8+6gPoHBDf50
	 hov4KoenMq/HbonB07e9L7iaDyGaZ0Ob7FucghcAh5qGANVkTnKWRTKTK1x/qnMQj5Dmc
	 DCi1x1BrLec2I18EXzHxTEFw7kFMgw5r61KCJFA49M4PgBUsgOWe9pJYJYqWjOEgnUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793710780;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=0OkAwpoj4XmAbnVdDSiPSvHVbykMeAdNYanRrxDZkIg=;
	b=fXjCPQ/KukGxuKDZQ9ERMB/iQHwO6Oct8xxl2PoLZq/ovwZ2VfS+V/qxdgXH9ygnCbwU
	 2L3v2ZYwMjottiq2beXs81icxalmwTX9cNxvq+Topn2RUz03qpLZAMkal/F1CsS5K3H85
	 +Xe4fc2gHB7+tnmCW64an14NZTrztWhgm/YWpqi8vTD8xWYnkGd9CzIbxDwkZxxdtAPR6
	 TEbwqNpv0z3+ZMfZ7FHCuQMIhnIJYJU/gfalY5uD/oVSK8RjyfkoCrC+n9Tb/m2EP41il
	 chQlzW3QZmQreu0U99QfJp2Ql4m+Q17kWK8ZhvfbRCWK+yaBt8nCmK13aeM07ILyHxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--gprocida.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fpWT0hvR;
	arc=none smtp.remote-ip=209.85.128.72
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F0F606A327
	for <linux-modules@vger.kernel.org>; Tue,  3 Nov 2026 12:59:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14F0F606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gprocida.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fpWT0hvR
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a77c1cbd15so41730195e9.0
        for <linux-modules@vger.kernel.org>; Tue, 03 Nov 2026 04:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793710778; x=1794315578; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0OkAwpoj4XmAbnVdDSiPSvHVbykMeAdNYanRrxDZkIg=;
        b=fpWT0hvRjhrWm7hy0bKmezROdCag/pslbIGva1h4yEn6LacCRQEi/Q9+Z2LfN4AZvi
         3HMTnXNQYNHw5oND3qAeJWTgDWnrE4DuckpqksSwft44lAPIHKTkz14K/NBCrj14XQqC
         zv6+gUM2lF2COfFIkm7dAsnrLmk22+cjdN1iSLtj9fWNsEj8OFqknZFGCq4f3YWa1lIv
         8eCQ78NlMnkATqGvz3zeDA1KW6Tn4nXBcTKwER+tumsvTVoXhVhy555CShgV1km0KiDw
         Dq5StVr/3xU4qHrBBiYUtvrgX/6qYEVgBGMG1QtcctTl1YfNGxcr4Xi4FTC1YV6QDu6x
         l18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793710778; x=1794315578;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0OkAwpoj4XmAbnVdDSiPSvHVbykMeAdNYanRrxDZkIg=;
        b=CFVntdSQXvvRDwJIHSQxVK6G2cLq/YRghWUmGiHvQRLEBQ0WYwj5takzzFusQKC1Yf
         9R9JTMpwUu/nvxCclyH9gRkgeMrXmz5sWWKJbLrMf0QyFrWYmivWcoDl9aBEHaiAeBJn
         9GtcbxmKerhNZ2z6jX4DEX7ilGCPnyTc6s+WXNw3aV1k5T5i/4CfjBqtEocFSiZ8f/6H
         1cq0CCNvsYK6dAX4XOUxHvkKxfp6pqwI2NsHmL80xh7dUlLT9GWrbo9rUyLswKKk1OY5
         3yrh7+XnDOOukv+yUa1r3/3L/nl68/dC6KqtzyutIwUyKNBBuespQ86BtcGQn22pFR4t
         PW1A==
X-Forwarded-Encrypted: i=1; AKwUvByp4OIpDFcS2O22MeQz887J5lBlzqa8e/xsO9SWcJTcROmcIiUZgNBCuQIJGjXNHOqbdoBCQK0/bvgACztj@vger.kernel.org
X-Gm-Message-State: APuU4Z/9u2OUGzpn2nDN0Mkpzvzeeud4X8DQXXaKBEP0bJJU0O4L3kzR
	ITmFA8PmYhry2MLTzKnTnMC23JhHg6tqEf8OWJbVdUVYY1aF5GZ8fI2zNZCk+ZVzANh9G0MTBq1
	n7rCtuvCRDXMyiw==
X-Received: from wmep9.prod.google.com ([2002:a05:600c:4309:b0:4a2:15e9:5ef1])
 (user=gprocida job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c107:b0:4b1:2026:6b41 with SMTP id 5b1f17b1804b1-4b1202673f8mr93884535e9.30.1793710777894;
 Tue, 03 Nov 2026 04:59:37 -0800 (PST)
Date: Tue,  3 Nov 2026 12:58:13 +0000
In-Reply-To: <20261022134617.228229-1-gprocida@google.com>
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261022134617.228229-1-gprocida@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261103125814.258105-2-gprocida@google.com>
Subject: [PATCH v3 1/2] rust: move EXPORT_SYMBOL_RUST_GPL to include/linux/export.h
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

Move identical definitions of `EXPORT_SYMBOL_RUST_GPL` to
`include/linux/export.h` from:

- `rust/exports.c`
- `drivers/gpu/nova-core/nova_core_exports.c`

Both files already include `<linux/export.h>`.

Update `scripts/misc-check` to recognize `EXPORT_SYMBOL_RUST_GPL()` and
reference it in `nova_core_exports.c`'s header comment so `W=2` builds
do not warn about an unused `<linux/export.h>` include.

Signed-off-by: Giuliano Procida <gprocida@google.com>
---
 drivers/gpu/nova-core/nova_core_exports.c |  5 ++---
 include/linux/export.h                    | 13 +++++++++++++
 rust/exports.c                            | 12 +-----------
 scripts/misc-check                        |  4 ++--
 4 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/nova-core/nova_core_exports.c b/drivers/gpu/nova-core/nova_core_exports.c
index 6e80ca9792ee..51858f376c7b 100644
--- a/drivers/gpu/nova-core/nova_core_exports.c
+++ b/drivers/gpu/nova-core/nova_core_exports.c
@@ -2,7 +2,8 @@
 // SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
 
 /*
- * Exports Rust symbols from the `nova_core` crate for use by dependent modules.
+ * Exports Rust symbols from the `nova_core` crate for use by dependent modules
+ * via `EXPORT_SYMBOL_RUST_GPL()`.
  *
  * This is a workaround until the build system supports Rust cross-module
  * dependencies natively.
@@ -10,6 +11,4 @@
 
 #include <linux/export.h>
 
-#define EXPORT_SYMBOL_RUST_GPL(sym) extern int sym; EXPORT_SYMBOL_GPL(sym)
-
 #include "exports_nova_core_generated.h"
diff --git a/include/linux/export.h b/include/linux/export.h
index a686fd0ba406..4aeb422d86af 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -93,4 +93,17 @@
 
 #define EXPORT_SYMBOL_FOR_MODULES(sym, mods) __EXPORT_SYMBOL(sym, "GPL", "module:" mods)
 
+/*
+ * A hack to export Rust symbols for loadable modules without having to redo
+ * the entire `EXPORT_SYMBOL_GPL` logic in Rust.
+ *
+ * This requires Rust's new/future `v0` mangling scheme because the default one
+ * ("legacy") uses invalid characters for C identifiers (thus we cannot use the
+ * `EXPORT_SYMBOL_*` macros).
+ *
+ * All symbols are exported as GPL-only to guarantee no GPL-only feature is
+ * accidentally exposed.
+ */
+#define EXPORT_SYMBOL_RUST_GPL(sym) extern int sym; EXPORT_SYMBOL_GPL(sym)
+
 #endif /* _LINUX_EXPORT_H */
diff --git a/rust/exports.c b/rust/exports.c
index 1b52460b0f4e..8b2dd4aa1f92 100644
--- a/rust/exports.c
+++ b/rust/exports.c
@@ -1,20 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * A hack to export Rust symbols for loadable modules without having to redo
- * the entire `include/linux/export.h` logic in Rust.
- *
- * This requires Rust's new/future `v0` mangling scheme because the default one
- * ("legacy") uses invalid characters for C identifiers (thus we cannot use the
- * `EXPORT_SYMBOL_*` macros).
- *
- * All symbols are exported as GPL-only to guarantee no GPL-only feature is
- * accidentally exposed.
+ * Export symbols from the `rust/` crates and C helpers for loadable modules.
  */
 
 #include <linux/export.h>
 
-#define EXPORT_SYMBOL_RUST_GPL(sym) extern int sym; EXPORT_SYMBOL_GPL(sym)
-
 #include "exports_core_generated.h"
 #include "exports_bindings_generated.h"
 #include "exports_kernel_generated.h"
diff --git a/scripts/misc-check b/scripts/misc-check
index 40e5a4b01ff4..b39d731cb413 100755
--- a/scripts/misc-check
+++ b/scripts/misc-check
@@ -45,7 +45,7 @@ check_tracked_ignored_files () {
 # does not automatically fix it.
 check_missing_include_linux_export_h () {
 
-	git -C "${srctree:-.}" grep --files-with-matches -E 'EXPORT_SYMBOL((_NS)?(_GPL)?|_FOR_MODULES)\(.*\)' \
+	git -C "${srctree:-.}" grep --files-with-matches -E 'EXPORT_SYMBOL((_RUST)?(_NS)?(_GPL)?|_FOR_MODULES)\(.*\)' \
 	    -- '*.[ch]' :^tools/ :^include/linux/export.h |
 	xargs -r git -C "${srctree:-.}" grep --files-without-match '#include[[:space:]]*<linux/export\.h>' |
 	xargs -r printf "%s: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing\n" >&2
@@ -58,7 +58,7 @@ check_unnecessary_include_linux_export_h () {
 
 	git -C "${srctree:-.}" grep --files-with-matches '#include[[:space:]]*<linux/export\.h>' \
 	    -- '*.[c]' :^tools/ |
-	xargs -r git -C "${srctree:-.}" grep --files-without-match -E 'EXPORT_SYMBOL((_NS)?(_GPL)?|_FOR_MODULES)\(.*\)' |
+	xargs -r git -C "${srctree:-.}" grep --files-without-match -E 'EXPORT_SYMBOL((_RUST)?(_NS)?(_GPL)?|_FOR_MODULES)\(.*\)' |
 	xargs -r printf "%s: warning: EXPORT_SYMBOL() is not used, but #include <linux/export.h> is present\n" >&2
 }
 
-- 
2.56.0.385.gac671c819a-goog

