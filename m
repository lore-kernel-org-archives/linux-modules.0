Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E8C44A411
	for <linux-modules@vger.kernel.org>; Sun, 11 Oct 2026 13:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791723661; cv=none; b=ImtDafwpWPFX7pZpIu0Muf633ZwQz2bWEIGg76gvJqi86V2qXYrIeN3BGQIgmpwjxB8ook1Pps3ZPTgZa28IqetbSu0TQ7afKhD9ZCyouVQxJYXxAVXeq3Dm0fyn1ow4EtS3csh81X2NXVwpSu93hpiTREArBQaklL/wGpSQk/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791723661; c=relaxed/simple;
	bh=WY1FYnWP8y5ybfNL1abpmvLYd0jVLf+Cna+ptCkyEi4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Kgfo9JpsgipnTYb1JrBufUo2TQ/nMUM7a9RPMgPkaEu86SBmrMhLarRW8u+iU91hJTsg4dROoo0AM11w2vPyl4EfHAJR4AyKe2ayhSyka5B9zZRvyCpZ8Cx8o7WLPXlGI+/kBUh86ln9/Z/Gqyx3PH/h3LVdl/Ecyd5+opupqoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a622NWlw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a622NWlw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E3B1F0089B;
	Sun, 11 Oct 2026 13:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791723658;
	bh=BrXteX7wUGBjdpCZ8B0QoQ10BhkLwgLIi5H9xjP+hgg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a622NWlwxtcDG5GokItMHYBi9GQhKwHTDpfFXNq5j7IgQwZm82IGi2rfFI2MDgLDs
	 KIA3RLOT5ZnPSbw3ssHfkLk8QW+673Z3NJtbx0/QpkZx23ojPbgVV4ftpQPLcG2wmf
	 apfEz+E3BSVnHUvdFqXYvy483MMkEjhSRpgRsDTg/PWbnGVSxrwuUWQWbQ/sTFgD7o
	 5KKsD2SjZxU9RYh/3NHo/06k1ejfpKyYv40mf7f5ZGb+jFvm0T6520pwPxh3LVrY01
	 3bgbR1vAYAKHn4jaXtUTLdlIEPMbL113IrzzrplvXdAYBeSPYulpyeEL+hKjnpR/Nl
	 LsssqMfOW1kwA==
Message-ID: <sashiko-outbox-167236@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 02/11] rust: sync: atomic: Add Atomic<u{8,16}>
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <linux@weissschuh.net>
Cc: gary@garyguo.net, linux-modules@vger.kernel.org, "Petr Pavlu" <petr.pavlu@suse.com>, ojeda@kernel.org
In-Reply-To: <20261011-rust-dyndbg-v1-2-832e4039b71f@weissschuh.net>
References: <20261011-rust-dyndbg-v1-0-832e4039b71f@weissschuh.net>
 <20261011-rust-dyndbg-v1-2-832e4039b71f@weissschuh.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 13:00:57 +0000
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] rust: test coverage regression: u32 dropped from atomic_arithmetic_=
tests
- [Low] rust: dead code: unusable AtomicAdd implementations for u8 and u16
--

commit bff46a0936305602d6b5e98e2a29f7e77f8ccefc
Author: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

rust: sync: atomic: Add Atomic<u{8,16}>
   =20
Add generic atomic support for small unsigned integers that have an
AtomicImpl with the same size and alignment. Also extend the unit tests.

> diff --git a/rust/kernel/sync/atomic/predefine.rs b/rust/kernel/sync/atom=
ic/predefine.rs
> index 3d63f40791fa2..4c1fb5e08dc26 100644
> --- a/rust/kernel/sync/atomic/predefine.rs
> +++ b/rust/kernel/sync/atomic/predefine.rs
> @@ -113,6 +113,32 @@ fn rhs_into_delta(rhs: isize) -> isize_atomic_repr {
>      }
>  }
> =20
> +// SAFETY: `u8` and `i8` has the same size and alignment, and `u8` is ro=
und-trip transmutable to
> +// `i8`.
> +unsafe impl super::AtomicType for u8 {
> +    type Repr =3D i8;
> +}
> +
> +// SAFETY: The wrapping add result of two `i8`s is a valid `u8`.
> +unsafe impl super::AtomicAdd<u8> for u8 {
> +    fn rhs_into_delta(rhs: u8) -> i8 {
> +        rhs as i8
> +    }
> +}

[Severity: Low]
Does this implementation for u8 result in unusable dead code?

Since the Repr type for u8 is i8, and i8 lacks an AtomicArithmeticOps
implementation, it seems impossible to call arithmetic methods like fetch_a=
dd
or add on Atomic<u8>.

> +// SAFETY: `u16` and `i16` has the same size and alignment, and `u16` is=
 round-trip transmutable to
> +// `i16`.
> +unsafe impl super::AtomicType for u16 {
> +    type Repr =3D i16;
> +}
> +
> +// SAFETY: The wrapping add result of two `i16`s is a valid `u16`.
> +unsafe impl super::AtomicAdd<u16> for u16 {
> +    fn rhs_into_delta(rhs: u16) -> i16 {
> +        rhs as i16
> +    }
> +}

[Severity: Low]
Does this implementation for u16 also result in unusable dead code?

Similar to u8, the Repr type i16 lacks an AtomicArithmeticOps implementatio=
n,
preventing the use of atomic arithmetic methods on Atomic<u16>.

[ ... ]

> @@ -263,7 +289,7 @@ fn atomic_cmpxchg_tests() {
> =20
>      #[test]
>      fn atomic_arithmetic_tests() {
> -        for_each_type!(42 in [i32, i64, u32, u64, isize, usize] |v| {
> +        for_each_type!(42 in [i32, i64, u64, isize, usize] |v| {

[Severity: Low]
Is u32 intentionally dropped from the list of types tested here?

This appears to cause a regression in test coverage for 32-bit unsigned ato=
mic
arithmetic operations.

>              let x =3D Atomic::new(v);
> =20
>              assert_eq!(v, x.fetch_add(12, Full));

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011-rust-dyndb=
g-v1-0-832e4039b71f@weissschuh.net?part=3D2
