Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail.alpinelinux.org ([74.117.189.114]:60841 "EHLO
	mail.alpinelinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751135AbaKQIm5 (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Mon, 17 Nov 2014 03:42:57 -0500
From: Natanael Copa <ncopa@alpinelinux.org>
To: linux-modules@vger.kernel.org
Cc: Natanael Copa <ncopa@alpinelinux.org>
Subject: [PATCH] util: fix build on systems missing strndupa
Date: Mon, 17 Nov 2014 09:36:29 +0100
Message-Id: <1416213389-6292-1-git-send-email-ncopa@alpinelinux.org>
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

we need include shared/missing.h to be able to compile on sysmtes that
lacks strndupa.
---
 shared/util.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/shared/util.c b/shared/util.c
index 855d4e4..4b92cbf 100644
--- a/shared/util.c
+++ b/shared/util.c
@@ -31,6 +31,7 @@
 #include <unistd.h>
 
 #include <shared/util.h>
+#include <shared/missing.h>
 
 #define USEC_PER_SEC  1000000ULL
 #define NSEC_PER_USEC 1000ULL
-- 
2.1.3

