Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743ED1714A2;
	Thu, 15 Aug 2024 13:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723727481; cv=none; b=Lgv0DqTfydMWcATbapWbUbromhg3Kf0SM4US/sCbEdQDf/6jt9V1fg4cMMgJQ6ymnIlfJtVLOnHMIiFSYekwm/VFcxWtRav3pzR/jQsbv+SRPpnBQEwKnA9dE3xCkFsm1kxhP4QOUYlx6Vav/5SR5Am+P249T74Wp5rOZR1627o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723727481; c=relaxed/simple;
	bh=757O26+5ZPnBoh7j8aKthYi3ucPVSyRWKNnky4QqYvo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j5dk+F0iLr3GFBFU/pYxvKfF1H20uzyZEfq02TXsG7Om/TiFoApr0iq0vkoqAuUwaUNg+Til8b8metR81RLIzsmPdsBen9MzkETk9utWtJu2mnOn4x/tJX1cFOYN8ieDtFVo1w51x3i0xAVABKFwoChbvCZlaw12aYWYkI4W/Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=metaspace.dk; spf=pass smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace.dk header.i=@metaspace.dk header.b=lcvxCZkY; arc=none smtp.client-ip=185.70.40.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace.dk header.i=@metaspace.dk header.b="lcvxCZkY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=metaspace.dk;
	s=protonmail; t=1723727474; x=1723986674;
	bh=pQHC8kTWve/pou9rdJQUHbrZKp74QqybR2ypPHRTiMo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=lcvxCZkYcqw0yaLxp/9qk84L2vceETo2raMK/VYlIZ0PFfwLk0aa079qgzfizodsU
	 qQrN6IYXuliUt21gXO2pYwbFr9A+ak9AfmvrYlecCpfzaedQ/fQeCAjvIxHUHS2eFF
	 DGRF9d09tJCxv50zF5CZb2fHmJsNSCjKlLv12IGQQaMyz4KaNDwdAowTGLHcFxFcYm
	 BdG0Cv3Qu+sTWVYwfKTKDulRgwCrpzamS6lGO6zv63oVJivizKC5ZLscPwXzBfljJ1
	 +7pZIrs+oTV082RT1VKZd0DdQ1rVA2ToM0hjDUBbUk0IWb1VVYx3MUu62t2bPs5ncG
	 fdsDoMJ7AwjNw==
Date: Thu, 15 Aug 2024 13:11:09 +0000
To: Benno Lossin <benno.lossin@proton.me>
From: Andreas Hindborg <nmi@metaspace.dk>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@samsung.com>, Adam Bratschi-Kaye <ark.email@gmail.com>
Subject: Re: [PATCH] rust: add `module_params` macro
Message-ID: <87ikw2rlbi.fsf@metaspace.dk>
In-Reply-To: <b95cc90a-46ae-44af-90af-0fc374cd381a@proton.me>
References: <20240705111455.142790-1-nmi@metaspace.dk> <49cad242-7a7c-4e9e-beb7-4f9c493ce794@proton.me> <878qxgnyzd.fsf@metaspace.dk> <ed2f7416-2631-411d-bb49-5a580dbf51b8@proton.me> <874j84nurn.fsf@metaspace.dk> <f84e9189-b64a-4761-86f5-ccd50fb62f36@proton.me> <87zfpvmd8y.fsf@metaspace.dk> <a98ddf54-3e27-4587-8e49-f19dd1ac65a6@proton.me> <87v80fme7g.fsf@metaspace.dk> <b95cc90a-46ae-44af-90af-0fc374cd381a@proton.me>
Feedback-ID: 113830118:user:proton
X-Pm-Message-ID: 56e6b912e6d7dfbc2158ac3ec6487c37618ec7cb
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Benno Lossin" <benno.lossin@proton.me> writes:

> On 05.08.24 12:55, Andreas Hindborg wrote:
>> "Benno Lossin" <benno.lossin@proton.me> writes:
>>> On 02.08.24 12:27, Andreas Hindborg wrote:
>>>> At a higher level where the bindings supply the parsing functions, we
>>>> can decide that passing an argument without a value yields a default
>>>> parameter value. C does this for the predefined `bool` type. The
>>>> predefined integer types does not support omitting the value.
>>>>
>>>> This patch only supports the higher level predefined parameter types,
>>>> and does not allow modules to supply their own parameter parsing
>>>> functions. None of the types we implement in this patch support passin=
g
>>>> the argument without a value. This is intentional to mirror the C
>>>> implementation.
>>>>
>>>> To that end, I removed `NOARG_ALLOWED`, and changed the parsing functi=
on
>>>> trait to:
>>>>
>>>>     fn try_from_param_arg(arg: &'static [u8]) -> Result<Self>;
>>>>
>>>> If/when we start supporting types like `bool` or custom parsing
>>>> functions provided by the module, we will have to update the signature
>>>> to take an `Option` to represent the case where the user passed an
>>>> argument without a value. However, to mimic C, the function must alway=
s
>>>> return a value if successful, even if the user did not supply a value =
to
>>>> the argument.
>>>>
>>>> Two different default values are in flight here. 1) the value that the
>>>> parameter will have before the kernel calls `try_from_param_arg` via
>>>> `set_param` and 2) the value to return from `try_from_param_arg` if th=
e
>>>> user did not pass a value with the argument.
>>>>
>>>> For a `bool` 1) would usually be `false` and 2) would always be `true`=
.
>>>>
>>>> For predefined types the module would not customize 2), but 1) is usef=
ul
>>>> to customize. For custom types where the module supplies the parsing
>>>> function, 2) would be implicitly given by the module in the parsing
>>>> function.
>>>>
>>>> In this patch set, we only have 1 default value, namely 1). We do not
>>>> need 2) because we do not support parameters without values.
>>>
>>> I am not sure that putting the default value of `my_module.param` into
>>> the `ModuleParam` trait is a good idea. It feels more correct to me to
>>> add an optional field to the part in `module!` that can be set to denot=
e
>>> this default value -- we might also want to change the name of
>>> `default`, what do you think of `default_inactive` and `default_active`=
?
>>=20
>> For all the predefined parameter types, the module code would never set
>> the `default_active` value. It should be part of the data parsing
>> specification for the predefined argument types.
>
> So if your module has an i32 parameter, you can't set a default value to
> eg 1000?

You _would_ be able to set the `default_inactive` value, which is the
value assigned to the static at initialization time. It would make sense
to default this to 0 for integer types and make it overridable in the
`module!` macro.

You would not be to set the `default_active` value, which is the value
assigned to the parameter static variable, when the parameter is passed
without value. The reason being that we want to mirror C, so we prohibit
this for predefined integer parameter types.

>
>> For custom parsing functions implemented in the module, it makes sense
>> specifying this value in the trait.
>
> Couldn't I just emulate the behavior from above by creating a
> `struct MyI32(i32)` and having a default value?
> In that case, why make it more difficult instead of providing a simple
> way to do it?

The way parameter parsing works in C (that we try to replicate) is that
we are able to parse a set of predefined types. For each predefined type
we have a set of parser functions. If a module author want to parse
something outside of the predefined set, they can provide custom parser
functions.

I would advocate we do the same in Rust. This patch provides a set of
predefined types that can be parsed. For parsing to other types, we
would eventually expand the features to allow the module authors to
implement the parsing trait on their own types.

So to answer your question: No, not in this patch set. But let's plan to
add it in the future.

>
>>> Since one might want an option by default be `true` and when one writes
>>> `my_module.param`, it should be `false`.
>>=20
>> I think this would be confusing, since the default C parameter types do
>> not have this semantic. Specifying a default true boolean as an argument
>> does not make it false in C land. TBH this also feels like the most sane
>> thing to do.
>
> Can't you also do the custom parameter parsing from above? ie have an
> integer parameter with a default value?
> Or is that frowned upon (ie not allowed through review)?

In C, you cannot, if you utilize the predefined parameter parsing
functions. Your can supply your own parser, and then you can do whatever
you want.

I would assume that it is best practice to reuse the predefined parsing
functions. For Rust code I would argue that we should have module
authors use the predefined parsers, unless they have very special
requirements.

>
>>> Also as the C side shows, having default values for integer types is no=
t
>>> really a good idea, since you might want a non-zero default value.
>>> If one does not specify the `default_active` value, then the
>>> `KERNEL_PARAM_OPS_FL_NOARG` is not set.
>>=20
>> I would rather predefine `KERNEL_PARAM_OPS_FL_NOARG` in the trait
>> implementation like C does. We would set the flag for `bool` but not for
>> integer types. For custom implementations of the trait, the developer
>> can do whatever they want.
>
> So we are only going to use it for `bool`?

I think so.

As far as I can tell, the predefined C parsers only allow this for bool.
Outside of the predefined parsers, I see only 4 custom argument parsers
that allow parameters without values.

>
>>> If you don't want to implement this (which I can fully understand, sinc=
e
>>> we might get `syn` before anyone needs params with default values), the=
n
>>> we should write this idea down (maybe in an issue?). But regardless, I
>>> would like to know your opinion on this topic.
>>=20
>> We can create he issue if this series is accepted without the feature.
>>=20
>>>
>>>>>> I think we need to drop the default value if we adopt the arg withou=
t
>>>>>> value scheme.
>>>>>
>>>>> Yes definitely. I don't see anything in the code doing this currently=
,
>>>>> right?
>>>>
>>>> The current patch uses the default value given in the `module!` macro =
to
>>>> initialize the parameter value.
>>>
>>> But what drops the default value, when an actual value is specified via
>>> `my_module.param=3Dvalue`? (or is the default value only assigned when
>>> nothing is specified?)
>>=20
>> Some more confusion maybe. When I wrote "drop the default value", I
>> meant remove it from the code, not specify it. I take it back though. We
>> would use the value given in the `module!` macro `default` field as
>> `default_inactive`. `default_active` is not required for integer types,
>> since they always require a value for the argument.
>>=20
>> But the drop would happen in `set_param` when the return value of
>> `core::ptr::replace` is dropped.
>
> Ah I see, I missed that.
>
>>>>>> We could also only allow `Copy` values to be used as Parameters (but
>>>>> then `str` cannot be used as a parameter...), since they can't implem=
ent
>>>>> `Drop`.
>>>>
>>>> We should plan on eventually supporting `String`.
>>>
>>> Yes.
>>>
>>>>>>>> Or we could just not adopt this feature in the Rust abstractions.
>>>>>>>
>>>>>>> Depends on how common this is and if people need to use it. I think=
 that
>>>>>>> what I proposed above isn't that complex, so it should be easy to
>>>>>>> implement.
>>>>>>
>>>>>> Rust modules would just force people to add "my_module.param=3D1" in=
stead
>>>>>> of just "my_module.param". I think that is reasonable.
>>>>>
>>>>> Eh, why do we want to give that up? I don't think it's difficult to d=
o.
>>>>
>>>> I just don't see the point. Just have the user pass `my_module.param=
=3D1`
>>>> instead of omitting the value. Having multiple ways of specifying for
>>>> instance a true boolean just leads to confusion. Some boolean paramete=
rs
>>>> have a default value of `true`, for instance `nvme.use_cmb_sqes`. In
>>>> this case specifying `nvme.use_cmb_sqes` has no effect, even though on=
e
>>>> might think it has.
>>>
>>> This just shows to me that a "global" default in `ModuleParam` is wrong=
,
>>> since for `use_cmb_sqes` one could either have a negated flag, or no
>>> default value, forcing the user to write `nvme.use_cmb_sqes=3Dfalse`.
>>=20
>> I do not think it is a good idea to be able to override the value
>> assigned to a parameter when it is given without a value. The more
>> predictable a user interface is, the better.
>
> By that argument, we should also not permit custom implementations to
> specify a default value.

If we provide a predefined set of parsing functions, most uses will use
those, and we will get a similar user experience across most of the
modules. If we allow said customization of the predefined parsers,
people will use it those customizations, and we will not get a good user
experience. If we omit the customizations, I think most will still stick
to predefined semantics, rather than implement their own parsers. For
those that actually need to have other semantics (or types), we will
have the option of user provided parsers, just as C.


Best regards,
Andreas



