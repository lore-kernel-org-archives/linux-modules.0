Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C9F35C691
	for <linux-modules@vger.kernel.org>; Wed, 22 Jul 2026 09:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784712182; cv=none; b=bD63TQecSGZgOikow3ctnm7o352VGvETaxQYhmg2PdDGnoK+RL52IwU5eE54ElTDci4Jym8rl6TzkXENYrklZHTEn47vJn7ZYYevYSCuB/CehRBA3jc8vEq2AJ/cgyflTF/6MzNDGauF9TRI22WTvDodL93+P1/SW97xpvfwJQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784712182; c=relaxed/simple;
	bh=V0I1EAHV+NuBrvoOUSZc5S8m2kG4dZFs+BbyKDyHurQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MkOj0lSEpb/RtbHp/q1vRZD5/D/4HxgN6WAVIUj3JS8qqe/lttC8cS5SYbcZDvNciTGcL3UOggpXzBOJ5egClwuaQRXSjohtoeRSch/ypmgOtMMtJK/6MkEx/4gkjBxZ26ub5yFJm2CYpj0JFWnrsnqwTqeOO8K3dHncHGlSWIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvyJSZD3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvyJSZD3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B01D1F000E9;
	Wed, 22 Jul 2026 09:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784712181;
	bh=eFVV1Ht+BGMMtfd+hJ9Ahgbt9AswwCXnIEjWHvS4E60=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dvyJSZD3X5TuERSHWxtrjW/CgN0nHre8TgpKeYJ8DND/+4B+GbsOv0DCGQOUBXNyu
	 TB2Mamvz3X69toytfRmoub9dJEigoVVApjjEpL039WjaypJHmRebT6N1TqR2oA9vG0
	 iZ/+Y4ahFX14RGYwbpRsrEzq3OuiZ4zrJkqqfvmUwqDszROEOYeFbgUvXvPirqER4n
	 DyGs2Hbzb3IgDY6GMk8ubdN8Bw9LFMFaQK/NS4L5j98jenoT7+dQfDigpst3y8DWZN
	 Zf1kDIaa+rjokpe71Xhn+ueU+Jp0Fxf2ceULIpQ9NWEK0j4c/majux0AtLFn62sakr
	 +MEqnhKt29Afg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] rust: sync: return `Result<&T, T>` from
 `SetOnce::populate()`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alice Ryhl" <aliceryhl@google.com>
Cc: ojeda@kernel.org, linux-modules@vger.kernel.org
In-Reply-To: <20260722-setonce-populate-v1-1-fa7455c26c42@google.com>
References: <20260722-setonce-populate-v1-0-fa7455c26c42@google.com>
 <20260722-setonce-populate-v1-1-fa7455c26c42@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 09:23:00 +0000
Message-Id: <20260722092301.1B01D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `ModuleParamAccess` lacks `#[repr(C)]`, leading to potential Undef=
ined Behavior and memory corruption when its pointer is cast to `SetOnce<T>=
`.
--

--- Patch [1]: [PATCH 1/3] rust: sync: return `Result<&T, T>` from `SetOnce=
::populate()` ---
commit e0d10f7a2c42bcda24ee9851cc2fda3d4c4bc480
Author: Alice Ryhl <aliceryhl@google.com>

rust: sync: return Result<&T, T> from SetOnce::populate()

This commit changes the return value of SetOnce::populate() from a boolean
to a Result to allow infallible access to the inserted value on success.
It also ensures the inserted value is not dropped under a lock if populate()
fails, and updates ModuleParam and Binder to handle the new return type.

> diff --git a/rust/kernel/module_param.rs b/rust/kernel/module_param.rs
> index 6541af218390c..8f0bd085badfe 100644
> --- a/rust/kernel/module_param.rs
> +++ b/rust/kernel/module_param.rs
> @@ -77,10 +77,10 @@ pub trait ModuleParam: Sized + Copy {
>          // SAFETY: By function safety requirements, this access is safe.
>          let container =3D unsafe { &*((*param).__bindgen_anon_1.arg.cast=
::<SetOnce<T>>()) };

[Severity: High]
This is a pre-existing issue, but since we are modifying this code block, is
it safe to cast this void pointer directly to SetOnce<T>?

Looking at the definition of ModuleParamAccess<T>, it lacks a #[repr(C)]
annotation:

rust/kernel/module_param.rs:ModuleParamAccess {
    value: SetOnce<T>,
    default: T,
}

Since it uses the default Rust layout, the compiler is free to reorder these
fields. When as_void_ptr() passes a pointer to the entire struct into the
C kernel parameters API:

rust/kernel/module_param.rs:ModuleParamAccess::as_void_ptr() {
    core::ptr::from_ref(self).cast_mut().cast()
}

And set_param casts it back directly to SetOnce<T> (assuming it sits at
offset 0), could this lead to memory corruption if the compiler decides to
place default before value?

> -        container
> -            .populate(new_value)
> -            .then_some(0)
> -            .ok_or(kernel::error::code::EEXIST)
> +        match container.populate(new_value) {
> +            Ok(_) =3D> Ok(0),
> +            Err(_) =3D> Err(EEXIST),
> +        }
>      })
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722-setonce-po=
pulate-v1-0-fa7455c26c42@google.com?part=3D1
