Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from furnace.wzff.de ([176.9.216.40]:48811 "EHLO furnace.wzff.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752361Ab3HZTCw (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Mon, 26 Aug 2013 15:02:52 -0400
From: John Spencer <maillist-kmod@barfooze.de>
To: linux-modules@vger.kernel.org
Cc: John Spencer <maillist-kmod@barfooze.de>
Subject: [PATCH 2/3] check if __GLIBC__ is defined before using _FILE_OFFSET_BITS
Date: Mon, 26 Aug 2013 20:20:49 +0200
Message-Id: <1377541250-10193-2-git-send-email-maillist-kmod@barfooze.de>
In-Reply-To: <1377541250-10193-1-git-send-email-maillist-kmod@barfooze.de>
References: <1377541250-10193-1-git-send-email-maillist-kmod@barfooze.de>
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

_FILE_OFFSET_BITS is a glibc internal macro.
musl provides 64bit off_t by default, but
defines stat64 etc as macros to make glibc-centric
programs happy. however the expansion causes
problems with the hack used here to work around
glibc's 32bit past...

Signed-off-by: John Spencer <maillist-kmod@barfooze.de>

---
 testsuite/path.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testsuite/path.c b/testsuite/path.c
index f87f5c5..f06fadd 100644
--- a/testsuite/path.c
+++ b/testsuite/path.c
@@ -185,7 +185,7 @@ WRAP_2ARGS(int, -1, mkdir, mode_t);
 WRAP_2ARGS(int, -1, access, int);
 WRAP_2ARGS(int, -1, stat, struct stat*);
 WRAP_2ARGS(int, -1, lstat, struct stat*);
-#ifndef _FILE_OFFSET_BITS
+#if defined(__GLIBC__) && !defined(_FILE_OFFSET_BITS)
 WRAP_2ARGS(int, -1, stat64, struct stat64*);
 WRAP_2ARGS(int, -1, lstat64, struct stat64*);
 WRAP_OPEN(64);
@@ -196,7 +196,7 @@ WRAP_OPEN();
 #ifdef HAVE___XSTAT
 WRAP_VERSTAT(__x,);
 WRAP_VERSTAT(__lx,);
-#ifndef _FILE_OFFSET_BITS
+#if defined(__GLIBC__) && !defined(_FILE_OFFSET_BITS)
 WRAP_VERSTAT(__x,64);
 WRAP_VERSTAT(__lx,64);
 #endif
-- 
1.7.3.4

