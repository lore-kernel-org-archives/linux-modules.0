Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792677335;
	b=UQNWqvt1SmdLFDP6jidvnYRROalQS5yQyG8qrZjWyQGCddkMGj4Rxv+uPrcuibeukIrS
	 c0k9ipM1vsgD2PPkRP6v9XzncjF/LuoEdIep+W/tCS/x8x22mV64oZS9jngxocmZ5e+xl
	 NsesVQLQk0//fPQtDtj/xPq61/YIptgv+2hASw2H+9B+JmPwuj6CHugqK3gu332P+CFMV
	 GSsswrymSOXDKai/11aXHIPMxGZ/U2cFtaRM16k9wfbqtvWXfDi8VSKRxcx/rivusXDFD
	 /8MBCIYPds+4p3nLoRXd8ZD+027xK28epdAsast6FEuft52XVrsXRg/QshGVOw318Cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792677335;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=F5aW/qVpvDGTvsEOYnNt03rF1dV+LBu8ELCbGPKZSjE=;
	b=yeRMbKHK8pQc325ATz6mfdJPcWJAorp+COjx/tq+4hdmXoQ2xCRsoMO/fEE+i1QDa1xV
	 Ko20fMZPFkE9zSwrvN7aQ5k+t6N9QHYAuel4mZx18lbMmwqerxT4A03O8Ax1baA34i5cg
	 zJ+bnHoAgoFJ7tXocLLHaY6b+f5pvEdMIfYY7k7uvxGq62oBHrnTw6LRBRzWjrOzEYyV7
	 gIODyHrjHO2idXOeE4NR1K9IFLZSqMGLVzJ0SBufUWATYbxCl2btbeXeqDpMl4X7mTJnu
	 MFI7Mad02rgN5gegQ+tMsTcpQsA3zVX6T0pPT0CvGOXSxtmfNi3LIeTHoqnHwzRtPZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OvdPA+il;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70F1606A31A
	for <linux-modules@vger.kernel.org>; Thu, 22 Oct 2026 13:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OvdPA+il
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2709F1F000C7;
	Thu, 22 Oct 2026 13:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792677334;
	bh=F5aW/qVpvDGTvsEOYnNt03rF1dV+LBu8ELCbGPKZSjE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OvdPA+ilziXCeKrL4/ulsXCQKJfqUfTk+6J7qkKhrKN8LtC+GQScMLyAV7R71aPi6
	 /2TH0fwLzRGQUpCHeZFlR6vobIaidEeB1rRJGTv967/jSy9YDoSVg2/TxpqcIBtkyK
	 YWdDvgkB99YDJvX3vU8t1zRH57ktcswBbdQNAW6PGci8H79vzHVyFGh1E/eY0sd8AE
	 wijtTg+MEPWII7eV/qnS9O3iOHf9WZzcIQm9lUjWVDbOgv5ks44yhh66bNpLU/Kehl
	 43tIzvIfplC/dmNET8hS8+uiP8aRuuuFuRbmIhCXE7137qQeGyaU3zfyMAeTLkL64N
	 0bTQuP8S4UYgA==
Message-ID: <sashiko-outbox-181589@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] rust: move EXPORT_SYMBOL_RUST_GPL to
 include/linux/export.h
Reply-To: sashiko-reviews@lists.linux.dev
To: "Giuliano Procida" <gprocida@google.com>
Cc: linux-modules@vger.kernel.org, "Petr Pavlu" <petr.pavlu@suse.com>, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261022134617.228229-2-gprocida@google.com>
References: <CANiq72mN9JYVitqgsZ2GkdmPVWqHZpJ-WNMNviiHV6C7gQMUwA@mail.gmail.com>
 <20261022134617.228229-2-gprocida@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 13:55:33 +0000
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] rust: missing scripts/misc-check update for EXPORT_SYMBOL_RUST_GPL()
--

commit 9207c761154db27eab7d2644afb940dea51e432c
Author: Giuliano Procida <gprocida@google.com>

rust: move EXPORT_SYMBOL_RUST_GPL to include/linux/export.h

This commit moves the duplicate definitions of EXPORT_SYMBOL_RUST_GPL from
rust/exports.c and drivers/gpu/nova-core/nova_core_exports.c into
include/linux/export.h.

> diff --git a/drivers/gpu/nova-core/nova_core_exports.c b/drivers/gpu/nova=
-core/nova_core_exports.c
> index 6e80ca9792ee5..480472b039db2 100644
> --- a/drivers/gpu/nova-core/nova_core_exports.c
> +++ b/drivers/gpu/nova-core/nova_core_exports.c
> @@ -10,6 +10,4 @@
> =20
>  #include <linux/export.h>
> =20
> -#define EXPORT_SYMBOL_RUST_GPL(sym) extern int sym; EXPORT_SYMBOL_GPL(sy=
m)
> -
>  #include "exports_nova_core_generated.h"
> diff --git a/include/linux/export.h b/include/linux/export.h
> index a686fd0ba4065..4aeb422d86afc 100644
> --- a/include/linux/export.h
> +++ b/include/linux/export.h
> @@ -93,4 +93,17 @@
> =20
>  #define EXPORT_SYMBOL_FOR_MODULES(sym, mods) __EXPORT_SYMBOL(sym, "GPL",=
 "module:" mods)
> =20
> +/*
> + * A hack to export Rust symbols for loadable modules without having to =
redo
> + * the entire `EXPORT_SYMBOL_GPL` logic in Rust.
> + *
> + * This requires Rust's new/future `v0` mangling scheme because the defa=
ult one
> + * ("legacy") uses invalid characters for C identifiers (thus we cannot =
use the
> + * `EXPORT_SYMBOL_*` macros).
> + *
> + * All symbols are exported as GPL-only to guarantee no GPL-only feature=
 is
> + * accidentally exposed.
> + */
> +#define EXPORT_SYMBOL_RUST_GPL(sym) extern int sym; EXPORT_SYMBOL_GPL(sy=
m)
> +
>  #endif /* _LINUX_EXPORT_H */
> diff --git a/rust/exports.c b/rust/exports.c
> index 1b52460b0f4ee..8b2dd4aa1f928 100644
> --- a/rust/exports.c
> +++ b/rust/exports.c
> @@ -1,20 +1,10 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * A hack to export Rust symbols for loadable modules without having to =
redo
> - * the entire `include/linux/export.h` logic in Rust.
> - *
> - * This requires Rust's new/future `v0` mangling scheme because the defa=
ult one
> - * ("legacy") uses invalid characters for C identifiers (thus we cannot =
use the
> - * `EXPORT_SYMBOL_*` macros).
> - *
> - * All symbols are exported as GPL-only to guarantee no GPL-only feature=
 is
> - * accidentally exposed.
> + * Export symbols from the `rust/` crates and C helpers for loadable mod=
ules.
>   */
> =20
>  #include <linux/export.h>
> =20
> -#define EXPORT_SYMBOL_RUST_GPL(sym) extern int sym; EXPORT_SYMBOL_GPL(sy=
m)
> -
>  #include "exports_core_generated.h"
>  #include "exports_bindings_generated.h"
>  #include "exports_kernel_generated.h"

[Severity: Low]
Does moving EXPORT_SYMBOL_RUST_GPL into include/linux/export.h cause
scripts/misc-check to emit false-positive warnings during W=3D2 builds?

In scripts/misc-check, check_missing_include_linux_export_h() and
check_unnecessary_include_linux_export_h() match export macros against
tracked files using:

scripts/misc-check:check_unnecessary_include_linux_export_h() {
	git -C "${srctree:-.}" grep --files-with-matches '#include[[:space:]]*<lin=
ux/export\.h>' \
	    -- '*.[c]' :^tools/ |
	xargs -r git -C "${srctree:-.}" grep --files-without-match -E 'EXPORT_SYMB=
OL((_NS)?(_GPL)?|_FOR_MODULES)\(.*\)' |
	xargs -r printf "%s: warning: EXPORT_SYMBOL() is not used, but #include <l=
inux/export.h> is present\n" >&2
}

Previously, the local macro definition in both rust/exports.c and
drivers/gpu/nova-core/nova_core_exports.c contained EXPORT_SYMBOL_GPL(sym),
which satisfied that regular expression.

With the macro definition moved to include/linux/export.h, rust/exports.c
only contains EXPORT_SYMBOL_RUST_GPL(rust_build_error), and
drivers/gpu/nova-core/nova_core_exports.c only includes
exports_nova_core_generated.h without any direct EXPORT_SYMBOL* calls in the
tracked .c file. As a result, running make W=3D2 warns on both files:

  drivers/gpu/nova-core/nova_core_exports.c: warning: EXPORT_SYMBOL() is no=
t used, but #include <linux/export.h> is present
  rust/exports.c: warning: EXPORT_SYMBOL() is not used, but #include <linux=
/export.h> is present

Should scripts/misc-check also be updated to recognize
EXPORT_SYMBOL_RUST_GPL() and handle C export files that only invoke it via
generated headers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022134617.2282=
29-1-gprocida@google.com?part=3D1
