Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail-yh0-f42.google.com ([209.85.213.42]:50306 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828Ab3GOFR6 (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Mon, 15 Jul 2013 01:17:58 -0400
Received: by mail-yh0-f42.google.com with SMTP id c41so4484402yho.29
        for <linux-modules@vger.kernel.org>; Sun, 14 Jul 2013 22:17:58 -0700 (PDT)
Received: from localhost.localdomain ([201.53.216.53])
        by mx.google.com with ESMTPSA id s29sm81191597yhf.6.2013.07.14.22.12.55
        for <linux-modules@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 22:12:55 -0700 (PDT)
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-modules@vger.kernel.org
Subject: [PATCH 4/6] util: Add len arg to mkdir_p()
Date: Mon, 15 Jul 2013 02:12:57 -0300
Message-Id: <1373865179-18366-4-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1373865179-18366-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1373865179-18366-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

From: Lucas De Marchi <lucas.demarchi@intel.com>

---
 libkmod/libkmod-util.c  | 9 +++++----
 libkmod/libkmod-util.h  | 2 +-
 testsuite/init_module.c | 2 +-
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/libkmod/libkmod-util.c b/libkmod/libkmod-util.c
index 5c680e7..45ca11a 100644
--- a/libkmod/libkmod-util.c
+++ b/libkmod/libkmod-util.c
@@ -323,11 +323,12 @@ static inline int is_dir(const char *path)
 	return -errno;
 }
 
-int mkdir_p(const char *path, mode_t mode)
+int mkdir_p(const char *path, int len, mode_t mode)
 {
-	char *start = strdupa(path);
-	int len = strlen(path);
-	char *end = start + len;
+	char *start, *end;
+
+	start = strndupa(path, len);
+	end = start + len;
 
 	/*
 	 * scan backwards, replacing '/' with '\0' while the component doesn't
diff --git a/libkmod/libkmod-util.h b/libkmod/libkmod-util.h
index 83c975c..4c45416 100644
--- a/libkmod/libkmod-util.h
+++ b/libkmod/libkmod-util.h
@@ -20,7 +20,7 @@ int read_str_ulong(int fd, unsigned long *value, int base) _must_check_ __attrib
 char *strchr_replace(char *s, int c, char r);
 bool path_is_absolute(const char *p) _must_check_ __attribute__((nonnull(1)));
 char *path_make_absolute_cwd(const char *p) _must_check_ __attribute__((nonnull(1)));
-int mkdir_p(const char *path, mode_t mode);
+int mkdir_p(const char *path, int len, mode_t mode);
 int alias_normalize(const char *alias, char buf[PATH_MAX], size_t *len) _must_check_ __attribute__((nonnull(1,2)));
 char *modname_normalize(const char *modname, char buf[PATH_MAX], size_t *len) __attribute__((nonnull(1, 2)));
 char *path_to_modname(const char *path, char buf[PATH_MAX], size_t *len) __attribute__((nonnull(2)));
diff --git a/testsuite/init_module.c b/testsuite/init_module.c
index ebf1b94..42177e7 100644
--- a/testsuite/init_module.c
+++ b/testsuite/init_module.c
@@ -155,7 +155,7 @@ static int create_sysfs_files(const char *modname)
 	strcpy(buf + len, modname);
 	len += strlen(modname);
 
-	assert(mkdir_p(buf, 0755) >= 0);
+	assert(mkdir_p(buf, len, 0755) >= 0);
 
 	strcpy(buf + len, "/initstate");
 	return write_one_line_file(buf, "live\n", strlen("live\n"));
-- 
1.8.3.2

