Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7456B38A9AE;
	Wed,  7 Jan 2026 16:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767803473; cv=none; b=i6R7ue2xcUJ0zZJdyb1Wbzalhc4gOmG7z0GRKp6JyGBbwhLXAsHYYAkpeZhYV3Xhg0hZ6lxK2JieAF5rOqB4Rc+WKr4Y3Q4fiS2Funry/lMADgK2rmdFn71fdy/v+WPUBcy5RapDwEwUX9Mzdck1VAQxBBHRoI0wpudFQj/ip68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767803473; c=relaxed/simple;
	bh=mSog3eRb67MjN/N9WM4h+cq8zwTKnd1clqBLd9NlkG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j77ccbclCnNNGRNfzJzNWALa7G2BnYc3MNysOWkc7kL41uKGd2inC/Cn328nFgEyRfENoq/fDoM5JlyUMF1fJJxdSUkK3CJlej3L1LpvKmC3uViYcoFEbzrkpUHhNlkQuYLqK2M0Z/NPTS1YoAgKBKQYLnnd0KLD3+GA/7UWrZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cA2ZBbbU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cA2ZBbbU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD04C4CEF1;
	Wed,  7 Jan 2026 16:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767803471;
	bh=mSog3eRb67MjN/N9WM4h+cq8zwTKnd1clqBLd9NlkG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=cA2ZBbbUkpVPdKM0AK8BMBgVwtk9OXyC5NObngrNQ8p9lPtf+5qhWxfh7ubKiyPV4
	 38NpGd3Lba9oNFwvkDX5BpBSxW+GfvM1trYwNp1u4pHMFcckHhTICZnHLT4RzYGyPS
	 zpHGCwmQcDweOcm1zVMFBdBKYBjSFMN1yZDPoiJlVSatbN92Y0uZ6dzvVg9yyzchMu
	 RmQ4WcFzuRJcmBuHIy6NABqkeDgY5CsTx22WRJ6ozvHxArjbgXay7pPp2h5pzgad+y
	 fptfcz26aoL2z685jx2ddmb0CEDZ/tehZhCQdFw0z/tQhgJdy7TQwWK5cWc6Gc4iHJ
	 4kRx3LgDMdK2g==
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
Subject: [PATCH v2 09/11] rust: macros: allow arbitrary types to be used in `module!` macro
Date: Wed,  7 Jan 2026 16:15:48 +0000
Message-ID: <20260107161729.3855851-10-gary@kernel.org>
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

Previously this only accepts an identifier, but now with `syn` it is
easy to make it accepts any type.

Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/macros/module.rs | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index ba345d672839e..31d39764c6926 100644
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
@@ -376,7 +377,7 @@ fn parse(input: ParseStream<'_>) -> Result<Self> {
 }
 
 pub(crate) struct ModuleInfo {
-    type_: Ident,
+    type_: Type,
     license: AsciiLitStr,
     name: AsciiLitStr,
     authors: Option<Punctuated<AsciiLitStr, Token![,]>>,
@@ -536,7 +537,6 @@ impl ::kernel::ModuleMetadata for #type_ {
         // Double nested modules, since then nobody can access the public items inside.
         mod __module_init {
             mod __module_init {
-                use super::super::#type_;
                 use pin_init::PinInit;
 
                 /// The "Rust loadable module" mark.
@@ -548,7 +548,7 @@ mod __module_init {
                 #[used(compiler)]
                 static __IS_RUST_MODULE: () = ();
 
-                static mut __MOD: ::core::mem::MaybeUninit<#type_> =
+                static mut __MOD: ::core::mem::MaybeUninit<super::super::LocalModule> =
                     ::core::mem::MaybeUninit::uninit();
 
                 // Loadable modules need to export the `{init,cleanup}_module` identifiers.
@@ -635,8 +635,9 @@ pub extern "C" fn #ident_exit() {
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

