Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788762F6931
	for <linux-modules@vger.kernel.org>; Wed, 12 Aug 2026 03:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786506258; cv=none; b=FHNSRNDEcIRrYoXpfERAU4Kd5MP+HX9IUa+OipxFAW/yOr/E6lSJX6u3TvzMseAm1vemNe9U5/qdK/UuiDhPBGWxhCHh+u785eLneMaNUpMwrUTjzyhchx4hrXv+9fwuv1U3LVFgMTGk55f6c3Wk225f7Vqmyo/mlAwYa2wleNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786506258; c=relaxed/simple;
	bh=hOazogFyL5H5WEfFDSpuLPjkjGdASjBu2PzK2rau2uA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i4FnqeERey3jA6w+tljx7NuMzQ8AfkkZruBqtAvA1RwitQwofRVCsUD6d0tz9Of6eUaQuKfrAJS7F/j+TFmlKLyhG0wXo+aM8D+FaazYiaA83mUygOMtDTAkfmCKKR4HEosn2Mzip2140/f4F88dUi7SElvsfyT2oeJ3sQo1w4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YfRIGEz4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfRIGEz4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB981F000E9;
	Wed, 12 Aug 2026 03:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786506257;
	bh=TcpeVVuDJjyOkQUaz2maQvOYxCW+B8Wa8/A8QWO+Ceg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YfRIGEz4RVCEX5rDlkCL40EH+XYa5WTXLIL2VaiUw5DnizhXhvsTvOLSPwALDudgQ
	 ybCw9sKXW1tkAPOyxETPNL9QZztqrqxKWM+gN00/nS8nrYKHNj/0N4hR9WRzwZQUhb
	 o5owiBxfobVvNXQgO1Mq2v8GKhV9Xu7NZo0SvuAiJpUb9gHMoMLn/3RrpF2zPA9C0b
	 aMKTg3fpBQ1OT2C3motnps6xzZL4LgdXYjprmZ92xMLmX9mVPv8ojg88DdjMt4Bn4m
	 t1Wp8DjQzehqWVmSzWqKbJ/7peiuJ8m57+Lt+FOB2Q7gXq4X7vtvWW4XpMy3SlZfEc
	 ZUj3STq1TfO1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] module/kallsyms: Filter out local and mapping
 symbols during module load
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tiezhu Yang" <yangtiezhu@loongson.cn>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260812032807.15034-4-yangtiezhu@loongson.cn>
References: <20260812032807.15034-1-yangtiezhu@loongson.cn>
 <20260812032807.15034-4-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 03:44:16 +0000
Message-Id: <20260812034416.DAB981F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Relocations can modify `.symtab` and `.strtab` between `layout_sym=
tab()` and `add_kallsyms()`, leading to a heap buffer overflow, out-of-boun=
ds read, and security control bypass.
--

--- Patch [3]: [PATCH v3 3/3] module/kallsyms: Filter out local and mapping=
 symbols during module load ---
commit b99e0a63da9d8d5ffb4bf7cbd78e368abde75865
Author: Tiezhu Yang <yangtiezhu@loongson.cn>

module/kallsyms: Filter out local and mapping symbols during module load

The compiler toolchains generate local and mapping symbols on certain
architectures like LoongArch for optimizations and relocations. This
commit filters them out during module load time using the newly
introduced is_kept_symbol() helper to keep /proc/kallsyms clean.

> diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
> index efc73f66defd5..77e05b5ca1f2c 100644
> --- a/kernel/module/kallsyms.c
> +++ b/kernel/module/kallsyms.c
> @@ -89,6 +89,9 @@ static bool is_kept_symbol(struct module *mod, const st=
ruct load_info *info,
>  	    !src->st_name)
>  		return false;
> =20
> +	if (is_local_mapping_symbol(&info->strtab[src->st_name]))
> +		return false;
> +

[Severity: High]
This is a pre-existing issue, but does this new check introduce an
out-of-bounds read if a malformed module modifies st_name?

In layout_symtab(), .symtab and .strtab are marked with SHF_ALLOC:

kernel/module/kallsyms.c:layout_symtab() {
    ...
    symsect->sh_flags |=3D SHF_ALLOC;
    strsect->sh_flags |=3D SHF_ALLOC;
    ...
}

Later, apply_relocations() applies relocations to sections with
SHF_ALLOC, which can mutate the symbol and string tables in module memory:

kernel/module/main.c:apply_relocations() {
    ...
    if (!(info->sechdrs[infosec].sh_flags & SHF_ALLOC) &&
        (!infosec || infosec !=3D info->index.pcpu))
        continue;
    ...
}

When add_kallsyms() re-evaluates the mutated symbol table, it calls
is_kept_symbol(), which uses the mutated src->st_name without bounds
checking against the unmodified info->strtab.

Could this read out of bounds if st_name is maliciously inflated?

Also, since a previously rejected symbol might now be kept after mutation,
could this overflow the mod->core_kallsyms.symtab array since the number
of kept symbols might now exceed the pre-calculated allocation?

>  #ifdef CONFIG_KALLSYMS_ALL
>  	if (src->st_shndx =3D=3D info->index.pcpu)
>  		return true;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812032807.1503=
4-1-yangtiezhu@loongson.cn?part=3D3
