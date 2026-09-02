Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DA43EB110
	for <linux-modules@vger.kernel.org>; Wed,  2 Sep 2026 08:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788338062; cv=none; b=fsHc+7Fkp1Gl1njlDH3mOwk09uky4arLoxHAlkMDwaHyaTUZg9G6ybCDaMM7gF/5nFXm/KCKAEVqx5zfQ43aM/3vb5/76bF8ZF5B6LZbo9vcHVQ2BT4zbjAeMKzGHS313fNCSt9OzxFZrb18/8qDuEd+RdKHdPlJEQLh5Y/KYRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788338062; c=relaxed/simple;
	bh=wWQJPS/88oe3h8x45eCIM8zqpAApN4kR8EAJ/gzeXJc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j+kuJvGL6UhWfpVzj0G4w++tE51HYikjw6jNeM87e4bYLnMzynQ6SWwQ75o2R6KZyAA5HX5jLi6P+BqJpxGDCgjfZ6w2JCQ9YZHkj5cDExcBteJ6GXm8IDF5xfYiDUKFzCYkrYETjZvnvtComSlYAWBwNvyqAANmQ8/HOHT+bTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sno7DqRu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sno7DqRu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D741F000E9;
	Wed,  2 Sep 2026 08:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788338060;
	bh=BZc5QPU7NlVLZQ1D4O/RzuMbpGISULm9CRel6KLx96w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Sno7DqRuC95CvTSqAE8iH/oEi5vxZJc03ciqTGc8VqN5hOgvbGtCjI5lnumJL4Dgg
	 aYylt0dE4r4V1LpJ/jFYrdsz5cwcXEnL7+b5CZxdMHo80LRZtlFpbVufZZN5aWKye2
	 hOE1T2BHjeJ880P5swLLkpxySoY+UVsEF/woxSFNaO1Yqp9KRXiQ8tdJHgyChhUaDJ
	 KAg978KSrVNnO8yqiMe2HIdJHiioERKIBn+rxPtpa5cOM/jHDR4zrgE0XKsbf80ZQv
	 oq6RhwctKhZsZaGpE3PWReq7+uJbdx7GEsnY5LROWb0kqqU2D/puDuAf+fgF7HV8l/
	 tnnpnC4y10aUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/4] alloc_tag: move release_module_tags() above
 reserve_module_tags()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hao Ge" <hao.ge@linux.dev>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260902081802.146145-2-hao.ge@linux.dev>
References: <20260902081802.146145-1-hao.ge@linux.dev>
 <20260902081802.146145-2-hao.ge@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 08:34:20 +0000
Message-Id: <20260902083420.A1D741F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `release_module_tags()` function modifies the `mod_area_mt` ma=
ple tree while holding `mas_lock` (a spinlock), which forces `mas_store()` =
to use `GFP_NOWAIT` for internal node allocations. If the tree needs to all=
ocate a node (e.g. to merge adjacent `NULL` slots via `mas_wr_extend_null()=
`) and memory pressure causes the allocation to fail, `mas_store()` silentl=
y aborts and leaves the maple state in an error condition. Because `release=
_module_tags()` does not check `mas_is_err(&mas)` or preallocate nodes, the=
 `mod` pointer remains in the tree after the module is freed. If a subseque=
ntly loaded module reuses the exact same `struct module *` address and then=
 is unloaded, `release_module_tags()` will match the stale pointer. This ca=
uses it to process the stale tag area, leading to a Use-After-Free when `pr=
_info` dereferences the old module's freed `.rodata` via `tag->ct.modname`.
--

commit 85214c8b1888956f945e1850b83b26c40f80620f
Author: Hao Ge <hao.ge@linux.dev>

alloc_tag: move release_module_tags() above reserve_module_tags()

This patch moves the release_module_tags() helper function above
reserve_module_tags() in the file. This allows reserve_module_tags() to
call it for cleanup on failure paths without needing a forward declaration.

Cc: stable@vger.kernel.org

> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
> index b334103104779..2070e682fe106 100644
> --- a/mm/alloc_tag.c
> +++ b/mm/alloc_tag.c
[ ... ]
> @@ -835,6 +835,52 @@ static int vm_module_tags_populate(void)
>  	return 0;
>  }
> =20
> +static void release_module_tags(struct module *mod, bool used)
> +{
> +	MA_STATE(mas, &mod_area_mt, module_tags.size, module_tags.size);
[ ... ]
> +release_area:
> +	mas_store(&mas, used ? &unloaded_mod : NULL);
> +	val =3D mas_prev_range(&mas, 0);
> +	if (val =3D=3D &prepend_mod)
> +		mas_store(&mas, NULL);

[Severity: High]
This isn't a bug introduced by this patch, but since the code is being
moved here, could these mas_store() calls fail silently under memory
pressure?

Since release_module_tags() modifies the maple tree while holding
mas_lock() (a spinlock), mas_store() uses GFP_NOWAIT for internal node
allocations, such as when it needs to merge adjacent NULL slots.

If a GFP_NOWAIT allocation fails, mas_store() aborts and leaves the
maple state in an error condition. Because this function doesn't
preallocate nodes before acquiring the lock or check mas_is_err(&mas)
after the store, the stale module pointer remains in the tree.

If a subsequently loaded module reuses the exact same struct module
address and is later unloaded, could this cause release_module_tags()
to process the stale entry instead? This appears it would trigger a
Use-After-Free when pr_info() dereferences the old module's freed
.rodata section via tag->ct.modname.

> +out:
> +	mas_unlock(&mas);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902081802.1461=
45-1-hao.ge@linux.dev?part=3D1
