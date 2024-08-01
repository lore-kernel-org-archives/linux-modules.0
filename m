Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62F73A1DA;
	Thu,  1 Aug 2024 15:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722525081; cv=none; b=oEXEbOsGHp++SPQvRJRXYzeH1m77zCAXHEY+mvFZ5CAXkbl6PCtPFClJE3ktFvmAfurjtiailtM+ZYuZ/PqO2ZzgiUlUd9BWH6xRxpmn6aUj46KhO3gn45E0kavgeWXWh6m6LmNj3hE2sUyZN8J5k4+KQom5IOVb8fjH6eC7WQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722525081; c=relaxed/simple;
	bh=po4KKyWk2XPjGMJDoL8LvhzcBLOhc3qdZPdYG13W3R8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GxsEPrVVodN5xm1/XW6F1pZ8ZG+XBZMOnWIByy5tM3Y5AovEEzutfE/iqLamdcwx1du7n5S41h5naQpcYhpCAm+JeXBwThcXs9gw8twigIDl+ywXpGFDf1URQFqGCfYYLuGG6QZNwWjMCyaUrlpXYVH5AsMoHE8QqXJL8lLqixs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=metaspace.dk; spf=pass smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace.dk header.i=@metaspace.dk header.b=Qvwtcq5F; arc=none smtp.client-ip=185.70.40.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace.dk header.i=@metaspace.dk header.b="Qvwtcq5F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=metaspace.dk;
	s=protonmail; t=1722525068; x=1722784268;
	bh=VIr0D/xjfsfSnd+r7NPz1sStBC+cKDUSfeuSBTUQoN8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Qvwtcq5FzFDHUu2fL96i6t5o3tNF06p1WPO4RbOiuTWn7mQ0TQEQ4IiSP0L7PJ1Uf
	 rlq+8il6Jz7tbWdPORjcUqtK8H3iuI/CykxIF4Dk3IVlCnHK7QbYukiqyO5MlZ1MEd
	 mRxFWbWUu03GkFr92J9ncwYe38sYsaq4mablMrxVApdunCU0fq+4jLLFrcyAjpAz0y
	 FbxSyyDmWf00tPoZErzVOZzCyDe+MyZVCVUHDDz+mGYxsx4HxufRuJerDCDvdthO8q
	 PmKNilAVpH2gD+lCf6KV9G+hczxn03JmrrVf3ML1n4x+BpKCcOhjrrqNet5Oq6XraH
	 faYnVTZD+lMig==
Date: Thu, 01 Aug 2024 15:11:04 +0000
To: Benno Lossin <benno.lossin@proton.me>
From: Andreas Hindborg <nmi@metaspace.dk>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@samsung.com>, Adam Bratschi-Kaye <ark.email@gmail.com>
Subject: Re: [PATCH] rust: add `module_params` macro
Message-ID: <874j84nurn.fsf@metaspace.dk>
In-Reply-To: <ed2f7416-2631-411d-bb49-5a580dbf51b8@proton.me>
References: <20240705111455.142790-1-nmi@metaspace.dk> <2838cf2e-936c-45de-bb19-af9da66fbe00@proton.me> <87plqso50o.fsf@metaspace.dk> <49cad242-7a7c-4e9e-beb7-4f9c493ce794@proton.me> <878qxgnyzd.fsf@metaspace.dk> <ed2f7416-2631-411d-bb49-5a580dbf51b8@proton.me>
Feedback-ID: 113830118:user:proton
X-Pm-Message-ID: 4f6c9e89d02fd7d4c6ef2a1a9b1d2f162195b1c2
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Benno Lossin" <benno.lossin@proton.me> writes:

> On 01.08.24 15:40, Andreas Hindborg wrote:
>> "Benno Lossin" <benno.lossin@proton.me> writes:
>>> On 01.08.24 13:29, Andreas Hindborg wrote:
>>>> "Benno Lossin" <benno.lossin@proton.me> writes:
>>>>> On 05.07.24 13:15, Andreas Hindborg wrote:
>>>>>> +
>>>>>> +/// Types that can be used for module parameters.
>>>>>> +///
>>>>>> +/// Note that displaying the type in `sysfs` will fail if
>>>>>> +/// [`core::str::from_utf8`] (as implemented through the [`core::fm=
t::Display`]
>>>>>> +/// trait) writes more than [`PAGE_SIZE`] bytes (including an addit=
ional null
>>>>>> +/// terminator).
>>>>>> +///
>>>>>> +/// [`PAGE_SIZE`]: `bindings::PAGE_SIZE`
>>>>>> +pub trait ModuleParam: core::fmt::Display + core::marker::Sized {
>>>>>> +    /// The `ModuleParam` will be used by the kernel module through=
 this type.
>>>>>> +    ///
>>>>>> +    /// This may differ from `Self` if, for example, `Self` needs t=
o track
>>>>>> +    /// ownership without exposing it or allocate extra space for o=
ther possible
>>>>>> +    /// parameter values. This is required to support string parame=
ters in the
>>>>>> +    /// future.
>>>>>> +    type Value: ?Sized;
>>>>>> +
>>>>>> +    /// Whether the parameter is allowed to be set without an argum=
ent.
>>>>>> +    ///
>>>>>> +    /// Setting this to `true` allows the parameter to be passed wi=
thout an
>>>>>> +    /// argument (e.g. just `module.param` instead of `module.param=
=3Dfoo`).
>>>>>> +    const NOARG_ALLOWED: bool;
>>>>>
>>>>> I think, there is a better way of doing this. Instead of this bool, w=
e
>>>>> do the following:
>>>>> 1. have a `const DEFAULT: Option<Self>`
>>>>> 2. change the type of the argument of `try_from_param_arg` to
>>>>>    `&'static [u8]`
>>>>>
>>>>> That way we don't have the weird behavior of `try_from_param_arg` tha=
t
>>>>> for params that don't have a default value.
>>>>
>>>> Since we have no parameter types for which `NOARG_ALLOWED` is true in
>>>> this patch set, it is effectively dead code. I will remove it.
>>>
>>> Hmm what parameters actually are optional? I looked at the old rust
>>> branch and only `bool` is marked as optional. Are there others?
>>>
>>> If it is used commonly for custom parameters (I could imagine that Rust
>>> modules have enums as parameters and specifying nothing could mean the
>>> default value), then it might be a good idea to just include it now.
>>> (otherwise we might forget the design later)
>>=20
>> As far as I can tell from the C code, all parameters are able to have
>> the `NOARG` flag set. We get a null pointer in the callback in that
>> case.
>>=20
>> If we want to handle this now, we could drop the `default` field
>> in the Rust module macro. There is no equivalent in the C macros.
>> And then use an `Option<Option<_>>` to represent the value. `None` would
>> be an unset parameter. `Some(None)` would be a parameter without a
>> value. `Some(Some(_))` would be a set parameter with a value. We could
>> probably fix the types so that only parameters with the `NOARG` flag use
>> the double option, others use a single option.
>
> What did you think of my approach that I detailed above? I would like to
> avoid `Option<Option<_>>` if we can.

How would you represent the case when the parameter is passed without a
value and a default is given in `module!`?

I think we need to drop the default value if we adopt the arg without
value scheme.

>
>> Or we could just not adopt this feature in the Rust abstractions.
>
> Depends on how common this is and if people need to use it. I think that
> what I proposed above isn't that complex, so it should be easy to
> implement.

Rust modules would just force people to add "my_module.param=3D1" instead
of just "my_module.param". I think that is reasonable.

>
>>>>>> +                    param_type.to_string(),
>>>>>> +                    param_ops_path(&param_type).to_string(),
>>>>>> +                );
>>>>>> +
>>>>>> +                self.emit_param("parmtype", &param_name, &param_ker=
nel_type);
>>>>>
>>>>> Is the spelling intentional? "parmtype"?
>>>>
>>>> This is intentional. I don't think the kernel is ever parsing this, bu=
t
>>>> it is parsed by the `modinfo` tool.
>>>
>>> Hmm, why is it not `paramtype`? Does that conflict with something?
>>=20
>> You would have to take that up with the maintainer(s) of the `modinfo`
>> tool. The name is externally dictated [1].
>
> Thanks for the pointer that's what I wanted to know (is it given from
> somewhere else? or is it a name that we came up with), then it's fine :)
>
>>>>>> +                            // Note: when we enable r/w parameters,=
 we need to lock here.
>>>>>> +
>>>>>> +                            // SAFETY: Parameters do not need to be=
 locked because they are
>>>>>> +                            // read only or sysfs is not enabled.
>>>>>> +                            unsafe {{
>>>>>> +                                <{param_type_internal} as kernel::m=
odule_param::ModuleParam>::value(
>>>>>> +                                    &__{name}_{param_name}_value
>>>>>> +                                )
>>>>>> +                            }}
>>>>>> +                        }}
>>>>>> +                    ",
>>>>>> +                    name =3D info.name,
>>>>>> +                    param_name =3D param_name,
>>>>>> +                    param_type_internal =3D param_type_internal,
>>>>>> +                );
>>>>>> +
>>>>>> +                let kparam =3D format!(
>>>>>> +                    "
>>>>>> +                    kernel::bindings::kernel_param__bindgen_ty_1 {{
>>>>>> +                        // SAFETY: Access through the resulting poi=
nter is
>>>>>> +                        // serialized by C side and only happens be=
fore module
>>>>>> +                        // `init` or after module `drop` is called.
>>>>>> +                        arg: unsafe {{ &__{name}_{param_name}_value=
 }}
>>>>>> +                            as *const _ as *mut core::ffi::c_void,
>>>>>
>>>>> Here you should use `addr_of[_mut]!` instead of taking a reference.
>>>>
>>>> This is a static initializer, so it would be evaluated in const contex=
t.
>>>> At that time, this is going to be the only reference to
>>>> `&__{name}_{param_name}_value` which would be const. So it should be
>>>> fine?
>>>
>>> When compiling this [1] with a sufficiently new Rust version, you will
>>> get an error:
>>>
>>>     warning: creating a shared reference to mutable static is discourag=
ed
>>>      --> src/main.rs:4:22
>>>       |
>>>     4 |     let x =3D unsafe { &foo };
>>>       |                      ^^^^ shared reference to mutable static
>>>       |
>>>       =3D note: for more information, see issue #114447 <https://github=
.com/rust-lang/rust/issues/114447>
>>>       =3D note: this will be a hard error in the 2024 edition
>>>       =3D note: this shared reference has lifetime `'static`, but if th=
e static ever gets mutated, or a mutable reference is created, then any fur=
ther use of this shared reference is Undefined Behavior
>>>       =3D note: `#[warn(static_mut_refs)]` on by default
>>>     help: use `addr_of!` instead to create a raw pointer
>>>       |
>>>     4 |     let x =3D unsafe { addr_of!(foo) };
>>>       |                      ~~~~~~~~~~~~~
>>>
>>> [1]: https://play.rust-lang.org/?version=3Dstable&mode=3Ddebug&edition=
=3D2021&gist=3Dc914a438938be6f5fc643ee277efa1d1
>>>
>>> So I think we should start using `addr_of!` for mutable static now.
>>=20
>> Oh. Thanks for the pointer.
>>=20
>> Hmm, `addr_of_mut!` still requires the unsafe block. Hopefully that goes
>> away as well with the feature you linked as well.
>
> I think that will take some time until it is gone.
>
>> This also requires `const_mut_refs`, but as I recall that is going to be
>> stabilized soon.
>
> That should only be needed if you need `addr_of_mut!`, but IIUC, you
> only need `addr_of!`, right?

The pointer we create here is the one passed to `free` in
module_param.rs, so it will eventually be used as `&mut T`.


Best regards,
Andreas


