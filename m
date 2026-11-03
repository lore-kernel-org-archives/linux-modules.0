Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704527;
	b=zBOSFI8ehxgLkJOwGRzbemQtvgKxtKdO738KXDBxCgb60cXABLuP4gSWkHWjIYp/1w8w
	 ie+xjHVD5ojNaU5drQdAsCOEySLBoD1tsoLhE3IYWfBz9AoaZG/rY545idyne6I1VsjRm
	 SSwAR3QdNwRBLlUnXGz7XjE38BSkG4dCahsQwTE/i5a0FVVGLw1PxBFvx9vMfOqDF+Aaw
	 Og6NZsG52EpC+3CmZFFEdhbPhYKqgWUeBhcj39Jt/VaLvrLQ/pELq1+M/IbceVOZHUuXw
	 xHiM7a5d1tzRIPzHzD857SEzRhRFizA8AppKRk+Bxw32b+OxmrHdjxB7/ToWoO256+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704527;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ALkPeRJ+xleR0HGQMfumvenGwhBrJI4/wqiBOXoCqKg=;
	b=lDEIxIVX6eueLmlZS3VevJ90kUdLx5LSP6aWbFDR+8NxxQp1NBd8+U/smewCQavfDNzx
	 UTv+IcFprLcGoR9Eu8PWLmYJ7Us8BRsdcIKMQ+GHhz/RD5sW1M/Kg4VsVIw1agpKFid2+
	 +L3BuDfPk3kjbap6UIkSVCVR68Bn74jLuBWMc2vvbsjQzVseOrOhCn0lg0ZNygKqN7u4b
	 kWPG93XYY4mNU7J0BU8PA97YGGq2aSCClxbLsVx+5yNww974FGmxKbUftWQ2AbnILtZoh
	 T+WH3G5gujKilmO5G94NaXfZgJt+adggyOKBpDgaOt1/31GuzY8fYs2Y11BfjtIeLbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XpBK+jTV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A198606BA5B;
	Tue,  3 Nov 2026 11:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XpBK+jTV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA02F1F000C1;
	Tue,  3 Nov 2026 11:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793704526;
	bh=ALkPeRJ+xleR0HGQMfumvenGwhBrJI4/wqiBOXoCqKg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XpBK+jTVgC9KXQsCuKhEsYmvZlZFq9d3DcafxFYcMTkxBRd9O/qPYvp4xr6gn5qYw
	 7YfS/8XuXogeCyFsQg88ZtMUCqgDP15RTAAn8IDRcCVG51XzST9y+GiY0HnlMuMkwF
	 SdljwqazI4SKAsEouXBlICby0GAz4BIgtvwXocuQeNdknctOMmAn/9YLaniWNyCks9
	 14cOW3U6yZAlXX6dT9UpTZQPnlcUyyOrAJSvlwHa/r2F7dnEz4+AsVwGSuxkA4m/kj
	 FYjGSWFANrP6w1UGYbNfszteu6fKBqaQHK3TIIf7LwOkvB/Y1sYM31nnUUpvhuk6Gk
	 qq7ta+CRiakoQ==
Message-ID: <sashiko-outbox-195130@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 1/4] kallsyms: embed source file:line info in kernel
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
In-Reply-To: <20261102111455.919102-2-sashal@kernel.org>
References: <20261102111455.919102-1-sashal@kernel.org>
 <20261102111455.919102-2-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 11:15:24 +0000
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
- [Medium] kallsyms: gen_lineinfo excludes STT_NOTYPE and unsized symbols i=
n sym_starts
- [Medium] kallsyms: collect_symbol_starts() includes SHN_ABS and mapping s=
ymbols
- [Medium] kallsyms: line-0 entries overwrite valid coverage in deduplicate=
()
- [Low] scripts: missing libelf in pkg-config query for gen_lineinfo in Mak=
efile
--

commit 939ac5438a3c14ba3c356cc9994f3c7b50467285
Author: Sasha Levin <sashal@kernel.org>

kallsyms: embed source file:line info in kernel stack traces

This commit adds CONFIG_KALLSYMS_LINEINFO and a host tool
(scripts/gen_lineinfo) to extract DWARF .debug_line address-to-source-line
mappings into vmlinux .rodata so stack traces include (file:line)
annotations.

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

[Severity: Low]
Should HOSTCFLAGS_gen_lineinfo.o and HOSTLDLIBS_gen_lineinfo in
scripts/Makefile query pkg-config for both libdw and libelf?

scripts/gen_lineinfo.c directly includes <elf.h> and <gelf.h> and calls
libelf APIs in main(), collect_symbol_starts(), and find_vmlinux_sym()
(such as elf_version(), elf_begin(), elf_nextscn(), gelf_getshdr(),
elf_getdata(), gelf_getsym(), elf_strptr(), elf_errmsg(), elf_errno(), and
elf_end()).

In elfutils, libdw.pc lists libelf under Requires.private rather than
Requires. When pkg-config is installed on the host, running:

  $(HOSTPKG_CONFIG) --libs libdw

succeeds with exit status 0 and outputs only -ldw, which prevents the
"|| echo -ldw -lelf" fallback from running. On toolchains that default to
--no-copy-dt-needed-entries where libdw.so is a symlink to libdw.so.1
rather than a linker script, linking scripts/gen_lineinfo can fail with
undefined references to the libelf symbols.

Would querying "$(HOSTPKG_CONFIG) --cflags libdw libelf" and
"$(HOSTPKG_CONFIG) --libs libdw libelf" avoid this build failure?

> diff --git a/scripts/gen_lineinfo.c b/scripts/gen_lineinfo.c
> new file mode 100644
> index 0000000000000..7562ac81acca5
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
> +			text_starts[i - 1].size =3D text_starts[i - 1].offset ?
> +						  text_starts[i].offset -
> +						  text_starts[i - 1].offset : 0;

[Severity: Medium]
Can unfiltered ELF symbols in collect_symbol_starts() in
scripts/gen_lineinfo.c corrupt the symbol extents in text_starts[]?

In collect_symbol_starts(), every STT_FUNC and STT_NOTYPE symbol in
SHT_SYMTAB whose st_value falls in [text_addr, text_end_addr) is added to
text_starts[] without checking sym.st_shndx or the symbol name:

  - SHN_ABS symbols (such as __kcfi_typeid_* hashes) whose values happen to
    fall in [text_addr, text_end_addr) are included.
  - Architecture mapping symbols ($x, $d on arm64/arm/riscv/loongarch) and
    assembler local labels (.L*) are included.

When the loop at the end of collect_symbol_starts() backfills sizes for
unsized entries:

	for (unsigned int i =3D 1; i < num_text_starts; i++) {
		if (!text_starts[i - 1].size)
			text_starts[i - 1].size =3D text_starts[i].offset -
						  text_starts[i - 1].offset;
	}

an internal .L* or $x label inside an unsized assembly routine truncates
that routine's extent at the first internal label, while an unsized mapping
or SHN_ABS symbol at a sequence boundary is given a non-zero size reaching
to the next symbol, which can cause starts_new_sequence() and
resolve_cu_row_groups() to misclassify DWARF sequence boundaries.

Additionally, why does collect_symbol_starts() exclude STT_NOTYPE and
unsized symbols from sym_starts[]?

At runtime, __sprint_symbol() -> kallsyms_lookup_buildid() resolves symbols
using the kallsyms table, which includes STT_NOTYPE code symbols and
unsized assembly labels (such as Clang .cold subfunctions, SYM_CODE_START
routines, SYM_INNER_LABEL entry points like entry_SYSCALL_64_after_hwframe,
and CONFIG_PROPELLER_CLANG basic-block symbols), and passes sym_start to
kallsyms_lookup_lineinfo():

	if (lineinfo_addrs[low] < min_offset)
		return false;

Because collect_symbol_starts() skips GELF_ST_TYPE(sym.st_info) !=3D STT_FU=
NC
when populating sym_starts[] and never backfills zero sizes in
sym_starts[], synthesize_symbol_starts() skips those symbols (or rejects
st_size =3D=3D 0 at "if (end <=3D start) continue;") and deduplicate() sets
at_symbol_start =3D false at their start offsets. Any frame inside those
symbols before a new file:line transition will then fail the min_offset
check in kallsyms_lookup_lineinfo() and lose its annotation.

[ ... ]
> +static void synthesize_symbol_starts(void)
> +{
> +	unsigned int base_entries =3D num_entries;
> +	unsigned int cursor =3D 0;
> +
> +	if (!base_entries || !num_sym_starts)
> +		return;
> +
> +	sort_unique(seq_ends, &num_seq_ends);
> +	qsort(asm_spans, num_asm_spans, sizeof(*asm_spans), compare_asm_spans);
> +
> +	for (unsigned int i =3D 0; i < num_sym_starts; i++) {
> +		unsigned int start =3D sym_starts[i].offset;
> +		unsigned int end =3D start + sym_starts[i].size;
> +
> +		while (cursor + 1 < base_entries &&
> +		       entries[cursor + 1].offset <=3D start)
> +			cursor++;
> +
> +		if (entries[cursor].offset > start)
> +			continue;	/* nothing covers this symbol */
> +		if (entries[cursor].offset =3D=3D start)
> +			continue;	/* already has its own entry */
> +		if (seq_end_between(entries[cursor].offset, start))
> +			continue;	/* coverage stopped before here */
> +
> +		if (end <=3D start)
> +			continue;	/* size overflowed */
> +
> +		/*
> +		 * A row reaching over a symbol with none inside it is padding
> +		 * or a split-out fragment in C, carrying the line of whatever
> +		 * it came from.  In assembly it is one macro expanding to a
> +		 * function per invocation, which the row does describe.
> +		 */
> +		if (!in_asm_span(start) &&
> +		    (cursor + 1 >=3D base_entries ||
> +		     entries[cursor + 1].offset >=3D end))
> +			continue;
> +
> +		add_entry(start, entries[cursor].file_id, entries[cursor].line);
> +	}
> +}
> +
> +static void deduplicate(void)
> +{
> +	unsigned int sym_cursor =3D 0;
> +	unsigned int i, j;
> +
> +	if (num_entries < 2)
> +		return;
> +
> +	/* Sort by offset, then file_id, then line for stability */
> +	qsort(entries, num_entries, sizeof(*entries), compare_entries);
> +
> +	synthesize_symbol_starts();
> +	qsort(entries, num_entries, sizeof(*entries), compare_entries);
> +
> +	/*
> +	 * Remove duplicate entries:
> +	 * - Same offset: keep last.  Earlier rows at that address cover no
> +	 *   bytes, so the final one is what describes the instruction, and
> +	 *   it is what addr2line reports.  For an inlined call that is the
> +	 *   inlined body rather than the call site.
> +	 * - Same file:line as previous kept entry: redundant for binary
> +	 *   search -- any address between them resolves to the earlier one
> +	 *
> +	 * Entries sitting on a symbol start are exempt from the second rule:
> +	 * they are the only thing standing between that symbol and the
> +	 * kernel's boundary check.
> +	 */
> +	j =3D 0;
> +	for (i =3D 1; i < num_entries; i++) {
> +		bool at_symbol_start;
> +
> +		if (entries[i].offset =3D=3D entries[j].offset) {
> +			/*
> +			 * Rows from different compile units can share an
> +			 * address, and coverage is their union: a real
> +			 * location beats another unit's no-coverage marker.
> +			 * Within one unit resolve_cu_row_groups() has already
> +			 * picked the row that describes the address.
> +			 */
> +			if (entries[i].line || !entries[j].line)
> +				entries[j] =3D entries[i];
> +			continue;
> +		}
> +
> +		while (sym_cursor < num_sym_starts &&
> +		       sym_starts[sym_cursor].offset < entries[i].offset)
> +			sym_cursor++;
> +		at_symbol_start =3D sym_cursor < num_sym_starts &&
> +				  sym_starts[sym_cursor].offset =3D=3D entries[i].offset;
> +
> +		if (!at_symbol_start &&
> +		    entries[i].file_id =3D=3D entries[j].file_id &&
> +		    entries[i].line =3D=3D entries[j].line)
> +			continue;
> +
> +		j++;
> +		if (j !=3D i)
> +			entries[j] =3D entries[i];
> +	}
> +	num_entries =3D j + 1;
> +}

[Severity: Medium]
Can line-0 end_sequence entries overwrite valid source coverage in
synthesize_symbol_starts() and deduplicate() in scripts/gen_lineinfo.c?

There appear to be three ways a line-0 entry can clobber a valid line entry
across compile units:

1. deduplicate() calls synthesize_symbol_starts() before collapsing
same-offset entries across compile units. When an earlier CU emits a valid
row (line > 0) at offset X and a later CU emits an end_sequence row
(line =3D=3D 0) at the same offset X, the line-0 entry has a higher seq and
sorts last at offset X. In synthesize_symbol_starts(), the cursor loop:

	while (cursor + 1 < base_entries &&
	       entries[cursor + 1].offset <=3D start)
		cursor++;

advances to the last entry at offset X, picking the line-0 entry instead
of the valid line entry.

2. In process_dwarf(), every sequence end passed to record_seq_end() also
emits a line-0 entry into entries[] at that same offset. Because cursor in
synthesize_symbol_starts() stops at the largest entry offset <=3D start,
there can never be a sequence end strictly between entries[cursor].offset
and start without a corresponding entry in entries[] that would have
advanced cursor to it. Thus seq_end_between(entries[cursor].offset, start)
never triggers, and because synthesize_symbol_starts() does not check
whether entries[cursor].line =3D=3D 0, a line-0 sequence-end entry at
entries[cursor].offset gets copied to start.

3. In deduplicate(), same-offset union resolution is interleaved with
adjacent (file_id, line) deduplication. Suppose entries[j] is at offset A
with (file_id=3D1, line=3D10), and at offset B > A (not a symbol start) CU1=
 has
(file_id=3D1, line=3D10) followed by CU2 having an end_sequence (file_id=3D=
0,
line=3D0) at the same offset B:

  - For CU1's entry at offset B, entries[i].offset !=3D entries[j].offset,
    and since (file_id, line) matches entries[j], the loop hits continue
    without updating entries[j].offset to B.
  - For CU2's line-0 entry at offset B, entries[i].offset (B) !=3D
    entries[j].offset (A), so it misses the "if (entries[i].offset =3D=3D
    entries[j].offset)" union check and is appended as a new entry at
    offset B with line 0, cutting off valid coverage from offset B onward.

Would collapsing same-offset entries across CUs in a separate pass before
running synthesize_symbol_starts() and before collapsing adjacent
identical (file_id, line) entries (and checking entries[cursor].line !=3D 0
in synthesize_symbol_starts()) avoid losing coverage here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102111455.9191=
02-1-sashal@kernel.org?part=3D1
