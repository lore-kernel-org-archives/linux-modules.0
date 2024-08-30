Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6883C567F
	for <linux-modules@vger.kernel.org>; Fri, 30 Aug 2024 03:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724989460; cv=none; b=lKvH1/NG5pnuhemqwJ/69WC9JIJqjiwu6DQX5nNw/5t81gG1XdLOW7WEa9UzbNBqqRmLt1HEy5Ua4lAPYayFp0LbV+GPhYNRAWUMqmwRgbKaQxx31QDFxpDD6ejSUwocHsovrdhtnHKwS54BsFz5kUnj1+QI+hIBOejjGPyeFLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724989460; c=relaxed/simple;
	bh=tGsdxuuv598jVK+tZLbnqdHHWwnUPEfVZ3aSORhi1xk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=uq32WrCVGYE/1BmxprN6jqvzk0660BeVmANS4aCC7FSPgKL9M7cw1so0r1QX6uqLolGXcSuD52dvJQyvLF34ZtNJny4y43wZeGMzA6L43al2fIpRDoj5rAzHsA7h0UBWOjixdD0LgWTcUxK9fdas71R+T/FxLHp85r0EKUnABDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-824c925d120so142200939f.3
        for <linux-modules@vger.kernel.org>; Thu, 29 Aug 2024 20:44:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724989458; x=1725594258;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EeOg+SB0yxrJiY7pfqPASylS6AmynBWxHScTHhkZb6w=;
        b=lHhbBXtP0xj+WQ/abdjZdWLFmgQdV0jfYfbSNcf4gpauhQ6AMp4JLANPFCoBXhLaZy
         XN4U0HXOnRDxKaKpmezGSzHZldM/mq/kiPvd2CJMuNWz+QShKFca/skflcfjiA6cdG2O
         Xndz1KldiZHxPza64VDlNOyX+lQVpiVk6mxRR/9ZjTCCumqNz+4LVr6TqfOJAzPstoYK
         ZZh5ceW22duGUgWZticiG0MvKNwD6J7k3h19QiobILktUF2K3jCuPkxA9cLaBLyEaA8b
         FExESx4o9uKifa9eSYG4jUHr+SULBQ3SZW2f7rxuwAFals1RsvcJorblBsKXBVuxVNb9
         pbDw==
X-Forwarded-Encrypted: i=1; AJvYcCVrY1zcB4XuLiOLc+GNBpxHbZuaB3V6a8iiOF7zPPJat1CwWYFYtoqlGWGlUrV9EjqCjrhtsPOBcAaXWrNn@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9Sb8vQ6tX8V5ffJQNiSDbat1CiRY97pBTXUxi2vjDA+JsS5Ds
	AU1y00mZZfhr3gMw44YP5Bqgl/FkXyd9TIaJIi8bpVNIurwBmNpWLdcOgdQRCPnu7FJZGIoWGjO
	G9jqogPJ23u5NQtACXkSK34zwSzQXeD2KMXo5yWfhkAphI84FQXgZxnM=
X-Google-Smtp-Source: AGHT+IGbv7tVYwWeIOWrlp7Jloc0bw6g2w9JSVtxBYUGpiYbxjroReNF5d4wrvw+ymZHcDmLX/bjTgq6E546OUUcpIa0Wjvx7aeH
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:13ce:b0:81f:7d7d:89fd with SMTP id
 ca18e2360f4ac-82a2623e7eamr5761839f.1.1724989458573; Thu, 29 Aug 2024
 20:44:18 -0700 (PDT)
Date: Thu, 29 Aug 2024 20:44:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eb77d60620de6758@google.com>
Subject: [syzbot] [modules?] kernel panic: stack is corrupted in call_usermodehelper_exec
From: syzbot <syzbot+14d9438422f594f856bd@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	mcgrof@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3b9dfd9e5936 Merge tag 'hwmon-for-v6.11-rc6' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=141ab933980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d76559f775f44ba6
dashboard link: https://syzkaller.appspot.com/bug?extid=14d9438422f594f856bd
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17d8c77b980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11034a35980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-3b9dfd9e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3dab2f917732/vmlinux-3b9dfd9e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/541828a1cf09/bzImage-3b9dfd9e.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/cc6a8f9d7bd9/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+14d9438422f594f856bd@syzkaller.appspotmail.com

Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: call_usermodehelper_exec+0x493/0x4a0
CPU: 0 UID: 0 PID: 5107 Comm: syz-executor310 Not tainted 6.11.0-rc5-syzkaller-00148-g3b9dfd9e5936 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 panic+0x349/0x860 kernel/panic.c:354
 __stack_chk_fail+0x15/0x20 kernel/panic.c:827
 call_usermodehelper_exec+0x493/0x4a0
 call_modprobe kernel/module/kmod.c:103 [inline]
 __request_module+0x3ee/0x650 kernel/module/kmod.c:173
 ctrl_getfamily+0x28e/0x6b0 net/netlink/genetlink.c:1450
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 __sys_sendto+0x3a4/0x4f0 net/socket.c:2204
 __do_sys_sendto net/socket.c:2216 [inline]
 __se_sys_sendto net/socket.c:2212 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2212
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb2add42023
Code: 64 89 02 48 c7 c0 ff ff ff ff eb b7 66 2e 0f 1f 84 00 00 00 00 00 90 80 3d 81 90 09 00 00 41 89 ca 74 14 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 75 c3 0f 1f 40 00 55 48 83 ec 30 44 89 4c 24
RSP: 002b:00007ffe2a46ace8 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007ffe2a46ad90 RCX: 00007fb2add42023
RDX: 000000000000001c RSI: 00007ffe2a46ade0 RDI: 0000000000000005
RBP: 0000000000000005 R08: 00007ffe2a46ad04 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
R13: 00007ffe2a46ad58 R14: 00007ffe2a46ade0 R15: 0000000000000000
 </TASK>
Kernel Offset: disabled
Rebooting in 86400 seconds..


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
