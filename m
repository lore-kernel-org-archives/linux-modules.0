Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F20427FA1
	for <linux-modules@vger.kernel.org>; Thu,  6 Aug 2026 09:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786008336; cv=none; b=DhWWYdQ8Dbe9P0k7XVAPHBO+pDDif6HNy6g8eMQc0urYQLOMQHkP5dcyFSO50g+8v8NmLCMH5vJjqAo4LFsC4WQ1YbqwUGoAm++9/ileTsDp+YqfYBTS283sIWjgClJjkVyhrXGN0YbPLpH1Qvi+XhcOcMSpwQndB0kX7Zw0Wj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786008336; c=relaxed/simple;
	bh=SiqGBLDuZCPn+rMTuCHSCqEOt3K+xS+5n2lrYKXRLyY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n9n6rVrQduzzNfSA+D0kCPU8NNe0gGIUUt//Kvi4OMzt4QAiQMjJRe05iUCzUMrAH0fFG0TyH6wpfuPpM/axqE2qVOhSoMISMCe9OyFVJj7zFH/ghfFqr/pVOFZg1fmu8tYqHVC+hTMcJhJ0C5nVFl8nNVomSdZBXSCt9yd2pcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWxZYESK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWxZYESK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B8E41F000E9;
	Thu,  6 Aug 2026 09:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786008334;
	bh=9bhS6lZm5mLFiyIA/+TAB3NawYW3lCRr6s1kVDhTh8Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kWxZYESK9FSbkbKG/ZOfa+2p341UeaIpyc3+KRR3YgjKAGFc1Ru0pHfJtNyyXJ3dn
	 fffXD8TlADuApDjk0KJFSJXdYnFeZrDeOLqi4VSaqmB6QU/IKguR4Z6OlY6b3V5GCO
	 KiE0grFLsmfIDUqIFWxrihdb9O3X8w2vypIgnCE9ByBaD01y1itUR2TBe5pg/ndXZf
	 7ObShsz0REoGxgqAKjI1c1bRrrkzM4HL/uHkVI/zrtw/k9jGZOcDr/XKFVoVYf2zG1
	 Piun6RY5UKn47+QLUAk6OTJzZpshyUwEnltOji8tboRNXZhx7V36VjmrOt3P5X9NI/
	 TaXD5MROhaloA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/6] module/dups: Inform duplicate requests about the
 result directly
Reply-To: sashiko-reviews@lists.linux.dev
To: "Petr Pavlu" <petr.pavlu@suse.com>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260806-module-stats-rcu-v3-1-2b0331106f00@suse.com>
References: <20260806-module-stats-rcu-v3-0-2b0331106f00@suse.com>
 <20260806-module-stats-rcu-v3-1-2b0331106f00@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 09:25:33 +0000
Message-Id: <20260806092534.4B8E41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Re-arming `delete_work` while it is currently executing leads =
to a Use-After-Free and timer corruption.
- [High] Waiters sleep in `wait_for_completion_state()` without holding a r=
eference to `kmod_req`, allowing `delete_work` to free the structure out fr=
om under them.
--

--- Patch [1]: [PATCH v3 1/6] module/dups: Inform duplicate requests about =
the result directly ---
commit b996b7173ceb4926f129328065b0224c2ccfe2d2
Author: Petr Pavlu <petr.pavlu@suse.com>

module/dups: Inform duplicate requests about the result directly

This patch removes the complete_work workqueue item that was used to delay
the completion signal. It updates kmod_dup_request_announce() to call
complete_all() and then immediately queue delete_work to clean up the entry.

> diff --git a/kernel/module/dups.c b/kernel/module/dups.c
> index 8b6f8f177de4f..45080f451e5c6 100644
> --- a/kernel/module/dups.c
> +++ b/kernel/module/dups.c
[ ... ]
> @@ -230,17 +205,17 @@ void kmod_dup_request_announce(char *module_name, i=
nt ret)
> =20
>  	kmod_req->dup_ret =3D ret;
> =20
> +	/* Inform all duplicate waiters to check the return value. */
> +	complete_all(&kmod_req->first_req_done);
> +

[Severity: High]
This isn't a bug introduced by this patch, but could this lead to a
use-after-free if a waiter thread is severely delayed after being woken up?

Waiters in kmod_dup_request_exists_wait() wait on this completion without
taking a reference to kmod_req:

kernel/module/dups.c:kmod_dup_request_exists_wait() {
    ...
    wait_for_completion_state(&kmod_req->first_req_done, ...);
    ...
    *dup_ret =3D kmod_req->dup_ret;
    ...
}

If a woken waiter is preempted, heavily throttled, or the system is suspend=
ed
for more than 60 seconds before it can return and read kmod_req->dup_ret,
delete_work will run and free kmod_req, causing a use-after-free when the
waiter resumes.

>  	/*
> -	 * If we complete() here we may allow duplicate threads
> -	 * to continue before the first one that submitted the
> -	 * request. We're in no rush also, given that each and
> -	 * every bounce back to userspace is slow we avoid that
> -	 * with a slight delay here. So queueue up the completion
> -	 * and let duplicates suffer, just wait a tad bit longer.
> -	 * There is no rush. But we also don't want to hold the
> -	 * caller up forever or introduce any boot delays.
> +	 * Now that we have allowed prior request_module() calls to go on
> +	 * with life, let's schedule deleting this entry. We don't have
> +	 * to do it right away, but we *eventually* want to do it so to not
> +	 * let this linger forever as this is just a boot optimization for
> +	 * possible abuses of vmalloc() incurred by finit_module() thrashing.
>  	 */
> -	queue_work(system_dfl_wq, &kmod_req->complete_work);
> +	queue_delayed_work(system_dfl_wq, &kmod_req->delete_work, 60 * HZ);

[Severity: Critical]
This is a pre-existing issue, but could this queue_delayed_work() call lead
to a use-after-free and timer corruption if it races with an executing
delete_work?

If a previous delete_work worker wakes up, clears the WORK_STRUCT_PENDING b=
it,
and blocks on kmod_dup_mutex:

Worker Thread:
  (clears WORK_STRUCT_PENDING)
  mutex_lock(&kmod_dup_mutex); // blocked

Concurrent module load:
kmod_dup_request_announce()
  mutex_lock(&kmod_dup_mutex);
  ...
  queue_delayed_work(..., &kmod_req->delete_work, 60 * HZ);
  mutex_unlock(&kmod_dup_mutex);

Because the pending bit was cleared by the worker, queue_delayed_work() will
successfully re-arm the timer.

When the worker thread acquires the mutex, it will unlink kmod_req and
unconditionally call kfree().  When the re-armed timer expires 60 seconds
later, the kernel will dereference the timer_list from freed memory, result=
ing
in a panic.

> =20
>  out:
>  	mutex_unlock(&kmod_dup_mutex);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806-module-sta=
ts-rcu-v3-0-2b0331106f00@suse.com?part=3D1
