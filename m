Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48235 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751732AbaB0Ww0 (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Thu, 27 Feb 2014 17:52:26 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 0715F7501B
	for <linux-modules@vger.kernel.org>; Thu, 27 Feb 2014 22:52:25 +0000 (UTC)
From: Michal Marek <mmarek@suse.cz>
To: linux-modules@vger.kernel.org
Subject: [PATCH 3/5] testsuite: Do not provide finit_module(2) on older kernels
Date: Thu, 27 Feb 2014 23:52:11 +0100
Message-Id: <1393541533-14719-4-git-send-email-mmarek@suse.cz>
In-Reply-To: <1393541533-14719-1-git-send-email-mmarek@suse.cz>
References: <1393541533-14719-1-git-send-email-mmarek@suse.cz>
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

If the test's uname -r is less that 3.8, return -ENOSYS from
finit_module(), so that the fallback is tested.
---
 testsuite/init_module.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/testsuite/init_module.c b/testsuite/init_module.c
index 42177e7..96f4aa7 100644
--- a/testsuite/init_module.c
+++ b/testsuite/init_module.c
@@ -37,6 +37,7 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/syscall.h>
+#include <sys/utsname.h>
 #include <unistd.h>
 
 /* kmod_elf_get_section() is not exported, we need the private header */
@@ -280,6 +281,25 @@ long init_module(void *mem, unsigned long len, const char *args)
 	return err;
 }
 
+static int check_kernel_version(int major, int minor)
+{
+	struct utsname u;
+	const char *p;
+	int maj = 0, min = 0;
+
+	if (uname(&u) < 0)
+		return false;
+	for (p = u.release; *p >= '0' && *p <= '9'; p++)
+		maj = maj * 10 + *p - '0';
+	if (*p == '.')
+		for (p++; *p >= '0' && *p <= '9'; p++)
+			min = min * 10 + *p - '0';
+	if (maj > major || (maj == major && min >= minor))
+		return true;
+	return false;
+}
+
+
 TS_EXPORT int finit_module(const int fd, const char *args, const int flags);
 
 int finit_module(const int fd, const char *args, const int flags)
@@ -289,6 +309,11 @@ int finit_module(const int fd, const char *args, const int flags)
 	unsigned long len;
 	struct stat st;
 
+	if (!check_kernel_version(3, 8)) {
+		stat("/old/kernel", &st);
+		errno = ENOSYS;
+		return -1;
+	}
 	if (fstat(fd, &st) < 0)
 		return -1;
 
-- 
1.7.3.1

