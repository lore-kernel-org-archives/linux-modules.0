Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:63083 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750913AbeACW3f (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Wed, 3 Jan 2018 17:29:35 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: linux-modules@vger.kernel.org
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Subject: [PATCH 6/6] testsuite: explain why overriding function may fail
Date: Wed,  3 Jan 2018 14:29:24 -0800
Message-Id: <20180103222924.26347-7-lucas.demarchi@intel.com>
In-Reply-To: <20180103222924.26347-1-lucas.demarchi@intel.com>
References: <20180103222924.26347-1-lucas.demarchi@intel.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On my computer `testsuite/test-modprobe modprobe_install_cmd_loop` was
failing because when it forks off the shell the child process ends up
calling syscall() which are are supposed to wrap. Here's the backtrace:

	#0  0x00007ffff6fdb66b in raise () from /lib64/libc.so.6
	#1  0x00007ffff6fdd381 in abort () from /lib64/libc.so.6
	#2  0x00007ffff77bac97 in syscall (__sysno=<optimized out>)
	    at testsuite/init_module.c:362
	#3  0x00007fffef92d4e7 in hashmap_base_new.lto_priv () from /lib64/libnss_systemd.so.2
	#4  0x00007fffef953f50 in sd_bus_open_system () from /lib64/libnss_systemd.so.2
	#5  0x00007fffef943123 in _nss_systemd_getpwuid_r () from /lib64/libnss_systemd.so.2
	#6  0x00007ffff707eea5 in getpwuid_r@@GLIBC_2.2.5 () from /lib64/libc.so.6
	#7  0x00007ffff707e608 in getpwuid () from /lib64/libc.so.6
	#8  0x00005555555859e1 in get_current_user_info.part ()
	#9  0x00005555555a375a in initialize_shell_variables ()
	#10 0x0000555555580fde in shell_initialize ()
	#11 0x00005555555846ff in main ()<Paste>

The reason it fails on my system and not on, for e.g., a new one set up with
mkosi is that the call to getpwuid() depends on the contents
/etc/nsswitch.conf. The systemd module calls syscall() to implement gettid()
which we can't forward due to being a variadic function.

No fix is provided here, but at least it's explained why this happens.
---
 testsuite/init_module.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/testsuite/init_module.c b/testsuite/init_module.c
index b7d220b..199186b 100644
--- a/testsuite/init_module.c
+++ b/testsuite/init_module.c
@@ -356,9 +356,14 @@ TS_EXPORT long int syscall(long int __sysno, ...)
 	}
 
 	/*
-	 * FIXME: no way to call the libc function - let's hope there are no
-	 * other users.
+	 * FIXME: no way to call the libc function due since this is a
+	 * variadic argument function and we don't have a vsyscall() variant
+	 * this may fail if a library or process is trying to call syscall()
+	 * directly, for example to implement gettid().
 	 */
+	fprintf(stderr, "FIXME FIXME FIXME: could not wrap call to syscall(%ld), this should not happen\n",
+		__sysno);
+
 	abort();
 }
 
-- 
2.14.3

