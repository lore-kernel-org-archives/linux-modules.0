Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D08233923
	for <linux-modules@vger.kernel.org>; Sun, 11 Oct 2026 13:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791724121; cv=none; b=X+noNxJjsaDt5TGXDpF3nHEIWN7BPfoXkgWj3/UEx55SiNxfXIOhlNNRlE05uBp2A11JTFYwvjqgD4D91GCZqt0hvWxg0KfmcNIXTGWmwdm6r7dmVD9/T0yejsrlZwhREdZJ2Dqc31IilTDLs88+Cu0GZqHcrytnKcGg+f6bjDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791724121; c=relaxed/simple;
	bh=8dmk1AMXKl0GzSc0mheZbw4kzO2t4A5eYj3izpkt30U=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=uKPmEGx6c2RTXGb+PoHXjGlhMJGec/46n69XWFdlAasuw4FWg+cxBq+bO53VxltsZHviSgra2FkRVj0QwkTEDzcM7rgH1CwmD55yyN2wRlOEaanYU6W/oGr77CbX28WTGpokO/JfhfYwtWOaUzUqZ1474pDrs/G5eL0YSexWjQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KhxAtCAF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KhxAtCAF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F1061F0089B;
	Sun, 11 Oct 2026 13:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791724120;
	bh=K/Q91yws4GgH9atyjg5HpbrGWRshPexsdevGNuQoiUw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KhxAtCAFHk38D3LrhqkDLRGW4E1CfTNX1eFffE/JgZs8UIQVVw3awSuvhZl2H0YaK
	 UaUwfOJLtFKinGXNsYHjOeyCdxsUGWDpx6SCOUjEJYsOsUDFe1t+fUZzh/usGWDNkm
	 yzhedIWwqr5qVnJqBbqEdi67qQe+UwwXeDFrr7Y2phA207nAUaFe4nsNaXgXYGHgQA
	 mIhlpqofH3+JmorkzOiZnKE3AE9yD+8VjC6VQCawEhEb8vw9KitwzUacEghv+/MUwr
	 57mQm5m6uGnDjGlqYZ6HA6EHz9YVvAPMxnZMvB8BWQbl7rX+VR9OSecA2KdV17nVfN
	 p9dyNXXJtkd/Q==
Message-ID: <sashiko-outbox-167246@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 08/11] rust: add support for dynamic debug
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <linux@weissschuh.net>
Cc: ojeda@kernel.org, linux-modules@vger.kernel.org, gary@garyguo.net, "Petr
 Pavlu" <petr.pavlu@suse.com>
In-Reply-To: <20261011-rust-dyndbg-v1-8-832e4039b71f@weissschuh.net>
References: <20261011-rust-dyndbg-v1-0-832e4039b71f@weissschuh.net>
 <20261011-rust-dyndbg-v1-8-832e4039b71f@weissschuh.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 13:08:39 +0000
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] printk: dynamic debug formatting prefixes are silently ignored i=
n Rust
- [Low] rust: data race due to mixed atomic/non-atomic access on C bitfield=
 flags
--

commit 62390fa941837d8feaa389e3a6ea73a463056133
Author: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

rust: add support for dynamic debug

This commit adds the Rust infrastructure to integrate with the dynamic debug
framework. It introduces a descriptor wrapper and macros to wire up the
conditional debug calls, with static keys and custom classes planned for
the future.

> diff --git a/rust/kernel/dynamic_debug.rs b/rust/kernel/dynamic_debug.rs
> new file mode 100644
> index 0000000000000..2fdc691eaac94
> --- /dev/null
> +++ b/rust/kernel/dynamic_debug.rs

[ ... ]

> +    #[inline(always)]
> +    pub unsafe fn branch_and_stack<F: FnOnce()>(desc: *mut Descriptor<'s=
tatic>, func: F) {
> +        // TODO: Use static keys.
> +
> +        let flags_ptr =3D project!(mut desc, .0.flags);
> +        // SAFETY: As per the function safety requirement desc is valid,=
 and properly aligned,
> +        // so flags_ptr is so, too. Updates from C are atomic.
> +        let flags =3D unsafe { atomic::atomic_load(flags_ptr, atomic::or=
dering::Relaxed) };
                             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^

[Severity: Low]
Does this atomic load in Rust race with non-atomic bitfield updates in C?

In the C core, the flags field is defined as an unsigned int bitfield
sharing a 32-bit memory location with lineno and class_id:

include/linux/dynamic_debug.h:struct _ddebug {
    ...
    unsigned int flags:8;
    ...
}

The C code modifies flags using non-atomic, unprotected read-modify-write
operations under a mutex:

lib/dynamic_debug.c:ddebug_change() {
    ...
    dp->flags =3D newflags;
    ...
}

Mixing atomic loads in Rust with non-atomic bitfield updates in C results
in a data race. While practically benign as word tearing on 32-bit aligned
words is rare, the assumption in the comments that C updates are atomic or
that flags is an independent byte appears factually incorrect.

> +
> +        if flags & flags::PRINT !=3D 0 {
> +            func();
                 ^^^^^^

[Severity: Medium]
Does this parameterless closure execution prevent formatting prefixes?

In C, dynamic debug formats optional prefixes such as module name,
function name, line number, or thread ID via dynamic_emit_prefix()
using the _ddebug descriptor.

Because func() does not receive the descriptor, the underlying closure
will invoke printk directly without retrieving the formatted prefix. As a
result, all dynamic debug formatting flags (+p, +m, +f, +l, +t) configured
via debugfs appear to be silently ignored for Rust logs, degrading expected
kernel observability features.

[ ... ]

> +macro_rules! dynamic_func_call_cls {
> +    ($cls:expr, $fmt:expr, $func:expr) =3D> {{
> +        const default_enabled: bool =3D cfg!(debug_assertions);
> +
> +        let descriptor =3D $crate::dynamic_debug_metadata_cls!(default_e=
nabled, $cls, $fmt);
> +
> +        // SAFETY: descriptor has static lifetime, so it is always valid.
> +        unsafe {
> +            $crate::dynamic_debug::Descriptor::branch_and_stack(descript=
or, $func);
                                                                           =
    ^^^^^

[Severity: Medium]
Will this macro need to pass the descriptor into the func closure so
that the underlying logging macro can use it for dynamic prefix formatting?

> +        }
> +    }};
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011-rust-dyndb=
g-v1-0-832e4039b71f@weissschuh.net?part=3D8
