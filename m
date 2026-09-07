Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE4023D7E3
	for <linux-modules@vger.kernel.org>; Mon,  7 Sep 2026 06:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763625; cv=none; b=s9Jt7iurvZUNTfxITvgHyoG8ScfRpO+85s+5wjs4ZMOntyMEkozMqehEKEoVbvQ8U54zi0yoBCosuLeqNv8NIwDoiVhxdPm2rA/YBHF+T46/MbMf8+TQwBFmw2j8mLZqJIAku7IRZ0JvpDR/i/5DXl+5wl9iQUo37Evled8/x1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763625; c=relaxed/simple;
	bh=x21PkamW4u8jKF/Kib4WJcgc887WJT0/MpLx/YUfGok=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V9OBw9KqWRhTC1yDkNPwV04PXQO5HuIeWP2jJpRRYesww2Gvt84Isc4RpVeNr+QrzHN8QFE2+Y+tJfsEOc3MRDn4danWh8Po/DcrcfoJTUsLQ71HhW4EQ16e0DbElx57jktIQ7PCqjwdL/xr8aW8gWANdrBvsa09RiJMdDlG0fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMfBjy8w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMfBjy8w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C614F1F00A3D;
	Mon,  7 Sep 2026 06:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788763624;
	bh=iqxyQnscVywPPMsYxKdUUWm+yWnHEuJNlBDzaO7loJ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XMfBjy8wZgTsOcqsOvV4HLWhiEolgi0qfMsgEvy8RhM7fDov621HZ030BOTv2fHOo
	 08jbEMRS4FF5CufgGnRye8GHiadudzEPX0MFjog3xfxV5TMSfSB4cQ0Jr5PLDNTRDh
	 T1AMfHQKd7D2PtPmEW8pFQJlGkfLMZ+MMKyWPiz530k7lkCsCrTPONZSOUln87cQra
	 GCMzO6gx09GcvAJbDQkOol41AsM9cO85DOSEmt7T9gviS368b1BArpthd+TFWjNagO
	 PfVKD9z+2OfHvK4ymsFKIZUbK82BWA90Q9OR5eaOI9ySeKbrQ+ptB/CjSgc2vVRUh8
	 8B/VjpNn3gHOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/4] module: allocate codetag sections before the
 regular module layout
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hao Ge" <hao.ge@linux.dev>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260907062414.106873-4-hao.ge@linux.dev>
References: <20260907062414.106873-1-hao.ge@linux.dev>
 <20260907062414.106873-4-hao.ge@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 06:47:03 +0000
Message-Id: <20260907064703.C614F1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Per-cpu counters for allocation tags are permanently leaked on m=
odule unload if the tag area overflows during module load.
--

commit 2a544bb32bf3bb065ea63ecd36207973b4aa45cd
Author: Hao Ge <hao.ge@linux.dev>

module: allocate codetag sections before the regular module layout

This commit modifies the module loader to decide and allocate codetag
sections in one pass before the regular module layout. If the separate
allocation overflows, it returns -EAGAIN so the section can fall back to
being a regular module section, allowing the module to still load.

Link: https://lore.kernel.org/all/499bb60c-c6e3-43a3-bd92-95a0567ece5e@suse=
.com/ [1]

> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 9b495571d8074..c3ea72e1e412f 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c

[ ... ]

> @@ -2947,6 +2908,49 @@ static bool blacklisted(const char *module_name)
> +static int allocate_codetag_sections(struct load_info *info)
> +{
> +	for (unsigned int i =3D 1; i < info->hdr->e_shnum; i++) {
> +		Elf_Shdr *shdr =3D &info->sechdrs[i];
> +		const char *sname =3D info->secstrings + shdr->sh_name;
> +		void *dest;
> +
> +		if (!codetag_needs_module_section(info->mod, sname, shdr->sh_size))
> +			continue;
> +
> +		dest =3D codetag_alloc_module_section(info->mod, sname, shdr->sh_size,
> +				arch_mod_section_prepend(info->mod, i), shdr->sh_addralign);
> +		if (WARN_ON(!dest)) {
> +			codetag_free_module_sections(info->mod);
> +			return -EINVAL;
> +		}
> +		if (dest =3D=3D ERR_PTR(-EAGAIN))
> +			/* Allocate the section as a regular section. */
> +			continue;

[Severity: Medium]
Could this fallback mechanism cause a permanent leak of per-cpu counters
when the module is unloaded?

When the module tag area overflows, reserve_module_tags() returns -EAGAIN,
and this code catches it to allow the section to load normally. Later in the
load process, the tags are still processed, and per-cpu counters are
unconditionally allocated for each tag:

mm/alloc_tag.c:load_module() {
    ...
    tag->counters =3D alloc_percpu(struct alloc_tag_counters);
    ...
}

However, on module unload, release_module_tags() searches the mod_area_mt
maple tree to find the module. Since the codetag section fell back to
standard memory and was never added to the maple tree, the search fails:

mm/alloc_tag.c:release_module_tags() {
    ...
    if (!val) /* module not found */
        goto out;
    ...
}

This early exit completely bypasses clean_unused_counters(), leaving all
those per-cpu counters allocated during load permanently leaked. Is there a
way to ensure the counters are cleaned up even when the codetag section
falls back to standard memory?

> +		if (IS_ERR(dest)) {
> +			codetag_free_module_sections(info->mod);
> +			return PTR_ERR(dest);
> +		}
> +
> +		if (shdr->sh_type !=3D SHT_NOBITS)
> +			memcpy(dest, (void *)shdr->sh_addr, shdr->sh_size);
> +		else
> +			memset(dest, 0, shdr->sh_size);
> +		shdr->sh_addr =3D (unsigned long)dest;
> +		shdr->sh_entsize =3D SH_ENTSIZE_STANDALONE;
> +	}
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907062414.1068=
73-1-hao.ge@linux.dev?part=3D3
