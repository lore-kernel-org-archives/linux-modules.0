Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.192
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794625914;
	b=G22XkCUjIcAJfTBtQb5SX0dSNmiarT+xrpQ4pLz/152Xm47MhzBJtXTO405qeJPNAYDn
	 tfGWd1FUGNVM3x9Cng5TgLvI2ZeSKRIExvFXv/hZl8X17Nu2TjjNR60bJ7FCQyJXmLudJ
	 IfsVeNpsDFYz5DLjyS38BDdXi+nh88S6Hki6l0NMwSKSm67NceDqkIF9bRWVmvMyXL73+
	 Id2JUjRkiOxkni6jp3V48FpRmYoXL0crnFwXo7jkWd+dVCi7sFhUCmWJs3980bfGDhp0J
	 iIVzR8//f7mIaGeuBxtApiRxIs8YwjcikvmIhOpt/VQCFroM4+Ynp0yWyGnkpTclF4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794625914;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:X-OQ-MSGID:References:
	 Date:Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=SKDUjpEKphEQiCe8fX473i9GylzzWA18uPL5w7bJQ5k=;
	b=yAdpfrDmfTHgVhqFBsEjXPA5UNp+sPBcQ43xCms3LpqcWYKkiKTvM2guoX8v6L+J4N1Z
	 xqkTn9ZAqRSmaW9+Lam3rsnYxL0mweFScBekZqdwFTWFVnBlq8qC3O87p/GEfTlV9mmOS
	 mNzNkm2FRUwt8/yLXDIdr6bAKPaJZ1XvWC3E4fgs1AoP7453GUwY44f2yzuAx+loPN/0G
	 Py7papIa2ZhjLqRs+33gOnp1DWGfgfojxT0h45GBMv/oplaEMFgrLTaaODNUxhAEsL+An
	 YaOSGiwoczlFTuoEFuHfYbbZwma7AAu4lABSUBRcRb36dVzKLyyFU3Rq+Div2wuJVuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=UtceLOQs;
	arc=none smtp.remote-ip=203.205.221.192
Received: from out203-205-221-192.mail.qq.com (out203-205-221-192.mail.qq.com [203.205.221.192])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAFB606A32D
	for <linux-modules@vger.kernel.org>; Sat, 14 Nov 2026 03:11:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EAFB606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=UtceLOQs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794625909; bh=SKDUjpEKphEQiCe8fX473i9GylzzWA18uPL5w7bJQ5k=;
	h=From:To:Cc:Subject:References:Date;
	b=UtceLOQsL/mNzmSPJdb/p4/lB0c+vsDoRWHMA41zz2iyNu5pbJDjY+zljrQOiVLxX
	 ZxYwofMa+2qZlH9NwklVv5pH5l8yXRc0HVGKVx9NooZcc37WklV9BR8HUeuUtWmprq
	 0Tg9W5fcdQUUestjib0Xox1Zkr8Qt/or4cx10wUc=
Received: from [172.18.4.77] ([202.113.185.209])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 2EE05A43; Sat, 14 Nov 2026 11:11:46 +0800
X-QQ-mid: xmsmtpt1794625906ti2qzbzdq
Message-ID: <tencent_4AF4D4976F851143A745D39A286A1FC2A807@qq.com>
X-QQ-XMAILINFO: OPIY/Y5G02yjqnkku2yQD3P32e2mWW0VPdGW0rlHOILM3gfNgU6z/eXWmtDOI7
	 nxTtoHAaylI+tMTZOh2JEOjvfrCQvVEK3c5aoPmpDHBxpwerBdZ0Kl2gc9Vq22hdO66sxJqsqNjD
	 VtFXs/QvQBpM1N89ftc6AX/QpUK8v8N/v65nJlAlMLr7Uqll3eT50OW/YN6LcRDA1BIGZKnGnCLO
	 ikd9qt1w7H9LW5Jkpj4LSe9LRpJzL8NUkWx1JnTlkvdor5Yxa4xQmlZw6NapeLo/zu6MwqdSo/aA
	 6AWWTrJBd3huUmwM/oP5VX4q5HdN+AEWJFnIshLrXiu2BNSN4kql9vZUu2vsZAY0GwGTEckAmQAW
	 B+WZODqWGNKdl+QvHmMe7wB1L+gz2BKZdEYyKuHW/IQfSMCuA3ntLlQ9/1QPFs+5UBBR7AS0J8H1
	 kFO+yWAi9Xwm4wexkDHdqHSG9QMHswLeXTxsJK6yu0k6gxL5Audsy2y54ceLJYBu3g2r+9C6JgS1
	 2Idrv0dQQuiliIR1IDWLMjwxDl2qzOEbDi1LT5li4dTkrfdLLQJUnfzUBFDj6vrKrmFef7xauhJR
	 XC0YSCgCBdVCc3rqw6hDcHBskqOYlrtf/n3Q5iKSy7rmp2pHxNe3YWIiGWZ3PKHWH+0yrOvf7Aku
	 mxHr6chTcTY0Q3ohVXn46XxZx/7WJPxMiH5RimRqMNzNKERKgLgSfVdjOU0g8CStbkKLI5/WR+zh
	 bbb4WIXKoGBIwAQkNdSPgeyywbTrNPfQ8+Zj9vZtNxb8aU2LrIVH8u9OiLrmVN11Ig1xt1TQHeCJ
	 BWpHe+7CbeA+mfVhorY/pmN0D3kia71lIUNrWkDgqeTCQK6qQe61ZLswW1e6sT2kslkPoY+M2+sg
	 Pk58BcFAEOxo3mGcYqiI2eYJ8Z2+xw4bQWcp4LgCQUcoj9NiC68B6XJofmi2NBAXYVRHOqhNVsu2
	 M+lp9x52LRgojuiocqK7XFOcjLx/WLfkCo6GM333Uz60mO7Vka0UVFPSwVc9SIjT6MB/xqCSyRs/
	 AVDMoQ3GoP+ls/VfNeI6xyE76bCCDWP/oRtK2ksB0iAt5wLW5MuQUd5BqAKXhzm+/4unJHdA==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: Guikun Yang <yangguikun19@qq.com>
To: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [Bug report] x86-64 apply_returns() decodes attacker-controlled
 addresses from unvalidated .return_sites entries - wild read on module load
X-OQ-MSGID: <x86-return-sites-wildread-20261114@qq.com>
References: <mod-r-offset-oob-20261113@qq.com>
 <srcu-struct-ptrs-wildwrite-20261114@qq.com>
Date: Sat, 14 Nov 2026 16:00:00 +0800
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
To: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
    Ingo Molnar <mingo@redhat.com>,
    Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
    Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
    Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
    linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [Bug report] x86-64 apply_returns() decodes attacker-controlled
 addresses from unvalidated .return_sites entries - wild read on module load

Hi Peter, Ingo,

The .return_sites section of a module is consumed by apply_returns()
without any validation of the computed addresses. Each entry is an s32
relative offset whose final value is fully attacker-controlled via the
R_X86_64_PC32 relocation addend (that relocation path has no overflow
check either), and the decoder dereferences the resulting address
byte-by-byte inside init_module() - a wild kernel read, deterministic,
KASLR-independent.

  BUG: unable to handle page fault for address: ffffffff402000e7
  Oops: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN NOPTI
  RIP: 0010:insn_get_prefixes.part.0+0xc1/0x14c0
  RBX: ffffffff402000e7   (the forged site pointer)
  Call Trace:
   insn_decode
   apply_returns
   module_finalize
   load_module
   __do_sys_init_module

The faulting address is the module's .return_sites location plus the
forged s32 - pointing into the unmapped hole below the kernel image.

## The path

module_finalize() hands the section over verbatim
(arch/x86/kernel/module.c):

  if (returns) {
          void *rseg = (void *)returns->sh_addr;
          apply_returns(rseg, rseg + returns->sh_size);
  }

apply_returns() computes and decodes without any bounds check
(arch/x86/kernel/alternative.c):

  for (s = start; s < end; s++) {
          void *dest = NULL, *addr = (void *)s + *s;
          struct insn insn;
          ...
          ret = insn_decode_kernel(&insn, addr);   /* wild read */

insn_decode_kernel() expands to insn_decode(..., MAX_INSN_SIZE,
INSN_MODE_KERN); the buffer length only bounds the decoder's own
15-byte window, not the validity of the address. insn_get_prefixes()
fetches bytes with get_unaligned() one at a time from that address.

## How the s32 becomes attacker-controlled

objtool emits .return_sites as zero bytes plus R_X86_64_PC32
relocations against .text symbols. __write_relocate_add() handles that
type as:

  case R_X86_64_PC32:
  case R_X86_64_PLT32:
          val -= (u64)loc;
          size = 4;
          break;

with no overflow check (R_X86_64_32/32S have one; PC32/PLT32 do not).
Modifying one r_addend in .rela.return_sites therefore controls the
s32 that ends up in the section - the write target bytes are already
zero, so nothing else in the file needs to change.

## Impact: not only a crash

The decode-failure and thunk-mismatch paths both print kernel memory
from the wild address:

  WARN_ONCE(dest != &__x86_return_thunk,
            "missing return thunk: %pS-%pS: %*ph",
            addr, dest, 5, addr);

That %*ph dumps five bytes read from the attacker-chosen address into
the kernel log. A local user who can read dmesg gets a five-byte
peek at any address within +/-2GB of the module's .return_sites
per load attempt - a repeatable kernel-memory disclosure, in addition
to the deterministic page fault.

## apply_retpolines() is the same pattern

The sibling consumer (arch/x86/kernel/alternative.c) is identical in
shape:

  for (s = start; s < end; s++) {
          void *addr = (void *)s + *s;
          ...
          ret = insn_decode_kernel(&insn, addr);

and is reachable the same way through .retpoline_sites. Both should
be fixed together.

## The fix has an in-tree precedent in the same call sequence

callthunks_patch_module_calls() processes .call_sites in the same
module_finalize() path and already validates exactly this class of
address (arch/x86/kernel/callthunks.c):

  static __init_or_module void patch_call(void *addr, const struct core_text *ct)
  {
          ...
          if (!within_coretext(ct, addr))
                  return;

with ct built from mod->mem[MOD_TEXT]. The suggested fix mirrors it
for .return_sites and .retpoline_sites - reject any computed site
address outside the module's text before decoding:

  struct core_text ct = {
          .base = (unsigned long)mod->mem[MOD_TEXT].base,
          .end  = (unsigned long)mod->mem[MOD_TEXT].base + mod->mem[MOD_TEXT].size,
  };
  for (s = start; s < end; s++) {
          void *addr = (void *)s + *s;
+         if (!within_coretext(&ct, addr))
+                 continue;

This is the third report in this series of unvalidated module
section contents (relocation r_offset <mod-r-offset-oob-20261113@qq.com>,
SRCU pointer section <srcu-struct-ptrs-wildwrite-20261114@qq.com>);
callthunks shows the loader already knows how to bound this class of
address - apply_returns/apply_retpolines are the paths it was never
applied to.

## Reproducer

Carrier is a real xt_mark.ko built from the same tree as the test
kernel. A single entry of .rela.return_sites has its r_addend changed
by 0x80000000; nothing else in the file differs. Same boot:

  1. load original xt_mark.ko    -> init_module returns 0
  2. unload                      -> 0
  3. load the modified module    -> the Oops above

The synthesizer (with sanity checks on sh_link/sh_info/entsize/
relocation type/target-zero), the A/B pair and the serial log are
available on request.

Tested on 7.3.0; arch/x86/kernel/alternative.c and module.c are
unchanged in mainline as of 2026-11-14 (both fetched and compared
byte-for-byte).

Thanks,
Guikun Yang

