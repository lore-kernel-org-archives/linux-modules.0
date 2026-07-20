Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B8A416D00
	for <linux-modules@vger.kernel.org>; Mon, 20 Jul 2026 12:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784550495; cv=none; b=inGlphXdKucoTwsKbtrRZikbSFVs4CVs5kdmKQa3mLk/HYtZr+ozH4kZ+MSe53RnMtDTYffN4gWVgNRUp7zdJsBlC8LHEwnX6ISmGqyWv6AVvgfDgGqhJrCQf+ZWWyLZJ1PGokeXegLFGtI3VQqBMUfLtHL00Ur7j7NZVPEXujk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784550495; c=relaxed/simple;
	bh=cznt05DNdVq2kbP256tYRbxZr0ffH1GxHcBevzAjrJE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Tao1jRX53EQD7nNqctGwKtgWclQvL144YZSBjihdxdXTkoCOrDJdi6qPsOCAeqRThPVVKcSRhDahULyvVh97JS7oIIfIYRLZNetiNu5ncTfxLsRBOARM54J9nlYMX6uB7lp5+cAI0tO6v3hmTc3nAsSfrkd/BlyJlo0ogK9UkZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWsHdhI/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWsHdhI/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 702481F000E9;
	Mon, 20 Jul 2026 12:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784550492;
	bh=XHOJXE02LRB/mPgF6CI0CrOf4iHQ9D53rrCrg2qq/64=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hWsHdhI/3TY+ZaHQPlgIK9ROYhmCBJz8xR14QBqExIEpPN9ufta1YrRtygY5Bc447
	 aY56Eutyo1pAqVSS/dMQuHgs9G7xHGvLR5mIjhKmHV0SG0kngeNl71rJAzDbOhEebh
	 IM03Kq2rjji+kbKC2nl7NixPd68XSUQYxdq1PNeJivdwFrBezWb82v+oRb5PSLyJdq
	 NqGKNEAZaqCXM3gE6hjob31B0hi38vS9RQxt83sv7kypym4hE1ZKHADAP5otz54JOE
	 9jvUK5CR0mYRZ4aCI2cRDZqAmXzPkiw81lIhCA9CqNdRjnk4Ws5y6a0cZCDbE7JmRi
	 mxAeuRT4V7TyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] module/dups: Inform duplicate requests about the
 result directly
Reply-To: sashiko-reviews@lists.linux.dev
To: "Petr Pavlu" <petr.pavlu@suse.com>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260720121621.750661-3-petr.pavlu@suse.com>
References: <20260720121621.750661-1-petr.pavlu@suse.com>
 <20260720121621.750661-3-petr.pavlu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 12:28:11 +0000
Message-Id: <20260720122812.702481F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Dropping `kmod_dup_mutex` prematurely without acquiring a referenc=
e leads to a Use-After-Free and data races.

Pre-existing issues:
- [High] A `request_module_nowait` call can erroneously complete a concurre=
nt `request_module` duplicate tracking object prematurely.
--

--- Patch [2]: [PATCH 2/5] module/dups: Inform duplicate requests about the=
 result directly ---
commit 5b4a732b8aa814f2e4a78fd3e59bb299a50f8a41
Author: Petr Pavlu <petr.pavlu@suse.com>

module/dups: Inform duplicate requests about the result directly

When kmod_dup_request_announce() announces the completion of
a request_module() call to duplicate waiters, it queues a work item to
invoke kmod_dup_request_complete(), and only that function calls
complete_all().

This adds an arbitrary delay that is unnecessary and provides little
benefit. Call complete_all() directly from kmod_dup_request_announce()
instead.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>

> diff --git a/kernel/module/dups.c b/kernel/module/dups.c
> index e1828e865edde..f0bdd7560d7e7 100644
> --- a/kernel/module/dups.c
> +++ b/kernel/module/dups.c

[ ... ]

> @@ -246,23 +221,22 @@ void kmod_dup_request_announce(char *module_name, i=
nt ret)
>  	 * that is owned by the current task.
>  	 */
>  	kmod_req =3D kmod_dup_request_lookup(module_name);
> +	mutex_unlock(&kmod_dup_mutex);
> +
>  	if (!kmod_req)
> -		goto out;
> +		return;
> =20
>  	kmod_req->dup_ret =3D ret;

[Severity: High]
Does unlocking kmod_dup_mutex here leave kmod_req unprotected?

If a thread is preempted after unlocking the mutex but before writing to
kmod_req->dup_ret, could delete_work execute, drop the refcount to zero,
and free kmod_req? This would result in a use-after-free when the preempted
thread resumes and attempts to write to kmod_req->dup_ret or call
complete_all(). Should we hold the mutex longer or acquire a reference?

> +	/* Inform all the duplicate waiters to check the return value. */
> +	complete_all(&kmod_req->first_req_done);

[Severity: High]
This is a pre-existing issue, but can this prematurely complete a concurrent
request_module() call?

When request_module_nowait() is called, it skips adding a tracking object to
the dup_kmod_reqs list, but continues to execute call_modprobe() and
unconditionally calls kmod_dup_request_announce().

If a concurrent request_module() call had created a tracking object for the
same module, the nowait thread's lookup will find it and call complete_all(=
),
prematurely waking up all duplicate waiters before the original modprobe has
actually finished. Does this function need to verify the caller owns the
request before completing it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720121621.7506=
61-1-petr.pavlu@suse.com?part=3D2
