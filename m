Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59755183CC5;
	Thu,  1 Aug 2024 13:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722519614; cv=none; b=aM9QLHGsPobhPObh0TQGPqKtSMCVBP8psu8VVdKgQB1iONFsew8lOCbTT77DoHz3chgWoix7x1OGlgbtA5ROqr70IEP51Sen+z+O/X/Uw1AHAOH3Y9TR2h7/iMvoKOuhPqdASVTEiuUBJWZBKGyWhZ/R0RuzmNGMki/9+hvg48k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722519614; c=relaxed/simple;
	bh=21jbxK8qXzuWbgRIcyHIMeHKEgLWlkmdiFPZ/uCSQxs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nfXkOSkyefwiTr1OfeLekGdfjh5mMcAFztd4WPrvLEZu4SGeDSxM8BfK5pafBUk6/5T6OjSkR4N4juM2js9tKwvSWoOt+mLPreo3ktdjRy9vSvoQRwrAyCGoKZvi3SPpWIW/0N33iAareo0pe3LODqY9XW6751JXznJSgzk+AMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=metaspace.dk; spf=pass smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace.dk header.i=@metaspace.dk header.b=WcbV8lGu; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace.dk header.i=@metaspace.dk header.b="WcbV8lGu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=metaspace.dk;
	s=protonmail; t=1722519607; x=1722778807;
	bh=rhX0FLpXsXnWn/EdgAIVtYtsDx6edczeM0/GqGYIcyw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=WcbV8lGuax6d9yJDhDh8l/3HE7SGVm8ylYRrL/Tg0g+1FiikET8cqynXErxH7j6+v
	 o8nJevJEcz5hel2xSoSADjAxccvzf9hyaWE1z73wuHR0AgyW5rjAPXeqm1S6K5CouV
	 dEvwqCrgJrHQ+jcF/n3KXfOfmaP9iaw+ibsdiinb/L5IZ3WKwxzsxdLu54/evfOpHf
	 rFitiowQUuaS7apUNHA/5EPG8dxTxi4zanmQ2gEsVcMcauSFvZDkfL9i/HwZLHMjna
	 7nRDkrX5piD2/LGIklWzzXzFsekR19kXBvTTbnimLE1KtRSWoliXdDeswWgJSLgVMw
	 4rvdHH3IpSq0A==
Date: Thu, 01 Aug 2024 13:40:03 +0000
To: Benno Lossin <benno.lossin@proton.me>
From: Andreas Hindborg <nmi@metaspace.dk>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@samsung.com>, Adam Bratschi-Kaye <ark.email@gmail.com>
Subject: Re: [PATCH] rust: add `module_params` macro
Message-ID: <878qxgnyzd.fsf@metaspace.dk>
In-Reply-To: <49cad242-7a7c-4e9e-beb7-4f9c493ce794@proton.me>
References: <20240705111455.142790-1-nmi@metaspace.dk> <2838cf2e-936c-45de-bb19-af9da66fbe00@proton.me> <87plqso50o.fsf@metaspace.dk> <49cad242-7a7c-4e9e-beb7-4f9c493ce794@proton.me>
Feedback-ID: 113830118:user:proton
X-Pm-Message-ID: 02ebcc38c7b50d253a01dd0e01a6e5f1b61e2983
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Benno Lossin" <benno.lossin@proton.me> writes:

> On 01.08.24 13:29, Andreas Hindborg wrote:
>>=20
>> Hi Benno,
>>=20
>> Thanks for the comments!
>>=20
>> "Benno Lossin" <benno.lossin@proton.me> writes:
>>=20
>>> On 05.07.24 13:15, Andreas Hindborg wrote:
>>=20
>> [...]
>>=20
>>>> +
>>>> +/// Types that can be used for module parameters.
>>>> +///
>>>> +/// Note that displaying the type in `sysfs` will fail if
>>>> +/// [`core::str::from_utf8`] (as implemented through the [`core::fmt:=
:Display`]
>>>> +/// trait) writes more than [`PAGE_SIZE`] bytes (including an additio=
nal null
>>>> +/// terminator).
>>>> +///
>>>> +/// [`PAGE_SIZE`]: `bindings::PAGE_SIZE`
>>>> +pub trait ModuleParam: core::fmt::Display + core::marker::Sized {
>>>> +    /// The `ModuleParam` will be used by the kernel module through t=
his type.
>>>> +    ///
>>>> +    /// This may differ from `Self` if, for example, `Self` needs to =
track
>>>> +    /// ownership without exposing it or allocate extra space for oth=
er possible
>>>> +    /// parameter values. This is required to support string paramete=
rs in the
>>>> +    /// future.
>>>> +    type Value: ?Sized;
>>>> +
>>>> +    /// Whether the parameter is allowed to be set without an argumen=
t.
>>>> +    ///
>>>> +    /// Setting this to `true` allows the parameter to be passed with=
out an
>>>> +    /// argument (e.g. just `module.param` instead of `module.param=
=3Dfoo`).
>>>> +    const NOARG_ALLOWED: bool;
>>>
>>> I think, there is a better way of doing this. Instead of this bool, we
>>> do the following:
>>> 1. have a `const DEFAULT: Option<Self>`
>>> 2. change the type of the argument of `try_from_param_arg` to
>>>    `&'static [u8]`
>>>
>>> That way we don't have the weird behavior of `try_from_param_arg` that
>>> for params that don't have a default value.
>>=20
>> Since we have no parameter types for which `NOARG_ALLOWED` is true in
>> this patch set, it is effectively dead code. I will remove it.
>
> Hmm what parameters actually are optional? I looked at the old rust
> branch and only `bool` is marked as optional. Are there others?
>
> If it is used commonly for custom parameters (I could imagine that Rust
> modules have enums as parameters and specifying nothing could mean the
> default value), then it might be a good idea to just include it now.
> (otherwise we might forget the design later)

As far as I can tell from the C code, all parameters are able to have
the `NOARG` flag set. We get a null pointer in the callback in that
case.

If we want to handle this now, we could drop the `default` field
in the Rust module macro. There is no equivalent in the C macros.
And then use an `Option<Option<_>>` to represent the value. `None` would
be an unset parameter. `Some(None)` would be a parameter without a
value. `Some(Some(_))` would be a set parameter with a value. We could
probably fix the types so that only parameters with the `NOARG` flag use
the double option, others use a single option.

Or we could just not adopt this feature in the Rust abstractions.

>
>>>> +
>>>> +    /// Convert a parameter argument into the parameter value.
>>>> +    ///
>>>> +    /// `None` should be returned when parsing of the argument fails.
>>>> +    /// `arg =3D=3D None` indicates that the parameter was passed wit=
hout an
>>>> +    /// argument. If `NOARG_ALLOWED` is set to `false` then `arg` is =
guaranteed
>>>> +    /// to always be `Some(_)`.
>
> [...]
>
>>>> diff --git a/rust/macros/helpers.rs b/rust/macros/helpers.rs
>>>> index 563dcd2b7ace..dc0b47879a8c 100644
>>>> --- a/rust/macros/helpers.rs
>>>> +++ b/rust/macros/helpers.rs
>>>> @@ -107,6 +107,14 @@ pub(crate) struct Generics {
>>>>      pub(crate) ty_generics: Vec<TokenTree>,
>>>>  }
>>>>
>>>> +pub(crate) fn get_string(it: &mut token_stream::IntoIter, expected_na=
me: &str) -> String {
>>>
>>> This name is rather weird, `get_field` makes more sense IMO.
>>=20
>> Looking at this, the `get` prefix is not aligned with other helpers. How
>> about `expect_string_field` ?
>
> SGTM
>
>>>> +    assert_eq!(expect_ident(it), expected_name);
>>>> +    assert_eq!(expect_punct(it), ':');
>>>> +    let string =3D expect_string(it);
>>>> +    assert_eq!(expect_punct(it), ',');
>>>
>>> Why do we require a trailing comma?
>>=20
>> For consistency with existing module macro. All keys must be terminated
>> with comma.
>
> Hmm I think that might be a bit unexpected, since everywhere else in
> Rust you are allowed to omit the trailing comma. But I guess if the
> entire `module!` macro does that currently, then we can change that when
> we move to `syn`.

Yes, I agree.

>
> [...]
>
>>>> +                    param_type.to_string(),
>>>> +                    param_ops_path(&param_type).to_string(),
>>>> +                );
>>>> +
>>>> +                self.emit_param("parmtype", &param_name, &param_kerne=
l_type);
>>>
>>> Is the spelling intentional? "parmtype"?
>>=20
>> This is intentional. I don't think the kernel is ever parsing this, but
>> it is parsed by the `modinfo` tool.
>
> Hmm, why is it not `paramtype`? Does that conflict with something?

You would have to take that up with the maintainer(s) of the `modinfo`
tool. The name is externally dictated [1].

>
>>>> +                self.emit_param("parm", &param_name, &param_descripti=
on);
>>>> +                let param_type_internal =3D param_type.clone();
>>>> +
>>>> +                let read_func =3D format!(
>>>> +                    "
>>>> +                        pub(crate) fn read(&self)
>>>> +                            -> &<{param_type_internal}
>>>> +                               as kernel::module_param::ModuleParam>:=
:Value {{
>>>
>>> Please add a `::` in front of `kernel::module_param::ModuleParam`. Ther=
e
>>> are more instances below.
>>=20
>> Thanks.
>>=20
>>>
>>>> +                            // Note: when we enable r/w parameters, w=
e need to lock here.
>>>> +
>>>> +                            // SAFETY: Parameters do not need to be l=
ocked because they are
>>>> +                            // read only or sysfs is not enabled.
>>>> +                            unsafe {{
>>>> +                                <{param_type_internal} as kernel::mod=
ule_param::ModuleParam>::value(
>>>> +                                    &__{name}_{param_name}_value
>>>> +                                )
>>>> +                            }}
>>>> +                        }}
>>>> +                    ",
>>>> +                    name =3D info.name,
>>>> +                    param_name =3D param_name,
>>>> +                    param_type_internal =3D param_type_internal,
>>>> +                );
>>>> +
>>>> +                let kparam =3D format!(
>>>> +                    "
>>>> +                    kernel::bindings::kernel_param__bindgen_ty_1 {{
>>>> +                        // SAFETY: Access through the resulting point=
er is
>>>> +                        // serialized by C side and only happens befo=
re module
>>>> +                        // `init` or after module `drop` is called.
>>>> +                        arg: unsafe {{ &__{name}_{param_name}_value }=
}
>>>> +                            as *const _ as *mut core::ffi::c_void,
>>>
>>> Here you should use `addr_of[_mut]!` instead of taking a reference.
>>=20
>> This is a static initializer, so it would be evaluated in const context.
>> At that time, this is going to be the only reference to
>> `&__{name}_{param_name}_value` which would be const. So it should be
>> fine?
>
> When compiling this [1] with a sufficiently new Rust version, you will
> get an error:
>
>     warning: creating a shared reference to mutable static is discouraged
>      --> src/main.rs:4:22
>       |
>     4 |     let x =3D unsafe { &foo };
>       |                      ^^^^ shared reference to mutable static
>       |
>       =3D note: for more information, see issue #114447 <https://github.c=
om/rust-lang/rust/issues/114447>
>       =3D note: this will be a hard error in the 2024 edition
>       =3D note: this shared reference has lifetime `'static`, but if the =
static ever gets mutated, or a mutable reference is created, then any furth=
er use of this shared reference is Undefined Behavior
>       =3D note: `#[warn(static_mut_refs)]` on by default
>     help: use `addr_of!` instead to create a raw pointer
>       |
>     4 |     let x =3D unsafe { addr_of!(foo) };
>       |                      ~~~~~~~~~~~~~
>
> [1]: https://play.rust-lang.org/?version=3Dstable&mode=3Ddebug&edition=3D=
2021&gist=3Dc914a438938be6f5fc643ee277efa1d1
>
> So I think we should start using `addr_of!` for mutable static now.

Oh. Thanks for the pointer.

Hmm, `addr_of_mut!` still requires the unsafe block. Hopefully that goes
away as well with the feature you linked as well.

This also requires `const_mut_refs`, but as I recall that is going to be
stabilized soon.

>
>> The safety comment is wrong though.
>>=20
>>> Also
>>> will this pointer be used to write to the static, in that case you need
>>> `_mut!`.
>>=20
>> Not in this version of the patch set, but potentially in future iteratio=
ns.
>
> All the more reason to use `addr_of!` IMO.
>
>>>> +                    }},
>>>> +                ",
>>>> +                    name =3D info.name,
>>>> +                    param_name =3D param_name,
>>>> +                );
>>>
>>> What is the reason for putting `kparam` and `read_func` outside of the
>>> `write!` below? I think it would be easier to read if they are inlined.
>>=20
>> It had different shapes based on other options in the original patch
>> set. I guess I can just inline it in this version.
>>=20
>>>
>>>> +                write!(
>>>> +                    self.param_buffer,
>>>> +                    "
>>>> +                static mut __{name}_{param_name}_value: {param_type_i=
nternal} =3D {param_default};
>>>> +
>>>> +                pub(crate) struct __{name}_{param_name};
>>>> +
>>>> +                impl __{name}_{param_name} {{ {read_func} }}
>>>> +
>>>> +                pub(crate) const {param_name}: __{name}_{param_name} =
=3D __{name}_{param_name};
>>>
>>> Why do we need a unit struct as a constant? I think it would make more
>>> sense to have a unit struct/empty enum as the type and the `read`
>>> function be without a receiver.
>>=20
>> To be able to call `module_parameters::my_parameter.read()`. Other
>> options would be `module_parameters::my_parameter::read()` or
>> `module_parameters::my_parameter_read()`.
>>=20
>> I don't think there will be a difference in the generated machine code.
>> I also don't have any particular preference. Probably
>> `module_parameters::my_parameter::read()` is the most idiomatic one.
>
> Yeah, I would prefer if we can avoid having both a constant and a type.
> The type then also can be an empty enum, so no value can be constructed.

Nice trick =F0=9F=91=8D

>
>>>> +
>>>> +                // Note: the C macro that generates the static struct=
s for the `__param` section
>>>> +                // asks for them to be `aligned(sizeof(void *))`. How=
ever, that was put in place
>>>> +                // in 2003 in commit 38d5b085d2a0 (\"[PATCH] Fix over=
-alignment problem on x86-64\")
>>>> +                // to undo GCC over-alignment of static structs of >3=
2 bytes. It seems that is
>>>> +                // not the case anymore, so we simplify to a transpar=
ent representation here
>>>> +                // in the expectation that it is not needed anymore.
>>>> +                // TODO: Revisit this to confirm the above comment an=
d remove it if it happened.
>>>
>>> Should this TODO be fixed before this is merged? Or do you intend for i=
t
>>> to stay?
>>> If this is indeed correct, should this also be changed in the C side (o=
f
>>> course a different patch)?
>>=20
>> I dug into this. The original code in this patch must be quite old,
>> because that the code the comment refers to was changed in Nov 2020 from
>> `aligned(sizeof(void *))` to `__aligned(__alignof__(struct
>> kernel_param))`. The commit message says that the rationale for not
>> removing the alignment completely is to prevent the compiler from
>> increasing the alignment, as this would mess up the array stride used in
>> the `__param` section.
>>=20
>> So I think we can remove the comment and keep `repr(transparent)`, right=
?
>> I think `rustc` would not increase the alignment of a `repr(C)` struct
>> for optimization purposes?
>
> I don't know that, maybe Gary or someone else knows how this works.
>
>>>> +                /// Newtype to make `bindings::kernel_param` `Sync`.
>>>> +                #[repr(transparent)]
>>>> +                struct __{name}_{param_name}_RacyKernelParam(kernel::=
bindings::kernel_param);
>>>> +
>>>> +                // SAFETY: C kernel handles serializing access to thi=
s type. We
>>>> +                // never access from Rust module.
>>>> +                unsafe impl Sync for __{name}_{param_name}_RacyKernel=
Param {{
>>>> +                }}
>>>
>>> Any reason to put the `}` on the next line?
>>=20
>> No. Do you have any tricks for formatting multi line strings of code lik=
e this?
>
> Not really, I don't think that this is a big deal, since this will
> eventually be replaced by `syn`, which can be formatted more easily.
>
>>>> +
>>>> +                #[cfg(not(MODULE))]
>>>> +                const __{name}_{param_name}_name: *const core::ffi::c=
_char =3D
>>>> +                    b\"{name}.{param_name}\\0\" as *const _ as *const=
 core::ffi::c_char;
>>>> +
>>>> +                #[cfg(MODULE)]
>>>> +                const __{name}_{param_name}_name: *const core::ffi::c=
_char =3D
>>>> +                    b\"{param_name}\\0\" as *const _ as *const core::=
ffi::c_char;
>>>> +
>>>> +                #[link_section =3D \"__param\"]
>>>> +                #[used]
>>>> +                static __{name}_{param_name}_struct: __{name}_{param_=
name}_RacyKernelParam =3D
>>>> +                    __{name}_{param_name}_RacyKernelParam(kernel::bin=
dings::kernel_param {{
>>>> +                        name: __{name}_{param_name}_name,
>>>> +                        // SAFETY: `__this_module` is constructed by =
the kernel at load time
>>>> +                        // and will not be freed until the module is =
unloaded.
>>>> +                        #[cfg(MODULE)]
>>>> +                        mod_: unsafe {{ &kernel::bindings::__this_mod=
ule as *const _ as *mut _ }},
>>>> +                        #[cfg(not(MODULE))]
>>>> +                        mod_: core::ptr::null_mut(),
>>>> +                        // SAFETY: This static is actually constant a=
s seen by
>>>> +                        // module code. But we need a unique address =
for it, so it
>>>> +                        // must be static.
>>>
>>> This safety comment makes no sense, should it be a normal comment?
>>=20
>> I removed the unsafe block and the safety comment as unsafe is not
>> required here.
>>=20
>>>
>>>> +                        ops: unsafe {{ &{ops} }} as *const kernel::bi=
ndings::kernel_param_ops,
>>>
>>> Why is this `unsafe` block needed, the `make_param_ops` macro declares =
a
>>> non-mut static.
>>>
>>>> +                        perm: 0, // Will not appear in sysfs
>>>> +                        level: -1,
>>>
>>> Why this value?
>>=20
>> The kernel has 8 initcall levels. Parameters can be assigned one of
>> these levels to have the parameter initialized just before the init
>> functions for that level are executed. -1 has no effect for loadable mod=
ules, but
>> for built-in modules it looks like the args will be initialized just aft=
er early
>> boot args (level 0).
>>=20
>> At any rate, this is what C side does.
>
> I see, I was just wondering where the magic value comes from (especially
> since the `perm` value has a comment explaining what it does).

I don't think we should add a comment here. The `level` field is not
well documented on C side. Probably the best thing here is to force
people to go read the C source.


Best regards,
Andreas

[1] https://github.com/kmod-project/kmod/blob/af21689dd0f1ef6f40d6ecc323885=
026a07486f9/tools/modinfo.c#L118


