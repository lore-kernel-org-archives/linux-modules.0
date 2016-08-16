Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from fmap.me ([91.92.66.84]:33938 "EHLO smtp.fmap.me"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750796AbcHPA6O (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Mon, 15 Aug 2016 20:58:14 -0400
From: Nikolay Amiantov <ab@fmap.me>
To: linux-modules@vger.kernel.org
Cc: Shea Levy <shea@shealevy.com>, Nikolay Amiantov <ab@fmap.me>
Subject: [PATCH 2/4] libkmod: allow hardcoding array of dirname prefixes
Date: Tue, 16 Aug 2016 03:50:30 +0300
Message-Id: <20160816005032.28881-3-ab@fmap.me>
In-Reply-To: <20160816005032.28881-1-ab@fmap.me>
References: <20160816005032.28881-1-ab@fmap.me>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Directories in the array are searched until the first directory with `uname -r`
subdirectory is found. As a fallback last item in the array is used
unconditionally.
---
 libkmod/libkmod.c | 45 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/libkmod/libkmod.c b/libkmod/libkmod.c
index 7b0247f..be9358d 100644
--- a/libkmod/libkmod.c
+++ b/libkmod/libkmod.c
@@ -206,7 +206,10 @@ static int log_priority(const char *priority)
 	return 0;
 }
 
-static const char *dirname_default_prefix = "/lib/modules";
+static const char *dirname_default_prefixes[] = {
+	"/lib/modules",
+	NULL
+};
 
 static char *get_kernel_release(const char *dirname)
 {
@@ -219,11 +222,43 @@ static char *get_kernel_release(const char *dirname)
 	if (uname(&u) < 0)
 		return NULL;
 
-	if ((dirname_prefix = getenv("MODULE_DIR")) == NULL)
-		dirname_prefix = dirname_default_prefix;
+	if ((dirname_prefix = getenv("MODULE_DIR")) != NULL) {
+		if(asprintf(&p, "%s/%s", dirname_prefix, u.release) < 0)
+			return NULL;
+	} else {
+		size_t i;
+		char buf[PATH_MAX];
+
+		for (i = 0; dirname_default_prefixes[i] != NULL; i++) {
+			int plen;
+
+			plen = snprintf(buf, sizeof(buf), "%s/%s", dirname_default_prefixes[i], u.release);
+			if (plen < 0)
+				return NULL;
+			else if (plen >= PATH_MAX)
+				continue;
+
+			if (dirname_default_prefixes[i + 1] != NULL) {
+				struct stat dirstat;
+
+				if (stat(buf, &dirstat) < 0) {
+					if (errno == ENOENT)
+						continue;
+					else
+						return NULL;
+				}
+
+				if (!S_ISDIR(dirstat.st_mode))
+					continue;
+			}
 
-	if (asprintf(&p, "%s/%s", dirname_prefix, u.release) < 0)
-		return NULL;
+			p = malloc(plen + 1);
+			if (p == NULL)
+				return NULL;
+			memcpy(p, buf, plen + 1);
+			break;
+		}
+	}
 
 	return p;
 }
-- 
2.9.2

