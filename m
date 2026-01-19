Received: from mail-ot1-f79.google.com (mail-ot1-f79.google.com [209.85.210.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6662E229F
	for <linux-modules@vger.kernel.org>; Mon, 19 Jan 2026 19:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768852589; cv=none; b=EHPGKSBhfFurzzorySIF2uI8WfuxS/pf/+5GImwezkbM0Tpu41pozlMT53zCI4CTzYCkh78oTWPPT1lygyD40Py08qEfoXU7RM4EJGp+Zy8v+NJ0Zl1UG3B7J5hLZeQOnxvZF9ro9aGjgZZxlzBN/yOkd/GlFEv1DuW5UII/M2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768852589; c=relaxed/simple;
	bh=IeKcNOcLje6PT1QDss+lAtL7jKYJYw1lxTT5txadrGc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=i/OAqrv6qb4G1JDbxHuyfUCFdgWpNHFXUZQfgtF2AqyhIP2cux/g7mn9KdaH7aIxzL89tXacLXK+yctVe3kraPTW/5DpUC2Ir1UouuiqPiXfczZKrtMzPNXo6Yv8sk50Q1Dz+QWYCi2FCVL2LSBDrptpeUa42/KFS+m/kKwdorM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f79.google.com with SMTP id 46e09a7af769-7cfd1080f66so6985558a34.2
        for <linux-modules@vger.kernel.org>; Mon, 19 Jan 2026 11:56:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768852584; x=1769457384;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kqBqE9fXiRx/AMYmw8uakxxJbkPqjjjQhlk9qawc3Uk=;
        b=qSsMbvbJ54j0BNt2UqcSkbxgEkEI+bPtKYtPCNAnOdHJR+tB5p11JCfWAj89Jgu4bR
         jhru70nbyNyziuFcurks8jSIJJYJ6Ri7KoOMNuPqfbTTmsjofwpQx6sOAaIXYRJ313Iw
         35X/HrSu8g97d/LPYdM0Xx2osauRtwzgTHtX/Ek7IFB1bnAVZuLJvyBGb2aU90tLCoB5
         mKhS2JcVa6jRLXBvnFNSqEy5WuDru90044+lunlA6YfhCaP4MAxwi2TFYkniqWuCsDdH
         SXlFPoqON6dtiinv6Hm9L9CPocQUNiuY97ul9TdySB7bCR7hNCshQESzdMZU0S2v5u/g
         sVIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsWVp/GtEIug65hEjSrqkzS9AMqc7x3mu/OkK1/IF9FI3KIB09SyJwFXhtLI2kGqid4BZSibx//iv0DX8R@vger.kernel.org
X-Gm-Message-State: AOJu0YxJWyfHVELP+ykYyGIFlmuxPumUKNGBWSoISeVmIJ0/p4eynS5b
	6XgzT5rWG5JumLyScz731rg68qM47LeehH3dIB5uybg4/utRijyetAq7N0PBALxAgs7TTQuyDUA
	BrcRr56Nueoys7TJhrOBn+po9nwK3qYKGixwyq1njxmjF41Py2PxT7RC3Hec=
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:811:b0:65f:6053:756d with SMTP id
 006d021491bc7-6611797f0d9mr5103499eaf.28.1768852584222; Mon, 19 Jan 2026
 11:56:24 -0800 (PST)
Date: Mon, 19 Jan 2026 11:56:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <696e8c68.a70a0220.34546f.04b3.GAE@google.com>
Subject: [syzbot] [modules?] INFO: rcu detected stall in inotify_add_watch
From: syzbot <syzbot+aa5520f7faf8d5438034@syzkaller.appspotmail.com>
To: atomlin@atomlin.com, da.gomez@kernel.org, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, mcgrof@kernel.org, petr.pavlu@suse.com, 
	samitolvanen@google.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    944aacb68baf Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1431d052580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=323fe5bdde2384a5
dashboard link: https://syzkaller.appspot.com/bug?extid=aa5520f7faf8d5438034
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=162c2dfc580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/575dc0ba1f73/disk-944aacb6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c81f6750bf1b/vmlinux-944aacb6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ce2273224949/bzImage-944aacb6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+aa5520f7faf8d5438034@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P12/2:b..l P6218/1:b..l P5834/1:b..l
rcu: 	(detected by 1, t=10503 jiffies, g=14653, q=1024 ncpus=2)
task:udevd           state:R  running task     stack:24568 pid:5834  tgid:5834  ppid:5196   task_flags:0x440140 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5256 [inline]
 __schedule+0x149b/0x4fd0 kernel/sched/core.c:6863
 preempt_schedule_irq+0x4d/0xa0 kernel/sched/core.c:7190
 irqentry_exit+0x5e3/0x670 kernel/entry/common.c:216
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
RIP: 0010:rcu_read_lock include/linux/rcupdate.h:868 [inline]
RIP: 0010:class_rcu_constructor include/linux/rcupdate.h:1195 [inline]
RIP: 0010:is_module_text_address+0x44/0x1e0 kernel/module/main.c:3856
Code: 00 00 00 48 c7 c7 a0 1a f4 8d 31 f6 31 d2 b9 02 00 00 00 45 31 c0 45 31 c9 53 e8 77 82 f2 ff 48 83 c4 08 e8 4e 5a ae 09 85 c0 <74> 3a e8 85 91 fb ff 84 c0 75 31 e8 3c 5a ae 09 85 c0 74 28 80 3d
RSP: 0018:ffffc90002ff7920 EFLAGS: 00000202
RAX: 0000000000000001 RBX: ffffffff81ab6c1d RCX: ffff88807bec3d00
RDX: 00000000706f5022 RSI: ffffffff8d976a6b RDI: ffffffff8bc086e0
RBP: 0000000000000001 R08: ffffffff81ab6c1d R09: ffffffff8df41aa0
R10: dffffc0000000000 R11: ffffffff81acf4d0 R12: ffff88807bec3d00
R13: ffff88805500bc80 R14: 00007f1b687219a7 R15: 1ffff920005fef3e
 kernel_text_address+0x94/0xe0 kernel/extable.c:119
 __kernel_text_address+0xd/0x40 kernel/extable.c:79
 unwind_get_return_address+0x4d/0x90 arch/x86/kernel/unwind_orc.c:385
 arch_stack_walk+0xfc/0x150 arch/x86/kernel/stacktrace.c:26
 stack_trace_save+0x9c/0xe0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 unpoison_slab_object mm/kasan/common.c:340 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:366
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4953 [inline]
 slab_alloc_node mm/slub.c:5263 [inline]
 kmem_cache_alloc_noprof+0x37d/0x710 mm/slub.c:5270
 inotify_new_watch fs/notify/inotify/inotify_user.c:599 [inline]
 inotify_update_watch fs/notify/inotify/inotify_user.c:647 [inline]
 __do_sys_inotify_add_watch fs/notify/inotify/inotify_user.c:781 [inline]
 __se_sys_inotify_add_watch+0x6d4/0xf10 fs/notify/inotify/inotify_user.c:729
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xec/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1b687219a7
RSP: 002b:00007fffd4df20d8 EFLAGS: 00000206 ORIG_RAX: 00000000000000fe
RAX: ffffffffffffffda RBX: 0000558f453876d0 RCX: 00007f1b687219a7
RDX: 0000000000000008 RSI: 0000558f45371360 RDI: 0000000000000007
RBP: 0000558f45360910 R08: 00000000000001d0 R09: 0000000000000003
R10: 0000000000000000 R11: 0000000000000206 R12: 0000558f453876d0
R13: 0000558f4536e190 R14: 0000000000000008 R15: 0000558f453876d0
 </TASK>
task:kworker/u8:17   state:R  running task     stack:24568 pid:6218  tgid:6218  ppid:2      task_flags:0x4208060 flags:0x00080000
Workqueue: events_unbound cfg80211_wiphy_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5256 [inline]
 __schedule+0x149b/0x4fd0 kernel/sched/core.c:6863
 preempt_schedule_irq+0x4d/0xa0 kernel/sched/core.c:7190
 irqentry_exit+0x5e3/0x670 kernel/entry/common.c:216
 asm_sysvec_reschedule_ipi+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:lock_release+0x2d8/0x3b0 kernel/locking/lockdep.c:5893
Code: 33 e2 10 00 00 00 00 eb b5 e8 d4 9e bb 09 f7 c3 00 02 00 00 74 b9 65 48 8b 05 c4 ed e1 10 48 3b 44 24 28 75 44 fb 48 83 c4 30 <5b> 41 5c 41 5d 41 5e 41 5f 5d e9 94 1e 72 ff cc 48 8d 3d 71 4a e7
RSP: 0018:ffffc9000257f3e0 EFLAGS: 00000282
RAX: 0526f4b768dc6600 RBX: 0000000000000202 RCX: 0000000000000046
RDX: 0000000000000003 RSI: ffffffff8d976a6b RDI: ffffffff8bc086e0
RBP: ffff88802d8e2a28 R08: ffffc9000257fa20 R09: ffffc9000257f538
R10: dffffc0000000000 R11: fffff520004afea9 R12: 0000000000000003
R13: 0000000000000003 R14: ffffffff8df41aa0 R15: ffff88802d8e1e80
 rcu_lock_release include/linux/rcupdate.h:341 [inline]
 rcu_read_unlock include/linux/rcupdate.h:897 [inline]
 class_rcu_destructor include/linux/rcupdate.h:1195 [inline]
 unwind_next_frame+0x1ab1/0x23d0 arch/x86/kernel/unwind_orc.c:695
 arch_stack_walk+0x11c/0x150 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x9c/0xe0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2540 [inline]
 slab_free mm/slub.c:6670 [inline]
 kmem_cache_free+0x197/0x620 mm/slub.c:6781
 skb_release_data+0x62d/0x7c0 net/core/skbuff.c:1107
 skb_release_all net/core/skbuff.c:1182 [inline]
 __kfree_skb net/core/skbuff.c:1196 [inline]
 sk_skb_reason_drop+0x127/0x170 net/core/skbuff.c:1234
 kfree_skb_reason include/linux/skbuff.h:1322 [inline]
 kfree_skb include/linux/skbuff.h:1331 [inline]
 ieee80211_iface_work+0xb2a/0x12d0 net/mac80211/iface.c:1792
 cfg80211_wiphy_work+0x2ab/0x450 net/wireless/core.c:438
 process_one_work kernel/workqueue.c:3257 [inline]
 process_scheduled_works+0xad1/0x1770 kernel/workqueue.c:3340
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3421
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x510/0xa50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
task:kworker/u8:0    state:R  running task     stack:24480 pid:12    tgid:12    ppid:2      task_flags:0x4208160 flags:0x00080000
Workqueue: ipv6_addrconf addrconf_dad_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5256 [inline]
 __schedule+0x149b/0x4fd0 kernel/sched/core.c:6863
 preempt_schedule_irq+0x4d/0xa0 kernel/sched/core.c:7190
 irqentry_exit+0x5e3/0x670 kernel/entry/common.c:216
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
RIP: 0010:lock_release+0x2d8/0x3b0 kernel/locking/lockdep.c:5893
Code: 33 e2 10 00 00 00 00 eb b5 e8 d4 9e bb 09 f7 c3 00 02 00 00 74 b9 65 48 8b 05 c4 ed e1 10 48 3b 44 24 28 75 44 fb 48 83 c4 30 <5b> 41 5c 41 5d 41 5e 41 5f 5d e9 94 1e 72 ff cc 48 8d 3d 71 4a e7
RSP: 0018:ffffc90000116f20 EFLAGS: 00000282
RAX: ccca9c3ae3660b00 RBX: 0000000000000202 RCX: 0000000000000046
RDX: 0000000000000005 RSI: ffffffff8d976a6b RDI: ffffffff8bc086e0
RBP: ffff88801c2a6778 R08: ffffc900001175b8 R09: ffffc90000117078
R10: dffffc0000000000 R11: fffff52000022e11 R12: 0000000000000005
R13: 0000000000000005 R14: ffffffff8df41aa0 R15: ffff88801c2a5b80
 rcu_lock_release include/linux/rcupdate.h:341 [inline]
 rcu_read_unlock include/linux/rcupdate.h:897 [inline]
 class_rcu_destructor include/linux/rcupdate.h:1195 [inline]
 unwind_next_frame+0x1ab1/0x23d0 arch/x86/kernel/unwind_orc.c:695
 arch_stack_walk+0x11c/0x150 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x9c/0xe0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x3e2/0x700 mm/slub.c:5776
 kmalloc_noprof include/linux/slab.h:957 [inline]
 kzalloc_noprof include/linux/slab.h:1094 [inline]
 ref_tracker_alloc+0x133/0x460 lib/ref_tracker.c:271
 __netdev_tracker_alloc include/linux/netdevice.h:4400 [inline]
 netdev_hold include/linux/netdevice.h:4429 [inline]
 dst_init+0xd9/0x450 net/core/dst.c:52
 dst_alloc+0x12a/0x170 net/core/dst.c:93
 ip6_dst_alloc net/ipv6/route.c:342 [inline]
 icmp6_dst_alloc+0x75/0x420 net/ipv6/route.c:3333
 mld_sendpack+0x683/0xe60 net/ipv6/mcast.c:1844
 ipv6_mc_dad_complete+0x88/0x410 net/ipv6/mcast.c:2279
 addrconf_dad_completed+0x6d5/0xd60 net/ipv6/addrconf.c:4340
 addrconf_dad_work+0xc36/0x14b0 net/ipv6/addrconf.c:-1
 process_one_work kernel/workqueue.c:3257 [inline]
 process_scheduled_works+0xad1/0x1770 kernel/workqueue.c:3340
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3421
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x510/0xa50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
rcu: rcu_preempt kthread starved for 10628 jiffies! g14653 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:27480 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5256 [inline]
 __schedule+0x149b/0x4fd0 kernel/sched/core.c:6863
 __schedule_loop kernel/sched/core.c:6945 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6960
 schedule_timeout+0x12b/0x270 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x301/0x1540 kernel/rcu/tree.c:2083
 rcu_gp_kthread+0x99/0x390 kernel/rcu/tree.c:2285
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x510/0xa50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:pv_native_safe_halt+0x13/0x20 arch/x86/kernel/paravirt.c:82
Code: 1e 84 b6 f5 cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d 53 91 0e 00 f3 0f 1e fa fb f4 <e9> f3 83 b6 f5 cc cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90000197e20 EFLAGS: 000002c6
RAX: 00000000000f3f43 RBX: ffffffff8197149e RCX: 0000000080000001
RDX: 0000000000000001 RSI: ffffffff8d792d31 RDI: ffffffff8bc086e0
RBP: ffffc90000197f10 R08: ffff8880b87336db R09: 1ffff110170e66db
R10: dffffc0000000000 R11: ffffed10170e66dc R12: ffffffff8f822470
R13: 1ffff1100385fb70 R14: 0000000000000001 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff888125f1f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe5546e0f98 CR3: 000000002efbb000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 arch_safe_halt arch/x86/include/asm/paravirt.h:107 [inline]
 default_idle+0x13/0x20 arch/x86/kernel/process.c:767
 default_idle_call+0x73/0xb0 kernel/sched/idle.c:122
 cpuidle_idle_call kernel/sched/idle.c:191 [inline]
 do_idle+0x1be/0x4d0 kernel/sched/idle.c:332
 cpu_startup_entry+0x44/0x60 kernel/sched/idle.c:430
 start_secondary+0x101/0x110 arch/x86/kernel/smpboot.c:312
 common_startup_64+0x13e/0x147
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
