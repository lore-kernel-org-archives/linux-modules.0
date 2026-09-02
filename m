Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE80D248880
	for <linux-modules@vger.kernel.org>; Wed,  2 Sep 2026 08:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788338020; cv=none; b=VUBwdKt8loXJzimvGyAGEeQ+wmJOCQQx2u+kodrsjcy/dWax4Mjo97fh0zrefwvlRP8Ntqq5TXs8MjWulxNRkVqmOcQxN5pZY2EbG1os/FoePKPXph+mwEAXCxmJmWODc79j1U0rNwnPeT8AIlSuWcksqKjzECKQ/4XAUNKk1Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788338020; c=relaxed/simple;
	bh=L4bqkFZr4M2KRAJosFKfekJOXqeu6sbrziL2c8cYexs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NgnEv11n7VXtUHOJjOGMRRrgC3UMBr2X9fuc7hVuIA3e2JABVqL+wx2CxXbCFSvpmxvc2EHjBK+fApaeTHYBkKMCuq0l+oX61A5ZjUpqIil/wQo1w9ZkKFE4AotSgRMMpr2srOffKV/Z0P4BZP9QPGY6X4LVncKTE8Bf8JtbpUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9zk9QzJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9zk9QzJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 706451F000E9;
	Wed,  2 Sep 2026 08:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788338018;
	bh=zG3kLhd/Dyd31JjDliEvBgqbrjNQOIs/IP3M/uVvbO8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W9zk9QzJq44QRYB+GY3zexCIOxljXt459spo+5K57DGENdEXp2zKQGnIOcrfUKJ2j
	 po/Wq9cRPTodGts8ihjRlUuw1THrdI33o4U519wnYmSF8wdid36fAACbfUD6L9fc9p
	 1EyaBKG5Y3o5oNeuKsZq7j23Y3ldFnX6FlxF31jrOXkeA5jUtvGktLaV5eDPzmalec
	 A5SCb6ADEulc/dWpwgBvCgmaNeK8r1IqNd9MYB4t1oOwk4+1TiQww4jhgcis9dOXdH
	 ldpZMMFLFnSACOXDOWBZ/UNfW7BXcSxHag+NF/oEkLzH6fkmGs1jK7DLkKCKzk+9wi
	 W0/4Euz4Q+88A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/4] module: introduce SH_ENTSIZE_STANDALONE for
 separately allocated sections
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hao Ge" <hao.ge@linux.dev>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260902081802.146145-3-hao.ge@linux.dev>
References: <20260902081802.146145-1-hao.ge@linux.dev>
 <20260902081802.146145-3-hao.ge@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 08:33:38 +0000
Message-Id: <20260902083338.706451F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `.data..percpu` section is incorrectly exported in sysfs wit=
h a dangling pointer to a freed temporary buffer.
--

commit 5082dc654c1b8850af405eef473b249c0d936de9
Author: Hao Ge <hao.ge@linux.dev>

module: introduce SH_ENTSIZE_STANDALONE for separately allocated sections

This commit introduces a new marker, SH_ENTSIZE_STANDALONE, to indicate
sections with a separate allocation. Instead of clearing the SHF_ALLOC
flag, it utilizes sh_entsize so that sections with separate allocations
like the percpu section can be correctly skipped during layout.

Link: https://lore.kernel.org/all/499bb60c-c6e3-43a3-bd92-95a0567ece5e@suse=
.com/

> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index d0e1e0bd2ad06..b114b815187a9 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
[ ... ]
> @@ -2822,7 +2810,8 @@ static int move_module(struct module *mod, struct l=
oad_info *info)
>  		Elf_Shdr *shdr =3D &info->sechdrs[i];
>  		const char *sname;
> =20
> -		if (!(shdr->sh_flags & SHF_ALLOC))
> +		if (!(shdr->sh_flags & SHF_ALLOC)
> +		    || shdr->sh_entsize =3D=3D SH_ENTSIZE_STANDALONE)
>  			continue;
> =20
>  		sname =3D info->secstrings + shdr->sh_name;
[ ... ]
> @@ -2967,8 +2957,13 @@ static struct module *layout_and_allocate(struct l=
oad_info *info, int flags)
>  	if (err < 0)
>  		return ERR_PTR(err);
> =20
> +	/* Repurpose sh_entsize to track where each section is allocated. */
> +	for (i =3D 0; i < info->hdr->e_shnum; i++)
> +		info->sechdrs[i].sh_entsize =3D ~0UL;
> +
>  	/* We will do a special allocation for per-cpu sections later. */
> -	info->sechdrs[info->index.pcpu].sh_flags &=3D ~(unsigned long)SHF_ALLOC;
> +	if (info->index.pcpu)
> +		info->sechdrs[info->index.pcpu].sh_entsize =3D SH_ENTSIZE_STANDALONE;
> =20
>  	/*
>  	 * Mark relevant sections as SHF_RO_AFTER_INIT so layout_sections() can

[Severity: Medium]
Because SHF_ALLOC is no longer cleared here, does this cause the
.data..percpu section to be incorrectly exported via sysfs?

With SHF_ALLOC remaining intact, sect_empty() in kernel/module/sysfs.c now
returns false for the percpu section, causing it to be processed instead of
skipped.

Additionally, because move_module() explicitly skips sections marked with
SH_ENTSIZE_STANDALONE, the sh_addr is never updated to the final allocated
memory.

This means when add_sect_attrs() exports the section:

kernel/module/sysfs.c:add_sect_attrs() {
    ...
	if (sect_empty(sec))
		continue;
    ...
	sattr->private =3D (void *)sec->sh_addr;
    ...
}

Will sattr->private end up storing an unmodified sh_addr pointing to the
freed temporary load_info buffer (info->hdr)?

This appears to leak a stale vmalloc pointer address to userspace when
reading the sysfs file for the section.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902081802.1461=
45-1-hao.ge@linux.dev?part=3D2
