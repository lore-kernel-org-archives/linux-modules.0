Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2D9322B96
	for <linux-modules@vger.kernel.org>; Thu, 26 Feb 2026 23:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772149661; cv=none; b=g0eIvkyv3hnuuwikjmdz0SDBZSn+vrQ/WQwjh116NN7MGRIVESvnQKE7Vs7NmQ/1Vcdwcws4PHhMTR5B/rZqlKEKYuCEWMG8SdTM5QXmI5z8Oc8jEVvr12RJO6lzVLKrSARk6ewHRXV85dFPMUqgSqF/yuVPnfrA4ydIUsQXGAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772149661; c=relaxed/simple;
	bh=muxh3fCFRhSf9Unv2vBe0W+v1Z0hoW/CIg7AHgZRxaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y3INkyDjC66EE9L8Axvmh7dtNnm9M5MBxpsKeEYifTPs0L04Fj+65cKIsgEfRRxlC3Se18o5JsK4SYWAF8oLgQZHLemn27JW5zgop8iAjhqt/elYVwgPuHkpP9QHMPDKCpr4kGjQK0+y0RwHd0drnsMSfLD1QnZEYFlL3YqDPNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EX/VZ7n4; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EX/VZ7n4"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1275750cfc7so2116719c88.0
        for <linux-modules@vger.kernel.org>; Thu, 26 Feb 2026 15:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772149660; x=1772754460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOJAuKmw4q0dzp0Ep92fm1clLy9bI5rwzposWVs1Z0k=;
        b=EX/VZ7n48a7dg7o4vgOtulAQFW7a9o8lBRcfmJ0uIbupnWZswyr7EOzckc3ZO59nm2
         nKdbuYWIVYTmhP+M3cXwh2s7QW4O+W5NTvUdGq0D3lujNhRghg4ABgcE6KdmE9mn/36q
         A6h9m/P4sl4+Pkj32k+hAFPTCvXi7Y5gzuzXuX//gWB19cyvqEYw19oKmsHDeeC/8/0p
         KGMbvGkUdHbmWV/ceBFFqvKm/Q28HpqpQTbBIU4eYHgrxi58vPlqBVQtD6yFxrm6chhr
         cZ+SPiTsqOhwlAQqlK+Wr9OtkUdiQo24XN4Jn/utzAe37IphwIV0KiaEJET+vCmjKYb0
         AgHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772149660; x=1772754460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iOJAuKmw4q0dzp0Ep92fm1clLy9bI5rwzposWVs1Z0k=;
        b=o3M5YKlEj/0FITLCVc4XY7i2yHzxJxPWwVmU8QJpn4oYmYHGAZ4xAwn2tN0u3o2xun
         gHuBka7Xji85Y0lQmV1AIki7Ou/fRI8dw2lq8703+d90jM/VjerUKU2ws4VjWeeKlHyU
         hx9w/xUVDf6eAioyW/BTZA1QNsJPZfMhCJi7cwgrxR/PAtAYyfD01+pOaCg/yFOBREUo
         GTPEIoGwZHLmQAaCNrHepl9PX/fSc36s8I6OBfj8Pu6t91GWc0LDlQuTSwxMU1Y0KRSq
         8+gSpLhTxe2DLZPpQKrNSUXmvPRtHv5i0lEEbZvPB7BUqhvoyk3msYzj9XbeVKwlV8tC
         yvrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUFXBjH1P9whcwYQ+JLYM6kgWh/X9MU/clYWWaaAd5V09lKgvWTC6VaBqlpPz7WYAGiUXKSyolhitTkBjQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0uPAjxrzcgXsHP2fT2fj7BlOaBCBX02i2sfGCCSYoeYNlewlq
	cwHMRiUaRj1PUcKIBKY5K9QmRgwCSp7S0fljDf8alvvnfMqm4IjExI2X
X-Gm-Gg: ATEYQzzh6OLhzod5rUFr5ISF+l95cdSKr/at1nOtMKZb3fY6EtCYX0Ze5+EcMqQB0PO
	ZtB8vfR5HHTXjFYVUYNx520TDZoL2v87KwBXjN1bxROCQvvUnVB/qoULaVPfk8QodWEIi7wBAws
	CZUXXXd6+RbyknyyHdEYZqmkOo0IW5l5TXjPGYvhgPFypMQhSdom6cA9rKfip6KPKmaVyxzKUNQ
	MqR2O9O8qV64ALMNtzeFAk6Si1ZwKD2kntkWtsyClsb+oB0cWbw4Y7uJeHtYeGfYRTXaDes4Jsx
	f+yoqq7K7I41D6eYUsUdD/id/4zg6HfikFL8LAQDkTV7vPHiJSHd+XzCv0ycpmqTTePDjPLwxv6
	0hsm6j/75Gbbesx5W9VsYnDbA1yhTgSo9hkul53O432eT/0YOyglaIu1N8LUeM0lVr2ypQgiskJ
	AuxlD9jBfOKfOgPXoHZasQPrO4N3qEb2BZnQBxf3ylruAQyavig8ozXfZOYq2KruDSLIA8FVQYo
	MdGcWEo5hsM
X-Received: by 2002:a05:7022:4583:b0:127:5cda:fb7d with SMTP id a92af1059eb24-1278fc2c5fbmr491168c88.6.1772149659700;
        Thu, 26 Feb 2026 15:47:39 -0800 (PST)
Received: from localhost (99-122-55-39.lightspeed.sntcca.sbcglobal.net. [99.122.55.39])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127899ea1e5sm4259846c88.7.2026.02.26.15.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 15:47:39 -0800 (PST)
From: Matthew Wood <thepacketgeek@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Tamir Duberstein <tamird@kernel.org>,
	David Gow <davidgow@google.com>,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
	linux-modules@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] rust: module_param: wire StringParam into the module! macro
Date: Thu, 26 Feb 2026 15:47:28 -0800
Message-ID: <20260226234736.428341-3-thepacketgeek@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260226234736.428341-1-thepacketgeek@gmail.com>
References: <20260226234736.428341-1-thepacketgeek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for `string` as a parameter type in the module! macro.

On the runtime side, add:
  - set_string_param(): an extern "C" callback matching the
    kernel_param_ops::set signature that stores the raw C string
    pointer directly into the SetOnce<StringParam> container, avoiding
    an unnecessary copy-and-parse round-trip.
  - PARAM_OPS_STRING: a static kernel_param_ops that uses
    set_string_param as its setter.
  - ModuleParam impl for StringParam with try_from_param_arg()
    returning -EINVAL, since string parameters are populated
    exclusively through the kernel's set callback.

On the macro side:
  - Change the Parameter::ptype field from Ident to syn::Type to
    support path-qualified types.
  - Recognize the `string` shorthand and resolve it to the fully
    qualified ::kernel::module_param::StringParam type during code
    generation.
  - Wrap string default values with StringParam::from_c_str(c_str!(...))
    to produce a compile-time CStr-backed default.
  - Route `string` to PARAM_OPS_STRING in param_ops_path().

Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
---
 rust/kernel/module_param.rs | 48 +++++++++++++++++++++++++++++++++++++
 rust/macros/module.rs       | 42 +++++++++++++++++++++++++-------
 2 files changed, 81 insertions(+), 9 deletions(-)

diff --git a/rust/kernel/module_param.rs b/rust/kernel/module_param.rs
index 80fe8643c0ab..67ff6f2ea9c2 100644
--- a/rust/kernel/module_param.rs
+++ b/rust/kernel/module_param.rs
@@ -86,6 +86,36 @@ pub trait ModuleParam: Sized + Copy {
     })
 }
 
+/// Set a string module parameter from a string.
+///
+/// Similar to [`set_param`] but for [`StringParam`].
+///
+/// # Safety
+///
+/// Same requirements as [`set_param`].
+unsafe extern "C" fn set_string_param(
+    val: *const c_char,
+    param: *const bindings::kernel_param,
+) -> c_int {
+    if val.is_null() {
+        crate::pr_warn!("Null pointer passed to `module_param::set_string_param`");
+        return EINVAL.to_errno();
+    }
+
+    crate::error::from_result(|| {
+        // SAFETY: val points to a valid C string from the kernel.
+        let cstr_param = unsafe { StringParam::from_ptr(val) };
+
+        // SAFETY: By function safety requirements, param.arg points to our SetOnce<StringParam>.
+        let container = unsafe { &*((*param).__bindgen_anon_1.arg.cast::<SetOnce<StringParam>>()) };
+
+        container
+            .populate(cstr_param)
+            .then_some(0)
+            .ok_or(kernel::error::code::EEXIST)
+    })
+}
+
 macro_rules! impl_int_module_param {
     ($ty:ident) => {
         impl ModuleParam for $ty {
@@ -175,6 +205,15 @@ pub fn as_bytes(&self) -> Option<&[u8]> {
 unsafe impl Send for StringParam {}
 unsafe impl Sync for StringParam {}
 
+impl ModuleParam for StringParam {
+    fn try_from_param_arg(_arg: &BStr) -> Result<Self> {
+        // For StringParam, we don't parse here - the kernel's set callback
+        // directly stores the pointer. This method should not be called
+        // when using PARAM_OPS_STRING.
+        Err(EINVAL)
+    }
+}
+
 /// A wrapper for kernel parameters.
 ///
 /// This type is instantiated by the [`module!`] macro when module parameters are
@@ -249,3 +288,12 @@ macro_rules! make_param_ops {
 make_param_ops!(PARAM_OPS_U64, u64);
 make_param_ops!(PARAM_OPS_ISIZE, isize);
 make_param_ops!(PARAM_OPS_USIZE, usize);
+
+/// Parameter ops for string parameters.
+#[doc(hidden)]
+pub static PARAM_OPS_STRING: bindings::kernel_param_ops = bindings::kernel_param_ops {
+    flags: 0,
+    set: Some(set_string_param),
+    get: None,
+    free: None,
+};
diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index e16298e520c7..0d76743741fb 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -8,7 +8,8 @@
 };
 use quote::{
     format_ident,
-    quote, //
+    quote,
+    ToTokens, //
 };
 use syn::{
     braced,
@@ -120,13 +121,15 @@ fn emit_params(&mut self, info: &ModuleInfo) {
 
         for param in params {
             let param_name_str = param.name.to_string();
-            let param_type_str = param.ptype.to_string();
+            let param_type_str = param.ptype.to_token_stream().to_string();
+            // Clean up the type string for modinfo (remove spaces around ::)
+            let param_type_clean = param_type_str.replace(" ", "");
 
             let ops = param_ops_path(&param_type_str);
 
             // Note: The spelling of these fields is dictated by the user space
             // tool `modinfo`.
-            self.emit_param("parmtype", &param_name_str, &param_type_str);
+            self.emit_param("parmtype", &param_name_str, &param_type_clean);
             self.emit_param("parm", &param_name_str, &param.description.value());
 
             let static_name = format_ident!("__{}_{}_struct", self.module, param.name);
@@ -137,14 +140,32 @@ fn emit_params(&mut self, info: &ModuleInfo) {
                     .expect("name contains NUL-terminator");
 
             let param_name = &param.name;
-            let param_type = &param.ptype;
             let param_default = &param.default;
 
+            // `string` is a shorthand for `StringParam` in the macro — resolve to
+            // the real type for code generation.
+            let is_str_param = param_type_str == "string";
+            let actual_type: Type = if is_str_param {
+                parse_quote!(::kernel::module_param::StringParam)
+            } else {
+                param.ptype.clone()
+            };
+
+            // For `string` params the default is always a string literal which
+            // gets wrapped with StringParam::from_c_str(kernel::c_str!(...)).
+            let default_expr = if is_str_param {
+                quote! {
+                    ::kernel::module_param::StringParam::from_c_str(::kernel::c_str!(#param_default))
+                }
+            } else {
+                quote!(#param_default)
+            };
+
             self.param_ts.extend(quote! {
                 #[allow(non_upper_case_globals)]
                 pub(crate) static #param_name:
-                    ::kernel::module_param::ModuleParamAccess<#param_type> =
-                        ::kernel::module_param::ModuleParamAccess::new(#param_default);
+                    ::kernel::module_param::ModuleParamAccess<#actual_type> =
+                        ::kernel::module_param::ModuleParamAccess::new(#default_expr);
 
                 const _: () = {
                     #[allow(non_upper_case_globals)]
@@ -186,7 +207,9 @@ fn emit_params(&mut self, info: &ModuleInfo) {
 }
 
 fn param_ops_path(param_type: &str) -> Path {
-    match param_type {
+    let type_name = param_type.rsplit("::").next().unwrap_or(param_type).trim();
+
+    match type_name {
         "i8" => parse_quote!(::kernel::module_param::PARAM_OPS_I8),
         "u8" => parse_quote!(::kernel::module_param::PARAM_OPS_U8),
         "i16" => parse_quote!(::kernel::module_param::PARAM_OPS_I16),
@@ -197,6 +220,7 @@ fn param_ops_path(param_type: &str) -> Path {
         "u64" => parse_quote!(::kernel::module_param::PARAM_OPS_U64),
         "isize" => parse_quote!(::kernel::module_param::PARAM_OPS_ISIZE),
         "usize" => parse_quote!(::kernel::module_param::PARAM_OPS_USIZE),
+        "string" => parse_quote!(::kernel::module_param::PARAM_OPS_STRING),
         t => panic!("Unsupported parameter type {}", t),
     }
 }
@@ -340,7 +364,7 @@ macro_rules! parse_ordered_fields {
 
 struct Parameter {
     name: Ident,
-    ptype: Ident,
+    ptype: Type,
     default: Expr,
     description: LitStr,
 }
@@ -349,7 +373,7 @@ impl Parse for Parameter {
     fn parse(input: ParseStream<'_>) -> Result<Self> {
         let name = input.parse()?;
         input.parse::<Token![:]>()?;
-        let ptype = input.parse()?;
+        let ptype: Type = input.parse()?;
 
         let fields;
         braced!(fields in input);
-- 
2.52.0

