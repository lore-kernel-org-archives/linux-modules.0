Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF052189BA2;
	Thu,  1 Aug 2024 11:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722511808; cv=none; b=Mv6DrsY1+uhYGxEPjTOWqJXUQOSjdKaVYexD0FW9HuumuEczC7lbHmJpLRgblaPQqP8TaPbZzjiY+fZHBHYOUlxBg8wuZgBKc3CnmI4HWgF5+CFe2IUgeTLZUsscdJ+YG7Pd9ZT3Aev96cXJOqvDvxWcwiKKpYvo68WLL2x+YO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722511808; c=relaxed/simple;
	bh=VgtZ2oOZGYyxn6HtiWcbqX+Ai1fITzrNHpvkrF7eIOI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HPDnD6k5H0AtR3t2+c4S51vGaovPULRs/yvw8N72L2gZc8e/QHBdlb3mp4ZpuqW3WTyZetv4n6/Ho8mAclUzIfr+MBUCOFXvdJyU5u5J9sZTRr6lF+E/MoCZEgPoNW9BIiUK+IycwnTiiwmCDnN6qnaxMwrPGgKTHzHEe5rngeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=metaspace.dk; spf=pass smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace.dk header.i=@metaspace.dk header.b=hHXqIiYR; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace.dk header.i=@metaspace.dk header.b="hHXqIiYR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=metaspace.dk;
	s=protonmail; t=1722511794; x=1722770994;
	bh=t5Aam9RncmzXx3s9IGiR6QSwyNprlAtYBAhFTSqZMC0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=hHXqIiYRdfHdZ0jJ5VU6NeX6oOjO/VsJoww6/n5RWR++pg0EmtIdfmLwl8K5NL4Wu
	 nrWssx34gtU/rODLJSWnm38n/JBucnXxaZTpEvNm2fYlHVKfkZOKxNNCEOEkAfklSi
	 KhSRb2YmQpB3f6vlQpN8v8zO0JcjMKIL/PZsG4iJgy5bJRM2Dju9StpFW2UzM6GNRd
	 FV240nptmt2Mq7syvw8rW2IxjJWCOrDp/5OPCWLs3L8H1XAY63Y6JuAFJsBqeypv1l
	 SSrqgP+/nW+o4kyfPvVIGSRrj44WVOjO2kwpPi1LhU2Kt1CiPqBLGupox8nuY8t0qI
	 lkq443KL5TSfA==
Date: Thu, 01 Aug 2024 11:29:49 +0000
To: Benno Lossin <benno.lossin@proton.me>
From: Andreas Hindborg <nmi@metaspace.dk>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@samsung.com>, Adam Bratschi-Kaye <ark.email@gmail.com>
Subject: Re: [PATCH] rust: add `module_params` macro
Message-ID: <87plqso50o.fsf@metaspace.dk>
In-Reply-To: <2838cf2e-936c-45de-bb19-af9da66fbe00@proton.me>
References: <20240705111455.142790-1-nmi@metaspace.dk> <2838cf2e-936c-45de-bb19-af9da66fbe00@proton.me>
Feedback-ID: 113830118:user:proton
X-Pm-Message-ID: 0a0b10e43e5537d2a38d7adfaba05a3979547fb0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hi Benno,

Thanks for the comments!

"Benno Lossin" <benno.lossin@proton.me> writes:

> On 05.07.24 13:15, Andreas Hindborg wrote:

[...]

>> +
>> +/// Types that can be used for module parameters.
>> +///
>> +/// Note that displaying the type in `sysfs` will fail if
>> +/// [`core::str::from_utf8`] (as implemented through the [`core::fmt::D=
isplay`]
>> +/// trait) writes more than [`PAGE_SIZE`] bytes (including an additiona=
l null
>> +/// terminator).
>> +///
>> +/// [`PAGE_SIZE`]: `bindings::PAGE_SIZE`
>> +pub trait ModuleParam: core::fmt::Display + core::marker::Sized {
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
>> +
>> +    /// Whether the parameter is allowed to be set without an argument.
>> +    ///
>> +    /// Setting this to `true` allows the parameter to be passed withou=
t an
>> +    /// argument (e.g. just `module.param` instead of `module.param=3Df=
oo`).
>> +    const NOARG_ALLOWED: bool;
>
> I think, there is a better way of doing this. Instead of this bool, we
> do the following:
> 1. have a `const DEFAULT: Option<Self>`
> 2. change the type of the argument of `try_from_param_arg` to
>    `&'static [u8]`
>
> That way we don't have the weird behavior of `try_from_param_arg` that
> for params that don't have a default value.

Since we have no parameter types for which `NOARG_ALLOWED` is true in
this patch set, it is effectively dead code. I will remove it.

>
>> +
>> +    /// Convert a parameter argument into the parameter value.
>> +    ///
>> +    /// `None` should be returned when parsing of the argument fails.
>> +    /// `arg =3D=3D None` indicates that the parameter was passed witho=
ut an
>> +    /// argument. If `NOARG_ALLOWED` is set to `false` then `arg` is gu=
aranteed
>> +    /// to always be `Some(_)`.
>> +    ///
>> +    /// Parameters passed at boot time will be set before [`kmalloc`] i=
s
>> +    /// available (even if the module is loaded at a later time). Howev=
er, in
>> +    /// this case, the argument buffer will be valid for the entire lif=
etime of
>> +    /// the kernel. So implementations of this method which need to all=
ocate
>> +    /// should first check that the allocator is available (with
>> +    /// [`crate::bindings::slab_is_available`]) and when it is not avai=
lable
>> +    /// provide an alternative implementation which doesn't allocate. I=
n cases
>> +    /// where the allocator is not available it is safe to save referen=
ces to
>> +    /// `arg` in `Self`, but in other cases a copy should be made.
>> +    ///
>> +    /// [`kmalloc`]: ../../../include/linux/slab.h
>> +    fn try_from_param_arg(arg: Option<&'static [u8]>) -> Option<Self>;
>
> Do we want this to return `Result` instead?
> Or rather, why is this returning `Option`?

Some legacy cruft is going on here I think. At some point in the past
the patch set supported parameters without value, and this option was
supposed to represent the presence of a value. It looks like it then got
aliased with parse errors.

Since we do not support parameters without value in this patch set, I
will update the return type and documentation to handle parse errors
with `Result`.

>
>> +
>> +    /// Get the current value of the parameter for use in the kernel mo=
dule.
>> +    ///
>> +    /// This function should not be used directly. Instead use the wrap=
per
>> +    /// `read` which will be generated by [`macros::module`].
>> +    fn value(&self) -> &Self::Value;
>> +
>> +    /// Set the module parameter from a string.
>> +    ///
>> +    /// Used to set the parameter value at kernel initialization, when =
loading
>> +    /// the module or when set through `sysfs`.
>> +    ///
>> +    /// `param.arg` is a pointer to `*mut Self` as set up by the [`modu=
le!`]
>> +    /// macro.
>> +    ///
>> +    /// See `struct kernel_param_ops.set`.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// If `val` is non-null then it must point to a valid null-termina=
ted
>> +    /// string. The `arg` field of `param` must be an instance of `Self=
`.
>> +    ///
>> +    /// # Invariants
>> +    ///
>> +    /// Currently, we only support read-only parameters that are not re=
adable
>> +    /// from `sysfs`. Thus, this function is only called at kernel
>> +    /// initialization time, or at module load time, and we have exclus=
ive
>> +    /// access to the parameter for the duration of the function.
>> +    ///
>> +    /// [`module!`]: macros::module
>> +    unsafe extern "C" fn set_param(
>> +        val: *const core::ffi::c_char,
>> +        param: *const crate::bindings::kernel_param,
>> +    ) -> core::ffi::c_int {
>> +        let arg =3D if val.is_null() {
>> +            None
>> +        } else {
>> +            // SAFETY: By function safety requirement, val is non-null =
and
>> +            // null-terminated. By C API contract, `val` is live and va=
lid for
>> +            // reads for the duration of this function.
>> +            Some(unsafe { CStr::from_char_ptr(val).as_bytes() })
>> +        };
>> +        match Self::try_from_param_arg(arg) {
>> +            Some(new_value) =3D> {
>> +                // SAFETY: `param` is guaranteed to be valid by C API c=
ontract
>> +                // and `arg` is guaranteed to point to an instance of `=
Self`.
>> +                let old_value =3D unsafe { (*param).__bindgen_anon_1.ar=
g as *mut Self };
>> +                // SAFETY: `old_value` is valid for writes, as we have =
exclusive
>> +                // access. `old_value` is pointing to an initialized st=
atic, an
>> +                // so it is properly initialized.
>> +                let _ =3D unsafe { core::ptr::replace(old_value, new_va=
lue) };
>> +                0
>> +            }
>> +            None =3D> EINVAL.to_errno(),
>> +        }
>> +    }
>
> Do implementers need to override this function? If not, then I would
> move it out of the trait.

Ok, makes sense =F0=9F=91=8D

>
>> +
>> +    /// Write a string representation of the current parameter value to=
 `buf`.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// Must not be called.
>> +    ///
>> +    /// # Note
>> +    ///
>> +    /// This should not be called as we declare all parameters as read =
only.
>> +    unsafe extern "C" fn get_param(
>> +        _buf: *mut core::ffi::c_char,
>> +        _param: *const crate::bindings::kernel_param,
>> +    ) -> core::ffi::c_int {
>> +        0
>> +    }
>
> Ditto.

Ok.

>
>> +
>> +    /// Drop the parameter.
>> +    ///
>> +    /// Called when unloading a module.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// The `arg` field of `param` must be an initialized instance of `=
Self`.
>> +    unsafe extern "C" fn free(arg: *mut core::ffi::c_void) {
>> +        // SAFETY: By function safety requirement, `arg` is an initiali=
zed
>> +        // instance of `Self`. By C API contract, `arg` will not be use=
d after
>> +        // this function returns.
>> +        unsafe { core::ptr::drop_in_place(arg as *mut Self) };
>> +    }
>
> Ditto.

Ok.

>
>> +}
>
> [...]
>
>> diff --git a/rust/macros/helpers.rs b/rust/macros/helpers.rs
>> index 563dcd2b7ace..dc0b47879a8c 100644
>> --- a/rust/macros/helpers.rs
>> +++ b/rust/macros/helpers.rs
>> @@ -107,6 +107,14 @@ pub(crate) struct Generics {
>>      pub(crate) ty_generics: Vec<TokenTree>,
>>  }
>>=20
>> +pub(crate) fn get_string(it: &mut token_stream::IntoIter, expected_name=
: &str) -> String {
>
> This name is rather weird, `get_field` makes more sense IMO.

Looking at this, the `get` prefix is not aligned with other helpers. How
about `expect_string_field` ?

>
>> +    assert_eq!(expect_ident(it), expected_name);
>> +    assert_eq!(expect_punct(it), ':');
>> +    let string =3D expect_string(it);
>> +    assert_eq!(expect_punct(it), ',');
>
> Why do we require a trailing comma?

For consistency with existing module macro. All keys must be terminated
with comma.


[...]

>> +
>> +    fn emit_params(&mut self, info: &ModuleInfo) {
>
> This parses the parameters, but shouldn't that happen in
> `ModuleInfo::parse`? I agree that it should be a different function, but
> I don't think that we should store the params as a `Group` and fail when
> we emit the params.

I can move the parsing to the parsing stage =F0=9F=91=8D

>
>> +        if let Some(params) =3D &info.params {
>> +            assert_eq!(params.delimiter(), Delimiter::Brace);
>> +
>> +            let mut it =3D params.stream().into_iter();
>> +
>> +            loop {
>> +                let param_name =3D match it.next() {
>> +                    Some(TokenTree::Ident(ident)) =3D> ident.to_string(=
),
>> +                    Some(_) =3D> panic!("Expected Ident or end"),
>> +                    None =3D> break,
>> +                };
>> +
>> +                assert_eq!(expect_punct(&mut it), ':');
>> +                let param_type =3D expect_ident(&mut it);
>> +                let group =3D expect_group(&mut it);
>> +                assert_eq!(expect_punct(&mut it), ',');
>
> Why do we require a trailing comma?

For consistency.

>
>> +
>> +                assert_eq!(group.delimiter(), Delimiter::Brace);
>
> This check will should be immediately after expecting the group.=20

Yes.

>
>> +
>> +                let mut param_it =3D group.stream().into_iter();
>> +                let param_default =3D get_param_default(&mut param_it);
>
> I don't understand why this is put into its own (5 LOC) function and
> other parts of this function are not. If you can separate parsing from
> emitting better, this will probably improve.

It is an easy thing to break out and adding it back inline does not do
anything good IMO. Let's see how it looks when I separate parsing and
emitting.

>
>> +                let param_description =3D get_string(&mut param_it, "de=
scription");
>> +                expect_end(&mut param_it);
>> +
>> +                let (param_kernel_type, ops): (String, _) =3D (
>
> Why do you need to specify the type like this?

Legacy cruft. I will remove it.

>
>> +                    param_type.to_string(),
>> +                    param_ops_path(&param_type).to_string(),
>> +                );
>> +
>> +                self.emit_param("parmtype", &param_name, &param_kernel_=
type);
>
> Is the spelling intentional? "parmtype"?

This is intentional. I don't think the kernel is ever parsing this, but
it is parsed by the `modinfo` tool.

>
>> +                self.emit_param("parm", &param_name, &param_description=
);
>> +                let param_type_internal =3D param_type.clone();
>> +
>> +                let read_func =3D format!(
>> +                    "
>> +                        pub(crate) fn read(&self)
>> +                            -> &<{param_type_internal}
>> +                               as kernel::module_param::ModuleParam>::V=
alue {{
>
> Please add a `::` in front of `kernel::module_param::ModuleParam`. There
> are more instances below.

Thanks.

>
>> +                            // Note: when we enable r/w parameters, we =
need to lock here.
>> +
>> +                            // SAFETY: Parameters do not need to be loc=
ked because they are
>> +                            // read only or sysfs is not enabled.
>> +                            unsafe {{
>> +                                <{param_type_internal} as kernel::modul=
e_param::ModuleParam>::value(
>> +                                    &__{name}_{param_name}_value
>> +                                )
>> +                            }}
>> +                        }}
>> +                    ",
>> +                    name =3D info.name,
>> +                    param_name =3D param_name,
>> +                    param_type_internal =3D param_type_internal,
>> +                );
>> +
>> +                let kparam =3D format!(
>> +                    "
>> +                    kernel::bindings::kernel_param__bindgen_ty_1 {{
>> +                        // SAFETY: Access through the resulting pointer=
 is
>> +                        // serialized by C side and only happens before=
 module
>> +                        // `init` or after module `drop` is called.
>> +                        arg: unsafe {{ &__{name}_{param_name}_value }}
>> +                            as *const _ as *mut core::ffi::c_void,
>
> Here you should use `addr_of[_mut]!` instead of taking a reference.

This is a static initializer, so it would be evaluated in const context.
At that time, this is going to be the only reference to
`&__{name}_{param_name}_value` which would be const. So it should be
fine?

The safety comment is wrong though.

>Also
> will this pointer be used to write to the static, in that case you need
> `_mut!`.

Not in this version of the patch set, but potentially in future iterations.

>
>> +                    }},
>> +                ",
>> +                    name =3D info.name,
>> +                    param_name =3D param_name,
>> +                );
>
> What is the reason for putting `kparam` and `read_func` outside of the
> `write!` below? I think it would be easier to read if they are inlined.

It had different shapes based on other options in the original patch
set. I guess I can just inline it in this version.

>
>> +                write!(
>> +                    self.param_buffer,
>> +                    "
>> +                static mut __{name}_{param_name}_value: {param_type_int=
ernal} =3D {param_default};
>> +
>> +                pub(crate) struct __{name}_{param_name};
>> +
>> +                impl __{name}_{param_name} {{ {read_func} }}
>> +
>> +                pub(crate) const {param_name}: __{name}_{param_name} =
=3D __{name}_{param_name};
>
> Why do we need a unit struct as a constant? I think it would make more
> sense to have a unit struct/empty enum as the type and the `read`
> function be without a receiver.

To be able to call `module_parameters::my_parameter.read()`. Other
options would be `module_parameters::my_parameter::read()` or
`module_parameters::my_parameter_read()`.

I don't think there will be a difference in the generated machine code.
I also don't have any particular preference. Probably
`module_parameters::my_parameter::read()` is the most idiomatic one.

>
>> +
>> +                // Note: the C macro that generates the static structs =
for the `__param` section
>> +                // asks for them to be `aligned(sizeof(void *))`. Howev=
er, that was put in place
>> +                // in 2003 in commit 38d5b085d2a0 (\"[PATCH] Fix over-a=
lignment problem on x86-64\")
>> +                // to undo GCC over-alignment of static structs of >32 =
bytes. It seems that is
>> +                // not the case anymore, so we simplify to a transparen=
t representation here
>> +                // in the expectation that it is not needed anymore.
>> +                // TODO: Revisit this to confirm the above comment and =
remove it if it happened.
>
> Should this TODO be fixed before this is merged? Or do you intend for it
> to stay?
> If this is indeed correct, should this also be changed in the C side (of
> course a different patch)?

I dug into this. The original code in this patch must be quite old,
because that the code the comment refers to was changed in Nov 2020 from
`aligned(sizeof(void *))` to `__aligned(__alignof__(struct
kernel_param))`. The commit message says that the rationale for not
removing the alignment completely is to prevent the compiler from
increasing the alignment, as this would mess up the array stride used in
the `__param` section.

So I think we can remove the comment and keep `repr(transparent)`, right?
I think `rustc` would not increase the alignment of a `repr(C)` struct
for optimization purposes?

>
>> +                /// Newtype to make `bindings::kernel_param` `Sync`.
>> +                #[repr(transparent)]
>> +                struct __{name}_{param_name}_RacyKernelParam(kernel::bi=
ndings::kernel_param);
>> +
>> +                // SAFETY: C kernel handles serializing access to this =
type. We
>> +                // never access from Rust module.
>> +                unsafe impl Sync for __{name}_{param_name}_RacyKernelPa=
ram {{
>> +                }}
>
> Any reason to put the `}` on the next line?

No. Do you have any tricks for formatting multi line strings of code like t=
his?

>
>> +
>> +                #[cfg(not(MODULE))]
>> +                const __{name}_{param_name}_name: *const core::ffi::c_c=
har =3D
>> +                    b\"{name}.{param_name}\\0\" as *const _ as *const c=
ore::ffi::c_char;
>> +
>> +                #[cfg(MODULE)]
>> +                const __{name}_{param_name}_name: *const core::ffi::c_c=
har =3D
>> +                    b\"{param_name}\\0\" as *const _ as *const core::ff=
i::c_char;
>> +
>> +                #[link_section =3D \"__param\"]
>> +                #[used]
>> +                static __{name}_{param_name}_struct: __{name}_{param_na=
me}_RacyKernelParam =3D
>> +                    __{name}_{param_name}_RacyKernelParam(kernel::bindi=
ngs::kernel_param {{
>> +                        name: __{name}_{param_name}_name,
>> +                        // SAFETY: `__this_module` is constructed by th=
e kernel at load time
>> +                        // and will not be freed until the module is un=
loaded.
>> +                        #[cfg(MODULE)]
>> +                        mod_: unsafe {{ &kernel::bindings::__this_modul=
e as *const _ as *mut _ }},
>> +                        #[cfg(not(MODULE))]
>> +                        mod_: core::ptr::null_mut(),
>> +                        // SAFETY: This static is actually constant as =
seen by
>> +                        // module code. But we need a unique address fo=
r it, so it
>> +                        // must be static.
>
> This safety comment makes no sense, should it be a normal comment?

I removed the unsafe block and the safety comment as unsafe is not
required here.

>
>> +                        ops: unsafe {{ &{ops} }} as *const kernel::bind=
ings::kernel_param_ops,
>
> Why is this `unsafe` block needed, the `make_param_ops` macro declares a
> non-mut static.
>
>> +                        perm: 0, // Will not appear in sysfs
>> +                        level: -1,
>
> Why this value?

The kernel has 8 initcall levels. Parameters can be assigned one of
these levels to have the parameter initialized just before the init
functions for that level are executed. -1 has no effect for loadable module=
s, but
for built-in modules it looks like the args will be initialized just after =
early
boot args (level 0).

At any rate, this is what C side does.

>
>> +                        flags: 0,
>> +                        __bindgen_anon_1: {kparam}
>> +                    }});
>> +                ",
>> +                    name =3D info.name,
>> +                    param_type_internal =3D param_type_internal,
>> +                    read_func =3D read_func,
>> +                    param_default =3D param_default,
>> +                    param_name =3D param_name,
>> +                    ops =3D ops,
>> +                    kparam =3D kparam,
>> +                )
>> +                .unwrap();
>> +            }
>> +        }
>>      }
>>  }
>>=20
>> +fn param_ops_path(param_type: &str) -> &'static str {
>> +    match param_type {
>> +        "i8" =3D> "::kernel::module_param::PARAM_OPS_I8",
>> +        "u8" =3D> "::kernel::module_param::PARAM_OPS_U8",
>> +        "i16" =3D> "::kernel::module_param::PARAM_OPS_I16",
>> +        "u16" =3D> "::kernel::module_param::PARAM_OPS_U16",
>> +        "i32" =3D> "::kernel::module_param::PARAM_OPS_I32",
>> +        "u32" =3D> "::kernel::module_param::PARAM_OPS_U32",
>> +        "i64" =3D> "::kernel::module_param::PARAM_OPS_I64",
>> +        "u64" =3D> "::kernel::module_param::PARAM_OPS_U64",
>> +        "isize" =3D> "::kernel::module_param::PARAM_OPS_ISIZE",
>> +        "usize" =3D> "::kernel::module_param::PARAM_OPS_USIZE",
>> +        t =3D> panic!("Unrecognized type {}", t),
>
> I would write "Unsupported parameter type `{}`!".

Ok.

>
>> +    }
>> +}
>> +
>> +fn get_param_default(param_it: &mut token_stream::IntoIter) -> String {
>> +    assert_eq!(expect_ident(param_it), "default");
>> +    assert_eq!(expect_punct(param_it), ':');
>> +    let default =3D try_literal(param_it).expect("Expected default para=
m value");
>> +    assert_eq!(expect_punct(param_it), ',');
>> +    default
>> +}
>> +
>
> Could you also add documentation in rust/macros/lib.rs on the `module!`
> macro how parameters can be declared/used? I took a look and it seems
> that there is out-of-date docs there also.

Yes, will do. It looks like that documentation was actually never
correct in mainline.

Best regards,
Andreas



