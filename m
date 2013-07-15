Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail-gg0-f173.google.com ([209.85.161.173]:50765 "EHLO
	mail-gg0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752853Ab3GOFVI (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Mon, 15 Jul 2013 01:21:08 -0400
Received: by mail-gg0-f173.google.com with SMTP id k3so3783462ggn.4
        for <linux-modules@vger.kernel.org>; Sun, 14 Jul 2013 22:21:06 -0700 (PDT)
Received: from localhost.localdomain ([201.53.216.53])
        by mx.google.com with ESMTPSA id s29sm81191597yhf.6.2013.07.14.22.12.51
        for <linux-modules@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 22:12:51 -0700 (PDT)
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-modules@vger.kernel.org
Subject: [PATCH 1/6] testsuite: Fix mkdir_p corner cases
Date: Mon, 15 Jul 2013 02:12:54 -0300
Message-Id: <1373865179-18366-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

From: Lucas De Marchi <lucas.demarchi@intel.com>

 - Fix infinite loop when path is relative
 - Fix not considering EEXIST as a success
 - General refactor to mkdir_p so it never calls mkdir for an existing
   dir (given no creates it from outside)
---
 testsuite/mkdir.c | 54 +++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 35 insertions(+), 19 deletions(-)

diff --git a/testsuite/mkdir.c b/testsuite/mkdir.c
index 0a7de69..be2e37b 100644
--- a/testsuite/mkdir.c
+++ b/testsuite/mkdir.c
@@ -23,47 +23,63 @@
 #include "mkdir.h"
 #include "testsuite.h"
 
+static inline int is_dir(const char *path)
+{
+	struct stat st;
+
+	if (stat(path, &st) >= 0) {
+		if (S_ISDIR(st.st_mode))
+			return 1;
+		return 0;
+	}
+
+	return -errno;
+}
+
 TS_EXPORT int mkdir_p(const char *path, mode_t mode)
 {
 	char *start = strdupa(path);
 	int len = strlen(path);
 	char *end = start + len;
-	struct stat st;
 
 	/*
 	 * scan backwards, replacing '/' with '\0' while the component doesn't
 	 * exist
 	 */
 	for (;;) {
-		if (stat(start, &st) >= 0) {
-			if (S_ISDIR(st.st_mode))
-				break;
-			return -ENOTDIR;
-		}
+		int r = is_dir(start);
+		if (r > 0) {
+			end += strlen(end);
 
-		/* Find the next component, backwards, discarding extra '/'*/
-		for (; end != start && *end != '/'; end--)
-			;
+			if (end == start + len)
+				return 0;
 
-		for (; end != start - 1 && *end == '/'; end--)
-			;
+			/* end != start, since it would be caught on the first
+			 * iteration */
+			*end = '/';
+			break;
+		} else if (r == 0)
+			return -ENOTDIR;
 
-		end++;
 		if (end == start)
 			break;
 
 		*end = '\0';
-	}
 
-	if (end == start + len)
-		return 0;
+		/* Find the next component, backwards, discarding extra '/'*/
+		while (end > start && *end != '/')
+			end--;
 
-	for (; end < start + len;) {
-		*end = '/';
-		end += strlen(end);
+		while (end > start && *(end - 1) == '/')
+			end--;
+	}
 
-		if (mkdir(start, mode) < 0)
+	for (; end < start + len;) {
+		if (mkdir(start, mode) < 0 && errno != EEXIST)
 			return -errno;
+
+		end += strlen(end);
+		*end = '/';
 	}
 
 	return 0;
-- 
1.8.3.2

