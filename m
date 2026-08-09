Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E982EBB8D;
	Sun,  9 Aug 2026 02:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786242152; cv=none; b=V36qQerfxyxGihzBbxRMu6WhfRyWq5XOl0Eyz0sG4T1PEi7C28hqyAqQseOGS6qKmI99VB10v67bbq8QTguQ4iretUp1WR8917VqxE3XFUyHjQaDb6f1jSj4btd3He40XXbVN1t5QSitRTn0V9yblSNrWoze+CU+ErcSB7KdYo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786242152; c=relaxed/simple;
	bh=P2+6OKAdVZlERr20OM7EWsz6DSfj1vWJeee+zHhDZKQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=NlMjKssf5XtmMLgsKoSeHIDhiEs+V1uNnJgfGl4Yw09ahAJnqUIjzGAtPPmObyEbmhzm+hdJPLgVOTWAUi9zPD78ZO1Ij3IRjvz/y3mKUoB2NU873GIMyRxY69gWWc/thJ8kDWNZg6E0l2Gm+mE9O/vYHzqrl4MmeCX0Lp/kQGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=O2BVWB/Z; arc=none smtp.client-ip=43.163.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="O2BVWB/Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1786242146; bh=sLxsKRTWFGMcFe30cVj/Iwh3P2DyaSCWGlJTnL88NJU=;
	h=Date:To:Cc:From:Subject;
	b=O2BVWB/ZJbA6emQ2bNUmHx4BkYlOHZVfqfmUotksEcbb9upXX+VTHl/B/jUZI5ilu
	 NJ48mssyUHOM2gRBqC3kT8+F/fiO6h6meHF5g39IxfnLxHsCDSxbtjpfOjl5FPDdi2
	 15yLa8L4hHWkUcV4KKYOUIrZivQeB1FPQRirNzNo=
Received: from [IPV6:2409:8a00:7893:9e40:542c:be54:7415:4303] ([2409:8a00:7893:9e40:542c:be54:7415:4303])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 598240EA; Sun, 09 Aug 2026 10:22:24 +0800
X-QQ-mid: xmsmtpt1786242144tv49rj6xa
Message-ID: <tencent_450C6DEA50F6BDD7895845A8A4B7D099CE06@qq.com>
X-QQ-XMAILINFO: ODQfruXGvXma43as21pmC7Lh6FCRZVUcNcOAouBo4wH3luNl0s9DZfb7etbuWz
	 NzYFTK2ZbPrA36KtZs2y/6vAxTlMw+30v+ArfPOeDUH7fZemEL+atz0xD9KFX0PXPvOeiW/A9I2l
	 MjgHCaGUe4YWTEcGlub3SQq0tMB+NsHPIKAI2e2BjMu6wnOcoFyy8JrFIjlBdvcMOJoMBdzbsVpE
	 GzPsrdqfibiHGp/ZxluBZO0iworOceOJRPlfkBPZ0HgBDLZYhs11mlS5c9m8OiEjQgtlX5mE3rkZ
	 uml3rceECc4FV8aqXfO90oAAX8eJgs77LYk7ijRb8cbcBQ+U9z8iBCfw/07zq6mESQoXUrvT7Y9s
	 qNGQqXei839x14gNQSjd9PS4ioYcDdHZIjIJO7U9win9fU6Ajbjx0nYnpaOOZDF7xGfrjzQS+AN4
	 QCqCcT2GJf5huNg45h97NSp1OJXPs3576bA5J3GMVjHTDK0WfIj2YsRPhvEjHvPrTY0S3whd85d5
	 tcqRpQU3ZcUhBwg/bRbk4LZ/7ObZD1094PhCASGvoRPkWBrk0HX5wd88pa74wfkGPbHi8sPXumWl
	 RgQHVsT78i90eRSSjj2DdLFWsVGdOZLLfTjTfnIdR2z867xfcV0gOg3BkZMWPN2qZQX/IsIPZFyA
	 Ynlo8fcERjtD/J6I1+CYRGhnw1rDeok66EW6XiEhjK4W40ouDJf+y6CommqNof9rT844+QrMFdoW
	 rCtzuRExcB46OkeDLb6RPJY1upydCOjyL0gQiFubOzg0KzacSN7IFbnxNMSJlnJbH+egRV6Y/80R
	 IOnq19+6XOpDW27gGu/pzD4xcW27/id1ynXGbwrKZQC7Dk23nfqAYnofRxQNfP4q13ys2lCIc4mN
	 Ebf24wgAtx8jJOcyRrIEJa0BoAuA5jnfbflqq1FRK9/A14HggIWQmG27GXfeBlu+RvncO9B3MeZq
	 WB1C0VCAFNtePB6w3UoZDb0ZFosWStK/Rp+6UlU6Jz9hrLg3OU5ExEcwae+YD9CwiVzqb+57ak3K
	 r7e5zkIX32IrTBEsk3QVD4k2FZeJtgplS7fsSR7DS4JGIdlMioGd4F04zGeTNF5aTpRpokmtL+yz
	 a1Bqmayq9pW+4BgAsBVU0A+JKdZJq+u3idz3WX6PBrEhFqPrqgoGYERNmgIuDLWcJ1oVUh/UYh88
	 ieMDMNbNnF2KGbKw==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-OQ-MSGID: <1f52b12e-b10e-42c8-ba1e-cf8275db6fb0@qq.com>
Date: Sun, 9 Aug 2026 10:22:24 +0800
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
Subject: [BUG] KASAN: use-after-free in idempotent() / finit_module concurrent
 fd close [ath10k_pci] [syzkaller]
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

Using the same fuzzing campaign as the sibling slab-UAF report, we hit a
use-after-free in the module loader's `idempotent()` while concurrently
loading ath10k_pci modules. This variant frees the backing physical page
entirely (returned to buddy, all KASAN shadow `0xff`), and is followed by a
GPF in the same function.

Reproducer summary:

    BUG: KASAN: use-after-free in idempotent kernel/module/main.c:3682 [inline]
    BUG: KASAN: use-after-free in idempotent_init_module kernel/module/main.c:3788 [inline]
    BUG: KASAN: use-after-free in __do_sys_finit_module kernel/module/main.c:3815 [inline]
    Read of size 8 at addr ffff88800f54fe48 by task modprobe/733

    The buggy address belongs to the physical page:
    page: refcount:0 mapcount:0 ... pfn:0xf54f   (shadow all 0xff = freed)

Followed by:

    Oops: general protection fault, probably for non-canonical address
    0xdffffc00000003a5; KASAN: probably user-memory-access in range
    [0x0000000000001d28-0x0000000000001d2f] inside idempotent().

`idempotent()` walks the global `idem_hash` list comparing `existing->cookie !=
cookie` where `cookie = file_inode(f)`. `fdget` pins only the `struct file`, not
the inode/backing page. A concurrent `close()` of the module-load fd frees the
inode's page and returns it to the buddy allocator (refcount 0, shadow all
`0xff`); another in-flight `finit_module` then dereferences that freed cookie.

This is the same root cause as the sibling slab-UAF (https://lore.kernel.org/all/tencent_95B4D4B2EC1DAF3C31FDD07D6FA8B3FA9907@qq.com/) — the
only difference is the object type released: a whole buddy page here vs. a
`UNIX-STREAM` slab object there. Should be fixed together in
`idempotent_init_module()` / `idempotent()`.

The crash report shows below:

BUG: KASAN: use-after-free in idempotent kernel/module/main.c:3682 [inline]
BUG: KASAN: use-after-free in idempotent_init_module kernel/module/main.c:3788 [inline]
BUG: KASAN: use-after-free in __do_sys_finit_module kernel/module/main.c:3815 [inline]
BUG: KASAN: use-after-free in __se_sys_finit_module+0x2ce/0x570 kernel/module/main.c:3799
Read of size 8 at addr ffff88800f54fe48 by task modprobe/733

CPU: 0 UID: 0 PID: 733 Comm: modprobe Tainted: G      D             7.1.0 #1 PREEMPT(lazy) 
Tainted: [D]=DIE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xa2/0xd0 lib/dump_stack.c:120
 print_address_description+0x77/0x200 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 idempotent kernel/module/main.c:3682 [inline]
 idempotent_init_module kernel/module/main.c:3788 [inline]
 __do_sys_finit_module kernel/module/main.c:3815 [inline]
 __se_sys_finit_module+0x2ce/0x570 kernel/module/main.c:3799
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x143/0x470 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3387df725d
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8b bb 0d 00 f7 d8 64 89 01 48
RSP: 002b:00007ffda1809848 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
RAX: ffffffffffffffda RBX: 000055fcd40f9e40 RCX: 00007f3387df725d
RDX: 0000000000000000 RSI: 000055fcbe6cfe52 RDI: 0000000000000008
RBP: 00007ffda1809900 R08: 0000000000000040 R09: 00007ffda1809890
R10: 00007f3387ed3b20 R11: 0000000000000246 R12: 000055fcbe6cfe52
R13: 0000000000040000 R14: 000055fcd4101590 R15: 0000000000000000
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xf54f
flags: 0x100000000000000(node=0|zone=1)
raw: 0100000000000000 0000000000000000 ffffea00003d53c8 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88800f54fd00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88800f54fd80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff88800f54fe00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                              ^
 ffff88800f54fe80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88800f54ff00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

Regards,
Yang Zi

