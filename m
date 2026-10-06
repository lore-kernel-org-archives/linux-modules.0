Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5111037F739
	for <linux-modules@vger.kernel.org>; Tue,  6 Oct 2026 22:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791325934; cv=none; b=jn3s8YZNVE1Ujy3W9iqYGe6SxDMRuWbe1p49iTFfzy/AcT4IDDAabu7PWu/c8Say24ZYZHnt0ctus1ikoT8uXPLLMaJFnqFddwJmdBzbZ494E5A1RV2f53dPcJOi0P/NaZXsf1Z5401XoRCABo+kwjAv0+MDklgt8nPFF8G/EHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791325934; c=relaxed/simple;
	bh=hFv0MXVPvhz0WRBwfQqUoYE9onwt9hZH/QfKgJ+frzw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=H5EaJqkw5DxkW6yy3/J9dt9EdLHYwCWS+iHI7hX9kiFd907GlH6LHiJthm+DVX/NSjy/yfOdAKlHGB3w5RAw3HBO9o3dcvbkavRJO1crsgvedAFvaYUh38b0zCIvemG17XcyXPKZN7BfCE/p5ox8oPU5M92sq49UY0GBhuec5BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U9T2Pg6S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9T2Pg6S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEDDC1F0089B;
	Tue,  6 Oct 2026 22:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791325932;
	bh=dWh1taBC+CTGq8F29sJLi1r2d0P0/jxQqLMz5jUGYBQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U9T2Pg6SYlQPOz1pTlYhNm8D9v0P7/DvlFqU86I9R7TFx8L6M8+CqSbOmRDPYU3Rq
	 NeCAuW3ZDlhf5ZlrlUQumjjirYXhudIB+8o8fGMat+exlR8XZTYuocSEAcutK/u7ad
	 4YpyXqGmAV1DlWYLDmKnoMddFZWzLDhWQNO4KvRAj4hSD8WglEQMHNcYEKXum6bsWs
	 rI6DQ6WpGjzWPeRtgF7AYXKJ2SKwIdS3W6JZreB3S1JWj2EMi9Y1mj+7muRWuHD0xz
	 OsERnajrzgGhZdpmXNXYM7i85TA4Qu8BLO/QdbV1o58ymdgudYpatvtm/h//Mvig6p
	 HcvLu0veAM1nA==
Message-ID: <sashiko-outbox-162492@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC 1/3] kbuild: modules: Add arm64 BTI fixup utility
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jeremy Linton" <jeremy.linton@arm.com>
Cc: "Petr Pavlu" <petr.pavlu@suse.com>, linux-modules@vger.kernel.org
In-Reply-To: <20261006221815.2823252-2-jeremy.linton@arm.com>
References: <20261006221815.2823252-1-jeremy.linton@arm.com>
 <20261006221815.2823252-2-jeremy.linton@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 22:32:12 +0000
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] build: missing elf_flagdata() causes relocation updates to be sile=
ntly discarded
- [Medium] build: POSIX exit code truncation wraps unfixed BTI counts of ex=
actly 256 to success
- [Medium] scripts: module-bti-check conflates fatal errors with violation =
counts
--

commit f30f3429bd0a90f5e903b1b7fe22a7c8b76f0249
Author: Jeremy Linton <jeremy.linton@arm.com>

kbuild: modules: Add arm64 BTI fixup utility

This commit introduces a new host build tool, module-bti-check, to verify
and fix up arm64 cross-section module calls that lack BTI landing pads.
It accomplishes this by scanning R_AARCH64_CALL26 relocations and placing
veneers in the target section where necessary.

> diff --git a/scripts/module-bti-check.c b/scripts/module-bti-check.c
> new file mode 100644
> index 0000000000000..c8bef0ed90bb7
> --- /dev/null
> +++ b/scripts/module-bti-check.c

[ ... ]

>  			if (fix) {
>  				ret =3D get_veneer(obj, veneers, &target, &veneer);
>  				if (ret)
>  					goto out;
> =20
>  				rela.r_info =3D GELF_R_INFO(veneer->secsym, R_AARCH64_CALL26);
>  				rela.r_addend =3D veneer->value;
>  				if (!gelf_update_rela(data, j, &rela))
>  					return elf_error(obj);

[Severity: High]
Does this miss setting the libelf dirty flag on the data descriptor?

When gelf_update_rela() is called in scan_relocations(), it updates the
in-memory buffer, but libelf requires elf_flagdata(data, ELF_C_SET,=20
ELF_F_DIRTY) to actually write the modifications back to the file during
elf_update().=20

Without the dirty flag, won't the new landing pad veneers be silently
discarded when the updated .rela section is dropped during the file write?

> =20
>  				obj->changed =3D true;
>  				continue;
>  			}

[ ... ]

>  			fprintf(stderr,
>  				"%s: cross-section call from %s%s%s+0x%llx to %s (%s+0x%llx) lacks a=
 BTI landing pad\n",
>  				obj->name, source ?: "", source ? " " : "",
>  				section_name(obj, shdr.sh_info),
>  				(unsigned long long)rela.r_offset, target.name,
>  				section_name(obj, target.section_index),
>  				(unsigned long long)target.value);
> =20
>  			unfixed++;
>  		}
>  	}
> =20
>  	ret =3D unfixed;
>  out:
>  	return ret;

[Severity: Medium]
Is there a risk of exit code truncation here? scan_relocations() returns
the raw count of unfixed occurrences, which is eventually propagated up
to main() and used as the process exit code.

Since POSIX exit codes are truncated to 8 bits, what happens if the tool
encounters exactly 256 (or 512, etc.) unfixed occurrences? It appears=20
returning 256 would wrap to 0, which might trick the build system into=20
treating it as a successful execution despite missing BTI pads.

[ ... ]

>  	/* Must happen after elf end, to assure correctness */
>  	while (veneers) {
>  		struct veneer *next =3D veneers->next;
> =20
>  		free(veneers);
>  		veneers =3D next;
>  	}
> =20
>  	if (fd >=3D 0)
>  		close(fd);
> =20
>  	if (ret < 0) {
>  		if (ret !=3D -ELIBBAD)
>  			fprintf(stderr, "%s: %s\n", name, strerror(-ret));
>  		return EXIT_FAILURE;
>  	}
> =20
>  	return ret;
>  }

[Severity: Medium]
Could this error handling conflate fatal OS or libelf errors with violation
counts?

In process_file(), negative error codes like -ENOMEM are converted to
EXIT_FAILURE (which is 1). Because this overlaps with the value returned
when there is exactly 1 unfixed violation, main() cannot differentiate
between a tool failure and a BTI warning.

[ ... ]

>  	if (elf_version(EV_CURRENT) =3D=3D EV_NONE) {
>  		fprintf(stderr, "libelf initialization failed: %s\n", elf_errmsg(-1));
>  		goto out;
>  	}
> =20
>  	for (i =3D optind; i < argc; i++) {
>  		int status =3D process_file(argv[i], fix);
> =20
>  		if (status && !warn) {
>  			ret =3D status;
>  			goto out;
>  		}
>  	}

When the --warn flag is active, it ignores all non-zero status codes. Won't
this silently mask build environment failures, returning success even if=20
the file couldn't be opened or processed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006221815.2823=
252-1-jeremy.linton@arm.com?part=3D1
