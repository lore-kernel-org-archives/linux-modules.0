Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9770016D321
	for <linux-modules@vger.kernel.org>; Mon, 19 Aug 2024 13:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724074472; cv=none; b=K/CDVmwP0dRez5GT841GgACHCZmyrbXAx34OEXXWVWFyofoK6tTLyYmEmhAMFSP1jLw+3fXJdajEDyXACBly4FEkmyXbRg55CukJFunHnd5KH4nj1CMbppxQcORJ6iX9wFZpZFO0ur/z2YXNuW6euXBju6T/ljUYZdQDjuGWBfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724074472; c=relaxed/simple;
	bh=9js+/ypq5ZKtYan1n6jFgYw5G1XGYN2iOC7HSou4EPY=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=NXYxoCHke7bR8Hi6BWuM6GYj907gQKMhHhKxZKdhYR3cTeZ+Pi3zFYfS7W7jm88S+vGMBz8nGtcAKqfznoplyWlYLdnPx2sA4/qgr5hVmGMgH3PETNJbk7Vr7qmaqrMZ524ofJ/YDbelnJdSN4IHWUT7/L73CLdZGXtYoZ5emUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=metaspace.dk; spf=pass smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace.dk header.i=@metaspace.dk header.b=HbiwAnbq; arc=none smtp.client-ip=185.70.40.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace.dk header.i=@metaspace.dk header.b="HbiwAnbq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=metaspace.dk;
	s=protonmail; t=1724074458; x=1724333658;
	bh=f5/YaG8ZkdvzUQ+iyW5AmjSuwGTKcptVabHcRzljnqc=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=HbiwAnbq4US5q79wHOkrRR6DKp9CsArJQ/b5tWugEQjWOx7Wtm7dcNTWconelvWAS
	 Bvph81PySyAoIjGp96FSg8YWf01m+0uTtEdyd2Dhk1VPCcKfuU8iv4rmFXzPCVRilE
	 EtDXzzpVfaqTPhta8090tchEAne/37z2g/Ve8tEZ2D7gaLEa+ANlwDdg7fujvaCqde
	 zwU2BxGvwb0LNMW0yC1WryZv2PGg9WKBdnkfvdJLvrPoqFp6ZeKWVe2W12TjE7IiY3
	 xADmhKChUQr1h2rZS5vygWfD2loLOkZsyIXwFGRBAf4vKQju6uUzFuAmCqVYdUM0KO
	 qDA5jqiXX3bjQ==
Date: Mon, 19 Aug 2024 13:34:13 +0000
To: Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>
From: Andreas Hindborg <nmi@metaspace.dk>
Cc: Andreas Hindborg <a.hindborg@samsung.com>, Adam Bratschi-Kaye <ark.email@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, Daniel Gomez <da.gomez@samsung.com>, rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] rust: add `module_params` macro
Message-ID: <20240819133345.3438739-1-nmi@metaspace.dk>
Feedback-ID: 113830118:user:proton
X-Pm-Message-ID: 3ea7ca1f46076a003f55a9bacd272fb2e39fb147
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

Link: https://github.com/Rust-for-Linux/linux/tree/bc22545f38d74473cfef3e9f=
d65432733435b79f [1]
Cc: Adam Bratschi-Kaye <ark.email@gmail.com>
Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>

---

Changes since v1 [2]:
- Remove support for params without values (`NOARG_ALLOWED`).
- Improve documentation for `try_from_param_arg`.
- Use prelude import.
- Refactor `try_from_param_arg` to return `Result`.
- Refactor `ParseInt::from_str` to return `Result`.
- Move C callable functions out of `ModuleParam` trait.
- Rename literal string field parser to `expect_string_field`.
- Move parameter parsing from generation to parsing stage.
- Use absolute type paths in macro code.
- Inline `kparam`and `read_func` values.
- Resolve TODO regarding alignment attributes.
- Remove unnecessary unsafe blocks in macro code.
- Improve error message for unrecognized parameter types.
- Do not use `self` receiver when reading parameter value.
- Add parameter documentation to `module!` macro.
- Use empty `enum` for parameter type.
- Use `addr_of_mut` to get address of parameter value variable.
- Enabled building of docs for for `module_param` module.

Link: https://lore.kernel.org/rust-for-linux/20240705111455.142790-1-nmi@me=
taspace.dk/ [2]
---
 rust/kernel/error.rs         |   2 -
 rust/kernel/lib.rs           |   1 +
 rust/kernel/module_param.rs  | 339 +++++++++++++++++++++++++++++++++++
 rust/macros/helpers.rs       |   8 +
 rust/macros/lib.rs           |  40 ++++-
 rust/macros/module.rs        | 229 ++++++++++++++++++++---
 samples/rust/rust_minimal.rs |  10 ++
 scripts/Makefile.build       |   2 +-
 8 files changed, 593 insertions(+), 38 deletions(-)
 create mode 100644 rust/kernel/module_param.rs

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 145f5c397009..8532a09947d4 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -312,8 +312,6 @@ pub(crate) fn from_err_ptr<T>(ptr: *mut T) -> Result<*m=
ut T> {
 ///     })
 /// }
 /// ```
-// TODO: Remove `dead_code` marker once an in-kernel client is available.
-#[allow(dead_code)]
 pub(crate) fn from_result<T, F>(f: F) -> T
 where
     T: From<i16>,
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 274bdc1b0a82..2840237eb73b 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -38,6 +38,7 @@
 pub mod ioctl;
 #[cfg(CONFIG_KUNIT)]
 pub mod kunit;
+pub mod module_param;
 #[cfg(CONFIG_NET)]
 pub mod net;
 pub mod page;
diff --git a/rust/kernel/module_param.rs b/rust/kernel/module_param.rs
new file mode 100644
index 000000000000..9dfee0311d65
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
+use crate::prelude::*;
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
+    /// Parse a parameter argument into the parameter value.
+    ///
+    /// `Err(_)` should be returned when parsing of the argument fails.
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
+    fn try_from_param_arg(arg: &'static [u8]) -> Result<Self>;
+
+    /// Get the current value of the parameter for use in the kernel modul=
e.
+    ///
+    /// This function should not be used directly. Instead use the wrapper
+    /// `read` which will be generated by [`macros::module`].
+    fn value(&self) -> &Self::Value;
+}
+
+/// Set the module parameter from a string.
+///
+/// Used to set the parameter value at kernel initialization, when loading
+/// the module or when set through `sysfs`.
+///
+/// `param.arg` is a pointer to `*mut T` as set up by the [`module!`]
+/// macro.
+///
+/// See `struct kernel_param_ops.set`.
+///
+/// # Safety
+///
+/// If `val` is non-null then it must point to a valid null-terminated
+/// string. The `arg` field of `param` must be an instance of `T`.
+///
+/// # Invariants
+///
+/// Currently, we only support read-only parameters that are not readable
+/// from `sysfs`. Thus, this function is only called at kernel
+/// initialization time, or at module load time, and we have exclusive
+/// access to the parameter for the duration of the function.
+///
+/// [`module!`]: macros::module
+unsafe extern "C" fn set_param<T>(
+    val: *const core::ffi::c_char,
+    param: *const crate::bindings::kernel_param,
+) -> core::ffi::c_int
+where
+    T: ModuleParam,
+{
+    // NOTE: If we start supporting arguments without values, val _is_ all=
owed
+    // to be null here.
+    assert!(!val.is_null());
+
+    // SAFETY: By function safety requirement, val is non-null and
+    // null-terminated. By C API contract, `val` is live and valid for rea=
ds
+    // for the duration of this function.
+    let arg =3D unsafe { CStr::from_char_ptr(val).as_bytes() };
+
+    crate::error::from_result(|| {
+        let new_value =3D T::try_from_param_arg(arg)?;
+
+        // SAFETY: `param` is guaranteed to be valid by C API contract
+        // and `arg` is guaranteed to point to an instance of `T`.
+        let old_value =3D unsafe { (*param).__bindgen_anon_1.arg as *mut T=
 };
+
+        // SAFETY: `old_value` is valid for writes, as we have exclusive
+        // access. `old_value` is pointing to an initialized static, an
+        // so it is properly initialized.
+        unsafe { core::ptr::replace(old_value, new_value) };
+        Ok(0)
+    })
+}
+
+/// Write a string representation of the current parameter value to `buf`.
+///
+/// # Safety
+///
+/// Must not be called.
+///
+/// # Note
+///
+/// This should not be called as we declare all parameters as read only.
+#[allow(clippy::extra_unused_type_parameters)]
+unsafe extern "C" fn get_param<T>(
+    _buf: *mut core::ffi::c_char,
+    _param: *const crate::bindings::kernel_param,
+) -> core::ffi::c_int
+where
+    T: ModuleParam,
+{
+    unreachable!("Parameters are not readable");
+}
+
+/// Drop the parameter.
+///
+/// Called when unloading a module.
+///
+/// # Safety
+///
+/// The `arg` field of `param` must be an initialized instance of `Self`.
+unsafe extern "C" fn free<T>(arg: *mut core::ffi::c_void)
+where
+    T: ModuleParam,
+{
+    // SAFETY: By function safety requirement, `arg` is an initialized
+    // instance of `T`. By C API contract, `arg` will not be used after
+    // this function returns.
+    unsafe { core::ptr::drop_in_place(arg as *mut T) };
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
+
+    // NOTE: Required because `checked_neg` is not provided by any trait.
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
+    fn from_str(src: &str) -> Result<Self> {
+        match src.bytes().next() {
+            None =3D> Err(EINVAL),
+            Some(b'-') =3D> Self::from_str_unsigned(&src[1..])
+                .map_err(|_| EINVAL)?
+                .checked_neg()
+                .ok_or(EINVAL),
+            Some(b'+') =3D> Self::from_str_unsigned(&src[1..]).map_err(|_|=
 EINVAL),
+            Some(_) =3D> Self::from_str_unsigned(src).map_err(|_| EINVAL),
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
+            fn try_from_param_arg(arg: &'static [u8]) -> Result<Self> {
+                let utf8 =3D core::str::from_utf8(arg)?;
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
+            flags: 0,
+            set: Some(set_param::<$ty>),
+            get: Some(get_param::<$ty>),
+            free: Some(free::<$ty>),
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
index 563dcd2b7ace..49388907370d 100644
--- a/rust/macros/helpers.rs
+++ b/rust/macros/helpers.rs
@@ -107,6 +107,14 @@ pub(crate) struct Generics {
     pub(crate) ty_generics: Vec<TokenTree>,
 }
=20
+pub(crate) fn expect_string_field(it: &mut token_stream::IntoIter, expecte=
d_name: &str) -> String {
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
diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index 159e75292970..1d7bc99ec5e0 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -20,6 +20,30 @@
 /// The `type` argument should be a type which implements the [`Module`]
 /// trait. Also accepts various forms of kernel metadata.
 ///
+/// The `params` field describe module parameters. Each entry has the form
+///
+/// ```ignore
+/// parameter_name: type {
+///     default: default_value,
+///     description: "Description",
+/// }
+/// ```
+///
+/// `type` may be one of
+///
+/// - `i8`
+/// - `u8`
+/// - `i8`
+/// - `u8`
+/// - `i16`
+/// - `u16`
+/// - `i32`
+/// - `u32`
+/// - `i64`
+/// - `u64`
+/// - `isize`
+/// - `usize`
+///
 /// C header: [`include/linux/moduleparam.h`](srctree/include/linux/module=
param.h)
 ///
 /// [`Module`]: ../kernel/trait.Module.html
@@ -36,21 +60,19 @@
 ///     description: "My very own kernel module!",
 ///     license: "GPL",
 ///     alias: ["alternate_module_name"],
+///     params: {
+///         my_parameter: i64 {
+///             default: 1,
+///             description: "This parameter has a default of 1",
+///         },
+///     },
 /// }
 ///
 /// struct MyModule;
 ///
 /// impl kernel::Module for MyModule {
 ///     fn init() -> Result<Self> {
-///         // If the parameter is writeable, then the kparam lock must be
-///         // taken to read the parameter:
-///         {
-///             let lock =3D THIS_MODULE.kernel_param_lock();
-///             pr_info!("i32 param is:  {}\n", writeable_i32.read(&lock))=
;
-///         }
-///         // If the parameter is read only, it can be read without locki=
ng
-///         // the kernel parameters:
-///         pr_info!("i32 param is:  {}\n", my_i32.read());
+///         pr_info!("i32 param is:  {}\n", module_parameters::my_paramete=
r::read());
 ///         Ok(Self)
 ///     }
 /// }
diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index 411dc103d82e..2fa9ed8e78ff 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
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
@@ -75,20 +83,135 @@ fn emit_base(&mut self, field: &str, content: &str, bu=
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
+            for param in params {
+                let ops =3D param_ops_path(&param.ptype);
+
+                self.emit_param("parmtype", &param.name, &param.ptype);
+                self.emit_param("parm", &param.name, &param.description);
+
+                write!(
+                    self.param_buffer,
+                    "
+                static mut __{name}_{param_name}_value: {param_type} =3D {=
param_default};
+
+                pub(crate) enum {param_name} {{}}
+
+                impl {param_name} {{
+                    pub(crate) fn read<'a>()
+                        -> &'a <{param_type} as ::kernel::module_param::Mo=
duleParam>::Value {{
+                        // Note: when we enable r/w parameters, we need to=
 lock here.
+
+                        // SAFETY: Parameters do not need to be locked bec=
ause they are
+                        // read only or sysfs is not enabled.
+                        unsafe {{
+                            <{param_type} as ::kernel::module_param::Modul=
eParam>::value(
+                                &__{name}_{param_name}_value
+                            )
+                        }}
+                    }}
+                }}
+
+                /// Newtype to make `bindings::kernel_param` `Sync`.
+                #[repr(transparent)]
+                struct __{name}_{param_name}_RacyKernelParam(::kernel::bin=
dings::kernel_param);
+
+                // SAFETY: C kernel handles serializing access to this typ=
e. We
+                // never access from Rust module.
+                unsafe impl Sync for __{name}_{param_name}_RacyKernelParam=
 {{ }}
+
+                #[cfg(not(MODULE))]
+                const __{name}_{param_name}_name: *const ::core::ffi::c_ch=
ar =3D
+                    b\"{name}.{param_name}\\0\" as *const _ as *const ::co=
re::ffi::c_char;
+
+                #[cfg(MODULE)]
+                const __{name}_{param_name}_name: *const ::core::ffi::c_ch=
ar =3D
+                    b\"{param_name}\\0\" as *const _ as *const ::core::ffi=
::c_char;
+
+                #[link_section =3D \"__param\"]
+                #[used]
+                static __{name}_{param_name}_struct: __{name}_{param_name}=
_RacyKernelParam =3D
+                    __{name}_{param_name}_RacyKernelParam(::kernel::bindin=
gs::kernel_param {{
+                        name: __{name}_{param_name}_name,
+                        // SAFETY: `__this_module` is constructed by the k=
ernel at load time
+                        // and will not be freed until the module is unloa=
ded.
+                        #[cfg(MODULE)]
+                        mod_: unsafe {{ &::kernel::bindings::__this_module=
 as *const _ as *mut _ }},
+                        #[cfg(not(MODULE))]
+                        mod_: ::core::ptr::null_mut(),
+                        ops: &{ops} as *const ::kernel::bindings::kernel_p=
aram_ops,
+                        perm: 0, // Will not appear in sysfs
+                        level: -1,
+                        flags: 0,
+                        __bindgen_anon_1:
+                            ::kernel::bindings::kernel_param__bindgen_ty_1=
 {{
+                                // SAFETY: As this is evaluated in const c=
ontext, it is
+                                // safe to take a reference to a mut stati=
c.
+                                arg: unsafe {{
+                                    ::core::ptr::addr_of_mut!(__{name}_{pa=
ram_name}_value)
+                                 }}.cast::<::core::ffi::c_void>(),
+                            }},
+                    }});
+                ",
+                    name =3D info.name,
+                    param_type =3D param.ptype,
+                    param_default =3D param.default,
+                    param_name =3D param.name,
+                    ops =3D ops,
+                )
+                .unwrap();
+            }
+        }
+    }
+}
+
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
+        t =3D> panic!("Unsupported parameter type {}", t),
     }
 }
=20
+fn expect_param_default(param_it: &mut token_stream::IntoIter) -> String {
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
@@ -98,6 +221,50 @@ struct ModuleInfo {
     description: Option<String>,
     alias: Option<Vec<String>>,
     firmware: Option<Vec<String>>,
+    params: Option<Vec<Parameter>>,
+}
+
+#[derive(Debug)]
+struct Parameter {
+    name: String,
+    ptype: String,
+    default: String,
+    description: String,
+}
+
+fn expect_params(it: &mut token_stream::IntoIter) -> Vec<Parameter> {
+    let params =3D expect_group(it);
+    assert_eq!(params.delimiter(), Delimiter::Brace);
+    let mut it =3D params.stream().into_iter();
+    let mut parsed =3D Vec::new();
+
+    loop {
+        let param_name =3D match it.next() {
+            Some(TokenTree::Ident(ident)) =3D> ident.to_string(),
+            Some(_) =3D> panic!("Expected Ident or end"),
+            None =3D> break,
+        };
+
+        assert_eq!(expect_punct(&mut it), ':');
+        let param_type =3D expect_ident(&mut it);
+        let group =3D expect_group(&mut it);
+        assert_eq!(group.delimiter(), Delimiter::Brace);
+        assert_eq!(expect_punct(&mut it), ',');
+
+        let mut param_it =3D group.stream().into_iter();
+        let param_default =3D expect_param_default(&mut param_it);
+        let param_description =3D expect_string_field(&mut param_it, "desc=
ription");
+        expect_end(&mut param_it);
+
+        parsed.push(Parameter {
+            name: param_name,
+            ptype: param_type,
+            default: param_default,
+            description: param_description,
+        })
+    }
+
+    parsed
 }
=20
 impl ModuleInfo {
@@ -112,6 +279,7 @@ fn parse(it: &mut token_stream::IntoIter) -> Self {
             "license",
             "alias",
             "firmware",
+            "params",
         ];
         const REQUIRED_KEYS: &[&str] =3D &["type", "name", "license"];
         let mut seen_keys =3D Vec::new();
@@ -140,6 +308,7 @@ fn parse(it: &mut token_stream::IntoIter) -> Self {
                 "license" =3D> info.license =3D expect_string_ascii(it),
                 "alias" =3D> info.alias =3D Some(expect_string_array(it)),
                 "firmware" =3D> info.firmware =3D Some(expect_string_array=
(it)),
+                "params" =3D> info.params =3D Some(expect_params(it)),
                 _ =3D> panic!(
                     "Unknown key \"{}\". Valid keys are: {:?}.",
                     key, EXPECTED_KEYS
@@ -183,28 +352,30 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream =
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
-    if let Some(firmware) =3D info.firmware {
+    if let Some(firmware) =3D &info.firmware {
         for fw in firmware {
-            modinfo.emit("firmware", &fw);
+            modinfo.emit("firmware", fw);
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
@@ -216,12 +387,14 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream =
{
             // SAFETY: `__this_module` is constructed by the kernel at loa=
d time and will not be
             // freed until the module is unloaded.
             #[cfg(MODULE)]
-            static THIS_MODULE: kernel::ThisModule =3D unsafe {{
-                kernel::ThisModule::from_ptr(&kernel::bindings::__this_mod=
ule as *const _ as *mut _)
+            static THIS_MODULE: ::kernel::ThisModule =3D unsafe {{
+                ::kernel::ThisModule::from_ptr(
+                    &::kernel::bindings::__this_module as *const _ as *mut=
 _
+                )
             }};
             #[cfg(not(MODULE))]
-            static THIS_MODULE: kernel::ThisModule =3D unsafe {{
-                kernel::ThisModule::from_ptr(core::ptr::null_mut())
+            static THIS_MODULE: ::kernel::ThisModule =3D unsafe {{
+                ::kernel::ThisModule::from_ptr(::core::ptr::null_mut())
             }};
=20
             // Double nested modules, since then nobody can access the pub=
lic items inside.
@@ -276,7 +449,8 @@ mod __module_init {{
                     #[doc(hidden)]
                     #[link_section =3D \"{initcall_section}\"]
                     #[used]
-                    pub static __{name}_initcall: extern \"C\" fn() -> cor=
e::ffi::c_int =3D __{name}_init;
+                    pub static __{name}_initcall: extern \"C\" fn()
+                        -> ::core::ffi::c_int =3D __{name}_init;
=20
                     #[cfg(not(MODULE))]
                     #[cfg(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS)]
@@ -291,7 +465,7 @@ mod __module_init {{
                     #[cfg(not(MODULE))]
                     #[doc(hidden)]
                     #[no_mangle]
-                    pub extern \"C\" fn __{name}_init() -> core::ffi::c_in=
t {{
+                    pub extern \"C\" fn __{name}_init() -> ::core::ffi::c_=
int {{
                         // SAFETY: This function is inaccessible to the ou=
tside due to the double
                         // module wrapping it. It is called exactly once b=
y the C side via its
                         // placement above in the initcall section.
@@ -314,8 +488,8 @@ mod __module_init {{
                     /// # Safety
                     ///
                     /// This function must only be called once.
-                    unsafe fn __init() -> core::ffi::c_int {{
-                        match <{type_} as kernel::Module>::init(&super::su=
per::THIS_MODULE) {{
+                    unsafe fn __init() -> ::core::ffi::c_int {{
+                        match <{type_} as ::kernel::Module>::init(&super::=
super::THIS_MODULE) {{
                             Ok(m) =3D> {{
                                 // SAFETY: No data race, since `__MOD` can=
 only be accessed by this
                                 // module and there only `__init` and `__e=
xit` access it. These
@@ -346,14 +520,17 @@ unsafe fn __exit() {{
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
index 2a9eaab62d1c..d9bc2218d504 100644
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
+            *module_parameters::test_parameter::read()
+        );
=20
         let mut numbers =3D Vec::new();
         numbers.push(72, GFP_KERNEL)?;
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index efacca63c897..a65bd0233843 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -263,7 +263,7 @@ $(obj)/%.lst: $(obj)/%.c FORCE
 # Compile Rust sources (.rs)
 # ------------------------------------------------------------------------=
---
=20
-rust_allowed_features :=3D new_uninit
+rust_allowed_features :=3D new_uninit,const_mut_refs
=20
 # `--out-dir` is required to avoid temporaries being created by `rustc` in=
 the
 # current working directory, which may be not accessible in the out-of-tre=
e

base-commit: 7c626ce4bae1ac14f60076d00eafe71af30450ba
--=20
2.46.0



