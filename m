Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE7A476CFE
	for <linux-modules@vger.kernel.org>; Wed, 29 Jul 2026 11:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785325142; cv=none; b=REmsmhiEtyy08IubIc5xb6LTOKL44/AI71taWz1g8DGKGGfCaD0WudXPoR7tJO0CImBs4pK02Gvr2eaSUi2YxR0hL/+hNQoe/3nxHS3lvqRK9DMSH5Q0aM+bFaIj9HsmozvsHEC3wTPmIwZBRncgZ9xnjbYkJo1BxJJ5ekjIQWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785325142; c=relaxed/simple;
	bh=9kiJ+Sf2mKugclDdpI8u9wgcZhWlnGhRIkdLLzQXad8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nUAdw/Saovt2+WEsno6ONdqsrsEBjNSqNx2Gur+GpkJ+TpRlgf5kyPRSMSIUQQri74QMOSGacfmtXNKThLyJGPMY1jPPiA06/RfejLNiAsKVXeTPlUuxdhhCK8NJ41GI50QW3TYT3M0MBq+Rakw4vVeRq59p2psoRP2MMXczUpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEXPy7VY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEXPy7VY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 693C71F00A3A;
	Wed, 29 Jul 2026 11:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785325140;
	bh=lDgZBvS8jMx4hwmsIF+GIVfzHx/OcJjVWuPqkn7zTMY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TEXPy7VYj6kaofZqLsI3XPV2QYKmW4berRfBEzaSJlgkmhDKClqLcR7PXI8qD9kGv
	 eaKW09bNYebIOb3n8/biaPJIJyUnTNhTxAbdXAaPdXlgXJFFFWlLzNx7uvKzCejfsr
	 jN/KLXBk80zNVrRGtc4MsKNiy/VvHGxbEpWbks9fmkDRb91nGu0niPH4toYp4DoSEF
	 wJYjhSRDIT9+9yi/MvG2EwifDATN14oSC1pl+LtwIHV5dZd/5dB/LvkSBlYXX44Ch5
	 6pgB2GFbSP6SJdTegztkpksw4XApVYxoUHqlf3zUWTCMX00pVwy+2A72QYb/C+jooD
	 0CYN0PLor6Usw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] params: fix charp corruption on allocation failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiacheng Yu" <yujiacheng3@huawei.com>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260729123243.790023-1-yujiacheng3@huawei.com>
References: <ff0b7cdd-8fa7-4cb8-9e21-6a7204809766@suse.com>
 <20260729123243.790023-1-yujiacheng3@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 11:38:59 +0000
Message-Id: <20260729113900.693C71F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-After-Free race condition due to dangling global pointer durin=
g module parameter update.
--

--- Patch [1]: [PATCH v2] params: fix charp corruption on allocation failur=
e ---
commit c59e6d7e9f9563e1394c57f9eedf07a9bb5f212b
Author: Jiacheng Yu <yujiacheng3@huawei.com>

params: fix charp corruption on allocation failure

This patch fixes a corruption issue when param_set_charp() fails to allocate
memory for the replacement string. It allocates and copies the replacement
first, replacing the parameter value only after allocation succeeds.

> diff --git a/kernel/params.c b/kernel/params.c
> index d3a4ecab4f278..8b25133fed242 100644
> --- a/kernel/params.c
> +++ b/kernel/params.c
[ ... ]
> @@ -269,19 +270,20 @@ int param_set_charp(const char *val, const struct k=
ernel_param *kp)
>  		return -ENOSPC;
>  	}
> =20
> -	maybe_kfree_parameter(*(char **)kp->arg);
> -
>  	/*
>  	 * This is a hack. We can't kmalloc() in early boot, and we
>  	 * don't need to; this mangled commandline is preserved.
>  	 */
>  	if (slab_is_available()) {
> -		*(char **)kp->arg =3D kmalloc_parameter(len + 1);
> -		if (!*(char **)kp->arg)
> +		tmp =3D kmalloc_parameter(len + 1);
> +		if (!tmp)
>  			return -ENOMEM;
> -		strcpy(*(char **)kp->arg, val);
> +		memcpy(tmp, val, len + 1);
>  	} else
> -		*(const char **)kp->arg =3D val;
> +		tmp =3D (char *)val;
> +
> +	maybe_kfree_parameter(*(char **)kp->arg);
> +	*(char **)kp->arg =3D tmp;

[Severity: High]
This isn't a bug introduced by this patch, but does this sequence leave a
deterministic use-after-free window for concurrent readers?

Because maybe_kfree_parameter() frees the old string while the global
parameter variable still points to it, any concurrent lockless reader of
the parameter might dereference a freed pointer before the reassignment
on the next line.

Could this be safely reordered to update the pointer before freeing the old
memory? For example:

	char *old =3D *(char **)kp->arg;
	*(char **)kp->arg =3D tmp;
	maybe_kfree_parameter(old);

> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729123243.7900=
23-1-yujiacheng3@huawei.com?part=3D1
