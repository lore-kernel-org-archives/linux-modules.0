Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF217256C8B
	for <linux-modules@vger.kernel.org>; Wed, 12 Aug 2026 06:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786514591; cv=none; b=jQPSxI6RfJZh2WR5UOtPjaJMjbLnTfuSfP8J71C5hFecNQbiSPSw2ODGAD5QpZqMXoPuicDPsUPoJT8LbUYvDJz8UVlezUEwE99XJjQF2vDfXdri5Ziy2XpqZXmMk8sn0anMAsRGD4Dlq6AJMMKH+/oubyCxiB49+vhfz1YR9tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786514591; c=relaxed/simple;
	bh=fC/Z3DxCz5YEKGDmsRHaE3DcA7A5LFbBdIYkwCFKK9Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZFHl5RongIXP9hgeRMtTkd2yxvacSAXqSyZmdXwrVOnI/c2VHWrb2pOSCvVWDyLvfZNsA2Nnxc/E4WCfviSDw7gYivjraEdGn2i7yO+/ll74ViQ8prQX+5+FFkget7L83V7UpmnlOOVwvPUQSZpXJh+VJivcmo5OXOUByEW8c1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVovbA3y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVovbA3y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B7EF1F00A3A;
	Wed, 12 Aug 2026 06:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786514589;
	bh=QPA6W9yLjonrg4JuZ8Q/1ZvoiCorz0RI8xTm/w5/flo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FVovbA3yFt2V1ghuhVGRdFhlsSg3eIxlCeiNB+u69iPzhgK8bdtXlnK8JUcldZuKH
	 4s8AecRAED7OwhMjOWFlBOwJKHrPaYaZwibNDIHn8r8QekPPZ2heopdjQiSx9/+Oqy
	 0QGIXt0l5vCVGBGKD5aPbhchZwKYSyyVM0SissLycC4683+79bMu3bHgYnLlJ7t4uF
	 DnMVMsXpt0aUAVEea3In9WG1RLa2KWLiQvEEhuC5o+ZdcSsWwsgm78wFYZZYJ0/E/Z
	 leuji0miB86ehIVMp5/vJ2il4T+PnEVtreKW9flmVS8FphrUJQsa9SJ1U7/G99eIBv
	 Wq0xd+N1OCQUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/2] alloc_tag: move release_module_tags() above
 reserve_module_tags()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hao Ge" <hao.ge@linux.dev>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260812054105.102637-2-hao.ge@linux.dev>
References: <20260812054105.102637-1-hao.ge@linux.dev>
 <20260812054105.102637-2-hao.ge@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 06:03:09 +0000
Message-Id: <20260812060309.8B7EF1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing cleanup in `reserve_module_tags()` error path leaves dangl=
ing pointer in maple tree.
- [High] `release_module_tags()` uses `mas_store()` which can fail silently=
 under memory pressure, leaving a dangling pointer.
--

--- Patch [1]: [PATCH v5 1/2] alloc_tag: move release_module_tags() above r=
eserve_module_tags() ---
commit 1dcbb4a041b40aefa702fd60db8fbd78ff223508
Author: Hao Ge <hao.ge@linux.dev>

alloc_tag: move release_module_tags() above reserve_module_tags()

This patch moves the release_module_tags() cleanup helper above
reserve_module_tags() to avoid the need for a forward declaration.

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

[ ... ]

> +release_area:
> +	mas_store(&mas, used ? &unloaded_mod : NULL);
> +	val =3D mas_prev_range(&mas, 0);
> +	if (val =3D=3D &prepend_mod)
> +		mas_store(&mas, NULL);

[Severity: High]
This is a pre-existing issue, but since the code is being moved here: could
mas_store() fail silently under memory pressure, leaving a dangling pointer?

When unloading a module, release_module_tags() calls mas_store() to clear
the module's reservation. If the internal maple tree allocation fails, is t=
he
error state ignored? This could leave the tree retaining the old pointer,
which might lead to a use-after-free when the module subsystem frees it.

Would using mas_store_gfp(..., GFP_KERNEL) be needed here to ensure the
maple tree can sleep to allocate memory?

> +out:
> +	mas_unlock(&mas);
> +}
> +
>  static void *reserve_module_tags(struct module *mod, unsigned long size,
>  				 unsigned int prepend, unsigned long align)
>  {

[Severity: High]
This isn't a bug introduced by this patch, but the commit message mentions
that reserve_module_tags() can fail after storing the reservation in the
maple tree and should call release_module_tags() to undo it.

However, looking at the existing reserve_module_tags() code down the line,
if vm_module_tags_populate() fails:

reserve_module_tags() {
    ...
    grow_res =3D vm_module_tags_populate();
    if (grow_res) {
        shutdown_mem_profiling(true);
        pr_err("Failed to allocate memory...\n", mod->name);
        return ERR_PTR(grow_res);
    }
    ...
}

Does this error path still return without actually calling
release_module_tags(mod, false)?

If the undo call is still missing here, it appears the maple tree mod_area_=
mt
might retain a pointer to the module that is being freed, potentially leadi=
ng
to a use-after-free during subsequent lookups. Should that call be added he=
re
in a follow-up patch?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812054105.1026=
37-1-hao.ge@linux.dev?part=3D1
