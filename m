Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E953876A9
	for <linux-modules@vger.kernel.org>; Tue,  6 Oct 2026 22:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791325711; cv=none; b=HxEYfTVzlqw4EABbnJUgY8i/5rpL6DZV9gi2ZXGaOT5Ma29J2UMungrqOi7EKrDBy7AuccbVbKSBt3Wx8Crz9kuHB92yWM/dOjiN/M+lmNeGllKzlqAG/gz7dAuasw2xim1FpMu03cNNQ2bPVYpdu42NVM7rV+DhrGdACVnWP3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791325711; c=relaxed/simple;
	bh=PKit7fN4mZFvt/5w91nbRoso0Vdp2Gv7vCHBmo3x6Uw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=reiilc+tsJqc8nPOIxa7Fta5/9kWvN/fR1INkM3iBHjMh+z5TKgkOiRWXmleMs2zhpi/kKnZXKacjPfzLT+mnwAR0BS2DS4RletG50A5lcNvvhIhuIpGS5kvXMzn3C7YPWlVL8GTur7PhtlLYR9weyEvBrplsyMs7Ruqj77Dwzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=krqTq2Qe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="krqTq2Qe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F10FA1F0089B;
	Tue,  6 Oct 2026 22:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791325710;
	bh=+IIEtvzTqi4oSDpoihb4t8rlHfJviig78mflcuxnpt8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=krqTq2Qedy1af9l+w23A/oBreIS0AV0E1qshb8rk3pFiQdmqYztozq8l86QI2PSTD
	 cD10m6r19KJkyGv6dofdB90aFwg9cZhtXinxCaQ7sJ12yXdgNexsoSOR8FZIag31Jx
	 J+0abTH19RUQUZGq0npOGiY3R+qIOBFhTWBCLLai1uIJpSF4Eh/rrWn3ltEiZJwIqS
	 WNTaYxKfdfQzFexjlGxcpY7lgNaKYGTWIeSiF9HEW8CIOaovsrDA5L1RtndKY9h2vy
	 ZQ7rw2NtFpbcjLImfc1KGPbU2GxBkk8Jy5VssbeUKWIImQMqiLoBfATMIk0fdt/IGF
	 MZD15MRTqzWKw==
Message-ID: <sashiko-outbox-162484@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC 2/3] kbuild: modules: Build and trigger BTI scanner for
 arm64
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jeremy Linton" <jeremy.linton@arm.com>
Cc: linux-modules@vger.kernel.org, "Petr Pavlu" <petr.pavlu@suse.com>
In-Reply-To: <20261006221815.2823252-3-jeremy.linton@arm.com>
References: <20261006221815.2823252-1-jeremy.linton@arm.com>
 <20261006221815.2823252-3-jeremy.linton@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 22:28:29 +0000
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] scripts/module-bti-check: missing elf_flagdata() on relocation buf=
fer
- [High] kbuild: module-bti-check ignores R_AARCH64_JUMP26 tail calls causi=
ng BTI panics
- [Medium] kbuild: unconditional bti_check execution breaks incremental bui=
lds
--

commit 6f17af1f0f493574af3f26ef3b98809bf3a9aca7
Author: Jeremy Linton <jeremy.linton@arm.com>

kbuild: modules: Build and trigger BTI scanner for arm64
   =20
Now that we have a utility which can detect and correct missing
landing pads, build it and hook it up to scan during module
finalization.

> diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
> index 01a37ec872b90..973adfa72a7d4 100644
> --- a/scripts/Makefile.modfinal
> +++ b/scripts/Makefile.modfinal
[ ... ]
> @@ -47,8 +53,12 @@ quiet_cmd_btf_ko =3D BTF [M] $@
>  	fi;
> =20
>  # Re-generate module BTFs if either module's .ko or vmlinux changed
> -%.ko: %.o %.mod.o .module-common.o $(objtree)/scripts/module.lds $(and $=
(CONFIG_DEBUG_INFO_BTF_MODULES),$(KBUILD_BUILTIN),$(objtree)/vmlinux) FORCE
> +%.ko: %.o %.mod.o .module-common.o $(objtree)/scripts/module.lds $(bti_c=
heck_dep) $(and $(CONFIG_DEBUG_INFO_BTF_MODULES),$(KBUILD_BUILTIN),$(objtre=
e)/vmlinux) FORCE
>  	+$(call if_changed,ld_ko_o)
> +ifdef CONFIG_ARM64_BTI_KERNEL
> +	+$(call cmd,bti_check)
> +endif
> +
>  ifdef CONFIG_DEBUG_INFO_BTF_MODULES
>  	+$(if $(newer-prereqs),$(call cmd,btf_ko))
>  endif

[Severity: Medium]
Will this execute the bti_check unconditionally on every incremental build?

Since the %.ko target uses FORCE, Kbuild relies on conditional macros to
prevent redundant execution. The bti_check command is not wrapped in an
if_changed guard.

Could this cause module-bti-check --fix to run on all modules every time
Kbuild is invoked, breaking the fast path for null builds?

While reviewing this, I also noticed a couple of regressions in
scripts/module-bti-check.c:

scripts/module-bti-check.c:scan_relocations() {
...
			if (!gelf_getrela(data, j, &rela))
				goto out_elferr;

			if (GELF_R_TYPE(rela.r_info) !=3D R_AARCH64_CALL26)
				continue;
...
}

[Severity: High]
Are R_AARCH64_JUMP26 tail calls intentionally filtered out here?

If a module contains a cross-section tail call to a static function, and the
distance requires a PLT, the PLT entry will use an indirect branch to target
the function.

Since static targets don't emit their own BTI pads and the JUMP26 relocation
is bypassed here, wouldn't this indirect branch trigger a BTI exception and=
 a
kernel panic at runtime?

scripts/module-bti-check.c:scan_relocations() {
...
				rela.r_info =3D GELF_R_INFO(veneer->secsym, R_AARCH64_CALL26);
				rela.r_addend =3D veneer->value;
				if (!gelf_update_rela(data, j, &rela))
					return elf_error(obj);

				obj->changed =3D true;
				continue;
...
}

[Severity: High]
Are these modified relocation entries successfully written back to the file?

gelf_update_rela() modifies the Elf_Data relocation block in memory, but the
data block is never flagged as dirty with elf_flagdata().

According to libelf semantics, won't elf_update() silently discard these
relocation changes because the buffer isn't marked dirty?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006221815.2823=
252-1-jeremy.linton@arm.com?part=3D2
