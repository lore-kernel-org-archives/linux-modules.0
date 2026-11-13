Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794578991;
	b=i5PpsodkYA+z/TGzwVL1C+vnJTzTnX4inxayhSW0q01iOSXM03dSWa20dRsi9Swyiqp1
	 N5jk5ZnWO1pBIGHiZ4Dc9NQmugAULEn2AIRMyVpwSAGVW42tkYujOdXzZjHWSNz5yIYnr
	 2tg95jbQbBsDAwDCdPMnOFWJJcaKgpu8RRo87FNR1ieru9JaZ/PlEu9ru/6/73ce00EXk
	 fwIfjAY9n7gaQcQ3w5/I2L/1MeO1Zl5tUkxiQ0UDku6ReMoDAto2z+qEY0bqs01YObdmy
	 GaMyleQW9Yy20vbcD2AfXD6C2Jopzvi36O2/oUC0KhFCVtG++ioz+71wxJZjyf8pDDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794578991;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:X-OQ-MSGID:Date:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=bAL0mG7gDM0Ds4mwj8nZj0AtHGkdJ+5sP2blMTQt1jA=;
	b=TTHvdmMTnGVEyU6cHUnIIlX7zxkGCe/D40kgm6hF+bGXMFnKmvcdZXr93xOJy+pOryZY
	 koQlVqQUN8MSaY1lih4PpSqQZKcEr2Ufk9if6qiUVZrc1DDJaCe/ALuHATyS8IVAWXDPK
	 RTu0xIfs8wflFcnY2bEmVq/N69xDmvTJ1mGPxEM8qyQlPmh7AomZArh7p1Fc+7jrMXJKU
	 MLi5pTGQP8+FEZyX8mJUdYCiq2E4XGm6RTnmwA2Zsaz2LJwlbYfY6Q2Mu1RJgyLZTeiVX
	 vRstYd/97UyzOm6YdFSJmLKqfd12Xg5brf/SQCrcYU4n+VX7k4JnJq/1Zv4u20v6cTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=emFOdmK1;
	arc=none smtp.remote-ip=203.205.221.149
Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23514606A32E;
	Fri, 13 Nov 2026 14:09:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23514606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=emFOdmK1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794578981; bh=bAL0mG7gDM0Ds4mwj8nZj0AtHGkdJ+5sP2blMTQt1jA=;
	h=From:To:Cc:Subject:Date;
	b=emFOdmK1wpaeWv4vxDtWixwyL5bqDFRhmA5YbZnPm9cuADLfsUA6QlDmZ7CegpAU5
	 6mWJ9veZNQ++ZSECnN5VeFh/sFz5hjR7FlEKCo95V80eG7bCAnSOhlrmMgZQEZ/4Kz
	 FvmjwgnzjtmUq/l3yLxaTf7/qhzB+VGUq/2SNNFI=
Received: from [172.18.4.77] ([202.113.185.209])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 2668D40C; Fri, 13 Nov 2026 22:09:38 +0800
X-QQ-mid: xmsmtpt1794578978tyc0xg9qc
Message-ID: <tencent_3088A959D4B80F725457EAC737C488ABD306@qq.com>
X-QQ-XMAILINFO: NC4p7XQIBeahJNh9TIiqCTt1EqrLWJ0DItzm73BWZg/6vMQutgNqMe6pr9wIaL
	 k9v4f3/nFdZWCSd/DlrAijMOipUCW/jOUIvJNi2yJOEynstjqPf5J2fIRTyeopMj4wk+NTZjAWiM
	 SqI4Mrow/ldJNVZmBMnFn7OJubsNmZon1uZ/QhVAz30EzS3C5FtRM98Tb2b2wbA0uJqZOZh4Ftg2
	 8Uh0RMxDWT0yjOP5r+F6/x618B/xdT5MlzPSl/AjgSn1JC6xBsAyBq2K1/oY2EJVzK8oawyxFTDD
	 w7Tn/FRWWr1lwAdhUbPXIWrQFsLGzqA+7LZUws9BsNUmmZ6jkCiaU+WtVX4fEXD/gQFsZ53Foek0
	 3NB0ONK7qi5RT92In09HvK4FFpUDSwKfCJ823Oden35I0f/Z8V/96G1AegAYaKWvc5I9s2XjDOnZ
	 vUTBcQzFOBhCYBm/XKjlJvtRAXqW2yF2mIzU6BBiqFKsuw7irGXx1lyKkKGVv/NdcyUCiAN47RL4
	 /pTsFOBrRvqgShY8ctDpsOXsubAp7JReasj/gpZCkmM5WNAYT32Cj2Z5vwWpgBZ1g8w5UkyrloE6
	 TrSvz7nKfRYD+dwBvoL23U1t8mU1e0Is684a7bVVIPrGZG+zkANR8tu0p1JDvN8pzefald/UFIdX
	 2HrRTMsweTiPkKTG33qP2unMRm+YrVahLb6IfJ+ZXtqc59aDDGiphWhnPW+zgpHlPEaFpaVJbdwU
	 y2QgutFOV0haWNrneMtI7FqmlAquzxdUhJ9qvZklEIXMq80SxySM4a5KaUESGNgq+ZlQ5h7IO6ot
	 ZP3/th5MBDwUSp+mfRycTpiZ3Mx50p5E18xEUBlSoh5Pcz3UMCT75UlaNYWHMAAiHWun72WPv+vE
	 VVrt3hmBd6n6l13uC4A3SuODxZENs8BT4pl9OkBdE0uXYDXT8ePH9ihQTaDF4GLLVKnegt+wldFj
	 t0JtUgPFiZy3NW0IhIBfly0GeFbdu8cesVL+87CcDMIYwO1+Xkf2JWalCrfGbBHRu2UE+M0k+39R
	 qZSkQ6k8GfBS1HTVbs5uOBiDksOm0tzLkfiwnXmymgWVODd1gkqMbWKMhRhv/cM8BxiNKKAg==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Guikun Yang <yangguikun19@qq.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>,
 Igor Solodrai <ihor.solodrai@linux.dev>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [Bug report] x86-64 module loader: relocation r_offset and symbol
 index are used without bounds checks - OOB write on module load
X-OQ-MSGID: <mod-r-offset-oob-20261113@qq.com>
Date: Fri, 13 Nov 2026 12:00:00 +0800
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

From: Guikun Yang <yangguikun19@qq.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>,
    Igor Solodrai <ihor.solodrai@linux.dev>, linux-modules@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [Bug report] x86-64 module loader: relocation r_offset and symbol
 index are used without bounds checks - OOB write on module load

Hi Luis, Petr, Igor,

Loading a crafted x86-64 module where one relocation entry's r_offset
(or its symbol index) points outside the target section ends in a wild
read and, for a target that is mapped and zero-filled, a controlled
out-of-bounds write. Both the ELF validity check and
__write_relocate_add() itself leave these two fields completely
unchecked. A/B reproducer below.

  Oops: general protection fault, probably for non-canonical address
  0xe00013fff8040000: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN NOPTI
  KASAN: maybe wild-memory-access in range [0x0000bfffc0200000-...]
  RIP: memcmp+0x67/0x1d0
  RDI: 0000bfffc0200000
  Call Trace:
   apply_relocate_add+0x20e
   load_module+0x40f7
   __do_sys_init_module

## The gap

__write_relocate_add() (arch/x86/kernel/module.c) takes the target
address and symbol pointer straight from the relocation entry:

  loc = (void *)sechdrs[sechdrs[relsec].sh_info].sh_addr
          + rel[i].r_offset;

  sym = (Elf64_Sym *)sechdrs[symindex].sh_addr
          + ELF64_R_SYM(rel[i].r_info);

  ...
  if (memcmp(loc, &zero, size))   /* wild read */
  ...
  write(loc, &val, size);         /* val = sym->st_value + r_addend */

r_offset is a 64-bit value from the module file, with no check against
the target section size. r_info's symbol index is likewise unchecked
against the symbol table entry count. apply_relocations() in
kernel/module/main.c only verifies infosec < e_shnum and SHF_ALLOC.

The ELF validity layer does not cover these either:
elf_validity_cache_sechdrs() validates sh_offset/sh_size (file-side,
via validate_section_offset()), and the recent series added checks for
section types and the symbol string table - but nothing bounds the
per-entry r_offset or the symbol index of the relocation entries.

## This is the same pattern that f9d69d5e7b fixed for st_shndx

f9d69d5e7b ("module: Fix kernel panic when a symbol st_shndx is out of
bounds", December 2025) added a bounds check for st_shndx indexing
sechdrs[] in simplify_symbols():

  if (sym[i].st_shndx >= info->hdr->e_shnum) { ... return -ENOEXEC; }

That check is in the current tree. The relocation entries in
__write_relocate_add() index memory the same way (an ELF-controlled
offset into an array base) and are still unchecked:

  simplify_symbols():   st_shndx -> sechdrs[st_shndx]   /* bounded */
  __write_relocate_add(): r_offset -> base + r_offset    /* unbounded */

391e982bfa (2022) already accepted that a crafted module file is a
realistic input ("It is trivial to craft a module to trigger OOB
access"), and the elf_validity_check() series exists precisely to
defend against malformed ELF. The relocation entries are the part of
that input that the validity layer does not reach.

## Impact: more than a crash

The memcmp(loc, &zero, size) / write(loc, &val, size) pair means the
loader reads the target first and only writes if it is zero. With a
non-canonical r_offset this is a deterministic #GP (reproduced). With
a r_offset aimed at a mapped, zero-filled kernel address, the write
lands - val is sym->st_value + r_addend, both attacker-controlled
within the module. Since init_module() can be retried with different
r_offset values, this is a usable probe-and-write primitive against
kernel memory, not just a crash.

## Reproduction

The carrier module is a real xt_mark.ko built from the same tree as
the test kernel (vermagic, this_module size, all 11 undefined symbols
matching), so the only variable is the eight modified bytes
(.rela.text[0].r_offset at file offset 0x17a0, changed to
0xc00000000000 so loc lands in the non-canonical range):

  before: init_module -> 0, delete_module -> 0 (module loads, unloads)
  after:  init_module -> Oops (trace above)

Same-tree build, same boot, single field changed. The A/B pair and
the init_reloc.c reproducer are available on request.

## Suggested fix

In apply_relocations(), before dispatching to per-arch
apply_relocate_add(), verify each entry points inside its target
section and its symbol index inside the symbol table. This covers all
architectures (arm64, powerpc, riscv, s390, loongarch have the same
raw `base + rel[i].r_offset` form):

  for (i = 1; i < info->hdr->e_shnum; i++) {
          ...
          if (info->sechdrs[i].sh_type == SHT_REL ||
              info->sechdrs[i].sh_type == SHT_RELA) {
                  for (j = 0; j < sechdrs[i].sh_size / sizeof(*rel); j++) {
                          /* bounds per entry, arch-dependent size */
                          ...
                  }
          }
  }

or, minimally, a per-arch check at the top of each relocation loop:

  loc_off = rel[i].r_offset;
  if (loc_off > sechdrs[sechdrs[relsec].sh_info].sh_size - sizeof(u64))
          return -ENOEXEC;
  if (ELF_R_SYM(rel[i].r_info) >=
      sechdrs[symindex].sh_size / sizeof(Elf_Sym))
          return -ENOEXEC;

(The minimal per-arch form matches how f9d69d5e7b added the st_shndx
bound locally in simplify_symbols().)

Tested on 7.3.0; arch/x86/kernel/module.c is unchanged in mainline as
of 2026-11-13.

Thanks,
Guikun Yang

