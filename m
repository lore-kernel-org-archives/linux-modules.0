Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE80E194AE6;
	Thu,  1 Aug 2024 12:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722515162; cv=none; b=YXKC+za4ut1SpFm3dWEgyi7/xSYE8NfFhgJLa08BsDptTCy0GDM7NwUCmdSDck9Xh6biR94TBZtFBJG4Ap2seSFMRQXhDbmtwVTfzpg254yj299rjFOhaN21KsY4zU7gM6WbEsZ753a1nKTELOPcy8Uoh/2SwGP5hdrBP2LJoM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722515162; c=relaxed/simple;
	bh=qbYuGyPU5EgjcLhZF+t06WHl/W+bgfycL5KkoqUP8Ac=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FVN7djnWUa72PapY5qiLyJX6SpqAqj6CUuPlL+cvz4V0ez6pnXldKIQoEDlNPcoG80DKW7mbEbk5DMmJX9rXqHUSul6JDNUu7zH6+7VUHqb33Q3hpmb6tCoBuaQzKZlPgrhEI+j9tZjNRRtdF9AA7wb8n+ZmRYTUQ86MtCGr7ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=cFF4BlEH; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="cFF4BlEH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722515156; x=1722774356;
	bh=QIWFrJfuSDSpAzK6fD0hmT3xSYv+6T3xQ6wj7lzfsFM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=cFF4BlEHhHr+u4WbHc7r6lw7dMw2lhYufZnAAf6NX9Di+QH6aNhQ5mYxhLtG2hJxh
	 eLXL3sMeOlgk3f4SQ5ahW6EN8CqNTvQXukiLI6RK0ZOEPeYL4mvCaEWl1TNCqS1MjM
	 fTnqAqcTcn0SSz56giZv/nS0fU3xrvIrfRXl8UzCq6devGRS+yoDCuh29YCcuBDVLg
	 C4xdHzY50SUa31kgeBiGIx6cFlHMbTm8nBDIGYxXk7bP+r8PLwyiRPAC9Y0lDnoPTy
	 3w/5IuItr1xnv6U3MloZ9saH5ZefdtJ5HSEW1JNXhnNibxNuQu39psG8gOy2aWufLt
	 9zDlszTYX8FFQ==
Date: Thu, 01 Aug 2024 12:25:50 +0000
To: Andreas Hindborg <nmi@metaspace.dk>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@samsung.com>, Adam Bratschi-Kaye <ark.email@gmail.com>
Subject: Re: [PATCH] rust: add `module_params` macro
Message-ID: <49cad242-7a7c-4e9e-beb7-4f9c493ce794@proton.me>
In-Reply-To: <87plqso50o.fsf@metaspace.dk>
References: <20240705111455.142790-1-nmi@metaspace.dk> <2838cf2e-936c-45de-bb19-af9da66fbe00@proton.me> <87plqso50o.fsf@metaspace.dk>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 578d61f0c3f63cab8e942d177f7f9f15c8e4bdc7
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01.08.24 13:29, Andreas Hindborg wrote:
>=20
> Hi Benno,
>=20
> Thanks for the comments!
>=20
> "Benno Lossin" <benno.lossin@proton.me> writes:
>=20
>> On 05.07.24 13:15, Andreas Hindborg wrote:
>=20
> [...]
>=20
>>> +
>>> +/// Types that can be used for module parameters.
>>> +///
>>> +/// Note that displaying the type in `sysfs` will fail if
>>> +/// [`core::str::from_utf8`] (as implemented through the [`core::fmt::=
Display`]
>>> +/// trait) writes more than [`PAGE_SIZE`] bytes (including an addition=
al null
>>> +/// terminator).
>>> +///
>>> +/// [`PAGE_SIZE`]: `bindings::PAGE_SIZE`
>>> +pub trait ModuleParam: core::fmt::Display + core::marker::Sized {
>>> +    /// The `ModuleParam` will be used by the kernel module through th=
is type.
>>> +    ///
>>> +    /// This may differ from `Self` if, for example, `Self` needs to t=
rack
>>> +    /// ownership without exposing it or allocate extra space for othe=
r possible
>>> +    /// parameter values. This is required to support string parameter=
s in the
>>> +    /// future.
>>> +    type Value: ?Sized;
>>> +
>>> +    /// Whether the parameter is allowed to be set without an argument=
.
>>> +    ///
>>> +    /// Setting this to `true` allows the parameter to be passed witho=
ut an
>>> +    /// argument (e.g. just `module.param` instead of `module.param=3D=
foo`).
>>> +    const NOARG_ALLOWED: bool;
>>
>> I think, there is a better way of doing this. Instead of this bool, we
>> do the following:
>> 1. have a `const DEFAULT: Option<Self>`
>> 2. change the type of the argument of `try_from_param_arg` to
>>    `&'static [u8]`
>>
>> That way we don't have the weird behavior of `try_from_param_arg` that
>> for params that don't have a default value.
>=20
> Since we have no parameter types for which `NOARG_ALLOWED` is true in
> this patch set, it is effectively dead code. I will remove it.

Hmm what parameters actually are optional? I looked at the old rust
branch and only `bool` is marked as optional. Are there others?

If it is used commonly for custom parameters (I could imagine that Rust
modules have enums as parameters and specifying nothing could mean the
default value), then it might be a good idea to just include it now.
(otherwise we might forget the design later)

>>> +
>>> +    /// Convert a parameter argument into the parameter value.
>>> +    ///
>>> +    /// `None` should be returned when parsing of the argument fails.
>>> +    /// `arg =3D=3D None` indicates that the parameter was passed with=
out an
>>> +    /// argument. If `NOARG_ALLOWED` is set to `false` then `arg` is g=
uaranteed
>>> +    /// to always be `Some(_)`.

[...]

>>> diff --git a/rust/macros/helpers.rs b/rust/macros/helpers.rs
>>> index 563dcd2b7ace..dc0b47879a8c 100644
>>> --- a/rust/macros/helpers.rs
>>> +++ b/rust/macros/helpers.rs
>>> @@ -107,6 +107,14 @@ pub(crate) struct Generics {
>>>      pub(crate) ty_generics: Vec<TokenTree>,
>>>  }
>>>
>>> +pub(crate) fn get_string(it: &mut token_stream::IntoIter, expected_nam=
e: &str) -> String {
>>
>> This name is rather weird, `get_field` makes more sense IMO.
>=20
> Looking at this, the `get` prefix is not aligned with other helpers. How
> about `expect_string_field` ?

SGTM

>>> +    assert_eq!(expect_ident(it), expected_name);
>>> +    assert_eq!(expect_punct(it), ':');
>>> +    let string =3D expect_string(it);
>>> +    assert_eq!(expect_punct(it), ',');
>>
>> Why do we require a trailing comma?
>=20
> For consistency with existing module macro. All keys must be terminated
> with comma.

Hmm I think that might be a bit unexpected, since everywhere else in
Rust you are allowed to omit the trailing comma. But I guess if the
entire `module!` macro does that currently, then we can change that when
we move to `syn`.

[...]

>>> +                    param_type.to_string(),
>>> +                    param_ops_path(&param_type).to_string(),
>>> +                );
>>> +
>>> +                self.emit_param("parmtype", &param_name, &param_kernel=
_type);
>>
>> Is the spelling intentional? "parmtype"?
>=20
> This is intentional. I don't think the kernel is ever parsing this, but
> it is parsed by the `modinfo` tool.

Hmm, why is it not `paramtype`? Does that conflict with something?

>>> +                self.emit_param("parm", &param_name, &param_descriptio=
n);
>>> +                let param_type_internal =3D param_type.clone();
>>> +
>>> +                let read_func =3D format!(
>>> +                    "
>>> +                        pub(crate) fn read(&self)
>>> +                            -> &<{param_type_internal}
>>> +                               as kernel::module_param::ModuleParam>::=
Value {{
>>
>> Please add a `::` in front of `kernel::module_param::ModuleParam`. There
>> are more instances below.
>=20
> Thanks.
>=20
>>
>>> +                            // Note: when we enable r/w parameters, we=
 need to lock here.
>>> +
>>> +                            // SAFETY: Parameters do not need to be lo=
cked because they are
>>> +                            // read only or sysfs is not enabled.
>>> +                            unsafe {{
>>> +                                <{param_type_internal} as kernel::modu=
le_param::ModuleParam>::value(
>>> +                                    &__{name}_{param_name}_value
>>> +                                )
>>> +                            }}
>>> +                        }}
>>> +                    ",
>>> +                    name =3D info.name,
>>> +                    param_name =3D param_name,
>>> +                    param_type_internal =3D param_type_internal,
>>> +                );
>>> +
>>> +                let kparam =3D format!(
>>> +                    "
>>> +                    kernel::bindings::kernel_param__bindgen_ty_1 {{
>>> +                        // SAFETY: Access through the resulting pointe=
r is
>>> +                        // serialized by C side and only happens befor=
e module
>>> +                        // `init` or after module `drop` is called.
>>> +                        arg: unsafe {{ &__{name}_{param_name}_value }}
>>> +                            as *const _ as *mut core::ffi::c_void,
>>
>> Here you should use `addr_of[_mut]!` instead of taking a reference.
>=20
> This is a static initializer, so it would be evaluated in const context.
> At that time, this is going to be the only reference to
> `&__{name}_{param_name}_value` which would be const. So it should be
> fine?

When compiling this [1] with a sufficiently new Rust version, you will
get an error:

    warning: creating a shared reference to mutable static is discouraged
     --> src/main.rs:4:22
      |
    4 |     let x =3D unsafe { &foo };
      |                      ^^^^ shared reference to mutable static
      |
      =3D note: for more information, see issue #114447 <https://github.com=
/rust-lang/rust/issues/114447>
      =3D note: this will be a hard error in the 2024 edition
      =3D note: this shared reference has lifetime `'static`, but if the st=
atic ever gets mutated, or a mutable reference is created, then any further=
 use of this shared reference is Undefined Behavior
      =3D note: `#[warn(static_mut_refs)]` on by default
    help: use `addr_of!` instead to create a raw pointer
      |
    4 |     let x =3D unsafe { addr_of!(foo) };
      |                      ~~~~~~~~~~~~~

[1]: https://play.rust-lang.org/?version=3Dstable&mode=3Ddebug&edition=3D20=
21&gist=3Dc914a438938be6f5fc643ee277efa1d1

So I think we should start using `addr_of!` for mutable static now.

> The safety comment is wrong though.
>=20
>> Also
>> will this pointer be used to write to the static, in that case you need
>> `_mut!`.
>=20
> Not in this version of the patch set, but potentially in future iteration=
s.

All the more reason to use `addr_of!` IMO.

>>> +                    }},
>>> +                ",
>>> +                    name =3D info.name,
>>> +                    param_name =3D param_name,
>>> +                );
>>
>> What is the reason for putting `kparam` and `read_func` outside of the
>> `write!` below? I think it would be easier to read if they are inlined.
>=20
> It had different shapes based on other options in the original patch
> set. I guess I can just inline it in this version.
>=20
>>
>>> +                write!(
>>> +                    self.param_buffer,
>>> +                    "
>>> +                static mut __{name}_{param_name}_value: {param_type_in=
ternal} =3D {param_default};
>>> +
>>> +                pub(crate) struct __{name}_{param_name};
>>> +
>>> +                impl __{name}_{param_name} {{ {read_func} }}
>>> +
>>> +                pub(crate) const {param_name}: __{name}_{param_name} =
=3D __{name}_{param_name};
>>
>> Why do we need a unit struct as a constant? I think it would make more
>> sense to have a unit struct/empty enum as the type and the `read`
>> function be without a receiver.
>=20
> To be able to call `module_parameters::my_parameter.read()`. Other
> options would be `module_parameters::my_parameter::read()` or
> `module_parameters::my_parameter_read()`.
>=20
> I don't think there will be a difference in the generated machine code.
> I also don't have any particular preference. Probably
> `module_parameters::my_parameter::read()` is the most idiomatic one.

Yeah, I would prefer if we can avoid having both a constant and a type.
The type then also can be an empty enum, so no value can be constructed.

>>> +
>>> +                // Note: the C macro that generates the static structs=
 for the `__param` section
>>> +                // asks for them to be `aligned(sizeof(void *))`. Howe=
ver, that was put in place
>>> +                // in 2003 in commit 38d5b085d2a0 (\"[PATCH] Fix over-=
alignment problem on x86-64\")
>>> +                // to undo GCC over-alignment of static structs of >32=
 bytes. It seems that is
>>> +                // not the case anymore, so we simplify to a transpare=
nt representation here
>>> +                // in the expectation that it is not needed anymore.
>>> +                // TODO: Revisit this to confirm the above comment and=
 remove it if it happened.
>>
>> Should this TODO be fixed before this is merged? Or do you intend for it
>> to stay?
>> If this is indeed correct, should this also be changed in the C side (of
>> course a different patch)?
>=20
> I dug into this. The original code in this patch must be quite old,
> because that the code the comment refers to was changed in Nov 2020 from
> `aligned(sizeof(void *))` to `__aligned(__alignof__(struct
> kernel_param))`. The commit message says that the rationale for not
> removing the alignment completely is to prevent the compiler from
> increasing the alignment, as this would mess up the array stride used in
> the `__param` section.
>=20
> So I think we can remove the comment and keep `repr(transparent)`, right?
> I think `rustc` would not increase the alignment of a `repr(C)` struct
> for optimization purposes?

I don't know that, maybe Gary or someone else knows how this works.

>>> +                /// Newtype to make `bindings::kernel_param` `Sync`.
>>> +                #[repr(transparent)]
>>> +                struct __{name}_{param_name}_RacyKernelParam(kernel::b=
indings::kernel_param);
>>> +
>>> +                // SAFETY: C kernel handles serializing access to this=
 type. We
>>> +                // never access from Rust module.
>>> +                unsafe impl Sync for __{name}_{param_name}_RacyKernelP=
aram {{
>>> +                }}
>>
>> Any reason to put the `}` on the next line?
>=20
> No. Do you have any tricks for formatting multi line strings of code like=
 this?

Not really, I don't think that this is a big deal, since this will
eventually be replaced by `syn`, which can be formatted more easily.

>>> +
>>> +                #[cfg(not(MODULE))]
>>> +                const __{name}_{param_name}_name: *const core::ffi::c_=
char =3D
>>> +                    b\"{name}.{param_name}\\0\" as *const _ as *const =
core::ffi::c_char;
>>> +
>>> +                #[cfg(MODULE)]
>>> +                const __{name}_{param_name}_name: *const core::ffi::c_=
char =3D
>>> +                    b\"{param_name}\\0\" as *const _ as *const core::f=
fi::c_char;
>>> +
>>> +                #[link_section =3D \"__param\"]
>>> +                #[used]
>>> +                static __{name}_{param_name}_struct: __{name}_{param_n=
ame}_RacyKernelParam =3D
>>> +                    __{name}_{param_name}_RacyKernelParam(kernel::bind=
ings::kernel_param {{
>>> +                        name: __{name}_{param_name}_name,
>>> +                        // SAFETY: `__this_module` is constructed by t=
he kernel at load time
>>> +                        // and will not be freed until the module is u=
nloaded.
>>> +                        #[cfg(MODULE)]
>>> +                        mod_: unsafe {{ &kernel::bindings::__this_modu=
le as *const _ as *mut _ }},
>>> +                        #[cfg(not(MODULE))]
>>> +                        mod_: core::ptr::null_mut(),
>>> +                        // SAFETY: This static is actually constant as=
 seen by
>>> +                        // module code. But we need a unique address f=
or it, so it
>>> +                        // must be static.
>>
>> This safety comment makes no sense, should it be a normal comment?
>=20
> I removed the unsafe block and the safety comment as unsafe is not
> required here.
>=20
>>
>>> +                        ops: unsafe {{ &{ops} }} as *const kernel::bin=
dings::kernel_param_ops,
>>
>> Why is this `unsafe` block needed, the `make_param_ops` macro declares a
>> non-mut static.
>>
>>> +                        perm: 0, // Will not appear in sysfs
>>> +                        level: -1,
>>
>> Why this value?
>=20
> The kernel has 8 initcall levels. Parameters can be assigned one of
> these levels to have the parameter initialized just before the init
> functions for that level are executed. -1 has no effect for loadable modu=
les, but
> for built-in modules it looks like the args will be initialized just afte=
r early
> boot args (level 0).
>=20
> At any rate, this is what C side does.

I see, I was just wondering where the magic value comes from (especially
since the `perm` value has a comment explaining what it does).

---
Cheers,
Benno

