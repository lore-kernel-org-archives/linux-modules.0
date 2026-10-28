Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205309;
	b=Nhy8OrR80DHV5yHuk9kq9sXmlk9dTZlPPR+O6rOnquuFMeT/x1AK1KzUBy2zahumY1Db
	 RPQYKbC4H3QQYkI2QC0Ddsrrj+V9Q24UFnbDXLs2emTLr+zUhPO2Fy+yLHnLdGROw2sqY
	 qGkNlD/CgDdeCl3BU6I9ttEo0guY4xp0fSysGPIQ5uTFA3H2sCfAPbgtrOEz0o7rM0ZTy
	 zK3hqHwNrjCDqQjdHS1rOyzywk8zBO0+IW9klkIDQzcHyDwHsBBegj4VV6UHluTzQ00+b
	 6kMM53AeQlPLjJAthq1shnq+kOSxbDU6yu7J2zNRCDRsMSlvnqaRQxfcGPG9ZockM1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205309;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=b6pcBVxdMQUwjf02KaU8qkuRRIgCQzwBtXV/ZrkSdNU=;
	b=ZAJeKRrUiFrSrxRsx40kniVP8FeKzSr0WbpXXgu6cbvjTd331YYVIC6F6KUb/GldDbb1
	 g+z/jg6vTlKdJyLf5P6WHwtNOWuS/GbQrijui5f0GQakSLiL/kVCVxyOIb2t/+GK7r3Kq
	 k0wZ1s5YvLzjv3TyK0BHLr5Ok0vbrs+77loys6ILXgDRU2MiGjDu/mOFzuPHFaSyIf9fJ
	 TOdDdAG53T0l/7Sxn1tzGM740u9jBcPQRtiqm2d3uFxXFaip38DOnY3Q8XQ0gZkwe8fTu
	 W1qR/mA2HuBlKxixqWH9DBjOo70zzSr4FHa99LGC54KL6KxalhHyS+i9oPPxg5fCVag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="JYqPx/9P";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D9C606A31A;
	Wed, 28 Oct 2026 16:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JYqPx/9P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D7081F01825;
	Wed, 28 Oct 2026 16:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793205309;
	bh=b6pcBVxdMQUwjf02KaU8qkuRRIgCQzwBtXV/ZrkSdNU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JYqPx/9PiWeGlzQLparH1mu72uexdOw6wZ7nbGw7qYqnQMS3ETSwIEk3w2TSKHjVP
	 BB/pzOw3/U82yOTB4H6G98SRIqIWXctRa0LL3MB/aC+N6Ujj8DrXnRI/H6cSIbqUPa
	 svHrpGyMmfba0sqKuiok9nWHOM0TFeoXNECKAOBUj6ZdyjgUgNd/o8oiuDBfQspV8s
	 BIlnVhzh51YMQqTwuDTzcUhTrGblROynC5JqngMW0B1DG2i4OAkgCs8QKuNTjGZahw
	 N2wfyTCtrNl01p4c6YGiCHfDgVH+xiXoqw1QY+N3q6vRQAuZsoQk9ubW9ett5TR210
	 9RUizdCTc+X1w==
Message-ID: <sashiko-outbox-188167@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 1/2] kcov: collect early boot coverage of init_task
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yunseong Kim" <yunseong.kim@est.tech>, "Jonathan Corbet" <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "James Morris" <jmorris@namei.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Andrey Konovalov" <andreyknvl@gmail.com>, "Alexander
 Potapenko" <glider@google.com>, "Dmitry Vyukov" <dvyukov@google.com>, "Peter
 Zijlstra" <peterz@infradead.org>, "Ingo Molnar" <mingo@redhat.com>, "Will
 Deacon" <will@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Waiman Long" <longman@redhat.com>, "Luis
 Chamberlain" <mcgrof@kernel.org>, "Petr Pavlu" <petr.pavlu@suse.com>, "Daniel
 Gomez" <da.gomez@kernel.org>, "Sami Tolvanen" <samitolvanen@google.com>, "Aaron
 Tomlin" <atomlin@atomlin.com>, "Paul E. McKenney" <paulmck@kernel.org>, "Frederic
 Weisbecker" <frederic@kernel.org>, "Neeraj Upadhyay" <neeraj.upadhyay@kernel.org>, "Joel
 Fernandes" <joelagnelf@nvidia.com>, "Josh Triplett" <josh@joshtriplett.org>, "Uladzislau
 Rezki" <urezki@gmail.com>, "Steven Rostedt" <rostedt@goodmis.org>, "Mathieu
 Desnoyers" <mathieu.desnoyers@efficios.com>, "Lai Jiangshan" <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, "Juri
 Lelli" <juri.lelli@redhat.com>, "Vincent Guittot" <vincent.guittot@linaro.org>, "Dietmar
 Eggemann" <dietmar.eggemann@arm.com>, "Ben Segall" <bsegall@google.com>, "Mel
 Gorman" <mgorman@suse.de>, "Valentin Schneider" <vschneid@redhat.com>, "K
 Prateek Nayak" <kprateek.nayak@amd.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Nathan
 Chancellor" <nathan@kernel.org>, "Nicolas Schier" <nsc@kernel.org>, "Thomas
 Gleixner" <tglx@kernel.org>, "Borislav Petkov" <bp@alien8.de>, "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org, "H.
 Peter Anvin" <hpa@zytor.com>
Cc: kasan-dev@googlegroups.com, linux-modules@vger.kernel.org, linux-mm@kvack.org, linux-kbuild@vger.kernel.org
In-Reply-To: <20261027-early-kcov-v1-1-6f2f053255ad@est.tech>
References: <20261027-early-kcov-v1-0-6f2f053255ad@est.tech>
 <20261027-early-kcov-v1-1-6f2f053255ad@est.tech>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 16:35:06 +0000
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
- [High] kcov: NULL deref in __sanitizer_cov_trace_pc() during selftest()
--

commit 2f2cd36073f62980c1305efe82a4239b11c076f5
Author: Yunseong Kim <yunseong.kim@est.tech>

kcov: collect early boot coverage of init_task

This commit adds CONFIG_EARLY_KCOV to record code coverage of init_task
from right after early parameter parsing in start_kernel() until the start
of rest_init(), and exposes the collected PCs via
/sys/kernel/debug/early_kcov. It also introduces CONFIG_KCOV_INSTRUMENT_NOI=
SY
and a kcov-noisy kbuild helper to instrument core subsystems normally
excluded due to coverage noise.

> diff --git a/kernel/Makefile b/kernel/Makefile
> index 4ff92e24680c5..b9e4f06e02ad0 100644
> --- a/kernel/Makefile
> +++ b/kernel/Makefile
> @@ -27,14 +27,14 @@ endif
> =20
>  # Prevents flicker of uninteresting __do_softirq()/__local_bh_disable_ip=
()
>  # in coverage traces.
> -KCOV_INSTRUMENT_softirq.o :=3D n
> +KCOV_INSTRUMENT_softirq.o :=3D $(kcov-noisy)

[ ... ]

> diff --git a/kernel/locking/Makefile b/kernel/locking/Makefile
> index cee1901d4cff8..9041cbbec9aae 100644
> --- a/kernel/locking/Makefile
> +++ b/kernel/locking/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # Any varying coverage in these files is non-deterministic
>  # and is generally not a function of system call inputs.
> -KCOV_INSTRUMENT		:=3D n
> +KCOV_INSTRUMENT		:=3D $(kcov-noisy)

[ ... ]

> diff --git a/kernel/rcu/Makefile b/kernel/rcu/Makefile
> index 0cfb009a99b9f..fd23c1dad641b 100644
> --- a/kernel/rcu/Makefile
> +++ b/kernel/rcu/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # Any varying coverage in these files is non-deterministic
>  # and is generally not a function of system call inputs.
> -KCOV_INSTRUMENT :=3D n
> +KCOV_INSTRUMENT :=3D $(kcov-noisy)

[ ... ]

> diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
> index b1f1a367034ff..4b4db5cca9b08 100644
> --- a/kernel/sched/Makefile
> +++ b/kernel/sched/Makefile
> @@ -9,7 +9,7 @@ ccflags-y +=3D $(call cc-disable-warning, unused-but-set-=
variable)
> =20
>  # These files are disabled because they produce non-interesting flaky co=
verage
>  # that is not a function of syscall inputs. E.g. involuntary context swi=
tches.
> -KCOV_INSTRUMENT :=3D n
> +KCOV_INSTRUMENT :=3D $(kcov-noisy)

[ ... ]

> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 6759087154edd..40bf654ec7515 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2233,6 +2233,51 @@ config KCOV_INSTRUMENT_ALL
>  	  filesystem fuzzing with AFL) then you will want to enable coverage
>  	  for more specific subsets of files, and should say n here.
> =20

[ ... ]

> +config KCOV_INSTRUMENT_NOISY
> +	bool "Also instrument code excluded only for noisy coverage"
> +	depends on EARLY_KCOV && KCOV_INSTRUMENT_ALL
> +	help
> +	  Some code (scheduler, RCU, locking, page and slab allocators,
> +	  rbtree, stack unwinding, ...) is excluded from KCOV instrumentation
> +	  because its coverage is not a function of system call inputs and
> +	  only adds noise to coverage-guided fuzzing. Code that is excluded
> +	  because it cannot be instrumented safely is not affected.
> +
> +	  Say y to instrument the noisy code as well, so that the early boot
> +	  coverage shows the complete execution path. This degrades the
> +	  coverage signal for syscall fuzzing, so say n for fuzzing kernels.

[Severity: High]
Can enabling CONFIG_KCOV_INSTRUMENT_NOISY trigger a NULL pointer dereference
in __sanitizer_cov_trace_pc() during kcov_init() -> selftest(), as well as
record interrupt entry and exit PCs into task coverage buffers?

In kernel/kcov.c, check_kcov_mode() filters out interrupt context using
in_task(), which relies on HARDIRQ_OFFSET being set in preempt_count().
However, several functions in kernel/softirq.c, kernel/sched/core.c,
kernel/locking/lockdep.c, and kernel/rcu/ run on every hardware interrupt
either before HARDIRQ_OFFSET is added or after it is subtracted, while
in_task() is still true:

- In kernel/softirq.c, irq_enter_rcu() and irq_enter() are not marked
  noinstr or __no_sanitize_coverage, so the compiler inserts a call to
  __sanitizer_cov_trace_pc() at function entry before __irq_enter_raw()
  adds HARDIRQ_OFFSET to preempt_count(). Likewise, __irq_exit_rcu()
  (inlined into irq_exit_rcu() and irq_exit()) calls
  preempt_count_sub(HARDIRQ_OFFSET) before finishing execution.

- When CONFIG_DEBUG_PREEMPT=3Dy or CONFIG_TRACE_PREEMPT_TOGGLE=3Dy,
  __irq_enter_raw() calls preempt_count_add(HARDIRQ_OFFSET) in
  kernel/sched/core.c, which is instrumented at entry before
  __preempt_count_add() updates preempt_count().

- On interrupt exit after HARDIRQ_OFFSET is cleared,
  irqentry_exit_to_kernel_mode() / irqentry_exit_cond_resched() can call
  trace_hardirqs_on() -> lockdep_hardirqs_on_prepare() in
  kernel/locking/lockdep.c, rcu_irq_exit_check_preempt() in kernel/rcu/,
  and preempt_schedule_irq() -> __schedule() in kernel/sched/core.c
  (before prepare_task_switch() sets KCOV_IN_CTXSW and after
  kcov_finish_switch() clears it).

When CONFIG_KCOV_SELFTEST=3Dy is also enabled (for example in allyesconfig
builds), kcov_init() calls selftest() at device_initcall time with
current->kcov_area =3D=3D NULL and current->kcov_size =3D=3D 0:

kernel/kcov.c:selftest() {
	...
	start =3D jiffies;
	WRITE_ONCE(current->kcov_mode, KCOV_MODE_TRACE_PC);
	while ((jiffies - start) * MSEC_PER_SEC / HZ < 300)
		;
	WRITE_ONCE(current->kcov_mode, 0);
}

When a timer interrupt fires during that loop, the instrumented interrupt
entry/exit path invokes __sanitizer_cov_trace_pc() while in_task() is true:

kernel/kcov.c:__sanitizer_cov_trace_pc() {
	...
	t =3D current;
	if (!check_kcov_mode(KCOV_MODE_TRACE_PC, t))
		return;

	area =3D t->kcov_area;
	/* The first 64-bit word is the number of subsequent PCs. */
	pos =3D READ_ONCE(area[0]) + 1;
	if (likely(pos < t->kcov_size)) {
	...
}

Because area[0] is read before checking t->kcov_size, dereferencing area
when t->kcov_area is NULL crashes the kernel on boot.

Should these interrupt entry/exit helpers be marked __no_sanitize_coverage
(or noinstr), or should CONFIG_KCOV_SELFTEST depend on
!KCOV_INSTRUMENT_NOISY?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-early-kcov=
-v1-0-6f2f053255ad@est.tech?part=3D1
