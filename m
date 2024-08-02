Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9A71537DE
	for <linux-modules@vger.kernel.org>; Fri,  2 Aug 2024 17:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722618730; cv=none; b=kzYZR5GHge2cfebatlB4k+fz8EUoJeKmtlmVU/oJgdBQkHFSCUntyHlCg/cRfxJ38lWeJXdkhrt2ZOhecgokCW+b0mKNWnDkvjwcQG9qgTwIxiAyoSoLSjTK6P8p4x3I4iVS1w0kSckydam+bHnYETvoPJeSWTTMcpI8QKzm3Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722618730; c=relaxed/simple;
	bh=neWOr6PL+EwexsPE988GKl0O2GiEtFK9JOQq2p/0/Zc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T6wUlO227VV1T7SkS3Q1HqETe75mGmtVWtf80pI/WvSp60pjitKBPMCUwumBO5ctOlCQ8/VmOT3qU/jVpUPCXOVjPeMgp+LJ5FdjUAtRaXpLX5YZ8skrHaW9PfPi/b5Jas38shrQOpzWfXGN2XcTDvQOHQrO5E6rY/45LjsLF6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=G1W3TPfT; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="G1W3TPfT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722618720; x=1722877920;
	bh=umKgQ0P6J3fg5Wvduw8E/YyfxFZOHX6++WZeN01S7fo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=G1W3TPfTWtkPqf07ROxONPFUPs1cLs2kI5QKgpW1N+hujvSZIjumqEsePgaeUVW15
	 hk4FPlXdM2UbEDF0j/t9gCoOrTirOzpvMotsUk4Vz7Rn4ZxxYwawPih5CPU4CtXVLU
	 6MEM/OISkPDe3JhGY/SESyO38m2W89/U3K2n0/i6A0Lk763qy2hWKrP6m62tp90pFo
	 zrYLEEQGMJnXbkvkURoquhgifXS50i3x+AqNPUFYjFL/2Ktk3HBAva+VmegMZmXGIB
	 KONrvrzBoFkkgDp97KOxWyaQLNhWDI2gS8O2PeIlorIJbiI0ARVrFPgk/Z4Tiev8Iv
	 UPUMNNUTbTMOA==
Date: Fri, 02 Aug 2024 17:11:56 +0000
To: Andreas Hindborg <nmi@metaspace.dk>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@samsung.com>, Adam Bratschi-Kaye <ark.email@gmail.com>
Subject: Re: [PATCH] rust: add `module_params` macro
Message-ID: <a98ddf54-3e27-4587-8e49-f19dd1ac65a6@proton.me>
In-Reply-To: <87zfpvmd8y.fsf@metaspace.dk>
References: <20240705111455.142790-1-nmi@metaspace.dk> <2838cf2e-936c-45de-bb19-af9da66fbe00@proton.me> <87plqso50o.fsf@metaspace.dk> <49cad242-7a7c-4e9e-beb7-4f9c493ce794@proton.me> <878qxgnyzd.fsf@metaspace.dk> <ed2f7416-2631-411d-bb49-5a580dbf51b8@proton.me> <874j84nurn.fsf@metaspace.dk> <f84e9189-b64a-4761-86f5-ccd50fb62f36@proton.me> <87zfpvmd8y.fsf@metaspace.dk>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: ec4420c4da41491ad3c4a6322959121f662f9b9e
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02.08.24 12:27, Andreas Hindborg wrote:
> "Benno Lossin" <benno.lossin@proton.me> writes:
>> On 01.08.24 17:11, Andreas Hindborg wrote:
>>> "Benno Lossin" <benno.lossin@proton.me> writes:
>>>> On 01.08.24 15:40, Andreas Hindborg wrote:
>>>>> "Benno Lossin" <benno.lossin@proton.me> writes:
>>>>>> On 01.08.24 13:29, Andreas Hindborg wrote:
>>>>>>> "Benno Lossin" <benno.lossin@proton.me> writes:
>>>>>>>> On 05.07.24 13:15, Andreas Hindborg wrote:
>>>>>>>>> +
>>>>>>>>> +/// Types that can be used for module parameters.
>>>>>>>>> +///
>>>>>>>>> +/// Note that displaying the type in `sysfs` will fail if
>>>>>>>>> +/// [`core::str::from_utf8`] (as implemented through the [`core:=
:fmt::Display`]
>>>>>>>>> +/// trait) writes more than [`PAGE_SIZE`] bytes (including an ad=
ditional null
>>>>>>>>> +/// terminator).
>>>>>>>>> +///
>>>>>>>>> +/// [`PAGE_SIZE`]: `bindings::PAGE_SIZE`
>>>>>>>>> +pub trait ModuleParam: core::fmt::Display + core::marker::Sized =
{
>>>>>>>>> +    /// The `ModuleParam` will be used by the kernel module thro=
ugh this type.
>>>>>>>>> +    ///
>>>>>>>>> +    /// This may differ from `Self` if, for example, `Self` need=
s to track
>>>>>>>>> +    /// ownership without exposing it or allocate extra space fo=
r other possible
>>>>>>>>> +    /// parameter values. This is required to support string par=
ameters in the
>>>>>>>>> +    /// future.
>>>>>>>>> +    type Value: ?Sized;
>>>>>>>>> +
>>>>>>>>> +    /// Whether the parameter is allowed to be set without an ar=
gument.
>>>>>>>>> +    ///
>>>>>>>>> +    /// Setting this to `true` allows the parameter to be passed=
 without an
>>>>>>>>> +    /// argument (e.g. just `module.param` instead of `module.pa=
ram=3Dfoo`).
>>>>>>>>> +    const NOARG_ALLOWED: bool;
>>>>>>>>
>>>>>>>> I think, there is a better way of doing this. Instead of this bool=
, we
>>>>>>>> do the following:
>>>>>>>> 1. have a `const DEFAULT: Option<Self>`
>>>>>>>> 2. change the type of the argument of `try_from_param_arg` to
>>>>>>>>    `&'static [u8]`
>>>>>>>>
>>>>>>>> That way we don't have the weird behavior of `try_from_param_arg` =
that
>>>>>>>> for params that don't have a default value.
>>>>>>>
>>>>>>> Since we have no parameter types for which `NOARG_ALLOWED` is true =
in
>>>>>>> this patch set, it is effectively dead code. I will remove it.
>>>>>>
>>>>>> Hmm what parameters actually are optional? I looked at the old rust
>>>>>> branch and only `bool` is marked as optional. Are there others?
>>>>>>
>>>>>> If it is used commonly for custom parameters (I could imagine that R=
ust
>>>>>> modules have enums as parameters and specifying nothing could mean t=
he
>>>>>> default value), then it might be a good idea to just include it now.
>>>>>> (otherwise we might forget the design later)
>>>>>
>>>>> As far as I can tell from the C code, all parameters are able to have
>>>>> the `NOARG` flag set. We get a null pointer in the callback in that
>>>>> case.
>>>>>
>>>>> If we want to handle this now, we could drop the `default` field
>>>>> in the Rust module macro. There is no equivalent in the C macros.
>>>>> And then use an `Option<Option<_>>` to represent the value. `None` wo=
uld
>>>>> be an unset parameter. `Some(None)` would be a parameter without a
>>>>> value. `Some(Some(_))` would be a set parameter with a value. We coul=
d
>>>>> probably fix the types so that only parameters with the `NOARG` flag =
use
>>>>> the double option, others use a single option.
>>>>
>>>> What did you think of my approach that I detailed above? I would like =
to
>>>> avoid `Option<Option<_>>` if we can.
>>>
>>> How would you represent the case when the parameter is passed without a
>>> value and a default is given in `module!`?
>>
>> I am a bit confused, there are two default values here:
>> (1) the value returned by `try_from_param_arg(None)`.
>> (2) the value given by the user to the `module!` macro.
>>
>> I am talking about changing the definition of ModuleParam, so (1). I get
>> the feeling that you are talking about (2), is that correct?
>=20
> I confused myself as well I think. I am talking about (1). Let me try
> again.
>=20
> If we support `NOARG_ALLOWED` (`KERNEL_PARAM_OPS_FL_NOARG` in C. I
> should change the flag name in Rust), modules can optionally support
> some parameters where users can pass parameters either as
> `my_module.param=3Dvalue` or `my_module.param`. Thus, at the level of
> `try_from_param_arg`, we need to represent two cases: parameter passed
> without value, and parameter passed with value. A third case, parameter
> not passed at all, is equivalent to `try_from_param_arg` never being
> called. In C this is undetectable for the predefined parameter types. I
> wanted the double option to detect this. But I guess it does not make
> sense.

My idea was to have an `const DEFAULT: Option<Self>` to represent the
following:
(1) if `DEFAULT =3D=3D None`, then `KERNEL_PARAM_OPS_FL_NOARG` is not set
    and thus either the `module!` user-specified default value is used,
    or it is specified via `my_module.param=3Dvalue` and
    `try_from_param_arg` is called.
(2) if `DEFAULT =3D=3D Some(d)`, then `KERNEL_PARAM_OPS_FL_NOARG` is set an=
d
    when `NULL` is given to `kernel_param_ops.set`, the parameter value
    is set to `d`, otherwise `try_from_param_arg` is called.

But I think I agree with you removing `NOARG_ALLOWED`, see below.

> At a higher level where the bindings supply the parsing functions, we
> can decide that passing an argument without a value yields a default
> parameter value. C does this for the predefined `bool` type. The
> predefined integer types does not support omitting the value.
>
> This patch only supports the higher level predefined parameter types,
> and does not allow modules to supply their own parameter parsing
> functions. None of the types we implement in this patch support passing
> the argument without a value. This is intentional to mirror the C
> implementation.
>=20
> To that end, I removed `NOARG_ALLOWED`, and changed the parsing function
> trait to:
>=20
>     fn try_from_param_arg(arg: &'static [u8]) -> Result<Self>;
>=20
> If/when we start supporting types like `bool` or custom parsing
> functions provided by the module, we will have to update the signature
> to take an `Option` to represent the case where the user passed an
> argument without a value. However, to mimic C, the function must always
> return a value if successful, even if the user did not supply a value to
> the argument.
>=20
> Two different default values are in flight here. 1) the value that the
> parameter will have before the kernel calls `try_from_param_arg` via
> `set_param` and 2) the value to return from `try_from_param_arg` if the
> user did not pass a value with the argument.
>=20
> For a `bool` 1) would usually be `false` and 2) would always be `true`.
>=20
> For predefined types the module would not customize 2), but 1) is useful
> to customize. For custom types where the module supplies the parsing
> function, 2) would be implicitly given by the module in the parsing
> function.
>=20
> In this patch set, we only have 1 default value, namely 1). We do not
> need 2) because we do not support parameters without values.

I am not sure that putting the default value of `my_module.param` into
the `ModuleParam` trait is a good idea. It feels more correct to me to
add an optional field to the part in `module!` that can be set to denote
this default value -- we might also want to change the name of
`default`, what do you think of `default_inactive` and `default_active`?

Since one might want an option by default be `true` and when one writes
`my_module.param`, it should be `false`.
Also as the C side shows, having default values for integer types is not
really a good idea, since you might want a non-zero default value.
If one does not specify the `default_active` value, then the
`KERNEL_PARAM_OPS_FL_NOARG` is not set.

If you don't want to implement this (which I can fully understand, since
we might get `syn` before anyone needs params with default values), then
we should write this idea down (maybe in an issue?). But regardless, I
would like to know your opinion on this topic.

>>> I think we need to drop the default value if we adopt the arg without
>>> value scheme.
>>
>> Yes definitely. I don't see anything in the code doing this currently,
>> right?
>=20
> The current patch uses the default value given in the `module!` macro to
> initialize the parameter value.

But what drops the default value, when an actual value is specified via
`my_module.param=3Dvalue`? (or is the default value only assigned when
nothing is specified?)

>> We could also only allow `Copy` values to be used as Parameters (but
>> then `str` cannot be used as a parameter...), since they can't implement
>> `Drop`.
>=20
> We should plan on eventually supporting `String`.

Yes.

>>>>> Or we could just not adopt this feature in the Rust abstractions.
>>>>
>>>> Depends on how common this is and if people need to use it. I think th=
at
>>>> what I proposed above isn't that complex, so it should be easy to
>>>> implement.
>>>
>>> Rust modules would just force people to add "my_module.param=3D1" inste=
ad
>>> of just "my_module.param". I think that is reasonable.
>>
>> Eh, why do we want to give that up? I don't think it's difficult to do.
>=20
> I just don't see the point. Just have the user pass `my_module.param=3D1`
> instead of omitting the value. Having multiple ways of specifying for
> instance a true boolean just leads to confusion. Some boolean parameters
> have a default value of `true`, for instance `nvme.use_cmb_sqes`. In
> this case specifying `nvme.use_cmb_sqes` has no effect, even though one
> might think it has.

This just shows to me that a "global" default in `ModuleParam` is wrong,
since for `use_cmb_sqes` one could either have a negated flag, or no
default value, forcing the user to write `nvme.use_cmb_sqes=3Dfalse`.

> Of course, if we are going to do things the same as C, we have to
> support it.

I think eventually this will be useful, but as you said it's not a
feature that you *need*.

>>>>>>>>> +                            // Note: when we enable r/w paramete=
rs, we need to lock here.
>>>>>>>>> +
>>>>>>>>> +                            // SAFETY: Parameters do not need to=
 be locked because they are
>>>>>>>>> +                            // read only or sysfs is not enabled=
.
>>>>>>>>> +                            unsafe {{
>>>>>>>>> +                                <{param_type_internal} as kernel=
::module_param::ModuleParam>::value(
>>>>>>>>> +                                    &__{name}_{param_name}_value
>>>>>>>>> +                                )
>>>>>>>>> +                            }}
>>>>>>>>> +                        }}
>>>>>>>>> +                    ",
>>>>>>>>> +                    name =3D info.name,
>>>>>>>>> +                    param_name =3D param_name,
>>>>>>>>> +                    param_type_internal =3D param_type_internal,
>>>>>>>>> +                );
>>>>>>>>> +
>>>>>>>>> +                let kparam =3D format!(
>>>>>>>>> +                    "
>>>>>>>>> +                    kernel::bindings::kernel_param__bindgen_ty_1=
 {{
>>>>>>>>> +                        // SAFETY: Access through the resulting =
pointer is
>>>>>>>>> +                        // serialized by C side and only happens=
 before module
>>>>>>>>> +                        // `init` or after module `drop` is call=
ed.
>>>>>>>>> +                        arg: unsafe {{ &__{name}_{param_name}_va=
lue }}
>>>>>>>>> +                            as *const _ as *mut core::ffi::c_voi=
d,
>>>>>>>>
>>>>>>>> Here you should use `addr_of[_mut]!` instead of taking a reference=
.
>>>>>>>
>>>>>>> This is a static initializer, so it would be evaluated in const con=
text.
>>>>>>> At that time, this is going to be the only reference to
>>>>>>> `&__{name}_{param_name}_value` which would be const. So it should b=
e
>>>>>>> fine?
>>>>>>
>>>>>> When compiling this [1] with a sufficiently new Rust version, you wi=
ll
>>>>>> get an error:
>>>>>>
>>>>>>     warning: creating a shared reference to mutable static is discou=
raged
>>>>>>      --> src/main.rs:4:22
>>>>>>       |
>>>>>>     4 |     let x =3D unsafe { &foo };
>>>>>>       |                      ^^^^ shared reference to mutable static
>>>>>>       |
>>>>>>       =3D note: for more information, see issue #114447 <https://git=
hub.com/rust-lang/rust/issues/114447>
>>>>>>       =3D note: this will be a hard error in the 2024 edition
>>>>>>       =3D note: this shared reference has lifetime `'static`, but if=
 the static ever gets mutated, or a mutable reference is created, then any =
further use of this shared reference is Undefined Behavior
>>>>>>       =3D note: `#[warn(static_mut_refs)]` on by default
>>>>>>     help: use `addr_of!` instead to create a raw pointer
>>>>>>       |
>>>>>>     4 |     let x =3D unsafe { addr_of!(foo) };
>>>>>>       |                      ~~~~~~~~~~~~~
>>>>>>
>>>>>> [1]: https://play.rust-lang.org/?version=3Dstable&mode=3Ddebug&editi=
on=3D2021&gist=3Dc914a438938be6f5fc643ee277efa1d1
>>>>>>
>>>>>> So I think we should start using `addr_of!` for mutable static now.
>>>>>
>>>>> Oh. Thanks for the pointer.
>>>>>
>>>>> Hmm, `addr_of_mut!` still requires the unsafe block. Hopefully that g=
oes
>>>>> away as well with the feature you linked as well.
>>>>
>>>> I think that will take some time until it is gone.
>>>>
>>>>> This also requires `const_mut_refs`, but as I recall that is going to=
 be
>>>>> stabilized soon.
>>>>
>>>> That should only be needed if you need `addr_of_mut!`, but IIUC, you
>>>> only need `addr_of!`, right?
>>>
>>> The pointer we create here is the one passed to `free` in
>>> module_param.rs, so it will eventually be used as `&mut T`.
>>
>> Oh then the original code is definitely wrong, since it creates a shared
>> reference. Yeah then you should use `addr_of_mut!`.
>=20
> Right. I agree the right thing is to change to `addr_of_mut!`. But I am
> curious. If the original code was
>=20
> ```rust
> arg: unsafe {{ &mut __{name}_{param_name}_value }} as *mut _ as *mut ::co=
re::ffi::c_void,
> ```
>=20
> Then it would be fine? Because we have the only mutable reference in
> existence when the code is evaluated.

That *might* be fine, but I don't know if there is anything that would
guarantee you that it is. Note that the code above uses a shared
reference, which definitely isn't OK.

---
Cheers,
Benno

