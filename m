Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9D934AAF4
	for <linux-modules@vger.kernel.org>; Wed,  7 Jan 2026 17:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767806436; cv=none; b=WJvKLtrDwNr3VCkCwRrnCIyMV9KbVo734wdLdJDP7SDNxP82PeilfDpwMIP9iPXGDXgCMr7vLrsk8CSSRpNfm/mVd92VKJZWbQdnHAgdHLtYTabvMnnA4fBBcD57QB6WS6etQY4lg78YSleYFzvk33ekDHdRhom6vQ5Hb1KqKCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767806436; c=relaxed/simple;
	bh=QL9jcMj+ETrVXAiXeeOJhQrxHBRfeRM02oQZagOTvAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j9dWKHBI8/633Y6H0+ErtXqLIIAsIDRGzzEc4ByHv0aaH+ylccItHSESRveQEzT02WRV1YojxKn5bTNDGt/3Els9ulqeSXDtMfnYg9QFSjEvgVydmo+08SZ0APckbzEwwao71ABOvibEUJPebwxr10TBUXO/IUll0KrzxuzyYT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nLRgNami; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLRgNami"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-650854c473fso2126256a12.1
        for <linux-modules@vger.kernel.org>; Wed, 07 Jan 2026 09:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767806404; x=1768411204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rd08SHTTj7f1dJuOaAtBbUFL/jwvZKz65J+rP5gH78c=;
        b=nLRgNamicRzc0ptHpKQdGPk2Po+nYQFc3c9fGYaJUPOKZVkQmfd/WQarCiDpJHPDPT
         dznRaRkAyW2L7tWmwdnrKQGaICP1jSydwabSZWORPVjDv0rNJ4h8bpaMhiKlh+VcrsQX
         fqlRKHExe9hVupO8lVb0YuO8jk2giJl7xXOamrgJwINJ+PhxR7R1dn4jE1T6xBzDOKOc
         Q6usOEwJ9HRieJdxOpYM63NRVsvlev8uG3jhAQofp0my7y8qDjnB9/gvjiN1nen/eLcF
         fwP+ynXm57uAbpSbiF60dinwODVEF0Wy3QPUEkVDjMUTbC02gx1mvsXULA4LVIonEIy7
         oh4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767806404; x=1768411204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rd08SHTTj7f1dJuOaAtBbUFL/jwvZKz65J+rP5gH78c=;
        b=Kv1S/O0qMvmNeGTVpyPIQxWWvtuhZWFnicRRJjOP2KeQmesLy0i4c3vKY8L9fWGc6+
         lkjiCSDqyn//3xE0zXW2NV9/IchxBFu7PdvQYv0xC9vG7ND8xUwDA/wK4O50xfmijlnp
         JQk6Ls+lteGin4KojjBjUZ6OqaWuV34sKWR3XLnPcZJn8gWdbR9Ef5u0Qspj5MlEM9Sy
         p1wCylgWUK3EqOtDBDohrnNJDpPOSqnTzsiT/M3ttXoNIqbyqewUEb1BUFvBmDGma+Ke
         UFWsOMCrG4B9nd6bnyBRS9ThY1bMo+U3LmGzywy0EiY7V3zRqtAfcuGgvCBks31V9v1j
         z7Fg==
X-Forwarded-Encrypted: i=1; AJvYcCWo1FX2untGij79rLlXJdhTqHuBDy5s/MDHvDaiRfD8i81AhPHgDbrfAkfNs3+SZfbc10mxDpvcx3ERgnMD@vger.kernel.org
X-Gm-Message-State: AOJu0YwWmTnxaZhHy8Y3B6IiR4BmPFaI8zWwfr1aaboensbncHUkJpcO
	C/yssrbMz802poKesr4Cm1gIG5lXJnWTJ5ayuZ8r9IuA38XywFgTx28z15Zx/gMIRA++22wMEor
	Pu/i7X5CVoV1L1D/Id9/2ORer+Iu3sTc=
X-Gm-Gg: AY/fxX7PLL/AeUNG2QmnVRelBNQ0J83fEFExTTHF/i3KSSMf5MOZniMTBFJtLvEtj3+
	xPTjutGOsrnyeKCVVcjRl6Nnt164LaxrY9/MFOaMa/04h6wxvKM0TVSqmwzKcWXW6z3s57BCbib
	YLDvJpFFH0STarFR4q6zM8UJqZMIF6R6OUfFqE8VEkzzIfYeg9+8Sbrz/9CdIZZqCSNNibwTPY+
	SvZpvyfK82TL/1OZyU/aq+o+/JWaMdzebsB001D6/XuXPjbz7C0EiAFroS1XqyndDrjA48YP99y
	MQJW7NilmU5gRUMRx5JLBj3h/4r11UEfroIb7STO7NsoLsipsxqhzHdVZ0p+UHlA2IJJ4pRXCXJ
	HX+WWfQ==
X-Google-Smtp-Source: AGHT+IHYEVDPE/m6s2S849lqeZ3TCTfWOFcfmFKb0ttg3h8Y3qFfF2S7aaIm2tydbi37qEKP7f6i1hILTVQp/piFLZA=
X-Received: by 2002:a05:6402:27c6:b0:64b:5d42:52f4 with SMTP id
 4fb4d7f45d1cf-65097c2b227mr3154355a12.15.1767806403508; Wed, 07 Jan 2026
 09:20:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107161729.3855851-1-gary@kernel.org> <20260107161729.3855851-6-gary@kernel.org>
In-Reply-To: <20260107161729.3855851-6-gary@kernel.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 7 Jan 2026 12:19:26 -0500
X-Gm-Features: AQt7F2qrupF0mJmGQ4cfot4Pmw5wtk6lPIaVw4MP0MDMjGBSkJSiRc0NWIyeOQg
Message-ID: <CAJ-ks9nzn3wgZMaQFXFHBOEf-Fuhr61Tp7Knvu0CWOWYgOEqDw@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] rust: macros: use `quote!` for `module!` macro
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, rust-for-linux@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 11:59=E2=80=AFAM Gary Guo <gary@kernel.org> wrote:
>
> From: Gary Guo <gary@garyguo.net>
>
> This has no behavioural change, but is good for maintainability. With
> `quote!`, we're no longer using string templates, so we don't need to
> quote " and {} inside the template anymore. Further more, editors can
> now highlight the code template.
>
> This also improves the robustness as it eliminates the need for string
> quoting and escaping.
>
> Co-developed-by: Benno Lossin <lossin@kernel.org>
> Signed-off-by: Benno Lossin <lossin@kernel.org>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Are there significant changes here? You didn't pick up my tag.

> ---
>  rust/macros/module.rs | 558 ++++++++++++++++++++++--------------------
>  1 file changed, 295 insertions(+), 263 deletions(-)
>
> diff --git a/rust/macros/module.rs b/rust/macros/module.rs
> index 6ad7b411ccde4..ba345d672839e 100644
> --- a/rust/macros/module.rs
> +++ b/rust/macros/module.rs
> @@ -1,12 +1,15 @@
>  // SPDX-License-Identifier: GPL-2.0
>
> -use std::fmt::Write;
> +use std::ffi::CString;
>
>  use proc_macro2::{
>      Literal,
>      TokenStream, //
>  };
> -use quote::ToTokens;
> +use quote::{
> +    format_ident,
> +    quote, //
> +};
>  use syn::{
>      braced,
>      bracketed,
> @@ -15,11 +18,13 @@
>          Parse,
>          ParseStream, //
>      },
> +    parse_quote,
>      punctuated::Punctuated,
>      Error,
>      Expr,
>      Ident,
>      LitStr,
> +    Path,
>      Result,
>      Token, //
>  };
> @@ -29,8 +34,8 @@
>  struct ModInfoBuilder<'a> {
>      module: &'a str,
>      counter: usize,
> -    buffer: String,
> -    param_buffer: String,
> +    ts: TokenStream,
> +    param_ts: TokenStream,
>  }
>
>  impl<'a> ModInfoBuilder<'a> {
> @@ -38,8 +43,8 @@ fn new(module: &'a str) -> Self {
>          ModInfoBuilder {
>              module,
>              counter: 0,
> -            buffer: String::new(),
> -            param_buffer: String::new(),
> +            ts: TokenStream::new(),
> +            param_ts: TokenStream::new(),
>          }
>      }
>
> @@ -56,33 +61,32 @@ fn emit_base(&mut self, field: &str, content: &str, b=
uiltin: bool, param: bool)
>              // Loadable modules' modinfo strings go as-is.
>              format!("{field}=3D{content}\0")
>          };
> -
> -        let buffer =3D if param {
> -            &mut self.param_buffer
> +        let length =3D string.len();
> +        let string =3D Literal::byte_string(string.as_bytes());
> +        let cfg =3D if builtin {
> +            quote!(#[cfg(not(MODULE))])
>          } else {
> -            &mut self.buffer
> +            quote!(#[cfg(MODULE)])
>          };
>
> -        write!(
> -            buffer,
> -            "
> -                {cfg}
> -                #[doc(hidden)]
> -                #[cfg_attr(not(target_os =3D \"macos\"), link_section =
=3D \".modinfo\")]
> -                #[used(compiler)]
> -                pub static __{module}_{counter}: [u8; {length}] =3D *{st=
ring};
> -            ",
> -            cfg =3D if builtin {
> -                "#[cfg(not(MODULE))]"
> -            } else {
> -                "#[cfg(MODULE)]"
> -            },
> +        let counter =3D format_ident!(
> +            "__{module}_{counter}",
>              module =3D self.module.to_uppercase(),
> -            counter =3D self.counter,
> -            length =3D string.len(),
> -            string =3D Literal::byte_string(string.as_bytes()),
> -        )
> -        .unwrap();
> +            counter =3D self.counter
> +        );
> +        let item =3D quote! {
> +            #cfg
> +            #[doc(hidden)]
> +            #[cfg_attr(not(target_os =3D "macos"), link_section =3D ".mo=
dinfo")]
> +            #[used(compiler)]
> +            pub static #counter: [u8; #length] =3D *#string;
> +        };
> +
> +        if param {
> +            self.param_ts.extend(item);
> +        } else {
> +            self.ts.extend(item);
> +        }
>
>          self.counter +=3D 1;
>      }
> @@ -115,77 +119,86 @@ fn emit_params(&mut self, info: &ModuleInfo) {
>          };
>
>          for param in params {
> -            let param_name =3D param.name.to_string();
> -            let param_type =3D param.ptype.to_string();
> -            let param_default =3D param.default.to_token_stream().to_str=
ing();
> +            let param_name_str =3D param.name.to_string();
> +            let param_type_str =3D param.ptype.to_string();

This renaming is unfortunately; these variables were just introduced
in the previous patch.

>
> -            let ops =3D param_ops_path(&param_type);
> +            let ops =3D param_ops_path(&param_type_str);
>
>              // Note: The spelling of these fields is dictated by the use=
r space
>              // tool `modinfo`.
> -            self.emit_param("parmtype", &param_name, &param_type);
> -            self.emit_param("parm", &param_name, &param.description.valu=
e());
> -
> -            write!(
> -                self.param_buffer,
> -                "
> -                pub(crate) static {param_name}:
> -                    ::kernel::module_param::ModuleParamAccess<{param_typ=
e}> =3D
> -                        ::kernel::module_param::ModuleParamAccess::new({=
param_default});
> -
> -                const _: () =3D {{
> -                    #[link_section =3D \"__param\"]
> -                    #[used]
> -                    static __{module_name}_{param_name}_struct:
> +            self.emit_param("parmtype", &param_name_str, &param_type_str=
);
> +            self.emit_param("parm", &param_name_str, &param.description.=
value());
> +
> +            let static_name =3D format_ident!("__{}_{}_struct", self.mod=
ule, param.name);
> +            let param_name_cstr =3D Literal::c_string(
> +                &CString::new(param_name_str).expect("name contains NUL-=
terminator"),
> +            );
> +            let param_name_cstr_with_module =3D Literal::c_string(
> +                &CString::new(format!("{}.{}", self.module, param.name))
> +                    .expect("name contains NUL-terminator"),
> +            );
> +
> +            let param_name =3D &param.name;
> +            let param_type =3D &param.ptype;
> +            let param_default =3D &param.default;
> +
> +            self.param_ts.extend(quote!{
> +                #[allow(non_upper_case_globals)]
> +                pub(crate) static #param_name:
> +                    ::kernel::module_param::ModuleParamAccess<#param_typ=
e> =3D
> +                        ::kernel::module_param::ModuleParamAccess::new(#=
param_default);
> +
> +                const _: () =3D {
> +                    #[allow(non_upper_case_globals)]
> +                    #[link_section =3D "__param"]
> +                    #[used(compiler)]
> +                    static #static_name:
>                          ::kernel::module_param::KernelParam =3D
>                          ::kernel::module_param::KernelParam::new(
> -                            ::kernel::bindings::kernel_param {{
> -                                name: if ::core::cfg!(MODULE) {{
> -                                    ::kernel::c_str!(\"{param_name}\").t=
o_bytes_with_nul()
> -                                }} else {{
> -                                    ::kernel::c_str!(\"{module_name}.{pa=
ram_name}\")
> -                                        .to_bytes_with_nul()
> -                                }}.as_ptr(),
> +                            ::kernel::bindings::kernel_param {
> +                                name: kernel::str::as_char_ptr_in_const_=
context(
> +                                    if ::core::cfg!(MODULE) {
> +                                        #param_name_cstr
> +                                    } else {
> +                                        #param_name_cstr_with_module
> +                                    }
> +                                ),
>                                  // SAFETY: `__this_module` is constructe=
d by the kernel at load
>                                  // time and will not be freed until the =
module is unloaded.
>                                  #[cfg(MODULE)]
> -                                mod_: unsafe {{
> +                                mod_: unsafe {
>                                      core::ptr::from_ref(&::kernel::bindi=
ngs::__this_module)
>                                          .cast_mut()
> -                                }},
> +                                },
>                                  #[cfg(not(MODULE))]
>                                  mod_: ::core::ptr::null_mut(),
> -                                ops: core::ptr::from_ref(&{ops}),
> +                                ops: core::ptr::from_ref(&#ops),
>                                  perm: 0, // Will not appear in sysfs
>                                  level: -1,
>                                  flags: 0,
> -                                __bindgen_anon_1: ::kernel::bindings::ke=
rnel_param__bindgen_ty_1 {{
> -                                    arg: {param_name}.as_void_ptr()
> -                                }},
> -                            }}
> +                                __bindgen_anon_1: ::kernel::bindings::ke=
rnel_param__bindgen_ty_1 {
> +                                    arg: #param_name.as_void_ptr()
> +                                },
> +                            }
>                          );
> -                }};
> -                ",
> -                module_name =3D info.name.value(),
> -                ops =3D ops,
> -            )
> -            .unwrap();
> +                };
> +            });
>          }
>      }
>  }
>
> -fn param_ops_path(param_type: &str) -> &'static str {
> +fn param_ops_path(param_type: &str) -> Path {
>      match param_type {
> -        "i8" =3D> "::kernel::module_param::PARAM_OPS_I8",
> -        "u8" =3D> "::kernel::module_param::PARAM_OPS_U8",
> -        "i16" =3D> "::kernel::module_param::PARAM_OPS_I16",
> -        "u16" =3D> "::kernel::module_param::PARAM_OPS_U16",
> -        "i32" =3D> "::kernel::module_param::PARAM_OPS_I32",
> -        "u32" =3D> "::kernel::module_param::PARAM_OPS_U32",
> -        "i64" =3D> "::kernel::module_param::PARAM_OPS_I64",
> -        "u64" =3D> "::kernel::module_param::PARAM_OPS_U64",
> -        "isize" =3D> "::kernel::module_param::PARAM_OPS_ISIZE",
> -        "usize" =3D> "::kernel::module_param::PARAM_OPS_USIZE",
> +        "i8" =3D> parse_quote!(::kernel::module_param::PARAM_OPS_I8),
> +        "u8" =3D> parse_quote!(::kernel::module_param::PARAM_OPS_U8),
> +        "i16" =3D> parse_quote!(::kernel::module_param::PARAM_OPS_I16),
> +        "u16" =3D> parse_quote!(::kernel::module_param::PARAM_OPS_U16),
> +        "i32" =3D> parse_quote!(::kernel::module_param::PARAM_OPS_I32),
> +        "u32" =3D> parse_quote!(::kernel::module_param::PARAM_OPS_U32),
> +        "i64" =3D> parse_quote!(::kernel::module_param::PARAM_OPS_I64),
> +        "u64" =3D> parse_quote!(::kernel::module_param::PARAM_OPS_U64),
> +        "isize" =3D> parse_quote!(::kernel::module_param::PARAM_OPS_ISIZ=
E),
> +        "usize" =3D> parse_quote!(::kernel::module_param::PARAM_OPS_USIZ=
E),
>          t =3D> panic!("Unsupported parameter type {}", t),
>      }
>  }
> @@ -424,29 +437,41 @@ fn parse(input: ParseStream<'_>) -> Result<Self> {
>  }
>
>  pub(crate) fn module(info: ModuleInfo) -> Result<TokenStream> {
> +    let ModuleInfo {
> +        type_,
> +        license,
> +        name,
> +        authors,
> +        description,
> +        alias,
> +        firmware,
> +        imports_ns,
> +        params: _,
> +    } =3D &info;
> +
>      // Rust does not allow hyphens in identifiers, use underscore instea=
d.
> -    let ident =3D info.name.value().replace('-', "_");
> +    let ident =3D name.value().replace('-', "_");
>      let mut modinfo =3D ModInfoBuilder::new(ident.as_ref());
> -    if let Some(authors) =3D &info.authors {
> +    if let Some(authors) =3D authors {
>          for author in authors {
>              modinfo.emit("author", &author.value());
>          }
>      }
> -    if let Some(description) =3D &info.description {
> +    if let Some(description) =3D description {
>          modinfo.emit("description", &description.value());
>      }
> -    modinfo.emit("license", &info.license.value());
> -    if let Some(aliases) =3D &info.alias {
> +    modinfo.emit("license", &license.value());
> +    if let Some(aliases) =3D alias {
>          for alias in aliases {
>              modinfo.emit("alias", &alias.value());
>          }
>      }
> -    if let Some(firmware) =3D &info.firmware {
> +    if let Some(firmware) =3D firmware {
>          for fw in firmware {
>              modinfo.emit("firmware", &fw.value());
>          }
>      }
> -    if let Some(imports) =3D &info.imports_ns {
> +    if let Some(imports) =3D imports_ns {
>          for ns in imports {
>              modinfo.emit("import_ns", &ns.value());
>          }
> @@ -459,182 +484,189 @@ pub(crate) fn module(info: ModuleInfo) -> Result<=
TokenStream> {
>
>      modinfo.emit_params(&info);
>
> -    Ok(format!(
> -        "
> -            /// The module name.
> -            ///
> -            /// Used by the printing macros, e.g. [`info!`].
> -            const __LOG_PREFIX: &[u8] =3D b\"{name}\\0\";
> -
> -            // SAFETY: `__this_module` is constructed by the kernel at l=
oad time and will not be
> -            // freed until the module is unloaded.
> -            #[cfg(MODULE)]
> -            static THIS_MODULE: ::kernel::ThisModule =3D unsafe {{
> -                extern \"C\" {{
> -                    static __this_module: ::kernel::types::Opaque<::kern=
el::bindings::module>;
> -                }}
> -
> -                ::kernel::ThisModule::from_ptr(__this_module.get())
> -            }};
> -            #[cfg(not(MODULE))]
> -            static THIS_MODULE: ::kernel::ThisModule =3D unsafe {{
> -                ::kernel::ThisModule::from_ptr(::core::ptr::null_mut())
> -            }};
> -
> -            /// The `LocalModule` type is the type of the module created=
 by `module!`,
> -            /// `module_pci_driver!`, `module_platform_driver!`, etc.
> -            type LocalModule =3D {type_};
> -
> -            impl ::kernel::ModuleMetadata for {type_} {{
> -                const NAME: &'static ::kernel::str::CStr =3D c\"{name}\"=
;
> -            }}
> -
> -            // Double nested modules, since then nobody can access the p=
ublic items inside.
> -            mod __module_init {{
> -                mod __module_init {{
> -                    use super::super::{type_};
> -                    use pin_init::PinInit;
> -
> -                    /// The \"Rust loadable module\" mark.
> -                    //
> -                    // This may be best done another way later on, e.g. =
as a new modinfo
> -                    // key or a new section. For the moment, keep it sim=
ple.
> -                    #[cfg(MODULE)]
> -                    #[doc(hidden)]
> -                    #[used(compiler)]
> -                    static __IS_RUST_MODULE: () =3D ();
> -
> -                    static mut __MOD: ::core::mem::MaybeUninit<{type_}> =
=3D
> -                        ::core::mem::MaybeUninit::uninit();
> -
> -                    // Loadable modules need to export the `{{init,clean=
up}}_module` identifiers.
> -                    /// # Safety
> -                    ///
> -                    /// This function must not be called after module in=
itialization, because it may be
> -                    /// freed after that completes.
> -                    #[cfg(MODULE)]
> -                    #[doc(hidden)]
> -                    #[no_mangle]
> -                    #[link_section =3D \".init.text\"]
> -                    pub unsafe extern \"C\" fn init_module() -> ::kernel=
::ffi::c_int {{
> -                        // SAFETY: This function is inaccessible to the =
outside due to the double
> -                        // module wrapping it. It is called exactly once=
 by the C side via its
> -                        // unique name.
> -                        unsafe {{ __init() }}
> -                    }}
> -
> -                    #[cfg(MODULE)]
> -                    #[doc(hidden)]
> -                    #[used(compiler)]
> -                    #[link_section =3D \".init.data\"]
> -                    static __UNIQUE_ID___addressable_init_module: unsafe=
 extern \"C\" fn() -> i32 =3D init_module;
> -
> -                    #[cfg(MODULE)]
> -                    #[doc(hidden)]
> -                    #[no_mangle]
> -                    #[link_section =3D \".exit.text\"]
> -                    pub extern \"C\" fn cleanup_module() {{
> -                        // SAFETY:
> -                        // - This function is inaccessible to the outsid=
e due to the double
> -                        //   module wrapping it. It is called exactly on=
ce by the C side via its
> -                        //   unique name,
> -                        // - furthermore it is only called after `init_m=
odule` has returned `0`
> -                        //   (which delegates to `__init`).
> -                        unsafe {{ __exit() }}
> -                    }}
> -
> -                    #[cfg(MODULE)]
> -                    #[doc(hidden)]
> -                    #[used(compiler)]
> -                    #[link_section =3D \".exit.data\"]
> -                    static __UNIQUE_ID___addressable_cleanup_module: ext=
ern \"C\" fn() =3D cleanup_module;
> -
> -                    // Built-in modules are initialized through an initc=
all pointer
> -                    // and the identifiers need to be unique.
> -                    #[cfg(not(MODULE))]
> -                    #[cfg(not(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS))]
> -                    #[doc(hidden)]
> -                    #[link_section =3D \"{initcall_section}\"]
> -                    #[used(compiler)]
> -                    pub static __{ident}_initcall: extern \"C\" fn() ->
> -                        ::kernel::ffi::c_int =3D __{ident}_init;
> -
> -                    #[cfg(not(MODULE))]
> -                    #[cfg(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS)]
> -                    ::core::arch::global_asm!(
> -                        r#\".section \"{initcall_section}\", \"a\"
> -                        __{ident}_initcall:
> -                            .long   __{ident}_init - .
> -                            .previous
> -                        \"#
> -                    );
> -
> -                    #[cfg(not(MODULE))]
> -                    #[doc(hidden)]
> -                    #[no_mangle]
> -                    pub extern \"C\" fn __{ident}_init() -> ::kernel::ff=
i::c_int {{
> -                        // SAFETY: This function is inaccessible to the =
outside due to the double
> -                        // module wrapping it. It is called exactly once=
 by the C side via its
> -                        // placement above in the initcall section.
> -                        unsafe {{ __init() }}
> -                    }}
> -
> -                    #[cfg(not(MODULE))]
> -                    #[doc(hidden)]
> -                    #[no_mangle]
> -                    pub extern \"C\" fn __{ident}_exit() {{
> -                        // SAFETY:
> -                        // - This function is inaccessible to the outsid=
e due to the double
> -                        //   module wrapping it. It is called exactly on=
ce by the C side via its
> -                        //   unique name,
> -                        // - furthermore it is only called after `__{ide=
nt}_init` has
> -                        //   returned `0` (which delegates to `__init`).
> -                        unsafe {{ __exit() }}
> -                    }}
> -
> -                    /// # Safety
> -                    ///
> -                    /// This function must only be called once.
> -                    unsafe fn __init() -> ::kernel::ffi::c_int {{
> -                        let initer =3D
> -                            <{type_} as ::kernel::InPlaceModule>::init(&=
super::super::THIS_MODULE);
> -                        // SAFETY: No data race, since `__MOD` can only =
be accessed by this module
> -                        // and there only `__init` and `__exit` access i=
t. These functions are only
> -                        // called once and `__exit` cannot be called bef=
ore or during `__init`.
> -                        match unsafe {{ initer.__pinned_init(__MOD.as_mu=
t_ptr()) }} {{
> -                            Ok(m) =3D> 0,
> -                            Err(e) =3D> e.to_errno(),
> -                        }}
> -                    }}
> -
> -                    /// # Safety
> -                    ///
> -                    /// This function must
> -                    /// - only be called once,
> -                    /// - be called after `__init` has been called and r=
eturned `0`.
> -                    unsafe fn __exit() {{
> -                        // SAFETY: No data race, since `__MOD` can only =
be accessed by this module
> -                        // and there only `__init` and `__exit` access i=
t. These functions are only
> -                        // called once and `__init` was already called.
> -                        unsafe {{
> -                            // Invokes `drop()` on `__MOD`, which should=
 be used for cleanup.
> -                            __MOD.assume_init_drop();
> -                        }}
> -                    }}
> -                    {modinfo}
> -                }}
> -            }}
> -            mod module_parameters {{
> -                {params}
> -            }}
> -        ",
> -        type_ =3D info.type_,
> -        name =3D info.name.value(),
> -        ident =3D ident,
> -        modinfo =3D modinfo.buffer,
> -        params =3D modinfo.param_buffer,
> -        initcall_section =3D ".initcall6.init"
> -    )
> -    .parse()
> -    .expect("Error parsing formatted string into token stream."))
> +    let modinfo_ts =3D modinfo.ts;
> +    let params_ts =3D modinfo.param_ts;
> +
> +    let ident_init =3D format_ident!("__{ident}_init");
> +    let ident_exit =3D format_ident!("__{ident}_exit");
> +    let ident_initcall =3D format_ident!("__{ident}_initcall");
> +    let initcall_section =3D ".initcall6.init";
> +
> +    let global_asm =3D format!(
> +        r#".section "{initcall_section}", "a"
> +        __{ident}_initcall:
> +            .long   __{ident}_init - .
> +            .previous
> +        "#
> +    );
> +
> +    let name_cstr =3D
> +        Literal::c_string(&CString::new(name.value()).expect("name conta=
ins NUL-terminator"));
> +
> +    Ok(quote! {
> +        /// The module name.
> +        ///
> +        /// Used by the printing macros, e.g. [`info!`].
> +        const __LOG_PREFIX: &[u8] =3D #name_cstr.to_bytes_with_nul();
> +
> +        // SAFETY: `__this_module` is constructed by the kernel at load =
time and will not be
> +        // freed until the module is unloaded.
> +        #[cfg(MODULE)]
> +        static THIS_MODULE: ::kernel::ThisModule =3D unsafe {
> +            extern "C" {
> +                static __this_module: ::kernel::types::Opaque<::kernel::=
bindings::module>;
> +            };
> +
> +            ::kernel::ThisModule::from_ptr(__this_module.get())
> +        };
> +
> +        #[cfg(not(MODULE))]
> +        static THIS_MODULE: ::kernel::ThisModule =3D unsafe {
> +            ::kernel::ThisModule::from_ptr(::core::ptr::null_mut())
> +        };
> +
> +        /// The `LocalModule` type is the type of the module created by =
`module!`,
> +        /// `module_pci_driver!`, `module_platform_driver!`, etc.
> +        type LocalModule =3D #type_;
> +
> +        impl ::kernel::ModuleMetadata for #type_ {
> +            const NAME: &'static ::kernel::str::CStr =3D #name_cstr;
> +        }
> +
> +        // Double nested modules, since then nobody can access the publi=
c items inside.
> +        mod __module_init {
> +            mod __module_init {
> +                use super::super::#type_;
> +                use pin_init::PinInit;
> +
> +                /// The "Rust loadable module" mark.
> +                //
> +                // This may be best done another way later on, e.g. as a=
 new modinfo
> +                // key or a new section. For the moment, keep it simple.
> +                #[cfg(MODULE)]
> +                #[doc(hidden)]
> +                #[used(compiler)]
> +                static __IS_RUST_MODULE: () =3D ();
> +
> +                static mut __MOD: ::core::mem::MaybeUninit<#type_> =3D
> +                    ::core::mem::MaybeUninit::uninit();
> +
> +                // Loadable modules need to export the `{init,cleanup}_m=
odule` identifiers.
> +                /// # Safety
> +                ///
> +                /// This function must not be called after module initia=
lization, because it may be
> +                /// freed after that completes.
> +                #[cfg(MODULE)]
> +                #[doc(hidden)]
> +                #[no_mangle]
> +                #[link_section =3D ".init.text"]
> +                pub unsafe extern "C" fn init_module() -> ::kernel::ffi:=
:c_int {
> +                    // SAFETY: This function is inaccessible to the outs=
ide due to the double
> +                    // module wrapping it. It is called exactly once by =
the C side via its
> +                    // unique name.
> +                    unsafe { __init() }
> +                }
> +
> +                #[cfg(MODULE)]
> +                #[doc(hidden)]
> +                #[used(compiler)]
> +                #[link_section =3D ".init.data"]
> +                static __UNIQUE_ID___addressable_init_module: unsafe ext=
ern "C" fn() -> i32 =3D
> +                    init_module;
> +
> +                #[cfg(MODULE)]
> +                #[doc(hidden)]
> +                #[no_mangle]
> +                #[link_section =3D ".exit.text"]
> +                pub extern "C" fn cleanup_module() {
> +                    // SAFETY:
> +                    // - This function is inaccessible to the outside du=
e to the double
> +                    //   module wrapping it. It is called exactly once b=
y the C side via its
> +                    //   unique name,
> +                    // - furthermore it is only called after `init_modul=
e` has returned `0`
> +                    //   (which delegates to `__init`).
> +                    unsafe { __exit() }
> +                }
> +
> +                #[cfg(MODULE)]
> +                #[doc(hidden)]
> +                #[used(compiler)]
> +                #[link_section =3D ".exit.data"]
> +                static __UNIQUE_ID___addressable_cleanup_module: extern =
"C" fn() =3D cleanup_module;
> +
> +                // Built-in modules are initialized through an initcall =
pointer
> +                // and the identifiers need to be unique.
> +                #[cfg(not(MODULE))]
> +                #[cfg(not(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS))]
> +                #[doc(hidden)]
> +                #[link_section =3D #initcall_section]
> +                #[used(compiler)]
> +                pub static #ident_initcall: extern "C" fn() ->
> +                    ::kernel::ffi::c_int =3D #ident_initcall;
> +
> +                #[cfg(not(MODULE))]
> +                #[cfg(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS)]
> +                ::core::arch::global_asm!(#global_asm);
> +
> +                #[cfg(not(MODULE))]
> +                #[doc(hidden)]
> +                #[no_mangle]
> +                pub extern "C" fn #ident_init() -> ::kernel::ffi::c_int =
{
> +                    // SAFETY: This function is inaccessible to the outs=
ide due to the double
> +                    // module wrapping it. It is called exactly once by =
the C side via its
> +                    // placement above in the initcall section.
> +                    unsafe { __init() }
> +                }
> +
> +                #[cfg(not(MODULE))]
> +                #[doc(hidden)]
> +                #[no_mangle]
> +                pub extern "C" fn #ident_exit() {
> +                    // SAFETY:
> +                    // - This function is inaccessible to the outside du=
e to the double
> +                    //   module wrapping it. It is called exactly once b=
y the C side via its
> +                    //   unique name,
> +                    // - furthermore it is only called after `#ident_ini=
t` has
> +                    //   returned `0` (which delegates to `__init`).
> +                    unsafe { __exit() }
> +                }
> +
> +                /// # Safety
> +                ///
> +                /// This function must only be called once.
> +                unsafe fn __init() -> ::kernel::ffi::c_int {
> +                    let initer =3D
> +                        <#type_ as ::kernel::InPlaceModule>::init(&super=
::super::THIS_MODULE);
> +                    // SAFETY: No data race, since `__MOD` can only be a=
ccessed by this module
> +                    // and there only `__init` and `__exit` access it. T=
hese functions are only
> +                    // called once and `__exit` cannot be called before =
or during `__init`.
> +                    match unsafe { initer.__pinned_init(__MOD.as_mut_ptr=
()) } {
> +                        Ok(m) =3D> 0,
> +                        Err(e) =3D> e.to_errno(),
> +                    }
> +                }
> +
> +                /// # Safety
> +                ///
> +                /// This function must
> +                /// - only be called once,
> +                /// - be called after `__init` has been called and retur=
ned `0`.
> +                unsafe fn __exit() {
> +                    // SAFETY: No data race, since `__MOD` can only be a=
ccessed by this module
> +                    // and there only `__init` and `__exit` access it. T=
hese functions are only
> +                    // called once and `__init` was already called.
> +                    unsafe {
> +                        // Invokes `drop()` on `__MOD`, which should be =
used for cleanup.
> +                        __MOD.assume_init_drop();
> +                    }
> +                }
> +
> +                #modinfo_ts
> +            }
> +        }
> +
> +        mod module_parameters {
> +            #params_ts
> +        }
> +    })
>  }
> --
> 2.51.2
>
>
