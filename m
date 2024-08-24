Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B0A29A1
	for <linux-modules@vger.kernel.org>; Sat, 24 Aug 2024 21:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724534634; cv=none; b=ZRuCZ3rMWdUcO8fI8qYtmGOQMgDlRQ7Q/coTDqPoeYBBsRvelmKOqy3LMJNrmIV0sZ6ijNpkgHhNTArBeVdML5mn9B20n3qnSs5Cy+iadDBjdB08teYyRmrK0DSAFBdUGt35ZKNvjKR3LxVx9BDG49s4i+Anzij43NIDlVhPRhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724534634; c=relaxed/simple;
	bh=wr2wQo5KphEVul+LT19DjVzQDnhc+9gcfmV/iZtPUc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hx5y8UFTXLmo+9nsgYmiHMH4cyCuPbvR3460Ay4j2tLYUgCTU2D9d+1YeNr48MTL2mg66xcz6tSbTPG8yjNm25pdlBCXKPEhF8BYDgOyjc90AAD16w7YdkPdKuzXpYCT4L/VV7yShj1hkZSytM5Um4c0opnRfZRYcy71GqfhTpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=HUIuhIN5; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="HUIuhIN5"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6c0e22218d0so34066107b3.0
        for <linux-modules@vger.kernel.org>; Sat, 24 Aug 2024 14:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1724534631; x=1725139431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UZpJ0AOJ+7UfacrtyOhzZPyuAKMCYDAPDE/XRFNLE6w=;
        b=HUIuhIN5LL4DDPrmeOmB4Sa5qoGa84BW6iFBnq5EH+MOprNY0NEdd/cLt53kRlYntb
         SGc5/rhQmeumDKvQH9CE6JlWRn2m4Q2TK6Gt2RaqZbLCliT5DemOoMuTOuj7lsQm0vt/
         TJdYD0ZNjhSTtcU21OcQKqKgbMHgLlKCHEnkERRtUsGiZ2EWs5VUAaoheCoh9uGw4/RK
         nzjadycJ9tGmNFKePyxem7pVtObmdXQSImCrF6/ouV9Tw+5rUgmcgAl2HPMur/R0U2+d
         nGvuLWY+cTeQlA9MAazYQ9rPljs/ShCCCoWkn0Qrk/xl+2BeTNHXe7sb8P1QX0myqM98
         Dycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724534631; x=1725139431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UZpJ0AOJ+7UfacrtyOhzZPyuAKMCYDAPDE/XRFNLE6w=;
        b=Pa0ZXlOSeJW2WFgYEgXmRhNAW0NO8p64VIm5Td6o2jGous69a/pf5FPCCAZ0Xs7/vQ
         C5fM91Zb1et4cC6L151VZ8R1xrQNXxG3v+YNk2qP7njikolbRy5LQ7RNs1GtPar6ceiT
         LLgpqUqzeQhgMo6YwRiBFTu4HDTwHrQLLuNEoPH9vNmp/y0cSHvHoIMDKGxBaMSH9k0o
         4t3zbN7JYMzWqdYkFKneMlp6fU64DIJYtQoiYbay1O8oyLsNfuXO7RIX2AvNO4mp23TL
         Q2lp6biOzjlHF8I+9TgZEGT8il27ja3BQ0Gu4js9hH9TZ9NeLBHDaTeUiEMl/s08uQFm
         3tmw==
X-Forwarded-Encrypted: i=1; AJvYcCWDGa49aDOf3SkZ5TAloK38FFgBrbtgXcv3b6zE78TYH13lJzGg4UgpWFi4qYrthUC34USy9OotL0at87Fc@vger.kernel.org
X-Gm-Message-State: AOJu0YwZd4SFjOX9ng2iKXpngNwILKXEFJu62is3uWKt5aStmK0z49hW
	jYwHHx2GgO8LIpqVoTRl0yeFb3Xh0h0X7WS9EBhPT5hVCpagZmaJK0oAA4H29DGMTcqAZEyIZaU
	ywXsHo4yh158VILHPVa7Ja80Paan+rKOEHlAuWw==
X-Google-Smtp-Source: AGHT+IHPFk8rIY007r1frs+UxSooLPtvtsc4X/SxiDYqZWSyAqPLS1X9VDQpN4STqYDh1h2tsL7cOkJJ6Yky9M3atYw=
X-Received: by 2002:a05:690c:398:b0:6c8:1e30:513f with SMTP id
 00721157ae682-6c81e3054e1mr41362477b3.23.1724534631045; Sat, 24 Aug 2024
 14:23:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819133345.3438739-1-nmi@metaspace.dk> <CALNs47sqt==o+hM5M1b0vTayKH177naybg_KurcirXszYAa22A@mail.gmail.com>
 <c5af692e-56e7-427f-81d5-8b887478aff1@proton.me>
In-Reply-To: <c5af692e-56e7-427f-81d5-8b887478aff1@proton.me>
From: Trevor Gross <tmgross@umich.edu>
Date: Sat, 24 Aug 2024 16:23:40 -0500
Message-ID: <CALNs47tLRa4uVU8t8w6=oi+sMPxEVdw5GQdLwpatc-kEREQg6A@mail.gmail.com>
Subject: Re: [PATCH v2] rust: add `module_params` macro
To: Benno Lossin <benno.lossin@proton.me>
Cc: Andreas Hindborg <nmi@metaspace.dk>, Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Adam Bratschi-Kaye <ark.email@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Alice Ryhl <aliceryhl@google.com>, Daniel Gomez <da.gomez@samsung.com>, 
	rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 24, 2024 at 8:16=E2=80=AFAM Benno Lossin <benno.lossin@proton.m=
e> wrote:
> > We shouldn't enable `const_mut_refs`. It is indeed close to
> > stabilization, but it is still kind of churny right now and we don't
> > want to enable the sharp edges everywhere.
> >
> > If the change from `static mut` to `UnsafeCell` that I mentioned above
> > happens, `addr_of_mut!` turns into a `.get().cast::<...>()` takes the
> > place of `addr_of_mut!` and doesn't require this feature (and also
> > isn't unsafe).
>
> I think this is a good idea. There might only be a problem with not
> being `Sync` though... So probably need to use `SyncUnsafeCell` instead.

Ah whoops, yeah that is what I meant.

> > If you prefer not to make that change, I think
> > `addr_of!(...).cast_mut()` might be the best solution.
>
> Won't that be resulting in the wrong provenance? I.e. the pointer won't
> be allowed to write to that location?
>
> I just checked with miri, it doesn't complain (even with
> `strict-provenance`), so I guess it's fine? It feels rather wrong to me
> to allow writing through a pointer obtained via `addr_of!`.

I think that `static mut` gets the interior mutability rules that
`UnsafeCell` has, that *const and *mut become interchangeable. Quick
demo for the `UnsafeCell` at [1]. We would probably have to ask opsem
to clarify.

Coincidentally I had been talking to Ralf about this very pattern
before seeing this, at [2].

> > Other thought: would a wrapper type make more sense here? Something lik=
e this:
> >
> > ```
> > /* implementation */
> > struct ModParam<T>(UnsafeCell<T>);
> > [...]
> > module! {
> >     // ...
> >     // instantiated as:
> >     // `static MY_PARAM: ModParam<i64> =3D ModParam::new(1);`
>
> We used to do this, but it lead to problems: normally the parameter has
> a lower case name, since that's the convention in the kernel. [...]

To me it seemed logical to keep the uppercase names here since it
matches the convention for what they are (statics), and the macro
could lowercase it for the bits exposed to the kernel. But I
absolutely get the consistency argument here.

> [...] But then
> pattern matching prioritises the static instead of introducing it as a
> local parameter:
>
>     let MY_PARAM =3D ...;
>
> would fail, since you can't match MY_PARAM.
>
> This is also the reason why they live in their own module.

I'm not sure I follow the example here. It looks like it is shadowing
a static's name as a local, why would you want that? Or if you meant
the other way around `let SomePat(...) =3D MY_PARAM`, wouldn't it just
be `let SomePat(...) =3D MY_PARAM.get()`? (Sorry if I missed some
context here).

> But you can still do the modification of creating `ModParam` and using
> that as the type of the static.

Do you mean an expansion like this?

    // module_parameters is kind of a long name
    mod mod_params {
        #[allow(non_upper_case_globals)]
       static my_param: ModParam<i32> =3D ModParam::new(...);
    }

I don't mind that, even if the name is a bit weird by rust conventions.

(For what it's worth, I used this wrapper type pattern for a plugin
project that does shared variables in a similar way. I have been quite
happy with it.)

- Trevor

[1]: https://play.rust-lang.org/?version=3Dstable&mode=3Ddebug&edition=3D20=
21&gist=3D43664620f50384b7a3d5bf74ce7c3e39
[2]: https://rust-lang.zulipchat.com/#narrow/stream/146212-t-compiler.2Fcon=
st-eval/topic/More.20accidental.20stabilization
