Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC42374A02;
	Wed, 14 Oct 2026 02:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791945423; cv=none; b=IB1X8sK9bQnGf6go3RDjpAoNnX3jgwQix0szk1oW5Iv3oSK2lRNw+iQ7MUDuq2gGNHeezVmtE32BZjDjomfczxuTIJZe/ob76tTdpCDHy6kl9ZM5/DnW28p9PTrBptR3/dXAT8xh3clfAdVORU477R/CnghyO/ZZxmiItkwHruk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791945423; c=relaxed/simple;
	bh=KU4XiwlXrL2d7Q/4sc0RlM4/nO0fVf9uJvSn2ojsoxE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=KM4rLIxue6tv/riTAg90kAkH/+0Mb/OHmsfX7Pslw4rk4+OJ/yF6dVDpizr8vBXa3BvydlV4G7u4Im5e6A9IvcHJxygSAccsLBzE3T0C7idUYbWmTZsk8yzcWmEy/vqfrOMP5vZzCCfTQdhnH0XImJXx43EJiZp73YhwipgEMb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GK6ss6g3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GK6ss6g3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3241F00898;
	Wed, 14 Oct 2026 02:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791945422;
	bh=PRtAFEgT5NTm0yqpmOI5RJyAxjmM1xZ3WBSV5mgGrh4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GK6ss6g3ZaAC6nLyY+ZTjYnDl44m1wgvr/DuKtMWZSDixwzLS3AmaZwROGIX63Wjd
	 jD8S7jcnk2RSgIMPSrbolRd0HDcljQoBGhLcwdzYzt+XZd95ANjjkV7yFRS3KgaJxB
	 Q3+2dcPUTPX/51NSIFD/ilLTXKMVEhbmSgoO4rg8RdKjsVtvnTViGSUWKjwAIJN3Jn
	 8/TdIDfjVIE252ksUD/oVtGPe8CLgFKsbBeE331dkVEPVcWqQWnMHzwb+Xp5UF8B5U
	 YJ0fhMIlg9ads1dP46qqNyz/U56ttMKtLndWuRpUOVX8cMFqEJgm5PE3m7x0iLFFht
	 gD+7fxvSOciaQ==
Message-ID: <sashiko-outbox-170725@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 26/40] dyndbg-test: add do_bulk testpoint, rename
 do_prints to do_classes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>, "Jason Baron" <jbaron@akamai.com>, "Shuah
 Khan" <shuah@kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>, "Thomas
 Zimmermann" <tzimmermann@suse.de>, "David Airlie" <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, "Arnd Bergmann" <arnd@arndb.de>, "Luis
 Chamberlain" <mcgrof@kernel.org>, "Petr Pavlu" <petr.pavlu@suse.com>, "Daniel
 Gomez" <da.gomez@kernel.org>, "Sami Tolvanen" <samitolvanen@google.com>, "Aaron
 Tomlin" <atomlin@atomlin.com>, "Jonathan Corbet" <corbet@net.net>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Nathan Chancellor" <nathan@kernel.org>, "Nicolas
 Schier" <nsc@kernel.org>, "Shuah Khan" <skhan@linuxfoundation.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Pavel
 Machek" <pavel@kernel.org>, "Len Brown" <lenb@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>, "Petr
 Mladek" <pmladek@suse.com>, "Steven Rostedt" <rostedt@goodmis.org>, "John
 Ogness" <john.ogness@linutronix.de>, "Sergey Senozhatsky" <senozhatsky@chromium.org>,
 =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <linux@weissschuh.net>
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org
In-Reply-To: <20261012-dd-cmap-part2-clean-v12-26-3c8cc5725def@gmail.com>
References: <20261012-dd-cmap-part2-clean-v12-0-3c8cc5725def@gmail.com>
 <20261012-dd-cmap-part2-clean-v12-26-3c8cc5725def@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 02:37:00 +0000
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] test_dynamic_debug: classmap offset mismatch for submodule classes
- [Low] locking: param_set_do_repeats blocks param_lock for up to 60s
--

commit adf504f365302c7db4e37850cebef69f82ed353f
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg-test: add do_bulk testpoint, rename do_prints to do_classes

This patch renames do_prints to do_classes to better align with its purpose
and introduces do_bulk to generate high-volume workloads. It adds support f=
or
executing these debug operations multiple times or over a timed duration us=
ing
shared module parameter callbacks.

> diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
> index 01ce07001d4c7..19e27b5747ac2 100644
> --- a/lib/test_dynamic_debug.c
> +++ b/lib/test_dynamic_debug.c

[ ... ]

> @@ -28,25 +28,57 @@
>  #endif
> =20
>  #include <linux/module.h>
> +#include <linux/sched.h>
> +#include <linux/sched/signal.h>
> +#include <linux/jiffies.h>
> =20
> -/* re-gen output by reading or writing sysfs node: do_prints */
> +#define TEST_MAX_REPEATS 10000
> +#define TEST_MAX_SECONDS 60
> =20
> -static void do_prints(void); /* device under test */
> -static int param_set_do_prints(const char *instr, const struct kernel_pa=
ram *kp)
> +/* re-trigger debug output by reading or writing sysfs nodes: do_classes=
 or do_bulk */
> +static void do_classes(int); /* device under test */
> +static void do_bulk(int);    /* device under test */
> +
> +static int param_set_do_repeats(const char *instr, const struct kernel_p=
aram *kp)
>  {
> -	do_prints();
> +	int rc, ct;
> +	void (*repeat_fn)(int) =3D kp->arg;
> +
> +	rc =3D kstrtoint(instr, 0, &ct);
> +	if (rc) {
> +		pr_err("expecting numeric input, using 1 instead\n");
> +		ct =3D 1;
> +	}
> +	if (ct > TEST_MAX_REPEATS) {
> +		pr_warn("%s: clamping %d to %d\n", kp->name, ct, TEST_MAX_REPEATS);
> +		ct =3D TEST_MAX_REPEATS;
> +	} else if (ct < -TEST_MAX_SECONDS) {
> +		pr_warn("%s: clamping %d seconds to -%d\n",
> +			kp->name, ct, TEST_MAX_SECONDS);
> +		ct =3D -TEST_MAX_SECONDS;
> +	}
> +
> +	repeat_fn(ct);

[Severity: Low]
Does this synchronous loop execution block param_lock system-wide?

When test_dynamic_debug is built-in, writing to its module parameters via
sysfs triggers param_attr_store() in kernel/params.c, which acquires the
global param_lock mutex around the .set callback:

kernel/params.c:param_attr_store() {
    ...
    kernel_param_lock(mk->mod);
    if (param_check_unsafe(attribute->param))
        err =3D attribute->param->ops->set(buf, attribute->param);
    ...
}

Because param_set_do_repeats() invokes the workload synchronously (which
can run for up to 60 seconds as shown in do_classes() below), this starves
param_lock, preventing other processes from reading or writing any
built-in module parameters for the duration.

> +
>  	return 0;
>  }

[ ... ]

> @@ -103,7 +135,10 @@ enum cat_disjoint_bits {
>  	D2_DRMRES };
> =20
>  /* numeric verbosity, V2 > V1 related.  V1 is > D2_DRMRES */
> -enum cat_level_num { V1 =3D 16, V2, V3, V4, V5, V6, V7 };
> +enum cat_level_num { V1 =3D 16, V2, V3, V4, V5, V6, V7, V8 };
> +
> +/* test _USE_ w offset */
> +enum cat_level_offset { Vu1 =3D V1 + 8, Vu2, Vu3, Vu4, Vu5, Vu6, Vu7, Vu=
8 };
> =20
>  /* recapitulate DRM's multi-classmap setup */
>  #if !defined(TEST_DYNAMIC_DEBUG_SUBMOD)

[ ... ]

> @@ -160,6 +183,19 @@ DYNAMIC_DEBUG_CLASSMAP_DEFINE(fail_emptyclass, 0, 0 =
/* ,empty */);
>  DYNAMIC_DEBUG_CLASSMAP_DEFINE(fail_maptype, 3, 10, "no such type");
>  DYNAMIC_DEBUG_CLASSMAP_DEFINE(fail_base_len, 0, 60,
>  			      "base", "plus", "classes", "length", "too-big");
> +#endif
> +
> +#else /* TEST_DYNAMIC_DEBUG_SUBMOD */
> +
> +/*
> + * in submod/drm-drivers, use the classmaps defined in top/parent
> + * module above.
> + */
> +
> +DYNAMIC_DEBUG_CLASSMAP_USE(map_disjoint_bits);
> +DYNAMIC_DEBUG_CLASSMAP_USE_(map_level_num, 7);

[Severity: Low]
Is this registration macro passing an outdated offset?

The patch adds V8 to map_level_num, increasing its length to 8. While
cat_level_offset correctly shifts the submodule's class definitions by 8
(Vu1 =3D V1 + 8) above, this registration macro still tells dyndbg the
classes start at offset 7.

This mismatch causes submodule debug callsites to map to the wrong class
IDs, leaving the last class (Vu8) completely out of bounds and
uncontrollable.

> +
> +#if defined(DD_MACRO_ARGCHECK)
>  DYNAMIC_DEBUG_CLASSMAP_USE_(fail_offset_big, 100);
>  #endif /* DD_MACRO_ARGCHECK */

[ ... ]

> @@ -210,20 +247,85 @@ static void do_levels(void)

[ ... ]

> -static void do_prints(void)
> +static void do_classes(int ct)
> +{
> +	if (ct < 0) {
> +		unsigned long timeout =3D jiffies + (-ct) * HZ;
> +
> +		pr_debug("%s for %d seconds:\n", __func__, -ct);
> +		while (time_before(jiffies, timeout)) {
> +			if (signal_pending(current))
> +				break;
> +			do_cats();
> +			do_levels();
> +			cond_resched();
> +		}
> +		return;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-dd-cmap-pa=
rt2-clean-v12-0-3c8cc5725def@gmail.com?part=3D26
