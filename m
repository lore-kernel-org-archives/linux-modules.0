Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704528;
	b=HKyP97VafpvBtKhm80ByJ8DhCSOR6JBriMwryPbDaWX5Z/s1++1ExVU4Z9+e4rKivkrC
	 ufyO8/CERASV2PbWPSJSytX8Q5rlNKWK5nIY/ewvY7DI0388siQD58xFFRIo5J5SWVf0Y
	 uKGN/NIdLAY3BCuHbB0wLyDtqz9tNaMYwvTKpjXHVaXgi0H2By6vDqD1CkRtiFf1rep1t
	 9bw7lw0hUucxiDr2cmzZKtKTiH7nAnbDRc7KcekeEYjSG8eQUf5Zi5/YuJkHFdNrvzYQZ
	 EX7XTUDr8DIiJuDJJWnTOPDJusteTQ4iumJKvVUD0DUC3VumFtP+zGFAe9hZVvf0f8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704528;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XiV3jMg1YBKexs9QhvAYguLuKhpGqkbYswYYFBFmFp4=;
	b=IvEtl5abxmrXedqRTkx7W0XPXnmBzw6uvwdYJrp5mVec73fyC4SS1vdVlEz+5JNE89FB
	 hBpK+6wtu3uDC4pnppkHsJ+gfTTzisf79VdV18ypZ7w+TcB+uGcyYyberO2ngQ+9tTSNl
	 dFZEv63Ov4qi/Yh1l4tk8iAZhRqehi4AMiQFZ9KAfmR8f5ufeF3scA3OemuU2qVG/7EBG
	 aMeiISRaCLLCdJLJIxvuV1+HEiT8+QZHV6tmr4S0uPK5GLUvGIw0hGK1ebHKUs8rIgp9L
	 Jbnm6NYFULaiFZApZfrudTCGl2+KqiquD4hEMCUooiTij84zIanMMU3BIpmHH9e79YQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lPNKOgnT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B06C606BA69;
	Tue,  3 Nov 2026 11:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lPNKOgnT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DE931F00919;
	Tue,  3 Nov 2026 11:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793704528;
	bh=XiV3jMg1YBKexs9QhvAYguLuKhpGqkbYswYYFBFmFp4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lPNKOgnTAqCCNOJ2WAX7Rs3S4v6hLnFP6fkgpDJei+s12aUNi/iFpPpNG14W7wi/s
	 /gh5CSOdp3w17EFLf3ZBnMOWJkmikXHLFJt5FKrXKFIs1TmML1Rhx169WuRaXU3Yoh
	 0oP307MhSZnr62iPYNQrjq9BOcTpuQnLr0zMdMot190Nrr88BUjOXXaKFv4vOitPHK
	 3ZqXYyU3HacWreiLmyTraNZjVn1qUcLIdLsMA/mEkiAu/UNt6BYCzmYSXF9CVWcdaG
	 NF8pf566Bt+LbQiRVZ0oO09PCeVB4kTcJo/Xkxeb7DCm6etnP+HYvSzSlG9RtQi+/C
	 G/IjKbmE5IAQQ==
Message-ID: <sashiko-outbox-195131@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 2/4] kallsyms: extend lineinfo to loadable modules
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
In-Reply-To: <20261102111455.919102-3-sashal@kernel.org>
References: <20261102111455.919102-1-sashal@kernel.org>
 <20261102111455.919102-3-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 11:15:26 +0000
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] kbuild: running module.lds twice in cmd_ld_ko_o breaks alloc_t=
ags and arm64
- [Medium] scripts/gen_lineinfo: early return in deduplicate() leaves stale=
 n_entries
- [Medium] scripts/gen_lineinfo: zero bias in resolve_covered_sections() al=
iases .text
- [Medium] scripts/gen_lineinfo: resolve_covered_sections() leaves zero bia=
s gap
--

commit 576d6bd5b277b6e1ee712d143954da5c356b15a1
Author: Sasha Levin <sashal@kernel.org>

kallsyms: extend lineinfo to loadable modules

This commit adds CONFIG_KALLSYMS_LINEINFO_MODULES to embed source file and
line number lookup tables (.mod_lineinfo and .init.mod_lineinfo) into
loadable kernel modules via a two-stage partial link in Makefile.modfinal
and a new --module mode in scripts/gen_lineinfo.

> diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
> index 01a37ec872b90..2f19dc184ffe7 100644
> --- a/scripts/Makefile.modfinal
> +++ b/scripts/Makefile.modfinal
> @@ -46,8 +46,47 @@ quiet_cmd_btf_ko =3D BTF [M] $@
>  		$(CONFIG_SHELL) $(srctree)/scripts/gen-btf.sh --btf_base $(objtree)/vm=
linux $@; \
>  	fi;
> =20
[ ... ]
> +ifdef CONFIG_KALLSYMS_LINEINFO_MODULES
> +lineinfo_ldflags_all =3D $(KBUILD_LDFLAGS_MODULE) $(LDFLAGS_MODULE)
> +lineinfo_ldflags_last =3D $(filter --be8 --build-id --build-id=3D%,		\
> +			       $(lineinfo_ldflags_all))
> +
> +      cmd_ld_ko_o =3D							\
> +	rm -f $@.lineinfo_pre $@.lineinfo.o;				\
> +	$(LD) -r $(KBUILD_LDFLAGS)					\
> +		$(filter-out $(lineinfo_ldflags_last),			\
> +			     $(lineinfo_ldflags_all))			\
> +		-T $(objtree)/scripts/module.lds			\
> +		-o $@.lineinfo_pre $(filter %.o, $^);			\
> +	$(CONFIG_SHELL) $(srctree)/scripts/gen-mod-lineinfo.sh		\
> +		$@.lineinfo_pre $@.lineinfo.o;				\
> +	$(LD) -r $(KBUILD_LDFLAGS) $(lineinfo_ldflags_last)		\
> +		-T $(objtree)/scripts/module.lds -o $@			\
> +		$$(test -f $@.lineinfo.o && echo $@.lineinfo.o)		\
> +		$@.lineinfo_pre;					\

[Severity: Critical]
Does passing -T $(objtree)/scripts/module.lds to both ld -r passes in
cmd_ld_ko_o break CONFIG_MEM_ALLOC_PROFILING and arm64 module loading?

Under CONFIG_MEM_ALLOC_PROFILING, scripts/module.lds.S expands
MOD_SEPARATE_CODETAG_SECTIONS() from include/asm-generic/codetag.lds.h into:

	.codetag.alloc_tags 0 : {
		. =3D ALIGN(8);
		__start_alloc_tags =3D .;
		KEEP(*(alloc_tags))
		__stop_alloc_tags =3D .;
	}

In the first ld -r pass, input alloc_tags sections from the module's .o fil=
es
are renamed into the output section .codetag.alloc_tags in $@.lineinfo_pre.
When the second ld -r pass runs with -T scripts/module.lds on
$@.lineinfo_pre, there are no longer any input sections named alloc_tags, so
KEEP(*(alloc_tags)) matches nothing and resets both __start_alloc_tags and
__stop_alloc_tags to offset 0 before orphan placement appends
.codetag.alloc_tags.

At module load time, move_module() allocates .codetag.alloc_tags with each
struct alloc_tag.counters initialized to NULL, while codetag_module_init() =
in
lib/codetag.c sees:

	/* Ignore empty ranges */
	if (range.start =3D=3D range.stop)
		return 0;

and skips calling mm/alloc_tag.c:load_module() to allocate per-CPU counters.
The first instrumented allocation in the module then dereferences
tag->counters =3D=3D NULL in alloc_tag_ref_set().

In addition, on arm64, arch/arm64/include/asm/module.lds.h defines:

	.text.ftrace_trampoline 0 : {
		BYTE(0)
	}

which creates a 1-byte writable (SHF_ALLOC | SHF_WRITE) section in
$@.lineinfo_pre during the first link. In the second link with
-T scripts/module.lds, the earlier rule in scripts/module.lds.S:

	.text 0 : {
		*(.text .text.[0-9a-zA-Z_]*)
	}

matches .text.ftrace_trampoline from $@.lineinfo_pre and merges it into
.text. That gives .text SHF_WRITE | SHF_EXECINSTR flags (and grows .text by=
 1
byte), causing module_enforce_rwx_sections() in kernel/module/strict_rwx.c =
to
reject every module load with -ENOEXEC when CONFIG_STRICT_MODULE_RWX is
enabled.

> diff --git a/scripts/gen_lineinfo.c b/scripts/gen_lineinfo.c
> index 7562ac81acca5..d9cc213e65735 100644
> --- a/scripts/gen_lineinfo.c
> +++ b/scripts/gen_lineinfo.c
[ ... ]
> @@ -635,12 +732,728 @@ static void collect_symbol_starts(Elf *elf, unsign=
ed long long text_addr)
[ ... ]
> +static void resolve_covered_sections(Elf *elf,
> +				     struct covered_section *sections,
> +				     unsigned int num_sections)
> +{
> +	Elf_Scn *scn =3D NULL;
> +	GElf_Shdr shdr;
> +	size_t shstrndx;
> +	unsigned long long cursor =3D 0;

[Severity: Medium]
When cursor starts at 0 in resolve_covered_sections(), the first present
covered section in all_sections[] (normally .text) gets sections[0].bias =
=3D 0,
giving it the synthetic range [0, size).

In an ET_REL module object produced by ld -r -T scripts/module.lds, functio=
ns
in sections discarded by /DISCARD/ (such as .discard.*) or discarded COMDAT
groups have their .debug_line DW_LNE_set_address relocations zeroed or
pointed at STN_UNDEF (st_shndx =3D=3D SHN_UNDEF, st_value =3D=3D 0). In
apply_one_debug_reloc(), section_by_index() returns NULL for SHN_UNDEF, so =
no
bias is added and those discarded sequences remain at [0, seq_len).

Won't classify_address() in process_dwarf() then match those [0, seq_len)
addresses against sections[0] and merge discarded line entries into .text?

[ ... ]
> +	/* Pack present sections into non-overlapping bias ranges. */
> +	for (unsigned int i =3D 0; i < num_sections; i++) {
> +		if (!sections[i].present)
> +			continue;
> +		sections[i].bias =3D cursor;
> +		cursor +=3D sections[i].size;
> +		cursor =3D (cursor + 15) & ~15ULL;	/* pad for separation */
> +	}
> +	for (unsigned int i =3D 0; i < num_extra_sections; i++) {
> +		extra_sections[i].bias =3D cursor;
> +		cursor +=3D extra_sections[i].size;
> +		cursor =3D (cursor + 15) & ~15ULL;
> +	}
> +}

[Severity: Medium]
Does (cursor + 15) & ~15ULL in resolve_covered_sections() actually provide a
separation gap when a section's size is 0 or a multiple of 16 bytes?

Because text sections on architectures such as x86_64, arm64, riscv, s390,
and loongarch are commonly 16-byte aligned in size (or 0 bytes when empty,
since covered sections do not require shdr.sh_size !=3D 0 to set present =3D
true), cursor + sections[i].size is already a multiple of 16. In that case,
(cursor + 15) & ~15ULL adds 0 bytes of padding and leaves
sections[next].bias =3D=3D sections[i].bias + sections[i].size.

If an empty DWARF sequence starts at offset 0 of sections[next] (with an
end_sequence row at addr =3D=3D sections[next].bias), process_dwarf() and
classify_seq_end() query classify_address() at addr - 1, which lands at
sections[i].bias + sections[i].size - 1 and misclassifies the row into
sections[i]. Likewise, any non-end_sequence address at offset =3D=3D
sections[i].size lands on sections[next].bias and is classified as offset 0
of sections[next].

[ ... ]
> @@ -1049,16 +1919,19 @@ static void synthesize_symbol_starts(void)
[ ... ]
> -static void deduplicate(void)
> +static void deduplicate(struct covered_section *sections,
> +			unsigned int num_sections)
>  {
>  	unsigned int sym_cursor =3D 0;
>  	unsigned int i, j;
> =20
>  	if (num_entries < 2)
>  		return;

[Severity: Medium]
What happens in module mode if resolve_cu_row_groups() collapses a compile
unit's rows down to num_entries =3D=3D 1 before deduplicate() is called?

In process_dwarf(), sections[sec_id].n_entries is incremented for every raw
DWARF line row before add_entry():

	loffset =3D (unsigned int)sec_off;
	sections[sec_id].n_entries++;

At the end of the compile unit, resolve_cu_row_groups() collapses rows shar=
ing
the same (section_id, offset) and shrinks num_entries =3D j without adjusti=
ng
sections[sec_id].n_entries.

If num_entries is 1 when deduplicate(all_sections, ALL_SECTIONS) is called,
this early return skips both synthesize_symbol_starts() and the loop at the
end of deduplicate() that resets and recomputes sections[k].n_entries from
entries[0 .. num_entries - 1]:

	if (sections) {
		for (unsigned int k =3D 0; k < num_sections; k++)
			sections[k].n_entries =3D 0;
		for (i =3D 0; i < num_entries; i++)
			sections[entries[i].section_id].n_entries++;
	}

When emit_blob() -> emit_section_table() then iterates count =3D
all_sections[i].n_entries (>=3D 2) times, won't it read past num_entries in=
to
stale entries[1 .. count - 1] that were discarded by resolve_cu_row_groups(=
)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102111455.9191=
02-1-sashal@kernel.org?part=3D2
