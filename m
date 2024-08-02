Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EEE1DC48E;
	Fri,  2 Aug 2024 10:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722594446; cv=none; b=Zk9U3D+wlKl+hXnaMUMAVI590LzgSgFHKv+PFMFJ+8fMLuYQhlthvP9ItLTWS4QjwgbKtKXRkGP4w9KBs/E0M5zi6yXvOilo5PEuKwZYc4H0xgaPXSyioF9qCkEhF80JyEF5aN4AAHyCnkjWdO7w3az60+Jq5TnJkW8T0uL0gFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722594446; c=relaxed/simple;
	bh=ZJ1v5lXpqVSV2BqvUcjgjhkZpNzFxy4H6afhN8G7fdk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L72B6SVDoyK7JjF6mYsD1OjZdMlDQtFaqUrY4UMx/3UbWs8t9t6TjaRdS/fZ3sVncTJ58x/+IJ0Z/vjrmisuOMXeSJqLdjtyRF5Rf+cSOIoM3AcXVRz2xDk3Xa4huf96K1S7THjdBjDETG6fkOnpW9akX4FTB/viG6DER264d8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=metaspace.dk; spf=pass smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace.dk header.i=@metaspace.dk header.b=HOZ5vCIC; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace.dk header.i=@metaspace.dk header.b="HOZ5vCIC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=metaspace.dk;
	s=protonmail; t=1722594433; x=1722853633;
	bh=n4q6Mf5FhYPzxJqH5t1sA+KJXOLip4OsfCIIEgFgWHQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=HOZ5vCIC4SLyjbWm5d3zQgQi0o2xVvLBLgTQ6CV+6Jc4zSV8gauGhTRtIKQicSQ97
	 VkXedo/dlavY19J0xOJnSq3H/yHcKCqP5KsDSMnBqMOvj9flG4FCYvA13FPDkoKe7n
	 V/YZ4ttqw4hIGwV6UU2rDlTq9Y1zSaYib/1PrF7wUgCQF7SFQt1HTHsoQ4dGv4TA67
	 upzftjbBAhBo5KyTGAb0JbUYGEkrbgfYMCrp8NoOikkg97dukzBoGJ60WfFtBtQRx+
	 vVoI5jGVYD3PiKsytlY4VceKoWvOJ2uh+KPQhiIMc7dU4vQjr+70OGH0g57BazwwST
	 qIrY7PajuyMtA==
Date: Fri, 02 Aug 2024 10:27:07 +0000
To: Benno Lossin <benno.lossin@proton.me>
From: Andreas Hindborg <nmi@metaspace.dk>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@samsung.com>, Adam Bratschi-Kaye <ark.email@gmail.com>
Subject: Re: [PATCH] rust: add `module_params` macro
Message-ID: <87zfpvmd8y.fsf@metaspace.dk>
In-Reply-To: <f84e9189-b64a-4761-86f5-ccd50fb62f36@proton.me>
References: <20240705111455.142790-1-nmi@metaspace.dk> <2838cf2e-936c-45de-bb19-af9da66fbe00@proton.me> <87plqso50o.fsf@metaspace.dk> <49cad242-7a7c-4e9e-beb7-4f9c493ce794@proton.me> <878qxgnyzd.fsf@metaspace.dk> <ed2f7416-2631-411d-bb49-5a580dbf51b8@proton.me> <874j84nurn.fsf@metaspace.dk> <f84e9189-b64a-4761-86f5-ccd50fb62f36@proton.me>
Feedback-ID: 113830118:user:proton
X-Pm-Message-ID: a0964ea08d15e0f9618dac6e05f05e1178f2b443
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Benno Lossin" <benno.lossin@proton.me> writes:

> On 01.08.24 17:11, Andreas Hindborg wrote:
>> "Benno Lossin" <benno.lossin@proton.me> writes:
>>> On 01.08.24 15:40, Andreas Hindborg wrote:
>>>> "Benno Lossin" <benno.lossin@proton.me> writes:
>>>>> On 01.08.24 13:29, Andreas Hindborg wrote:
>>>>>> "Benno Lossin" <benno.lossin@proton.me> writes:
>>>>>>> On 05.07.24 13:15, Andreas Hindborg wrote:
>>>>>>>> +
>>>>>>>> +/// Types that can be used for module parameters.
>>>>>>>> +///
>>>>>>>> +/// Note that displaying the type in `sysfs` will fail if
>>>>>>>> +/// [`core::str::from_utf8`] (as implemented through the [`core::=
fmt::Display`]
>>>>>>>> +/// trait) writes more than [`PAGE_SIZE`] bytes (including an add=
itional null
>>>>>>>> +/// terminator).
>>>>>>>> +///
>>>>>>>> +/// [`PAGE_SIZE`]: `bindings::PAGE_SIZE`
>>>>>>>> +pub trait ModuleParam: core::fmt::Display + core::marker::Sized {
>>>>>>>> +    /// The `ModuleParam` will be used by the kernel module throu=
gh this type.
>>>>>>>> +    ///
>>>>>>>> +    /// This may differ from `Self` if, for example, `Self` needs=
 to track
>>>>>>>> +    /// ownership without exposing it or allocate extra space for=
 other possible
>>>>>>>> +    /// parameter values. This is required to support string para=
meters in the
>>>>>>>> +    /// future.
>>>>>>>> +    type Value: ?Sized;
>>>>>>>> +
>>>>>>>> +    /// Whether the parameter is allowed to be set without an arg=
ument.
>>>>>>>> +    ///
>>>>>>>> +    /// Setting this to `true` allows the parameter to be passed =
without an
>>>>>>>> +    /// argument (e.g. just `module.param` instead of `module.par=
am=3Dfoo`).
>>>>>>>> +    const NOARG_ALLOWED: bool;
>>>>>>>
>>>>>>> I think, there is a better way of doing this. Instead of this bool,=
 we
>>>>>>> do the following:
>>>>>>> 1. have a `const DEFAULT: Option<Self>`
>>>>>>> 2. change the type of the argument of `try_from_param_arg` to
>>>>>>>    `&'static [u8]`
>>>>>>>
>>>>>>> That way we don't have the weird behavior of `try_from_param_arg` t=
hat
>>>>>>> for params that don't have a default value.
>>>>>>
>>>>>> Since we have no parameter types for which `NOARG_ALLOWED` is true i=
n
>>>>>> this patch set, it is effectively dead code. I will remove it.
>>>>>
>>>>> Hmm what parameters actually are optional? I looked at the old rust
>>>>> branch and only `bool` is marked as optional. Are there others?
>>>>>
>>>>> If it is used commonly for custom parameters (I could imagine that Ru=
st
>>>>> modules have enums as parameters and specifying nothing could mean th=
e
>>>>> default value), then it might be a good idea to just include it now.
>>>>> (otherwise we might forget the design later)
>>>>
>>>> As far as I can tell from the C code, all parameters are able to have
>>>> the `NOARG` flag set. We get a null pointer in the callback in that
>>>> case.
>>>>
>>>> If we want to handle this now, we could drop the `default` field
>>>> in the Rust module macro. There is no equivalent in the C macros.
>>>> And then use an `Option<Option<_>>` to represent the value. `None` wou=
ld
>>>> be an unset parameter. `Some(None)` would be a parameter without a
>>>> value. `Some(Some(_))` would be a set parameter with a value. We could
>>>> probably fix the types so that only parameters with the `NOARG` flag u=
se
>>>> the double option, others use a single option.
>>>
>>> What did you think of my approach that I detailed above? I would like t=
o
>>> avoid `Option<Option<_>>` if we can.
>>=20
>> How would you represent the case when the parameter is passed without a
>> value and a default is given in `module!`?
>
> I am a bit confused, there are two default values here:
> (1) the value returned by `try_from_param_arg(None)`.
> (2) the value given by the user to the `module!` macro.
>
> I am talking about changing the definition of ModuleParam, so (1). I get
> the feeling that you are talking about (2), is that correct?

I confused myself as well I think. I am talking about (1). Let me try
again.

If we support `NOARG_ALLOWED` (`KERNEL_PARAM_OPS_FL_NOARG` in C. I
should change the flag name in Rust), modules can optionally support
some parameters where users can pass parameters either as
`my_module.param=3Dvalue` or `my_module.param`. Thus, at the level of
`try_from_param_arg`, we need to represent two cases: parameter passed
without value, and parameter passed with value. A third case, parameter
not passed at all, is equivalent to `try_from_param_arg` never being
called. In C this is undetectable for the predefined parameter types. I
wanted the double option to detect this. But I guess it does not make
sense.

At a higher level where the bindings supply the parsing functions, we
can decide that passing an argument without a value yields a default
parameter value. C does this for the predefined `bool` type. The
predefined integer types does not support omitting the value.

This patch only supports the higher level predefined parameter types,
and does not allow modules to supply their own parameter parsing
functions. None of the types we implement in this patch support passing
the argument without a value. This is intentional to mirror the C
implementation.

To that end, I removed `NOARG_ALLOWED`, and changed the parsing function
trait to:

    fn try_from_param_arg(arg: &'static [u8]) -> Result<Self>;

If/when we start supporting types like `bool` or custom parsing
functions provided by the module, we will have to update the signature
to take an `Option` to represent the case where the user passed an
argument without a value. However, to mimic C, the function must always
return a value if successful, even if the user did not supply a value to
the argument.

Two different default values are in flight here. 1) the value that the
parameter will have before the kernel calls `try_from_param_arg` via
`set_param` and 2) the value to return from `try_from_param_arg` if the
user did not pass a value with the argument.

For a `bool` 1) would usually be `false` and 2) would always be `true`.

For predefined types the module would not customize 2), but 1) is useful
to customize. For custom types where the module supplies the parsing
function, 2) would be implicitly given by the module in the parsing
function.

In this patch set, we only have 1 default value, namely 1). We do not
need 2) because we do not support parameters without values.

>
>> I think we need to drop the default value if we adopt the arg without
>> value scheme.
>
> Yes definitely. I don't see anything in the code doing this currently,
> right?

The current patch uses the default value given in the `module!` macro to
initialize the parameter value.

> We could also only allow `Copy` values to be used as Parameters (but
> then `str` cannot be used as a parameter...), since they can't implement
> `Drop`.

We should plan on eventually supporting `String`.

>
>>>> Or we could just not adopt this feature in the Rust abstractions.
>>>
>>> Depends on how common this is and if people need to use it. I think tha=
t
>>> what I proposed above isn't that complex, so it should be easy to
>>> implement.
>>=20
>> Rust modules would just force people to add "my_module.param=3D1" instea=
d
>> of just "my_module.param". I think that is reasonable.
>
> Eh, why do we want to give that up? I don't think it's difficult to do.

I just don't see the point. Just have the user pass `my_module.param=3D1`
instead of omitting the value. Having multiple ways of specifying for
instance a true boolean just leads to confusion. Some boolean parameters
have a default value of `true`, for instance `nvme.use_cmb_sqes`. In
this case specifying `nvme.use_cmb_sqes` has no effect, even though one
might think it has.

Of course, if we are going to do things the same as C, we have to
support it.

>
>>>>>>>> +                            // Note: when we enable r/w parameter=
s, we need to lock here.
>>>>>>>> +
>>>>>>>> +                            // SAFETY: Parameters do not need to =
be locked because they are
>>>>>>>> +                            // read only or sysfs is not enabled.
>>>>>>>> +                            unsafe {{
>>>>>>>> +                                <{param_type_internal} as kernel:=
:module_param::ModuleParam>::value(
>>>>>>>> +                                    &__{name}_{param_name}_value
>>>>>>>> +                                )
>>>>>>>> +                            }}
>>>>>>>> +                        }}
>>>>>>>> +                    ",
>>>>>>>> +                    name =3D info.name,
>>>>>>>> +                    param_name =3D param_name,
>>>>>>>> +                    param_type_internal =3D param_type_internal,
>>>>>>>> +                );
>>>>>>>> +
>>>>>>>> +                let kparam =3D format!(
>>>>>>>> +                    "
>>>>>>>> +                    kernel::bindings::kernel_param__bindgen_ty_1 =
{{
>>>>>>>> +                        // SAFETY: Access through the resulting p=
ointer is
>>>>>>>> +                        // serialized by C side and only happens =
before module
>>>>>>>> +                        // `init` or after module `drop` is calle=
d.
>>>>>>>> +                        arg: unsafe {{ &__{name}_{param_name}_val=
ue }}
>>>>>>>> +                            as *const _ as *mut core::ffi::c_void=
,
>>>>>>>
>>>>>>> Here you should use `addr_of[_mut]!` instead of taking a reference.
>>>>>>
>>>>>> This is a static initializer, so it would be evaluated in const cont=
ext.
>>>>>> At that time, this is going to be the only reference to
>>>>>> `&__{name}_{param_name}_value` which would be const. So it should be
>>>>>> fine?
>>>>>
>>>>> When compiling this [1] with a sufficiently new Rust version, you wil=
l
>>>>> get an error:
>>>>>
>>>>>     warning: creating a shared reference to mutable static is discour=
aged
>>>>>      --> src/main.rs:4:22
>>>>>       |
>>>>>     4 |     let x =3D unsafe { &foo };
>>>>>       |                      ^^^^ shared reference to mutable static
>>>>>       |
>>>>>       =3D note: for more information, see issue #114447 <https://gith=
ub.com/rust-lang/rust/issues/114447>
>>>>>       =3D note: this will be a hard error in the 2024 edition
>>>>>       =3D note: this shared reference has lifetime `'static`, but if =
the static ever gets mutated, or a mutable reference is created, then any f=
urther use of this shared reference is Undefined Behavior
>>>>>       =3D note: `#[warn(static_mut_refs)]` on by default
>>>>>     help: use `addr_of!` instead to create a raw pointer
>>>>>       |
>>>>>     4 |     let x =3D unsafe { addr_of!(foo) };
>>>>>       |                      ~~~~~~~~~~~~~
>>>>>
>>>>> [1]: https://play.rust-lang.org/?version=3Dstable&mode=3Ddebug&editio=
n=3D2021&gist=3Dc914a438938be6f5fc643ee277efa1d1
>>>>>
>>>>> So I think we should start using `addr_of!` for mutable static now.
>>>>
>>>> Oh. Thanks for the pointer.
>>>>
>>>> Hmm, `addr_of_mut!` still requires the unsafe block. Hopefully that go=
es
>>>> away as well with the feature you linked as well.
>>>
>>> I think that will take some time until it is gone.
>>>
>>>> This also requires `const_mut_refs`, but as I recall that is going to =
be
>>>> stabilized soon.
>>>
>>> That should only be needed if you need `addr_of_mut!`, but IIUC, you
>>> only need `addr_of!`, right?
>>=20
>> The pointer we create here is the one passed to `free` in
>> module_param.rs, so it will eventually be used as `&mut T`.
>
> Oh then the original code is definitely wrong, since it creates a shared
> reference. Yeah then you should use `addr_of_mut!`.

Right. I agree the right thing is to change to `addr_of_mut!`. But I am
curious. If the original code was

```rust
arg: unsafe {{ &mut __{name}_{param_name}_value }} as *mut _ as *mut ::core=
::ffi::c_void,
```

Then it would be fine? Because we have the only mutable reference in
existence when the code is evaluated.


Best regards,
Andreas


