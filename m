Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C787739E6EF;
	Wed,  7 Jan 2026 16:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767803441; cv=none; b=LIIPuELuzyir0Dq0Uqwyj1ndEDeMU6a2nKq9VtkUowk3IwYCmjeMqstEuRpe1W5K4h23T32Btm+GB0rBrWFhZfH4NYDzokBWuBt4m4Yq3A0uYcwTT2lzWG7yTQ5846fLeElCQQqklobybOBNkz4D1Z0RejiAB19is7Tpd5RkeMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767803441; c=relaxed/simple;
	bh=zxOcymW1jzRdf2SFdVDYAE4jBg3L2i+xI6WgwlTdirE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZmLTCsVYy6PE+3g253GyUBZpeIx4yKE0uBUF6xpvCZaB1v+Zz/0cMMS1EgswnSQeIKgsW9pEIlaPLE4YeBP/TTbEnaek08dNYyy6MgNU690Dn19ixWbwPymqBpR7LVo7ugMH4NielUmSr1reviL4pZuM5A6bi7BxUDJh4bBvDv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YfxSe4zk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfxSe4zk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E540AC19422;
	Wed,  7 Jan 2026 16:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767803440;
	bh=zxOcymW1jzRdf2SFdVDYAE4jBg3L2i+xI6WgwlTdirE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=YfxSe4zkeJ7T6Bhl0GjUbH/PT8aZ3hLKgXlRh2SW/KYJpEG2Axq32AsgqnaM1yBiP
	 vXHlEeWDwvEyS/USjtsu1nhDL27MjKfWVEAT7dcsR5HUFHbIOx+vNJnm8G0pVep+79
	 mjytBqqM8KT/nObsVlotOQcDy5pnv8S90FyJtyPIz9dzF7USIyJC9In+2ikLNOgMl0
	 caXEl48xFTaQbutLeyeRonIb2koGqEQHv+Nv43rzECuufD8fooJ8LMqBzHMHB98ZkB
	 PixwK5UHv+JRpCMjSYqBsmbKlFtcKb2JEWbRjN6p2C+Qn8R79Fpgg+vOKA3Lwog6Bx
	 zgaCHVbzd6tdA==
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
Subject: [PATCH v2 05/11] rust: macros: use `quote!` for `module!` macro
Date: Wed,  7 Jan 2026 16:15:44 +0000
Message-ID: <20260107161729.3855851-6-gary@kernel.org>
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

This has no behavioural change, but is good for maintainability. With
`quote!`, we're no longer using string templates, so we don't need to
quote " and {} inside the template anymore. Further more, editors can
now highlight the code template.

This also improves the robustness as it eliminates the need for string
quoting and escaping.

Co-developed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/macros/module.rs | 558 ++++++++++++++++++++++--------------------
 1 file changed, 295 insertions(+), 263 deletions(-)

diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index 6ad7b411ccde4..ba345d672839e 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -1,12 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0
 
-use std::fmt::Write;
+use std::ffi::CString;
 
 use proc_macro2::{
     Literal,
     TokenStream, //
 };
-use quote::ToTokens;
+use quote::{
+    format_ident,
+    quote, //
+};
 use syn::{
     braced,
     bracketed,
@@ -15,11 +18,13 @@
         Parse,
         ParseStream, //
     },
+    parse_quote,
     punctuated::Punctuated,
     Error,
     Expr,
     Ident,
     LitStr,
+    Path,
     Result,
     Token, //
 };
@@ -29,8 +34,8 @@
 struct ModInfoBuilder<'a> {
     module: &'a str,
     counter: usize,
-    buffer: String,
-    param_buffer: String,
+    ts: TokenStream,
+    param_ts: TokenStream,
 }
 
 impl<'a> ModInfoBuilder<'a> {
@@ -38,8 +43,8 @@ fn new(module: &'a str) -> Self {
         ModInfoBuilder {
             module,
             counter: 0,
-            buffer: String::new(),
-            param_buffer: String::new(),
+            ts: TokenStream::new(),
+            param_ts: TokenStream::new(),
         }
     }
 
@@ -56,33 +61,32 @@ fn emit_base(&mut self, field: &str, content: &str, builtin: bool, param: bool)
             // Loadable modules' modinfo strings go as-is.
             format!("{field}={content}\0")
         };
-
-        let buffer = if param {
-            &mut self.param_buffer
+        let length = string.len();
+        let string = Literal::byte_string(string.as_bytes());
+        let cfg = if builtin {
+            quote!(#[cfg(not(MODULE))])
         } else {
-            &mut self.buffer
+            quote!(#[cfg(MODULE)])
         };
 
-        write!(
-            buffer,
-            "
-                {cfg}
-                #[doc(hidden)]
-                #[cfg_attr(not(target_os = \"macos\"), link_section = \".modinfo\")]
-                #[used(compiler)]
-                pub static __{module}_{counter}: [u8; {length}] = *{string};
-            ",
-            cfg = if builtin {
-                "#[cfg(not(MODULE))]"
-            } else {
-                "#[cfg(MODULE)]"
-            },
+        let counter = format_ident!(
+            "__{module}_{counter}",
             module = self.module.to_uppercase(),
-            counter = self.counter,
-            length = string.len(),
-            string = Literal::byte_string(string.as_bytes()),
-        )
-        .unwrap();
+            counter = self.counter
+        );
+        let item = quote! {
+            #cfg
+            #[doc(hidden)]
+            #[cfg_attr(not(target_os = "macos"), link_section = ".modinfo")]
+            #[used(compiler)]
+            pub static #counter: [u8; #length] = *#string;
+        };
+
+        if param {
+            self.param_ts.extend(item);
+        } else {
+            self.ts.extend(item);
+        }
 
         self.counter += 1;
     }
@@ -115,77 +119,86 @@ fn emit_params(&mut self, info: &ModuleInfo) {
         };
 
         for param in params {
-            let param_name = param.name.to_string();
-            let param_type = param.ptype.to_string();
-            let param_default = param.default.to_token_stream().to_string();
+            let param_name_str = param.name.to_string();
+            let param_type_str = param.ptype.to_string();
 
-            let ops = param_ops_path(&param_type);
+            let ops = param_ops_path(&param_type_str);
 
             // Note: The spelling of these fields is dictated by the user space
             // tool `modinfo`.
-            self.emit_param("parmtype", &param_name, &param_type);
-            self.emit_param("parm", &param_name, &param.description.value());
-
-            write!(
-                self.param_buffer,
-                "
-                pub(crate) static {param_name}:
-                    ::kernel::module_param::ModuleParamAccess<{param_type}> =
-                        ::kernel::module_param::ModuleParamAccess::new({param_default});
-
-                const _: () = {{
-                    #[link_section = \"__param\"]
-                    #[used]
-                    static __{module_name}_{param_name}_struct:
+            self.emit_param("parmtype", &param_name_str, &param_type_str);
+            self.emit_param("parm", &param_name_str, &param.description.value());
+
+            let static_name = format_ident!("__{}_{}_struct", self.module, param.name);
+            let param_name_cstr = Literal::c_string(
+                &CString::new(param_name_str).expect("name contains NUL-terminator"),
+            );
+            let param_name_cstr_with_module = Literal::c_string(
+                &CString::new(format!("{}.{}", self.module, param.name))
+                    .expect("name contains NUL-terminator"),
+            );
+
+            let param_name = &param.name;
+            let param_type = &param.ptype;
+            let param_default = &param.default;
+
+            self.param_ts.extend(quote!{
+                #[allow(non_upper_case_globals)]
+                pub(crate) static #param_name:
+                    ::kernel::module_param::ModuleParamAccess<#param_type> =
+                        ::kernel::module_param::ModuleParamAccess::new(#param_default);
+
+                const _: () = {
+                    #[allow(non_upper_case_globals)]
+                    #[link_section = "__param"]
+                    #[used(compiler)]
+                    static #static_name:
                         ::kernel::module_param::KernelParam =
                         ::kernel::module_param::KernelParam::new(
-                            ::kernel::bindings::kernel_param {{
-                                name: if ::core::cfg!(MODULE) {{
-                                    ::kernel::c_str!(\"{param_name}\").to_bytes_with_nul()
-                                }} else {{
-                                    ::kernel::c_str!(\"{module_name}.{param_name}\")
-                                        .to_bytes_with_nul()
-                                }}.as_ptr(),
+                            ::kernel::bindings::kernel_param {
+                                name: kernel::str::as_char_ptr_in_const_context(
+                                    if ::core::cfg!(MODULE) {
+                                        #param_name_cstr
+                                    } else {
+                                        #param_name_cstr_with_module
+                                    }
+                                ),
                                 // SAFETY: `__this_module` is constructed by the kernel at load
                                 // time and will not be freed until the module is unloaded.
                                 #[cfg(MODULE)]
-                                mod_: unsafe {{
+                                mod_: unsafe {
                                     core::ptr::from_ref(&::kernel::bindings::__this_module)
                                         .cast_mut()
-                                }},
+                                },
                                 #[cfg(not(MODULE))]
                                 mod_: ::core::ptr::null_mut(),
-                                ops: core::ptr::from_ref(&{ops}),
+                                ops: core::ptr::from_ref(&#ops),
                                 perm: 0, // Will not appear in sysfs
                                 level: -1,
                                 flags: 0,
-                                __bindgen_anon_1: ::kernel::bindings::kernel_param__bindgen_ty_1 {{
-                                    arg: {param_name}.as_void_ptr()
-                                }},
-                            }}
+                                __bindgen_anon_1: ::kernel::bindings::kernel_param__bindgen_ty_1 {
+                                    arg: #param_name.as_void_ptr()
+                                },
+                            }
                         );
-                }};
-                ",
-                module_name = info.name.value(),
-                ops = ops,
-            )
-            .unwrap();
+                };
+            });
         }
     }
 }
 
-fn param_ops_path(param_type: &str) -> &'static str {
+fn param_ops_path(param_type: &str) -> Path {
     match param_type {
-        "i8" => "::kernel::module_param::PARAM_OPS_I8",
-        "u8" => "::kernel::module_param::PARAM_OPS_U8",
-        "i16" => "::kernel::module_param::PARAM_OPS_I16",
-        "u16" => "::kernel::module_param::PARAM_OPS_U16",
-        "i32" => "::kernel::module_param::PARAM_OPS_I32",
-        "u32" => "::kernel::module_param::PARAM_OPS_U32",
-        "i64" => "::kernel::module_param::PARAM_OPS_I64",
-        "u64" => "::kernel::module_param::PARAM_OPS_U64",
-        "isize" => "::kernel::module_param::PARAM_OPS_ISIZE",
-        "usize" => "::kernel::module_param::PARAM_OPS_USIZE",
+        "i8" => parse_quote!(::kernel::module_param::PARAM_OPS_I8),
+        "u8" => parse_quote!(::kernel::module_param::PARAM_OPS_U8),
+        "i16" => parse_quote!(::kernel::module_param::PARAM_OPS_I16),
+        "u16" => parse_quote!(::kernel::module_param::PARAM_OPS_U16),
+        "i32" => parse_quote!(::kernel::module_param::PARAM_OPS_I32),
+        "u32" => parse_quote!(::kernel::module_param::PARAM_OPS_U32),
+        "i64" => parse_quote!(::kernel::module_param::PARAM_OPS_I64),
+        "u64" => parse_quote!(::kernel::module_param::PARAM_OPS_U64),
+        "isize" => parse_quote!(::kernel::module_param::PARAM_OPS_ISIZE),
+        "usize" => parse_quote!(::kernel::module_param::PARAM_OPS_USIZE),
         t => panic!("Unsupported parameter type {}", t),
     }
 }
@@ -424,29 +437,41 @@ fn parse(input: ParseStream<'_>) -> Result<Self> {
 }
 
 pub(crate) fn module(info: ModuleInfo) -> Result<TokenStream> {
+    let ModuleInfo {
+        type_,
+        license,
+        name,
+        authors,
+        description,
+        alias,
+        firmware,
+        imports_ns,
+        params: _,
+    } = &info;
+
     // Rust does not allow hyphens in identifiers, use underscore instead.
-    let ident = info.name.value().replace('-', "_");
+    let ident = name.value().replace('-', "_");
     let mut modinfo = ModInfoBuilder::new(ident.as_ref());
-    if let Some(authors) = &info.authors {
+    if let Some(authors) = authors {
         for author in authors {
             modinfo.emit("author", &author.value());
         }
     }
-    if let Some(description) = &info.description {
+    if let Some(description) = description {
         modinfo.emit("description", &description.value());
     }
-    modinfo.emit("license", &info.license.value());
-    if let Some(aliases) = &info.alias {
+    modinfo.emit("license", &license.value());
+    if let Some(aliases) = alias {
         for alias in aliases {
             modinfo.emit("alias", &alias.value());
         }
     }
-    if let Some(firmware) = &info.firmware {
+    if let Some(firmware) = firmware {
         for fw in firmware {
             modinfo.emit("firmware", &fw.value());
         }
     }
-    if let Some(imports) = &info.imports_ns {
+    if let Some(imports) = imports_ns {
         for ns in imports {
             modinfo.emit("import_ns", &ns.value());
         }
@@ -459,182 +484,189 @@ pub(crate) fn module(info: ModuleInfo) -> Result<TokenStream> {
 
     modinfo.emit_params(&info);
 
-    Ok(format!(
-        "
-            /// The module name.
-            ///
-            /// Used by the printing macros, e.g. [`info!`].
-            const __LOG_PREFIX: &[u8] = b\"{name}\\0\";
-
-            // SAFETY: `__this_module` is constructed by the kernel at load time and will not be
-            // freed until the module is unloaded.
-            #[cfg(MODULE)]
-            static THIS_MODULE: ::kernel::ThisModule = unsafe {{
-                extern \"C\" {{
-                    static __this_module: ::kernel::types::Opaque<::kernel::bindings::module>;
-                }}
-
-                ::kernel::ThisModule::from_ptr(__this_module.get())
-            }};
-            #[cfg(not(MODULE))]
-            static THIS_MODULE: ::kernel::ThisModule = unsafe {{
-                ::kernel::ThisModule::from_ptr(::core::ptr::null_mut())
-            }};
-
-            /// The `LocalModule` type is the type of the module created by `module!`,
-            /// `module_pci_driver!`, `module_platform_driver!`, etc.
-            type LocalModule = {type_};
-
-            impl ::kernel::ModuleMetadata for {type_} {{
-                const NAME: &'static ::kernel::str::CStr = c\"{name}\";
-            }}
-
-            // Double nested modules, since then nobody can access the public items inside.
-            mod __module_init {{
-                mod __module_init {{
-                    use super::super::{type_};
-                    use pin_init::PinInit;
-
-                    /// The \"Rust loadable module\" mark.
-                    //
-                    // This may be best done another way later on, e.g. as a new modinfo
-                    // key or a new section. For the moment, keep it simple.
-                    #[cfg(MODULE)]
-                    #[doc(hidden)]
-                    #[used(compiler)]
-                    static __IS_RUST_MODULE: () = ();
-
-                    static mut __MOD: ::core::mem::MaybeUninit<{type_}> =
-                        ::core::mem::MaybeUninit::uninit();
-
-                    // Loadable modules need to export the `{{init,cleanup}}_module` identifiers.
-                    /// # Safety
-                    ///
-                    /// This function must not be called after module initialization, because it may be
-                    /// freed after that completes.
-                    #[cfg(MODULE)]
-                    #[doc(hidden)]
-                    #[no_mangle]
-                    #[link_section = \".init.text\"]
-                    pub unsafe extern \"C\" fn init_module() -> ::kernel::ffi::c_int {{
-                        // SAFETY: This function is inaccessible to the outside due to the double
-                        // module wrapping it. It is called exactly once by the C side via its
-                        // unique name.
-                        unsafe {{ __init() }}
-                    }}
-
-                    #[cfg(MODULE)]
-                    #[doc(hidden)]
-                    #[used(compiler)]
-                    #[link_section = \".init.data\"]
-                    static __UNIQUE_ID___addressable_init_module: unsafe extern \"C\" fn() -> i32 = init_module;
-
-                    #[cfg(MODULE)]
-                    #[doc(hidden)]
-                    #[no_mangle]
-                    #[link_section = \".exit.text\"]
-                    pub extern \"C\" fn cleanup_module() {{
-                        // SAFETY:
-                        // - This function is inaccessible to the outside due to the double
-                        //   module wrapping it. It is called exactly once by the C side via its
-                        //   unique name,
-                        // - furthermore it is only called after `init_module` has returned `0`
-                        //   (which delegates to `__init`).
-                        unsafe {{ __exit() }}
-                    }}
-
-                    #[cfg(MODULE)]
-                    #[doc(hidden)]
-                    #[used(compiler)]
-                    #[link_section = \".exit.data\"]
-                    static __UNIQUE_ID___addressable_cleanup_module: extern \"C\" fn() = cleanup_module;
-
-                    // Built-in modules are initialized through an initcall pointer
-                    // and the identifiers need to be unique.
-                    #[cfg(not(MODULE))]
-                    #[cfg(not(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS))]
-                    #[doc(hidden)]
-                    #[link_section = \"{initcall_section}\"]
-                    #[used(compiler)]
-                    pub static __{ident}_initcall: extern \"C\" fn() ->
-                        ::kernel::ffi::c_int = __{ident}_init;
-
-                    #[cfg(not(MODULE))]
-                    #[cfg(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS)]
-                    ::core::arch::global_asm!(
-                        r#\".section \"{initcall_section}\", \"a\"
-                        __{ident}_initcall:
-                            .long   __{ident}_init - .
-                            .previous
-                        \"#
-                    );
-
-                    #[cfg(not(MODULE))]
-                    #[doc(hidden)]
-                    #[no_mangle]
-                    pub extern \"C\" fn __{ident}_init() -> ::kernel::ffi::c_int {{
-                        // SAFETY: This function is inaccessible to the outside due to the double
-                        // module wrapping it. It is called exactly once by the C side via its
-                        // placement above in the initcall section.
-                        unsafe {{ __init() }}
-                    }}
-
-                    #[cfg(not(MODULE))]
-                    #[doc(hidden)]
-                    #[no_mangle]
-                    pub extern \"C\" fn __{ident}_exit() {{
-                        // SAFETY:
-                        // - This function is inaccessible to the outside due to the double
-                        //   module wrapping it. It is called exactly once by the C side via its
-                        //   unique name,
-                        // - furthermore it is only called after `__{ident}_init` has
-                        //   returned `0` (which delegates to `__init`).
-                        unsafe {{ __exit() }}
-                    }}
-
-                    /// # Safety
-                    ///
-                    /// This function must only be called once.
-                    unsafe fn __init() -> ::kernel::ffi::c_int {{
-                        let initer =
-                            <{type_} as ::kernel::InPlaceModule>::init(&super::super::THIS_MODULE);
-                        // SAFETY: No data race, since `__MOD` can only be accessed by this module
-                        // and there only `__init` and `__exit` access it. These functions are only
-                        // called once and `__exit` cannot be called before or during `__init`.
-                        match unsafe {{ initer.__pinned_init(__MOD.as_mut_ptr()) }} {{
-                            Ok(m) => 0,
-                            Err(e) => e.to_errno(),
-                        }}
-                    }}
-
-                    /// # Safety
-                    ///
-                    /// This function must
-                    /// - only be called once,
-                    /// - be called after `__init` has been called and returned `0`.
-                    unsafe fn __exit() {{
-                        // SAFETY: No data race, since `__MOD` can only be accessed by this module
-                        // and there only `__init` and `__exit` access it. These functions are only
-                        // called once and `__init` was already called.
-                        unsafe {{
-                            // Invokes `drop()` on `__MOD`, which should be used for cleanup.
-                            __MOD.assume_init_drop();
-                        }}
-                    }}
-                    {modinfo}
-                }}
-            }}
-            mod module_parameters {{
-                {params}
-            }}
-        ",
-        type_ = info.type_,
-        name = info.name.value(),
-        ident = ident,
-        modinfo = modinfo.buffer,
-        params = modinfo.param_buffer,
-        initcall_section = ".initcall6.init"
-    )
-    .parse()
-    .expect("Error parsing formatted string into token stream."))
+    let modinfo_ts = modinfo.ts;
+    let params_ts = modinfo.param_ts;
+
+    let ident_init = format_ident!("__{ident}_init");
+    let ident_exit = format_ident!("__{ident}_exit");
+    let ident_initcall = format_ident!("__{ident}_initcall");
+    let initcall_section = ".initcall6.init";
+
+    let global_asm = format!(
+        r#".section "{initcall_section}", "a"
+        __{ident}_initcall:
+            .long   __{ident}_init - .
+            .previous
+        "#
+    );
+
+    let name_cstr =
+        Literal::c_string(&CString::new(name.value()).expect("name contains NUL-terminator"));
+
+    Ok(quote! {
+        /// The module name.
+        ///
+        /// Used by the printing macros, e.g. [`info!`].
+        const __LOG_PREFIX: &[u8] = #name_cstr.to_bytes_with_nul();
+
+        // SAFETY: `__this_module` is constructed by the kernel at load time and will not be
+        // freed until the module is unloaded.
+        #[cfg(MODULE)]
+        static THIS_MODULE: ::kernel::ThisModule = unsafe {
+            extern "C" {
+                static __this_module: ::kernel::types::Opaque<::kernel::bindings::module>;
+            };
+
+            ::kernel::ThisModule::from_ptr(__this_module.get())
+        };
+
+        #[cfg(not(MODULE))]
+        static THIS_MODULE: ::kernel::ThisModule = unsafe {
+            ::kernel::ThisModule::from_ptr(::core::ptr::null_mut())
+        };
+
+        /// The `LocalModule` type is the type of the module created by `module!`,
+        /// `module_pci_driver!`, `module_platform_driver!`, etc.
+        type LocalModule = #type_;
+
+        impl ::kernel::ModuleMetadata for #type_ {
+            const NAME: &'static ::kernel::str::CStr = #name_cstr;
+        }
+
+        // Double nested modules, since then nobody can access the public items inside.
+        mod __module_init {
+            mod __module_init {
+                use super::super::#type_;
+                use pin_init::PinInit;
+
+                /// The "Rust loadable module" mark.
+                //
+                // This may be best done another way later on, e.g. as a new modinfo
+                // key or a new section. For the moment, keep it simple.
+                #[cfg(MODULE)]
+                #[doc(hidden)]
+                #[used(compiler)]
+                static __IS_RUST_MODULE: () = ();
+
+                static mut __MOD: ::core::mem::MaybeUninit<#type_> =
+                    ::core::mem::MaybeUninit::uninit();
+
+                // Loadable modules need to export the `{init,cleanup}_module` identifiers.
+                /// # Safety
+                ///
+                /// This function must not be called after module initialization, because it may be
+                /// freed after that completes.
+                #[cfg(MODULE)]
+                #[doc(hidden)]
+                #[no_mangle]
+                #[link_section = ".init.text"]
+                pub unsafe extern "C" fn init_module() -> ::kernel::ffi::c_int {
+                    // SAFETY: This function is inaccessible to the outside due to the double
+                    // module wrapping it. It is called exactly once by the C side via its
+                    // unique name.
+                    unsafe { __init() }
+                }
+
+                #[cfg(MODULE)]
+                #[doc(hidden)]
+                #[used(compiler)]
+                #[link_section = ".init.data"]
+                static __UNIQUE_ID___addressable_init_module: unsafe extern "C" fn() -> i32 =
+                    init_module;
+
+                #[cfg(MODULE)]
+                #[doc(hidden)]
+                #[no_mangle]
+                #[link_section = ".exit.text"]
+                pub extern "C" fn cleanup_module() {
+                    // SAFETY:
+                    // - This function is inaccessible to the outside due to the double
+                    //   module wrapping it. It is called exactly once by the C side via its
+                    //   unique name,
+                    // - furthermore it is only called after `init_module` has returned `0`
+                    //   (which delegates to `__init`).
+                    unsafe { __exit() }
+                }
+
+                #[cfg(MODULE)]
+                #[doc(hidden)]
+                #[used(compiler)]
+                #[link_section = ".exit.data"]
+                static __UNIQUE_ID___addressable_cleanup_module: extern "C" fn() = cleanup_module;
+
+                // Built-in modules are initialized through an initcall pointer
+                // and the identifiers need to be unique.
+                #[cfg(not(MODULE))]
+                #[cfg(not(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS))]
+                #[doc(hidden)]
+                #[link_section = #initcall_section]
+                #[used(compiler)]
+                pub static #ident_initcall: extern "C" fn() ->
+                    ::kernel::ffi::c_int = #ident_initcall;
+
+                #[cfg(not(MODULE))]
+                #[cfg(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS)]
+                ::core::arch::global_asm!(#global_asm);
+
+                #[cfg(not(MODULE))]
+                #[doc(hidden)]
+                #[no_mangle]
+                pub extern "C" fn #ident_init() -> ::kernel::ffi::c_int {
+                    // SAFETY: This function is inaccessible to the outside due to the double
+                    // module wrapping it. It is called exactly once by the C side via its
+                    // placement above in the initcall section.
+                    unsafe { __init() }
+                }
+
+                #[cfg(not(MODULE))]
+                #[doc(hidden)]
+                #[no_mangle]
+                pub extern "C" fn #ident_exit() {
+                    // SAFETY:
+                    // - This function is inaccessible to the outside due to the double
+                    //   module wrapping it. It is called exactly once by the C side via its
+                    //   unique name,
+                    // - furthermore it is only called after `#ident_init` has
+                    //   returned `0` (which delegates to `__init`).
+                    unsafe { __exit() }
+                }
+
+                /// # Safety
+                ///
+                /// This function must only be called once.
+                unsafe fn __init() -> ::kernel::ffi::c_int {
+                    let initer =
+                        <#type_ as ::kernel::InPlaceModule>::init(&super::super::THIS_MODULE);
+                    // SAFETY: No data race, since `__MOD` can only be accessed by this module
+                    // and there only `__init` and `__exit` access it. These functions are only
+                    // called once and `__exit` cannot be called before or during `__init`.
+                    match unsafe { initer.__pinned_init(__MOD.as_mut_ptr()) } {
+                        Ok(m) => 0,
+                        Err(e) => e.to_errno(),
+                    }
+                }
+
+                /// # Safety
+                ///
+                /// This function must
+                /// - only be called once,
+                /// - be called after `__init` has been called and returned `0`.
+                unsafe fn __exit() {
+                    // SAFETY: No data race, since `__MOD` can only be accessed by this module
+                    // and there only `__init` and `__exit` access it. These functions are only
+                    // called once and `__init` was already called.
+                    unsafe {
+                        // Invokes `drop()` on `__MOD`, which should be used for cleanup.
+                        __MOD.assume_init_drop();
+                    }
+                }
+
+                #modinfo_ts
+            }
+        }
+
+        mod module_parameters {
+            #params_ts
+        }
+    })
 }
-- 
2.51.2

