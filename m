Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754773CD8C9
	for <linux-modules@vger.kernel.org>; Wed, 16 Sep 2026 18:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789581937; cv=none; b=kNC8NtxbMsO6AzSDCrQfQ1ksVsv/ZOhl075gZ3LX+0Zg7hO0LBdRwIjOwP7PpyBJzGESmtr0EwM3sdAV3AZE5qwEFQEJMBNSDNGqYJQdO1x2Q+TnChGQikdVKXntn1g7F6qDfvfU0aU0dPk9EgNTB3hi4i5e5P0HANfKNcNcC/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789581937; c=relaxed/simple;
	bh=/eqhEfReefhzws6iOzbVBH0+CE1mxRmwoS1nCSzgCag=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BB5mbf1jJHpDkW/c40jepYAU4Dd7yM4F2m8SUKqNU9jnP16yrr+pIHfpYd711cdmwQevxK6II1y+6J1NxgItyN1SFnGhr1X/iApQjdg4cOT9kGmOnLm0Qffbg2TrNffiu2MVnA9lyeOoX2VoSkWC7QRiFxPZigfYGKwQQMSxqrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSyy2rTQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSyy2rTQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F0E21F00898;
	Wed, 16 Sep 2026 18:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789581923;
	bh=cEeWTloPHd7MxJz1kLFooaS6coSNsbnxpkfBANQZMzM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HSyy2rTQE6EgOCo9BkOYsd6Vj14n3rkSzRV3fGWUsIoZDsPjJAu4YSeu1nLU+HHNU
	 X51FuGYOXT/By6mngl/ZoeQneDADV6GkO/hsUW71ePqHkhNJq1EKAuaJEelUjaW/RB
	 B638dXNm4yX/X68tGc62zNe37hlRhnNCPEqiqPqKAu7YqVTtv015lKvSiivrxtogro
	 p6+Jbs1Jo0S01yuwnK44AvWrIQaHF+DGt+Sf96n/fRVMfdXSpVDWgCKRmyLoUUxVQp
	 EiIjuD0J7spAlIIXx6gM4jsA+Xl+NxLDW+67dTBWSK2K7ZMUWfwImQ8QNgqljkn5CQ
	 iPRJCHfFQVPEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] module: Validate the __version_ext_names section
 offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fang Xieyan" <fangxy@xiaopeng.com>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260916174753.14870-3-fangxy@xiaopeng.com>
References: <20260916174753.14870-1-fangxy@xiaopeng.com>
 <20260916174753.14870-3-fangxy@xiaopeng.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 18:05:22 +0000
Message-Id: <20260916180523.1F0E21F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] module: allows reading arbitrary file data for SHT_NOBITS sections
--

commit 7826bfa932aee0181b2db001dad06d62e3bc7702
Author: Fang Xieyan <fangxy@xiaopeng.com>
module: Validate the __version_ext_names section offset

This commit bounds the offset of the __version_ext_names section to prevent
an out-of-bounds read when encountering a SHT_NOBITS section. It adds a call
to validate_section_offset() in elf_validity_cache_index_versions() before
dereferencing the section's offset.

> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index e36bfe4734d59..adaaaca5a4e68 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2296,6 +2296,16 @@ static int elf_validity_cache_index_versions(struc=
t load_info *info, int flags)
>  	 * number of entries in every section.
>  	 */
>  	if (vers_ext_crc) {
> +		/*
> +		 * The name section is walked by its sh_offset and sh_size
> +		 * below. elf_validity_check_sectionheaders() exempts SHT_NOBITS
> +		 * sections from validate_section_offset(), so a __version_ext_names
> +		 * section of that type reaches here with an unvalidated sh_offset.
> +		 * Bound it before dereferencing hdr + sh_offset.
> +		 */
> +		if (validate_section_offset(info, &info->sechdrs[vers_ext_name]))
> +			return -ENOEXEC;

[Severity: Low]
Does this allow in-bounds SHT_NOBITS sections to pass, reading arbitrary
in-bounds file data as extended version names?

This would appear to violate ELF semantics since SHT_NOBITS sections are
not supposed to hold file data.

> +
>  		crc_count =3D info->sechdrs[vers_ext_crc].sh_size / sizeof(u32);
>  		name =3D (void *)info->hdr +
>  			info->sechdrs[vers_ext_name].sh_offset;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916174753.1487=
0-1-fangxy@xiaopeng.com?part=3D2
