Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3744936CDE7;
	Mon, 12 Jan 2026 17:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768237922; cv=none; b=oejUgpQP2bBIs314FUQEPSz78RCyvuNNacNwW/Zz2gtgkWitWfarcQaGLNLj+lV5XPWfWJER4D99EFACrnX6qzI34orzBc2M2H3iq2TkxVunpC1PfhIHdytnjRk9L/fwNxpqCEjsR+g45f41bqnx7bjtYQ4kz9LFhZnnpSpfPu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768237922; c=relaxed/simple;
	bh=LRKQqHzDCx7LA6zyhA6WTRPZ4R78v39BxwX+QL/wIUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aLT/wU3crIut0uKTulZONoFWR9O6cry4Y3DJF/K9m5ag9qP8CBYOG4dkhhnLVHZDrSlgNlVTHwuNWJCY2AeSmQtYDwEMOarWkjah1bw460JumwEAuxmEWO9jcrYw3hHE/1EjKyXvkMPHidar32nvIyGsHdER2fznkySrW+JigB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vFPlHsfj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vFPlHsfj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D000BC19422;
	Mon, 12 Jan 2026 17:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768237922;
	bh=LRKQqHzDCx7LA6zyhA6WTRPZ4R78v39BxwX+QL/wIUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=vFPlHsfj9PjGqbQUjg0wO1Ml+KU+UdygS8tz1yiWHsZeWI+0Ra/QZCWNtM2XoB5xq
	 h1icuQLlyXcJXuVBU03yyqeJJ3aYcpeOSGo6R/VYYA1M4NZN3AMndD73rXRNBsuBwJ
	 VFogYNdxxR7kvIQ3RoHPOKqSLinhqbTYy6k3mGi9Y4QUNmBEN8D1Bfl5IFfckvweyW
	 KOIPoeVA2HQdOpemwtJW1mgioF4CixTJYP7kAeskyrTT6Aacpie7Qb/KxOjytBpEUh
	 SsSPoWKaGRVY7RExahqZSIO5cbv3KxzGEdYpe2adMjfEZhOVRoQr5zqDBvX7D1nWu9
	 doG1KGhPiQFCQ==
From: Gary Guo <gary@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>
Cc: rust-for-linux@vger.kernel.org,
	Tamir Duberstein <tamird@gmail.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/12] rust: macros: rearrange `#[doc(hidden)]` in `module!` macro
Date: Mon, 12 Jan 2026 17:07:21 +0000
Message-ID: <20260112170919.1888584-11-gary@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260112170919.1888584-1-gary@kernel.org>
References: <20260112170919.1888584-1-gary@kernel.org>
Reply-To: Gary Guo <gary@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gary Guo <gary@garyguo.net>

This `#[doc(hidden)]` can just be applied on a module to hide anything
within.

Reviewed-by: Tamir Duberstein <tamird@gmail.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/macros/module.rs | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index 9e0242d42d51f..e16298e520c78 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -77,7 +77,6 @@ fn emit_base(&mut self, field: &str, content: &str, builtin: bool, param: bool)
         );
         let item = quote! {
             #cfg
-            #[doc(hidden)]
             #[cfg_attr(not(target_os = "macos"), link_section = ".modinfo")]
             #[used(compiler)]
             pub static #counter: [u8; #length] = *#string;
@@ -528,6 +527,7 @@ impl ::kernel::ModuleMetadata for #type_ {
         }
 
         // Double nested modules, since then nobody can access the public items inside.
+        #[doc(hidden)]
         mod __module_init {
             mod __module_init {
                 use pin_init::PinInit;
@@ -537,7 +537,6 @@ mod __module_init {
                 // This may be best done another way later on, e.g. as a new modinfo
                 // key or a new section. For the moment, keep it simple.
                 #[cfg(MODULE)]
-                #[doc(hidden)]
                 #[used(compiler)]
                 static __IS_RUST_MODULE: () = ();
 
@@ -550,7 +549,6 @@ mod __module_init {
                 /// This function must not be called after module initialization, because it may be
                 /// freed after that completes.
                 #[cfg(MODULE)]
-                #[doc(hidden)]
                 #[no_mangle]
                 #[link_section = ".init.text"]
                 pub unsafe extern "C" fn init_module() -> ::kernel::ffi::c_int {
@@ -561,14 +559,12 @@ mod __module_init {
                 }
 
                 #[cfg(MODULE)]
-                #[doc(hidden)]
                 #[used(compiler)]
                 #[link_section = ".init.data"]
                 static __UNIQUE_ID___addressable_init_module: unsafe extern "C" fn() -> i32 =
                     init_module;
 
                 #[cfg(MODULE)]
-                #[doc(hidden)]
                 #[no_mangle]
                 #[link_section = ".exit.text"]
                 pub extern "C" fn cleanup_module() {
@@ -582,7 +578,6 @@ pub extern "C" fn cleanup_module() {
                 }
 
                 #[cfg(MODULE)]
-                #[doc(hidden)]
                 #[used(compiler)]
                 #[link_section = ".exit.data"]
                 static __UNIQUE_ID___addressable_cleanup_module: extern "C" fn() = cleanup_module;
@@ -591,7 +586,6 @@ pub extern "C" fn cleanup_module() {
                 // and the identifiers need to be unique.
                 #[cfg(not(MODULE))]
                 #[cfg(not(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS))]
-                #[doc(hidden)]
                 #[link_section = #initcall_section]
                 #[used(compiler)]
                 pub static #ident_initcall: extern "C" fn() ->
@@ -602,7 +596,6 @@ pub extern "C" fn cleanup_module() {
                 ::core::arch::global_asm!(#global_asm);
 
                 #[cfg(not(MODULE))]
-                #[doc(hidden)]
                 #[no_mangle]
                 pub extern "C" fn #ident_init() -> ::kernel::ffi::c_int {
                     // SAFETY: This function is inaccessible to the outside due to the double
@@ -612,7 +605,6 @@ pub extern "C" fn #ident_init() -> ::kernel::ffi::c_int {
                 }
 
                 #[cfg(not(MODULE))]
-                #[doc(hidden)]
                 #[no_mangle]
                 pub extern "C" fn #ident_exit() {
                     // SAFETY:
-- 
2.51.2

