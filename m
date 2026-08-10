Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E293B4432
	for <linux-modules@vger.kernel.org>; Mon, 10 Aug 2026 10:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786356197; cv=none; b=Bhx8p4bQUvLttLEIbcqP0YV70pw0W0WDIvcVBE5u3Hhl1rFwKfLX/fWfmmGpBR8k+PpTHYr5y1tYwgs8bhsiE/bfBKnWdEDVJBuvJQcnY82wYtQ8HzN6x9yDjghc9VGBjknZKvo9pNtE5BgQTCzUysYeevGmVHWkfp04fk5/Uh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786356197; c=relaxed/simple;
	bh=Zk4kz/6m1bLx7iWvB/n484IC+Ry0LxTWcxsiqOT9J9I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ewAlj6NBkdDN7F134aX7s4rlx1Bc1kFqxiPAZrHx8qGvrgAV1BFcQ7Kl+XyzJgWNjaMvh4LCbivQexFD7Sru6tVFtOpM2S3CwWw5X01rRqY+6mxD3z1WAO1uBLjxc7SemHfKp+8xosCG/TjWsH3F2dDqUeUgRR8O/EEtLDtvCrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E5KjvlVv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5KjvlVv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C2C1F000E9;
	Mon, 10 Aug 2026 10:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786356195;
	bh=74WunDMsQpawcsErWnaBQKO2/y+zEZz3jwGq6qfuV0Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E5KjvlVv8V+JRUS6ExVYBm+R3V6M18ygCK22xiBFIJWIJ6eHz1ZXXmWMEwi2RT4Ix
	 m7v4NGqBrbo6sZGpp0tBESj4fKNz5AgzMP7zwBV1u85aelZqxTeNuQUL9NO6+fHsw3
	 XS5XwJfKKsE8atmexhx6J1CHqpUmYnOzpJkA9603gHcEsAlA6bWf3KKBkbnaTn07Sa
	 zH6bnN0Qupt4a14qxvoFH1jR02or8m2Y2ygjSoKmAq7gazQohVnQtrRY7JRK3JYlW7
	 iY5bxZuAq+PiFzwyT3zLQJzSZkbDblV0Q1bQ8HGX0ydtX7MZBCEy4dqOxK/7qnqGLs
	 ZRVHIRNTZRTIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] alloc_tag: move release_module_tags() above
 reserve_module_tags()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hao Ge" <hao.ge@linux.dev>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260810093955.153015-2-hao.ge@linux.dev>
References: <20260810093955.153015-1-hao.ge@linux.dev>
 <20260810093955.153015-2-hao.ge@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 10:03:14 +0000
Message-Id: <20260810100315.B4C2C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] reserve_module_tags() silently succeeds and returns a valid-lookin=
g pointer when mas_store() fails, corrupting the module tags allocation spa=
ce.
- [High] release_module_tags() ignores failures from mas_store(), permanent=
ly leaking the module's maple tree range.
--

--- Patch [1]: [PATCH v4 1/2] alloc_tag: move release_module_tags() above r=
eserve_module_tags() ---
commit 96b4c3fa8241c380a13e2a15009ac553cfc71daa
Author: Hao Ge <hao.ge@linux.dev>

alloc_tag: move release_module_tags() above reserve_module_tags()

release_module_tags() is a cleanup helper. reserve_module_tags() can
also fail after storing the reservation in the maple tree, in which
case it should call release_module_tags() to undo it. Move the helper
above reserve_module_tags() so no forward declaration is needed.

No functional change.

> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
> index e93e7fec1f066..96a9196635fea 100644
> --- a/mm/alloc_tag.c
> +++ b/mm/alloc_tag.c
> @@ -493,6 +493,52 @@ static int vm_module_tags_populate(void)
>  	return 0;
>  }
> =20
> +static void release_module_tags(struct module *mod, bool used)
> +{

[ ... ]

> +release_area:
> +	mas_store(&mas, used ? &unloaded_mod : NULL);
> +	val =3D mas_prev_range(&mas, 0);
> +	if (val =3D=3D &prepend_mod)
> +		mas_store(&mas, NULL);

[Severity: High]
This isn't a bug introduced by this patch, but does this ignore failures fr=
om
mas_store()?

Since mas_store() is called with the maple tree lock held, it forces an
implicit GFP_NOWAIT allocation. If this allocation fails under memory
pressure, mas_store() sets mas into an error state without modifying the tr=
ee.

Because the return value is ignored, the next call mas_prev_range(&mas, 0)
would immediately return NULL upon seeing the error state, causing the padd=
ing
cleanup mas_store(&mas, NULL) to be skipped.

Could this result in the module's maple tree range being permanently leaked
because the original module pointer remains in the tree?

> +out:
> +	mas_unlock(&mas);
> +}
> +
> +static void *reserve_module_tags(struct module *mod, unsigned long size,
> +				 unsigned int prepend, unsigned long align)
> +{

[Severity: High]
This isn't a bug introduced by this patch, but does reserve_module_tags()
silently succeed when mas_store() fails?

If mas_store(&mas, mod) fails due to memory pressure:

	if (mas_is_err(&mas)) {
		mas.index =3D pad_start;
		mas_erase(&mas);
		ret =3D ERR_PTR(xa_err(mas.node));
	}

Does mas_erase(&mas) destroy the error state in mas.node before it can be
read?

mas_erase() resets the maple state and walks the tree, overwriting the error
pointer in mas.node with a valid tree node or NULL. The subsequent
ret =3D ERR_PTR(xa_err(mas.node)) then reads this non-error node, resulting=
 in
ret =3D NULL.

Since ret is not an error pointer, would IS_ERR(ret) evaluate to false,
causing the function to incorrectly return success?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810093955.1530=
15-1-hao.ge@linux.dev?part=3D1
