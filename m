Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5188C4219FD
	for <linux-modules@vger.kernel.org>; Fri,  6 Feb 2026 18:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770401134; cv=none; b=ckl4TGCf1Lu8evuqtpy22y34K84b7kUPyQ5i+fCUNh/LrBBvcoYDiCyYKpG1zt972MM+lQGfJUC91RM8OvxdCJ0dLdq9/kqn3HtNUZdHpOllz+baW2R+DW5CqJdIUnr0sLAxN4bUHk9f8IgG3LGe8mez8h5UBQKxNP9gCktMptY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770401134; c=relaxed/simple;
	bh=eIbxboW/V5+FQZZ3bYlet11DXvZCkGbTbGhZRbovbOo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=TbjyoUC8SoB5T9qxFihd5TzerNgnRbg/ry8TDSW0gIamqQeyj7a8ebsYE8Z9JRMuRzZ4oFmV+5L7Pfi8AOM5vpJ4qJGgQbBAR0fPHRBHk84aICblhJyLtPvIt4850EIoM1wwQeAd+97zS82dtK+JwjgA/zhDHYYY+co/Fzr/ZVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-6640dc1ca05so9294990eaf.1
        for <linux-modules@vger.kernel.org>; Fri, 06 Feb 2026 10:05:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770401133; x=1771005933;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nSpbGy3B1NrgROOpizmjJYBMSHCApF8ouUOjkUrx6pc=;
        b=XAT0uWo/YK9t4PTXNJ/9oW5UK9PoQPTFBGyMjQcVLVudN2RKEI7IBHV8ouCOV4bAxt
         hvDCH0tBDyZ59oJNjlKten+479BUoaZ+BmxYtPfsQL5iUhvVKRf3kNCVWm/G4LI2gp9C
         VaVCs/o6U3XOIu/4vAG8RNTjwo5tD/oHloA6kSOVD2n6JiN6joNZjJmwgdUOYT4q/NVN
         ktw6OTYV3o+ds9BWk/Cb7oHhWAopVWNCAzdEEUdOkR/bpMdGX2LXfAcTlILNwR7/cicA
         qXfr+TmarQPY3elItQ/CMCxoAcLRMOg2sCoMxWZX1Gr66NW4gylO45eON8yHUW89NXAV
         jO0w==
X-Forwarded-Encrypted: i=1; AJvYcCUznwmnKO0RNIfc2mgv99TX1wUGN/azxtIQE9dUyDkSPbm3ROLMZDIhc1kfievQVkCeS98gtqjx3KLYtFIr@vger.kernel.org
X-Gm-Message-State: AOJu0YzZg7dlsb3shvwDFVQNyGf7R167byblmyan28ZeRO34phr5YOrS
	O7e8g8c1XrVGLdKaYfILaiew/som2sAQHL+ZmjpRmcZsOehOvTDLN7Lbjw4DHhS4Rw0JICc9RJu
	SpyXE7TDfw9nojlOTTPQGTe0eSSmJ0/z5oBlzFBbysdjllNzpU0+sP4jQdLw=
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:16a:b0:66e:25f5:4b3e with SMTP id
 006d021491bc7-66e25f54d17mr380497eaf.32.1770401133064; Fri, 06 Feb 2026
 10:05:33 -0800 (PST)
Date: Fri, 06 Feb 2026 10:05:33 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69862d6d.a00a0220.37c87e.003b.GAE@google.com>
Subject: [syzbot] [modules?] KASAN: slab-out-of-bounds Write in try_module_get (2)
From: syzbot <syzbot+e993e01b15c8eefd9cd4@syzkaller.appspotmail.com>
To: da.gomez@kernel.org, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, mcgrof@kernel.org, petr.pavlu@suse.com, 
	samitolvanen@google.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8e621c9a3375 Merge tag 'net-6.18-rc7' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=110c9a12580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1cd7f786c0f5182f
dashboard link: https://syzkaller.appspot.com/bug?extid=e993e01b15c8eefd9cd4
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6be75789d60e/disk-8e621c9a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/62e7a40cfe48/vmlinux-8e621c9a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3e523caa536d/bzImage-8e621c9a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e993e01b15c8eefd9cd4@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
BUG: KASAN: slab-out-of-bounds in atomic_inc_not_zero include/linux/atomic/atomic-instrumented.h:1536 [inline]
BUG: KASAN: slab-out-of-bounds in try_module_get+0x4c/0xd0 kernel/module/main.c:913
Write of size 4 at addr ffff888141a87f08 by task syz.1.7015/6511

CPU: 1 UID: 0 PID: 6511 Comm: syz.1.7015 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xcd/0x630 mm/kasan/report.c:482
 kasan_report+0xe0/0x110 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:194 [inline]
 kasan_check_range+0x100/0x1b0 mm/kasan/generic.c:200
 instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
 atomic_inc_not_zero include/linux/atomic/atomic-instrumented.h:1536 [inline]
 try_module_get+0x4c/0xd0 kernel/module/main.c:913
 dvb_device_open+0x124/0x3b0 drivers/media/dvb-core/dvbdev.c:103
 chrdev_open+0x234/0x6a0 fs/char_dev.c:414
 do_dentry_open+0x982/0x1530 fs/open.c:965
 vfs_open+0x82/0x3f0 fs/open.c:1097
 do_open fs/namei.c:3975 [inline]
 path_openat+0x1de4/0x2cb0 fs/namei.c:4134
 do_filp_open+0x20b/0x470 fs/namei.c:4161
 do_sys_openat2+0x11b/0x1d0 fs/open.c:1437
 do_sys_open fs/open.c:1452 [inline]
 __do_sys_openat fs/open.c:1468 [inline]
 __se_sys_openat fs/open.c:1463 [inline]
 __x64_sys_openat+0x174/0x210 fs/open.c:1463
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f14c238f749
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f14c3243038 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f14c25e5fa0 RCX: 00007f14c238f749
RDX: 0000000000000100 RSI: 0000200000000000 RDI: ffffffffffffff9c
RBP: 00007f14c2413f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f14c25e6038 R14: 00007f14c25e5fa0 R15: 00007fff9eaadb88
 </TASK>

Allocated by task 1:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:56
 kasan_save_track+0x14/0x30 mm/kasan/common.c:77
 poison_kmalloc_redzone mm/kasan/common.c:400 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:417
 kmalloc_noprof include/linux/slab.h:957 [inline]
 kzalloc_noprof include/linux/slab.h:1094 [inline]
 dvb_register_device+0x1e4/0x2370 drivers/media/dvb-core/dvbdev.c:475
 dvb_dmxdev_init+0x33e/0x4e0 drivers/media/dvb-core/dmxdev.c:1436
 vidtv_bridge_dmxdev_init drivers/media/test-drivers/vidtv/vidtv_bridge.c:343 [inline]
 vidtv_bridge_dvb_init drivers/media/test-drivers/vidtv/vidtv_bridge.c:445 [inline]
 vidtv_bridge_probe+0x75d/0xa90 drivers/media/test-drivers/vidtv/vidtv_bridge.c:508
 platform_probe+0x106/0x1d0 drivers/base/platform.c:1405
 call_driver_probe drivers/base/dd.c:581 [inline]
 really_probe+0x241/0xa90 drivers/base/dd.c:659
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:801
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:831
 __driver_attach+0x283/0x580 drivers/base/dd.c:1217
 bus_for_each_dev+0x13e/0x1d0 drivers/base/bus.c:370
 bus_add_driver+0x2e9/0x690 drivers/base/bus.c:678
 driver_register+0x15c/0x4b0 drivers/base/driver.c:249
 vidtv_bridge_init+0x45/0x80 drivers/media/test-drivers/vidtv/vidtv_bridge.c:598
 do_one_initcall+0x123/0x6e0 init/main.c:1283
 do_initcall_level init/main.c:1345 [inline]
 do_initcalls init/main.c:1361 [inline]
 do_basic_setup init/main.c:1380 [inline]
 kernel_init_freeable+0x5c8/0x920 init/main.c:1593
 kernel_init+0x1c/0x2b0 init/main.c:1483
 ret_from_fork+0x675/0x7d0 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff888141a87e00
 which belongs to the cache kmalloc-256 of size 256
The buggy address is located 48 bytes to the right of
 allocated 216-byte region [ffff888141a87e00, ffff888141a87ed8)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x141a86
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0x57ff00000000040(head|node=1|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 057ff00000000040 ffff88813ffa6b40 ffffea0001fdc480 0000000000000005
raw: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 057ff00000000040 ffff88813ffa6b40 ffffea0001fdc480 0000000000000005
head: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 057ff00000000001 ffffea000506a181 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000002
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 19365672156, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1af/0x220 mm/page_alloc.c:1845
 prep_new_page mm/page_alloc.c:1853 [inline]
 get_page_from_freelist+0x10a3/0x3a30 mm/page_alloc.c:3879
 __alloc_frozen_pages_noprof+0x25f/0x2470 mm/page_alloc.c:5178
 alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2416
 alloc_slab_page mm/slub.c:3059 [inline]
 allocate_slab mm/slub.c:3232 [inline]
 new_slab+0x24a/0x360 mm/slub.c:3286
 ___slab_alloc+0xd79/0x1a50 mm/slub.c:4655
 __slab_alloc.constprop.0+0x63/0x110 mm/slub.c:4778
 __slab_alloc_node mm/slub.c:4854 [inline]
 slab_alloc_node mm/slub.c:5276 [inline]
 __kmalloc_cache_noprof+0x477/0x780 mm/slub.c:5766
 kmalloc_noprof include/linux/slab.h:957 [inline]
 kzalloc_noprof include/linux/slab.h:1094 [inline]
 bus_add_driver+0x92/0x690 drivers/base/bus.c:662
 driver_register+0x15c/0x4b0 drivers/base/driver.c:249
 usb_register_driver+0x216/0x4d0 drivers/usb/core/driver.c:1078
 do_one_initcall+0x123/0x6e0 init/main.c:1283
 do_initcall_level init/main.c:1345 [inline]
 do_initcalls init/main.c:1361 [inline]
 do_basic_setup init/main.c:1380 [inline]
 kernel_init_freeable+0x5c8/0x920 init/main.c:1593
 kernel_init+0x1c/0x2b0 init/main.c:1483
 ret_from_fork+0x675/0x7d0 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888141a87e00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888141a87e80: 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc
>ffff888141a87f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                      ^
 ffff888141a87f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888141a88000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
