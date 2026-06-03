Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79714390C81
	for <linux-modules@vger.kernel.org>; Wed,  3 Jun 2026 16:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780504618; cv=none; b=XdsqLvT+xIJ21TjaRiT5iFq6Fjria9bBAvyHPPiW62pRIg2Ocb871GRoQy1MPKXZ4TzeaIS2/17HurrZCt1vOJHMXuZXr7n68TH/7VQ6Vcusjx4tCcEL00ePXCmuOQb7fSvf7JoiZJm1xnlCj0fOYROr42UXkUOcckYfX9rD3/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780504618; c=relaxed/simple;
	bh=By1C9HBazFOqpfaALRrFk4n0QMPBHDSEkLF7uRpcDrY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cUR5zge4Pm7QnRBOwAWeIdQyvrcP//uQMtVQ8g7eyHBi9lSGc8bU5SPsDL30atIc/p81hg1MKel8WfuFm7eWlQq74acazm3oHklz+93NQU+ZhhmpqfTdpP3XLqUStOhs/FzKArewj5mJimBjNYJsD+VU5yBUxvTBNp1hwe6IUV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZhscmxr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZhscmxr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D72851F00893;
	Wed,  3 Jun 2026 16:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780504617;
	bh=fe4QjgFlBCYZDgz9xHN3ZdxLRr7wyK21sKzBODTm87U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aZhscmxrqUW5JQRw81taEUkokv8w4CLolRm1MBdcn0TkVEUl75/OPn3asbgXGVy1T
	 a+rwQpP+QIJXBpbY5zQ64F2sfUXNUFfCIT3wpbEgXKcEap2f+e+FGImQFnEwKTb+8v
	 /veq3610/3vRF9dMJyTc2pLEZ5VzLmxJHvhjM0/ROjeJLdMU/3/OETVMQxfnTMefRq
	 tG5intZTxE1i29fHvs7kijMabvqdgXlc/Jkb7O7lCS8kgmKm/7/hnVkXeQSoPDdJCU
	 vt1FqA9byvPFIuJ+SrehjGfOyiEMO2T2MoJcGM9pZ9yFGLUPeT0+/YDFjQB01y/kQe
	 1gqsHExVOnAVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] module: dups: use strscpy() to copy module name in dup
 request
Reply-To: sashiko-reviews@lists.linux.dev
To: "Naveen Kumar Chaudhary" <naveen.osdev@gmail.com>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <v546667lngoo6dxwb7gqzf7liya2opdfeevrtar7iipsbkipfc@uh5fuaofcrty>
References: <v546667lngoo6dxwb7gqzf7liya2opdfeevrtar7iipsbkipfc@uh5fuaofcrty>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 16:36:56 +0000
Message-Id: <20260603163656.D72851F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing reference counting on `kmod_req` leads to Use-After-Fr=
ee (UAF).
- [High] Holding `kmod_dup_mutex` during `synchronize_rcu()` introduces sev=
ere system-wide latency spikes.
--

commit c71132da4445b6f78bb4bc00760a72ed998ebd13
Author: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>

module: dups: use strscpy() to copy module name in dup request

This commit replaces a fragile memcpy() call with strscpy() when copying
the module name into a duplicate request. This ensures bounds-checking
and explicit NUL-termination for the fixed-size buffer.

> diff --git a/kernel/module/dups.c b/kernel/module/dups.c
> index 1d720a5311ba0..33bddfb573171 100644
> --- a/kernel/module/dups.c
> +++ b/kernel/module/dups.c
> @@ -129,7 +129,7 @@ bool kmod_dup_request_exists_wait(char *module_name, =
bool wait, int *dup_ret)
>  	if (!new_kmod_req)
>  		return false;
> =20
> -	memcpy(new_kmod_req->name, module_name, strlen(module_name));
> +	strscpy(new_kmod_req->name, module_name, MODULE_NAME_LEN);
>  	INIT_WORK(&new_kmod_req->complete_work, kmod_dup_request_complete);
>  	INIT_DELAYED_WORK(&new_kmod_req->delete_work, kmod_dup_request_delete);

[Severity: High]
This is a pre-existing issue, but does kmod_dup_request_delete() cause
severe system-wide latency spikes?

In kernel/module/dups.c:kmod_dup_request_delete(), synchronize_rcu() is
called while holding the global kmod_dup_mutex:

    mutex_lock(&kmod_dup_mutex);
    list_del_rcu(&kmod_req->list);
    synchronize_rcu();
    mutex_unlock(&kmod_dup_mutex);

Because kmod_dup_mutex is acquired by every request_module() call
system-wide, this stalls all unrelated module autoloading attempts during
the RCU grace period. Furthermore, the RCU synchronization appears
functionally useless because the only reader, kmod_dup_request_lookup(),
strictly requires kmod_dup_mutex to be held rather than relying on RCU:

    list_for_each_entry_rcu(kmod_req, &dup_kmod_reqs, list,
                            lockdep_is_held(&kmod_dup_mutex)) {

>  	init_completion(&new_kmod_req->first_req_done);

[Severity: Critical]
This is a pre-existing issue, but is there a use-after-free risk for
kmod_req here?

The kmod_req structure lacks a reference count, and its lifetime is
managed by an arbitrary 60-second delayed work queued during completion:

kernel/module/dups.c:kmod_dup_request_complete() {
    ...
    queue_delayed_work(system_dfl_wq, &kmod_req->delete_work, 60 * HZ);
    ...
}

If a duplicate request task sleeping in wait_for_completion_state() is
delayed for more than 60 seconds (e.g., due to a VM hypervisor pause,
cgroup freezer, or severe scheduler starvation), kmod_dup_request_delete()
will execute and kfree() the structure:

kernel/module/dups.c:kmod_dup_request_delete() {
    ...
    kfree(kmod_req);
    ...
}

When the delayed task eventually resumes in kmod_dup_request_exists_wait(),
it attempts to read kmod_req->dup_ret or remove itself from the freed
waitqueue:

kernel/module/dups.c:kmod_dup_request_exists_wait() {
    ...
    ret =3D wait_for_completion_state(&kmod_req->first_req_done,
                                    TASK_KILLABLE);
    if (ret) {
        *dup_ret =3D ret;
        return true;
    }

    /* Now the duplicate request has the same exact return value ... */
    *dup_ret =3D kmod_req->dup_ret;
    ...
}

Would it be safer to use proper reference counting for kmod_req?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/v546667lngoo6dxwb7g=
qzf7liya2opdfeevrtar7iipsbkipfc@uh5fuaofcrty?part=3D1
