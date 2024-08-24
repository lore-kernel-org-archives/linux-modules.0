Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC7815DBB3
	for <linux-modules@vger.kernel.org>; Sat, 24 Aug 2024 11:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724498855; cv=none; b=rRLsMS8OnV5CpYxjOALwrZ9zyziBFvwywjFlksapYx90E69tmYBx/3S3Pr0jjv+sokMvSUdhnV7UqbXQmjCEnAbVZXbSWl+inxUJJRyFfzeNh7lIL9DmQXpk7ub2g2IWns+W4zV6+TZbCFB1SQX513Zqy5dxHW8SK8HLNdK34cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724498855; c=relaxed/simple;
	bh=9Ad/iUqHoKjyEXhQ6ZbmZQ88SbToS6uVHHQklnBdFgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BtG6By6uHhJUzA+0w2tip945n7MRlgqEcqOKvD/Ur7gAUnxBW+pfOxFC9dmB3sBAGXuhFtGL34lBzbesIcO7VGmt1P1V0UO6OZUy5K6xZLgnUsQ3ovZR3tlb7MqcL9P2fNqRljBru7ufOyptxPTwEruguFgdC8ctNayZ7di02yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=c6JYwKtu; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="c6JYwKtu"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6b2e6e7ad28so31075467b3.0
        for <linux-modules@vger.kernel.org>; Sat, 24 Aug 2024 04:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1724498850; x=1725103650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uf3Uqj2ntRhoNs77IBnzgmYlWIcskuvNHSmHXutGlHY=;
        b=c6JYwKtuYStFjxt8jUUCuxAklKQ2e58Br7anjyvZ9ny3rZPNv3Itb7TQ6fFUwVJ3NQ
         x8wde8pAPhZGuumhWkcFuaChRxMw940m6CCbxt5DuaqJF8q4wO+EBoMD3jJhej6mAbf/
         2mAJrzyxA/f0TEByejGUQtwitJKMmpCzDlEsED+R+QCpFmuyMlLiMFCpFznJtCQRzfGS
         Jn1FaQ04E760FZnoVTulIj5aAJ4gqE93g5ljYhKhw6Spikb69LZ/avFoa6F8UqcCCkBf
         ayu6gZ5kNz+QlyuBf0NY65qpLQ0NucEFnZ2S3AL/iH1+/4RYvfhLwwwlf5xC0H8Wj/84
         6OnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724498850; x=1725103650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uf3Uqj2ntRhoNs77IBnzgmYlWIcskuvNHSmHXutGlHY=;
        b=gKCKApoaaA/Wsc8hUga+ZHwWebcztfd7pJrjlkH4uOYibdTjwDVggxB2EGv1/JhZS4
         oW91H2F3yUfzPQGt7oKnz2/1etijnJlnNd8Tm8MQS4a7ITDttp//dBCwqsVMSuag8GXN
         tUDxzEDsv1IjJ8IC9mbZZ0S23dmMMFSoDG2+GSKOg/jOFN9BoN0/zoGlKg9LKqLJrlFl
         RzSQ0SK8WQdELA7M8l0JWTID/4a10VYYHE7AcAypEgwGtvAE2SsHaqMyYqT49tl6Eg8k
         L5AjjbH+tGuTMVG4nI4/+NzdUXG1SjfPr3cRjEJIFcJU41we4ZfHS5QvLrxCupIniQOF
         jGtg==
X-Forwarded-Encrypted: i=1; AJvYcCU43zuhgNsCQA+T8L71hCt9VmScXdyriCtZracwU2NMKUXWvCnXm79XQNKS6Iszor0f3J6fSwBCFx8hMPhp@vger.kernel.org
X-Gm-Message-State: AOJu0YwnSicp2YeXIYQPP2ex/ARlNJdQdxX+mlirnxkBWF4p2XCsoopJ
	DP2SmOiF6x9nuiRUeQmlNCJPw5dWFsa494bhAKt4gS+Js8H1/iYNo2JmpVBPi58mbWggC/RK0KQ
	AtxaFQzaudGTPTOz+Jg9vpazdahk4LcplRperbA==
X-Google-Smtp-Source: AGHT+IEAlZUcZ4ff9oMz0rwgCQ5DHbkIhhkXpPLZG5hznLK+6qud1slxJYtVy0L4xlTLSeo4lYia/UYqmpmL1QwrX9g=
X-Received: by 2002:a05:690c:89:b0:66b:c28b:f234 with SMTP id
 00721157ae682-6c6035ac54fmr44891797b3.21.1724498850225; Sat, 24 Aug 2024
 04:27:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819133345.3438739-1-nmi@metaspace.dk>
In-Reply-To: <20240819133345.3438739-1-nmi@metaspace.dk>
From: Trevor Gross <tmgross@umich.edu>
Date: Sat, 24 Aug 2024 06:27:19 -0500
Message-ID: <CALNs47sqt==o+hM5M1b0vTayKH177naybg_KurcirXszYAa22A@mail.gmail.com>
Subject: Re: [PATCH v2] rust: add `module_params` macro
To: Andreas Hindborg <nmi@metaspace.dk>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Adam Bratschi-Kaye <ark.email@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Daniel Gomez <da.gomez@samsung.com>, rust-for-linux@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 8:35=E2=80=AFAM Andreas Hindborg <nmi@metaspace.dk>=
 wrote:
>
> From: Andreas Hindborg <a.hindborg@samsung.com>
>
> This patch includes changes required for Rust kernel modules to utilize
> module parameters. This code implements read only support for integer
> types without `sysfs` support.

> diff --git a/rust/kernel/module_param.rs b/rust/kernel/module_param.rs
> new file mode 100644
> index 000000000000..9dfee0311d65
> --- /dev/null
> +++ b/rust/kernel/module_param.rs
> @@ -0,0 +1,339 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Types for module parameters.
> +//!
> +//! C header: [`include/linux/moduleparam.h`](../../../include/linux/mod=
uleparam.h)
> +
> +use crate::prelude::*;
> +
> +/// Types that can be used for module parameters.
> +///
> +/// Note that displaying the type in `sysfs` will fail if
> +/// [`core::str::from_utf8`] (as implemented through the [`core::fmt::Di=
splay`]
> +/// trait) writes more than [`PAGE_SIZE`] bytes (including an additional=
 null
> +/// terminator).

I'm a bit confused where `str::from_utf8` comes into play - maybe just:

    Note that displaying the type in `sysfs` will fail if the [`Display`]
    (core::fmt::Display) implementation would write more than
    [`PAGE_SIZE`] - 1 bytes.

> +/// [`PAGE_SIZE`]: `bindings::PAGE_SIZE`
> +pub trait ModuleParam: core::fmt::Display + core::marker::Sized {

I don't think `Sized` should need `core::marker`

> +    /// The `ModuleParam` will be used by the kernel module through this=
 type.
> +    ///
> +    /// This may differ from `Self` if, for example, `Self` needs to tra=
ck
> +    /// ownership without exposing it or allocate extra space for other =
possible
> +    /// parameter values. This is required to support string parameters =
in the
> +    /// future.
> +    type Value: ?Sized;

^ proof of the above :)

"This is required... in the future" could probably be moved to a
non-doc comment or just dropped.

> +/// Write a string representation of the current parameter value to `buf=
`.
> +///
> +/// # Safety
> +///
> +/// Must not be called.
> +///
> +/// # Note
> +///
> +/// This should not be called as we declare all parameters as read only.
> +#[allow(clippy::extra_unused_type_parameters)]
> +unsafe extern "C" fn get_param<T>(

I think this could make sense being a safe function. I get that
calling it would mean something is wrong - but that's a problem of
broken invariants elsewhere and not just calling this, no?

> +/// Trait for parsing integers.
> +///
> +/// Strings beginning with `0x`, `0o`, or `0b` are parsed as hex, octal,=
 or
> +/// binary respectively. Strings beginning with `0` otherwise are parsed=
 as
> +/// octal. Anything else is parsed as decimal. A leading `+` or `-` is a=
lso
> +/// permitted. Any string parsed by [`kstrtol()`] or [`kstrtoul()`] will=
 be
> +/// successfully parsed.
> +///
> +/// [`kstrtol()`]: https://www.kernel.org/doc/html/latest/core-api/kerne=
l-api.html#c.kstrtol
> +/// [`kstrtoul()`]: https://www.kernel.org/doc/html/latest/core-api/kern=
el-api.html#c.kstrtoul
> +trait ParseInt: Sized {

Since this is standalone functionality, it might be better moved to a
different module for reuse (and probably its own patch).

I'm not sure about the name either, would something like `FromKStr`
with a method `from_kstr` make more sense? Also because the current
trait will conflict if `core::str::FromStr` is also in scope.

The methods could use docs, and the trait could probably get a doctest
and/or some unit tests.

> +    fn from_str(src: &str) -> Result<Self> {
> +        match src.bytes().next() {
> +            None =3D> Err(EINVAL),
> +            Some(b'-') =3D> Self::from_str_unsigned(&src[1..])
> +                .map_err(|_| EINVAL)?
> +                .checked_neg()
> +                .ok_or(EINVAL),
> +            Some(b'+') =3D> Self::from_str_unsigned(&src[1..]).map_err(|=
_| EINVAL),
> +            Some(_) =3D> Self::from_str_unsigned(src).map_err(|_| EINVAL=
),
> +        }
> +    }

kstrtol returns -ERANGE on overflow, this might need to check the
`.kind()` of parse errors to match this

> +macro_rules! impl_parse_int {
> +    ($ty:ident) =3D> {

Nit: `$ty` could be a `:ty` here (makes no difference)

> +macro_rules! impl_module_param {

Nit: maybe `impl_int_module_param` since it doesn't handle other types

> +#[doc(hidden)]
> +#[macro_export]
> +/// Generate a static [`kernel_param_ops`](../../../include/linux/module=
param.h) struct.
> +///
> +/// # Examples
> +///
> +/// ```ignore
> +/// make_param_ops!(
> +///     /// Documentation for new param ops.
> +///     PARAM_OPS_MYTYPE, // Name for the static.
> +///     MyType // A type which implements [`ModuleParam`].
> +/// );
> +/// ```

Nit: move attributes to after the docs

> +macro_rules! make_param_ops {
> +    ($ops:ident, $ty:ty) =3D> {
> +        $crate::make_param_ops!(
> +            #[doc=3D""]
> +            $ops,
> +            $ty
> +        );
> +    };

I don't think you need this first pattern, since the meta in the below
pattern is optional. But...

> +    ($(#[$meta:meta])* $ops:ident, $ty:ty) =3D> {
> +        $(#[$meta])*

...you could probably just drop the `$meta` and remove docs from the
invocation by adding the following here

    /// Rust implementation of [`kernel_param_ops`]
    /// (../../../include/linux/moduleparam.h)
    #[doc(concat!("for [`", stringify!($ty), "`].))]

Since the docs are the same except the type

> +        ///
> +        /// Static [`kernel_param_ops`](../../../include/linux/modulepar=
am.h)
> +        /// struct generated by [`make_param_ops`].
> +        pub static $ops: $crate::bindings::kernel_param_ops =3D $crate::=
bindings::kernel_param_ops {
> +            flags: 0,
> +            set: Some(set_param::<$ty>),
> +            get: Some(get_param::<$ty>),
> +            free: Some(free::<$ty>),
> +        };

Could this be a const rather than a static?

> +impl_module_param!(i8);
> +impl_module_param!(u8);
> +impl_module_param!(i16);
> +impl_module_param!(u16);
> +impl_module_param!(i32);
> +impl_module_param!(u32);
> +impl_module_param!(i64);
> +impl_module_param!(u64);
> +impl_module_param!(isize);
> +impl_module_param!(usize);

Nit: these could probably go above `impl_module_param` to be next to
their macro definition.

> diff --git a/rust/macros/helpers.rs b/rust/macros/helpers.rs
> index 563dcd2b7ace..49388907370d 100644
> --- a/rust/macros/helpers.rs
> +++ b/rust/macros/helpers.rs
> @@ -107,6 +107,14 @@ pub(crate) struct Generics {
>      pub(crate) ty_generics: Vec<TokenTree>,
>  }
>
> +pub(crate) fn expect_string_field(it: &mut token_stream::IntoIter, expec=
ted_name: &str) -> String {

Just to make it obvious what it is looking for:

    /// Expect `expected_name: "value",`

> diff --git a/rust/macros/module.rs b/rust/macros/module.rs
> index 411dc103d82e..2fa9ed8e78ff 100644
> --- a/rust/macros/module.rs
> +++ b/rust/macros/module.rs

> +    fn emit_params(&mut self, info: &ModuleInfo) {
> +        if let Some(params) =3D &info.params {

Switching to

    let Some(params) =3D &info.params else {
        return;
    };

would save an indentation level

> +            for param in params {
> +                let ops =3D param_ops_path(&param.ptype);
> +
> +                self.emit_param("parmtype", &param.name, &param.ptype);
> +                self.emit_param("parm", &param.name, &param.description)=
;
> +

(Referring to below) could the template string body be indented
another level, so it doesn't hang left of the parent `write!` macro?

Also - maybe `let pfx =3D format!("__{name}_{param_name}") here then use
`{pfx}` in the template, since that sequence is repeated a lot.

> +                write!(
> +                    self.param_buffer,
> +                    "
> +                static mut __{name}_{param_name}_value: {param_type} =3D=
 {param_default};

Ah.. we need to migrate from `static mut` to `UnsafeCell` wrappers at
some point. Since `module!` already uses `static mut`, this may need
to happen separately - meaning I don't think we need to block on
making any change here.

This would mean adding an `UnsafeSyncCell` / `RacyCell` (just a
wrapper around `UnsafeCell` that always implements `Sync`), using
`UnsafeSyncCell<{param_type}>` as the type here, and changing from
`static mut` to just `static`.

(I can take a look at doing this change for existing `static mut` in
the near future).

> +                /// Newtype to make `bindings::kernel_param` `Sync`.
> +                #[repr(transparent)]
> +                struct __{name}_{param_name}_RacyKernelParam(::kernel::b=
indings::kernel_param);
> +
> +                // SAFETY: C kernel handles serializing access to this t=
ype. We
> +                // never access from Rust module.
> +                unsafe impl Sync for __{name}_{param_name}_RacyKernelPar=
am {{ }}

Could there just be a type for this in the kernel crate rather than
creating one as part of the macro?

> +                #[cfg(not(MODULE))]
> +                const __{name}_{param_name}_name: *const ::core::ffi::c_=
char =3D
> +                    b\"{name}.{param_name}\\0\" as *const _ as *const ::=
core::ffi::c_char;

This should work as `c\"{name}.{param_name}\".as_ptr()` now

> +
> +                #[cfg(MODULE)]
> +                const __{name}_{param_name}_name: *const ::core::ffi::c_=
char =3D
> +                    b\"{param_name}\\0\" as *const _ as *const ::core::f=
fi::c_char;

Same as above.

> +                #[link_section =3D \"__param\"]
> +                #[used]
> +                static __{name}_{param_name}_struct: __{name}_{param_nam=
e}_RacyKernelParam =3D
> +                    __{name}_{param_name}_RacyKernelParam(::kernel::bind=
ings::kernel_param {{
> +                        name: __{name}_{param_name}_name,

You could eliminate the above `__{name}_{param_name}_name` consts by using:

    name: if cfg!(MODULE) {
        c\"{param_name}\\"
    } else {
        c\"{name}.{param_name}\\"
    }.as_ptr(),

> +                        // SAFETY: `__this_module` is constructed by the=
 kernel at load time
> +                        // and will not be freed until the module is unl=
oaded.
> +                        #[cfg(MODULE)]
> +                        mod_: unsafe {{ &::kernel::bindings::__this_modu=
le as *const _ as *mut _ }},

Prefer `.cast::<T>().cast_mut()`

> +                        #[cfg(not(MODULE))]
> +                        mod_: ::core::ptr::null_mut(),
> +                        ops: &{ops} as *const ::kernel::bindings::kernel=
_param_ops,
> +                        perm: 0, // Will not appear in sysfs

For my knowledge, what would be needed to make sysfs work?

> +                        level: -1,
> +                        flags: 0,
> +                        __bindgen_anon_1:
> +                            ::kernel::bindings::kernel_param__bindgen_ty=
_1 {{
> +                                // SAFETY: As this is evaluated in const=
 context, it is
> +                                // safe to take a reference to a mut sta=
tic.
> +                                arg: unsafe {{
> +                                    ::core::ptr::addr_of_mut!(__{name}_{=
param_name}_value)
> +                                 }}.cast::<::core::ffi::c_void>(),

A note on this toward the end

> +                            }},
> +                    }});
> +                ",

> @@ -216,12 +387,14 @@ pub(crate) fn module(ts: TokenStream) -> TokenStrea=
m {

Is a lot of below just some rewrapping and leading `::`? It may be
good to split off tweaks to the existing code

>              // SAFETY: `__this_module` is constructed by the kernel at l=
oad time and will not be
>              // freed until the module is unloaded.
>              #[cfg(MODULE)]
> -            static THIS_MODULE: kernel::ThisModule =3D unsafe {{
> -                kernel::ThisModule::from_ptr(&kernel::bindings::__this_m=
odule as *const _ as *mut _)
> +            static THIS_MODULE: ::kernel::ThisModule =3D unsafe {{
> +                ::kernel::ThisModule::from_ptr(
> +                    &::kernel::bindings::__this_module as *const _ as *m=
ut _
> +                )
>              }};
>              #[cfg(not(MODULE))]
> -            static THIS_MODULE: kernel::ThisModule =3D unsafe {{
> -                kernel::ThisModule::from_ptr(core::ptr::null_mut())
> +            static THIS_MODULE: ::kernel::ThisModule =3D unsafe {{
> +                ::kernel::ThisModule::from_ptr(::core::ptr::null_mut())
>              }};
>
>              // Double nested modules, since then nobody can access the p=
ublic items inside.
> @@ -276,7 +449,8 @@ mod __module_init {{
>                      #[doc(hidden)]
>                      #[link_section =3D \"{initcall_section}\"]
>                      #[used]
> -                    pub static __{name}_initcall: extern \"C\" fn() -> c=
ore::ffi::c_int =3D __{name}_init;
> +                    pub static __{name}_initcall: extern \"C\" fn()
> +                        -> ::core::ffi::c_int =3D __{name}_init;
>
>                      #[cfg(not(MODULE))]
>                      #[cfg(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS)]
> @@ -291,7 +465,7 @@ mod __module_init {{
>                      #[cfg(not(MODULE))]
>                      #[doc(hidden)]
>                      #[no_mangle]
> -                    pub extern \"C\" fn __{name}_init() -> core::ffi::c_=
int {{
> +                    pub extern \"C\" fn __{name}_init() -> ::core::ffi::=
c_int {{
>                          // SAFETY: This function is inaccessible to the =
outside due to the double
>                          // module wrapping it. It is called exactly once=
 by the C side via its
>                          // placement above in the initcall section.
> @@ -314,8 +488,8 @@ mod __module_init {{
>                      /// # Safety
>                      ///
>                      /// This function must only be called once.
> -                    unsafe fn __init() -> core::ffi::c_int {{
> -                        match <{type_} as kernel::Module>::init(&super::=
super::THIS_MODULE) {{
> +                    unsafe fn __init() -> ::core::ffi::c_int {{
> +                        match <{type_} as ::kernel::Module>::init(&super=
::super::THIS_MODULE) {{
>                              Ok(m) =3D> {{
>                                  // SAFETY: No data race, since `__MOD` c=
an only be accessed by this
>                                  // module and there only `__init` and `_=
_exit` access it. These
> @@ -346,14 +520,17 @@ unsafe fn __exit() {{
>                              __MOD =3D None;
>                          }}
>                      }}
> -
>                      {modinfo}
>                  }}
>              }}
> +            mod module_parameters {{
> +                {params}
> +            }}
>          ",
>          type_ =3D info.type_,
>          name =3D info.name,
>          modinfo =3D modinfo.buffer,
> +        params =3D modinfo.param_buffer,
>          initcall_section =3D ".initcall6.init"
>      )
>      .parse()

> diff --git a/samples/rust/rust_minimal.rs b/samples/rust/rust_minimal.rs
> index 2a9eaab62d1c..d9bc2218d504 100644
> --- a/samples/rust/rust_minimal.rs
> +++ b/samples/rust/rust_minimal.rs
> @@ -10,6 +10,12 @@
>      author: "Rust for Linux Contributors",
>      description: "Rust minimal sample",
>      license: "GPL",
> +    params: {
> +        test_parameter: i64 {
> +            default: 1,
> +            description: "This parameter has a default of 1",
> +        },
> +    },
>  }

I was going to suggest updating the sample then saw you did that
already, thanks :)

> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index efacca63c897..a65bd0233843 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -263,7 +263,7 @@ $(obj)/%.lst: $(obj)/%.c FORCE
>  # Compile Rust sources (.rs)
>  # ----------------------------------------------------------------------=
-----
>
> -rust_allowed_features :=3D new_uninit
> +rust_allowed_features :=3D new_uninit,const_mut_refs

We shouldn't enable `const_mut_refs`. It is indeed close to
stabilization, but it is still kind of churny right now and we don't
want to enable the sharp edges everywhere.

If the change from `static mut` to `UnsafeCell` that I mentioned above
happens, `addr_of_mut!` turns into a `.get().cast::<...>()` takes the
place of `addr_of_mut!` and doesn't require this feature (and also
isn't unsafe).

If you prefer not to make that change, I think
`addr_of!(...).cast_mut()` might be the best solution.

---

Other thought: would a wrapper type make more sense here? Something like th=
is:

```
/* implementation */
struct ModParam<T>(UnsafeCell<T>);

// `Parameter` is the existing `ModParameter` (could be
// any name). It could be sealed.
impl<T: Parameter> ModParam<T> {
    #[doc(hidden)] // used in the macro
    fn new(value: T) -> Self { ... }

    fn get(&self) -> T::Value { ... }
    fn set(&self, v: T::Value) { ... }
}
```

With usage:

```
module! {
    // ...
    // instantiated as:
    // `static MY_PARAM: ModParam<i64> =3D ModParam::new(1);`
    MY_PARAM: i64 {
        default: 1,
        description: "foo",
    },
}

fn foo() {
    pr_info!("My param is {}", MY_PARAM.get());
}
```

Advantages I see:
- You bring your own name, rather than being scoped and needing to
remember the module name
- You can check `ModParam` in the docs to see the API, rather than
needing to refer to source for the exact signatures of `read` and
`write`
- The interface gets a bit more like a mutex or atomic

- Trevor
