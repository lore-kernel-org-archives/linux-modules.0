Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3FF39E6CB;
	Wed,  7 Jan 2026 16:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767803436; cv=none; b=XOs2DE8WCiPpIATDVhSdfoQoDvyQUd48xqEW0cN1Qe4s7229lifsqBfMn8VIzOItqalA2EcvbCYN7i/Bis9UnhkywXi285JNzW6plYF48nAdEq4Jo2ga44b/XfF0jhk2vWyDxcI/B9lEWfmwHkMsCLWlXEld/GzVu7z9/ENWCIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767803436; c=relaxed/simple;
	bh=2GgeZpROWDwJAL2len3LNV0WkuOENfp2YwSPqNibeeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=soPcKDBjUVYlVmvz6Y6hP9fGaFXPp1ODsc1nIJZnnoJa7D5CzZEZfNVhk//qXdjg6lMlCAjeyHHG1eryr3T22seDSpSnBoTcSnuGpNhJvtGOrSihv++ehOQkxigheVt1XynQCTi6/9AV1BE3hfbdunzSGCpAyZYWXiZBWfWu2Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k53Z1ABd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k53Z1ABd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D9DC4CEF7;
	Wed,  7 Jan 2026 16:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767803435;
	bh=2GgeZpROWDwJAL2len3LNV0WkuOENfp2YwSPqNibeeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=k53Z1ABdx14wcmrHzOUGjNoXUwYjkYpk+6pVkihKU65GmxMovCwkBjsWiKYXc2vvZ
	 ovhGReiu/YQjuOkdD3H/hWQxnxRJ/fj/30VtXHXoF8Bh8x27n1VAMZqbkPcfzdTLSR
	 69PxRWtaRJxNJVMNkQ+0FZfPf6teTF1xBwbbF7S7WcndyNoWqbq5udC6RkLJxBpbHz
	 qBTKWYJtFjvpTxxSxnmPNdml+I0aWqqAf/YNe/X7dP2rTddtzxzydHewGRCFcPCQTW
	 NPgOu+ZrPVjGtHUNml41LezcW6cdObhjjXSSdtjMuwMumR26yFRM3FjqYSFyS3hoAf
	 HTMVC+WemfyDg==
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
	Aaron Tomlin <atomlin@atomlin.com>,
	Tamir Duberstein <tamird@gmail.com>,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Cc: rust-for-linux@vger.kernel.org,
	Patrick Miller <paddymills@proton.me>,
	linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org
Subject: [PATCH v2 04/11] rust: macros: use `syn` to parse `module!` macro
Date: Wed,  7 Jan 2026 16:15:43 +0000
Message-ID: <20260107161729.3855851-5-gary@kernel.org>
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

With `syn` being available in the kernel, use it to parse the complex
custom `module!` macro to replace existing helpers. Only parsing is
changed in this commit, the code generation is untouched.

This has the benefit of better error message when the macro is used
incorrectly, as it can point to a concrete span on what's going wrong.

For example, if a field is specified twice, previously it reads:

    error: proc macro panicked
      --> samples/rust/rust_minimal.rs:7:1
       |
    7  | / module! {
    8  | |     type: RustMinimal,
    9  | |     name: "rust_minimal",
    10 | |     author: "Rust for Linux Contributors",
    11 | |     description: "Rust minimal sample",
    12 | |     license: "GPL",
    13 | |     license: "GPL",
    14 | | }
       | |_^
       |
       = help: message: Duplicated key "license". Keys can only be specified once.

now it reads:

    error: duplicated key "license". Keys can only be specified once.
      --> samples/rust/rust_minimal.rs:13:5
       |
    13 |     license: "GPL",
       |     ^^^^^^^

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/macros/helpers.rs | 109 ++++--------
 rust/macros/lib.rs     |   6 +-
 rust/macros/module.rs  | 389 +++++++++++++++++++++++++----------------
 3 files changed, 277 insertions(+), 227 deletions(-)

diff --git a/rust/macros/helpers.rs b/rust/macros/helpers.rs
index 13fafaba12261..fa66ef6eb0f3d 100644
--- a/rust/macros/helpers.rs
+++ b/rust/macros/helpers.rs
@@ -1,53 +1,21 @@
 // SPDX-License-Identifier: GPL-2.0
 
-use proc_macro2::{token_stream, Group, Ident, TokenStream, TokenTree};
-
-pub(crate) fn try_ident(it: &mut token_stream::IntoIter) -> Option<String> {
-    if let Some(TokenTree::Ident(ident)) = it.next() {
-        Some(ident.to_string())
-    } else {
-        None
-    }
-}
-
-pub(crate) fn try_sign(it: &mut token_stream::IntoIter) -> Option<char> {
-    let peek = it.clone().next();
-    match peek {
-        Some(TokenTree::Punct(punct)) if punct.as_char() == '-' => {
-            let _ = it.next();
-            Some(punct.as_char())
-        }
-        _ => None,
-    }
-}
-
-pub(crate) fn try_literal(it: &mut token_stream::IntoIter) -> Option<String> {
-    if let Some(TokenTree::Literal(literal)) = it.next() {
-        Some(literal.to_string())
-    } else {
-        None
-    }
-}
-
-pub(crate) fn try_string(it: &mut token_stream::IntoIter) -> Option<String> {
-    try_literal(it).and_then(|string| {
-        if string.starts_with('\"') && string.ends_with('\"') {
-            let content = &string[1..string.len() - 1];
-            if content.contains('\\') {
-                panic!("Escape sequences in string literals not yet handled");
-            }
-            Some(content.to_string())
-        } else if string.starts_with("r\"") {
-            panic!("Raw string literals are not yet handled");
-        } else {
-            None
-        }
-    })
-}
-
-pub(crate) fn expect_ident(it: &mut token_stream::IntoIter) -> String {
-    try_ident(it).expect("Expected Ident")
-}
+use proc_macro2::{
+    token_stream,
+    Ident,
+    TokenStream,
+    TokenTree, //
+};
+use quote::ToTokens;
+use syn::{
+    parse::{
+        Parse,
+        ParseStream, //
+    },
+    Error,
+    LitStr,
+    Result, //
+};
 
 pub(crate) fn expect_punct(it: &mut token_stream::IntoIter) -> char {
     if let TokenTree::Punct(punct) = it.next().expect("Reached end of token stream for Punct") {
@@ -57,27 +25,28 @@ pub(crate) fn expect_punct(it: &mut token_stream::IntoIter) -> char {
     }
 }
 
-pub(crate) fn expect_string(it: &mut token_stream::IntoIter) -> String {
-    try_string(it).expect("Expected string")
-}
+/// A string literal that is required to have ASCII value only.
+pub(crate) struct AsciiLitStr(LitStr);
 
-pub(crate) fn expect_string_ascii(it: &mut token_stream::IntoIter) -> String {
-    let string = try_string(it).expect("Expected string");
-    assert!(string.is_ascii(), "Expected ASCII string");
-    string
+impl Parse for AsciiLitStr {
+    fn parse(input: ParseStream<'_>) -> Result<Self> {
+        let s: LitStr = input.parse()?;
+        if !s.value().is_ascii() {
+            return Err(Error::new_spanned(s, "expected ASCII-only string literal"));
+        }
+        Ok(Self(s))
+    }
 }
 
-pub(crate) fn expect_group(it: &mut token_stream::IntoIter) -> Group {
-    if let TokenTree::Group(group) = it.next().expect("Reached end of token stream for Group") {
-        group
-    } else {
-        panic!("Expected Group");
+impl ToTokens for AsciiLitStr {
+    fn to_tokens(&self, ts: &mut TokenStream) {
+        self.0.to_tokens(ts);
     }
 }
 
-pub(crate) fn expect_end(it: &mut token_stream::IntoIter) {
-    if it.next().is_some() {
-        panic!("Expected end");
+impl AsciiLitStr {
+    pub(crate) fn value(&self) -> String {
+        self.0.value()
     }
 }
 
@@ -114,17 +83,3 @@ pub(crate) fn file() -> String {
         proc_macro::Span::call_site().file()
     }
 }
-
-/// Parse a token stream of the form `expected_name: "value",` and return the
-/// string in the position of "value".
-///
-/// # Panics
-///
-/// - On parse error.
-pub(crate) fn expect_string_field(it: &mut token_stream::IntoIter, expected_name: &str) -> String {
-    assert_eq!(expect_ident(it), expected_name);
-    assert_eq!(expect_punct(it), ':');
-    let string = expect_string(it);
-    assert_eq!(expect_punct(it), ',');
-    string
-}
diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index 9955c04dbaae3..c5347127a3a51 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -131,8 +131,10 @@
 ///   - `firmware`: array of ASCII string literals of the firmware files of
 ///     the kernel module.
 #[proc_macro]
-pub fn module(ts: TokenStream) -> TokenStream {
-    module::module(ts.into()).into()
+pub fn module(input: TokenStream) -> TokenStream {
+    module::module(parse_macro_input!(input))
+        .unwrap_or_else(|e| e.into_compile_error())
+        .into()
 }
 
 /// Declares or implements a vtable trait.
diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index b855a2b586e18..6ad7b411ccde4 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -2,28 +2,30 @@
 
 use std::fmt::Write;
 
-use proc_macro2::{token_stream, Delimiter, Literal, TokenStream, TokenTree};
+use proc_macro2::{
+    Literal,
+    TokenStream, //
+};
+use quote::ToTokens;
+use syn::{
+    braced,
+    bracketed,
+    ext::IdentExt,
+    parse::{
+        Parse,
+        ParseStream, //
+    },
+    punctuated::Punctuated,
+    Error,
+    Expr,
+    Ident,
+    LitStr,
+    Result,
+    Token, //
+};
 
 use crate::helpers::*;
 
-fn expect_string_array(it: &mut token_stream::IntoIter) -> Vec<String> {
-    let group = expect_group(it);
-    assert_eq!(group.delimiter(), Delimiter::Bracket);
-    let mut values = Vec::new();
-    let mut it = group.stream().into_iter();
-
-    while let Some(val) = try_string(&mut it) {
-        assert!(val.is_ascii(), "Expected ASCII string");
-        values.push(val);
-        match it.next() {
-            Some(TokenTree::Punct(punct)) => assert_eq!(punct.as_char(), ','),
-            None => break,
-            _ => panic!("Expected ',' or end of array"),
-        }
-    }
-    values
-}
-
 struct ModInfoBuilder<'a> {
     module: &'a str,
     counter: usize,
@@ -113,12 +115,16 @@ fn emit_params(&mut self, info: &ModuleInfo) {
         };
 
         for param in params {
-            let ops = param_ops_path(&param.ptype);
+            let param_name = param.name.to_string();
+            let param_type = param.ptype.to_string();
+            let param_default = param.default.to_token_stream().to_string();
+
+            let ops = param_ops_path(&param_type);
 
             // Note: The spelling of these fields is dictated by the user space
             // tool `modinfo`.
-            self.emit_param("parmtype", &param.name, &param.ptype);
-            self.emit_param("parm", &param.name, &param.description);
+            self.emit_param("parmtype", &param_name, &param_type);
+            self.emit_param("parm", &param_name, &param.description.value());
 
             write!(
                 self.param_buffer,
@@ -160,10 +166,7 @@ fn emit_params(&mut self, info: &ModuleInfo) {
                         );
                 }};
                 ",
-                module_name = info.name,
-                param_type = param.ptype,
-                param_default = param.default,
-                param_name = param.name,
+                module_name = info.name.value(),
                 ops = ops,
             )
             .unwrap();
@@ -187,127 +190,82 @@ fn param_ops_path(param_type: &str) -> &'static str {
     }
 }
 
-fn expect_param_default(param_it: &mut token_stream::IntoIter) -> String {
-    assert_eq!(expect_ident(param_it), "default");
-    assert_eq!(expect_punct(param_it), ':');
-    let sign = try_sign(param_it);
-    let default = try_literal(param_it).expect("Expected default param value");
-    assert_eq!(expect_punct(param_it), ',');
-    let mut value = sign.map(String::from).unwrap_or_default();
-    value.push_str(&default);
-    value
-}
-
-#[derive(Debug, Default)]
-struct ModuleInfo {
-    type_: String,
-    license: String,
-    name: String,
-    authors: Option<Vec<String>>,
-    description: Option<String>,
-    alias: Option<Vec<String>>,
-    firmware: Option<Vec<String>>,
-    imports_ns: Option<Vec<String>>,
-    params: Option<Vec<Parameter>>,
-}
-
-#[derive(Debug)]
-struct Parameter {
-    name: String,
-    ptype: String,
-    default: String,
-    description: String,
-}
-
-fn expect_params(it: &mut token_stream::IntoIter) -> Vec<Parameter> {
-    let params = expect_group(it);
-    assert_eq!(params.delimiter(), Delimiter::Brace);
-    let mut it = params.stream().into_iter();
-    let mut parsed = Vec::new();
-
-    loop {
-        let param_name = match it.next() {
-            Some(TokenTree::Ident(ident)) => ident.to_string(),
-            Some(_) => panic!("Expected Ident or end"),
-            None => break,
-        };
-
-        assert_eq!(expect_punct(&mut it), ':');
-        let param_type = expect_ident(&mut it);
-        let group = expect_group(&mut it);
-        assert_eq!(group.delimiter(), Delimiter::Brace);
-        assert_eq!(expect_punct(&mut it), ',');
-
-        let mut param_it = group.stream().into_iter();
-        let param_default = expect_param_default(&mut param_it);
-        let param_description = expect_string_field(&mut param_it, "description");
-        expect_end(&mut param_it);
-
-        parsed.push(Parameter {
-            name: param_name,
-            ptype: param_type,
-            default: param_default,
-            description: param_description,
-        })
-    }
-
-    parsed
-}
-
-impl ModuleInfo {
-    fn parse(it: &mut token_stream::IntoIter) -> Self {
-        let mut info = ModuleInfo::default();
-
-        const EXPECTED_KEYS: &[&str] = &[
-            "type",
-            "name",
-            "authors",
-            "description",
-            "license",
-            "alias",
-            "firmware",
-            "imports_ns",
-            "params",
-        ];
-        const REQUIRED_KEYS: &[&str] = &["type", "name", "license"];
+/// Parse fields that are required to use a specific order.
+///
+/// As fields must follow a specific order, we *could* just parse fields one by one by peeking.
+/// However the error message generated when implementing that way is not very friendly.
+///
+/// So instead we parse fields in an arbitrary order, but only enforce the ordering after parsing,
+/// and if the wrong order is used, the proper order is communicated to the user with error message.
+///
+/// Usage looks like this:
+/// ```ignore
+/// parse_ordered_fields! {
+///     from input;
+///
+///     // This will extract "foo: <field>" into a variable named "foo".
+///     // The variable will have type `Option<_>`.
+///     foo => <expression that parses the field>,
+///
+///     // If you need the variable name to be different than the key name.
+///     // This extracts "baz: <field>" into a variable named "bar".
+///     // You might want this if "baz" is a keyword.
+///     baz as bar => <expression that parse the field>,
+///
+///     // You can mark a key as required, and the variable will no longer be `Option`.
+///     // foobar will be of type `Expr` instead of `Option<Expr>`.
+///     foobar [required] => input.parse::<Expr>()?,
+/// }
+/// ```
+macro_rules! parse_ordered_fields {
+    (@gen
+        [$input:expr]
+        [$([$name:ident; $key:ident; $parser:expr])*]
+        [$([$req_name:ident; $req_key:ident])*]
+    ) => {
+        $(let mut $name = None;)*
+
+        const EXPECTED_KEYS: &[&str] = &[$(stringify!($key),)*];
+        const REQUIRED_KEYS: &[&str] = &[$(stringify!($req_key),)*];
+
+        let span = $input.span();
         let mut seen_keys = Vec::new();
 
         loop {
-            let key = match it.next() {
-                Some(TokenTree::Ident(ident)) => ident.to_string(),
-                Some(_) => panic!("Expected Ident or end"),
-                None => break,
-            };
+            if $input.is_empty() {
+                break;
+            }
+
+            let key = $input.call(Ident::parse_any)?;
 
             if seen_keys.contains(&key) {
-                panic!("Duplicated key \"{key}\". Keys can only be specified once.");
+                Err(Error::new_spanned(
+                    &key,
+                    format!(r#"duplicated key "{key}". Keys can only be specified once."#),
+                ))?
             }
 
-            assert_eq!(expect_punct(it), ':');
-
-            match key.as_str() {
-                "type" => info.type_ = expect_ident(it),
-                "name" => info.name = expect_string_ascii(it),
-                "authors" => info.authors = Some(expect_string_array(it)),
-                "description" => info.description = Some(expect_string(it)),
-                "license" => info.license = expect_string_ascii(it),
-                "alias" => info.alias = Some(expect_string_array(it)),
-                "firmware" => info.firmware = Some(expect_string_array(it)),
-                "imports_ns" => info.imports_ns = Some(expect_string_array(it)),
-                "params" => info.params = Some(expect_params(it)),
-                _ => panic!("Unknown key \"{key}\". Valid keys are: {EXPECTED_KEYS:?}."),
+            $input.parse::<Token![:]>()?;
+
+            match &*key.to_string() {
+                $(
+                    stringify!($key) => $name = Some($parser),
+                )*
+                _ => {
+                    Err(Error::new_spanned(
+                        &key,
+                        format!(r#"unknown key "{key}". Valid keys are: {EXPECTED_KEYS:?}."#),
+                    ))?
+                }
             }
 
-            assert_eq!(expect_punct(it), ',');
-
+            $input.parse::<Token![,]>()?;
             seen_keys.push(key);
         }
 
-        expect_end(it);
-
         for key in REQUIRED_KEYS {
             if !seen_keys.iter().any(|e| e == key) {
-                panic!("Missing required key \"{key}\".");
+                Err(Error::new(span, format!(r#"missing required key "{key}""#)))?
             }
         }
 
@@ -319,43 +277,178 @@ fn parse(it: &mut token_stream::IntoIter) -> Self {
         }
 
         if seen_keys != ordered_keys {
-            panic!("Keys are not ordered as expected. Order them like: {ordered_keys:?}.");
+            Err(Error::new(
+                span,
+                format!(r#"keys are not ordered as expected. Order them like: {ordered_keys:?}."#),
+            ))?
+        }
+
+        $(let $req_name = $req_name.expect("required field");)*
+    };
+
+    // Handle required fields.
+    (@gen
+        [$input:expr] [$($tok:tt)*] [$($req:tt)*]
+        $key:ident as $name:ident [required] => $parser:expr,
+        $($rest:tt)*
+    ) => {
+        parse_ordered_fields!(
+            @gen [$input] [$($tok)* [$name; $key; $parser]] [$($req)* [$name; $key]] $($rest)*
+        )
+    };
+    (@gen
+        [$input:expr] [$($tok:tt)*] [$($req:tt)*]
+        $name:ident [required] => $parser:expr,
+        $($rest:tt)*
+    ) => {
+        parse_ordered_fields!(
+            @gen [$input] [$($tok)* [$name; $name; $parser]] [$($req)* [$name; $name]] $($rest)*
+        )
+    };
+
+    // Handle optional fields.
+    (@gen
+        [$input:expr] [$($tok:tt)*] [$($req:tt)*]
+        $key:ident as $name:ident => $parser:expr,
+        $($rest:tt)*
+    ) => {
+        parse_ordered_fields!(
+            @gen [$input] [$($tok)* [$name; $key; $parser]] [$($req)*] $($rest)*
+        )
+    };
+    (@gen
+        [$input:expr] [$($tok:tt)*] [$($req:tt)*]
+        $name:ident => $parser:expr,
+        $($rest:tt)*
+    ) => {
+        parse_ordered_fields!(
+            @gen [$input] [$($tok)* [$name; $name; $parser]] [$($req)*] $($rest)*
+        )
+    };
+
+    (from $input:expr; $($tok:tt)*) => {
+        parse_ordered_fields!(@gen [$input] [] [] $($tok)*)
+    }
+}
+
+struct Parameter {
+    name: Ident,
+    ptype: Ident,
+    default: Expr,
+    description: LitStr,
+}
+
+impl Parse for Parameter {
+    fn parse(input: ParseStream<'_>) -> Result<Self> {
+        let name = input.parse()?;
+        input.parse::<Token![:]>()?;
+        let ptype = input.parse()?;
+
+        let fields;
+        braced!(fields in input);
+
+        parse_ordered_fields! {
+            from fields;
+            default [required] => fields.parse()?,
+            description [required] => fields.parse()?,
         }
 
-        info
+        Ok(Self {
+            name,
+            ptype,
+            default,
+            description,
+        })
     }
 }
 
-pub(crate) fn module(ts: TokenStream) -> TokenStream {
-    let mut it = ts.into_iter();
+pub(crate) struct ModuleInfo {
+    type_: Ident,
+    license: AsciiLitStr,
+    name: AsciiLitStr,
+    authors: Option<Punctuated<AsciiLitStr, Token![,]>>,
+    description: Option<LitStr>,
+    alias: Option<Punctuated<AsciiLitStr, Token![,]>>,
+    firmware: Option<Punctuated<AsciiLitStr, Token![,]>>,
+    imports_ns: Option<Punctuated<AsciiLitStr, Token![,]>>,
+    params: Option<Punctuated<Parameter, Token![,]>>,
+}
 
-    let info = ModuleInfo::parse(&mut it);
+impl Parse for ModuleInfo {
+    fn parse(input: ParseStream<'_>) -> Result<Self> {
+        parse_ordered_fields!(
+            from input;
+            type as type_ [required] => input.parse()?,
+            name [required] => input.parse()?,
+            authors => {
+                let list;
+                bracketed!(list in input);
+                Punctuated::parse_terminated(&list)?
+            },
+            description => input.parse()?,
+            license [required] => input.parse()?,
+            alias => {
+                let list;
+                bracketed!(list in input);
+                Punctuated::parse_terminated(&list)?
+            },
+            firmware => {
+                let list;
+                bracketed!(list in input);
+                Punctuated::parse_terminated(&list)?
+            },
+            imports_ns => {
+                let list;
+                bracketed!(list in input);
+                Punctuated::parse_terminated(&list)?
+            },
+            params => {
+                let list;
+                braced!(list in input);
+                Punctuated::parse_terminated(&list)?
+            },
+        );
+
+        Ok(ModuleInfo {
+            type_,
+            license,
+            name,
+            authors,
+            description,
+            alias,
+            firmware,
+            imports_ns,
+            params,
+        })
+    }
+}
 
+pub(crate) fn module(info: ModuleInfo) -> Result<TokenStream> {
     // Rust does not allow hyphens in identifiers, use underscore instead.
-    let ident = info.name.replace('-', "_");
+    let ident = info.name.value().replace('-', "_");
     let mut modinfo = ModInfoBuilder::new(ident.as_ref());
     if let Some(authors) = &info.authors {
         for author in authors {
-            modinfo.emit("author", author);
+            modinfo.emit("author", &author.value());
         }
     }
     if let Some(description) = &info.description {
-        modinfo.emit("description", description);
+        modinfo.emit("description", &description.value());
     }
-    modinfo.emit("license", &info.license);
+    modinfo.emit("license", &info.license.value());
     if let Some(aliases) = &info.alias {
         for alias in aliases {
-            modinfo.emit("alias", alias);
+            modinfo.emit("alias", &alias.value());
         }
     }
     if let Some(firmware) = &info.firmware {
         for fw in firmware {
-            modinfo.emit("firmware", fw);
+            modinfo.emit("firmware", &fw.value());
         }
     }
     if let Some(imports) = &info.imports_ns {
         for ns in imports {
-            modinfo.emit("import_ns", ns);
+            modinfo.emit("import_ns", &ns.value());
         }
     }
 
@@ -366,7 +459,7 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
 
     modinfo.emit_params(&info);
 
-    format!(
+    Ok(format!(
         "
             /// The module name.
             ///
@@ -536,12 +629,12 @@ mod module_parameters {{
             }}
         ",
         type_ = info.type_,
-        name = info.name,
+        name = info.name.value(),
         ident = ident,
         modinfo = modinfo.buffer,
         params = modinfo.param_buffer,
         initcall_section = ".initcall6.init"
     )
     .parse()
-    .expect("Error parsing formatted string into token stream.")
+    .expect("Error parsing formatted string into token stream."))
 }
-- 
2.51.2

