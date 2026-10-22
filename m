Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792676786;
	b=IALkRtB21iMC0D10AMntHEAO9XshGs7DiNK4DzMXq13Snabnid8OgpVALew4PUznUJ6d
	 VRp4e7sPg8KZesDkhWd/ASjeenZdH+StBa80hoDqYlnQ5FA+N2bwHaRbY/x1SR4/U0ide
	 dafnscxqA/Px8/VEnUn9P0eMFn3+MEF4AxHk5c+YHQcn7PM6vQnNpFDYLeDrJQF0NKbLs
	 5EXjhIVHI3ggKhuYlTk5hW8NE76ZSgsVKxnxIWAoGW9jeMsz3P/2unog27UsBLzOJMdho
	 41/XXhBuKOLQujuVqxcvplU/YbBQDSWkLJ2Id7Jyr8dNSzXfiuJq4Ih04faiKxNv5rA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792676786;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=11ggokIMRypuUy0ebBD2Pma9Z5eDvf39juHTVgfmHlI=;
	b=c+OPfHCDKWdfxcxk42PxzqZ29clKFOBmwezKLddHQHGJqNAXQkGGb+xdZG4chB25neKy
	 kd9k4OHCRlXzNnUtVH+eqsOO2oSwWHGpuYAPf+wSHGAHQq63ffuMTh9a5gPfj4coTtCWM
	 GD/dIOKgmLrOtfiHUewsQb8vu+pUF+fqzZScFB1MpvnHtW3QEAEWfNWi0HrPQv0E7H8AB
	 pJHoRpKuypjK/YCuA+zTd+nYI1Bl05/OoWADrT3Rs/y+r0xEx1xDFb0LqbnuAHw8c9U4l
	 xOJmZ5+MyliHZk/hs2gQrsdHdmTFO0U53brDrJiUDd3m3c8m6W3SYn9CGF/8MG0a6jA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--gprocida.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=UY8anVZf;
	arc=none smtp.remote-ip=209.85.128.70
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA50560A6F6C
	for <linux-modules@vger.kernel.org>; Thu, 22 Oct 2026 13:46:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA50560A6F6C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gprocida.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=UY8anVZf
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a020cf06c3so10972415e9.3
        for <linux-modules@vger.kernel.org>; Thu, 22 Oct 2026 06:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792676784; x=1793281584; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=11ggokIMRypuUy0ebBD2Pma9Z5eDvf39juHTVgfmHlI=;
        b=UY8anVZfeba1Oa4XnqIXAtgHOHRwK697WtxnMGwpzGMtB9ehDQL3++wnOCCRbguj/E
         45u97155oBH1P84DgHy1y1go+UYUX9luJ9WDIXlZ0UthCHA3cp1CZfJ3JoJsRioV6w7S
         sv7VQJn9uUelOf4WDLI/beYUon2jMjwE7Q9a1ZRW++BH/DIPfs/Cxzak4iO1ixywJKjB
         r229wCcirlpnnTInw3+u/ap6ILAKAtVeZC3ePFnilm2xMWV7HRQMn8wMGxIu0dPailAr
         PjBZuCxDqA3pqITrUuGLkPst+ws8ULDD3iSWWdbMXRNppIFg6lkw4iNULKDeMRTKS24q
         QsUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792676784; x=1793281584;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=11ggokIMRypuUy0ebBD2Pma9Z5eDvf39juHTVgfmHlI=;
        b=qfyWj0ErO35+7JYqOyHbwaruJCALh/o0zL28gmJA7/LqcyvVlSnBRLajDD6DmMC7rq
         okLFELBZwuRp8AhloU5UTlQw5rU29JtOJ4pKJXduOk0ZEoMFJNA7WQn8UEMka7Hnvgfg
         iVC4JKwH/wI4yOcZU/Zjpdign48vvsIZWk52oRKKuqHI70PAVcJQ0tYgndnCnaVcXtE5
         tFpEM1Ckhmy5oJ6bV4bxk39jtVeXh/bwhitRDbBRCK1xsBIaWhKTpdD6uDADIr9KkJmd
         BGRgOmuY80ui6GyTQtvbreSwmI7o6FgZcEsPR98G5SmruNNvT0jJjX7QU3GWXiHD8+vM
         3izg==
X-Forwarded-Encrypted: i=1; AKwUvBx51giBH04Ba76qR1pi3cCXQNCCVRn/UJ5ZN3FNmjGq3kNA2lbwE4ZJusak0Smc6Wsc1DVtE7LT8MjWQmaD@vger.kernel.org
X-Gm-Message-State: AFq9FYKAgSGOVfQ627LEXY8dKnWcBqtw6uTIfcQ2rnp01pI+cmV1v/73
	zRxWIZTkW+XSv78iwNP2T7STbDsu82HfWSJOk075QFxN8LUmrhNgXLu7x/UFQjquYfoDdIAQBLQ
	jajmIVfgfjBTDWA==
X-Received: from wmer22.prod.google.com ([2002:a05:600c:4356:b0:4a2:fdd:ce6d])
 (user=gprocida job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3e15:b0:4a1:e11f:b2d5 with SMTP id 5b1f17b1804b1-4a1fd8a85bfmr97893685e9.2.1792676783783;
 Thu, 22 Oct 2026 06:46:23 -0700 (PDT)
Date: Thu, 22 Oct 2026 14:46:16 +0100
In-Reply-To: <CANiq72mN9JYVitqgsZ2GkdmPVWqHZpJ-WNMNviiHV6C7gQMUwA@mail.gmail.com>
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <CANiq72mN9JYVitqgsZ2GkdmPVWqHZpJ-WNMNviiHV6C7gQMUwA@mail.gmail.com>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
Message-ID: <20261022134617.228229-2-gprocida@google.com>
Subject: [PATCH v2 1/2] rust: move EXPORT_SYMBOL_RUST_GPL to include/linux/export.h
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

Signed-off-by: Giuliano Procida <gprocida@google.com>
---
 drivers/gpu/nova-core/nova_core_exports.c |  2 --
 include/linux/export.h                    | 13 +++++++++++++
 rust/exports.c                            | 12 +-----------
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/nova-core/nova_core_exports.c b/drivers/gpu/nova-core/nova_core_exports.c
index 6e80ca9792ee..480472b039db 100644
--- a/drivers/gpu/nova-core/nova_core_exports.c
+++ b/drivers/gpu/nova-core/nova_core_exports.c
@@ -10,6 +10,4 @@
 
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
-- 
2.56.0.218.g1ec904b173-goog

