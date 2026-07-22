Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6AB47010E
	for <linux-modules@vger.kernel.org>; Wed, 22 Jul 2026 09:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784712431; cv=none; b=qoHkB5j1E01FjQ73ft/j4Hnb8XYYwDSf3l0L0TJJLXMKqg2Bl5wj1vz0sfGIy0x3KTx1mXVxA+q8svtokMzz+FpNFZxOQqOSugvgKgfPWLu3sXZ3GgMWZccFq5M380Qp6dkZor1N0cWlbf2ImJALidpVjj287kbZObULPMX4V0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784712431; c=relaxed/simple;
	bh=F+GzksK2oouwMq3r+M8RdrTYyYjSSyJ72/lhzw8nlkk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U1bQhnSe0TeYDUGxaHKhF662rU+XWBK5QsmwC3u2fumLtadARKmugAavKa+8qAtzu+QQ4jIaoc5zMOFgoSii1MOu5KhrqwgHnKYcaZGmOdV59LqZN7G2z9K8cxHkhEcc8ujbIqNHYdCy9xtCaRwjXo5vChStVmuvX+jSJbUf3jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vv7+kT7S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vv7+kT7S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C68C51F00A3A;
	Wed, 22 Jul 2026 09:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784712430;
	bh=mJDsLfssyJp91KytEB1R2AuihUas7/cZVTkE3fR1Xng=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vv7+kT7SGHXVvLtVaeK77XUYak4S27pZjV7tyZvSKdV8NlY1iPhqoWWaBgxzhVKqT
	 yv/GlHBjnkh/RidA6Oe90exo6/1dXOmWWbahA7NLVEqoLuzDsA0DnbEe9ypQAkPkfS
	 fJZzB25gmLgBvplnirmyw2pGOXjRlltZCypvRG7IK8dZjAib8wwmtKR1wx9N/AtxtG
	 auU6dTRUOli2Xe7+rroSjMxSPCqEkefaK7j2xDC7Xv7r9jAa+oPXRgWEn+vRqQRbA5
	 aaHd5YN1H5TuxRy5E+89FLYfpV0wkH4CCVBDW5CHLaM43vvBGdn8vUI7SCiofjLXs1
	 8mm4PZYg1MD2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] rust: sync: add SetOnce::try_get_or_populate()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alice Ryhl" <aliceryhl@google.com>
Cc: linux-modules@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260722-setonce-populate-v1-2-fa7455c26c42@google.com>
References: <20260722-setonce-populate-v1-0-fa7455c26c42@google.com>
 <20260722-setonce-populate-v1-2-fa7455c26c42@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 09:27:09 +0000
Message-Id: <20260722092709.C68C51F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Optimistic, unlocked execution of the initialization closure `f()`=
 leads to duplicate side-effects and spurious TOCTOU initialization failure=
s.
--

--- Patch [2]: [PATCH 2/3] rust: sync: add SetOnce::try_get_or_populate() -=
--
commit fa04209af44f9b7b6642f550eaec6a8a1f95a58a
Author: Alice Ryhl <aliceryhl@google.com>

rust: sync: add SetOnce::try_get_or_populate()

This commit introduces a try_get_or_populate() helper to SetOnce. The new
method allows callers to use a user-provided lock to avoid spinning on the
internal atomic state during concurrent initialization.

> diff --git a/rust/kernel/sync/set_once.rs b/rust/kernel/sync/set_once.rs
> index a78f8c8e87dbf..d9cc598a8d78f 100644
> --- a/rust/kernel/sync/set_once.rs
> +++ b/rust/kernel/sync/set_once.rs

[ ... ]

> @@ -104,6 +111,34 @@ pub fn populate(&self, value: T) -> Result<&T, T> {
>          }
>      }
> =20
> +    /// Get the value, or populate it if it's missing.
> +    ///
> +    /// This method is useful to avoid spinning on the internal atomic s=
tate. If all writers call
> +    /// this method with the same lock, then they are synchronized with =
each other and it's
> +    /// guaranteed that no caller will attempt to invoke [`SetOnce::popu=
late`] more than once.
> +    pub fn try_get_or_populate<F, E, U, B>(&self, lock: &lock::Lock<U, B=
>, f: F) -> Result<&T, E>
> +    where
> +        B: lock::Backend,
> +        F: FnOnce() -> Result<T, E>,
> +    {
> +        if let Some(value) =3D self.as_ref() {
> +            return Ok(value);
> +        }
> +
> +        let mut to_insert =3D f()?;
         ^^^^

[Severity: High]
Could this introduce a regression where evaluating f() outside the lock
risks duplicate side-effects?

If multiple threads call try_get_or_populate() concurrently on an
uninitialized SetOnce, they could both bypass the initial as_ref() check
and execute f() simultaneously. If f() performs operations like allocating
hardware resources or registering IDs, wouldn't those occur multiple times
before reaching the lock?

Additionally, if thread A successfully initializes the value inside the lock
but thread B subsequently fails during its concurrent evaluation of f(), the
? operator will immediately return the error. Does this cause thread B to
erroneously fail and propagate the error, even though the SetOnce is now
fully populated by thread A?

> +        loop {
> +            if let Some(value) =3D self.as_ref() {
> +                return Ok(value);
> +            }
> +
> +            let _guard =3D lock.lock();
> +            match self.populate(to_insert) {
> +                Ok(value) =3D> return Ok(value),
> +                Err(ret) =3D> to_insert =3D ret,
> +            }
> +        }
> +    }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722-setonce-po=
pulate-v1-0-fa7455c26c42@google.com?part=3D2
