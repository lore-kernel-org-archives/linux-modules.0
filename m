Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59736 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933031Ab3EBTlU (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Thu, 2 May 2013 15:41:20 -0400
Date: Thu, 2 May 2013 21:41:19 +0200
From: Jan Luebbe <jlu@pengutronix.de>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-modules <linux-modules@vger.kernel.org>
Subject: Re: [PATCH] libkmod: Avoid calling syscall() with -1
Message-ID: <20130502194119.GA18636@pengutronix.de>
References: <1367506032-17290-1-git-send-email-jlu@pengutronix.de>
 <CAMOw1v64418ddfM4v3OW7sEYGq+d7FKmHUsizAsDbNRQnSy10w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAMOw1v64418ddfM4v3OW7sEYGq+d7FKmHUsizAsDbNRQnSy10w@mail.gmail.com>
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On Thu, May 02, 2013 at 01:21:08PM -0300, Lucas De Marchi wrote:
> Indeed. But I had already a patch for that, just waiting the bug
> reporter to test it:
> 
> http://bugs.funtoo.org/browse/FL-534
> 
> And the patch:
> http://bugs.funtoo.org/secure/attachment/11098/dont-call-libc.diff

In that patch, the new #ifndef is never used, as __NR_finit_module is
defined a few lines up.

This one looks better, but failes to compile:
http://bugs.funtoo.org/secure/attachment/11099/0001-missing-Don-t-call-syscall-with-syscallno-1.patch
libkmod/missing.h:27:17: error: '__NR_finit_module' undeclared (first use in this function)

I've changed your patch a little (put the real call into the #else branch).
With this version, I don't see the problem any more.

----

From: Lucas De Marchi <lucas.de.marchi@gmail.com>
Date: Thu, 2 May 2013 13:22:57 -0300
Subject: [PATCH] missing: Don't call syscall() with syscallno == -1

Reported-by: Jean-Francis Roy <jeanfrancis@funtoo.org>
Reported-by: Jan Luebbe <jlu@pengutronix.de>
---
 libkmod/missing.h |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/libkmod/missing.h b/libkmod/missing.h
index edb88b9..b31af84 100644
--- a/libkmod/missing.h
+++ b/libkmod/missing.h
@@ -1,5 +1,6 @@
 #pragma once
 
+#include <errno.h>
 #include <unistd.h>
 #include <sys/syscall.h>
 
@@ -15,13 +16,14 @@
 # define MODULE_INIT_IGNORE_VERMAGIC 2
 #endif
 
-#ifndef __NR_finit_module
-# define __NR_finit_module -1
-#endif
-
 #ifndef HAVE_FINIT_MODULE
 static inline int finit_module(int fd, const char *uargs, int flags)
 {
+#ifndef __NR_finit_module
+	errno = ENOSYS;
+	return -1;
+#else
 	return syscall(__NR_finit_module, fd, uargs, flags);
+#endif
 }
 #endif

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
