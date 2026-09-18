Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1629C37C903
	for <linux-modules@vger.kernel.org>; Fri, 18 Sep 2026 13:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789737770; cv=none; b=ME6TQFeK8BLyYeBNpfkIgBPmFSCC1Mrm54UCYMfmJGjn5HoqjkbWFJepcnjYdjy5zt/1CJrMYK4MnKXkCh5edpp6pDNQ/eMAbHDPdn64/Qd6RrFKLDYmeOtSN7tyYNCMo7n/V/cOrAUEtLv/YhbyQ6/+0jmpMhhVi/q0biRIyl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789737770; c=relaxed/simple;
	bh=b1No/s+YxvLDDWJ/c9YG5eDsGoNlnCstFBf6EMY3bdM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QE9sIGbd4fUpW6fFiwGtPNPQ/qwXLFvzq41T3eltF02NVUcNH/wkQfWY74DTpfFty2Gb0GwQsB8S6m2YcCeqIxy89rJuW/JQ+SecHlKz4nmw3sETGQAbolBY9aww63BjLi0obSsRexQxwoqiYoBIsMC5tpo7Z/7JtBoALousAu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gzs8LdAh; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzs8LdAh"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843f22dcb8so524392f8f.0
        for <linux-modules@vger.kernel.org>; Fri, 18 Sep 2026 06:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789737766; x=1790342566; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bi9+tp0tdSAqr1IOm/IF32S8WKoTQ+Hz6781U37us8U=;
        b=gzs8LdAh3l2N1BGYmnmRpRNeJmsU9TLEQKCral5PpadH8AZaNVIKi9SHLNWQNVd2h7
         Lz7bkfSz4rEyKG07BHrMr287Y98PhOgaizgvjyLlMl5kctIWfXVawoW3rFH8w9FNOtpz
         pYARzRMqB6dE+/0tKN2gBGyBZTn8TwL43mH4H22ZxdVRExYoEBwuwOoEnQ+U8YBOHS4h
         AH/21IqMALzTbuZWzg9S3RhmONcElOSJ+uClJhD3OQQY3xQfoeT4JQ2ODh2bIPDB09s+
         aOueOO3Iv/HI5ZCgZKfrsx+33vG8ZB7slOyfPLyAE2cH6U1fSyFbJcycLxiye4N7v60O
         DbOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789737766; x=1790342566;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bi9+tp0tdSAqr1IOm/IF32S8WKoTQ+Hz6781U37us8U=;
        b=dwysaOZCMcrfcMavqe6YWDopolOz9NzWLSMnHzNQ+4Z13JGGig3bQ986fTr0wVojaN
         0qjkubQWzxfusdvwBi550Nxarwc4rhRqJBSmfVcxnymkqDJCASCQoiu6OBQ/kwPZEGb3
         eHF+yHqi+tuQzlEB54hMxnSjSLP7XeB+q8m16Cc6OOeSrZPivdQUZ9gn3SyrBt5cFFKw
         ez3xwmTOWwjT6FlGURxVzaNXOxI6wJZ3pSEejdlNnbIOOoPJid4FaxqqQOkeEOw/lt+9
         +O4aW+PaiPHGngqsZfZEPr0Khrj6btTggvry6z1orM6FoqnDrBe9tjRHPlMs83bjrzIP
         dLog==
X-Forwarded-Encrypted: i=1; AKwUvBz/OUWKcSXs9zYqSu57MG2uRLQsBC/nWmGCa3XUsK20Lok+ptq+BtaGfOUJ6G7LDVnXVmnC8OZ5VBOwNeT3@vger.kernel.org
X-Gm-Message-State: AFuF++llmlgNmZKWUMfpX7C0/nM5ORiBat0cghjjCL6Mu9K/ckk4W8TZ
	67EEuYk6WvHypL6rlTHV0hw1cDuclS+drmkOuPqhUaHmCb8BimvExobH
X-Gm-Gg: AYBFou2ohyhcDIok7BT71ufqXa0VzMfGO22JI5895IHYyYzI2fUdW0YzCGhZnEjNo4C
	dj+u8drkr009Rwp3/AoZ7xg8h6bcjj2tSDgyyxgBzEIfb1QMHh98ZsbbIoYqTVGuVdeNKNhCJjq
	faTZXeGY5YhHUx5HVtpmDIC35MaqWlMjJNrfsjT9blIhxuRfj5WG3UXBbZ6mgby1GDQD9h5iFie
	Uvc4x7dxIs31+KwetWZZTm3rKNaEp4Uh2HCN2x8/6qo+/D2VDcCccLoAiiAnaI/05qmAmfpkRzi
	InO7tJPDGvfrxBciW6uas7V71jrpu3Da466R6/glwZikHBVrb+H4bp3pfwYC1gsDL//gsDmV8BX
	wTqtrjvSr11RghPLnE+UeOVoTkQFSGOIq30t64O3VGGfH3czBZQSCCBc18UXTgYeH+WlpC4GC+W
	cV95h2NbcIZ16ZeEHeyIi2sxuYEeHy6i1BvVV90WB9yFaF60nI8D4rP7GEr6h+QsHLN9bz8vCSC
	/dSpsZcBcaBq1zz3VoNKnq/9wXSktGRKw8=
X-Received: by 2002:a5d:5f90:0:b0:486:e737:d94b with SMTP id ffacd0b85a97d-4871e3814ebmr3476154f8f.51.1789737766063;
        Fri, 18 Sep 2026 06:22:46 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4871ff5605dsm4015260f8f.19.2026.09.18.06.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 06:22:45 -0700 (PDT)
Date: Fri, 18 Sep 2026 14:22:41 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Mahanta Jambigi <mjambigi@linux.ibm.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-s390@vger.kernel.org, "D. Wythe"
 <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, Sidraya
 Jayagond <sidraya@linux.ibm.com>, Tony Lu <tonylu@linux.alibaba.com>, Wen
 Gu <guwen@linux.alibaba.com>, Alexandra Winter <wintera@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Hidayath Khan <hidayath@linux.ibm.com>
Subject: Re: [RFC] module: init-failure path can free a module with live
 try_module_get() users
Message-ID: <20260918142241.55a6630a@pumpkin>
In-Reply-To: <5dc1fe2b-289e-4786-b9e9-e181dda8d4e9@linux.ibm.com>
References: <5dc1fe2b-289e-4786-b9e9-e181dda8d4e9@linux.ibm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Aug 2026 11:43:46 +0530
Mahanta Jambigi <mjambigi@linux.ibm.com> wrote:

> Hi Luis, Petr, Daniel, Sami, Aaron,
> 
> I'm writing to ask about what looks like a generic module-init failure
> lifetime problem in the module loader. I ran into it while working on
> the SMC networking module (net/smc/), but after several patch
> iterations, it seems the root issue may belong in kernel/module/main.c
> rather than in SMC itself. I'd appreciate your guidance on whether this
> reading is correct, and if so, what fix direction would be preferred.
> 
> THE ISSUE IN do_init_module()
> =============================
> 
> include/linux/module.h has a long-standing FIXME in module_is_live():
> 
>     /* FIXME: It'd be nice to isolate modules during init, too, so they
>        aren't used before they (may) fail. But presently too much code
>        (IDE & SCSI) require entry into the module during init. */
>     static inline bool module_is_live(struct module *mod)
>     {
>         return mod->state != MODULE_STATE_GOING;
>     }
> 
> Because MODULE_STATE_COMING is not MODULE_STATE_GOING, try_module_get()
> can succeed once a module's __init is executing. If __init makes the
> module externally reachable partway through and then later fails, the
> failure path in do_init_module() appears to do:

It is rather worse that that.
If sock_create() auto-loads a module (eg sctp) then nothing stops a second
sock_create() entering the protocol code before the initialisation completes.
That can be hit by two separate applications, I hit it from an out of tree
kernel module and avoided the problem by putting a mutex() around the
sock_create() call.

It might help by letting try_module_get(THIS_MODULE) always succeed
while blocking other requests until initialisation completes.
The code making the call must own a reference (otherwise the code could
just disappear), and that reference stops the module being unloaded.
That would let the initialisation code grab extra references (eg for
a worker thread) without allowing other codes paths enter the
part-initialised driver.

David

> 
>     fail:
>         mod->state = MODULE_STATE_GOING;
>         synchronize_rcu();
>         module_put(mod);
>         ...
>         free_module(mod);
> 
> synchronize_rcu() waits for RCU readers, but not for threads that
> already obtained a module reference via try_module_get() and are still
> executing module text.
> 
> By contrast, the normal unload path in try_stop_module() refuses to
> proceed while the refcount is non-zero.
> 
> So the asymmetry seems to be that the normal unload path waits for
> references to drain, while the init-failure path does not.
> 
> A concrete race would look like:
> 
>   1. Module __init registers an externally reachable interface.
>   2. User space enters through that interface and try_module_get()
>      succeeds while the module is still COMING.
>   3. A later __init step fails.
>   4. do_init_module() frees the module.
>   5. The in-flight caller is still executing module text.
> 
> SMC AS A CONCRETE EXAMPLE
> =========================
> 
> In SMC, simply moving registration later does not appear to eliminate
> the window, because there are two separate registration points that can
> make the module reachable via socket():
> 
>   1. sock_register(&smc_sock_family_ops)
>      After this, socket(AF_SMC, ...) can succeed and reach
>      try_module_get() via __sock_create().
> 
>   2. smc_inet_init() -> inet_register_protosw()
>      After this, socket(AF_INET, SOCK_STREAM, IPPROTO_SMC) can succeed
>      and again reach try_module_get().
> 
> Either registration point can succeed before a later init step fails.
> 
> This may not be specific to SMC; other protocol modules that become
> reachable during init, such as Bluetooth, may have similar exposure and
> appear worth auditing as well.
> 
> ON THE FIXME'S IDE/SCSI CONCERN
> ===============================
> 
> The FIXME mentions IDE and SCSI as reasons not to isolate modules
> during init.
> 
>   1. IDE was removed in Linux 5.14, so that half of the concern no
>      longer applies.
> 
>   2. SCSI still appears to self-reference during init
>      (scsi_device_get() -> try_module_get(hostt->module) during
>      scsi_scan_host()), so a blanket wait-for-refcount-to-drain
>      approach in the failure path may deadlock there.
> 
> Also, strong_try_module_get() already rejects MODULE_STATE_COMING with
> -EBUSY, so the infrastructure for refusing callers during init already
> exists in some form.
> 
> QUESTIONS
> =========
> 
> First, is my reading of this init-failure refcount/lifetime asymmetry
> correct?
> 
> If so, would one of the following directions be acceptable?
> 
>   1. An opt-in mechanism (for example, a module flag) for modules that
>      are safe to isolate during init and whose init-failure path should
>      wait for external references to drain.
> 
>   2. Treating MODULE_STATE_COMING as non-live for normal
>      try_module_get() users, with some explicit escape hatch for the
>      remaining subsystems that genuinely need self-entry during init.
> 
> Any guidance on the preferred direction would be much appreciated.
> 
> Best regards,
> Mahanta Jambigi
> 

