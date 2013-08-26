Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from furnace.wzff.de ([176.9.216.40]:48808 "EHLO furnace.wzff.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752336Ab3HZTCt (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Mon, 26 Aug 2013 15:02:49 -0400
From: John Spencer <maillist-kmod@barfooze.de>
To: linux-modules@vger.kernel.org
Cc: John Spencer <maillist-kmod@barfooze.de>
Subject: [PATCH 1/3] remove non-portable usage of strndupa
Date: Mon, 26 Aug 2013 20:20:48 +0200
Message-Id: <1377541250-10193-1-git-send-email-maillist-kmod@barfooze.de>
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

usage of strndupa is neither C99 nor POSIX,
so musl libc does not implement it.
it's a glibc invention, and a dangerous one since
usage of alloca() is considered bad practice.

fixes build with musl libc.

Signed-off-by: John Spencer <maillist-kmod@barfooze.de>

---
 libkmod/libkmod-util.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/libkmod/libkmod-util.c b/libkmod/libkmod-util.c
index d686250..9615d0f 100644
--- a/libkmod/libkmod-util.c
+++ b/libkmod/libkmod-util.c
@@ -28,6 +28,7 @@
 #include <unistd.h>
 #include <errno.h>
 #include <string.h>
+#include <limits.h>
 #include <ctype.h>
 
 #include "libkmod.h"
@@ -323,8 +324,11 @@ static inline int is_dir(const char *path)
 int mkdir_p(const char *path, int len, mode_t mode)
 {
 	char *start, *end;
-
-	start = strndupa(path, len);
+	char buf[PATH_MAX+1];
+	snprintf(buf, sizeof buf, "%s", path);
+	assert(len < sizeof(buf));
+	buf[len] = 0;
+	start = buf;
 	end = start + len;
 
 	/*
-- 
1.7.3.4

