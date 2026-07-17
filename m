Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296CA3502A7
	for <linux-modules@vger.kernel.org>; Fri, 17 Jul 2026 08:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784277619; cv=none; b=H7p0ok0iP+3MGR3q4PxDMe+cb0QELEnNpQRaf+ei4NCZTUj412SXJednDZVpkceb0gnqk1QnmC9kGutXmPxdAaoP//TB3fN11ZW4ycen7vgYEWQUQl+QpS6QtNtuCqAP6HvOT17E1gBndhfMSHqKUiJ+kGXkGeD1vTIe4OZagdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784277619; c=relaxed/simple;
	bh=mMOA+tizYDZ2flofsgUAeW8A9FlYc5bLW63FaaMUL4E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NM1A5LqNls668ndXWJzxy7yJLinGUh79VsfDvXP0v1m6m6LssPdbLRv4+N7g24mQiljWbPfhMUhcLKv0MSdeJ2fusURrvctGK7COalBgRpduBf+jPWXBY428RkXn8wUGjZHLerqo87buWErIODdaD/tk9/Kfbi2hh3zy1knZ0pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VDQwzbWK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VDQwzbWK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9CFE1F000E9;
	Fri, 17 Jul 2026 08:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784277617;
	bh=BlFs5VUJKhnDQ5K9zlPB3S8PSeGA177fvd4d+/48RQg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VDQwzbWKFS0zyKZ1HOyO05XGW+OtoJ7jqzD/wYBD7+7Ncu/d2Ty6N7QVlJXVjaTFR
	 ACXWX2vJErTRqxRNALELneCYEt0kaxSGlvqq57FxiQCmv6TzDVoI6KiPGOQ/3JFmHE
	 Dqt0x3nsk0sFFSxDTeeu52YWpvk0fLqIAdviE+1hkIM3m9GQDvJs6hwzhvuKzPZb+p
	 2iGMDoznfE1yWIeEzfStFBqC9bQu8yTuIxWRSholnTDCXZQ3pUvlPRkNkxiru5ZxsJ
	 XSfFxTc0Xr13mxHJgLKzz/msUqktgLgKqpWS3mFW/4h7BC/hHWyO2T+bug84K763sg
	 8KBAyGtY+jSeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] module: fix UAF and GPF in idempotent_init_module via
 heap allocation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mingyu Wang" <25181214217@stu.xidian.edu.cn>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260717082601.81704-1-25181214217@stu.xidian.edu.cn>
References: <20260717082601.81704-1-25181214217@stu.xidian.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 08:40:17 +0000
Message-Id: <20260717084017.A9CFE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The patch fails to fix the root cause of the KASAN GPF and lea=
ves a permanent deadlock in idempotent module loading.
--

--- Patch [1]: [PATCH] module: fix UAF and GPF in idempotent_init_module vi=
a heap allocation ---
commit e69cf661c8a6752503caa8d7d7d8b55a7d925049
Author: Mingyu Wang <25181214217@stu.xidian.edu.cn>

module: fix UAF and GPF in idempotent_init_module via heap allocation

This commit changes the local stack variable used for tracking idempotent
module loading state to a heap allocation. It aims to prevent a KASAN
slab-out-of-bounds read and general protection fault when a task exits
abruptly while its node is still in the global hash list.

> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 528690ba160bd..0cf66a911fb69 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -3780,21 +3780,29 @@ static int init_module_from_file(struct file *f, =
const char __user * uargs, int
> =20
>  static int idempotent_init_module(struct file *f, const char __user * ua=
rgs, int flags)
>  {
> -	struct idempotent idem;
> +	struct idempotent *idem;
> +	int ret;
> =20
>  	if (!(f->f_mode & FMODE_READ))
>  		return -EBADF;
> =20
> +	idem =3D kmalloc_obj(*idem, GFP_KERNEL);
> +	if (!idem)
> +		return -ENOMEM;
> +

[Severity: Critical]
This is a pre-existing issue, but does moving this allocation to the heap
actually resolve the crash, or does it just shift the uninitialized memory
issue from the stack to the heap?

If another task has already started loading the module, idempotent() finds
the existing cookie and returns false without adding the new task's entry to
the hash list.

The loser task then goes to the else block below and calls
idempotent_wait_for_completion(idem). Since it was never added to the list,
the winner task's idempotent_complete() will never wake it up, resulting in
a permanent deadlock.

Furthermore, kmalloc_obj() with GFP_KERNEL does not zero the memory. If the
deadlocked task is interrupted by a signal, idempotent_wait_for_completion()
executes this cleanup path:

kernel/module/main.c:idempotent_wait_for_completion()
    if (wait_for_completion_interruptible(&u->complete)) {
        spin_lock(&idem_lock);
        if (!hlist_unhashed(&u->entry))
            hlist_del(&u->entry);

Since the memory is uninitialized, hlist_unhashed() evaluates garbage data.
If it evaluates to false, hlist_del() will dereference invalid pointers and
cause memory corruption or a general protection fault.

Would it make sense to zero-initialize the allocation to avoid evaluating
garbage data, and ensure the loser's entry is properly linked before waiting
so it can actually be woken up?

>  	/* Are we the winners of the race and get to do this? */
> -	if (!idempotent(&idem, file_inode(f))) {
> -		int ret =3D init_module_from_file(f, uargs, flags);
> -		return idempotent_complete(&idem, ret);
> +	if (!idempotent(idem, file_inode(f))) {
> +		ret =3D init_module_from_file(f, uargs, flags);
> +		ret =3D idempotent_complete(idem, ret);
> +	} else {
> +		/*
> +		 * Somebody else won the race and is loading the module.
> +		 */
> +		ret =3D idempotent_wait_for_completion(idem);
>  	}
> =20
> -	/*
> -	 * Somebody else won the race and is loading the module.
> -	 */
> -	return idempotent_wait_for_completion(&idem);
> +	kfree(idem);
> +	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717082601.8170=
4-1-25181214217@stu.xidian.edu.cn?part=3D1
