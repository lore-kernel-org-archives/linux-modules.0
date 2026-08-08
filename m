Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0A928640B;
	Sat,  8 Aug 2026 17:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786208535; cv=none; b=JxGTVlKVAoWM3+B2EWasKFRh/SVcDv0k/oZRaS2GuQ68FQl7aE54dCPPdTKf7JyV1EG8UicsePes4F/xUBKkAr/sszARX7w9+G4deXUyZ5sC+zhLiO7QqRy8CyOBRbMQdIRavKpL++gn2OSY69ue704R7/SLgMRLMBSQlMM3NPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786208535; c=relaxed/simple;
	bh=fUrKag/XYymgmhOVJUoQh1ou36ReidXY9KTYOqY7fZo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=qaq/cnUf6NIxQk0XBmdbc72oFm1JQQVwlXNJky4POhpRQpQj3yDnxHE6qHLJ6sSllU+pUvvWGDLHOVZwqQG+vdfJGst5YvsdlIXAj5kzZNHUTGumIxA4CDe9Bp8dMPm1jkrs77a0dZSqD6wnhLo+gObNgav0elPJuIoL+pkc0ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=nusNAaUL; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="nusNAaUL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1786208521; bh=0fN/RV/R9ZUlhrMEOPF0NVTLILleAQ9lremVNzY4Ap4=;
	h=Date:From:Subject:To:Cc;
	b=nusNAaULvIOhBSFiZ69Ol4iULnq24uU5R0A8tcLG441ffm8fw8/ptKZMqXXgVS9Dl
	 UMmEcSyNODcEiZm2E1/jIvP/bsq3uQMAnBac8O9fPhNsBferuowDDHSOvCdB3QKs3p
	 7yf7Rt9qck8AFQC3QHXeTiDmCRruqmXWI9KZ+uTE=
Received: from [IPV6:2409:8a00:7893:9e40:542c:be54:7415:4303] ([2409:8a00:7893:9e40:542c:be54:7415:4303])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 313105F; Sun, 09 Aug 2026 01:00:49 +0800
X-QQ-mid: xmsmtpt1786208449tl369af42
Message-ID: <tencent_95B4D4B2EC1DAF3C31FDD07D6FA8B3FA9907@qq.com>
X-QQ-XMAILINFO: M07Ulnfy3VHK/yNPskhH853klo9cyV/NrkzsfcOis5LJv2gWL/N1iF4I+YAFdz
	 e3e5auhhWHl7FCo1YHdmJPl9DHsHLXz5Xeu7cXPinkaDtnEWZ/FJAjQQFGlk10Qc8LOYmKQkQxKl
	 qKD36lqAq+kgP4uqfp/RNLW/THeE+W5wnSuyhXZzgdINhmwOwbM68OwlOrlQCBtxFLdkRVRMeF1I
	 R4jVb3CDk/XOlbGZxJxEWZgC3+LuBy+sIU/ylGLQkPeHGX3oF9G4psvBXwGpJH6uPDAz2/PQsJBD
	 q4BNW53eVRIAkWUbNsCei95RbaHFv66jYoEZyd0FHTyF/3ZWpYMQGH1AfvFW+oAN4/w9owk0yovH
	 E+n/iVeA35jJc5eYxaiaSkivBfWJq0+hGS9l6EPbN1+zZx8Xh8zMRBfE49KbAKTW1vVOenKBGeZu
	 XAW6s+dg5JoqRsBuXaai5+8R+cUAk+gmtPGp//ei/UWoUG4AQqGngqhcv4tBcNs03S6y+p6/y8gd
	 6R4E+A6dBKZaJoV41a2zgtK/vK2svKObnrRZ3ni5rVUdHs/R0qOcSgaWduam4f3eR8yMz9aFBSAk
	 Ioni0QQIVL+wjyZwtnvrRzKUT8Jgr5jdPiJLP2Cquw8iClmG/MSNURao73sQueIxC9okEfSGFPbE
	 mmqud+6kOeF7HiLyX8twKyQi68/4lGET9W23d5aQWwkzrXSVUy7ZZe6LTrOunp9Ul85Bqo/76WsY
	 9fkxWyqndbqZ2VlFkiT3N6MQb5VEEI/XT1TjT4vBWQ2JeFvsGQwyF3ESd4+fkGQcBvaIayM03o1k
	 8teRpCn9rMsGJBhuD5SOEQcUGE+4qiG5TXY0nr+dxbTFu3nuYil3kUDInfzMi76eTGVMNDa1tbAH
	 p03K8LXbbNQivJP00Y9COsQktj4bXmU3xtyjRZof6ke7YwVAIwOBFUCwWLKzRiSMUyjUByKkFcwg
	 AxjfMX+DT/ZdedirD1Co9+AmSPteUdDA/BJPnzgcNZk50Jw3FsHlFVH66C3vIAm+H72OMGHQ+40o
	 dZ+jlE7jBpDZKQDzsFUbR45wvPmm6cB6NTABAkISGyrCF5m5m1CarxQ30i55LmLuO7NMfwMMs8LH
	 2azEMF
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-OQ-MSGID: <bae638bc-6d0a-456a-a020-13900e568b3e@qq.com>
Date: Sun, 9 Aug 2026 01:00:45 +0800
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Yang Zi <2959243019@qq.com>
Subject: [BUG] slab-use-after-free in idempotent() during concurrent
 finit_module [syzkaller] [ath10k_pci]
To: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

While fuzzing the kernel with syzkaller (KASAN), we hit a slab
use-after-free in the module loader's idempotent path. The crash is a
Read of size 8 in `idempotent()` in kernel/module/main.c while
concurrently loading modules via `finit_module`, when the load fd is
`close()`d from another thread.

Reproducer summary:

    BUG: KASAN: slab-use-after-free in idempotent kernel/module/main.c:3682 [inline]
    BUG: KASAN: slab-use-after-free in idempotent_init_module kernel/module/main.c:3788 [inline]
    BUG: KASAN: slab-use-after-free in __do_sys_finit_module kernel/module/main.c:3815 [inline]
    Read of size 8 at addr ffff88800d36fe48 by task modprobe/715

    The buggy address belongs to the object at ffff88800d36f700
    which belongs to the cache UNIX-STREAM of size 2048
    The buggy address is located 1864 bytes inside of a freed 2048-byte region

Allocated by task 634: __sys_socket → unix_create1 → sk_alloc → kmem_cache_alloc (2048 B)
Freed by task 634:  __x64_sys_close → __fput → sock_close → unix_release_sock → __sk_destruct → sk_prot_free → kmem_cache_free

`idempotent()` uses `file_inode(f)` as the cookie to compare entries on the
global `idem_hash` list. `fdget` only holds a reference on the `struct file`,
not on the inode/socket object. When a concurrent thread `close()`s the
module-load fd while another `finit_module` is inside `idempotent()`, the
`UNIX-STREAM` socket object is freed and the inode-cookie is dereferenced on
the hash list → slab-use-after-free (Read 8 B).

Root-cause hypothesis: the `file_inode(f)` cookie has no lifetime protection
across the `hlist_for_each_entry` in `idempotent()`; the concurrent `close`
can release the object underneath the traversal.

Related upstream reports/fixes for this idempotent mechanism:
  – "module: always complete idempotent loads" (Fixes: 9b9879fc0327)
  – "module: fix UAF and GPF in idempotent_init_module via heap allocation"
This bug looks like the same family: the idempotent entries use
`file_inode(f)` as cookie with no lifetime protection.

Note: this crash was found while fuzzing an instrumented driver
(ath10k_pci) via finit_module, but I think the fault is entirely in the module
loader; the driver is only the load carrier.

The crash report shows below:

```
BUG: KASAN: slab-use-after-free in idempotent kernel/module/main.c:3682 [inline]
BUG: KASAN: slab-use-after-free in idempotent_init_module kernel/module/main.c:3788 [inline]
BUG: KASAN: slab-use-after-free in __do_sys_finit_module kernel/module/main.c:3815 [inline]
BUG: KASAN: slab-use-after-free in __se_sys_finit_module+0x2ce/0x570 kernel/module/main.c:3799
Read of size 8 at addr ffff88800d36fe48 by task modprobe/715

CPU: 0 UID: 0 PID: 715 Comm: modprobe Tainted: G      D             7.1.0 #1 PREEMPT(lazy) 
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
RIP: 0033:0x7fde6089825d
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8b bb 0d 00 f7 d8 64 89 01 48
RSP: 002b:00007ffc075f59b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
RAX: ffffffffffffffda RBX: 000055c71a011cd0 RCX: 00007fde6089825d
RDX: 0000000000000000 RSI: 000055c7007b0e52 RDI: 0000000000000008
RBP: 00007ffc075f5a70 R08: 0000000000000040 R09: 00007ffc075f5a00
R10: 00007fde60974b20 R11: 0000000000000246 R12: 000055c7007b0e52
R13: 0000000000040000 R14: 000055c71a019590 R15: 0000000000000000
 </TASK>

Allocated by task 634:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 unpoison_slab_object mm/kasan/common.c:340 [inline]
 __kasan_slab_alloc+0x4b/0x60 mm/kasan/common.c:366
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4570 [inline]
 slab_alloc_node mm/slub.c:4899 [inline]
 kmem_cache_alloc_noprof+0x13e/0x570 mm/slub.c:4906
 sk_prot_alloc+0x56/0x210 net/core/sock.c:2246
 sk_alloc+0x3a/0x760 net/core/sock.c:2308
 unix_create1+0xb3/0x730 net/unix/af_unix.c:-1
 unix_create+0x161/0x210 net/unix/af_unix.c:1169
 __sock_create+0x4a4/0x930 net/socket.c:1665
 sock_create net/socket.c:1723 [inline]
 __sys_socket_create net/socket.c:1760 [inline]
 __sys_socket+0xd6/0x1b0 net/socket.c:1807
 __do_sys_socket net/socket.c:1821 [inline]
 __se_sys_socket net/socket.c:1819 [inline]
 __x64_sys_socket+0x7a/0x90 net/socket.c:1819
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x143/0x470 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 634:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x3a/0x60 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2689 [inline]
 slab_free mm/slub.c:6251 [inline]
 kmem_cache_free+0x175/0x5a0 mm/slub.c:6378
 sk_prot_free net/core/sock.c:2289 [inline]
 __sk_destruct+0x602/0x750 net/core/sock.c:2391
 sock_put include/net/sock.h:2011 [inline]
 unix_release_sock+0x90c/0xaf0 net/unix/af_unix.c:732
 unix_release+0x92/0xd0 net/unix/af_unix.c:1184
 __sock_release net/socket.c:722 [inline]
 sock_close+0xad/0x220 net/socket.c:1515
 __fput+0x418/0xa50 fs/file_table.c:510
 fput_close_sync+0xc2/0x1b0 fs/file_table.c:615
 __do_sys_close fs/open.c:1507 [inline]
 __se_sys_close fs/open.c:1492 [inline]
 __x64_sys_close+0x7e/0x110 fs/open.c:1492
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x143/0x470 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88800d36f700
 which belongs to the cache UNIX-STREAM of size 2048
The buggy address is located 1864 bytes inside of
 freed 2048-byte region [ffff88800d36f700, ffff88800d36ff00)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff88800d36cc80 pfn:0xd368
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff88800d36ff81
flags: 0x100000000000240(workingset|head|node=0|zone=1)
page_type: f5(slab)
raw: 0100000000000240 ffff88800b7bf3c0 ffffea000043c010 ffffea0000400e10
raw: ffff88800d36cc80 00000008000f000d 00000000f5000000 ffff88800d36ff81
head: 0100000000000240 ffff88800b7bf3c0 ffffea000043c010 ffffea0000400e10
head: ffff88800d36cc80 00000008000f000d 00000000f5000000 ffff88800d36ff81
head: 0100000000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88800d36fd00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88800d36fd80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88800d36fe00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                              ^
 ffff88800d36fe80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88800d36ff00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
```

Regards,
Yang Zi <2959243019@qq.com>

