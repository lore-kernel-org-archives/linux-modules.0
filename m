Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9DA143C63
	for <linux-modules@vger.kernel.org>; Sat,  9 Nov 2024 22:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731190715; cv=none; b=Q0FEAcVPk+9Um5jBZYKoWG6oAgryPaqIfcCZPPPzpR5Yw334JfaV4PepdlL+iIC7xUs0w8ylemiPDsKmJ0UWtjn2aES8TNKeRL4LbeVBDglBh+q9qXiz/yimXFRmYr83X2iM2jKeUsoqmjunpJ8l/WpVgSyXeDvcES7NvX9E6eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731190715; c=relaxed/simple;
	bh=fzBFJIcd3qlFlWYoEdtn06bovmvzZegifUjMYynKNtM=;
	h=MIME-Version:Content-Type:Date:Message-ID:Subject:CC:To:From:
	 In-Reply-To:References; b=P3mfEeo5nO/Eo1n2KzzCuPjbjZUtSDdluaB7e2Mm3WoJhkpxTicSfCG1TPm5snKeIKAfWqJQDFyVSTi1k7DxdNeTG6ohhqWjVsYB639x6ArXSztiWm2iAjUHpXA4jTWGBLJFJqOUCu866YiXBzXrl8hX7rgzOCPosx3ia1HxrGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=AF8bvp+v; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AF8bvp+v"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20241109221831euoutp0214b5f988223c9c08bdfd6c173765fa2e~GbMetq9Eo1942519425euoutp02B
	for <linux-modules@vger.kernel.org>; Sat,  9 Nov 2024 22:18:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20241109221831euoutp0214b5f988223c9c08bdfd6c173765fa2e~GbMetq9Eo1942519425euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1731190711;
	bh=1QYkVJ2Bgp5p8UrOg8lRsj0WLdLN1sJlQeeS+VEyRNc=;
	h=Date:Subject:CC:To:From:In-Reply-To:References:From;
	b=AF8bvp+v+B+AvPVLsXk/8dr+GCJlKRe045+P2R/BVu7nqXxNU/oG22IeojfM2dgae
	 U0sxTpN7s+O0QC77lOogeSNU2bxq2hED+VYHwais9OXcLJNru1vvufxpcZvwstZYeU
	 G6eiDX1ZW/q6GghUQASydc1085UuwwkhkSui+jN8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20241109221831eucas1p24f3b1e7927d45a70cf0fd6f4fe489f4e~GbMeLNgCF1899518995eucas1p2x;
	Sat,  9 Nov 2024 22:18:31 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 22.B4.20409.6BFDF276; Sat,  9
	Nov 2024 22:18:30 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20241109221829eucas1p250055e370d38d9104f71e08633139406~GbMc1-RbV0948609486eucas1p2O;
	Sat,  9 Nov 2024 22:18:29 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241109221829eusmtrp232ac7c25b60d39f36561ce02b1116f71~GbMc1brwE1587815878eusmtrp2a;
	Sat,  9 Nov 2024 22:18:29 +0000 (GMT)
X-AuditID: cbfec7f4-c39fa70000004fb9-9a-672fdfb6c881
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 2D.59.19654.5BFDF276; Sat,  9
	Nov 2024 22:18:29 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241109221829eusmtip26dea181605cb08805274e8a5f09da181~GbMcmpob31523115231eusmtip24;
	Sat,  9 Nov 2024 22:18:29 +0000 (GMT)
Received: from mail.scsc.local (106.110.32.87) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Sat, 9 Nov 2024 22:18:28 +0000
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 9 Nov 2024 23:18:27 +0100
Message-ID: <D5HZVZY3ZW6B.3MM2Y4NBQ51MC@samsung.com>
Subject: Re: [RFC PATCH 1/3] module: Split module_enable_rodata_ro()
CC: <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Luis Chamberlain
	<mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen
	<samitolvanen@google.com>, Kees Cook <kees@kernel.org>,
	<linux-modules@vger.kernel.org>
From: Daniel Gomez <da.gomez@samsung.com>
X-Mailer: aerc 0.18.2-67-g7f69618ac1fd
In-Reply-To: <737f952790c96a09ad5e51689918b97ef9b29174.1731148254.git.christophe.leroy@csgroup.eu>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsWy7djPc7rb7uunGzw7ZmVxZ9Jzdot1b8+z
	WlzeNYfNomH2d1aLGxOeMlos/fKO2WLpiresFps3TWV24PD4evMck8eCTaUem1Z1snm8O3eO
	3WP9lqssHp83yQWwRXHZpKTmZJalFunbJXBlXN+6nb1gh3TFoVd7mBoYX4l1MXJySAiYSOxa
	vZoFxBYSWMEoMe9nWRcjF5D9hVFix9/DjBDOZ0aJbxsWs8J0PF3wnQkisZxR4kfjM4Sq61em
	MUM4Oxglpq14DTaYV0BQ4uTMJ2A2s4C2xLKFr5khbE2J1u2/2UFsFgEViS/PZzBD1JtIbLp7
	HywuLOAisXTiAjaIeg+JRQcesYAsEBF4ziixem8XWIINaNC+k5vYIe5Tk/jfPxFsGadAkkTj
	gelMEHFFiRkTV7JA2LUSp7bcAvtBQqCZU2LNtu9AgziAHBeJJ7vjIGqEJV4d3wI1U0bi/875
	UHPSJZasmwU1p0Biz+1ZrBCt1hJ9Z3Igwo4S18/NhQrzSdx4KwhxPp/EpG3TmSHCvBIdbUIT
	GFVmIQXQLKQAmoUUQAsYmVcxiqeWFuempxYb5aWW6xUn5haX5qXrJefnbmIEpp/T/45/2cG4
	/NVHvUOMTByMhxglOJiVRHg1/PXThXhTEiurUovy44tKc1KLDzFKc7AoifOqpsinCgmkJ5ak
	ZqemFqQWwWSZODilGphWLHmx6dGKJEHOTRzZf18ar8lOWO51Z+XSOkHbtBkr10nNj1mz1SHv
	RnR4LE+axfI/8jOXW5V7/fokJbXpinjiBUV1LcX7a8ouLYzb+uPWqs2JrTN2iuU5MpXvubm8
	++uBsj7pVekv5+65deDhxCu/opl2b2/n9913YolHs9Hk6zcd9j04u3ubZkKkam26o+yRMD/p
	OX+vTfgR+z8y8NqCnqQpbVt71u4osGK5cvez0gzDv/9duU+f/syyrLk/+zL3b2NGy+6KZ/za
	oe/W7NLdVTW3c2L61bqmeM0FLmuOP5ZhuXTrzt33yS+Mv7FOf3TPvmXVz9NXZdh9NGfaTGt3
	3mGXvzI3OvZyyC3/hnkV4kosxRmJhlrMRcWJAAvyrxmuAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsVy+t/xe7pb7+unG8w4L2txZ9Jzdot1b8+z
	WlzeNYfNomH2d1aLGxOeMlos/fKO2WLpiresFps3TWV24PD4evMck8eCTaUem1Z1snm8O3eO
	3WP9lqssHp83yQWwRenZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTm
	ZJalFunbJehlXN+6nb1gh3TFoVd7mBoYX4l1MXJySAiYSDxd8J2pi5GLQ0hgKaPE0qk7mCAS
	MhIbv1xlhbCFJf5c62KDKPrIKNHy+ygjhLODUaJn5XxGkCpeAUGJkzOfsIDYzALaEssWvmaG
	sDUlWrf/ZgexWQRUJL48n8EMUW8isenufbC4sICLxNKJC9gg6j0kFh14xAKyQETgOaPE6r1d
	YAk2oEH7Tm5ihzhJTeJ//0QWiCs2M0qcW7Ia7ApOgSSJxgPToX5QlJgxcSULhF0r8fnvM8YJ
	jCKzkBw7C8mxs5Acu4CReRWjSGppcW56brGRXnFibnFpXrpecn7uJkZglG479nPLDsaVrz7q
	HWJk4mA8xCjBwawkwqvhr58uxJuSWFmVWpQfX1Sak1p8iNEU6OuJzFKiyfnANJFXEm9oZmBq
	aGJmaWBqaWasJM7LduV8mpBAemJJanZqakFqEUwfEwenVAPTnG9ta5k1gvVXby1Y+jd5+rSp
	3P0+33+93rRgq+7T5TsdZGz11nyWjDY56f+obKXy0ayDFldVhAQfhaqZ3n7+++p5vyq22ns7
	gqXWPd93Y/qX6cdXTWv/1+p4JdUhSfqo17Xjd/4w1rxJlrpy8c0GWwGVbcn7rB20Dx7ZEcDg
	4OV6vvHb2c+V/wR3M33x4lzeLnzGVGnbq57eR+dfK6+WuL3Rr5KbtezScsayW9MzI+/YSD6Y
	+9LvauZLR/41ScwqCv6q+mySbq18WqJvppac4fzpkZn64d/mF/80f7j0TwywnnUz8V/QiZDP
	SicPyIomnlbrOPjOx2LD7HNTziq+8Ak5qVe4b5/EsgXSm9JPXlZiKc5INNRiLipOBADson0C
	WwMAAA==
X-CMS-MailID: 20241109221829eucas1p250055e370d38d9104f71e08633139406
X-Msg-Generator: CA
X-RootMTR: 20241109103551eucas1p1bddb2f2d9a898aba967868dece7cd685
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241109103551eucas1p1bddb2f2d9a898aba967868dece7cd685
References: <CGME20241109103551eucas1p1bddb2f2d9a898aba967868dece7cd685@eucas1p1.samsung.com>
	<737f952790c96a09ad5e51689918b97ef9b29174.1731148254.git.christophe.leroy@csgroup.eu>

On Sat Nov 9, 2024 at 11:35 AM CET, Christophe Leroy wrote:
> module_enable_rodata_ro() is called twice, once before module init
> to set rodata sections readonly and once after module init to set
> rodata_after_init section readonly.
>
> The second time, only the rodata_after_init section needs to be
> set to read-only, no need to re-apply it to already set rodata.
>
> Split module_enable_rodata_ro() in two.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Tested-by: Daniel Gomez <da.gomez@samsung.com>

> ---
>  kernel/module/internal.h   |  3 ++-
>  kernel/module/main.c       |  4 ++--
>  kernel/module/strict_rwx.c | 13 +++++++++----
>  3 files changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/module/internal.h b/kernel/module/internal.h
> index 2ebece8a789f..994f35a779dc 100644
> --- a/kernel/module/internal.h
> +++ b/kernel/module/internal.h
> @@ -322,7 +322,8 @@ static inline struct module *mod_find(unsigned long a=
ddr, struct mod_tree_root *
>  }
>  #endif /* CONFIG_MODULES_TREE_LOOKUP */
> =20
> -int module_enable_rodata_ro(const struct module *mod, bool after_init);
> +int module_enable_rodata_ro(const struct module *mod);
> +int module_enable_rodata_ro_after_init(const struct module *mod);
>  int module_enable_data_nx(const struct module *mod);
>  int module_enable_text_rox(const struct module *mod);
>  int module_enforce_rwx_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 49b9bca9de12..2de4ad7af335 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2581,7 +2581,7 @@ static noinline int do_init_module(struct module *m=
od)
>  	/* Switch to core kallsyms now init is done: kallsyms may be walking! *=
/
>  	rcu_assign_pointer(mod->kallsyms, &mod->core_kallsyms);
>  #endif
> -	ret =3D module_enable_rodata_ro(mod, true);
> +	ret =3D module_enable_rodata_ro_after_init(mod);
>  	if (ret)
>  		goto fail_mutex_unlock;
>  	mod_tree_remove_init(mod);
> @@ -2751,7 +2751,7 @@ static int complete_formation(struct module *mod, s=
truct load_info *info)
>  	module_bug_finalize(info->hdr, info->sechdrs, mod);
>  	module_cfi_finalize(info->hdr, info->sechdrs, mod);
> =20
> -	err =3D module_enable_rodata_ro(mod, false);
> +	err =3D module_enable_rodata_ro(mod);
>  	if (err)
>  		goto out_strict_rwx;
>  	err =3D module_enable_data_nx(mod);
> diff --git a/kernel/module/strict_rwx.c b/kernel/module/strict_rwx.c
> index c45caa4690e5..f68c59974ae2 100644
> --- a/kernel/module/strict_rwx.c
> +++ b/kernel/module/strict_rwx.c
> @@ -44,7 +44,7 @@ int module_enable_text_rox(const struct module *mod)
>  	return 0;
>  }
> =20
> -int module_enable_rodata_ro(const struct module *mod, bool after_init)
> +int module_enable_rodata_ro(const struct module *mod)
>  {
>  	int ret;
> =20
> @@ -58,12 +58,17 @@ int module_enable_rodata_ro(const struct module *mod,=
 bool after_init)
>  	if (ret)
>  		return ret;
> =20
> -	if (after_init)
> -		return module_set_memory(mod, MOD_RO_AFTER_INIT, set_memory_ro);
> -
>  	return 0;
>  }
> =20
> +int module_enable_rodata_ro_after_init(const struct module *mod)
> +{
> +	if (!IS_ENABLED(CONFIG_STRICT_MODULE_RWX) || !rodata_enabled)
> +		return 0;
> +
> +	return module_set_memory(mod, MOD_RO_AFTER_INIT, set_memory_ro);
> +}
> +
>  int module_enable_data_nx(const struct module *mod)
>  {
>  	if (!IS_ENABLED(CONFIG_STRICT_MODULE_RWX))

