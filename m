Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AD117BEA2;
	Wed, 28 Aug 2024 12:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724849569; cv=none; b=p+9wRg48hfm3SmzXkIwCvY1/A/eUGf+pBx6I9zqtI2wxExiAXj1za8sEdc/st1JiJrxsBVeF52T6BwaSjTSRXKGCpywtHjIXfW7fhbHERZpZHt+3w42LmFLSR3BPr3SLURWzxFOyWX6mXNzfV3gt0B0DvtzEqXSL2M/vst8TO7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724849569; c=relaxed/simple;
	bh=9dgFCgHz3Mpl5OlJklA6+n4HX4HbbJhDnTAyphtzJNs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BS+V1yQOZyw343Y74I1xC4EAfWsy2LpH9dxCOvqP/v8+fB90a4qopNnUQAx8SNKWF43v3cQi2D1/U3ZW8Blly9pad3a4p7vNcdgRM+6h8JhtkhFp4qByArICyDX4O/R+9RBFvwo7erPUWqouqiAG4N3DhLZw7XZH/tmquzNG13A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=metaspace.dk; spf=pass smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace.dk header.i=@metaspace.dk header.b=cq2eZGha; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace.dk header.i=@metaspace.dk header.b="cq2eZGha"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=metaspace.dk;
	s=protonmail; t=1724849561; x=1725108761;
	bh=FjpQwaU6IotTsXEinzkn7hfJUH+1jVD+9K1+WeK+7Go=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=cq2eZGha7rxXj4cTJOzz8UNXGyoccBQEABwyzzqeto6mmDieJ/PQgvaMt8to2mUyr
	 CljDZjHfLaCFhXGswP6RFJqFx6Mn863iiE+j0Qi9Wyg9SOVjQCma98M7wB0InUadPp
	 Wnh41+Nu64tzPUl0UUR2PuOGsAVqZ5OXyOUok1bTcXkHXhkk/McF9T+2x2v6QJCPsq
	 xQ00kQVm2QVVzUYNCNwxfU9rWs9c3GrXJJHJkFGN/QCVSnwEW00IlyjdlGl5aYXM5G
	 WPud5PE8PKBixuqk1xvQgMNy43yVxs3ReSOESAyk5+iOy9PjW5BmIUteiY27wfyyJL
	 e0UkkJ0BjTqpQ==
Date: Wed, 28 Aug 2024 12:52:36 +0000
To: Trevor Gross <tmgross@umich.edu>
From: Andreas Hindborg <nmi@metaspace.dk>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Adam Bratschi-Kaye <ark.email@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, Daniel Gomez <da.gomez@samsung.com>, rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rust: add `module_params` macro
Message-ID: <874j74x111.fsf@metaspace.dk>
In-Reply-To: <CALNs47sqt==o+hM5M1b0vTayKH177naybg_KurcirXszYAa22A@mail.gmail.com>
References: <20240819133345.3438739-1-nmi@metaspace.dk> <CALNs47sqt==o+hM5M1b0vTayKH177naybg_KurcirXszYAa22A@mail.gmail.com>
Feedback-ID: 113830118:user:proton
X-Pm-Message-ID: 8a39379655860f58945f7a235257145fe297bf21
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hi Trevor,

Thanks a lot for the thorough review!

"Trevor Gross" <tmgross@umich.edu> writes:

> On Mon, Aug 19, 2024 at 8:35=E2=80=AFAM Andreas Hindborg <nmi@metaspace.d=
k> wrote:
>>
>> From: Andreas Hindborg <a.hindborg@samsung.com>
>>
>> This patch includes changes required for Rust kernel modules to utilize
>> module parameters. This code implements read only support for integer
>> types without `sysfs` support.
>
>> diff --git a/rust/kernel/module_param.rs b/rust/kernel/module_param.rs
>> new file mode 100644
>> index 000000000000..9dfee0311d65
>> --- /dev/null
>> +++ b/rust/kernel/module_param.rs
>> @@ -0,0 +1,339 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +//! Types for module parameters.
>> +//!
>> +//! C header: [`include/linux/moduleparam.h`](../../../include/linux/mo=
duleparam.h)
>> +
>> +use crate::prelude::*;
>> +
>> +/// Types that can be used for module parameters.
>> +///
>> +/// Note that displaying the type in `sysfs` will fail if
>> +/// [`core::str::from_utf8`] (as implemented through the [`core::fmt::D=
isplay`]
>> +/// trait) writes more than [`PAGE_SIZE`] bytes (including an additiona=
l null
>> +/// terminator).
>
> I'm a bit confused where `str::from_utf8` comes into play - maybe just:
>
>     Note that displaying the type in `sysfs` will fail if the [`Display`]
>     (core::fmt::Display) implementation would write more than
>     [`PAGE_SIZE`] - 1 bytes.

I think it is a hint for where to look if things go wrong for `core`
types. But it makes sense to cut it to cut `Display`.

>> +/// [`PAGE_SIZE`]: `bindings::PAGE_SIZE`
>> +pub trait ModuleParam: core::fmt::Display + core::marker::Sized {
>
> I don't think `Sized` should need `core::marker`

Thanks.

>
>> +    /// The `ModuleParam` will be used by the kernel module through thi=
s type.
>> +    ///
>> +    /// This may differ from `Self` if, for example, `Self` needs to tr=
ack
>> +    /// ownership without exposing it or allocate extra space for other=
 possible
>> +    /// parameter values. This is required to support string parameters=
 in the
>> +    /// future.
>> +    type Value: ?Sized;
>
> ^ proof of the above :)
>
> "This is required... in the future" could probably be moved to a
> non-doc comment or just dropped.

OK.

>
>> +/// Write a string representation of the current parameter value to `bu=
f`.
>> +///
>> +/// # Safety
>> +///
>> +/// Must not be called.
>> +///
>> +/// # Note
>> +///
>> +/// This should not be called as we declare all parameters as read only=
.
>> +#[allow(clippy::extra_unused_type_parameters)]
>> +unsafe extern "C" fn get_param<T>(
>
> I think this could make sense being a safe function. I get that
> calling it would mean something is wrong - but that's a problem of
> broken invariants elsewhere and not just calling this, no?

The "must not be called" requirement will be dropped when we support
parameters writable through sysfs. Once we allow it to be called, it is
going to have safety requirements and it will have to be unsafe. So I
see no point it not making it unsafe now.

>
>> +/// Trait for parsing integers.
>> +///
>> +/// Strings beginning with `0x`, `0o`, or `0b` are parsed as hex, octal=
, or
>> +/// binary respectively. Strings beginning with `0` otherwise are parse=
d as
>> +/// octal. Anything else is parsed as decimal. A leading `+` or `-` is =
also
>> +/// permitted. Any string parsed by [`kstrtol()`] or [`kstrtoul()`] wil=
l be
>> +/// successfully parsed.
>> +///
>> +/// [`kstrtol()`]: https://www.kernel.org/doc/html/latest/core-api/kern=
el-api.html#c.kstrtol
>> +/// [`kstrtoul()`]: https://www.kernel.org/doc/html/latest/core-api/ker=
nel-api.html#c.kstrtoul
>> +trait ParseInt: Sized {
>
> Since this is standalone functionality, it might be better moved to a
> different module for reuse (and probably its own patch).
>
> I'm not sure about the name either, would something like `FromKStr`
> with a method `from_kstr` make more sense? Also because the current
> trait will conflict if `core::str::FromStr` is also in scope.

I see, that makes sense. I can rename it and move it to a separate patch
and module.

>
> The methods could use docs, and the trait could probably get a doctest
> and/or some unit tests.

I will add that.

>
>> +    fn from_str(src: &str) -> Result<Self> {
>> +        match src.bytes().next() {
>> +            None =3D> Err(EINVAL),
>> +            Some(b'-') =3D> Self::from_str_unsigned(&src[1..])
>> +                .map_err(|_| EINVAL)?
>> +                .checked_neg()
>> +                .ok_or(EINVAL),
>> +            Some(b'+') =3D> Self::from_str_unsigned(&src[1..]).map_err(=
|_| EINVAL),
>> +            Some(_) =3D> Self::from_str_unsigned(src).map_err(|_| EINVA=
L),
>> +        }
>> +    }
>
> kstrtol returns -ERANGE on overflow, this might need to check the
> `.kind()` of parse errors to match this

Good idea.

>
>> +macro_rules! impl_parse_int {
>> +    ($ty:ident) =3D> {
>
> Nit: `$ty` could be a `:ty` here (makes no difference)

=F0=9F=91=8D

>
>> +macro_rules! impl_module_param {
>
> Nit: maybe `impl_int_module_param` since it doesn't handle other types

Yes.

>
>> +#[doc(hidden)]
>> +#[macro_export]
>> +/// Generate a static [`kernel_param_ops`](../../../include/linux/modul=
eparam.h) struct.
>> +///
>> +/// # Examples
>> +///
>> +/// ```ignore
>> +/// make_param_ops!(
>> +///     /// Documentation for new param ops.
>> +///     PARAM_OPS_MYTYPE, // Name for the static.
>> +///     MyType // A type which implements [`ModuleParam`].
>> +/// );
>> +/// ```
>
> Nit: move attributes to after the docs

Will do. Is that a style thing we documented somewhere? Could we have
`clippy` warn about this?

>
>> +macro_rules! make_param_ops {
>> +    ($ops:ident, $ty:ty) =3D> {
>> +        $crate::make_param_ops!(
>> +            #[doc=3D""]
>> +            $ops,
>> +            $ty
>> +        );
>> +    };
>
> I don't think you need this first pattern, since the meta in the below
> pattern is optional. But...
>
>> +    ($(#[$meta:meta])* $ops:ident, $ty:ty) =3D> {
>> +        $(#[$meta])*
>
> ...you could probably just drop the `$meta` and remove docs from the
> invocation by adding the following here
>
>     /// Rust implementation of [`kernel_param_ops`]
>     /// (../../../include/linux/moduleparam.h)
>     #[doc(concat!("for [`", stringify!($ty), "`].))]
>
> Since the docs are the same except the type

I am not sure I think that is more simple. But either way is fine by me.

>
>> +        ///
>> +        /// Static [`kernel_param_ops`](../../../include/linux/modulepa=
ram.h)
>> +        /// struct generated by [`make_param_ops`].
>> +        pub static $ops: $crate::bindings::kernel_param_ops =3D $crate:=
:bindings::kernel_param_ops {
>> +            flags: 0,
>> +            set: Some(set_param::<$ty>),
>> +            get: Some(get_param::<$ty>),
>> +            free: Some(free::<$ty>),
>> +        };
>
> Could this be a const rather than a static?

It cannot, because we need an address for it. As far as I understand
`const` items are not guaranteed to have an address.

>
>> +impl_module_param!(i8);
>> +impl_module_param!(u8);
>> +impl_module_param!(i16);
>> +impl_module_param!(u16);
>> +impl_module_param!(i32);
>> +impl_module_param!(u32);
>> +impl_module_param!(i64);
>> +impl_module_param!(u64);
>> +impl_module_param!(isize);
>> +impl_module_param!(usize);
>
> Nit: these could probably go above `impl_module_param` to be next to
> their macro definition.

Either that, or we move each of the three macro instances for each type tog=
ether.

>
>> diff --git a/rust/macros/helpers.rs b/rust/macros/helpers.rs
>> index 563dcd2b7ace..49388907370d 100644
>> --- a/rust/macros/helpers.rs
>> +++ b/rust/macros/helpers.rs
>> @@ -107,6 +107,14 @@ pub(crate) struct Generics {
>>      pub(crate) ty_generics: Vec<TokenTree>,
>>  }
>>
>> +pub(crate) fn expect_string_field(it: &mut token_stream::IntoIter, expe=
cted_name: &str) -> String {
>
> Just to make it obvious what it is looking for:
>
>     /// Expect `expected_name: "value",`

Right.

>> diff --git a/rust/macros/module.rs b/rust/macros/module.rs
>> index 411dc103d82e..2fa9ed8e78ff 100644
>> --- a/rust/macros/module.rs
>> +++ b/rust/macros/module.rs
>
>> +    fn emit_params(&mut self, info: &ModuleInfo) {
>> +        if let Some(params) =3D &info.params {
>
> Switching to
>
>     let Some(params) =3D &info.params else {
>         return;
>     };
>
> would save an indentation level

I don't mind the indentation level, but I think what you propose with
early abort is easier to read. I was actually not aware of this syntax.


>> +            for param in params {
>> +                let ops =3D param_ops_path(&param.ptype);
>> +
>> +                self.emit_param("parmtype", &param.name, &param.ptype);
>> +                self.emit_param("parm", &param.name, &param.description=
);
>> +
>
> (Referring to below) could the template string body be indented
> another level, so it doesn't hang left of the parent `write!` macro?

Sure.

>
> Also - maybe `let pfx =3D format!("__{name}_{param_name}") here then use
> `{pfx}` in the template, since that sequence is repeated a lot.

Ok.

>
>> +                write!(
>> +                    self.param_buffer,
>> +                    "
>> +                static mut __{name}_{param_name}_value: {param_type} =
=3D {param_default};
>
> Ah.. we need to migrate from `static mut` to `UnsafeCell` wrappers at
> some point. Since `module!` already uses `static mut`, this may need
> to happen separately - meaning I don't think we need to block on
> making any change here.
>
> This would mean adding an `UnsafeSyncCell` / `RacyCell` (just a
> wrapper around `UnsafeCell` that always implements `Sync`), using
> `UnsafeSyncCell<{param_type}>` as the type here, and changing from
> `static mut` to just `static`.
>
> (I can take a look at doing this change for existing `static mut` in
> the near future).

It seems this discussion is happening on Zulip. Dropping a link to
discussion there for people not aware [1].

>
>> +                /// Newtype to make `bindings::kernel_param` `Sync`.
>> +                #[repr(transparent)]
>> +                struct __{name}_{param_name}_RacyKernelParam(::kernel::=
bindings::kernel_param);
>> +
>> +                // SAFETY: C kernel handles serializing access to this =
type. We
>> +                // never access from Rust module.
>> +                unsafe impl Sync for __{name}_{param_name}_RacyKernelPa=
ram {{ }}
>
> Could there just be a type for this in the kernel crate rather than
> creating one as part of the macro?

We can, but I do not think we gain anything? If we move it to the kernel
crate, we will have to mark it as `pub` and it will just clutter the
name space.

>
>> +                #[cfg(not(MODULE))]
>> +                const __{name}_{param_name}_name: *const ::core::ffi::c=
_char =3D
>> +                    b\"{name}.{param_name}\\0\" as *const _ as *const :=
:core::ffi::c_char;
>
> This should work as `c\"{name}.{param_name}\".as_ptr()` now

Cool.

>
>> +
>> +                #[cfg(MODULE)]
>> +                const __{name}_{param_name}_name: *const ::core::ffi::c=
_char =3D
>> +                    b\"{param_name}\\0\" as *const _ as *const ::core::=
ffi::c_char;
>
> Same as above.
>
>> +                #[link_section =3D \"__param\"]
>> +                #[used]
>> +                static __{name}_{param_name}_struct: __{name}_{param_na=
me}_RacyKernelParam =3D
>> +                    __{name}_{param_name}_RacyKernelParam(::kernel::bin=
dings::kernel_param {{
>> +                        name: __{name}_{param_name}_name,
>
> You could eliminate the above `__{name}_{param_name}_name` consts by usin=
g:
>
>     name: if cfg!(MODULE) {
>         c\"{param_name}\\"
>     } else {
>         c\"{name}.{param_name}\\"
>     }.as_ptr(),

Either way is fine for me.

>
>> +                        // SAFETY: `__this_module` is constructed by th=
e kernel at load time
>> +                        // and will not be freed until the module is un=
loaded.
>> +                        #[cfg(MODULE)]
>> +                        mod_: unsafe {{ &::kernel::bindings::__this_mod=
ule as *const _ as *mut _ }},
>
> Prefer `.cast::<T>().cast_mut()`


Changed to `addr_of_mut!`, but this is also subject to the discussion in
[1], `const_mut_refs` being flaky, right?

>
>> +                        #[cfg(not(MODULE))]
>> +                        mod_: ::core::ptr::null_mut(),
>> +                        ops: &{ops} as *const ::kernel::bindings::kerne=
l_param_ops,
>> +                        perm: 0, // Will not appear in sysfs
>
> For my knowledge, what would be needed to make sysfs work?

We would set the flags field to allow read and/or write, and we would
need to apply proper locking around the parameter storage.

>
>> +                        level: -1,
>> +                        flags: 0,
>> +                        __bindgen_anon_1:
>> +                            ::kernel::bindings::kernel_param__bindgen_t=
y_1 {{
>> +                                // SAFETY: As this is evaluated in cons=
t context, it is
>> +                                // safe to take a reference to a mut st=
atic.
>> +                                arg: unsafe {{
>> +                                    ::core::ptr::addr_of_mut!(__{name}_=
{param_name}_value)
>> +                                 }}.cast::<::core::ffi::c_void>(),
>
> A note on this toward the end
>
>> +                            }},
>> +                    }});
>> +                ",
>
>> @@ -216,12 +387,14 @@ pub(crate) fn module(ts: TokenStream) -> TokenStre=
am {
>
> Is a lot of below just some rewrapping and leading `::`? It may be
> good to split off tweaks to the existing code

Yes, absolute type paths were requested in v1. I will split those that
are not directly related to this change set.

>
>>              // SAFETY: `__this_module` is constructed by the kernel at =
load time and will not be
>>              // freed until the module is unloaded.
>>              #[cfg(MODULE)]
>> -            static THIS_MODULE: kernel::ThisModule =3D unsafe {{
>> -                kernel::ThisModule::from_ptr(&kernel::bindings::__this_=
module as *const _ as *mut _)
>> +            static THIS_MODULE: ::kernel::ThisModule =3D unsafe {{
>> +                ::kernel::ThisModule::from_ptr(
>> +                    &::kernel::bindings::__this_module as *const _ as *=
mut _
>> +                )
>>              }};
>>              #[cfg(not(MODULE))]
>> -            static THIS_MODULE: kernel::ThisModule =3D unsafe {{
>> -                kernel::ThisModule::from_ptr(core::ptr::null_mut())
>> +            static THIS_MODULE: ::kernel::ThisModule =3D unsafe {{
>> +                ::kernel::ThisModule::from_ptr(::core::ptr::null_mut())
>>              }};
>>
>>              // Double nested modules, since then nobody can access the =
public items inside.
>> @@ -276,7 +449,8 @@ mod __module_init {{
>>                      #[doc(hidden)]
>>                      #[link_section =3D \"{initcall_section}\"]
>>                      #[used]
>> -                    pub static __{name}_initcall: extern \"C\" fn() -> =
core::ffi::c_int =3D __{name}_init;
>> +                    pub static __{name}_initcall: extern \"C\" fn()
>> +                        -> ::core::ffi::c_int =3D __{name}_init;
>>
>>                      #[cfg(not(MODULE))]
>>                      #[cfg(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS)]
>> @@ -291,7 +465,7 @@ mod __module_init {{
>>                      #[cfg(not(MODULE))]
>>                      #[doc(hidden)]
>>                      #[no_mangle]
>> -                    pub extern \"C\" fn __{name}_init() -> core::ffi::c=
_int {{
>> +                    pub extern \"C\" fn __{name}_init() -> ::core::ffi:=
:c_int {{
>>                          // SAFETY: This function is inaccessible to the=
 outside due to the double
>>                          // module wrapping it. It is called exactly onc=
e by the C side via its
>>                          // placement above in the initcall section.
>> @@ -314,8 +488,8 @@ mod __module_init {{
>>                      /// # Safety
>>                      ///
>>                      /// This function must only be called once.
>> -                    unsafe fn __init() -> core::ffi::c_int {{
>> -                        match <{type_} as kernel::Module>::init(&super:=
:super::THIS_MODULE) {{
>> +                    unsafe fn __init() -> ::core::ffi::c_int {{
>> +                        match <{type_} as ::kernel::Module>::init(&supe=
r::super::THIS_MODULE) {{
>>                              Ok(m) =3D> {{
>>                                  // SAFETY: No data race, since `__MOD` =
can only be accessed by this
>>                                  // module and there only `__init` and `=
__exit` access it. These
>> @@ -346,14 +520,17 @@ unsafe fn __exit() {{
>>                              __MOD =3D None;
>>                          }}
>>                      }}
>> -
>>                      {modinfo}
>>                  }}
>>              }}
>> +            mod module_parameters {{
>> +                {params}
>> +            }}
>>          ",
>>          type_ =3D info.type_,
>>          name =3D info.name,
>>          modinfo =3D modinfo.buffer,
>> +        params =3D modinfo.param_buffer,
>>          initcall_section =3D ".initcall6.init"
>>      )
>>      .parse()
>
>> diff --git a/samples/rust/rust_minimal.rs b/samples/rust/rust_minimal.rs
>> index 2a9eaab62d1c..d9bc2218d504 100644
>> --- a/samples/rust/rust_minimal.rs
>> +++ b/samples/rust/rust_minimal.rs
>> @@ -10,6 +10,12 @@
>>      author: "Rust for Linux Contributors",
>>      description: "Rust minimal sample",
>>      license: "GPL",
>> +    params: {
>> +        test_parameter: i64 {
>> +            default: 1,
>> +            description: "This parameter has a default of 1",
>> +        },
>> +    },
>>  }
>
> I was going to suggest updating the sample then saw you did that
> already, thanks :)
>
>> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
>> index efacca63c897..a65bd0233843 100644
>> --- a/scripts/Makefile.build
>> +++ b/scripts/Makefile.build
>> @@ -263,7 +263,7 @@ $(obj)/%.lst: $(obj)/%.c FORCE
>>  # Compile Rust sources (.rs)
>>  # ---------------------------------------------------------------------=
------
>>
>> -rust_allowed_features :=3D new_uninit
>> +rust_allowed_features :=3D new_uninit,const_mut_refs
>
> We shouldn't enable `const_mut_refs`. It is indeed close to
> stabilization, but it is still kind of churny right now and we don't
> want to enable the sharp edges everywhere.
>
> If the change from `static mut` to `UnsafeCell` that I mentioned above
> happens, `addr_of_mut!` turns into a `.get().cast::<...>()` takes the
> place of `addr_of_mut!` and doesn't require this feature (and also
> isn't unsafe).
>
> If you prefer not to make that change, I think
> `addr_of!(...).cast_mut()` might be the best solution.

From the discussion at [1] it sounds to me like `static UnsafeCell` is the =
way
forward. I can apply that for the `static mut` instances this patch
introduces, and I can wait for `module` to be patched with that change
before resending this. No rush.

>
> ---
>
> Other thought: would a wrapper type make more sense here? Something like =
this:
>
> ```
> /* implementation */
> struct ModParam<T>(UnsafeCell<T>);
>
> // `Parameter` is the existing `ModParameter` (could be
> // any name). It could be sealed.
> impl<T: Parameter> ModParam<T> {
>     #[doc(hidden)] // used in the macro
>     fn new(value: T) -> Self { ... }
>
>     fn get(&self) -> T::Value { ... }
>     fn set(&self, v: T::Value) { ... }
> }
> ```
>
> With usage:
>
> ```
> module! {
>     // ...
>     // instantiated as:
>     // `static MY_PARAM: ModParam<i64> =3D ModParam::new(1);`
>     MY_PARAM: i64 {
>         default: 1,
>         description: "foo",
>     },
> }
>
> fn foo() {
>     pr_info!("My param is {}", MY_PARAM.get());
> }
> ```
>
> Advantages I see:
> - You bring your own name, rather than being scoped and needing to
> remember the module name

The scoping is intentional. We did not want to pollute the name space,
and `pin_init` had some issues when names were clashing. I think maybe
this was discussed in v1.

> - You can check `ModParam` in the docs to see the API, rather than
> needing to refer to source for the exact signatures of `read` and
> `write`

Yes, that is a bit annoying. We could also implement `read` as a trait
impl, so the trait would be documented in the `kernel` crate.

In the original code that this patch descends from, `read` was generated
differently, depending on how the parameter would integrate with sysfs.
We might be able to do that with generics withthe `ModParam` you suggest.

> - The interface gets a bit more like a mutex or atomic

We discussed passing `self` in v1 and dropped it in favor of the
associated method accessor. It would make sense with the `ModParam`
approach you suggest though.


Best regards,
Andreas


[1] https://rust-for-linux.zulipchat.com/#narrow/stream/x/topic/x/with/4650=
40682


