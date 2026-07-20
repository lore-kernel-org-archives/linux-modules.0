Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CED416129
	for <linux-modules@vger.kernel.org>; Mon, 20 Jul 2026 12:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784550334; cv=none; b=DHQ0lEjsrzGX8MHO/CD63HnvUQUJGO61WQcBt2cUp2Oxg/BLanVEVPTeVgQbReHyIuSdAayuQ7dhuR/hGHWdBb+WJO6yvjTuT+QmFVSJX3bRkttNtCU6U7QH+LLnYEm+KzNodwqgXYYnCZOWhXv4x5vITMykb6XehVk+tbjDL+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784550334; c=relaxed/simple;
	bh=n/e1wSqOX8oEDMFB3nq8xhaIE4N1Tl96VGoPEGGgMOo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Mju5wV3CMba50q023EIYziYXBnpfNsB8Z0AERAxbz0JZeCH6NgWFdTQeP5gi/pomgSB/V9WOb+WjiBOh1Wl9LGIk1GowpMpNBpgavWlRahMkgGy/vMHMU8CuTJC53yr7ms+rznfzih+p/t0+sdx2rxrV/ggzQERkqL9jNjI3Dyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2LqxLWz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2LqxLWz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9661F00A3A;
	Mon, 20 Jul 2026 12:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784550333;
	bh=UR3tvcIs9OVx6sBrxweZR4SpWTo2ymL55ECjQmqXnp4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D2LqxLWzMHs33pmkUmvBOZ59QXukX6wXF5p2ImqVE+zTTcbed9tPvUXr48xFTifhY
	 0U00QMUF6/uXOHMRCI6X8PPwjmxSBakCvv0tw4JWbTv3GLz619FHAzweBQQJ5VwhhA
	 bLqEdvlFRm3oR4i9c5toh0Gv6WUcabOnYNNTzBoY5gk3Sp/KgMGeByCQzMMXB+dJZJ
	 S1s26hLjq+PmUHX+iM9mZx/yXYean/3WM56yBFWZJVFUpKsaKwjOezbIRYVdZ8CoY4
	 LS7IbkqVWmb603y2PqU/dzsMdl4L7ML/LBYVK0PajCpjA+Wrr/DmJqTnsLxXBbu19D
	 u+bRDUPScBB+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] module/dups: Use scoped guards for kmod_dup_mutex
Reply-To: sashiko-reviews@lists.linux.dev
To: "Petr Pavlu" <petr.pavlu@suse.com>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260720121621.750661-4-petr.pavlu@suse.com>
References: <20260720121621.750661-1-petr.pavlu@suse.com>
 <20260720121621.750661-4-petr.pavlu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 12:25:32 +0000
Message-Id: <20260720122533.1F9661F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Mixing goto-based cleanup labels with scope-based cleanup (scoped_g=
uard) in the same function.
--

--- Patch [3]: [PATCH 3/5] module/dups: Use scoped guards for kmod_dup_mute=
x ---
commit 3299ca2ac8ae46392f412ae7c186f4907e7f8201
Author: Petr Pavlu <petr.pavlu@suse.com>

module/dups: Use scoped guards for kmod_dup_mutex

This patch replaces explicit mutex_lock/unlock calls for kmod_dup_mutex
with scoped_guard to shorten the code and clarify the lock's scope.

> diff --git a/kernel/module/dups.c b/kernel/module/dups.c
> index f0bdd7560d7e7..a62619ec057ed 100644
> --- a/kernel/module/dups.c
> +++ b/kernel/module/dups.c

[ ... ]

> @@ -122,10 +121,13 @@ bool kmod_dup_request_exists_wait(char *module_name=
, bool wait, int *dup_ret)
>  	INIT_DELAYED_WORK(&new_kmod_req->delete_work, kmod_dup_request_delete);
>  	init_completion(&new_kmod_req->first_req_done);
> =20
> -	mutex_lock(&kmod_dup_mutex);
> +	scoped_guard(mutex, &kmod_dup_mutex) {
> +		kmod_req =3D kmod_dup_request_lookup(module_name);
> +		if (kmod_req) {
> +			get_kmod_req(kmod_req);
> +			goto dup_req;
> +		}
> =20
> -	kmod_req =3D kmod_dup_request_lookup(module_name);
> -	if (!kmod_req) {

[Severity: Low]
Does this mix scope-based cleanup with goto-based cleanup in the same
function?

Looking further down in kmod_dup_request_exists_wait(), there are still
several goto statements that jump to an out label for manual cleanup:

	if (!wait) {
		/* ... */
		*dup_ret =3D 0;
		goto out;
	}
=09
	ret =3D wait_for_completion_state(&kmod_req->first_req_done,
					TASK_KILLABLE);
	if (ret) {
		*dup_ret =3D ret;
		goto out;
	}

	*dup_ret =3D kmod_req->dup_ret;

out:
	put_kmod_req(kmod_req);
	return true;

According to include/linux/cleanup.h, the expectation is that usage of
"goto" and cleanup helpers is never mixed in the same function. All resourc=
es=20
that need a "goto" cleanup should either be converted to scope-based cleanu=
p,=20
or none of them should.

Should put_kmod_req() be converted to use scope-based cleanup as well, or=20
should this function avoid using scoped_guard() to keep the cleanup pattern
consistent?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720121621.7506=
61-1-petr.pavlu@suse.com?part=3D3
