Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600132FBE1F
	for <linux-modules@vger.kernel.org>; Mon,  3 Nov 2025 10:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762164529; cv=none; b=R5TMbiPPzPIwwTMMt1+DMXg6lW7K6zGUUHjjYcCYoSIMnU2KfZh5CrCCx3ZOlEaBzMv/MvbpRNGBz9Z90RhuUn+S+eZ9vsT2/QxhzjtflcuS+Hd7pfAx/QUb/qx1jaJnqgwa55RvZRna57fi4fi+JmwA/V/rbfsCwt/31rHa/d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762164529; c=relaxed/simple;
	bh=YsTF68mjR39B/r/G6EPCUdpxSXCB8HJ4vZ+J81ZFViU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=qxGWT/GurrHuICV1zwtTDZIauIblt0qNJ3279IQAJrXAWg17dNh2YFUOeXy5G9YYcaLpbpQMuhzGJZrNPzXKA7e92TY/eN5OPR3oJh+M8zh8IWe6IdxsH25954/gRmubGaPhXXKmYs63cim4WiKivR2GvF4n8yGA4Tx2Ue+lnqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMNO6Hbf; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMNO6Hbf"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b4f323cf89bso928281566b.2
        for <linux-modules@vger.kernel.org>; Mon, 03 Nov 2025 02:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762164526; x=1762769326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tLS6qgKRGlV1tkSNCOlSCrCisKumvAST+7mt3QUKFME=;
        b=DMNO6HbfY7/ZVxGwmvwUUzErGvh8CWY+wb/crRNs3uS/5/PkUFPWJhyGKWEt1IgKv2
         WbsPLhnvK8r/Kq6gNTAcTnmAExm6HgmdDaasRENjtlVfvbEPhVRJ+S5Kg+2ullVMdpSm
         cSIZRXF0SbA+q8HzSaKcJgfZ2dtT6dQwRU5R0mj8/Plx9PeCp10G4BgUXS0C7CA8h7R5
         6z6WFB21x+xXrSyRbJQXQbTUtrCBTptX9FvVX7d2DUCO3KydSkvRjYGD+WDXisVosTGB
         8ITCH6tNmhaXOGLiJeIww35gaRvT6n7WsDYKZDt9YmB4vfPmU9aBTOg5A7BIy3C5B9I+
         1dvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762164526; x=1762769326;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLS6qgKRGlV1tkSNCOlSCrCisKumvAST+7mt3QUKFME=;
        b=Nk8S+x0N2zVC4ruNxtrrCoXp2YiPM5jSmB9uDLZDr5/0qCNgVeJ+ypIiBip6/91g0/
         YqZ6rPMwJK+ppgmu5xXkcSs0fhhrG+0BA42c7aO1jUGzRy8SsGln2ayUtfP6QWqBUxR4
         N81jP0yYqZTVmMVFtnl8/Q7fBlC5dQdlkqST0iup+NoGhkLlwCfxX8xXwJAm7VgtV23W
         GDQMIqzHu5KoF8kiENC5WOTjUGjGRIE1VX/uuNj1o0WlB9rSRRd+YNwL7u/Y3Rc8E994
         RDFzC+7AUpok2dQZoYdh6XP4/pZMxDrcjvO3Qj5LBnNe2MDLMbFjkrO0XiuhTJzovCaN
         /1cQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUqBQdB9LTn3Nqu5HGsPNU1Xz0DXz3qsZc1Ua9rgAlnn6/+SjJfG4r6mReGih/FD85Jbw/NkWxoX3doUQC@vger.kernel.org
X-Gm-Message-State: AOJu0YyYVGx4UPT5GafiLTkwX74arrSiwva/qRX9Ug15g5qijdY3eD1/
	TzL0kj7+eXWlJA/sMVfXFiy6Y9mTVLjR/idvSs3JuQXLkD4lmZQMZL+v
X-Gm-Gg: ASbGncvDhvqQhx8RZ7rBDI0StaD07wkPU8bZcaPHqDhXr1LAOajol3QGifJhGgVXGY0
	8jAQ6YgvFm58RWBcyTyOvwk8/wN6lbf33NgDukdowi7NMamiiiNIYEpZIYNV3R/H8pSVw1qg/1K
	SOxdvYEt/LilhMnEt6EXndKetrWcwicrWUKlP/QOtjl32hM8iAXjXuPTOZ4ZBsftYBqWK0f6uDV
	cHxO1G5RHDHFuLH248eQcN8OGpj3q0FfImtsm9w2AH8Jbj2FNNjFyMG+xzQqmVsNKtQqr0yJ9ar
	9HvksSwovL8VhIEO0IuQswb7SA9H7WXrpY9d9V73d2F8mninCh5GQ2g6P9bAME1jIJGSBohtVfi
	uvuBWFMEJIEvEvkofSspsIWJuAF7GZGfsukmq/Hr0SqOuEA5idzwrPjasSta8ziVJUx/1nN2MSt
	o+E106A2Ush+Yi
X-Google-Smtp-Source: AGHT+IEv5yXN9Rq+z/PHyS8obHrzjUW6HYGA45FU+WSNF/Zev/u9SGVmMPbE9+9XkPkG1FxuYOM0eQ==
X-Received: by 2002:a17:907:3d4f:b0:b70:6d3a:a08b with SMTP id a640c23a62f3a-b70700ad4dfmr1388461366b.10.1762164525413;
        Mon, 03 Nov 2025 02:08:45 -0800 (PST)
Received: from foxbook (bgu110.neoplus.adsl.tpnet.pl. [83.28.84.110])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b718a2dd982sm74711866b.49.2025.11.03.02.08.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 03 Nov 2025 02:08:45 -0800 (PST)
Date: Mon, 3 Nov 2025 11:08:35 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: bigeasy@linutronix.de
Cc: bp@alien8.de, da.gomez@samsung.com, dave.hansen@linux.intel.com,
 hpa@zytor.com, jpoimboe@kernel.org, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org, mcgrof@kernel.org, mingo@redhat.com,
 paulmck@kernel.org, peterz@infradead.org, petr.pavlu@suse.com,
 samitolvanen@google.com, tglx@linutronix.de, x86@kernel.org
Subject: Re: [PATCH v3 22/28] x86: Use RCU in all users of
 __module_address().
Message-ID: <20251103110835.1dca378c.michal.pecio@gmail.com>
In-Reply-To: <20250108090457.512198-23-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

> x86: Use RCU in all users of __module_address().
>
> __module_address() can be invoked within a RCU section, there is no
> requirement to have preemption disabled.
> 
> Replace the preempt_disable() section around __module_address() with
> RCU.
> 
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: x86@kernel.org
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/x86/kernel/callthunks.c | 3 +--
>  arch/x86/kernel/unwind_orc.c | 4 +---
>  2 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
> index f17d166078823..276b5368ff6b0 100644
> --- a/arch/x86/kernel/callthunks.c
> +++ b/arch/x86/kernel/callthunks.c
> @@ -98,11 +98,10 @@ static inline bool within_module_coretext(void *addr)
>  #ifdef CONFIG_MODULES
>  	struct module *mod;
>  
> -	preempt_disable();
> +	guard(rcu)();
>  	mod = __module_address((unsigned long)addr);
>  	if (mod && within_module_core((unsigned long)addr, mod))
>  		ret = true;
> -	preempt_enable();
>  #endif
>  	return ret;
>  }
> diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
> index d4705a348a804..977ee75e047c8 100644
> --- a/arch/x86/kernel/unwind_orc.c
> +++ b/arch/x86/kernel/unwind_orc.c
> @@ -476,7 +476,7 @@ bool unwind_next_frame(struct unwind_state *state)
>  		return false;
>  
>  	/* Don't let modules unload while we're reading their ORC data. */
> -	preempt_disable();
> +	guard(rcu)();
>  
>  	/* End-of-stack check for user tasks: */
>  	if (state->regs && user_mode(state->regs))
> @@ -669,14 +669,12 @@ bool unwind_next_frame(struct unwind_state *state)
>  		goto err;
>  	}
>  
> -	preempt_enable();
>  	return true;

Hi,

There is a regression report on a distribution forum which involves
an out of tree module on a patched kernel (yes, I know) calling
stack_trace_save() in task context, which arrives here and apparently
calls the various deref_stack_xxx() functions with preemption enabled,
which in turn call stack_access_ok() leading to a BUG:

Nov 02 21:44:30 ArchBasement kernel: BUG: using smp_processor_id() in preemptible [00000000] code: Xorg/1183
Nov 02 21:44:30 ArchBasement kernel: caller is in_entry_stack+0x11/0x60
Nov 02 21:44:30 ArchBasement kernel: CPU: 0 UID: 1000 PID: 1183 Comm: Xorg Tainted: P           OE       6.16.12-hardened1-1-hardened #1 PREEMPT(full)  6edb90a7a07fab33bbee72d6d5ef53ba6eec3b9c
Nov 02 21:44:30 ArchBasement kernel: Tainted: [P]=PROPRIETARY_MODULE, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
Nov 02 21:44:30 ArchBasement kernel: Hardware name: ASUS All Series/Z97-E, BIOS 0803 02/23/2016
Nov 02 21:44:30 ArchBasement kernel: Call Trace:
Nov 02 21:44:30 ArchBasement kernel:  <TASK>
Nov 02 21:44:30 ArchBasement kernel:  dump_stack_lvl+0x5d/0x80
Nov 02 21:44:30 ArchBasement kernel:  check_preemption_disabled+0xe5/0xf0
Nov 02 21:44:30 ArchBasement kernel:  in_entry_stack+0x11/0x60
Nov 02 21:44:30 ArchBasement kernel:  get_stack_info+0x2c/0x80
Nov 02 21:44:30 ArchBasement kernel:  stack_access_ok+0x51/0xa0
Nov 02 21:44:30 ArchBasement kernel:  unwind_next_frame+0x1cb/0x7b0
Nov 02 21:44:30 ArchBasement kernel:  ? _nv003168kms+0x42/0x50 [nvidia_modeset 90775ea8a26c5e58b97ef4b3f46eb45efa040eb2]
Nov 02 21:44:30 ArchBasement kernel:  ? __pfx_stack_trace_consume_entry+0x10/0x10
Nov 02 21:44:30 ArchBasement kernel:  arch_stack_walk+0xa6/0x110
Nov 02 21:44:30 ArchBasement kernel:  ? _nv003168kms+0x42/0x50 [nvidia_modeset 90775ea8a26c5e58b97ef4b3f46eb45efa040eb2]
Nov 02 21:44:30 ArchBasement kernel:  stack_trace_save+0x4d/0x70

Is this nvidia doing something wrong, or a problem with this commit?

The removed code suggests that preemption is allowed here, and as far
as I see, this call trace is still possible on vanilla 6.18. Perhaps
preempt_disable() needs to be restored around this code?

Regards,
Michal
