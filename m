Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9383A1B5;
	Sun,  9 Aug 2026 13:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786281524; cv=none; b=J9DCUZFsXq0FydqOOXgWW7IAg6ijINfM13LcAYBkAJpgBF7LfrU81FMcI2EWUeDEc6NCmHIdH9bd1stqsNqCkpq0Vu/sxhh/ekQ56pbsTeQaRI888+yYT+0LEmq5eSbm2ZG6Yt55Ee8Y767eVtIrmjdaD5ebygS23dqHn31XDxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786281524; c=relaxed/simple;
	bh=RbI5cHwi3/xUzdTwEJrUiwIJlYr/Ej7Y3eZKrU4zXk4=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=UG7UUFx34me/1GhMrZTcGeCMrNmdtxAr59SjfYDxtckhue0hdCk9AU0tfJHNkGdrB1hISG1h/qg9hAxnDIWt+w//KHyhbW44tHpWWAbG+fsmTHPUYl8YZi103UO6iEf2KAju/ocADbGutA4/xZnkB6b7yTp4UxR0lyANmvDoLyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=G+5gdbcy; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="G+5gdbcy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1786281490; bh=HoGgwajY1wRBOE328Xguym2+i0Le2B1Od7bQc5QEe/g=;
	h=Date:To:Cc:From:Subject;
	b=G+5gdbcyFPfm8UJEK65Q2cZVW31e0ReL6kkX4BuUAnf5BbrlNvvQ3ERNI1L6LyZtw
	 /L4/W3RVMaLvREfgg5BArCxPQM6vtBw3e0+qByMzxYrWdRYTvn+vqZ7+cEv9mzB5QS
	 MfTY0XEE3i9nzDPn2iFXKKOjjK/ULZqSuBLKdICo=
Received: from [IPV6:2409:8a00:7894:a160:3949:d046:3341:37f5] ([2409:8a00:7894:a160:3949:d046:3341:37f5])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 4898803E; Sun, 09 Aug 2026 21:18:09 +0800
X-QQ-mid: xmsmtpt1786281489txrrraycp
Message-ID: <tencent_50EC6C61A627B5205BC10B416C2A14DA9B05@qq.com>
X-QQ-XMAILINFO: Nte9/BsRzcszI6lekCPxtpRPCCUXFB+deQMAoqpLq1eI4Ohs6vy5V8PPUlhTR8
	 lHmB9Vy0TPIdJ654KzGvvKqFB2YtmXHxOyXzyPF+yHgOdfkT8D8iiNew8LQ3MpEzeFU5gjueodi8
	 uRJYZ4pGNp5oz9W9jHrnYS12V6mM6nS217AjUzsERN/m9MieNg83c6duJ24xbq9yFV7USI1kJbWt
	 HJbNkrh1MxA2JMU06tYUP+ECDbPqJ66TT5GS90DlbwehW9gy39e+PKL3vW3Zc5YJNnOPtk1ugekS
	 lCADF83qtnjDJGse4JZGtbI56Ih1YTIevgqwE+6OVRl2WcX2h9g6pkRaN8HIPIBY+6cD5sAbUJVZ
	 OSOlDFXBe372iDxAR1v2zZWUp1SK99PGkWP5z0po1z49QMbfCFvJYl501owKCr3VG/bDn83Rwhr6
	 871qm9fl4WCKtpVKEFKgvdjGWFe+OHNuIfuZHwwy1qEpM8o1HoTJTmESjZTszcTDzO+0oX12GRzb
	 cuZSNd7d/AjG+8VhIXe9pRAkibUTkw2iH8gofM85ZSr89S1r3vZhmVTqN3rU6oUaVwRXuPBs884r
	 7FeHKsdrIeQd9ZqQdBTUJXKjiQZYL/7HZWpB/NXNGU5tnAyNHaPyI85brOZFHltXfhD4J7o+3dvl
	 KWnfS2zKwzbFSaGl+DprCuJKzPeF5i0PhK79bURtitexFlU/ihGa7/P2t3llEmDlD+6J8VGwXqpz
	 Tk1OkCd6H1VmU9nx7soi9ARmabrFLhbxlC1SB3xZ/rjGA+cWglgHx+rSALG+VTIgbQ0UBy1707Q2
	 /yKq7WcFeCpTdYdMO5L9edtdQZ2Yq2y8tOl+CBquWHgQeAJ9U6LvqBN0/bBVH81A01mS5k2bq2aS
	 U4eqdn/9Pq881Ata1IplTUw1t2yfa6rLlLylCfET2HtGB9syWeLLaG1PJ7MEacvL8/LyPO3zRX0q
	 j8v3ZG9j3cBOJ+TXltqgOw1ePUuehVVwAHuh9Z4jWgmiSDYv4Yvb5dGpxN+KxvgrNTWz26spdMMX
	 y8gmJMyjqFqXWvOx8As0ih+ncdkIuH8UJAXD48UP7s5R/D5bwkuqghGFJJ4MPPtOuvkcjqPl9LmK
	 OTdWhuYmibEAB61TA=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-OQ-MSGID: <b9ca55c4-753f-4241-806f-dd68db9ec62b@qq.com>
Date: Sun, 9 Aug 2026 21:18:09 +0800
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
From: Yang Zi <2959243019@qq.com>
Subject: [BUG] KASAN: wild-memory-access in idempotent (concurrent
 finit_module) [dw_xdata_pcie] [syzkaller]
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

While fuzzing the kernel v7.1 with syzkaller (KASAN), we triggered a
wild-memory-access in the module-loading de-duplication helper. Concurrent
`finit_module` calls pass `file_inode(f)` as the `cookie` into `idempotent()`,
which traverses the shared `idem_hash` hlist; under an fd/close race the inode
can be released and reused, turning the cookie into a non-canonical address that
is dereferenced during the list walk.

Reproducer summary (see attached report/log):

    BUG: KASAN: wild-memory-access in idempotent kernel/module/main.c:3682 [inline]
    BUG: KASAN: wild-memory-access in idempotent_init_module kernel/module/main.c:3788 [inline]
    BUG: KASAN: wild-memory-access in __do_sys_finit_module kernel/module/main.c:3815 [inline]
    BUG: KASAN: wild-memory-access in __se_sys_finit_module+0x145/0x410 kernel/module/main.c:3799
    Read of size 8 at addr 8000000053120fff by task modprobe/1106

    Oops: general protection fault, probably for non-canonical address
    0x800000005...: 0000 [#2] SMP KASAN NOPTI

The trap compares `existing->cookie` against `cookie` by dereferencing a
corrupted hlist node pointer (`cmp %rbx,0x0(%r13)`). The second-order crash is
in the `igbvf` driver probe path, i.e. the same concurrent load/probe had
already corrupted memory, eventually escalating to BAD_PAGE / DIE.

Root-cause hypothesis: `idempotent()` relies on the lifetime of `cookie`
(= the inode from `file_inode(f)`), but a concurrent `close()` / fd reuse can
free and repurpose that inode while the hlist traversal still holds a stale
pointer to it — classic use-after-free, here manifesting as a wild read on a
non-canonical address.

The crash report attached below:

BUG: KASAN: wild-memory-access in idempotent kernel/module/main.c:3682 [inline]
BUG: KASAN: wild-memory-access in idempotent_init_module kernel/module/main.c:3788 [inline]
BUG: KASAN: wild-memory-access in __do_sys_finit_module kernel/module/main.c:3815 [inline]
BUG: KASAN: wild-memory-access in __se_sys_finit_module+0x145/0x410 kernel/module/main.c:3799
Read of size 8 at addr 8000000053120fff by task modprobe/1106

CPU: 0 UID: 0 PID: 1106 Comm: modprobe Tainted: G      D W  O        7.1.0 #2 PREEMPT(lazy) 
Tainted: [D]=DIE, [W]=WARN, [O]=OOT_MODULE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xa2/0xd0 lib/dump_stack.c:120
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 idempotent kernel/module/main.c:3682 [inline]
 idempotent_init_module kernel/module/main.c:3788 [inline]
 __do_sys_finit_module kernel/module/main.c:3815 [inline]
 __se_sys_finit_module+0x145/0x410 kernel/module/main.c:3799
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14b/0x490 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9cebcc325d
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8b bb 0d 00 f7 d8 64 89 01 48
RSP: 002b:00007ffc05413188 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
RAX: ffffffffffffffda RBX: 0000557fbb772ce0 RCX: 00007f9cebcc325d
RDX: 0000000000000000 RSI: 0000557faa18ae52 RDI: 0000000000000003
RBP: 00007ffc05413240 R08: 0000000000000040 R09: 0000000000000002
R10: 00007f9cebd9fb20 R11: 0000000000000246 R12: 0000557faa18ae52
R13: 0000000000040000 R14: 0000557fbb772c50 R15: 0000000000000000
 </TASK>

Regards,
Yang Zi

