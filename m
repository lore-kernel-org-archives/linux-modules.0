Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail-yh0-f51.google.com ([209.85.213.51]:61861 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753235Ab3GOFSv (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Mon, 15 Jul 2013 01:18:51 -0400
Received: by mail-yh0-f51.google.com with SMTP id l109so4477865yhq.24
        for <linux-modules@vger.kernel.org>; Sun, 14 Jul 2013 22:18:50 -0700 (PDT)
Received: from localhost.localdomain ([201.53.216.53])
        by mx.google.com with ESMTPSA id s29sm81191597yhf.6.2013.07.14.22.12.56
        for <linux-modules@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 22:12:57 -0700 (PDT)
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-modules@vger.kernel.org
Subject: [PATCH 5/6] util: Add mkdir_parents()
Date: Mon, 15 Jul 2013 02:12:58 -0300
Message-Id: <1373865179-18366-5-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1373865179-18366-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1373865179-18366-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

From: Lucas De Marchi <lucas.demarchi@intel.com>

Like mkdir_p, but discard the leaf and create all parent directories.
---
 libkmod/libkmod-util.c | 11 +++++++++++
 libkmod/libkmod-util.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/libkmod/libkmod-util.c b/libkmod/libkmod-util.c
index 45ca11a..764c551 100644
--- a/libkmod/libkmod-util.c
+++ b/libkmod/libkmod-util.c
@@ -373,6 +373,17 @@ int mkdir_p(const char *path, int len, mode_t mode)
 	return 0;
 }
 
+int mkdir_parents(const char *path, mode_t mode)
+{
+	char *end = strrchr(path, '/');
+
+	/* no parent directories */
+	if (end == NULL)
+		return 0;
+
+	return mkdir_p(path, end - path, mode);
+}
+
 const struct kmod_ext kmod_exts[] = {
 	{".ko", sizeof(".ko") - 1},
 #ifdef ENABLE_ZLIB
diff --git a/libkmod/libkmod-util.h b/libkmod/libkmod-util.h
index 4c45416..f7f3e90 100644
--- a/libkmod/libkmod-util.h
+++ b/libkmod/libkmod-util.h
@@ -21,6 +21,7 @@ char *strchr_replace(char *s, int c, char r);
 bool path_is_absolute(const char *p) _must_check_ __attribute__((nonnull(1)));
 char *path_make_absolute_cwd(const char *p) _must_check_ __attribute__((nonnull(1)));
 int mkdir_p(const char *path, int len, mode_t mode);
+int mkdir_parents(const char *path, mode_t mode);
 int alias_normalize(const char *alias, char buf[PATH_MAX], size_t *len) _must_check_ __attribute__((nonnull(1,2)));
 char *modname_normalize(const char *modname, char buf[PATH_MAX], size_t *len) __attribute__((nonnull(1, 2)));
 char *path_to_modname(const char *path, char buf[PATH_MAX], size_t *len) __attribute__((nonnull(2)));
-- 
1.8.3.2

