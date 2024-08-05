Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C336155398
	for <linux-modules@vger.kernel.org>; Mon,  5 Aug 2024 10:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722855352; cv=none; b=HSLzURcthYn5uQYDoL2QizEFp8Btmnfp0hpGazdNZu0bP481T3+o1Rcrhu1qM7dk2Gyh5iHaYh7ajvJlyqx2iKyXP9/Ab1JxMM3bkrSHloCy0UsAbTN2OyAqgnN+Uhn4t9Bj2Ufu3cn4omfle0HQKAJVQzze4KCPiEeM1EKH700=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722855352; c=relaxed/simple;
	bh=SMqWOmgw/UDQXI2Viucl1TGtgCXgecBTRV2zcND0Ov8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S69Lpvk6eUm0DRdOob0S/VMF4oHpIY0Ph642dkzXpC2dO9POkNZuL0l5Azi883auTpz4NfwdbVCbQySZIXEpPfojeZscZ51nCsMwEhL2duY5yttU6YF+AcIWZg2pDNIhlHvXOO7z5XX72e7Aydx9UqrEjEPqU14vhRjmd0lcpYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=metaspace.dk; spf=pass smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace.dk header.i=@metaspace.dk header.b=TTxeSwXJ; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace.dk header.i=@metaspace.dk header.b="TTxeSwXJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=metaspace.dk;
	s=protonmail; t=1722855334; x=1723114534;
	bh=OTPTbzBzU9Sc0BiNhZFoNYMGQYF2LvoMfWD2omsoqAg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=TTxeSwXJRvVzr4Y7TaLQD7Nltz7GhDPQJ880OD+5JdUj9HImzZPe8S8Vz2mYnbWdo
	 6vS2LibQfVfaK5hQ33WPZXu8n/yWtWWwEXQogSH8cKGME1kEDHH8mrzwkEBcsYGRbw
	 0iE/emOgj/FmaFsvMQo6St71KdFYWFlBmaPtUtLa/zlJMhTeF+IEs5MPwDVSnRHOL6
	 z+e+UpliZPsY5pqZhvI3v5sTmZTzPT3RFjvHticaiEwN81v6aUbtq5CX6y5ar4svyl
	 pWXp6EFrp7QrHNVtJexVBVQqCff/6rLHpknTfeV6qhqqHRZ6T6bhJ65HzRMQ4KdBqe
	 p6FtoWBioujtQ==
Date: Mon, 05 Aug 2024 10:55:27 +0000
To: Benno Lossin <benno.lossin@proton.me>
From: Andreas Hindborg <nmi@metaspace.dk>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@samsung.com>, Adam Bratschi-Kaye <ark.email@gmail.com>
Subject: Re: [PATCH] rust: add `module_params` macro
Message-ID: <87v80fme7g.fsf@metaspace.dk>
In-Reply-To: <a98ddf54-3e27-4587-8e49-f19dd1ac65a6@proton.me>
References: <20240705111455.142790-1-nmi@metaspace.dk> <2838cf2e-936c-45de-bb19-af9da66fbe00@proton.me> <87plqso50o.fsf@metaspace.dk> <49cad242-7a7c-4e9e-beb7-4f9c493ce794@proton.me> <878qxgnyzd.fsf@metaspace.dk> <ed2f7416-2631-411d-bb49-5a580dbf51b8@proton.me> <874j84nurn.fsf@metaspace.dk> <f84e9189-b64a-4761-86f5-ccd50fb62f36@proton.me> <87zfpvmd8y.fsf@metaspace.dk> <a98ddf54-3e27-4587-8e49-f19dd1ac65a6@proton.me>
Feedback-ID: 113830118:user:proton
X-Pm-Message-ID: 080071366be32d61e8165c71df79521035cb1d27
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Benno Lossin" <benno.lossin@proton.me> writes:

> On 02.08.24 12:27, Andreas Hindborg wrote:
>> "Benno Lossin" <benno.lossin@proton.me> writes:
>>> On 01.08.24 17:11, Andreas Hindborg wrote:
>>>> "Benno Lossin" <benno.lossin@proton.me> writes:
>>>>> On 01.08.24 15:40, Andreas Hindborg wrote:
>>>>>> "Benno Lossin" <benno.lossin@proton.me> writes:
>>>>>>> On 01.08.24 13:29, Andreas Hindborg wrote:
>>>>>>>> "Benno Lossin" <benno.lossin@proton.me> writes:
>>>>>>>>> On 05.07.24 13:15, Andreas Hindborg wrote:
>>>>>>>>>> +
>>>>>>>>>> +/// Types that can be used for module parameters.
>>>>>>>>>> +///
>>>>>>>>>> +/// Note that displaying the type in `sysfs` will fail if
>>>>>>>>>> +/// [`core::str::from_utf8`] (as implemented through the [`core=
::fmt::Display`]
>>>>>>>>>> +/// trait) writes more than [`PAGE_SIZE`] bytes (including an a=
dditional null
>>>>>>>>>> +/// terminator).
>>>>>>>>>> +///
>>>>>>>>>> +/// [`PAGE_SIZE`]: `bindings::PAGE_SIZE`
>>>>>>>>>> +pub trait ModuleParam: core::fmt::Display + core::marker::Sized=
 {
>>>>>>>>>> +    /// The `ModuleParam` will be used by the kernel module thr=
ough this type.
>>>>>>>>>> +    ///
>>>>>>>>>> +    /// This may differ from `Self` if, for example, `Self` nee=
ds to track
>>>>>>>>>> +    /// ownership without exposing it or allocate extra space f=
or other possible
>>>>>>>>>> +    /// parameter values. This is required to support string pa=
rameters in the
>>>>>>>>>> +    /// future.
>>>>>>>>>> +    type Value: ?Sized;
>>>>>>>>>> +
>>>>>>>>>> +    /// Whether the parameter is allowed to be set without an a=
rgument.
>>>>>>>>>> +    ///
>>>>>>>>>> +    /// Setting this to `true` allows the parameter to be passe=
d without an
>>>>>>>>>> +    /// argument (e.g. just `module.param` instead of `module.p=
aram=3Dfoo`).
>>>>>>>>>> +    const NOARG_ALLOWED: bool;
>>>>>>>>>
>>>>>>>>> I think, there is a better way of doing this. Instead of this boo=
l, we
>>>>>>>>> do the following:
>>>>>>>>> 1. have a `const DEFAULT: Option<Self>`
>>>>>>>>> 2. change the type of the argument of `try_from_param_arg` to
>>>>>>>>>    `&'static [u8]`
>>>>>>>>>
>>>>>>>>> That way we don't have the weird behavior of `try_from_param_arg`=
 that
>>>>>>>>> for params that don't have a default value.
>>>>>>>>
>>>>>>>> Since we have no parameter types for which `NOARG_ALLOWED` is true=
 in
>>>>>>>> this patch set, it is effectively dead code. I will remove it.
>>>>>>>
>>>>>>> Hmm what parameters actually are optional? I looked at the old rust
>>>>>>> branch and only `bool` is marked as optional. Are there others?
>>>>>>>
>>>>>>> If it is used commonly for custom parameters (I could imagine that =
Rust
>>>>>>> modules have enums as parameters and specifying nothing could mean =
the
>>>>>>> default value), then it might be a good idea to just include it now=
.
>>>>>>> (otherwise we might forget the design later)
>>>>>>
>>>>>> As far as I can tell from the C code, all parameters are able to hav=
e
>>>>>> the `NOARG` flag set. We get a null pointer in the callback in that
>>>>>> case.
>>>>>>
>>>>>> If we want to handle this now, we could drop the `default` field
>>>>>> in the Rust module macro. There is no equivalent in the C macros.
>>>>>> And then use an `Option<Option<_>>` to represent the value. `None` w=
ould
>>>>>> be an unset parameter. `Some(None)` would be a parameter without a
>>>>>> value. `Some(Some(_))` would be a set parameter with a value. We cou=
ld
>>>>>> probably fix the types so that only parameters with the `NOARG` flag=
 use
>>>>>> the double option, others use a single option.
>>>>>
>>>>> What did you think of my approach that I detailed above? I would like=
 to
>>>>> avoid `Option<Option<_>>` if we can.
>>>>
>>>> How would you represent the case when the parameter is passed without =
a
>>>> value and a default is given in `module!`?
>>>
>>> I am a bit confused, there are two default values here:
>>> (1) the value returned by `try_from_param_arg(None)`.
>>> (2) the value given by the user to the `module!` macro.
>>>
>>> I am talking about changing the definition of ModuleParam, so (1). I ge=
t
>>> the feeling that you are talking about (2), is that correct?
>>=20
>> I confused myself as well I think. I am talking about (1). Let me try
>> again.
>>=20
>> If we support `NOARG_ALLOWED` (`KERNEL_PARAM_OPS_FL_NOARG` in C. I
>> should change the flag name in Rust), modules can optionally support
>> some parameters where users can pass parameters either as
>> `my_module.param=3Dvalue` or `my_module.param`. Thus, at the level of
>> `try_from_param_arg`, we need to represent two cases: parameter passed
>> without value, and parameter passed with value. A third case, parameter
>> not passed at all, is equivalent to `try_from_param_arg` never being
>> called. In C this is undetectable for the predefined parameter types. I
>> wanted the double option to detect this. But I guess it does not make
>> sense.
>
> My idea was to have an `const DEFAULT: Option<Self>` to represent the
> following:
> (1) if `DEFAULT =3D=3D None`, then `KERNEL_PARAM_OPS_FL_NOARG` is not set
>     and thus either the `module!` user-specified default value is used,
>     or it is specified via `my_module.param=3Dvalue` and
>     `try_from_param_arg` is called.
> (2) if `DEFAULT =3D=3D Some(d)`, then `KERNEL_PARAM_OPS_FL_NOARG` is set =
and
>     when `NULL` is given to `kernel_param_ops.set`, the parameter value
>     is set to `d`, otherwise `try_from_param_arg` is called.
>
> But I think I agree with you removing `NOARG_ALLOWED`, see below.

Great!

>
>> At a higher level where the bindings supply the parsing functions, we
>> can decide that passing an argument without a value yields a default
>> parameter value. C does this for the predefined `bool` type. The
>> predefined integer types does not support omitting the value.
>>
>> This patch only supports the higher level predefined parameter types,
>> and does not allow modules to supply their own parameter parsing
>> functions. None of the types we implement in this patch support passing
>> the argument without a value. This is intentional to mirror the C
>> implementation.
>>=20
>> To that end, I removed `NOARG_ALLOWED`, and changed the parsing function
>> trait to:
>>=20
>>     fn try_from_param_arg(arg: &'static [u8]) -> Result<Self>;
>>=20
>> If/when we start supporting types like `bool` or custom parsing
>> functions provided by the module, we will have to update the signature
>> to take an `Option` to represent the case where the user passed an
>> argument without a value. However, to mimic C, the function must always
>> return a value if successful, even if the user did not supply a value to
>> the argument.
>>=20
>> Two different default values are in flight here. 1) the value that the
>> parameter will have before the kernel calls `try_from_param_arg` via
>> `set_param` and 2) the value to return from `try_from_param_arg` if the
>> user did not pass a value with the argument.
>>=20
>> For a `bool` 1) would usually be `false` and 2) would always be `true`.
>>=20
>> For predefined types the module would not customize 2), but 1) is useful
>> to customize. For custom types where the module supplies the parsing
>> function, 2) would be implicitly given by the module in the parsing
>> function.
>>=20
>> In this patch set, we only have 1 default value, namely 1). We do not
>> need 2) because we do not support parameters without values.
>
> I am not sure that putting the default value of `my_module.param` into
> the `ModuleParam` trait is a good idea. It feels more correct to me to
> add an optional field to the part in `module!` that can be set to denote
> this default value -- we might also want to change the name of
> `default`, what do you think of `default_inactive` and `default_active`?

For all the predefined parameter types, the module code would never set
the `default_active` value. It should be part of the data parsing
specification for the predefined argument types.

For custom parsing functions implemented in the module, it makes sense
specifying this value in the trait.

> Since one might want an option by default be `true` and when one writes
> `my_module.param`, it should be `false`.

I think this would be confusing, since the default C parameter types do
not have this semantic. Specifying a default true boolean as an argument
does not make it false in C land. TBH this also feels like the most sane
thing to do.

> Also as the C side shows, having default values for integer types is not
> really a good idea, since you might want a non-zero default value.
> If one does not specify the `default_active` value, then the
> `KERNEL_PARAM_OPS_FL_NOARG` is not set.

I would rather predefine `KERNEL_PARAM_OPS_FL_NOARG` in the trait
implementation like C does. We would set the flag for `bool` but not for
integer types. For custom implementations of the trait, the developer
can do whatever they want.

> If you don't want to implement this (which I can fully understand, since
> we might get `syn` before anyone needs params with default values), then
> we should write this idea down (maybe in an issue?). But regardless, I
> would like to know your opinion on this topic.

We can create he issue if this series is accepted without the feature.

>
>>>> I think we need to drop the default value if we adopt the arg without
>>>> value scheme.
>>>
>>> Yes definitely. I don't see anything in the code doing this currently,
>>> right?
>>=20
>> The current patch uses the default value given in the `module!` macro to
>> initialize the parameter value.
>
> But what drops the default value, when an actual value is specified via
> `my_module.param=3Dvalue`? (or is the default value only assigned when
> nothing is specified?)

Some more confusion maybe. When I wrote "drop the default value", I
meant remove it from the code, not specify it. I take it back though. We
would use the value given in the `module!` macro `default` field as
`default_inactive`. `default_active` is not required for integer types,
since they always require a value for the argument.

But the drop would happen in `set_param` when the return value of
`core::ptr::replace` is dropped.

>
>>> We could also only allow `Copy` values to be used as Parameters (but
>>> then `str` cannot be used as a parameter...), since they can't implemen=
t
>>> `Drop`.
>>=20
>> We should plan on eventually supporting `String`.
>
> Yes.
>
>>>>>> Or we could just not adopt this feature in the Rust abstractions.
>>>>>
>>>>> Depends on how common this is and if people need to use it. I think t=
hat
>>>>> what I proposed above isn't that complex, so it should be easy to
>>>>> implement.
>>>>
>>>> Rust modules would just force people to add "my_module.param=3D1" inst=
ead
>>>> of just "my_module.param". I think that is reasonable.
>>>
>>> Eh, why do we want to give that up? I don't think it's difficult to do.
>>=20
>> I just don't see the point. Just have the user pass `my_module.param=3D1=
`
>> instead of omitting the value. Having multiple ways of specifying for
>> instance a true boolean just leads to confusion. Some boolean parameters
>> have a default value of `true`, for instance `nvme.use_cmb_sqes`. In
>> this case specifying `nvme.use_cmb_sqes` has no effect, even though one
>> might think it has.
>
> This just shows to me that a "global" default in `ModuleParam` is wrong,
> since for `use_cmb_sqes` one could either have a negated flag, or no
> default value, forcing the user to write `nvme.use_cmb_sqes=3Dfalse`.

I do not think it is a good idea to be able to override the value
assigned to a parameter when it is given without a value. The more
predictable a user interface is, the better.


Best regards,
Andreas


