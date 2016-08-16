Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from fmap.me ([91.92.66.84]:33934 "EHLO smtp.fmap.me"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752258AbcHPA6O (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Mon, 15 Aug 2016 20:58:14 -0400
From: Nikolay Amiantov <ab@fmap.me>
To: linux-modules@vger.kernel.org
Cc: Shea Levy <shea@shealevy.com>
Subject: [PATCH 1/4] libkmod: add MODULE_DIR to override kernel modules directory
Date: Tue, 16 Aug 2016 03:50:29 +0300
Message-Id: <20160816005032.28881-2-ab@fmap.me>
In-Reply-To: <20160816005032.28881-1-ab@fmap.me>
References: <20160816005032.28881-1-ab@fmap.me>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

From: Shea Levy <shea@shealevy.com>

It is used as a path if this environment variable is set, and `uname -r` is
appended to the end. Otherwise, default /lib/modules/`uname -r` is used as
usual.
---
 libkmod/libkmod.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/libkmod/libkmod.c b/libkmod/libkmod.c
index 69fe431..7b0247f 100644
--- a/libkmod/libkmod.c
+++ b/libkmod/libkmod.c
@@ -211,7 +211,7 @@ static const char *dirname_default_prefix = "/lib/modules";
 static char *get_kernel_release(const char *dirname)
 {
 	struct utsname u;
-	char *p;
+	char *p, *dirname_prefix;
 
 	if (dirname != NULL)
 		return path_make_absolute_cwd(dirname);
@@ -219,7 +219,10 @@ static char *get_kernel_release(const char *dirname)
 	if (uname(&u) < 0)
 		return NULL;
 
-	if (asprintf(&p, "%s/%s", dirname_default_prefix, u.release) < 0)
+	if ((dirname_prefix = getenv("MODULE_DIR")) == NULL)
+		dirname_prefix = dirname_default_prefix;
+
+	if (asprintf(&p, "%s/%s", dirname_prefix, u.release) < 0)
 		return NULL;
 
 	return p;
-- 
2.9.2

