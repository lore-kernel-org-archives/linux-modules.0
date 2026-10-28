Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205312;
	b=h/mG43asrShB5VNbRVOy3jvXPbWWdqwFbiLXFC62RiH4kV0WdCCRS96cjZRUy/U4DU6V
	 BwfwkLc179sJso76NQpHGW5obZbUK/EDNAWgdoILEDCmvq4PZDGWzatzm5YofV2yzXjjJ
	 Kp8V4nU0g5t3cAWjVP7VXvxi4iqhSleg+wErmfT20cAVp0bFFHFWGd+1Jca9A/azF6hNp
	 2UUAOoXOdnaFXx5AvG4JZUvYYFDzWuWLkdFGgcnvqUOzgW54oQ2aqQzcVfeS3Yyc9PRYU
	 m6JPRKqgmeCS8oS0GqqArttWqQm3CkjKlOp84Baxt5M/wpDHo9k+ppnKA4ARmKLpZPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205312;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LsxY8Y0pmbaFpLJ9PntFjRMT7awe6GsgDxXoVZC163Q=;
	b=1SnmgzEgktrV4DD/siNhnBbaKCFJHF8rr+gZJBJDKH6xzr0xZQtqKA5u/eGePO9zQ6ec
	 b9WSooFwHdQE/dETfBNEL+bD2CMxho3q4rw+dB4DdJB+JSJ3f+u7oJzG5zQz4h/sU6H6X
	 jdOpMWxguveix7PtL4aQKbg2iDZIeZLXtSRXFrCpIBRHUF8wU4kxhkqs9sqFCVbhLx0EQ
	 GQL0Z65dae7ARSQdSimybleSaTumLrLRMnKoUSBDLJ04/xtHGtJZQjnEgS70My0SO5Mco
	 ec4gp9v19EjEJIrzZdcb5RCDsMA6pIrcFdvxkes0TQi1Lxqp6PXpM0oF5Ndx6SKJDmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zcmrdaow;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA1E606A322;
	Wed, 28 Oct 2026 16:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zcmrdaow
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71901F031E0;
	Wed, 28 Oct 2026 16:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793205311;
	bh=LsxY8Y0pmbaFpLJ9PntFjRMT7awe6GsgDxXoVZC163Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZcmrdaowSfrUee9ovwE8wL1mbXPhKkGcHAJ/sNA6Q+l9Okfg0Pk4rSfrPV/KS+OM4
	 iq3fJYxFmFMEPtlhwZ8oKXdO6JWDOGj1tWgs/5vksMcQsxjBSri2Ko6jZ1c8AZ1pbw
	 hYaofSf9KnPRREbyW99xWOa8oXMPog7YkskU6bN4m5tUvmQWw2z1DlzaE0JGLAL1vH
	 83EM3VlCZUgKFA8cLPfGghSF1XrUzF2KqKFisW2stpfX3DU2XGB1HzqK1Vd1MWzzYu
	 +H4cAztvEk5BFBrJOMDsUQ24cBprZ/AXvBupnESAhaDK1IpTKUNfYwQrn1Qrbaf2WS
	 75wO0EJ2FVteg==
Message-ID: <sashiko-outbox-188168@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 2/2] x86/kcov: allow instrumenting noisy objects for
 early boot coverage
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
In-Reply-To: <20261027-early-kcov-v1-2-6f2f053255ad@est.tech>
References: <20261027-early-kcov-v1-0-6f2f053255ad@est.tech>
 <20261027-early-kcov-v1-2-6f2f053255ad@est.tech>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 16:35:09 +0000
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
- [High] x86/kcov: instrumenting apic/ crashes selftest() on FRED timer ent=
ry
--

commit c1145245b36a2aa7f3b165ab0f5b126b2c810470
Author: Yunseong Kim <yunseong.kim@est.tech>

x86/kcov: allow instrumenting noisy objects for early boot coverage

This commit switches several x86 Makefile exclusions from hardcoded n to
$(kcov-noisy) so that CONFIG_KCOV_INSTRUMENT_NOISY=3Dy can collect early bo=
ot
coverage from arch/x86/kernel/, arch/x86/kernel/apic/, and arch/x86/lib/.

> diff --git a/arch/x86/kernel/apic/Makefile b/arch/x86/kernel/apic/Makefile
> index 581db89477f92..146cbd766c924 100644
> --- a/arch/x86/kernel/apic/Makefile
> +++ b/arch/x86/kernel/apic/Makefile
> @@ -5,7 +5,7 @@
> =20
>  # Leads to non-deterministic coverage that is not a function of syscall =
inputs.
>  # In particular, smp_apic_timer_interrupt() is called in random places.
> -KCOV_INSTRUMENT		:=3D n
> +KCOV_INSTRUMENT		:=3D $(kcov-noisy)

[Severity: High]
Does instrumenting arch/x86/kernel/apic/apic.o cause a NULL pointer
dereference during boot when CONFIG_KCOV_INSTRUMENT_NOISY=3Dy and
CONFIG_KCOV_SELFTEST=3Dy on FRED-enabled x86_64 systems?

In arch/x86/kernel/apic/apic.c, DEFINE_IDTENTRY_SYSVEC(sysvec_apic_timer_in=
terrupt)
expands via arch/x86/include/asm/idtentry.h:

    void fred_##func(struct pt_regs *regs)
    {
        instr_##func (regs);
    }

Unlike the IDT entry wrapper sysvec_apic_timer_interrupt(),
fred_sysvec_apic_timer_interrupt() is not marked noinstr or
__no_sanitize_coverage. When apic.o is instrumented with KCOV,
fred_sysvec_apic_timer_interrupt() and the inlined
instr_sysvec_apic_timer_interrupt() -> run_sysvec_on_irqstack_cond() ->
call_on_irqstack_cond() call into __sanitizer_cov_trace_pc() before
irq_enter_rcu() adds HARDIRQ_OFFSET to preempt_count (and again after
irq_exit_rcu() removes HARDIRQ_OFFSET).

During boot, after rest_init() -> early_kcov_stop() clears
init_task.kcov_area to NULL, device_initcall(kcov_init) invokes selftest()
in kernel/kcov.c:

    start =3D jiffies;
    WRITE_ONCE(current->kcov_mode, KCOV_MODE_TRACE_PC);
    while ((jiffies - start) * MSEC_PER_SEC / HZ < 300)
        ;
    WRITE_ONCE(current->kcov_mode, 0);

While selftest() spins waiting for timer interrupts to advance jiffies with
current->kcov_area =3D=3D NULL, the first LAPIC timer interrupt under FRED
enters fred_sysvec_apic_timer_interrupt() while in_task() in
check_kcov_mode() is still true, reaching __sanitizer_cov_trace_pc() in
kernel/kcov.c:

    area =3D t->kcov_area;
    /* The first 64-bit word is the number of subsequent PCs. */
    pos =3D READ_ONCE(area[0]) + 1;

and dereferencing NULL.

In addition, during normal task KCOV tracing on FRED systems, if a LAPIC
timer interrupt preempts a traced task inside __sanitizer_cov_trace_pc() or
write_comp_data() between reading area[0] and writing back the updated
count, can the nested KCOV calls in fred_sysvec_apic_timer_interrupt() have
their area[0] updates overwritten when the interrupted context resumes and
stores its stale index?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-early-kcov=
-v1-0-6f2f053255ad@est.tech?part=3D2
