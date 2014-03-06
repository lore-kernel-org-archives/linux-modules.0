Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58973 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750829AbaCFRDw (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Thu, 6 Mar 2014 12:03:52 -0500
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id C4193ACB0
	for <linux-modules@vger.kernel.org>; Thu,  6 Mar 2014 17:03:51 +0000 (UTC)
From: Michal Marek <mmarek@suse.cz>
To: linux-modules@vger.kernel.org
Subject: [PATCH] testsuite: Fix uname() during glibc startup
Date: Thu,  6 Mar 2014 18:03:46 +0100
Message-Id: <1394125426-31945-1-git-send-email-mmarek@suse.cz>
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

In a specific configuration (chroot with the linux32 personality), the
modprobe_install_cmd_loop test failed, because the bash process handling
the install command segfaulted. The backtrace showed a uname() call
during libpthread initialization, at which point the environ pointer
hadn't been initialized yet:

	Program terminated with signal SIGSEGV, Segmentation fault.
	#0  0x080c1591 in getenv (name=<optimized out>,
	    name@entry=0xf775f850 "TESTSUITE_UNAME_R") at getenv.c:81
	81	      for (i = 0, len = strlen (name); environ[i]; i++)
	(gdb) bt
	#0  0x080c1591 in getenv (name=<optimized out>,
	    name@entry=0xf775f850 "TESTSUITE_UNAME_R") at getenv.c:81
	#1  0xf775f754 in uname (u=u@entry=0xff946350) at testsuite/uname.c:32
	#2  0xf74ffc6c in is_smp_system ()
	    at ../nptl/sysdeps/unix/sysv/linux/i386/smp.h:39
	#3  __pthread_initialize_minimal_internal () at nptl-init.c:460
	#4  0xf74fe32c in _init () at ../sysdeps/i386/crti.S:74
	#5  0x00000000 in ?? ()
	(gdb) p environ
	$1 = (char **) 0x0

I don't know why it only happend in the chroot, but glibc can call its
own functions and impose any restrictions before main() is started, so
we have to adapt.

Also, do not return error if there is an environment, but the
environment variable is not found. If uname() is called by kmod, then
the respective test will simply fail later. If it's something else
calling uname(), then we do not want to disturb the program.
---
 testsuite/uname.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/testsuite/uname.c b/testsuite/uname.c
index 2ada200..f55c435 100644
--- a/testsuite/uname.c
+++ b/testsuite/uname.c
@@ -22,6 +22,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <stdio.h>
+#include <unistd.h>
 
 #include "testsuite.h"
 
@@ -29,17 +30,10 @@ TS_EXPORT int uname(struct utsname *u)
 {
 	static void *nextlib = NULL;
 	static int (*nextlib_uname)(struct utsname *u);
-	const char *release = getenv(S_TC_UNAME_R);
+	const char *release;
 	int err;
 	size_t sz;
 
-	if (release == NULL) {
-		fprintf(stderr, "TRAP uname(): missing export %s?\n",
-							S_TC_UNAME_R);
-		errno = EFAULT;
-		return -1;
-	}
-
 	if (nextlib == NULL) {
 #ifdef RTLD_NEXT
 		nextlib = RTLD_NEXT;
@@ -53,6 +47,20 @@ TS_EXPORT int uname(struct utsname *u)
 	if (err < 0)
 		return err;
 
+	if (!environ)
+		/*
+		 * probably called from within glibc before main(); unsafe
+		 * to call getenv()
+		 */
+		return 0;
+
+	release = getenv(S_TC_UNAME_R);
+	if (release == NULL) {
+		fprintf(stderr, "TRAP uname(): missing export %s?\n",
+							S_TC_UNAME_R);
+		return 0;
+	}
+
 	sz = strlen(release) + 1;
 	if (sz > sizeof(u->release)) {
 		fprintf(stderr, "uname(): sizeof release (%s) "
-- 
1.8.4.5

