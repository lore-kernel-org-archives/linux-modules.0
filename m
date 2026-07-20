Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F4F417D8F
	for <linux-modules@vger.kernel.org>; Mon, 20 Jul 2026 12:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784550766; cv=none; b=JJeFqaSRgTg4Uh0Zie1am6DeaJvZqDqQtVC90ZN3A2ZNOSU54bM2A3t/3ZJAMoxlfbI0sAxDNPQTWPOnlZL3hgxaivZqfRWFrtUfhZQiG069Q+NJjv53cfbZqY+knDcTvwV3a4g4O8ma80X34uLj1J+G0Z1UBrxhu3v679WgKUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784550766; c=relaxed/simple;
	bh=D6G7IUqmJnHM5uky7r00zkPuE8q+UnHUyVHuiC3pJLw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MohQzPp6Az2GnP/xdN13PQUm19C9Fi7iwELwGFHzk4P4PVku6y6tx917caUZzZqJc1uGf7DoddUF3L7hYjsBYqk++ZJXY1s5I8s3AbSDns3ybiYyOwQ65HTSp6dSSRwNmHSKNkdmOLrU1KcCrzzdm9WgVAAktT0+6CjwUSPQ9Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNQ0oWj2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNQ0oWj2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE231F000E9;
	Mon, 20 Jul 2026 12:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784550765;
	bh=uviTrai8dXlfmS775ix8TU1/T0U3E8zfEmyh5pbZo8o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oNQ0oWj2wCOTjSMQ4dY7z00l/cKft1N21vhYlWRiLeucKQSi6HYtHHc+3A8gK9S04
	 rpePZzGbwKZnIJO3tgN7GEmZqNkrtBOF41mxOZdp4kDq7TB1ATTOqNBOM9V/BbIOZS
	 4Ah7X9jv16BcRG6n0Qz8XPHkTCHM599hQ93j/8Rxkgq/YcvU4L40HS6Vs/yXYZ503w
	 QoGVcRcVckGZyxQ7qm28pUxxR8mclz0YNpss9jAZ8WLC0pp5Bi/og4VXzO+SHklok7
	 AwPGSZ3CNPvksDWibVz9jorET/3ttOBdWbO/2PKAeiU6+LcROiBl5kdTOWWHd86rzi
	 a8umjCt7VZGhA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] module/dups: Fix use-after-free in kmod_dup_req
 lifetime handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Petr Pavlu" <petr.pavlu@suse.com>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260720121621.750661-2-petr.pavlu@suse.com>
References: <20260720121621.750661-1-petr.pavlu@suse.com>
 <20260720121621.750661-2-petr.pavlu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 12:32:44 +0000
Message-Id: <20260720123244.EDE231F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] A pre-existing use-after-free exists in `kmod_dup_request_comp=
lete()` due to `kmod_dup_request_announce()` queuing `complete_work` withou=
t holding a reference.
--

--- Patch [1]: [PATCH 1/5] module/dups: Fix use-after-free in kmod_dup_req =
lifetime handling ---
commit c16274209ebc300f334c8ae6c8a5bec3494aa562
Author: Petr Pavlu <petr.pavlu@suse.com>

module/dups: Fix use-after-free in kmod_dup_req lifetime handling

The kmod dups code uses RCU to ensure that a kmod_dup_req instance is freed
only after it is no longer referenced. When releasing an instance, the
kmod_dup_request_delete() function removes the kmod_dup_req from the
dup_kmod_reqs list, waits via synchronize_rcu() and finally frees it.
However, this doesn't work correctly because parallel users referencing the
instance in kmod_dup_request_exists_wait() don't enter an RCU read-side
critical section. This can result in a use-after-free.

Fix the issue by changing the lifecycle management of kmod_dup_req to use
reference counting.

> diff --git a/kernel/module/dups.c b/kernel/module/dups.c
> index 1d720a5311ba0..e1828e865edde 100644
> --- a/kernel/module/dups.c
> +++ b/kernel/module/dups.c

[ ... ]

> @@ -224,6 +241,10 @@ void kmod_dup_request_announce(char *module_name, in=
t ret)
> =20
>  	mutex_lock(&kmod_dup_mutex);
> =20
> +	/*
> +	 * Find the entry previously added in kmod_dup_request_exists_wait()
> +	 * that is owned by the current task.
> +	 */
>  	kmod_req =3D kmod_dup_request_lookup(module_name);
>  	if (!kmod_req)
>  		goto out;

[Severity: Critical]
This is a pre-existing issue, but is there still a use-after-free risk for
complete_work even with the refcounting switch?

Looking further down in kmod_dup_request_announce(), it queues the
asynchronous work item without incrementing the object's reference count:

	queue_work(system_dfl_wq, &kmod_req->complete_work);

Because no reference is held for the work item, kmod_req could be freed by
delete_work before kmod_dup_request_complete() finishes executing.

When the work executes in kmod_dup_request_complete() and dereferences
kmod_req to call complete_all(&kmod_req->first_req_done), this could access
freed memory.

Can concurrent auto-loads trigger this? For instance, if multiple tasks
execute __request_module() concurrently:

Task 1 (wait=3Dfalse)                 Task 2 (wait=3Dtrue)
kmod_dup_request_announce()
  queue_work(complete_work)
                                    kmod_dup_request_announce()
                                      queue_work(complete_work)

Could the second complete_work execution be queued just before the 60-second
timer expires, and run right after delete_work frees the object?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720121621.7506=
61-1-petr.pavlu@suse.com?part=3D1
