Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794057902;
	b=uA00beR4QmKEFWEAU2XUwIFgdeo/yIEM/liY+afJO/Qf5izXykOZgzz7rn4nGhPxgMcK
	 Wg99Dnbt0xtGpOcQhmsrOI6okr6yntX08ph5QpvwmP9Ibyefl56EKc1ejZEvuS81Tn9aW
	 hgszpGsuR9Y/bFIjKtFqsZzCycOSMS5yr4cZt64Iz2o++qyp4umizxsoIntZANqoC4ksD
	 gdwvTbv7vfPHNw7yQuoTSMSKINxYG4B2r6E5scSx93I+Ymcssgy+Q2GpFtV0biDJ6Sdyv
	 fuWL8tWlcTb0Kgo3OswOvDzvGty8rSbQbWacukLsCeqr1ukCB0XmAgkecLh1KiA+SMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794057902;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nbafJ0KiybSXyhutiioP9xN2icfvoHKhCsiwksSYsx0=;
	b=ZpiMRfOeDgydFYl+ZxRXMekkTZPMYOZIbOOe0v0O/0er9jkjWc9nYzs+szZ2fZmKOx/V
	 kB4RBIcqO7icmdPinQQWPNt2vbfHGs6rJJWfLC0TlQDfmj6Xk6GPYaYZEedCMFnjGjGw1
	 +ZQu79KC/7HXDh8lypUGqBzik5+7jaEa31U59yzGG3QFs8v9PTerdOwzpfCoT1uWnGy3T
	 lwu0ZF2DZR+88FBE9p9xMgqeMyG3p4ZI6P/xWoZ+BPaaKHUW4ZwTBk3P3m1wVrECU8s32
	 6hlOiy+SWjpuayCe7qQx0/sh1LPBJTCO5+PL9b8QK0Gl19Jj7ouUU2aPe0kAEqX8iqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OMJNXL8c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25F8606A337;
	Sat,  7 Nov 2026 13:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OMJNXL8c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6003E1F0089F;
	Sat,  7 Nov 2026 13:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794057901;
	bh=nbafJ0KiybSXyhutiioP9xN2icfvoHKhCsiwksSYsx0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OMJNXL8cionplf+0Ijzs/a7iwX0E3GDSUZgitUXqWCAYCqcxdPwIP+Xzw+cw2Illi
	 GFaaMNDRNk4AOVTneN7a2PSRkND0bnfb0IDAjtfX/EMWz3fXazRzMIiXtmZHnZAJUW
	 5G/6ndn9APbvbiwOFXymhV7iXezuaBiAoSGtw/bATqASvHgtku/zYHAAzftNhxkfyy
	 iyRLa/FbXTSGM3eQxDCXiQ/8gq2+moFU4h0X8KJiciMOPMgtuXtEONtqpi/fghlioc
	 rvdwjQiZizboTx30e+AIKamUbRtSoUypuTPcPi/0uCRmimF/gn8wYcxmFSruf6vGzh
	 711u6SU99I77g==
Message-ID: <sashiko-outbox-202909@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 1/4] kallsyms: embed source file:line info in kernel
 stack traces
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>, "Masahiro
 Yamada" <masahiroy@kernel.org>, "Luis Chamberlain" <mcgrof@kernel.org>, "Linus
 Torvalds" <torvalds@linux-foundation.org>, "Richard Weinberger" <richard@nod.at>, "Juergen
 Gross" <jgross@suse.com>, "Geert Uytterhoeven" <geert@linux-m68k.org>, "James
 Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: "Jonathan Corbet" <corbet@lwn.net>, "Nathan Chancellor" <nathan@kernel.org>, "Nicolas
 Schier" <nsc@kernel.org>, "Petr Pavlu" <petr.pavlu@suse.com>, "Daniel Gomez" <da.gomez@kernel.org>, "Aaron
 Tomlin" <atomlin@atomlin.com>, "Greg KH" <gregkh@linuxfoundation.org>, "Petr
 Mladek" <pmladek@suse.com>, "Steven Rostedt" <rostedt@goodmis.org>, "Kees
 Cook" <kees@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>, "Thorsten
 Leemhuis" <linux@leemhuis.info>, "Vlastimil Babka" <vbabka@kernel.org>, "Helge
 Deller" <deller@gmx.de>, "Randy Dunlap" <rdunlap@infradead.org>, "Laurent
 Pinchart" <laurent.pinchart@ideasonboard.com>, "Vivian Wang" <wangruikang@iscas.ac.cn>, "Zhen
 Lei" <thunder.leizhen@huawei.com>, "Sami Tolvanen" <samitolvanen@google.com>, linux-kbuild@vger.kernel.org, linux-modules@vger.kernel.org
In-Reply-To: <20261106132432.248387-2-sashal@kernel.org>
References: <20261106132432.248387-1-sashal@kernel.org>
 <20261106132432.248387-2-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 13:24:59 +0000
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] kallsyms: collect_symbol_starts() excludes STT_NOTYPE and
  unsized symbols
- [Medium] kallsyms: collect_symbol_starts() includes SHN_ABS and
  mapping symbols
- [Low] scripts: missing libelf in pkg-config query for gen_lineinfo in
  Makefile
--

commit 5d77a3194e4ba642dd6e711d224cf8351955c65e
Author: Sasha Levin <sashal@kernel.org>

kallsyms: embed source file:line info in kernel stack traces

This commit adds CONFIG_KALLSYMS_LINEINFO and the scripts/gen_lineinfo host
tool to extract DWARF .debug_line mappings from vmlinux and embed source
file:line annotations into kernel stack traces.

> diff --git a/scripts/Makefile b/scripts/Makefile
> index d7fbb7ca098b1..94b09cf7c1839 100644
> --- a/scripts/Makefile
> +++ b/scripts/Makefile
> @@ -4,6 +4,7 @@
>  # the kernel for the build process.
> =20
>  hostprogs-always-y				+=3D kallsyms
> +hostprogs-always-$(CONFIG_KALLSYMS_LINEINFO)		+=3D gen_lineinfo
>  hostprogs-always-$(BUILD_C_RECORDMCOUNT)		+=3D recordmcount
>  hostprogs-always-$(CONFIG_BUILDTIME_TABLE_SORT)		+=3D sorttable
>  hostprogs-always-$(CONFIG_ASN1)				+=3D asn1_compiler
> @@ -40,6 +41,8 @@ HOSTCFLAGS_asn1_compiler.o =3D -I$(srctree)/include
>  HOSTCFLAGS_sign-file.o =3D $(shell $(HOSTPKG_CONFIG) --cflags libcrypto =
2> /dev/null)
>  HOSTCFLAGS_sign-file.o +=3D -I$(srctree)/tools/include/uapi/
>  HOSTLDLIBS_sign-file =3D $(shell $(HOSTPKG_CONFIG) --libs libcrypto 2> /=
dev/null || echo -lcrypto)
> +HOSTCFLAGS_gen_lineinfo.o =3D $(shell $(HOSTPKG_CONFIG) --cflags libdw 2=
> /dev/null)
> +HOSTLDLIBS_gen_lineinfo =3D $(shell $(HOSTPKG_CONFIG) --libs libdw 2> /d=
ev/null || echo -ldw -lelf)
> =20
>  ifdef CONFIG_UNWINDER_ORC
>  ifeq ($(ARCH),x86_64)

[Severity: Low]
Should HOSTCFLAGS_gen_lineinfo.o and HOSTLDLIBS_gen_lineinfo query
pkg-config for both libdw and libelf?

scripts/gen_lineinfo.c directly calls libelf and gelf functions such as
elf_begin() and gelf_getsym().  In elfutils, libdw.pc lists libelf under
Requires.private and outputs only -ldw for --libs, so when pkg-config
succeeds the fallback is skipped and linking gen_lineinfo fails with
undefined libelf references on linkers using --no-copy-dt-needed-entries.

> diff --git a/scripts/gen_lineinfo.c b/scripts/gen_lineinfo.c
> new file mode 100644
> index 0000000000000..1b347d07b7ad5
> --- /dev/null
> +++ b/scripts/gen_lineinfo.c

[ ... ]

> +static void collect_symbol_starts(Elf *elf, unsigned long long text_addr)
> +{
> +	Elf_Scn *scn =3D NULL;
> +	GElf_Shdr shdr;
> +
> +	while ((scn =3D elf_nextscn(elf, scn)) !=3D NULL) {
> +		Elf_Data *data;
> +		size_t nsyms;
> +
> +		if (!gelf_getshdr(scn, &shdr))
> +			continue;
> +		if (shdr.sh_type !=3D SHT_SYMTAB || !shdr.sh_entsize)
> +			continue;
> +
> +		data =3D elf_getdata(scn, NULL);
> +		if (!data)
> +			continue;
> +
> +		nsyms =3D shdr.sh_size / shdr.sh_entsize;
> +		for (size_t i =3D 0; i < nsyms; i++) {
> +			GElf_Sym sym;
> +			unsigned long long raw;
> +
> +			if (!gelf_getsym(data, i, &sym))
> +				continue;
> +			switch (GELF_ST_TYPE(sym.st_info)) {
> +			case STT_FUNC:
> +			case STT_NOTYPE:
> +				break;
> +			default:
> +				continue;
> +			}
> +			if (sym.st_value < text_addr)
> +				continue;
> +			if (text_end_addr && sym.st_value >=3D text_end_addr)
> +				continue;

[Severity: Medium]
Can unfiltered SHN_ABS, mapping ($x, $d, $a, $t) and local (.L*) symbols in
collect_symbol_starts() corrupt the symbol extents in text_starts[]?

Any STT_NOTYPE symbol whose value falls in [_text, _etext) is added to
text_starts[] without checking sym.st_shndx or symbol names.  When the loop
at the end of collect_symbol_starts() infers sizes for unsized symbols from
the distance to the next entry (while leaving the final entry at size 0 if
unsized), internal mapping or .L* labels truncate the inferred extent of the
enclosing routine, and mapping or SHN_ABS symbols receive non-zero sizes of
their own.  starts_new_sequence() -> symbol_extent_at() then misclassifies
DWARF sequence boundaries in resolve_cu_row_groups(), dropping valid opening
line rows or keeping bogus extents.

> +
> +			raw =3D sym.st_value - text_addr;
> +			if (raw > UINT_MAX)
> +				continue;
> +
> +			if (num_sym_starts >=3D sym_starts_capacity) {
> +				sym_starts_capacity =3D sym_starts_capacity ?
> +					sym_starts_capacity * 2 : 16384;
> +				sym_starts =3D xrealloc(sym_starts,
> +						      sym_starts_capacity *
> +						      sizeof(*sym_starts));
> +			}
> +			if (num_text_starts >=3D text_starts_capacity) {
> +				text_starts_capacity =3D text_starts_capacity ?
> +					text_starts_capacity * 2 : 16384;
> +				text_starts =3D xrealloc(text_starts,
> +						       text_starts_capacity *
> +						       sizeof(*text_starts));
> +			}
> +			text_starts[num_text_starts].offset =3D (unsigned int)raw;
> +			text_starts[num_text_starts].size =3D
> +				sym.st_size > UINT_MAX ? UINT_MAX :
> +				(unsigned int)sym.st_size;
> +			num_text_starts++;
> +
> +			if (GELF_ST_TYPE(sym.st_info) !=3D STT_FUNC)
> +				continue;
> +
> +			sym_starts[num_sym_starts].offset =3D (unsigned int)raw;
> +			sym_starts[num_sym_starts].size =3D
> +				sym.st_size > UINT_MAX ? UINT_MAX :
> +				(unsigned int)sym.st_size;
> +			num_sym_starts++;
> +		}
> +	}
> +
> +	sort_starts(sym_starts, &num_sym_starts);
> +	sort_starts(text_starts, &num_text_starts);
> +
> +	/*
> +	 * An unsized label reaches the next symbol, and a sequence beginning
> +	 * there cannot run past it.
> +	 */
> +	for (unsigned int i =3D 1; i < num_text_starts; i++) {
> +		if (!text_starts[i - 1].size)
> +			text_starts[i - 1].size =3D text_starts[i].offset -
> +						  text_starts[i - 1].offset;
> +	}
> +}

[Severity: Medium]
Does excluding STT_NOTYPE and unsized symbols from sym_starts[] leave stack
frames in those symbols without lineinfo annotations?

At runtime, __sprint_symbol() resolves kallsyms symbols regardless of wheth=
er
they are STT_FUNC or STT_NOTYPE, and kallsyms_lookup_lineinfo() rejects any
entry below sym_start - _text.  However, sym_starts[] excludes STT_NOTYPE
symbols (such as Clang .cold split subfunctions, SYM_CODE_START assembly
routines, SYM_INNER_LABEL entry points like entry_SYSCALL_64_after_hwframe,
and CONFIG_PROPELLER_CLANG basic-block symbols) and never backfills zero
st_size values.  As a result, synthesize_symbol_starts() does not copy
covering rows to their start addresses and deduplicate() can drop entries
at their start when the file and line match the previous entry, causing
kallsyms_lookup_lineinfo() to fail the min_offset boundary check.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106132432.2483=
87-1-sashal@kernel.org?part=3D1
