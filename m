Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0077A45000
	for <linux-modules@vger.kernel.org>; Thu, 17 Sep 2026 19:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789673186; cv=none; b=sCcXgBiIYfcYJ2h5Hn5QQN9QahLHkHVhs5k2zJOHDuJl7SNtQpe4n8cdpcbA/X1Ua+Bt+PwcTBnDJ72PpmnZiT3SyMBFkIrVynDnX08M/OAbvn/rq3s3calUz4MWbfrmz9nKXgjS/szqstg8TwLdKbkT38rTGjjkZyGSDl2HD2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789673186; c=relaxed/simple;
	bh=KvRs4C+Dk8lKDjsXDjxlgLRUOU/xzRRySNirpfFqCyo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NWZqVVm+Xzop1w4V+K0yk8Aislr5Q9Sbkoi/NzKcDBOkVd202TbURAEh9J7sI4tXTFTVeM2BSMxATY9PRAdykvirXly9myrRZC1wVsp0kvkOUsVx6bSZVGIORkYZsaMCB1TEiBiOuaUU9EKGQ12r4bx1B97bN03JZZVkFz2v0uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=otHxfhQf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="otHxfhQf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88CE61F000FF;
	Thu, 17 Sep 2026 19:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789673184;
	bh=xeiTM7Hvwcxt5MrjJnKPurTnkK+537sK3frJi7Vw8Qk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=otHxfhQfONdy2tmdYC8KYjl6osaQNbq+VTsYa1qdW+ZY7kH5+ZwgcYQmVHa+/TjJh
	 GxqpMv+OZFfOovpHLF1epedwuVV08ibq009TcTSg6y/nXmBquN+H17J+90I/UolepJ
	 qB7MK92YvPnkTflyuvv5A6Q4rDV2rully3PqzD2olA0Gq1gi9ecu1vPUYsJWl6o6LW
	 yuRw4eI33dsyzUSOeNY9JhxxVGrkGPnIJBYP6LmfUodkD1DNil6rURekeyk+xY9Sm6
	 9UfnwNWYmfVb6PGqOrj6YojyyZ71lZX1gJeQEIzgi/RzHkk8KxBK6pYNMLSRqyMab1
	 Bu99Jh7KFIlmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] module: Sanitize the undefined sh_name of
 SHT_NULL sections
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fang Xieyan" <fangxy@xiaopeng.com>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260917190618.94759-2-fangxy@xiaopeng.com>
References: <20260917190618.94759-1-fangxy@xiaopeng.com>
 <20260917190618.94759-2-fangxy@xiaopeng.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 19:26:24 +0000
Message-Id: <20260917192624.88CE61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] module: OOB memory read via SHT_NULL section aliasing
--

commit 536b936ee0704f1857141d93c7d4113160b708c4
Author: Fang Xieyan <fangxy@xiaopeng.com>
module: Sanitize the undefined sh_name of SHT_NULL sections

This commit sets the sh_name of SHT_NULL sections to 0 in order to provide a
safe, in-bounds value for section name walkers. By giving undefined values =
the
empty string at index 0, valid modules remain unaffected while out-of-bounds
reads are prevented.

> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index d0e1e0bd2ad06..e36bfe4734d59 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2060,9 +2060,18 @@ static int elf_validity_cache_secstrings(struct lo=
ad_info *info)
> =20
>  	for (i =3D 0; i < info->hdr->e_shnum; i++) {
>  		shdr =3D &info->sechdrs[i];
> -		/* SHT_NULL means sh_name has an undefined value */
> -		if (shdr->sh_type =3D=3D SHT_NULL)
> +		/*
> +		 * SHT_NULL means sh_name has an undefined value. The section
> +		 * name walkers that follow (find_any_unique_sec(),
> +		 * module_mark_ro_after_init(), ...) look the name up as
> +		 * secstrings + sh_name for every section, so give the undefined
> +		 * value a safe in-bounds meaning instead of skipping the check:
> +		 * the empty string at index 0.
> +		 */
> +		if (shdr->sh_type =3D=3D SHT_NULL) {
> +			shdr->sh_name =3D 0;

[Severity: High]
Does this safely neutralize SHT_NULL sections?

This forcefully sets the name to index 0, assuming index 0 is always
guaranteed to be an empty string. However, earlier in
elf_validity_cache_secstrings(), the string table validation checks the last
byte but fails to ensure that secstrings[0] =3D=3D '\0':

kernel/module/main.c:elf_validity_cache_secstrings() {
    ...
	if (secstrings[strhdr->sh_size - 1] !=3D '\0') {
		pr_err("ELF Spec violation: section name table isn't null terminated\n");
		return -ENOEXEC;
	}
    ...
}

Because of this, can an attacker craft a string table starting with a criti=
cal
section name like .modinfo so that a SHT_NULL section at index i > 0 aliases
to .modinfo?

Since walkers like find_any_unique_sec() do not filter out SHT_NULL section=
s,
this spoofed name at index 0 could be successfully matched:

kernel/module/main.c:find_any_unique_sec() {
    ...
	for (i =3D 1; i < info->hdr->e_shnum; i++) {
		if (strcmp(info->secstrings + info->sechdrs[i].sh_name,
			   name) =3D=3D 0) {
    ...
}

Furthermore, SHT_NULL sections are explicitly exempted from offset validati=
on
in elf_validity_cache_sechdrs():

kernel/module/main.c:elf_validity_cache_sechdrs() {
    ...
		switch (shdr->sh_type) {
		case SHT_NULL:
		case SHT_NOBITS:
			/* No contents, offset/size don't mean anything */
			continue;
    ...
}

Could this allow functions like get_next_modinfo() to dereference the
unvalidated sh_offset of the aliased SHT_NULL section?

kernel/module/main.c:get_next_modinfo() {
    ...
	char *modinfo =3D (char *)info->hdr + infosec->sh_offset;
    ...
}

Could this lead to an out-of-bounds memory read and a potential kernel pani=
c?

>  			continue;
> +		}
>  		if (shdr->sh_name >=3D strhdr->sh_size) {
>  			pr_err("Invalid ELF section name in module (section %u type %u)\n",
>  			       i, shdr->sh_type);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917190618.9475=
9-1-fangxy@xiaopeng.com?part=3D1
