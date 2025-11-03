Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71212FABF8;
	Mon,  3 Nov 2025 10:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762166080; cv=none; b=C8fD5V+GkGXJ1YepbL4vq7Qkx2gizGa03yLLRgQkeedbND74k0bA7HL2jQZfSebjsfJfpkJjgYM5TJikfQb43NIOTMtZ4kyN5FQuzyjTZGY/AftcuXAyvcuRoj9oVj/a/f/XYwKDJhM6TpHPpNrXX5KZdXZDKq/N0GNV02QQ+0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762166080; c=relaxed/simple;
	bh=8hcTDItY8kBoxn0miQMEedHmfMv8mVt0n7+GypIExEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N51o63TDciAw0vea855z0yPsIVDFvDKnQ4c3RzVo5v7wyi1RnJN9Iby6tFHqJuBtbQSFdrxqcJUIs0rB+8mv8lpVnbGQowhWLrnHBWRFTWXdpcoyYnk0a11ppQhxjiT4mCPVQuiWNKZj+ROOoF8cKkkSJIQDMTxhr9sXKYFYWLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yYTddFQ5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1NchKN+E; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yYTddFQ5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1NchKN+E"
Date: Mon, 3 Nov 2025 11:34:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762166076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TucjMQ+47l+5RTsAimzHenmlPKCUj3SbuPVz+/+LEeM=;
	b=yYTddFQ5txZvpgFwBTF3JM/xHZZ+VG87UdIttVQ3fe8KTrYp4Izf6+ZspW6CYkRtS7+dJ/
	RBEjt7mO9lfNjQoJ92XoyAfY4G5wazQGe/ruaB+FwpPJcRQViddCdCoiKc+JkgUQ8HIj84
	4bB6Yt/cU90xvCUQecQYWzIUD/hiB7DjfpeiJ6RabTZf7nZjXOy0rWoblshCdLfJfJHAy3
	KTkH8+9YMNpvKBjZPlE7y7+EFSbdSVcnLnQAXT3Q8gD4WJHvMAohXq5ymc+uLqlkHBpd8l
	913tpcHet/WOQ53f/aEkp4tKT+3u4FtQYq4yuMLPk57/4KzOhLjCHvGU0ieBsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762166076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TucjMQ+47l+5RTsAimzHenmlPKCUj3SbuPVz+/+LEeM=;
	b=1NchKN+EwOnZ4g9xZmS5oS2EjEMbRJS+tquuhefdpCc4kFqDekiENRFkUbRIiX3/aVpfjL
	vwOsS0gK9cLMrHDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Michal Pecio <michal.pecio@gmail.com>
Cc: bp@alien8.de, da.gomez@samsung.com, dave.hansen@linux.intel.com,
	hpa@zytor.com, jpoimboe@kernel.org, linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org, mcgrof@kernel.org, mingo@redhat.com,
	paulmck@kernel.org, peterz@infradead.org, petr.pavlu@suse.com,
	samitolvanen@google.com, tglx@linutronix.de, x86@kernel.org
Subject: Re: [PATCH v3 22/28] x86: Use RCU in all users of __module_address().
Message-ID: <20251103103434.D6m23Iud@linutronix.de>
References: <20250108090457.512198-23-bigeasy@linutronix.de>
 <20251103110835.1dca378c.michal.pecio@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251103110835.1dca378c.michal.pecio@gmail.com>

On 2025-11-03 11:08:35 [+0100], Michal Pecio wrote:
> Hi,
Hi,

> There is a regression report on a distribution forum which involves
> an out of tree module on a patched kernel (yes, I know) calling
> stack_trace_save() in task context, which arrives here and apparently
> calls the various deref_stack_xxx() functions with preemption enabled,
> which in turn call stack_access_ok() leading to a BUG:
> 
> Nov 02 21:44:30 ArchBasement kernel: BUG: using smp_processor_id() in preemptible [00000000] code: Xorg/1183
> Nov 02 21:44:30 ArchBasement kernel: caller is in_entry_stack+0x11/0x60
> Nov 02 21:44:30 ArchBasement kernel: CPU: 0 UID: 1000 PID: 1183 Comm: Xorg Tainted: P           OE       6.16.12-hardened1-1-hardened #1 PREEMPT(full)  6edb90a7a07fab33bbee72d6d5ef53ba6eec3b9c
> Nov 02 21:44:30 ArchBasement kernel: Tainted: [P]=PROPRIETARY_MODULE, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
> Nov 02 21:44:30 ArchBasement kernel: Hardware name: ASUS All Series/Z97-E, BIOS 0803 02/23/2016
> Nov 02 21:44:30 ArchBasement kernel: Call Trace:
> Nov 02 21:44:30 ArchBasement kernel:  <TASK>
> Nov 02 21:44:30 ArchBasement kernel:  dump_stack_lvl+0x5d/0x80
> Nov 02 21:44:30 ArchBasement kernel:  check_preemption_disabled+0xe5/0xf0
> Nov 02 21:44:30 ArchBasement kernel:  in_entry_stack+0x11/0x60
> Nov 02 21:44:30 ArchBasement kernel:  get_stack_info+0x2c/0x80
> Nov 02 21:44:30 ArchBasement kernel:  stack_access_ok+0x51/0xa0
> Nov 02 21:44:30 ArchBasement kernel:  unwind_next_frame+0x1cb/0x7b0
> Nov 02 21:44:30 ArchBasement kernel:  ? _nv003168kms+0x42/0x50 [nvidia_modeset 90775ea8a26c5e58b97ef4b3f46eb45efa040eb2]
> Nov 02 21:44:30 ArchBasement kernel:  ? __pfx_stack_trace_consume_entry+0x10/0x10
> Nov 02 21:44:30 ArchBasement kernel:  arch_stack_walk+0xa6/0x110
> Nov 02 21:44:30 ArchBasement kernel:  ? _nv003168kms+0x42/0x50 [nvidia_modeset 90775ea8a26c5e58b97ef4b3f46eb45efa040eb2]
> Nov 02 21:44:30 ArchBasement kernel:  stack_trace_save+0x4d/0x70
> 
> Is this nvidia doing something wrong, or a problem with this commit?
> 
> The removed code suggests that preemption is allowed here, and as far
> as I see, this call trace is still possible on vanilla 6.18. Perhaps
> preempt_disable() needs to be restored around this code?

Do you have the complete backtrace? Is this SMP or UP build?

> Regards,
> Michal

Sebastian
