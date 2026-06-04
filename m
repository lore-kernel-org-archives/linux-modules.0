Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7056313535
	for <linux-modules@vger.kernel.org>; Thu,  4 Jun 2026 18:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780597199; cv=none; b=d6/eeS6m1FGd9TR2UpJCzpRJ0igRtGPgPapimVAw0cjE6Gf47V0CUkkJdIRICjMAobJAdZhecNeX4/8DJNq3T7P3QIq9mUHWaB2xH9bLB4wfM4BJITEn/cotk70NWw71OWfZzEuwf8a5tiPu/HPfXvtsrgM4VpXC7Spo8CIlmBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780597199; c=relaxed/simple;
	bh=r54QX+u8M8iHn1PeQK5uRz2e+pRcrgu6t1IhstJeE0k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D7gbhrGboFA55qHYdc17VmfhJd7HamY8FTYhSznyCeFOv5+ooEPFi/0XvD6Prq1uUk0rs7iy5gHu89vniOetXe2KJktzYzMlOcGXCQg8LKaLrNW8iJWcHEbmICQVOCB2syuzwjihu+YvcHRIpolE34nqaC1gsEiag5ShgL+xvuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hiYp03J4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hiYp03J4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B771F00893;
	Thu,  4 Jun 2026 18:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780597198;
	bh=z8c7j5etuOw4INvTMKLFhqD6A9PMpQs4O86TBISOutE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hiYp03J4lWDBZ4wLpl5aosC1d221YnuE7rMFBNxIuOoo/8DIfahoSsSbk+BKKPb9z
	 5gIkGBZNErGanwYEJfHx8m0OFOfvM3iLl+cDhobY0M2RO4KLNo7NImrRLVNjYrcR5o
	 ECDKo0WIA4b8UHiqkCsEIIkqZ2QMOqoXy1TCKElZxWUe4HyDXg3P+xEBtUt3lWw8PW
	 LQCXOfzn0ZKbLrnnp5MV7X6Vkv/U4vVXT/DWqxn56VguIlLpXZsbPRjkoohVcOnUyF
	 QPSL1kSKL4TpKbXRZOuobZXqSlhzKRraE1d+DIrYGJoypq/XDCpgwVrGkgWRKp9usx
	 FZckVFbySl70A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] module: use strscpy() to copy module names in stats
 and dup tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Naveen Kumar Chaudhary" <naveen.osdev@gmail.com>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <slebbzn7p6c4ybokolvey2sgvrooit66zjewwggqac2755ujgp@ptanmtdclmw5>
References: <slebbzn7p6c4ybokolvey2sgvrooit66zjewwggqac2755ujgp@ptanmtdclmw5>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 18:19:57 +0000
Message-Id: <20260604181958.46B771F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Incomplete fix: Truncating overlong module names breaks deduplic=
ation and causes list bloat/memory leak.

Pre-existing issues:
- [High] Race condition in duplicate module load tracking causing Use-After=
-Free.
--

commit 609988fdef836043f78467817ec8e3cba34b5daf
Author: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>

module: use strscpy() to copy module names in stats and dup tracking

Both try_add_failed_module() and kmod_dup_request_exists_wait() use
memcpy() with strlen() to copy module names into fixed-size buffers.
Neither performs a bounds check on the copy. This patch replaces
memcpy() with strscpy() to ensure the copy is bounded and NUL-terminated.

> diff --git a/kernel/module/dups.c b/kernel/module/dups.c
> index 1d720a5311ba0..8b6f8f177de4f 100644
> --- a/kernel/module/dups.c
> +++ b/kernel/module/dups.c
> @@ -129,7 +129,7 @@ bool kmod_dup_request_exists_wait(char *module_name, =
bool wait, int *dup_ret)
>  	if (!new_kmod_req)
>  		return false;
> =20
> -	memcpy(new_kmod_req->name, module_name, strlen(module_name));
> +	strscpy(new_kmod_req->name, module_name);

[Severity: High]
This is a pre-existing issue, but looking at kmod_dup_request_exists_wait(),
is there a race condition that could lead to a use-after-free?

In kmod_dup_request_exists_wait(), the kmod_req pointer is retrieved while
holding kmod_dup_mutex, but the lock is dropped before waiting on the
completion:

kernel/module/dups.c:kmod_dup_request_exists_wait() {
    ...
    mutex_unlock(&kmod_dup_mutex);
    ...
    ret =3D wait_for_completion_state(&kmod_req->first_req_done, TASK_KILLA=
BLE);
    if (ret) {
        *dup_ret =3D ret;
        return true;
    }
    ...
    *dup_ret =3D kmod_req->dup_ret;
    ...
}

There doesn't appear to be a reference count or RCU read-side critical sect=
ion
protecting kmod_req during this wait.

The completion is signaled by kmod_dup_request_complete(), which then
schedules kmod_dup_request_delete() via delayed work after 60 seconds.

If a duplicate request arrives exactly 60 seconds later, it could drop the
mutex just before the delayed work executes and frees the request:

kernel/module/dups.c:kmod_dup_request_delete() {
    ...
    mutex_lock(&kmod_dup_mutex);
    list_del_rcu(&kmod_req->list);
    synchronize_rcu();
    mutex_unlock(&kmod_dup_mutex);
    kfree(kmod_req);
}

When the duplicate thread resumes and accesses kmod_req->dup_ret, would it
dereference the freed memory?

[ ... ]

> diff --git a/kernel/module/stats.c b/kernel/module/stats.c
> index 3a9672f93a8ef..78b59bc05387f 100644
> --- a/kernel/module/stats.c
> +++ b/kernel/module/stats.c
> @@ -253,7 +253,7 @@ int try_add_failed_module(const char *name, enum fail=
_dup_mod_reason reason)
>  	mod_fail =3D kzalloc_obj(*mod_fail);
>  	if (!mod_fail)
>  		return -ENOMEM;
> -	memcpy(mod_fail->name, name, strlen(name));
> +	strscpy(mod_fail->name, name);

[Severity: Medium]
Does truncating overlong module names here break deduplication?

If try_add_failed_module() is called with an overlong name (which can
originate from the .modinfo ELF section), strscpy() safely truncates the
string stored in mod_fail->name.

However, the deduplication lookup uses strcmp(), which compares the truncat=
ed
stored name against the untruncated original string:

kernel/module/stats.c:try_add_failed_module() {
    ...
    list_for_each_entry_rcu(mod_fail, &dup_failed_modules, list, lockdep_is=
_held(&module_mutex)) {
        if (!strcmp(mod_fail->name, name)) {
            atomic_long_inc(&mod_fail->count);
    ...
}

This comparison will always fail for overlong names.

Would every attempt to load a malformed module allocate a new mod_fail stru=
ct
and add it to dup_failed_modules, potentially allowing an attacker with
CAP_SYS_MODULE to trigger unbounded list bloat and a memory leak?

>  	__set_bit(reason, &mod_fail->dup_fail_mask);
>  	atomic_long_inc(&mod_fail->count);
>  	list_add_rcu(&mod_fail->list, &dup_failed_modules);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/slebbzn7p6c4ybokolv=
ey2sgvrooit66zjewwggqac2755ujgp@ptanmtdclmw5?part=3D1
