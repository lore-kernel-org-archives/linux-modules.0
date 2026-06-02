Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8025630677B
	for <linux-modules@vger.kernel.org>; Tue,  2 Jun 2026 04:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780374282; cv=none; b=FhyS8irgCV4XIwgJBGypQfzF7iBx18XY73H1JSFvBpeoe+L9/PuGFdKLaibHuso5rt62WkNmoH/lET3QYSo/oIsXGZYpwIRKTzvpcy6e00VpKS/bYY3bQJIVdNLGPFkXqDW1YyWNwa2DfwNd3Sd/W7ixE+qqgx+8XZWeh5l2Ims=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780374282; c=relaxed/simple;
	bh=V6LwKl30XDnEWMAHMPHxd4Scv28Y0AYWNdFHYCmOUSM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BEShS9jmDu0VKNEM4nMNhT2zIOgO3IeCOCgCuQn4MkkrkMddpuVHG9852MXN/sznhciLnDYv7Cib9r+8g+vTy8/HtCqjbURLQXgXU26HbX3RMaxJyhDvZO5q5n5zqpHMbQy9zLxXpWrAWKee6vX72lg9oJ/fJZKISB60oUBXjaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nj5GfKcF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nj5GfKcF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 996331F00893;
	Tue,  2 Jun 2026 04:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780374280;
	bh=jtEPToHZkjj85qJ/YrlSOSNzn9dlmAVIYSLAwK9o1Ds=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nj5GfKcFEkjO6m/6eNbwbwESzKX81mTw6ZXQYxPt48gsbn8AS98cX+zciP4ATrXjO
	 H6Yhp8gW/d/POiOvBSqqJEY6lAgABa0KU3/nl0YcmNGA1qzNU6ubRImqT06lDVdib9
	 2URSZijaIz+q4WtLx+RtUj9jNpSHcqsrhiXqWS0TuUV99TZ3Oam4ISIV2chPpvfaoZ
	 +vH34sR2esVLJjIUZCEWfDIrDqANKm59wgMPwjbwh/eSwXrD8Tvy9L6pbCnsMtBPw6
	 sjfFCSAPWNdoIYBm9tJbw1kmJ00tCHDbHxZ/dbw0tvZdIbmag3uBcyMoQNXzdrR7lZ
	 IYy7PRq/OEILQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] module: dups: don't hold mutex across synchronize_rcu()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Naveen Kumar Chaudhary" <naveen.osdev@gmail.com>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <ajydyxgaea27rhcopp5eauji24znotu65d2b4uw344yvmwcc6f@7l5re6f2xcuk>
References: <ajydyxgaea27rhcopp5eauji24znotu65d2b4uw344yvmwcc6f@7l5re6f2xcuk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 04:24:40 +0000
Message-Id: <20260602042440.996331F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-After-Free due to missing reference counting on kmod_req.
--

commit 6715d39010e803da11ebd165eb2b1fa9278aa3d7
Author: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>

module: dups: don't hold mutex across synchronize_rcu()

This commit optimizes kmod_dup_request_delete() by moving synchronize_rcu()
outside the kmod_dup_mutex critical section. This prevents blocking other
mutex users during the RCU grace period.

> diff --git a/kernel/module/dups.c b/kernel/module/dups.c
> index 1d720a5311ba0..46e74c06ed52d 100644
> --- a/kernel/module/dups.c
> +++ b/kernel/module/dups.c
> @@ -88,8 +88,8 @@ static void kmod_dup_request_delete(struct work_struct =
*work)
>  	 */
>  	mutex_lock(&kmod_dup_mutex);
>  	list_del_rcu(&kmod_req->list);
> -	synchronize_rcu();
>  	mutex_unlock(&kmod_dup_mutex);
> +	synchronize_rcu();
>  	kfree(kmod_req);

[Severity: High]
This is a pre-existing issue, but does this code leave kmod_req vulnerable
to a use-after-free since waiters don't hold a reference count?

In kmod_dup_request_exists_wait(), a duplicate requester drops kmod_dup_mut=
ex
and blocks on wait_for_completion_state(&kmod_req->first_req_done). If the
original thread finishes loading and calls kmod_dup_request_complete(), it
queues this delete_work with an arbitrary 60-second delay.

If the waiter is preempted or otherwise delayed for more than 60 seconds
(either before blocking, or after waking up but before reading
kmod_req->dup_ret), kmod_dup_request_delete() will free kmod_req here.

The synchronize_rcu() call does not protect the waiter because the waiter
sleeps in wait_for_completion_state() and cannot hold an RCU read lock.
When the waiter resumes, it could attempt lock operations on the freed
completion structure's waitqueue lock, or read kmod_req->dup_ret, resulting
in a use-after-free.

Would it be safer to add explicit reference counting to kmod_req to ensure
it remains allocated until all waiters have resumed and finished reading?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/ajydyxgaea27rhcopp5=
eauji24znotu65d2b4uw344yvmwcc6f@7l5re6f2xcuk?part=3D1
