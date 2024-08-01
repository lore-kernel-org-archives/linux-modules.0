Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52B214264C;
	Thu,  1 Aug 2024 19:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722540540; cv=none; b=tDmfe/n0b7Js4539aX64zRvvwRdcyQeVqNK5PdMyNV9mfGJxUHlCzafeQ2IPNtSB5nk6qm37h9csqj/YHNN7uvO6B29YoliCWc1j/XPaK0M3pIHB/ub0s6oayX3XXqU/a34/HThq1306vnQv8w2sS+lVzWu3t5Mbny6EvftyP6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722540540; c=relaxed/simple;
	bh=nm7mRUUvpotv8csWeKxtedF6S9rWnWZUfqbxHGM2QwM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=faQiVxVA89Z4ikg+H5bWoCouiR/5E+xheEvxvuajhppyVu2CV/0d1cVMePerQDo715Kfpyujk34VsP4B5K+t9RvtF6d0Ws/kzzyJzvLnuoPJzV0VGhxuQngGG7whRsGJdjlavV4l5X/cdIOYv2huxzGWiblcwski7gsolArpwpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=cHbGDsZY; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="cHbGDsZY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722540534; x=1722799734;
	bh=rzyIZo4WeFihZYLvnv3+qIQgI3iMLadZn0JBo/A7Cyw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=cHbGDsZY6XtiQK2RjrktPCxiC8bnht13ygEEzp7IkXZIh2L4ZWc7bx+nLHNVb2bDA
	 WhUort6K+uYUnQVi9mlavNUCpjgcVIa/0VQuxfip80aoi2vuNbezcoRUHfLN07PHJw
	 Bp7pt5VsekZbVPqhxK7dBdMtZbnB+4nQmU3gB8HksA551ALucwqiuCUrXXhzjekqVm
	 G5KoHQ0KcrRZge1p6rdN3ApwN7CMCwyN61/gK7I//yLUc6uAaTQpEApuJYplQJ5jjY
	 AhtRdl2wf/OT024qft+LqojIBSnZAyVWzc9ztCrizk4Zph1VrNdkInJ1yrh+eBKzk6
	 FMe/RF4AWKClQ==
Date: Thu, 01 Aug 2024 19:28:50 +0000
To: Andreas Hindborg <nmi@metaspace.dk>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@samsung.com>, Adam Bratschi-Kaye <ark.email@gmail.com>
Subject: Re: [PATCH] rust: add `module_params` macro
Message-ID: <f84e9189-b64a-4761-86f5-ccd50fb62f36@proton.me>
In-Reply-To: <874j84nurn.fsf@metaspace.dk>
References: <20240705111455.142790-1-nmi@metaspace.dk> <2838cf2e-936c-45de-bb19-af9da66fbe00@proton.me> <87plqso50o.fsf@metaspace.dk> <49cad242-7a7c-4e9e-beb7-4f9c493ce794@proton.me> <878qxgnyzd.fsf@metaspace.dk> <ed2f7416-2631-411d-bb49-5a580dbf51b8@proton.me> <874j84nurn.fsf@metaspace.dk>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: a09efa0a343639e2111b456264b989253a813cc9
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01.08.24 17:11, Andreas Hindborg wrote:
> "Benno Lossin" <benno.lossin@proton.me> writes:
>> On 01.08.24 15:40, Andreas Hindborg wrote:
>>> "Benno Lossin" <benno.lossin@proton.me> writes:
>>>> On 01.08.24 13:29, Andreas Hindborg wrote:
>>>>> "Benno Lossin" <benno.lossin@proton.me> writes:
>>>>>> On 05.07.24 13:15, Andreas Hindborg wrote:
>>>>>>> +
>>>>>>> +/// Types that can be used for module parameters.
>>>>>>> +///
>>>>>>> +/// Note that displaying the type in `sysfs` will fail if
>>>>>>> +/// [`core::str::from_utf8`] (as implemented through the [`core::f=
mt::Display`]
>>>>>>> +/// trait) writes more than [`PAGE_SIZE`] bytes (including an addi=
tional null
>>>>>>> +/// terminator).
>>>>>>> +///
>>>>>>> +/// [`PAGE_SIZE`]: `bindings::PAGE_SIZE`
>>>>>>> +pub trait ModuleParam: core::fmt::Display + core::marker::Sized {
>>>>>>> +    /// The `ModuleParam` will be used by the kernel module throug=
h this type.
>>>>>>> +    ///
>>>>>>> +    /// This may differ from `Self` if, for example, `Self` needs =
to track
>>>>>>> +    /// ownership without exposing it or allocate extra space for =
other possible
>>>>>>> +    /// parameter values. This is required to support string param=
eters in the
>>>>>>> +    /// future.
>>>>>>> +    type Value: ?Sized;
>>>>>>> +
>>>>>>> +    /// Whether the parameter is allowed to be set without an argu=
ment.
>>>>>>> +    ///
>>>>>>> +    /// Setting this to `true` allows the parameter to be passed w=
ithout an
>>>>>>> +    /// argument (e.g. just `module.param` instead of `module.para=
m=3Dfoo`).
>>>>>>> +    const NOARG_ALLOWED: bool;
>>>>>>
>>>>>> I think, there is a better way of doing this. Instead of this bool, =
we
>>>>>> do the following:
>>>>>> 1. have a `const DEFAULT: Option<Self>`
>>>>>> 2. change the type of the argument of `try_from_param_arg` to
>>>>>>    `&'static [u8]`
>>>>>>
>>>>>> That way we don't have the weird behavior of `try_from_param_arg` th=
at
>>>>>> for params that don't have a default value.
>>>>>
>>>>> Since we have no parameter types for which `NOARG_ALLOWED` is true in
>>>>> this patch set, it is effectively dead code. I will remove it.
>>>>
>>>> Hmm what parameters actually are optional? I looked at the old rust
>>>> branch and only `bool` is marked as optional. Are there others?
>>>>
>>>> If it is used commonly for custom parameters (I could imagine that Rus=
t
>>>> modules have enums as parameters and specifying nothing could mean the
>>>> default value), then it might be a good idea to just include it now.
>>>> (otherwise we might forget the design later)
>>>
>>> As far as I can tell from the C code, all parameters are able to have
>>> the `NOARG` flag set. We get a null pointer in the callback in that
>>> case.
>>>
>>> If we want to handle this now, we could drop the `default` field
>>> in the Rust module macro. There is no equivalent in the C macros.
>>> And then use an `Option<Option<_>>` to represent the value. `None` woul=
d
>>> be an unset parameter. `Some(None)` would be a parameter without a
>>> value. `Some(Some(_))` would be a set parameter with a value. We could
>>> probably fix the types so that only parameters with the `NOARG` flag us=
e
>>> the double option, others use a single option.
>>
>> What did you think of my approach that I detailed above? I would like to
>> avoid `Option<Option<_>>` if we can.
>=20
> How would you represent the case when the parameter is passed without a
> value and a default is given in `module!`?

I am a bit confused, there are two default values here:
(1) the value returned by `try_from_param_arg(None)`.
(2) the value given by the user to the `module!` macro.

I am talking about changing the definition of ModuleParam, so (1). I get
the feeling that you are talking about (2), is that correct?

> I think we need to drop the default value if we adopt the arg without
> value scheme.

Yes definitely. I don't see anything in the code doing this currently,
right?
We could also only allow `Copy` values to be used as Parameters (but
then `str` cannot be used as a parameter...), since they can't implement
`Drop`.

>>> Or we could just not adopt this feature in the Rust abstractions.
>>
>> Depends on how common this is and if people need to use it. I think that
>> what I proposed above isn't that complex, so it should be easy to
>> implement.
>=20
> Rust modules would just force people to add "my_module.param=3D1" instead
> of just "my_module.param". I think that is reasonable.

Eh, why do we want to give that up? I don't think it's difficult to do.

>>>>>>> +                            // Note: when we enable r/w parameters=
, we need to lock here.
>>>>>>> +
>>>>>>> +                            // SAFETY: Parameters do not need to b=
e locked because they are
>>>>>>> +                            // read only or sysfs is not enabled.
>>>>>>> +                            unsafe {{
>>>>>>> +                                <{param_type_internal} as kernel::=
module_param::ModuleParam>::value(
>>>>>>> +                                    &__{name}_{param_name}_value
>>>>>>> +                                )
>>>>>>> +                            }}
>>>>>>> +                        }}
>>>>>>> +                    ",
>>>>>>> +                    name =3D info.name,
>>>>>>> +                    param_name =3D param_name,
>>>>>>> +                    param_type_internal =3D param_type_internal,
>>>>>>> +                );
>>>>>>> +
>>>>>>> +                let kparam =3D format!(
>>>>>>> +                    "
>>>>>>> +                    kernel::bindings::kernel_param__bindgen_ty_1 {=
{
>>>>>>> +                        // SAFETY: Access through the resulting po=
inter is
>>>>>>> +                        // serialized by C side and only happens b=
efore module
>>>>>>> +                        // `init` or after module `drop` is called=
.
>>>>>>> +                        arg: unsafe {{ &__{name}_{param_name}_valu=
e }}
>>>>>>> +                            as *const _ as *mut core::ffi::c_void,
>>>>>>
>>>>>> Here you should use `addr_of[_mut]!` instead of taking a reference.
>>>>>
>>>>> This is a static initializer, so it would be evaluated in const conte=
xt.
>>>>> At that time, this is going to be the only reference to
>>>>> `&__{name}_{param_name}_value` which would be const. So it should be
>>>>> fine?
>>>>
>>>> When compiling this [1] with a sufficiently new Rust version, you will
>>>> get an error:
>>>>
>>>>     warning: creating a shared reference to mutable static is discoura=
ged
>>>>      --> src/main.rs:4:22
>>>>       |
>>>>     4 |     let x =3D unsafe { &foo };
>>>>       |                      ^^^^ shared reference to mutable static
>>>>       |
>>>>       =3D note: for more information, see issue #114447 <https://githu=
b.com/rust-lang/rust/issues/114447>
>>>>       =3D note: this will be a hard error in the 2024 edition
>>>>       =3D note: this shared reference has lifetime `'static`, but if t=
he static ever gets mutated, or a mutable reference is created, then any fu=
rther use of this shared reference is Undefined Behavior
>>>>       =3D note: `#[warn(static_mut_refs)]` on by default
>>>>     help: use `addr_of!` instead to create a raw pointer
>>>>       |
>>>>     4 |     let x =3D unsafe { addr_of!(foo) };
>>>>       |                      ~~~~~~~~~~~~~
>>>>
>>>> [1]: https://play.rust-lang.org/?version=3Dstable&mode=3Ddebug&edition=
=3D2021&gist=3Dc914a438938be6f5fc643ee277efa1d1
>>>>
>>>> So I think we should start using `addr_of!` for mutable static now.
>>>
>>> Oh. Thanks for the pointer.
>>>
>>> Hmm, `addr_of_mut!` still requires the unsafe block. Hopefully that goe=
s
>>> away as well with the feature you linked as well.
>>
>> I think that will take some time until it is gone.
>>
>>> This also requires `const_mut_refs`, but as I recall that is going to b=
e
>>> stabilized soon.
>>
>> That should only be needed if you need `addr_of_mut!`, but IIUC, you
>> only need `addr_of!`, right?
>=20
> The pointer we create here is the one passed to `free` in
> module_param.rs, so it will eventually be used as `&mut T`.

Oh then the original code is definitely wrong, since it creates a shared
reference. Yeah then you should use `addr_of_mut!`.

---
Cheers,
Benno

