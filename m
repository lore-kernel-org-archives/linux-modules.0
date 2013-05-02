Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from sirius.lasnet.de ([78.47.116.19]:48426 "EHLO sirius.lasnet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754674Ab3EBP1L (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Thu, 2 May 2013 11:27:11 -0400
From: Jan Luebbe <jlu@pengutronix.de>
To: linux-modules@vger.kernel.org
Cc: Jan Luebbe <jlu@pengutronix.de>
Date: Thu,  2 May 2013 16:47:12 +0200
Message-Id: <1367506032-17290-1-git-send-email-jlu@pengutronix.de>
Subject: [PATCH] libkmod: Avoid calling syscall() with -1
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

At least in qemu 1.4.1 for vexpress/arm-cortexa9, this resulted in an
illegal instruction error. Solve that by returning an error when
__NR_finit_module is -1.
---
 libkmod/missing.h |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/libkmod/missing.h b/libkmod/missing.h
index edb88b9..ac24a35 100644
--- a/libkmod/missing.h
+++ b/libkmod/missing.h
@@ -20,8 +20,15 @@
 #endif
 
 #ifndef HAVE_FINIT_MODULE
+#include <errno.h>
+
 static inline int finit_module(int fd, const char *uargs, int flags)
 {
-	return syscall(__NR_finit_module, fd, uargs, flags);
+	if (__NR_finit_module == -1) {
+		errno = ENOSYS;
+		return -1;
+	} else {
+		return syscall(__NR_finit_module, fd, uargs, flags);
+	}
 }
 #endif
