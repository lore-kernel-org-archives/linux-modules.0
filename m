Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C537A140384;
	Sat, 24 Aug 2024 13:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724505369; cv=none; b=EYzOh3CE7c12X3c24M52SQtwCNXGI1FlA5aKbOqL/KNIYSsm0GKN4kybmg0/GCQ/nY1BNNv4CpO2R2jjExUTddwxnPLzrzzsgYWcR5BM1M3YJNVRbl00ASyc3MFeyRb0mE2DqmtUskR8QyznfB75oHDiVw33gb7qXCnsiG3bfoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724505369; c=relaxed/simple;
	bh=KcVkahOQAHCgnH2L7RB2u9h7jOUYfQ3P5fB58Qbo05s=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HkF2ErmD+gHajD6age2NSUEakd39OtGoibPtEtBbffyiTBQthqUPvw0F+c/51XX5vmZn+Siy+8SJcBxSqxPMblq6Heii7OfbeEks5Z15C+5sOTlEPkjdSDuWwMahIM4D2oaytgmSx2WW84ojNb6v+lm90X75dTc6JVXp14au268=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=LQGEZQYH; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="LQGEZQYH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1724505357; x=1724764557;
	bh=MNUaaX3dPERPXelDUWvXcBEDKs1aN2nvZe3FiuJzQkg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=LQGEZQYHui43ng9E6pn4fXxe89/jr0wdcZ17CZMmBuWD54f4roN+mshuA+S2qa24T
	 7DN5oLoQOXidOGH8uwn2sLKK70e9+DxEL2IWQ3U71gnYhPSAyxg3Fvb9lGVTxpeCr7
	 6Mf0WE7LU0i0h10s0KM7AlOwCh6AiuPSaxHrXCKAHxcbrci1vHzNMpDYNR6t/eaxkE
	 szoNJWPKn5K4uC9HsqnQcIJiwW/IQcwV2XMtYBpizqL/FEoFWF8MJ0g0We8JSDUI+y
	 xfvlKw1sAwYt67zv/YBK6f4u8e3OLxSUs96pEZL6fX/ljLQy0fYmbK1j5JtENcnEnY
	 LZhIi2Mp6vQFg==
Date: Sat, 24 Aug 2024 13:15:52 +0000
To: Trevor Gross <tmgross@umich.edu>, Andreas Hindborg <nmi@metaspace.dk>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Adam Bratschi-Kaye <ark.email@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Daniel Gomez <da.gomez@samsung.com>, rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rust: add `module_params` macro
Message-ID: <c5af692e-56e7-427f-81d5-8b887478aff1@proton.me>
In-Reply-To: <CALNs47sqt==o+hM5M1b0vTayKH177naybg_KurcirXszYAa22A@mail.gmail.com>
References: <20240819133345.3438739-1-nmi@metaspace.dk> <CALNs47sqt==o+hM5M1b0vTayKH177naybg_KurcirXszYAa22A@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: cb691d3f725873ce2abe5665717caa34ed3313be
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 24.08.24 13:27, Trevor Gross wrote:
> On Mon, Aug 19, 2024 at 8:35=E2=80=AFAM Andreas Hindborg <nmi@metaspace.d=
k> wrote:
>> From: Andreas Hindborg <a.hindborg@samsung.com>
>> +                write!(
>> +                    self.param_buffer,
>> +                    "
>> +                static mut __{name}_{param_name}_value: {param_type} =
=3D {param_default};
>=20
> Ah.. we need to migrate from `static mut` to `UnsafeCell` wrappers at
> some point. Since `module!` already uses `static mut`, this may need

IIRC Alice wanted to do something about that.

> to happen separately - meaning I don't think we need to block on
> making any change here.
>=20
> This would mean adding an `UnsafeSyncCell` / `RacyCell` (just a
> wrapper around `UnsafeCell` that always implements `Sync`), using
> `UnsafeSyncCell<{param_type}>` as the type here, and changing from
> `static mut` to just `static`.
>=20
> (I can take a look at doing this change for existing `static mut` in
> the near future).
>=20
>> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
>> index efacca63c897..a65bd0233843 100644
>> --- a/scripts/Makefile.build
>> +++ b/scripts/Makefile.build
>> @@ -263,7 +263,7 @@ $(obj)/%.lst: $(obj)/%.c FORCE
>>  # Compile Rust sources (.rs)
>>  # ---------------------------------------------------------------------=
------
>>
>> -rust_allowed_features :=3D new_uninit
>> +rust_allowed_features :=3D new_uninit,const_mut_refs
>=20
> We shouldn't enable `const_mut_refs`. It is indeed close to
> stabilization, but it is still kind of churny right now and we don't
> want to enable the sharp edges everywhere.
>=20
> If the change from `static mut` to `UnsafeCell` that I mentioned above
> happens, `addr_of_mut!` turns into a `.get().cast::<...>()` takes the
> place of `addr_of_mut!` and doesn't require this feature (and also
> isn't unsafe).

I think this is a good idea. There might only be a problem with not
being `Sync` though... So probably need to use `SyncUnsafeCell` instead.

> If you prefer not to make that change, I think
> `addr_of!(...).cast_mut()` might be the best solution.

Won't that be resulting in the wrong provenance? I.e. the pointer won't
be allowed to write to that location?

I just checked with miri, it doesn't complain (even with
`strict-provenance`), so I guess it's fine? It feels rather wrong to me
to allow writing through a pointer obtained via `addr_of!`.

> ---
>=20
> Other thought: would a wrapper type make more sense here? Something like =
this:
>=20
> ```
> /* implementation */
> struct ModParam<T>(UnsafeCell<T>);
>=20
> // `Parameter` is the existing `ModParameter` (could be
> // any name). It could be sealed.
> impl<T: Parameter> ModParam<T> {
>     #[doc(hidden)] // used in the macro
>     fn new(value: T) -> Self { ... }
>=20
>     fn get(&self) -> T::Value { ... }
>     fn set(&self, v: T::Value) { ... }
> }
> ```
>=20
> With usage:
>=20
> ```
> module! {
>     // ...
>     // instantiated as:
>     // `static MY_PARAM: ModParam<i64> =3D ModParam::new(1);`

We used to do this, but it lead to problems: normally the parameter has
a lower case name, since that's the convention in the kernel. But then
pattern matching prioritises the static instead of introducing it as a
local parameter:

    let MY_PARAM =3D ...;

would fail, since you can't match MY_PARAM.

This is also the reason why they live in their own module.

But you can still do the modification of creating `ModParam` and using
that as the type of the static.

---
Cheers,
Benno

>     MY_PARAM: i64 {
>         default: 1,
>         description: "foo",
>     },
> }
>=20
> fn foo() {
>     pr_info!("My param is {}", MY_PARAM.get());
> }
> ```
>=20
> Advantages I see:
> - You bring your own name, rather than being scoped and needing to
> remember the module name
> - You can check `ModParam` in the docs to see the API, rather than
> needing to refer to source for the exact signatures of `read` and
> `write`
> - The interface gets a bit more like a mutex or atomic
>=20
> - Trevor

