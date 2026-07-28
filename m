Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2059A3F0ABE
	for <linux-modules@vger.kernel.org>; Tue, 28 Jul 2026 07:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785225487; cv=none; b=gXDurXFgyPLhFRuGmlBlipfGZkUuVR5GCMjJDqGN/nlx67lPLhcFSIJ/cuszOKg9otk5EKODB08Dwgtr6M+hsOjgYGogUgIyGE/sFT89iU8uX7z7esfOExC/Tc0p86Tn3fP2fn03j85bQpHhKfl4Q9a3yyv7Wua7oF4nCRlOgSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785225487; c=relaxed/simple;
	bh=WG6rsBcwjiyw6qkpgQ33SdXW4cfc3Ob0wWdTc3UO5fY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PWCHa8FAq0+bL9pHtpuMY4EISkjecQRgPyA8Jgjpm/Le/35mw96OW9VExztTaocFsjd+3ai1NiPh16N4X85Scb5VHRBBEaqR8GfSU2nBuRKKPfIfD1x7JownVAgz3pE78dPJX4ym95BrfxLabmKsB5v0oWchU8ZF0eIfwws5O5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exx2bJnz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exx2bJnz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA13C1F000E9;
	Tue, 28 Jul 2026 07:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785225483;
	bh=ZTPJ9XN2jz1qpQ3/gUhjI+9eqN1OBR5CmJaAgTREbmY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=exx2bJnzT5JTcy3qgku1GCXqhxvT4Fo2SVuZ4ylRhnKP+zlFUNcNPvhVutoNchlw0
	 179wp7z6OWf4wS1Us5a0rynggfZpWYrkIQt6Fc1hsaWfCaXzHmad484dD/tYgxQO3p
	 ATnu8Boabwbm3K5LtoXQMKl8HqmLQhYTQn5FvAeCxEILtTWHIXipHRyZEieUO6YTyK
	 woJU3cq0Hz0FSogjgKZpnFbZWvw/yOhPCCvQzCMPaXuXfkwr0gXJFfbIIKSrpU0P2t
	 MbyqnjDynu+A2bEDCFbsGPz4OzkiLQRYGfkrcJcWk883oTTFmcbEYiZH6c/lb1tmmE
	 99DHuUq9Dkk+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] params: fix charp corruption on allocation failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiacheng Yu" <yujiacheng3@huawei.com>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260728085518.3865621-1-yujiacheng3@huawei.com>
References: <20260728085518.3865621-1-yujiacheng3@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 07:58:03 +0000
Message-Id: <20260728075803.AA13C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-after-free window in param_set_charp due to freeing old parame=
ter before updating the pointer.
--

--- Patch [1]: [PATCH] params: fix charp corruption on allocation failure -=
--
commit 0bae951c4e6e4a0145f488c9bedd9a7a2b9a129f
Author: Jiacheng Yu <yujiacheng3@huawei.com>

params: fix charp corruption on allocation failure

This commit fixes an issue in param_set_charp() where a failure to allocate
memory for a parameter update leaves the parameter set to NULL after its old
value has already been freed. It allocates and copies the new string into a
temporary variable first, replacing the actual parameter only after success.

> diff --git a/kernel/params.c b/kernel/params.c
> --- a/kernel/params.c
> +++ b/kernel/params.c
[ ... ]
> @@ -269,19 +270,20 @@ int param_set_charp(const char *val, const struct k=
ernel_param *kp)
[ ... ]
>  	if (slab_is_available()) {
> -		*(char **)kp->arg =3D kmalloc_parameter(len + 1);
> -		if (!*(char **)kp->arg)
> +		tmp =3D kmalloc_parameter(len + 1);
> +		if (!tmp)
>  			return -ENOMEM;
> -		strcpy(*(char **)kp->arg, val);
> +		strscpy(tmp, val, len + 1);
>  	} else
> -		*(const char **)kp->arg =3D val;
> +		tmp =3D (char *)val;
> +
> +	maybe_kfree_parameter(*(char **)kp->arg);
> +	*(char **)kp->arg =3D tmp;

[Severity: High]
This is a pre-existing issue, but does freeing the old parameter before
updating the pointer create a use-after-free window?

By calling maybe_kfree_parameter() on the old value before assigning tmp to
the global kp->arg pointer, there is a brief window where kp->arg points to
freed memory. If another kernel subsystem locklessly reads this parameter
during this window, could it trigger a use-after-free dereference?

Since the patch rewrites this logic to use a temporary variable, would it
be safer to assign tmp to *(char **)kp->arg before calling
maybe_kfree_parameter() on the old string to ensure readers always see a
valid pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728085518.3865=
621-1-yujiacheng3@huawei.com?part=3D1
