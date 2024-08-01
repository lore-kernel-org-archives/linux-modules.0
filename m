Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052D916DECD
	for <linux-modules@vger.kernel.org>; Thu,  1 Aug 2024 14:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722522083; cv=none; b=TgPhBAvjQDMU/wc2LuVWfn8j/YcDncv5Yj0FBkZCMzDKPi3zzOzvbPEUAFgUVlSdGR+dG3yGsJPlq3lWd7K2kRlYVW6RXReeesRJ7ebnycjDm5EDanopUjpxuVmdBHKAx+I2qOCO9KUoyn+7FyGJFeyosbQKjhAi1HceZKHrB04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722522083; c=relaxed/simple;
	bh=PfMqkfN42J4e0dqvTm5SvtF6IOoWYEeysMtd20JQ8DU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MczLTvvIDmHuwCwDN/URDQ/ECquokvT0iDmBMoTmGrpyMPP2pcb3xB1FXnHDPqXz1pupzaD87EB1uR+/9F6m10cpunksUqSwTJoU4jyqnOne2CbjPNuYNgvpV8/zpewzhDw+C2Q4JjvsqCRC5CPOPxb3TLP9CI4+rcS1SMt6v4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=USCgwMHG; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="USCgwMHG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722522079; x=1722781279;
	bh=LXd8+skXHkJjJoFz+sBO8AAh+6v9cCgpMDN8fc+xS1E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=USCgwMHGV9qDIGf5J7oBp9DRKD4fXLEFqMIqdsj5pXlPrkUBSMYCeAIJ4coOdpDC8
	 NFnco217BvGlPDRFr14EBE7rqZ2JFp5JCYSFXK8Gwj2Eae3hZ9QQOH/wV8XLbopj/B
	 aMYlzNZ+uJCnxilnzD/cYTjAqb8HpfWa5O81fQuxTSBNJrL1aIviHTgQm9hLG1VKas
	 PT+2qu3hDJucyH2vqb+iXGzTXD/76qKMM3ukhLOFY1Tbhb/SqwPANM0bqKyGw936Os
	 wTdx3BtU5x5A7EvbVfgg3Nv60O2QfwUTQy7+1G9P15UyKWjjzqjYtwILalcCgVD2jz
	 YGas/pgZ1IQZQ==
Date: Thu, 01 Aug 2024 14:21:13 +0000
To: Andreas Hindborg <nmi@metaspace.dk>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@samsung.com>, Adam Bratschi-Kaye <ark.email@gmail.com>
Subject: Re: [PATCH] rust: add `module_params` macro
Message-ID: <ed2f7416-2631-411d-bb49-5a580dbf51b8@proton.me>
In-Reply-To: <878qxgnyzd.fsf@metaspace.dk>
References: <20240705111455.142790-1-nmi@metaspace.dk> <2838cf2e-936c-45de-bb19-af9da66fbe00@proton.me> <87plqso50o.fsf@metaspace.dk> <49cad242-7a7c-4e9e-beb7-4f9c493ce794@proton.me> <878qxgnyzd.fsf@metaspace.dk>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 39a3d6e161169e2681298c1681513f946ad3eb54
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01.08.24 15:40, Andreas Hindborg wrote:
> "Benno Lossin" <benno.lossin@proton.me> writes:
>> On 01.08.24 13:29, Andreas Hindborg wrote:
>>> "Benno Lossin" <benno.lossin@proton.me> writes:
>>>> On 05.07.24 13:15, Andreas Hindborg wrote:
>>>>> +
>>>>> +/// Types that can be used for module parameters.
>>>>> +///
>>>>> +/// Note that displaying the type in `sysfs` will fail if
>>>>> +/// [`core::str::from_utf8`] (as implemented through the [`core::fmt=
::Display`]
>>>>> +/// trait) writes more than [`PAGE_SIZE`] bytes (including an additi=
onal null
>>>>> +/// terminator).
>>>>> +///
>>>>> +/// [`PAGE_SIZE`]: `bindings::PAGE_SIZE`
>>>>> +pub trait ModuleParam: core::fmt::Display + core::marker::Sized {
>>>>> +    /// The `ModuleParam` will be used by the kernel module through =
this type.
>>>>> +    ///
>>>>> +    /// This may differ from `Self` if, for example, `Self` needs to=
 track
>>>>> +    /// ownership without exposing it or allocate extra space for ot=
her possible
>>>>> +    /// parameter values. This is required to support string paramet=
ers in the
>>>>> +    /// future.
>>>>> +    type Value: ?Sized;
>>>>> +
>>>>> +    /// Whether the parameter is allowed to be set without an argume=
nt.
>>>>> +    ///
>>>>> +    /// Setting this to `true` allows the parameter to be passed wit=
hout an
>>>>> +    /// argument (e.g. just `module.param` instead of `module.param=
=3Dfoo`).
>>>>> +    const NOARG_ALLOWED: bool;
>>>>
>>>> I think, there is a better way of doing this. Instead of this bool, we
>>>> do the following:
>>>> 1. have a `const DEFAULT: Option<Self>`
>>>> 2. change the type of the argument of `try_from_param_arg` to
>>>>    `&'static [u8]`
>>>>
>>>> That way we don't have the weird behavior of `try_from_param_arg` that
>>>> for params that don't have a default value.
>>>
>>> Since we have no parameter types for which `NOARG_ALLOWED` is true in
>>> this patch set, it is effectively dead code. I will remove it.
>>
>> Hmm what parameters actually are optional? I looked at the old rust
>> branch and only `bool` is marked as optional. Are there others?
>>
>> If it is used commonly for custom parameters (I could imagine that Rust
>> modules have enums as parameters and specifying nothing could mean the
>> default value), then it might be a good idea to just include it now.
>> (otherwise we might forget the design later)
>=20
> As far as I can tell from the C code, all parameters are able to have
> the `NOARG` flag set. We get a null pointer in the callback in that
> case.
>=20
> If we want to handle this now, we could drop the `default` field
> in the Rust module macro. There is no equivalent in the C macros.
> And then use an `Option<Option<_>>` to represent the value. `None` would
> be an unset parameter. `Some(None)` would be a parameter without a
> value. `Some(Some(_))` would be a set parameter with a value. We could
> probably fix the types so that only parameters with the `NOARG` flag use
> the double option, others use a single option.

What did you think of my approach that I detailed above? I would like to
avoid `Option<Option<_>>` if we can.

> Or we could just not adopt this feature in the Rust abstractions.

Depends on how common this is and if people need to use it. I think that
what I proposed above isn't that complex, so it should be easy to
implement.

>>>>> +                    param_type.to_string(),
>>>>> +                    param_ops_path(&param_type).to_string(),
>>>>> +                );
>>>>> +
>>>>> +                self.emit_param("parmtype", &param_name, &param_kern=
el_type);
>>>>
>>>> Is the spelling intentional? "parmtype"?
>>>
>>> This is intentional. I don't think the kernel is ever parsing this, but
>>> it is parsed by the `modinfo` tool.
>>
>> Hmm, why is it not `paramtype`? Does that conflict with something?
>=20
> You would have to take that up with the maintainer(s) of the `modinfo`
> tool. The name is externally dictated [1].

Thanks for the pointer that's what I wanted to know (is it given from
somewhere else? or is it a name that we came up with), then it's fine :)

>>>>> +                            // Note: when we enable r/w parameters, =
we need to lock here.
>>>>> +
>>>>> +                            // SAFETY: Parameters do not need to be =
locked because they are
>>>>> +                            // read only or sysfs is not enabled.
>>>>> +                            unsafe {{
>>>>> +                                <{param_type_internal} as kernel::mo=
dule_param::ModuleParam>::value(
>>>>> +                                    &__{name}_{param_name}_value
>>>>> +                                )
>>>>> +                            }}
>>>>> +                        }}
>>>>> +                    ",
>>>>> +                    name =3D info.name,
>>>>> +                    param_name =3D param_name,
>>>>> +                    param_type_internal =3D param_type_internal,
>>>>> +                );
>>>>> +
>>>>> +                let kparam =3D format!(
>>>>> +                    "
>>>>> +                    kernel::bindings::kernel_param__bindgen_ty_1 {{
>>>>> +                        // SAFETY: Access through the resulting poin=
ter is
>>>>> +                        // serialized by C side and only happens bef=
ore module
>>>>> +                        // `init` or after module `drop` is called.
>>>>> +                        arg: unsafe {{ &__{name}_{param_name}_value =
}}
>>>>> +                            as *const _ as *mut core::ffi::c_void,
>>>>
>>>> Here you should use `addr_of[_mut]!` instead of taking a reference.
>>>
>>> This is a static initializer, so it would be evaluated in const context=
.
>>> At that time, this is going to be the only reference to
>>> `&__{name}_{param_name}_value` which would be const. So it should be
>>> fine?
>>
>> When compiling this [1] with a sufficiently new Rust version, you will
>> get an error:
>>
>>     warning: creating a shared reference to mutable static is discourage=
d
>>      --> src/main.rs:4:22
>>       |
>>     4 |     let x =3D unsafe { &foo };
>>       |                      ^^^^ shared reference to mutable static
>>       |
>>       =3D note: for more information, see issue #114447 <https://github.=
com/rust-lang/rust/issues/114447>
>>       =3D note: this will be a hard error in the 2024 edition
>>       =3D note: this shared reference has lifetime `'static`, but if the=
 static ever gets mutated, or a mutable reference is created, then any furt=
her use of this shared reference is Undefined Behavior
>>       =3D note: `#[warn(static_mut_refs)]` on by default
>>     help: use `addr_of!` instead to create a raw pointer
>>       |
>>     4 |     let x =3D unsafe { addr_of!(foo) };
>>       |                      ~~~~~~~~~~~~~
>>
>> [1]: https://play.rust-lang.org/?version=3Dstable&mode=3Ddebug&edition=
=3D2021&gist=3Dc914a438938be6f5fc643ee277efa1d1
>>
>> So I think we should start using `addr_of!` for mutable static now.
>=20
> Oh. Thanks for the pointer.
>=20
> Hmm, `addr_of_mut!` still requires the unsafe block. Hopefully that goes
> away as well with the feature you linked as well.

I think that will take some time until it is gone.

> This also requires `const_mut_refs`, but as I recall that is going to be
> stabilized soon.

That should only be needed if you need `addr_of_mut!`, but IIUC, you
only need `addr_of!`, right?

---
Cheers,
Benno

