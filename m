Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC75B38425B
	for <linux-modules@vger.kernel.org>; Thu, 27 Aug 2026 03:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787800623; cv=none; b=fO3fkHTTVoMXreInoH3qu5q0M+h7LGMLgZ1hzHIOcHvw3IU1P5leOFQNCpC41zJVgBLF1++KpnKDRd4KSuGX/L7hTAYvbf8D74nCI2Upcfrd88PSQq2p49teg/R3PwqGbUZqZSr9/JSFiFF25Cy33zPO48OawsEVj1IZM4n6M9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787800623; c=relaxed/simple;
	bh=UL6go6UPqAATR7bivbrHCPL6F4h7wJg6PVQwMxOixPk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eW5nye6hFnfvX89wnQEDnnB0r3wzKek0jQpQTcbp0TU1hPioaSGuyN8ZlIThiQ2axsExbt+8xHrl46iVcblKUKCQTRgHU4vKjwOw8f62CGA7Q8a5MXaM2FXHJq/ItBKDZUskJHo8U+qT23AS/899aPCm0G/OUb9jsuRGc7sb9rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ui20Q3uE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ui20Q3uE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE7B1F00A3A;
	Thu, 27 Aug 2026 03:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787800621;
	bh=yYPcvBZBkSJ4qw0xPs632IR489BQEO9T+CC09SHt4qg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ui20Q3uE2gH8NEOkfVuQksSL4Q7ncUbAZW/d9SVtcMyxoppVc+QZPJ9Os9bji9307
	 xJMHuT3gF0DhLckYyc5LZHQwl981Bh2FZYNqlHzAaOGNXmflJ0LBLaIjHRBL96ss91
	 4RI6VjtPwjZk93ckZpEpYLIeSg29wjZybs05aBCNyuXBFxXBPqVb38rhzBqwD78lxr
	 tMciHGidkd1HlATG4nHo+PTIYqhQsLkJv7luh+QGdgP9x/rSQAVCOuYkZoekrWVZQC
	 NxPtbvn538i+cLb7yugxZvM0MBYX4L4Tl15n1elYsvEHZBuwiUe6tPoD44whF1JrPD
	 lA/lVL+wb5yAQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] module: fix lost error code from
 codetag_load_module()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hao Ge" <hao.ge@linux.dev>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260827030503.49171-1-hao.ge@linux.dev>
References: <20260827030503.49171-1-hao.ge@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 03:17:01 +0000
Message-Id: <20260827031701.9FE7B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing `codetag_unload_module(mod)` on `codetag_load_module()` fa=
ilure permanently strands partially initialized codetags, causing a Use-Aft=
er-Free when the freed module is subsequently accessed.
--

commit 46e63afac7b776756489b1e2ad6cec3cf1e11513
Author: Hao Ge <hao.ge@linux.dev>

module: fix lost error code from codetag_load_module()

If codetag_load_module() fails, err is not set to reflect the failure
and load_module() returns 0 after the module has been torn down.

> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index d0e1e0bd2ad06..c1b34dc1e89ac 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -3581,8 +3581,9 @@ static int load_module(struct load_info *info, cons=
t char __user *uargs,
>  			goto sysfs_cleanup;
>  	}
> =20
> -	if (codetag_load_module(mod))
> -		goto sysfs_cleanup;
> +	err =3D codetag_load_module(mod);
> +	if (err)
> +		goto livepatch_cleanup;

[Severity: High]
This isn't a bug introduced by this patch, but missing codetag_unload_modul=
e()
on codetag_load_module() failure permanently strands partially initialized
codetags, causing a use-after-free when the freed module is subsequently
accessed.

If a module load is initiated, and codetag_load_module() iterates through
registered codetag_types:

lib/codetag.c:codetag_load_module() {
    ...
		ret =3D codetag_module_init(cttype, mod);
		if (ret)
			break;
    ...
}

If an early iteration succeeds but a subsequent one fails (e.g., kmalloc
failure inside codetag_module_init()), codetag_load_module() breaks and
returns the error without unwinding previously allocated cmod entries.

load_module() receives the error, jumps to livepatch_cleanup and eventually
calls module_deallocate(mod, info) to free the module memory. However,
codetag_unload_module(mod) is never invoked on this error path, leaving
cmod entries pointing to freed module memory inside the successfully
initialized cttype->mod_idr structures.

When subsequent codetag operations (like reading /proc/allocinfo) iterate
over cttype->mod_idr, they will access the freed module memory.

Should this error path invoke codetag_unload_module(mod) to clean up the
partially registered state before tearing down and freeing the module
memory?

> =20
>  	/* Get rid of temporary copy. */
>  	free_copy(info, flags);
> @@ -3592,6 +3593,9 @@ static int load_module(struct load_info *info, cons=
t char __user *uargs,
> =20
>  	return do_init_module(mod);
> =20
> + livepatch_cleanup:
> +	if (is_livepatch_module(mod))
> +		free_module_elf(mod);
>   sysfs_cleanup:
>  	mod_sysfs_teardown(mod);
>   coming_cleanup:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827030503.4917=
1-1-hao.ge@linux.dev?part=3D1
