Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A3E42A165
	for <linux-modules@vger.kernel.org>; Sun, 11 Oct 2026 13:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791723691; cv=none; b=plebz0lsOxLobXhHv6oO7dvv3vcE2UXw/z/Xw3KKLeoJgOn42BYsXxzMoEOxB+32FbzKJE/s+xq63qTNYpnmttblz6AMpL+7w/JjZVQzSyzHDy+oCCYQAercftO3jlYZNzIYclCoIbi33F4hHeSvV1cMqC5XMUPQRJXuUCL9hxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791723691; c=relaxed/simple;
	bh=Yro/87TlbesoA1taNYt8P1e60WdskwBwb0J277ZCQpc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=FXS+rCyhF81XLwBUBq1tVC14K0iNhiK5Pai7N87NsW5f8g2QjrrRacUxe2SrdKoyT6qvagn+Vvt2GQzNbqpxyO+Cmf6jrInwiBElD/QgIgcatWsgIukU/t3F81oWHbL+3tA1HScv1syvg+ZZ/6PYA9S76m0x+5luE0SJb5G2E+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cugE82s9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cugE82s9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 610731F0089D;
	Sun, 11 Oct 2026 13:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791723685;
	bh=H6eFBHkwtaFLF7W7Oiv1uJvzdHmTtHYGa4oyvlFrU64=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cugE82s98N7KhK+lJGrnAGviGeC56DjWq/ACtEpcmd/kmPXa6oEAbxfgq/CmnhyU+
	 k1FeS/IyhICGzBaw/4V4oMATIMofrwV7x9otNy6Jt0geVmjNGvQHbXZIiyufVaco6Y
	 nrdhPWk4B2znDzFd0RA2Bm9omkBJFElj8kFHc37jK+tjGZvdCnSA/R3oU1yTE/Ox+R
	 B2L6Co+Ytp8w0flWUIUgLmUPmBhwMZ4rQhNdeV98Ja9v5wyN5Qmsf/xssEv53ImZig
	 eYGVSQCPZLqouZdG6gpJaLU4RQN1vzOZgk+uCdJupmyECetCyFvHh7AeFUB/eE68pk
	 HATJC/y0iq63g==
Message-ID: <sashiko-outbox-167239@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 11/11] rust: device: enable dynamic debug for
 dev_dbg!()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <linux@weissschuh.net>
Cc: "Petr Pavlu" <petr.pavlu@suse.com>, linux-modules@vger.kernel.org, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261011-rust-dyndbg-v1-11-832e4039b71f@weissschuh.net>
References: <20261011-rust-dyndbg-v1-0-832e4039b71f@weissschuh.net>
 <20261011-rust-dyndbg-v1-11-832e4039b71f@weissschuh.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 13:01:24 +0000
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] rust: dev_dbg!() unconditionally evaluates formatting arguments =
and device expression
--

commit 8da2aef728fa950b65c5e5a0eaa3ddd52cf5dbeb
Author: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

rust: device: enable dynamic debug for dev_dbg!()

Wire up dynamic debug to also work for the dev_dbg!() macro.

> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> index 2d49063f4f7c8..db2c9adc5410e 100644
> --- a/rust/kernel/device.rs
> +++ b/rust/kernel/device.rs

[ ... ]

> @@ -918,6 +918,15 @@ macro_rules! dev_dbg {
>      ($dev:expr, $($f:tt)*) =3D> {
>          match (&$dev, $crate::prelude::fmt!($($f)*)) {
>              (dev, args) =3D> {
> +                // TODO: Switch to cfg_select!() when that is usable.
> +                #[cfg(any(CONFIG_DYNAMIC_DEBUG, all(CONFIG_DYNAMIC_DEBUG=
_CORE, debug_assertions)))]
> +                $crate::dynamic_func_call!($crate::__format_string!($($f=
)*), || {
> +                    // SAFETY: klevel is null-terminated, uses one of th=
e kernel constants.
> +                    unsafe { $crate::dev_printk!($crate::bindings::KERN_=
DEBUG, dev, args) }
> +                });

[Severity: Medium]
Does this unconditionally evaluate the formatting arguments and device
expression?

Since the match (&$dev, $crate::prelude::fmt!($($f)*)) block is placed
outside the dynamic debug conditional closure, the fmt! macro and $dev
expressions are evaluated before the closure is called.

This causes a performance regression by forcing runtime evaluation of all
arguments even when the dynamic debug branch is disabled, defeating the
zero-cost benefit of dynamic debug.

Could the match block be placed inside the conditionally executed closure
passed to dynamic_func_call!, and similarly placed inside the fallback
if cfg!(debug_assertions) block to properly defer evaluation?

> +
> +                #[cfg(not(any(CONFIG_DYNAMIC_DEBUG,
> +                          all(CONFIG_DYNAMIC_DEBUG_CORE, debug_assertion=
s))))]
>                  if cfg!(debug_assertions) {
>                      // SAFETY: klevel is null-terminated, uses one of th=
e kernel constants.
>                      unsafe { $crate::dev_printk!($crate::bindings::KERN_=
DEBUG, dev, args) }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011-rust-dyndb=
g-v1-0-832e4039b71f@weissschuh.net?part=3D11
