Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBE344F56F;
	Sun, 11 Oct 2026 12:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791723193; cv=none; b=YeWDGSJ0E10TWmEu93W8Zn4NRjiIHY+v2PlKPJIiB4nVhuEhuq5CSdn3tjsYhoIG6ROw6YJToN9Kh2bgrI5cqtbcHESKsXc2dzCjmpM/0m5gizkWOFSdEw5X5pP1qoOwYQDUAc2UJtYarhGJQT5RbW9iItpLn60o412/TYZJj/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791723193; c=relaxed/simple;
	bh=u8CtNh2qod6FtJX0y48YXCPwQ4zljs4zmQyDBNmw9PA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I41xcLotaco3WJAi/qNRdpp33cp9MJEb+pXQ+9jdPnNL0LaqAqTJ49H+/32Mv+59hS75LNTRwbN7CqNlMYa11iG135aHJt9roOcuJOvkO6YfF6jVhnyqx0XJ+/xHoim4lagX0NMFpuPHZ0LzcxrUnnm6X7t7mBA+I+NC5JoNS5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=GWGbyoDt; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="GWGbyoDt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1791723179;
	bh=u8CtNh2qod6FtJX0y48YXCPwQ4zljs4zmQyDBNmw9PA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GWGbyoDt9Vnp4tquUytXKA9fUb3RQn8nS+DAy046R4cXtIvMW5iU72+0kTIPnCL8f
	 +hbz4wQg2Rg421DQ8Q8cOQub8ED2Ry8J/7r+5vqIEQSDSlQvl12k062e1CxTP8B6Lv
	 40oEmO+e/X+qVCsQe9B1CA+/XXeKUQr7KWE/w4mo=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 11 Oct 2026 14:52:32 +0200
Subject: [PATCH RFC 08/11] rust: add support for dynamic debug
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261011-rust-dyndbg-v1-8-832e4039b71f@weissschuh.net>
References: <20261011-rust-dyndbg-v1-0-832e4039b71f@weissschuh.net>
In-Reply-To: <20261011-rust-dyndbg-v1-0-832e4039b71f@weissschuh.net>
To: Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, Will Deacon <will@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, 
 Lyude Paul <lyude@redhat.com>, Yury Norov <yury.norov@gmail.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>, 
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
 Rae Moar <raemoar63@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, driver-core@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791723177; l=10739;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=u8CtNh2qod6FtJX0y48YXCPwQ4zljs4zmQyDBNmw9PA=;
 b=3UXHaSFFnHFMEGY4gEK8+GAB5hx7MkWrVHvAkGVn197gPmB+8KWZHWIQ3fXSsFuNCcYPBga/4
 WPKilYY4zt4BSqyrUntVQQuI7t9afcQPnQQQjIXKosKEUBa+5fMrZXg
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Add the Rust infrastructure to integrate with the dynamic debug
infrastructure.

Static keys are not used for now, as the full bindings are missing
for those. Also custom classes are not supported yet, but could be
added on top.

pr_debug!() and dev_dbg!() will be wired up in later patches.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 MAINTAINERS                     |   1 +
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/dynamic_debug.rs    | 264 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   2 +
 4 files changed, 268 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 72294ddfa5b7..c36e3c9bfe89 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9261,6 +9261,7 @@ S:	Maintained
 F:	include/linux/dynamic_debug.h
 F:	lib/dynamic_debug.c
 F:	lib/test_dynamic_debug.c
+F:	rust/kernel/dynamic_debug.rs
 
 DYNAMIC INTERRUPT MODERATION
 M:	Tal Gilboa <talgi@nvidia.com>
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index c706dda5b5ca..e6b7de0d7773 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -55,6 +55,7 @@
 #include <linux/dma-direction.h>
 #include <linux/dma-mapping.h>
 #include <linux/dma-resv.h>
+#include <linux/dynamic_debug.h>
 #include <linux/errname.h>
 #include <linux/ethtool.h>
 #include <linux/fdtable.h>
diff --git a/rust/kernel/dynamic_debug.rs b/rust/kernel/dynamic_debug.rs
new file mode 100644
index 000000000000..2fdc691eaac9
--- /dev/null
+++ b/rust/kernel/dynamic_debug.rs
@@ -0,0 +1,264 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2026 Thomas Weißschuh <linux@weissschuh.net>
+
+//! Dynamic debug support for printk.
+//!
+//! C header: [`include/linux/dynamic_debug.h`](srctree/include/linux/dynamic_debug.h)
+
+use crate::num::casts;
+use crate::num::Bounded;
+use crate::ptr::project;
+use crate::static_assert;
+use crate::str::{as_char_ptr_in_const_context, CStr};
+use crate::sync::atomic;
+use core::marker::PhantomData;
+use core::mem::{align_of, size_of};
+use pin_init::zeroed;
+
+mod flags {
+    use crate::num::casts::u32_into_u8;
+
+    pub(super) const NONE: u8 = u32_into_u8::<{ bindings::_DPRINTK_FLAGS_NONE }>();
+    pub(super) const PRINT: u8 = u32_into_u8::<{ bindings::_DPRINTK_FLAGS_PRINT }>();
+    pub(super) const INCL_STACK: u8 = u32_into_u8::<{ bindings::_DPRINTK_FLAGS_INCL_STACK }>();
+}
+
+/// Line number type.
+///
+/// Constrained to ensure that all values can be encoded in a [`Descriptor`].
+pub type LineNumber = Bounded<u32, 18>;
+
+/// Class ID type.
+///
+/// Constrained to ensure that all values can be encoded in a [`Descriptor`].
+pub type ClassId = Bounded<u32, 6>;
+
+static_assert!(ClassId::USABLE_BITS == bindings::CLS_BITS);
+static_assert!(
+    LineNumber::USABLE_BITS + ClassId::USABLE_BITS
+        == casts::usize_into_u32::<{ size_of::<BitfieldBindgenUnit>() }>() * u8::BITS
+);
+
+type BitfieldBindgenUnit = bindings::__BindgenBitfieldUnit<[u8; 3]>;
+
+const fn encode_bitfield(line_number: LineNumber, class_id: ClassId) -> BitfieldBindgenUnit {
+    let line_number = line_number.get();
+    let class_id = class_id.get();
+
+    // TODO: Use bindings::_ddebug::new_bitfield_1() when usable in const functions.
+    let bytes = if cfg!(target_endian = "big") {
+        [
+            (line_number >> 10) as u8,
+            (line_number >> 2) as u8,
+            (line_number as u8) << 6 | class_id as u8,
+        ]
+    } else {
+        [
+            line_number as u8,
+            (line_number >> 8) as u8,
+            (line_number >> 16) as u8 | (class_id as u8) << 2,
+        ]
+    };
+
+    BitfieldBindgenUnit::new(bytes)
+}
+
+/// Wrapper around a `struct _ddebug` descriptor.
+#[repr(transparent)]
+pub struct Descriptor<'a>(bindings::_ddebug, PhantomData<&'a ()>);
+
+static_assert!(size_of::<Descriptor<'_>>() == size_of::<bindings::_ddebug>());
+// Required by the dynamic debug core.
+static_assert!(align_of::<Descriptor<'_>>() == 8);
+
+// SAFETY: Only the flags field is changed at runtime using atomic operations.
+unsafe impl<'a> Sync for Descriptor<'a> {}
+
+impl<'a> Descriptor<'a> {
+    /// Create a new descriptor.
+    pub const fn new(
+        default_enabled: bool,
+        modname: &'a CStr,
+        filename: &'a CStr,
+        function: &'a CStr,
+        format: &'a CStr,
+        line_number: LineNumber,
+        class_id: Option<ClassId>,
+    ) -> Self {
+        let class_id = match class_id {
+            Some(c) => c,
+            None => ClassId::new::<{ bindings::_DPRINTK_CLASS_DFLT }>(),
+        };
+
+        let flags = if default_enabled {
+            flags::NONE | flags::PRINT
+        } else {
+            flags::NONE
+        };
+
+        Self(
+            #[allow(clippy::needless_update)]
+            bindings::_ddebug {
+                modname: as_char_ptr_in_const_context(modname),
+                function: as_char_ptr_in_const_context(function),
+                filename: as_char_ptr_in_const_context(filename),
+                format: as_char_ptr_in_const_context(format),
+                _bitfield_1: encode_bitfield(line_number, class_id),
+                flags,
+                #[cfg(CONFIG_JUMP_LABEL)]
+                key: Self::new_static_key(),
+                ..zeroed()
+            },
+            PhantomData,
+        )
+    }
+
+    #[cfg(CONFIG_JUMP_LABEL)]
+    const fn new_static_key() -> bindings::_ddebug__bindgen_ty_1 {
+        /*
+         * Always use static_key_false for now. branch_and_stack() below does not use it (yet),
+         * and the dynamic debug core doesn't know how it was initialized in any case.
+         */
+        bindings::_ddebug__bindgen_ty_1 {
+            dd_key_false: bindings::static_key_false {
+                key: bindings::static_key {
+                    enabled: bindings::atomic_t { counter: 0 },
+                    __bindgen_anon_1: bindings::static_key__bindgen_ty_1 {
+                        type_: casts::u32_as_usize(bindings::JUMP_TYPE_FALSE),
+                    },
+                },
+            },
+        }
+    }
+
+    /// Execute `func` if the descriptor active. Also print a stacktrace if enabled.
+    ///
+    /// # Safety
+    ///
+    /// The given `desc` must be valid throughout the call of the function.
+    #[inline(always)]
+    pub unsafe fn branch_and_stack<F: FnOnce()>(desc: *mut Descriptor<'static>, func: F) {
+        // TODO: Use static keys.
+
+        let flags_ptr = project!(mut desc, .0.flags);
+        // SAFETY: As per the function safety requirement `desc` is valid, and properly aligned,
+        // so `flags_ptr` is so, too. Updates from C are atomic.
+        let flags = unsafe { atomic::atomic_load(flags_ptr, atomic::ordering::Relaxed) };
+
+        if flags & flags::PRINT != 0 {
+            func();
+
+            if flags & flags::INCL_STACK != 0 {
+                // SAFETY: Can be called from any context where printk can be used.
+                unsafe {
+                    bindings::dump_stack();
+                }
+            }
+        }
+    }
+}
+
+/// Allocate a dynamic debug descriptor.
+#[macro_export]
+#[expect(clippy::crate_in_macro_def)]
+macro_rules! dynamic_debug_metadata_cls {
+    ($default_enabled:expr, $cls:expr, $fmt:expr) => {{
+        use $crate::c_str;
+        use $crate::dynamic_debug::{Descriptor, LineNumber};
+
+        #[link_section = "__dyndbg"]
+        #[used(compiler)]
+        static mut descriptor: Descriptor = Descriptor::new(
+            $default_enabled,
+            crate::__LOG_PREFIX,
+            c_str!(file!()),
+            // Rust does not provide the current function, approximate with module_path!().
+            c_str!(module_path!()),
+            c_str!($fmt),
+            LineNumber::new::<{ line!() }>(),
+            $cls,
+        );
+
+        ::core::ptr::addr_of_mut!(descriptor)
+    }};
+}
+
+/// Add a runtime-configurable function invocation for a specific class.
+#[macro_export]
+macro_rules! dynamic_func_call_cls {
+    ($cls:expr, $fmt:expr, $func:expr) => {{
+        const default_enabled: bool = cfg!(debug_assertions);
+
+        let descriptor = $crate::dynamic_debug_metadata_cls!(default_enabled, $cls, $fmt);
+
+        // SAFETY: `descriptor` has static lifetime, so it is always valid.
+        unsafe {
+            $crate::dynamic_debug::Descriptor::branch_and_stack(descriptor, $func);
+        }
+    }};
+}
+
+/// Add a runtime-configurable function invocation.
+#[macro_export]
+macro_rules! dynamic_func_call {
+    ($fmt:expr, $func:expr) => {{
+        $crate::dynamic_func_call_cls!(None, $fmt, $func);
+    }};
+}
+
+#[doc(hidden)]
+#[macro_export]
+macro_rules! __format_string {
+    ($fmt:literal) => {
+        $fmt
+    };
+
+    ($fmt:literal, $($arg:tt)*) => {
+        $fmt
+    };
+}
+
+#[macros::kunit_tests(rust_dynamic_debug)]
+mod tests {
+    use super::*;
+
+    #[test]
+    fn test_bitfield_encoding() -> Result<(), ()> {
+        struct TestCase {
+            line_number: u32,
+            class_id: u32,
+        }
+
+        let test_cases = [
+            TestCase {
+                line_number: 0b101010101010101010,
+                class_id: 0b101010,
+            },
+            TestCase {
+                line_number: 0b111111111111111111,
+                class_id: 0b000000,
+            },
+            TestCase {
+                line_number: 0b000000000000000000,
+                class_id: 0b111111,
+            },
+            TestCase {
+                line_number: 0b101100111000111100,
+                class_id: 0b111111,
+            },
+        ];
+
+        for case in test_cases {
+            let line_number = LineNumber::try_new(case.line_number).ok_or(())?;
+            let class_id = ClassId::try_new(case.class_id).ok_or(())?;
+
+            assert_eq!(
+                bindings::_ddebug::new_bitfield_1(*line_number, *class_id,),
+                encode_bitfield(line_number, class_id),
+            );
+        }
+
+        Ok(())
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 7d48f931877d..ff4bdd24353d 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -70,6 +70,8 @@
 pub mod driver;
 #[cfg(CONFIG_DRM = "y")]
 pub mod drm;
+#[cfg(CONFIG_DYNAMIC_DEBUG_CORE)]
+pub mod dynamic_debug;
 pub mod error;
 pub mod faux;
 #[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]

-- 
2.56.0

