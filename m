Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794591509;
	b=trh4yagNP1x6msQh05T1NrIIvD7wDybEY5DL/UW7R5UVog4niNcEpn7f0qY5YmDC230I
	 CLoapQMAdb5Nwni3M/Phrjr1jm/0opMd39HxHCz+rRnRoSzONWltCqd7NCB8LD91TCHlX
	 kPGIdy6/heqj/0fvdcpABh28/aFpm0w/xAglcRyETc8iL7h6oWf0I0FgN8trhoVN6hcM8
	 jZCNTUcXY/rQQ5xiU162FgVHJwXkeWQKfztjtxC4d6VORkvL7I7ZZP/6mCfXyP/6txk7g
	 Gya+aKoB3bgZ9RnKhq8V0JZZGawnCp/PSn5MAkC0gE+6MVscEX8lKbpzLWg6aTmG4Xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794591509;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:X-OQ-MSGID:References:
	 Date:Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=qTZ9ux48xtnyLLqPljckoZG1ruWNiZxfNGEpJDN1Gho=;
	b=m6pLbNI5Kw3lFdu1iBgz5pYh1iATJ13Qy4AViwY93R/WRF4jxCaQ5YZza+DQ84LW7cxV
	 n+UhzS/0PzkoJAg2cphFPW62K6sDKC0NIKWFKUQChOhmkQJVgee+umw1+84PMo4ZoNFNv
	 3RnByfhfCfobKo+L5Rkl7sZLIdhUeMg+GL++x7AO7QdGFd0HH8hr2n0PMFdy4z7lnvHsh
	 BFUozp56W24IL7adg7DEaA/NTWLDK/X0DFlEVh3Pklkks8ikdqHVkBiANJ8XyrVUA5U/E
	 Wn29SQ+nb8wnzeZkovklB1K8VVbbTm6WsaJEFzZ4woXXw4WK/YMZn92e01EPC2Ig4cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=I3rXUTSU;
	arc=none smtp.remote-ip=162.62.57.64
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833C5607E07B;
	Fri, 13 Nov 2026 17:38:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 833C5607E07B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=I3rXUTSU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794591497; bh=qTZ9ux48xtnyLLqPljckoZG1ruWNiZxfNGEpJDN1Gho=;
	h=From:To:Cc:Subject:References:Date;
	b=I3rXUTSUSjNp43ZLSLjeh609SdERBZew7biK43wUPARBg/P8SxcXdXvZ3rya99d75
	 stjBjlchmf7tNOcmSJZaaEOx4wIAOSMR1CxHcL5eZIIMHHh2v/EpeAw5ulbYOwh2/8
	 hf9sFEvx7uBFXJSPFW/GpC3JIUN4FgFxoKoCyUsA=
Received: from [172.18.4.77] ([202.113.185.209])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 98F14CB0; Sat, 14 Nov 2026 01:38:15 +0800
X-QQ-mid: xmsmtpt1794591495tc9pphd19
Message-ID: <tencent_3923A965DF3923C24E79A60851533EB55108@qq.com>
X-QQ-XMAILINFO: MqswyhUqVe0CnrQE7U8V6aV5rtQ3O/qx64f5RARQ0Tvu5feQguJz4ppgnIrchZ
	 /r5UOoZaPK2gm6tEdPEpr9HrgNgT3c6yN65V9HuWgOcqJ+lLGHPtk3Of8GZWIcDZRMMGYMiRcVRt
	 CiBRoURmHe3Si/GfW4KCb6o/VRETH66D3xDOjT8fK2C8Qtp7RC0frTvTW9XzJA5ZNfg/+zlTSM0k
	 m4KGey+9j7ljQpR2550GAmp9v1Eg+BparFfoGfzoQ3eXh8Jtfdme1Yaeuz50CvJnUej+aoaYshoH
	 S05WnWG8I4iT4IApKKYiz0w3UmH1LtSIn4Yf2Wjm4yoQFASmJPBcXHCp9CE1sxye6Rkgg0d+6wAA
	 7pmVNexJaALrcoCDphDI1qkmUKywqSqOxK6Ig29mfjiLZdEVhg/U4USWr+50SbltppOjzOLLHXir
	 fBAbVwnLFo+Co9HhzsexXXEY0PgtVqNW1UufP8hqeZDSjcMAOhKJWMiiN6cbveZKB9x+nN2qOX2Y
	 fNIIsbqLvbxHdrp9HUWjETFIO2NtcxQ/5xrjY1Z95/WQQgKZ9Gsphx6jNoHBzWEgHZMzx0niyqqk
	 bhQMaRTcGnYLcKDyYUnodzE4qlSfD9jRvZ5oFAASatbUVupl/DjtjAKvg0+IxYyX8yWOrjJgqM2a
	 TqwPGCpEfX6OYShZ0jYnHjS+2hpNt1mSXTVgK+wCkWPl7F55szDopluUfrbB6WX/GwCSodPH6YeN
	 9cgLJVBmtRGoKvAUsPG6sHf5X0ojUg2VV6AJtbp3HqoHrsrKqHtzDO6EAbeGZ1lOJLWdVQwxn7Ej
	 TkNDrHNnpOqF6tMlRwm3Tnp/Z5yCRuQUCVH8HdRwfDrskArrumPM+tPsjE8Bo5Di9Bo6cJ1xMcG8
	 9LlRdOG/6eJD/YVCKUa8m3/0vH7NGjcxfKgpQSrNjFQQLSWSq1YWLNPi/b1+43tcHfG1TjsPwzYp
	 ltJRD+4LHHkr1dOaqb1KH105q+O/NASwpmaMDo7dIubexvZjD7cEV1bu+KBVv6wGAnRW033G4hWs
	 dW1C3V7nr9m+QynxXRHq6FngaVekAG6nM6NaO+qxWi1hyUTPDd
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Guikun Yang <yangguikun19@qq.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 linux-rcu@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [Bug report] srcu_module_coming() dereferences unvalidated
 ___srcu_struct_ptrs entries - wild kernel-memory write on module load
X-OQ-MSGID: <srcu-struct-ptrs-wildwrite-20261114@qq.com>
References: <mod-r-offset-oob-20261113@qq.com>
Date: Sat, 14 Nov 2026 10:00:00 +0800
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
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
    linux-rcu@vger.kernel.org, linux-modules@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [Bug report] srcu_module_coming() dereferences unvalidated
 ___srcu_struct_ptrs entries - wild kernel-memory write on module load

Hi Paul, Luis,

The module loader hands the contents of the ___srcu_struct_ptrs section
to SRCU as an array of absolute struct srcu_struct * pointers, with no
validation of any entry. srcu_module_coming() then writes through each
one during the MODULE_STATE_COMING notification, inside init_module().
A crafted module whose synthetic section contains an arbitrary 64-bit
value therefore gets a kernel-heap pointer written to an
attacker-chosen address.

  Oops: general protection fault, probably for non-canonical address
  0xe00006aaa0000021: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN NOPTI
  KASAN: probably user-memory-access in range
  [0x0000555500000108-0x000055550000010f]
  RIP: 0010:srcu_module_notify+0x480/0x610
  RAX: 0000607f57d191c0   (alloc_percpu return, the value being written)
  RBX: 0000555500000100   (the section entry, verbatim from the file)
  RDI: 0000555500000108   (&ssp->sda)
   notifier_call_chain
   blocking_notifier_call_chain_robust
   load_module
   __do_sys_init_module

## The three pieces

Loader, zero validation (kernel/module/main.c):

  mod->srcu_struct_ptrs = section_objs(info, "___srcu_struct_ptrs",
                                       sizeof(*mod->srcu_struct_ptrs),
                                       &mod->num_srcu_structs);

section_objs() counts entries and returns sh_addr; the bytes' validity
is entirely up to the ELF file.

Generator, absolute pointer (include/linux/srcutree.h):

  struct srcu_struct * const __srcu_struct_##name
        __section("___srcu_struct_ptrs") = &name

Unlike __tracepoints_ptrs (PREL32 self-relative on x86), this is a
link-time absolute address. In a hand-built section the bytes are
whatever the attacker writes, and since no .rela entry targets them,
apply_relocations() never touches them either.

Consumer, write on load (kernel/rcu/srcutree.c, unchanged from 7.3 to
mainline 2026-11-14):

  ssp = *(sspp++);
  ssp->sda = alloc_percpu(struct srcu_data);       /* wild write */
  if (WARN_ON_ONCE(!ssp->sda))
          return -ENOMEM;
  ssp->srcu_ctrp = &ssp->sda->srcu_ctrs[0];        /* second write */

ssp->sda sits at offset 8, so an entry value V makes the kernel write
a freshly allocated percpu pointer to V+8, and a pointer derived from
it to V. The unload/rollback path (srcu_module_going()) dereferences
ssp->srcu_sup and frees ssp->sda through the same unchecked entries.

## Why this is more than a crash

The write value is a kernel heap address and the target is a fully
attacker-chosen 64-bit address. Pointing the entry at a
userland-readable mapping leaks the percpu allocation address directly
to userspace, defeating percpu-base randomization and contributing to
KASLR defeat. Pointing it at any zero-filled kernel address lands the
write. A non-canonical target gives the deterministic #GP above
(reproduced 7.3.0, KASAN inline, DEBUG_PAGEALLOC).

## The fix has an in-tree precedent

jump_label.c validates exactly this class of pointer in the same
module-notification path (kernel/jump_label.c:716):

  if (within_module((unsigned long)key, mod)) {
          static_key_set_entries(key, iter);
          continue;
  }

The suggested fix mirrors it in srcu_module_coming() and
srcu_module_going():

  for (i = 0; i < mod->num_srcu_structs; i++) {
          ssp = *(sspp++);
+         if (!ssp || !within_module((unsigned long)ssp, mod))
+                 return -EINVAL;
          ssp->sda = alloc_percpu(struct srcu_data);

__tracepoints_ptrs and __bpf_raw_tp_map are sibling pointer sections
with the same exposure; a shared check in find_module_sections()
would cover the class, but the SRCU entries are the concrete
write-what-where primitive demonstrated here.

This is the second report in this series: the relocation r_offset
bounds gap went out as <mod-r-offset-oob-20261113@qq.com> yesterday.
Both are cases of the module loader consuming section contents that
its ELF validity layer never checked.

## Reproducer

Carrier is a real xt_mark.ko built from the same tree as the test
kernel (vermagic, this_module size, 11 undefined symbols all
matching). A section synthesizer appends an 8-byte
___srcu_struct_ptrs entry (0x0000555500000100), fixing shstrtab,
e_shnum and e_shoff. Same boot, three steps:

  1. load original xt_mark.ko   -> 0
  2. unload                     -> 0
  3. load synthesized module    -> the Oops above

The A/B pair, the synthesizer and the reproducer are available on
request.

Tested on 7.3.0; kernel/rcu/srcutree.c and the loader path are
unchanged in mainline as of 2026-11-14.

Thanks,
Guikun Yang

