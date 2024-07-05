Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC335147C91;
	Fri,  5 Jul 2024 11:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720178139; cv=none; b=kPzVVuc5T0fptscpzlw63QHQB3emGIpI6btw/4RkOKTXQdEvHy3KeU4x946IlIybc7VxCR0XTdxFXN2Ej3kju8N/hGIdxqMh9IHp1KwF/L0P8FEr2YXuxSpiiQEOBPAm/Tp3psIGoc7dVMr4mcaEEIqu29r8LMqyWWSByJ5Awo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720178139; c=relaxed/simple;
	bh=Sf0Rt2h49yByBEutbHzpvwmhYIta1yKSD41MJ2QEarc=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=eEE2nQMx3oCyPkvnrdml2Os95p5T8/wDPtn3wacW8zjtHuoY39+WuQO1f7bm4kOvXFyVZc7tFpw0MYb0gpH1e1pV42NOxlCDIISPwPtNOu8ium3Em4AlnZWUUGactrPWZXp4tHtW51wGGt7ToVVc7rkYask7jGQJggqZDJFe51Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=metaspace.dk; spf=pass smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace.dk header.i=@metaspace.dk header.b=p1WfoV8l; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace.dk header.i=@metaspace.dk header.b="p1WfoV8l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=metaspace.dk;
	s=protonmail; t=1720178118; x=1720437318;
	bh=QAtadnPC69QFACYxGaKNT29iS1QlU+IVSEARqnb3SDk=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=p1WfoV8lZuO9dlO0IGB0ojZ5yqk+2lRTD5OBO1tWvuG3WQOcou9kkvHXhb1U9mlxq
	 zkgz3cF8ZK+cxcEmQHvQgOSRgLrTK6EkX6C1X/kOvbK2W1PwKHNE1OXtg8THGWxd0J
	 Ru73NkfKfzo/4XWa4dMA9HjMKuJ8Aa/pqWTVmpBLmv2LMHIwPdr1TRVhdlKEvrZJXQ
	 2IdrZo19FlZCzKyA3iHCxZq8UYgL01KlVgjXkrPF8oxkfXUHtzHyMJ11EIXS+dps/M
	 rP/9XmyIH9PU8G+rYn90HaRScaKLt/oTHBN3E+v5F6TFWoOvx3Zohz6DZzVv51HDIr
	 NE8d4midiSZNw==
Date: Fri, 05 Jul 2024 11:15:11 +0000
To: Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>
From: Andreas Hindborg <nmi@metaspace.dk>
Cc: rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@samsung.com>, Adam Bratschi-Kaye <ark.email@gmail.com>
Subject: [PATCH] rust: add `module_params` macro
Message-ID: <20240705111455.142790-1-nmi@metaspace.dk>
Feedback-ID: 113830118:user:proton
X-Pm-Message-ID: e10718939176a4e855019f2ba0a05bdea4807172
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Andreas Hindborg <a.hindborg@samsung.com>

This patch includes changes required for Rust kernel modules to utilize
module parameters. This code implements read only support for integer
types without `sysfs` support.

This code is a reduced and updated version of code by Adam available in the
original `rust` branch [1].

[1] https://github.com/Rust-for-Linux/linux/tree/bc22545f38d74473cfef3e9fd6=
5432733435b79f

Cc: Adam Bratschi-Kaye <ark.email@gmail.com>
Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>

---

I have patches queued up for `rnull` that depend on this patch.
---
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/lib.rs              |   2 +
 rust/kernel/module_param.rs     | 339 ++++++++++++++++++++++++++++++++
 rust/macros/helpers.rs          |   8 +
 rust/macros/module.rs           | 230 ++++++++++++++++++++--
 samples/rust/rust_minimal.rs    |  10 +
 6 files changed, 571 insertions(+), 19 deletions(-)
 create mode 100644 rust/kernel/module_param.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helpe=
r.h
index ddb5644d4fd9..767169f46f10 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -25,3 +25,4 @@ const gfp_t RUST_CONST_HELPER_GFP_KERNEL =3D GFP_KERNEL;
 const gfp_t RUST_CONST_HELPER_GFP_KERNEL_ACCOUNT =3D GFP_KERNEL_ACCOUNT;
 const gfp_t RUST_CONST_HELPER_GFP_NOWAIT =3D GFP_NOWAIT;
 const gfp_t RUST_CONST_HELPER___GFP_ZERO =3D __GFP_ZERO;
+const size_t RUST_CONST_HELPER_PAGE_SIZE =3D PAGE_SIZE;
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index fbd91a48ff8b..7cc2730e572f 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -33,6 +33,8 @@
 pub mod ioctl;
 #[cfg(CONFIG_KUNIT)]
 pub mod kunit;
+#[doc(hidden)]
+pub mod module_param;
 #[cfg(CONFIG_NET)]
 pub mod net;
 pub mod prelude;
diff --git a/rust/kernel/module_param.rs b/rust/kernel/module_param.rs
new file mode 100644
index 000000000000..dc1108d20723
--- /dev/null
+++ b/rust/kernel/module_param.rs
@@ -0,0 +1,339 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Types for module parameters.
+//!
+//! C header: [`include/linux/moduleparam.h`](../../../include/linux/modul=
eparam.h)
+
+use crate::{error::code::*, str::CStr};
+
+/// Types that can be used for module parameters.
+///
+/// Note that displaying the type in `sysfs` will fail if
+/// [`core::str::from_utf8`] (as implemented through the [`core::fmt::Disp=
lay`]
+/// trait) writes more than [`PAGE_SIZE`] bytes (including an additional n=
ull
+/// terminator).
+///
+/// [`PAGE_SIZE`]: `bindings::PAGE_SIZE`
+pub trait ModuleParam: core::fmt::Display + core::marker::Sized {
+    /// The `ModuleParam` will be used by the kernel module through this t=
ype.
+    ///
+    /// This may differ from `Self` if, for example, `Self` needs to track
+    /// ownership without exposing it or allocate extra space for other po=
ssible
+    /// parameter values. This is required to support string parameters in=
 the
+    /// future.
+    type Value: ?Sized;
+
+    /// Whether the parameter is allowed to be set without an argument.
+    ///
+    /// Setting this to `true` allows the parameter to be passed without a=
n
+    /// argument (e.g. just `module.param` instead of `module.param=3Dfoo`=
).
+    const NOARG_ALLOWED: bool;
+
+    /// Convert a parameter argument into the parameter value.
+    ///
+    /// `None` should be returned when parsing of the argument fails.
+    /// `arg =3D=3D None` indicates that the parameter was passed without =
an
+    /// argument. If `NOARG_ALLOWED` is set to `false` then `arg` is guara=
nteed
+    /// to always be `Some(_)`.
+    ///
+    /// Parameters passed at boot time will be set before [`kmalloc`] is
+    /// available (even if the module is loaded at a later time). However,=
 in
+    /// this case, the argument buffer will be valid for the entire lifeti=
me of
+    /// the kernel. So implementations of this method which need to alloca=
te
+    /// should first check that the allocator is available (with
+    /// [`crate::bindings::slab_is_available`]) and when it is not availab=
le
+    /// provide an alternative implementation which doesn't allocate. In c=
ases
+    /// where the allocator is not available it is safe to save references=
 to
+    /// `arg` in `Self`, but in other cases a copy should be made.
+    ///
+    /// [`kmalloc`]: ../../../include/linux/slab.h
+    fn try_from_param_arg(arg: Option<&'static [u8]>) -> Option<Self>;
+
+    /// Get the current value of the parameter for use in the kernel modul=
e.
+    ///
+    /// This function should not be used directly. Instead use the wrapper
+    /// `read` which will be generated by [`macros::module`].
+    fn value(&self) -> &Self::Value;
+
+    /// Set the module parameter from a string.
+    ///
+    /// Used to set the parameter value at kernel initialization, when loa=
ding
+    /// the module or when set through `sysfs`.
+    ///
+    /// `param.arg` is a pointer to `*mut Self` as set up by the [`module!=
`]
+    /// macro.
+    ///
+    /// See `struct kernel_param_ops.set`.
+    ///
+    /// # Safety
+    ///
+    /// If `val` is non-null then it must point to a valid null-terminated
+    /// string. The `arg` field of `param` must be an instance of `Self`.
+    ///
+    /// # Invariants
+    ///
+    /// Currently, we only support read-only parameters that are not reada=
ble
+    /// from `sysfs`. Thus, this function is only called at kernel
+    /// initialization time, or at module load time, and we have exclusive
+    /// access to the parameter for the duration of the function.
+    ///
+    /// [`module!`]: macros::module
+    unsafe extern "C" fn set_param(
+        val: *const core::ffi::c_char,
+        param: *const crate::bindings::kernel_param,
+    ) -> core::ffi::c_int {
+        let arg =3D if val.is_null() {
+            None
+        } else {
+            // SAFETY: By function safety requirement, val is non-null and
+            // null-terminated. By C API contract, `val` is live and valid=
 for
+            // reads for the duration of this function.
+            Some(unsafe { CStr::from_char_ptr(val).as_bytes() })
+        };
+        match Self::try_from_param_arg(arg) {
+            Some(new_value) =3D> {
+                // SAFETY: `param` is guaranteed to be valid by C API cont=
ract
+                // and `arg` is guaranteed to point to an instance of `Sel=
f`.
+                let old_value =3D unsafe { (*param).__bindgen_anon_1.arg a=
s *mut Self };
+                // SAFETY: `old_value` is valid for writes, as we have exc=
lusive
+                // access. `old_value` is pointing to an initialized stati=
c, an
+                // so it is properly initialized.
+                let _ =3D unsafe { core::ptr::replace(old_value, new_value=
) };
+                0
+            }
+            None =3D> EINVAL.to_errno(),
+        }
+    }
+
+    /// Write a string representation of the current parameter value to `b=
uf`.
+    ///
+    /// # Safety
+    ///
+    /// Must not be called.
+    ///
+    /// # Note
+    ///
+    /// This should not be called as we declare all parameters as read onl=
y.
+    unsafe extern "C" fn get_param(
+        _buf: *mut core::ffi::c_char,
+        _param: *const crate::bindings::kernel_param,
+    ) -> core::ffi::c_int {
+        0
+    }
+
+    /// Drop the parameter.
+    ///
+    /// Called when unloading a module.
+    ///
+    /// # Safety
+    ///
+    /// The `arg` field of `param` must be an initialized instance of `Sel=
f`.
+    unsafe extern "C" fn free(arg: *mut core::ffi::c_void) {
+        // SAFETY: By function safety requirement, `arg` is an initialized
+        // instance of `Self`. By C API contract, `arg` will not be used a=
fter
+        // this function returns.
+        unsafe { core::ptr::drop_in_place(arg as *mut Self) };
+    }
+}
+
+/// Trait for parsing integers.
+///
+/// Strings beginning with `0x`, `0o`, or `0b` are parsed as hex, octal, o=
r
+/// binary respectively. Strings beginning with `0` otherwise are parsed a=
s
+/// octal. Anything else is parsed as decimal. A leading `+` or `-` is als=
o
+/// permitted. Any string parsed by [`kstrtol()`] or [`kstrtoul()`] will b=
e
+/// successfully parsed.
+///
+/// [`kstrtol()`]: https://www.kernel.org/doc/html/latest/core-api/kernel-=
api.html#c.kstrtol
+/// [`kstrtoul()`]: https://www.kernel.org/doc/html/latest/core-api/kernel=
-api.html#c.kstrtoul
+trait ParseInt: Sized {
+    fn from_str_radix(src: &str, radix: u32) -> Result<Self, core::num::Pa=
rseIntError>;
+    fn checked_neg(self) -> Option<Self>;
+
+    fn from_str_unsigned(src: &str) -> Result<Self, core::num::ParseIntErr=
or> {
+        let (radix, digits) =3D if let Some(n) =3D src.strip_prefix("0x") =
{
+            (16, n)
+        } else if let Some(n) =3D src.strip_prefix("0X") {
+            (16, n)
+        } else if let Some(n) =3D src.strip_prefix("0o") {
+            (8, n)
+        } else if let Some(n) =3D src.strip_prefix("0O") {
+            (8, n)
+        } else if let Some(n) =3D src.strip_prefix("0b") {
+            (2, n)
+        } else if let Some(n) =3D src.strip_prefix("0B") {
+            (2, n)
+        } else if src.starts_with('0') {
+            (8, src)
+        } else {
+            (10, src)
+        };
+        Self::from_str_radix(digits, radix)
+    }
+
+    fn from_str(src: &str) -> Option<Self> {
+        match src.bytes().next() {
+            None =3D> None,
+            Some(b'-') =3D> Self::from_str_unsigned(&src[1..]).ok()?.check=
ed_neg(),
+            Some(b'+') =3D> Some(Self::from_str_unsigned(&src[1..]).ok()?)=
,
+            Some(_) =3D> Some(Self::from_str_unsigned(src).ok()?),
+        }
+    }
+}
+
+macro_rules! impl_parse_int {
+    ($ty:ident) =3D> {
+        impl ParseInt for $ty {
+            fn from_str_radix(src: &str, radix: u32) -> Result<Self, core:=
:num::ParseIntError> {
+                $ty::from_str_radix(src, radix)
+            }
+
+            fn checked_neg(self) -> Option<Self> {
+                self.checked_neg()
+            }
+        }
+    };
+}
+
+impl_parse_int!(i8);
+impl_parse_int!(u8);
+impl_parse_int!(i16);
+impl_parse_int!(u16);
+impl_parse_int!(i32);
+impl_parse_int!(u32);
+impl_parse_int!(i64);
+impl_parse_int!(u64);
+impl_parse_int!(isize);
+impl_parse_int!(usize);
+
+macro_rules! impl_module_param {
+    ($ty:ident) =3D> {
+        impl ModuleParam for $ty {
+            type Value =3D $ty;
+
+            const NOARG_ALLOWED: bool =3D false;
+
+            fn try_from_param_arg(arg: Option<&'static [u8]>) -> Option<Se=
lf> {
+                let bytes =3D arg?;
+                let utf8 =3D core::str::from_utf8(bytes).ok()?;
+                <$ty as crate::module_param::ParseInt>::from_str(utf8)
+            }
+
+            #[inline(always)]
+            fn value(&self) -> &Self::Value {
+                self
+            }
+        }
+    };
+}
+
+#[doc(hidden)]
+#[macro_export]
+/// Generate a static [`kernel_param_ops`](../../../include/linux/modulepa=
ram.h) struct.
+///
+/// # Examples
+///
+/// ```ignore
+/// make_param_ops!(
+///     /// Documentation for new param ops.
+///     PARAM_OPS_MYTYPE, // Name for the static.
+///     MyType // A type which implements [`ModuleParam`].
+/// );
+/// ```
+macro_rules! make_param_ops {
+    ($ops:ident, $ty:ty) =3D> {
+        $crate::make_param_ops!(
+            #[doc=3D""]
+            $ops,
+            $ty
+        );
+    };
+    ($(#[$meta:meta])* $ops:ident, $ty:ty) =3D> {
+        $(#[$meta])*
+        ///
+        /// Static [`kernel_param_ops`](../../../include/linux/moduleparam=
.h)
+        /// struct generated by [`make_param_ops`].
+        pub static $ops: $crate::bindings::kernel_param_ops =3D $crate::bi=
ndings::kernel_param_ops {
+            flags: if <$ty as $crate::module_param::ModuleParam>::NOARG_AL=
LOWED {
+                $crate::bindings::KERNEL_PARAM_OPS_FL_NOARG
+            } else {
+                0
+            },
+            set: Some(<$ty as $crate::module_param::ModuleParam>::set_para=
m),
+            get: Some(<$ty as $crate::module_param::ModuleParam>::get_para=
m),
+            free: Some(<$ty as $crate::module_param::ModuleParam>::free),
+        };
+    };
+}
+
+impl_module_param!(i8);
+impl_module_param!(u8);
+impl_module_param!(i16);
+impl_module_param!(u16);
+impl_module_param!(i32);
+impl_module_param!(u32);
+impl_module_param!(i64);
+impl_module_param!(u64);
+impl_module_param!(isize);
+impl_module_param!(usize);
+
+make_param_ops!(
+    /// Rust implementation of [`kernel_param_ops`](../../../include/linux=
/moduleparam.h)
+    /// for [`i8`].
+    PARAM_OPS_I8,
+    i8
+);
+make_param_ops!(
+    /// Rust implementation of [`kernel_param_ops`](../../../include/linux=
/moduleparam.h)
+    /// for [`u8`].
+    PARAM_OPS_U8,
+    u8
+);
+make_param_ops!(
+    /// Rust implementation of [`kernel_param_ops`](../../../include/linux=
/moduleparam.h)
+    /// for [`i16`].
+    PARAM_OPS_I16,
+    i16
+);
+make_param_ops!(
+    /// Rust implementation of [`kernel_param_ops`](../../../include/linux=
/moduleparam.h)
+    /// for [`u16`].
+    PARAM_OPS_U16,
+    u16
+);
+make_param_ops!(
+    /// Rust implementation of [`kernel_param_ops`](../../../include/linux=
/moduleparam.h)
+    /// for [`i32`].
+    PARAM_OPS_I32,
+    i32
+);
+make_param_ops!(
+    /// Rust implementation of [`kernel_param_ops`](../../../include/linux=
/moduleparam.h)
+    /// for [`u32`].
+    PARAM_OPS_U32,
+    u32
+);
+make_param_ops!(
+    /// Rust implementation of [`kernel_param_ops`](../../../include/linux=
/moduleparam.h)
+    /// for [`i64`].
+    PARAM_OPS_I64,
+    i64
+);
+make_param_ops!(
+    /// Rust implementation of [`kernel_param_ops`](../../../include/linux=
/moduleparam.h)
+    /// for [`u64`].
+    PARAM_OPS_U64,
+    u64
+);
+make_param_ops!(
+    /// Rust implementation of [`kernel_param_ops`](../../../include/linux=
/moduleparam.h)
+    /// for [`isize`].
+    PARAM_OPS_ISIZE,
+    isize
+);
+make_param_ops!(
+    /// Rust implementation of [`kernel_param_ops`](../../../include/linux=
/moduleparam.h)
+    /// for [`usize`].
+    PARAM_OPS_USIZE,
+    usize
+);
diff --git a/rust/macros/helpers.rs b/rust/macros/helpers.rs
index 563dcd2b7ace..dc0b47879a8c 100644
--- a/rust/macros/helpers.rs
+++ b/rust/macros/helpers.rs
@@ -107,6 +107,14 @@ pub(crate) struct Generics {
     pub(crate) ty_generics: Vec<TokenTree>,
 }
=20
+pub(crate) fn get_string(it: &mut token_stream::IntoIter, expected_name: &=
str) -> String {
+    assert_eq!(expect_ident(it), expected_name);
+    assert_eq!(expect_punct(it), ':');
+    let string =3D expect_string(it);
+    assert_eq!(expect_punct(it), ',');
+    string
+}
+
 /// Parses the given `TokenStream` into `Generics` and the rest.
 ///
 /// The generics are not present in the rest, but a where clause might rem=
ain.
diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index acd0393b5095..fc794855b99e 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
=20
 use crate::helpers::*;
-use proc_macro::{token_stream, Delimiter, Literal, TokenStream, TokenTree}=
;
+use proc_macro::{token_stream, Delimiter, Group, Literal, TokenStream, Tok=
enTree};
 use std::fmt::Write;
=20
 fn expect_string_array(it: &mut token_stream::IntoIter) -> Vec<String> {
@@ -26,6 +26,7 @@ struct ModInfoBuilder<'a> {
     module: &'a str,
     counter: usize,
     buffer: String,
+    param_buffer: String,
 }
=20
 impl<'a> ModInfoBuilder<'a> {
@@ -34,10 +35,11 @@ fn new(module: &'a str) -> Self {
             module,
             counter: 0,
             buffer: String::new(),
+            param_buffer: String::new(),
         }
     }
=20
-    fn emit_base(&mut self, field: &str, content: &str, builtin: bool) {
+    fn emit_base(&mut self, field: &str, content: &str, builtin: bool, par=
am: bool) {
         let string =3D if builtin {
             // Built-in modules prefix their modinfo strings by `module.`.
             format!(
@@ -51,8 +53,14 @@ fn emit_base(&mut self, field: &str, content: &str, buil=
tin: bool) {
             format!("{field}=3D{content}\0", field =3D field, content =3D =
content)
         };
=20
+        let buffer =3D if param {
+            &mut self.param_buffer
+        } else {
+            &mut self.buffer
+        };
+
         write!(
-            &mut self.buffer,
+            buffer,
             "
                 {cfg}
                 #[doc(hidden)]
@@ -75,20 +83,190 @@ fn emit_base(&mut self, field: &str, content: &str, bu=
iltin: bool) {
         self.counter +=3D 1;
     }
=20
-    fn emit_only_builtin(&mut self, field: &str, content: &str) {
-        self.emit_base(field, content, true)
+    fn emit_only_builtin(&mut self, field: &str, content: &str, param: boo=
l) {
+        self.emit_base(field, content, true, param)
     }
=20
-    fn emit_only_loadable(&mut self, field: &str, content: &str) {
-        self.emit_base(field, content, false)
+    fn emit_only_loadable(&mut self, field: &str, content: &str, param: bo=
ol) {
+        self.emit_base(field, content, false, param)
     }
=20
     fn emit(&mut self, field: &str, content: &str) {
-        self.emit_only_builtin(field, content);
-        self.emit_only_loadable(field, content);
+        self.emit_internal(field, content, false);
+    }
+
+    fn emit_internal(&mut self, field: &str, content: &str, param: bool) {
+        self.emit_only_builtin(field, content, param);
+        self.emit_only_loadable(field, content, param);
+    }
+
+    fn emit_param(&mut self, field: &str, param: &str, content: &str) {
+        let content =3D format!("{param}:{content}", param =3D param, cont=
ent =3D content);
+        self.emit_internal(field, &content, true);
+    }
+
+    fn emit_params(&mut self, info: &ModuleInfo) {
+        if let Some(params) =3D &info.params {
+            assert_eq!(params.delimiter(), Delimiter::Brace);
+
+            let mut it =3D params.stream().into_iter();
+
+            loop {
+                let param_name =3D match it.next() {
+                    Some(TokenTree::Ident(ident)) =3D> ident.to_string(),
+                    Some(_) =3D> panic!("Expected Ident or end"),
+                    None =3D> break,
+                };
+
+                assert_eq!(expect_punct(&mut it), ':');
+                let param_type =3D expect_ident(&mut it);
+                let group =3D expect_group(&mut it);
+                assert_eq!(expect_punct(&mut it), ',');
+
+                assert_eq!(group.delimiter(), Delimiter::Brace);
+
+                let mut param_it =3D group.stream().into_iter();
+                let param_default =3D get_param_default(&mut param_it);
+                let param_description =3D get_string(&mut param_it, "descr=
iption");
+                expect_end(&mut param_it);
+
+                let (param_kernel_type, ops): (String, _) =3D (
+                    param_type.to_string(),
+                    param_ops_path(&param_type).to_string(),
+                );
+
+                self.emit_param("parmtype", &param_name, &param_kernel_typ=
e);
+                self.emit_param("parm", &param_name, &param_description);
+                let param_type_internal =3D param_type.clone();
+
+                let read_func =3D format!(
+                    "
+                        pub(crate) fn read(&self)
+                            -> &<{param_type_internal}
+                               as kernel::module_param::ModuleParam>::Valu=
e {{
+                            // Note: when we enable r/w parameters, we nee=
d to lock here.
+
+                            // SAFETY: Parameters do not need to be locked=
 because they are
+                            // read only or sysfs is not enabled.
+                            unsafe {{
+                                <{param_type_internal} as kernel::module_p=
aram::ModuleParam>::value(
+                                    &__{name}_{param_name}_value
+                                )
+                            }}
+                        }}
+                    ",
+                    name =3D info.name,
+                    param_name =3D param_name,
+                    param_type_internal =3D param_type_internal,
+                );
+
+                let kparam =3D format!(
+                    "
+                    kernel::bindings::kernel_param__bindgen_ty_1 {{
+                        // SAFETY: Access through the resulting pointer is
+                        // serialized by C side and only happens before mo=
dule
+                        // `init` or after module `drop` is called.
+                        arg: unsafe {{ &__{name}_{param_name}_value }}
+                            as *const _ as *mut core::ffi::c_void,
+                    }},
+                ",
+                    name =3D info.name,
+                    param_name =3D param_name,
+                );
+                write!(
+                    self.param_buffer,
+                    "
+                static mut __{name}_{param_name}_value: {param_type_intern=
al} =3D {param_default};
+
+                pub(crate) struct __{name}_{param_name};
+
+                impl __{name}_{param_name} {{ {read_func} }}
+
+                pub(crate) const {param_name}: __{name}_{param_name} =3D _=
_{name}_{param_name};
+
+                // Note: the C macro that generates the static structs for=
 the `__param` section
+                // asks for them to be `aligned(sizeof(void *))`. However,=
 that was put in place
+                // in 2003 in commit 38d5b085d2a0 (\"[PATCH] Fix over-alig=
nment problem on x86-64\")
+                // to undo GCC over-alignment of static structs of >32 byt=
es. It seems that is
+                // not the case anymore, so we simplify to a transparent r=
epresentation here
+                // in the expectation that it is not needed anymore.
+                // TODO: Revisit this to confirm the above comment and rem=
ove it if it happened.
+                /// Newtype to make `bindings::kernel_param` `Sync`.
+                #[repr(transparent)]
+                struct __{name}_{param_name}_RacyKernelParam(kernel::bindi=
ngs::kernel_param);
+
+                // SAFETY: C kernel handles serializing access to this typ=
e. We
+                // never access from Rust module.
+                unsafe impl Sync for __{name}_{param_name}_RacyKernelParam=
 {{
+                }}
+
+                #[cfg(not(MODULE))]
+                const __{name}_{param_name}_name: *const core::ffi::c_char=
 =3D
+                    b\"{name}.{param_name}\\0\" as *const _ as *const core=
::ffi::c_char;
+
+                #[cfg(MODULE)]
+                const __{name}_{param_name}_name: *const core::ffi::c_char=
 =3D
+                    b\"{param_name}\\0\" as *const _ as *const core::ffi::=
c_char;
+
+                #[link_section =3D \"__param\"]
+                #[used]
+                static __{name}_{param_name}_struct: __{name}_{param_name}=
_RacyKernelParam =3D
+                    __{name}_{param_name}_RacyKernelParam(kernel::bindings=
::kernel_param {{
+                        name: __{name}_{param_name}_name,
+                        // SAFETY: `__this_module` is constructed by the k=
ernel at load time
+                        // and will not be freed until the module is unloa=
ded.
+                        #[cfg(MODULE)]
+                        mod_: unsafe {{ &kernel::bindings::__this_module a=
s *const _ as *mut _ }},
+                        #[cfg(not(MODULE))]
+                        mod_: core::ptr::null_mut(),
+                        // SAFETY: This static is actually constant as see=
n by
+                        // module code. But we need a unique address for i=
t, so it
+                        // must be static.
+                        ops: unsafe {{ &{ops} }} as *const kernel::binding=
s::kernel_param_ops,
+                        perm: 0, // Will not appear in sysfs
+                        level: -1,
+                        flags: 0,
+                        __bindgen_anon_1: {kparam}
+                    }});
+                ",
+                    name =3D info.name,
+                    param_type_internal =3D param_type_internal,
+                    read_func =3D read_func,
+                    param_default =3D param_default,
+                    param_name =3D param_name,
+                    ops =3D ops,
+                    kparam =3D kparam,
+                )
+                .unwrap();
+            }
+        }
     }
 }
=20
+fn param_ops_path(param_type: &str) -> &'static str {
+    match param_type {
+        "i8" =3D> "::kernel::module_param::PARAM_OPS_I8",
+        "u8" =3D> "::kernel::module_param::PARAM_OPS_U8",
+        "i16" =3D> "::kernel::module_param::PARAM_OPS_I16",
+        "u16" =3D> "::kernel::module_param::PARAM_OPS_U16",
+        "i32" =3D> "::kernel::module_param::PARAM_OPS_I32",
+        "u32" =3D> "::kernel::module_param::PARAM_OPS_U32",
+        "i64" =3D> "::kernel::module_param::PARAM_OPS_I64",
+        "u64" =3D> "::kernel::module_param::PARAM_OPS_U64",
+        "isize" =3D> "::kernel::module_param::PARAM_OPS_ISIZE",
+        "usize" =3D> "::kernel::module_param::PARAM_OPS_USIZE",
+        t =3D> panic!("Unrecognized type {}", t),
+    }
+}
+
+fn get_param_default(param_it: &mut token_stream::IntoIter) -> String {
+    assert_eq!(expect_ident(param_it), "default");
+    assert_eq!(expect_punct(param_it), ':');
+    let default =3D try_literal(param_it).expect("Expected default param v=
alue");
+    assert_eq!(expect_punct(param_it), ',');
+    default
+}
+
 #[derive(Debug, Default)]
 struct ModuleInfo {
     type_: String,
@@ -97,14 +275,22 @@ struct ModuleInfo {
     author: Option<String>,
     description: Option<String>,
     alias: Option<Vec<String>>,
+    params: Option<Group>,
 }
=20
 impl ModuleInfo {
     fn parse(it: &mut token_stream::IntoIter) -> Self {
         let mut info =3D ModuleInfo::default();
=20
-        const EXPECTED_KEYS: &[&str] =3D
-            &["type", "name", "author", "description", "license", "alias"]=
;
+        const EXPECTED_KEYS: &[&str] =3D &[
+            "type",
+            "name",
+            "author",
+            "description",
+            "license",
+            "alias",
+            "params",
+        ];
         const REQUIRED_KEYS: &[&str] =3D &["type", "name", "license"];
         let mut seen_keys =3D Vec::new();
=20
@@ -131,6 +317,7 @@ fn parse(it: &mut token_stream::IntoIter) -> Self {
                 "description" =3D> info.description =3D Some(expect_string=
(it)),
                 "license" =3D> info.license =3D expect_string_ascii(it),
                 "alias" =3D> info.alias =3D Some(expect_string_array(it)),
+                "params" =3D> info.params =3D Some(expect_group(it)),
                 _ =3D> panic!(
                     "Unknown key \"{}\". Valid keys are: {:?}.",
                     key, EXPECTED_KEYS
@@ -174,23 +361,25 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream =
{
     let info =3D ModuleInfo::parse(&mut it);
=20
     let mut modinfo =3D ModInfoBuilder::new(info.name.as_ref());
-    if let Some(author) =3D info.author {
-        modinfo.emit("author", &author);
+    if let Some(author) =3D &info.author {
+        modinfo.emit("author", author);
     }
-    if let Some(description) =3D info.description {
-        modinfo.emit("description", &description);
+    if let Some(description) =3D &info.description {
+        modinfo.emit("description", description);
     }
     modinfo.emit("license", &info.license);
-    if let Some(aliases) =3D info.alias {
+    if let Some(aliases) =3D &info.alias {
         for alias in aliases {
-            modinfo.emit("alias", &alias);
+            modinfo.emit("alias", alias);
         }
     }
=20
     // Built-in modules also export the `file` modinfo string.
     let file =3D
         std::env::var("RUST_MODFILE").expect("Unable to fetch RUST_MODFILE=
 environmental variable");
-    modinfo.emit_only_builtin("file", &file);
+    modinfo.emit_only_builtin("file", &file, false);
+
+    modinfo.emit_params(&info);
=20
     format!(
         "
@@ -332,14 +521,17 @@ unsafe fn __exit() {{
                             __MOD =3D None;
                         }}
                     }}
-
                     {modinfo}
                 }}
             }}
+            mod module_parameters {{
+                {params}
+            }}
         ",
         type_ =3D info.type_,
         name =3D info.name,
         modinfo =3D modinfo.buffer,
+        params =3D modinfo.param_buffer,
         initcall_section =3D ".initcall6.init"
     )
     .parse()
diff --git a/samples/rust/rust_minimal.rs b/samples/rust/rust_minimal.rs
index 2a9eaab62d1c..359e6d8ec983 100644
--- a/samples/rust/rust_minimal.rs
+++ b/samples/rust/rust_minimal.rs
@@ -10,6 +10,12 @@
     author: "Rust for Linux Contributors",
     description: "Rust minimal sample",
     license: "GPL",
+    params: {
+        test_parameter: i64 {
+            default: 1,
+            description: "This parameter has a default of 1",
+        },
+    },
 }
=20
 struct RustMinimal {
@@ -20,6 +26,10 @@ impl kernel::Module for RustMinimal {
     fn init(_module: &'static ThisModule) -> Result<Self> {
         pr_info!("Rust minimal sample (init)\n");
         pr_info!("Am I built-in? {}\n", !cfg!(MODULE));
+        pr_info!(
+            "My parameter: {}\n",
+            *module_parameters::test_parameter.read()
+        );
=20
         let mut numbers =3D Vec::new();
         numbers.push(72, GFP_KERNEL)?;

base-commit: f2661062f16b2de5d7b6a5c42a9a5c96326b8454
--=20
2.45.2


