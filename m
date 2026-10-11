Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4F22AD03
	for <linux-modules@vger.kernel.org>; Sun, 11 Oct 2026 13:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791723684; cv=none; b=q1GlOUOW4xnljRpZMec7D9T88hCldwWPNyvljsa4D028ivubDpC6DkfPJaHJyeFtNXgowuve1ZA7M91qn7O0pkCyw9JQOGYC0hplKQmppoKFXwcBpMcTghOuzJji6ymDjqPUUM5qmLjgyXqcWB/WArTZGClF3MtH+S16mNPCTEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791723684; c=relaxed/simple;
	bh=OEVBkLqYykcE/+jx4rbQHGQR1bljNkG4f/vxgOQMwG0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=qqMv7IyTuCAJ68gfhQdB4VhbW7zOF6zoDF0O42q6Xh2n3b82CiBzdPjc09gbA9zi0wSEWJl07K56biVfySkfk9leSj8j8yTky+y3SjV9yNC3Ux+Uftxv3SccuQeG15fochjKmIGxO8tmtlh+ELStCAeOPa9Muazbta0Bc4wQOu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXBTcm2H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXBTcm2H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0711F0089C;
	Sun, 11 Oct 2026 13:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791723674;
	bh=xJxHkzyMyiickXnDvtnhNNGQFzhvZOOCEwkYL8YuDfs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oXBTcm2HmZomKhx1I0YHG2XUzUY2a2SrYeY7jgqKuWN8OEXO+t14I5HOvETEI53/C
	 5Dm/MUtSEo0bSHkl/usTRT7dmLYauqDAlPetHgUo3MHJs4TwY2/7XC3D0qvq2CVJWk
	 GsH4+zZeiiVaqQKvU4QsXRh2MiPgIHaU+WulZkZf3O5lM1ExgHh+4kpdMpZdy27/Bx
	 G54RXhULSCFYoyTGBE2YcfKLk0HX5+h4jSAdxibky3ygsmurcnXPFx83CDywVRwztY
	 at58mFawxZIlYy2vkRRkPcc+4Zp5DmE9vvsygVEQ1n4EViSPQKamyCTaDUY8kw1fCt
	 WOi18bU1DyQBw==
Message-ID: <sashiko-outbox-167237@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 10/11] rust: device: remove logging methods
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <linux@weissschuh.net>
Cc: ojeda@kernel.org, "Petr Pavlu" <petr.pavlu@suse.com>, linux-modules@vger.kernel.org, gary@garyguo.net
In-Reply-To: <20261011-rust-dyndbg-v1-10-832e4039b71f@weissschuh.net>
References: <20261011-rust-dyndbg-v1-0-832e4039b71f@weissschuh.net>
 <20261011-rust-dyndbg-v1-10-832e4039b71f@weissschuh.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 13:01:13 +0000
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] rust: dev_dbg!: unconditional evaluation of formatting arguments
- [Low] rust: Device::printk missing #[inline] attribute
--

commit b813060ef1de2d7eca47689d919683f6792237c4
Author: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
Subject: rust: device: remove logging methods

This commit removes the logging wrapper methods from the Device struct, mov=
ing
the logic into macros that directly call Device::printk. This change allows
the dynamic debug core to statically allocate descriptors at the macro
callsite.

> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> index 2291d85b6849e..2d49063f4f7c8 100644
> --- a/rust/kernel/device.rs
> +++ b/rust/kernel/device.rs

[ ... ]

> @@ -387,7 +305,7 @@ pub fn pr_dbg(&self, args: fmt::Arguments<'_>) {
>      /// Callers must ensure that `klevel` is null-terminated; in particu=
lar, one of the
>      /// `KERN_*`constants, for example, `KERN_CRIT`, `KERN_ALERT`, etc.
>      #[cfg_attr(not(CONFIG_PRINTK), allow(unused_variables))]
> -    unsafe fn printk(&self, klevel: &[u8], msg: fmt::Arguments<'_>) {
> +    pub unsafe fn printk(&self, klevel: &[u8], msg: fmt::Arguments<'_>) {

[Severity: Low]
Is it intentional to omit the #[inline] attribute on this function? Accordi=
ng
to the Rust subsystem guidelines, small abstraction functions that forward =
to C
bindings should be annotated with #[inline] to ensure optimal inlining.

>          // SAFETY: `klevel` is null-terminated and one of the kernel con=
stants. `self.as_raw`
>          // is valid because `self` is valid. The "%pA" format string exp=
ects a pointer to

[ ... ]

> @@ -948,5 +915,14 @@ macro_rules! dev_info {
>  /// ```
>  #[macro_export]
>  macro_rules! dev_dbg {
> -    ($($f:tt)*) =3D> { $crate::dev_printk!(pr_dbg, $($f)*) }
> +    ($dev:expr, $($f:tt)*) =3D> {
> +        match (&$dev, $crate::prelude::fmt!($($f)*)) {
> +            (dev, args) =3D> {
> +                if cfg!(debug_assertions) {

[Severity: Medium]
Does this match block unconditionally evaluate the formatting arguments bef=
ore
the debug_assertions check is performed?

Because the match scrutinee evaluates fmt!($($f)*) eagerly, any computation=
ally
expensive operations or side effects in the arguments might be executed eve=
n in
release builds.

Could the if cfg!(debug_assertions) check wrap the entire match block inste=
ad
to ensure zero overhead when debugging is disabled?

> +                    // SAFETY: `klevel` is null-terminated, uses one of =
the kernel constants.
> +                    unsafe { $crate::dev_printk!($crate::bindings::KERN_=
DEBUG, dev, args) }
> +                }
> +            }
> +        }
> +    }
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011-rust-dyndb=
g-v1-0-832e4039b71f@weissschuh.net?part=3D10
