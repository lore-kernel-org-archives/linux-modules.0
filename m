Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794485724;
	b=lTZ3IxutFW/b/OBON/kSYk+HY+i2+048aV8zg+s4mqrGQCiLBldqNzfnWCHfYuQrYVdC
	 NzBPjo7Q1xAr0/+q0y/wbTuL+VghG6iB9Lz0aI5+MYgBJRSFfou4GBl2JTgcH8k7wzBSR
	 kG2DVajx5K6jaTdixjvygDF2rNz4nqtJolUR4bLXwW5U+EJjyGm8qTbucEI5cm0DEZ9FI
	 VcuwmsP7QFPA9uYL/ed/eiOSJS5F2x+sp32ZOrUd/VVgfAyIJsZovugfgKfEIt8UT7vQI
	 dEztC8Apt6HJA7rSxTgaWgpPL/kSfPrStBQpNityn8b6tTgXohebU4u4Ve19v9c0EWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794485724;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=45z5YfrL9I48bRl1PrF4Vt8PvNpnRKDiwkVvBZd1m84=;
	b=NfPjcWOGWoyI9ODvoXYy57o3xLefbCpkendNiStmd7ehcmcbSaakv5totETAETBM4v/8
	 aETCdk37tYaxi0r1oUIrsyaJfCNVsejAEymHyDfRWcsaVHCp2t0At4ITDkZBvyoQfCxaj
	 7FozuAWfoMeTIDsi+TsYzDrUC4v8zWS11kMS1dV/FOgBupfglf1opongkBivoxhafvC3q
	 R8Uz/s8YnZy9OfXJDz9sSY74xcAbXg95y92azhJRujADUWmbe8aDVSs3RHSaPcqVwTNGo
	 iAwZlakiSo61Z1ltEMD5aBevO/q0hyQCfgf7iAo97QeA/o5MPpqDBGhMhhvdgfModug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--gprocida.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=X6uVtKQz;
	arc=none smtp.remote-ip=209.85.128.70
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA680606A321
	for <linux-modules@vger.kernel.org>; Thu, 12 Nov 2026 12:15:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA680606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gprocida.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=X6uVtKQz
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a80bd45e1cso23961275e9.3
        for <linux-modules@vger.kernel.org>; Thu, 12 Nov 2026 04:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794485722; x=1795090522; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=45z5YfrL9I48bRl1PrF4Vt8PvNpnRKDiwkVvBZd1m84=;
        b=X6uVtKQzS+1TEA+H1VPRtBhwGUEOnSobHUoaHnDHHAsgGYADbViXWqXwUZOVUNsd/W
         ppWsnVKhWXTlbQjQPtd14r3y0beBTwsWgtSV/E4q48mhImTmnU7LPmYACaEInJXpJBhe
         Fk+edEZhcHms06RcOQ31NssQBGEyYbJoxFEmziQgN2feVogKnYh2gJccjNolvPdt78po
         cOSR2uE1KY5SOnItS0Ldj3ER+YWgPA91pX8sz8PSWG9Sdl/jGyWJu+kGvcn8AWtUMFvx
         AdP6MrhddmRfDqTrPh1+dLV96HYMoqcNyZp+NGSaRvg65VVoxi9mK1YXW5zluSmL2u8p
         OycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794485722; x=1795090522;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=45z5YfrL9I48bRl1PrF4Vt8PvNpnRKDiwkVvBZd1m84=;
        b=sH/xTaoqro9AZFl/8y8nhcPkKV2wxgcpfII0FQpa8YrmXz5BCScETg9vOs9z9exJcr
         OHXralIUkG8Ti8uLXlsXBft/2g9cNibHCiKpxrypM3OCLI85H2ZR7zwfEKAiE7IMw+IB
         rZUcA7Ok0OA8kcjuOhqSBQbRhrBbX4pPMXIR2/Erpb5i1sjmkrSgGu78TtQ5rVaNRG0h
         Xae6Ip1G+EIey23ZdMSpPu/G85i9yNdA50v+FWRXxt7R3HStV1yuU9Cu0efVPCiQO08K
         IgJGLYo9N56aIpaFAgfH9abYQnZOSp1jZY5fUn9Mq2YDNfmf8SHBtnUdtfRr7umRAiuO
         DO0A==
X-Forwarded-Encrypted: i=1; AL+hErF+fzRr6q032j5N9liSkOi2QmHYRrzkQEbPFAyT5FgO+Vb896Io4VRQbuV4WH3NBZsfUDk5j+XpnS0lVOpS@vger.kernel.org
X-Gm-Message-State: APuU4Z8dT+YJ0X946xwDP1bHykKa636vwz4Uh6pjfpowD56IQxqwyy0t
	yeYzex1XAarI965s06+SFpyzSSjciz58q+P10ifbr+swnA8q2JvIYlY060Ko2FgDLpDRMzsSWU4
	1eqO1YJJvbX0TTA==
X-Received: from wmbfc17.prod.google.com ([2002:a05:600c:5251:b0:4a3:5d65:cf26])
 (user=gprocida job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4513:b0:4a1:702f:c736 with SMTP id 5b1f17b1804b1-4ba0931d928mr93908205e9.3.1794485721754;
 Thu, 12 Nov 2026 04:15:21 -0800 (PST)
Date: Thu, 12 Nov 2026 12:15:10 +0000
In-Reply-To: <20261112121512.1670347-1-gprocida@google.com>
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261112121512.1670347-1-gprocida@google.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261112121512.1670347-3-gprocida@google.com>
Subject: [PATCH v5 2/4] rust: convert exports.c to assembly
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

Previously, `rust/exports.c` defined `EXPORT_SYMBOL_RUST_GPL(sym)` with
`extern int sym;` so that it could invoke the C `EXPORT_SYMBOL_GPL(sym)`
macro, which requires `sym` to be a declared C identifier in scope for
`typeof(sym)`, `__ADDRESSABLE(sym)` and `__GENDWARFKSYMS_EXPORT(sym)`.

This caused the C compiler to emit DWARF debug information in
`rust/exports.o` describing every exported Rust and helper symbol,
functions and data alike, as a C `int` variable. Those bogus `int` DWARF
entries ended up in `vmlinux`, conflicting with the true DWARF types
emitted by `rustc` and confusing debuggers and ABI analysis tools.

Convert `rust/exports.c` to `rust/exports.S` and emit
`EXPORT_SYMBOL_GPL(sym)` directly. Under `__ASSEMBLY__`,
`<linux/export.h>` expands `EXPORT_SYMBOL_GPL(sym)` straight to
`___EXPORT_SYMBOL(sym, "GPL", ...)` without requiring symbol
declarations or emitting bogus DWARF entries, while also avoiding a C
compilation step.

Signed-off-by: Giuliano Procida <gprocida@google.com>
---
 rust/Makefile                 |  2 +-
 rust/{exports.c => exports.S} | 12 +++++-------
 2 files changed, 6 insertions(+), 8 deletions(-)
 rename rust/{exports.c => exports.S} (72%)

diff --git a/rust/Makefile b/rust/Makefile
index 0ac9ab28cc2b..2e5f5a84bb24 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -564,7 +564,7 @@ rust_exports = $(NM) -p --defined-only $(1) | awk '$$2~/(T|R|D|B)/ && $$3!~/__(p
 
 quiet_cmd_exports = EXPORTS $@
       cmd_exports = \
-	$(call rust_exports,$<,"EXPORT_SYMBOL_RUST_GPL(%s);\n") > $@
+	$(call rust_exports,$<,"EXPORT_SYMBOL_GPL(%s)\n") > $@
 
 $(obj)/exports_core_generated.h: $(obj)/core.o FORCE
 	$(call if_changed,exports)
diff --git a/rust/exports.c b/rust/exports.S
similarity index 72%
rename from rust/exports.c
rename to rust/exports.S
index 1b52460b0f4e..e1a6923081fa 100644
--- a/rust/exports.c
+++ b/rust/exports.S
@@ -1,11 +1,11 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * A hack to export Rust symbols for loadable modules without having to redo
  * the entire `include/linux/export.h` logic in Rust.
  *
  * This requires Rust's new/future `v0` mangling scheme because the default one
- * ("legacy") uses invalid characters for C identifiers (thus we cannot use the
- * `EXPORT_SYMBOL_*` macros).
+ * ("legacy") uses invalid characters for C identifiers (thus we could not use
+ * the `EXPORT_SYMBOL_*` macros).
  *
  * All symbols are exported as GPL-only to guarantee no GPL-only feature is
  * accidentally exposed.
@@ -13,8 +13,6 @@
 
 #include <linux/export.h>
 
-#define EXPORT_SYMBOL_RUST_GPL(sym) extern int sym; EXPORT_SYMBOL_GPL(sym)
-
 #include "exports_core_generated.h"
 #include "exports_bindings_generated.h"
 #include "exports_kernel_generated.h"
@@ -23,7 +21,7 @@
 #include "exports_helpers_generated.h"
 #endif
 
-// For modules using `rust/build_error.rs`.
+/* For modules using `rust/build_error.rs`. */
 #ifdef CONFIG_RUST_BUILD_ASSERT_ALLOW
-EXPORT_SYMBOL_RUST_GPL(rust_build_error);
+EXPORT_SYMBOL_GPL(rust_build_error)
 #endif
-- 
2.56.0.567.gdb80ae8cd5-goog

