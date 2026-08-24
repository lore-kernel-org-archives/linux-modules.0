Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E89B231832
	for <linux-modules@vger.kernel.org>; Mon, 24 Aug 2026 02:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787537016; cv=none; b=MspLrH4ip6JHUzO2wFHFRCajRhNubgmxIZCQp0nf4gg+XhvrTaJyyecafuMxJfliZV0fGf/TQIHXBlQ6+bk1KBcccYmG0DJOVwGZgcGyKDuBcKwAObh/tvZ4itynxuRfFYj19sFoNLi7Hb42LEQLlBEJGDOTL2Hf70haM9mAG6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787537016; c=relaxed/simple;
	bh=sJlvR/RUHiP3GzpobbJXUbp+yjhi9MruYJG5M4xuoWo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m/rEsUhMgzCUayRuLG5JgTX+IascMR5M3RiLjjdsUndljBV8cBxTjNt1RIX+8iP8afVlWVHbd+W3zebWUzUgZrMsVLUG6L3bhlKTxVEgTbd0ZUh3epHNA+qqgZEOOer2D6EHXEi9hxWmlTzb730XT37WN0F/tWMyKxAOXRTkcS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5aafsXD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5aafsXD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E991F000E9;
	Mon, 24 Aug 2026 02:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787537015;
	bh=CrC/oXjpBpv25h5mViwJmpz3ZYNoc9IRKgrm3W50b7o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c5aafsXDdEUTwF/1GvZIuAK1TnqyMK7JMDNYUGORnOTKtEY4P7DzVRJYcrDiON2Je
	 3ryvuWUMIOSrF1Hq8dvgaj2k6lzX9OvXEiOwm4k9Mx72MFPt+LXoectzgko8D915wm
	 3tLyFDzHPP1tYjhsm2ercgwsZsdpXhWYMEbJG8dzGplRHxJtmnfL+tUqrNFStnjP5H
	 k8B3CXLZpGfspSSEywjO+duek2sGYfPdYK+udISV7u+wdjRcZySAZHvUnaVLAvc5U0
	 r9YqxGeawmIR5rNmxGuUP38SrX+vcxr3g6WIdiCviV/cQqQNENj1UZSupOKJYz2Alq
	 FpqkcWn3x1hiw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] module: fix lost error code from codetag_load_module()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hao Ge" <hao.ge@linux.dev>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260824014736.35026-1-hao.ge@linux.dev>
References: <20260824014736.35026-1-hao.ge@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 02:03:34 +0000
Message-Id: <20260824020334.E8E991F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing call to codetag_unload_module() in the error path leaves d=
angling module pointers in codetag_types IDR.
--

--- Patch [1]: [PATCH] module: fix lost error code from codetag_load_module=
() ---
commit 5006baafc1e00091b0abb9c8d393876e887ccb31
Author: Hao Ge <hao.ge@linux.dev>

module: fix lost error code from codetag_load_module()

This commit fixes a bug where the error code from codetag_load_module()
was previously lost. It ensures load_module() correctly captures the error
and aborts module loading upon failure.

> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -3581,7 +3581,8 @@ static int load_module(struct load_info *info, cons=
t char __user *uargs,
>  			goto sysfs_cleanup;
>  	}
> =20
> -	if (codetag_load_module(mod))
> +	err =3D codetag_load_module(mod);
> +	if (err)
>  		goto sysfs_cleanup;

[Severity: High]
This is a pre-existing issue, but by fixing the error path here, we might
expose a use-after-free bug during module load failures.

If codetag_load_module() fails partway through the list of codetag_types:

lib/codetag.c:codetag_load_module() {
	...
	list_for_each_entry(cttype, &codetag_types, link) {
		ret =3D codetag_module_init(cttype, mod);
		if (ret)
			break;
	}
	...
}

It returns an error without rolling back the types that were already
successfully initialized. We then jump to sysfs_cleanup, which eventually
calls module_deallocate() in the free_module block to free the module memor=
y.

However, there is no call to codetag_unload_module() anywhere in this clean=
up
path to clean up the dangling references from the codetag_types IDR.

Will this leave dangling pointers that result in a use-after-free dereferen=
ce
of the freed module memory when codetags are later iterated (for example,
when reading from /proc/allocinfo)?

lib/codetag.c:codetag_next_ct() {
	...
			ct =3D get_first_module_ct(cmod);
	...
}

> =20
>  	/* Get rid of temporary copy. */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824014736.3502=
6-1-hao.ge@linux.dev?part=3D1
