Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8183E10E6;
	Sun, 25 Aug 2024 07:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724569793; cv=none; b=dbCbQImFhFpqkqneNG1W5nAJZ4RapF7274jaxL4dG3tHyacLuHQmd0byUYBskoGgsazQoFOSy9HHUVXnrdEAVacirtaowghUnzfIfriYuTJt3gperdKebLNoIEpyqEhzEfaAkRhnzKuU7vj+keuBsZXW2SCVvqrfos5KNCry/XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724569793; c=relaxed/simple;
	bh=cQRnn1n1kkZVLNeZfQxh11rL+9kptIzgU5EFR5FoQSE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kyhn2/8CgJonBPt9JdguKJCp+SbIlQe8iLZmDkWkk5PxMPv8Ecq9apVtBiaaynXsYQ0EtrjMVngXz3KGV03jtUB5Uwa5JqtQN5uGOYeQFukw+nEDil9WqtqeSC6crvYVTrkF/Ial5N56Uzgu4IV1IelgeT8WtXYYgVWSvar1Tbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=UI/Gpgn9; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="UI/Gpgn9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1724569788; x=1724828988;
	bh=r+JlGWakdNmuWvqHZkN1l/8TkAJmG126UQ/vIF8Paus=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=UI/Gpgn9m1bvR+faB1ZPCWnmc212U88gAqG/cEciQ4anN6v09Apuxit4sAUqIr9+j
	 N52ZVLbAZ/doSsmNI1gpyTCb8tWQgVilGqO83sQMKW+baQylnLWS+MfB9IfyEIgf/T
	 PiQEu9Sj6XVkZaS86y4oZE+1NuzOv1OXk3REVf/FIcxHNwR5atx/dGzieCLBZo9xya
	 CnTXIRPNrYL1jkRGcuT80Zhk4mH+GfEPO1Uw2i+F/hsmTtYHtti/Pg0suJZaPg8n66
	 eHLgFu2dkJwe4LDy32nv00spoUvlZbfwVAZ7QkBojwdTkOnSnKyJZOjFM+rRhGbpEF
	 TwtbB3cK1j+qQ==
Date: Sun, 25 Aug 2024 07:09:45 +0000
To: Trevor Gross <tmgross@umich.edu>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Andreas Hindborg <nmi@metaspace.dk>, Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Adam Bratschi-Kaye <ark.email@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Daniel Gomez <da.gomez@samsung.com>, rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rust: add `module_params` macro
Message-ID: <9eea4df8-09aa-4067-b408-2aa86c7f4084@proton.me>
In-Reply-To: <CALNs47tLRa4uVU8t8w6=oi+sMPxEVdw5GQdLwpatc-kEREQg6A@mail.gmail.com>
References: <20240819133345.3438739-1-nmi@metaspace.dk> <CALNs47sqt==o+hM5M1b0vTayKH177naybg_KurcirXszYAa22A@mail.gmail.com> <c5af692e-56e7-427f-81d5-8b887478aff1@proton.me> <CALNs47tLRa4uVU8t8w6=oi+sMPxEVdw5GQdLwpatc-kEREQg6A@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: d73dfc11e9ff9a9b2dea24f4c958c759cc107d01
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 24.08.24 23:23, Trevor Gross wrote:
> On Sat, Aug 24, 2024 at 8:16=E2=80=AFAM Benno Lossin <benno.lossin@proton=
.me> wrote:
>>> We shouldn't enable `const_mut_refs`. It is indeed close to
>>> stabilization, but it is still kind of churny right now and we don't
>>> want to enable the sharp edges everywhere.
>>>
>>> If the change from `static mut` to `UnsafeCell` that I mentioned above
>>> happens, `addr_of_mut!` turns into a `.get().cast::<...>()` takes the
>>> place of `addr_of_mut!` and doesn't require this feature (and also
>>> isn't unsafe).
>>
>> I think this is a good idea. There might only be a problem with not
>> being `Sync` though... So probably need to use `SyncUnsafeCell` instead.
>=20
> Ah whoops, yeah that is what I meant.
>=20
>>> If you prefer not to make that change, I think
>>> `addr_of!(...).cast_mut()` might be the best solution.
>>
>> Won't that be resulting in the wrong provenance? I.e. the pointer won't
>> be allowed to write to that location?
>>
>> I just checked with miri, it doesn't complain (even with
>> `strict-provenance`), so I guess it's fine? It feels rather wrong to me
>> to allow writing through a pointer obtained via `addr_of!`.
>=20
> I think that `static mut` gets the interior mutability rules that
> `UnsafeCell` has, that *const and *mut become interchangeable. Quick
> demo for the `UnsafeCell` at [1]. We would probably have to ask opsem
> to clarify.

I see. I suggested to Andreas to change it to the current version, seems
like I was wrong on this... I feel like the `SyncUnsafeCell` version is
still better, since we can avoid a `static mut`.

> Coincidentally I had been talking to Ralf about this very pattern
> before seeing this, at [2].
>=20
>>> Other thought: would a wrapper type make more sense here? Something lik=
e this:
>>>
>>> ```
>>> /* implementation */
>>> struct ModParam<T>(UnsafeCell<T>);
>>> [...]
>>> module! {
>>>     // ...
>>>     // instantiated as:
>>>     // `static MY_PARAM: ModParam<i64> =3D ModParam::new(1);`
>>
>> We used to do this, but it lead to problems: normally the parameter has
>> a lower case name, since that's the convention in the kernel. [...]
>=20
> To me it seemed logical to keep the uppercase names here since it
> matches the convention for what they are (statics), and the macro
> could lowercase it for the bits exposed to the kernel. But I
> absolutely get the consistency argument here.

That would also be an option, but it might be confusing for people, they
enter a SCREAMING_CASE_SNAKE name, but when they start the kernel it
doesn't work.

>> [...] But then
>> pattern matching prioritises the static instead of introducing it as a
>> local parameter:
>>
>>     let MY_PARAM =3D ...;
>>
>> would fail, since you can't match MY_PARAM.
>>
>> This is also the reason why they live in their own module.
>=20
> I'm not sure I follow the example here. It looks like it is shadowing
> a static's name as a local, why would you want that? Or if you meant
> the other way around `let SomePat(...) =3D MY_PARAM`, wouldn't it just
> be `let SomePat(...) =3D MY_PARAM.get()`? (Sorry if I missed some
> context here).

Yeah I expressed this poorly, the problem before was that you would
write:

    module! {
        /* ... */
        params: {
            foo: i64 {
                default: 1,
                description: "foo",
            }
        }
    }

    pub struct MyDriver {
        foo: i64,
    }

    impl Module for MyDriver {
        fn init(_: &'static ThisModule) -> Result<Self> {
            let foo =3D foo.read();
            //  ^^^ cannot be named the same as a static
            Ok(Self { foo })
        }
    }

>> But you can still do the modification of creating `ModParam` and using
>> that as the type of the static.
>=20
> Do you mean an expansion like this?
>=20
>     // module_parameters is kind of a long name
>     mod mod_params {
>         #[allow(non_upper_case_globals)]
>        static my_param: ModParam<i32> =3D ModParam::new(...);
>     }

Yes that's what I meant, although `my_param` should be `pub(crate)`.

> I don't mind that, even if the name is a bit weird by rust conventions.

Yeah, but I think since they are in their own module, it's fine.

One thing that we need to decide would be if we want

    mod_params::my_param::read()

or

    mod_params::my_param.read()

I slightly prefer the first one, which would mean that the expansion
would have to be:

    mod mod_params {
        pub(crate) enum my_param {}
        static my_param_value: ModParam<i32> =3D ModParam::new(...);
        impl my_param {
            pub(crate) fn read() {
                my_param_value.read()
            }
            /* ... */
        }
    }

> (For what it's worth, I used this wrapper type pattern for a plugin
> project that does shared variables in a similar way. I have been quite
> happy with it.)

Good to know!

---
Cheers,
Benno

>=20
> - Trevor
>=20
> [1]: https://play.rust-lang.org/?version=3Dstable&mode=3Ddebug&edition=3D=
2021&gist=3D43664620f50384b7a3d5bf74ce7c3e39
> [2]: https://rust-lang.zulipchat.com/#narrow/stream/146212-t-compiler.2Fc=
onst-eval/topic/More.20accidental.20stabilization

