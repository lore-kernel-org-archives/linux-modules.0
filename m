Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail-ye0-f174.google.com ([209.85.213.174]:64563 "EHLO
	mail-ye0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752376Ab3GOFMy (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Mon, 15 Jul 2013 01:12:54 -0400
Received: by mail-ye0-f174.google.com with SMTP id m9so3820591yen.33
        for <linux-modules@vger.kernel.org>; Sun, 14 Jul 2013 22:12:53 -0700 (PDT)
Received: from localhost.localdomain ([201.53.216.53])
        by mx.google.com with ESMTPSA id s29sm81191597yhf.6.2013.07.14.22.12.52
        for <linux-modules@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 22:12:53 -0700 (PDT)
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-modules@vger.kernel.org
Subject: [PATCH 2/6] util: Add mkdir_p implementation from testsuite
Date: Mon, 15 Jul 2013 02:12:55 -0300
Message-Id: <1373865179-18366-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1373865179-18366-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1373865179-18366-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

From: Lucas De Marchi <lucas.demarchi@intel.com>

---
 Makefile.am             |  1 -
 libkmod/libkmod-util.c  | 64 ++++++++++++++++++++++++++++++++++++
 libkmod/libkmod-util.h  |  1 +
 testsuite/init_module.c |  1 -
 testsuite/mkdir.c       | 86 -------------------------------------------------
 testsuite/mkdir.h       | 24 --------------
 6 files changed, 65 insertions(+), 112 deletions(-)
 delete mode 100644 testsuite/mkdir.c
 delete mode 100644 testsuite/mkdir.h

diff --git a/Makefile.am b/Makefile.am
index 0ed944c..57b7372 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -154,7 +154,6 @@ testsuite_path_la_LDFLAGS = $(TESTSUITE_OVERRIDE_LIBS_LDFLAGS)
 testsuite_delete_module_la_LDFLAGS = $(TESTSUITE_OVERRIDE_LIBS_LDFLAGS)
 testsuite_init_module_la_LDFLAGS = $(TESTSUITE_OVERRIDE_LIBS_LDFLAGS)
 testsuite_init_module_la_SOURCES = testsuite/init_module.c \
-				   testsuite/mkdir.c testsuite/mkdir.h \
 				   testsuite/stripped-module.h
 testsuite_init_module_la_LIBADD = libkmod/libkmod-internal.la
 
diff --git a/libkmod/libkmod-util.c b/libkmod/libkmod-util.c
index e636ae1..5c680e7 100644
--- a/libkmod/libkmod-util.c
+++ b/libkmod/libkmod-util.c
@@ -2,6 +2,8 @@
  * libkmod - interface to kernel module operations
  *
  * Copyright (C) 2011-2013  ProFUSION embedded systems
+ * Copyright (C) 2013  Intel Corporation. All rights reserved.
+ * Copyright (C) 2012  Lucas De Marchi <lucas.de.marchi@gmail.com>
  *
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
@@ -308,6 +310,68 @@ char *path_make_absolute_cwd(const char *p)
 	return r;
 }
 
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
+int mkdir_p(const char *path, mode_t mode)
+{
+	char *start = strdupa(path);
+	int len = strlen(path);
+	char *end = start + len;
+
+	/*
+	 * scan backwards, replacing '/' with '\0' while the component doesn't
+	 * exist
+	 */
+	for (;;) {
+		int r = is_dir(start);
+		if (r > 0) {
+			end += strlen(end);
+
+			if (end == start + len)
+				return 0;
+
+			/* end != start, since it would be caught on the first
+			 * iteration */
+			*end = '/';
+			break;
+		} else if (r == 0)
+			return -ENOTDIR;
+
+		if (end == start)
+			break;
+
+		*end = '\0';
+
+		/* Find the next component, backwards, discarding extra '/'*/
+		while (end > start && *end != '/')
+			end--;
+
+		while (end > start && *(end - 1) == '/')
+			end--;
+	}
+
+	for (; end < start + len;) {
+		if (mkdir(start, mode) < 0 && errno != EEXIST)
+			return -errno;
+
+		end += strlen(end);
+		*end = '/';
+	}
+
+	return 0;
+}
+
 const struct kmod_ext kmod_exts[] = {
 	{".ko", sizeof(".ko") - 1},
 #ifdef ENABLE_ZLIB
diff --git a/libkmod/libkmod-util.h b/libkmod/libkmod-util.h
index 17f8801..83c975c 100644
--- a/libkmod/libkmod-util.h
+++ b/libkmod/libkmod-util.h
@@ -20,6 +20,7 @@ int read_str_ulong(int fd, unsigned long *value, int base) _must_check_ __attrib
 char *strchr_replace(char *s, int c, char r);
 bool path_is_absolute(const char *p) _must_check_ __attribute__((nonnull(1)));
 char *path_make_absolute_cwd(const char *p) _must_check_ __attribute__((nonnull(1)));
+int mkdir_p(const char *path, mode_t mode);
 int alias_normalize(const char *alias, char buf[PATH_MAX], size_t *len) _must_check_ __attribute__((nonnull(1,2)));
 char *modname_normalize(const char *modname, char buf[PATH_MAX], size_t *len) __attribute__((nonnull(1, 2)));
 char *path_to_modname(const char *path, char buf[PATH_MAX], size_t *len) __attribute__((nonnull(2)));
diff --git a/testsuite/init_module.c b/testsuite/init_module.c
index 686f671..ebf1b94 100644
--- a/testsuite/init_module.c
+++ b/testsuite/init_module.c
@@ -44,7 +44,6 @@
 
 /* FIXME: hack, change name so we don't clash */
 #undef ERR
-#include "mkdir.h"
 #include "testsuite.h"
 #include "stripped-module.h"
 
diff --git a/testsuite/mkdir.c b/testsuite/mkdir.c
deleted file mode 100644
index be2e37b..0000000
--- a/testsuite/mkdir.c
+++ /dev/null
@@ -1,86 +0,0 @@
-/*
- * Copyright (C) 2012  Lucas De Marchi <lucas.de.marchi@gmail.com
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
-
-#include <errno.h>
-#include <string.h>
-#include <sys/stat.h>
-#include <sys/types.h>
-
-#include "mkdir.h"
-#include "testsuite.h"
-
-static inline int is_dir(const char *path)
-{
-	struct stat st;
-
-	if (stat(path, &st) >= 0) {
-		if (S_ISDIR(st.st_mode))
-			return 1;
-		return 0;
-	}
-
-	return -errno;
-}
-
-TS_EXPORT int mkdir_p(const char *path, mode_t mode)
-{
-	char *start = strdupa(path);
-	int len = strlen(path);
-	char *end = start + len;
-
-	/*
-	 * scan backwards, replacing '/' with '\0' while the component doesn't
-	 * exist
-	 */
-	for (;;) {
-		int r = is_dir(start);
-		if (r > 0) {
-			end += strlen(end);
-
-			if (end == start + len)
-				return 0;
-
-			/* end != start, since it would be caught on the first
-			 * iteration */
-			*end = '/';
-			break;
-		} else if (r == 0)
-			return -ENOTDIR;
-
-		if (end == start)
-			break;
-
-		*end = '\0';
-
-		/* Find the next component, backwards, discarding extra '/'*/
-		while (end > start && *end != '/')
-			end--;
-
-		while (end > start && *(end - 1) == '/')
-			end--;
-	}
-
-	for (; end < start + len;) {
-		if (mkdir(start, mode) < 0 && errno != EEXIST)
-			return -errno;
-
-		end += strlen(end);
-		*end = '/';
-	}
-
-	return 0;
-}
diff --git a/testsuite/mkdir.h b/testsuite/mkdir.h
deleted file mode 100644
index 35f6a1d..0000000
--- a/testsuite/mkdir.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * Copyright (C) 2012  Lucas De Marchi <lucas.de.marchi@gmail.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
-
-#pragma once
-
-#include <sys/stat.h>
-#include <sys/types.h>
-
-int mkdir_p(const char *path, mode_t mode);
-- 
1.8.3.2

