Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4649237419D;
	Mon, 12 Jan 2026 17:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768237918; cv=none; b=IExKl1VNt4Ro0c+M+IUT7XDNiZq8dBg1wJtMgQDGZrNm5BQqXHV2DwoDSd/rfdW9e/CxA8mZbB8dgXAyCUz1mL08Ks8ZLfU1CS1t82XyGQsOXy7rXf30kufCJWW1VwSaeMI3YRBXNF3s6YaIzaPB6/WWbeyTV+fAzCaP9/x/wFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768237918; c=relaxed/simple;
	bh=/V4yd3pW/y4F+wfHGVv64QUmsW0PH0YPeAL8gS44IsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CYC1KBWyTQHD8FRIhyfFh6tDVyQGJIZzLg1UUznjpGIsy/+U0OkRrPplV5EBpSKzXqJTkRDbUdCckC//10RilmT+e+L6XgO3UGYHLCzBshpsLOMEfJtSEykL4x9IuYhzDUcYZz6L1C/HLsatFflCG38xtT2v7fXFM4l2/NEMULg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jv1cjjKM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jv1cjjKM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E940FC2BC86;
	Mon, 12 Jan 2026 17:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768237918;
	bh=/V4yd3pW/y4F+wfHGVv64QUmsW0PH0YPeAL8gS44IsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=Jv1cjjKMRiS3dJSICTFzHV9dJejqn40/LJIof8/EFQQJMY0ix4+wF16vDSqsNOQnp
	 oXi6HHnHpiKdIYtztQUr8zWpNLDpr4BinYcFtAsEEz1RUEUINJ7rlA4DVQfSE7FVse
	 teKRTDCLI56iGtEMhFbeZrbucQVh+fOxMRAigCKynKgfDvm2EG/qfbu1YRpBCQ5bwr
	 NurFeqknvvAib2v+9ntKqAZuWZaSfWjZOoj/zQ8sMW4T/uY4nFLl6KxD2zhC68l5GO
	 vbOmebB0cluFcODqWHETKL4BpV1RCbnY6HoDxX57sLYiMa9rleu/+aK/8Yl+QwrO7V
	 hW2H//vkpqwoA==
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
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/12] rust: macros: allow arbitrary types to be used in `module!` macro
Date: Mon, 12 Jan 2026 17:07:20 +0000
Message-ID: <20260112170919.1888584-10-gary@kernel.org>
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

Previously this only accepts an identifier, but now with `syn` it is
easy to make it accepts any type.

Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/macros/module.rs | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index 43ada49525c9d..9e0242d42d51f 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -26,7 +26,8 @@
     LitStr,
     Path,
     Result,
-    Token, //
+    Token,
+    Type, //
 };
 
 use crate::helpers::*;
@@ -370,7 +371,7 @@ fn parse(input: ParseStream<'_>) -> Result<Self> {
 }
 
 pub(crate) struct ModuleInfo {
-    type_: Ident,
+    type_: Type,
     license: AsciiLitStr,
     name: AsciiLitStr,
     authors: Option<Punctuated<AsciiLitStr, Token![,]>>,
@@ -529,7 +530,6 @@ impl ::kernel::ModuleMetadata for #type_ {
         // Double nested modules, since then nobody can access the public items inside.
         mod __module_init {
             mod __module_init {
-                use super::super::#type_;
                 use pin_init::PinInit;
 
                 /// The "Rust loadable module" mark.
@@ -541,7 +541,7 @@ mod __module_init {
                 #[used(compiler)]
                 static __IS_RUST_MODULE: () = ();
 
-                static mut __MOD: ::core::mem::MaybeUninit<#type_> =
+                static mut __MOD: ::core::mem::MaybeUninit<super::super::LocalModule> =
                     ::core::mem::MaybeUninit::uninit();
 
                 // Loadable modules need to export the `{init,cleanup}_module` identifiers.
@@ -628,8 +628,9 @@ pub extern "C" fn #ident_exit() {
                 ///
                 /// This function must only be called once.
                 unsafe fn __init() -> ::kernel::ffi::c_int {
-                    let initer =
-                        <#type_ as ::kernel::InPlaceModule>::init(&super::super::THIS_MODULE);
+                    let initer = <super::super::LocalModule as ::kernel::InPlaceModule>::init(
+                        &super::super::THIS_MODULE
+                    );
                     // SAFETY: No data race, since `__MOD` can only be accessed by this module
                     // and there only `__init` and `__exit` access it. These functions are only
                     // called once and `__exit` cannot be called before or during `__init`.
-- 
2.51.2

