Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:49020 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056AbaI3HmD (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Tue, 30 Sep 2014 03:42:03 -0400
Received: by mail-wi0-f172.google.com with SMTP id ex7so3245678wid.17
        for <linux-modules@vger.kernel.org>; Tue, 30 Sep 2014 00:42:01 -0700 (PDT)
From: Thomas De Schampheleire <patrickdepinguin@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Robert Yang <liezhi.yang@windriver.com>
Subject: [PATCH] Add dummy definition of O_CLOEXEC
Date: Tue, 30 Sep 2014 09:41:46 +0200
Message-Id: <1412062906-27378-1-git-send-email-patrickdepinguin@gmail.com>
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

From: Robert Yang <liezhi.yang@windriver.com>

O_CLOEXEC is introduced from Linux 2.6.23, so old kernel doesn't have
it, we need check before use.

This patch is much more like a workaround, since it may need fcntl() use
FD_CLOEXEC to replace.

This problem was reported by "Ting Liu <b28495@freescale.com>"

[Thomas De Schampheleire <thomas.de.schampheleire@gmail.com:
 - move dummy definition from libkmod-internal.h to missing.h
 - update commit title]
---
 libkmod/missing.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/libkmod/missing.h b/libkmod/missing.h
index 4c0d136..e123e98 100644
--- a/libkmod/missing.h
+++ b/libkmod/missing.h
@@ -19,6 +19,10 @@
 # define __NR_finit_module -1
 #endif
 
+#ifndef O_CLOEXEC
+#define O_CLOEXEC 0
+#endif
+
 #ifndef HAVE_FINIT_MODULE
 #include <errno.h>
 
-- 
1.7.1

