Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299313321D4;
	Wed,  7 Jan 2026 16:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767803478; cv=none; b=Dv/FV+2XPNxCq/NiJpfK4WpMC+uRTwftgcqKJc0kLd4YRxBkkFPyZhqlEkAfTAJIrltz8zZz/xVkr+v7qvYzM+gx+WQwZwuvr8d41ty3ZBCs+44yBaQy+0uTpTK/wRwEqMl8/drvmrAjr4XNQGulDgTtyunW7UwGPN1sTaxex1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767803478; c=relaxed/simple;
	bh=sVyKAeAHMe+9/vCmBslwQga38MUmsMxubIifg87RqR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D3fC8sI+6B2smcmVGuGFgIuagDY4SadfG9+V5Sz+UkhYZ0rm8S7HyGG719JMzE82nKiW1Qa1N8/e3QXW8vDdEgQYLdkg18SKDwKS1+wYAtZ9zfej8W1/+JkkW4/gmD5qqG+EDmxqhNm1FYw7hLagPlV6cpaB/vLog9VXjNDvsUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zksd2bMD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zksd2bMD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1746DC4CEF7;
	Wed,  7 Jan 2026 16:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767803475;
	bh=sVyKAeAHMe+9/vCmBslwQga38MUmsMxubIifg87RqR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=Zksd2bMDNUaTEu2Fn577nRmW4U96N5Pp0SwsscGD51olqunwX5NRcn58OljmNiMr1
	 OcGk031Zo1gzSlg77OSN7Uh9UqwDNt8J7+jz/Hb5zZiC8nQ850S9an1CslIaMHOcWT
	 GBS5AEkT8zPBfvRy23xFDKiK7ZaDqjfvxBRJLisAvkJ3/drFoqCs+p0OKf+wukg5/G
	 oDGB8Kl8pkJrEqKzquZ9yROY8NDJaJ35G4R3Jjnvp44qkPszYoTVmYlrcg+4mersPF
	 sFvffg4Nxo4PV2RDj1HD3JvGv1EXel8nuAB8ubIQ2CsIDD6LZA58q08NaspoaA15Ha
	 3upaHR4ZDRFlg==
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
Subject: [PATCH v2 10/11] rust: macros: rearrange `#[doc(hidden)]` in `module!` macro
Date: Wed,  7 Jan 2026 16:15:49 +0000
Message-ID: <20260107161729.3855851-11-gary@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260107161729.3855851-1-gary@kernel.org>
References: <20260107161729.3855851-1-gary@kernel.org>
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
index 31d39764c6926..c86cced5e0e8f 100644
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
@@ -535,6 +534,7 @@ impl ::kernel::ModuleMetadata for #type_ {
         }
 
         // Double nested modules, since then nobody can access the public items inside.
+        #[doc(hidden)]
         mod __module_init {
             mod __module_init {
                 use pin_init::PinInit;
@@ -544,7 +544,6 @@ mod __module_init {
                 // This may be best done another way later on, e.g. as a new modinfo
                 // key or a new section. For the moment, keep it simple.
                 #[cfg(MODULE)]
-                #[doc(hidden)]
                 #[used(compiler)]
                 static __IS_RUST_MODULE: () = ();
 
@@ -557,7 +556,6 @@ mod __module_init {
                 /// This function must not be called after module initialization, because it may be
                 /// freed after that completes.
                 #[cfg(MODULE)]
-                #[doc(hidden)]
                 #[no_mangle]
                 #[link_section = ".init.text"]
                 pub unsafe extern "C" fn init_module() -> ::kernel::ffi::c_int {
@@ -568,14 +566,12 @@ mod __module_init {
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
@@ -589,7 +585,6 @@ pub extern "C" fn cleanup_module() {
                 }
 
                 #[cfg(MODULE)]
-                #[doc(hidden)]
                 #[used(compiler)]
                 #[link_section = ".exit.data"]
                 static __UNIQUE_ID___addressable_cleanup_module: extern "C" fn() = cleanup_module;
@@ -598,7 +593,6 @@ pub extern "C" fn cleanup_module() {
                 // and the identifiers need to be unique.
                 #[cfg(not(MODULE))]
                 #[cfg(not(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS))]
-                #[doc(hidden)]
                 #[link_section = #initcall_section]
                 #[used(compiler)]
                 pub static #ident_initcall: extern "C" fn() ->
@@ -609,7 +603,6 @@ pub extern "C" fn cleanup_module() {
                 ::core::arch::global_asm!(#global_asm);
 
                 #[cfg(not(MODULE))]
-                #[doc(hidden)]
                 #[no_mangle]
                 pub extern "C" fn #ident_init() -> ::kernel::ffi::c_int {
                     // SAFETY: This function is inaccessible to the outside due to the double
@@ -619,7 +612,6 @@ pub extern "C" fn #ident_init() -> ::kernel::ffi::c_int {
                 }
 
                 #[cfg(not(MODULE))]
-                #[doc(hidden)]
                 #[no_mangle]
                 pub extern "C" fn #ident_exit() {
                     // SAFETY:
-- 
2.51.2

