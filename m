Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:54044 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069Ab3GNL4u (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Sun, 14 Jul 2013 07:56:50 -0400
Received: by mail-wi0-f180.google.com with SMTP id c10so1994211wiw.1
        for <linux-modules@vger.kernel.org>; Sun, 14 Jul 2013 04:56:49 -0700 (PDT)
From: Tom Gundersen <teg@jklm.no>
To: linux-modules@vger.kernel.org
Cc: Tom Gundersen <teg@jklm.no>
Subject: [PATCH 2/2] static-nodes: create parent directories of output file
Date: Sun, 14 Jul 2013 13:56:18 +0200
Message-Id: <1373802978-12456-2-git-send-email-teg@jklm.no>
In-Reply-To: <1373802978-12456-1-git-send-email-teg@jklm.no>
References: <1373802978-12456-1-git-send-email-teg@jklm.no>
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Allows us to drop call to "mkdir -p" from the systemd service file.
---
 Makefile.am          |  3 +-
 tools/mkdir.c        | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/mkdir.h        | 25 ++++++++++++++++
 tools/static-nodes.c | 14 ++++++++-
 4 files changed, 121 insertions(+), 2 deletions(-)
 create mode 100644 tools/mkdir.c
 create mode 100644 tools/mkdir.h

diff --git a/Makefile.am b/Makefile.am
index 0ed944c..ab49dfd 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -111,7 +111,8 @@ tools_kmod_SOURCES = tools/kmod.c tools/kmod.h tools/lsmod.c \
 		     tools/rmmod.c tools/insmod.c \
 		     tools/modinfo.c tools/modprobe.c \
 		     tools/depmod.c tools/log.h tools/log.c \
-		     tools/static-nodes.c
+		     tools/static-nodes.c tools/mkdir.c \
+		     tools/mkdir.h
 tools_kmod_LDADD = libkmod/libkmod-util.la \
 		   libkmod/libkmod-internal.la
 
diff --git a/tools/mkdir.c b/tools/mkdir.c
new file mode 100644
index 0000000..9935366
--- /dev/null
+++ b/tools/mkdir.c
@@ -0,0 +1,81 @@
+/*
+ * Copyright (C) 2012  Lucas De Marchi <lucas.de.marchi@gmail.com
+ * Copyright (C) 2013  Tom Gundersen <teg@jklm.no>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include <errno.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+
+#include "mkdir.h"
+
+static int mkdir_p(char *path, mode_t mode)
+{
+	char *end = path + strlen(path);
+	struct stat st;
+	int r;
+
+	/*
+	 * don't try to overwrite existing file, succeed if it is a directory,
+	 * fail otherwise
+	 */
+	if (stat(path, &st) >= 0) {
+		if (S_ISDIR(st.st_mode)) {
+			return 0;
+		} else
+			return -ENOTDIR;
+	}
+
+	/* Find the last '/' */
+	while (end > path && *end != '/')
+		end--;
+
+	/* discard extra '/' */
+	while (end > path && *(end - 1) == '/')
+		end--;
+
+	/* if a parent directory was found, create it recursively */
+	if (end != path) {
+		*end = '\0';
+		r = mkdir_p(path, mode);
+		*end = '/';
+
+		if (r < 0)
+			return -errno;
+	}
+
+	/* create the desired directory */
+	return mkdir(path, mode);
+}
+
+int mkdir_parents(const char *path, mode_t mode) {
+	char *dirname = strdupa(path);
+	char *offset = strrchr(dirname, '/');
+
+	/* no parent directories */
+	if (!offset) {
+		return 0;
+	}
+
+	/* compute the dirname */
+	while (*(offset - 1) == '/')
+		offset--;
+	*offset = '\0';
+
+	return mkdir_p(dirname, mode);
+}
diff --git a/tools/mkdir.h b/tools/mkdir.h
new file mode 100644
index 0000000..5327fbe
--- /dev/null
+++ b/tools/mkdir.h
@@ -0,0 +1,25 @@
+/*
+ * Copyright (C) 2012  Lucas De Marchi <lucas.de.marchi@gmail.com>
+ * Copyright (C) 2013  Tom Gundersen <teg@jklm.no>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#pragma once
+
+#include <sys/stat.h>
+#include <sys/types.h>
+
+int mkdir_parents(const char *path, mode_t mode);
diff --git a/tools/static-nodes.c b/tools/static-nodes.c
index b4a3c08..fb2d633 100644
--- a/tools/static-nodes.c
+++ b/tools/static-nodes.c
@@ -32,6 +32,8 @@
 #include <sys/types.h>
 #include "libkmod-util.h"
 
+#include "mkdir.h"
+
 #include "kmod.h"
 
 struct static_nodes_format {
@@ -230,9 +232,19 @@ static int do_static_nodes(int argc, char *argv[])
 	}
 
 	if (out == NULL) {
+		int r;
+
+		r = mkdir_parents(output, 0755);
+		if (r < 0) {
+			fprintf(stderr, "Error: could not create parent directory for %s - %m.\n",
+				output);
+			ret = EXIT_FAILURE;
+			goto finish;
+		}
+
 		out = fopen(output, "we");
 		if (out == NULL) {
-			fprintf(stderr, "Error: could not create %s!\n",
+			fprintf(stderr, "Error: could not create %s - %m\n",
 				output);
 			ret = EXIT_FAILURE;
 			goto finish;
-- 
1.8.3.2

