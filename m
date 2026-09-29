Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFFE3B0AEF
	for <linux-modules@vger.kernel.org>; Tue, 29 Sep 2026 08:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790671247; cv=none; b=rfTDJbNDGA12xLS3b0NVtqJYQxnH/aIIT/WNj7kw3eIy5auZtt+h2+06EVsxofjK4uce45LiQw94OBjynmIdfIlO56Yf4Rhv6f2O7ZZ7RNLY1UHhJxI1o+Hkr7FfqG6HH/4DIO8BThsJLcspC+M75h7ds8wC1/SBBqP0pCX5JFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790671247; c=relaxed/simple;
	bh=S+PjPkM3pr6yeCyz40gCIxrsP3KtdEpQWJmrEPggij4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uEUUi/vVzBYle3dcRP4pgmlC5HOFMj3tCxJ7+MkuWb6icury0xHPJn6f7apNEB1A7N03SGfK5ZAqUpxM6wtSdAq//3x7N7FyLOg0OnAjOYUY86Kn9mxS06QfjiVwUw9vH6jY0a4F/+WfwJPg52HYNwJ13UbKk0FhGx9pvaFxwIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWrZRsxx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWrZRsxx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E4591F000FF;
	Tue, 29 Sep 2026 08:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790671245;
	bh=5cy6j9fNirX12qNnxqo63Vd5kGmkoTDefJ5oVac7vYE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hWrZRsxxZcVJ2hwCt7j6Z2AvUlx/mIZP9I/MWcIRMRsgMySJDvzPGUg/ZqHnvrG09
	 +4FW/qLoVZ3WonYuSHtzLURwqFd9yv/aoqznGKtgGRsBFCDgBmp8f5BqcvDZqCNAt+
	 bL9X7nS4/evNSRMG/JH9X6P4hKlV880prh+Z+oZuOZKjyJ4kQXd3+L8yY81qwd1AvE
	 HtuU1T2b1mXVGCgQq/ejDmVWqaQPLHZ6PLecZAFax68OkhisK3XnZfQHA3MIsq11vG
	 dgpGcEsLNiaQe9t+lZrMV91vDT6d7mwfnHnmOFbR3kLifsrjALfgCGFZXA+5cdAUpz
	 hm/98gksb1KZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 6/7] alloc_tag: skip percpu counter allocation when
 profiling is disabled
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hao Ge" <hao.ge@linux.dev>
Cc: "Petr Pavlu" <petr.pavlu@suse.com>, linux-modules@vger.kernel.org
In-Reply-To: <20260929082014.160587-7-hao.ge@linux.dev>
References: <20260929082014.160587-1-hao.ge@linux.dev>
 <20260929082014.160587-7-hao.ge@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 08:40:45 +0000
Message-Id: <20260929084045.9E4591F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] mm: crash on freeing static percpu variable when module load fails=
 or profiling disabled
--

commit 1ed77a1b45b5a7a434417c336e13dff08f4838d1
Author: Hao Ge <hao.ge@linux.dev>

alloc_tag: skip percpu counter allocation when profiling is disabled

After shutdown_mem_profiling() clears mem_profiling_support,
needs_section_mem() returns false, so later modules have their codetag
section placed as regular data and never enter the alloc_tag maple tree.
codetag_load_module() still called load_module(), which allocated a percpu
counter for every tag; release_module_tags() could not find these modules
on unload, so the counters leaked.

> diff --git a/lib/codetag.c b/lib/codetag.c
> index a9cda4c962a30..a0b600720afc1 100644
> --- a/lib/codetag.c
> +++ b/lib/codetag.c
[ ... ]
> @@ -388,7 +390,11 @@ void codetag_unload_module(struct module *mod)
>  			++cttype->content_id;
>  		}
>  		up_write(&cttype->mod_lock);
> -		if (found && cttype->desc.free_section_mem)
> +		/*
> +		 * A module whose module_load() returned -EOPNOTSUPP is not
> +		 * in the idr but may still hold reserved section memory.
> +		 */
> +		if (cttype->desc.free_section_mem)
>  			cttype->desc.free_section_mem(mod, true);
>  	}
>  	mutex_unlock(&codetag_lock);

[Severity: High]
Does this unconditional call to free_section_mem() lead to a crash when
freeing statically allocated percpu memory?

On architectures defining CONFIG_ARCH_MODULE_NEEDS_WEAK_PER_CPU,
DEFINE_ALLOC_TAG initializes tag->counters to the statically allocated
&_shared_alloc_tag.

If a module load skips dynamic counter allocation (either because
mem_profiling_support is false and load_module() returns -EOPNOTSUPP, or if
alloc_percpu() fails with -ENOMEM), tag->counters remains pointing to
&_shared_alloc_tag.

Because free_section_mem() is now called unconditionally here on module unl=
oad
or load failure, it triggers the cleanup path for these uninitialized tags:
release_module_tags() -> clean_unused_counters()

In clean_unused_counters(), since the static _shared_alloc_tag has 0 bytes,
it unconditionally calls free_percpu(tag->counters):

mm/alloc_tag.c:clean_unused_counters() {
	...
		if (!counter.bytes) {
			free_percpu(tag->counters);
			tag->counters =3D NULL;
	...
}

Calling free_percpu() on a statically allocated per-cpu variable that doesn=
't
belong to a managed chunk can corrupt memory and cause a crash.

> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
> index 1a6108a596684..1106fc60dc89c 100644
> --- a/mm/alloc_tag.c
> +++ b/mm/alloc_tag.c
> @@ -981,6 +981,10 @@ static int load_module(struct module *mod, struct co=
detag *start, struct codetag
>  	struct alloc_tag *stop_tag;
>  	struct alloc_tag *tag;
> =20
> +	/* Profiling disabled: load the module without its tags. */
> +	if (!mem_profiling_support)
> +		return -EOPNOTSUPP;
> +
>  	/* percpu counters for core allocations are already statically allocate=
d */
>  	if (!mod)
>  		return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929082014.1605=
87-1-hao.ge@linux.dev?part=3D6
