Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:24430 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755991AbeAHV2e (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Mon, 8 Jan 2018 16:28:34 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: linux-modules@vger.kernel.org
Cc: caio.oliveira@intel.com
Subject: [PATCH v2] testsuite: also wrap gettid in syscall()
Date: Mon,  8 Jan 2018 13:28:29 -0800
Message-Id: <20180108212829.14484-1-lucas.demarchi@intel.com>
In-Reply-To: <20180108162708.16662-1-lucas.demarchi@intel.com>
References: <20180108162708.16662-1-lucas.demarchi@intel.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Not a perfect solution for overriding syscall(), but at least
it makes the testsuite to pass in a modified nsswitch.conf (one that has
a module which calls syscall() to get the thread id).
---

v2:
	- Check nextlib_syscall rather than nextlib to avoid races in
	  multithreaded programs
	- Add error message in case we fail to get symbol

 testsuite/init_module.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/testsuite/init_module.c b/testsuite/init_module.c
index 199186b..c70147e 100644
--- a/testsuite/init_module.c
+++ b/testsuite/init_module.c
@@ -355,6 +355,26 @@ TS_EXPORT long int syscall(long int __sysno, ...)
 		return ret;
 	}
 
+	if (__sysno == __NR_gettid) {
+		static void *nextlib = NULL;
+		static long (*nextlib_syscall)(long number, ...);
+
+		if (nextlib_syscall == NULL) {
+#ifdef RTLD_NEXT
+			nextlib = RTLD_NEXT;
+#else
+			nextlib = dlopen("libc.so.6", RTLD_LAZY);
+#endif
+			nextlib_syscall = dlsym(nextlib, "syscall");
+			if (nextlib_syscall == NULL) {
+				fprintf(stderr, "FIXME FIXME FIXME: libc is missing syscall symbol\n");
+				abort();
+			}
+		}
+
+		return nextlib_syscall(__NR_gettid);
+	}
+
 	/*
 	 * FIXME: no way to call the libc function due since this is a
 	 * variadic argument function and we don't have a vsyscall() variant
-- 
2.14.3

