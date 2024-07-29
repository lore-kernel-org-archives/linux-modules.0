Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB30C2F5A;
	Mon, 29 Jul 2024 17:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722273409; cv=none; b=SAiV3IeyTHXv8xQhaKPAqCMy+SemBlxNWA/ApvDazQCbVJcIB7Z5Z6Mad8tj0DnkDnW/uk7OyQ9T1eASBVDPEKA1w98Qf7DhNwawoXHM8kukGWpz487XejU/2bEkBA2jiTW0Wq7jqhupOgGhCprR40yLOfsIo6e+nV+Em0DKQDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722273409; c=relaxed/simple;
	bh=LIhUn+qjZldBRKvEfJ3yqkzB7XgsRDyCF2R7wADyO0s=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xva5szOmsxgnOO5bLvfJ2nkxsZgxQadWILlRdOneU2SGTdDBzp8NeM9O8QRHLtlYkU22WiXcWcrYvVHqsQKUumASGB420uzXEPUt8mmlk9Ojec9n71ogmbrN1LZJRRmpfxockst/nCa3XhH9Re9WXevac5RrMORKxHAQzN9icuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=HTCweDrM; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="HTCweDrM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722273402; x=1722532602;
	bh=NBvysXclgg1EeFsVDyern1mI0hAwq8Z2cj4b6YBXLE4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=HTCweDrM/Yjf3bUkZGX8wUeNEvjkEpog1QCLIwiYK+foemld3dBSx9TOjxBidLohx
	 l0U2rN8MipFdbWhVoVXPrqXooF1xFvgSxGIlrMgaW40fW943FoEQGorGw9clp4eynj
	 T8bgNKev8Ia3tjAMvdsoB/sVgOW7rbkhMEYObRcJamj5mcHWxG6UI5KGDwWUvScyU0
	 VrDvng57n7x+VrksG0tXpbPjM7mHs7g141VEjpFkfDjhLRDN34XpRaE1+EuZ5cAzAI
	 g2svkN4V1nR5V7iTnRziQ33DC4LySvqYbKPUqKyhuStl7f0GWBTU3hbTqndq4UzocW
	 KPhR/HCs5mv+w==
Date: Mon, 29 Jul 2024 17:16:37 +0000
To: Andreas Hindborg <nmi@metaspace.dk>, Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@samsung.com>, Adam Bratschi-Kaye <ark.email@gmail.com>
Subject: Re: [PATCH] rust: add `module_params` macro
Message-ID: <2838cf2e-936c-45de-bb19-af9da66fbe00@proton.me>
In-Reply-To: <20240705111455.142790-1-nmi@metaspace.dk>
References: <20240705111455.142790-1-nmi@metaspace.dk>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 1fb46c8957eaf3bf134fabf8cebb123bc283827f
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05.07.24 13:15, Andreas Hindborg wrote:
> From: Andreas Hindborg <a.hindborg@samsung.com>
>=20
> This patch includes changes required for Rust kernel modules to utilize
> module parameters. This code implements read only support for integer
> types without `sysfs` support.
>=20
> This code is a reduced and updated version of code by Adam available in t=
he
> original `rust` branch [1].
>=20
> [1] https://github.com/Rust-for-Linux/linux/tree/bc22545f38d74473cfef3e9f=
d65432733435b79f
>=20
> Cc: Adam Bratschi-Kaye <ark.email@gmail.com>
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
>=20
> ---
>=20
> I have patches queued up for `rnull` that depend on this patch.
> ---
>  rust/bindings/bindings_helper.h |   1 +
>  rust/kernel/lib.rs              |   2 +
>  rust/kernel/module_param.rs     | 339 ++++++++++++++++++++++++++++++++
>  rust/macros/helpers.rs          |   8 +
>  rust/macros/module.rs           | 230 ++++++++++++++++++++--
>  samples/rust/rust_minimal.rs    |  10 +
>  6 files changed, 571 insertions(+), 19 deletions(-)
>  create mode 100644 rust/kernel/module_param.rs
>=20
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_hel=
per.h
> index ddb5644d4fd9..767169f46f10 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -25,3 +25,4 @@ const gfp_t RUST_CONST_HELPER_GFP_KERNEL =3D GFP_KERNEL=
;
>  const gfp_t RUST_CONST_HELPER_GFP_KERNEL_ACCOUNT =3D GFP_KERNEL_ACCOUNT;
>  const gfp_t RUST_CONST_HELPER_GFP_NOWAIT =3D GFP_NOWAIT;
>  const gfp_t RUST_CONST_HELPER___GFP_ZERO =3D __GFP_ZERO;
> +const size_t RUST_CONST_HELPER_PAGE_SIZE =3D PAGE_SIZE;
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index fbd91a48ff8b..7cc2730e572f 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -33,6 +33,8 @@
>  pub mod ioctl;
>  #[cfg(CONFIG_KUNIT)]
>  pub mod kunit;
> +#[doc(hidden)]
> +pub mod module_param;
>  #[cfg(CONFIG_NET)]
>  pub mod net;
>  pub mod prelude;
> diff --git a/rust/kernel/module_param.rs b/rust/kernel/module_param.rs
> new file mode 100644
> index 000000000000..dc1108d20723
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
> +use crate::{error::code::*, str::CStr};
> +
> +/// Types that can be used for module parameters.
> +///
> +/// Note that displaying the type in `sysfs` will fail if
> +/// [`core::str::from_utf8`] (as implemented through the [`core::fmt::Di=
splay`]
> +/// trait) writes more than [`PAGE_SIZE`] bytes (including an additional=
 null
> +/// terminator).
> +///
> +/// [`PAGE_SIZE`]: `bindings::PAGE_SIZE`
> +pub trait ModuleParam: core::fmt::Display + core::marker::Sized {
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
> +
> +    /// Whether the parameter is allowed to be set without an argument.
> +    ///
> +    /// Setting this to `true` allows the parameter to be passed without=
 an
> +    /// argument (e.g. just `module.param` instead of `module.param=3Dfo=
o`).
> +    const NOARG_ALLOWED: bool;

I think, there is a better way of doing this. Instead of this bool, we
do the following:
1. have a `const DEFAULT: Option<Self>`
2. change the type of the argument of `try_from_param_arg` to
   `&'static [u8]`

That way we don't have the weird behavior of `try_from_param_arg` that
for params that don't have a default value.

> +
> +    /// Convert a parameter argument into the parameter value.
> +    ///
> +    /// `None` should be returned when parsing of the argument fails.
> +    /// `arg =3D=3D None` indicates that the parameter was passed withou=
t an
> +    /// argument. If `NOARG_ALLOWED` is set to `false` then `arg` is gua=
ranteed
> +    /// to always be `Some(_)`.
> +    ///
> +    /// Parameters passed at boot time will be set before [`kmalloc`] is
> +    /// available (even if the module is loaded at a later time). Howeve=
r, in
> +    /// this case, the argument buffer will be valid for the entire life=
time of
> +    /// the kernel. So implementations of this method which need to allo=
cate
> +    /// should first check that the allocator is available (with
> +    /// [`crate::bindings::slab_is_available`]) and when it is not avail=
able
> +    /// provide an alternative implementation which doesn't allocate. In=
 cases
> +    /// where the allocator is not available it is safe to save referenc=
es to
> +    /// `arg` in `Self`, but in other cases a copy should be made.
> +    ///
> +    /// [`kmalloc`]: ../../../include/linux/slab.h
> +    fn try_from_param_arg(arg: Option<&'static [u8]>) -> Option<Self>;

Do we want this to return `Result` instead?
Or rather, why is this returning `Option`?

> +
> +    /// Get the current value of the parameter for use in the kernel mod=
ule.
> +    ///
> +    /// This function should not be used directly. Instead use the wrapp=
er
> +    /// `read` which will be generated by [`macros::module`].
> +    fn value(&self) -> &Self::Value;
> +
> +    /// Set the module parameter from a string.
> +    ///
> +    /// Used to set the parameter value at kernel initialization, when l=
oading
> +    /// the module or when set through `sysfs`.
> +    ///
> +    /// `param.arg` is a pointer to `*mut Self` as set up by the [`modul=
e!`]
> +    /// macro.
> +    ///
> +    /// See `struct kernel_param_ops.set`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// If `val` is non-null then it must point to a valid null-terminat=
ed
> +    /// string. The `arg` field of `param` must be an instance of `Self`=
.
> +    ///
> +    /// # Invariants
> +    ///
> +    /// Currently, we only support read-only parameters that are not rea=
dable
> +    /// from `sysfs`. Thus, this function is only called at kernel
> +    /// initialization time, or at module load time, and we have exclusi=
ve
> +    /// access to the parameter for the duration of the function.
> +    ///
> +    /// [`module!`]: macros::module
> +    unsafe extern "C" fn set_param(
> +        val: *const core::ffi::c_char,
> +        param: *const crate::bindings::kernel_param,
> +    ) -> core::ffi::c_int {
> +        let arg =3D if val.is_null() {
> +            None
> +        } else {
> +            // SAFETY: By function safety requirement, val is non-null a=
nd
> +            // null-terminated. By C API contract, `val` is live and val=
id for
> +            // reads for the duration of this function.
> +            Some(unsafe { CStr::from_char_ptr(val).as_bytes() })
> +        };
> +        match Self::try_from_param_arg(arg) {
> +            Some(new_value) =3D> {
> +                // SAFETY: `param` is guaranteed to be valid by C API co=
ntract
> +                // and `arg` is guaranteed to point to an instance of `S=
elf`.
> +                let old_value =3D unsafe { (*param).__bindgen_anon_1.arg=
 as *mut Self };
> +                // SAFETY: `old_value` is valid for writes, as we have e=
xclusive
> +                // access. `old_value` is pointing to an initialized sta=
tic, an
> +                // so it is properly initialized.
> +                let _ =3D unsafe { core::ptr::replace(old_value, new_val=
ue) };
> +                0
> +            }
> +            None =3D> EINVAL.to_errno(),
> +        }
> +    }

Do implementers need to override this function? If not, then I would
move it out of the trait.

> +
> +    /// Write a string representation of the current parameter value to =
`buf`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Must not be called.
> +    ///
> +    /// # Note
> +    ///
> +    /// This should not be called as we declare all parameters as read o=
nly.
> +    unsafe extern "C" fn get_param(
> +        _buf: *mut core::ffi::c_char,
> +        _param: *const crate::bindings::kernel_param,
> +    ) -> core::ffi::c_int {
> +        0
> +    }

Ditto.

> +
> +    /// Drop the parameter.
> +    ///
> +    /// Called when unloading a module.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The `arg` field of `param` must be an initialized instance of `S=
elf`.
> +    unsafe extern "C" fn free(arg: *mut core::ffi::c_void) {
> +        // SAFETY: By function safety requirement, `arg` is an initializ=
ed
> +        // instance of `Self`. By C API contract, `arg` will not be used=
 after
> +        // this function returns.
> +        unsafe { core::ptr::drop_in_place(arg as *mut Self) };
> +    }

Ditto.

> +}

[...]

> diff --git a/rust/macros/helpers.rs b/rust/macros/helpers.rs
> index 563dcd2b7ace..dc0b47879a8c 100644
> --- a/rust/macros/helpers.rs
> +++ b/rust/macros/helpers.rs
> @@ -107,6 +107,14 @@ pub(crate) struct Generics {
>      pub(crate) ty_generics: Vec<TokenTree>,
>  }
>=20
> +pub(crate) fn get_string(it: &mut token_stream::IntoIter, expected_name:=
 &str) -> String {

This name is rather weird, `get_field` makes more sense IMO.

> +    assert_eq!(expect_ident(it), expected_name);
> +    assert_eq!(expect_punct(it), ':');
> +    let string =3D expect_string(it);
> +    assert_eq!(expect_punct(it), ',');

Why do we require a trailing comma?

> +    string
> +}
> +
>  /// Parses the given `TokenStream` into `Generics` and the rest.
>  ///
>  /// The generics are not present in the rest, but a where clause might r=
emain.
> diff --git a/rust/macros/module.rs b/rust/macros/module.rs
> index acd0393b5095..fc794855b99e 100644
> --- a/rust/macros/module.rs
> +++ b/rust/macros/module.rs
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>=20
>  use crate::helpers::*;
> -use proc_macro::{token_stream, Delimiter, Literal, TokenStream, TokenTre=
e};
> +use proc_macro::{token_stream, Delimiter, Group, Literal, TokenStream, T=
okenTree};
>  use std::fmt::Write;
>=20
>  fn expect_string_array(it: &mut token_stream::IntoIter) -> Vec<String> {
> @@ -26,6 +26,7 @@ struct ModInfoBuilder<'a> {
>      module: &'a str,
>      counter: usize,
>      buffer: String,
> +    param_buffer: String,
>  }
>=20
>  impl<'a> ModInfoBuilder<'a> {
> @@ -34,10 +35,11 @@ fn new(module: &'a str) -> Self {
>              module,
>              counter: 0,
>              buffer: String::new(),
> +            param_buffer: String::new(),
>          }
>      }
>=20
> -    fn emit_base(&mut self, field: &str, content: &str, builtin: bool) {
> +    fn emit_base(&mut self, field: &str, content: &str, builtin: bool, p=
aram: bool) {
>          let string =3D if builtin {
>              // Built-in modules prefix their modinfo strings by `module.=
`.
>              format!(
> @@ -51,8 +53,14 @@ fn emit_base(&mut self, field: &str, content: &str, bu=
iltin: bool) {
>              format!("{field}=3D{content}\0", field =3D field, content =
=3D content)
>          };
>=20
> +        let buffer =3D if param {
> +            &mut self.param_buffer
> +        } else {
> +            &mut self.buffer
> +        };
> +
>          write!(
> -            &mut self.buffer,
> +            buffer,
>              "
>                  {cfg}
>                  #[doc(hidden)]
> @@ -75,20 +83,190 @@ fn emit_base(&mut self, field: &str, content: &str, =
builtin: bool) {
>          self.counter +=3D 1;
>      }
>=20
> -    fn emit_only_builtin(&mut self, field: &str, content: &str) {
> -        self.emit_base(field, content, true)
> +    fn emit_only_builtin(&mut self, field: &str, content: &str, param: b=
ool) {
> +        self.emit_base(field, content, true, param)
>      }
>=20
> -    fn emit_only_loadable(&mut self, field: &str, content: &str) {
> -        self.emit_base(field, content, false)
> +    fn emit_only_loadable(&mut self, field: &str, content: &str, param: =
bool) {
> +        self.emit_base(field, content, false, param)
>      }
>=20
>      fn emit(&mut self, field: &str, content: &str) {
> -        self.emit_only_builtin(field, content);
> -        self.emit_only_loadable(field, content);
> +        self.emit_internal(field, content, false);
> +    }
> +
> +    fn emit_internal(&mut self, field: &str, content: &str, param: bool)=
 {
> +        self.emit_only_builtin(field, content, param);
> +        self.emit_only_loadable(field, content, param);
> +    }
> +
> +    fn emit_param(&mut self, field: &str, param: &str, content: &str) {
> +        let content =3D format!("{param}:{content}", param =3D param, co=
ntent =3D content);
> +        self.emit_internal(field, &content, true);
> +    }
> +
> +    fn emit_params(&mut self, info: &ModuleInfo) {

This parses the parameters, but shouldn't that happen in
`ModuleInfo::parse`? I agree that it should be a different function, but
I don't think that we should store the params as a `Group` and fail when
we emit the params.

> +        if let Some(params) =3D &info.params {
> +            assert_eq!(params.delimiter(), Delimiter::Brace);
> +
> +            let mut it =3D params.stream().into_iter();
> +
> +            loop {
> +                let param_name =3D match it.next() {
> +                    Some(TokenTree::Ident(ident)) =3D> ident.to_string()=
,
> +                    Some(_) =3D> panic!("Expected Ident or end"),
> +                    None =3D> break,
> +                };
> +
> +                assert_eq!(expect_punct(&mut it), ':');
> +                let param_type =3D expect_ident(&mut it);
> +                let group =3D expect_group(&mut it);
> +                assert_eq!(expect_punct(&mut it), ',');

Why do we require a trailing comma?

> +
> +                assert_eq!(group.delimiter(), Delimiter::Brace);

This check will should be immediately after expecting the group.=20

> +
> +                let mut param_it =3D group.stream().into_iter();
> +                let param_default =3D get_param_default(&mut param_it);

I don't understand why this is put into its own (5 LOC) function and
other parts of this function are not. If you can separate parsing from
emitting better, this will probably improve.

> +                let param_description =3D get_string(&mut param_it, "des=
cription");
> +                expect_end(&mut param_it);
> +
> +                let (param_kernel_type, ops): (String, _) =3D (

Why do you need to specify the type like this?

> +                    param_type.to_string(),
> +                    param_ops_path(&param_type).to_string(),
> +                );
> +
> +                self.emit_param("parmtype", &param_name, &param_kernel_t=
ype);

Is the spelling intentional? "parmtype"?

> +                self.emit_param("parm", &param_name, &param_description)=
;
> +                let param_type_internal =3D param_type.clone();
> +
> +                let read_func =3D format!(
> +                    "
> +                        pub(crate) fn read(&self)
> +                            -> &<{param_type_internal}
> +                               as kernel::module_param::ModuleParam>::Va=
lue {{

Please add a `::` in front of `kernel::module_param::ModuleParam`. There
are more instances below.

> +                            // Note: when we enable r/w parameters, we n=
eed to lock here.
> +
> +                            // SAFETY: Parameters do not need to be lock=
ed because they are
> +                            // read only or sysfs is not enabled.
> +                            unsafe {{
> +                                <{param_type_internal} as kernel::module=
_param::ModuleParam>::value(
> +                                    &__{name}_{param_name}_value
> +                                )
> +                            }}
> +                        }}
> +                    ",
> +                    name =3D info.name,
> +                    param_name =3D param_name,
> +                    param_type_internal =3D param_type_internal,
> +                );
> +
> +                let kparam =3D format!(
> +                    "
> +                    kernel::bindings::kernel_param__bindgen_ty_1 {{
> +                        // SAFETY: Access through the resulting pointer =
is
> +                        // serialized by C side and only happens before =
module
> +                        // `init` or after module `drop` is called.
> +                        arg: unsafe {{ &__{name}_{param_name}_value }}
> +                            as *const _ as *mut core::ffi::c_void,

Here you should use `addr_of[_mut]!` instead of taking a reference. Also
will this pointer be used to write to the static, in that case you need
`_mut!`.

> +                    }},
> +                ",
> +                    name =3D info.name,
> +                    param_name =3D param_name,
> +                );

What is the reason for putting `kparam` and `read_func` outside of the
`write!` below? I think it would be easier to read if they are inlined.

> +                write!(
> +                    self.param_buffer,
> +                    "
> +                static mut __{name}_{param_name}_value: {param_type_inte=
rnal} =3D {param_default};
> +
> +                pub(crate) struct __{name}_{param_name};
> +
> +                impl __{name}_{param_name} {{ {read_func} }}
> +
> +                pub(crate) const {param_name}: __{name}_{param_name} =3D=
 __{name}_{param_name};

Why do we need a unit struct as a constant? I think it would make more
sense to have a unit struct/empty enum as the type and the `read`
function be without a receiver.

> +
> +                // Note: the C macro that generates the static structs f=
or the `__param` section
> +                // asks for them to be `aligned(sizeof(void *))`. Howeve=
r, that was put in place
> +                // in 2003 in commit 38d5b085d2a0 (\"[PATCH] Fix over-al=
ignment problem on x86-64\")
> +                // to undo GCC over-alignment of static structs of >32 b=
ytes. It seems that is
> +                // not the case anymore, so we simplify to a transparent=
 representation here
> +                // in the expectation that it is not needed anymore.
> +                // TODO: Revisit this to confirm the above comment and r=
emove it if it happened.

Should this TODO be fixed before this is merged? Or do you intend for it
to stay?
If this is indeed correct, should this also be changed in the C side (of
course a different patch)?

> +                /// Newtype to make `bindings::kernel_param` `Sync`.
> +                #[repr(transparent)]
> +                struct __{name}_{param_name}_RacyKernelParam(kernel::bin=
dings::kernel_param);
> +
> +                // SAFETY: C kernel handles serializing access to this t=
ype. We
> +                // never access from Rust module.
> +                unsafe impl Sync for __{name}_{param_name}_RacyKernelPar=
am {{
> +                }}

Any reason to put the `}` on the next line?

> +
> +                #[cfg(not(MODULE))]
> +                const __{name}_{param_name}_name: *const core::ffi::c_ch=
ar =3D
> +                    b\"{name}.{param_name}\\0\" as *const _ as *const co=
re::ffi::c_char;
> +
> +                #[cfg(MODULE)]
> +                const __{name}_{param_name}_name: *const core::ffi::c_ch=
ar =3D
> +                    b\"{param_name}\\0\" as *const _ as *const core::ffi=
::c_char;
> +
> +                #[link_section =3D \"__param\"]
> +                #[used]
> +                static __{name}_{param_name}_struct: __{name}_{param_nam=
e}_RacyKernelParam =3D
> +                    __{name}_{param_name}_RacyKernelParam(kernel::bindin=
gs::kernel_param {{
> +                        name: __{name}_{param_name}_name,
> +                        // SAFETY: `__this_module` is constructed by the=
 kernel at load time
> +                        // and will not be freed until the module is unl=
oaded.
> +                        #[cfg(MODULE)]
> +                        mod_: unsafe {{ &kernel::bindings::__this_module=
 as *const _ as *mut _ }},
> +                        #[cfg(not(MODULE))]
> +                        mod_: core::ptr::null_mut(),
> +                        // SAFETY: This static is actually constant as s=
een by
> +                        // module code. But we need a unique address for=
 it, so it
> +                        // must be static.

This safety comment makes no sense, should it be a normal comment?

> +                        ops: unsafe {{ &{ops} }} as *const kernel::bindi=
ngs::kernel_param_ops,

Why is this `unsafe` block needed, the `make_param_ops` macro declares a
non-mut static.

> +                        perm: 0, // Will not appear in sysfs
> +                        level: -1,

Why this value?

> +                        flags: 0,
> +                        __bindgen_anon_1: {kparam}
> +                    }});
> +                ",
> +                    name =3D info.name,
> +                    param_type_internal =3D param_type_internal,
> +                    read_func =3D read_func,
> +                    param_default =3D param_default,
> +                    param_name =3D param_name,
> +                    ops =3D ops,
> +                    kparam =3D kparam,
> +                )
> +                .unwrap();
> +            }
> +        }
>      }
>  }
>=20
> +fn param_ops_path(param_type: &str) -> &'static str {
> +    match param_type {
> +        "i8" =3D> "::kernel::module_param::PARAM_OPS_I8",
> +        "u8" =3D> "::kernel::module_param::PARAM_OPS_U8",
> +        "i16" =3D> "::kernel::module_param::PARAM_OPS_I16",
> +        "u16" =3D> "::kernel::module_param::PARAM_OPS_U16",
> +        "i32" =3D> "::kernel::module_param::PARAM_OPS_I32",
> +        "u32" =3D> "::kernel::module_param::PARAM_OPS_U32",
> +        "i64" =3D> "::kernel::module_param::PARAM_OPS_I64",
> +        "u64" =3D> "::kernel::module_param::PARAM_OPS_U64",
> +        "isize" =3D> "::kernel::module_param::PARAM_OPS_ISIZE",
> +        "usize" =3D> "::kernel::module_param::PARAM_OPS_USIZE",
> +        t =3D> panic!("Unrecognized type {}", t),

I would write "Unsupported parameter type `{}`!".

> +    }
> +}
> +
> +fn get_param_default(param_it: &mut token_stream::IntoIter) -> String {
> +    assert_eq!(expect_ident(param_it), "default");
> +    assert_eq!(expect_punct(param_it), ':');
> +    let default =3D try_literal(param_it).expect("Expected default param=
 value");
> +    assert_eq!(expect_punct(param_it), ',');
> +    default
> +}
> +

Could you also add documentation in rust/macros/lib.rs on the `module!`
macro how parameters can be declared/used? I took a look and it seems
that there is out-of-date docs there also.

---
Cheers,
Benno

