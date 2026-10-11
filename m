Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D1A3C76AD;
	Sun, 11 Oct 2026 12:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791723191; cv=none; b=qhO+P0ODyBI3eiaPl1WSSQ+rDuHxFSy/9OCwdVk0/1wjH4Hs6MKh3AmhnlWzFitabyPWQLAB2RH+OAat5AE7JZo9qmt1lWCEMTiUGHNfjSQbW0IWog/OIOUXs36lqAMyY5s5oVj71w3GeCoV3sIHbYp0LJTVdjb/1WtG+T0oBt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791723191; c=relaxed/simple;
	bh=ksWwlWRvqo8LrD2HrKTHz/EuYt0ywjdJyChTACPDpUg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kwSDxs2wC/W6VchklwmjepMIvAmYUR8xCu+W2vA6R+dm6Oc1E48xb7P+c3Kw0jNb+pKc7mjVQaaSgyowdgyxKMBwnQEVn3Pd5njpRjOUOHbwxBdaAD3xbmOfVJWPnLV0c5xJ/fO6q9CoHOkCsyGG6JKIT/xXru7VRBXh7DqMUZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=DyNGD3UT; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="DyNGD3UT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1791723178;
	bh=ksWwlWRvqo8LrD2HrKTHz/EuYt0ywjdJyChTACPDpUg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DyNGD3UT88g8nyIQS7Xgp1PqjZCHdIb10pzEajy4MfdOSh73lUQfQOPRDITz36o4x
	 Srx/O7xQaDGxqCLx+S8gVItDAHEM2wV9cCm7OHdnqhpSzmMZ3aTSZgvKMl6Lnv6ilM
	 DIxDOFMEDKxuH7H4jymBQhCYhZ2PZaApyXYcrJAs=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 11 Oct 2026 14:52:25 +0200
Subject: [PATCH RFC 01/11] rust: print: use CStr for __LOG_PREFIX
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261011-rust-dyndbg-v1-1-832e4039b71f@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791723177; l=5081;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=ksWwlWRvqo8LrD2HrKTHz/EuYt0ywjdJyChTACPDpUg=;
 b=3NEW2rGeYpgWpCjJjnO6Hsf+44NjvM/zYQrLzpaqSbd4+avaIHy6KBVX35PN8lkiE0vMOv1dm
 XHhq470YjsBCZkINqTmSnTWYLViYwYzyukg93aTuPJhpKtflt3lXUTS
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The users of __LOG_PREFIX require that it is 0-terminated.
Currently this requirement is only encoded in safety comments.

Switch to CStr which can guarantee this invariant through the type
system.

As __LOG_PREFIX and Module::NAME are now identical, reuse the former to
implement the latter.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 rust/kernel/lib.rs          |  4 ++--
 rust/kernel/print.rs        | 11 ++++-------
 rust/macros/module.rs       |  4 ++--
 scripts/rustdoc_test_gen.rs |  4 ++--
 4 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 7225abc64084..7d48f931877d 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -159,7 +159,7 @@
 pub use uapi;
 
 /// Prefix to appear before log messages printed from within the `kernel` crate.
-const __LOG_PREFIX: &[u8] = b"rust_kernel\0";
+const __LOG_PREFIX: &str::CStr = c"rust_kernel";
 
 /// Dummy module type for `#[vtable]` `impl` blocks within the `kernel` crate (e.g. KUnit tests).
 // The `allow` is needed since it may be unused (e.g. KUnit tests may be disabled).
@@ -167,7 +167,7 @@
 struct LocalModule;
 
 impl ModuleMetadata for LocalModule {
-    const NAME: &'static str::CStr = c"rust_kernel";
+    const NAME: &'static str::CStr = __LOG_PREFIX;
 
     const THIS_MODULE: ThisModule = {
         // SAFETY: `try_module_get`/`module_put` handle null module pointers gracefully.
diff --git a/rust/kernel/print.rs b/rust/kernel/print.rs
index 0d62beeedca5..9ce52b9fa69f 100644
--- a/rust/kernel/print.rs
+++ b/rust/kernel/print.rs
@@ -96,15 +96,14 @@ pub mod format_strings {
 ///
 /// # Safety
 ///
-/// The format string must be one of the ones in [`format_strings`], and
-/// the module name must be null-terminated.
+/// The format string must be one of the ones in [`format_strings`].
 ///
 /// [`_printk`]: srctree/include/linux/printk.h
 #[doc(hidden)]
 #[cfg_attr(not(CONFIG_PRINTK), allow(unused_variables))]
 pub unsafe fn call_printk(
     format_string: &[u8; format_strings::LENGTH],
-    module_name: &[u8],
+    module_name: &CStr,
     args: fmt::Arguments<'_>,
 ) {
     // `_printk` does not seem to fail in any path.
@@ -113,7 +112,7 @@ pub unsafe fn call_printk(
     unsafe {
         bindings::_printk(
             format_string.as_ptr(),
-            module_name.as_ptr(),
+            module_name.as_char_ptr(),
             core::ptr::from_ref(&args).cast::<c_void>(),
         );
     }
@@ -157,9 +156,7 @@ macro_rules! print_macro (
         match $crate::prelude::fmt!($($arg)+) {
             // SAFETY: This hidden macro should only be called by the documented
             // printing macros which ensure the format string is one of the fixed
-            // ones. All `__LOG_PREFIX`s are null-terminated as they are generated
-            // by the `module!` proc macro or fixed values defined in a kernel
-            // crate.
+            // ones.
             args => unsafe {
                 $crate::print::call_printk(
                     &$format_string,
diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index 0a7b9e24c960..6228fe23c310 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -496,14 +496,14 @@ pub(crate) fn module(info: ModuleInfo) -> Result<TokenStream> {
         /// The module name.
         ///
         /// Used by the printing macros, e.g. [`info!`].
-        const __LOG_PREFIX: &[u8] = #name_cstr.to_bytes_with_nul();
+        const __LOG_PREFIX: &::kernel::str::CStr = #name_cstr;
 
         /// The `LocalModule` type is the type of the module created by `module!`,
         /// `module_pci_driver!`, `module_platform_driver!`, etc.
         type LocalModule = #type_;
 
         impl ::kernel::ModuleMetadata for #type_ {
-            const NAME: &'static ::kernel::str::CStr = #name_cstr;
+            const NAME: &'static ::kernel::str::CStr = __LOG_PREFIX;
 
             #[cfg(MODULE)]
             const THIS_MODULE: ::kernel::ThisModule = {
diff --git a/scripts/rustdoc_test_gen.rs b/scripts/rustdoc_test_gen.rs
index 754c5aafcce4..488de817b425 100644
--- a/scripts/rustdoc_test_gen.rs
+++ b/scripts/rustdoc_test_gen.rs
@@ -224,7 +224,7 @@ macro_rules! line {{
         BufWriter::new(File::create("rust/doctests_kernel_generated.rs").unwrap()),
         r#"//! `kernel` crate documentation tests.
 
-const __LOG_PREFIX: &[u8] = b"rust_doctests_kernel\0";
+const __LOG_PREFIX: &kernel::str::CStr = c"rust_doctests_kernel";
 
 /// Dummy module type for doctest context.
 struct LocalModule;
@@ -237,7 +237,7 @@ macro_rules! line {{
 use core::ptr::null_mut;
 
 impl ModuleMetadata for LocalModule {{
-    const NAME: &'static CStr = c"rust_doctests_kernel";
+    const NAME: &'static CStr = __LOG_PREFIX;
     const THIS_MODULE: ThisModule = {{
         // SAFETY: `try_module_get`/`module_put` handle null module pointers gracefully.
         unsafe {{ ThisModule::from_ptr(null_mut()) }}

-- 
2.56.0

