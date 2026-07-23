Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83D635BDC2
	for <linux-modules@vger.kernel.org>; Thu, 23 Jul 2026 08:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784796074; cv=none; b=aztyu43HTIsTBfKYkT285gmqwF9pUARWNWvImIKMls9F4/9WWPzTvloGQ5DKKhqcwvHU+c+nmbrZFEjLMuDFpdasiX5rRlzrRDHLJz70Gd2OT88zLJ8F+p3bhfpz95UHJuAHpaodE4OwqUdX/c6Ib6mqzWmjo94mETt2C9aOKnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784796074; c=relaxed/simple;
	bh=QgfrTGjZNTarXKYM1bihCRmwJ/2KOEG5Q2WnTTx/rCY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OXbVY8uDR35vBlxLkOkBN9Y4I4DszJQycsG3JM1jLURMCeBxOdRzK5sztKE76lLvtY1F4YS6Rb0hROLKsZ94hPgI0DiD6J2a8iHKrtYp3XI0iWpsK7/SAG5kGSHCQKMIwxwyowF8AytqiGhPTgsV0iMKbqUbuG1Ot+LGiHD8ttE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64F631F00A3D;
	Thu, 23 Jul 2026 08:41:13 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/6] module/dups: Inform duplicate requests about the
 result directly
Reply-To: sashiko-reviews@lists.linux.dev
To: "Petr Pavlu" <petr.pavlu@suse.com>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260723-module-stats-rcu-v2-1-bd582261fae3@suse.com>
References: <20260723-module-stats-rcu-v2-0-bd582261fae3@suse.com>
 <20260723-module-stats-rcu-v2-1-bd582261fae3@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 08:41:12 +0000
Message-Id: <20260723084113.64F631F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lack of reference counting on `kmod_dup_req` allows Use-After-Free=
 vulnerabilities when duplicate waiters or concurrent announcers race with =
the 60-second deletion timer.
--

--- Patch [1]: [PATCH v2 1/6] module/dups: Inform duplicate requests about =
the result directly ---
commit a68253df788049311e521e9217563df8d2aeb41e
Author: Petr Pavlu <petr.pavlu@suse.com>

    module/dups: Inform duplicate requests about the result directly

    When kmod_dup_request_announce() announces the completion of
    a request_module() call to duplicate waiters, it queues a work item to
    invoke kmod_dup_request_complete(), and only that function calls
    complete_all(). This adds an arbitrary delay that is unnecessary and
    provides little benefit. Call complete_all() directly from
    kmod_dup_request_announce() instead.

> diff --git a/kernel/module/dups.c b/kernel/module/dups.c
> index 1d720a5311ba0..b063bc423aa81 100644
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

[Severity: High]
This is a pre-existing issue, but could this delayed work cause a
use-after-free since kmod_dup_req lacks reference counting?

If a duplicate request thread waits on first_req_done in
kmod_dup_request_exists_wait() without holding a reference, and is preempted
for over 60 seconds after waking up, the deletion worker could call kfree()
on kmod_req in kmod_dup_request_delete(). When the waiter resumes, reading
kmod_req->dup_ret would result in a use-after-free.

Additionally, could queue_delayed_work() here race with an actively
executing teardown? If two threads concurrently call
kmod_dup_request_announce() for the same module, and the second thread calls
it exactly when the 60-second timer fires, it could re-arm the timer while
the first worker thread clears the pending bit but blocks on
kmod_dup_mutex. The second thread would release the mutex, the worker would
proceed to free kmod_req, and the re-armed timer would later fire on freed
memory.

> =20
>  out:
>  	mutex_unlock(&kmod_dup_mutex);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723-module-sta=
ts-rcu-v2-0-bd582261fae3@suse.com?part=3D1
