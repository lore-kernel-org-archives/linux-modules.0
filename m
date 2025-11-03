Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B162EC09A;
	Mon,  3 Nov 2025 11:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762169875; cv=none; b=SPYtmqAGDB60wzPts1dQ/uh864hLOK/AmnLpeUphxlNc8vsS5s3LP0WdYs6KtUBK63LvAnz1447RsfIHJmYW0xjxyY3W0wsPjN4nqKyx/UTieNqkZwISaj7JO3fpFn/uUJ6umAwRjXTkhYkcpLo1zjavgBflUF74EC4GpUAyswQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762169875; c=relaxed/simple;
	bh=vrPKqaZjzgyI32CVu2lhvSvdm+nTkP6PkJwjnq4gOwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NxlxF5ueRsc7cM3rhAQbsVu2kidy0lf/rE31Ra2YytnsLDvsArgF+X+pdUJlJqBxj2ayR74uUi4PuCwq5WoEPlD4ZuBegT0FlXz+dYVHaDm2g5VZbpDLwwlkwzp8mSqoaybE7WrcztrZ/zj2vWwq9xnqa224Df0iEralNNqIRIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mlHLs6EO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Elx285e/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mlHLs6EO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Elx285e/"
Date: Mon, 3 Nov 2025 12:37:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762169871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H+A2kkbWSNB6iE8g8vdOv3L2psTaC6itGdNeIXfXL90=;
	b=mlHLs6EObUfkFh7qYD9lH1Ss1YVLuQiFxFdiH1Lv2+o4iTO2n3J8ya5TVcqbKG2YBHFfkk
	aJX1shswrFnHZj3OAvXc6uC1i5A+Pilyzuy16k1OR8gTWD50l9vL7RXoguQeXof+T4mvV6
	ntwpnDu1J2etMY32Se0UmfQNB6kt9FKcuv09QbxJHbF7s908dLUVIait5Q04VcE6mYBzCV
	WhLr/V1j15FKEOnelg5G/QUYukxBJHdVyJUun8bUhjXditJmklh802wK4vug+Acoxm1NDT
	m8SuDkQsXYvKEGN8UZLZEbOgVZhMQwkUQ+DFg/qigRVIrRrcRMSn606rxPgP+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762169871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H+A2kkbWSNB6iE8g8vdOv3L2psTaC6itGdNeIXfXL90=;
	b=Elx285e/b/noOw36t17lLI3pQaCnNp6mR1yLsnhf/TZE2qRVJUVXjhtRpc+8wRz56p4zj1
	iKlXIAeae1daY+Bw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Michal Pecio <michal.pecio@gmail.com>
Cc: bp@alien8.de, da.gomez@samsung.com, dave.hansen@linux.intel.com,
	hpa@zytor.com, jpoimboe@kernel.org, linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org, mcgrof@kernel.org, mingo@redhat.com,
	paulmck@kernel.org, peterz@infradead.org, petr.pavlu@suse.com,
	samitolvanen@google.com, tglx@linutronix.de, x86@kernel.org
Subject: Re: [PATCH v3 22/28] x86: Use RCU in all users of __module_address().
Message-ID: <20251103113750.qam3KIkT@linutronix.de>
References: <20250108090457.512198-23-bigeasy@linutronix.de>
 <20251103110835.1dca378c.michal.pecio@gmail.com>
 <20251103103434.D6m23Iud@linutronix.de>
 <20251103113907.4e647f33.michal.pecio@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251103113907.4e647f33.michal.pecio@gmail.com>

On 2025-11-03 11:39:07 [+0100], Michal Pecio wrote:
> Sorry, I forgot to include the link. There is also a similar warning
> regarding __this_cpu_read(). Pretty sure the kernel is SMP.
> 
> https://bbs.archlinux.org/viewtopic.php?id=309960

The stack trace is a bit odd. The compressed version is:
| BUG: using smp_processor_id() in preemptible [00000000] code: Xorg/1183
| caller is in_entry_stack+0x11/0x60
| CPU: 3 UID: 1000 PID: 1183 Comm: Xorg Tainted: P           OE       6.16.12-hardened1-1-hardened #1 PREEMPT(full)  6edb90a7a07fab33bbee72d6d5ef53ba6eec3b9c
| Tainted: [P]=PROPRIETARY_MODULE, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
| Hardware name: ASUS All Series/Z97-E, BIOS 0803 02/23/2016
| Call Trace:
|  <TASK>
|  dump_stack_lvl+0x5d/0x80
|  check_preemption_disabled+0xe5/0xf0
|  in_entry_stack+0x11/0x60
|  get_stack_info+0x2c/0x80
|  stack_access_ok+0x51/0xa0
|  unwind_next_frame+0x1cb/0x7b0
|  arch_stack_walk+0xa6/0x110
|  stack_trace_save+0x4d/0x70
|  __kfence_alloc+0xb7/0x6f0
|  __kmalloc_noprof+0x520/0x560
|  os_alloc_mem+0x108/0x120 [nvidia 9746d397d5c5bffeb186e829669bb24c0846a4a7]
|  _nv015295rm+0x34/0x50 [nvidia 9746d397d5c5bffeb186e829669bb24c0846a4a7]
|  _nv015297rm+0x2b/0xd0 [nvidia 9746d397d5c5bffeb186e829669bb24c0846a4a7]
|  _nv016352rm+0x1c/0x90 [nvidia 9746d397d5c5bffeb186e829669bb24c0846a4a7]
|  _nv059298rm+0x65/0xb0 [nvidia 9746d397d5c5bffeb186e829669bb24c0846a4a7]
|  _nv054041rm+0x20f/0x360 [nvidia 9746d397d5c5bffeb186e829669bb24c0846a4a7]
|  _nv056165rm+0x54/0xd0 [nvidia 9746d397d5c5bffeb186e829669bb24c0846a4a7]
|  _nv056096rm+0xa0/0x500 [nvidia 9746d397d5c5bffeb186e829669bb24c0846a4a7]
|  _nv015919rm+0x424/0x680 [nvidia 9746d397d5c5bffeb186e829669bb24c0846a4a7]
|  _nv054015rm+0x69/0xd0 [nvidia 9746d397d5c5bffeb186e829669bb24c0846a4a7]
|  _nv014185rm+0x86/0xa0 [nvidia 9746d397d5c5bffeb186e829669bb24c0846a4a7]
|  _nv000652rm+0x5e/0x70 [nvidia 9746d397d5c5bffeb186e829669bb24c0846a4a7]
|  rm_kernel_rmapi_op+0x167/0x273 [nvidia 9746d397d5c5bffeb186e829669bb24c0846a4a7]
|  nvkms_call_rm+0x4c/0x80 [nvidia_modeset 90775ea8a26c5e58b97ef4b3f46eb45efa040eb2]
|  _nv003168kms+0x42/0x50 [nvidia_modeset 90775ea8a26c5e58b97ef4b3f46eb45efa040eb2]
|  ? do_syscall_64+0x82/0x8d0
|  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
|  </TASK>

The last two entries start with a '?' which means it did not originate
from the "stack unwind" but was laying around while passing through.
I would expect the last two entries to be there without the '?' because
userland (as in X here) enters the kernel via a proper syscall entry
which should be part of the stack strace.

Now, get_stack_info() where the warning originates: It starts with a
check to see if the stack pointer belongs to the current task's stack
frame which it does not. Then it checks if the task found is the
currently running task. That it does. So in that case, we must be
serving an exception (such as an IRQ) because the stack does not belong
to the current task.  However preemption is not disabled which indicates
that we do not do this.
This in turn suggests that nvidia replaced the stack from while entering
the syscall probably in _nv003168kms() or the binary blob which invokes
the kernel function does not have a proper ORC entry which leads to a
wrong turn in the process.

So the warning is well deserved.

Sebastian
