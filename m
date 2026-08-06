Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F32E3F3285
	for <linux-modules@vger.kernel.org>; Thu,  6 Aug 2026 09:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786009325; cv=none; b=aLX883Lqya9bFp7RGRiPAbt7ycF7btoBFaqFcJO8Y9SWePReXnVr57xW/LvikT1Yc91c/Il5SRt80e7jCKvmFFAxMNjR5yas3H7NNlp4guJB+sBIa7EcgQEZqG1Mlk3re/hngO4t5VKosWT0nLfakpk8YrRW9ifACjzUSjaggsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786009325; c=relaxed/simple;
	bh=tVHP17r468cipyYaUa75+zr4iQR1T/aDllzCui0VRIU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WTWHZsdNqUF7K0taZaGt4BCMaAb5FM6Php//N860ylIJTMmnT9fI0M1PtDKPkrurJmFbgDyZZLJuGTNq3b80GkPxrtPrNCYcaLMXNUIuj6xtfLGKY2ccN6BymqmoO2KbwqwKyqsneRKhW00K3P0O31ZVrc422FVrUtgE84rJxhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=neNb2woO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="neNb2woO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A981F000E9;
	Thu,  6 Aug 2026 09:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786009322;
	bh=7ckOZE3WKUBxAOJ4X5NMKUQKEgoBm/3J8MmX0bzn/WI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=neNb2woO/gd7bfILWDoVyHp7qrTOMCh6G9uaaAH+GT97Al8/5fsJPRZqn/hw9lYz4
	 iQAfS6amRirbrYMoegfV6/ptGbj4ftVCCRNPoXtYWZvC1M7EnqFrauotQurCzaFdF5
	 T20jt3L9EW/RMCedFpXBKVebdwvthDqJRxdAODDq4+/K/iHfoA499pepNWObeVjtJx
	 tRS8PeZy0YxINhxqTokR5epngmvo0s/3aNPoC4UsdCZlvKvFkkIwp4gz3MqarJFfKR
	 /7TwgXtK1vCzVbmycfP3aUg5kLT2mGHG5oJD3KTCVz/JAAZKKQK81K53Cn1DdIwg+9
	 1KjKf5m3Phz0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/6] module/dups: Avoid unnecessary kmod_dup_req
 allocations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Petr Pavlu" <petr.pavlu@suse.com>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260806-module-stats-rcu-v3-3-2b0331106f00@suse.com>
References: <20260806-module-stats-rcu-v3-0-2b0331106f00@suse.com>
 <20260806-module-stats-rcu-v3-3-2b0331106f00@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 09:42:02 +0000
Message-Id: <20260806094202.A5A981F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A `request_module_nowait()` call can prematurely complete a concur=
rent `request_module(wait=3Dtrue)` request, causing synchronous waiters to =
proceed before the module is actually loaded.
--

--- Patch [3]: [PATCH v3 3/6] module/dups: Avoid unnecessary kmod_dup_req a=
llocations ---
commit c39253dbe61d24363b967a87af56bd7ef5c557ff
Author: Petr Pavlu <petr.pavlu@suse.com>

module/dups: Avoid unnecessary kmod_dup_req allocations

This commit defers the allocation of kmod_dup_req until it is actually
needed, instead of preallocating it before taking the mutex. It introduces
a helper alloc_kmod_req() to simplify the initialization process.

> diff --git a/kernel/module/dups.c b/kernel/module/dups.c
> --- a/kernel/module/dups.c
> +++ b/kernel/module/dups.c
[ ... ]
> @@ -138,7 +141,6 @@ bool kmod_dup_request_exists_wait(char *module_name, =
bool wait, int *dup_ret)
>  		 * If a prior request to this one came through with
>  		 * request_module() though, then a request_module_nowait()
>  		 * would benefit from duplicate detection.
>  		 */
>  		if (!wait) {
> -			kfree(new_kmod_req);
>  			pr_debug("New request_module_nowait() for %s -- cannot track duplicat=
es for this request\n", module_name);
>  			mutex_unlock(&kmod_dup_mutex);
>  			return false;

[Severity: High]
This is a pre-existing issue, but does a request_module_nowait() call risk
prematurely completing a concurrent request_module() call that is waiting?

If Thread B calls request_module_nowait("foo"), it doesn't create a
tracking entry because wait is false. If Thread A subsequently calls
request_module("foo") with wait=3Dtrue, it creates the tracking entry and
blocks for processing. If Thread C then calls request_module("foo") with
wait=3Dtrue, it finds Thread A's entry and blocks waiting for it.

Because Thread B used nowait, its execution finishes quickly (waiting only
for the modprobe binary to exec) and returns 0. It then unconditionally
announces completion:

kernel/module/dups.c:kmod_dup_request_announce() {
        ...
        kmod_req =3D kmod_dup_request_lookup(module_name);
        if (!kmod_req || completion_done(&kmod_req->first_req_done)) {
                mutex_unlock(&kmod_dup_mutex);
                return;
        }

        kmod_req->dup_ret =3D ret;

        /* Inform all duplicate waiters to check the return value. */
        complete_all(&kmod_req->first_req_done);
        ...
}

Won't this find Thread A's tracking entry, assign dup_ret =3D 0, and wake up
Thread C prematurely while the module is still being loaded in the
background by Thread A?

If Thread C receives a success return value before the module is actually
fully loaded and initialized, could this cause drivers or subsystems to
attempt to use uninitialized module symbols or hardware features?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806-module-sta=
ts-rcu-v3-0-2b0331106f00@suse.com?part=3D3
